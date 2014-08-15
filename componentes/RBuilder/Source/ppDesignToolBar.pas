{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2006                   BBBBB   }

unit ppDesignToolBar;

interface

uses
  Controls,
  TypInfo,
  ActnList,

  ppTB2Item,

  ppRTTI,
  ppDesignToolActions,
  ppToolbarTBX;

type

  TppDesignToolActionLinkTB = class;


 {@TppDesignToolbar}
  TppDesignToolbar = class(TppToolbar)
  private
    FActionList: TppDesignToolActionList;
  protected
    property ActionList: TppDesignToolActionList read FActionList;
  public
    procedure Initialize(aParent: TWinControl; aActionList: TppDesignToolActionList); overload; virtual;

  end;

  {@TppDesignMenuBar}
  TppDesignMenuBar = class(TppMenuBar)
  private
    FActionList: TppDesignToolActionList;
  protected
    property ActionList: TppDesignToolActionList read FActionList;
  public
    procedure Initialize(aParent: TWinControl; aActionList: TppDesignToolActionList); overload; virtual;
  end;

  {TppDesignToolActionLinkTB}
  TppDesignToolActionLinkTB = class(TppTBCustomItemActionLink, IppDesignToolActionLink)
   protected
     function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
     function _AddRef: Integer; stdcall;
     function _Release: Integer; stdcall;

   public

     procedure UpdateClient(aPropName: String; aPropValue: Variant);  overload;
     procedure UpdateClient(aPropName: String; aPropValue: TObject); overload;
   end;

     {TppDesignToolActionLink}
  TppDesignToolActionLink = class(TActionLink, IppDesignToolActionLink)
   private
     FClient: TObject;
   protected
     procedure AssignClient(aClient: TObject); override;
     function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
     function _AddRef: Integer; stdcall;
     function _Release: Integer; stdcall;

   public
     procedure UpdateClient(aPropName: String; aPropValue: Variant);  overload;
     procedure UpdateClient(aPropName: String; aPropValue: TObject); overload;
     
   end;

  {@TppDesignEditToolItem}
  TppDesignEditToolItem = class(TppEditToolItem)
  protected
    function GetActionLinkClass: TppTBCustomItemActionLinkClass; override;
  end;

 {@TppDesignComboBoxToolItem}
  TppDesignComboBoxToolItem = class(TppComboBoxToolItem)
  protected
    function GetActionLinkClass: TppTBCustomItemActionLinkClass; override;
  end;

  {@TppDesignPalettButton}
  TppDesignPalettButton = class(TppPalettButton)
    function GetActionLinkClass: TppTBCustomItemActionLinkClass; override;
 end;

  {@TppDesignToolPalette}
   TppDesignToolPalette = class(TppToolPalette)
  protected
    function GetActionLinkClass: TActionLinkClass; override;
  end;

 
implementation

{------------------------------------------------------------------------------}
{ TppToolbar.Initialize}

procedure TppDesignToolbar.Initialize(aParent: TWinControl; aActionList: TppDesignToolActionList);
begin
  Parent := aParent;
  FActionList := aActionList;

  CreateItems();

end;

{------------------------------------------------------------------------------}
{ TppToolbar.Initialize}

procedure TppDesignMenuBar.Initialize(aParent: TWinControl; aActionList: TppDesignToolActionList);
begin
  Parent := aParent;
  FActionList := aActionList;

  CreateItems();

end;

{ QueryInterface

  Called each time an interface is requested. }

function TppDesignToolActionLinkTB.QueryInterface(const IID: TGUID; out Obj): HResult;
const
  E_NOINTERFACE = HResult($80004002);
begin

  if GetInterface(IID, Obj) then
    Result := 0
  else
    Result := E_NOINTERFACE;
    
end;

procedure TppDesignToolActionLinkTB.UpdateClient(aPropName: String; aPropValue: TObject);
begin
  if not TraRTTI.IsValidPropName(FClient, aPropName) then Exit;

  TraRTTI.SetPropValue(FClient, aPropName, aPropValue);

end;

procedure TppDesignToolActionLinkTB.UpdateClient(aPropName: String; aPropValue: Variant);
var
  lsValue: String;
  liValue: Integer;
  lPropType: TTypeKind;
begin

  if not TraRTTI.IsValidPropName(FClient, aPropName) then Exit;

  lPropType := TypInfo.PropType(FClient, aPropName);


  if lPropType = tkEnumeration then
    TypInfo.SetPropValue(FClient, aPropName, aPropValue)

  else if lPropType in [tkSet, tkInteger] then
    begin
      liValue := aPropValue;

      TypInfo.SetPropValue(FClient, aPropName, liValue);

    end
  else
    begin
      lsValue := aPropValue;

      TraRTTI.SetPropValueFromString(FClient, aPropName, lsValue);
    end;

end;

{  _AddRef

  Called each time an interface reference is created. }

function TppDesignToolActionLinkTB._AddRef: Integer;
begin
  Result := -1;
end;

{  _Release

  Called each time an interface variable is set to nil or goes out of scope. }

function TppDesignToolActionLinkTB._Release: Integer;
begin
  Result := -1;
end;


{ TppDesignToolActionLink }

procedure TppDesignToolActionLink.AssignClient(aClient: TObject);
begin

  FClient := aClient;
  
end;

{ QueryInterface

  Called each time an interface is requested. }

function TppDesignToolActionLink.QueryInterface(const IID: TGUID; out Obj): HResult;
const
  E_NOINTERFACE = HResult($80004002);
begin

  if GetInterface(IID, Obj) then
    Result := 0
  else
    Result := E_NOINTERFACE;
    
end;

procedure TppDesignToolActionLink.UpdateClient(aPropName: String; aPropValue: TObject);
begin
  if not TraRTTI.IsValidPropName(FClient, aPropName) then Exit;

  TraRTTI.SetPropValue(FClient, aPropName, aPropValue);

end;

procedure TppDesignToolActionLink.UpdateClient(aPropName: String; aPropValue: Variant);
var
  lsValue: String;
  liValue: Integer;
  lPropType: TTypeKind;
begin

  if not TraRTTI.IsValidPropName(FClient, aPropName) then Exit;

  lPropType := TypInfo.PropType(FClient, aPropName);

  if lPropType = tkEnumeration then
    TypInfo.SetPropValue(FClient, aPropName, aPropValue)

  else if lPropType in [tkSet, tkInteger] then
    begin
      liValue := aPropValue;

      TypInfo.SetPropValue(FClient, aPropName, liValue);

    end
  else
    begin
      lsValue := aPropValue;

      TraRTTI.SetPropValueFromString(FClient, aPropName, lsValue);
    end;

end;

{  _AddRef

  Called each time an interface reference is created. }

function TppDesignToolActionLink._AddRef: Integer;
begin
  Result := -1;
end;

{  _Release

  Called each time an interface variable is set to nil or goes out of scope. }

function TppDesignToolActionLink._Release: Integer;
begin
  Result := -1;
end;

function TppDesignEditToolItem.GetActionLinkClass: TppTBCustomItemActionLinkClass;
begin
  Result := TppDesignToolActionLinkTB;
end;

function TppDesignComboBoxToolItem.GetActionLinkClass: TppTBCustomItemActionLinkClass;
begin
  Result := TppDesignToolActionLinkTB;
end;

{ TppDesignPalettButton }

function TppDesignPalettButton.GetActionLinkClass: TppTBCustomItemActionLinkClass;
begin
  Result := TppDesignToolActionLinkTB;

end;

{ TppDesignToolPalette }

function TppDesignToolPalette.GetActionLinkClass: TActionLinkClass;
begin
  Result := TppDesignToolActionLink;

end;









end.
