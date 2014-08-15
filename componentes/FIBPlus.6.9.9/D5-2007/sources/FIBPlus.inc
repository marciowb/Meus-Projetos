{***************************************************************}
{ FIBPlus - component library for direct access to Firebird and }
{ InterBase databases                                           }
{                                                               }
{    FIBPlus is based in part on the product                    }
{    Free IB Components, written by Gregory H. Deatz for        }
{    Hoagland, Longo, Moran, Dunst & Doukas Company.            }
{    mailto:gdeatz@hlmdd.com                                    }
{                                                               }
{    Copyright (c) 1998-2007 Devrace Ltd.                       }
{    Written by Serge Buzadzhy (buzz@devrace.com)               }
{                                                               }
{ ------------------------------------------------------------- }
{    FIBPlus home page: http://www.fibplus.com/                 }
{    FIBPlus support  : http://www.devrace.com/support/         }
{ ------------------------------------------------------------- }
{                                                               }
{  Please see the file License.txt for full license information }
{***************************************************************}

{$DEFINE SUPPORT_IB2007}

//{$DEFINE CSMonitor}
{$DEFINE FAST_LOCATE}

//{$DEFINE SUPPORT_KOI8_CHARSET}

//{$IFNDEF VER130}
{$DEFINE NO_USE_COMP }
//{$ENDIF}

//  {$DEFINE NO_MONITOR}
//{$DEFINE FIBPLUS_TRIAL}

//{$DEFINE LONG_METADATA_NAMES}

//{$DEFINE OBSOLETE_PROPS}
(*For load old dfms*)

//{$DEFINE NO_GUI}

//{$DEFINE USE_DEPRECATE_METHODS1}
//{$DEFINE USE_DEPRECATE_METHODS2}
(* FIBDabase.DataSets ->  FIBDabase.Bases*)

{$DEFINE FIB_FIELDS_VER2}
(*TFIBDateTimeField,TFIBDateField,TFIBTimeField,TFIBBlobField*)


//{$DEFINE DFM_VERSION1}
(* This define for save dfm with old format  *)
(*Conditions and FIBDataSet.Options*)

{$DEFINE SUPPORT_ARRAY_FIELD}
(* This define for ARRAY FIELD SUPPORT  *)
{$DEFINE INC_SERVICE_SUPPORT}
(* This define for include  service components  *)


{$IFDEF VER130}
  {$IFDEF BCB}			// C++Buider 5.0
  {$ObjExportAll on}
  {$ENDIF}

  {$DEFINE D4+}
  {$DEFINE D5+}
{$ENDIF}

{$IFDEF VER140}
  {$DEFINE D4+}
  {$DEFINE D5+}
  {$DEFINE D6+}
  {$IFDEF BCB}			// C++Buider 6.0
  {$ObjExportAll on}
  {$ENDIF}
  {$WARN SYMBOL_PLATFORM OFF}
{$ENDIF}

{$IFDEF VER150}
  {$DEFINE D4+}
  {$DEFINE D5+}
  {$DEFINE D6+}
  {$DEFINE D7+}

  {$WARN UNSAFE_TYPE OFF}
  {$WARN UNSAFE_CODE OFF}
  {$WARN UNSAFE_CAST OFF}
  {$WARN SYMBOL_PLATFORM OFF}
{$ENDIF}

// Probably Delphi 2005 defines
{$IFDEF VER170}
  {$DEFINE D4+}
  {$DEFINE D5+}
  {$DEFINE D6+}
  {$DEFINE D7+}
  {$DEFINE D9+}

  {$INLINE OFF}
  {$WARN UNSAFE_TYPE OFF}
  {$WARN UNSAFE_CODE OFF}
  {$WARN UNSAFE_CAST OFF}
  {$WARN SYMBOL_PLATFORM OFF}
{$ENDIF}


{$IFDEF VER180}
  {$DEFINE D4+}
  {$DEFINE D5+}
  {$DEFINE D6+}
  {$DEFINE D7+}
  {$DEFINE D9+}
  {$DEFINE D10+}
  {$WARN UNSAFE_TYPE OFF}
  {$WARN UNSAFE_CODE OFF}
  {$WARN UNSAFE_CAST OFF}
  {$WARN SYMBOL_PLATFORM OFF}
{$ENDIF}

 {$IFNDEF LINUX}
   {$DEFINE MSWINDOWS}
 {$ELSE}
   {$DEFINE NO_MONITOR}
   {$DEFINE NO_REGISTRY}
   {$UNDEF SUPPORT_KOI8_CHARSET}
   {$UNDEF SUPPORT_DOS_CHARSET}
 {$ENDIF}

{$IFNDEF LINUX}
 {$IFNDEF  NO_GUI}
  {$DEFINE DIRECT_USE_DB_LOGIN_FORM}
 {$ENDIF}
{$ENDIF}

 {$IFDEF MSWINDOWS}
  {$DEFINE WINDOWS}
 {$ENDIF}

(* {$UNDEF WINDOWS}
 {$DEFINE LINUX}*)
 
(*
 * Compiler defines
 *)

{$A+}                           (* Aligned records: On *)
{$B-}                           (* Short circuit boolean expressions: Off *)
{$G+}                           (* Imported data: On *)
{$H+}                           (* Huge Strings: On *)
{$J-}                           (* Modification of Typed Constants: Off *)
{$M+}                           (* Generate run-time type information: On *)
{$Q-}                           (* Overflow checks: Off *)
{$R-}                           (* Range checks: Off *)
{$T+}                           (* Typed address: On *)
{$U+}                           (* Pentim-safe FDIVs: On *)
{$X+}                           (* Extended syntax: On *)
{$Z1}                           (* Minimum Enumeration Size: 1 Byte *)

