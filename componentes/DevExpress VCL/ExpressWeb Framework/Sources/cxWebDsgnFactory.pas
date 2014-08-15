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
unit cxWebDsgnFactory;

interface

{$I cxVer.inc}

uses Classes, SysUtils,
  cxWebDsgnIntf, cxWebUtils;

type
  TcxWebDesignerFactory = class
  private
    FList: TList;
    FDefaultDesigner: TcxAbstractWebDesignerClass;

    function GetCount: Integer;
    function GetWebDesigner(Index: Integer): TcxAbstractWebDesignerClass;
    function GetDefaultDesigner: TcxAbstractWebDesignerClass;
    procedure SetDefaultDesigner(Value: TcxAbstractWebDesignerClass);
  protected
    constructor CreateInstance(ADummy: Boolean = True);
    class function AccessInstance(Request: Integer): TcxWebDesignerFactory;
  public
    constructor Create;
    destructor Destroy; override;
    class function Instance: TcxWebDesignerFactory;
    class procedure ReleaseInstance;

    procedure RegisterDesigner(ADesigner: TcxAbstractWebDesignerClass; DefaultDesigner: Boolean);
    procedure UnregisterDesigner(ADesigner: TcxAbstractWebDesignerClass);
    function GetDesignerByID(AId: Integer): TcxAbstractWebDesignerClass;
    function GetDesignerByName(AName: String): TcxAbstractWebDesignerClass;

    property Count: Integer read GetCount;
    property DefaultDesigner: TcxAbstractWebDesignerClass read GetDefaultDesigner write SetDefaultDesigner;
    property WebDesigners[Index: Integer]: TcxAbstractWebDesignerClass  read GetWebDesigner; default;
  end;

function WebDesignerFactory: TcxWebDesignerFactory;

implementation

function WebDesignerFactory: TcxWebDesignerFactory;
begin
  Result := TcxWebDesignerFactory.Instance;
end;

{ TcxWebDesignerFactory }
constructor TcxWebDesignerFactory.Create;
begin
  inherited Create;
  raise Exception.CreateFmt('Access class %s through Instance only', [ClassName]);
end;

destructor TcxWebDesignerFactory.Destroy;
begin
  FList.Free;
  inherited Destroy;
end;

constructor TcxWebDesignerFactory.CreateInstance(ADummy: Boolean = True);
begin
  FList := TList.Create;
end;

var
  FInstance: TcxWebDesignerFactory = nil;

class function TcxWebDesignerFactory.AccessInstance(Request: Integer): TcxWebDesignerFactory;
begin
  case Request of
    0 : ;
    1 : if not Assigned(FInstance) then FInstance := CreateInstance;
    2 : FInstance := nil;
  else
    raise Exception.CreateFmt('Illegal request %d in AccessInstance',
      [Request]);
  end;
  Result := FInstance;
end;

class function TcxWebDesignerFactory.Instance: TcxWebDesignerFactory;
begin
  Result := AccessInstance(1);
end;

class procedure TcxWebDesignerFactory.ReleaseInstance;
begin
  AccessInstance(0).Free;
end;

function TcxWebDesignerFactory.GetCount: Integer;
begin
  Result := FList.Count;
end;

function TcxWebDesignerFactory.GetWebDesigner(Index: Integer): TcxAbstractWebDesignerClass;
begin
  Result := TcxAbstractWebDesignerClass(FList[Index]);
end;

function TcxWebDesignerFactory.GetDefaultDesigner: TcxAbstractWebDesignerClass;
begin
  Result := nil;
  if FDefaultDesigner <> nil then
    Result := FDefaultDesigner
  else
    if Count > 0 then
      Result := WebDesigners[0];
end;

procedure TcxWebDesignerFactory.SetDefaultDesigner(Value: TcxAbstractWebDesignerClass);
begin
  FDefaultDesigner := Value;
end;

procedure TcxWebDesignerFactory.RegisterDesigner(ADesigner: TcxAbstractWebDesignerClass; DefaultDesigner: Boolean);
begin
  FList.Add(ADesigner);
  if DefaultDesigner then
    FDefaultDesigner := ADesigner;
end;

procedure TcxWebDesignerFactory.UnregisterDesigner(ADesigner: TcxAbstractWebDesignerClass);
begin
  if FDefaultDesigner = ADesigner then
    FDefaultDesigner := nil;
  FList.Remove(ADesigner);
end;

function TcxWebDesignerFactory.GetDesignerByID(AId: Integer): TcxAbstractWebDesignerClass;
var
  i: Integer;
begin
  Result := DefaultDesigner;
  for i := 0 to Count - 1 do
    if WebDesigners[i].GetID = AID then
    begin
      Result := WebDesigners[i];
      break;
    end;
end;

function TcxWebDesignerFactory.GetDesignerByName(AName: String): TcxAbstractWebDesignerClass;
var
  i: Integer;
begin
  Result := DefaultDesigner;
  for i := 0 to Count - 1 do
    if (CompareText(WebDesigners[i].GetName, AName) = 0) then
    begin
      Result := WebDesigners[i];
      break;
    end;
end;


initialization

finalization
  TcxWebDesignerFactory.ReleaseInstance;
  
end.
