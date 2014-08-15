{*******************************************************************}
{                                                                   }
{       ExpressWeb Framework by Developer Express                   }
{       HTML Rendering Modules                                      }
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

unit cxWebUpdateControlPosition;

interface

{$I cxVer.inc}

uses
  Types, Classes,
  cxWebRender;

type
  TcxCustomWebUpdateControlPositionItem = class
  protected
    function GetBoundsRect: TRect; virtual; abstract;
    procedure SetBoundsRect(const Value: TRect); virtual; abstract;
  public
    procedure WriteHTML(HTMLTextBuilder: TcxHTMLTextBuilder); virtual;

    property BoundsRect: TRect read GetBoundsRect write SetBoundsRect;
  end;

procedure UpdateWebControlsPosition(AList: TList);

implementation

{ TcxCustomWebUpdateControlPositionItem }
procedure TcxCustomWebUpdateControlPositionItem.WriteHTML(HTMLTextBuilder: TcxHTMLTextBuilder);
begin
end;

procedure UpdateWebControlsPosition(AList: TList);
var
  ASortedList: TList;
  AChangedList: TList;

  function GetItem(AIndex: Integer): TcxCustomWebUpdateControlPositionItem;
  begin
    Result := TcxCustomWebUpdateControlPositionItem(AList[AIndex]);
  end;

  function IsFirstRectHasPrioritet(const ARect1, ARect2: TRect): Boolean;
  begin
    Result := ((ARect1.Top - ARect2.Top)  + (ARect1.Left - ARect2.Left)) < 0;
  end;

  procedure AddIntoSortedList(AControl: TcxCustomWebUpdateControlPositionItem);
  var
    I: Integer;
    AIsInserted: Boolean;
    AControlRect: TRect;
  begin
    AIsInserted := False;
    AControlRect := AControl.BoundsRect;
    for I := 0 to ASortedList.Count - 1 do
      if IsFirstRectHasPrioritet(AControlRect,
        TcxCustomWebUpdateControlPositionItem(ASortedList[I]).BoundsRect) then
      begin
        ASortedList.Insert(I, AControl);
        AIsInserted := True;
        break;
      end;
    if not AIsInserted then
     ASortedList.Add(AControl);
  end;

  function GetTheBestRect(AControl: TcxCustomWebUpdateControlPositionItem;
        ALeftDif, ATopDif: Integer): TRect;

    function GetIntersectCount(ARect: TRect): Integer;
    var
      I: Integer;
      AIntersectRect: TRect;
    begin
      Result := 0;
      for I := 0 to ASortedList.Count - 1 do
        if (TcxCustomWebUpdateControlPositionItem(ASortedList[I]) <> AControl) then
        begin
          IntersectRect(AIntersectRect, TcxCustomWebUpdateControlPositionItem(ASortedList[I]).BoundsRect, ARect);
          if not IsRectEmpty(AIntersectRect) then
            Inc(Result);
        end;
    end;

  var
    ALeftIntersectCount, ATopIntersectCount: Integer;
    ARect: TRect;
  begin
    Result := AControl.BoundsRect;
    ARect := AControl.BoundsRect;
    OffSetRect(ARect, ALeftDif, 0);
    ALeftIntersectCount := GetIntersectCount(ARect);
    ARect := AControl.BoundsRect;
    OffSetRect(ARect, 0, ATopDif);
    ATopIntersectCount := GetIntersectCount(ARect);
    if ALeftIntersectCount > ATopIntersectCount then
       OffSetRect(Result, 0, ATopDif)
    else
      if ALeftIntersectCount < ATopIntersectCount then
        OffSetRect(Result, ALeftDif, 0)
      else
      begin
        if ATopDif < ALeftDif then
          OffSetRect(Result, 0, ATopDif)
        else OffSetRect(Result, ALeftDif, 0);
      end;

  end;

  procedure CheckControlPosition;
  var
    I: Integer;
    AControl: TcxCustomWebUpdateControlPositionItem;
    ANewControlRect: TRect;
    AIntersectRect: TRect;
    ATopDif, ALeftDif: Integer;
  begin
    AControl := TcxCustomWebUpdateControlPositionItem(ASortedList[0]);
    AChangedList.Clear;
    for I := 1 to ASortedList.Count - 1 do
    begin
      ANewControlRect := TcxCustomWebUpdateControlPositionItem(ASortedList[I]).BoundsRect;
      IntersectRect(AIntersectRect, AControl.BoundsRect, ANewControlRect);
      if not IsRectEmpty(AIntersectRect) then
      begin
        AChangedList.Add(ASortedList[I]);
        ATopDif := AControl.BoundsRect.Bottom - ANewControlRect.Top;
        ALeftDif := AControl.BoundsRect.Right - ANewControlRect.Left;
        ANewControlRect := GetTheBestRect(TcxCustomWebUpdateControlPositionItem(ASortedList[I]),
                        ALeftDif, ATopDif);
        TcxCustomWebUpdateControlPositionItem(ASortedList[I]).BoundsRect := ANewControlRect;
      end;
    end;

    for I := 0 to AChangedList.Count - 1 do
      ASortedList.Remove(AChangedList[I]);
    for I := 0 to AChangedList.Count - 1 do
      AddIntoSortedList(TcxCustomWebUpdateControlPositionItem(AChangedList[I]));
  end;

var
  I: Integer;
begin
  ASortedList := TList.Create;
  AChangedList := TList.Create;
  try
    for I := 0 to AList.Count - 1 do
        AddIntoSortedList(GetItem(I));
    while ASortedList.Count > 1 do
    begin
      CheckControlPosition;
      ASortedList.Delete(0);
    end;
  finally
    ASortedList.Free;
    AChangedList.Free;
  end;
end;



end.
