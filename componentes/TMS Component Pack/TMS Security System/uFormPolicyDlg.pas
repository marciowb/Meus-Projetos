{***********************************************************************}
{ TMS Security framework                                                }
{ for Delphi & C++Builder                                               }
{                                                                       }
{ written by                                                            }
{   TMS Software                                                        }
{   Copyright © 2003 - 2008                                             }
{   Email : info@tmssoftware.com                                        }
{   Web : http://www.tmssoftware.com                                    }
{***********************************************************************}
unit uFormPolicyDlg;

interface

uses
  Windows, Classes, Dialogs, Controls, Forms, uFormPolicy, ComCtrls, ImgList,
  uFormPolicyDesigner, uSecControl, usecdlgform, TypInfo, SysUtils;

const
  REG_SettingsSectionName = 'Policy Dialog';

type

  TControlItem = class(TCollectionItem)
  private
    FComponent: TComponent;
  protected
    function GetDisplayName: string; override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property Component: TComponent read FComponent write FComponent;
  end;

  TControlCollection = class(TCollection)
  private
    FOwner: TComponent;
    function GetItem(Index: Integer): TControlItem;
    procedure SetItem(Index: Integer; const Value: TControlItem);
  public
    constructor Create(AOwner: TComponent);
    function Add: TControlItem;
    function Insert(index: Integer): TControlItem;
    property Items[Index: Integer]: TControlItem read GetItem write SetItem; default;
    function IsIgnored(Component: TComponent): Boolean;
    function GetOwner: TPersistent; override;    
  end;

  TuilFilterComponentEvent = procedure(Sender: TObject; AComponent: TComponent; var Allow: boolean) of object;

  TuilFormPolicyDlg = class(TComponent)
  private
    FSaveToRegistry: Boolean;
    FWidth: Integer;
    FPanelWidth: Integer;
    FHeight: Integer;
    FRegistryKey: string;
    FUilFormPolicy: TUilFormPolicy;
    FIgnoreList: TControlCollection;
    FFormName: string;
    FUilFilterComponent: TuilFilterComponentEvent;
  protected
    procedure SaveComponentOptionsToRegistry; dynamic;
    procedure LoadComponentOptionsFromRegistry; dynamic;
    procedure AddToList(AForm: TfrmFormPolicy; CompName, ClassName: string);
    procedure AddComponents(EditForm: TForm; AForm: TfrmFormPolicy);
    procedure AddPolicies(EditForm: TForm; AForm: TfrmFormPolicy; APolicy: TuilPolicy);
    procedure SavePolicies(AForm: TfrmFormPolicy; Policies: TuilPolicy);
    function GetClassImage(AClassName: string): integer;
    procedure Loaded; override;    
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Execute: boolean;
  published
    property FormPolicy: TUilFormPolicy read FUilFormPolicy write FUilFormPolicy;
    property FormName: string read FFormName write FFormName;
    property IgnoreList: TControlCollection read FIgnoreList write FIgnoreList;
    property RegistryKey: string read FRegistryKey write FRegistryKey;
    property SaveToRegistry: Boolean read FSaveToRegistry write FSaveToRegistry;
    property OnFilterComponent: TuilFilterComponentEvent read FUilFilterComponent write FUilFilterComponent;
  end;

implementation

uses
  Registry;

{ TuilFormPolicyDlg }

function TuilFormPolicyDlg.GetClassImage(AClassName: string): integer;
var
  ClassName: string;
begin
  Result := Unknown;
  ClassName := Uppercase(AClassName);
  if (ClassName = 'TLABEL') or (ClassName = 'TDBTEXT') then
    Result := LabelImage
  else if (ClassName = 'TBUTTON') or (ClassName = 'TBITBTN') then
    Result := ButtonImage
  else if (ClassName = 'TEDIT') or (ClassName = 'TDBEDIT') then
    Result := EditImage
  else if (ClassName = 'TCHECKBOX') or (ClassName = 'TDBCHECKBOX') then
    Result := CheckImage
  else if ClassName = 'TRADIOBUTTON' then
    Result := RadioImage
  else if ClassName = 'TMENUITEM' then
    Result := MenuImage
  else if (ClassName = 'TLISTBOX') or (ClassName = 'TDBLISTBOX') then
    Result := ListBoxImage
  else if (ClassName = 'TMEMO') or (ClassName = 'TDBMEMO') then
    Result := MemoImage;
end;

procedure TuilFormPolicyDlg.LoadComponentOptionsFromRegistry;
begin
  with TRegIniFile.Create(FRegistryKey) do
  try
    RootKey := HKEY_CURRENT_USER;
    FWidth := ReadInteger(REG_SettingsSectionName, 'Width', 455);
    FHeight := ReadInteger(REG_SettingsSectionName, 'Height', 269);
    FPanelWidth := ReadInteger(REG_SettingsSectionName, 'PanelWidth', 145);

    if FWidth = 0 then
      FWidth := 455;
    if FHeight = 0 then
      FHeight := 269;
    if FPanelWidth = 0 then
      FPanelWidth := 145;

  finally
    Free;
  end;
end;

procedure TuilFormPolicyDlg.Loaded;
begin
  inherited;
  FWidth := 359;
  FHeight := 269;
  FPanelWidth := 145;
  if FSaveToRegistry then
    LoadComponentOptionsFromRegistry;
end;

procedure TuilFormPolicyDlg.AddPolicies(EditForm: TForm; AForm: TfrmFormPolicy; APolicy: TuilPolicy);
var
  k: integer;
  SubNode,
  Node: TTreeNode;
  j: integer;
begin
  for j := 0 to APolicy.Count - 1 do // Iterate
  begin
    Node := AForm.tvPolicies.Items.Add(nil, (APolicy.Items[j] as TuilPolicyItem).PolicyName);
    Node.ImageIndex := Ord((APolicy.Items[j] as TuilPolicyItem).PolicyAction);
    Node.SelectedIndex := Ord((APolicy.Items[j] as TuilPolicyItem).PolicyAction);
    for k := 0 to (APolicy.Items[j] as TuilPolicyItem).Items.Count - 1 do // Iterate
      if EditForm.FindComponent(((APolicy.Items[j] as TuilPolicyItem).Items[k])) <> nil then
      begin
        SubNode := AForm.tvPolicies.Items.AddChild(Node, ((APolicy.Items[j] as TuilPolicyItem).Items[k]));
        SubNode.ImageIndex := 4;
        SubNode.SelectedIndex := 4;
      end; // for
  end; // for
  AForm.tvPolicies.FullExpand;
end;

procedure TuilFormPolicyDlg.AddToList(AForm: TfrmFormPolicy; CompName, ClassName: string);
var
  Found: boolean;
  Node: TTreeNode;
  ImageNumber: integer;
begin
  if (CompName = '') or (ClassName = '') then Exit;

  Found := False;
  Node := AForm.tvComponents.Items.GetFirstNode;
  if (Node = nil) then
  begin
    ImageNumber := GetClassImage(ClassName);
    Node := AForm.tvComponents.Items.Add(nil, ClassName);
    Node.SelectedIndex := ImageNumber;
    Node.ImageIndex := ImageNumber;
    AForm.tvComponents.Items.AddChild(Node, CompName);
  end
  else
  begin
    while (Node <> nil) and (not Found) do
    begin
      if Node.Text = ClassName then
      begin
        Found := True;
        AForm.tvComponents.Items.AddChild(Node, CompName);
      end
      else
        Node := Node.GetNextSibling;

    end; // while
    if (Node = nil) and (not Found) then
    begin
      ImageNumber := GetClassImage(ClassName);
      Node := AForm.tvComponents.Items.Add(nil, ClassName);
      Node.SelectedIndex := ImageNumber;
      Node.ImageIndex := ImageNumber;
      AForm.tvComponents.Items.AddChild(Node, CompName);
    end
  end;
end;


procedure TuilFormPolicyDlg.AddComponents(EditForm: TForm; AForm: TfrmFormPolicy);
var
  j: integer;
  PropInfo: PPropInfo;
  Allow: boolean;
  
begin
  for j := 0 to EditForm.ComponentCount - 1 do // Iterate
  begin
    if not IgnoreList.IsIgnored(EditForm.Components[j]) then
    begin
      // find all components with Enabled, Visible or ReadOnly property
      PropInfo := TypInfo.GetPropInfo(EditForm.Components[j].ClassInfo, 'Enabled');
      if PropInfo <> nil then
      begin
        Allow := true;

        if Assigned(OnFilterComponent) then
          OnFilterComponent(Self,EditForm.Components[j], Allow);

        if Allow then
          AddToList(AForm, EditForm.Components[j].Name, EditForm.Components[j].ClassName)
      end
      else
      begin
        PropInfo := TypInfo.GetPropInfo(EditForm.Components[j].ClassInfo, 'Visible');
        if PropInfo <> nil then
        begin
          Allow := true;

          if Assigned(OnFilterComponent) then
            OnFilterComponent(Self,EditForm.Components[j], Allow);

          AddToList(AForm, EditForm.Components[j].Name, EditForm.Components[j].ClassName);
        end
        else
          begin
            PropInfo := TypInfo.GetPropInfo(EditForm.Components[j].ClassInfo, 'ReadOnly');
            if PropInfo <> nil then
            begin
              Allow := true;

              if Assigned(OnFilterComponent) then
                OnFilterComponent(Self,EditForm.Components[j], Allow);

              AddToList(AForm, EditForm.Components[j].Name, EditForm.Components[j].ClassName);
            end;
          end;
      end



    end;
  end; // for
  AForm.tvComponents.FullExpand;
  AForm.tvComponents.Selected := AForm.tvComponents.Items.GetFirstNode;
  AForm.tvComponents.AlphaSort;
end;


function TuilFormPolicyDlg.Execute: boolean;
var
  AForm: TfrmFormPolicy;
  Policies: TuilPolicy;
begin
  Result := false;
  { To call the inherited implementation, use "inherited Edit;" }
  AForm := TfrmFormPolicy.Create(nil);
  with AForm do
  begin
    try
      FormPolicy := self.FormPolicy;
      FormName := self.FormPolicy.Owner.Name;
      Policies := FuilFormPolicy.Policies;
      AForm.Width := FWidth;
      AForm.Height := FHeight;
      AForm.Panel2.Width := FPanelWidth;

      // Load up existing policies...
      AddComponents(self.Owner as TForm, AForm);
      FuilFormPolicy.LoadFromDatabase(FuilFormPolicy.Owner.Name);
      AddPolicies(self.Owner as TForm, AForm, Policies);

      if ShowModal = idOK then
      begin
        SavePolicies(AForm, Policies);

        if not (csDesigning in ComponentState) then
        begin
          FuilFormPolicy.LoadFromDataBase(FuilFormPolicy.Owner.Name);
          FuilFormPolicy.Apply;
        end;

        FWidth := AForm.Width;
        FHeight := AForm.Height;
        FPanelWidth := AForm.Panel2.Width;
        Result := true;
      end;
    finally
      AForm.Free; { Free dialog.}
    end;
  end;
end;

procedure TuilFormPolicyDlg.SaveComponentOptionsToRegistry;
begin
  with TRegIniFile.Create(FRegistryKey) do
  try
    RootKey := HKEY_CURRENT_USER;
    WriteInteger(REG_SettingsSectionName, 'Width', FWidth);
    WriteInteger(REG_SettingsSectionName, 'Height', FHeight);
    WriteInteger(REG_SettingsSectionName, 'PanelWidth', FPanelWidth);
  finally 
    Free;
  end;
end;

procedure TuilFormPolicyDlg.SavePolicies(AForm: TfrmFormPolicy; Policies: TuilPolicy);
var
  Item: TuilPolicyItem;
  SubNode: TTreeNode;
  Node: TTreeNode;
  OldActive: boolean;
  ItemList: string;

begin
  OldActive := Policies.FormPolicy.SecurityManager.PermissionBindary.DataSource.DataSet.Active;
  if not OldActive then
    Policies.FormPolicy.SecurityManager.PermissionBindary.DataSource.DataSet.Open;
  try
    Policies.Clear;
    Node := AForm.tvPolicies.Items[0];
    while Assigned(Node) do
    begin
      Item := Policies.Add as TuilPolicyItem;
      Item.PolicyName := Node.Text;
      Item.PolicyAction := TPolicyAction(Node.ImageIndex);

      ItemList := '';
      SubNode := Node.GetFirstChild;

      while Assigned(SubNode) do
      begin
        if ItemList <> '' then
          ItemList := ItemList + ',' + SubNode.Text
        else
          ItemList := SubNode.Text;

        Item.Items.Add(SubNode.Text);
        SubNode := SubNode.getNextSibling;
      end;

      Policies.FormPolicy.SecurityManager.PermissionBindary.AddPermission(Item.PolicyName, ItemList, self.Owner.Name,Integer(Item.PolicyAction));

      Node := Node.GetNextSibling;
    end; // while
  finally
    if not OldActive then
      Policies.FormPolicy.SecurityManager.PermissionBindary.DataSource.DataSet.Close;
  end;
end;


constructor TuilFormPolicyDlg.Create(AOwner: TComponent);
begin
  inherited;
  FIgnoreList := TControlCollection.Create(Self);
  FRegistryKey := 'Software\tmssoftware\Security System';  
end;

destructor TuilFormPolicyDlg.Destroy;
begin
  if FSaveToRegistry then
    SaveComponentOptionsToRegistry;

  FIgnoreList.Free;
  inherited;
end;

{ TControlItem }

procedure TControlItem.Assign(Source: TPersistent);
begin
  FComponent := (Source as TControlItem).Component;
end;

constructor TControlItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
end;

destructor TControlItem.Destroy;
begin
  inherited;
end;

function TControlItem.GetDisplayName: string;
begin
  if Assigned(Component) then
    Result := Component.Name
  else
    Result := 'Item '+ IntToStr(Index);  
end;

{ TControlCollection }

function TControlCollection.Add: TControlItem;
begin
  Result := TControlItem(inherited Add);
end;

constructor TControlCollection.Create(AOwner: TComponent);
begin
  inherited Create(TControlItem);
  FOwner := AOwner;
end;

function TControlCollection.GetItem(Index: Integer): TControlItem;
begin
  Result := TControlItem(inherited Items[Index]);
end;

function TControlCollection.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

function TControlCollection.Insert(Index: Integer): TControlItem;
begin
  Result := TControlItem(inherited Insert(Index));
end;

function TControlCollection.IsIgnored(Component: TComponent): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 1 to Count do
  begin
    if (Items[i - 1].Component = Component) then
    begin
      Result := true;
      Break;
    end;
  end;
end;

procedure TControlCollection.SetItem(Index: Integer;
  const Value: TControlItem);
begin
  inherited Items[Index] := Value;
end;

end.
