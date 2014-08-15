
{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2010                    BBBBB   }

unit ppXLSRendererManager;

interface

uses
  Classes,
  ppDevice,
  ppXLSRenderer;


type

  {@TppXLSRendererManager

    When a report is printed to the XLS device, TppXLSRenderer descendants
    are used to convert the draw command to XLS cells. It is the purpose
    of this class to cache and mangage these objects during the device output
    process. This class also has class functions that support the registration
    of draw command renderers.

    Each TppXLSRenderer descendant has a class function called
    GetDrawCommandClass which returns the draw command class the renderer is
    designed to handle. When the renderer manager is asked for a renderer, it
    creates one for the right draw command class. If one does not exist for
    the specific draw command class, it traces up the inheritance chain to find
    one for an ancestor if one is available. Once they are created, these
    renderer objects are stored in a pool so they can be reused.

  }

  TppXLSRendererManager = class
  private
    FRenderers: TList;

    class procedure Finalize;
    function GetRendererInstance(aRendererClass: TppXLSRendererClass): TppXLSRenderer;
    class procedure Initialize;

  public
    constructor Create;
    destructor Destroy; override;

    function GetRendererForDrawCommand(aDrawCommand: TppDrawCommand): TppXLSRenderer;
    
    class function GetRendererClass(aDrawCommandClass: TClass): TppXLSRendererClass;
    class procedure GetRendereClasses(var aRendererClasses: TList);
    class procedure RegisterRenderer(aXLSRendererClass: TppXLSRendererClass);
    class procedure UnregisterRenderer(aXLSRendererClass: TppXLSRendererClass);

  end;

implementation

uses
  SyncObjs;

var
  uLock: TCriticalSection;
  uRendererClasses: TList;

constructor TppXLSRendererManager.Create;
begin
  inherited;

  FRenderers := TList.Create;
  
end;

destructor TppXLSRendererManager.Destroy;
var
  liIndex: Integer;
begin

  for liIndex := FRenderers.Count - 1 downto 0 do
    TObject(FRenderers[liIndex]).Free;

  FRenderers.Free;
  FRenderers := nil;
  
  inherited;
end;

class procedure TppXLSRendererManager.Finalize;
begin
  uRendererClasses.Free;
  uRendererClasses := nil;
  uLock.Free;
  uLock := nil;
end;

class procedure TppXLSRendererManager.GetRendereClasses(var aRendererClasses: TList);
begin

  uLock.Acquire;

  try
    aRendererClasses.Assign(uRendererClasses);

  finally
    uLock.Release;

  end;

end;

{ TppXLSRendererManager.GetRendererClass }

class function TppXLSRendererManager.GetRendererClass(aDrawCommandClass: TClass): TppXLSRendererClass;
var
  liIndex: Integer;
  lDrawCommandClass: TppDrawCommandClass;
  lRendererClass: TppXLSRendererClass;
begin

  uLock.Acquire;

  try

    Result := nil;

    liIndex := 0;

    while (Result = nil) and (liIndex < uRendererClasses.Count) do
      begin

        lRendererClass := TppXLSRendererClass(uRendererClasses.Items[liIndex]);

        lDrawCommandClass := lRendererClass.DrawCommandClass;

        if (aDrawCommandClass = lDrawCommandClass) then
          Result := lRendererClass;

        Inc(liIndex);

      end;

    {if no renderer found, then recurse using the parent drawcommand class}
    if ((Result = nil) and (aDrawCommandClass <> TppDrawCommand)) then
      Result := GetRendererClass(TppDrawCommandClass(aDrawCommandClass.ClassParent));

  finally
    uLock.Release;

  end;

end;

{@TppXLSRendererManager.GetRendererForDrawCommand

  This a the main entry point for the functionality provided by the renderer
  manager. When the device wants to process a draw command, it uses the
  renderer manager to get an instantiated TppXLSRenderer descendant that can
  be used for processing. This function will return nil if no renderer is
  available for the draw command. }

function TppXLSRendererManager.GetRendererForDrawCommand(aDrawCommand: TppDrawCommand): TppXLSRenderer;
var
  lRendererClass: TppXLSRendererClass;
begin

  Result := nil;

  lRendererClass := GetRendererClass(TppDrawCommandClass(aDrawCommand.ClassType));
  if (lRendererClass <> nil) then
    Result := GetRendererInstance(lRendererClass);

end;

{@TppXLSRendererManager.GetRendererInstance }

function TppXLSRendererManager.GetRendererInstance(aRendererClass: TppXLSRendererClass): TppXLSRenderer;
var
  liIndex: Integer;
begin

  Result := nil;

  liIndex := 0;

  while (Result = nil) and (liIndex < FRenderers.Count) do
    begin

      if (TppXLSRenderer(FRenderers.Items[liIndex]).ClassType = aRendererClass) then
        Result := TppXLSRenderer(FRenderers.Items[liIndex]);

      Inc(liIndex);

    end;

  if (Result = nil) then
    begin

      Result := aRendererClass.Create;
      FRenderers.Add(Result);

    end;

end;

class procedure TppXLSRendererManager.Initialize;
begin
  if uLock <> nil then Exit;

  uLock := TCriticalSection.Create;
  uRendererClasses := TList.Create;
end;

{@TppXLSRendererManager.RegisterRenderer

  Used to register a custom TppPDFRenderer descendant. The class type is added
  to a list. If a renderer already exists for the associated draw command, then
  it is deleted. }

class procedure TppXLSRendererManager.RegisterRenderer(aXLSRendererClass: TppXLSRendererClass);
var
  liIndex: Integer;
  lRendererClass: TppXLSRendererClass;
begin

  if (uLock = nil) then
    TppXLSRendererManager.Initialize;

  uLock.Acquire;

  try

    for liIndex := 0 to uRendererClasses.Count - 1 do
      begin

        lRendererClass := TppXLSRendererClass(uRendererClasses.Items[liIndex]);

        if (lRendererClass.DrawCommandClass = aXLSRendererClass.DrawCommandClass) then
          uRendererClasses.Delete(liIndex);

      end;

    uRendererClasses.Add(aXLSRendererClass);

  finally
    uLock.Release;
  end;

end;

{@TppXLSRendererManager.UnregisterRenderer

  Used to remove a renderer class from the list of renderers. }

class procedure TppXLSRendererManager.UnregisterRenderer(aXLSRendererClass: TppXLSRendererClass);
var
  liIndex: Integer;
begin

  if (uLock = nil) then Exit;

  uLock.Acquire;

  try

    liIndex := uRendererClasses.IndexOf(aXLSRendererClass);

    if (liIndex > -1) then
      uRendererClasses.Delete(liIndex);

  finally
    uLock.Release;
  end;

end;


initialization

  TppXLSRendererManager.Initialize;

finalization

  TppXLSRendererManager.Finalize;



end.
