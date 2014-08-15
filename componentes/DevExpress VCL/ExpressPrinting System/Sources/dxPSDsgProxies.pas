{*******************************************************************
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressPrinting System COMPONENT SUITE                      }
{                                                                   }
{       Copyright (C) 1998-2010 Developer Express Inc.              }
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

unit dxPSDsgProxies;

interface

{$I cxVer.inc}

uses
   {$IFDEF DELPHI6} 
    DesignIntf, DesignEditors, ComponentDesigner,
   {$ELSE}
    DsgnIntf, LibIntf,
   {$ENDIF}  
  Classes, ImgList, Controls, ComCtrls, dxBase, dxPSSngltn;

const
  NodeUncheckedStateIndex = 0;
  NodeCheckedStateIndex = 1;
  NodeParticallyCheckedStateIndex = 2;
  
type
 {$IFDEF DELPHI6}
  TFormDesigner = IDesigner;
  IPersistent = TPersistent;
  IComponent = TComponent;
 {$ELSE}
  TFormDesigner = IFormDesigner;
 {$ENDIF}
  
 {$IFDEF DELPHI6} 
  TdxDesignSelectionList = IDesignerSelections;
 {$ELSE}  
   {$IFDEF DELPHI5}
    TdxDesignSelectionList = TDesignerSelectionList;        
   {$ELSE}
    TdxDesignSelectionList = TComponentList;
   {$ENDIF}      
 {$ENDIF}

 {$IFDEF DELPHI6}
  TdxDesignEnvironment = IDesignEnvironment;
 {$ElSE}
   {$IFDEF DELPHI5}
    TdxDesignEnvironment = IDelphiIDE;  
   {$ELSE}  
    TdxDesignEnvironment = TIDelphiIDE;
   {$ENDIF}
 {$ENDIF}

function IdeEnvironment: TdxDesignEnvironment;
  
{ helpers } 
function CreateDesignSelectionList: TdxDesignSelectionList;
procedure FreeDesignSelectionList(const ASelections: TdxDesignSelectionList);
procedure RestoreDesignSelection(const ADesigner: TFormDesigner; var AList: TdxDesignSelectionList);
procedure SaveDesignSelection(const ADesigner: TFormDesigner; out AList: TdxDesignSelectionList);
function GetBaseRegistryKey: string;

{$IFNDEF DELPHI6} 
function TryExtractPersistent(Component: IPersistent): TPersistent;
{$ENDIF}

type
  TdxIdeComponentImageItem = class
  private
    FComponentClass: TComponentClass;
    FImageIndex: Integer;
  public
    constructor Create(AImageIndex: Integer; AComponentClass: TComponentClass);
    property ComponentClass: TComponentClass read FComponentClass;
    property ImageIndex: Integer read FImageIndex;
  end;
  
  TdxIdeImagesProvider = class(TBasedxPSSingleton)
  private
    FImages: TCustomImageList;
    FItems: TList;
    function GetCount: Integer;
    function GetImageIndex(ComponentClass: TComponentClass): Integer;
    function GetImageIndexByComponentClassName(const ClassName: string): Integer;
    function GetImageIndexByObject(AnObject: TPersistent): Integer;
    function GetItem(Index: Integer): TdxIdeComponentImageItem;
  protected  
    procedure FinalizeInstance; override;
    procedure InitializeInstance; override;
    
    procedure Add(AImageIndex: Integer; AComponentClass: TComponentClass);
    procedure ClearItems;
    function ImageIndexByComponentClass(AComponentClass: TComponentClass): Integer;
    property Items[Index: Integer]: TdxIdeComponentImageItem read GetItem;
  public
    class function Instance: TdxIdeImagesProvider; reintroduce; overload; 
    procedure Refresh;

    property Count: Integer read GetCount;
    property ImageIndexes[ComponentClass: TComponentClass]: Integer read GetImageIndex; default;  
    property ImageIndexesByComponentClassName[const ClassName: string]: Integer read GetImageIndexByComponentClassName;
    property ImageIndexesByObject[AnObject: TPersistent]: Integer read GetImageIndexByObject;
    property Images: TCustomImageList read FImages;
  end;
   
function dxIdeImagesProvider: TdxIdeImagesProvider;

implementation

uses
  ToolsAPI,
 {$IFDEF DELPHI9}
  PaletteAPI,
 {$ENDIF}
  Forms, Windows, Graphics, StdCtrls, SysUtils, dxPSCore, dxPSUtl;

{$IFNDEF DELPHI6}
const
  CompIconSize = 28;
{$ENDIF}

type
  IdxIDEPaletteItem = {$IFDEF DELPHI9}IInternalPaletteItem{$ELSE}IPaletteItem{$ENDIF};
 {$IFDEF DELPHI6}
  IdxIDEPalletePaint = {$IFDEF DELPHI9}INTAPalettePaintIcon{$ELSE}IPalettePaint{$ENDIF};
 {$ENDIF}
 
function IdeEnvironment: TdxDesignEnvironment;
begin
 {$IFDEF DELPHI6}
  if ActiveDesigner <> nil then
    Result := ActiveDesigner.Environment
  else  
    Result := nil;
 {$ELSE}
  Result := DelphiIDE;
 {$ENDIF}
end;
  
function CreateDesignSelectionList: TdxDesignSelectionList;
begin
 {$IFDEF DELPHI6} 
  Result := CreateSelectionList;
 {$ELSE}  
   {$IFDEF DELPHI5}
    Result := TDesignerSelectionList.Create;
   {$ELSE}
    Result := TComponentList.Create;
   {$ENDIF}      
 {$ENDIF}
end;

procedure FreeDesignSelectionList(const ASelections: TdxDesignSelectionList);
begin
 {$IFNDEF DELPHI6} 
  ASelections.Free;
 {$ENDIF}
end;

procedure RestoreDesignSelection(const ADesigner: TFormDesigner; var AList: TdxDesignSelectionList);
begin
  ADesigner.SetSelections(AList);
  FreeDesignSelectionList(AList);
end;

procedure SaveDesignSelection(const ADesigner: TFormDesigner; out AList: TdxDesignSelectionList);
begin
  AList := CreateDesignSelectionList;
  ADesigner.GetSelections(AList);
end;

function GetBaseRegistryKey: string;
begin
  Result := (BorlandIDEServices as IOTAServices).GetBaseRegistryKey;
end;

{$IFNDEF DELPHI6} 
function TryExtractPersistent(Component: IPersistent): TPersistent;
begin
  Result := DsgnIntf.TryExtractPersistent(Component);
end;
{$ENDIF}

{ TdxIdeComponentImageItem }

constructor TdxIdeComponentImageItem.Create(AImageIndex: Integer; AComponentClass: TComponentClass);
begin
  inherited Create;
  FComponentClass := AComponentClass;
  FImageIndex :=  AImageIndex;
end;

{ TdxIdeImagesProvider }

function dxIdeImagesProvider: TdxIdeImagesProvider;
begin
  Result := TdxIdeImagesProvider.Instance;
end;

class function TdxIdeImagesProvider.Instance: TdxIdeImagesProvider;
begin
  Result := inherited Instance as TdxIdeImagesProvider;
end;

procedure TdxIdeImagesProvider.FinalizeInstance;
begin
  FImages.Free;
  ClearItems;
  FItems.Free;
  inherited;
end;

procedure TdxIdeImagesProvider.InitializeInstance;
begin
  inherited;
  FImages := TImageList.CreateSize(CompIconSize + 1, CompIconSize + 1); // plus one for frame
  FItems := TList.Create;
end;

procedure TdxIdeImagesProvider.Add(AImageIndex: Integer; AComponentClass: TComponentClass);
begin
  FItems.Add(TdxIdeComponentImageItem.Create(AImageIndex, AComponentClass));
end;

procedure TdxIdeImagesProvider.ClearItems;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do 
    Items[I].Free;
  FItems.Clear;  
end;

function TdxIdeImagesProvider.ImageIndexByComponentClass(AComponentClass: TComponentClass): Integer;
var
  I: Integer;
  Item: TdxIdeComponentImageItem;
begin
  Result := -1;  
  if AComponentClass <> nil then
  begin
   {$IFDEF DELPHI5}
    if AComponentClass.InheritsFrom(TFrame) then 
      AComponentClass := TFrame;
   {$ENDIF}   
    if AComponentClass.InheritsFrom(TForm) then 
      AComponentClass := TForm;

    for I := 0 to Count - 1 do 
    begin
      Item := Items[I];
      if AComponentClass = Item.ComponentClass then 
      begin
        Result := Item.ImageIndex;
        Exit;
      end;
    end;  
  end;  
end;

procedure TdxIdeImagesProvider.Refresh;

  { TPaintItemStyle = set of (piDown, piSelected, piFramed, piGosted);}

  function GetComponentImage(APaletteItem: IdxIDEPaletteItem; ABitmap: TBitmap): Boolean;
  var
    R: TRect;
   {$IFDEF DELPHI6}
    Painter: IdxIDEPalletePaint;
   {$ENDIF}  
  begin
    R := MakeRect(0, 0, ABitmap.Width, ABitmap.Height);
    ABitmap.Canvas.Brush.Color := clBtnFace;
    ABitmap.Canvas.FillRect(R);
   {$IFDEF DELPHI6}
    Result := Supports(APaletteItem, IdxIDEPalletePaint, Painter);
   {$IFDEF DELPHI9}
    if Result then
    begin
      Painter.Paint(ABitmap.Canvas, 0, 0, pi24x24);
      DrawEdge(ABitmap.Canvas.Handle, R, BDR_RAISEDINNER, BF_RECT);
    end;
   {$ELSE}
    if Result then
      Painter.Paint(ABitmap.Canvas, 0, 0, [piFramed]);
   {$ENDIF}
   {$ELSE}
    Result := True;
    APaletteItem.Paint(ABitmap.Canvas, 0, 0);
    DrawEdge(ABitmap.Canvas.Handle, R, BDR_RAISEDINNER, BF_RECT);
   {$ENDIF}
  end;
  
  function AddComponentToImages(ABitmap: TBitmap; AComponentClass: TComponentClass): Integer;
  var
    PaletteItem: IdxIDEPaletteItem;
  begin         
    Result := -1;
    if IdeEnvironment = nil then Exit;

    PaletteItem := IdeEnvironment.GetPaletteItem(AComponentClass);
    if (PaletteItem <> nil) and GetComponentImage(PaletteItem, ABitmap) then
    begin
      FImages.Add(ABitmap, nil);
      Result := FImages.Count - 1;
    end;  
  end;
 
var
  List: TdxClassList;
  Bitmap: TBitmap;
  I, ImageIndex: Integer;
  ComponentClass: TComponentClass;
begin
  FImages.Clear;
  ClearItems;
  
  List := TdxClassList.Create;
  try
    Bitmap := TBitmap.Create;
    try
      Bitmap.Width := FImages.Width;
      Bitmap.Height := FImages.Height;
      dxPSCore.dxPSGetSupportedComponentsList(List);
      for I := 0 to List.Count - 1 do 
      begin
        ComponentClass := TComponentClass(List[I]);
        if ComponentClass <> nil then 
        begin
          ImageIndex := AddComponentToImages(Bitmap, ComponentClass);
          Add(ImageIndex, ComponentClass);
        end;  
      end;  
    finally  
      Bitmap.Free;
    end;
  finally
    List.Free;
  end;  
end;

function TdxIdeImagesProvider.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function TdxIdeImagesProvider.GetImageIndex(ComponentClass: TComponentClass): Integer;
begin
  Result := ImageIndexByComponentClass(ComponentClass);
end;                                                                

function TdxIdeImagesProvider.GetImageIndexByComponentClassName(const ClassName: string): Integer;
var
  AClass: TClass;
begin
  AClass := Classes.GetClass(ClassName);
  if AClass.InheritsFrom(TComponent) then
    Result := ImageIndexes[TComponentClass(AClass)]
  else
    Result := -1;
end;

function TdxIdeImagesProvider.GetImageIndexByObject(AnObject: TPersistent): Integer;
begin
  if AnObject is TComponent then 
    Result := ImageIndexes[TComponentClass(AnObject.ClassType)]
  else
    Result := -1;
end;
    
function TdxIdeImagesProvider.GetItem(Index: Integer): TdxIdeComponentImageItem;
begin
  Result := TdxIdeComponentImageItem(FItems[Index]);
end;

initialization

finalization
  TdxIdeImagesProvider.ReleaseInstance;
   
end.
 
