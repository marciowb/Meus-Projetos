{***********************************************************************}
{ TMS Security System                                                   }
{ for Delphi & C++Builder                                               }
{                                                                       }
{ written by                                                            }
{   TMS Software                                                        }
{   Copyright © 2003 - 2008                                             }
{   Email : info@tmssoftware.com                                        }
{   Web : http://www.tmssoftware.com                                    }
{***********************************************************************}
unit uSecuReg;

interface

{$R TSSUI.RES}

{$I TMSDEFS.INC}

uses
   Classes,
   {$IFDEF DELPHI6_LVL}
   DesignIntf,
   DesignEditors,
   {$ELSE}
   DsgnIntf,
   {$ENDIF}
   Controls,
   SysUtils,
   Dialogs,
   uSecControl,
   uFormPolicy,
   uLoginDlg,
   uChangePasswordDlg,
   uAboutUILSecurity,
   uFormPolicyDesigner,
   uFormPolicyDlg,
   uFormPolicyDesignerProp,
   uSecDlg,
   uSecDlgForm,
   uProxy
   ;

procedure Register;

type
   TuilFormPolicyEditor = class(TDefaultEditor)
   public
      function GetVerbCount : integer; override;
      function GetVerb(Index : integer) : string; override;
      procedure ExecuteVerb(Index : integer); override;
      {$ifdef DELPHI6_LVL}
      procedure EditProperty(const Prop: IProperty; var Continue : Boolean); override;
      {$else}
      procedure EditProperty(PropertyEditor: TPropertyEditor; var Continue, FreeEditor : Boolean); override;
      {$endif}
   end;  { TuilSecurityManagerEditor }

   TuilSecManEditor = class(TDefaultEditor)
   public
      function GetVerbCount : integer; override;
      function GetVerb(Index : integer) : string; override;
      procedure ExecuteVerb(Index : integer); override;
      {$ifdef DELPHI6_LVL}
      procedure EditProperty(const Prop: IProperty; var Continue : Boolean); override;
      {$else}
      procedure EditProperty(PropertyEditor: TPropertyEditor; var Continue, FreeEditor : Boolean); override;
      {$endif}
      procedure Edit; override;
   end;  { TuilSecManEditor }

   TuilDataFieldProperty = class(TStringProperty)
   public
      function  GetAttributes: TPropertyAttributes; override;
      procedure GetValues(Proc: TGetStrProc); override;
      procedure GetValueList(List: TStrings);
      procedure SetValue(const Value: string); override;
   end; { TuilBindary }

implementation

uses
  uBindary
  {$IFDEF DELPHI2006_LVL}
  , WideStrings
  {$ENDIF}
  ;

{ TuilFormPolicyEditor }

function TuilFormPolicyEditor.GetVerbCount : integer;
begin
   result := 1;
end;  { GetVerbCount }

function TuilFormPolicyEditor.GetVerb(Index : integer) : string;
begin
   case Index of
      0 : result := 'Edit Form Policy...';
   end;
end;  { GetVerb }


procedure TuilFormPolicyEditor.ExecuteVerb(Index : integer);
var
   SavedOpen : boolean;
begin
   if not assigned((Component as TuilFormPolicy).SecurityManager) then
      raise Exception.Create('You must specify a SecurityManager.');
   if not assigned((Component as TuilFormPolicy).SecurityManager.PermissionBindary.DataSource) then
      raise Exception.Create('You must specify a DataSource for the SecurityManager''s PermissionBindary.');
   if not assigned((Component as TuilFormPolicy).SecurityManager.PermissionBindary.DataSource.DataSet) then
      raise Exception.Create('You must specify a DataSet for the DataSource of the SecurityManager''s PermissionBindary.');

   SavedOpen := (Component as TuilFormPolicy).SecurityManager.PermissionBindary.DataSource.DataSet.Active;
   try
      if not SavedOpen then
         (Component as TuilFormPolicy).SecurityManager.PermissionBindary.DataSource.DataSet.Open;

      case Index of
         0 : begin
                Edit;
                Designer.Modified;  { Update component on form. }
             end;
      end;
   finally
      if not SavedOpen then
         (Component as TuilFormPolicy).SecurityManager.PermissionBindary.DataSource.DataSet.Close;
   end;
end;  { ExecuteVerb }


{$ifdef DELPHI6_LVL}
procedure TuilFormPolicyEditor.EditProperty(const Prop: IProperty; var Continue : Boolean);
{$else}
procedure TuilFormPolicyEditor.EditProperty(PropertyEditor: TPropertyEditor; var Continue, FreeEditor : Boolean);
{$endif}
var
  PropName: string;
begin
  {$ifdef DELPHI6_LVL}
  PropName := Prop.GetName;
  {$else}
  PropName := PropertyEditor.GetName;
  {$endif}
  if (CompareText(PropName, 'POLICIES') = 0) then
  begin
    {$ifdef DELPHI6_LVL}
    Prop.Edit;
    {$else}
    PropertyEditor.Edit;
    {$endif}
    Continue := False;
  end;
end;


{ TuilSecManEditor }

procedure TuilSecManEditor.Edit;
var
   AForm : TfrmPermissionsDlg;
//   Component : TuilSecurityManager;
   SavedUser,
   SavedUserAcc,
   SavedGroup,
   SavedGroupAcc,
   SavedGroupMem,
   SavedAccess    : boolean;
begin
   if not Assigned((Component as TuilSecurityManager).UserBindary.DataSource) then
   begin
     inherited;
     Exit;
   end;

   if not Assigned((Component as TuilSecurityManager).GroupBindary.DataSource) then
   begin
     inherited;
     Exit;
   end;

   if not Assigned((Component as TuilSecurityManager).PermissionBindary.DataSource) then
   begin
     inherited;
     Exit;
   end;

   if not Assigned((Component as TuilSecurityManager).GroupBindary.GroupPermissions.DataSource) then
   begin
     inherited;
     Exit;
   end;

   if not Assigned((Component as TuilSecurityManager).UserBindary.UserPermissions.DataSource) then
   begin
     inherited;
     Exit;
   end;

   if not Assigned((Component as TuilSecurityManager).UserBindary.DataSource.DataSet) then
   begin
     inherited;
     Exit;
   end;

   if not Assigned((Component as TuilSecurityManager).GroupBindary.DataSource.DataSet) then
   begin
     inherited;
     Exit;
   end;

   if not Assigned((Component as TuilSecurityManager).PermissionBindary.DataSource.DataSet) then
   begin
     inherited;
     Exit;
   end;

   if not Assigned((Component as TuilSecurityManager).GroupBindary.GroupPermissions.DataSource.DataSet) then
   begin
     inherited;
     Exit;
   end;

   if not Assigned((Component as TuilSecurityManager).UserBindary.UserPermissions.DataSource.DataSet) then
   begin
     inherited;
     Exit;
   end;

   AForm := TfrmPermissionsDlg.Create(nil);
   with AForm do
   begin
     SavedUser := (Component as TuilSecurityManager).UserBindary.DataSource.DataSet.Active;
     SavedUserAcc := (Component as TuilSecurityManager).UserBindary.UserPermissions.DataSource.DataSet.Active;
     SavedGroup := (Component as TuilSecurityManager).GroupBindary.DataSource.DataSet.Active;
     SavedGroupAcc := (Component as TuilSecurityManager).GroupBindary.GroupPermissions.DataSource.DataSet.Active;
     SavedGroupMem := (Component as TuilSecurityManager).GroupBindary.GroupMembershipBindary.DataSource.DataSet.Active;
     SavedAccess := (Component as TuilSecurityManager).PermissionBindary.DataSource.DataSet.Active;

     try
       (Component as TuilSecurityManager).UserBindary.DataSource.DataSet.Open;
       (Component as TuilSecurityManager).UserBindary.UserPermissions.DataSource.DataSet.Open;
       (Component as TuilSecurityManager).GroupBindary.DataSource.DataSet.Open;
       (Component as TuilSecurityManager).GroupBindary.GroupPermissions.DataSource.DataSet.Open;
       (Component as TuilSecurityManager).GroupBindary.GroupMembershipBindary.DataSource.DataSet.Open;
       (Component as TuilSecurityManager).PermissionBindary.DataSource.DataSet.Open;

       AForm.SecurityManager := Component as TuilSecurityManager;
       if AForm.ShowModal = mrOK then ;
     finally
       if not SavedUser then
         (Component as TuilSecurityManager).UserBindary.DataSource.DataSet.Close;
       if not SavedUserAcc then
         (Component as TuilSecurityManager).UserBindary.UserPermissions.DataSource.DataSet.Close;
       if not SavedGroup then
         (Component as TuilSecurityManager).GroupBindary.DataSource.DataSet.Close;
       if not SavedGroupAcc then
         (Component as TuilSecurityManager).GroupBindary.GroupPermissions.DataSource.DataSet.Close;
       if not SavedGroupMem then
         (Component as TuilSecurityManager).GroupBindary.GroupMembershipBindary.DataSource.DataSet.Close;
       if not SavedAccess then
         (Component as TuilSecurityManager).PermissionBindary.DataSource.DataSet.Close;;
       AForm.Free;  { Free dialog. }
     end;
   end;
end;  { EditSecurity }

function TuilSecManEditor.GetVerbCount : integer;
begin
   result := 1;
end;  { GetVerbCount }

function TuilSecManEditor.GetVerb(Index : integer) : string;
begin
   case Index of
      0 : result := 'Edit Permissions...';
   end;
end;  { GetVerb }

procedure TuilSecManEditor.ExecuteVerb(Index : integer);
begin
   if not assigned((Component as TuilSecurityManager).UserBindary.DataSource) then
      raise Exception.Create('You must specify a DataSource for the SecurityManager''s UserBindary.');
   if not assigned((Component as TuilSecurityManager).UserBindary.DataSource.DataSet) then
      raise Exception.Create('You must specify a DataSet for the DataSource of the SecurityManager''s UserBindary.');

   if not assigned((Component as TuilSecurityManager).UserBindary.UserPermissions.DataSource) then
      raise Exception.Create('You must specify a DataSource for the SecurityManager''s UserBindary.UserPermissions.');
   if not assigned((Component as TuilSecurityManager).UserBindary.UserPermissions.DataSource.DataSet) then
      raise Exception.Create('You must specify a DataSet for the DataSource of the SecurityManager''s UserBindary.UserPermissions.');

   if not assigned((Component as TuilSecurityManager).GroupBindary.DataSource) then
      raise Exception.Create('You must specify a DataSource for the SecurityManager''s GroupBindary.');
   if not assigned((Component as TuilSecurityManager).GroupBindary.DataSource.DataSet) then
      raise Exception.Create('You must specify a DataSet for the DataSource of the SecurityManager''s GroupBindary.');

   if not assigned((Component as TuilSecurityManager).GroupBindary.GroupPermissions.DataSource) then
      raise Exception.Create('You must specify a DataSource for the SecurityManager''s GroupBindary.GroupPermissions.');
   if not assigned((Component as TuilSecurityManager).GroupBindary.GroupPermissions.DataSource.DataSet) then
      raise Exception.Create('You must specify a DataSet for the DataSource of the SecurityManager''s GroupBindary.GroupPermissions.');

   if not assigned((Component as TuilSecurityManager).GroupBindary.GroupMembershipBindary.DataSource) then
      raise Exception.Create('You must specify a DataSource for the SecurityManager''s GroupBindary.GroupMembershipBindary.');
   if not assigned((Component as TuilSecurityManager).GroupBindary.GroupMembershipBindary.DataSource.DataSet) then
      raise Exception.Create('You must specify a DataSet for the DataSource of the SecurityManager''s GroupBindary.GroupMembershipBindary.');

   if not assigned((Component as TuilSecurityManager).PermissionBindary.DataSource) then
      raise Exception.Create('You must specify a DataSource for the SecurityManager''s PermissionBindary.');
   if not assigned((Component as TuilSecurityManager).PermissionBindary.DataSource.DataSet) then
      raise Exception.Create('You must specify a DataSet for the DataSource of the SecurityManager''s PermissionBindary.');

   try
      case Index of
         0 : begin
                Edit;
                Designer.Modified;  { Update component on form. }
             end;
      end;
   finally
   end;
end;  { ExecuteVerb }

{$ifdef DELPHI6_LVL}
procedure TuilSecManEditor.EditProperty(const Prop: IProperty; var Continue : Boolean);
{$else}
procedure TuilSecManEditor.EditProperty(PropertyEditor: TPropertyEditor; var Continue, FreeEditor : Boolean);
{$endif}
var
  PropName: string;
begin
  {$ifdef DELPHI6_LVL}
  PropName := Prop.GetName;
  {$else}
  PropName := PropertyEditor.GetName;
  {$endif}
  if (CompareText(PropName, 'PERMISSIONBINDARY') = 0) then
  begin
    {$ifdef DELPHI6_LVL}
    Prop.Edit;
    {$else}
    PropertyEditor.Edit;
    {$endif}    
    Continue := False;
  end;
end;

{ TuilDataFieldProperty }

function TuilDataFieldProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paSortList, paMultiSelect];
end;

procedure TuilDataFieldProperty.GetValues(Proc: TGetStrProc);
var
   j      : Integer;
   Values : TStringList;
begin
   Values := TStringList.Create;
   try
      GetValueList(Values);
      for j := 0 to Values.Count - 1 do
         Proc(Values[j]);
   finally
      Values.Free;
   end;
end;

procedure TuilDataFieldProperty.GetValueList(List: TStrings);
var
  Component : TPersistent;
  Bindary   : TuilBindary;
  {$IFNDEF DELPHI2006_LVL}
  sl: TStringList;
  {$ENDIF}
  {$IFDEF DELPHI2006_LVL}
  sl: TWideStringList;
  i: integer;
  {$ENDIF}

begin
  Component := GetComponent(0);
  if not Assigned(Component) then
    Exit;
    
  Bindary := nil;

  if Component is TuilBindary then
    Bindary := TuilBindary(Component);

  if Assigned(Bindary) then
    if Assigned(Bindary.DataSource) then
      if Assigned(Bindary.DataSource.DataSet) then
      begin
        {$IFNDEF DELPHI2006_LVL}
        sl := TStringList.Create;
        {$ENDIF}
        {$IFDEF DELPHI2006_LVL}
        sl := TWideStringList.Create;
        {$ENDIF}

        Bindary.DataSource.DataSet.GetFieldNames(sl);
        {$IFNDEF DELPHI2006_LVL}
        List.Assign(sl);
        {$ENDIF}

        {$IFDEF DELPHI2006_LVL}
        for i := 1 to sl.Count do
        begin
          List.Add(WideCharToString(PWideChar(sl.Strings[i - 1])));
        end;
        {$ENDIF}

        sl.Free;
      end;
end;

procedure TuilDataFieldProperty.SetValue(const Value: String);
var
  AFieldName: String;
  APos: Integer;
begin
  AFieldName := Value;

  APos := Pos('.', AFieldName);
  if (APos > 0) then
    AFieldName := Copy(AFieldName, APos + 1, Length(AFieldName));

  SetStrValue(AFieldName);
end;


{ Register }
procedure Register;
begin
  RegisterComponentEditor(TuilFormPolicy, TuilFormPolicyEditor);
  RegisterComponentEditor(TuilSecurityManager, TuilSecManEditor);
  RegisterPropertyEditor(TypeInfo(TuilPolicy), TuilFormPolicy, 'Policies', TuilFormPolicyProperty);

  RegisterPropertyEditor(TypeInfo(string), TuilSecurityManager, 'Version', TVersionEditor);
  RegisterPropertyEditor(TypeInfo(string), TuilFormPolicy, 'Version', TVersionEditor);

  RegisterPropertyEditor(TypeInfo(string), TuilAccessBindary, 'PermissionField', TuilDataFieldProperty);

  RegisterPropertyEditor(TypeInfo(string), TuilPermissionBindary, 'ItemField', TuilDataFieldProperty);
  RegisterPropertyEditor(TypeInfo(string), TuilPermissionBindary, 'ActionField', TuilDataFieldProperty);
  RegisterPropertyEditor(TypeInfo(string), TuilPermissionBindary, 'FormNameField', TuilDataFieldProperty);

  RegisterPropertyEditor(TypeInfo(string), TuilUserAccessBindary, 'UserNameField', TuilDataFieldProperty);
  RegisterPropertyEditor(TypeInfo(string), TuilGroupAccessBindary, 'GroupNameField', TuilDataFieldProperty);
  RegisterPropertyEditor(TypeInfo(string), TuilGroupMembershipBindary, 'UserNameField', TuilDataFieldProperty);
  RegisterPropertyEditor(TypeInfo(string), TuilGroupMembershipBindary, 'GroupNameField', TuilDataFieldProperty);

  RegisterPropertyEditor(TypeInfo(string), TuilUserBindary, 'UserNameField', TuilDataFieldProperty);
  RegisterPropertyEditor(TypeInfo(string), TuilUserBindary, 'FullNameField', TuilDataFieldProperty);
  RegisterPropertyEditor(TypeInfo(string), TuilUserBindary, 'PasswordField', TuilDataFieldProperty);
  RegisterPropertyEditor(TypeInfo(string), TuilUserBindary, 'AccessCountField', TuilDataFieldProperty);
  RegisterPropertyEditor(TypeInfo(string), TuilUserBindary, 'CreatedDateField', TuilDataFieldProperty);
  RegisterPropertyEditor(TypeInfo(string), TuilUserBindary, 'EnabledField', TuilDataFieldProperty);
  RegisterPropertyEditor(TypeInfo(string), TuilUserBindary, 'LastAccessField', TuilDataFieldProperty);
  RegisterPropertyEditor(TypeInfo(string), TuilUserBindary, 'LastAccessTimeField', TuilDataFieldProperty);
  RegisterPropertyEditor(TypeInfo(string), TuilUserBindary, 'CreatedTimeField', TuilDataFieldProperty);

  RegisterPropertyEditor(TypeInfo(string), TuilGroupBindary, 'GroupNameField', TuilDataFieldProperty);
  RegisterPropertyEditor(TypeInfo(string), TuilGroupBindary, 'GroupDescriptionField', TuilDataFieldProperty);

  RegisterComponents('TMS Security', [TuilLoginDlg]);
  RegisterComponents('TMS Security', [TuilChangePasswordDlg]);
  RegisterComponents('TMS Security', [TuilSecurityDlg]);
  RegisterComponents('TMS Security', [TuilFormPolicyDlg]);
end;

end.

