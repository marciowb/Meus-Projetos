{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       Express RTTI Inspector Strings Editor                       }
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

unit dxOIStringsEd;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls;

type
  TdxfmStringsEditor = class(TForm)
    pnlBottom: TPanel;
    pnlBottomRight: TPanel;
    btnOK: TButton;
    btnCancel: TButton;
    pnlClient: TPanel;
    GroupBox: TGroupBox;
    pnlClientTop: TPanel;
    Label1: TLabel;
    pnlClientClient: TPanel;
    Memo1: TMemo;
    procedure Memo1Change(Sender: TObject);
  private  
    procedure DrawSizeGrip;
    function MouseInGripRect(const Pt: TPoint): Boolean;
    procedure WMNCHitTest(var message: TWMNCHitTest); message WM_NCHITTEST;
  protected
    procedure CreateParams(var Params: TCreateParams); override;    
    procedure DoShow; override;
    procedure Paint; override;
  end;

  PdxStringsEditorDlgData = ^TdxStringsEditorDlgData;
  TdxStringsEditorDlgData = record
    Caption: string;
    Text: string;
  end;
  
function ShowdxStringsEditor(const AData: PdxStringsEditorDlgData): Boolean;

implementation

{$R *.DFM}

function ShowdxStringsEditor(const AData: PdxStringsEditorDlgData): Boolean;
var
  Form: TdxfmStringsEditor;
begin
  Form := TdxfmStringsEditor.Create(nil);
  with Form do 
  try
    Caption := AData.Caption;
    Memo1.Text := AData.Text;
    Result := Form.ShowModal = mrOK;
    if Result then 
      AData^.Text := Memo1.Text;
  finally
    Free;
  end;
end;

procedure TdxfmStringsEditor.WMNCHitTest(var message: TWMNCHitTest);
begin
  inherited;
  if MouseInGripRect(ScreenToClient(SmallPointToPoint(message.Pos))) then 
    message.Result := HTBOTTOMRIGHT
end;

function TdxfmStringsEditor.MouseInGripRect(const Pt: TPoint): Boolean;
var
  GripSize: Integer;
  GripRect: TRect;
begin
  GripSize := GetSystemMetrics(SM_CXVSCROLL);
  GripRect := Bounds(ClientWidth - GripSize, ClientHeight - GripSize, GripSize, GripSize);
  Result := PtInRect(GripRect, Pt);
end;

procedure TdxfmStringsEditor.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.WindowClass.Style := Params.WindowClass.Style or CS_HREDRAW or CS_VREDRAW;
end;

procedure TdxfmStringsEditor.Memo1Change(Sender: TObject);
begin
  Label1.Caption := IntToStr(Memo1.Perform(EM_GETLINECOUNT, 0, 0)) + ' line(s)';
end;

procedure TdxfmStringsEditor.DoShow;
begin
  inherited DoShow;
  Memo1Change(nil);
end;

procedure TdxfmStringsEditor.Paint;
begin  
  inherited Paint;
  if WindowState <> wsMaximized then DrawSizeGrip;
end;

procedure TdxfmStringsEditor.DrawSizeGrip;
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

end.
