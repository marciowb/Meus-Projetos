{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit ppCmpReg;

interface

{$I ppIfDef.pas}

uses
  Windows, Classes, Graphics, ppUtils;

type

  {@TppRegComponent }
  TppRegComponent = class
    FHInstance: Longint;
    FComponentClass: TComponentClass;
    FToolBarPosition: Integer;
    FToolBarName: String;
    FHint: String;
    FHintIndex: Integer;

    public
      constructor Create(aComponentClass: TComponentClass;
                         const aToolBarName: String;
                         aToolBarPosition: Integer;
                         aHintIndex: Integer;
                         const aHint: String;
                         aHInstance: Longint);

      property HInstance: Longint read FHInstance write FHInstance;
      property ComponentClass: TComponentClass read FComponentClass;
      property ToolBarPosition: Integer read FToolBarPosition;
      property ToolBarName: String read FToolBarName;
      property Hint: String read FHint;
      property HintIndex: Integer read FHintIndex;

  end; {record, TppRegComponent}




  function  ppComponentClassList: TppRegList;


implementation

uses
  ppClass;

var
  FComponentClassList: TppRegList = nil;

{******************************************************************************
 *
 ** R E G   C O M P O N E N T
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppRegComponent.Create }

constructor TppRegComponent.Create(aComponentClass: TComponentClass;
                                 const aToolBarName: String;
                                 aToolBarPosition: Integer;
                                 aHintIndex: Integer;
                                 const aHint: String;
                                 aHInstance: Longint);
begin
  inherited Create;

  FComponentClass := aComponentClass;
  FToolBarName := aToolBarName;
  FToolBarPosition := aToolBarPosition;
  FHintIndex := aHintIndex;
  FHint := aHint;
  FHInstance := aHInstance;
  
end; {constructor, Create}



{******************************************************************************
 *
 ** R E G I S T E R   P R O C E D U R E S
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ ppComponentClassList - this routine creates the stringlist which will contain
  the class reference variables for the Report Components.  The register routines
  always call this routine first, thus forcing the creation of the stringlist.
  This approach was taken because unit loading sequences would not guarantee
  that ppComponent initialization fired first, resulting in a nil ppComponentClassList.
  This function solves that problem...}

function ppComponentClassList: TppRegList;
begin

  if FComponentClassList = nil then
    FComponentClassList := TppRegList.Create;

  Result := FComponentClassList;
end;

{------------------------------------------------------------------------------}
{ ppRegisterComponentHandler }

procedure ppRegisterComponentHandler(aComponentClass: TComponentClass;
                                     const aToolBarName: String;
                                     aToolBarPosition: Integer;
                                     aHintIndex: Integer;
                                     const aHint: String;
                                     aHInstance: Longint);
var
  lRegComponent: TppRegComponent;
  liIndex: Integer;
begin

  liIndex := ppComponentClassList.IndexOf(aComponentClass.ClassName);

  if (liIndex <> -1) then
    begin
      ppComponentClassList.Objects[liIndex].Free;
      ppComponentClassList.Delete(liIndex);
      UnRegisterClass(aComponentClass);
    end;

  lRegComponent := TppRegComponent.Create(aComponentClass,
                                          aToolBarName,
                                          aToolBarPosition,
                                          aHintIndex,
                                          aHint,
                                          aHInstance);

  RegisterClass(lRegComponent.ComponentClass);

  ppComponentClassList.AddObject(aComponentClass.ClassName, lRegComponent);

end; {procedure, ppRegisterComponentHandler}


{------------------------------------------------------------------------------}
{ ppUnRegisterComponentHandler }

procedure ppUnRegisterComponentHandler(aComponentClass: TComponentClass);
var
  liIndex: Integer;

begin

  if (aComponentClass = nil) then Exit;

  UnRegisterClass(aComponentClass);

  if (FComponentClassList = nil) then Exit;

  liIndex := (ppComponentClassList.IndexOf(aComponentClass.ClassName));

  if (liIndex >= 0) then
    begin
      UnRegisterClass(aComponentClass);
      ppComponentClassList.Objects[liIndex].Free;
      ppComponentClassList.Delete(liIndex);
    end;

end; {procedure, ppUnRegisterComponentHandler}

{******************************************************************************
 *
 ** I N I T I A L I Z A T I O N   /   F I N A L I Z A T I O N
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ FreeComponentClassList }

procedure FreeComponentClassList;
var
  liIndex: Integer;
begin

  if (FComponentClassList = nil) then Exit;

  for liIndex := 0 to FComponentClassList.Count - 1 do
    FComponentClassList.Objects[liIndex].Free;

  FComponentClassList.Free;
  FComponentClassList := nil;

end; {procedure, FreeComponentClassList}

initialization

  ppClass.ppRegisterComponentProc := ppRegisterComponentHandler;
  ppClass.ppUnRegisterComponentProc := ppUnRegisterComponentHandler;

finalization

  ppClass.ppRegisterComponentProc := nil;
  ppClass.ppUnRegisterComponentProc := nil;

  FreeComponentClassList;
  
end.
