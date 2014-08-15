{*******************************************************************}
{                                                                   }
{       ExpressScript Engine by Developer Express                   }
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
unit cxScriptDispFactory;

interface

uses
  Classes, SysUtils, cxScriptDispImpl;

type
  TcxScriptDispClassFactory = class
  private
    FClassList: TList;
  protected
    constructor CreateInstance(ADummy: Boolean = True);
    class function AccessInstance(Request: Integer): TcxScriptDispClassFactory;
  public
    constructor Create;
    destructor Destroy; override;
    class function Instance: TcxScriptDispClassFactory;
    class procedure ReleaseInstance;

    function GetDispatchClass(const AClass: TClass): TcxScriptDispImplClass;
    procedure RegisterDispatch(ADispatchClass: TcxScriptDispImplClass);
    procedure UnregisterDispatch(ADispatchClass: TcxScriptDispImplClass);
  end;

  TcxScriptDispFactory = class
  private
    FObjectList: TList;
    FComponentNotificator: TComponent;
    function GetDispatchImplementator(AObject: TObject): TcxScriptDispImpl;

    procedure RemoveComponent(AComponent: TComponent);

    constructor CreateInstance(ADummy: Boolean = True);
    class function AccessInstance(Request: Integer): TcxScriptDispFactory;
    procedure ClearObjectImplementators;
  public
    constructor Create;
    destructor Destroy; override;
    class function Instance: TcxScriptDispFactory;
    class procedure ReleaseInstance;

    function GetDispatch(AObject: TObject): TcxScriptDispImpl;
  end;

function ScriptDispFactory: TcxScriptDispFactory;
function ScriptDispClassFactory: TcxScriptDispClassFactory;

implementation

uses
  Windows, cxScriptDBImpl;

type
TComponentNotificator = class(TComponent)
protected
  procedure Notification(AComponent: TComponent; Operation: TOperation); override;
end;

procedure TComponentNotificator.Notification(AComponent: TComponent; Operation: TOperation);
begin
  if Operation = opRemove then
    ScriptDispFactory.RemoveComponent(AComponent);
  AComponent.RemoveFreeNotification(self);
end;

function ScriptDispFactory: TcxScriptDispFactory;
begin
  Result := TcxScriptDispFactory.Instance;
end;

function ScriptDispClassFactory: TcxScriptDispClassFactory;
begin
  Result := TcxScriptDispClassFactory.Instance;
end;

{ TcxScriptDispClassFactory }
constructor TcxScriptDispClassFactory.Create;
begin
  inherited Create;
  raise Exception.CreateFmt('Access class %s through Instance only', [ClassName]);
end;

destructor TcxScriptDispClassFactory.Destroy;
begin
  FClassList.Free;
  inherited Destroy;
end;

constructor TcxScriptDispClassFactory.CreateInstance(ADummy: Boolean = True);
begin
  FClassList := TList.Create;
end;

var
  FScriptDispClassFactoryInstance: TcxScriptDispClassFactory = nil;

class function TcxScriptDispClassFactory.AccessInstance(Request: Integer): TcxScriptDispClassFactory;
begin
  case Request of
    0 : ;
    1 : if not Assigned(FScriptDispClassFactoryInstance) then FScriptDispClassFactoryInstance := CreateInstance;
    2 : FScriptDispClassFactoryInstance := nil;
  else
    raise Exception.CreateFmt('Illegal request %d in AccessInstance',
      [Request]);
  end;
  Result := FScriptDispClassFactoryInstance;
end;

class function TcxScriptDispClassFactory.Instance: TcxScriptDispClassFactory;
begin
  Result := AccessInstance(1);
end;

class procedure TcxScriptDispClassFactory.ReleaseInstance;
begin
  AccessInstance(0).Free;
end;

procedure TcxScriptDispClassFactory.RegisterDispatch(
        ADispatchClass: TcxScriptDispImplClass);
begin
  if FClassList.IndexOf(ADispatchClass) < 0 then
    FClassList.Add(ADispatchClass);
end;

procedure TcxScriptDispClassFactory.UnregisterDispatch(
        ADispatchClass: TcxScriptDispImplClass);
begin
  FClassList.Remove(ADispatchClass);
end;

function TcxScriptDispClassFactory.GetDispatchClass(
        const AClass: TClass): TcxScriptDispImplClass;
var
  I: Integer;
  ACurrent: TcxScriptDispImplClass;
begin
  Result := nil;
  if AClass = nil then exit;

  for I := 0 to FClassList.Count - 1 do
  begin
    ACurrent := TcxScriptDispImplClass(FClassList[I]);

    if AClass.InheritsFrom(ACurrent.GetObjectClass) then
      if (Result = nil) or
        not Result.GetObjectClass.InheritsFrom(ACurrent.GetObjectClass) then
        Result := ACurrent;

    if (Result <> nil) and (Result.GetObjectClass = AClass) then
      break;
  end;
end;

{ TcxScriptDispFactory }

constructor TcxScriptDispFactory.Create;
begin
  inherited Create;
  raise Exception.CreateFmt('Access class %s through Instance only', [ClassName]);
end;

destructor TcxScriptDispFactory.Destroy;
begin
  FComponentNotificator.Free;
  ClearObjectImplementators;
  FObjectList.Free;
  inherited Destroy;
end;

constructor TcxScriptDispFactory.CreateInstance(ADummy: Boolean = True);
begin
  FObjectList := TList.Create;
  FComponentNotificator := TComponentNotificator.Create(nil);
end;

type
  PcxMultiThreadListItem = ^TcxMultiThreadListItem;
  TcxMultiThreadListItem = record
    ThreadID: Cardinal;
    Obj: TcxScriptDispFactory;
  end;

  TcxMultiThreadList = class
  private
    FList: TThreadList;
    procedure Clear;
  public
    constructor Create;
    destructor Destroy; override;
    function GetScriptDispFactory: TcxScriptDispFactory;
    procedure DeleteScriptDispFactory;
  end;

{ TcxMultiThreadList }

constructor TcxMultiThreadList.Create;
begin
  inherited Create;
  FList := TThreadList.Create;
end;

destructor TcxMultiThreadList.Destroy;
begin
  Clear;
  FList.Free;
  inherited Destroy;
end;

function TcxMultiThreadList.GetScriptDispFactory: TcxScriptDispFactory;
var
  AListItem: PcxMultiThreadListItem;
  I: Integer;
begin
  Result := nil;
  with FList.LockList do
  try
    for I := 0 to Count - 1 do
    begin
      AListItem := PcxMultiThreadListItem(List[I]);
      if (AListItem^.ThreadID = GetCurrentThreadId) then
      begin
        Result := AListItem.Obj;
          break;
      end;
    end;
    if Result = nil then
    begin
       Result := TcxScriptDispFactory.CreateInstance;
       New(AListItem);
       AListItem^.ThreadID := GetCurrentThreadId;
       AListItem^.Obj := Result;
       FList.Add(AListItem);
    end;
  finally
    FList.UnlockList;
  end;
end;

procedure TcxMultiThreadList.DeleteScriptDispFactory;
var
  AListItem: PcxMultiThreadListItem;
  I: Integer;
begin
  with FList.LockList do
  try
    for I := 0 to Count - 1 do
    begin
      AListItem := PcxMultiThreadListItem(List[I]);
      if (AListItem^.ThreadID = GetCurrentThreadId) then
      begin
        AListItem.Obj.Free;
        FList.Remove(AListItem);
        Dispose(AListItem);
        break;
      end;
    end;
  finally
    FList.UnlockList;
  end;
end;

procedure TcxMultiThreadList.Clear;
var
  I: Integer;
begin
  try
    with FList.LockList do
    begin
      for I := 0 to Count - 1 do
      begin
        PcxMultiThreadListItem(List[I]).Obj.Free;
        Dispose(List[I])
      end;
      Clear;
    end;  
  finally
    FList.UnlockList;
  end;
end;

var
  FMultiThreadListInstance: TcxMultiThreadList;

class function TcxScriptDispFactory.AccessInstance(Request: Integer): TcxScriptDispFactory;
begin
  case Request of
    0 : ;
    1 : ;
    2 : ;
  else
    raise Exception.CreateFmt('Illegal request %d in AccessInstance',
      [Request]);
  end;
  if FMultiThreadListInstance <> nil then
    Result := FMultiThreadListInstance.GetScriptDispFactory
  else
    Result := nil;
end;

class function TcxScriptDispFactory.Instance: TcxScriptDispFactory;
begin
  Result := AccessInstance(1);
end;

class procedure TcxScriptDispFactory.ReleaseInstance;
begin
  FMultiThreadListInstance.DeleteScriptDispFactory;
end;

function TcxScriptDispFactory.GetDispatch(AObject: TObject): TcxScriptDispImpl;
var
  ADispatchObjectClass: TcxScriptDispImplClass;
begin
  if AObject <> nil then
  begin
    if AObject is TcxScriptDispImpl then
    begin
      Result := TcxScriptDispImpl(AObject);
      if FObjectList.IndexOf(Result) < 0 then
        FObjectList.Add(Result);
      if Result.Component <> nil then
        Result.Component.FreeNotification(FComponentNotificator);
    end
    else
    begin
      Result := GetDispatchImplementator(AObject);
      if Result = nil then
      begin
        ADispatchObjectClass := ScriptDispClassFactory.GetDispatchClass(AObject.ClassType);
        if ADispatchObjectClass <> nil then
        begin
          Result := ADispatchObjectClass.Create(AObject);
          FObjectList.Add(Result);
          if Result.Component <> nil then
            Result.Component.FreeNotification(FComponentNotificator);
        end;
      end;
    end;
  end
  else
    Result := nil;  
end;

function TcxScriptDispFactory.GetDispatchImplementator(AObject: TObject): TcxScriptDispImpl;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to FObjectList.Count - 1 do
    if(TcxScriptDispImpl(FObjectList[I]).Owner = AObject) then
    begin
      Result := TcxScriptDispImpl(FObjectList[I]);
      break;
    end;
end;

procedure TcxScriptDispFactory.ClearObjectImplementators;
var
  I: integer;
begin
  for I := 0 to FObjectList.Count - 1 do
    TcxScriptDispImpl(FObjectList[I]).Free;
  FObjectList.Clear;
end;

procedure TcxScriptDispFactory.RemoveComponent(AComponent: TComponent);
var
  I: Integer;
begin
  I := 0;
  while I < FObjectList.Count do
  begin
    if(TcxScriptDispImpl(FObjectList[I]).Component = AComponent) then
    begin
      TcxScriptDispImpl(FObjectList[I]).Free;
      FObjectList.Delete(I);
    end else Inc(I);
  end;
end;

initialization
  FMultiThreadListInstance := TcxMultiThreadList.Create;
  
finalization
   TcxScriptDispClassFactory.ReleaseInstance;
   FreeAndNil(FMultiThreadListInstance);
end.
