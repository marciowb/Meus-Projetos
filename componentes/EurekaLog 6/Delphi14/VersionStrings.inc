{************************************************}
{                                                }
{               EurekaLog v 6.x                  }
{             Version Strings file               }
{                                                }
{  Copyright (c) 2001 - 2008 by Fabio Dell'Aria  }
{                                                }
{************************************************}

{$I Exceptions.inc}

{$IFDEF Delphi12Up}
const
  _CompanyName = 'CodeGear';
{$ELSE}
const
  _CompanyName = 'Borland';
{$ENDIF}

{$IFDEF Delphi12}
const
  _BDSVer      = '6';
  _LanguageVer = '12';
{$ENDIF}

{$IFDEF Delphi14}
const
  _BDSVer      = '7';
  _LanguageVer = '14';
{$ENDIF}

{$IFDEF Delphi15}
const
  _BDSVer      = '9';
  _LanguageVer = '15';
{$ENDIF}

{$IFDEF Delphi16}
const
  _BDSVer      = '10';
  _LanguageVer = '16';
{$ENDIF}

{$IFDEF Delphi17}
const
  _BDSVer      = '11';
  _LanguageVer = '17';
{$ENDIF}

{$IFDEF Delphi18}
const
  _BDSVer      = '12';
  _LanguageVer = '18';
{$ENDIF}

{$IFDEF Delphi19}
const
  _BDSVer      = '13';
  _LanguageVer = '19';
{$ENDIF}

{$IFDEF Delphi20}
const
  _BDSVer      = '14';
  _LanguageVer = '20';
{$ENDIF}

{$IFDEF Delphi21}
const
  _BDSVer      = '15';
  _LanguageVer = '21';
{$ENDIF}

{$IFDEF Delphi22}
const
  _BDSVer      = '16';
  _LanguageVer = '22';
{$ENDIF}

{$IFDEF Delphi23}
const
  _BDSVer      = '17';
  _LanguageVer = '23';
{$ENDIF}

{$IFDEF Delphi24}
const
  _BDSVer      = '18';
  _LanguageVer = '24';
{$ENDIF}

{$IFDEF Delphi25}
const
  _BDSVer      = '19';
  _LanguageVer = '25';
{$ENDIF}

{$IFDEF Delphi26}
const
  _BDSVer      = '20';
  _LanguageVer = '26';
{$ENDIF}

{$IFDEF Delphi27}
const
  _BDSVer      = '21';
  _LanguageVer = '27';
{$ENDIF}

{$IFDEF Delphi28}
const
  _BDSVer      = '22';
  _LanguageVer = '28';
{$ENDIF}

{$IFDEF Delphi29}
const
  _BDSVer      = '23';
  _LanguageVer = '29';
{$ENDIF}

{$IFDEF Delphi30}
const
  _BDSVer      = '24';
  _LanguageVer = '30';
{$ENDIF}

//------------------------------------------------------------------------------

{$IFDEF Delphi3}
const
  RADVersionString = '3.0';
  Real_RADVersionString = RADVersionString;
  VCL = 'VCL30.DPL';
  INDY1 = '';
  INDY2 = '';
  IniAppendLine = '';
  CreateFileA_Module = VCL;
{$ENDIF}

{$IFDEF Delphi4}
const
  RADVersionString = '4.0';
  Real_RADVersionString = RADVersionString;
  VCL = 'VCL40.BPL';
  INDY1 = 'INDY40.BPL';
  INDY2 = 'INDYCORE40.BPL';  
  IniAppendLine = '';
  CreateFileA_Module = VCL;
  LoadLibraryExA_Module = 'CORIDE40.BPL';
{$ENDIF}

{$IFDEF Delphi5}
const
  RADVersionString = '5.0';
  Real_RADVersionString = RADVersionString;
  VCL = 'VCL50.BPL';
  INDY1 = 'INDY50.BPL';
  INDY2 = 'INDYCORE50.BPL';  
  {$IFDEF CBuilder}
    IniAppendLine = '</IDEOPTIONS>';
  {$ELSE}
    IniAppendLine = '';
  {$ENDIF}
  CreateFileA_Module = VCL;
  LoadLibraryExA_Module = 'CORIDE50.BPL';
{$ENDIF}

{$IFDEF Delphi6}
const
  RADVersionString = '6.0';
  Real_RADVersionString = RADVersionString;
  VCL = 'VCL60.BPL';
  CLX = 'VISUALCLX60.BPL';
  INDY1 = 'INDY60.BPL';
  INDY2 = 'INDYCORE60.BPL';  
  {$IFDEF CBuilder}
    IniAppendLine = '</IDEOPTIONS>';
  {$ELSE}
    IniAppendLine = '';
  {$ENDIF}
  CreateFileA_Module = 'RTL60.BPL';
  LoadLibraryExA_Module = 'COREIDE60.BPL';
{$ENDIF}

{$IFDEF Delphi7}
const
  RADVersionString = '7.0';
  Real_RADVersionString = RADVersionString;
  VCL = 'VCL70.BPL';
  CLX = 'VISUALCLX70.BPL';
  INDY1 = 'INDY70.BPL';
  INDY2 = 'INDYCORE70.BPL';  
  IniAppendLine = '';
  CreateFileA_Module = 'RTL70.BPL';
  LoadLibraryExA_Module = 'COREIDE70.BPL';
{$ENDIF}

{$IFDEF Delphi9}
const
  RADVersionString = '3.0';
  Real_RADVersionString = '9.0';
  VCL = 'VCL90.BPL';
  CLX = 'VISUALCLX90.BPL'; // CLX unsupported ???
  INDY1 = 'INDY90.BPL';
  INDY2 = 'INDYCORE90.BPL';
  IniAppendLine = '</BorlandProject>';
  CreateFileA_Module = 'RTL90.BPL';
  LoadLibraryExA_Module = 'COREIDE90.BPL';
{$ENDIF}

{$IFDEF Delphi10}
const
  RADVersionString = '4.0';
  Real_RADVersionString = '10.0';
  VCL = 'VCL100.BPL';
  CLX = 'VISUALCLX100.BPL'; // CLX unsupported ???
  INDY1 = 'INDY90.BPL';
  INDY2 = 'INDYCORE90.BPL';
  IniAppendLine = '</BorlandProject>';
  CreateFileA_Module = 'RTL100.BPL';
  LoadLibraryExA_Module = 'COREIDE100.BPL';
{$ENDIF}

{$IFDEF Delphi11}
const
  RADVersionString = '5.0';
  Real_RADVersionString = '11.0';
  VCL = 'VCL100.BPL';
  CLX = 'VISUALCLX100.BPL'; // CLX unsupported ???
  INDY1 = 'INDY100.BPL';
  INDY2 = 'INDYCORE100.BPL';  
  IniAppendLine = '';
  CreateFileA_Module = 'RTL100.BPL';
  LoadLibraryExA_Module = 'COREIDE100.BPL';
{$ENDIF}

{$IFDEF Delphi12Up}
const
  RADVersionString = (_BDSVer + '.0');
  Real_RADVersionString = (_LanguageVer + '.0');
  VCL = ('VCL' + _LanguageVer + '0.BPL');
  CLX = ''; // CLX unsupported!
  INDY1 = ('INDY' + _LanguageVer + '0.BPL');
  INDY2 = ('INDYCORE' + _LanguageVer + '0.BPL');
  IniAppendLine = '';
  CreateFileA_Module = ('RTL' + _LanguageVer + '0.BPL');
  LoadLibraryExA_Module = ('COREIDE' + _LanguageVer + '0.BPL');
{$ENDIF}

{$IFNDEF CBuilder}
  {$IFDEF Delphi9Up}
    RADRegKeyName = 'BDS';
    RADExeName = 'BDS.EXE';
    DEFINEDirName = 'BDS';
  {$ELSE}
    RADRegKeyName = 'Delphi';
    RADExeName = 'DELPHI32.EXE';
    DEFINEDirName = 'DELPHI';
  {$ENDIF}
  DefaultSourceExt = '.pas';
  InstallDirName = 'Delphi';
{$ELSE}
  {$IFDEF Delphi10Up}
    RADRegKeyName = 'BDS';
    RADExeName = 'BDS.EXE';
    DEFINEDirName = 'BDS';
  {$ELSE}
    RADRegKeyName = 'C++Builder';
    RADExeName = 'BCB.EXE';
    DEFINEDirName = 'BCB';
  {$ENDIF}
  DefaultSourceExt = '.cpp';
  InstallDirName = 'CBuilder';
{$ENDIF}
