unit cxWebISAPIAppFix;

interface

uses
  ISAPIApp, IsapiHTTP, Isapi2;

type
  TcxWebISAPIFactory = class(TISAPIFactory)
  protected
    function NewRequest(var AECB: TEXTENSION_CONTROL_BLOCK): TISAPIRequest; override;
  end;

  TcxWebISAPIRequest = class(TISAPIRequest)
  protected
    function GetStringVariable(Index: Integer): string; override;
  end;

procedure cxISAPIFix;

implementation

uses SysUtils;

{ TcxWebISAPIFactory }

function TcxWebISAPIFactory.NewRequest(var AECB: TEXTENSION_CONTROL_BLOCK): TISAPIRequest;
begin
  Result := TcxWebISAPIRequest.Create(@AECB);
end;

procedure cxISAPIFix;
begin
  TcxWebISAPIFactory.Create;
end;

{ TcxWebISAPIRequest }

function TcxWebISAPIRequest.GetStringVariable(Index: Integer): string;
begin
  case Index of
    16: Result := IntToStr(ECB.cbTotalBytes);
    25:
    begin
      if ECB.cbAvailable > 0 then
        SetString(Result, PChar(ECB.lpbData), ECB.cbAvailable);
      while Length(Result) < Integer(ECB.cbTotalBytes) do
        Result := Result + ReadString(Integer(ECB.cbTotalBytes) - Length(Result));
    end;
  else
    Result := inherited GetStringVariable(Index);
  end;
end;

end.
