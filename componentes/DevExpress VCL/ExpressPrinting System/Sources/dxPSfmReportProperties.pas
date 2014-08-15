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

unit dxPSfmReportProperties;

interface

{$I cxVer.inc}

uses
  Windows, Classes, Controls, Graphics, StdCtrls, ComCtrls, ExtCtrls, Forms, 
  dxPSCore, dxPSForm, dxExtCtrls;
                           
type
  TdxfmPSReportProperties = class(TCustomdxPSExplorerItemPropertySheets)
    pcSummary: TPageControl;
    tshSummary: TTabSheet;
    btnOK: TButton;
    btnCancel: TButton;
    btnHelp: TButton;
    Image1: TImage;
    edName: TEdit;
    Bevel1: TBevel;
    lblCreator: TLabel;
    lblCreationDate: TLabel;
    Bevel2: TBevel;
    edCreator: TEdit;
    edCreationDate: TEdit;
    pcDescription: TPageControl;
    tshDescription: TTabSheet;
    tshPreview: TTabSheet;
    memDescription: TMemo;
    btnPreview: TButton;
    bvlPreviewHost: TBevel;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure PreviewClick(Sender: TObject);
  private
    FPreviewBox: TdxPSImageScrollBox;
    function GetReportCaption: string;
    function GetReportCreationDateTime: TDateTime; 
    function GetReportCreator: string;
    function GetReportDescription: string;
    procedure SetReportCaption(const Value: string);
    procedure SetReportCreationDateTime(const Value: TDateTime);
    procedure SetReportCreator(const Value: string);
    procedure SetReportDescription(const Value: string);
    procedure SetReportPreview(Value: TGraphic);
  protected
    procedure CreateWnd; override;

    procedure BeforeConstruction; override;
    procedure Done; override;
    procedure Initialize; override;
    
    procedure CreateControls; virtual;
    function HasGraphic: Boolean;
    procedure LoadStrings; virtual;
  public
    constructor Create(AOwner: TComponent); override;

    function ExplorerItem: TdxPSExplorerItem; reintroduce; overload;
    
    property ReportCaption: string read GetReportCaption write SetReportCaption;
    property ReportCreationDateTime: TDateTime read GetReportCreationDateTime write SetReportCreationDateTime;
    property ReportCreator: string read GetReportCreator write SetReportCreator;
    property ReportDescription: string read GetReportDescription write SetReportDescription;
    property ReportPreview: TGraphic write SetReportPreview;

    property PreviewBox: TdxPSImageScrollBox read FPreviewBox;
  end;

implementation

{$R *.dfm}

uses
 {$IFDEF DELPHI7} 
  Themes, 
 {$ENDIF}
  Messages, SysUtils, Dialogs, ExtDlgs, cxClasses, dxPSGlbl, dxPSUtl, dxPSRes, 
  dxPcPrVW;
  
{ TdxfmPSReportProperties }

constructor TdxfmPSReportProperties.Create(AOwner: TComponent);
begin
  inherited;

  HelpContext := dxPSGlbl.dxhcPSReportPropertiesDlg;
  if HelpContext = 0 then
  begin
    btnOK.BoundsRect := btnCancel.BoundsRect;
    btnCancel.BoundsRect := btnHelp.BoundsRect;
    btnHelp.Visible := False;
    BorderIcons := BorderIcons - [biHelp];
  end;
  
  CreateControls;
  LoadStrings; 
  pcDescription.ActivePage := tshDescription;
end;

function TdxfmPSReportProperties.ExplorerItem: TdxPSExplorerItem;
begin
  Result := inherited ExplorerItem as TdxPSExplorerItem;
end;

procedure TdxfmPSReportProperties.CreateWnd;
begin
  inherited;
  SendMessage(Handle, WM_SETICON, 1, Icon.Handle);
end;

procedure TdxfmPSReportProperties.BeforeConstruction;
begin
  inherited;
  Options := Options + [foSizeableDialog];
end;

procedure TdxfmPSReportProperties.Done;
begin
  if ModalResult = mrOK then 
    with ExplorerItem.ReportDocument do
    begin
      BeginUpdate;
      try
        Caption := ReportCaption;
        Description := ReportDescription;
      finally
        EndUpdate;  
      end;  
    end;  
end;

procedure TdxfmPSReportProperties.Initialize;
const
  Colors: array[Boolean] of TColor = (clWindow, clBtnFace);
begin
  with ExplorerItem.ReportDocument do
  begin
    ReportCaption := Caption;
    ReportCreator := Creator;
    ReportCreationDateTime := CreationDate;
    ReportDescription := Description;
    ReportPreview := Preview;
  end;  
  
  Caption := ReportCaption;
  if Caption <> '' then 
    Caption := '"' + Caption + '"  ';
  Caption := Caption + DropAmpersand(cxGetResourceString(@sdxProperties));

  edName.ReadOnly := ExplorerItem.IsCurrentlyLoaded;
 {$IFDEF DELPHI7}
  if not Themes.ThemeServices.ThemesEnabled then
  begin
 {$ENDIF} 
    edName.Color := Colors[edName.ReadOnly];
    edCreator.ParentColor := True;
    edCreationDate.ParentColor := True;
 {$IFDEF DELPHI7}
  end
  else
  begin
    Control_SetParentBackground(edCreator, True);
    Control_SetParentBackground(edCreationDate, True);
  end;
 {$ENDIF} 
 
  btnPreview.Enabled := HasGraphic;
  PreviewBox.Enabled := HasGraphic;
end;

procedure TdxfmPSReportProperties.CreateControls;
begin
  bvlPreviewHost.Visible := False;
  
  FPreviewBox := TdxPSImageScrollBox.Create(Self);
  with FPreviewBox do
  begin
    Parent := tshPreview;
    Align := alTop;
    Anchors := [akLeft..akBottom];
    Height := bvlPreviewHost.Height;
  end;
end;

function TdxfmPSReportProperties.HasGraphic: Boolean;
begin
  Result := PreviewBox.HasGraphic;
end;

procedure TdxfmPSReportProperties.LoadStrings;
begin
  inherited;
  btnOK.Caption := cxGetResourceString(@sdxBtnOK);
  btnCancel.Caption := cxGetResourceString(@sdxBtnCancel);
  btnHelp.Caption := cxGetResourceString(@sdxBtnHelp);
  btnPreview.Caption := AddEndEllipsis(cxGetResourceString(@sdxPreview));
  
  tshSummary.Caption := cxGetResourceString(@sdxSummary);
  lblCreator.Caption := cxGetResourceString(@sdxCreator);
  lblCreationDate.Caption  := cxGetResourceString(@sdxCreationDate);
  tshDescription.Caption := DropColon(DropAmpersand(cxGetResourceString(@sdxDescription)));
  tshPreview.Caption := DropAmpersand(cxGetResourceString(@sdxPreview));
end;

function TdxfmPSReportProperties.GetReportCaption: string;
begin
  Result := edName.Text;
end;

function TdxfmPSReportProperties.GetReportCreationDateTime: TDateTime; 
begin
  Result := SysUtils.StrToDateTime(edCreationDate.Text);
end;

function TdxfmPSReportProperties.GetReportCreator: string;
begin
  Result := edCreator.Text;
end;

function TdxfmPSReportProperties.GetReportDescription: string;
begin
  Result := memDescription.Text;
end;

procedure TdxfmPSReportProperties.SetReportCaption(const Value: string);
begin
  edName.Text := Value;
end;                     

procedure TdxfmPSReportProperties.SetReportCreationDateTime(const Value: TDateTime);
const
  LongDateFormat = 'mmmm d, yyyy';
var
  SystemTime: TSystemTime;
  DefaultLCID: LCID;
  DateFormat, TimeFormat: string;
  Buffer: array[Byte] of Char;
begin                 
  DateTimeToSystemTime(Value, SystemTime);
  DefaultLCID := GetThreadLocale;
  
  DateFormat := GetLocaleStr(DefaultLCID, LOCALE_SLONGDATE, LongDateFormat);
  GetDateFormat(DefaultLCID, 0, @SystemTime, PChar(DateFormat), @Buffer, SizeOf(Buffer));
  edCreationDate.Text := Buffer;
  
  TimeFormat := GetLocaleStr(DefaultLCID, LOCALE_STIMEFORMAT, LongTimeFormat);
  GetTimeFormat(DefaultLCID, 0, @SystemTime, PChar(TimeFormat), @Buffer, SizeOf(Buffer));
  edCreationDate.Text := edCreationDate.Text + ',   ' + Buffer;
end;

procedure TdxfmPSReportProperties.SetReportCreator(const Value: string);
begin
  edCreator.Text := Value;
end;

procedure TdxfmPSReportProperties.SetReportDescription(const Value: string);
begin
  memDescription.Text := Value;
end;

procedure TdxfmPSReportProperties.SetReportPreview(Value: TGraphic);
begin
  PreviewBox.Picture.Graphic := Value;
end;

procedure TdxfmPSReportProperties.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose := (ModalResult = mrCancel) or ExplorerItem.IsCurrentlyLoaded or 
    not ExplorerItem.IsNameChanged(ReportCaption) or ExplorerItem.CanRenameTo(ReportCaption);
  if not CanClose then
  begin
    dxPSUtl.MessageError(ExplorerItem.CannotRenameMessageText(ExplorerItem.DisplayName, ReportCaption));
    ActiveControl := edName;
    edName.SelectAll;
  end;
end;

procedure TdxfmPSReportProperties.PreviewClick(Sender: TObject);
begin
  dxPcPrVW.dxShowPicturePreview(PreviewBox.Picture.Graphic);
end;

end.
