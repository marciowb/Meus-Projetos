
{*******************************************************************}
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

unit dxPScxEditorLnks;

interface

{$I cxVer.inc}

uses
  Classes, Graphics, Controls, StdCtrls, cxControls, cxContainer, cxListBox, 
  cxImage, cxEdit, cxMemo, dxPSCore, dxPSLbxLnk, dxPSGraphicLnk, dxPSTextLnk;

type
  TcxListBoxReportLink = class(TCustomdxListBoxReportLinkControl)
  private
    function GetcxListBox: TcxListBox;
  protected
    function GetCustomListBox: TCustomListBox; override;
  public
    property cxListBox: TcxListBox read GetcxListBox;  
  published
    property AutoWidth; 
    property Color;
    property EndEllipsis;
    property EvenColor;
    property EvenFont;
    property Font;
    property OddColor;
    property OddFont;
    property Options;
    property Multiline;
    property PaintItemsGraphics;
    property RowAutoHeight;
    property ScaleFonts;
    property SupportedCustomDraw;
    property Transparent;
    property TransparentGraphics;
    property UseCustomPageBreaks;
    property UseHorzDelimiters;
    property UseVertDelimiters;
    property Width;
    
    property OnCustomDrawItem;
    property OnGetCustomPageBreaks;
    property OnInitializeItem;
  end;

  TcxCustomImageReportLink = class(TCustomdxPictureReportLink)
  private
    function GetcxCustomImage: TcxCustomImage;
  protected
    procedure InternalRestoreDefaults; override;
    procedure InternalRestoreFromOriginal; override;

    function GetGraphicHeight: Integer; override;
    function GetGraphicWidth: Integer; override;
    function GetPicture: TPicture; override;

    property cxCustomImage: TcxCustomImage read GetcxCustomImage;
  public
    constructor Create(AOwner: TComponent); override;
    function DataProviderPresent: Boolean; override;
  end;

  TcxImageReportLink = class(TcxCustomImageReportLink)
  private
    function GetcxImage: TcxImage;
  public
    property cxImage: TcxImage read GetcxImage;
  published
    property BorderColor;
    property Center default True;
    property DrawBorder;
    property Proportional default True;
    property Stretch;
    property Transparent;
    property TransparentColor;
  end;
  
  TcxCustomMemoReportLink = class(TdxCustomMemoReportLink)
  private
    function GetcxCustomMemo: TcxCustomMemo;
  protected
    function GetCustomMemo: TCustomMemo; override;
    property cxCustomMemo: TcxCustomMemo read GetcxCustomMemo;
  end;
  
  TcxMemoReportLink = class(TcxCustomMemoReportLink)
  private
    function GetcxMemo: TcxMemo;
  public
    property cxMemo: TcxMemo read GetcxMemo;
  end;

{ Helpers } 

function cxContainer_GetInnerControl(AControl: TcxContainer): TWinControl;
function cxControl_GetHScrollBar(AControl: TcxControl): TcxControlScrollBar;
function cxControl_GetVScrollBar(AControl: TcxControl): TcxControlScrollBar;
function cxControl_GetSizeGrip(AControl: TcxControl): TcxSizeGrip;
function cxEdit_GetProperties(AControl: TcxCustomEdit): TcxCustomEditProperties;
function cxImage_GetPicture(AControl: TcxCustomImage): TPicture;

implementation

uses
  dxPScxCommon;
  
type
  TcxContainerAccess = class(TcxContainer);
  TcxControlAccess = class(TcxControl);
  TcxCustomEditAccess = class(TcxCustomEdit);
  TcxCustomImageAccess = class(TcxCustomImage);

{ Helpers } 

function cxContainer_GetInnerControl(AControl: TcxContainer): TWinControl;
begin
  Result := TcxContainerAccess(AControl).InnerControl;
end;

function cxControl_GetHScrollBar(AControl: TcxControl): TcxControlScrollBar;
begin
  Result := TcxControlAccess(AControl).HScrollBar;
end;

function cxControl_GetVScrollBar(AControl: TcxControl): TcxControlScrollBar;
begin
  Result := TcxControlAccess(AControl).VScrollBar;
end;

function cxControl_GetSizeGrip(AControl: TcxControl): TcxSizeGrip;
begin
  Result := TcxControlAccess(AControl).SizeGrip;
end;

function cxEdit_GetProperties(AControl: TcxCustomEdit): TcxCustomEditProperties;
begin
  Result := TcxCustomEditAccess(AControl).ActiveProperties;
end;

function cxImage_GetPicture(AControl: TcxCustomImage): TPicture;
begin
  Result := TcxCustomImageAccess(AControl).Picture;
end;
  
{ TcxListBoxReportLink }

function TcxListBoxReportLink.GetCustomListBox: TCustomListBox;
begin
  if cxListBox <> nil then
    Result := TCustomListBox(cxContainer_GetInnerControl(cxListBox))
  else
    Result := nil;  
end;

function TcxListBoxReportLink.GetcxListBox: TcxListBox;
begin
  Result := inherited Component as TcxListBox;
end;
  
{ TcxCustomImageReportLink }
  
constructor TcxCustomImageReportLink.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  InternalRestoreDefaults;
  LinkModified(False);
end;

function TcxCustomImageReportLink.DataProviderPresent: Boolean;
begin
  if DataSource = rldsComponent then
    Result := cxCustomImage <> nil
  else
    Result := inherited DataProviderPresent;
end;
            
procedure TcxCustomImageReportLink.InternalRestoreDefaults;
begin
  inherited InternalRestoreDefaults;
  Proportional := True;
  Center := True;
end;
  
procedure TcxCustomImageReportLink.InternalRestoreFromOriginal;
begin
  inherited InternalRestoreFromOriginal;
  Center := cxImageProperties_GetCenter(cxEdit_GetProperties(cxCustomImage));
  Stretch := cxImageProperties_GetStretch(cxEdit_GetProperties(cxCustomImage));
  Proportional := cxImageProperties_GetProportional(cxEdit_GetProperties(cxCustomImage));
end;

function TcxCustomImageReportLink.GetGraphicHeight: Integer;
begin
  if cxCustomImage <> nil then
  begin
    Result := cxCustomImage.Height;
    // 3.2
    //if IsAggregated and (Result < inherited GetGraphicHeight) then 
    //  Result := inherited GetGraphicHeight;
  end    
  else
    Result := inherited GetGraphicHeight;  
end;

function TcxCustomImageReportLink.GetGraphicWidth: Integer;
begin
  if cxCustomImage <> nil then
  begin
    Result := cxCustomImage.Width;
    // 3.2
    //if IsAggregated and (Result < inherited GetGraphicWidth) then 
    //  Result := inherited GetGraphicWidth;
  end    
  else
    Result := inherited GetGraphicWidth;
end;
    
function TcxCustomImageReportLink.GetPicture: TPicture;
begin
  if cxCustomImage <> nil then 
    Result := cxImage_GetPicture(cxCustomImage)
  else 
    Result := inherited GetPicture;
end;
    
function TcxCustomImageReportLink.GetcxCustomImage: TcxCustomImage;
begin
  Result := inherited Component as TcxCustomImage;
end;

{ TcxImageReportLink }

function TcxImageReportLink.GetcxImage: TcxImage;
begin
  Result := inherited Component as TcxImage;
end;
  
{ TcxCustomMemoReportLink }

function TcxCustomMemoReportLink.GetCustomMemo: TCustomMemo;
begin
  if cxCustomMemo <> nil then
    Result := TCustomMemo(cxContainer_GetInnerControl(cxCustomMemo))
  else
    Result := nil;  
end;

function TcxCustomMemoReportLink.GetcxCustomMemo: TcxCustomMemo;
begin
  Result := inherited Component as TcxCustomMemo;
end;
  
{ TcxMemoReportLink }

function TcxMemoReportLink.GetcxMemo: TcxMemo;
begin
  Result := inherited Component as TcxMemo;
end;

initialization
  dxPSRegisterReportLink(TcxListBoxReportLink, TcxListBox, TdxLBxReportLinkDesignWindow);
  dxPSRegisterReportLink(TcxImageReportLink, TcxImage, nil);
  dxPSRegisterReportLink(TcxMemoReportLink, TcxMemo, TdxfmTextReportLinkDesignWindow);

finalization
  dxPSUnregisterReportLink(TcxMemoReportLink, TcxMemo, TdxfmTextReportLinkDesignWindow);
  dxPSUnregisterReportLink(TcxImageReportLink, TcxImage, nil);
  dxPSUnregisterReportLink(TcxListBoxReportLink, TcxListBox, TdxLBxReportLinkDesignWindow);
  
end.
