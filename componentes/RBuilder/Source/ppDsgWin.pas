{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2008                    BBBBB   }

unit ppDsgWin;

interface

{$I ppIfDef.pas}

uses
  {$IFDEF Delphi9}ppHelp2_TLB,{$ENDIF}
  {$IFDEF Delphi9}ExtCtrls,{$ENDIF}
  {$IFDEF Delphi6} DesignIntf, DesignWindows, {$ELSE} DsgnIntf, DsgnWnds, {$ENDIF}
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ppDsIntf, TypInfo;

type

  {@TppDesignWindow }
  TppDesignWindow = class(TDesignWindow)
    private
      FRBComponentDesigner: TppComponentDesigner;
      FForm: TForm;
      FSelectionChanging: Boolean;
      
      procedure SetRBComponentDesigner(aComponentDesigner: TppComponentDesigner);

    protected
      function UniqueName(Component: TComponent): string; override;
      procedure Notification(aComponent: TComponent; Operation: TOperation); override;

      procedure SetDesignerSelection(aSelection: TppDesignerSelectionList);

    public
      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;

      {inherited from TDesignWindow}
{$IFDEF Delphi6}
      procedure ItemDeleted(const aDesigner: IDesigner; Item: TPersistent); override;
      procedure DesignerOpened(const Designer: IDesigner; AResurrecting: Boolean); override;
      procedure DesignerClosed(const Designer: IDesigner; aGoingDormant: Boolean); override;
      {procedure WindowHide; override;
      procedure WindowShow; override;}

{$ELSE}
      procedure ComponentDeleted(Component: IPersistent); override;
      procedure FormClosed(aCustomForm: TCustomForm); override;
{$ENDIF}

{$IFDEF Delphi6}
      procedure SelectionChanged(const aDesigner: IDesigner; const aSelection: IDesignerSelections); override;
{$ELSE} {$IFDEF Delphi5}
      procedure SelectionChanged(ASelection: TDesignerSelectionList); override;
{$ELSE}
      procedure SelectionChanged(aSelection: TComponentList); override;
{$ENDIF} {$ENDIF}

      property RBComponentDesigner: TppComponentDesigner read FRBComponentDesigner write SetRBComponentDesigner;
      property Form: TForm read FForm write FForm;

  end; {class, TppDesignWindow}



  {@TppDelphiFormDesigner }
  TppDelphiFormDesigner = class(TppFormDesigner)
    private
      FMethods: TStringList;
{$IFDEF Delphi6}
      FFormDesigner: IDesigner;
{$ELSE}
      FFormDesigner: IFormDesigner;
{$ENDIF}
{$IFDEF Delphi9}
      FTimer: TTimer;

      procedure ehTimerNotification(Sender: TObject);
{$ENDIF}

      procedure GetMethodsProc(const MethodName: String);

    protected

      function GetActive: Boolean; override;

    public
{$IFDEF Delphi6}
      constructor Create(aIDesigner: IInterface); override;
      destructor Destroy; override;
      procedure SetDesigner(aIDesigner: IInterface); override;
{$ELSE}
      constructor Create(aIDesigner: IUnknown); override;
      procedure SetDesigner(aIDesigner: IUnknown); override;
{$ENDIF}

      function  CreateComponent(ComponentClass: TComponentClass; Parent: TComponent; Left, Top, Width, Height: Integer): TComponent; override;
      procedure GetComponentNames(TypeData: PTypeData; Proc: TGetStrProc); override;
      function  MethodExists(const Name: string): Boolean; override;
      procedure Modified; override;

      function GetMethodAddress(aComponent: TComponent; const aMethodName: string; var aAddress: Pointer): Boolean; override;

      function  GetComponent(const Name: string): TComponent; override;
      function CreateMethod(const Name: string; TypeData: PTypeData): TMethod;  override;
      procedure GetMethods(TypeData: PTypeData; Proc: TGetStrProc); override;

       {procedure AddToInterface(InvKind: Integer; const Name: string; VT: Word; const TypeInfo: string);
       function  CreateComponent(ComponentClass: TComponentClass; Parent: TComponent; Left, Top, Width, Height: Integer): TComponent;
       function  MethodFromAncestor(const Method: TMethod): Boolean;
       procedure MakeComponentLinkable(Component: TComponent);
       function  GetAncestorDesigner: IFormDesigner;
       function  GetComponentName(Component: TComponent): string;
       function  GetIsDormant: Boolean;
       function  GetMethodName(const Method: TMethod): string;
       function  GetObject(const Name: string): TPersistent;
       function  GetObjectName(Instance: TPersistent): string;
       procedure GetObjectNames(TypeData: PTypeData; Proc: TGetStrProc);
       function  GetPrivateDirectory: string;
       procedure GetProjectModules(Proc: TGetModuleProc);
       function  GetRoot: TComponent;
       procedure GetSelections(const List: IDesignerSelections);
       function  HasInterface: Boolean;
       function  HasInterfaceMember(const Name: string): Boolean;
       function  IsSourceReadOnly: Boolean;
       function  IsComponentLinkable(Component: TComponent): Boolean;
       procedure RenameMethod(const CurName, NewName: string);
       procedure Revert(Instance: TPersistent; PropInfo: PPropInfo);
       procedure SelectComponent(Instance: TPersistent);
       procedure SetSelections(const List: IDesignerSelections);
       procedure ShowMethod(const Name: string);
       function  UniqueName(const BaseName: string): string;

       property  AncestorDesigner: IFormDesigner read GetAncestorDesigner;
       property  IsDormant: Boolean read GetIsDormant; }


   end; {class, TppFormDesigner}

{$IFDEF Delphi9}

  {TppBDSHelp2 }
  TppBDSHelp2 = class(TInterfacedObject, IppHelp2)
    private
      FIHelp: ppHelp2_TLB.Help;

      class function CollectionName: String;
      class function DefaultTopicURL: String;

      function GetIHelp: ppHelp2_TLB.Help;
      procedure DisplayDefaultTopic;
      procedure DisplayTopicFromURL(aURL: String);

    public
      procedure iDisplayTopicFromKeyword(aKeyWord: String);
  end;

{$ENDIF}

var
  ppDesignWindow: TppDesignWindow;

implementation

{$R *.DFM}

{------------------------------------------------------------------------------}
{ TppDesignWindow.Create }

constructor TppDesignWindow.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  FRBComponentDesigner := nil;
  FForm := nil;
  FSelectionChanging := False;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppDesignWindow.Destroy }

destructor TppDesignWindow.Destroy;
begin

  FForm := nil;
  FRBComponentDesigner.Free;
  FRBComponentDesigner := nil;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppDesignWindow.SetRBComponentDesigner }

procedure TppDesignWindow.SetRBComponentDesigner(aComponentDesigner: TppComponentDesigner);
begin
  if (FRBComponentDesigner <> nil) then
    FRBComponentDesigner.OnSetSelection := nil;

  FRBComponentDesigner := aComponentDesigner;

  if (FRBComponentDesigner <> nil) then
    FRBComponentDesigner.OnSetSelection := SetDesignerSelection;

end; {procedure, SetRBComponentDesigner}

{------------------------------------------------------------------------------}
{ TppDesignWindow.Notification }

procedure TppDesignWindow.Notification(AComponent: TComponent; Operation: TOperation);
begin

  inherited Notification(AComponent, Operation);

  if (aComponent = FRBComponentDesigner) and (Operation = opRemove) then
    begin

       SetRBComponentDesigner(nil);

       {note: must use Release here rather than Free or get an Access Violation}
       if not (csDestroying in ComponentState) then
       begin
{$IFDEF Delphi5}
         Designer.ClearSelection;
{$ENDIF}
         Release;
       end;

    end;

end; {procedure, Notification}

{$IFDEF Delphi6}

{------------------------------------------------------------------------------}
{ TppDesignWindow.DesignerOpened }

procedure TppDesignWindow.DesignerOpened(const Designer: IDesigner; aResurrecting: Boolean);
begin

end; {procedure, DesignerOpened}

{------------------------------------------------------------------------------}
{ TppDesignWindow.DesignerClosed }

procedure TppDesignWindow.DesignerClosed(const Designer: IDesigner; aGoingDormant: Boolean);
begin

  inherited DesignerClosed(Designer, aGoingDormant);

  if (Designer = Self.Designer) then
    Free;


end; {procedure, DesignerClosed}

{------------------------------------------------------------------------------}
{ TppDesignWindow.ItemDeleted }

procedure TppDesignWindow.ItemDeleted(const aDesigner: IDesigner; Item: TPersistent);
begin

  inherited ItemDeleted(aDesigner, Item);

  if (FRBComponentDesigner <> nil) and (Item = FRBComponentDesigner.Component) then
    Free;

end; {procedure, ComponentDeleted}

{$ELSE}

{------------------------------------------------------------------------------}
{ TppDesignWindow.FormClosed }

procedure TppDesignWindow.FormClosed(aCustomForm: TCustomForm);
begin

  if (aCustomForm = FForm) then
    Free;

end; {procedure, FormClosed}

{------------------------------------------------------------------------------}
{ TppDesignWindow.ComponentDeleted }

procedure TppDesignWindow.ComponentDeleted(Component: IPersistent);
begin

  inherited ComponentDeleted(Component);

  if (FRBComponentDesigner <> nil) and
     (ExtractPersistent(Component) = FRBComponentDesigner.Component) then
    Free;

end; {procedure, ComponentDeleted}

{$ENDIF}

{------------------------------------------------------------------------------}
{ TppDesignWindow.SelectionChanged }

{$IFDEF Delphi6}
procedure TppDesignWindow.SelectionChanged(const aDesigner: IDesigner; const aSelection: IDesignerSelections);
{$ELSE} {$IFDEF Delphi5}
procedure TppDesignWindow.SelectionChanged(aSelection: TDesignerSelectionList);
{$ELSE}
procedure TppDesignWindow.SelectionChanged(aSelection: TComponentList);
{$ENDIF}{$ENDIF}
var
  lComponentList: TppDesignerSelectionList;
  liSelection: Integer;
begin

  {check whether SelectionChange fired due to SetDesignerSelection method}
  if FSelectionChanging then Exit;

  lComponentList := TppDesignerSelectionList.Create;

  for liSelection := 0 to aSelection.Count-1 do
    lComponentList.Add(aSelection[liSelection]);

  FSelectionChanging := True;

  try
    if (FRBComponentDesigner <> nil) then
      FRBComponentDesigner.SelectionChanged(lComponentList);
  finally
    FSelectionChanging := False;
    lComponentList.Free;
  end;


end; {procedure, SelectionChanged}

{------------------------------------------------------------------------------}
{ TppDesignWindow.SetDesignerSelection }

procedure TppDesignWindow.SetDesignerSelection(aSelection: TppDesignerSelectionList);
var
  liIndex: Integer;
{$IFDEF Delphi6}
  lSelection: TDesignerSelections;
{$ELSE} {$IFDEF Delphi5}
  lSelection: TDesignerSelectionList;
{$ELSE}
  lSelection: TComponentList;
{$ENDIF}{$ENDIF}

begin
  if FSelectionChanging then Exit;

{$IFDEF Delphi6}
  lSelection := TDesignerSelections.Create;
{$ELSE} {$IFDEF Delphi5}
  lSelection := TDesignerSelectionList.Create;
{$ELSE}
  lSelection := TComponentList.Create;
{$ENDIF} {$ENDIF}

{$IFDEF Delphi6}
  for liIndex := 0 to aSelection.Count-1 do
    IDesignerSelections(lSelection).Add(aSelection[liIndex]);

{$ELSE}
  for liIndex := 0 to aSelection.Count-1 do
    lSelection.Add(aSelection[liIndex]);
{$ENDIF}

  {notify object inspector}
  FSelectionChanging := True;
  try
    SetSelection(lSelection);
  finally
    FSelectionChanging := False;
  end;


end; {procedure, SetDesignerSelection}

{------------------------------------------------------------------------------}
{ TppDesignWindow.UniqueName }

function TppDesignWindow.UniqueName(Component: TComponent): string;
begin
  Result := '';
end; {function, UniqueName}

{******************************************************************************
 *
 ** F O R M   D E S I G N E R
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppDelphiFormDesigner.Create }

{$IFDEF Delphi6}
constructor TppDelphiFormDesigner.Create(aIDesigner: IInterface);
begin
  inherited Create(aIDesigner);

  FFormDesigner := IDesigner(aIDesigner);

{$IFDEF Delphi9}
  FTimer := TTimer.Create(nil);
  FTimer.Enabled := False;
  FTimer.Interval := 500;
  FTimer.OnTimer := ehTimerNotification;
{$ENDIF}

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppDelphiFormDesigner.Destroy }

destructor TppDelphiFormDesigner.Destroy;
begin

{$IFDEF Delphi9}
  FTimer.Free;
{$ENDIF}

  inherited Destroy;

end;

{------------------------------------------------------------------------------}
{ TppDelphiFormDesigner.SetDesigner }

procedure TppDelphiFormDesigner.SetDesigner(aIDesigner: IInterface);
begin

  FFormDesigner := IDesigner(aIDesigner);

end; {procedure, SetDesigner}

{$ELSE}

constructor TppDelphiFormDesigner.Create(aIDesigner: IUnknown);
begin
  inherited Create(aIDesigner);

  FFormDesigner := IFormDesigner(aIDesigner);

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppDelphiFormDesigner.SetDesigner }

procedure TppDelphiFormDesigner.SetDesigner(aIDesigner: IUnknown);
begin

  FFormDesigner := IFormDesigner(aIDesigner);

end; {procedure, SetDesigner}

{$ENDIF}

{------------------------------------------------------------------------------}
{ TppDelphiFormDesigner.GetActive }

function TppDelphiFormDesigner.GetActive: Boolean;
begin
  Result := (FFormDesigner <> nil);

end; {function, GetActive}

{------------------------------------------------------------------------------}
{ TppDelphiFormDesigner.CreateComponent }

function TppDelphiFormDesigner.CreateComponent(ComponentClass: TComponentClass; Parent: TComponent; Left, Top, Width, Height: Integer): TComponent;
begin
  if (FFormDesigner <> nil) then
    Result := FFormDesigner.CreateComponent(ComponentClass, Parent, Left, Top, Width, Height)
  else
    Result := nil;
end; {function, CreateComponent}

{------------------------------------------------------------------------------}
{ TppDelphiFormDesigner.Modified }


{$IFDEF Delphi9}
procedure TppDelphiFormDesigner.Modified;
begin
  if not FTimer.Enabled then
    FTimer.Enabled := True;
    
end; {procedure, Modified}

procedure TppDelphiFormDesigner.ehTimerNotification(Sender: TObject);
begin
  if (FFormDesigner <> nil) then
    FFormDesigner.Modified;

  FTimer.Enabled := False;
  
end;

{$ELSE}

procedure TppDelphiFormDesigner.Modified;
begin
  if (FFormDesigner <> nil) then
    FFormDesigner.Modified;
end; {procedure, Modified}

{$ENDIF}

{------------------------------------------------------------------------------}
{ TppDelphiFormDesigner.GetComponent }

function TppDelphiFormDesigner.GetComponent(const Name: string): TComponent;
begin
  if (FFormDesigner <> nil) then
    Result := FFormDesigner.GetComponent(Name)
  else
    Result := nil;
end; {procedure, GetComponent}

{------------------------------------------------------------------------------}
{ TppDelphiFormDesigner.GetComponentNames }

procedure TppDelphiFormDesigner.GetComponentNames(TypeData: PTypeData; Proc: TGetStrProc);
begin
  if (FFormDesigner <> nil) then
    FFormDesigner.GetComponentNames(TypeData, Proc);
end; {procedure, GetComponentNames}

{------------------------------------------------------------------------------}
{ TppDelphiFormDesigner.MethodExists }

function TppDelphiFormDesigner.MethodExists(const Name: String): Boolean;
begin
  if (FFormDesigner <> nil) then
    Result := FFormDesigner.MethodExists(Name)
  else
    Result := False;
end; {function, MethodExists}

{------------------------------------------------------------------------------}
{ TppDelphiFormDesigner.CreateMethod }

function TppDelphiFormDesigner.CreateMethod(const Name: string; TypeData: PTypeData): TMethod;
begin
  if (FFormDesigner <> nil) then
    Result := FFormDesigner.CreateMethod(Name, TypeData);
end; {function, CreateMethod}

{------------------------------------------------------------------------------}
{ TppDelphiFormDesigner.GetMethods }

procedure TppDelphiFormDesigner.GetMethods(TypeData: PTypeData; Proc: TGetStrProc);
begin
  if (FFormDesigner <> nil) then
    FFormDesigner.GetMethods(TypeData, Proc);
end; {procedure, GetMethods}

{------------------------------------------------------------------------------}
{ TppDelphiFormDesigner.GetMethodAddress }

function TppDelphiFormDesigner.GetMethodAddress(aComponent: TComponent; const aMethodName: string; var aAddress: Pointer): Boolean;
var
  liPropCount,
  liMethodCount,
  liMethod: Integer;
  lMethod: TMethod;
  lPPropList: PPropList;
  lbMethodExists: Boolean;
  lDesigner: IDesigner;

begin

  Result := False;

  aAddress := nil;

  if (FFormDesigner = nil) or (aComponent = nil) then Exit;

  lPPropList := nil;

  lDesigner := FFormDesigner;

{$IFDEF Delphi9}
  repeat
    lbMethodExists := lDesigner.MethodExists(aMethodName);

    if not(lbMethodExists) then
      lDesigner := lDesigner.AncestorDesigner;

  until lbMethodExists or (lDesigner = nil);
{$ELSE}

  lbMethodExists := lDesigner.MethodExists(aMethodName);

{$ENDIF}


  {ask the designer whether this method exists }
  if lbMethodExists then
    try

      {allocate memory for property list }
      liPropCount := GetTypeData(aComponent.ClassInfo)^.PropCount;

      GetMem(lPPropList, liPropCount * SizeOf(Pointer));

      {create string list used to store method names}
      FMethods := TStringList.Create;

      {get methods props for the current component }
      liMethodCount := GetPropList(aComponent.ClassInfo, [tkMethod], lPPropList);

      liMethod := 0;

     {look for the address of the method }
      while (aAddress = nil) and (liMethod < liMethodCount) do
        begin

          FMethods.Clear;
          {ask designer for list of method names that are valid for the method type}

          lDesigner.GetMethods(GetTypeData(lPPropList^[liMethod]^.PropType^), GetMethodsProc);

          {check whether the method we're looking for is in the list }
          if FMethods.IndexOf(aMethodName) >= 0 then
            begin
              {get the address from the designer }

              lMethod := lDesigner.CreateMethod(aMethodName, GetTypeData(lPPropList^[liMethod]^.PropType^));

              aAddress := lMethod.Code;

            end;

          Inc(liMethod);

        end;

    finally

      FMethods.Free;

      FreeMem(lPPropList);


    end;

  Result := (aAddress <> nil);

end; {procedure, GetMethodAddress}

{------------------------------------------------------------------------------}
{ TppDelphiFormDesigner.GetMethodsProc - call back proc for Designer.GetMethods routine }

procedure TppDelphiFormDesigner.GetMethodsProc(const MethodName: String);
begin
  FMethods.Add(MethodName);

end; {procedure, GetMethodsProc}

{$IFDEF Delphi9}

{******************************************************************************
 *
 ** BDS Help2
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppBDSHelp2.CollectionName}

class function TppBDSHelp2.CollectionName: String;
begin

  {$IFDEF Delphi14}
    Result := 'ms-help://embarcadero.rs2010';
  {$ELSE} {$IFDEF Delphi12}
    Result := 'ms-help://embarcadero.rs2009';
  {$ELSE} {$IFDEF Delphi11}
    Result := 'ms-help://borland.bds5';
  {$ELSE} {$IFDEF Delphi10}
    Result := 'ms-help://borland.bds4';
  {$ELSE}
    Result := 'ms-help://borland.bds3';
  {$ENDIF}
  {$ENDIF}
  {$ENDIF}
  {$ENDIF}

end;

{------------------------------------------------------------------------------}
{ TppBDSHelp2.DefaultTopicURL}

class function TppBDSHelp2.DefaultTopicURL: String;
begin

  {$IFDEF Delphi14}
    Result := 'ms-help://embarcadero.rs2010/rbuilder/DelphiComponents_htm.html';
  {$ELSE} {$IFDEF Delphi12}
    Result := 'ms-help://embarcadero.rs2009/rbuilder/DelphiComponents_htm.html';
  {$ELSE} {$IFDEF Delphi11}
    Result := 'ms-help://borland.bds5/rbuilder/DelphiComponents_htm.html';
  {$ELSE} {$IFDEF Delphi10}
    Result := 'ms-help://borland.bds4/bds4start/html/intro.htm';
  {$ELSE}
    Result := 'ms-help://borland.bds3/bds3start/html/intro.htm';
  {$ENDIF}
  {$ENDIF}
  {$ENDIF}
  {$ENDIF}

end;

{------------------------------------------------------------------------------}
{ TppBDSHelp2.GetIHelp}

function TppBDSHelp2.GetIHelp: ppHelp2_TLB.Help;
begin

  if (FIHelp = nil) then
    begin
      FIHelp := CoDExploreAppObj.Create;
      FIHelp.SetCollection(TppBDSHelp2.CollectionName, '');
    end;

  Result := FIHelp;

end;

{------------------------------------------------------------------------------}
{ TppBDSHelp2.iDisplayTopicFromKeyword}

procedure TppBDSHelp2.iDisplayTopicFromKeyword(aKeyWord: String);
begin
  try

    if (aKeyWord <> '') then
      begin
        // display topic
        GetIHelp.DisplayTopicFromF1Keyword(aKeyWord);

        // sync index and show
//        try
          GetIHelp.SyncIndex(aKeyWord, Ord(True));
//        except
          // suppress exception;
//        end;

      end

    else
      DisplayDefaultTopic;

  except
    DisplayDefaultTopic;

  end;

end;

{------------------------------------------------------------------------------}
{ TppBDSHelp2.DisplayDefaultTopic}

procedure TppBDSHelp2.DisplayDefaultTopic;
begin
  DisplayTopicFromURL(TppBDSHelp2.DefaultTopicURL);
end;

{------------------------------------------------------------------------------}
{ TppBDSHelp2.DisplayTopicFromURL}

procedure TppBDSHelp2.DisplayTopicFromURL(aURL: String);
begin

  try
    GetIHelp.DisplayTopicFromURL(aURL);
  except
  end;

end;

{$ENDIF}


initialization

  ppRegisterFormDesignerClass(TppDelphiFormDesigner);

{$IFDEF Delphi9}
  TppHelp2Manager.RegisterIHelp2(TppBDSHelp2);
{$ENDIF}


finalization

  ppRegisterFormDesignerClass(nil);



end.
