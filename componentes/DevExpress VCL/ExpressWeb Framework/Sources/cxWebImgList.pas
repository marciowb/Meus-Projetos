{*******************************************************************}
{                                                                   }
{       ExpressWeb Framework by Developer Express                   }
{       Visual Web Control Library                                  }
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
unit cxWebImgList;

{$I cxVer.inc}

interface

uses
  Classes,
  cxWebRender;

type
  TcxWebImageList = class;

  TcxWebImageItem = class(TCollectionItem)
  private
    FBorderWidth: Integer;
    FFileName: string;
    FHeight: Integer;
    FHint: string;
    FHorzSpace: Integer;
    FName: string;
    FVertSpace: Integer;
    FWidth: Integer;

    function GetImageList: TcxWebImageList;
    function GetFullFilePath: string;
    procedure SetFileName(Value: string);
    procedure SetHeight(Value: Integer);
    procedure SetWidth(Value: Integer);
  protected
    function GetDisplayName: string; override;
    property ImageList: TcxWebImageList read GetImageList;
  public
    procedure Assign(Source: TPersistent); override;
    procedure WriteHTML(HTMLTextBuilder: TcxHTMLTextBuilder);

    property FullFilePath: string read GetFullFilePath;
    property Name: string read FName write FName;
  published
    property BorderWidth: Integer read FBorderWidth write FBorderWidth default 0;
    property FileName: string read FFileName write SetFileName;
    property Hint: string read FHint write FHint;
    property Height: Integer read FHeight write SetHeight default 0;
    property HorzSpace: Integer read FHorzSpace write FHorzSpace default 0;
    property VertSpace: Integer read FVertSpace write FVertSpace default 0;
    property Width: Integer read FWidth write SetWidth default 0;
  end;

  TcxWebImages = class(TCollection)
  private
    FImageList: TcxWebImageList;
    function GetItem(Index: Integer): TcxWebImageItem;
    procedure SetItem(Index: Integer; Value: TcxWebImageItem);
  protected
    function GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create(AImageList: TcxWebImageList);
    function Add: TcxWebImageItem;
    property Items[Index: Integer]: TcxWebImageItem read GetItem write SetItem; default;
  end;

  TcxWebImageList = class(TComponent)
  private
    FClients: TList;
    FImages: TcxWebImages;
    FImagesPath: string;
    FDesignImagesPath: string;

    procedure SetImagesPath(Value: string);
    procedure SetDesignImagesPath(Value: string);
    procedure SetImages(Value: TcxWebImages);
    function GetClient(Index: Integer): TComponent;
    function GetClientCount: Integer;
  protected
    procedure UpdateClients;
    property Clients[Index: Integer]: TComponent read GetClient;
    property ClientCount: Integer read GetClientCount;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure RegisterClient(AComponent: TComponent);
    procedure UnregisterClient(AComponent: TComponent);
    function ValidIndex(AIndex: Integer): Boolean;
  published
    property Images: TcxWebImages read FImages write SetImages;
    property ImagesPath: string read FImagesPath write SetImagesPath;
    property DesignImagesPath: string read FDesignImagesPath write SetDesignImagesPath;
  end;

implementation

uses
  SysUtils,
  cxWebIntf;

{ TcxWebImageItem }

function TcxWebImageItem.GetImageList: TcxWebImageList;
begin
  if Collection is TcxWebImages then
    Result := TcxWebImages(Collection).FImageList
  else
    Result := nil;
end;

procedure TcxWebImageItem.SetFileName(Value: string);
begin
  if FFileName <> Value then
  begin
    FFileName := Value;
    if ImageList <> nil then
      ImageList.UpdateClients;
  end;
end;

procedure TcxWebImageItem.SetHeight(Value: Integer);
begin
  if Value < 0 then
    Value := 0;
  if FHeight <> Value then
    FHeight := Value;
end;

procedure TcxWebImageItem.SetWidth(Value: Integer);
begin
  if Value < 0 then
    Value := 0;
  if FWidth <> Value then
    FWidth := Value;
end;

function TcxWebImageItem.GetDisplayName: string;
begin
  if FileName <> '' then
    Result := ExtractFileName(FileName)
  else Result := inherited GetDisplayName;
end;

procedure TcxWebImageItem.Assign(Source: TPersistent);
begin
  if Source is TcxWebImageItem then
  begin
    BorderWidth := TcxWebImageItem(Source).BorderWidth;
    FileName := TcxWebImageItem(Source).FileName;
    Hint := TcxWebImageItem(Source).Hint;
    Height := TcxWebImageItem(Source).Height;
    HorzSpace := TcxWebImageItem(Source).HorzSpace;
    VertSpace := TcxWebImageItem(Source).VertSpace;
    Width := TcxWebImageItem(Source).Width;
  end
  else
    inherited Assign(Source);
end;

procedure TcxWebImageItem.WriteHTML(HTMLTextBuilder: TcxHTMLTextBuilder);
begin
  HTMLTextBuilder.WriteSingleTag(TcxHTMLTagImg, False, False);
  HTMLTextBuilder.WriteAttribute(aSrc, FullFilePath);
  HTMLTextBuilder.WriteAttribute(aAlt, Hint);
  HTMLTextBuilder.WriteAttribute(aTitle, Hint);
  HTMLTextBuilder.WriteAttribute(aBorder, BorderWidth);
  HTMLTextBuilder.WriteAttribute(aHspace, HorzSpace);
  HTMLTextBuilder.WriteAttribute(aVspace, VertSpace);

  if Width > 0 then
    HTMLTextBuilder.WriteAttribute(aWidth, Width);
  if Height > 0 then
    HTMLTextBuilder.WriteAttribute(aHeight, Height);
end;

function TcxWebImageItem.GetFullFilePath: string;
var
  Delim: Char;
begin
  if (csDesigning in ImageList.ComponentState) or
    ((ImageList.Owner <> nil) and (csDesigning in ImageList.Owner.ComponentState)) then
  begin
    Result := ImageList.DesignImagesPath;
    Delim := '\';
  end
  else
  begin
    Result := ImageList.ImagesPath;
    Delim := '/';
  end;
  if (Result <> '') and (Result[Length(Result)] <> '/') and
    (Result[Length(Result)] <> '\') then
    Result := Result + Delim;
  Result := Result + FFileName;
end;

{ TcxWebImages }

constructor TcxWebImages.Create(AImageList: TcxWebImageList);
begin
  inherited Create(TcxWebImageItem);
  FImageList := AImageList;
end;

function TcxWebImages.GetItem(Index: Integer): TcxWebImageItem;
begin
  Result := TcxWebImageItem(inherited Items[Index]);
end;

procedure TcxWebImages.SetItem(Index: Integer; Value: TcxWebImageItem);
begin
  Items[Index].Assign(Value);
end;

function TcxWebImages.GetOwner: TPersistent;
begin
  Result := FImageList;
end;

procedure TcxWebImages.Update(Item: TCollectionItem);
begin
  if FImageList <> nil then
    FImageList.UpdateClients;
end;

function TcxWebImages.Add: TcxWebImageItem;
begin
  Result := TcxWebImageItem(inherited Add);
end;

{ TcxWebImageList }

constructor TcxWebImageList.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FImages := TcxWebImages.Create(Self);
  FClients := TList.Create;
end;

destructor TcxWebImageList.Destroy;
begin
  FClients.Free;
  FImages.Free;
  inherited Destroy;
end;

procedure TcxWebImageList.RegisterClient(AComponent: TComponent);
begin
  if FClients.IndexOf(AComponent) < 0 then
    FClients.Add(AComponent);
end;

procedure TcxWebImageList.UnregisterClient(AComponent: TComponent);
begin
  FClients.Remove(AComponent);
end;

function TcxWebImageList.ValidIndex(AIndex: Integer): Boolean;
begin
  Result := (AIndex >= 0) and (AIndex < Images.Count);
end;

procedure TcxWebImageList.SetImagesPath(Value: string);
begin
  if FImagesPath <> Value then
  begin
    FImagesPath := Value;
    UpdateClients;
  end;
end;

procedure TcxWebImageList.SetDesignImagesPath(Value: string);
begin
  if FDesignImagesPath <> Value then
  begin
    FDesignImagesPath := Value;
    UpdateClients;
  end;
end;

procedure TcxWebImageList.SetImages(Value: TcxWebImages);
begin
  FImages.Assign(Value);
end;

function TcxWebImageList.GetClient(Index: Integer): TComponent;
begin
  Result := TComponent(FClients.Items[Index]);
end;

function TcxWebImageList.GetClientCount: Integer;
begin
  Result := FClients.Count;
end;

procedure TcxWebImageList.UpdateClients;
var
  I: Integer;
  AControl: IcxWebControl;
begin
  if csDestroying in ComponentState then exit;
  for I := 0 to ClientCount - 1 do
    if Supports(Clients[I], IcxWebControl, AControl) and (AControl.DesignerControl <> nil) then
      AControl.DesignerControl.UpdateContext;
end;

initialization
  RegisterClasses([TcxWebImageList, TcxWebImageItem]);

end.

