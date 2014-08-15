{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit ppInterfacedObject;

interface

uses
  Classes;
  
type

  {@TppInterfacedObject

    Interfaced object that disables reference counting.

   In other words, when an interface is retrieved from an object, that object
   is not freed just because the interface goes out of scope.}

  TppInterfacedObject = class(TObject, IUnknown)
    protected
      function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
      function _AddRef: Integer; stdcall;
      function _Release: Integer; stdcall;
  end;

implementation


{ QueryInterface

  Called each time an interface is requested. }

function TppInterfacedObject.QueryInterface(const IID: TGUID; out Obj): HResult;
const
  E_NOINTERFACE = HResult($80004002);
begin

  if GetInterface(IID, Obj) then
    Result := 0
  else
    Result := E_NOINTERFACE;
    
end;


{  _AddRef

  Called each time an interface reference is created. }

function TppInterfacedObject._AddRef: Integer;
begin
  Result := -1;
end;


{  _Release

  Called each time an interface variable is set to nil or goes out of scope. }

function TppInterfacedObject._Release: Integer;
begin
  Result := -1;
end;


end.
