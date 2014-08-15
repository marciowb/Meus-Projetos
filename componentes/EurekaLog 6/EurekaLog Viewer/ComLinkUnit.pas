unit ComLinkUnit;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  ComObj, ActiveX, EurekaLog_Viewer_TLB, StdVcl, SingletonComObj;

type
  TLink = class(TSingletonAutoObject, ILink)
  protected
    procedure AddFiles(Files: OleVariant); safecall;
  end;

procedure StartComServer;

implementation

uses ComServ, EViewer, Variants, SysUtils;

procedure TLink.AddFiles(Files: OleVariant);
var
  n: Integer;
begin
  if ((not VarIsArray(Files)) or (VarArrayDimCount(Files) <> 1)) then
    raise Exception.Create('You must use a valid and not empty Variant Array of WideStrings.');

  for n := VarArrayLowBound(Files, 1) to VarArrayHighBound(Files, 1) do
    if (VarType(Files[n]) <> varOleStr) then
      raise Exception.CreateFmt('Index: %d is not a WideString.', [n]);

  for n := VarArrayLowBound(Files, 1) to VarArrayHighBound(Files, 1) do
    ELViewerMainForm.ImportLog(Files[n]);
end;

//------------------------------------------------------------------------------

procedure StartComServer;
begin
  TSingletonFactory.Create(ComServer, TLink, Class_Link, ciMultiInstance, tmApartment);
end;

end.
