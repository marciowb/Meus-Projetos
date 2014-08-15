{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit ppComm;

interface

{$I ppIfDef.pas}

uses

{$IFDEF Delphi5}
  contnrs,
{$ENDIF}
  Classes, SysUtils, Forms, TypInfo, ppDsIntf, ppTypes, ppUtils,
  Windows, Dialogs,
  ppRTTI;

type

  TppCommunicator = class;
  TppCommunicatorClass = class of TppCommunicator;

  TppNotifyEvent = procedure (Sender: TObject; aCommunicator: TppCommunicator; aOperation: TppOperationType) of object;
  TppEventNotifyEvent = procedure (Sender: TObject; aCommunicator: TppCommunicator; aEventID: Integer; aParams: TraParamList) of object;


  {@TppCommunicator

    TppCommunicator is an abstract ancestor class that enables components to
    participate in notification relationships.  When one objects needs to
    reference another, a simple notification can be established via AddNotify.
    If either object is destroyed, then the Notify method of the other object
    will be called, with ppopRemove passed as the operation.  When one object
    needs to be notified of a specific change in state of another object (and
    any possible values associated with that change) the relationship should
    be established with AddEventNotify. The notifying object will then call
    the EventNotify method of the listening object when the requested state
    change occurs.}

  {@TppCommunicator.ComponentDesigner

    The component designer manages the form displayed when the user double-
    clicks the component at Delphi design-time.}

  {@TppCommunicator.DesignState

    This property indicates the state of the component as designated by the
    Report Designer. This property is valid when the component is being
    designed in the Delphi IDE or in the Report Designer at run-time.  The
    possible values are:

    <Table>
    Value	                 Meaning
    ------------------     --------
    pppcDesigning	         The report is attached to a Report Designer
                           component.
    pppcDesignPreviewing   The report is being previewed in the Report
                           Designer.
    pppcDesignPrinting	   The report is being printed from within the
                           Report Designer.
    pppcDisplayData	       Whether or not the user has the View | Show Data menu
                           option turned on.
    pppcCopying	           The component is being copied to the clipboard.
    pppcPasting	           The component is being pasted from the clipboard.
    pppcLoading	           The component is being loaded - corresponds with the
                           standard Delphi Loaded procedure.
    pppcTemplateLoading	   The component is being loaded from a template.
    pppcTemplateSaving	   The component is being saved to a template.
    pppcUpdating	         Indicates that multiple changes are being made to the
                           report and that changes should not be communicated to
                           the Report Designer.
    pppcCreating	         The component is being created.
    pppcEmpty	             Indicates that a module is empty and should not be
                           saved down.  (Applies only to code modules and data
                           modules)
    </Table>}

  {@TppCommunicator.EventNotifies

    This property contains the events of which a communicator would like to be
    notified. Notification is established by calling the AddEventNotify routine.
    When a communicator begins notifying components of a certain event, it first
    checks this property to make sure the component has requested notifcation
    for the event type being broadcasted. If the event type is not in the
    EventNotifies property, then the communicator is not notified for that
    particular event. The possible event type values are:

    <Table>
    Value	                                  Meaning
    ------------------------------          ---------
    ciProducerAfterPrint	                  AfterPrint event of a report
    ciProducerBeforePrint	                  BeforePrint event of a report
    ciProducerCancel	                      OnCancel event of a report
    ciProducerCancelDialogCreate            OnCancelDialogCreate event of a
                                            report
    ciProducerCancelDialogClose	            OnCancelDialogClose event of a
                                            report
    ciProducerPreviewFormCreate	            OnPreviewFormCreate event of a
                                            report
    ciProducerPreviewFormClose	            OnPreviewFormClose event of a report
    ciProducerPrintDialogCreate	            OnPrintDialogCreate event of a
                                            report
    ciProducerPrintDialogClose	            OnPrintDialogClose event of a report
    ciProducerSaveText	                    OnSaveText event of a report
    ciEngineStart	                          OnEngineStart event of a report
                                            engine
    ciEngineEnd	                            OnEngineEnd event of a report engine
    ciEngineEndColumn	                      OnEndColumn event of a report
    ciEngineEndFirstPass	                  OnEndFirstPass event of a report
    ciEngineEndPage	                        OnEndPage event of a report
    ciEngineEndSecondPass	                  OnEndSecondPass event of a report
    ciEngineStartColumn	                    OnStartColumn event of a report
    ciEngineStartFirstPass	                OnStartFirstPass event of a report
    ciEngineStartPage	                      OnStartPage event of a report
    ciEngineStartSecondPass	                OnStartSecondPass event of a report
    ciBandAfterPrint	                      AfterPrint event of a band
    ciBandBeforePrint	                      BeforePrint event of a band
    ciBandAfterGenerate	                    AfterGenerate event of a band
    ciBandBeforeGenerate	                  BeforeGenerate event of a band
    ciGroupAfterGroupBreak	                AfterGroupBreak event of a group
    ciGroupBeforeGroupBreak	                BeforeGroupBreak event of a group
    ciGroupGetBreakValue	                  OnGetBreakValue event of a group
    ciComponentPrint	                      OnPrint event of a component
    ciComponentCalc	                        OnCalc event of a TppVariable
                                            component
    ciComponentReset	                      OnReset event of a TppVariable
                                            component
    ciTraversal	                            Called each time the engine makes a
                                            traversal
    ciRecordPositionChange	                OnRecordPositionChange event of a
                                            data
                                            pipeline
    ciPipelineMasterRecordPositionChange    OnMasterRecordPositionChange
                                            event of a detail data pipeline
    ciPipelineGotoBookmark	                OnGotoBookmark event of a data
                                            pipeline
    ciPipelineDataChange	                  OnDataChange event of a data
                                            pipeline
    ciPipelineFirst	                        OnFirst event of a data pipeline
    ciPipelineNext	                        OnNext event of a data pipeline
    ciPipelinePrior	                        OnPrior event of a data pipeline
    ciPipelineLast	                        OnLast event of a data pipeline
    ciPipelineOpen	                        OnOpen event of a data pipeline
    ciPipelineClose	                        OnClose event of a data pipeline
    ciPipelineTraversal	                    OnTraversal event of a data pipeline
    ciCacheableSwitchCache	                Called when a cacheable component
                                            needs to switch to disk based
                                            caching
    ciCacheableRaiseException	              Called when a cachable component has
                                            attempted to switch to disk based
                                            caching but failed
    ciCacheableFreeCache	                  Called when the cache is freed.
    </Table>}

  {@TppCommunicator.FormDesigner

    Points to a wrapper class for the Delphi IDE form designer.  Resolves
    the problem of different form designer implementations in Delphi 3 and
    Delphi 4.}

  {@TppCommunicator.Name

    The Name property specifies the name of the component.  All components
    on a report must have a unique name.  When you create components at
    design-time, ReportBuilder assigns sequential names based on the name
    of the TppReport component and the type of the sub-component you are
    creating, such as 'ppReport1Label1', 'ppReport1Label2', and so on.  If
    you change the name of the Report to say, 'ppCustomerList',
    ReportBuilder will rename the associated sub-components
    'ppCustomerListLabel1', 'ppCustomerListLabel2', and so on.

    Note: Change component names only at design-time.}

  {@TppCommunicator.OnEventNotify

    Fires when the EventNotify procedure has been called.}

  {@TppCommunicator.OnNotify

    Fires when the Notify procedure has been called.}

  {@TppCommunicator.Owner

    Indicates the component that is responsible for freeing this component.
    Use Owner to find the owner of a component. When one component owns
    another, the memory for the owned component is freed when its owner's
    memory is freed. This means that when a form is destroyed, all the
    components on the form are also destroyed.

    By default, a form owns all components that are on it. In turn, the
    form is owned by the application. Thus when the application shuts down
    and its memory is freed, the memory for all forms (and all their owned
    components) is also freed.

    The owner of a component is determined by the parameter passed to the
    constructor when the component is created. For components created in
    the form designer, the form is automatically assigned as the owner.}

  {@TppCommunicator.Tag

    The Tag property is available to store an integer value as part of a
    component.

    The Tag property is not used by ReportBuilder, but has been provided so
    that your application can store a value in a report component when
    necessary.}

  {@TppCommunicator.UserName

    For all of report components within a report, the username is unique.
    For DataPipeline and DataDictionary components the user name is unique
    within the owning form. The UserName must be a valid Pascal identifier; it
    cannot contain spaces.  The purpose of the UserName is to display
    a more user friendly name for the components in the Report Designer and
    within the RAP language.  The standard Delphi Name property could not
    be used because it must be unique at the form level, whereas the
    UserName need only be unique at the report level. (i.e. you can have
    two reports on a form, each containing a label with the UserName
    'ReportTitle'.)}

  TppCommunicator = class(TComponent, IUnknown)
    private
      FComponentDesigner: TppComponentDesigner;
      FDesignState: TppDesignStates;
      FNotifyList: TList;
      FEventNotifyList: TList;
      FEvents: TppEvents;
      FDesignEventHub: TppCommunicator;
      FNameChangeOnLoad: Boolean;
      FUserName: TComponentName;
      FOnNotify: TppNotifyEvent;
      FOnEventNotify: TppEventNotifyEvent;

      procedure AddOrderedEventNotify(aCommunicator: TppCommunicator);
      function  GetFormDesigner: TppFormDesigner;
      function GetDesignEventHub: TppCommunicator;
      function  GetNotifyCommunicator(aIndex: Integer): TppCommunicator;
      function  GetNotifyCommunicatorCount: Integer;
      procedure SetDesignEventHub(const Value: TppCommunicator);

    protected
      function GetComponentDesigner: TppComponentDesigner; virtual;
      function  GetDefaultUserName: String; virtual;
      function  GetPropUserName: TComponentName; virtual;  {note: CBuilder will not support GetUserName }
      procedure Loaded; override;
      procedure SetComponentDesigner(aComponentDesigner: TppComponentDesigner); virtual;
      procedure DSChanged(aDesignStateSet: TppDesignStates); virtual;
      procedure SetName(const NewName: TComponentName); override;
      procedure SetUserName(const aUserName: TComponentName); virtual;
      procedure PropertyChange; virtual;

      function QueryInterface(const IID: TGUID; out Obj): HResult; override; stdcall;
      function _AddRef: Integer; stdcall;
      function _Release: Integer; stdcall;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      procedure BeforeDestruction; override;
      procedure ChangeOwner(aNewOwner: TComponent); virtual;
      function  GetValidName(aComponent: TComponent): String;  virtual;

      procedure SetParentComponent(Value: TComponent); override;

      procedure SendEventNotify(aCommunicator: TppCommunicator; aEventID: Integer; aParams: TraParamList);
      procedure SendNotify(aCommunicator: TppCommunicator; aOperation: TppOperationType);

      {design time methods}
      procedure AfterPropertyChange; virtual;
      procedure BeforePropertyChange(aPropertyName: String); virtual;
      procedure SendDesignMessage(aMsg, aWParam: Integer; aOParam: TObject); virtual;

      {communication routines}
      procedure AddNotify(aCommunicator: TppCommunicator);
      procedure Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType); virtual;
      procedure RemoveNotify(aCommunicator: TppCommunicator);

      {event communication routines}
      procedure AddEventNotify(aCommunicator: TppCommunicator);
      procedure EventNotify(aCommunicator: TppCommunicator; aEventID: Integer; aParams: TraParamList); virtual;
      function IsActiveNotify(aEventID: Integer): Boolean;
      procedure RemoveEventNotify(aCommunicator: TppCommunicator);

      {state routines}
      procedure DSExclude(aDesignStateSet: TppDesignStates); virtual;
      procedure DSInclude(aDesignStateSet: TppDesignStates); virtual;

      {user name routines}
      function  IsValidUserName(aUserName: String): Boolean; virtual;
      function  FindUserObject(aUserName: String): TppCommunicator; virtual;
      function  FindUserObjectInComponent(aUserName: String; aComponent: TComponent): TppCommunicator;
      function  GetUniqueUserName(aComponent: TComponent): String; virtual;
      function  GetParentCommunicator: TppCommunicator;

      function EventOrder: String; virtual;

      property DesignEventHub: TppCommunicator read GetDesignEventHub write SetDesignEventHub;
      property ComponentDesigner: TppComponentDesigner read GetComponentDesigner write SetComponentDesigner;
      property DesignState: TppDesignStates read FDesignState;
      property EventNotifies: TppEvents read FEvents write FEvents;
      property FormDesigner: TppFormDesigner read GetFormDesigner;
      property NameChangeOnLoad: Boolean read FNameChangeOnLoad write FNameChangeOnLoad;
      property NotifyCommunicators[Index: Integer]: TppCommunicator read GetNotifyCommunicator;
      property NotifyCommunicatorCount: Integer read GetNotifyCommunicatorCount;
      property Owner; {redeclare for docomatic}
      property UserName: TComponentName read GetPropUserName write SetUserName;

      property OnNotify: TppNotifyEvent read FOnNotify write FOnNotify;
      property OnEventNotify: TppEventNotifyEvent read FOnEventNotify write FOnEventNotify;

    published
      property Name; {redeclare for docomatic}
      property Tag;  {redeclare for docomatic}

  end; {class, TppCommunicator}


  {@TppCommunicatorPickList }
  TppCommunicatorPickList = class(TStringList)
    private
      FParent: TppCommunicator;
      FFormDesigner: TppFormDesigner;
      FComponentClass: TppCommunicatorClass;

      procedure AddComponent(aComponent: TComponent);

      procedure BuildList;
      procedure BuildListFromDataModule(aDataModule: TDataModule);

      procedure BuildListFromDesigner(aDesigner: TppFormDesigner);
      procedure BuildListFromOwner(aOwner: TComponent);

      procedure GetDataItemsCallback(const S: string);

      function GetComponentForName(aName: String): TppCommunicator;

      procedure SetParent(aParent: TppCommunicator);

    public
      constructor Create(aParent: TppCommunicator; aComponentClass: TppCommunicatorClass); virtual;

      procedure Refresh;

      property Parent: TppCommunicator read FParent write SetParent;

      property Components[aUserName: String]: TppCommunicator read GetComponentForName;

    end; {class, TppCommunicatorPickList}



{$IFDEF Delphi5}
  { TppComponentList }
  TppComponentList = class(TComponentList)
    public
      constructor Create(aOwner: TComponent); virtual;
  end;

{$ELSE}

  {@TppComponentList }
  TppComponentList = class(TComponent)
    private
      FList: TList;

      function GetItems(aIndex: Integer): TComponent;

    public

      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      procedure Notification(aComponent: TComponent; Operation: TOperation); override;

      procedure Add(aComponent: TComponent);
      procedure Delete(aIndex: Integer);
      function IndexOf(aComponent: TComponent): Integer;
      function Count: Integer;

      property Items[Index: Integer]: TComponent read GetItems; default;

    end;  {class, TppComponentList}


{$ENDIF}

  {@TraTppCommunicatorRTTI }
  TraTppCommunicatorRTTI = class(TraTComponentRTTI)
    public
      class function  GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean; override;
      class function  GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
      class function  RefClass: TClass; override;
      class function  SetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
  end; {class, TraTppCommunicatorRTTI}


implementation

uses
  ppDesignEventHub;


{******************************************************************************
 *
 ** C O M M U N I C A T O R
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{@TppCommunicator.Create

  The Create method allocates memory to create the component and initializes its
  data as needed. The owner of the created component is passed in the aOwner
  parameter.

  You seldom need to call Create. Objects designed with ReportBuilder create
  and destroy themselves as needed, so you don't have to worry about it. If you
  construct an object by calling the Create method, you should call Free to
  release memory and dispose of the object.}

constructor TppCommunicator.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  FComponentDesigner := nil;
  FDesignState := [];
  FEventNotifyList := nil;
  FNameChangeOnLoad := False;
  FEvents := [];
  FNotifyList := nil;
  FOnNotify := nil;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{@TppCommunicator.Destroy

  Do not call Destroy directly. Call Free instead.  Free verifies that the
  component is not nil, and only then calls Destroy.

  Before freeing the instance of the component, Destroy sends out an opRemove
  notification so that any other component with dependencies on the component
  can make appropriate adjustments.  Destroy then frees all components that it
  owns (all components listed in the Components property).  Finally it removes
  the Component from the Components property of its Owner and frees the memory
  allocated to the component.

  Never explicitly free a component in one of its own event handlers, nor free
  a component from the event handler of a component that it owns or contains.

  Note:	A form owns all the controls and non-visual components that are placed
  on it in design mode. When it is freed, all of these components are
  automatically freed as well. By default, all forms are owned by the
  global Application object. When an application terminates, it frees the
  global Application object, which frees all forms. For objects that are not
  components, and for components created with a nil owner, be sure to call Free
  after finishing with the object; otherwise the memory allocated for the object
  will be lost until the application terminates.}

destructor TppCommunicator.Destroy;
begin

  SendNotify(Self, ppopRemove);

  FNotifyList.Free;
  FEventNotifyList.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppCommunicator.BeforeDestruction }

procedure TppCommunicator.BeforeDestruction;
begin

  inherited BeforeDestruction;

end; {procedure, BeforeDestruction}

{------------------------------------------------------------------------------}
{ TppCommunicator.Loaded }

procedure TppCommunicator.Loaded;
begin

  inherited Loaded;

  {required to ensure versions 3.5 and earlier have a user name}
  if ppCheckPropInfo(Self, 'UserName') and (FUserName = '') then
    SetUserName(GetDefaultUserName);

end; {procedure, Loaded}

{------------------------------------------------------------------------------}
{ TppCommunicator.GetNotifyCommunicator }

function TppCommunicator.GetNotifyCommunicator(aIndex: Integer): TppCommunicator;
begin
  if (FNotifyList <> nil) then
    Result := TppCommunicator(FNotifyList[aIndex])
  else
    Result := nil;
end; {function, GetNotifyCommunicator}

{------------------------------------------------------------------------------}
{ TppCommunicator.GetNotifyCommunicator }

function TppCommunicator.GetNotifyCommunicatorCount: Integer;
begin
  if (FNotifyList <> nil) then
    Result := FNotifyList.Count
  else
    Result := 0;
end; {function, GetNotifyCommunicator}

{------------------------------------------------------------------------------}
{@TppCommunicator.AddNotify

  Establishes a relationship between two objects, such that each object will
  call the Notify method of the other object when it is being destroyed. The
  usual response to such notification is for the receiving object to nil out a
  private variable or remove the calling object from a TList in which a
  reference to the object is being held.}

procedure TppCommunicator.AddNotify(aCommunicator: TppCommunicator);
begin

  if (FNotifyList = nil) then
    FNotifyList := TList.Create;

  if FNotifyList.IndexOf(aCommunicator) < 0 then
    begin
      FNotifyList.Add(aCommunicator);
      aCommunicator.AddNotify(Self);
    end;

end; {procedure, AddNotify}

{------------------------------------------------------------------------------}
{@TppCommunicator.RemoveNotify

  Terminates the relationship between two objects. Usually called when a
  reference held by an object is set to a different object.}

procedure TppCommunicator.RemoveNotify(aCommunicator: TppCommunicator);
begin

  if (FNotifyList = nil) then Exit;

  if FNotifyList.IndexOf(aCommunicator) >= 0 then
    begin
      FNotifyList.Remove(aCommunicator);
      aCommunicator.RemoveNotify(Self);
    end;

  if (FNotifyList <> nil) and (FNotifyList.Count = 0) then
    begin
      FNotifyList.Free;
      FNotifyList := nil;
    end;

end; {procedure, RemoveNotify}

{------------------------------------------------------------------------------}
{@TppCommunicator.SendNotify

  Loops through all of the objects which have some sort of relationship with
  the current object and notifies them that the given operation has occurred.
  Most often used to send a ppopRemove operation, notifying all interested
  objects that the current object is being destroyed.}

procedure TppCommunicator.SendNotify(aCommunicator: TppCommunicator; aOperation: TppOperationType);
var
  liIndex: Integer;
  lCommunicator: TppCommunicator;
begin

  if (FNotifyList = nil) then Exit;

  {note: process loop last to first because object that are notifiy will likely remove themselves from the list}
  {note2: when an object is notified, it may notify other objects that may remove themselves from the list also}
  for liIndex := FNotifyList.Count - 1 downto 0 do
    if (FNotifyList <> nil) and (liIndex < FNotifyList.Count) then
      begin
        lCommunicator := TppCommunicator(FNotifyList[liIndex]);

        lCommunicator.Notify(aCommunicator, aOperation);
      end;

end; {procedure, SendNotify}

{------------------------------------------------------------------------------}
{@TppCommunicator.Notify

  When an object is freed, the Notify method of every object in the FNotifyList
  of that object is called, passing the ppopRemove operation. This allows the
  called objects to remove the destroyed object from their NotifyList and to nil
  out any private variables which were holding a reference to the destroyed
  object.}

procedure TppCommunicator.Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType);
var
  liIndex: Integer;
begin

  if (aOperation <> ppopRemove) then
    begin
      if Assigned(FOnNotify) then FOnNotify(Self, aCommunicator, aOperation)
    end
  else
    begin
      if (FDesignEventHub = aCommunicator) then
        FDesignEventHub := nil;

      if (FNotifyList <> nil) then
        begin
          FNotifyList.Remove(aCommunicator);

         { if (FNotifyList.Count = 0) then
            begin
              FNotifyList.Free;
              FNotifyList := nil;
            end;}
        end;


     if (FEventNotifyList <> nil) then
        begin
          liIndex := FEventNotifyList.IndexOf(aCommunicator);

          if (liIndex <> -1) then
            FEventNotifyList.Delete(liIndex);

         { if (FEventNotifyList.Count = 0) then
            begin
              FEventNotifyList.Free;
              FEventNotifyList := nil;
            end;}
        end;

      if Assigned(FOnNotify) then FOnNotify(Self, aCommunicator, aOperation);

  end;

end; {procedure, Notify}

{------------------------------------------------------------------------------}
{@TppCommunicator.EventOrder

  EventOrder allows the listening objects to specify the order in which they
  should receive notification of a certain event. When one object has
  established an event notification relationship with another the order in which
  the objects receive notification of a certain event can be vital.}

function TppCommunicator.EventOrder: String;
begin
  Result := '';
end; {procedure, EventOrder}

{------------------------------------------------------------------------------}
{ TppCommunicator.IsActiveNotify }

function TppCommunicator.IsActiveNotify(aEventID: Integer): Boolean;
var
  liIndex: Integer;
  lCommunicator: TppCommunicator;
begin

  Result := False;

  liIndex := 0;

  while not(Result) and (liIndex < NotifyCommunicatorCount) do
    begin
      lCommunicator := NotifyCommunicators[liIndex];

      if (aEventID in lCommunicator.EventNotifies) then
        Result := True
      else
        Inc(liIndex);
    end;

end; {function, IsActiveNotify}


{------------------------------------------------------------------------------}
{@TppCommunicator.AddEventNotify

 Places the communicator specifed in aCommunicator in the notify and event
 notify lists.}

procedure TppCommunicator.AddEventNotify(aCommunicator: TppCommunicator);
begin

  if (FEventNotifyList = nil) then
    FEventNotifyList := TList.Create;

  if (FEventNotifyList.IndexOf(aCommunicator) < 0) then
    begin

      if (aCommunicator.EventOrder <> '') then
        AddOrderedEventNotify(aCommunicator)
      else
        FEventNotifyList.Add(aCommunicator);

      AddNotify(aCommunicator);
    end;

end; {procedure, AddEventNotify}

{------------------------------------------------------------------------------}
{ TppCommunicator.AddOrderedEventNotify }

procedure TppCommunicator.AddOrderedEventNotify(aCommunicator: TppCommunicator);
var
  lEventOrders: TStringList;
  liIndex: Integer;
  lCommunicator: TppCommunicator;
begin

  lEventOrders := TStringList.Create;

  for liIndex := 0 to FEventNotifyList.Count - 1 do
    begin
      lCommunicator := TppCommunicator(FEventNotifyList[liIndex]);

      lEventOrders.AddObject(lCommunicator.EventOrder, lCommunicator);
    end;

  lEventOrders.AddObject(aCommunicator.EventOrder, aCommunicator);

  lEventOrders.Sort;

  FEventNotifyList.Clear;

  for liIndex := 0 to lEventOrders.Count - 1 do
    FEventNotifyList.Add(lEventOrders.Objects[liIndex]);

  lEventOrders.Free;

end; {procedure, AddOrderedEventNotify}


{@TppCommunicator.RemoveEventNotify
 Remove a communicator from the notify and event notify lists.}

procedure TppCommunicator.RemoveEventNotify(aCommunicator: TppCommunicator);
var
  liIndex: Integer;
begin
  if (FEventNotifyList = nil) then Exit;

  liIndex := FEventNotifyList.IndexOf(aCommunicator);

  if (liIndex <> -1) then
    begin
      FEventNotifyList.Delete(liIndex);

      RemoveNotify(aCommunicator);
    end;

  if (FEventNotifyList <> nil) and (FEventNotifyList.Count = 0) then
    begin
      FEventNotifyList.Free;
      FEventNotifyList := nil;
    end;

end; {procedure, RemoveEventNotify}

{------------------------------------------------------------------------------}
{ TppCommunicator.SendEventNotify }

procedure TppCommunicator.SendEventNotify(aCommunicator: TppCommunicator; aEventID: Integer; aParams: TraParamList);
var
  liIndex: Integer;
  lCommunicator: TppCommunicator;
  liSaveCount: Integer;
begin

  if (FEventNotifyList = nil) then Exit;

  liIndex := 0;

  while (FEventNotifyList <> nil) and (liIndex < FEventNotifyList.Count) do
    begin

      lCommunicator := TppCommunicator(FEventNotifyList[liIndex]);

      liSaveCount := FEventNotifyList.Count;

      if (aEventID in lCommunicator.EventNotifies) then
        lCommunicator.EventNotify(aCommunicator, aEventID, aParams);

      if (FEventNotifyList <> nil) and (FEventNotifyList.Count = liSaveCount) then
        Inc(liIndex);

    end;

end; {procedure, SendEventNotify}


{@TppCommunicator.EventNotify
 Called when a aCommunicator is firing an event for which the current
 communicator requested notification for by calling AddEventNotify and
 configuring the EventNotifies property.}

procedure TppCommunicator.EventNotify(aCommunicator: TppCommunicator; aEventID: Integer; aParams: TraParamList);
begin
  if Assigned(FOnEventNotify) then FOnEventNotify(Self, aCommunicator, aEventID, aParams);
end; {procedure, EventNotify}


{@TppCommunicator.DSInclude
 Used to control the DesignState property.}

procedure TppCommunicator.DSInclude(aDesignStateSet: TppDesignStates);
begin

  {if diference of new set with existing set is empty, then do nothing}
  if (aDesignStateSet - FDesignState) = [] then Exit;

  FDesignState := FDesignState + aDesignStateSet;

  DSChanged(aDesignStateSet);
end; {procedure, DSInclude}


{@TppCommunicator.DSExclude
 Used to controls the DesignState property.}

procedure TppCommunicator.DSExclude(aDesignStateSet: TppDesignStates);
begin

  {if intersection of new set with existing set is empty, then do nothing}
  if (aDesignStateSet * FDesignState) = [] then Exit;

  FDesignState := FDesignState - aDesignStateSet;

  DSChanged(aDesignStateSet);
end; {procedure, DSExclude}

{------------------------------------------------------------------------------}
{ TppCommunicator.DSChanged }

procedure TppCommunicator.DSChanged(aDesignStateSet: TppDesignStates);
begin

end; {procedure, DSChanged}

{------------------------------------------------------------------------------}
{ TppCommunicator.SetComponentDesigner }

procedure TppCommunicator.SetComponentDesigner(aComponentDesigner: TppComponentDesigner);
begin
  FComponentDesigner := aComponentDesigner;
end; {procedure, SetComponentDesigner}

{------------------------------------------------------------------------------}
{ TppCommunicator.GetFormDesigner }

function TppCommunicator.GetFormDesigner: TppFormDesigner;
var
  lParent: TppCommunicator;

begin

  Result := nil;

  if ComponentDesigner <> nil then
    Result := ComponentDesigner.FormDesigner

  else
    begin

     {try parent, if possible}
     lParent := GetParentCommunicator;

     if (lParent <> nil)then
       Result := lParent.GetFormDesigner;

    end;


end; {function, GetFormDesigner}


{@TppCommunicator.GetValidName
 Returns unique name for the Name property of the component.}

function TppCommunicator.GetValidName(aComponent: TComponent): String;
var
  lsNamingPrefix: String;
begin

  lsNamingPrefix := ppGetStdNamingPrefix(aComponent);

  if (Owner <> nil) then
   Result := ppGetUniqueName(Owner, lsNamingPrefix, aComponent)

  else  {run-time designing }
    Result := ppGetUniqueName(Self, lsNamingPrefix, aComponent);

end; {function, GetValidName}


{------------------------------------------------------------------------------}
{ TppCommunicator.GetComponentDesigner }

function TppCommunicator.GetComponentDesigner: TppComponentDesigner;
begin
  Result := FComponentDesigner;

end;

{------------------------------------------------------------------------------}
{ TppCommunicator.SendDesignMessage }

procedure TppCommunicator.SendDesignMessage(aMsg: Integer; aWParam: Integer; aOParam: TObject);
var
  lEventHub: TppDesignEventHub;
begin

  lEventHub := TppDesignEventHub(GetDesignEventHub);

  if lEventHub <> nil then
    lEventHub.DesignEventNotify(aMsg, aOParam);

end;  {procedure, SendDesignMessage}

{------------------------------------------------------------------------------}
{ TppCommunicator.BeforePropertyChange }

procedure TppCommunicator.BeforePropertyChange(aPropertyName: String);
var
  lEventHub: TppDesignEventHub;
  lEventParams: TppPropertyChangeEventParams;
begin

  lEventHub := TppDesignEventHub(GetDesignEventHub);

  if lEventHub <> nil then
    begin
      lEventParams := lEventHub.ComponentEvents.GetPropertyChangeEventParams(Self, aPropertyName);
      lEventHub.ComponentEvents.mcBeforePropertyChange.Notify(Self, lEventParams);
    end;

end;

{------------------------------------------------------------------------------}
{ TppCommunicator.AfterPropertyChange }

procedure TppCommunicator.AfterPropertyChange;
var
  lEventHub: TppDesignEventHub;
begin
  if (csDestroying in ComponentState) then Exit;
  
  lEventHub := TppDesignEventHub(GetDesignEventHub);

  if lEventHub <> nil then
    lEventHub.ComponentEvents.mcAfterPropertyChange.Notify(Self, nil);

end;


{------------------------------------------------------------------------------}
{ TppCommunicator.PropertyChange }

procedure TppCommunicator.PropertyChange;
begin

  AfterPropertyChange;

end; {procedure, PropertyChange}

{------------------------------------------------------------------------------}
{ TppCommunicator.SetUserName }

procedure TppCommunicator.SetUserName(const aUserName: TComponentName);
var
  liNameNo: Integer;
  lObject: TObject;
  lsLastChar: String;
  lsUserName: String;


begin

{  if (FUserName = aUserName) then Exit;}

{  if ((csReading in ComponentState) or (csLoading in ComponentState)) and
     not (pppcPasting in DesignState)  then
    begin
      FUserName := aUserName;
      Exit;
    end;}

    
  if not IsValidIdent(aUserName) then Exit;

  BeforePropertyChange('UserName');
  
  if IsValidUserName(aUserName) then
      FUserName := aUserName

  else
    begin

      {check for a naming no}
      lsLastChar := Copy(aUserName, Length(aUserName), 1);

      liNameNo := StrToIntDef(lsLastChar, 0);

      {if a naming no exists then exit (allow naming to be handled elsewhere}
      if (liNameNo > 0) then Exit;

      {find a new username (ex. plCustomer should be plCustomer1) }
      repeat
        Inc(liNameNo);

        lsUserName := aUserName + IntToStr(liNameNo);

        lObject := FindUserObject(lsUserName);

      until (lObject = nil) or (lObject = Self);

      FUserName := lsUserName;

    end;


  SendNotify(Self, ppopUserNameChange);

  PropertyChange;

end; {procedure, SetUserName}


{------------------------------------------------------------------------------}
{ TppCommunicator.SetName }

procedure TppCommunicator.SetName(const NewName: TComponentName);
var
  lbUpdateUserName: Boolean;

begin

  lbUpdateUserName := (FUserName = '') or (FUserName = Name)
                                       or (FUserName = Copy(Name, 3, Length(Name)));

  inherited SetName(NewName);


  if ((csReading in ComponentState) or (csLoading in ComponentState)) and
    not (pppcPasting in DesignState) then Exit;

  if lbUpdateUserName then
    SetUserName(GetDefaultUserName);

  SendEventNotify(Self, ciNameChanged, nil);

end; {procedure, SetName}

{------------------------------------------------------------------------------}
{ TppCommunicator.GetPropUserName }

function TppCommunicator.GetPropUserName: TComponentName;
begin

  Result := FUserName;

end; {function, GetPropUserName}

{------------------------------------------------------------------------------}
{ TppCommunicator.GetDefaultUserName }

function TppCommunicator.GetDefaultUserName: String;
begin

  {check whether Name contains 'pp' or 'ra' etc, if so strip it off}
  if Copy(Name, 1,2) = Copy(ClassName, 2,2) then
    Result := Copy(Name, 3, Length(Name))
  else
    Result := Name;

  if not(IsValidUserName(Result)) then
    Result := GetUniqueUserName(Self);

end; {function, GetDefaultUserName}



{@TppCommunicator.IsValidUserName
 Determines if a given user name is valid.}

function TppCommunicator.IsValidUserName(aUserName: String): Boolean;
var
  lObject: TObject;

begin

  Result := False;

  if not IsValidIdent(aUserName) then Exit;

  lObject := FindUserObject(aUserName);

  {if no object found or object is self, then user name is valid}
  Result := (lObject = nil)  or (lObject = Self);

end; {function, IsValidUserName}


{@TppCommunicator.GetParentCommunicator
 Returns parent communicator.}

function TppCommunicator.GetParentCommunicator: TppCommunicator;
var
  lParent: TComponent;

begin

  Result := nil;

  if HasParent then
    begin

      lParent := GetParentComponent;

      if (lParent <> nil) and (lParent is TppCommunicator) then
          Result := TppCommunicator(lParent);

    end;


end;  {function, GetParentCommunicator}



{@TppCommunicator.GetUniqueUserName
 Generates a unique user name.  The components owner should already by set.}

function TppCommunicator.GetUniqueUserName(aComponent: TComponent): String;
var
  lsNamingPrefix: String;
  lParent: TppCommunicator;

begin

  {defer to parent, if possible}
  lParent := GetParentCommunicator;

  if (lParent <> nil)then
    begin
      Result := lParent.GetUniqueUserName(aComponent);
      Exit;
    end;


  lsNamingPrefix := ppGetUserNamePrefix(aComponent);

  Result := ppGetUniqueName(aComponent.Owner, lsNamingPrefix, aComponent)

end; {function, GetUniqueUserName}



{@TppCommunicator.FindUserObject
 Used to locate a communicator by object name.}

function TppCommunicator.FindUserObject(aUserName: String): TppCommunicator;
var
  lParent: TppCommunicator;

begin

  {defer to parent, if possible}
  lParent := GetParentCommunicator;

  if (lParent <> nil) then
    begin
      Result := lParent.FindUserObject(aUserName);
      Exit;
    end;


  if (Owner = nil) then
    begin
      Result := nil;
      Exit;
    end;


  Result := FindUserObjectInComponent(aUserName, Owner);


end; {function, FindUserObject}


{@TppCommunicator.FindUserObjectInComponent
 Used to locate a communicator in a given component.}

function TppCommunicator.FindUserObjectInComponent(aUserName: String; aComponent: TComponent): TppCommunicator;
var
  liComponent: Integer;
  liComponentCount: Integer;
  lCommunicator: TppCommunicator;

begin

  Result := nil;

  if (aComponent = nil) then Exit;

  liComponentCount := aComponent.ComponentCount;

  for liComponent := 0 to liComponentCount-1 do

    if (aComponent.Components[liComponent] is TppCommunicator) then
      begin
        lCommunicator := TppCommunicator(aComponent.Components[liComponent]);

        if (CompareText(lCommunicator.UserName, aUserName) = 0) then
          begin
            Result := lCommunicator;
            Exit;
          end;

      end;

end; {function, FindUserObjectInComponent}

{------------------------------------------------------------------------------}
{ TppCommunicator.SetParentComponent }

procedure TppCommunicator.SetParentComponent(Value: TComponent);
begin

end; {procedure, SetParentComponent}



{@TppCommunicator.ChangeOwner

 Called when the owner of the component is changing.}

procedure TppCommunicator.ChangeOwner(aNewOwner: TComponent);
begin

  if (aNewOwner = Owner) then Exit;

  {remove from current owner}
  if Owner <> nil then
    Owner.RemoveComponent(Self);

  {assign new owner}
  if aNewOwner <> nil then
    begin
      {if (aNewOwner.FindComponent(Name) <> nil) then
        begin
          Name := ppGetUniqueName(aNewOwner, ppGetStdNamingPrefix(Self), Self);
        end; }

      if (FindUserObjectInComponent(FUserName, aNewOwner) <> nil) then
        FUserName := GetUniqueUserName(Self);

      aNewOwner.InsertComponent(Self);


    end;

end; {procedure, ChangeOwner}

function TppCommunicator.GetDesignEventHub: TppCommunicator;
var
  lParent: TppCommunicator;
begin

  lParent := GetParentCommunicator;

  if (lParent <> nil) then
    Result := lParent.DesignEventHub
  else
    Result := FDesignEventHub;

end;

{ QueryInterface

  Called each time an interface is requested. }

function TppCommunicator.QueryInterface(const IID: TGUID; out Obj): HResult;
const
  E_NOINTERFACE = HResult($80004002);
begin

  if GetInterface(IID, Obj) then
    Result := 0
  else
    Result := E_NOINTERFACE;
    
end;

procedure TppCommunicator.SetDesignEventHub(const Value: TppCommunicator);
begin

  if FDesignEventHub = Value then Exit;

  if (Value <> nil) and not (Value is TppDesignEventHub) then
    raise EReportBuilderError.Create('TppCommunicator.SetDesignEventHub: Value must be of type TppDesignEventHub');

  if (FDesignEventHub <> nil) then
    FDesignEventHub.RemoveNotify(Self);

  FDesignEventHub := Value;

  if (FDesignEventHub <> nil) then
    FDesignEventHub.AddNotify(Self);

end;


{  _AddRef

  Called each time an interface reference is created. }

function TppCommunicator._AddRef: Integer;
begin
  Result := -1;
end;


{  _Release

  Called each time an interface variable is set to nil or goes out of scope. }

function TppCommunicator._Release: Integer;
begin
  Result := -1;
end;



{******************************************************************************
*
*  C o m m u n i c a t o r P i c k L i s t
*
******************************************************************************}

{------------------------------------------------------------------------------}
{ TppCommunicatorPickList }

constructor TppCommunicatorPickList.Create(aParent: TppCommunicator; aComponentClass: TppCommunicatorClass);
begin
  inherited Create;

  FComponentClass := aComponentClass;

  SetParent(aParent);


end;  {procedure, Create}


{------------------------------------------------------------------------------}
{ TppCommunicatorPickList.AddComponent }

procedure TppCommunicatorPickList.AddComponent(aComponent: TComponent);
begin
  {only add to list, if pipeline's Visible property set to true}
  AddObject(TppCommunicator(aComponent).UserName, aComponent);

end; {procedure, AddComponent}


{------------------------------------------------------------------------------}
{ TppCommunicatorPickList.BuildList }

procedure TppCommunicatorPickList.BuildList;
begin

  Clear;

  if (FParent = nil) then Exit;

  {build list of data pipeline names}
  if (FFormDesigner = nil) then
    BuildListFromOwner(FParent.Owner)
  else
    BuildListFromDesigner(FFormDesigner);

end; {procedure, BuildList}

{------------------------------------------------------------------------------}
{ TppCommunicatorPickList.Refresh }

procedure TppCommunicatorPickList.Refresh;
begin

  BuildList;

end; {procedure, Refresh}


{------------------------------------------------------------------------------}
{ TppCommunicatorPickList.SetParent }

procedure TppCommunicatorPickList.SetParent(aParent: TppCommunicator);
begin

  FParent := aParent;

  {get the form designer}
  if FParent <> nil then
    FFormDesigner := FParent.FormDesigner
  else
    FFormDesigner := nil;

  BuildList;

end; {procedure, SetParent}


{------------------------------------------------------------------------------}
{ TppCommunicatorPickList.BuildListFromDesigner }

procedure TppCommunicatorPickList.BuildListFromDesigner(aDesigner: TppFormDesigner);
begin
  aDesigner.GetComponentNames(GetTypeData(FComponentClass.ClassInfo), GetDataItemsCallback);

end; {procedure, BuildListFromDesigner}

{------------------------------------------------------------------------------}
{ TppCommunicatorPickList.GetDataItemsCallback }

procedure TppCommunicatorPickList.GetDataItemsCallback(const S: string);
var
  lComponent: TppCommunicator;

begin
  lComponent := TppCommunicator(FFormDesigner.GetComponent(S));
  AddObject(lComponent.UserName, lComponent);

end; {procedure, GetDataItemsCallback}


{------------------------------------------------------------------------------}
{ TppCommunicatorPickList.GetComponentForName }

function TppCommunicatorPickList.GetComponentForName(aName: String): TppCommunicator;
var
  liIndex: Integer;

begin
  liIndex := IndexOf(aName);

  if liIndex < 0 then
    Result := nil
  else
    Result := TppCommunicator(Objects[liIndex]);

end; {procedure, GetComponentForName}


{------------------------------------------------------------------------------}
{ TppCommunicatorPickList.BuildListFromOwner }

procedure TppCommunicatorPickList.BuildListFromOwner(aOwner: TComponent);
var
  liComponent: Integer;
  liComponents: Integer;
  liDataModule: Integer;

begin

  if (aOwner <> nil) then
    liComponents := aOwner.ComponentCount
  else
    liComponents := 0;

  {add components residing in owner}
  for liComponent := 0 to liComponents-1 do
    if aOwner.Components[liComponent] is FComponentClass then
      AddComponent(TppCommunicator(aOwner.Components[liComponent]));


  {add components residing in data modules }
  for liDataModule := 0 to Screen.DataModuleCount-1 do
    BuildListFromDataModule(Screen.DataModules[liDataModule]);

end; {procedure, BuildListFromOwner}

{------------------------------------------------------------------------------}
{ TppCommunicatorPickList.BuildListFromDataModule }

procedure TppCommunicatorPickList.BuildListFromDataModule(aDataModule: TDataModule);
var
  liComponent: Integer;

begin

  for liComponent := 0 to aDataModule.ComponentCount-1 do

    if aDataModule.Components[liComponent] is FComponentClass then
      AddComponent(TppCommunicator(aDataModule.Components[liComponent]));

end; {procedure, BuildListFromDataModule}


{******************************************************************************
 *
 ** C O M P O N E N T   L I S T
 *
{******************************************************************************}


{$IFDEF Delphi5}

{------------------------------------------------------------------------------}
{ TppComponentList.Create }

constructor TppComponentList.Create(aOwner: TComponent);
begin

  inherited Create;

  OwnsObjects := False;

end; {function, Create}

{$ELSE}

{------------------------------------------------------------------------------}
{ TppComponentList.Create }

constructor TppComponentList.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  FList := TList.Create;

end; {function, Create}

{------------------------------------------------------------------------------}
{ TppComponentList.Destroy }

destructor TppComponentList.Destroy;
begin

  FList.Free;

  inherited Destroy;

end; {function, Create}

{------------------------------------------------------------------------------}
{ TppComponentList.GetItems }

function TppComponentList.GetItems(aIndex: Integer): TComponent;
begin

  Result := TComponent(FList[aIndex]);

end; {function, GetItems}


{------------------------------------------------------------------------------}
{ TppComponentList.Count }

function TppComponentList.Count: Integer;
begin
  Result := FList.Count;

end; {function, Count}


{------------------------------------------------------------------------------}
{ TppComponentList.IndexOf }

function TppComponentList.IndexOf(aComponent: TComponent): Integer;
begin
  Result := FList.IndexOf(aComponent);

end; {function, IndexOf}

{------------------------------------------------------------------------------}
{ TppComponentList.Add }

procedure TppComponentList.Add(aComponent: TComponent);
begin
  FList.Add(aComponent);

  aComponent.FreeNotification(Self);

end; {procedure, Add}

{------------------------------------------------------------------------------}
{ TppComponentList.Delete }

procedure TppComponentList.Delete(aIndex: Integer);
begin
  FList.Delete(aIndex);

end; {procedure, Remove}


{------------------------------------------------------------------------------}
{ TppComponentList.Notification }

procedure TppComponentList.Notification(aComponent: TComponent; Operation: TOperation);
var
  liIndex: Integer;
  
begin
  if (Operation = opRemove) then
    begin
      liIndex := (IndexOf(aComponent));

      if liIndex >= 0 then
        Delete(liIndex);

    end;


  inherited Notification(aComponent, Operation);

end; {procedure, Notification}


{$ENDIF}


{******************************************************************************
 *
 ** C O M M U N I C A T O R   R T T I
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TraTppCommunicatorRTTI.RefClass }

class function TraTppCommunicatorRTTI.RefClass: TClass;
begin
  Result := TppCommunicator;
end; {class function, RefClass}

{------------------------------------------------------------------------------}
{ TraTppCommunicatorRTTI.GetPropRec }

class function TraTppCommunicatorRTTI.GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean;
begin

  Result := True;

  if CompareText(aPropName, 'UserName') = 0 then
    PropToRec(aPropName, daString, False, aPropRec)

  else
    Result := inherited GetPropRec(aClass, aPropName, aPropRec);

end; {class function, GetPropRec}

{------------------------------------------------------------------------------}
{ TraTppCommunicatorRTTI.GetPropValue }

class function TraTppCommunicatorRTTI.GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;

  if CompareText(aPropName, 'UserName') = 0 then
    String(aValue) := TppCommunicator(aObject).UserName

  else
    Result := inherited GetPropValue(aObject, aPropName, aValue);

end; {class function, GetPropValue}

{------------------------------------------------------------------------------}
{ TraTppCommunicatorRTTI.SetPropValue }

class function TraTppCommunicatorRTTI.SetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;

  if (CompareText(aPropName, 'UserName') = 0) then
    TppCommunicator(aObject).UserName := String(aValue)

  else
    Result := inherited SetPropValue(aObject, aPropName, aValue);

end; {class function, SetPropValue}




initialization

  raRegisterRTTI(TraTppCommunicatorRTTI);

finalization

  raUnRegisterRTTI(TraTppCommunicatorRTTI);

end.
