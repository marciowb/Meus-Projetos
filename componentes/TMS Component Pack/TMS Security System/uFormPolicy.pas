{***********************************************************************}
{ TMS Security System                                                   }
{ for Delphi & C++Builder                                               }
{                                                                       }
{ written by                                                            }
{   TMS Software                                                        }
{   Copyright © 2003 - 2009                                             }
{   Email : info@tmssoftware.com                                        }
{   Web : http://www.tmssoftware.com                                    }
{***********************************************************************}
unit uFormPolicy;

interface

{$I TMSDEFS.INC}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, TypInfo,
  uSecControl, ComCtrls, uBindary
  {$IFDEF DELPHI6_LVL}
  , Variants
  {$ENDIF}
  ;

type

  TPolicyAction = (paDisable, paHide, paCustom, paReadOnly);
  TuilPolicy = class;
  TuilPolicyItem = class;

  TCustomSecureEvent = procedure(Sender: TObject; AComponent: TComponent; Secure: Boolean) of object;

  TuilFormPolicy = class(TComponent)
  private
    FPolicies: TuilPolicy;
    FSecurityManager: TuilSecurityManager;
    FOnCustomSecure: TCustomSecureEvent;
    FActive: Boolean;
  protected
    function GetSecurityManager: TuilSecurityManager;
    procedure SetSecurityManager(newValue: TuilSecurityManager);
    function GetVersion: string; virtual;
    procedure SetVersion(NewValue: string);
    function GetPolicies: TuilPolicy; virtual;
    procedure SetPolicies(NewValue: TuilPolicy);
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; operation: TOperation); override;
    procedure CustomSecure(AComponent: TComponent; Secure: Boolean); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Apply; virtual;
    procedure LoadFromDataBase(AFormName: string); virtual;
    procedure RemoveFromDataBase(AFormName,APermission: string); virtual;
  published
    property Active: Boolean read FActive write FActive default true;
    property Policies: TuilPolicy read GetPolicies write SetPolicies;
    property SecurityManager: TuilSecurityManager read GetSecurityManager write SetSecurityManager;
    property Version: string read GetVersion write SetVersion;
    property OnCustomSecure: TCustomSecureEvent read FOnCustomSecure write FOnCustomSecure;
  end;

  TuilPolicy = class(TCollection)
  private
    FFormPolicy: TuilFormPolicy;
    function GetItem(Index: Integer): TuilPolicyItem;
    procedure SetItem(Index: Integer; const Value: TuilPolicyItem);
  protected
    function GetOwner: TPersistent; override;
  public
    constructor Create(FormPolicy: TuilFormPolicy);
    destructor Destroy; override;
    property FormPolicy: TuilFormPolicy read FFormPolicy write FFormPolicy;
    function Add: TuilPolicyItem;
    function Insert(Index: Integer): TuilPolicyItem;
    property Items[Index: Integer]: TuilPolicyItem read GetItem write SetItem;
  end;

  TuilPolicyItem = class(TCollectionItem)
  private
    FItems: TStrings;
    FPolicyName: string;
    FPolicyAction: TPolicyAction;
  protected
    function GetDisplayName: string; override;
    function GetName: string; virtual;
    procedure SetName(newValue: string); virtual;
    procedure SetItems(const Value: TStrings);
    procedure SecureItems(Value: boolean); virtual;
    procedure RemoveItem(AItem: string);
  public
    procedure Activate;
    procedure Deactivate;
  published
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    property Items: TStrings read FItems write SetItems;
    property PolicyName: string read GetName write SetName;
    property PolicyAction: TPolicyAction read FPolicyAction write FPolicyAction;
  end;

implementation

uses usmGlobals;

{ TuilPolicy }

function TuilPolicy.Add: TuilPolicyItem;
begin
  Result := TuilPolicyItem(inherited Add);
end;

constructor TuilPolicy.Create(FormPolicy: TuilFormPolicy);
begin
  inherited Create(TuilPolicyItem);
  FFormPolicy := FormPolicy;
end;

destructor TuilPolicy.Destroy;
begin

  inherited Destroy;
end;

function TuilPolicy.GetItem(Index: Integer): TuilPolicyItem;
begin
  Result := TuilPolicyItem(inherited Items[Index]);
end;

function TuilPolicy.GetOwner: TPersistent;
begin
  Result := FFormPolicy;
end;


function TuilPolicy.Insert(Index: Integer): TuilPolicyItem;
begin
  Result := TuilPolicyItem(inherited Insert(Index));
end;

procedure TuilPolicy.SetItem(Index: Integer; const Value: TuilPolicyItem);
begin
  inherited Items[Index] := Value;
end;

{ TuilPolicyItem }


constructor TuilPolicyItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FItems := TStringList.Create;
end;

destructor TuilPolicyItem.Destroy;
begin
  FItems.Free;
  FItems := nil;
  inherited Destroy;
end;

function TuilPolicyItem.GetDisplayName: string;
begin
  Result := FPolicyName;
end;

function TuilPolicyItem.GetName: string;
begin
  Result := FPolicyName;
end;

procedure TuilPolicyItem.SetName(newValue: string);
begin
  if FPolicyName <> newValue then
    FPolicyName := newValue;
end;

procedure TuilPolicyItem.SetItems(const Value: TStrings);
begin
  FItems.Assign(Value);
end;

procedure TuilPolicyItem.SecureItems(Value: boolean);
var
  PropString: string;
  Comp: TComponent;
  PropInfo: PPropInfo;
  j: longint;
begin
  case FPolicyAction of
  paDisable: PropString := 'Enabled';
  paHide: PropString := 'Visible';
  paReadOnly: PropString := 'ReadOnly';
  end;

  for j := 0 to FItems.Count - 1 do
  begin
    Comp := (Collection as TuilPolicy).FormPolicy.Owner.FindComponent(FItems[j]);
    
    if Assigned(Comp) then
    begin
      case FPolicyAction of
      paHide:
        begin
          if (Comp is TTabSheet) or (Comp.ClassName = 'TAdvOfficePage') then
          begin
            PropInfo := GetPropInfo(Comp.ClassInfo, 'TabVisible');
            if PropInfo <> nil then
            begin
              if Value then
                SetOrdProp(Comp, PropInfo, integer(False))
              else
                SetOrdProp(Comp, PropInfo, integer(True))
            end
          end
          else
          begin
            PropInfo := GetPropInfo(Comp.ClassInfo, PropString);
            if PropInfo <> nil then
            begin
              if Value then
                SetOrdProp(Comp, PropInfo, integer(False))
              else
                SetOrdProp(Comp, PropInfo, integer(True))
            end;
          end;
        end;
      paDisable, paReadOnly:
        begin
          if (Comp.ClassName = 'TAdvOfficePage') then
          begin
            PropInfo := GetPropInfo(Comp.ClassInfo, 'TabEnabled');
            if PropInfo <> nil then
            begin
              if Value then
                SetOrdProp(Comp, PropInfo, integer(False))
              else
                SetOrdProp(Comp, PropInfo, integer(True))
            end
          end
          else
          begin
            PropInfo := GetPropInfo(Comp.ClassInfo, PropString);
            if PropInfo <> nil then
            begin
              if Value then
                SetOrdProp(Comp, PropInfo, integer(False))
              else
                SetOrdProp(Comp, PropInfo, integer(True))
            end
          end;
        end;
      paCustom:
        begin
          (Collection as TuilPolicy).FormPolicy.CustomSecure(Comp, Value);
        end;
      end;
    end;
  end;
end;

procedure TuilPolicyItem.Activate;
begin
  SecureItems(True);
end;

procedure TuilPolicyItem.Deactivate;
begin
  SecureItems(False);
end;

procedure TuilPolicyItem.RemoveItem(AItem: string);
var
  Index: Integer;
begin
  Index := FItems.IndexOf(AItem);
  if Index > -1 then
    FItems.Delete(Index);
end;

{ TuilFormPolicy }

procedure TuilFormPolicy.Loaded;
begin
  inherited Loaded;

  if not (csDesigning in ComponentState) then
  begin
    LoadFromDataBase(Owner.Name);
  end;  

  if Active then
  begin
    if Assigned(FSecurityManager) then
      if FSecurityManager.Active then
        Apply;
  end;      
end;

constructor TuilFormPolicy.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

{$IFDEF Shareware}
{$I uShareware.inc}
{$ENDIF}

  FPolicies := TuilPolicy.Create(Self);
  FActive := True;
end;

destructor TuilFormPolicy.Destroy;
begin
  if Assigned(FSecurityManager) then
    FSecurityManager.Detach(Self);

  FPolicies.Free;
  FPolicies := nil;
  inherited Destroy;
end;

function TuilFormPolicy.GetPolicies: TuilPolicy;
begin
  result := FPolicies;
end;

procedure TuilFormPolicy.SetPolicies(newValue: TuilPolicy);
begin
  FPolicies.Assign(newValue);
end;

function TuilFormPolicy.GetSecurityManager: TuilSecurityManager;
begin
  Result := FSecurityManager;
end;

function TuilFormPolicy.GetVersion: string;
begin
  Result := VersionString;
end;

procedure TuilFormPolicy.SetVersion(NewValue: string);
begin
   // Do nothing;
end;


procedure TuilFormPolicy.SetSecurityManager(newValue: TuilSecurityManager);
begin
  if FSecurityManager <> newValue then
  begin
    if Assigned(FSecurityManager) then
      FSecurityManager.Detach(Self);

    if FSecurityManager <> newValue then
    begin
      FSecurityManager := newValue;
      if FSecurityManager <> nil then
        FSecurityManager.Attach(Self);
    end;
  end;
end;


procedure TuilFormPolicy.Apply;
var
  j: integer;
  PolicyName: string;
begin
  if csDesigning in ComponentState then
    Exit;

   // This routine now automatically disables/hides ALL policies
   // then selectively enables/shows them. This allows the same
   // component to reside in multiple policies.
  for j := 0 to FPolicies.Count - 1 do
  begin
    (FPolicies.Items[j] as TuilPolicyItem).Activate;
  end;  

  for j := 0 to FPolicies.Count - 1 do
  begin
    PolicyName := (FPolicies.Items[j] as TuilPolicyItem).PolicyName;
    if FSecurityManager.HasPermission(PolicyName) then
      (FPolicies.Items[j] as TuilPolicyItem).Deactivate;
  end;
end;

//procedure TuilFormPolicy.Deactivate;
//var
//   j : integer;
//   PolicyName : string;
//begin
//   if csDesigning in ComponentState then Exit;
//   for j := 0 to FPolicies.Count-1 do
//   begin
//      PolicyName := (FPolicies.Items[j] as TuilPolicyItem).PolicyName;
//      if FSecurityManager.HasPermission(PolicyName) then
//         (FPolicies.Items[j] as TuilPolicyItem).Deactivate;
//   end;
//end;

procedure TuilFormPolicy.Notification(AComponent: TComponent;
  operation: TOperation);
var
  j: integer;
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
  begin
    if AComponent = FSecurityManager then
      FSecurityManager := nil
    else
    begin
      if Assigned(FPolicies) then
        for j := 0 to FPolicies.Count - 1 do // Iterate
          (FPolicies.Items[j] as TuilPolicyItem).RemoveItem(AComponent.Name);
    end;
  end;
end;

procedure TuilFormPolicy.RemoveFromDataBase(AFormName,APermission: string);
begin
  if Assigned(FSecurityManager) then
  begin
    if FSecurityManager.PermissionBindary.Storage = psForm then
      Exit;

    with FSecurityManager.PermissionBindary do
    if Assigned(DataSource.DataSet) and DataSource.DataSet.Active then
    begin
      if DataSource.DataSet.Locate(FSecurityManager.PermissionBindary.PermissionField+';'+FSecurityManager.PermissionBindary.FormNameField,
        VarArrayOf([APermission, AFormName]),[]) then
      begin
         DataSource.DataSet.Edit;
         DataSource.DataSet.Delete;
      end
      else
      begin
        raise Exception.CreateFmt('Unable to delete non-existing permission "%s" in the form "%s"',[APermission, AFormName]);
      end;
    end;
  end;
end;

procedure TuilFormPolicy.LoadFromDataBase(AFormName: string);
var
  pi: TuilPolicyItem;
begin
  if Assigned(FSecurityManager) then
  begin
    if FSecurityManager.PermissionBindary.Storage = psForm then
      Exit;

    with FSecurityManager.PermissionBindary do
    begin
      if Assigned(DataSource.DataSet) then
      begin

        DataSource.DataSet.Active := true;
        DataSource.DataSet.Filter := FormNameField + '=' + QuotedStr(AFormName);
        DataSource.DataSet.Filtered := true;

        FPolicies.Clear;
        DataSource.DataSet.First;

        while not DataSource.DataSet.Eof do
        begin
          pi := FPolicies.Add;
          pi.PolicyName := DataSource.DataSet.FieldByName(KeyField).AsString;
          pi.Items.CommaText := DataSource.DataSet.FieldByName(ItemField).AsString;
          pi.PolicyAction := TPolicyAction(DataSource.DataSet.FieldByName(ActionField).AsInteger);
          DataSource.DataSet.Next;
        end;

        DataSource.DataSet.Filtered := false;
        DataSource.DataSet.Filter := '';;
      end;
    end;
  end;
end;

procedure TuilFormPolicy.CustomSecure(AComponent: TComponent;
  Secure: Boolean);
begin
  if Assigned(OnCustomSecure) then
    OnCustomSecure(Self, AComponent, Secure);
end;

end.
