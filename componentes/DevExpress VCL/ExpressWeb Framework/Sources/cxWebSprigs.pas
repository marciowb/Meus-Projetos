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
unit cxWebSprigs;

{$I cxVer.inc}

interface

uses
  Classes, SysUtils, TreeIntf,
  cxWebIntf;

type
  TcxWebComponentSprigClass = class of TcxWebComponentSprig;
  TcxWebComponentSprig = class(TComponentSprig)
  public
    constructor Create(AItem: TPersistent); override;
    function Ghosted: Boolean; override;
  end;

  TcxWebControlSprigClass = class of TcxWebControlSprig;
  TcxWebControlSprig = class(TcxWebComponentSprig)
  public
    constructor Create(AItem: TPersistent); override;
    class function PaletteOverTo(AParent: TSprig; AClass: TClass): Boolean; override;
    function DeleteStyle: TSprigDeleteStyle; override;
    function CustomDelete: Boolean; override;
    function DragOverTo(AParent: TSprig): Boolean; override;
    function DragDropTo(AParent: TSprig): Boolean; override;
  end;

  TcxWebContainerControlSprigClass = class of TcxWebContainerControlSprig;
  TcxWebContainerControlSprig = class(TcxWebControlSprig)
  public
    constructor Create(AItem: TPersistent); override;
    function DragOver(AItem: TSprig): Boolean; override;
    function DragDrop(AItem: TSprig): Boolean; override;
    function PaletteOver(ASprigClass: TSprigClass; AClass: TClass): Boolean; override;
  end;

  TcxWebRootSprigClass = class of TcxWebRootSprig;
  TcxWebRootSprig = class(TRootSprig)
  public
    function AcceptsClass(AClass: TClass): Boolean; override;
    function DragDrop(AItem: TSprig): Boolean; override;
    function DragOver(AItem: TSprig): Boolean; override;
    function PaletteOver(ASprigClass: TSprigClass; AClass: TClass): Boolean; override;
  end;

  TcxWebModuleRootSprig = class(TcxWebRootSprig)
  public
    constructor Create(AItem: TPersistent); override;
  end;

const
  cxWebComponentSprigImage = CComponentSprigImage;
  cxWebControlSprigImage = CControlSprigImage;
  cxWebContainerSprigImage = CUIContainerSprigImage;
  cxWebModuleSprigImage = CFormSprigImage;
  cxWebControlImageIndexes: array[Boolean] of Integer = (cxWebControlSprigImage, cxWebContainerSprigImage);

implementation

uses ToolsAPI, DesignIntf,
  {$IFDEF VCL}
  Windows, Controls, ComCtrls,
  {$ELSE}
  Qt, Types, QControls, QComCtrls,
  {$ENDIF}
  cxWebControls, cxWebClasses, cxWebModule, cxWebDsgnUtils;

{ TcxWebComponentSprig }

constructor TcxWebComponentSprig.Create(AItem: TPersistent);
begin
  inherited Create(AItem);
  ImageIndex := cxWebComponentSprigImage;
end;

function TcxWebComponentSprig.Ghosted: Boolean;
begin
  Result := False;
end;

{ TcxWebControlSprig }

function WebControlAcceptsTo(AParent: TSprig): Boolean;
var
  AContainer: IcxWebContainerControl;
begin
  Result := ((AParent is TcxWebContainerControlSprig) or (AParent is TcxWebRootSprig)) and
     AParent.Item.GetInterface(IcxWebContainerControl, AContainer) and
     AContainer.CanAcceptsControls;
end;

constructor TcxWebControlSprig.Create(AItem: TPersistent);
begin
  inherited Create(AItem);
  ImageIndex := cxWebControlSprigImage;
end;

class function TcxWebControlSprig.PaletteOverTo(AParent: TSprig; AClass: TClass): Boolean;
begin
  Result := WebControlAcceptsTo(AParent);
end;

function TcxWebControlSprig.DeleteStyle: TSprigDeleteStyle;
var
  ADesigner: IDesigner;
  AList: IDesignerSelections;
begin
  if GetDesigner(ADesigner) then
  begin
    Result := dsCustom;
    AList := TDesignerSelections.Create;
    ADesigner.GetSelections(AList);
    if (AList.Count > 1) or
      ((AList.Count = 1) and not (AList.Items[0] is TComponent))then
      Result := dsAbort;
  end else Result := dsAbort;
end;

function TcxWebControlSprig.CustomDelete: Boolean;
begin
  Result := Item <> nil;
  if Result then
    Item.Free;
end;


function TcxWebControlSprig.DragOverTo(AParent: TSprig): Boolean;
begin
  Result := WebControlAcceptsTo(AParent);
end;

function TcxWebControlSprig.DragDropTo(AParent: TSprig): Boolean;
begin
  Result := WebControlAcceptsTo(AParent);
end;

{ TcxWebContainerControlSprig }

function WebContainerControlDragDrop(Sender, AItem: TSprig): Boolean;
var
  AContainer: IcxWebContainerControl;
  AContainerControl: IcxWebControl;
  R: TRect;
  NewLeft, NewTop: Integer;
begin
  Result := TcxWebControlSprig(AItem).Parent <> Sender;
  if Result and AItem.DragDropTo(Sender) then
  begin
    Sender.Item.GetInterface(IcxWebContainerControl, AContainer);
    if Supports(AContainer, IcxWebControl, AContainerControl) then
      R := AContainerControl.BoundsRect
    else
      with TcxWebControl(AItem.Item) do
        R := Rect(0, 0, Width, Height);
    OffsetRect(R, -R.Left, -R.Top);
    with TcxWebControl(AItem.Item) do
    begin
      Parent := AContainer;
      NewLeft := Left;
      NewTop := Top;
      if NewLeft + Width > R.Right - R.Left then
        NewLeft := R.Right - R.Left - Width;
      if NewLeft < 0 then NewLeft := 0;

      if NewTop + Height > R.Bottom - R.Top then
        NewTop := R.Bottom - R.Top - Height;
      if NewTop < 0 then NewTop := 0;

      SetBounds(NewLeft, NewTop, Width, Height);
    end;
  end;
end;

function WebContainerControlDragOver(Sender, AItem: TSprig): Boolean;
var
  Container: IcxWebContainerControl;
begin
  Result := (AItem is TcxWebControlSprig) and
     Sender.Item.GetInterface(IcxWebContainerControl, Container) and
     Container.CanAcceptsControls and AItem.DragOverTo(Sender);
end;

function WebContainerControlPaletteOver(Sender: TSprig; ASprigClass: TSprigClass; AClass: TClass): Boolean;
var
  Container: IcxWebContainerControl;
begin
  Result := (ASprigClass.InheritsFrom(TcxWebControlSprig) or ASprigClass.InheritsFrom(TcxWebRootSprig)) and
     Sender.Item.GetInterface(IcxWebContainerControl, Container) and
     Container.CanAcceptsControls;
end;

constructor TcxWebContainerControlSprig.Create(AItem: TPersistent);
var
 Container: IcxWebContainerControl;
begin
  inherited Create(AItem);
  Item.GetInterface(IcxWebContainerControl, Container);
  ImageIndex := cxWebControlImageIndexes[Container.CanAcceptsControls];
end;

function TcxWebContainerControlSprig.DragDrop(AItem: TSprig): Boolean;
begin
  Result := (AItem.Owner = Owner) and WebContainerControlDragDrop(Self, AItem);
end;

function TcxWebContainerControlSprig.DragOver(AItem: TSprig): Boolean;
begin
  Result := (AItem.Owner = Owner) and WebContainerControlDragOver(Self, AItem);
end;

function TcxWebContainerControlSprig.PaletteOver(ASprigClass: TSprigClass; AClass: TClass): Boolean;
begin
  Result := WebContainerControlPaletteOver(Self, ASprigClass, AClass);
end;

{ TcxWebRootSprig }

function TcxWebRootSprig.AcceptsClass(AClass: TClass): Boolean;
begin
  Result := not AClass.InheritsFrom(TControl) and inherited AcceptsClass(AClass);
end;

function TcxWebRootSprig.DragDrop(AItem: TSprig): Boolean;
begin
  Result := (AItem.Owner = Self) and
    ((AItem is TcxWebControlSprig) and WebContainerControlDragDrop(Self, AItem)) or
    ((AItem is TComponentSprig) and inherited DragDrop(AItem));
end;

function TcxWebRootSprig.DragOver(AItem: TSprig): Boolean;
begin
  Result := (AItem.Owner = Self) and WebContainerControlDragOver(Self, AItem);
end;

function TcxWebRootSprig.PaletteOver(ASprigClass: TSprigClass; AClass: TClass): Boolean;
begin
  Result := WebContainerControlPaletteOver(Self, ASprigClass, AClass) or
    ASprigClass.InheritsFrom(TComponentSprig);
end;

  
{ TcxWebModuleRootSprig }  

constructor TcxWebModuleRootSprig.Create(AItem: TPersistent);
begin
  inherited Create(AItem);
  ImageIndex := cxWebModuleSprigImage;
end;

initialization
  RegisterSprigType(TcxWebComponent, TcxWebComponentSprig);
  RegisterSprigType(TcxWebControl, TcxWebControlSprig);  
  RegisterSprigType(TcxWebContainerControl, TcxWebContainerControlSprig);    
  RegisterRootSprigType(TcxCustomWebPageModule, TcxWebModuleRootSprig);
  
end.

