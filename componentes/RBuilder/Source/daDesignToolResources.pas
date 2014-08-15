unit daDesignToolResources;

interface

uses
  ppToolResources;

type

  TdaDesignToolResources = class
    public
      class function ToolImageList:  TppToolImageList;

    end;


implementation

var
  uToolImageList: TppToolImageList;

{------------------------------------------------------------------------------}
{ ToolImageList}

class function TdaDesignToolResources.ToolImageList: TppToolImageList;
begin

  if (uToolImageList = nil) then
    begin
      uToolImageList := TppToolImageList.Create(nil);
    end;

  Result := uToolImageList;

end; {function, ToolImageList}


initialization
  uToolImageList := nil;

finalization
  uToolImageList.Free;
  uToolImageList := nil;


end.
