{************************************************}
{                                                }
{               EurekaLog v 6.x                  }
{                 Include file                   }
{                                                }
{  Copyright (c) 2001 - 2008 by Fabio Dell'Aria  }
{                                                }
{************************************************}

// Do NOT change the below lines (are used in build script)
//{$DEFINE EUREKALOG_DEMO}
{$DEFINE ENTERPRISE}
{$DEFINE PROFESSIONAL} // Comment only for Standard version.
//{$DEFINE DUNIT}

//{$DEFINE GENERATE_ACTIVEX} // WARNING: only internal uses (allow generation of ActiveX controls).

{$B-} // Disable Complete-Boolean evaluation.
{$T-} // Disable Typed-Pointer generation.
{$U-} // Disable Safe-Divide generation.
{$J-} // Disable Assignable-Typed-Constant.
{$A+} // Enable Record-Field-Alignment.
{$X+} // Enable Extended-Syntax.
{$V+} // Enable Strict-Var-Strings.
{$P+} // Enable Open-Parameters.
{$H+} // Enable Huge-Strings.
{$C+} // Enable Assertions.
{$Z1} // Set MinEnumSize=1 byte.
{$R-} // Disable Range-Checking.
{$Q-} // Disable Overflow-Checking.
{$D+} // Enable Debug-Infos generation (for internal Debugging).

{$IFNDEF DUNIT}
  {$W-} // Disable Stack-Frames generation.
  {$O+} // Enable Optimization.
{$ELSE}
  {$W+} // Enable Stack-Frames generation.
  {$O-} // Disable Optimization.
{$ENDIF}

// Delphi/C++Builder DEFINE directives...

{$IFDEF VER100} // Delphi 3.0
  {$DEFINE Delphi3Up}
  {$DEFINE Delphi3}
  {$DEFINE Delphi3Down}
  {$DEFINE Delphi4Down}
  {$DEFINE Delphi5Down}
  {$DEFINE Delphi6Down}
  {$DEFINE Delphi7Down}
  {$DEFINE Delphi8Down}
  {$DEFINE Delphi9Down}
  {$DEFINE Delphi10Down}
  {$DEFINE Delphi11Down}
  {$DEFINE Delphi12Down}
  {$DEFINE Delphi14Down}
  {$DEFINE Delphi15Down}
  {$DEFINE Delphi16Down}
  {$DEFINE Delphi17Down}
  {$DEFINE Delphi18Down}
  {$DEFINE Delphi19Down}
  {$DEFINE Delphi20Down}
  {$DEFINE Delphi21Down}
  {$DEFINE Delphi22Down}
  {$DEFINE Delphi23Down}
  {$DEFINE Delphi24Down}
  {$DEFINE Delphi25Down}
  {$DEFINE Delphi26Down}
  {$DEFINE Delphi27Down}
  {$DEFINE Delphi28Down}
  {$DEFINE Delphi29Down}
  {$DEFINE Delphi30Down}
{$ENDIF}

{$IFDEF VER120} // Delphi 4.0
  {$DEFINE Delphi3Up}
  {$DEFINE Delphi4Up}
  {$DEFINE Delphi4}
  {$DEFINE Delphi4Down}
  {$DEFINE Delphi5Down}
  {$DEFINE Delphi6Down}
  {$DEFINE Delphi7Down}
  {$DEFINE Delphi8Down}
  {$DEFINE Delphi9Down}
  {$DEFINE Delphi10Down}
  {$DEFINE Delphi11Down}
  {$DEFINE Delphi12Down}
  {$DEFINE Delphi14Down}
  {$DEFINE Delphi15Down}
  {$DEFINE Delphi16Down}
  {$DEFINE Delphi17Down}
  {$DEFINE Delphi18Down}
  {$DEFINE Delphi19Down}
  {$DEFINE Delphi20Down}
  {$DEFINE Delphi21Down}
  {$DEFINE Delphi22Down}
  {$DEFINE Delphi23Down}
  {$DEFINE Delphi24Down}
  {$DEFINE Delphi25Down}
  {$DEFINE Delphi26Down}
  {$DEFINE Delphi27Down}
  {$DEFINE Delphi28Down}
  {$DEFINE Delphi29Down}
  {$DEFINE Delphi30Down}
{$ENDIF}

{$IFDEF VER130} // Delphi 5.0
  {$DEFINE Delphi3Up}
  {$DEFINE Delphi4Up}
  {$DEFINE Delphi5Up}
  {$DEFINE Delphi5}
  {$DEFINE Delphi5Down}
  {$DEFINE Delphi6Down}
  {$DEFINE Delphi7Down}
  {$DEFINE Delphi8Down}
  {$DEFINE Delphi9Down}
  {$DEFINE Delphi10Down}
  {$DEFINE Delphi11Down}
  {$DEFINE Delphi12Down}
  {$DEFINE Delphi14Down}
  {$DEFINE Delphi15Down}
  {$DEFINE Delphi16Down}
  {$DEFINE Delphi17Down}
  {$DEFINE Delphi18Down}
  {$DEFINE Delphi19Down}
  {$DEFINE Delphi20Down}
  {$DEFINE Delphi21Down}
  {$DEFINE Delphi22Down}
  {$DEFINE Delphi23Down}
  {$DEFINE Delphi24Down}
  {$DEFINE Delphi25Down}
  {$DEFINE Delphi26Down}
  {$DEFINE Delphi27Down}
  {$DEFINE Delphi28Down}
  {$DEFINE Delphi29Down}
  {$DEFINE Delphi30Down}
{$ENDIF}

{$IFDEF VER140} // Delphi 6.0
  {$DEFINE Delphi3Up}
  {$DEFINE Delphi4Up}
  {$DEFINE Delphi5Up}
  {$DEFINE Delphi6Up}
  {$DEFINE Delphi6}
  {$DEFINE Delphi6Down}
  {$DEFINE Delphi7Down}
  {$DEFINE Delphi8Down}
  {$DEFINE Delphi9Down}
  {$DEFINE Delphi10Down}
  {$DEFINE Delphi11Down}
  {$DEFINE Delphi12Down}
  {$DEFINE Delphi14Down}
  {$DEFINE Delphi15Down}
  {$DEFINE Delphi16Down}
  {$DEFINE Delphi17Down}
  {$DEFINE Delphi18Down}
  {$DEFINE Delphi19Down}
  {$DEFINE Delphi20Down}
  {$DEFINE Delphi21Down}
  {$DEFINE Delphi22Down}
  {$DEFINE Delphi23Down}
  {$DEFINE Delphi24Down}
  {$DEFINE Delphi25Down}
  {$DEFINE Delphi26Down}
  {$DEFINE Delphi27Down}
  {$DEFINE Delphi28Down}
  {$DEFINE Delphi29Down}
  {$DEFINE Delphi30Down}
{$ENDIF}

{$IFDEF VER150} // Delphi 7.0
  {$DEFINE Delphi3Up}
  {$DEFINE Delphi4Up}
  {$DEFINE Delphi5Up}
  {$DEFINE Delphi6Up}
  {$DEFINE Delphi7Up}
  {$DEFINE Delphi7}
  {$DEFINE Delphi7Down}
  {$DEFINE Delphi8Down}
  {$DEFINE Delphi9Down}
  {$DEFINE Delphi10Down}
  {$DEFINE Delphi11Down}
  {$DEFINE Delphi12Down}
  {$DEFINE Delphi14Down}
  {$DEFINE Delphi15Down}
  {$DEFINE Delphi16Down}
  {$DEFINE Delphi17Down}
  {$DEFINE Delphi18Down}
  {$DEFINE Delphi19Down}
  {$DEFINE Delphi20Down}
  {$DEFINE Delphi21Down}
  {$DEFINE Delphi22Down}
  {$DEFINE Delphi23Down}
  {$DEFINE Delphi24Down}
  {$DEFINE Delphi25Down}
  {$DEFINE Delphi26Down}
  {$DEFINE Delphi27Down}
  {$DEFINE Delphi28Down}
  {$DEFINE Delphi29Down}
  {$DEFINE Delphi30Down}
{$ENDIF}

{$IFDEF VER170} // Delphi 9.0
  {$DEFINE Delphi3Up}
  {$DEFINE Delphi4Up}
  {$DEFINE Delphi5Up}
  {$DEFINE Delphi6Up}
  {$DEFINE Delphi7Up}
  {$DEFINE Delphi8Up}
  {$DEFINE Delphi9Up}
  {$DEFINE Delphi9}
  {$DEFINE Delphi9Down}
  {$DEFINE Delphi10Down}
  {$DEFINE Delphi11Down}
  {$DEFINE Delphi12Down}
  {$DEFINE Delphi14Down}
  {$DEFINE Delphi15Down}
  {$DEFINE Delphi16Down}
  {$DEFINE Delphi17Down}
  {$DEFINE Delphi18Down}
  {$DEFINE Delphi19Down}
  {$DEFINE Delphi20Down}
  {$DEFINE Delphi21Down}
  {$DEFINE Delphi22Down}
  {$DEFINE Delphi23Down}
  {$DEFINE Delphi24Down}
  {$DEFINE Delphi25Down}
  {$DEFINE Delphi26Down}
  {$DEFINE Delphi27Down}
  {$DEFINE Delphi28Down}
  {$DEFINE Delphi29Down}
  {$DEFINE Delphi30Down}

  {$DEFINE EurekaLog_XML_Options}
{$ENDIF}

{$IFDEF VER180} // Delphi 10.0
  {$IFNDEF VER185}
    {$DEFINE Delphi3Up}
    {$DEFINE Delphi4Up}
    {$DEFINE Delphi5Up}
    {$DEFINE Delphi6Up}
    {$DEFINE Delphi7Up}
    {$DEFINE Delphi8Up}
    {$DEFINE Delphi9Up}
    {$DEFINE Delphi10Up}
    {$DEFINE Delphi10}
    {$DEFINE Delphi10Down}
    {$DEFINE Delphi11Down}
    {$DEFINE Delphi12Down}
    {$DEFINE Delphi14Down}
    {$DEFINE Delphi15Down}
    {$DEFINE Delphi16Down}
    {$DEFINE Delphi17Down}
    {$DEFINE Delphi18Down}
    {$DEFINE Delphi19Down}
    {$DEFINE Delphi20Down}
    {$DEFINE Delphi21Down}
    {$DEFINE Delphi22Down}
    {$DEFINE Delphi23Down}
    {$DEFINE Delphi24Down}
    {$DEFINE Delphi25Down}
    {$DEFINE Delphi26Down}
    {$DEFINE Delphi27Down}
    {$DEFINE Delphi28Down}
    {$DEFINE Delphi29Down}
    {$DEFINE Delphi30Down}

    {$DEFINE EurekaLog_XML_Options}
  {$ENDIF}
{$ENDIF}

{$IFDEF VER185} // Delphi 11.0
  {$DEFINE Delphi3Up}
  {$DEFINE Delphi4Up}
  {$DEFINE Delphi5Up}
  {$DEFINE Delphi6Up}
  {$DEFINE Delphi7Up}
  {$DEFINE Delphi8Up}
  {$DEFINE Delphi9Up}
  {$DEFINE Delphi10Up}
  {$DEFINE Delphi11Up}
  {$DEFINE Delphi11}
  {$DEFINE Delphi11Down}
  {$DEFINE Delphi12Down}
  {$DEFINE Delphi14Down}
  {$DEFINE Delphi15Down}
  {$DEFINE Delphi16Down}
  {$DEFINE Delphi17Down}
  {$DEFINE Delphi18Down}
  {$DEFINE Delphi19Down}
  {$DEFINE Delphi20Down}
  {$DEFINE Delphi21Down}
  {$DEFINE Delphi22Down}
  {$DEFINE Delphi23Down}
  {$DEFINE Delphi24Down}
  {$DEFINE Delphi25Down}
  {$DEFINE Delphi26Down}
  {$DEFINE Delphi27Down}
  {$DEFINE Delphi28Down}
  {$DEFINE Delphi29Down}
  {$DEFINE Delphi30Down}
{$ENDIF}

{$IFDEF VER100} // Delphi 3.0
  {$DEFINE Delphi3Up}
  {$DEFINE Delphi3}
  {$DEFINE Delphi3Down}
  {$DEFINE Delphi4Down}
  {$DEFINE Delphi5Down}
  {$DEFINE Delphi6Down}
  {$DEFINE Delphi7Down}
  {$DEFINE Delphi8Down}
  {$DEFINE Delphi9Down}
  {$DEFINE Delphi10Down}
  {$DEFINE Delphi11Down}
  {$DEFINE Delphi12Down}
  {$DEFINE Delphi14Down}
  {$DEFINE Delphi15Down}
  {$DEFINE Delphi16Down}
  {$DEFINE Delphi17Down}
  {$DEFINE Delphi18Down}
  {$DEFINE Delphi19Down}
  {$DEFINE Delphi20Down}
  {$DEFINE Delphi21Down}
  {$DEFINE Delphi22Down}
  {$DEFINE Delphi23Down}
  {$DEFINE Delphi24Down}
  {$DEFINE Delphi25Down}
  {$DEFINE Delphi26Down}
  {$DEFINE Delphi27Down}
  {$DEFINE Delphi28Down}
  {$DEFINE Delphi29Down}
  {$DEFINE Delphi30Down}
{$ENDIF}

{$IFDEF VER120} // Delphi 4.0
  {$DEFINE Delphi3Up}
  {$DEFINE Delphi4Up}
  {$DEFINE Delphi4}
  {$DEFINE Delphi4Down}
  {$DEFINE Delphi5Down}
  {$DEFINE Delphi6Down}
  {$DEFINE Delphi7Down}
  {$DEFINE Delphi8Down}
  {$DEFINE Delphi9Down}
  {$DEFINE Delphi10Down}
  {$DEFINE Delphi11Down}
  {$DEFINE Delphi12Down}
  {$DEFINE Delphi14Down}
  {$DEFINE Delphi15Down}
  {$DEFINE Delphi16Down}
  {$DEFINE Delphi17Down}
  {$DEFINE Delphi18Down}
  {$DEFINE Delphi19Down}
  {$DEFINE Delphi20Down}
  {$DEFINE Delphi21Down}
  {$DEFINE Delphi22Down}
  {$DEFINE Delphi23Down}
  {$DEFINE Delphi24Down}
  {$DEFINE Delphi25Down}
  {$DEFINE Delphi26Down}
  {$DEFINE Delphi27Down}
  {$DEFINE Delphi28Down}
  {$DEFINE Delphi29Down}
  {$DEFINE Delphi30Down}
{$ENDIF}

{$IFDEF VER130} // Delphi 5.0
  {$DEFINE Delphi3Up}
  {$DEFINE Delphi4Up}
  {$DEFINE Delphi5Up}
  {$DEFINE Delphi5}
  {$DEFINE Delphi5Down}
  {$DEFINE Delphi6Down}
  {$DEFINE Delphi7Down}
  {$DEFINE Delphi8Down}
  {$DEFINE Delphi9Down}
  {$DEFINE Delphi10Down}
  {$DEFINE Delphi11Down}
  {$DEFINE Delphi12Down}
  {$DEFINE Delphi14Down}
  {$DEFINE Delphi15Down}
  {$DEFINE Delphi16Down}
  {$DEFINE Delphi17Down}
  {$DEFINE Delphi18Down}
  {$DEFINE Delphi19Down}
  {$DEFINE Delphi20Down}
  {$DEFINE Delphi21Down}
  {$DEFINE Delphi22Down}
  {$DEFINE Delphi23Down}
  {$DEFINE Delphi24Down}
  {$DEFINE Delphi25Down}
  {$DEFINE Delphi26Down}
  {$DEFINE Delphi27Down}
  {$DEFINE Delphi28Down}
  {$DEFINE Delphi29Down}
  {$DEFINE Delphi30Down}
{$ENDIF}

{$IFDEF VER140} // Delphi 6.0
  {$DEFINE Delphi3Up}
  {$DEFINE Delphi4Up}
  {$DEFINE Delphi5Up}
  {$DEFINE Delphi6Up}
  {$DEFINE Delphi6}
  {$DEFINE Delphi6Down}
  {$DEFINE Delphi7Down}
  {$DEFINE Delphi8Down}
  {$DEFINE Delphi9Down}
  {$DEFINE Delphi10Down}
  {$DEFINE Delphi11Down}
  {$DEFINE Delphi12Down}
  {$DEFINE Delphi14Down}
  {$DEFINE Delphi15Down}
  {$DEFINE Delphi16Down}
  {$DEFINE Delphi17Down}
  {$DEFINE Delphi18Down}
  {$DEFINE Delphi19Down}
  {$DEFINE Delphi20Down}
  {$DEFINE Delphi21Down}
  {$DEFINE Delphi22Down}
  {$DEFINE Delphi23Down}
  {$DEFINE Delphi24Down}
  {$DEFINE Delphi25Down}
  {$DEFINE Delphi26Down}
  {$DEFINE Delphi27Down}
  {$DEFINE Delphi28Down}
  {$DEFINE Delphi29Down}
  {$DEFINE Delphi30Down}
{$ENDIF}

{$IFDEF VER150} // Delphi 7.0
  {$DEFINE Delphi3Up}
  {$DEFINE Delphi4Up}
  {$DEFINE Delphi5Up}
  {$DEFINE Delphi6Up}
  {$DEFINE Delphi7Up}
  {$DEFINE Delphi7}
  {$DEFINE Delphi7Down}
  {$DEFINE Delphi8Down}
  {$DEFINE Delphi9Down}
  {$DEFINE Delphi10Down}
  {$DEFINE Delphi11Down}
  {$DEFINE Delphi12Down}
  {$DEFINE Delphi14Down}
  {$DEFINE Delphi15Down}
  {$DEFINE Delphi16Down}
  {$DEFINE Delphi17Down}
  {$DEFINE Delphi18Down}
  {$DEFINE Delphi19Down}
  {$DEFINE Delphi20Down}
  {$DEFINE Delphi21Down}
  {$DEFINE Delphi22Down}
  {$DEFINE Delphi23Down}
  {$DEFINE Delphi24Down}
  {$DEFINE Delphi25Down}
  {$DEFINE Delphi26Down}
  {$DEFINE Delphi27Down}
  {$DEFINE Delphi28Down}
  {$DEFINE Delphi29Down}
  {$DEFINE Delphi30Down}
{$ENDIF}

{$IFDEF VER170} // Delphi 9.0
  {$DEFINE Delphi3Up}
  {$DEFINE Delphi4Up}
  {$DEFINE Delphi5Up}
  {$DEFINE Delphi6Up}
  {$DEFINE Delphi7Up}
  {$DEFINE Delphi8Up}
  {$DEFINE Delphi9Up}
  {$DEFINE Delphi9}
  {$DEFINE Delphi9Down}
  {$DEFINE Delphi10Down}
  {$DEFINE Delphi11Down}
  {$DEFINE Delphi12Down}
  {$DEFINE Delphi14Down}
  {$DEFINE Delphi15Down}
  {$DEFINE Delphi16Down}
  {$DEFINE Delphi17Down}
  {$DEFINE Delphi18Down}
  {$DEFINE Delphi19Down}
  {$DEFINE Delphi20Down}
  {$DEFINE Delphi21Down}
  {$DEFINE Delphi22Down}
  {$DEFINE Delphi23Down}
  {$DEFINE Delphi24Down}
  {$DEFINE Delphi25Down}
  {$DEFINE Delphi26Down}
  {$DEFINE Delphi27Down}
  {$DEFINE Delphi28Down}
  {$DEFINE Delphi29Down}
  {$DEFINE Delphi30Down}

  {$DEFINE EurekaLog_XML_Options}
{$ENDIF}

{$IFDEF VER180} // Delphi 10.0
  {$IFNDEF VER185}
    {$DEFINE Delphi3Up}
    {$DEFINE Delphi4Up}
    {$DEFINE Delphi5Up}
    {$DEFINE Delphi6Up}
    {$DEFINE Delphi7Up}
    {$DEFINE Delphi8Up}
    {$DEFINE Delphi9Up}
    {$DEFINE Delphi10Up}
    {$DEFINE Delphi10}
    {$DEFINE Delphi10Down}
    {$DEFINE Delphi11Down}
    {$DEFINE Delphi12Down}
    {$DEFINE Delphi14Down}
    {$DEFINE Delphi15Down}
    {$DEFINE Delphi16Down}
    {$DEFINE Delphi17Down}
    {$DEFINE Delphi18Down}
    {$DEFINE Delphi19Down}
    {$DEFINE Delphi20Down}
    {$DEFINE Delphi21Down}
    {$DEFINE Delphi22Down}
    {$DEFINE Delphi23Down}
    {$DEFINE Delphi24Down}
    {$DEFINE Delphi25Down}
    {$DEFINE Delphi26Down}
    {$DEFINE Delphi27Down}
    {$DEFINE Delphi28Down}
    {$DEFINE Delphi29Down}
    {$DEFINE Delphi30Down}

    {$DEFINE EurekaLog_XML_Options}
  {$ENDIF}
{$ENDIF}

{$IFDEF VER185} // Delphi 11.0
  {$DEFINE Delphi3Up}
  {$DEFINE Delphi4Up}
  {$DEFINE Delphi5Up}
  {$DEFINE Delphi6Up}
  {$DEFINE Delphi7Up}
  {$DEFINE Delphi8Up}
  {$DEFINE Delphi9Up}
  {$DEFINE Delphi10Up}
  {$DEFINE Delphi11Up}
  {$DEFINE Delphi11}
  {$DEFINE Delphi11Down}
  {$DEFINE Delphi12Down}
  {$DEFINE Delphi14Down}
  {$DEFINE Delphi15Down}
  {$DEFINE Delphi16Down}
  {$DEFINE Delphi17Down}
  {$DEFINE Delphi18Down}
  {$DEFINE Delphi19Down}
  {$DEFINE Delphi20Down}
  {$DEFINE Delphi21Down}
  {$DEFINE Delphi22Down}
  {$DEFINE Delphi23Down}
  {$DEFINE Delphi24Down}
  {$DEFINE Delphi25Down}
  {$DEFINE Delphi26Down}
  {$DEFINE Delphi27Down}
  {$DEFINE Delphi28Down}
  {$DEFINE Delphi29Down}
  {$DEFINE Delphi30Down}
{$ENDIF}

{$IFDEF VER200} // Delphi 12.0
  {$DEFINE Delphi3Up}
  {$DEFINE Delphi4Up}
  {$DEFINE Delphi5Up}
  {$DEFINE Delphi6Up}
  {$DEFINE Delphi7Up}
  {$DEFINE Delphi8Up}
  {$DEFINE Delphi9Up}
  {$DEFINE Delphi10Up}
  {$DEFINE Delphi11Up}
  {$DEFINE Delphi12Up}
  {$DEFINE Delphi12}
  {$DEFINE Delphi12Down}
  {$DEFINE Delphi14Down}
  {$DEFINE Delphi15Down}
  {$DEFINE Delphi16Down}
  {$DEFINE Delphi17Down}
  {$DEFINE Delphi18Down}
  {$DEFINE Delphi19Down}
  {$DEFINE Delphi20Down}
  {$DEFINE Delphi21Down}
  {$DEFINE Delphi22Down}
  {$DEFINE Delphi23Down}
  {$DEFINE Delphi24Down}
  {$DEFINE Delphi25Down}
  {$DEFINE Delphi26Down}
  {$DEFINE Delphi27Down}
  {$DEFINE Delphi28Down}
  {$DEFINE Delphi29Down}
  {$DEFINE Delphi30Down}
{$ENDIF}

{$IFDEF VER210} // Delphi 14.0
  {$DEFINE Delphi3Up}
  {$DEFINE Delphi4Up}
  {$DEFINE Delphi5Up}
  {$DEFINE Delphi6Up}
  {$DEFINE Delphi7Up}
  {$DEFINE Delphi8Up}
  {$DEFINE Delphi9Up}
  {$DEFINE Delphi10Up}
  {$DEFINE Delphi11Up}
  {$DEFINE Delphi12Up}
  {$DEFINE Delphi14Up}
  {$DEFINE Delphi14}
  {$DEFINE Delphi14Down}
  {$DEFINE Delphi15Down}
  {$DEFINE Delphi16Down}
  {$DEFINE Delphi17Down}
  {$DEFINE Delphi18Down}
  {$DEFINE Delphi19Down}
  {$DEFINE Delphi20Down}
  {$DEFINE Delphi21Down}
  {$DEFINE Delphi22Down}
  {$DEFINE Delphi23Down}
  {$DEFINE Delphi24Down}
  {$DEFINE Delphi25Down}
  {$DEFINE Delphi26Down}
  {$DEFINE Delphi27Down}
  {$DEFINE Delphi28Down}
  {$DEFINE Delphi29Down}
  {$DEFINE Delphi30Down}
{$ENDIF}

{$IFDEF VER220} // Delphi 15.0
  {$DEFINE Delphi3Up}
  {$DEFINE Delphi4Up}
  {$DEFINE Delphi5Up}
  {$DEFINE Delphi6Up}
  {$DEFINE Delphi7Up}
  {$DEFINE Delphi8Up}
  {$DEFINE Delphi9Up}
  {$DEFINE Delphi10Up}
  {$DEFINE Delphi11Up}
  {$DEFINE Delphi12Up}
  {$DEFINE Delphi14Up}
  {$DEFINE Delphi15Up}
  {$DEFINE Delphi15}
  {$DEFINE Delphi15Down}
  {$DEFINE Delphi16Down}
  {$DEFINE Delphi17Down}
  {$DEFINE Delphi18Down}
  {$DEFINE Delphi19Down}
  {$DEFINE Delphi20Down}
  {$DEFINE Delphi21Down}
  {$DEFINE Delphi22Down}
  {$DEFINE Delphi23Down}
  {$DEFINE Delphi24Down}
  {$DEFINE Delphi25Down}
  {$DEFINE Delphi26Down}
  {$DEFINE Delphi27Down}
  {$DEFINE Delphi28Down}
  {$DEFINE Delphi29Down}
  {$DEFINE Delphi30Down}
{$ENDIF}

{$IFDEF VER230} // Delphi 16.0
  {$DEFINE Delphi3Up}
  {$DEFINE Delphi4Up}
  {$DEFINE Delphi5Up}
  {$DEFINE Delphi6Up}
  {$DEFINE Delphi7Up}
  {$DEFINE Delphi8Up}
  {$DEFINE Delphi9Up}
  {$DEFINE Delphi10Up}
  {$DEFINE Delphi11Up}
  {$DEFINE Delphi12Up}
  {$DEFINE Delphi14Up}
  {$DEFINE Delphi15Up}
  {$DEFINE Delphi16Up}
  {$DEFINE Delphi16}
  {$DEFINE Delphi16Down}
  {$DEFINE Delphi17Down}
  {$DEFINE Delphi18Down}
  {$DEFINE Delphi19Down}
  {$DEFINE Delphi20Down}
  {$DEFINE Delphi21Down}
  {$DEFINE Delphi22Down}
  {$DEFINE Delphi23Down}
  {$DEFINE Delphi24Down}
  {$DEFINE Delphi25Down}
  {$DEFINE Delphi26Down}
  {$DEFINE Delphi27Down}
  {$DEFINE Delphi28Down}
  {$DEFINE Delphi29Down}
  {$DEFINE Delphi30Down}
{$ENDIF}

{$IFDEF VER240} // Delphi 17.0
  {$DEFINE Delphi3Up}
  {$DEFINE Delphi4Up}
  {$DEFINE Delphi5Up}
  {$DEFINE Delphi6Up}
  {$DEFINE Delphi7Up}
  {$DEFINE Delphi8Up}
  {$DEFINE Delphi9Up}
  {$DEFINE Delphi10Up}
  {$DEFINE Delphi11Up}
  {$DEFINE Delphi12Up}
  {$DEFINE Delphi14Up}
  {$DEFINE Delphi15Up}
  {$DEFINE Delphi16Up}
  {$DEFINE Delphi17Up}
  {$DEFINE Delphi17}
  {$DEFINE Delphi17Down}
  {$DEFINE Delphi18Down}
  {$DEFINE Delphi19Down}
  {$DEFINE Delphi20Down}
  {$DEFINE Delphi21Down}
  {$DEFINE Delphi22Down}
  {$DEFINE Delphi23Down}
  {$DEFINE Delphi24Down}
  {$DEFINE Delphi25Down}
  {$DEFINE Delphi26Down}
  {$DEFINE Delphi27Down}
  {$DEFINE Delphi28Down}
  {$DEFINE Delphi29Down}
  {$DEFINE Delphi30Down}
{$ENDIF}

{$IFDEF VER250} // Delphi 18.0
  {$DEFINE Delphi3Up}
  {$DEFINE Delphi4Up}
  {$DEFINE Delphi5Up}
  {$DEFINE Delphi6Up}
  {$DEFINE Delphi7Up}
  {$DEFINE Delphi8Up}
  {$DEFINE Delphi9Up}
  {$DEFINE Delphi10Up}
  {$DEFINE Delphi11Up}
  {$DEFINE Delphi12Up}
  {$DEFINE Delphi14Up}
  {$DEFINE Delphi15Up}
  {$DEFINE Delphi16Up}
  {$DEFINE Delphi17Up}
  {$DEFINE Delphi18Up}
  {$DEFINE Delphi18}
  {$DEFINE Delphi18Down}
  {$DEFINE Delphi19Down}
  {$DEFINE Delphi20Down}
  {$DEFINE Delphi21Down}
  {$DEFINE Delphi22Down}
  {$DEFINE Delphi23Down}
  {$DEFINE Delphi24Down}
  {$DEFINE Delphi25Down}
  {$DEFINE Delphi26Down}
  {$DEFINE Delphi27Down}
  {$DEFINE Delphi28Down}
  {$DEFINE Delphi29Down}
  {$DEFINE Delphi30Down}
{$ENDIF}

{$IFDEF VER260} // Delphi 19.0
  {$DEFINE Delphi3Up}
  {$DEFINE Delphi4Up}
  {$DEFINE Delphi5Up}
  {$DEFINE Delphi6Up}
  {$DEFINE Delphi7Up}
  {$DEFINE Delphi8Up}
  {$DEFINE Delphi9Up}
  {$DEFINE Delphi10Up}
  {$DEFINE Delphi11Up}
  {$DEFINE Delphi12Up}
  {$DEFINE Delphi14Up}
  {$DEFINE Delphi15Up}
  {$DEFINE Delphi16Up}
  {$DEFINE Delphi17Up}
  {$DEFINE Delphi18Up}
  {$DEFINE Delphi19Up}
  {$DEFINE Delphi19}
  {$DEFINE Delphi19Down}
  {$DEFINE Delphi20Down}
  {$DEFINE Delphi21Down}
  {$DEFINE Delphi22Down}
  {$DEFINE Delphi23Down}
  {$DEFINE Delphi24Down}
  {$DEFINE Delphi25Down}
  {$DEFINE Delphi26Down}
  {$DEFINE Delphi27Down}
  {$DEFINE Delphi28Down}
  {$DEFINE Delphi29Down}
  {$DEFINE Delphi30Down}
{$ENDIF}

{$IFDEF VER270} // Delphi 20.0
  {$DEFINE Delphi3Up}
  {$DEFINE Delphi4Up}
  {$DEFINE Delphi5Up}
  {$DEFINE Delphi6Up}
  {$DEFINE Delphi7Up}
  {$DEFINE Delphi8Up}
  {$DEFINE Delphi9Up}
  {$DEFINE Delphi10Up}
  {$DEFINE Delphi11Up}
  {$DEFINE Delphi12Up}
  {$DEFINE Delphi14Up}
  {$DEFINE Delphi15Up}
  {$DEFINE Delphi16Up}
  {$DEFINE Delphi17Up}
  {$DEFINE Delphi18Up}
  {$DEFINE Delphi19Up}
  {$DEFINE Delphi20Up}
  {$DEFINE Delphi20}
  {$DEFINE Delphi20Down}
  {$DEFINE Delphi21Down}
  {$DEFINE Delphi22Down}
  {$DEFINE Delphi23Down}
  {$DEFINE Delphi24Down}
  {$DEFINE Delphi25Down}
  {$DEFINE Delphi26Down}
  {$DEFINE Delphi27Down}
  {$DEFINE Delphi28Down}
  {$DEFINE Delphi29Down}
  {$DEFINE Delphi30Down}
{$ENDIF}

{$IFDEF VER280} // Delphi 21.0
  {$DEFINE Delphi3Up}
  {$DEFINE Delphi4Up}
  {$DEFINE Delphi5Up}
  {$DEFINE Delphi6Up}
  {$DEFINE Delphi7Up}
  {$DEFINE Delphi8Up}
  {$DEFINE Delphi9Up}
  {$DEFINE Delphi10Up}
  {$DEFINE Delphi11Up}
  {$DEFINE Delphi12Up}
  {$DEFINE Delphi14Up}
  {$DEFINE Delphi15Up}
  {$DEFINE Delphi16Up}
  {$DEFINE Delphi17Up}
  {$DEFINE Delphi18Up}
  {$DEFINE Delphi19Up}
  {$DEFINE Delphi20Up}
  {$DEFINE Delphi21Up}
  {$DEFINE Delphi21}
  {$DEFINE Delphi21Down}
  {$DEFINE Delphi22Down}
  {$DEFINE Delphi23Down}
  {$DEFINE Delphi24Down}
  {$DEFINE Delphi25Down}
  {$DEFINE Delphi26Down}
  {$DEFINE Delphi27Down}
  {$DEFINE Delphi28Down}
  {$DEFINE Delphi29Down}
  {$DEFINE Delphi30Down}
{$ENDIF}

{$IFDEF VER290} // Delphi 22.0
  {$DEFINE Delphi3Up}
  {$DEFINE Delphi4Up}
  {$DEFINE Delphi5Up}
  {$DEFINE Delphi6Up}
  {$DEFINE Delphi7Up}
  {$DEFINE Delphi8Up}
  {$DEFINE Delphi9Up}
  {$DEFINE Delphi10Up}
  {$DEFINE Delphi11Up}
  {$DEFINE Delphi12Up}
  {$DEFINE Delphi14Up}
  {$DEFINE Delphi15Up}
  {$DEFINE Delphi16Up}
  {$DEFINE Delphi17Up}
  {$DEFINE Delphi18Up}
  {$DEFINE Delphi19Up}
  {$DEFINE Delphi20Up}
  {$DEFINE Delphi21Up}
  {$DEFINE Delphi22Up}
  {$DEFINE Delphi22}
  {$DEFINE Delphi22Down}
  {$DEFINE Delphi23Down}
  {$DEFINE Delphi24Down}
  {$DEFINE Delphi25Down}
  {$DEFINE Delphi26Down}
  {$DEFINE Delphi27Down}
  {$DEFINE Delphi28Down}
  {$DEFINE Delphi29Down}
  {$DEFINE Delphi30Down}
{$ENDIF}

{$IFDEF VER300} // Delphi 23.0
  {$DEFINE Delphi3Up}
  {$DEFINE Delphi4Up}
  {$DEFINE Delphi5Up}
  {$DEFINE Delphi6Up}
  {$DEFINE Delphi7Up}
  {$DEFINE Delphi8Up}
  {$DEFINE Delphi9Up}
  {$DEFINE Delphi10Up}
  {$DEFINE Delphi11Up}
  {$DEFINE Delphi12Up}
  {$DEFINE Delphi14Up}
  {$DEFINE Delphi15Up}
  {$DEFINE Delphi16Up}
  {$DEFINE Delphi17Up}
  {$DEFINE Delphi18Up}
  {$DEFINE Delphi19Up}
  {$DEFINE Delphi20Up}
  {$DEFINE Delphi21Up}
  {$DEFINE Delphi22Up}
  {$DEFINE Delphi23Up}
  {$DEFINE Delphi23}
  {$DEFINE Delphi23Down}
  {$DEFINE Delphi24Down}
  {$DEFINE Delphi25Down}
  {$DEFINE Delphi26Down}
  {$DEFINE Delphi27Down}
  {$DEFINE Delphi28Down}
  {$DEFINE Delphi29Down}
  {$DEFINE Delphi30Down}
{$ENDIF}

{$IFDEF VER310} // Delphi 24.0
  {$DEFINE Delphi3Up}
  {$DEFINE Delphi4Up}
  {$DEFINE Delphi5Up}
  {$DEFINE Delphi6Up}
  {$DEFINE Delphi7Up}
  {$DEFINE Delphi8Up}
  {$DEFINE Delphi9Up}
  {$DEFINE Delphi10Up}
  {$DEFINE Delphi11Up}
  {$DEFINE Delphi12Up}
  {$DEFINE Delphi14Up}
  {$DEFINE Delphi15Up}
  {$DEFINE Delphi16Up}
  {$DEFINE Delphi17Up}
  {$DEFINE Delphi18Up}
  {$DEFINE Delphi19Up}
  {$DEFINE Delphi20Up}
  {$DEFINE Delphi21Up}
  {$DEFINE Delphi22Up}
  {$DEFINE Delphi23Up}
  {$DEFINE Delphi24Up}
  {$DEFINE Delphi24}
  {$DEFINE Delphi24Down}
  {$DEFINE Delphi25Down}
  {$DEFINE Delphi26Down}
  {$DEFINE Delphi27Down}
  {$DEFINE Delphi28Down}
  {$DEFINE Delphi29Down}
  {$DEFINE Delphi30Down}
{$ENDIF}

{$IFDEF VER320} // Delphi 25.0
  {$DEFINE Delphi3Up}
  {$DEFINE Delphi4Up}
  {$DEFINE Delphi5Up}
  {$DEFINE Delphi6Up}
  {$DEFINE Delphi7Up}
  {$DEFINE Delphi8Up}
  {$DEFINE Delphi9Up}
  {$DEFINE Delphi10Up}
  {$DEFINE Delphi11Up}
  {$DEFINE Delphi12Up}
  {$DEFINE Delphi14Up}
  {$DEFINE Delphi15Up}
  {$DEFINE Delphi16Up}
  {$DEFINE Delphi17Up}
  {$DEFINE Delphi18Up}
  {$DEFINE Delphi19Up}
  {$DEFINE Delphi20Up}
  {$DEFINE Delphi21Up}
  {$DEFINE Delphi22Up}
  {$DEFINE Delphi23Up}
  {$DEFINE Delphi24Up}
  {$DEFINE Delphi25Up}
  {$DEFINE Delphi25}
  {$DEFINE Delphi25Down}
  {$DEFINE Delphi26Down}
  {$DEFINE Delphi27Down}
  {$DEFINE Delphi28Down}
  {$DEFINE Delphi29Down}
  {$DEFINE Delphi30Down}
{$ENDIF}

{$IFDEF VER330} // Delphi 26.0
  {$DEFINE Delphi3Up}
  {$DEFINE Delphi4Up}
  {$DEFINE Delphi5Up}
  {$DEFINE Delphi6Up}
  {$DEFINE Delphi7Up}
  {$DEFINE Delphi8Up}
  {$DEFINE Delphi9Up}
  {$DEFINE Delphi10Up}
  {$DEFINE Delphi11Up}
  {$DEFINE Delphi12Up}
  {$DEFINE Delphi14Up}
  {$DEFINE Delphi15Up}
  {$DEFINE Delphi16Up}
  {$DEFINE Delphi17Up}
  {$DEFINE Delphi18Up}
  {$DEFINE Delphi19Up}
  {$DEFINE Delphi20Up}
  {$DEFINE Delphi21Up}
  {$DEFINE Delphi22Up}
  {$DEFINE Delphi23Up}
  {$DEFINE Delphi24Up}
  {$DEFINE Delphi25Up}
  {$DEFINE Delphi26Up}
  {$DEFINE Delphi26}
  {$DEFINE Delphi26Down}
  {$DEFINE Delphi27Down}
  {$DEFINE Delphi28Down}
  {$DEFINE Delphi29Down}
  {$DEFINE Delphi30Down}
{$ENDIF}

{$IFDEF VER340} // Delphi 27.0
  {$DEFINE Delphi3Up}
  {$DEFINE Delphi4Up}
  {$DEFINE Delphi5Up}
  {$DEFINE Delphi6Up}
  {$DEFINE Delphi7Up}
  {$DEFINE Delphi8Up}
  {$DEFINE Delphi9Up}
  {$DEFINE Delphi10Up}
  {$DEFINE Delphi11Up}
  {$DEFINE Delphi12Up}
  {$DEFINE Delphi14Up}
  {$DEFINE Delphi15Up}
  {$DEFINE Delphi16Up}
  {$DEFINE Delphi17Up}
  {$DEFINE Delphi18Up}
  {$DEFINE Delphi19Up}
  {$DEFINE Delphi20Up}
  {$DEFINE Delphi21Up}
  {$DEFINE Delphi22Up}
  {$DEFINE Delphi23Up}
  {$DEFINE Delphi24Up}
  {$DEFINE Delphi25Up}
  {$DEFINE Delphi26Up}
  {$DEFINE Delphi27Up}
  {$DEFINE Delphi27}
  {$DEFINE Delphi27Down}
  {$DEFINE Delphi28Down}
  {$DEFINE Delphi29Down}
  {$DEFINE Delphi30Down}
{$ENDIF}

{$IFDEF VER350} // Delphi 28.0
  {$DEFINE Delphi3Up}
  {$DEFINE Delphi4Up}
  {$DEFINE Delphi5Up}
  {$DEFINE Delphi6Up}
  {$DEFINE Delphi7Up}
  {$DEFINE Delphi8Up}
  {$DEFINE Delphi9Up}
  {$DEFINE Delphi10Up}
  {$DEFINE Delphi11Up}
  {$DEFINE Delphi12Up}
  {$DEFINE Delphi14Up}
  {$DEFINE Delphi15Up}
  {$DEFINE Delphi16Up}
  {$DEFINE Delphi17Up}
  {$DEFINE Delphi18Up}
  {$DEFINE Delphi19Up}
  {$DEFINE Delphi20Up}
  {$DEFINE Delphi21Up}
  {$DEFINE Delphi22Up}
  {$DEFINE Delphi23Up}
  {$DEFINE Delphi24Up}
  {$DEFINE Delphi25Up}
  {$DEFINE Delphi26Up}
  {$DEFINE Delphi27Up}
  {$DEFINE Delphi28Up}
  {$DEFINE Delphi28}
  {$DEFINE Delphi28Down}
  {$DEFINE Delphi29Down}
  {$DEFINE Delphi30Down}
{$ENDIF}

{$IFDEF VER360} // Delphi 29.0
  {$DEFINE Delphi3Up}
  {$DEFINE Delphi4Up}
  {$DEFINE Delphi5Up}
  {$DEFINE Delphi6Up}
  {$DEFINE Delphi7Up}
  {$DEFINE Delphi8Up}
  {$DEFINE Delphi9Up}
  {$DEFINE Delphi10Up}
  {$DEFINE Delphi11Up}
  {$DEFINE Delphi12Up}
  {$DEFINE Delphi14Up}
  {$DEFINE Delphi15Up}
  {$DEFINE Delphi16Up}
  {$DEFINE Delphi17Up}
  {$DEFINE Delphi18Up}
  {$DEFINE Delphi19Up}
  {$DEFINE Delphi20Up}
  {$DEFINE Delphi21Up}
  {$DEFINE Delphi22Up}
  {$DEFINE Delphi23Up}
  {$DEFINE Delphi24Up}
  {$DEFINE Delphi25Up}
  {$DEFINE Delphi26Up}
  {$DEFINE Delphi27Up}
  {$DEFINE Delphi28Up}
  {$DEFINE Delphi29Up}
  {$DEFINE Delphi29}
  {$DEFINE Delphi29Down}
  {$DEFINE Delphi30Down}
{$ENDIF}

{$IFDEF VER370} // Delphi 30.0
  {$DEFINE Delphi3Up}
  {$DEFINE Delphi4Up}
  {$DEFINE Delphi5Up}
  {$DEFINE Delphi6Up}
  {$DEFINE Delphi7Up}
  {$DEFINE Delphi8Up}
  {$DEFINE Delphi9Up}
  {$DEFINE Delphi10Up}
  {$DEFINE Delphi11Up}
  {$DEFINE Delphi12Up}
  {$DEFINE Delphi14Up}
  {$DEFINE Delphi15Up}
  {$DEFINE Delphi16Up}
  {$DEFINE Delphi17Up}
  {$DEFINE Delphi18Up}
  {$DEFINE Delphi19Up}
  {$DEFINE Delphi20Up}
  {$DEFINE Delphi21Up}
  {$DEFINE Delphi22Up}
  {$DEFINE Delphi23Up}
  {$DEFINE Delphi24Up}
  {$DEFINE Delphi25Up}
  {$DEFINE Delphi26Up}
  {$DEFINE Delphi27Up}
  {$DEFINE Delphi28Up}
  {$DEFINE Delphi29Up}
  {$DEFINE Delphi30Up}
  {$DEFINE Delphi30}
  {$DEFINE Delphi30Down}
{$ENDIF}

{$IFDEF BCB} // C++Builder
  {$DEFINE CBuilder}
  {$OBJEXPORTALL On}
  {$DEFINE EurekaLog_XML_Options}
{$ELSE}
  {$DEFINE Delphi}
{$ENDIF}

{$IFNDEF CBuilder} // Use Win32 INI file
  {$IFDEF Delphi7Down}
    {$DEFINE UseIniFile}
  {$ENDIF}
{$ENDIF}

// Disable "Special" Warnings Messages...
{$IFDEF Delphi6Up}
  {$WARN SYMBOL_PLATFORM OFF}   // Disable General Platform Warning Messages.
  {$WARN UNIT_PLATFORM OFF}     // Disable Unit Platform Warning Messages.
  {$WARN UNIT_DEPRECATED OFF}   // Disable Unit Deprecated Warning Messages.
  {$WARN SYMBOL_DEPRECATED OFF} // Disable Symbol Deprecated Warning Messages.
  {$IFDEF Delphi7Up}
    {$WARN UNSAFE_CODE OFF} // Disable Unsafe Code Warning Messages.
    {$WARN UNSAFE_TYPE OFF} // Disable Unsafe Type Warning Messages.
    {$WARN UNSAFE_CAST OFF} // Disable Unsafe TypeCast Warning Messages.
  {$ENDIF}
{$ENDIF}

{$IFDEF Delphi12Up}
  {$WARN IMPLICIT_STRING_CAST OFF}
  {$WARN IMPLICIT_STRING_CAST_LOSS OFF}
  {$WARN SUSPICIOUS_TYPECAST ERROR}
{$ENDIF}


