{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit ppDsIntf;

interface

{$I ppIfDef.pas}

uses
  Windows,
  Comctrls,
  Controls,
  Classes,
  Forms,
  TypInfo,
  SysUtils,

  ppTBXStatusBars,
  ppTypes,
  ppUtils,
  ppCollectionBase;

type

  TppComponentDesigner = class;
  TppComponentDesignerClass = class of TppComponentDesigner;
  TppDesignModuleClass = class of TppDesignModule;


  {TppDesignerSelectionList}
  TppDesignerSelectionList = class(TList)
    private
      function GetComponent(aIndex: Integer): TPersistent;

    public

      function Equals(const aList: TppDesignerSelectionList): Boolean; {$IFDEF Delphi12} reintroduce; {$ENDIF}
      property Components[Index: Integer]: TPersistent read GetComponent; default;

    end;  {class, TppDesignerSelectionList }


  TppSetSelectionEvent = procedure(Components: TppDesignerSelectionList) of object;


  TppFormDesignerClass = class of TppFormDesigner;

  {TppFormDesigner }
  TppFormDesigner = class
    private

    protected
      function GetActive: Boolean; virtual; abstract;

    public
{$IFDEF Delphi6}
      constructor Create(aIDesigner: IInterface); virtual;
      procedure SetDesigner(aIDesigner: IInterface); virtual;
{$ELSE}
      constructor Create(aIDesigner: IUnknown); virtual;
      procedure SetDesigner(aIDesigner: IUnknown); virtual;
{$ENDIF}

      function  CreateComponent(ComponentClass: TComponentClass; Parent: TComponent; Left, Top, Width, Height: Integer): TComponent; virtual; abstract;
      procedure GetComponentNames(TypeData: PTypeData; Proc: TGetStrProc); virtual; abstract;
      function  MethodExists(const Name: string): Boolean; virtual; abstract;
      procedure Modified;  virtual; abstract;

      function GetMethodAddress(aComponent: TComponent; const aMethodName: string; var aAddress: Pointer): Boolean; virtual; abstract;

      function GetComponent(const Name: string): TComponent; virtual; abstract;

      function CreateMethod(const Name: string; TypeData: PTypeData): TMethod; virtual; abstract;
      procedure GetMethods(TypeData: PTypeData; Proc: TGetStrProc); virtual; abstract;

      property Active: Boolean read GetActive;

   end; {class, TppFormDesigner}


  {TppComponentDesigner

    Abstract ancestor class for ReportBuilder component designers.}

  TppComponentDesigner = class(TForm)
    private
      FComponent: TComponent;
      FFormDesigner: TppFormDesigner;
      FOnSetSelection: TppSetSelectionEvent;
      FDesignModuleClassSubscriber: TObject;
      FErrorMessage: String;
      FOnHelp: TppHelpEvent;
{$IFNDEF Delphi9}
      FPopupParent: TCustomForm;
{$ENDIF}
    protected
      procedure DesignModuleClassListChanged(Sender: TObject); virtual;
      procedure DoOnHelp(Sender: TObject; var aHelpFile, aKeyphrase: String; var aCallHelp: Boolean); virtual;
      procedure DoOnSetSelection(aComponentList: TppDesignerSelectionList);
      procedure SetComponent(aComponent: TComponent); virtual;
      function  GetCurrentComponent: TComponent; virtual;
      function GetDesignTime: Boolean;
      procedure SetCurrentComponent(aComponent: TComponent); virtual;

      function GetStatusBar: TppTBXStatusBar; virtual;
      procedure SetErrorMessage(aErrorMessage: String);

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      procedure CreateParams(var Params: TCreateParams); override;

{$IFDEF Delphi6}
      constructor CreateDesignTimeDesigner(aOwner: TComponent; aIDesigner: IInterface);
{$ELSE}
      constructor CreateDesignTimeDesigner(aOwner: TComponent; aIDesigner: IUnknown);
{$ENDIF}

      procedure Notification(aComponent: TComponent; Operation: TOperation); override;

      function  ValidSettings: Boolean; virtual;
      procedure ComponentModified; virtual;
      procedure ComponentChanged; virtual;
      procedure SelectionChanged(aSelection: TppDesignerSelectionList);  virtual; abstract;
      function ShowModal: Integer; override;

      property Component: TComponent read FComponent write SetComponent;
      property CurrentComponent: TComponent read GetCurrentComponent write SetCurrentComponent;
      property DesignTime: Boolean read GetDesignTime;
      property ErrorMessage: String read FErrorMessage;
      property FormDesigner: TppFormDesigner read FFormDesigner write FFormDesigner;
      property OnHelp: TppHelpEvent read FOnHelp write FOnHelp;
      property OnSetSelection: TppSetSelectionEvent read FOnSetSelection write FOnSetSelection;
{$IFNDEF Delphi9}
      property PopupParent: TCustomForm read FPopupParent write FPopupParent;
{$ENDIF}
      property StatusBar: TppTBXStatusBar read GetStatusBar;

  end; {class, TppComponentDesigner}


  {@TppDesignModule }
  TppDesignModule = class(TComponent)
    private
      FActive: Boolean;
      FParent: TWinControl;
      FComponentDesigner: TppComponentDesigner;
      FCaption: String;
      FOrderIndex: Integer;
      FComponent: TComponent;
      FLanguageIndex: Integer;

      procedure SetActive(aValue: Boolean);

    protected
      procedure ActiveChanged; virtual;
      procedure SetComponent(aComponent: TComponent); virtual;

      function GetStatusBar: TppTBXStatusBar; virtual;
      procedure SetLanguageIndex(aLanguageIndex: Integer); virtual;
      procedure DoOnHelp(Sender: TObject; var aHelpFile, aKeyphrase: String; var aCallHelp: Boolean); virtual;

    public
      constructor CreateModule(aParent: TWinControl; aComponentDesigner: TppComponentDesigner); virtual;

      procedure ActiveChanging(var aAllowChange: Boolean); virtual;
      procedure LoadStart; virtual;
      procedure LoadEnd; virtual;
      procedure LoadStateInfo; virtual;
      procedure SaveStateInfo; virtual;
      procedure SaveStart; virtual;
      procedure CloseQuery(var CanClose: Boolean); virtual;
      procedure Close; virtual;

      property Active: Boolean read FActive write SetActive;
      property ComponentDesigner: TppComponentDesigner read FComponentDesigner;
      property Component: TComponent read FComponent write SetComponent;
      property Caption: String read FCaption write FCaption;
      property Parent: TWinControl read FParent;
      property OrderIndex: Integer read FOrderIndex write FOrderIndex;
      property StatusBar: TppTBXStatusBar read GetStatusBar;
      property LanguageIndex: Integer read FLanguageIndex write SetLanguageIndex;

    end; {class, TppDesignModule}


  {TppDesignModuleCollection}
  TppDesignModuleCollection = class(TppComponentCollectionBase)
  private
    function GetItemForIndex(aIndex: Integer): TppDesignModule;
    function GetItemsByName(aName: String): TppDesignModule;

  public
    procedure Add(aObject: TppDesignModule);
    function IndexOf(aObject: TppDesignModule): Integer;
    function IndexOfName(aName: String): Integer;
    procedure Remove(aObject: TppDesignModule);

    property Items[Index: Integer]: TppDesignModule read GetItemForIndex; default;
    property ItemsByName[Name: String]: TppDesignModule read GetItemsByName;


  end;



{$IFDEF Delphi9}
    IppHelp2 = interface
    ['{2F9242BC-BF84-4FBA-8A2F-31E3842036E4}']
      procedure iDisplayTopicFromKeyword(aKeyWord: String);
    end;

    TppHelp2Manager = class
      class procedure RegisterIHelp2(aClass: TInterfacedClass);
      class function IHelp2: IppHelp2;
    end;

    TppHelp2 = class
      class procedure DisplayTopicFromKeyword(aKeyWord: String);
    end;
{$ENDIF}


  function  ppGetComponentDesignerClass(aComponent: TComponent): TppComponentDesignerClass;
  procedure ppRegisterComponentDesigner(aComponentDesignerClass: TppComponentDesignerClass;
                                        aComponentClass: TComponentClass);

  procedure ppUnRegisterComponentDesigner(aComponentDesignerClass: TppComponentDesignerClass;
                                        aComponentClass: TComponentClass);

  procedure ppRegisterDesignModule(aDesignModuleClass: TppDesignModuleClass;
                                   const aComponentDesignerClassName: String);


  procedure ppUnRegisterDesignModule(aDesignModuleClass: TppDesignModuleClass;
                                   const aComponentDesignerClassName: String);


  procedure ppGetDesignModuleClasses(aComponentDesignerClassName: String; aClassList: TList);
  procedure ppSubscribeDesignModuleClassList(aRegListSubscriber: TObject);
  procedure ppUnSubscribeDesignModuleClassList(aRegListSubscriber: TObject);

  function ppGetFormDesignerClass: TppFormDesignerClass;
  procedure ppRegisterFormDesignerClass(aFormDesignerClass: TppFormDesignerClass);

implementation

var
  FDesignerClassList: TStringList = nil;
  FDesignModuleClassList: TppRegList = nil;
  FFormDesignerClass: TppFormDesignerClass = nil;
{$IFDEF Delphi9}
  uHelp2Class: TInterfacedClass;
  uIHelp2: IppHelp2;
{$ENDIF}



{$IFDEF Delphi9}

{******************************************************************************
 *
 ** HELP 2
 *
{******************************************************************************}


class procedure TppHelp2Manager.RegisterIHelp2(aClass: TInterfacedClass);
begin
  uHelp2Class := aClass;
end;

class function TppHelp2Manager.IHelp2: IppHelp2;
begin
  if (uIHelp2 = nil) and (uHelp2Class <> nil) then
    uIHelp2 := uHelp2Class.Create as IppHelp2;

  Result := uIHelp2;
end;

class procedure TppHelp2.DisplayTopicFromKeyword(aKeyWord: String);
begin

  if (TppHelp2Manager.IHelp2 <> nil) then
    TppHelp2Manager.IHelp2.iDisplayTopicFromKeyword(aKeyWord);

end;

{$ENDIF}

{******************************************************************************
 *
 ** D E S I G N E R  S E L E C T I O N  L I S T
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppDesignerSelectionList.GetComponent }

function TppDesignerSelectionList.GetComponent(aIndex: Integer): TPersistent;
begin
  Result := TPersistent(Items[aIndex]);
end; {function, GetComponent}


{------------------------------------------------------------------------------}
{ TppDesignerSelectionList.Equals }

function TppDesignerSelectionList.Equals(const aList: TppDesignerSelectionList): Boolean;
var
  liIndex: Integer;
begin
  Result := False;

  if aList.Count <> Count then Exit;

  for liIndex := 0 to Count - 1 do
    if aList[liIndex] <> Items[liIndex] then Exit;

  Result := True;

end;  {function, Equals}

{******************************************************************************
 *
 ** F O R M   D E S I G N E R
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppFormDesigner.Create }

{$IFDEF Delphi6}
constructor TppFormDesigner.Create(aIDesigner: IInterface);
{$ELSE}
constructor TppFormDesigner.Create(aIDesigner: IUnknown);
{$ENDIF}
begin

  inherited Create;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppFormDesigner.SetDesigner }

{$IFDEF Delphi6}
procedure TppFormDesigner.SetDesigner(aIDesigner: IInterface);
{$ELSE}
procedure TppFormDesigner.SetDesigner(aIDesigner: IUnknown);
{$ENDIF}
begin

end; {constructor, SetDesigner}


{******************************************************************************
 *
 ** C O M P O N E N T   D E S I G N E R
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppComponentDesigner.CreateDesignTimeDesigner }

{$IFDEF Delphi6}
constructor TppComponentDesigner.CreateDesignTimeDesigner(aOwner: TComponent; aIDesigner: IInterface);
{$ELSE}
constructor TppComponentDesigner.CreateDesignTimeDesigner(aOwner: TComponent; aIDesigner: IUnknown);
{$ENDIF}
begin

  {call default constructor}
  Create(aOwner);

  {create the borland IDesigner wrapper}
  if FFormDesignerClass <> nil then
    FFormDesigner := FFormDesignerClass.Create(aIDesigner);


end; {constructor, CreateDesignTimeDesigner}

{------------------------------------------------------------------------------}
{ TppComponentDesigner.Create }

constructor TppComponentDesigner.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  ParentFont := True;

{$IFDEF Delphi9}
  PopupMode := pmExplicit;
{$ENDIF}

  FComponent      := nil;
  FFormDesigner := nil;

  FOnHelp := nil;
  FOnSetSelection := nil;

  FDesignModuleClassSubscriber := TppRegListSubscriber.Create;
  TppRegListSubscriber(FDesignModuleClassSubscriber).OnListChanged := DesignModuleClassListChanged;

  ppSubscribeDesignModuleClassList(FDesignModuleClassSubscriber);

end; {constructor, Create}


{------------------------------------------------------------------------------}
{ TppComponentDesigner.Destroy }

destructor TppComponentDesigner.Destroy;
begin

  ppUnSubscribeDesignModuleClassList(FDesignModuleClassSubscriber);

  FDesignModuleClassSubscriber.Free;

  FFormDesigner.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppComponentDesigner.CreateParams}

procedure TppComponentDesigner.CreateParams(var Params: TCreateParams);
begin

  inherited CreateParams(Params);

  // display designer on task bar, at Delphi design-time
  if DesignTime then
    Params.ExStyle := Params.ExStyle or WS_EX_APPWINDOW;

{$IFDEF Delphi9}
  // nothing
{$ELSE}
  if (FPopupParent <> nil) then
    Params.WndParent := FPopupParent.Handle
  else if (Screen.ActiveForm <> nil) and (fsModal in FormState) then
    Params.WndParent := Screen.ActiveForm.Handle;
{$ENDIF}

end; {procedure, CreateParams}

{------------------------------------------------------------------------------}
{ TppComponentDesigner.DoOnHelp}

procedure TppComponentDesigner.DoOnHelp(Sender: TObject; var aHelpFile, aKeyphrase: String; var aCallHelp: Boolean);
begin
  {fire the help event}
  if Assigned(FOnHelp) then FOnHelp(Sender, aHelpFile, aKeyphrase, aCallHelp);

end; {procedure, DoOnHelp}

{------------------------------------------------------------------------------}
{ TppComponentDesigner.Notification}

procedure TppComponentDesigner.Notification(aComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);


{$IFDEF Delphi6}

  {Delphi DesignTime - free component designer when component is destroyed}
  if (aComponent = FComponent) and (Operation = opRemove) then
    begin
      if DesignTime and (csDestroying in aComponent.ComponentState) and
         not (csDestroying in ComponentState) then

        Release;
    end;

{$ENDIF}

end; {procedure, Notification}

{------------------------------------------------------------------------------}
{ TppComponentDesigner.SetComponent }

procedure TppComponentDesigner.SetComponent(aComponent: TComponent);
begin
  FComponent := aComponent;

{$IFDEF Delphi6}
  if DesignTime then
    FComponent.FreeNotification(Self);
{$ENDIF}

end; {procedure, SetComponent}

{------------------------------------------------------------------------------}
{ TppComponentDesigner.GetCurrentComponent }

function TppComponentDesigner.GetCurrentComponent: TComponent;
begin
  Result := FComponent;
end; {constructor, GetCurrentComponent}

{------------------------------------------------------------------------------}
{ TppComponentDesigner.GetDesignTime }

function TppComponentDesigner.GetDesignTime: Boolean;
begin
  Result := (FFormDesigner <> nil);

end; {constructor, GetDesignTime}

{------------------------------------------------------------------------------}
{ TppComponentDesigner.SetCurrentComponent }

procedure TppComponentDesigner.SetCurrentComponent(aComponent: TComponent);
begin

end; {procedure, SetCurrentComponent}

{------------------------------------------------------------------------------}
{ TppComponentDesigner.DoOnSetSelection }

procedure TppComponentDesigner.DoOnSetSelection(aComponentList: TppDesignerSelectionList);
begin
  if Assigned(FOnSetSelection) then FOnSetSelection(aComponentList);
  
end; {procedure, DoOnSetSelection}

{------------------------------------------------------------------------------}
{ TppComponentDesigner.ComponentModified }

procedure TppComponentDesigner.ComponentModified;
begin

  {notify Form Designer that component changed - this updates Object Inspector, and
   ensures Form Designer asks user, 'save changes?' when form is closed}
  if (FComponent = nil) then Exit;

  if (csDestroying in FComponent.ComponentState) then Exit;

  if not(csDesigning in FComponent.ComponentState) then Exit;

  if DesignTime then
    FormDesigner.Modified;

end; {procedure, ComponentModified}


{------------------------------------------------------------------------------}
{ TppComponentDesigner.ComponentChanged }

procedure TppComponentDesigner.ComponentChanged;
begin

end; {procedure, ComponentChanged}


{------------------------------------------------------------------------------}
{ TppComponentDesigner.GetStatusBar }

function TppComponentDesigner.GetStatusBar: TppTBXStatusBar;
begin

  Result := nil;

end;  {function, GetStatusBar}


{------------------------------------------------------------------------------}
{ TppComponentDesigner.DesignModuleClassListChanged }

procedure TppComponentDesigner.DesignModuleClassListChanged(Sender: TObject);
begin
  
end; {procedure, DesignModuleClassListChanged}


{------------------------------------------------------------------------------}
{ TppComponentDesigner.ValidSettings }

function  TppComponentDesigner.ValidSettings: Boolean;
begin

  {descendants can override this validate any config settings and set the ErrorMessage}
  Result := True;

end;  {function, ValidSettings}

{------------------------------------------------------------------------------}
{ TppComponentDesigner.SetErrorMessage }

procedure  TppComponentDesigner.SetErrorMessage(aErrorMessage: String);
begin

  FErrorMessage := aErrorMessage;

end;  {procedure, SetErrorMessage}

{------------------------------------------------------------------------------}
{ TppComponentDesigner.ShowModal }

function TppComponentDesigner.ShowModal: Integer;
begin

{$IFDEF Delphi9}
  if (PopupParent = nil) then
    PopupParent := Screen.ActiveForm;
{$ELSE}
  if HandleAllocated then
    RecreateWnd;
{$ENDIF}

  Result := inherited ShowModal;

end;



{******************************************************************************
 *
 ** D E S I G N  M O D U L E
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppDesignModule.CreateModule }

constructor TppDesignModule.CreateModule(aParent: TWinControl; aComponentDesigner: TppComponentDesigner);
begin

  inherited Create(aParent);

  FParent := aParent;
  FComponentDesigner := aComponentDesigner;
  FOrderIndex := 0;
  FActive  := False;
  FCaption := '';

end; {constructor, CreateModule}

{------------------------------------------------------------------------------}
{ TppDesignModule.SetActive }

procedure TppDesignModule.SetActive(aValue: Boolean);
begin

  FActive := aValue;
  ActiveChanged;

end; {procedure, SetActive}

{------------------------------------------------------------------------------}
{ TppDesignModule.ActiveChanging }

procedure TppDesignModule.ActiveChanging(var aAllowChange: Boolean);
begin
  aAllowChange := True;

end; {procedure, ActiveChanging}

{------------------------------------------------------------------------------}
{ TppDesignModule.LoadStart }

procedure TppDesignModule.LoadStart;
begin

end; {procedure, LoadStart}

{------------------------------------------------------------------------------}
{ TppDesignModule.LoadEnd }

procedure TppDesignModule.LoadEnd;
begin

end; {procedure, LoadEnd}

{------------------------------------------------------------------------------}
{ TppDesignModule.SaveStart }

procedure TppDesignModule.SaveStart;
begin

end; {procedure, SaveStart}

{------------------------------------------------------------------------------}
{ TppDesignModule.LoadStateInfo }

procedure TppDesignModule.LoadStateInfo;
begin

end; {procedure, LoadStateInfo}

{------------------------------------------------------------------------------}
{ TppDesignModule.SaveStateInfo }

procedure TppDesignModule.SaveStateInfo;
begin

end; {procedure, SaveStateInfo}


{------------------------------------------------------------------------------}
{ TppDesignModule.ActiveChanged }

procedure TppDesignModule.ActiveChanged;
begin

end; {procedure, ActiveChanged}

{------------------------------------------------------------------------------}
{ TppDesignModule.SetComponent }

procedure TppDesignModule.SetComponent(aComponent: TComponent);
begin
  FComponent := aComponent;

end; {procedure, SetComponent}

{------------------------------------------------------------------------------}
{ TppDesignModule.SetLanguageIndex }

procedure TppDesignModule.SetLanguageIndex(aLanguageIndex: Integer);
begin
  FLanguageIndex := aLanguageIndex;

end; {procedure, SetLanguageIndex}

{------------------------------------------------------------------------------}
{ TppDesignModule.GetStatusBar }

function TppDesignModule.GetStatusBar: TppTBXStatusBar;
begin
  if (FComponentDesigner <> nil) then
    Result := FComponentDesigner.StatusBar
  else
    Result := nil;

end; {procedure, GetStatusBar}

{------------------------------------------------------------------------------}
{ TppDesignModule.CloseQuery }

procedure TppDesignModule.CloseQuery(var CanClose: Boolean);
begin

end; {procedure, CloseQuery}

{------------------------------------------------------------------------------}
{ TppDesignModule.Close }

procedure TppDesignModule.Close;
begin

end; {procedure, Close}

{------------------------------------------------------------------------------}
{ TppDesignModule.DoOnHelp}

procedure TppDesignModule.DoOnHelp(Sender: TObject; var aHelpFile, aKeyphrase: String; var aCallHelp: Boolean);
begin
  ComponentDesigner.DoOnHelp(Sender, aHelpFile, aKeyPhrase, aCallHelp);

end; {procedure, DoOnHelp}


{******************************************************************************
 *
 ** D E S I G N  M O D U L E   C O L L E C T I O N
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppDesignModuleCollection.Add}

procedure TppDesignModuleCollection.Add(aObject: TppDesignModule);
begin
  InnerList.Add(aObject);
end;

{------------------------------------------------------------------------------}
{ TppDesignModuleCollection.GetItemForIndex}

function TppDesignModuleCollection.GetItemForIndex( aIndex: Integer): TppDesignModule;
begin
  Result := TppDesignModule(InnerList[aIndex]);

end;

{------------------------------------------------------------------------------}
{ TppDesignModuleCollection.GetItemsByName}

function TppDesignModuleCollection.GetItemsByName(aName: String): TppDesignModule;
var
  liIndex: Integer;
begin
  liIndex := IndexOfName(aName);

  if (liIndex >= 0) then
    Result := GetItemForIndex(liIndex)
  else
    Result := nil;

end;

{------------------------------------------------------------------------------}
{ TppDesignModuleCollection.IndexOf}

function TppDesignModuleCollection.IndexOf(aObject: TppDesignModule): Integer;
begin
  Result := InnerList.IndexOf(aObject)

end;

{------------------------------------------------------------------------------}
{ TppDesignModuleCollection.IndexOfName}

function TppDesignModuleCollection.IndexOfName(aName: String): Integer;
var
  liIndex: Integer;
  lbFound: Boolean;
begin

  liIndex := 0;
  lbFound := False;

  while not(lbFound) and (liIndex < InnerList.Count) do
    begin
      if (GetItemForIndex(liIndex).Name = aName) then
        lbFound := True
      else
        Inc(liIndex);

    end;

  if lbFound then
    Result := liIndex
  else
    Result := -1;

end;

{------------------------------------------------------------------------------}
{ TppDesignModuleCollection.Remove}

procedure TppDesignModuleCollection.Remove(aObject: TppDesignModule);
begin
  InnerList.Remove(aObject);

end;



{******************************************************************************
 *
 ** D E S I G N E R  R E G I S T E R   P R O C E D U R E S
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ ppGetDesignerClassList }

function ppGetDesignerClassList: TStringList;
begin

  if (FDesignerClassList = nil) then
    FDesignerClassList := TStringList.Create;

  Result := FDesignerClassList;

end; {function, ppGetDesignerClassList}

{------------------------------------------------------------------------------}
{ ppGetComponentDesignerClass }

function ppGetComponentDesignerClass(aComponent: TComponent): TppComponentDesignerClass;
var
  liIndex: Integer;
  lClassList: TStringList;

begin
  lClassList := ppGetDesignerClassList;

  liIndex :=  lClassList.IndexOf(aComponent.ClassName);

  if liIndex >= 0 then
    Result := TppComponentDesignerClass(lClassList.Objects[liIndex])
  else
    Result := nil;

end; {function, ppGetComponentDesignerClass}

{------------------------------------------------------------------------------}
{ ppRegisterComponentDesigner }

procedure ppRegisterComponentDesigner(aComponentDesignerClass: TppComponentDesignerClass; aComponentClass: TComponentClass);
var
  lClassList: TStringList;
  lDesignerClass: TppComponentDesignerClass;
  liIndex: Integer;
begin
  if (aComponentDesignerClass = nil) or (aComponentClass = nil) then Exit;

  RegisterClass(aComponentDesignerClass);

  lClassList := ppGetDesignerClassList;

  liIndex :=  lClassList.IndexOf(aComponentClass.ClassName);

  if (liIndex = -1) then
    lClassList.AddObject(aComponentClass.ClassName, TObject(aComponentDesignerClass))

  else
    begin
      lDesignerClass := TppComponentDesignerClass(lClassList.Objects[liIndex]);

      UnRegisterClass(lDesignerClass);

      lClassList.Objects[liIndex] := TObject(aComponentDesignerClass);
    end;

end; {procedure, ppRegisterComponentDesigner}


{------------------------------------------------------------------------------}
{ ppUnRegisterComponentDesigner }

procedure ppUnRegisterComponentDesigner(aComponentDesignerClass: TppComponentDesignerClass; aComponentClass: TComponentClass);
var
  lClassList: TStringList;
  liIndex: Integer;
begin
  if (aComponentDesignerClass = nil) or (aComponentClass = nil) then Exit;


  lClassList := ppGetDesignerClassList;

  liIndex := lClassList.IndexOf(aComponentClass.ClassName);

  if (liIndex >= 0) then
    lClassList.Delete(liIndex);


end; {procedure, ppUnRegisterComponentDesigner}

{******************************************************************************
 *
 ** D E S I G N M O D U L E  R E G I S T E R   P R O C E D U R E S
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ ppGetDesignModuleClassList }

function ppGetDesignModuleClassList: TppRegList;
begin

  if (FDesignModuleClassList = nil) then
    FDesignModuleClassList := TppRegList.Create;

  Result := FDesignModuleClassList;

end; {function, ppGetDesignerClassList}


{------------------------------------------------------------------------------}
{ ppRegisterDesignModule }

procedure ppRegisterDesignModule(aDesignModuleClass: TppDesignModuleClass; const aComponentDesignerClassName: String);
var
  lClassList: TStringList;
  lDesignModuleClass: TppDesignModuleClass;
  liIndex: Integer;
  liClass: Integer;

begin

  if (aDesignModuleClass = nil) or (aComponentDesignerClassName = '') then Exit;

  RegisterClass(aDesignModuleClass);

  lClassList := ppGetDesignModuleClassList;

  liClass  := 0;
  liIndex := -1;

  while (liClass < lClassList.Count) and (liIndex = -1) do
    if (lClassList[liClass] = aComponentDesignerClassName) then
      begin
        lDesignModuleClass := TppDesignModuleClass(lClassList.Objects[liClass]);

        if lDesignModuleClass = aDesignModuleClass then
          liIndex := liClass
        else
          Inc(liClass);

      end;


  if (liIndex = -1) then
    lClassList.AddObject(aComponentDesignerClassName, TObject(aDesignModuleClass));


end; {procedure, ppRegisterDesignModule}

{------------------------------------------------------------------------------}
{ ppUnRegisterDesignModule }

procedure ppUnRegisterDesignModule(aDesignModuleClass: TppDesignModuleClass; const aComponentDesignerClassName: String);
var
  lClassList: TStringList;
  lsComponentDesignerClassName: String;
  lDesignModuleClass: TppDesignModuleClass;
  lbClassRemoved: Boolean;
  liIndex: Integer;
begin

  if (aDesignModuleClass = nil) or (aComponentDesignerClassName = '') then Exit;

  UnRegisterClass(aDesignModuleClass);

  if (FDesignModuleClassList = nil) then Exit;

  lClassList := ppGetDesignModuleClassList;

  liIndex  := 0;
  lbClassRemoved := False;

  while not(lbClassRemoved) and (liIndex < lClassList.Count) do
    begin
      lsComponentDesignerClassName := lClassList[liIndex];
      lDesignModuleClass := TppDesignModuleClass(lClassList.Objects[liIndex]);

      if (lsComponentDesignerClassName = aComponentDesignerClassName) and (lDesignModuleClass = aDesignModuleClass) then
        begin
          lClassList.Delete(liIndex);

          lbClassRemoved := True;
        end

      else
        Inc(liIndex);
    end;

end; {procedure, ppUnRegisterDesignModule}

{------------------------------------------------------------------------------}
{ ppGetDesignModuleClasses }

procedure ppGetDesignModuleClasses(aComponentDesignerClassName: String; aClassList: TList);
var
  lClassList: TStringList;
  liClass: Integer;

begin

  lClassList := ppGetDesignModuleClassList;

  for liClass := 0 to lClassList.Count-1 do

   if (lClassList[liClass] = aComponentDesignerClassName) then
      aClassList.Add(lClassList.Objects[liClass]);

end; {procedure, ppGetDesignModuleClasses}

{------------------------------------------------------------------------------}
{ ppSubscribeDesignModuleClassList }

procedure ppSubscribeDesignModuleClassList(aRegListSubscriber: TObject);
begin

  if aRegListSubscriber is TppRegListSubscriber then
    ppGetDesignModuleClassList.AddNotify(TppRegListSubscriber(aRegListSubscriber));

end; {procedure, ppSubscribeDesignModuleClassList}

{------------------------------------------------------------------------------}
{ ppUnSubscribeDesignModuleClassList }

procedure ppUnSubscribeDesignModuleClassList(aRegListSubscriber: TObject);
begin

  if aRegListSubscriber is TppRegListSubscriber then
    ppGetDesignModuleClassList.RemoveNotify(TppRegListSubscriber(aRegListSubscriber));

end;  {procedure, ppUnSubscribeDesignModuleClassList}

{------------------------------------------------------------------------------}
{ ppRegisterFormDesignerClass }

function ppGetFormDesignerClass: TppFormDesignerClass;
begin
  Result := FFormDesignerClass;
end;  {function, ppGetFormDesignerClass}

{------------------------------------------------------------------------------}
{ ppRegisterFormDesignerClass }

procedure ppRegisterFormDesignerClass(aFormDesignerClass: TppFormDesignerClass);
begin
  FFormDesignerClass := aFormDesignerClass;

end; {procedure, ppRegisterFormDesignerClass}

{******************************************************************************
 *
 ** I N I T I A L I Z A T I O N   /   F I N A L I Z A T I O N
 *
{******************************************************************************}


initialization

finalization

{$IFDEF Delphi9}
  uIHelp2 := nil;
{$ENDIF}
  
  FDesignerClassList.Free;
  FDesignerClassList := nil;

  FDesignModuleClassList.Free;
  FDesignModuleClassList := nil;

end.

