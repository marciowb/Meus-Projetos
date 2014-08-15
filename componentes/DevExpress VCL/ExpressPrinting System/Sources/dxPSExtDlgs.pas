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

unit dxPSExtDlgs;

interface

{$I cxVer.inc}

uses 
  Messages, Windows, SysUtils, Classes, Controls, Forms, StdCtrls, Graphics, 
  ExtCtrls, Buttons, Dialogs, cxClasses, dxPSCore, dxExtCtrls;

type
  TdxPSOpenReportDialog = class(TOpenDialog)
  private
    FPrevFileName: string;
    FPreviewRect: TRect;
    FReportDocument: TdxPSReportDocument;

    btnPreview: TSpeedButton;
    lblPreview: TLabel;
    pnlPicture: TPanel;
    pnlToolBar: TPanel;
    sbxPreview: TdxPSImageScrollBox;
    function GetGraphic: TGraphic;
    function GetHasDocument: Boolean;
    function GetIsDocumentValid: Boolean;
    procedure PreviewClick(Sender: TObject);
  protected
    procedure DoClose; override;
    procedure DoSelectionChange; override;
    procedure DoShow; override;
    function TaskModalDialog(DialogFunc: Pointer; var DialogData): Bool; override;
    procedure CreateControls; virtual;
    procedure Initialize; virtual;
    function IsSelectedFileValid: Boolean; virtual;
    procedure LoadReportDocument;
    procedure LoadStrings; virtual;
    procedure PlacePreviewPanelInitial;
    procedure UpdateControls; virtual;
    
    property Graphic: TGraphic read GetGraphic;
    property HasDocument: Boolean read GetHasDocument;
    property IsDocumentValid: Boolean read GetIsDocumentValid;
    property PreviewRect: TRect read FPreviewRect;
    property ReportDocument: TdxPSReportDocument read FReportDocument;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Execute: Boolean; override;
  end;

  TdxPSSaveReportDialog = class(TdxPSOpenReportDialog)
  public
    constructor Create(AOwner: TComponent); override;
    function Execute: Boolean; override;
  end;
  
const
  sdxPicturePanel = 'pnlPicture';       // Don't localize
  sdxPreviewButton = 'btnPreview';      // Don't localize
  sdxPreviewLabel = 'lblPreview';       // Don't localize
  sdxPreviewScrollBox = 'sbxPreview';   // Don't localize
  sdxPreviewToolBar = 'pnlToolBar';     // Don't localize
  
implementation

uses
  CommDlg, dxPSRes, dxPSImgs, dxPSUtl, dxPCPrVw;

{$R dxPSExtDlgs.res}

{ TdxPSOpenReportDialog }

constructor TdxPSOpenReportDialog.Create(AOwner: TComponent);
begin
  inherited;
  CreateControls;
  DefaultExt := dxPSCore.dxPSReportFileShortExtension;
  Filter := Format('%s (*.%1:s)|*.%1:s', [cxGetResourceString(@sdxPSReportFiles), dxPSCore.dxPSReportFileShortExtension]);
  Options := Options + [ofPathMustExist, ofFileMustExist];
  Title := cxGetResourceString(@sdxLoadReportDataToFileTitle);
end;

destructor TdxPSOpenReportDialog.Destroy;
begin
  FreeAndNil(FReportDocument);
  inherited;
end;

function TdxPSOpenReportDialog.Execute: Boolean;
begin
  if NewStyleControls and not (ofOldStyleDialog in Options) then
    Template := 'DXPSDLGTEMPLATE' 
  else
    Template := nil;
  Result := inherited Execute;
end;

procedure TdxPSOpenReportDialog.DoClose;
begin
  inherited;
  Application.HideHint;
end;

procedure TdxPSOpenReportDialog.DoSelectionChange;
begin
  if FileName <> FPrevFileName then
  begin
    FPrevFileName := FileName;
    if IsSelectedFileValid then 
      LoadReportDocument;
    UpdateControls;
  end;
  inherited;
end;
                              
procedure TdxPSOpenReportDialog.DoShow;
begin
  Initialize;
  inherited;
end;

function TdxPSOpenReportDialog.TaskModalDialog(DialogFunc: Pointer; var DialogData): Bool;
var
  Wnd: HWND;
begin
  Wnd := SetParent(Handle, GetForegroundWindow);
  TOpenFileName(DialogData).hInstance := hInstance;
  Result := inherited TaskModalDialog(DialogFunc,  DialogData);
  SetParent(Handle, Wnd);
end;

procedure TdxPSOpenReportDialog.CreateControls;

  procedure CreatePicturePanel;
  begin
    pnlPicture := TPanel.Create(Self);
    with pnlPicture do
    begin
      Name := sdxPicturePanel;
      Caption := '';
      BevelInner := bvNone;
      BevelOuter := bvNone;
      TabOrder := 1;

      SetBounds(204, 5, 169, 200);
    end;
  end;
  
  procedure CreatePreviewToolBar;
  begin
    pnlToolBar := TPanel.Create(Self);
    with pnlToolBar do
    begin
      Parent := pnlPicture;
      Align := alTop;
      BevelInner := bvNone;
      BevelOuter := bvNone;
      Height := 31; //29
      Name := sdxPreviewToolBar;
      Caption := '';
      TabOrder := 0;
    end;
  end;
             
  procedure CreatePreviewLabel;
  begin
    lblPreview := TLabel.Create(Self);
    with lblPreview do
    begin
      Parent := pnlToolBar;
      AutoSize := False;
      Caption := '';
      Name := sdxPreviewLabel;

      SetBounds(2, 6, 157, 23);
    end;  
  end;

  procedure CreatePreviewButton;
  begin
    btnPreview := TSpeedButton.Create(Self);
    with btnPreview do
    begin
      Parent := pnlToolBar;
      Enabled := False;
      Bitmap_LoadFromResourceName(Glyph, IDB_DXPSPREVIEW);
      Name := sdxPreviewButton;
      ParentShowHint := False;
      ShowHint := True;

      SetBounds(77, 1, 23, 22);
      
      OnClick := PreviewClick;
    end;
  end;

  procedure CreatePreviewScrollBox;
  begin
    sbxPreview := TdxPSImageScrollBox.Create(Self);
    with sbxPreview do
    begin
      Parent := pnlPicture;
      Align := alClient;
      Ctl3D := True;
      HorzScrollBar.Tracking := True;
      Name := sdxPreviewScrollBox;
      TabOrder := 1;
      VertScrollBar.Tracking := True;

      OnDblClick := PreviewClick;
    end;
  end;

  {procedure CreateCreatorPanel;
  begin
    pnlCreatr := TPanel.Create(Self);
    with pnlCreator do 
    begin
      Parent := pnlPicture;
      Align := alBottom;
      Name := sdxCreatorPanel;
    end;
  end;}
  
begin
  CreatePicturePanel;
  CreatePreviewToolBar;
  CreatePreviewLabel;
  CreatePreviewButton;
  CreatePreviewScrollBox;
end;

function TdxPSOpenReportDialog.IsSelectedFileValid: Boolean;
begin
  Result := FileExists(FileName) and (GetFileAttributes(PChar(FileName)) <> $FFFFFFFF);
end;

procedure TdxPSOpenReportDialog.LoadReportDocument;
var
  Stream: TFileStream;
begin
  FreeAndNil(FReportDocument);
  Stream := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
  try
    try
      FReportDocument := TBasedxReportLink.ExtractReportDocument(Stream, True);
    except
      FReportDocument := nil;
    end;  
  finally
    Stream.Free;
  end;
end;

procedure TdxPSOpenReportDialog.Initialize;
begin
  LoadStrings;
  PlacePreviewPanelInitial;
  UpdateControls;
end;
                            
procedure TdxPSOpenReportDialog.LoadStrings;
begin
  lblPreview.Caption := DropAmpersand(cxGetResourceString(@sdxPreview)) + ':';
  btnPreview.Hint := DropAmpersand(cxGetResourceString(@sdxPreview));
end;

procedure TdxPSOpenReportDialog.PlacePreviewPanelInitial;
var
  R: TRect;
begin      
  R := GetStaticRect;

  Windows.GetClientRect(Handle, FPreviewRect);
  FPreviewRect.Left := R.Left + (R.Right - R.Left);
  Inc(FPreviewRect.Top, 4);
  
  pnlPicture.ParentWindow := Handle;
  pnlPicture.Realign;
  pnlPicture.BoundsRect := PreviewRect;

  btnPreview.Left := pnlToolBar.BoundsRect.Right - btnPreview.Width - 2;
end;

procedure TdxPSOpenReportDialog.UpdateControls;
begin
  btnPreview.Enabled := IsDocumentValid;
  
  sbxPreview.Enabled := IsDocumentValid;
  sbxPreview.Picture.Assign(Graphic);
  if IsDocumentValid then
    sbxPreview.HintText := ''
  else
    if FileExists(FileName) then 
      sbxPreview.HintText := cxGetResourceString(@sdxReportDocumentIsCorrupted)
    else
      sbxPreview.HintText := cxGetResourceString(@sdxNone);
end;

function TdxPSOpenReportDialog.GetGraphic: TGraphic;
begin
  if ReportDocument <> nil then
    Result := ReportDocument.Preview
  else  
    Result := nil;
end;

function TdxPSOpenReportDialog.GetHasDocument: Boolean;
begin
  Result := ReportDocument <> nil; 
end;

function TdxPSOpenReportDialog.GetIsDocumentValid: Boolean;
begin
  Result := Graphic <> nil;
end;

procedure TdxPSOpenReportDialog.PreviewClick(Sender: TObject);
begin
  dxPCPrVw.dxShowPicturePreview(Graphic);
end;

{ TdxPSSaveReportDialog }
                                 
constructor TdxPSSaveReportDialog.Create(AOwner: TComponent);
begin
  inherited;
  Options := Options + [ofOverwritePrompt];
  Title := cxGetResourceString(@sdxSaveReportDataToFileTitle);
end;

function TdxPSSaveReportDialog.Execute: Boolean;
begin
  if NewStyleControls and not (ofOldStyleDialog in Options) then
    Template := 'DXPSDLGTEMPLATE' 
  else
    Template := nil;
  Result := DoExecute(@GetSaveFileName);
end;

end.

