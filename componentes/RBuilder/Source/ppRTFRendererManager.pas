unit ppRTFRendererManager;

interface

uses
  Classes,
  ppDevice,
  ppRTFRenderer;


type

  {@TppRTFRendererManager

    When a report is printed to the PDF device, TppRTFRenderer descendants
    are used to convert the draw command to PDF instructions. It is the purpose
    of this class to cache and mangage these objects during the device output
    process. This class also has class functions that support the registration
    of draw command renderers.

    Each TppRTFRenderer descendant has a class function called
    GetDrawCommandClass which returns the draw command class the renderer is
    designed to handle. When the renderer manager is asked for a renderer, it
    creates one for the right draw command class. If one does not exist for
    the specific draw command class, it traces up the inheritance chain to find
    one for an ancestor if one is available. Once they are created, these
    renderer objects are stored in a pool so they can be reused.

    By default TppRTFRendererGeneric is registered for TppDrawCommand, this
    class will be used if no other renderer is available. }

  TppRTFRendererManager = class
  private
    FRenderers: TList;

    function GetRendererClass(aDrawCommandClass: TppDrawCommandClass): TppRTFRendererClass;
    function GetRendererInstance(aRendererClass: TppRTFRendererClass): TppRTFRenderer;

  public
    constructor Create;
    destructor Destroy; override;
    function GetRendererForDrawCommand(aDrawCommand: TppDrawCommand): TppRTFRenderer;
    
    class procedure RegisterRenderer(aRTFRendererClass: TppRTFRendererClass);
    class procedure UnregisterRenderer(aRTFRendererClass: TppRTFRendererClass);

  end;

implementation

uses
  SyncObjs;

var
  uLock: TCriticalSection;
  uRendererClasses: TList;

constructor TppRTFRendererManager.Create;
begin
  inherited;

  FRenderers := TList.Create;
  
end;

destructor TppRTFRendererManager.Destroy;
var
  liIndex: Integer;
begin

  for liIndex := FRenderers.Count - 1 downto 0 do
    TObject(FRenderers[liIndex]).Free;

  FRenderers.Free;
  FRenderers := nil;
  
  inherited;
end;

{ TppRTFRendererManager.GetRendererClass }

function TppRTFRendererManager.GetRendererClass(aDrawCommandClass: TppDrawCommandClass): TppRTFRendererClass;
var
  liIndex: Integer;
  lDrawCommandClass: TppDrawCommandClass;
  lRendererClass: TppRTFRendererClass;
begin

  Result := nil;

  liIndex := 0;

  while (Result = nil) and (liIndex < uRendererClasses.Count) do
    begin

      lRendererClass := TppRTFRendererClass(uRendererClasses.Items[liIndex]);

      lDrawCommandClass := lRendererClass.DrawCommandClass;

      if (aDrawCommandClass = lDrawCommandClass) then
        Result := lRendererClass;

      Inc(liIndex);

    end;

  {if no renderer found, then recurse using the parent drawcommand class}
  if ((Result = nil) and (aDrawCommandClass <> TppDrawCommand)) then
    Result := GetRendererClass(TppDrawCommandClass(aDrawCommandClass.ClassParent));

end;

{@TppRTFRendererManager.GetRendererForDrawCommand

  This a the main entry point for the functionality provided by the renderer
  manager. When the device wants to process a draw command, it uses the
  renderer manager to get an instantiated TppRTFRenderer descendant that can
  be used for processing. This function will return nil if no renderer is
  available for the draw command. }

function TppRTFRendererManager.GetRendererForDrawCommand(aDrawCommand: TppDrawCommand): TppRTFRenderer;
var
  lRendererClass: TppRTFRendererClass;
begin

  Result := nil;

  lRendererClass := GetRendererClass(TppDrawCommandClass(aDrawCommand.ClassType));
  if (lRendererClass <> nil) then
    Result := GetRendererInstance(lRendererClass);

end;

{@TppRTFRendererManager.GetRendererInstance }

function TppRTFRendererManager.GetRendererInstance(aRendererClass: TppRTFRendererClass): TppRTFRenderer;
var
  liIndex: Integer;
begin

  Result := nil;

  liIndex := 0;

  while (Result = nil) and (liIndex < FRenderers.Count) do
    begin

      if (TppRTFRenderer(FRenderers.Items[liIndex]).ClassType = aRendererClass) then
        Result := TppRTFRenderer(FRenderers.Items[liIndex]);

      Inc(liIndex);

    end;

  if (Result = nil) then
    begin

      Result := aRendererClass.Create;
      FRenderers.Add(Result);

    end;

end;

{@TppRTFRendererManager.RegisterRenderer

  Used to register a custom TppPDFRenderer descendant. The class type is added
  to a list. If a renderer already exists for the associated draw command, then
  it is deleted. }

class procedure TppRTFRendererManager.RegisterRenderer(aRTFRendererClass: TppRTFRendererClass);
var
  liIndex: Integer;
  lRendererClass: TppRTFRendererClass;
begin

  uLock.Acquire;

  try

    for liIndex := 0 to uRendererClasses.Count - 1 do
      begin

        lRendererClass := TppRTFRendererClass(uRendererClasses.Items[liIndex]);

        if (lRendererClass.DrawCommandClass = aRTFRendererClass.DrawCommandClass) then
          uRendererClasses.Delete(liIndex);

      end;

    uRendererClasses.Add(aRTFRendererClass);

  finally
    uLock.Release;
  end;

end;

{@TppRTFRendererManager.UnregisterRenderer

  Used to remove a renderer class from the list of renderers. }

class procedure TppRTFRendererManager.UnregisterRenderer(aRTFRendererClass: TppRTFRendererClass);
var
  liIndex: Integer;
begin

  uLock.Acquire;

  try

    liIndex := uRendererClasses.IndexOf(aRTFRendererClass);

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
