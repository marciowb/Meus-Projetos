{***************************************************************************}
{ Scripter Studio Pro Components for Delphi & C++Builder                    }
{ version 1.6.0.1                                                           }
{                                                                           }
{ written by TMS Software                                                   }
{            copyright © 1997 - 2010                                        }
{            Email : info@tmssoftware.com                                   }
{            Web : http://www.tmssoftware.com                               }
{                                                                           }
{ For information about version history, check the section "What's New"     }
{ at Scripter Studio manual.                                                }                                                                         
{                                                                           }
{ The source code is given as is. The author is not responsible             }
{ for any possible damage done due to the use of this code.                 }
{ The component can be freely used in any application. The complete         }
{ source code remains property of the author and may not be distributed,    }
{ published, given or sold in any form as such. No parts of the source      }
{ code can be included in any other component or application without        }
{ written authorization of the author.                                      }
{***************************************************************************}

unit PictureInspEditor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, ExtDlgs, StdCtrls, PropertyInspEditors;

type
  TfrmPicture = class(TForm)
    btnOK: TButton;
    btnCancel: TButton;
    opdImage: TOpenPictureDialog;
    svdImage: TSavePictureDialog;
    pnlImage: TPanel;
    btnLoad: TButton;
    btnSave: TButton;
    btnClear: TButton;
    pntImage: TPaintBox;
    procedure btnLoadClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure pntImagePaint(Sender: TObject);
  private
    { Private declarations }
    FPicture: TPicture;
  public
    { Public declarations }
    property Picture: TPicture read FPicture;
  end;

  TPicturePropertyEditor = class(TPropertyEditor)
    function Execute: Boolean; override;
  end;

implementation

{$R *.DFM}

function TPicturePropertyEditor.Execute: Boolean;
begin
  with TfrmPicture.Create(nil) do
  try
    with Prop do
      if PropType=TypeInfo(TPicture) then FPicture.Assign(TPicture(Prop.AsObject))
      else
        if PropType=TypeInfo(TBitmap) then
        begin
          FPicture.Bitmap:=TBitmap(Prop.AsObject);
          opdImage.Filter:='Bitmaps (*.bmp)|*.bmp';
          svdImage.Filter:=opdImage.Filter;
        end
        else
          if PropType=TypeInfo(TIcon) then
          begin
            FPicture.Icon:=TIcon(Prop.AsObject);
            opdImage.Filter:='Icon files (*.ico)|*.ico';
            svdImage.Filter:=opdImage.Filter;
          end
          else FPicture.Graphic:=TGraphic(Prop.AsObject);
    Result:=ShowModal=mrOk;
    if Result then
      with Prop do
        if PropType=TypeInfo(TPicture) then TPicture(Prop.AsObject).Assign(FPicture)
        else
          Prop.AsObject:=FPicture.Graphic;
  finally
    Free;
  end;
end;

procedure TfrmPicture.btnLoadClick(Sender: TObject);
begin
  with opdImage do
    if Execute then
    begin
      FPicture.LoadFromFile(FileName);
      pntImage.Repaint;
    end;
end;

procedure TfrmPicture.btnSaveClick(Sender: TObject);
begin
  with FPicture,svdImage do
    if not Graphic.Empty and Execute then SaveToFile(FileName);
end;

procedure TfrmPicture.btnClearClick(Sender: TObject);
begin
  FPicture.Graphic:=nil;
  pntImage.Repaint;
end;

procedure TfrmPicture.FormCreate(Sender: TObject);
begin
  FPicture:=TPicture.Create;
end;

procedure TfrmPicture.FormDestroy(Sender: TObject);
begin
  FPicture.Free;
end;

procedure TfrmPicture.pntImagePaint(Sender: TObject);
var
  R: TRect;
begin
  if Assigned(FPicture.Graphic) and not FPicture.Graphic.Empty then
  begin
    with FPicture do R:=Rect(0,0,Width,Height);
    with pntImage,R do
    begin
      if (Right>ClientWidth) or (Bottom>ClientHeight) then
        if Right>Bottom then
        begin
          Right:=ClientWidth;
          Bottom:=Right*FPicture.Height div FPicture.Width;
        end
        else
        begin
          Bottom:=ClientHeight;
          Right:=Bottom*FPicture.Width div FPicture.Height;
        end;
      OffsetRect(R,(ClientWidth-Right) div 2,(ClientHeight-Bottom) div 2);
      Canvas.StretchDraw(R,FPicture.Graphic);
    end;
  end;
end;

end.
