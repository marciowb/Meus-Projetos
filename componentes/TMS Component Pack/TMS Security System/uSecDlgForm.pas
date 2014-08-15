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
unit uSecDlgForm;
         
interface

{$I TMSDEFS.INC}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, Buttons, uSecControl, Menus, ExtCtrls, ImgList, DB
  {$IFDEF DELPHI6_LVL}
  , Variants
  {$ENDIF}
  ;

type
  TuilUserEvent = procedure(Sender: TObject; UserName: string) of object;
  TuilGroupEvent = procedure(Sender: TObject; GroupName: string) of object;  


  TfrmPermissionsDlg = class(TForm)
    pcPermissions: TPageControl;
    tsUsers: TTabSheet;
    tsGroups: TTabSheet;
    tsMembership: TTabSheet;
    ilImages: TImageList;
    popUsers: TPopupMenu;
    Cut1: TMenuItem;
    PastePermissions1: TMenuItem;
    Remove1: TMenuItem;
    N1: TMenuItem;
    EditUser1: TMenuItem;
    Panel1: TPanel;
    Label1: TLabel;
    tvUsersUsers: TTreeView;
    Splitter1: TSplitter;
    Panel2: TPanel;
    tvUsersPermissions: TTreeView;
    Label2: TLabel;
    Panel4: TPanel;
    btnAddUser: TBitBtn;
    btnEditUser: TBitBtn;
    btnDeleteUser: TBitBtn;
    btnOK: TBitBtn;
    Panel3: TPanel;
    tvGroupsGroups: TTreeView;
    Label4: TLabel;
    Splitter2: TSplitter;
    Panel5: TPanel;
    btnAddGroup: TBitBtn;
    btnEditGroup: TBitBtn;
    btnDeleteGroup: TBitBtn;
    BitBtn1: TBitBtn;
    Panel6: TPanel;
    tvGroupsPermissions: TTreeView;
    Label3: TLabel;
    Panel7: TPanel;
    BitBtn6: TBitBtn;
    btnRemoveMembership: TBitBtn;
    Panel8: TPanel;
    Label6: TLabel;
    tvMembershipGroups: TTreeView;
    Splitter3: TSplitter;
    Panel9: TPanel;
    Label5: TLabel;
    tvMembershipUsers: TTreeView;
    Panel10: TPanel;
    btnPermissionToUser: TSpeedButton;
    Panel11: TPanel;
    Panel12: TPanel;
    btnDelUserPermission: TSpeedButton;
    btnPermissionToGroup: TSpeedButton;
    btnDelGroupPermission: TSpeedButton;
    btnUserToGroup: TSpeedButton;
    btnDelUserFromGroup: TSpeedButton;
    popGroups: TPopupMenu;
    miEditGroup: TMenuItem;
    miRemoveGroup: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    AddUser1: TMenuItem;
    AddGroup1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure tvUsersUsersDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure tvGroupsGroupsDragOver(Sender, Source: TObject; X,
      Y: Integer; State: TDragState; var Accept: Boolean);
    procedure tvMembershipGroupsDragOver(Sender, Source: TObject; X,
      Y: Integer; State: TDragState; var Accept: Boolean);
    procedure tvUsersUsersDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure btnAddUserClick(Sender: TObject);
    procedure btnDeleteUserClick(Sender: TObject);
    procedure btnEditUserClick(Sender: TObject);
    procedure btnAddGroupClick(Sender: TObject);
    procedure btnEditGroupClick(Sender: TObject);
    procedure btnDeleteGroupClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnRemoveMembershipClick(Sender: TObject);
    procedure Splitter1Moved(Sender: TObject);
    procedure Splitter2Moved(Sender: TObject);
    procedure Splitter3Moved(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Cut1Click(Sender: TObject);
    procedure PastePermissions1Click(Sender: TObject);
    procedure btnPermissionToUserClick(Sender: TObject);
    procedure btnPermissionToGroupClick(Sender: TObject);
    procedure btnUserToGroupClick(Sender: TObject);
    procedure tvMembershipGroupsChange(Sender: TObject; Node: TTreeNode);
  private
    CurrentCopy : TTreeNode;
    FOnUserAdded: TuilUserEvent;
    FOnUserDeleted: TuilUserEvent;
    FOnUserEdited: TuilUserEvent;
    FOnGroupAdded: TuilGroupEvent;
    FOnGroupDeleted: TuilGroupEvent;
    FOnGroupEdited: TuilGroupEvent;

    procedure AddChild(SenderTree : TTreeView; var Node : TTreeNode; AText : string; AImageNum : integer);
  public
    SecurityManager : TuilSecurityManager;
    procedure RefreshMembership; 
    procedure RefreshPermissions; 
    procedure AddUserPermission(Permission: string);
    procedure AddGroupPermission(Permission: string);
    procedure RemoveUserPermission(Permission: string);
    procedure RemoveGroupPermission(Permission: string);
    procedure RefreshUsers;
    procedure RefreshGroups;

    property OnUserAdded: TuilUserEvent read FOnUserAdded write FOnUserAdded;
    property OnUserDeleted: TuilUserEvent read FOnUserDeleted write FOnUserDeleted;
    property OnUserEdited: TuilUserEvent read FOnUserEdited write FOnUserEdited;

    property OnGroupAdded: TuilGroupEvent read FOnGroupAdded write FOnGroupAdded;
    property OnGroupDeleted: TuilGroupEvent read FOnGroupDeleted write FOnGroupDeleted;
    property OnGroupEdited: TuilGroupEvent read FOnGroupEdited write FOnGroupEdited;
  end;

var
  frmPermissionsDlg: TfrmPermissionsDlg;

implementation

{$R *.DFM}

uses
   uEditUserForm, uEditGroupForm;

procedure TfrmPermissionsDlg.AddChild(SenderTree : TTreeView; var Node : TTreeNode; AText : string; AImageNum : integer);
var
   CheckNode : TTreeNode;
begin
   while (Node.Parent <> nil) do
      Node := Node.Parent;

   // Check to see if the item is already in the list
   CheckNode := Node.GetFirstChild;
   while Assigned(CheckNode) do
   begin
      if (CheckNode.Text = AText) then Exit;
      CheckNode := CheckNode.GetNextSibling;
   end;      // while

   Node := SenderTree.Items.AddChild(Node, AText);
   if Assigned(Node) then
   begin
      Node.ImageIndex := AImageNum;
      Node.SelectedIndex := AImageNum;
   end;
end;


procedure TfrmPermissionsDlg.AddUserPermission(Permission: string);
begin
   SecurityManager.UserBindary.UserPermissions.AddAccess(Permission);
end;

procedure TfrmPermissionsDlg.AddGroupPermission(Permission: string);
begin
   SecurityManager.GroupBindary.GroupPermissions.AddAccess(Permission);
end;

procedure TfrmPermissionsDlg.RemoveUserPermission(Permission: string);
begin
   SecurityManager.UserBindary.UserPermissions.RemoveAccess(Permission);
end;

procedure TfrmPermissionsDlg.RemoveGroupPermission(Permission: string);
begin
   SecurityManager.GroupBindary.GroupPermissions.RemoveAccess(Permission);
end;

procedure TfrmPermissionsDlg.RefreshGroups;
var
   SubNode: TTreeNode;
   Node: TTreeNode;
begin                                    
   tvGroupsGroups.Items.Clear;

   tvMembershipGroups.Items.Clear;

   with SecurityManager.GroupBindary.DataSource.DataSet do
   begin
      First;
      while not EOF do
      begin
         Node := tvMembershipGroups.Items.Add(nil, FieldByName((SecurityManager.GroupBindary.GroupNameField)).AsString);
         Node.ImageIndex := 1;
         Node.SelectedIndex := 1;
         Node := tvGroupsGroups.Items.Add(nil, FieldByName((SecurityManager.GroupBindary.GroupNameField)).AsString);
         Node.ImageIndex := 1;
         Node.SelectedIndex := 1;

         // Add Permissions...
         with SecurityManager.GroupBindary.GroupPermissions.DataSource.DataSet do
         begin
            First;
            while not EOF do
            begin
              if FieldByName((SecurityManager.GroupBindary.GroupPermissions.GroupNameField)).AsString = Node.Text then
              begin
                SubNode := tvGroupsGroups.Items.AddChild(Node, FieldByName((SecurityManager.GroupBindary.GroupPermissions.PermissionField)).AsString);
                SubNode.ImageIndex := 2;
                SubNode.SelectedIndex := 2;
              end;
              Next;
            end;
         end;
         Next;
      end;      // while
   end;      // with
   tvGroupsGroups.FullExpand;
end;

procedure TfrmPermissionsDlg.RefreshUsers;
var
   Node,
   SubNode : TTreeNode;
begin
   tvUsersUsers.Items.Clear;
   tvMembershipUsers.Items.Clear;
   with SecurityManager.UserBindary.DataSource.DataSet do
   begin
      First;
      while not EOF do
      begin
         Node := tvMembershipUsers.Items.Add(nil, FieldByName((SecurityManager.UserBindary.UserNameField)).AsString);
         Node.ImageIndex := 0;
         Node.SelectedIndex := 0;
         Node := tvUsersUsers.Items.Add(nil, FieldByName((SecurityManager.UserBindary.UserNameField)).AsString);
         Node.ImageIndex := 0;
         Node.SelectedIndex := 0;

         // Add Permissions...
         with SecurityManager.UserBindary.UserPermissions.DataSource.DataSet do
         begin
            First;
            while not EOF do
            begin
              if FieldByName((SecurityManager.UserBindary.UserPermissions.UserNameField)).AsString = Node.Text then
              begin
                SubNode := tvUsersUsers.Items.AddChild(Node, FieldByName((SecurityManager.UserBindary.UserPermissions.PermissionField)).AsString);
                SubNode.ImageIndex := 2;
                SubNode.SelectedIndex := 2;
              end;  
              Next;
            end;
         end;
         Next;
      end;      // while
   end;      // with
   tvUsersUsers.FullExpand;
end;

procedure TfrmPermissionsDlg.RefreshPermissions;
var
   Node : TTreeNode;
begin
   with SecurityManager.PermissionBindary.DataSource.DataSet do
   begin
      First;
      while not EOF do
      begin
         Node := tvUsersPermissions.Items.Add(nil, FieldByName((SecurityManager.PermissionBindary.KeyField)).AsString);
         Node.ImageIndex := 2;
         Node.SelectedIndex := 2;
         Node := tvGroupsPermissions.Items.Add(nil, FieldByName((SecurityManager.PermissionBindary.KeyField)).AsString);
         Node.ImageIndex := 2;
         Node.SelectedIndex := 2;
         Next;
      end;      // while
   end;      // with
end;

procedure TfrmPermissionsDlg.RefreshMembership;
var
   Node,
   UserNode : TTreeNode;
begin
   Node := tvMemberShipGroups.Items.GetFirstNode;
   while (Node <> nil) do
   begin
      UserNode := tvMembershipUsers.Items.GetFirstNode;
      while UserNode <> nil do
      begin
         if SecurityManager.GroupBindary.GroupMembershipBindary.Locate(VarArrayOf([UserNode.Text, Node.Text])) then
            tvMembershipGroups.Items.AddChild(Node, UserNode.Text);
         UserNode := UserNode.GetNextSibling;
      end;      // while
      Node := Node.GetNextSibling;
   end;      // while
   tvMembershipGroups.FullExpand;
end;


procedure TfrmPermissionsDlg.FormCreate(Sender: TObject);
begin
   pcPermissions.ActivePage := tsUsers;
end;

procedure TfrmPermissionsDlg.tvUsersUsersDragOver(Sender, Source: TObject;
  X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
   Accept := Source = tvUsersPermissions;
end;

procedure TfrmPermissionsDlg.tvGroupsGroupsDragOver(Sender,
  Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
   Accept := Source = tvGroupsPermissions;
end;

procedure TfrmPermissionsDlg.tvMembershipGroupsDragOver(Sender,
  Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
   Accept := Source = tvMembershipUsers;
end;

procedure TfrmPermissionsDlg.tvUsersUsersDragDrop(Sender, Source: TObject;
  X, Y: Integer);
var
   SenderTree, SourceTree : TTreeView;
   Node, SourceNode: TTreeNode;
   ImgIndex : Integer;
begin
   ImgIndex := -1;
   SourceTree := (Source as TTreeView);
   SenderTree := (Sender as TTreeView);

   if SenderTree = tvUsersUsers then
      ImgIndex := 2

   else if SenderTree = tvGroupsGroups then
      ImgIndex := 2

   else if SenderTree = tvMembershipGroups then
      ImgIndex := 0;

   SourceNode := SourceTree.Selected;

   Node := SenderTree.GetNodeAt(X,Y);

   if not Assigned(Node) then
     Exit;
     

   if Node.Level = 1 then
     Node := Node.Parent;

   if Node = nil then
     Exit;

   if SourceNode = nil then
     Exit;

   if Sender = tvUsersUsers then
   begin
     if SecurityManager.UserBindary.Locate(Node.Text) then
     begin
       if SecurityManager.UserBindary.UserPermissions.AddUserAccess(Node.Text,SourceNode.Text) then
         AddChild(SenderTree, Node, SourceNode.Text, ImgIndex);
     end;    
   end;

   if Sender = tvGroupsGroups then
   begin
     if SecurityManager.GroupBindary.Locate(Node.Text) then
       if SecurityManager.GroupBindary.GroupPermissions.AddGroupAccess(Node.Text,SourceNode.Text) then
         AddChild(SenderTree, Node, SourceNode.Text, ImgIndex);
   end;

   if (Sender = tvMembershipGroups) then
     if SecurityManager.GroupBindary.GroupMembershipBindary.AddUserToGroup(SourceNode.Text, Node.Text) then
       AddChild(SenderTree, Node, SourceNode.Text, ImgIndex);

   SenderTree.FullExpand;
end;

procedure TfrmPermissionsDlg.btnAddUserClick(Sender: TObject);
var
  AForm: TfrmEditUser;
  Fld: TField;
begin
   AForm := TfrmEditUser.Create(nil);
   try
      AForm.txtUsername.DataField := SecurityManager.UserBindary.UserNameField;
      AForm.txtFullName.DataField := SecurityManager.UserBindary.FullNameField;
      AForm.txtPassword.DataField := SecurityManager.UserBindary.PasswordField;
      AForm.labAccessCount.DataField := SecurityManager.UserBindary.AccessCountField;
      AForm.labCreatedDate.DataField := SecurityManager.UserBindary.CreatedDateField;
      AForm.labLastAccess.DataField := SecurityManager.UserBindary.LastAccessField;
      AForm.cbEnabled.DataField := SecurityManager.UserBindary.EnabledField;
      AForm.dsUsers.DataSet := SecurityManager.UserBindary.DataSource.DataSet;
      with AForm.dsUsers.DataSet do
      begin
         Append;
         if SecurityManager.UserBindary.AccessCountField <> '' then
         begin
            if Assigned(FieldByName(SecurityManager.UserBindary.AccessCountField)) then
              FieldByName(SecurityManager.UserBindary.AccessCountField).AsInteger := 0;
         end;     
         if SecurityManager.UserBindary.CreatedDateField <> '' then
         begin
            if Assigned(FieldByName(SecurityManager.UserBindary.CreatedDateField)) then
              FieldByName(SecurityManager.UserBindary.CreatedDateField).AsDateTime := Date;
         end;     
         if SecurityManager.UserBindary.CreatedTimeField <> '' then
         begin
            if Assigned(FieldByName(SecurityManager.UserBindary.CreatedTimeField)) then
              FieldByName(SecurityManager.UserBindary.CreatedTimeField).AsDateTime := Time;
         end;     
         if SecurityManager.UserBindary.EnabledField <> '' then
         begin
            if Assigned(FieldByName(SecurityManager.UserBindary.EnabledField)) then
            begin
              Fld := FieldByName(SecurityManager.UserBindary.EnabledField);
              if Fld.DataType = ftBoolean then
                Fld.AsBoolean := true
              else
                Fld.AsInteger := 1;  
            end;
         end;
      end;      // with.Append;

      if AForm.ShowModal = idOK then
      begin
         with AForm.dsUsers.DataSet do
            FieldByName(SecurityManager.UserBindary.PasswordField).AsString :=
                SecurityManager.UserBindary.Encrypt(FieldByName(SecurityManager.UserBindary.PasswordField).AsString);
         AForm.dsUsers.DataSet.Post;

         if Assigned(OnUserAdded) then
           OnUserAdded(self, AForm.txtUsername.Text);
      end
      else
         AForm.dsUsers.DataSet.Cancel;
      RefreshUsers;
   finally // wrap up
      AForm.Release;
   end;    // try/finally

end;

procedure TfrmPermissionsDlg.btnEditUserClick(Sender: TObject);
var
   AForm: TfrmEditUser;
   OldPassword : string;
begin
   if tvUsersUsers.Selected = nil then Exit;
   if tvUsersUsers.Selected.Parent <> nil then tvUsersUsers.Selected := tvUsersUsers.Selected.Parent;

   if SecurityManager.UserBindary.Locate(tvUsersUsers.Selected.Text) then
   begin
      AForm := TfrmEditUser.Create(nil);
      try
         OldPassword := SecurityManager.UserBindary.DataSource.DataSet.FieldByName(SecurityManager.UserBindary.PasswordField).AsString;
         AForm.txtUsername.DataField := SecurityManager.UserBindary.UserNameField;
         AForm.txtFullName.DataField := SecurityManager.UserBindary.FullNameField;
         AForm.txtPassword.DataField := SecurityManager.UserBindary.PasswordField;
         AForm.labAccessCount.DataField := SecurityManager.UserBindary.AccessCountField;
         AForm.labCreatedDate.DataField := SecurityManager.UserBindary.CreatedDateField;
         AForm.labLastAccess.DataField := SecurityManager.UserBindary.LastAccessField;
         AForm.cbEnabled.DataField := SecurityManager.UserBindary.EnabledField;
         AForm.dsUsers.DataSet := SecurityManager.UserBindary.DataSource.DataSet;
         AForm.txtPasswordVerify.Text := OldPassword;
         with AForm.dsUsers.DataSet do
            Edit;

         if AForm.ShowModal = idOK then
         with AForm.dsUsers.DataSet do
         begin
            // only encrypt if the password has changed...
            if OldPassword <> FieldByName(SecurityManager.UserBindary.PasswordField).AsString then
               FieldByName(SecurityManager.UserBindary.PasswordField).AsString :=
                   SecurityManager.UserBindary.Encrypt(FieldByName(SecurityManager.UserBindary.PasswordField).AsString);
            AForm.dsUsers.DataSet.Post;

            if Assigned(OnUserEdited) then
              OnUserEdited(self, AForm.txtUsername.Text);
         end
         else
            AForm.dsUsers.DataSet.Cancel;

      finally
         AForm.Release;
      end;
      RefreshUsers;
   end;
end;

procedure TfrmPermissionsDlg.btnDeleteUserClick(Sender: TObject);
begin
   if tvUsersUsers.Selected = nil then exit;

   if tvUsersUsers.Selected.Parent = nil then
   begin
      if MessageDlg('Are you sure you want to delete ' + tvUsersUsers.Selected.Text + '?', mtConfirmation, [mbYes, mbNo], 0) = idYes then
      begin
         if SecurityManager.UserBindary.Locate(tvUsersUsers.Selected.Text) then
         begin
            SecurityManager.UserBindary.DataSource.Dataset.Edit;
            SecurityManager.UserBindary.DataSource.Dataset.Delete;

            if Assigned(OnUserDeleted) then
              OnUserDeleted(Self,tvUsersUsers.Selected.Text);

         end;
         RefreshUsers;
      end;
   end
   else
   begin
      if SecurityManager.UserBindary.Locate(tvUsersUsers.Selected.Parent.Text) then
      begin
         if SecurityManager.UserBindary.UserPermissions.RemoveUserAccess(tvUsersUsers.Selected.Parent.Text,tvUsersUsers.Selected.Text) then
            tvUsersUsers.Selected.Delete;
      end;
   end;
end;

procedure TfrmPermissionsDlg.btnAddGroupClick(Sender: TObject);
var
  AForm: TfrmEditGroup;
begin
   AForm := TfrmEditGroup.Create(nil);
   try
      AForm.txtGroupName.DataField := SecurityManager.GroupBindary.GroupNameField;
      AForm.txtGroupDescription.DataField := SecurityManager.GroupBindary.GroupDescriptionField;
      AForm.dsGroups.DataSet := SecurityManager.GroupBindary.DataSource.DataSet;
      AForm.dsGroups.DataSet.Append;

      if AForm.ShowModal = idOK then
      begin
         AForm.dsGroups.DataSet.Post;
         if Assigned(OnGroupAdded) then
           OnGroupAdded(Self,AForm.txtGroupName.Text);
      end
      else
         AForm.dsGroups.DataSet.Cancel;
      RefreshGroups;
      RefreshMembership;
   finally // wrap up
      AForm.Release;
   end;    // try/finally
end;

procedure TfrmPermissionsDlg.btnEditGroupClick(Sender: TObject);
var
  AForm: TfrmEditGroup;
begin
   if tvGroupsGroups.Selected = nil then Exit;
   if tvGroupsGroups.Selected.Parent <> nil then Exit;

   if SecurityManager.GroupBindary.Locate(tvGroupsGroups.Selected.Text) then
   begin
      AForm := TfrmEditGroup.Create(nil);
      try
         AForm.txtGroupName.DataField := SecurityManager.GroupBindary.GroupNameField;
         AForm.txtGroupDescription.DataField := SecurityManager.GroupBindary.GroupDescriptionField;
         AForm.dsGroups.DataSet := SecurityManager.GroupBindary.DataSource.DataSet;
         AForm.dsGroups.DataSet.Edit;

         if AForm.ShowModal = idOK then
         begin
            AForm.dsGroups.DataSet.Post;
            if Assigned(OnGroupEdited) then
              OnGroupEdited(Self,AForm.txtGroupName.Text);
         end
         else
            AForm.dsGroups.DataSet.Cancel;

         RefreshGroups;
         RefreshMembership;
      finally // wrap up
         AForm.Release;
      end;    // try/finally
   end;
end;

procedure TfrmPermissionsDlg.btnDeleteGroupClick(Sender: TObject);
begin
   if (tvGroupsGroups.Selected = nil) then Exit;

   if tvGroupsGroups.Selected.Parent = nil then
   begin
      if MessageDlg('Are you sure you want to delete ' + tvGroupsGroups.Selected.Text + '?', mtConfirmation, [mbYes, mbNo], 0) = idYes then
      begin
         if SecurityManager.GroupBindary.Locate(tvGroupsGroups.Selected.Text) then
         begin
            SecurityManager.GroupBindary.DataSource.Dataset.Edit;
            SecurityManager.GroupBindary.DataSource.Dataset.Delete;

            if Assigned(OnGroupDeleted) then
              OnGroupDeleted(Self,tvGroupsGroups.Selected.Text);

         end;
         RefreshGroups;
         RefreshMembership;
      end;
   end
   else
   begin
      if SecurityManager.GroupBindary.Locate(tvGroupsGroups.Selected.Parent.Text) then
      begin
         SecurityManager.GroupBindary.GroupPermissions.RemoveGroupAccess(tvGroupsGroups.Selected.Parent.Text, tvGroupsGroups.Selected.Text);
         tvGroupsGroups.Selected.Delete;
      end;
   end;

end;

procedure TfrmPermissionsDlg.FormShow(Sender: TObject);
begin
   RefreshUsers;
   RefreshGroups;
   RefreshPermissions;
   RefreshMembership;
end;

procedure TfrmPermissionsDlg.btnRemoveMembershipClick(Sender: TObject);
begin
   if (tvMembershipGroups.Selected = nil) then Exit;
   if (tvMembershipGroups.Selected.Parent = nil) then Exit;

   if MessageDlg('Are you sure you want to remove ' + tvMembershipGroups.Selected.Text + ' from ' + tvMembershipGroups.Selected.Parent.Text + '?', mtConfirmation, [mbYes, mbNo], 0) = idYes then
      SecurityManager.GroupBindary.GroupMembershipBindary.RemoveUserFromGroup(tvMembershipGroups.Selected.Text, tvMembershipGroups.Selected.Parent.Text);

   RefreshGroups;
   RefreshMembership;
end;

procedure TfrmPermissionsDlg.Splitter1Moved(Sender: TObject);
begin
   tvUsersPermissions.Refresh;
end;

procedure TfrmPermissionsDlg.Splitter2Moved(Sender: TObject);
begin
   tvGroupsPermissions.Refresh;
end;

procedure TfrmPermissionsDlg.Splitter3Moved(Sender: TObject);
begin
   tvMembershipUsers.Refresh;
end;

procedure TfrmPermissionsDlg.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if (ssCtrl in Shift) then
      case Key of
         ord('A')  : if pcPermissions.ActivePage = tsUsers then
                        btnPermissionToUserClick(nil)
                     else if pcPermissions.ActivePage = tsGroups then
                        btnPermissionToGroupClick(nil)
                     else
                        btnUserToGroupClick(nil);
         ord('R'),
         vk_Delete : if pcPermissions.ActivePage = tsUsers then
                        btnDeleteUserClick(nil)
                     else if pcPermissions.ActivePage = tsGroups then
                        btnDeleteGroupClick(nil)
                     else
                        btnRemoveMembershipClick(nil);
      end;
end;

procedure TfrmPermissionsDlg.Cut1Click(Sender: TObject);
begin
   if tvUsersUsers.Selected <> nil then
      CurrentCopy := tvUsersUsers.Selected
   else
      Exit;
   while CurrentCopy.Parent <> nil do
     CurrentCopy := CurrentCopy.Parent;
end;

procedure TfrmPermissionsDlg.PastePermissions1Click(Sender: TObject);
var
   DestNode : TTreeNode;
begin
   if (tvUsersUsers.Selected <> nil) and (tvUsersUsers.Selected <> CurrentCopy) then
      DestNode := tvUsersUsers.Selected
   else
      Exit;

   while DestNode.Parent <> nil do
      DestNode := DestNode.Parent;

//      if SecurityManager.UserBindary.Locate(CurNode.Parent.Text) then
//         SecurityManager.UserBindary.UserPermissions.AddAccess(CurNode.Text);
end;

procedure TfrmPermissionsDlg.btnPermissionToUserClick(Sender: TObject);
var
   Node : TTreeNode;
begin
   if not Assigned(tvUsersPermissions.Selected) then
     Exit;

   Node := tvUsersUsers.Selected;
   if not Assigned(Node) then
     Exit;

   while Assigned(Node.Parent) do
      Node := Node.Parent;

   if SecurityManager.UserBindary.Locate(Node.Text) then
      if SecurityManager.UserBindary.UserPermissions.AddUserAccess(Node.Text, tvUsersPermissions.Selected.Text) then
         AddChild(tvUsersUsers, Node, tvUsersPermissions.Selected.Text, 2);
         
   Node.Selected := true;

   Node := tvUsersPermissions.Selected.GetNextSibling;
   if Node <> nil then
      Node.Selected := true;
end;

procedure TfrmPermissionsDlg.btnPermissionToGroupClick(Sender: TObject);
var
   Node : TTreeNode;
begin
   if not Assigned(tvGroupsPermissions.Selected) then Exit;
   Node := tvGroupsGroups.Selected;
   if not Assigned(Node) then Exit;
   while Assigned(Node.Parent) do
      Node := Node.Parent;

   if SecurityManager.GroupBindary.Locate(Node.Text) then
      if SecurityManager.GroupBindary.GroupPermissions.AddGroupAccess(Node.Text, tvGroupsPermissions.Selected.Text) then
         AddChild(tvGroupsGroups, Node, tvGroupsPermissions.Selected.Text, 2);
   Node.Selected := true;

   Node := tvGroupsPermissions.Selected.GetNextSibling;
   if Node <> nil then
      Node.Selected := true;
end;

procedure TfrmPermissionsDlg.btnUserToGroupClick(Sender: TObject);
var
   Node : TTreeNode;
begin
   if not Assigned(tvMembershipUsers.Selected) then
     Exit;

   Node := tvMembershipGroups.Selected;

   if not Assigned(Node) then
     Exit;

   while Assigned(Node.Parent) do
      Node := Node.Parent;

   if SecurityManager.GroupBindary.Locate(Node.Text) then
      if SecurityManager.GroupBindary.GroupMembershipBindary.AddUserToGroup(tvMembershipUsers.Selected.Text, Node.Text) then
         AddChild(tvMembershipGroups, Node, tvMembershipUsers.Selected.Text, 0);

   Node.Selected := true;
   Node := tvMembershipUsers.Selected.GetNextSibling;
//   if Node.GetNextSibling <> nil then
//      Node.GetNextSibling.Selected := true;
   if assigned(Node) then
      Node.Selected := true;

end;

procedure TfrmPermissionsDlg.tvMembershipGroupsChange(Sender: TObject;
  Node: TTreeNode);
begin
   if Assigned(Node) then
      btnRemoveMembership.Enabled := Assigned(Node.Parent);
end;

end.
