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
unit uFormPolicyDesignerProp;

{$I TMSDEFS.INC}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, ToolWin,
{$IFDEF DELPHI6_LVL}
  DesignIntf,
  DesignEditors,
{$ELSE}
  DsgnIntf,
{$ENDIF}
  uFormPolicy, uFormPolicyDesigner, ExtCtrls, Menus,
  TypInfo, Buttons, WinTypes, ImgList;

type

  TuilFormPolicyProperty = class(TPropertyEditor)
    function AllEqual: boolean; override;
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure SetValue(const Value: string); override;
    procedure AddComponents(AForm: TfrmFormPolicy);
    procedure AddPolicies(AForm: TfrmFormPolicy; APolicy: TuilPolicy);
    procedure SavePolicies(AForm: TfrmFormPolicy; Policies: TuilPolicy);
    procedure AddToList(AForm: TfrmFormPolicy; CompName, ClassName: string);
    function GetClassImage(AClassName: string): integer;
  end;

implementation

function TuilFormPolicyProperty.GetClassImage(AClassName: string): integer;
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

procedure TuilFormPolicyProperty.AddToList(AForm: TfrmFormPolicy; CompName, ClassName: string);
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

procedure TuilFormPolicyProperty.SavePolicies(AForm: TfrmFormPolicy; Policies: TuilPolicy);
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
      while assigned(SubNode) do
      begin
        if ItemList <> '' then
          ItemList := ItemList + ',' + SubNode.Text
        else
          ItemList := SubNode.Text;

        Item.Items.Add(SubNode.Text);
        SubNode := SubNode.getNextSibling;
      end; // while

      {$IFDEF DELPHI6_LVL}
      Policies.FormPolicy.SecurityManager.PermissionBindary.AddPermission(Item.PolicyName, ItemList, Designer.Root.Name, Integer(Item.PolicyAction));
      {$ELSE}
      Policies.FormPolicy.SecurityManager.PermissionBindary.AddPermission(Item.PolicyName, ItemList, Designer.Form.Name, Integer(Item.PolicyAction));
      {$ENDIF}

      Node := Node.GetNextSibling;
    end; // while
  finally
    if not OldActive then
      Policies.FormPolicy.SecurityManager.PermissionBindary.DataSource.DataSet.Close;
  end;
end;

procedure TuilFormPolicyProperty.AddPolicies(AForm: TfrmFormPolicy; APolicy: TuilPolicy);
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
{$IFDEF DELPHI6_LVL}
      if Designer.Root.FindComponent(((APolicy.Items[j] as TuilPolicyItem).Items[k])) <> nil then
{$ELSE}
      if Designer.Form.FindComponent(((APolicy.Items[j] as TuilPolicyItem).Items[k])) <> nil then
{$ENDIF}
      begin
        SubNode := AForm.tvPolicies.Items.AddChild(Node, ((APolicy.Items[j] as TuilPolicyItem).Items[k]));
        SubNode.ImageIndex := 4;
        SubNode.SelectedIndex := 4;
      end; // for
  end; // for
  AForm.tvPolicies.FullExpand;
end;

procedure TuilFormPolicyProperty.AddComponents(AForm: TfrmFormPolicy);
var
  j: integer;
  PropInfo: PPropInfo;
begin
{$IFDEF DELPHI6_LVL}
  for j := 0 to Designer.Root.ComponentCount - 1 do // Iterate
{$ELSE}
  for j := 0 to Designer.Form.ComponentCount - 1 do // Iterate
{$ENDIF}
  begin
{$IFDEF DELPHI6_LVL}
    PropInfo := TypInfo.GetPropInfo(Designer.Root.Components[j].ClassInfo, 'Enabled');
{$ELSE}
    PropInfo := TypInfo.GetPropInfo(Designer.Form.Components[j].ClassInfo, 'Enabled');
{$ENDIF}
    if PropInfo <> nil then
{$IFDEF DELPHI6_LVL}
      AddToList(AForm, Designer.Root.Components[j].Name, Designer.Root.Components[j].ClassName)
{$ELSE}
      AddToList(AForm, Designer.Form.Components[j].Name, Designer.Form.Components[j].ClassName)
{$ENDIF}
    else
    begin
{$IFDEF DELPHI6_LVL}
      PropInfo := TypInfo.GetPropInfo(Designer.Root.Components[j].ClassInfo, 'Visible');
      if PropInfo <> nil then
        AddToList(AForm, Designer.Root.Components[j].Name, Designer.Root.Components[j].ClassName)
{$ELSE}
      PropInfo := TypInfo.GetPropInfo(Designer.Form.Components[j].ClassInfo, 'Visible');
      if PropInfo <> nil then
        AddToList(AForm, Designer.Form.Components[j].Name, Designer.Form.Components[j].ClassName)
{$ENDIF}
     else
     begin
{$IFDEF DELPHI6_LVL}
       PropInfo := TypInfo.GetPropInfo(Designer.Root.Components[j].ClassInfo, 'TabVisible');
       if PropInfo <> nil then
         AddToList(AForm, Designer.Root.Components[j].Name, Designer.Root.Components[j].ClassName);
{$ELSE}
       PropInfo := TypInfo.GetPropInfo(Designer.Form.Components[j].ClassInfo, 'TabVisible');
       if PropInfo <> nil then
         AddToList(AForm, Designer.Form.Components[j].Name, Designer.Form.Components[j].ClassName);
{$ENDIF}
      end;
    end
  end; // for
  AForm.tvComponents.FullExpand;
  AForm.tvComponents.Selected := AForm.tvComponents.Items.GetFirstNode;
  AForm.tvComponents.AlphaSort;
end;

function TuilFormPolicyProperty.AllEqual: boolean;
{ Called whenever more than one component is selected. If this method returns true, GetValue is called; otherwise nothing is displayed in the Object Inspector. Only called when GetAttributes returns paMultiSelect. }
begin
  result := true;
end; { AllEqual }

procedure TuilFormPolicyProperty.Edit;
{ Called when the '...' button is pressed or the property is double-clicked. }
var
  AForm: TfrmFormPolicy;
  Policies: TuilPolicy;
begin
  { To call the inherited implementation, use "inherited Edit;" }
  { CDK: Place your overriding code here. }
  AForm := TfrmFormPolicy.Create(nil);
  with AForm do
  begin
    try
      Policies := TuilPolicy(Pointer(GetOrdValue));

      // Load up existing policies...
      AddComponents(AForm);
      Policies.FormPolicy.LoadFromDatabase(Policies.FormPolicy.Owner.Name);      
      AddPolicies(AForm, Policies);

      if ShowModal = idOK then
      begin
        SavePolicies(AForm, Policies);
        Self.Designer.Modified;
      end;
    finally
      AForm.Free; { Free dialog. }
    end;
  end;
end; { Edit }

function TuilFormPolicyProperty.GetAttributes: TPropertyAttributes;
{ Returns information used by the Object Inspector to show the approprate adornments (e.g., "..." button, drop-down button). }
begin
  GetAttributes := inherited GetAttributes + [paDialog, paRevertable] - [paSubProperties];
end; { GetAttributes }

function TuilFormPolicyProperty.GetValue: string;
{ Returns a string representation for the property's current value, so that the Object Inspector can display it. The default is "unknown". }
begin
  GetValue := '(TuilPolicy)';
end; { GetValue }

procedure TuilFormPolicyProperty.SetValue(const Value: string);
{ Called to set the value of the property.  }
begin
//  SetOrdValue(TStrings(GetOrdValue));
end; { SetValue }


end.
