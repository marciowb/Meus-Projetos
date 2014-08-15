{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2004                    BBBBB   }

unit ppUndo;

interface

uses
  Windows,
  SysUtils,
  Classes,
  Graphics,
  ppTypes,
  ppUtils,
  ppCollectionBase,
  ppDb,
  ppClass,
  ppReport;

type

  TppUndoable = class;
  TppUndoableCollection = class;
  TppUndoableClass = class of TppUndoable;

  {TppUndoableClassInfo}
  TppUndoableClassInfo = class
  private
    FOperation: String;
    FUndoableClass: TppUndoableClass;

  public
    constructor Create(aOperation: String; aUndoableClass: TppUndoableClass);
    property Operation: String read FOperation;
    property UndoableClass: TppUndoableClass read FUndoableClass;

  end;

  {TppUndoableClassInfoCollection}
  TppUndoableClassInfoCollection = class(TppCollectionBase)
  private
    function GetItemForOperation(aOperation: String): TppUndoableClassInfo;
    function GetItemForIndex(aIndex: Integer): TppUndoableClassInfo;
    function IndexOfOperation(aOperation: String): Integer;

  public
    constructor Create; override;

    procedure Add(aUndoableClassInfo: TppUndoableClassInfo);
    procedure Remove(aUndoableClassInfo: TppUndoableClassInfo);

    property Items[Operation: String]: TppUndoableClassInfo read GetItemForOperation; default;

  end;


  {TppUndoableClassFactory}
  TppUndoableClassFactory = class
  private

    class function GetUndoableClassInfoCollection: TppUndoableClassInfoCollection;
    class function IsValidEmbeddedPropName(aObject: TObject; aOperation: String): Boolean;

  public
    class procedure Register(aOperation: String; aUndoableClass: TppUndoableClass);  overload;
    class procedure Register(aUndoableClassInfo: TppUndoableClassInfo);  overload;
    class procedure UnRegister(aUndoableClassInfo: TppUndoableClassInfo);

    class function CreateInstance(aOperation: String; aObject: TObject): TppUndoable;

  end;

  {TppUndoable

    Abstract ancestor for undoable operations.

    Has the capability for undoing and redoing one atomic operation}
  TppUndoable = class
  private
    FComponentName: String;
    FOperation: String;
    FSubItems: TppUndoableCollection;

    function GetSubItems: TppUndoableCollection;
    procedure UndoSubItems(aReport: TppCustomReport);

  protected
    function GetDescription: String; virtual; //abstract;
    procedure Prepare(aObject: TObject); virtual;
    procedure DoOperation(aObject: TObject); virtual; abstract;

  public
    constructor Create(aObject: TObject; aOperation: String); virtual;
    destructor Destroy; override;

    procedure Execute(aReport: TppCustomReport); virtual;
    procedure ExecuteRedo(aReport: TppCustomReport); virtual;

    property Description: String read GetDescription;
    property Operation: String read FOperation;
    property ComponentName: String read FComponentName;
    property SubItems: TppUndoableCollection read GetSubItems;

  end;


  {TppUndoableCollection }
  TppUndoableCollection = class(TppCollectionBase)
  private
    function GetItemForIndex(Index: Integer): TppUndoable;
  public
    constructor Create; override;

    procedure Add(aUndoable: TppUndoable);
    procedure Remove(aUndoable: TppUndoable);

    property Items[Index: Integer]: TppUndoable read GetItemForIndex; default;

  end;


  {TppUndoableTask
    Contains a collection of undoable operations}
  TppUndoableTask = class
  private
    FUndoables: TppUndoableCollection;

  public
    constructor Create; virtual;
    destructor Destroy; override;

    procedure Execute(aReport: TppCustomReport); virtual;
    procedure ExecuteRedo(aReport: TppCustomReport); virtual;

    property Items: TppUndoableCollection read FUndoables;

  end;


  {TppUndoableTaskCollection}
  TppUndoableTaskCollection = class(TppCollectionBase)
  private
    FCapacity: Integer;
    
    function GetItemForIndex(Index: Integer): TppUndoableTask;
    procedure SetCapacity(const Value: Integer);

  public
    constructor Create; override;
    destructor Destroy; override;

    procedure Add(aUndoable: TppUndoableTask);
    procedure Clear; override;
    procedure Remove(aUndoable: TppUndoableTask);
    procedure RemoveAndFree(aUndoable: TppUndoableTask);
    function RemoveLast: TppUndoableTask;

    property Capacity: Integer read FCapacity write SetCapacity;
    property Items[Index: Integer]: TppUndoableTask read GetItemForIndex; default;
  end;

  
  {TppUndoManager}
  TppUndoManager = class
  private
    FActive: Boolean;
    FBusy: Boolean;
    FCurrentOperation: TppUndoable;
    FCurrentTask: TppUndoableTask;
    FUndoableTasks: TppUndoableTaskCollection;
    FRedoableTasks: TppUndoableTaskCollection;
    FEndTask: Integer;
    FEndOperation: Integer;

    function GetRedoableCount: Integer;
    function GetUndoableCount: Integer;
    procedure AddUndoable(aUndoable: TppUndoable);
    function GetCapacity: Integer;
    procedure SetCapacity(const Value: Integer);

  public
    constructor Create; virtual;
    destructor Destroy; override;

    procedure Clear;

    function BeginTask: TppUndoableTask;
    procedure EndTask;

    procedure AddOperation(aOperation: String; aObject: TObject); 
    procedure BeginOperation(aOperation: String; aObject: TObject);
    procedure EndOperation;

    procedure PerformUndo(aReport: TppCustomReport);
    procedure PerformRedo(aReport: TppCustomReport);

    property Active: Boolean read FActive write FActive;
    property Busy: Boolean read FBusy;
    property Capacity: Integer read GetCapacity write SetCapacity;

    property UndoableCount: Integer read GetUndoableCount;
    property RedoableCount: Integer read GetRedoableCount;

    property UndoableTasks: TppUndoableTaskCollection read FUndoableTasks;
    property RedoableTasks: TppUndoableTaskCollection read FRedoableTasks;

  end;


  {TppSetBoundsUnDoable
    - ancestor to Move and Resize operations}
  TppSetBoundsUnDoable = class(TppUndoable)
  private
    FBoundsRect: TppSizeRect;

  protected
    procedure Prepare(aObject: TObject); override;
    procedure DoOperation(aObject: TObject); override;

  public
    property BoundsRect: TppSizeRect read FBoundsRect;

  end;

  {TppMoveUnDoable
    - Undoable for the Move operations}
  TppMoveUnDoable = class(TppSetBoundsUnDoable)
  protected
    function GetDescription: String; override;
  end;

  {TppResizeUnDoable
    - Undoable for the Resize operations}
  TppResizeUnDoable = class(TppSetBoundsUnDoable)
  protected
    function GetDescription: String; override;
  end;


  {TppZOrderUnDoable
    - Undoable for the BringToFront, SendToBack operations}
  TppZOrderUnDoable = class(TppUndoable)
  private
    FZIndex: Integer;

  protected
    procedure Prepare(aObject: TObject); override;
    procedure DoOperation(aObject: TObject); override;

  public
    property ZIndex: Integer read FZIndex write FZIndex;

  end;


  {TppComponentInstanceUndoable }
  TppComponentInstanceUndoable = class(TppUndoable)
  private
    FObjectStream: TMemoryStream;
    FPipelineList: TppDataPipelineList;
    FReport: TppCustomReport;
    FRegionName: String;
    FReportName: String;

  protected
    procedure Prepare(aObject: TObject); override;

    procedure ObjectToStream(aComponent: TComponent); virtual;
    procedure ObjectFromStream(aReport: TppCustomReport); virtual;
    procedure ComponentReadCallback(Component: TComponent); virtual;
    procedure ReaderOnFindMethod(Reader: TReader; const MethodName: string; var Address: Pointer; var Error: Boolean); virtual;
    procedure ReaderOnSetName(Reader: TReader; Component: TComponent; var Name: string); virtual;

  public
    destructor Destroy; override;

    procedure Execute(aReport: TppCustomReport); override;
    procedure ExecuteRedo(aReport: TppCustomReport); override;

  end;

  {TppComponentDestroyUndoable }
  TppComponentDestroyUndoable = class(TppComponentInstanceUndoable)
  public
    constructor Create(aObject: TObject; aOperation: String); override;

  end;

  {TppSetPropUndoable
    - default undoable for set prop operations}
  TppSetPropUndoable = class(TppUndoable)
  private
    FPropertyName: String;
    FPropValueAsString: String;

  protected
    procedure Prepare(aObject: TObject); override;
    procedure DoOperation(aObject: TObject); override;


  public
    property PropertyName: String read FPropertyName write FPropertyName;
    property PropValueAsString: String read FPropValueAsString write FPropValueAsString;

  end;

  {TppSetEmbeddedPropUndoable
    - default undoable for set prop operations on embedded objects}
  TppSetEmbeddedPropUndoable = class(TppSetPropUndoable)
  private
    FQualifier: String;

  protected
    procedure Prepare(aObject: TObject); override;
    procedure DoOperation(aObject: TObject); override;

  public
    property Qualifier: String read FQualifier write FQualifier;

  end;

  {TppSetPersistentPropUndoable }
  TppSetPersistentPropUndoable = class(TppUndoable)
  private
    FPropertyName: String;
    FPropValue: TPersistent;

  protected
    procedure Prepare(aObject: TObject); override;
    procedure DoOperation(aObject: TObject); override;

  public
    property PropertyName: String read FPropertyName;
    destructor Destroy; override;

  end;

  {TppSetFontUndoable }
  TppSetFontUndoable = class(TppUndoable)
  private
    FPropertyName: String;
    FPropValue: TFont;

  protected
    procedure Prepare(aObject: TObject); override;
    procedure DoOperation(aObject: TObject); override;

  public
    destructor Destroy; override;

    property PropertyName: String read FPropertyName;

  end;

  {TppSetFontSizeUndoable}
  TppSetFontSizeUndoable = class(TppUndoable)
  private
    FPropertyName: String;
    FPropValue: Integer;

  protected
    procedure Prepare(aObject: TObject); override;
    procedure DoOperation(aObject: TObject); override;

  public
    property PropertyName: String read FPropertyName;

  end;

  {TppSetFontStyleUndoable}
  TppSetFontStyleUndoable = class(TppUndoable)
  private
    FPropertyName: String;
    FPropValue: TFontStyles;

  protected
    procedure Prepare(aObject: TObject); override;
    procedure DoOperation(aObject: TObject); override;

  public
    property PropertyName: String read FPropertyName;

  end;

  {TppSetFontColorUndoable}
  TppSetFontColorUndoable = class(TppUndoable)
  private
    FPropertyName: String;
    FPropValue: TColor;

  protected
    procedure Prepare(aObject: TObject); override;
    procedure DoOperation(aObject: TObject); override;

  public
    property PropertyName: String read FPropertyName;

  end;

  {TppSetPenStyleUndoable}
  TppSetPenStyleUndoable = class(TppUndoable)
  private
    FPropertyName: String;
    FPropValue: TPenStyle;

  protected
    procedure Prepare(aObject: TObject); override;
    procedure DoOperation(aObject: TObject); override;

  public
    property PropertyName: String read FPropertyName;

  end;

  {TppSetPenColorUndoable}
  TppSetPenColorUndoable = class(TppUndoable)
  private
    FPropertyName: String;
    FPropValue: TColor;

  protected
    procedure Prepare(aObject: TObject); override;
    procedure DoOperation(aObject: TObject); override;

  public
    property PropertyName: String read FPropertyName;

  end;

  {TppSetBrushStyleUndoable}
  TppSetBrushStyleUndoable = class(TppUndoable)
  private
    FPropertyName: String;
    FPropValue: TBrushStyle;

  protected
    procedure Prepare(aObject: TObject); override;
    procedure DoOperation(aObject: TObject); override;

  public
    property PropertyName: String read FPropertyName;

  end;

  {TppSetBrushColorUndoable}
  TppSetBrushColorUndoable = class(TppUndoable)
  private
    FPropertyName: String;
    FPropValue: TColor;

  protected
    procedure Prepare(aObject: TObject); override;
    procedure DoOperation(aObject: TObject); override;

  public
    property PropertyName: String read FPropertyName;

  end;



  {TppSetAnchorsUndoable}
  TppSetAnchorsUndoable = class(TppUndoable)
  private
    FPropertyName: String;
    FPropValue: TppAnchors;

  protected
    procedure Prepare(aObject: TObject); override;
    procedure DoOperation(aObject: TObject); override;

  public
    property PropertyName: String read FPropertyName;

  end;


  {TppSetBorderPositionsUndoable}
  TppSetBorderPositionsUndoable = class(TppUndoable)
  private
    FPropertyName: String;
    FPropValue: TppBorderPositions;

  protected
    procedure Prepare(aObject: TObject); override;
    procedure DoOperation(aObject: TObject); override;

  public
    property PropertyName: String read FPropertyName;

  end;


  {TppSetBandUndoable }
  TppSetBandUndoable = class(TppUndoable)
  private
    FBandName: String;

  protected
    procedure Prepare(aObject: TObject); override;
    procedure DoOperation(aObject: TObject); override;

  public
    property BandName: String read FBandName;

  end;

  {TppSetDataPipelineUndoable }
  TppSetDataPipelineUndoable = class(TppUndoable)
  private
    FDataPipelineName: String;

  protected
    procedure Prepare(aObject: TObject); override;
    procedure DoOperation(aObject: TObject); override;

  public
    property DataPipelineName: String read FDataPipelineName;

  end;

  {TppSetRegionUndoable }
  TppSetRegionUndoable = class(TppUndoable)
  private
    FRegionName: String;

  protected
    procedure Prepare(aObject: TObject); override;
    procedure DoOperation(aObject: TObject); override;

  public
    property RegionName: String read FRegionName;

  end;


implementation

uses
  ppRTTI,
  ppComm,
  ppRegion;

const
  ciDefaultCapacity = 50;

var
  uUndoableClassInfoCollection: TppUndoableClassInfoCollection;

{******************************************************************************
 *
 ** Undoable Class Info
 *
{******************************************************************************}

{TppUndoableClassInfo.Create}
constructor TppUndoableClassInfo.Create(aOperation: String; aUndoableClass: TppUndoableClass);
begin

  inherited Create;

  FOperation := aOperation;
  FUndoableClass := aUndoableClass;

end;

{******************************************************************************
 *
 ** Undoable Class Info Collection
 *
{******************************************************************************}

{TppUndoableClassInfoCollection.Create }

constructor TppUndoableClassInfoCollection.Create;
begin
  inherited;

  InnerList.OwnsObjects := True;
end;

{TppUndoableClassInfoCollection.Add }

procedure TppUndoableClassInfoCollection.Add(aUndoableClassInfo: TppUndoableClassInfo);
begin
  InnerList.Add(aUndoableClassInfo)
end;

{TppUndoableClassInfoCollection.GetItemForIndex }

function TppUndoableClassInfoCollection.GetItemForIndex(aIndex: Integer): TppUndoableClassInfo;
begin
  Result := TppUndoableClassInfo(InnerList[aIndex]);
end;

{TppUndoableClassInfoCollection.IndexOfOperation }

function TppUndoableClassInfoCollection.IndexOfOperation(aOperation: String): Integer;
var
  liIndex: Integer;
  lbFound: Boolean;
begin
  liIndex := 0;
  lbFound := False;

  while not(lbFound) and (liIndex < InnerList.Count) do
    begin
      if (AnsiCompareText(GetItemForIndex(liIndex).Operation, aOperation) = 0) then
        lbFound := True
      else
        Inc(liIndex);

    end;

  if lbFound then
    Result := liIndex
  else
    Result := -1;

end;

{TppUndoableClassInfoCollection.GetItemForOperation }

function TppUndoableClassInfoCollection.GetItemForOperation(aOperation: String): TppUndoableClassInfo;
var
  liIndex: Integer;
begin

  liIndex := IndexOfOperation(aOperation);

  if liIndex >= 0 then
    Result := GetItemForIndex(liIndex)
  else
    Result := nil;

end;

{TppUndoableClassInfoCollection.Remove }

procedure TppUndoableClassInfoCollection.Remove(aUndoableClassInfo: TppUndoableClassInfo);
begin
  InnerList.Remove(aUndoableClassInfo);

end;

{******************************************************************************
 *
 ** Undoable Class Factory
 *
{******************************************************************************}

{TppUndoableClassFactory.CreateInstance }

class function TppUndoableClassFactory.CreateInstance(aOperation: String; aObject: TObject): TppUndoable;
var
  lUndoableClassInfo: TppUndoableClassInfo;
  lPropRec: TraPropRec;
begin
   lUndoableClassInfo := GetUndoableClassInfoCollection[aOperation];

  // if not found and the operation is a valid property then, create a SetProp undoable
  if (lUndoableClassInfo = nil) then
    begin
      if TraRTTI.IsValidPropName(aObject, aOperation) then
        begin
          TraRTTI.GetPropRec(aObject.ClassType, aOperation, lPropRec);
          if (lPropRec.ClassType <> nil) and lPropRec.ClassType.InheritsFrom(TPersistent) then
            lUndoableClassInfo := GetUndoableClassInfoCollection['SetPersistentProp']
          else
            lUndoableClassInfo := GetUndoableClassInfoCollection['SetProp'];
        end
      else if IsValidEmbeddedPropName(aObject, aOperation) then
        lUndoableClassInfo := GetUndoableClassInfoCollection['SetEmbeddedProp'];
    end;


  if (lUndoableClassInfo <> nil) then
    Result := lUndoableClassInfo.UndoableClass.Create(aObject, aOperation)
  else
    Result := nil;

end;

{TppUndoableClassFactory.IsValidEmbeddedPropName }

class function TppUndoableClassFactory.IsValidEmbeddedPropName(aObject: TObject; aOperation: String): Boolean;
var
  liDotPos: Integer;
  lEmbeddedObject: TObject;
  lsPropertyName: String;
  lsQualifier: String;
begin
  inherited;

  // parse operation name: Qualifier.PropName
  // example: Border.Color
  liDotPos := Pos('.', aOperation);

  lsQualifier :=  Copy(aOperation, 1, liDotPos-1);
  lsPropertyName := Copy(aOperation, liDotPos+1, Length(aOperation));

  // get the embedded object
  lEmbeddedObject := nil;
  TraRTTI.GetPropValue(aObject, lsQualifier, lEmbeddedObject);

  Result := (lEmbeddedObject <> nil) and TraRTTI.IsValidPropName(lEmbeddedObject, lsPropertyName);

end;


{TppUndoableClassFactory.GetUndoableClassInfoCollection }

class function TppUndoableClassFactory.GetUndoableClassInfoCollection: TppUndoableClassInfoCollection;
begin
  if (uUndoableClassInfoCollection = nil) then
    uUndoableClassInfoCollection := TppUndoableClassInfoCollection.Create;

  Result := uUndoableClassInfoCollection;

end;

{TppUndoableClassFactory.Register }

class procedure TppUndoableClassFactory.Register(aUndoableClassInfo: TppUndoableClassInfo);
begin
  GetUndoableClassInfoCollection.Add(aUndoableClassInfo);
end;

class procedure TppUndoableClassFactory.Register(aOperation: String; aUndoableClass: TppUndoableClass);
begin
  Register(TppUndoableClassInfo.Create(aOperation, aUndoableClass));

end;

{TppUndoableClassFactory.UnRegister }

class procedure TppUndoableClassFactory.UnRegister(aUndoableClassInfo: TppUndoableClassInfo);
begin
  GetUndoableClassInfoCollection.Remove(aUndoableClassInfo);

end;


{******************************************************************************
 *
 ** Undoable Collection
 *
{******************************************************************************}

{TppUndoableCollection.Create }

constructor TppUndoableCollection.Create;
begin
  inherited;

  InnerList.OwnsObjects := True;

end;


{TppUndoableCollection.Add }
procedure TppUndoableCollection.Add(aUndoable: TppUndoable);
begin
  InnerList.Add(aUndoable);
end;

{TppUndoableCollection.GetItemForIndex }

function TppUndoableCollection.GetItemForIndex(Index: Integer): TppUndoable;
begin
  Result := TppUndoable(InnerList[Index]);
end;

{TppUndoableCollection.Remove }

procedure TppUndoableCollection.Remove(aUndoable: TppUndoable);
begin
  InnerList.Remove(aUndoable);

end;

{******************************************************************************
 *
 ** Undoable Task
 *
{******************************************************************************}

{TppUndoableTask.Create }

constructor TppUndoableTask.Create;
begin
  inherited;

  FUndoables := TppUndoableCollection.Create;

end;

{TppUndoableTask.Destroy }

destructor TppUndoableTask.Destroy;
begin
  FUndoables.Free;
  FUndoables := nil;
  inherited;
end;

{TppUndoableTask.Execute }

procedure TppUndoableTask.Execute(aReport: TppCustomReport);
var
  liIndex: Integer;
begin
   for liIndex := 0 to FUndoables.Count-1 do
    FUndoables[liIndex].Execute(aReport);

end;

procedure TppUndoableTask.ExecuteRedo(aReport: TppCustomReport);
var
  liIndex: Integer;
begin
//  for liIndex := 0 to FUndoables.Count-1 do
  for liIndex := FUndoables.Count-1 downto 0 do
    FUndoables[liIndex].Execute(aReport);

end;



{******************************************************************************
 *
 ** Undoable Task Collection
 *
{******************************************************************************}

{TppUndoableTaskCollection.Create }

constructor TppUndoableTaskCollection.Create;
begin
  inherited;

  FCapacity := ciDefaultCapacity;

end;

destructor TppUndoableTaskCollection.Destroy;
begin

  Clear;

  inherited;

end;

{TppUndoableTaskCollection.Add }

procedure TppUndoableTaskCollection.Add(aUndoable: TppUndoableTask);
begin
  // delete first item, if capacity has been reached
  if (InnerList.Count >= FCapacity) and (InnerList.Count > 0) then
    RemoveAndFree(Items[0]);

  InnerList.Add(aUndoable);

end;

procedure TppUndoableTaskCollection.Clear;
var
  liIndex: Integer;
begin

  for liIndex := 0 to InnerList.Count-1 do
    InnerList[liIndex].Free;

  inherited;

end;

{TppUndoableTaskCollection.GetItemForIndex }

function TppUndoableTaskCollection.GetItemForIndex(Index: Integer): TppUndoableTask;
begin
  Result := TppUndoableTask(InnerList[Index]);
end;

{TppUndoableTaskCollection.Remove }

procedure TppUndoableTaskCollection.Remove(aUndoable: TppUndoableTask);
begin
  InnerList.Remove(aUndoable);

end;

{TppUndoableTaskCollection.RemoveAndFree }

procedure TppUndoableTaskCollection.RemoveAndFree(aUndoable: TppUndoableTask);
begin
  InnerList.Remove(aUndoable);
  aUndoable.Free;

end;

{TppUndoableTaskCollection.RemoveLast }

function TppUndoableTaskCollection.RemoveLast: TppUndoableTask;
begin
  if InnerList.Count > 0 then
    begin
      Result := TppUndoableTask(InnerList.Last);
      InnerList.Remove(Result);
    end
  else
    Result := nil;

end;

{TppUndoableTaskCollection.SetCapacity }

procedure TppUndoableTaskCollection.SetCapacity(const Value: Integer);
begin
  if (Value >= 0) then
    begin
      FCapacity := Value;

      while (InnerList.Count > FCapacity) do
       RemoveAndFree(Items[0]);

    end;

end;

{******************************************************************************
 *
 ** Undoable
 *
{******************************************************************************}

{TppUndoable.Create }

constructor TppUndoable.Create(aObject: TObject; aOperation: String);
begin
  inherited Create;

  FOperation := aOperation;

  Prepare(aObject);

end;

{TppUndoable.Destroy }

destructor TppUndoable.Destroy;
begin

  FSubItems.Free;
  FSubItems := nil;

  inherited;
end;

{TppUndoable.GetDescription }

function TppUndoable.GetDescription: String;
begin
  Result := ClassName;
end;

{TppUndoable.GetSubItems }

function TppUndoable.GetSubItems: TppUndoableCollection;
begin
  if (FSubItems = nil) then
    FSubItems := TppUndoableCollection.Create;

  Result := FSubItems;

end;

{TppUndoable.Prepare }

procedure TppUndoable.Prepare(aObject: TObject);
begin
  if (aObject is TComponent) then
    FComponentName := TComponent(aObject).Name;

end;


{TppUndoable.Execute }

procedure TppUndoable.Execute(aReport: TppCustomReport);
var
  lComponent: TComponent;
begin
  lComponent := aReport.Owner.FindComponent(FComponentName);

  if (lComponent <> nil) then
    begin
      UndoSubItems(aReport);
      DoOperation(lComponent);
    end;

end;

{TppUndoable.ExecuteRedo }

procedure TppUndoable.ExecuteRedo(aReport: TppCustomReport);
var
  lComponent: TComponent;
begin
  lComponent := aReport.Owner.FindComponent(FComponentName);

  if (lComponent <> nil) then
    DoOperation(lComponent);

end;


{TppUndoable.UndoSubItems }

procedure TppUndoable.UndoSubItems(aReport: TppCustomReport);
var
  liIndex: Integer;
begin

  if (FSubItems <> nil) then
    for liIndex := 0 to FSubItems.Count-1 do
      FSubItems[liIndex].Execute(aReport);

end;


{******************************************************************************
 *
 ** SetBounds Undoable
 *
{******************************************************************************}

{TppSetBoundsUnDoable.Redo }

procedure TppSetBoundsUnDoable.Prepare(aObject: TObject);
var
  lComponent: TppComponent;
begin

  inherited;

  lComponent := TppComponent(aObject);

  FBoundsRect.Left   := lComponent.mmLeft;
  FBoundsRect.Top    := lComponent.mmTop;
  FBoundsRect.Width  := lComponent.mmWidth;
  FBoundsRect.Height := lComponent.mmHeight;

end;

procedure TppSetBoundsUnDoable.DoOperation(aObject: TObject);
var
  lComponent: TppComponent;
  lBoundsRect: TppSizeRect;
begin

  lComponent := TppComponent(aObject);

  {initialize to support the redo}
  lBoundsRect.Left   := lComponent.mmLeft;
  lBoundsRect.Top    := lComponent.mmTop;
  lBoundsRect.Width  := lComponent.mmWidth;
  lBoundsRect.Height := lComponent.mmHeight;

  lComponent.mmSetBounds(BoundsRect.Left, BoundsRect.Top, BoundsRect.Width, BoundsRect.Height);

  FBoundsRect := lBoundsRect;

end;


function TppMoveUnDoable.GetDescription: String;
begin
  Result := 'Move Object';
end;

function TppResizeUnDoable.GetDescription: String;
begin
  Result := 'Resize Object';
end;

{******************************************************************************
 *
 *  Undo Manager
 *
{******************************************************************************}

{TppUndoManager.Create }

constructor TppUndoManager.Create;
begin
  inherited Create;

  FUndoableTasks := TppUndoableTaskCollection.Create;
  FRedoableTasks := TppUndoableTaskCollection.Create;

end;

{TppUndoManager.Destroy }

destructor TppUndoManager.Destroy;
begin
  Clear;

  FUndoableTasks.Free;
  FRedoableTasks.Free;

  inherited;

end;

{TppUndoManager.Clear }

procedure TppUndoManager.Clear;
begin

  if not Active then Exit;
  
  FBusy := False;
  FUndoableTasks.Clear;
  FRedoableTasks.Clear;
  FEndOperation := 0;
  FEndTask := 0;
  FCurrentOperation.Free;
  FCurrentOperation := nil;
  FCurrentTask.Free;
  FCurrentTask := nil;

end;

{TppUndoManager.BeginTask }

function TppUndoManager.BeginTask: TppUndoableTask;
begin

  if Active and not(Busy) then
    begin
      Inc(FEndTask);
      if (FCurrentTask = nil) then
        FCurrentTask := TppUndoableTask.Create;
      Result := FCurrentTask;
    end
  else
    Result := nil;

end;

{TppUndoManager.EndTask }

procedure TppUndoManager.EndTask;
begin

  if (FEndTask = 0) or Busy then Exit;

  Dec(FEndTask);

  if (FEndTask = 0) and (FCurrentTask <> nil) then
    begin
      if (FCurrentTask.Items.Count > 0) then
        FUndoableTasks.Add(FCurrentTask)
      else
        FCurrentTask.Free;
      FCurrentTask := nil;
    end;

end;

procedure TppUndoManager.AddOperation(aOperation: String; aObject: TObject);
begin

  BeginOperation(aOperation, aObject);
  EndOperation;

end;


procedure TppUndoManager.BeginOperation(aOperation: String; aObject: TObject);
var
  lOperation: TppUndoable;
begin
  if not(Active) or Busy then Exit;

  Inc(FEndOperation);

  lOperation := TppUndoableClassFactory.CreateInstance(aOperation, aObject);

  if (lOperation <> nil) then
    begin
      if (FCurrentOperation = nil) then
        FCurrentOperation := lOperation
      else
        FCurrentOperation.SubItems.Add(lOperation);
    end;
    
  if (FCurrentOperation <> nil) then
    FBusy := True;

end;

procedure TppUndoManager.EndOperation;
begin
  if (FEndOperation = 0) then Exit;

  Dec(FEndOperation);

  if (FEndOperation = 0) and (FCurrentOperation <> nil) then
    begin
      AddUndoable(FCurrentOperation);
      FCurrentOperation := nil;
    end;

  FBusy := False;

end;

{TppUndoManager.AddUndoable }

procedure TppUndoManager.AddUndoable(aUndoable: TppUndoable);
var
  lUndoableTask: TppUndoableTask;
begin

  FRedoableTasks.Clear;

  if (FCurrentTask <> nil) then
    lUndoableTask := FCurrentTask
  else
    begin
      lUndoableTask := TppUndoableTask.Create;
      FUndoableTasks.Add(lUndoableTask);
    end;

  lUndoableTask.Items.Add(aUndoable);

end;

{TppUndoManager.PerformRedo }

procedure TppUndoManager.PerformRedo(aReport: TppCustomReport);
var
  lUndoableTask: TppUndoableTask;
begin
  if not(Active) or Busy then Exit;

  if (FRedoableTasks.Count = 0) then Exit;

  FActive := False;

  try
    lUndoableTask := FRedoableTasks.RemoveLast;

    lUndoableTask.ExecuteRedo(aReport);

    FUndoableTasks.Add(lUndoableTask);

  finally
    FActive := True;

  end;

end;

{TppUndoManager.PerformUndo }

procedure TppUndoManager.PerformUndo(aReport: TppCustomReport);
var
  lUndoableTask: TppUndoableTask;
begin
  if not(Active) or Busy then Exit;

  if (FUndoableTasks.Count = 0) then Exit;

  FActive := False;

  try
    lUndoableTask := FUndoableTasks.RemoveLast;

    lUndoableTask.Execute(aReport);

    FRedoableTasks.Add(lUndoableTask);

  finally
    FActive := True;

  end;

end;



{TppUndoManager.GetRedoableCount }

function TppUndoManager.GetRedoableCount: Integer;
begin
  Result := FRedoableTasks.Count;

end;

{TppUndoManager.GetUndoableCount }

function TppUndoManager.GetUndoableCount: Integer;
begin
  Result := FUndoableTasks.Count;

end;

{TppUndoManager.GetCapacity }

function TppUndoManager.GetCapacity: Integer;
begin
  Result := FUndoableTasks.Capacity;

end;

{TppUndoManager.SetCapacity }

procedure TppUndoManager.SetCapacity(const Value: Integer);
begin
  FUndoableTasks.Capacity := Value;
  FRedoableTasks.Capacity := Value;

end;

{******************************************************************************
 *
 *  Component Instance Undoable
 *
{******************************************************************************}


{ TppComponentInstanceUndoable }

destructor TppComponentInstanceUndoable.Destroy;
begin

  FObjectStream.Free;
  FObjectStream := nil;

  inherited;
end;

procedure TppComponentInstanceUndoable.Prepare(aObject: TObject);
begin

  inherited;

  if (aObject is TppComponent) and (TppComponent(aObject).Region <> nil) then
    FRegionName := TppComponent(TppComponent(aObject)).Region.Name
  else
    FRegionName := '';

  if (aObject is TppBand) and (TppBand(aObject).Report <> nil) then
    FReportName := TppBand(aObject).Report.Name
  else  if (aObject is TppGroup) and (TppGroup(aObject).Report <> nil) then
    FReportName := TppGroup(aObject).Report.Name
  else
    FReportName := '';

end;



procedure TppComponentInstanceUndoable.Execute(aReport: TppCustomReport);
var
  lComponent: TComponent;
begin
  lComponent := aReport.Owner.FindComponent(FComponentName);

  if (lComponent <> nil) then
    begin
      // prepare for redo
      ObjectToStream(lComponent);

      // free the object to undo the creation
      lComponent.Free;

    end
  else
    begin
      // perform the redo by loading the component from stream
      ObjectFromStream(aReport);

    end;

end;


procedure TppComponentInstanceUndoable.ExecuteRedo(aReport: TppCustomReport);
var
  lComponent: TComponent;
begin
  lComponent := aReport.Owner.FindComponent(FComponentName);

  if (lComponent <> nil) then
    begin
      // prepare for redo
      ObjectToStream(lComponent);

      // free the object to undo the creation
      lComponent.Free;

    end
  else
    begin
      // perform the redo by loading the component from stream
      ObjectFromStream(aReport);

    end;


end;

procedure TppComponentInstanceUndoable.ObjectToStream(aComponent: TComponent);
var
 lWriter: TWriter;
begin

  FObjectStream := TMemoryStream.Create;

  lWriter := TWriter.Create(FObjectStream, 1024);

  if (aComponent is TppCommunicator) then
    TppCommunicator(aComponent).DSInclude([pppcCopying]);

  try
    lWriter.Root := aComponent.Owner;
    lWriter.WriteSignature;
    lWriter.WriteComponent(aComponent);
    lWriter.WriteListEnd;

  finally
    if (aComponent is TppComponent) then
      TppCommunicator(aComponent).DSExclude([pppcCopying]);

    lWriter.Free;

  end;

end;

procedure TppComponentInstanceUndoable.ObjectFromStream(aReport: TppCustomReport);
var
  lReader: TReader;

begin

  if (FObjectStream = nil) then Exit;

  FObjectStream.Position := 0;
  FPipelineList := TppDataPipelineList.Create(aReport);
  FReport := aReport;

  lReader := TReader.Create(FObjectStream, 1024);

  try

    lReader.OnSetName    := ReaderOnSetName;
    lReader.OnFindMethod := ReaderOnFindMethod;

    lReader.ReadComponents(aReport.Owner, nil, ComponentReadCallback);
  finally
    lReader.Free;
    FPipelineList.Free;
    FPipelineList := nil;
    FReport := nil;
  end;

end;

procedure TppComponentInstanceUndoable.ReaderOnSetName(Reader: TReader; Component: TComponent; var Name: string);
begin

  if (Component is TppCommunicator) then
    TppCommunicator(Component).DSInclude([pppcPasting]);

end;

procedure TppComponentInstanceUndoable.ReaderOnFindMethod(Reader: TReader; const MethodName: string;
                                var Address: Pointer; var Error: Boolean);
begin
  {if method not found, don't raise an exception}
  Error := False;

end;


procedure TppComponentInstanceUndoable.ComponentReadCallback(Component: TComponent);
var
  lComponent : TppComponent;
  lBand: TppBand;
  lGroup: TppGroup;
begin

  if (Component is TppComponent) then
    begin
      lComponent := TppComponent(Component);
      lComponent.Band := TppBand(FReport.GetBand(lComponent.BandType, lComponent.GroupNo));

      if lComponent.IsDataAware then
        lComponent.ResolvePipelineReferences(FPipelineList);

      if (FRegionName <> '') then
        lComponent.Region := TppRegion(FReport.Owner.FindComponent(FRegionName));

    end
  else if (Component is TppBand) then
    begin
      lBand := TppBand(Component);
      
      if (FReportName <> '') then
        lBand.Report := TppCustomReport(FReport.Owner.FindComponent(FReportName))
      else
        lBand.Report := FReport;

      lBand.SendDesignMessage(RM_BANDADDED, ppWCustomMsg, lBand);
    end
  else if (Component is TppGroup) then
    begin
      lGroup := TppGroup(Component);
      if (FReportName <> '') then
        lGroup.Report := TppCustomReport(FReport.Owner.FindComponent(FReportName))
      else
        lGroup.Report := FReport;

      lGroup.HeaderBand.SendDesignMessage(RM_BANDADDED, ppWCustomMsg, lGroup.HeaderBand);

    end;
end;


{******************************************************************************
 *
 *  Component Destroy Undoable
 *
{******************************************************************************}

{ TppComponentDestroyUndoable }

constructor TppComponentDestroyUndoable.Create(aObject: TObject; aOperation: String);
begin
  inherited;

  ObjectToStream(TComponent(aObject));


end;

{******************************************************************************
 *
 *  Set Prop Undoable
 *
{******************************************************************************}

procedure TppSetPropUndoable.DoOperation(aObject: TObject);
var
  lComponent: TComponent;
  lsPropValueAsString: String;
begin

  lComponent := TComponent(aObject);

  lsPropValueAsString := TraRTTI.GetPropValueAsString(lComponent, FPropertyName);

  TraRTTI.SetPropValueFromString(lComponent, FPropertyName, FPropValueAsString);

  FPropValueAsString := lsPropValueAsString;

end;

procedure TppSetPropUndoable.Prepare(aObject: TObject);
begin
  inherited;

  FPropertyName := Operation;
  FPropValueAsString := TraRTTI.GetPropValueAsString(aObject, FPropertyName);

end;

{******************************************************************************
 *
 *  Set Embedded Object Prop Undoable
 *
{******************************************************************************}

procedure TppSetEmbeddedPropUndoable.DoOperation(aObject: TObject);
var
  lEmbeddedObject: TObject;
  lsPropValueAsString: String;
begin

  // get the embedded object
  TraRTTI.GetPropValue(aObject, Qualifier, lEmbeddedObject);

  if (lEmbeddedObject <> nil) then
    begin
      lsPropValueAsString := TraRTTI.GetPropValueAsString(lEmbeddedObject, PropertyName);

      TraRTTI.SetPropValueFromString(lEmbeddedObject, PropertyName, PropValueAsString);

      PropValueAsString := lsPropValueAsString;
    end;

end;

procedure TppSetEmbeddedPropUndoable.Prepare(aObject: TObject);
var
  liDotPos: Integer;
  lEmbeddedObject: TObject;
begin
  inherited;

  // parse operation name: Qualifier.PropName
  // example: Border.Color
  liDotPos := Pos('.', Operation);

  Qualifier :=  Copy(Operation, 1, liDotPos-1);
  PropertyName := Copy(Operation, liDotPos+1, Length(Operation));

  // get the embedded object
  TraRTTI.GetPropValue(aObject, Qualifier, lEmbeddedObject);

  // get the property value
  if (lEmbeddedObject <> nil) then
    PropValueAsString := TraRTTI.GetPropValueAsString(lEmbeddedObject, PropertyName);

end;


{******************************************************************************
 *
 *  Set Font Undoable
 *
{******************************************************************************}


{ TppSetFontUndoable }

destructor TppSetFontUndoable.Destroy;
begin
  FPropValue.Free;

  inherited;
end;

procedure TppSetFontUndoable.DoOperation(aObject: TObject);
var
  lComponent: TComponent;
  lPropValue: TFont;
begin
  lComponent := TComponent(aObject);

  TraRTTI.GetPropValue(lComponent, FPropertyName, lPropValue);

  TraRTTI.SetPropValue(lComponent, FPropertyName, FPropValue);

  FPropValue.Assign(lPropValue);

end;

procedure TppSetFontUndoable.Prepare(aObject: TObject);
var
  lPropValue: TFont;
begin

  inherited;

  FPropValue := TppFont.Create;
  FPropertyName := Operation;

  if TraRTTI.GetPropValue(aObject, FPropertyName, lPropValue) then
    FPropValue.Assign(lPropValue);

end;

{******************************************************************************
 *
 *  Set Font Size Undoable
 *
{******************************************************************************}

{ TppSetFontSizeUndoable }

procedure TppSetFontSizeUndoable.DoOperation(aObject: TObject);
var
  lComponent: TComponent;
  lPropValue: Integer;
begin
  lComponent := TComponent(aObject);

  lPropValue := TppComponent(lComponent).Font.Size;

  TppComponent(lComponent).Font.Size := FPropValue;

  FPropValue := lPropValue;

end;

procedure TppSetFontSizeUndoable.Prepare(aObject: TObject);
begin

  inherited;

  FPropertyName := Operation;

  FPropValue := TppComponent(aObject).Font.Size;

end;

{******************************************************************************
 *
 *  Set Font Color Undoable
 *
{******************************************************************************}

{ TppSetFontColorUndoable }


procedure TppSetFontColorUndoable.DoOperation(aObject: TObject);
var
  lComponent: TComponent;
  lPropValue: Integer;
begin
  lComponent := TComponent(aObject);

  lPropValue := TppComponent(lComponent).Font.Color;

  TppComponent(lComponent).Font.Color := FPropValue;

  FPropValue := lPropValue;

end;

procedure TppSetFontColorUndoable.Prepare(aObject: TObject);
begin
  inherited;

  FPropertyName := Operation;

  FPropValue := TppComponent(aObject).Font.Color;

end;


{******************************************************************************
 *
 *  Set Font Size Undoable
 *
{******************************************************************************}

procedure TppSetFontStyleUndoable.DoOperation(aObject: TObject);
var
  lComponent: TComponent;
  lPropValue: TFontStyles;
begin

  lComponent := TComponent(aObject);

  lPropValue := TppComponent(lComponent).Font.Style;

  TppComponent(lComponent).Font.Style := FPropValue;

  FPropValue := lPropValue;

end;

procedure TppSetFontStyleUndoable.Prepare(aObject: TObject);
begin
  inherited;

  FPropertyName := Operation;

  FPropValue := TppComponent(aObject).Font.Style;

end;


{******************************************************************************
 *
 *  Set Pen Style Undoable
 *
{******************************************************************************}

{ TppSetPenStyleUndoable }


procedure TppSetPenStyleUndoable.DoOperation(aObject: TObject);
var
  lComponent: TComponent;
  lPen: TPen;
  lPropValue: TPenStyle;
begin
  lComponent := TComponent(aObject);

  TraRTTI.GetPropValue(lComponent, 'Pen', lPen);

  lPropValue := lPen.Style;

  lPen.Style := FPropValue;

  FPropValue := lPropValue;

end;

procedure TppSetPenStyleUndoable.Prepare(aObject: TObject);
var
  lPen: TPen;
begin

  inherited;

  FPropertyName := Operation;

  TraRTTI.GetPropValue(aObject, 'Pen', lPen);

  FPropValue := lPen.Style;

end;

{******************************************************************************
 *
 *  Set Brush Style Undoable
 *
{******************************************************************************}

{ TppSetBrushStyleUndoable }

procedure TppSetBrushStyleUndoable.DoOperation(aObject: TObject);
var
  lComponent: TComponent;
  lBrush: TBrush;
  lPropValue: TBrushStyle;
begin
  lComponent := TComponent(aObject);

  TraRTTI.GetPropValue(lComponent, 'Brush', lBrush);

  lPropValue := lBrush.Style;

  lBrush.Style := FPropValue;

  FPropValue := lPropValue;


end;

procedure TppSetBrushStyleUndoable.Prepare(aObject: TObject);
var
  lBrush: TBrush;
begin

  inherited;

  FPropertyName := Operation;

  TraRTTI.GetPropValue(aObject, 'Brush', lBrush);

  FPropValue := lBrush.Style;


end;

{******************************************************************************
 *
 *  Set Pen Color Undoable
 *
{******************************************************************************}

{ TppSetPenColorUndoable }

procedure TppSetPenColorUndoable.DoOperation(aObject: TObject);
var
  lComponent: TComponent;
  lPen: TPen;
  lPropValue: TColor;
begin

  lComponent := TComponent(aObject);

  TraRTTI.GetPropValue(lComponent, 'Pen', lPen);

  lPropValue := lPen.Color;

  lPen.Color := FPropValue;

  FPropValue := lPropValue;

end;

procedure TppSetPenColorUndoable.Prepare(aObject: TObject);
var
  lPen: TPen;
begin

  inherited;

  FPropertyName := Operation;

  TraRTTI.GetPropValue(aObject, 'Pen', lPen);

  FPropValue := lPen.Color;

end;

{******************************************************************************
 *
 *  Set Brush Color Undoable
 *
{******************************************************************************}

{ TppSetBrushColorUndoable }

procedure TppSetBrushColorUndoable.DoOperation(aObject: TObject);
var
  lComponent: TComponent;
  lBrush: TBrush;
  lPropValue: TColor;
begin

  lComponent := TComponent(aObject);

  TraRTTI.GetPropValue(lComponent, 'Brush', lBrush);

  lPropValue := lBrush.Color;

  lBrush.Color := FPropValue;

  FPropValue := lPropValue;

end;

procedure TppSetBrushColorUndoable.Prepare(aObject: TObject);
var
  lBrush: TBrush;
begin

  inherited;

  FPropertyName := Operation;

  TraRTTI.GetPropValue(aObject, 'Brush', lBrush);

  FPropValue := lBrush.Color;

end;

{******************************************************************************
 *
 *  Set Persistent Prop Undoable
 *
{******************************************************************************}

destructor TppSetPersistentPropUndoable.Destroy;
begin
  FPropValue.Free;
  FPropValue := nil;
  
  inherited;
end;

{ TppSetPersistentPropUndoable }

procedure TppSetPersistentPropUndoable.DoOperation(aObject: TObject);
var
  lComponent: TComponent;
  lPropValue: TPersistent;
  lTemp: TPersistent;
begin
  lComponent := TComponent(aObject);

  TraRTTI.GetPropValue(lComponent, FPropertyName, lPropValue);

  if (lPropValue <> nil) then
    begin
      lTemp := TPersistent(FPropValue.ClassType.Create);

      try
        lTemp.Assign(lPropValue);

        TraRTTI.SetPropValue(lComponent, FPropertyName, FPropValue);

        FPropValue.Assign(lTemp);
      finally
        lTemp.Free;
      end;
      
   end;


end;

procedure TppSetPersistentPropUndoable.Prepare(aObject: TObject);
var
  lPropValue: TPersistent;
begin
  inherited;

  FPropertyName := Operation;
  TraRTTI.GetPropValue(aObject, FPropertyName, lPropValue);

  if (lPropValue <> nil) then
    begin
      FPropValue := TPersistent(lPropValue.ClassType.Create);
      FPropValue.Assign(lPropValue);

    end;

end;

{******************************************************************************
 *
 *  Set Band Undoable
 *
{******************************************************************************}

{ TppSetBandUndoable }

procedure TppSetBandUndoable.DoOperation(aObject: TObject);
var
  lComponent: TppComponent;
  lBand: TppBand;
begin

  lComponent := TppComponent(aObject);

  lBand := lComponent.Band;

  lComponent.Band := TppBand(lComponent.Owner.FindComponent(FBandName));

  {initialize to support the redo}
  if (lBand <> nil) then
    FBandName := lBand.Name
  else
    FBandName := '';

end;

procedure TppSetBandUndoable.Prepare(aObject: TObject);
var
  lComponent: TppComponent;
begin

  inherited;

  lComponent := TppComponent(aObject);

  if (lComponent.Band <> nil) then
    FBandName := lComponent.Band.Name
  else
    FBandName := '';

end;


{******************************************************************************
 *
 *  Set DataPipeline Undoable
 *
{******************************************************************************}

{ TppSetDataPipelineUndoable }

procedure TppSetDataPipelineUndoable.DoOperation(aObject: TObject);
var
  lComponent: TppComponent;
  lsDataPipelineName: String;
  lPipelineList: TppDataPipelineList;
begin

  lComponent := TppComponent(aObject);

  if (lComponent.DataPipeline <> nil) then
    lsDataPipelineName := lComponent.DataPipeline.Name
  else
    lsDataPipelineName := '';

  lPipelineList := TppDataPipelineList.Create(lComponent.Report);

  lComponent.DataPipeline :=  lPipelineList.GetPipelineForComponentName(FDataPipelineName);

  lPipelineList.Free;


  {initialize to support the redo}
  FDataPipelineName := lsDataPipelineName;


end;

procedure TppSetDataPipelineUndoable.Prepare(aObject: TObject);
var
  lComponent: TppComponent;
begin

  inherited;

  lComponent := TppComponent(aObject);

  if (lComponent.DataPipeline <> nil) then
    FDataPipelineName := lComponent.DataPipeline.Name
  else
    FDataPipelineName := '';


end;


{******************************************************************************
 *
 *  Set Region Undoable
 *
{******************************************************************************}

procedure TppSetRegionUndoable.DoOperation(aObject: TObject);
var
  lComponent: TppComponent;
  lRegion: TComponent;
begin

  lComponent := TppComponent(aObject);

  lRegion := lComponent.Region;

  lComponent.Region := TppComponent(lComponent.Owner.FindComponent(FRegionName));

  {initialize to support the redo}
  if (lRegion <> nil) then
    FRegionName := lRegion.Name
  else
    FRegionName := '';


end;

procedure TppSetRegionUndoable.Prepare(aObject: TObject);
var
  lComponent: TppComponent;
begin

  inherited;

  lComponent := TppComponent(aObject);

  if (lComponent.Region <> nil) then
    FRegionName := lComponent.Region.Name
  else
    FRegionName := '';

end;

{******************************************************************************
 *
 *  Set Anchors Undoable
 *
{******************************************************************************}

{ TppSetAnchorsUndoable }

procedure TppSetAnchorsUndoable.DoOperation(aObject: TObject);
var
  lComponent: TppComponent;
  lPropValue: TppAnchors;
begin

  lComponent := TppComponent(aObject);

  lPropValue := lComponent.Anchors;

  lComponent.Anchors := FPropValue;

  FPropValue := lPropValue;

end;

procedure TppSetAnchorsUndoable.Prepare(aObject: TObject);
var
  lComponent: TppComponent;
begin
  inherited;

  lComponent := TppComponent(aObject);

  if (lComponent is TppComponent) then
    FPropValue := TppComponent(lComponent).Anchors
  else
    FPropValue := [];


end;


{******************************************************************************
 *
 *  Set BorderPositions Undoable
 *
{******************************************************************************}

{ TppSetBorderPositionsUndoable }

procedure TppSetBorderPositionsUndoable.DoOperation(aObject: TObject);
var
  lComponent: TppComponent;
  lBorder: TppBorder;
  lPropValue: TppBorderPositions;
begin

  lComponent := TppComponent(aObject);

  TraRTTI.GetPropValue(lComponent, 'Border', lBorder);

  lPropValue := lBorder.BorderPositions;

  lBorder.BorderPositions := FPropValue;

  FPropValue := lPropValue;


end;

procedure TppSetBorderPositionsUndoable.Prepare(aObject: TObject);
var
  lComponent: TppComponent;
  lBorder: TppBorder;
begin

  inherited;

  lComponent := TppComponent(aObject);

  TraRTTI.GetPropValue(lComponent, 'Border', lBorder);

  FPropValue := lBorder.BorderPositions

end;

{******************************************************************************
 *
 *  ZOrder Undoable
 *
{******************************************************************************}

{ TppZOrderUnDoable }

procedure TppZOrderUnDoable.DoOperation(aObject: TObject);
var
  lComponent: TppComponent;
begin

  lComponent := TppComponent(aObject);

  lComponent.Index := FZIndex;

end;

procedure TppZOrderUnDoable.Prepare(aObject: TObject);
begin
  inherited;

  FZIndex := TppComponent(aObject).Index;

end;





initialization
  RegisterClasses([TStrings, TStringList]);
  TppUndoableClassFactory.Register('SetProp', TppSetPropUndoable);
  TppUndoableClassFactory.Register('SetPersistentProp', TppSetPersistentPropUndoable);
  TppUndoableClassFactory.Register('SetEmbeddedProp', TppSetEmbeddedPropUndoable);
//  TppUndoableClassFactory.Register('Lines', TppSetPersistentPropUndoable);
  TppUndoableClassFactory.Register('MoveBounds', TppMoveUndoable);
  TppUndoableClassFactory.Register('ResizeBounds', TppResizeUndoable);
  TppUndoableClassFactory.Register('CreateComponent', TppComponentInstanceUndoable);
  TppUndoableClassFactory.Register('DestroyComponent', TppComponentDestroyUndoable);
  TppUndoableClassFactory.Register('PasteComponent', TppComponentInstanceUndoable);
  TppUndoableClassFactory.Register('CutComponent', TppComponentDestroyUndoable);
  TppUndoableClassFactory.Register('DataPipeline', TppSetDataPipelineUndoable);
  TppUndoableClassFactory.Register('Band', TppSetBandUndoable);
  TppUndoableClassFactory.Register('Region', TppSetRegionUndoable);
  TppUndoableClassFactory.Register('CreateBand', TppComponentInstanceUndoable);
  TppUndoableClassFactory.Register('DestroyBand', TppComponentDestroyUndoable);
  TppUndoableClassFactory.Register('CreateGroup', TppComponentInstanceUndoable);
  TppUndoableClassFactory.Register('DestroyGroup', TppComponentInstanceUndoable);
  TppUndoableClassFactory.Register('Font', TppSetFontUndoable);
  TppUndoableClassFactory.Register('Font.Size', TppSetFontSizeUndoable);
  TppUndoableClassFactory.Register('Font.Style', TppSetFontStyleUndoable);
  TppUndoableClassFactory.Register('Font.Color', TppSetFontColorUndoable);
  TppUndoableClassFactory.Register('Pen.Style', TppSetPenStyleUndoable);
  TppUndoableClassFactory.Register('Pen.Color', TppSetPenColorUndoable);
  TppUndoableClassFactory.Register('Brush.Style', TppSetBrushStyleUndoable);
  TppUndoableClassFactory.Register('Brush.Color', TppSetBrushColorUndoable);
  TppUndoableClassFactory.Register('Anchors', TppSetAnchorsUndoable);
  TppUndoableClassFactory.Register('Border.Positions', TppSetBorderPositionsUndoable);
  TppUndoableClassFactory.Register('Border.Color', TppSetEmbeddedPropUndoable);
  TppUndoableClassFactory.Register('BringToFront', TppZOrderUnDoable);
  TppUndoableClassFactory.Register('SendToBack', TppZOrderUnDoable);
  TppUndoableClassFactory.Register('BringForward', TppZOrderUnDoable);
  TppUndoableClassFactory.Register('Sendbackward', TppZOrderUnDoable);


finalization
  uUndoableClassInfoCollection.Free;
  uUndoableClassInfoCollection := nil;

end.
