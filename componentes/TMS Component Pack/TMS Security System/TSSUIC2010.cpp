//---------------------------------------------------------------------------

#include <basepch.h>
#pragma hdrstop
USEFORMNS("uAboutUILSecurity.pas", Uaboutuilsecurity, frmAboutUilUtilities);
USEFORMNS("uChangePasswordForm.pas", Uchangepasswordform, uilChangePasswordForm);
USEFORMNS("uLoginForm.pas", Uloginform, uilLoginForm);
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
