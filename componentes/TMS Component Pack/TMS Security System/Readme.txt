The TMS Security System 2.4
===========================

Contents:
---------

1) Welcome, and thanks!
2) Installing the components
3) Release Notes for Version 2.4
4) Update History
5) Orders
6) Copyright
7) Disclaimer of Warrantee


1) Welcome and thanks!
----------------------

Welcome to the TMS Security System 2.4! Thanks for your interest in our
system, and we hope that it becomes a powerful addition to your toolkit!
If you have any questions, suggestions or problems, feel free to contact
us at help@tmssoftware.com.


2) Installing the components
----------------------------

Delphi 6:

- Unzip tssd6.zip into a separate directory
- Choose File, Open and browse for TSSCoreD6.dpk
- From the package editor, press Compile
- Choose File, Open and browse for TSSUID6.dpk
- From the package editor, press Install
- The components are now installed in the component palette under TMS Security

Delphi 7:

- Unzip tssd7.zip into a separate directory
- Choose File, Open and browse for TSSCoreD7.dpk
- From the package editor, press Compile
- Choose File, Open and browse for TSSUID7.dpk
- From the package editor, press Install
- The components are now installed in the component palette under TMS Security

Delphi 2005:

- Unzip tssd2005.zip into a separate directory
- Choose File, Open and browse for TSSCoreD2005.bdsproj
- From the project manager, right click the project & press Compile
- Choose File, Open and browse for TSSUID2005.bdproj
- From the project manager, right click the project & press Install
- The components are now installed in the component palette under TMS Security

Delphi 2006/C++Builder 2006 (trial version):

- Close the IDE
- run setup.exe
- Restart the IDE

Delphi 2007,2009,2010,XE / C++Builder 2007,2009,2010,XE (trial version):

- Close the IDE
- run setup.exe
- Restart the IDE

Delphi 2006 registered version
- Choose File, Open and browse for TSSCoreD2006.bdsproj
- From the project manager, right click the project & press Compile
- Choose File, Open and browse for TSSUID2006.bdsproj
- From the project manager, right click the project & press Install
- The components are now installed in the component palette under TMS Security

Delphi 2007 registered version
- Choose File, Open and browse for TSSCoreD2007.dproj
- From the project manager, right click the project & press Compile
- Choose File, Open and browse for TSSUID2007.dproj
- From the project manager, right click the project & press Install
- The components are now installed in the component palette under TMS Security

Delphi 2009 registered version
- Choose File, Open and browse for TSSCoreD2009.dproj
- From the project manager, right click the project & press Compile
- Choose File, Open and browse for TSSUID2009.dproj
- From the project manager, right click the project & press Install
- The components are now installed in the component palette under TMS Security

Delphi 2010 registered version
- Choose File, Open and browse for TSSCoreD2010.dproj
- From the project manager, right click the project & press Compile
- Choose File, Open and browse for TSSUID2010.dproj
- From the project manager, right click the project & press Install
- The components are now installed in the component palette under TMS Security

Delphi XE registered version
- Choose File, Open and browse for TSSCoreD2011.dproj
- From the project manager, right click the project & press Compile
- Choose File, Open and browse for TSSUID2011.dproj
- From the project manager, right click the project & press Install
- The components are now installed in the component palette under TMS Security

C++Builder 2006 registered version
- Choose File, Open and browse for TSSCoreC2006.bdsproj
- From the project manager, right click the project & press Compile
- Choose File, Open and browse for TSSUIC2006.bdsproj
- From the project manager, right click the project & press Install
- The components are now installed in the component palette under TMS Security

C++Builder 2007 registered version
- Choose File, Open and browse for TSSCoreC2007.cbproj
- From the project manager, right click the project & press Compile
- Choose File, Open and browse for TSSUIC2007.cbproj
- From the project manager, right click the project & press Install
- The components are now installed in the component palette under TMS Security

C++Builder 2009 registered version
- Choose File, Open and browse for TSSCoreC2009.cbproj
- From the project manager, right click the project & press Compile
- Choose File, Open and browse for TSSUIC2009.cbproj
- From the project manager, right click the project & press Install
- The components are now installed in the component palette under TMS Security

C++Builder 2010 registered version
- Choose File, Open and browse for TSSCoreC2010.cbproj
- From the project manager, right click the project & press Compile
- Choose File, Open and browse for TSSUIC2010.cbproj
- From the project manager, right click the project & press Install
- The components are now installed in the component palette under TMS Security

C++Builder 2011 registered version
- Choose File, Open and browse for TSSCoreC2011.cbproj
- From the project manager, right click the project & press Compile
- Choose File, Open and browse for TSSUIC2011.cbproj
- From the project manager, right click the project & press Install
- The components are now installed in the component palette under TMS Security

C++Builder 6:

- Unzip tssc6.zip into a separate directory
- Choose File, Open and browse for TSSCoreC6.bpk
- From the package editor, press Compile
- Choose File, Open and browse for TSSUIC6.bpk
- From the package editor, press Install
- The components are now installed in the component palette under TMS Security


3) Release Notes for Version 2.4
--------------------------------

- The TMS Security System is compatible with Delphi 6,7,2005,2006,2007 & C++Builder 6,2006,2007
- While the user password is encrypted, you still need to use
  table-level encryption in order to ensure tight security.


4) Update History
-----------------
2.4.3  - New : Support for RAD Studio XE added

2.4    - New : CanAddUser, CanEditUser, CanDeleteUser properties added for TuilSecurityDlg
       - New : CanAddGroup, CanEditGroup, CanDeleteGroup properties added for TuilSecurityDlg
       - New : Persistence of form policy dialog size & splitter position
       - New : Persistence of security dialog splitter position
       - New : List components that have ReadOnly property in policy dialog 
       - New : Multiform demo
       - New : Full expand / full collaps options in policy dialog
       - Improved : Package structure

2.3.2  - New : Delphi 2007 support added

2.3.1  - New : FireBird demo (thanks to Udo Treichel)
       - Fixed : issue with SecuityManager assignment to FormPolicy

2.3    - uilSecurityManager.OnFailedLoginDetail event added
       - uilSecurityManager.LoginTriesRemaining property added
       - uilSecurityManager.LoginTryNumber property added
       - uilSecurityDialog.OnUserAdded, OnUserEdited, OnUserDeleted events added
       - uilSecurityDialog.OnGroupAdded, OnGroupEdited, OnGroupDeleted events added
       - uilChangePasswordDialog added 
       - OnFilterComponent added in uilFormPolicyDlg component
       - extension to offer better support for components like TAdvOfficePager
       - maximize, minimize buttons added in form policy dialog
       - Various smaller fixes & code improvements

2.2.2  - Improved handling of login dialog for blank usernames
       - Improved handling of form policy delete with database persisted policies

2.2.1  - Improved to allow the security system to work with databases that do not support boolean fields
       - Improved FormPolicyDlg to check policy selection before applying an action

2.2    - FormPolicyDlg.IgnoreList allows to remove components from the editable component list
       - SecurityManager.ChangePassword method added to alow the current logged in user to change the password
       - Improved handling of runtime editable form policies
       - Added support for Delphi 2005

2.1.0  - FormPolicy can be edited at runtime
       - Event to encrypt passwords in db
       - Custom security policy with event
       - Read Only security policy
       - PageControl tabsheet show/hide support
       - Active property for TuilFormPolicy to enable/disable security system on form level
       - Active property for TuilSecurityManager to enable/disable security system on application level
       - Added demo for ADO

2.0.12 - Added C++Builder 5 & C++Builder 6 support
       - Added demo for Apollo database

2.0.11 - Released as TMS Security System

2.0.10 - Added support for Delphi 7
       - Fixed problems using a TuilFormPolicy on DataModules
       - Fixed "missing field" errors when last access time property
         was left empty
       - Fixed occasional AV when deleting a form policies from a
         form
       - Fixed up the demo programs somewhat
       - Included demos for Paradox, Advantage, DBISAM and FlashFiler

2.0.8   - Added support for Delphi 6
	- Occasional AV when adding users to groups fixed
	- The "Panel4" caption that appeared on the membership
	  tab when resized has been removed
	- Demos updated with newest data files
	- Updated tutorial to include Master-Detail setup

2.0.7 	- Form Policy now lets Delphi know a change has been made.
	- The same component can now be in multiple policies without
	  conflict.
	- The UserBindary now has additional properties:
	    - CaseSensitivePassword
	    - CaseSensitiveUserName
	    - LastAccessTimeField
	    - CreatedTimeField
	- The LoginDlg now has additional events:
	    - OnAfterLoginAttempt
	    - OnBeforeLoginAttempt
	- Shareware version now displays nag screen instead of
	  detecting Delphi (this caused some problems with some
	  Delphi installs).

2.0.6   - The UserBindary now has a ChangePassword(NewPassword :
	  string) method to make it easier for end-users to change
	  their password.
	- All dialogs are now accessible by keyboard.
	- Buttons have been added to the SecurityDlg and Form Policy
	  editor.
	- Nicer images for most of the standard components are now
	  displayed in the Form Policy editor.
	- Internal changes to the way that the Bindaries and the
	  SecurityDlg work. The next major update (2.1) should make
	  designing your own SecurityDlg fairly easy because of this.
	- SecurityDlg.ShowGroups now works as expected.

2.0.5   - Strange problems with the component editors have been fixed.
	- User passwords are now encrypted using an internal routine.
	- OnEncrypt has been moved to the TuilBindary class.
	- Editing a user now puts the verify password in.


2.0.4 	- The TuilFormPolicy.ActivateAll and Deactivate methods have
	  been removed, and replaced with one Apply method
	- The help file has been improved somewhat
	- A manual, in DOC Format, has been included in the Help
	  folder.

2.0.3   - You can now double-click on the TuilSecurityManager and
	  edit users, groups and permissions!
	- All forms now have splitters (to resize the left and right
	  sides of the dialogs)
	- Right-click-delete menu item added to the Form Policy
	  Editor
	- Added a fieldname property editor for the various
	  Bindary classes
	- Added an Encrypt function and OnEncryptPassword event
	  to TuilSecurityManager
	- Added OnDisabledLogin event when a user attempts to login
	  with a disabled account
	- TuilSecurityDlg can now store it's size to the registry
	- Fix: You can no longer add the same permission multiple
	  times to a user or group
	- Fix: Adding a group no longer hides the group membership
	- Fix: In Delphi 3, sometimes a "Record not found" error
	  would come up.
	- Fix: You can no longer add the same item multiple times in
	  the Form Policy editor

2.0.2   - Added Default fieldnames to the various Bindary
	  classes
	- Fix: TuilLoginDlg.Retries now works as expected

2.0.1   - Fix: Enabled field now works correctly

2.0.0   - Initial public release


5) Orders
---------
Use of the components in your applications requires a license. With
a license, no additional runtime royalty fees have to be paid.
A license can be obtained upon registration for the TMS Security System
online from http://www.tmssoftware.com/go/?tss or
http://www.tmssoftware.com/go/?orders


6) Copyright
------------

Portions of the TMS Security System are (c) Copyright 2002, Unlimited Intelligence
Limited (UIL). TMS Security System is (c) Copyright 2003 - 2009, TMS software.
The entire package, including source, binaries, demos, and this file, are covered
under this copyright.


7) Disclaimer of Warrantee
--------------------------

NO WARRANTIES.  TMS software expressly
disclaims any warranty for the TMS Security System (SOFTWARE COMPONENT
PRODUCT(S)).  THE SOFTWARE COMPONENT PRODUCT(S) AND ANY RELATED
DOCUMENTATION IS PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, 
EITHER EXPRESS OR IMPLIED, INCLUDING, WITHOUT LIMITATION,
THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR 
PURPOSE, OR NONINFRINGEMENT.  THE ENTIRE RISK ARISING OUT OF USE OR
PERFORMANCE OF THE SOFTWARE COMPONENT PRODUCT(S) REMAINS WITH YOU. 
To the maximum extent permitted by applicable law, in no event shall
TMS software be liable for any special, incidental, indirect, or 
consequential damages whatsoever (including, without limitation, 
damages for loss of business profits, business interruption, loss of
business information, or any other pecuniary loss) arising out of the
use of or inability to use the SOFTWARE COMPONENTb PRODUCT(S) or the 
provision of or failure to provide Support Services, even if TMS software
has been advised of the possibility of such damages. 