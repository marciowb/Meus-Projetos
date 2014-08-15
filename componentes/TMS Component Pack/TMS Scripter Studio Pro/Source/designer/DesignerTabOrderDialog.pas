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

unit DesignerTabOrderDialog;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons;

{$I ASCRIPT.INC}

type
  TfrmTabOrder = class(TForm)
    lblControls: TLabel;
    lsbControls: TListBox;
    bbtMoveUp: TBitBtn;
    bbtMoveDown: TBitBtn;
    btnOK: TButton;
    btnCancel: TButton;
    procedure bbtMoveUpClick(Sender: TObject);
    procedure bbtMoveDownClick(Sender: TObject);
    procedure lsbControlsDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
    procedure lsbControlsStartDrag(Sender: TObject; var DragObject: TDragObject);
    procedure lsbControlsDragDrop(Sender, Source: TObject; X, Y: Integer);
  private
    FDragIndex: Integer;
  public
  end;

implementation

{$IFDEF DELPHI6_LVL}
uses
  Types;
{$ENDIF}

{BJF} {$IFNDEF UseGreatisUnits} {$R *.DFM} {$ENDIF}

{$IFDEF VER100}
{$DEFINE OLDEXCHANGE}
{$ENDIF}
{$IFDEF VER110}
{$DEFINE OLDEXCHANGE}
{$ENDIF}
{$IFDEF VER120}
{$DEFINE OLDEXCHANGE}
{$ENDIF}
{$IFDEF VER125}
{$DEFINE OLDEXCHANGE}
{$ENDIF}

procedure TfrmTabOrder.bbtMoveUpClick(Sender: TObject);
begin
  with lsbControls,Items do
  begin
    if ItemIndex>0 then
    begin
      Exchange(ItemIndex,Pred(ItemIndex));
      {$IFDEF OLDEXCHANGE}
      ItemIndex:=Pred(ItemIndex);
      {$ENDIF}
    end;
    SetFocus;
  end;
end;

procedure TfrmTabOrder.bbtMoveDownClick(Sender: TObject);
begin
  with lsbControls,Items do
  begin
    if ItemIndex<Pred(Count) then
    begin
      Exchange(ItemIndex,Succ(ItemIndex));
      {$IFDEF OLDEXCHANGE}
      ItemIndex:=Succ(ItemIndex);
      {$ENDIF}
    end;
    SetFocus;
  end;
end;

procedure TfrmTabOrder.lsbControlsDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
var
  NDragIndex: Integer;
begin
  with lsbControls do
  begin
    NDragIndex:=ItemAtPos(Point(X,Y),True);
    Accept:=(Sender=Source) and (NDragIndex<>ItemIndex) and (NDragIndex>-1) and (NDragIndex<Items.Count);
    if FDragIndex<>NDragIndex then
    begin
      if FDragIndex<>ItemIndex then Canvas.DrawFocusRect(ItemRect(FDragIndex));
      if NDragIndex<>ItemIndex then Canvas.DrawFocusRect(ItemRect(NDragIndex));
      FDragIndex:=NDragIndex;
    end;
  end;
end;

procedure TfrmTabOrder.lsbControlsStartDrag(Sender: TObject;
  var DragObject: TDragObject);
begin
  FDragIndex:=lsbControls.ItemIndex;
end;

procedure TfrmTabOrder.lsbControlsDragDrop(Sender, Source: TObject; X,
  Y: Integer);
begin
  with lsbControls,Items do
  begin
    Move(ItemIndex,FDragIndex);
    ItemIndex:=FDragIndex;
  end;
end;

end.
