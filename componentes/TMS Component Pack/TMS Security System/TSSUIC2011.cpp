//---------------------------------------------------------------------------

#include <basepch.h>
#pragma hdrstop
USEFORMNS("uLoginForm.pas", Uloginform, uilLoginForm);
USEFORMNS("uChangePasswordForm.pas", Uchangepasswordform, uilChangePasswordForm);
USEFORMNS("uAboutUILSecurity.pas", Uaboutuilsecurity, frmAboutUilUtilities);
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
