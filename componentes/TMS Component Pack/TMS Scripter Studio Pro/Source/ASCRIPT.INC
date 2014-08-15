{$RANGECHECKS OFF}
{$BOOLEVAL OFF}

{Set directive THEMED_IDE to use additional TMS Components in the scripter IDE. The IDE will be themed, you will be
 able to set an AppStyler to the TIDEDialog component}
{.$DEFINE THEMED_IDE}

{.$DEFINE OverrideDescendants}
{Until version 2.6.3.0 of Scripter Studio, the method/properties registration system worked this way:
 Whenever a method/property was registered in a class, it was also registered in all descendants of the class,
 regardless if the method was already registered or not. For example, let's say Create method was registered
 in TComponent class, receiving 1 parameter:

 DefineClass(TComponent).DefineMethod('Create', 1, .....);

 then the same Create method is declared in TObject class, but receiving 0 parameter:

 DefineClass(TObject).DefineMethod('Create', 0, .....);

 the last create method would override the first one declared in TComponent class. This way, the Create method
 of TComponent would accept no parameters.

 This of course was wrong, and then fixed: if a method is already declared in a descendant, it will not be overriden.

 However, since this changes the registration system very deeply, and since lots of user are registering lots
 of classes and methods, maybe this bug fix might break working code. Thus, the directive OverrideDescendants
 can be defined in order to use the old (buggy) mechanism, to keep old code working, if necessary}


{Define UseGreatisUnits directive to use scripter pro together with greatis components}
{.$DEFINE UseGreatisUnits}


// Do not change anything below this line
//------------------------------------------------------------------------------
{$IFNDEF VER80}
 {$IFNDEF VER90}
  {$IFNDEF VER93}
    {$DEFINE AT_D3}          { Delphi 3.0 or higher }
    {$IFNDEF VER100}
      {$IFNDEF VER110}
        {$DEFINE AT_D4}      { Delphi 4.0 or higher }
        {$IFNDEF VER120}
          {$IFNDEF VER125}
            {$DEFINE AT_D5}  { Delphi 5.0 or higher }
          {$ENDIF}
        {$ENDIF}
      {$ENDIF}
    {$ENDIF}
  {$ENDIF}
 {$ENDIF}
{$ENDIF}



{$IFDEF LINUX}
{$DEFINE TMSCLX}
{$ENDIF}

{$IFDEF VER90}
{$DEFINE DELPHI2_LVL}
{$DEFINE ISDELPHI}
{$ENDIF}

{$IFDEF VER93}
{$DEFINE DELPHI2_LVL}
{$ENDIF}

{$IFDEF VER100}
{$DEFINE DELPHI2_LVL}
{$DEFINE DELPHI3_LVL}
{$DEFINE ISDELPHI}
{$ENDIF}

{$IFDEF VER110}
{$DEFINE DELPHI2_LVL}
{$DEFINE DELPHI3_LVL}
{$ENDIF}

{$IFDEF VER120}
{$DEFINE DELPHI2_LVL}
{$DEFINE DELPHI3_LVL}
{$DEFINE DELPHI4_LVL}
{$DEFINE ISDELPHI}
{$ENDIF}

{$IFDEF VER125}
{$DEFINE DELPHI2_LVL}
{$DEFINE DELPHI3_LVL}
{$DEFINE DELPHI4_LVL}
{$ENDIF}

{$IFDEF VER130}
{$DEFINE DELPHI2_LVL}
{$DEFINE DELPHI3_LVL}
{$DEFINE DELPHI4_LVL}
{$DEFINE DELPHI5_LVL}
{$ENDIF}

{$IFDEF VER140}
{$DEFINE DELPHI2_LVL}
{$DEFINE DELPHI3_LVL}
{$DEFINE DELPHI4_LVL}
{$DEFINE DELPHI5_LVL}
{$DEFINE DELPHI6_LVL}
 {$IFNDEF BCB}
  {$DEFINE ISDELPHI}
 {$ENDIF}
{$ENDIF}

{$IFDEF VER150}
{$DEFINE DELPHI2_LVL}
{$DEFINE DELPHI3_LVL}
{$DEFINE DELPHI4_LVL}
{$DEFINE DELPHI5_LVL}
{$DEFINE DELPHI6_LVL}
{$DEFINE DELPHI7_LVL}
 {$IFNDEF BCB}
  {$DEFINE ISDELPHI}
 {$ENDIF}
{$ENDIF}

{$IFDEF VER160}
  {$DEFINE DELPHI2_LVL}
  {$DEFINE DELPHI3_LVL}
  {$DEFINE DELPHI4_LVL}
  {$DEFINE DELPHI5_LVL}
  {$DEFINE DELPHI6_LVL}
  {$DEFINE DELPHI7_LVL}
  {$DEFINE TMSDOTNET}
  {$IFNDEF BCB}
    {$DEFINE ISDELPHI}
  {$ENDIF}
{$ENDIF}

{$IFDEF VER170}
  {$DEFINE DELPHI2_LVL}
  {$DEFINE DELPHI3_LVL}
  {$DEFINE DELPHI4_LVL}
  {$DEFINE DELPHI5_LVL}
  {$DEFINE DELPHI6_LVL}
  {$DEFINE DELPHI7_LVL}
  {$DEFINE DELPHI9_LVL}
  {$IFDEF CLR}
    {$DEFINE TMSDOTNET}
  {$ENDIF}
  {$IFNDEF BCB}
    {$DEFINE ISDELPHI}
  {$ENDIF}
{$ENDIF}

{$IFDEF VER180}
  {$DEFINE DELPHI2_LVL}
  {$DEFINE DELPHI3_LVL}
  {$DEFINE DELPHI4_LVL}
  {$DEFINE DELPHI5_LVL}
  {$DEFINE DELPHI6_LVL}
  {$DEFINE DELPHI7_LVL}
  {$DEFINE DELPHI9_LVL}
  {$DEFINE DELPHI2006_LVL}
  {$IFDEF CLR}
    {$DEFINE TMSDOTNET}
  {$ENDIF}
  {$IFNDEF BCB}
    {$DEFINE ISDELPHI}
  {$ENDIF}
{$ENDIF}


{$IFDEF VER185}
  {$DEFINE DELPHI2_LVL}
  {$DEFINE DELPHI3_LVL}
  {$DEFINE DELPHI4_LVL}
  {$DEFINE DELPHI5_LVL}
  {$DEFINE DELPHI6_LVL}
  {$DEFINE DELPHI7_LVL}
  {$DEFINE DELPHI9_LVL}
  {$DEFINE DELPHI2006_LVL}
  {$DEFINE DELPHI2007_LVL}
  {$IFDEF CLR}
    {$DEFINE TMSDOTNET}
  {$ENDIF}
  {$IFNDEF BCB}
    {$DEFINE ISDELPHI}
  {$ENDIF}
{$ENDIF}

{$IFDEF VER190}
  {$DEFINE DELPHI2_LVL}
  {$DEFINE DELPHI3_LVL}
  {$DEFINE DELPHI4_LVL}
  {$DEFINE DELPHI5_LVL}
  {$DEFINE DELPHI6_LVL}
  {$DEFINE DELPHI7_LVL}
  {$DEFINE DELPHI9_LVL}
  {$DEFINE DELPHI2006_LVL}
  {$DEFINE DELPHI2007_LVL}
  {$IFDEF CLR}
    {$DEFINE TMSDOTNET}
  {$ENDIF}
  {$IFNDEF BCB}
    {$DEFINE ISDELPHI}
  {$ENDIF}
{$ENDIF}

{$IFDEF VER200}
  {$DEFINE DELPHI2_LVL}
  {$DEFINE DELPHI3_LVL}
  {$DEFINE DELPHI4_LVL}
  {$DEFINE DELPHI5_LVL}
  {$DEFINE DELPHI6_LVL}
  {$DEFINE DELPHI7_LVL}
  {$DEFINE DELPHI9_LVL}
  {$DEFINE DELPHI2006_LVL}
  {$DEFINE DELPHI2007_LVL}
  {$DEFINE DELPHI2009_LVL}
  {$IFDEF CLR}
    {$DEFINE TMSDOTNET}
  {$ENDIF}
  {$IFNDEF BCB}
    {$DEFINE ISDELPHI}
  {$ENDIF}
{$ENDIF}

{$IFDEF VER210}
  {$DEFINE DELPHI2_LVL}
  {$DEFINE DELPHI3_LVL}
  {$DEFINE DELPHI4_LVL}
  {$DEFINE DELPHI5_LVL}
  {$DEFINE DELPHI6_LVL}
  {$DEFINE DELPHI7_LVL}
  {$DEFINE DELPHI9_LVL}
  {$DEFINE DELPHI2006_LVL}
  {$DEFINE DELPHI2007_LVL}
  {$DEFINE DELPHI2009_LVL}
  {$DEFINE DELPHI2010_LVL}
  {$IFDEF CLR}
    {$DEFINE TMSDOTNET}
  {$ENDIF}
  {$IFNDEF BCB}
    {$DEFINE ISDELPHI}
  {$ENDIF}
{$ENDIF}

{$IFDEF VER220}
  {$DEFINE DELPHI2_LVL}
  {$DEFINE DELPHI3_LVL}
  {$DEFINE DELPHI4_LVL}
  {$DEFINE DELPHI5_LVL}
  {$DEFINE DELPHI6_LVL}
  {$DEFINE DELPHI7_LVL}
  {$DEFINE DELPHI9_LVL}
  {$DEFINE DELPHI2006_LVL}
  {$DEFINE DELPHI2007_LVL}
  {$DEFINE DELPHI2009_LVL}
  {$DEFINE DELPHI2010_LVL}
  {$DEFINE DELPHI2011_LVL}
  {$IFDEF CLR}
    {$DEFINE TMSDOTNET}
  {$ENDIF}
  {$IFNDEF BCB}
    {$DEFINE ISDELPHI}
  {$ENDIF}
{$ENDIF}

{$IFDEF VER110}
 {$ObjExportAll On}
{$ENDIF}

{$IFDEF VER125}
 {$ObjExportAll On}
{$ENDIF}

{$IFDEF VER130}
 {$IFDEF BCB}
  {$ObjExportAll On}
 {$ELSE}
  {$DEFINE ISDELPHI}
 {$ENDIF}
{$ENDIF}

{$IFDEF ISDELPHI}
 {$IFDEF DELPHI3_LVL}
  {$DEFINE DELPHI_ONLY_LVL3}
 {$ENDIF}
{$ENDIF}

{$IFDEF DELPHI7_LVL}
{$WARN UNIT_PLATFORM OFF}
{$WARN SYMBOL_PLATFORM OFF}
{$ENDIF}


