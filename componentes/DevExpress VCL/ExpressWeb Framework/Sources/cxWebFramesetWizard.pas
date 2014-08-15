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
unit cxWebFramesetWizard;

{$I cxVer.inc}

interface

uses Classes, SysUtils, HTTPApp,  ToolsAPI,
  {$IFDEF VCL}
  Windows, Graphics,
  {$ELSE}
  Qt, Types, QGraphics,
  {$ENDIF}
  cxWebWizardUtils;

type
  TcxWebFramesetWizard = class(TcxWebCustomModuleWizard, IOTAFormWizard)
  public
    function GetName: string; override;
    function GetIDString: string; override;
    function GetComment: string; override;
    function GetGlyph: Cardinal; override;
    procedure Execute; override;
  end;

  TcxWebFramesetCreator = class(TcxWebModuleCreator)
  protected
    function GetProperties: string; override;
  end;

  PcxWebFramesetTemplate = ^TcxWebFramesetTemplate;
  TcxWebFramesetTemplate = record
    Name: string;
    Description: string;
    DrawProc: TcxFramesetTemplateDrawProc;
    Tempate: string;
  end;

  TcxWebFramesetTemplates = class
  private
    FItems: TList;
    function GetCount: Integer;
    function GetItem(Index: Integer): PcxWebFramesetTemplate;
  protected
    procedure Clear;
  public
    constructor Create;
    destructor Destroy; override;
    procedure RegisterTemplate(AName, ADescription, ATempate: string;
       ADrawProc: TcxFramesetTemplateDrawProc);

    property Count: Integer read GetCount;
    property Items[Index: Integer]: PcxWebFramesetTemplate read GetItem;
  end;

procedure Register;

var
  FramesetTemplates: TcxWebFramesetTemplates;

implementation

uses
  cxWebDsgnConsts, cxWebDsgnStrs, cxfmWebFramesetWizard;


{ TcxWebPageModuleWizard }

procedure TcxWebFramesetWizard.Execute;
var
  AModuleWizardData: TcxWebModuleWizardData;
  AModuleServices: IOTAModuleServices;
begin
  with AModuleWizardData do
  begin
    ModuleType := wmtFrameset;
    CacheMode := caDestroy;
    CreateMode := crOnDemand;
    IsPublished := True;
  end;
  if ShowcxWebNewFramesetWizard(@AModuleWizardData) and
    Supports(BorlandIDEServices, IOTAModuleServices, AModuleServices) then
    AModuleServices.CreateModule(TcxWebFramesetCreator.Create(@AModuleWizardData));
end;

function TcxWebFramesetWizard.GetName: string;
begin
  Result := scxWebFramesetWizardName;
end;

function TcxWebFramesetWizard.GetIDString: string;
begin
  Result := scxWebFramesetWizardID;
end;

function TcxWebFramesetWizard.GetComment: string;
begin
  Result := scxWebFramesetWizardComment;
end;

function TcxWebFramesetWizard.GetGlyph: Cardinal;
begin
  Result :=
  {$IFDEF VCL}
    LoadIcon(HInstance, scxWebFramesetWizardIconName);
  {$ELSE}
    GetIconResourceID(scxWebFramesetWizardIconName);
  {$ENDIF}
end;

{TcxWebFramesetCreator}

function TcxWebFramesetCreator.GetProperties: string;
begin
  Result := Format(' DesignerId = %d ', [CreationData.DesignerID]);
end;

{ TcxWebFramesetTemplateList }

constructor TcxWebFramesetTemplates.Create;
begin
  FItems := TList.Create;
end;

destructor TcxWebFramesetTemplates.Destroy;
begin
  Clear;
  FItems.Free;
  inherited;
end;

function TcxWebFramesetTemplates.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function TcxWebFramesetTemplates.GetItem(Index: Integer): PcxWebFramesetTemplate;
begin
  Result := PcxWebFramesetTemplate(FItems.Items[Index]);
end;

procedure TcxWebFramesetTemplates.Clear;
var
  I: Integer;
begin
  for I := 0 to FItems.Count - 1 do
    Dispose(PcxWebFramesetTemplate(FItems.Items[I]));
  FItems.Clear;
end;

procedure TcxWebFramesetTemplates.RegisterTemplate(AName,
  ADescription, ATempate: string; ADrawProc: TcxFramesetTemplateDrawProc);
var
  Item: PcxWebFramesetTemplate;
begin
  New(Item);
  with Item^ do
  begin
    Name := AName;
    Description := ADescription;
    DrawProc := ADrawProc;
    Tempate := ATempate;
  end;
  FItems.Add(Item);
end;

procedure DrawTemplate1(Canvas: TCanvas; R: TRect);
begin
  Canvas.Rectangle(R);
  Canvas.MoveTo(R.Left, (R.Bottom - R.Top) div 5);
  Canvas.LineTo(R.Right - 1, (R.Bottom - R.Top) div 5);
  Canvas.MoveTo((R.Right - R.Left) div 2, (R.Bottom - R.Top) div 5);
  Canvas.LineTo((R.Right - R.Left) div 2, R.Bottom - 1);
end;

procedure DrawTemplate2(Canvas: TCanvas; R: TRect);
begin
  Canvas.Rectangle(R);
  Canvas.MoveTo((R.Right - R.Left) div 3, R.Top);
  Canvas.LineTo((R.Right - R.Left) div 3, R.Bottom - 1);
end;

procedure DrawTemplate3(Canvas: TCanvas; R: TRect);
begin
  Canvas.Rectangle(R);
  Canvas.MoveTo(R.Left, 9 * (R.Bottom - R.Top) div 10);
  Canvas.LineTo(R.Right - 1, 9 * (R.Bottom - R.Top) div 10);
end;

procedure DrawTemplate4(Canvas: TCanvas; R: TRect);
begin
  Canvas.Rectangle(R);
  Canvas.MoveTo(R.Left, 3 * (R.Bottom - R.Top) div 4);
  Canvas.LineTo(R.Right - 1, 3 * (R.Bottom - R.Top) div 4);
end;

procedure DrawTemplate5(Canvas: TCanvas; R: TRect);
begin
  Canvas.Rectangle(R);
  Canvas.MoveTo(R.Left, (R.Bottom - R.Top) div 6);
  Canvas.LineTo(R.Right - 1, (R.Bottom - R.Top) div 6);
end;

procedure DrawTemplate6(Canvas: TCanvas; R: TRect);
begin
  Canvas.Rectangle(R);
  Canvas.MoveTo(R.Left, (R.Bottom - R.Top) div 5);
  Canvas.LineTo(R.Right - 1, (R.Bottom - R.Top) div 5);
  Canvas.MoveTo(R.Left, 6 * (R.Bottom - R.Top) div 7);
  Canvas.LineTo(R.Right - 1, 6 * (R.Bottom - R.Top) div 7);
  Canvas.MoveTo((R.Right - R.Left) div 3, (R.Bottom - R.Top) div 5);
  Canvas.LineTo((R.Right - R.Left) div 3, 6 * (R.Bottom - R.Top) div 7);

end;

procedure DrawTemplate7(Canvas: TCanvas; R: TRect);
begin
  Canvas.Rectangle(R);
  Canvas.MoveTo(R.Left, (R.Bottom - R.Top) div 2);
  Canvas.LineTo(R.Right - 1, (R.Bottom - R.Top) div 2);
end;

procedure DrawTemplate8(Canvas: TCanvas; R: TRect);
begin
  Canvas.Rectangle(R);
  Canvas.MoveTo((R.Right -  R.Left) div 4, R.Top);
  Canvas.LineTo((R.Right -  R.Left) div 4, R.Bottom - 1);
  Canvas.MoveTo((R.Right -  R.Left) div 4, (R.Bottom - R.Top) div 5);
  Canvas.LineTo(R.Right - 1, (R.Bottom - R.Top) div 5);
end;

procedure DrawTemplate9(Canvas: TCanvas; R: TRect);
begin
  Canvas.Rectangle(R);
  Canvas.MoveTo(R.Left, (R.Bottom - R.Top) div 5);
  Canvas.LineTo(R.Right - 1, (R.Bottom - R.Top) div 5);
  Canvas.MoveTo(R.Left, (R.Bottom - R.Top) div 2);
  Canvas.LineTo(R.Right - 1, (R.Bottom - R.Top) div 2);
end;

procedure DrawTemplate10(Canvas: TCanvas; R: TRect);
begin
  Canvas.Rectangle(R);
  Canvas.MoveTo((R.Right - R.Left) div 2, R.Top);
  Canvas.LineTo((R.Right - R.Left) div 2, R.Bottom - 1);
end;

procedure DrawTemplate11(Canvas: TCanvas; R: TRect);
begin
  Canvas.Rectangle(R);
end;

procedure Register;
begin
  RegisterPackageWizard(TcxWebFramesetWizard.Create);
end;

initialization
  FramesetTemplates := TcxWebFramesetTemplates.Create;
  FramesetTemplates.RegisterTemplate(scxTemplate1Name, scxTemplate1Description, scxTemplate1Template, DrawTemplate1);
  FramesetTemplates.RegisterTemplate(scxTemplate2Name, scxTemplate2Description, scxTemplate2Template, DrawTemplate2);
  FramesetTemplates.RegisterTemplate(scxTemplate3Name, scxTemplate3Description, scxTemplate3Template, DrawTemplate3);
  FramesetTemplates.RegisterTemplate(scxTemplate4Name, scxTemplate4Description, scxTemplate4Template, DrawTemplate4);
  FramesetTemplates.RegisterTemplate(scxTemplate5Name, scxTemplate5Description, scxTemplate5Template, DrawTemplate5);
  FramesetTemplates.RegisterTemplate(scxTemplate6Name, scxTemplate6Description, scxTemplate6Template, DrawTemplate6);
  FramesetTemplates.RegisterTemplate(scxTemplate7Name, scxTemplate7Description, scxTemplate7Template, DrawTemplate7);
  FramesetTemplates.RegisterTemplate(scxTemplate8Name, scxTemplate8Description, scxTemplate8Template, DrawTemplate8);
  FramesetTemplates.RegisterTemplate(scxTemplate9Name, scxTemplate9Description, scxTemplate9Template, DrawTemplate9);
  FramesetTemplates.RegisterTemplate(scxTemplate10Name, scxTemplate10Description, scxTemplate10Template, DrawTemplate10);
  FramesetTemplates.RegisterTemplate(scxTemplate11Name, scxTemplate11Description, scxTemplate11Template, DrawTemplate11);
      
finalization
  FramesetTemplates.Free;

end.

