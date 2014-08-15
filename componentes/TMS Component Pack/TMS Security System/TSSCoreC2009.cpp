//---------------------------------------------------------------------------

#include <basepch.h>
#pragma hdrstop
USEFORMNS("uFormPolicyDesigner.pas", Uformpolicydesigner, frmFormPolicy);
USEFORMNS("uEditUserForm.pas", Uedituserform, frmEditUser);
USEFORMNS("uEditGroupForm.pas", Ueditgroupform, frmEditGroup);
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
