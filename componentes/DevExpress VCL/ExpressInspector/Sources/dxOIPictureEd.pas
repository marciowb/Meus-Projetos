{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       Express RTTI Inspector Picture editor 	                    }
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

unit dxOIPictureEd;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, ExtDlgs, Buttons, StdCtrls, Menus;

type
  TdxfmPictureEditor = class(TForm)
    OpenPictureDialog: TOpenPictureDialog;
    SavePictureDialog: TSavePictureDialog;
    GroupBox: TGroupBox;
    pmImage: TPopupMenu;
    miLoad: TMenuItem;
    miSave: TMenuItem;
    miLine: TMenuItem;
    miCopy: TMenuItem;
    miPaste: TMenuItem;
    miLne2: TMenuItem;
    miClear: TMenuItem;
    pnlBottom: TPanel;
    pnlBottomRight: TPanel;
    btnCancel: TButton;
    btnOk: TButton;
    pnlRight: TPanel;
    btnLoad: TButton;
    btnSave: TButton;
    btnCopy: TButton;
    btnPaste: TButton;
    btnClear: TButton;
    pnlClient: TPanel;
    Panel3: TPanel;
    Image: TImage;
    procedure btnLoadClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure btnCopyClick(Sender: TObject);
    procedure btnPasteClick(Sender: TObject);
    procedure pmImagePopup(Sender: TObject);
  private
    FClipboardFormat: Word;
    procedure DrawSizeGrip;
    function HasPicture: Boolean;
    function MouseInGripRect(const Pt: TPoint): Boolean;
    procedure UpdateButtons;
    procedure WMNCHitTest(var message: TWMNCHitTest); message WM_NCHITTEST;
  protected  
    procedure CreateParams(var Params: TCreateParams); override;
    procedure Paint; override;
  end;

  PdxPictureEditorDlgData = ^TdxPictureEditorDlgData;
  TdxPictureEditorDlgData = record
    Caption: string;
    ClipboardFormat: Word;
    GraphicFilter: string;
    Picture: TPicture;
  end;

function ShowdxPictureEditor(const AData: PdxPictureEditorDlgData): Boolean;

implementation

{$R *.DFM}

uses
  ClipBrd;

function ShowdxPictureEditor(const AData: PdxPictureEditorDlgData): Boolean;
var
  Form: TdxfmPictureEditor;
begin
  Form := TdxfmPictureEditor.Create(nil);
  with Form do
  try
    Image.Picture := AData^.Picture;
    Caption := AData^.Caption;
    OpenPictureDialog.Filter := AData^.GraphicFilter;
    SavePictureDialog.Filter := AData^.GraphicFilter;
    FClipboardFormat := AData^.ClipboardFormat;
    UpdateButtons;
    Result := ShowModal = mrOK;
    if Result then 
      AData^.Picture.Assign(Image.Picture);
  finally
    Free;
  end;
end;

{ = =========================================================================  }
{ TdxfmPictureEditor class implementation                                      }
{ = =========================================================================  }
procedure TdxfmPictureEditor.WMNCHitTest(var message: TWMNCHitTest);
begin
  inherited;
  if MouseInGripRect(ScreenToClient(SmallPointToPoint(message.Pos))) then 
    message.Result := HTBOTTOMRIGHT
end;

function TdxfmPictureEditor.MouseInGripRect(const Pt: TPoint): Boolean;
var
  GripSize: Integer;
  GripRect: TRect;
begin
  GripSize := GetSystemMetrics(SM_CXVSCROLL);
  GripRect := Bounds(ClientWidth - GripSize, ClientHeight - GripSize, GripSize, GripSize);
  Result := PtInRect(GripRect, Pt);
end;

function TdxfmPictureEditor.HasPicture: Boolean;
begin
  Result := (Image.Picture.Graphic <> nil) and not Image.Picture.Graphic.Empty;
end;

procedure TdxfmPictureEditor.UpdateButtons;
begin
  btnSave.Enabled := HasPicture; 
  btnCopy.Enabled := HasPicture;
  btnPaste.Enabled := Clipboard.HasFormat(FClipboardFormat);
  btnClear.Enabled := HasPicture;
  if HasPicture then 
    Panel3.Caption := ''
  else
    Panel3.Caption := '(None)';  
end;

procedure TdxfmPictureEditor.btnLoadClick(Sender: TObject);
begin
  if OpenPictureDialog.Execute then
  begin
    Image.Picture.LoadFromFile(OpenPictureDialog.FileName);
    UpdateButtons;
  end;  
end;

procedure TdxfmPictureEditor.btnSaveClick(Sender: TObject);
begin
  if SavePictureDialog.Execute then
  begin
    Image.Picture.SaveToFile(SavePictureDialog.FileName);
    UpdateButtons;
  end;  
end;

procedure TdxfmPictureEditor.btnClearClick(Sender: TObject);
begin
  Image.Picture := nil;
  UpdateButtons;
end;

procedure TdxfmPictureEditor.btnCopyClick(Sender: TObject);
begin
  Clipboard.Assign(Image.Picture);
  UpdateButtons;
end;

procedure TdxfmPictureEditor.btnPasteClick(Sender: TObject);
begin
  Image.Picture.Assign(Clipboard);
  UpdateButtons;
end;

procedure TdxfmPictureEditor.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.WindowClass.Style := Params.WindowClass.Style or CS_HREDRAW or CS_VREDRAW;
end;

procedure TdxfmPictureEditor.Paint;
begin  
  inherited Paint;
  if WindowState <> wsMaximized then DrawSizeGrip;
end;

procedure TdxfmPictureEditor.DrawSizeGrip;
var
  V: Integer;
  R: TRect;  
begin
  V := GetSystemMetrics(SM_CXVSCROLL);
  R := ClientRect;
  FillRect(Canvas.Handle, R, HBRUSH(COLOR_BTNFACE + 1));  
  R := Rect(R.Right - V, R.Bottom - V, R.Right, R.Bottom);
  DrawFrameControl(Canvas.Handle, R, DFC_SCROLL, DFCS_SCROLLSIZEGRIP); 
end;

procedure TdxfmPictureEditor.pmImagePopup(Sender: TObject);
begin
  miLoad.Enabled := btnLoad.Enabled;
  miSave.Enabled := btnSave.Enabled;
  miCopy.Enabled := btnCopy.Enabled;
  miPaste.Enabled := btnPaste.Enabled;
  miClear.Enabled := btnClear.Enabled;
end;

end.
