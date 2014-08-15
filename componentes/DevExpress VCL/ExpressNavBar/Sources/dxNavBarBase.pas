{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressNavBar                                               }
{                                                                   }
{       Copyright (c) 2002-2010 Developer Express Inc.              }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSNAVBAR AND ALL ACCOMPANYING   }
{   VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY.             }
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

unit dxNavBarBase;

{$I cxVer.inc}

interface

uses
  Classes, cxClasses;

type
  TdxNavBarChangeType = (doRecreate, doRecalc, doRedraw);
  TdxNavBarChangeEvent = procedure(Sender: TObject; AType: TdxNavBarChangeType) of object;

  TdxNavBarComponentCollection = class;
  TdxNavBarComponentCollectionItem = class(TcxComponentCollectionItem)
  private
    function InternalGetCollection: TdxNavBarComponentCollection;
    procedure InternalSetCollection(Value: TdxNavBarComponentCollection);
  protected
    procedure InitiateActions; virtual;
    procedure SetIndex(Value: Integer); override;
  public
    property Collection: TdxNavBarComponentCollection read InternalGetCollection
      write InternalSetCollection;
  end;
  TdxNavBarComponentCollectionItemClass = class of TdxNavBarComponentCollectionItem;

  TdxNavBarComponentCollection = class(TcxComponentCollection)
  private
    function InternalGetOwner: TComponent;
  protected
    procedure InitiateActions; virtual;
  public
    function Add: TdxNavBarComponentCollectionItem;
    function ItemByName(const AName: string): TdxNavBarComponentCollectionItem;
    property Owner: TComponent read InternalGetOwner;
  end;

implementation

{ TdxComponentCollectionItem }

procedure TdxNavBarComponentCollectionItem.InitiateActions;
begin
end;

procedure TdxNavBarComponentCollectionItem.SetIndex(Value: Integer);
begin
  if Collection = nil then
    Exit;
  if Value < 0 then
    Value := 0;
  if Value > Collection.Count - 1
    then Value := Collection.Count - 1;
  inherited SetIndex(Value);
end;

function TdxNavBarComponentCollectionItem.InternalGetCollection: TdxNavBarComponentCollection;
begin
  Result := TdxNavBarComponentCollection(inherited Collection);
end;

procedure TdxNavBarComponentCollectionItem.InternalSetCollection(Value: TdxNavBarComponentCollection);
begin
  inherited Collection := Value;
end;

{ TdxComponentCollection }

function TdxNavBarComponentCollection.Add: TdxNavBarComponentCollectionItem;
begin
  Result := TdxNavBarComponentCollectionItem(inherited Add);
end;

function TdxNavBarComponentCollection.ItemByName(const AName: string): TdxNavBarComponentCollectionItem;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to Count - 1 do
    if Items[I].Name = AName then
    begin
      Result := TdxNavBarComponentCollectionItem(Items[I]);
      Break;
    end;
end;

procedure TdxNavBarComponentCollection.InitiateActions;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    TdxNavBarComponentCollectionItem(Items[I]).InitiateActions;
end;

function TdxNavBarComponentCollection.InternalGetOwner: TComponent;
begin
  Result := ParentComponent;
end;

end.
