{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit ppTextSearchEngineRegistry;

interface

uses
  Classes,
  ppTextSearchCustomEngine;

type

  {@TppTextSearchEngineRegistry}

  TppTextSearchEngineRegistry = class
    public
      class procedure Register(aSearchEngineClass: TppTextSearchCustomEngineClass);
      class procedure UnRegister(aSearchEngineClass: TppTextSearchCustomEngineClass);

      class function GetEngineForDescription(const aDescription: String): TppTextSearchCustomEngineClass;
      class procedure GetEngines(aList: TStrings);

  end;


implementation

uses
  SysUtils,
  ppTextSearchError;

var
  FEngineClasses: TList = nil;

{@TppTextSearchEngineRegistry.GetEngineForDescription }

class function TppTextSearchEngineRegistry.GetEngineForDescription(const aDescription: String): TppTextSearchCustomEngineClass;
var
  liIndex: Integer;
  lClass: TppTextSearchCustomEngineClass;
begin

  Result := nil;

  for liIndex := 0 to FEngineClasses.Count - 1 do
    begin
      lClass := TppTextSearchCustomEngineClass(FEngineClasses[liIndex]);

      if (lClass.Description = aDescription) then
        Result := lClass;
    end;

end;
   
{@TppTextSearchEngineRegistry.GetEngines }

class procedure TppTextSearchEngineRegistry.GetEngines(aList: TStrings);
var
  liIndex: Integer;
  lClass: TppTextSearchCustomEngineClass;
begin

  aList.Clear;

  for liIndex := 0 to FEngineClasses.Count - 1 do
    begin
      lClass := TppTextSearchCustomEngineClass(FEngineClasses[liIndex]);

      aList.Add(lClass.Description);
    end;
end;

{@TppTextSearchEngineRegistry.Register }

class procedure TppTextSearchEngineRegistry.Register(aSearchEngineClass: TppTextSearchCustomEngineClass);
begin

  if (aSearchEngineClass = nil) then
    raise ESearchError.Create('TppTextSearchEngineRegistry.Register: Cannot register a nil class');

  if (FEngineClasses = nil) then
    FEngineClasses := TList.Create;

  if (FEngineClasses.IndexOf(aSearchEngineClass) = -1) then
    FEngineClasses.Add(TObject(aSearchEngineClass));

end;
   
{@TppTextSearchEngineRegistry.UnRegister }

class procedure TppTextSearchEngineRegistry.UnRegister(aSearchEngineClass: TppTextSearchCustomEngineClass);
begin

  if (aSearchEngineClass = nil) then
    raise ESearchError.Create('TppTextSearchEngineRegistry.UnRegister: Cannot unregister a nil class');

  if (FEngineClasses <> nil) then
    FEngineClasses.Remove(TObject(aSearchEngineClass));

end;

initialization

finalization
  FEngineClasses.Free;
  FEngineClasses := nil;

end.
