{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2006                    BBBBB   }
  
unit ppMulticast;

interface

uses
  Classes,
  Contnrs,

  ppComm,
  ppTypes;

type

  TppNotifyEvent = procedure (Sender: TObject; aParameters: TObject) of object;

  {TppMethodPointer

    Simple wrapper for a Delphi TMethod}
    
  TppMethodPointer = class
  private
    FInstance: TObject;
    FCode: Pointer;

    function GetTMethod: TMethod;

  public
    constructor Create(aMethod: TMethod); virtual;

    property Instance: TObject read FInstance;
    property Code: Pointer read FCode;

    property TMethod: TMethod read GetTMethod;

  end;

 {TppMethodPointerList

    TppMethodPointerList manages a list of method pointers}
    
  TppMethodPointerList = class(TppCommunicator)
    private
      FInnerList: TObjectList;

      function GetCount: Integer;
      function GetMethodForIndex(aIndex: Integer): TMethod;
    protected

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      procedure Notification(AComponent: TComponent; Operation: TOperation); override;
      procedure Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType); override;

      procedure Add(aMethod: TMethod);
      procedure Prepend(aMethod: TMethod);
      procedure Remove(aMethod: TMethod); overload;
      procedure Remove(aObject: TObject); overload;

      property Items[Index: Integer]: TMethod read GetMethodForIndex; default;
      property Count: Integer read GetCount;

  end;


  {TppMulticastEvent
    Represents a multi-cast event}
  TppMulticastEvent = class
    private
      FMethodPointers: TppMethodPointerList;

      function GetEmpty: Boolean;
      function GetNotifyEvent(Index: Integer): TppNotifyEvent;

    protected
      property MethodPointers: TppMethodPointerList read FMethodPointers;

    public
      constructor Create; virtual;
      destructor Destroy; override;

      procedure AddNotify(aNotifyEvent: TppNotifyEvent); overload; virtual;
      procedure RemoveNotify(aNotifyEvent: TppNotifyEvent); overload; virtual;
      procedure RemoveNotify(aListener: TObject); overload; virtual;

      procedure Notify(Sender: TObject; aParameters: TObject); overload; virtual;
      procedure PrependNotify(aNotifyEvent: TppNotifyEvent); virtual;
      property Empty: Boolean read GetEmpty;

  end;



implementation

{******************************************************************************
 *
 ** M e t h o d   P o i n t e r
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppMethodPointer.Create }

constructor TppMethodPointer.Create(aMethod: TMethod);
begin

  inherited Create;

  FInstance := aMethod.Data;
  FCode := aMethod.Code;

end;

{------------------------------------------------------------------------------}
{ TppMethodPointer.GetTMethod }

function TppMethodPointer.GetTMethod: TMethod;
begin
  Result.Data := FInstance;
  Result.Code := FCode;
end;


{******************************************************************************
 *
 ** Method Pointer  List
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppMethodPointerList.Create }

constructor TppMethodPointerList.Create(aOwner: TComponent);
begin
  inherited;

  FInnerList := TObjectList.Create;
  FInnerList.OwnsObjects := True;

end;

{------------------------------------------------------------------------------}
{ TppMethodPointerList.Destroy }

destructor TppMethodPointerList.Destroy;
begin

  FInnerList.Free;
  FInnerList := nil;

  inherited;

end;

{------------------------------------------------------------------------------}
{ TppMethodPointerList.Notification }

procedure TppMethodPointerList.Notification(aComponent: TComponent; Operation: TOperation);
begin
  inherited;

  if (Operation = opRemove) then
    Remove(aComponent);

end;

{------------------------------------------------------------------------------}
{ TppMethodPointerList.Notify }

procedure TppMethodPointerList.Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType);
begin
  inherited;

  if (aOperation = ppopRemove) then
    Remove(aCommunicator);

end;

{------------------------------------------------------------------------------}
{ TppMethodPointerList.GetCount }

function TppMethodPointerList.GetCount: Integer;
begin
  Result := FInnerList.Count;
end;


{------------------------------------------------------------------------------}
{ TppMethodPointerList.GetMethodForIndex }

function TppMethodPointerList.GetMethodForIndex(aIndex: Integer): TMethod;
begin
  Result := TppMethodPointer(FInnerList[aIndex]).TMethod;

end;

{------------------------------------------------------------------------------}
{ TppMethodPointerList.Add }

procedure TppMethodPointerList.Add(aMethod: TMethod);
var
  lMethodPointer: TppMethodPointer;
  lObject: TObject;
begin

  lMethodPointer := TppMethodPointer.Create(aMethod);

  FInnerList.Add(lMethodPointer);

  lObject := lMethodPointer.Instance;

  if (lObject is TppCommunicator)  then
    TppCommunicator(lObject).AddNotify(Self)
  else if (lObject is TComponent)  then
    TComponent(lObject).FreeNotification(Self);

end;

{------------------------------------------------------------------------------}
{ TppMethodPointerList.Prepend }

procedure TppMethodPointerList.Prepend(aMethod: TMethod);
var
  lMethodPointer: TppMethodPointer;
  lObject: TObject;
begin

  lMethodPointer := TppMethodPointer.Create(aMethod);

  FInnerList.Insert(0, lMethodPointer);

  lObject := lMethodPointer.Instance;

  if (lObject is TppCommunicator)  then
    TppCommunicator(lObject).AddNotify(Self)
  else if (lObject is TComponent)  then
    TComponent(lObject).FreeNotification(Self);

end;

{------------------------------------------------------------------------------}
{ TppMethodPointerList.Remove }

procedure TppMethodPointerList.Remove(aMethod: TMethod);
var
  lbFound: Boolean;
  liIndex: Integer;
  lMethod: TMethod;
begin

  lbFound := False;
  liIndex := 0;

  while not(lbFound) and (liIndex < FInnerList.Count) do
    begin
      lMethod := GetMethodForIndex(liIndex);

      if (aMethod.Code = lMethod.Code) and (aMethod.Data = lMethod.Data) then
        begin
          FInnerList.Delete(liIndex);
          lbFound := True;
        end;

      Inc(liIndex);

    end;

end;

{------------------------------------------------------------------------------}
{ TppMethodPointerList.Remove }

procedure TppMethodPointerList.Remove(aObject: TObject);
var
  liIndex: Integer;
begin

  liIndex := FInnerList.Count-1;

  while (liIndex >= 0) do
    begin
      if (aObject = TppMethodPointer(FInnerList[liIndex]).Instance) then
        FInnerList.Delete(liIndex);

      Dec(liIndex);

    end;

end;

{******************************************************************************
 *
 ** M u l t i   C a s t   E v e n t
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppMulticastEvent.Create }

constructor TppMulticastEvent.Create;
begin
  inherited Create;

  FMethodPointers := TppMethodPointerList.Create(nil);

end;

{------------------------------------------------------------------------------}
{ TppMulticastEvent.Destroy }

destructor TppMulticastEvent.Destroy;
begin

  FMethodPointers.Free;
  FMethodPointers := nil;

  inherited;

end;

{------------------------------------------------------------------------------}
{ TppMulticastEvent.GetNotifyEvent }

function TppMulticastEvent.GetNotifyEvent(Index: Integer): TppNotifyEvent;
begin

  Result := TppNotifyEvent(FMethodPointers[Index]);

end;

{------------------------------------------------------------------------------}
{ TppMulticastEvent.Notify }

procedure TppMulticastEvent.Notify(Sender: TObject; aParameters: TObject);
var
  liIndex: Integer;
  lNotifyEvent: TppNotifyEvent;
begin

  liIndex := 0;

  while (liIndex < FMethodPointers.Count) do
    begin
      lNotifyEvent := GetNotifyEvent(liIndex);
      lNotifyEvent(Sender, aParameters);

      Inc(liIndex);
    end;

end;

{------------------------------------------------------------------------------}
{ TppMulticastEvent.Subscribe }

procedure TppMulticastEvent.AddNotify(aNotifyEvent: TppNotifyEvent);
var
  lMethod: TMethod;
begin
  lMethod := TMethod(aNotifyEvent);

  FMethodPointers.Add(lMethod);

end;

{------------------------------------------------------------------------------}
{ TppMulticastEvent.GetEmpty }

function TppMulticastEvent.GetEmpty: Boolean;
begin
  Result := (FMethodPointers = nil) or (FMethodPointers.Count = 0);
end;

{------------------------------------------------------------------------------}
{ TppMulticastEvent.PrependNotify }

procedure TppMulticastEvent.PrependNotify(aNotifyEvent: TppNotifyEvent);
var
  lMethod: TMethod;
begin
  lMethod := TMethod(aNotifyEvent);

  FMethodPointers.Prepend(lMethod);
end;

{------------------------------------------------------------------------------}
{ TppMulticastEvent.RemoveNotify }

procedure TppMulticastEvent.RemoveNotify(aNotifyEvent: TppNotifyEvent);
var
  lMethod: TMethod;
begin

  lMethod := TMethod(aNotifyEvent);
  FMethodPointers.Remove(lMethod);

end;

{------------------------------------------------------------------------------}
{ TppMulticastEvent.RemoveNotify }

procedure TppMulticastEvent.RemoveNotify(aListener: TObject);
begin
  FMethodPointers.Remove(aListener);

end;



end.
