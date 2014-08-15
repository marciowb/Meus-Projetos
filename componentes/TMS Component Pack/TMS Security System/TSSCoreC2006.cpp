//---------------------------------------------------------------------------

#include <basepch.h>
#pragma hdrstop
USEFORMNS("uEditGroupForm.pas", Ueditgroupform, frmEditGroup);
USEFORMNS("uEditUserForm.pas", Uedituserform, frmEditUser);
USEFORMNS("uFormPolicyDesigner.pas", Uformpolicydesigner, frmFormPolicy);
//---------------------------------------------------------------------------
#pragma package(smart_init)
//---------------------------------------------------------------------------

//   Package source.
//---------------------------------------------------------------------------

#pragma argsused
int WINAPI DllEntryPoint(HINSTANCE hinst, unsigned long reason, void*)
{
        return 1;
}
//---------------------------------------------------------------------------
