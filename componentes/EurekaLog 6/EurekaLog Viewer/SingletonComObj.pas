unit SingletonComObj;

interface

uses ComObj, ActiveX;

type
  TSingletonFactory = class(TAutoObjectFactory)
  private
    FObject: TComObject;
  public
    constructor Create(ComServer: TComServerObject; AutoClass: TAutoClass;
      const ClassID: TGUID; Instancing: TClassInstancing; ThreadingModel: TThreadingModel);
    procedure ClearGlobalObjectRef; virtual;
    function CreateComObject(const Controller: IUnknown): TComObject; override;
  end;

  TSingletonAutoObject = class(TAutoObject)
  private
    FSAutoFactory: TSingletonFactory;
  public
    destructor Destroy; override;
    procedure Initialize; override;
  end;

implementation

{ TSingletonFactory }

constructor TSingletonFactory.Create(ComServer: TComServerObject; AutoClass: TAutoClass;
  const ClassID: TGUID; Instancing: TClassInstancing; ThreadingModel: TThreadingModel);
begin
  inherited;
  ClearGlobalObjectRef;
end;

procedure TSingletonFactory.ClearGlobalObjectRef;
begin
  FObject := nil;
end;

function TSingletonFactory.CreateComObject(const Controller: IUnknown): TComObject;
begin
  if (Controller = nil) then
  begin
    if (FObject = nil) then
      FObject := (inherited CreateComObject(Controller));
    Result := FObject;
  end
  // Aggregations are not supported...
  else Result := nil;
end;

{ TSingletonAutoObject }

destructor TSingletonAutoObject.Destroy;
begin
  FSAutoFactory.ClearGlobalObjectRef;
  inherited;
end;

procedure TSingletonAutoObject.Initialize;
begin
  inherited;
  FSAutoFactory := (AutoFactory as TSingletonFactory);
end;

end.
