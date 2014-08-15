{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit ppTextSearchDrawCommandHighlightRegistry;

interface

uses
  Classes,
  ppDevice,
  ppTextSearchDrawCommandHighlighter;

type

  {@TppDrawCommandHighlightRegistryList }

  TppTextSearchHighlightRegistryList = class
    private
      FHighlighters: TList;
      FDrawCommandClasses: TList;
      FHighlighterClasses: TList;

      function CreateHighlighter(aDrawCommandHighlighterClass: TppTextSearchDrawCommandHighlighterClass): TppTextSearchDrawCommandHighlighter;
      function GetRegisteredClassIndex(aDrawCommandClass: TppDrawCommandClass; aStartIndex: Integer): Integer;
      function GetHighlighterClassForDrawCommand(aDrawCommand: TppDrawCommand): TppTextSearchDrawCommandHighlighterClass;
      function GetHighlighter(aDrawCommandHighlighterClass: TppTextSearchDrawCommandHighlighterClass): TppTextSearchDrawCommandHighlighter;

    public
      constructor Create;
      destructor Destroy; override;

      procedure Add(aDrawCommandClass: TppDrawCommandClass; aDrawCommandHighlighterClass: TppTextSearchDrawCommandHighlighterClass);
      procedure Remove(aDrawCommandClass: TppDrawCommandClass; aDrawCommandHighlighterClass: TppTextSearchDrawCommandHighlighterClass; aStartingIndex: Integer);
      function GetHighlighterForDrawCommand(aDrawCommand: TppDrawCommand): TppTextSearchDrawCommandHighlighter;
      function IsRegistered(aDrawCommandClass: TppDrawCommandClass): Boolean;

    end;

  {@TppTextSearchDrawCommandHighlightRegistry }

  TppTextSearchDrawCommandHighlightRegistry = class
    public
      class procedure Register(aDrawCommandClass: TppDrawCommandClass; aDrawCommandHighlighterClass: TppTextSearchDrawCommandHighlighterClass);
      class procedure UnRegister(aDrawCommandClass: TppDrawCommandClass; aDrawCommandHighlighterClass: TppTextSearchDrawCommandHighlighterClass);

      class function GetHighlighterForDrawCommand(aDrawCommand: TppDrawCommand): TppTextSearchDrawCommandHighlighter;
      class function IsRegistered(aDrawCommandClass: TppDrawCommandClass): Boolean;

  end;


implementation

uses
  ppTextSearchError;

var
  uRegistrations: TppTextSearchHighlightRegistryList = nil;

{TppTextSearchDrawCommandHighlightRegistry-----------------------------------------------}

{@TppTextSearchDrawCommandHighlightRegistry.CreateHighlighterForDrawCommand }

class function TppTextSearchDrawCommandHighlightRegistry.GetHighlighterForDrawCommand(aDrawCommand: TppDrawCommand): TppTextSearchDrawCommandHighlighter;
begin
  Result := uRegistrations.GetHighlighterForDrawCommand(aDrawCommand);
end;
     
{@TppTextSearchDrawCommandHighlightRegistry.IsRegistered }

class function TppTextSearchDrawCommandHighlightRegistry.IsRegistered(aDrawCommandClass: TppDrawCommandClass): Boolean;
begin
  Result := uRegistrations.IsRegistered(aDrawCommandClass);
end;

{@TppTextSearchDrawCommandHighlightRegistry.Register }

class procedure TppTextSearchDrawCommandHighlightRegistry.Register(aDrawCommandClass: TppDrawCommandClass; aDrawCommandHighlighterClass: TppTextSearchDrawCommandHighlighterClass);
begin
  if (uRegistrations = nil) then
    uRegistrations := TppTextSearchHighlightRegistryList.Create;

  uRegistrations.Add(aDrawCommandClass, aDrawCommandHighlighterClass);
end;
 
{@TppTextSearchDrawCommandHighlightRegistry.UnRegister }

class procedure TppTextSearchDrawCommandHighlightRegistry.UnRegister(aDrawCommandClass: TppDrawCommandClass; aDrawCommandHighlighterClass: TppTextSearchDrawCommandHighlighterClass);
begin
  if (uRegistrations <> nil) then
    uRegistrations.Remove(aDrawCommandClass, aDrawCommandHighlighterClass, 0);
end;

{TppDrawCommandHighlightRegistration-------------------------------------------}

{@TppDrawCommandHighlightRegistration.Create

constructor TppDrawCommandHighlightRegistration.Create;
begin
  FDrawCommand := nil;
  FHighlighter := nil;
end;}

{TppTextSearchHighlightRegistryList---------------------------------------}

{@TppTextSearchHighlightRegistryList.Create }

constructor TppTextSearchHighlightRegistryList.Create;
begin
  FHighlighters := TList.Create;
  FDrawCommandClasses := TList.Create;
  FHighlighterClasses := TList.Create;
end;
   
{@TppTextSearchHighlightRegistryList.Destroy }

destructor TppTextSearchHighlightRegistryList.Destroy;
var
  liIndex: Integer;
begin

  for liIndex := FHighlighters.Count - 1 downto 0 do
    TppTextSearchDrawCommandHighlighter(FHighlighters[liIndex]).Free;

  FHighlighters.Free;
  FDrawCommandClasses.Free;
  FHighlighterClasses.Free;

  inherited Destroy;

end;

{@TppTextSearchHighlightRegistryList.Add }

procedure TppTextSearchHighlightRegistryList.Add(aDrawCommandClass: TppDrawCommandClass; aDrawCommandHighlighterClass: TppTextSearchDrawCommandHighlighterClass);
begin
  FDrawCommandClasses.Add(TObject(aDrawCommandClass));
  FHighlighterClasses.Add(TObject(aDrawCommandHighlighterClass));
end;

{@TppTextSearchHighlightRegistryList.Remove }

procedure TppTextSearchHighlightRegistryList.Remove(aDrawCommandClass: TppDrawCommandClass; aDrawCommandHighlighterClass: TppTextSearchDrawCommandHighlighterClass; aStartingIndex: Integer);
var
  liDrawCommandIndex: Integer;
begin

  liDrawCommandIndex := GetRegisteredClassIndex(aDrawCommandClass, aStartingIndex);

  if (liDrawCommandIndex <> -1) then
    begin

      if (FHighlighterClasses[liDrawCommandIndex] = aDrawCommandHighlighterClass) then
        begin
          FDrawCommandClasses.Delete(liDrawCommandIndex);
          FHighlighterClasses.Delete(liDrawCommandIndex);
        end
      else
        Remove(aDrawCommandClass, aDrawCommandHighlighterClass, liDrawCommandIndex + 1);

    end;
    
end;

{@TppTextSearchHighlightRegistryList.GetHighlighterClassForDrawCommand }

function TppTextSearchHighlightRegistryList.GetHighlighterClassForDrawCommand(aDrawCommand: TppDrawCommand): TppTextSearchDrawCommandHighlighterClass;
var
  liHighlighterIndex: Integer;
begin

  liHighlighterIndex := GetRegisteredClassIndex(TppDrawCommandClass(aDrawCommand.ClassType), 0);

  if (liHighlighterIndex = -1) then
    raise ESearchError.Create('TppTextSearchHighlightRegistry.GetHighlighterForDrawCommand: Unable to find highlighter class for: ' + aDrawCommand.ClassName + '.');

  Result := TppTextSearchDrawCommandHighlighterClass(FHighlighterClasses[liHighlighterIndex])

end;

{@TppTextSearchHighlightRegistryList.GetHighlighterForDrawCommand }

function TppTextSearchHighlightRegistryList.GetHighlighterForDrawCommand(aDrawCommand: TppDrawCommand): TppTextSearchDrawCommandHighlighter;
var
  lHighlighterClass: TppTextSearchDrawCommandHighlighterClass;
begin

  lHighlighterClass := GetHighlighterClassForDrawCommand(aDrawCommand);

  Result := GetHighlighter(lHighlighterClass);

  if (Result = nil) then
    Result := CreateHighlighter(lHighlighterClass);

end;

{@TppTextSearchHighlightRegistryList.CreateHighlighter }

function TppTextSearchHighlightRegistryList.CreateHighlighter(aDrawCommandHighlighterClass: TppTextSearchDrawCommandHighlighterClass): TppTextSearchDrawCommandHighlighter;
var
  lHighlighter: TppTextSearchDrawCommandHighlighter;
begin

  lHighlighter := aDrawCommandHighlighterClass.Create;

  FHighlighters.Add(lHighlighter);

  Result := lHighlighter;

end;

{@TppTextSearchHighlightRegistryList.GetHighlighter }

function TppTextSearchHighlightRegistryList.GetHighlighter(aDrawCommandHighlighterClass: TppTextSearchDrawCommandHighlighterClass): TppTextSearchDrawCommandHighlighter;
var
  liIndex: Integer;
  lHighlighter: TppTextSearchDrawCommandHighlighter;
begin

  liIndex := 0;
  lHighlighter := nil;

  while (liIndex < FHighlighters.Count) and not(lHighlighter is aDrawCommandHighlighterClass) do
    begin
      lHighlighter := TppTextSearchDrawCommandHighlighter(FHighlighters[liIndex]);
      Inc(liIndex);
    end;

  if (liIndex = FHighlighters.Count) then
    Result := nil
  else
    Result := lHighlighter;

end;

{@TppTextSearchHighlightRegistryList.GetRegisteredClassIndex }

function TppTextSearchHighlightRegistryList.GetRegisteredClassIndex(aDrawCommandClass: TppDrawCommandClass; aStartIndex: Integer): Integer;
var
  liIndex: Integer;
  lClass: TClass;
  lCurrentClass: TClass;
  liCurrentIndex: Integer;
begin

  lCurrentClass :=  nil;
  liCurrentIndex := -1;

  {use the latest registered classes as they are added to the end of the list}
  for liIndex := aStartIndex to FDrawCommandClasses.Count - 1 do
    begin
      lClass := TClass(FDrawCommandClasses[liIndex]);

      if (aDrawCommandClass.InheritsFrom(lClass)) and
        ((lCurrentClass = nil) or (lCurrentClass.InheritsFrom(lClass))) then
        begin
          lCurrentClass := lClass;
          liCurrentIndex := liIndex;
        end;

    end;

  Result := liCurrentIndex;

end;

{@TppTextSearchHighlightRegistryList.IsRegistered }

function TppTextSearchHighlightRegistryList.IsRegistered(aDrawCommandClass: TppDrawCommandClass): Boolean;
var
  liAncestorIndex: Integer;
begin

  {is this class registered?}
  Result := (FDrawCommandClasses.IndexOf(TObject(aDrawCommandClass)) <> -1);

  {if not, then is an ancestor registered?}
  if not(Result) then
    begin
      liAncestorIndex := GetRegisteredClassIndex(aDrawCommandClass, 0);

      Result := (liAncestorIndex <> -1);
    end;

end;

initialization
  if (uRegistrations = nil) then
    uRegistrations := TppTextSearchHighlightRegistryList.Create;

finalization
  uRegistrations.Free;
  uRegistrations := nil;

end.
