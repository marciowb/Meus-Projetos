unit ppPDFRendererManager;

interface

uses
  Classes,
  ppDevice,
  ppPDFRenderer;


type

  {@TppRendererManager

    When a report is printed to the PDF device, TppPDFRenderer descendants
    are used to convert the draw command to PDF instructions. It is the purpose
    of this class to cache and mangage these objects during the device output
    process. This class also has class functions that support the registration
    of draw command renderers.

    Each TppPDFRenderer descendant has a class function called
    GetDrawCommandClass which returns the draw command class the renderer is
    designed to handle. When the renderer manager is asked for a renderer, it
    creates one for the right draw command class. If one does not exist for
    the specific draw command class, it traces up the inheritance chain to find
    one for an ancestor if one is available. Once they are created, these
    renderer objects are stored in a pool so they can be reused.

    By default TppPDFRendererGeneric is registered for TppDrawCommand, this
    class will be used if no other renderer is available. }

  TppPDFRendererManager = class
  private
    FRenderers: TList;

    function GetRendererClass(aDrawCommandClass: TppDrawCommandClass): TppPDFRendererClass;
    function GetRendererInstance(aRendererClass: TppPDFRendererClass): TppPDFRenderer;

  public
    constructor Create;
    destructor Destroy; override;
    function GetRendererForDrawCommand(aDrawCommand: TppDrawCommand): TppPDFRenderer;
    
    class procedure RegisterRenderer(aPDFRendererClass: TppPDFRendererClass);
    class procedure UnregisterRenderer(aPDFRendererClass: TppPDFRendererClass);

  end;

implementation

uses
  SyncObjs;

var
  uLock: TCriticalSection;
  uRendererClasses: TList;

constructor TppPDFRendererManager.Create;
begin
  inherited;

  FRenderers := TList.Create;
  
end;

destructor TppPDFRendererManager.Destroy;
var
  liIndex: Integer;
begin

  for liIndex := FRenderers.Count - 1 downto 0 do
    TObject(FRenderers[liIndex]).Free;

  FRenderers.Free;
  FRenderers := nil;
  
  inherited;
end;

{ TppPDFRendererManager.GetRendererClass }

function TppPDFRendererManager.GetRendererClass(aDrawCommandClass: TppDrawCommandClass): TppPDFRendererClass;
var
  liIndex: Integer;
  lDrawCommandClass: TppDrawCommandClass;
  lRendererClass: TppPDFRendererClass;
begin

  Result := nil;

  liIndex := 0;

  while (Result = nil) and (liIndex < uRendererClasses.Count) do
    begin

      lRendererClass := TppPDFRendererClass(uRendererClasses.Items[liIndex]);

      lDrawCommandClass := lRendererClass.DrawCommandClass;

      if (aDrawCommandClass = lDrawCommandClass) then
        Result := lRendererClass;

      Inc(liIndex);

    end;

  {if no renderer found, then recurse using the parent drawcommand class}
  if ((Result = nil) and (aDrawCommandClass <> TppDrawCommand)) then
    Result := GetRendererClass(TppDrawCommandClass(aDrawCommandClass.ClassParent));

end;

{@TppPDFRendererManager.GetRendererForDrawCommand

  This a the main entry point for the functionality provided by the renderer
  manager. When the device wants to process a draw command, it uses the
  renderer manager to get an instantiated TppPDFRenderer descendant that can
  be used for processing. This function will return nil if no renderer is
  available for the draw command. }

function TppPDFRendererManager.GetRendererForDrawCommand(aDrawCommand: TppDrawCommand): TppPDFRenderer;
var
  lRendererClass: TppPDFRendererClass;
begin

  Result := nil;

  lRendererClass := GetRendererClass(TppDrawCommandClass(aDrawCommand.ClassType));
  if (lRendererClass <> nil) then
    Result := GetRendererInstance(lRendererClass);

end;

{@TppPDFRendererManager.GetRendererInstance }

function TppPDFRendererManager.GetRendererInstance(aRendererClass: TppPDFRendererClass): TppPDFRenderer;
var
  liIndex: Integer;
begin

  Result := nil;

  liIndex := 0;

  while (Result = nil) and (liIndex < FRenderers.Count) do
    begin

      if (TppPDFRenderer(FRenderers.Items[liIndex]).ClassType = aRendererClass) then
        Result := TppPDFRenderer(FRenderers.Items[liIndex]);

      Inc(liIndex);

    end;

  if (Result = nil) then
    begin

      Result := aRendererClass.Create;
      FRenderers.Add(Result);

    end;

end;

{@TppPDFRendererManager.RegisterRenderer

  Used to register a custom TppPDFRenderer descendant. The class type is added
  to a list. If a renderer already exists for the associated draw command, then
  it is deleted. }

class procedure TppPDFRendererManager.RegisterRenderer(aPDFRendererClass: TppPDFRendererClass);
var
  liIndex: Integer;
  lRendererClass: TppPDFRendererClass;
begin

  uLock.Acquire;

  try

    for liIndex := 0 to uRendererClasses.Count - 1 do
      begin

        lRendererClass := TppPDFRendererClass(uRendererClasses.Items[liIndex]);

        if (lRendererClass.DrawCommandClass = aPDFRendererClass.DrawCommandClass) then
          uRendererClasses.Delete(liIndex);

      end;

    uRendererClasses.Add(aPDFRendererClass);

  finally
    uLock.Release;
  end;

end;

{@TppPDFRendererManager.UnregisterRenderer

  Used to remove a renderer class from the list of renderers. }

class procedure TppPDFRendererManager.UnregisterRenderer(aPDFRendererClass: TppPDFRendererClass);
var
  liIndex: Integer;
begin

  uLock.Acquire;

  try

    liIndex := uRendererClasses.IndexOf(aPDFRendererClass);

    if (liIndex > -1) then
      uRendererClasses.Delete(liIndex);

  finally
    uLock.Release;
  end;

end;


initialization

  uLock := TCriticalSection.Create;
  uRendererClasses := TList.Create;

finalization

  uRendererClasses.Free;
  uLock.Free;


end.
