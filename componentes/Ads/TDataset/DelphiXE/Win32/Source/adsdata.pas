// Copyright (c) 2002-2006 Extended Systems, Inc.
// Portions Copyright (c) 2005-2010, iAnywhere Solutions, Inc.
// All rights reserved. All unpublished rights reserved.
//
// This source code can be used, modified, or copied by the licensee as long as
// the modifications (or the new binary resulting from a copy or modification of
// this source code) are used with Extended Systems' products. The source code
// is not redistributable as source code, but is redistributable as compiled
// and linked binary code. If the source code is used, modified, or copied by
// the licensee, Extended Systems Inc. reserves the right to receive from the
// licensee, upon request, at no cost to Extended Systems Inc., the modifications.
//
// Extended Systems Inc. does not warrant that the operation of this software
// will meet your requirements or that the operation of the software will be
// uninterrupted, be error free, or that defects in software will be corrected.
// This software is provided "AS IS" without warranty of any kind. The entire
// risk as to the quality and performance of this software is with the purchaser.
// If this software proves defective or inadequate, purchaser assumes the entire
// cost of servicing or repair. No oral or written information or advice given
// by an Extended Systems Inc. representative shall create a warranty or in any
// way increase the scope of this warranty.
{*******************************************************************************
* Source File : adsdata.pas
* Description : This is the Delphi TDataSet Descendant component for the
*               Advantage Client Engine.
* Notes       :
*******************************************************************************}
unit adsdata;

{$IFDEF FPC}
   {$MODE Delphi}{$H+}   // Use "delphi" compatibility mode
{$ENDIF}

{* Override any compiler directives we don't want, but that that user might have
 * defined in their project. *}
{$T-}   // turns off typed @ operator
{$B-}   // use short-circuit boolean expressions
{$R-}   // no range checking
{$V-}   // no var-string checking

{$INCLUDE versions.inc}

{$IFDEF ADSDELPHI7_OR_NEWER}
   {$WARN UNSAFE_TYPE OFF}
   {$WARN UNSAFE_CODE OFF}
   {$WARN UNSAFE_CAST OFF}
{$ENDIF}

{$IFDEF ADSDELPHI2006_OR_NEWER}
   {$WARN SYMBOL_DEPRECATED OFF}
{$ENDIF}

interface

uses
{$ifdef WIN32}
{$IFNDEF FPC}
   Windows,
{$ELSE}
   JwaWinBase,
{$ENDIF}
{$endif}

{$IFDEF ADSDELPHI6_OR_NEWER }
   FMTBcd,
   {$IFNDEF FPC}
   StrUtils,
   {$ENDIF}
{$ENDIF}
   Classes,
   SysUtils,
   DB,
{$IFNDEF FPC}
   DBCommon,
{$ENDIF}
   IniFiles,
   ace,
   aceunpub,
   adscnnct,
   adsver,
{$IFDEF ADSDELPHI4_OR_NEWER}
   syncobjs;
{$else}
   {* Get TCriticalSection definition from AdsAEPSessionMgr. *}
   AdsAEPSessionMgr;
{$endif}

const
   {  Constant for array of index handles }
   ARRAY_NDX = 256;
   {  INVALID ACE handle }
   INVALID_ACE_HANDLE = -1;
   {  Constant for julian to delphi date.  This is how many days between 1/1/0001 and }
   {  the start of the Julian date }
   JULIAN_TO_DELPHI_DATE = 1721425;
   {  Constant for Delphi Date to TIMEDATE conversion }
   DELPHI_DATE_TO_DATETIME = 693960;
   {  Constant for conversions from Julian to TDateTime values (do not ask me why) }
   DELPHI_DATETIME_TO_JULIAN = JULIAN_TO_DELPHI_DATE + DELPHI_DATE_TO_DATETIME - 366;
   { Constant for the number of milliseconds per day }
   MSEC_PER_DAY = 24*60*60*1000;

   { Map ADS field type constants from ace.pas to TFieldType types }
   AdsDataTypeMap: array[0..ADS_MAX_FIELD_TYPE-1] of TFieldType =
   (
   ftUnknown,
   ftBoolean,
   ftSmallInt, // ADS_NUMERIC could be float, address if this map is ever used
   ftDate,
   ftString,
   ftMemo,
   ftBLOB,
   ftGraphic,
   ftMemo,
   ftDate,
   ftFloat,
   ftInteger,
   ftSmallInt,
   ftTime,
   ftDateTime,
   ftAutoInc,
   ftBytes,
   ftCurrency,
   ftBCD,
{$IFDEF ADSDELPHI4_OR_NEWER }
   ftLargeInt,
{$ELSE}
   ftInteger,
{$ENDIF}
   ftString,
   ftBCD,
   ftDateTime,
   ftString,
   ftVarBytes
{$IFDEF ADSDELPHI2008_OR_NEWER }
   ,
   ftBytes,    // ADS_SYSTEM_FIELD -- client should never use this..
               // but it needs to be present.
   ftWideString,  // ADS_NCHAR
   ftWideString,  // ADS_NCHAR
   ftWideMemo     // ADS_NMEMO
{$ENDIF}
   );

type

{$IFDEF ADSDELPHI2008_OR_NEWER}
   PAdsBuffer = PByte;
   AdsBufferItem = byte;
{$ELSE}
   PAdsBuffer = PChar;
   AdsBufferItem = char;
{$ENDIF}

    // Used by designer and ARC
    TDimensions = record
      Top    : integer;
      Left   : integer;
      Width  : integer;
      Height : integer;
   end;

   {  The following are enumerated types that will show in the property editor as is }
   {  enumerated list of the table types dealing with specific index structures }
   TAdsTableTypes = ( ttAdsCDX, ttAdsNTX, ttAdsADT, ttAdsDefault, ttAdsVFP );

   {  enumerated list of the index types whether indexed on none, tag, or expression }
   TAdsIndexTypes = ( ndxNone, ndxIndexName, ndxIndexField, ndxDefault );

   {  enumerated list of the lock types whether propriatary or compatible }
   TAdsLockTypes = ( Proprietary, Compatible );

   {  enumerated list of the character types }
   TAdsCharTypes = ( ANSI, OEM, CZECH_VFP_CI_AS_1250, GENERAL_VFP_CI_AS_1250,
                     HUNGARY_VFP_CI_AS_1250, MACHINE_VFP_BIN_1250, POLISH_VFP_CI_AS_1250,
                     SLOVAK_VFP_CI_AS_1250, MACHINE_VFP_BIN_1251, RUSSIAN_VFP_CI_AS_1251,
                     DUTCH_VFP_CI_AS_1252, GENERAL_VFP_CI_AS_1252, GERMAN_VFP_CI_AS_1252,
                     ICELAND_VFP_CI_AS_1252, MACHINE_VFP_BIN_1252, NORDAN_VFP_CI_AS_1252,
                     SPANISH_VFP_CI_AS_1252, SWEFIN_VFP_CI_AS_1252, UNIQWT_VFP_CS_AS_1252,
                     GREEK_VFP_CI_AS_1253, MACHINE_VFP_BIN_1253, GENERAL_VFP_CI_AS_1254,
                     MACHINE_VFP_BIN_1254, TURKISH_VFP_CI_AS_1254, DUTCH_VFP_CI_AS_437,
                     GENERAL_VFP_CI_AS_437, GERMAN_VFP_CI_AS_437, ICELAND_VFP_CI_AS_437,
                     MACHINE_VFP_BIN_437, NORDAN_VFP_CI_AS_437, SPANISH_VFP_CI_AS_437,
                     SWEFIN_VFP_CI_AS_437, UNIQWT_VFP_CS_AS_437, GENERAL_VFP_CI_AS_620,
                     MACHINE_VFP_BIN_620, POLISH_VFP_CI_AS_620, GREEK_VFP_CI_AS_737,
                     MACHINE_VFP_BIN_737, DUTCH_VFP_CI_AS_850, GENERAL_VFP_CI_AS_850,
                     ICELAND_VFP_CI_AS_850, MACHINE_VFP_BIN_850, NORDAN_VFP_CI_AS_850,
                     SPANISH_VFP_CI_AS_850, SWEFIN_VFP_CI_AS_850, UNIQWT_VFP_CS_AS_850,
                     CZECH_VFP_CI_AS_852, GENERAL_VFP_CI_AS_852, HUNGARY_VFP_CI_AS_852,
                     MACHINE_VFP_BIN_852, POLISH_VFP_CI_AS_852, SLOVAK_VFP_CI_AS_852,
                     GENERAL_VFP_CI_AS_857, MACHINE_VFP_BIN_857, TURKISH_VFP_CI_AS_857,
                     GENERAL_VFP_CI_AS_861, ICELAND_VFP_CI_AS_861, MACHINE_VFP_BIN_861,
                     GENERAL_VFP_CI_AS_865, MACHINE_VFP_BIN_865, NORDAN_VFP_CI_AS_865,
                     SWEFIN_VFP_CI_AS_865, MACHINE_VFP_BIN_866, RUSSIAN_VFP_CI_AS_866,
                     CZECH_VFP_CI_AS_895, GENERAL_VFP_CI_AS_895, MACHINE_VFP_BIN_895,
                     SLOVAK_VFP_CI_AS_895, DANISH_ADS_CS_AS_1252, DUTCH_ADS_CS_AS_1252,
                     ENGL_AMER_ADS_CS_AS_1252, ENGL_CAN_ADS_CS_AS_1252, ENGL_UK_ADS_CS_AS_1252,
                     FINNISH_ADS_CS_AS_1252, FRENCH_ADS_CS_AS_1252, FRENCH_CAN_ADS_CS_AS_1252,
                     GERMAN_ADS_CS_AS_1252, ICELANDIC_ADS_CS_AS_1252, ITALIAN_ADS_CS_AS_1252,
                     NORWEGIAN_ADS_CS_AS_1252, PORTUGUESE_ADS_CS_AS_1252, SPANISH_ADS_CS_AS_1252,
                     SPAN_MOD_ADS_CS_AS_1252, SWEDISH_ADS_CS_AS_1252, RUSSIAN_ADS_CS_AS_1251,
                     ASCII_ADS_CS_AS_1252, TURKISH_ADS_CS_AS_1254, POLISH_ADS_CS_AS_1250,
                     BALTIC_ADS_CS_AS_1257, UKRAINIAN_ADS_CS_AS_1251, DUDEN_DE_ADS_CS_AS_1252,
                     USA_ADS_CS_AS_437, DANISH_ADS_CS_AS_865, DUTCH_ADS_CS_AS_850,
                     FINNISH_ADS_CS_AS_865, FRENCH_ADS_CS_AS_863, GERMAN_ADS_CS_AS_850,
                     GREEK437_ADS_CS_AS_437, GREEK851_ADS_CS_AS_851, ICELD850_ADS_CS_AS_850,
                     ICELD861_ADS_CS_AS_861, ITALIAN_ADS_CS_AS_850, NORWEGN_ADS_CS_AS_865,
                     PORTUGUE_ADS_CS_AS_860, SPANISH_ADS_CS_AS_852, SWEDISH_ADS_CS_AS_865,
                     MAZOVIA_ADS_CS_AS_852, PC_LATIN_ADS_CS_AS_852, ISOLATIN_ADS_CS_AS_850,
                     RUSSIAN_ADS_CS_AS_866, NTXCZ852_ADS_CS_AS_852, NTXCZ895_ADS_CS_AS_895,
                     NTXSL852_ADS_CS_AS_852, NTXSL895_ADS_CS_AS_895, NTXHU852_ADS_CS_AS_852,
                     NTXPL852_ADS_CS_AS_852, TURKISH_ADS_CS_AS_857, BOSNIAN_ADS_CS_AS_775 );

   const
   TAdsCharTypeMap : array[0..(ADS_MAX_CHAR_SETS-1)] of string =
                   ( 'ANSI', 'OEM', 'CZECH_VFP_CI_AS_1250', 'GENERAL_VFP_CI_AS_1250',
                     'HUNGARY_VFP_CI_AS_1250', 'MACHINE_VFP_BIN_1250', 'POLISH_VFP_CI_AS_1250',
                     'SLOVAK_VFP_CI_AS_1250', 'MACHINE_VFP_BIN_1251', 'RUSSIAN_VFP_CI_AS_1251',
                     'DUTCH_VFP_CI_AS_1252', 'GENERAL_VFP_CI_AS_1252', 'GERMAN_VFP_CI_AS_1252',
                     'ICELAND_VFP_CI_AS_1252', 'MACHINE_VFP_BIN_1252', 'NORDAN_VFP_CI_AS_1252',
                     'SPANISH_VFP_CI_AS_1252', 'SWEFIN_VFP_CI_AS_1252', 'UNIQWT_VFP_CS_AS_1252',
                     'GREEK_VFP_CI_AS_1253', 'MACHINE_VFP_BIN_1253', 'GENERAL_VFP_CI_AS_1254',
                     'MACHINE_VFP_BIN_1254', 'TURKISH_VFP_CI_AS_1254', 'DUTCH_VFP_CI_AS_437',
                     'GENERAL_VFP_CI_AS_437', 'GERMAN_VFP_CI_AS_437', 'ICELAND_VFP_CI_AS_437',
                     'MACHINE_VFP_BIN_437', 'NORDAN_VFP_CI_AS_437', 'SPANISH_VFP_CI_AS_437',
                     'SWEFIN_VFP_CI_AS_437', 'UNIQWT_VFP_CS_AS_437', 'GENERAL_VFP_CI_AS_620',
                     'MACHINE_VFP_BIN_620', 'POLISH_VFP_CI_AS_620', 'GREEK_VFP_CI_AS_737',
                     'MACHINE_VFP_BIN_737', 'DUTCH_VFP_CI_AS_850', 'GENERAL_VFP_CI_AS_850',
                     'ICELAND_VFP_CI_AS_850', 'MACHINE_VFP_BIN_850', 'NORDAN_VFP_CI_AS_850',
                     'SPANISH_VFP_CI_AS_850', 'SWEFIN_VFP_CI_AS_850', 'UNIQWT_VFP_CS_AS_850',
                     'CZECH_VFP_CI_AS_852', 'GENERAL_VFP_CI_AS_852', 'HUNGARY_VFP_CI_AS_852',
                     'MACHINE_VFP_BIN_852', 'POLISH_VFP_CI_AS_852', 'SLOVAK_VFP_CI_AS_852',
                     'GENERAL_VFP_CI_AS_857', 'MACHINE_VFP_BIN_857', 'TURKISH_VFP_CI_AS_857',
                     'GENERAL_VFP_CI_AS_861', 'ICELAND_VFP_CI_AS_861', 'MACHINE_VFP_BIN_861',
                     'GENERAL_VFP_CI_AS_865', 'MACHINE_VFP_BIN_865', 'NORDAN_VFP_CI_AS_865',
                     'SWEFIN_VFP_CI_AS_865', 'MACHINE_VFP_BIN_866', 'RUSSIAN_VFP_CI_AS_866',
                     'CZECH_VFP_CI_AS_895', 'GENERAL_VFP_CI_AS_895', 'MACHINE_VFP_BIN_895',
                     'SLOVAK_VFP_CI_AS_895', 'DANISH_ADS_CS_AS_1252', 'DUTCH_ADS_CS_AS_1252',
                     'ENGL(AMER)_ADS_CS_AS_1252', 'ENGL(CAN)_ADS_CS_AS_1252', 'ENGL(UK)_ADS_CS_AS_1252',
                     'FINNISH_ADS_CS_AS_1252', 'FRENCH_ADS_CS_AS_1252', 'FRENCH_CAN_ADS_CS_AS_1252',
                     'GERMAN_ADS_CS_AS_1252', 'ICELANDIC_ADS_CS_AS_1252', 'ITALIAN_ADS_CS_AS_1252',
                     'NORWEGIAN_ADS_CS_AS_1252', 'PORTUGUESE_ADS_CS_AS_1252', 'SPANISH_ADS_CS_AS_1252',
                     'SPAN(MOD)_ADS_CS_AS_1252', 'SWEDISH_ADS_CS_AS_1252', 'RUSSIAN_ADS_CS_AS_1251',
                     'ASCII_ADS_CS_AS_1252', 'TURKISH_ADS_CS_AS_1254', 'POLISH_ADS_CS_AS_1250',
                     'BALTIC_ADS_CS_AS_1257', 'UKRAINIAN_ADS_CS_AS_1251', 'DUDEN_DE_ADS_CS_AS_1252',
                     'USA_ADS_CS_AS_437', 'DANISH_ADS_CS_AS_865', 'DUTCH_ADS_CS_AS_850',
                     'FINNISH_ADS_CS_AS_865', 'FRENCH_ADS_CS_AS_863', 'GERMAN_ADS_CS_AS_850',
                     'GREEK437_ADS_CS_AS_437', 'GREEK851_ADS_CS_AS_851', 'ICELD850_ADS_CS_AS_850',
                     'ICELD861_ADS_CS_AS_861', 'ITALIAN_ADS_CS_AS_850', 'NORWEGN_ADS_CS_AS_865',
                     'PORTUGUE_ADS_CS_AS_860', 'SPANISH_ADS_CS_AS_852', 'SWEDISH_ADS_CS_AS_865',
                     'MAZOVIA_ADS_CS_AS_852', 'PC_LATIN_ADS_CS_AS_852', 'ISOLATIN_ADS_CS_AS_850',
                     'RUSSIAN_ADS_CS_AS_866', 'NTXCZ852_ADS_CS_AS_852', 'NTXCZ895_ADS_CS_AS_895',
                     'NTXSL852_ADS_CS_AS_852', 'NTXSL895_ADS_CS_AS_895', 'NTXHU852_ADS_CS_AS_852',
                     'NTXPL852_ADS_CS_AS_852', 'TURKISH_ADS_CS_AS_857', 'BOSNIAN_ADS_CS_AS_775' );

   const
   ADS_MAX_UNICODE_LOCALES = 212;

   const
   TAdsUnicodeLocales : array[0..(ADS_MAX_UNICODE_LOCALES-1)] of string =
                      ( 'ads_ascii', 'ar', 'ar_AE', 'ar_BH', 'ar_DZ', 'ar_EG', 'ar_IQ',
                        'ar_JO', 'ar_KW', 'ar_LB', 'ar_LY', 'ar_MA', 'ar_OM', 'ar_QA',
                        'ar_SA', 'ar_SD', 'ar_SY', 'ar_TN', 'ar_YE', 'as', 'as_IN',
                        'be', 'be_BY', 'bg', 'bg_BG', 'bn', 'bn_IN', 'ca', 'ca_ES',
                        'cs', 'cs_CZ', 'cy', 'da', 'da_DK', 'de', 'de_AT', 'de_BE',
                        'de_CH', 'de_DE', 'de_LU', 'el', 'el_GR', 'en', 'en_AU',
                        'en_BE', 'en_BW', 'en_CA', 'en_GB', 'en_HK', 'en_IE', 'en_IN',
                        'en_MT', 'en_NZ', 'en_PH', 'en_SG', 'en_US', 'en_US_POSIX',
                        'en_VI', 'en_ZA', 'en_ZW', 'eo', 'es', 'es_AR', 'es_BO',
                        'es_CL', 'es_CO', 'es_CR', 'es_DO', 'es_EC', 'es_ES', 'es_GT',
                        'es_HN', 'es_MX', 'es_NI', 'es_PA', 'es_PE', 'es_PR', 'es_PY',
                        'es_SV', 'es_US', 'es_UY', 'es_VE', 'et', 'et_EE', 'fa',
                        'fa_AF', 'fa_IR', 'fi', 'fi_FI', 'fo', 'fo_FO', 'fr', 'fr_BE',
                        'fr_CA', 'fr_CH', 'fr_FR', 'fr_LU', 'ga', 'ga_IE', 'gu',
                        'gu_IN', 'haw', 'he', 'he_IL', 'hi', 'hi_IN', 'hr', 'hr_HR',
                        'hu', 'hu_HU', 'id', 'id_ID', 'is', 'is_IS', 'it', 'it_CH',
                        'it_IT', 'ja', 'ja_JP', 'kk', 'kk_KZ', 'kl', 'kl_GL', 'km',
                        'kn', 'kn_IN', 'ko', 'ko_KR', 'kok', 'lt', 'lt_LT', 'lv',
                        'lv_LV', 'mk', 'mk_MK', 'ml', 'mr', 'mr_IN', 'ms', 'ms_BN',
                        'ms_MY', 'mt', 'mt_MT', 'nb', 'nb_NO', 'nl', 'nl_BE', 'nl_NL',
                        'nn', 'nn_NO', 'om', 'om_ET', 'om_KE', 'or', 'pa', 'pa_Arab',
                        'pa_Arab_PK', 'pa_Guru', 'pa_Guru_IN', 'pl', 'pl_PL', 'ps',
                        'ps_AF', 'pt', 'pt_BR', 'pt_PT', 'ro', 'ro_RO', 'ru', 'ru_RU',
                        'ru_UA', 'sk', 'sk_SK', 'sl', 'sl_SI', 'sq', 'sq_AL', 'sr',
                        'sr_Cyrl', 'sr_Cyrl_BA', 'sr_Cyrl_ME', 'sr_Cyrl_RS', 'sr_Latn',
                        'sr_Latn_BA', 'sr_Latn_ME', 'sr_Latn_RS', 'sv', 'sv_FI',
                        'sv_SE', 'ta', 'ta_IN', 'te', 'te_IN', 'th', 'th_TH', 'tr',
                        'tr_TR', 'uk', 'uk_UA', 'ur', 'ur_IN', 'ur_PK', 'vi', 'vi_VN',
                        'zh', 'zh_Hans', 'zh_Hans_CN', 'zh_Hans_SG', 'zh_Hant', 'zh_Hant_HK',
                        'zh_Hant_MO', 'zh_Hant_TW' );

   type
   {  enumerated list of the respecting filters types }
   TAdsRespectFilters = ( IGNORE_WHEN_COUNTING, RESPECT_WHEN_COUNTING );

   {  enumerated list of the respecting scope types }
   TAdsRespectScopes = ( IGNORE_SCOPES_WHEN_COUNTING, RESPECT_SCOPES_WHEN_COUNTING );

   {  integer subrange for possible index page sizes. }
   TAdsIndexPageSizes = 0..8192;   { 0 means to use default size }

   {  Read-ahead record caching values }
   TAdsRecordCacheTypes = ( rcNone, rcStandard, rcAggressive );

   {  AOF types }
   TAdsAOFTypes = ( atDynamic, atKeySet, atFixed );

   {  Record locking modes  }
   TAdsRecordLockingModes = ( lmPessimistic, lmOptimistic );

   { Table create options }
   TAdsCreateTableOption = ( ctFreeTable, ctDictionaryTable );
   TAdsCreateTableOptions = set of TAdsCreateTableOption;

   { Table caching options }
   TAdsTableCachingOption = ( tcNone, tcReads, tcWrites );

   { Forward declarations }
   TAdsDataSet = class;

   { type definition for ADSHANDLE and array of adshandle }
{$IFNDEF FPC}
   ADSHANDLE = Longint;
{$ENDIF}

   { type to determine how specific our sequenced rec nums are }
   TAdsSequencedLevel = ( slStandard, slExact );

   { This data type defines what type of procedure to pass to
     AdsRegisterCallbackFunction(). }
   TAdsCallbackFunction = function( usPercent: Word;
                                    ulCallbackID: UNSIGNED32 ): UNSIGNED32; stdcall;

   { This data type defines what type of procedure to pass to
     AdsRegisterProgressCallback(). }
   TAdsProgressCallback = function( usPercent: Word ): UNSIGNED32; stdcall;

   { This data type defines what type of procedure to pass to
     AdsRegisterSQLAbortFunc(). }
   TAdsSQLAbortFunc = function: UNSIGNED32; stdcall;

   {  Datatype for TBlobdata.  Similar definition to implementation of the }
   {  TTables TBlobData. Note that the 690 is only for the array type }
   {  declaration.  The actual memory allocated dynamically at the table open }
   {  time to match the number of memo/blob fields in the table. If there are }
   {  more than 690 memo/blob fields in the table, and if the program is compiled }
   {  with the range checking option turned on, a runtime error will be produced. }
   {  Simply increase the number below will take care of the problem. }
{$IFDEF FPC} {$HINTS OFF} {$ENDIF}{* Need to turn hints off to prevent type redef hint *}
   TBlobData = pointer;
{$IFDEF FPC} {$HINTS ON} {$ENDIF}
   TBlobDataArray = array [0..690] of TBlobData;
   PBlobDataArray = ^TBlobDataArray;

   {  enumerated list of the look up keys.  Each one represents a key buffer }
   TKeyIndex = ( kiLookup, kiRangeStart, kiRangeEnd, kiCurRangeStart,
                 kiCurRangeEnd, kiSave );

   {  To implement partial key correctly through ACE, we have to keep track }
   {  whether a field has been set in the buffer. }
   {  Note that the 6969 is only for the array type declaration.  The actual memory }
   {  allocated for the array is calculated dynamically when the key buffers are }
   {  initialized. It will always have enough storage for all fields in the table. }
   {  If there are more than 6969 field in the table, and if the program is compiled }
   {  with the range checking option turned on, a runtime error will be produced. }
   {  Simply increase the number below will take care of the problem. }
   TKeyFieldLenArray = array [1..6969] of UNSIGNED16;
   PKeyFieldLenArray = ^TKeyFieldLenArray;

   {  A record structure that will be a header structure to the key buffer }
   {  The Data portion of the KeyBuffer is the raw record filled in as the key }
   PAdsKeyBuffer = ^TAdsKeyBuffer;
   TAdsKeyBuffer = record
     Modified      : Boolean;
     Exclusive     : Boolean;
     FieldCount    : Integer;
     BufferSize    : UNSIGNED32;
     Data          : record end; {  Offset for start of record buffer }
     mausFieldLens : record end; {  Offset for start of logical field lengths }
   end;

   {  A record structure that will be a trailer structure to each raw record buffer }
   PRecInfo = ^TRecInfo;
   TRecInfo = record
      LogicalRecNumber: Longint;
      UpdateStatus: TUpdateStatus;
      BookmarkFlag: TBookmarkFlag;
   end;

   ADSHandleArray = array[0..1] of ADSHANDLE;
   PADSHandleArray = ^ADSHandleArray;

   {  A Database engine exception handler class }
   EADSDatabaseError = class( EDatabaseError )
   private
      ulACEError              : UNSIGNED32;
      ulSQLErrorCode          : UNSIGNED32;
      strDataSetInstanceName  : STRING;
      strDataSetInstanceOwner : STRING;
      strDatabaseName         : STRING;
      strDatabasePath         : STRING;
      strTableName            : STRING;
      strColumnName           : STRING;
      procedure GetNativeSQLError( strError : string );
   public
      constructor Create( oDataSet     : TAdsDataSet;
                          ulErrCode    : UNSIGNED32;
                          const strMsg : String );
      destructor  Destroy; override;
      property    ACEErrorCode          : UNSIGNED32 read ulACEError;
      property    SQLErrorCode          : UNSIGNED32 read ulSQLErrorCode;
      property    DataSetInstanceName   : STRING read strDataSetInstanceName;
      property    DataSetInstanceOwner  : STRING read strDataSetInstanceOwner;
      property    DatabaseName          : STRING read strDatabaseName;
      property    DatabasePath          : STRING read strDatabasePath;
      property    TableName             : STRING read strTableName;
      property    ColumnName            : STRING read strColumnName;
   end;

   {  This is the class that will handle the list of index files to open and close }
   TAdsIndexFiles = class( TStringList )
   private
      mpoOwner: TAdsDataSet;  {  A pointer to the AdsTable object }
   public
      constructor Create( AOwner: TAdsDataSet );
      function Add( const strValue: string ): Integer; override;
      procedure Clear; override;
      procedure Delete( Index: Integer ); override;
      procedure Insert( Index: Integer; const S: string ); override;
   end;

   {  This is a class to encapsulate the ADS options that can be set at run or design }
   {  time }
   TAdsTableOptions = class( TPersistent )
   private  {  Private data members of the TAdsTableOptions }
      meAdsLockType            : TAdsLockTypes;       {  Specific table lock type for the table }
      meAdsCharType            : TAdsCharTypes;       {  Specific char types for the table }
      meAdsRespectFilters      : TAdsRespectFilters;  {  Flag to know whether to respect filters }
      meAdsRespectScopes       : TAdsRespectScopes;   {  Flag to know whether to respect scopes }
      mbAdsRightsCheck         : Boolean;             {  Flag to determine rights checking is enabled }
      mpoAdsTable              : TAdsDataSet;         {  Instance to the table for checking of active }
      mbAdsOptimizedFilters    : Boolean;             {  Flag to turn Optimized filtering on or off }
      mbRefreshCount           : Boolean;             {  if true RecordCount always calls }
                                                      {  AdsGetRecordCount with the refresh option }
      mbAOFResolveImmediate    : Boolean;             {  If true then set AOF's with the resolve_immediate flag }
      mulIndexPageSize         : TAdsIndexPageSizes;  {  Size of the index pages when creating new indexes or reindexing }
      meAdsRecordCache         : TAdsRecordCacheTypes;{  Level of read-ahead record caching. }
      meAdsAOFType             : TAdsAOFTypes;        {  AOF types }
      mbAutoKeyFieldCount      : Boolean;             {  If true, use pre-6.2 multifield index behavior }
      mbCalcFieldsBeforeFilter : Boolean;             {  True if want calc/lookup fields populated before OnFilteredRecord event }
      meRecordLockingMode      : TAdsRecordLockingModes;
      mbPreserveSpaces         : Boolean;             {  If true don't turn a buffer of spaces into a NULL field value }
      mbNumericsAsFloats       : Boolean;             {  If true, don't convert ADT numerics (or static DBF cursors) to ftBCD }
      mstrCollation            : String;              {  Collation Language - with optional Unicode Locale }
      meAdsCachingOption       : TAdsTableCachingOption; { Table caching option (none, reads, writes) }
      procedure SetAdsCharType( eValue: TAdsCharTypes );
      procedure SetAdsLockType( eValue: TAdsLockTypes );
      procedure SetAdsRightsCheck( bValue: Boolean );
      procedure SetAdsOptimizedFilters( bValue: Boolean );
      procedure SetAdsRecordCache( eValue: TAdsRecordCacheTypes );
      procedure SetAdsCachingOption( eValue: TAdsTableCachingOption );
   public
     { Public method declarations }
      procedure SetTableInstance( poAdsTable : TAdsDataSet );
      property OwningDataSet:   TAdsDataSet read mpoAdsTable;
   published
      property AdsLockType:     TAdsLockTypes read meAdsLockType write SetAdsLockType
                                default Proprietary;
      property AdsCharType:     TAdsCharTypes read meAdsCharType write SetAdsCharType
                                default ANSI;
      property AdsFilterOptions: TAdsRespectFilters read meAdsRespectFilters
                                write meAdsRespectFilters default IGNORE_WHEN_COUNTING;
      property AdsFreshRecordCount:Boolean read mbRefreshCount write mbRefreshCount default False;
      property AdsScopeOptions: TAdsRespectScopes read meAdsRespectScopes
                                write meAdsRespectScopes default IGNORE_SCOPES_WHEN_COUNTING;
      property AdsAOFResolveImmediate: Boolean read mbAOFResolveImmediate
                                write mbAOFResolveImmediate default False;
      property AdsRightsCheck:  Boolean read mbAdsRightsCheck write SetAdsRightsCheck
                                default True;
      property AdsOptimizedFilters: Boolean read mbAdsOptimizedFilters
                                    write SetAdsOptimizedFilters default True;
      property AdsIndexPageSize:    TAdsIndexPageSizes read mulIndexPageSize write mulIndexPageSize default ADS_DEFAULT;
      property AdsRecordCache:  TAdsRecordCacheTypes read meAdsRecordCache write SetAdsRecordCache
                                default rcStandard;
      property AdsAOFType:      TAdsAOFTypes read meAdsAOFType write meAdsAOFType default atDynamic;
      property AdsAutoKeyFieldCount: Boolean read mbAutoKeyFieldCount write mbAutoKeyFieldCount default False;
      property AdsCalcFieldsBeforeFilter: Boolean read mbCalcFieldsBeforeFilter write mbCalcFieldsBeforeFilter default False;
      property AdsRecordLockingMode: TAdsRecordLockingModes read meRecordLockingMode
                                     write meRecordLockingMode default lmPessimistic;
      property AdsPreserveSpaces: Boolean read mbPreserveSpaces write mbPreserveSpaces default False;
      property AdsNumericsAsFloats: Boolean read mbNumericsAsFloats write mbNumericsAsFloats default False;
      property AdsCollation: String read mstrCollation write mstrCollation;
      property AdsCachingOption: TAdsTableCachingOption read meAdsCachingOption
                                  write SetAdsCachingOption default tcNone;
   end;

   TACEFieldDef = class( TCollectionItem )
   private
      FName        : string;
      FNumber      : UNSIGNED16;
      FOffset      : UNSIGNED32;
      FLength      : UNSIGNED32;
      FType        : UNSIGNED16;
      FDecimals    : UNSIGNED16;
      FModified    : Boolean;
      FPermissions : UNSIGNED8;
      FNullable    : Boolean;
   public
      property FieldName : string read FName write FName;
      property FieldNumber : UNSIGNED16 read FNumber write FNumber;
      property Offset : UNSIGNED32 read FOffset write FOffset;
      property Length : UNSIGNED32 read FLength write FLength;
      property FieldType : UNSIGNED16 read FType write FType;
      property Decimals : UNSIGNED16 read FDecimals write FDecimals;
      property Permissions : UNSIGNED8 read FPermissions write FPermissions;
      property Modified : Boolean read FModified write FModified;
      property Nullable : Boolean read FNullable write FNullable;
   end;

   TACEFieldDefs = class( TCollection )
   private
      FOwner : TPersistent;
      function GetItem(Index: Integer): TACEFieldDef;
      procedure SetItem(Index: Integer; Value: TACEFieldDef);
   protected
      function GetOwner: TPersistent; override;
   public
      constructor Create( Owner: TPersistent );
      function Add: TACEFieldDef;
      function IndexOf( const FieldName: string ): Integer;
      property Items[Index: Integer]: TACEFieldDef read GetItem write SetItem; default;
   end;

   TAdsStringField = class( TStringField )
   private
      FCaseInsensitive : boolean;
   public
      constructor Create(AOwner: TComponent); override;
   published
      property CaseInsensitive: boolean read FCaseInsensitive default False;
   end;

   TAdsBCDField = class( TBCDField )
   public
      constructor Create(AOwner: TComponent); override;
   end;


   {  The mother of our components.  The TAdsDataSet.  The big Kahuna. }
   TAdsDataSet = class( TDataset )

   private  {  Private data members of the TAdsDataSet }
      FACEFieldDefs:    TACEFieldDefs;
      FOldRecordBuffer: PAdsBuffer;
      mlActiveHandle:   Longint;        {  Index handle if index set else table handle }
      meActiveIndexType: TAdsIndexTypes;{  Specific active type for the table }
      musBlobCacheOfs:  UNSIGNED16;     {  The offset of blob cache in the rec buffers }
      musBookmarkOfs:   UNSIGNED16;     {  The offset bookmark in the rec buffers }
      mbCanModify:      Boolean;        {  Flag to determine if you can modify data }
      mstrDatabaseName: String;         {  Database Name }
      mstrExprStruct:   String;         {  holder for the expression structure }
      mpFilterBuffer:   PAdsBuffer;     {  pointer to the filter buffer }
      mlHandle:         Longint;        {  The table handle }
      mstrIndexFieldNames: String;      {  Expression names concatenated by ';' }
      mpoIndexDefs:     TIndexDefs;     {  Index defs }
      mstrIndexName:    String;         {  Tag name of the index }
      mstrDefaultIndex: String;
      mapKeyBuffers:    array[TKeyIndex] of PAdsKeyBuffer; {  Array of key buffers }
      mpstKeyBuffer:    PAdsKeyBuffer;  {  Current key buffer }
      mstrMasterField:  String;         {  Field name from master table for relation }
      mpoMasterLink:    TMasterDataLink;{  Data Source for master table for relation }
      musRecBufSize:    UNSIGNED16;     {  Record buffer size }
      musRecInfoOfs:    UNSIGNED16;     {  Record information offset }
      musRecordSize:    UNSIGNED16;     {  Record size }
      mulTableOptions:  UNSIGNED32;     {  Table Open Options }
      mbScoped:         Boolean;        {  If a scope should be set or not }
      mstrAliasPath:    string;         {  the path associated to an alias }
      mstrScopeEnd:     string;         {  The ending range of a scope }
      mstrScopeStart:   string;         {  The starting range of a scope }
      mstrStruct:       string;         {  holder for the table structure }
      strBinaryFieldName: String;       {  A field name to set the field def of field }
      mlBinaryFldLen:   Longint;        {  Total length for the set binary field }
      mbIsSequenced:    Boolean;        {  Flag to tell whether the dataset is sequenced }
      mbAppendEOF:      Boolean;        {  Flag to tell whether the dataset is at EOF
                                           when a record was being appended }
      mbAppendBOF:      Boolean;        {  Flag to tell whether the dataset is at BOF
                                           when a record was being appended }
      mbDisplayedPathNoExistsWarning : Boolean; { boolean to indicate that the error
                                                  message was displayed, once }
      mulSavedCRC:      UNSIGNED32;
      musOpenCharType:  UNSIGNED16;     {  Flag if open dataset uses an ANSI or OEM char type }

{$IFDEF ADSDELPHI5_OR_NEWER}
{$IFNDEF FPC}
      FOnUpdateRecord: TUpdateRecordEvent;      { Used by IProviderSupport interface implementation }
{$ENDIF}
{$ENDIF}

      procedure UpdateRange;
      function  GetVersionInfo : String;
      procedure WriteVersionInfo( value : string );
      function  GetSegmentFieldNum( iSegment : integer ) : integer;

   protected {  Protected methods for the TAdsDataSet }
      mpoAdsTableOptions: TAdsTableOptions; {  pointer to the table options object }
      mbExclusive:      Boolean;        {  Flag to determine if open exclusive }
      mbReadOnly:       Boolean;        {  Flag to set if table is read only }
      mstrTableName:    String;         {  Table name }
      meTableType:      TadsTableTypes; {  Table type from the enumerated list above }
      musOpenTableType: UNSIGNED16;     {  ADS_CDX or ADS_NTX for the table type }
      mpoIndexFiles:    TAdsIndexFiles; {  All associated index files to be opened }
      FbStoreActive:    Boolean;        {  Used to determine whether or not to store the Active property. *}
      meSeqLevel:       TAdsSequencedLevel;  {  Flag to tell how exact the sequenced rec nums should be }
      musAceTableType:  UNSIGNED16;     { ACE table type of the actual opened table }

      function  BuildAOFOptions : UNSIGNED16;
      procedure ActivateFilters; virtual;
      procedure ActivateScope; virtual;
      procedure AddFieldDesc( hTableHandle : ADSHANDLE; sFieldNum : SIGNED16 );
      function  ADSGetBinaryFieldLen : Longint;
      procedure ADSSetBinaryFieldLen( lValue : Longint );
      function  IsFieldBlank( pcData : PAdsBuffer; ulDataLen : UNSIGNED32; usADSDataType : UNSIGNED16;
                              pRecBuf : PAdsBuffer; Field: TField ) : Boolean;
      function  IsBlobBlank( pRecBuf: PAdsBuffer; Field: TBlobField; pcData: PAdsBuffer; usADSDataType: UNSIGNED16 ) : Boolean;
      function  ADSGetDataField( Field: TField; pRecBuf: PAdsBuffer; pBuffer: Pointer; var bIsBlank: Boolean ) : Boolean;
      procedure ADSPutField( usFieldNo: UNSIGNED16; eDelphiFieldType : TFieldType;
                             pRecBuf: PAdsBuffer; pBuffer: Pointer );
      procedure AllocKeyBuffers;
      function  AllocRecordBuffer: PAdsBuffer; override;
      procedure BuildRawKey( poKeyIndex : TKeyIndex; bPartial : Boolean; pcKeyBuffer : PChar;
                             pusLen : pWord );
      function  CalculateSequenceNumber : UNSIGNED32; virtual;
      function  CheckEmptyResultSet : Boolean;
      procedure CheckSetKeyMode;
      procedure CloseTableAndIndexes( hHandle : ADSHANDLE );
      procedure DataEvent( Event: TDataEvent; Info: Longint ); override;
      procedure DeactivateFilters; virtual;
      procedure DeactivateScope; virtual;
      function  FieldsAreIndexed( const strKeyFields: string;
                                  var hIndexField : ADSHANDLE ) : Boolean;
      function  FindRecord( Restart, GoForward: Boolean ): Boolean; override;
      procedure FreeKeyBuffers;
      procedure FreeRecordBuffer( var Buffer: PAdsBuffer ); override;
      function  GetActiveIndexFieldNames : string;
      function  GetActiveRecBuf( var pRecBuf: PAdsBuffer ): Boolean;
      function  GetAdsConnection: TAdsConnection;
      procedure GetBookmarkData( Buffer: PAdsBuffer; Data: Pointer ); override;
      function  GetBookmarkFlag( Buffer: PAdsBuffer ): TBookmarkFlag; override;
      function  GetCurTranslatedRecord( pucRec: PAdsBuffer; pulLen: pUNSIGNED32;
                                        GetMode : TGetMode ): TGetResult;
      procedure ReadTranslatedRecord( pucRec: PAdsBuffer; pulLen: pUNSIGNED32; bCalcFields: boolean );
      function  GetCurrentKeySize : UNSIGNED16;
      function  GetCanModify: Boolean; override;
      function  GetDataSource: TDataSource; override;
{$IFNDEF ADSDELPHI4_OR_NEWER}
      { this function is decalared to be public in delphi 4 but protected in D3 }
      function  GetFieldData( Field: TField; Buffer: Pointer ): Boolean; override;
{$ENDIF}
      function  GetIndexField( Index: Integer ): TField;
      function  GetKeyBuffer( poKeyIndex: TKeyIndex ): PAdsKeyBuffer;
      function  GetKeyExclusive: Boolean;
      function  GetKeyFieldCount: SIGNED16;
      function GetLastAutoinc: Integer; virtual; abstract;
      function  GetMasterFields: string;
      function  GetRecNo: Integer; override;
      procedure SetRecNo( value: integer ); override;
      function  GetRecord( Buffer: PAdsBuffer; GetMode: TGetMode;
                          DoCheck: Boolean ): TGetResult; override;
      function  GetRecordCount: Integer; override;
      function  GetRecordSize: Word; override;
      function  GetRefreshProperty : Boolean;
      {$IFNDEF FPC}
      function  GetStateFieldValue( State: TDataSetState; Field: TField ):
                                   Variant; override;
      {$ENDIF}
      procedure InitBufferPointers;
      function  InitKeyBuffer( pBuffer: PAdsKeyBuffer ): PAdsKeyBuffer;
      procedure InitRecord( Buffer: PAdsBuffer ); override;
      procedure InternalAddRecord( Buffer: Pointer; Append: Boolean ); override;
      procedure InternalCancel; override;
      procedure InternalClose; override;
      procedure InternalDelete; override;
      procedure InternalEdit; override;
      procedure InternalFirst; override;
      procedure InternalGotoBookmark( Bookmark: Pointer ); override;
      procedure InternalHandleException; override;
      procedure InternalInsert;
{$IFDEF ADSDELPHI4_OR_NEWER}  { Delphi 4, 5 and CBuilder 4 }
      override;
{$ENDIF}
      procedure InternalInitFieldDefs; override;
      procedure InternalInitRecord( Buffer: PAdsBuffer ); override;
      procedure InternalLast; override;
      procedure InternalOpen; override;
      procedure InternalPost; override;
      procedure InternalSetToRecord( Buffer: PAdsBuffer ); override;
      function  IsAceScopeSet : Boolean;
      function  IsAceIndexConditional : Boolean;
      function  IsAceIndexUniqueDBF : Boolean;
      function  IsAceIndexCustom : Boolean;
      function  IndexIsLocateFriendly( hIndex : ADSHANDLE ) : Boolean;
      function  IsCursorOpen: Boolean; override;
      function  LocateRecord( const KeyFields: string; const KeyValues: Variant;
                              Options: TLocateOptions ): Boolean;
      procedure MasterChanged( poSender: TObject );
      procedure MasterDisabled( poSender: TObject );
      function  OpenAdvantageFiles : ADSHANDLE; virtual; abstract;
      function  FindMatchingParen( pcStr : PAceChar; usCurPos : UNSIGNED16; usStrLen : UNSIGNED16 ) : UNSIGNED16;
      function  GetFieldClass(FieldType: TFieldType): TFieldClass; override;
      procedure ParseFilterExpression( var strAdsFilter : string;  var usExact : UNSIGNED16 );
      procedure PostKeyBuffer( bCommit: Boolean );
      function  RecordFilter( RecBuf: Pointer ): Boolean;
      function  ResetCursorRange: Boolean;
      procedure SetAdsConnection( poValue: TAdsConnection );
      procedure SetBookmarkData( Buffer: PAdsBuffer; Data: Pointer ); override;
      procedure SetBookmarkFlag( Buffer: PAdsBuffer; Value: TBookmarkFlag ); override;
      function  SetCursorRange: Boolean;
      procedure SetDatabaseName( strValue: String ); virtual;
      procedure SetDataSource( poValue: TDataSource );
      procedure SetExclusive( bValue: Boolean );
      procedure SetFieldData( Field: TField; Buffer: Pointer ); override;
      procedure SetFiltered( Value: Boolean ); override;
      procedure SetFilterText( const Value: string ); override;
{$IFDEF ADSCBUILDER3_OR_NEWER}
      procedure SetIndexDefs( Value: TIndexDefs );
{$ENDIF}
      procedure SetIndexField( Index: Integer; Value: TField );
      procedure SetIndexFieldNames( const strValue : String );
      procedure SetIndexName( const strValue : String );
      procedure SetKeyBuffer( poKeyIndex: TKeyIndex; bClear: Boolean );
      procedure SetKeyExclusive( bValue: Boolean );
      procedure SetKeyFieldCount( sValue: SIGNED16 );
      procedure SetKeyFields( poKeyIndex: TKeyIndex; const aValues: array of const );
      procedure SetLinkRanges( MasterFields: TList );
      procedure SetMasterFields( const strValue: string );
      procedure SetReadOnly( bValue: Boolean );
      procedure SetScoped( bValue: Boolean );
      procedure SetScopeStart( strValue : String );
      procedure SetScopeEnd( strValue : String );
      procedure SetTableName( strValue: String );
      procedure SetTableType( eValue: TAdsTableTypes ); virtual;
      function  BuildFilterString( poFields : TList;
                                   bExactCompare : Boolean;
                                   bCaseInsensitive : Boolean ) : string;
      procedure SwitchToIndex;
      procedure UpdateIndexDefs; override;
      procedure DoAfterInsert; override;
      procedure DoBeforeCancel; override;
      procedure DoOnNewRecord; override;
      procedure DoAfterOpen; override;
{$IFDEF ADSDELPHI5_OR_NEWER}
      { IProviderSupport }
      {$IFNDEF FPC}
      function  PSIsSQLSupported: Boolean; override;
      procedure PSReset; override;
      function  PSUpdateRecord( UpdateKind: TUpdateKind; Delta: TDataSet ): Boolean; override;
      procedure PSEndTransaction( Commit: Boolean ); override;
      function  PSExecuteStatement( const ASQL: string; AParams: TParams;
                                    ResultSet: Pointer = nil ): Integer; override;
      function  PSGetQuoteChar: string; override;
      function  PSInTransaction: Boolean; override;
      function  PSIsSQLBased: Boolean; override;
      procedure PSStartTransaction; override;
      {$ENDIF}
{$ENDIF}
      procedure SetHandle( Value: ADSHANDLE );
      procedure FreeOldRecordBuffer;
      function  EvalClientFilter( bForward : boolean ) : boolean;
      procedure EvalClientFilteredSeek( pcKey     : PChar;
                                        usKeyLen  : UNSIGNED16;
                                        usKeyType : UNSIGNED16;
                                        pusFound  : PUNSIGNED16 );
      procedure GetCharTypeAfterOpen( hDataSet : ADSHANDLE );

   public
      mpoAdsConnection: TAdsConnection; {  A handle to the connection class instance }

    { Public property declarations }
      property    ACEFieldDefs: TACEFieldDefs read FACEFieldDefs;
      property    AdsBinaryFldLen: Longint read AdsGetBinaryFieldLen write
                                 AdsSetBinaryFieldLen;
      property    AdsConnection: TAdsConnection read GetAdsConnection;

      property    ActiveHandle: Longint read mlActiveHandle write mlActiveHandle;
      property    Handle: Longint read mlHandle;
{$IFDEF ADSDELPHI3}
      property    IndexDefs: TIndexDefs read mpoIndexDefs;
{$ENDIF}
      property    IndexFields[Index: Integer]: TField read GetIndexField write SetIndexField;
      property    KeyExclusive: Boolean read GetKeyExclusive write SetKeyExclusive;
      property    KeyFieldCount: SIGNED16 read GetKeyFieldCount write SetKeyFieldCount;
      property    KeySize: UNSIGNED16 read GetCurrentKeySize;
      property    MasterLink : TMasterDataLink read mpoMasterLink;
      property    RecordSize: Word read GetRecordSize;
      property    RecNo: Integer  read GetRecNo write SetRecNo;
      property    RecordCount: Integer read GetRecordCount;
      property    ScopeStart: String  read mstrScopeStart write SetScopeStart;
      property    TableType:  TAdsTableTypes read meTableType write SetTableType
                              default ttAdsADT;

     { Public method declarations }
      constructor Create( AOwner: TComponent ); override;
      destructor  Destroy; override;
      function  GetAceConnectionHandle : ADSHANDLE;
      function  GetAceTableHandle : ADSHANDLE;
      function  GetAceIndexHandle : ADSHANDLE;
      function  GetAceOrderHandle : ADSHANDLE;
      function  AdsActiveRecord : ADSHANDLE;
      procedure ADSSetFieldToBinary( strFieldName : String );
      procedure AddIndex( const strName : string; strFields: string; poOptions: TIndexOptions );
      procedure AddIndexEx( strFileName : string; strIndexName : string; strFields: string; poOptions : TIndexOptions );
      procedure ApplyRange;
      function  BookmarkValid( Bookmark: TBookmark ): Boolean; override;
      procedure Cancel; override;
      procedure CancelRange;
      function  CompareBookmarks( Bookmark1, Bookmark2: TBookmark ): Integer; override;
      function  ConnectAndGetHandle : ADSHANDLE;
      procedure CloseIndexFile( const strIndexName: string );
{$IFDEF ADSDELPHI4_OR_NEWER}
      procedure CreateTable; overload;
      procedure CreateTable( eOptions : TAdsCreateTableOptions ); overload;
{$ELSE}
      procedure CreateTable;
{$ENDIF}
      procedure InternalCreateTable( eOptions : TAdsCreateTableOptions );
      function  CreateBlobStream( Field: TField; Mode: TBlobStreamMode ): TStream; override;
      procedure DeleteIndex( const strName: string );
      procedure DeleteTable;
      procedure EditKey;
      procedure EmptyTable;
      procedure EditRangeEnd;
      procedure EditRangeStart;
      function  FindKey( const KeyValues: array of const ): Boolean;
      procedure FindNearest( const KeyValues: array of const );
      procedure GotoCurrent( poTable: TAdsDataSet );
      function  GetCurrentRecord( Buffer: PAdsBuffer ): Boolean; override;
      function  GetDatabasePath: string;
      function  GetNativeDatabasePath: string;
{$IFDEF ADSDELPHI4_OR_NEWER}
      { this function is decalared to be public in delphi 4 but protected in D3 }
      function  GetFieldData( Field: TField; Buffer: Pointer ): Boolean; override;
{$ENDIF}
      procedure GetFiles( var poCurrList : TStringList );
      procedure GetIndexNames( poList: TStrings );
      procedure GetFTSIndexNames( poList: TStrings );
      function  GotoKey: Boolean;
      procedure GotoNearest;
      function  IndexFieldCount : UNSIGNED16;
      function  IsSequenced: Boolean; override;
      function  Locate( const KeyFields: string; const KeyValues: Variant;
                        Options: TLocateOptions ): Boolean; override;
      procedure LockTable;
      function  Lookup( const KeyFields: string; const KeyValues: Variant;
                        const ResultFields: string ): Variant; override;
      procedure OpenIndexFile( const strIndexName: string );
      procedure PackTable;
      procedure Post; override;
      procedure SetKey;
      procedure SetRange( const aStartValues, aEndValues: array of const );
      procedure SetRangeEnd;
      procedure SetRangeStart;
      procedure UnlockTable;
      procedure UpdateDefaultIndex;
      procedure InvalidateAceHandles; virtual;
      function  LocateLocally( strFilter : string ) : boolean;
      function  GetEffectiveCollation: String;

   protected
    { Protected declarations }
      property AdsTableOptions: TAdsTableOptions read mpoAdsTableOptions
                                write mpoAdsTableOptions;
      property Exclusive:       Boolean read mbExclusive write SetExclusive default False;
      property ReadOnly:        Boolean read mbReadOnly write SetReadOnly default False;
      property TableName:       String  read mstrTableName write SetTableName;
      property InfoExpression:  String read mstrExprStruct write mstrExprStruct;
      property IndexFiles:      TAdsIndexFiles  read mpoIndexFiles write mpoIndexFiles;


   published
      property Active           stored FbStoreActive;
      property AutoCalcFields;
      property DatabaseName:    String  read mstrDatabaseName write SetDatabaseName;
      property Filter;
      property Filtered;
      property InfoStructure:   String read mstrStruct write mstrStruct;
{$IFDEF ADSCBUILDER3_OR_NEWER}
      property IndexDefs:       TIndexDefs read mpoIndexDefs write SetIndexDefs stored False;
{$ENDIF}
      property IndexFieldNames: String  read mstrIndexFieldNames write SetIndexFieldNames;
      property IndexName:       String  read mstrIndexName write SetIndexName;
      property MasterFields:    string read GetMasterFields write SetMasterFields;
      property MasterSource:    TDataSource read GetDataSource write SetDataSource;
      property Sequenced:       Boolean read mbIsSequenced write mbIsSequenced default False;
      property SequencedLevel:  TAdsSequencedLevel read meSeqLevel write meSeqLevel default slStandard;
      property Scoped:          Boolean read mbScoped write SetScoped default False;
      property ScopeBegin:      String  read mstrScopeStart write SetScopeStart;
      property ScopeEnd:        String  read mstrScopeEnd write SetScopeEnd;
      property StoreActive:     Boolean read FbStoreActive write FbStoreActive default True;
      property Version:         String  read GetVersionInfo write WriteVersionInfo stored False;


      { overridden Event Handlers }
      {  These are methods of TDataSet and are just recognized here so that the }
      {  event tab of the object inspector will recognize them }
      property BeforeOpen;
      property AfterOpen;
      property BeforeClose;
      property AfterClose;
      property BeforeInsert;
      property AfterInsert;
      property BeforeEdit;
      property AfterEdit;
      property BeforePost;
      property AfterPost;
      property BeforeCancel;
      property AfterCancel;
      property BeforeDelete;
      property AfterDelete;
      property BeforeScroll;
      property AfterScroll;
{$IFDEF ADSDELPHI5_OR_NEWER}
      property BeforeRefresh;
      property AfterRefresh;
{$ENDIF}
      property OnCalcFields;
      property OnNewRecord;
      property OnFilterRecord;
      property OnEditError;
      property OnPostError;
      property OnDeleteError;
{$IFDEF ADSDELPHI5_OR_NEWER}
{$IFNDEF FPC}
      property OnUpdateRecord: TUpdateRecordEvent read FOnUpdateRecord write FOnUpdateRecord;
{$ENDIF}
{$ENDIF}   {* IFDEF ADSDELPHI5_OR_NEWER *}



{  Section of test methods to make sure all virtual functions show if being called }
{  The following functions NoOp except if CALLTRACE is defined to show what could }
{  be getting called }
   protected
{$ifndef ADSDELPHI5_OR_NEWER} { Delphi 3,4 and CBuilder 3,4 }
      function  BCDToCurr( BCD: Pointer; var Curr: Currency ): Boolean; override;
      function  CurrToBCD( const Curr: Currency; BCD: Pointer; Precision,
                           Decimals: Integer ): Boolean; override;
{$endif}
      procedure ClearCalcFields( Buffer: PAdsBuffer ); override;
      procedure CloseBlob( Field: TField ); override;
      procedure CloseCursor; override;
      function  GetIsIndexField( Field: TField ): Boolean; override;
      procedure InitFieldDefs; override;
      procedure InternalRefresh; override;
      procedure OpenCursor( InfoQuery: Boolean ); override;
      procedure SetOnFilterRecord( const Value: TFilterRecordEvent ); override;
{  end of test methods to make sure all virtual functions show if being called }


{  The following are stubs for public methods and procedures that will raise exceptions }
{  if they are called.  This will help in debugging why something is not working for }
{  third party controls. }
   protected
      function  GetTableLevel : Integer;
      function  GetDBDataBase : Variant;
      function  GetDBHandle : Variant;
      function  GetDBLocale : Variant;
      function  GetDBSession : Variant;
      function  GetProvider : Variant;
      function  GetSessionName : String;
      function  GetCacheBlobs : Boolean;
      function  GetCachedUpdates : Boolean;
      function  GetExpIndex : Boolean;
      function  GetLocale : Variant;
      function  GetUpdateObject : Variant;
      function  GetUpdatesPending : Boolean;
      function  GetUpdateRecordSet : Variant;
      procedure SetTableLevel( Value : Integer );
      procedure SetSessionName( Value : String );
      procedure SetCacheBlobs( Value : Boolean );
      procedure SetCachedUpdates( Value : Boolean );
      procedure SetUpdateObject( Value : Variant );
      procedure SetUpdateRecordSet( Value : Variant );


   public
      property DefaultIndex: String read mstrDefaultIndex;
      property TableLevel: Integer read GetTableLevel write SetTableLevel;
      property Database: Variant read GetDBDataBase;
      property DBHandle: Variant read GetDBHandle;
      property DBLocale: Variant read GetDBLocale;
      property DBSession: Variant read GetDBSession;
      property Provider: Variant read GetProvider;
      property SessionName: string read GetSessionName write SetSessionName;

      property CacheBlobs: Boolean read GetCacheBlobs write SetCacheBlobs default True;
      property CachedUpdates: Boolean read GetCachedUpdates write SetCachedUpdates default False;
      property ExpIndex: Boolean read GetExpIndex;
      property Locale: Variant read GetLocale;
      property UpdateObject: Variant read GetUpdateObject write SetUpdateObject;
      property UpdatesPending: Boolean read GetUpdatesPending;
      property UpdateRecordTypes: Variant read GetUpdateRecordSet write SetUpdateRecordSet;

      function BatchMove( ASource: Variant; AMode: Variant ): Longint; virtual;
      procedure RenameTable( const NewTableName: string ); virtual;
      function CheckOpen( Status: Variant ): Boolean;

      procedure ApplyUpdates;
      procedure CancelUpdates;
      procedure CommitUpdates;
      function ConstraintsDisabled: Boolean;
      procedure DisableConstraints;
      procedure EnableConstraints;
      procedure FetchAll;
      procedure FlushBuffers;
      procedure GetIndexInfo;
      procedure RevertRecord;
{$ifdef ADSDELPHI4_OR_NEWER}
      function UpdateStatus: TUpdateStatus; override;
{$else}
      function UpdateStatus: TUpdateStatus;
{$endif}



{  The end of the stubs for public methods and procedures that will raise exceptions }
{  if they are called.  This will help in debugging why something is not working for }
{  third party controls. }


  end;

 { TAdsBlobCache }
 {  This is the blob cach object for reading and writing Memos and Images or any binary }
   TAdsBlobCache = class( TMemoryStream )
   private
      mhAdsTable:      ADSHANDLE;       {  ACE Table handle }
      mulRecNum:       UNSIGNED32;      {  Record number of the cached blob }
      mbBlobModified:  Boolean;         {  Flag if modified }
   public
      mulFieldNo: UNSIGNED32;           {  Field number of the cached blob }
      constructor Create;
      destructor  Destroy; override;
      procedure   RefreshCache( hAdsTable : ADSHANDLE; ulFieldNo : UNSIGNED32;
                               ulRecNo : UNSIGNED32; bForceReread : Boolean );
      function    Read( var Buffer; Count: Longint ): Longint; override;
      function    Write( const Buffer; Count: Longint ): Longint; override;
      procedure   Truncate;
      procedure   ClearCache;
      Procedure   Flush;
      function    IsCacheModified : Boolean;
   end;


 { TAdsBlobStream }
 {  This is the stream object for reading and writing Memos and Images or any binary }
   TAdsBlobStream = class( TStream )
   private
      moField:           TBlobField;       {  this is need so we can change the modified status }
      moMode:            TBlobStreamMode;  {  Read or Write }
      moAdsBlobCach:     TAdsBlobCache;
      mbModified:        boolean;

      function GetBlobSize: LongInt;

   public
      constructor Create( Field: TBlobField; Mode: TBlobStreamMode );
      destructor  Destroy; override;
      function    Read( var Buffer; Count: Longint ): Longint; override;
      function    Write( const Buffer; Count: Longint ): Longint; override;
      function    Seek( Offset: Longint; Origin: Word ): Longint; override;
      procedure   Truncate;

      property    Size: Integer read GetBlobSize;
   end;

   PDyanmicConnLIst = ^TDynamicConnList;
   TDynamicConnList = class
   private
      FItems : TList;
      FSync  : TCriticalSection;
   public
      constructor Create;
      destructor  Destroy; override;
      function    Add( strDatabasename : string ) : ADSHANDLE;
      function    FindSameDatabasename( strDatabasename : string ) : ADSHANDLE;
   end;

   PDynamicConn = ^TDynamicConn;
   TDynamicConn = class
   private
      FhAceConn        : ADSHANDLE;
      FstrDatabasename : string;
   end;

procedure WriteCallTrace( strWrite : String );

procedure ACECheck( oDataSet : TAdsDataSet; ulErrorCode: UNSIGNED32 );

function GetAliasInfo( strAlias : string; var strPath : string;
                       var eTableType : TAdsTableTypes ) : boolean; {$IFNDEF FPC} forward; {$ENDIF}

function GetAliasPathAndFileName : string; {$IFNDEF FPC} forward; {$ENDIF}

function GetAdsDataSetList       : TThreadList;
function LockAdsDataSetList      : TList;
procedure UnlockAdsDataSetList;


procedure AddUpperExpr( hTable : ADSHANDLE; var strFields : string );

function GetFieldFromList( iIndex : integer; strFieldList : string ) : string;

function IsSlash( x : char ) : boolean;

function SlashInStr( str : string ) : boolean;

{$IFNDEF ADSDELPHI5_OR_NEWER}
procedure FreeAndNil(var Obj);
{$ENDIF}

{$IFDEF ADSDELPHI5}
function StrToBcd(const AValue: string): TBcd;
function BcdToStr(const Bcd: TBcd): string;
{$ENDIF}

var
   HandleExceptionProc : procedure( sender : tobject );
   goDynamicConnList   : TDynamicConnList;

implementation

{$IFDEF ADSDELPHI6_OR_NEWER}
{* Don't show platform-specific unit warnings. *}
{$WARN UNIT_PLATFORM OFF}
{$ENDIF}

uses
{$ifdef LINUX}
   Libc,     // used for memset functionality
{$endif}

   adsstrng,
   Math,
   adstable,
   adsdictionary

{$IFDEF ADSDELPHI6_OR_NEWER}
, variants
{$ENDIF}
;

const
   {  Error Messages }
   SNotEditing = 'Dataset not in edit mode';
   SNotIndexField = 'Field ''%s'' is not indexed and cannot be modified';
   SFieldReadOnly = 'Field ''%s'' cannot be modified';
   STableMismatch = 'Tables are not the same';
   SNoUpdatePermission = 'Update permission not granted on this field: ';
   SNoInsertPermission = 'Insert permission not granted on this field: ';

   { The following are from the BDE.INT file.  We can probably include the whole file to          }
   {  get the constant but most of the file are BDE specific and not used by TDataset Descendant. }
   CMPLess           = -1;             { Bkm1 < Bkm2 }
   CMPEql            = 0;              { BookMarks are exactly the same }
   CMPGtr            = 1;              { Bkm1 > Bkm2 }
   CMPKeyEql         = 2;              { Only Bkm1.key_val = Bkm2.key_val }

type
   pTDateTimeRec  = ^TDateTimeRec;
{$IFNDEF FPC}
   pWordBool      = ^WordBool;
{$ENDIF}

{$IFNDEF ADSDELPHI4_OR_NEWER }
   { StringReplace replaces occurances of <oldpattern> with <newpattern> in a
  given string.  Assumes the string may contain Multibyte characters }
  TReplaceFlags = set of ( rfReplaceAll, rfIgnoreCase );
{$ENDIF }

var
   oAdsDatasets : TThreadList;

threadvar
   bExceptionSet: Boolean;          {  Global flag per-thread showing if an exception is raised }

{**********************************************************
*  Module:  IsSlash
*  Input:   x - character to test
*  Output: true if slash, false if not
*  Description: utility function
**********************************************************}
function IsSlash( x : char ) : boolean;
begin
   if ( x = '/' ) or ( x = '\' ) then
      result := true
   else
      result := false;
end;


{**********************************************************
*  Module:  SlashInStr
*  Input:   str - string to search
*  Output: true if slash in str, false if not
*  Description: utility function
**********************************************************}
function SlashInStr( str : string ) : boolean;
begin
   if ( ( pos( '/', str ) > 0 ) or ( pos( '\', str ) > 0 ) ) then
      result := true
   else
      result := false;
end;


{$IFNDEF ADSDELPHI2008_OR_NEWER}
function AnsiStrAlloc(Size: Cardinal): PChar;
begin
  Result := StrAlloc( Size );
end;
{$ENDIF}

{$IFNDEF ADSDELPHI4_OR_NEWER }

{**********************************************************
*  Module:  StringReplace
*  Output:
*  Return:  NewPattern
*  Description:
*  Note:
**********************************************************}
function StringReplace( const S, OldPattern, NewPattern: string;
  Flags: TReplaceFlags ): string;
var
  SearchStr, Patt, NewStr: string;
  Offset: Integer;
begin
  if rfIgnoreCase in Flags then
  begin
    SearchStr := AnsiUpperCase( S );
    Patt := AnsiUpperCase( OldPattern );
  end else
  begin
    SearchStr := S;
    Patt := OldPattern;
  end;
  NewStr := S;
  Result := '';
  while SearchStr <> '' do
  begin
    Offset := AnsiPos( Patt, SearchStr );
    if Offset = 0 then
    begin
      Result := Result + NewStr;
      Break;
    end;
    Result := Result + Copy( NewStr, 1, Offset - 1 ) + NewPattern;
    NewStr := Copy( NewStr, Offset + Length( OldPattern ), MaxInt );
    if not ( rfReplaceAll in Flags ) then
    begin
      Result := Result + NewStr;
      Break;
    end;
    SearchStr := Copy( SearchStr, Offset + Length( Patt ), MaxInt );
  end;
end;
{$ENDIF }



{**********************************************************
*  Module:  GetAdsDataSetList
*  Input:
*  Output: The list of AdsDataset instances
*  Description: Return the list of AdsDataset instances
**********************************************************}
function GetAdsDataSetList : TThreadList;
begin
   Result := oAdsDatasets;
end;


{**********************************************************
*  Module:  LockAdsDataSetList
*  Input:
*  Output: data set list
*  Description: Locks the TThreadList (gets critical
*     section) and returns a pointer to the list it
*     contains.
**********************************************************}
function LockAdsDataSetList : TList;
begin
   Result := oAdsDatasets.LockList;
end;


{**********************************************************
*  Module:  UnlockAdsDataSetList
*  Input:
*  Output:
*  Description: Unlock the TThreadList (leave crit sec)
**********************************************************}
procedure UnlockAdsDataSetList;
begin
   oAdsDatasets.UnlockList;
end;


{$ifdef LINUX}
procedure FillMemory( buffer : PChar; length : integer; value : byte );
begin
   memset( buffer, value, length );
end;
{$endif}


{* TDynamicConnList *}

{*******************************************************************************
*  Module: TDynamicConnList.Create
*  Input:
*  Output:
*  Description: constructor for our dynamic-connection
*               list.
*******************************************************************************}
constructor TDynamicConnList.Create;
begin
   inherited Create;
   FItems := TList.Create;
   FSync  := TCriticalSection.Create;
end;   {* TDynamicConnList.Create *}



{*******************************************************************************
*  Module: TDynamicConnList.Destroy
*  Input:
*  Output:
*  Description: Destructor for out dynamic-conn list.
*               Explicitly closes all connections and then
*               frees the memory associated with them.
*******************************************************************************}
destructor TDynamicConnList.Destroy;
var
   iCount : integer;
begin
   {*
    * Free the struct associated with each entry. Note that when using a
    * TList it is possible to have nil pointers mixed in the list. We never
    * remove entries from this list until right here though, so there is no
    * need to pack the list. See Delphi help on TList if you need more
    * clarification.
    *}
   for iCount := 0 to (FItems.Count - 1) do
   begin
      ACECHECK( nil,
                AdsDisconnect( TDynamicConn( FItems.Items[iCount] ).FhAceConn ) );
      TDynamicConn( FItems[iCount] ).Free;
   end;

   FItems.Free;
   FSync.Free;
end;   {* TDynamicConnList.Destroy *}



{*******************************************************************************
*  Module: TDynamicConnList.Add
*  Input:   strDatabasename : databasename to add to the list
*  Output:  ACE connection handle established, or 0 if error
*  Description: Get a new ace connection, add to the list and return its handle
*******************************************************************************}
function TDynamicConnList.Add( strDatabasename : string ) : ADSHANDLE;
var
   hConn : ADSHANDLE;
   oConn : TDynamicConn;
begin

   {* Enter critical section *}
   FSync.enter;
   try
      oConn := nil;
      hConn := 0;

      {* get a connection *}
      ACECHECK( nil, AdsConnect( PAceChar( AnsiString( strDatabasename ) ), @hConn ) );

      try
         {* OK, we got a connection, now allocate the memory for it *}
         oConn := TDynamicConn.Create;

         {* add it to the TList *}
         FItems.Add( oConn );

         {* and fill it up *}
         oConn.FhAceConn := hConn;
         oConn.FstrDatabasename := strDatabasename;

         {* return the ACE handle *}
         result := hConn;
      except
         on E: Exception do
            begin
            if ( assigned( oConn ) ) then
               oConn.Free;
            if ( hConn <> 0 ) then
               AdsDisconnect( hConn );
            {* just keep result at zero, this will flag the caller to raise an exception *}
            result := 0;
            end;
      end;

   finally
      {* Leave critical section *}
      FSync.leave;
   end;

end;   {* TDynamicConnList.Add *}



{*******************************************************************************
*  Module: TDynamicConnList.FindSameDatabasename
*  Input:   strDatabasename : name to find in list
*  Output:  ACE conn handle if found, o/w zero
*  Description: Search the list for an entry with this databasename.
*  NOTE paths are not converted to UNC or anything, we just use the string
*  as it lives in the databasepath property (or the alias). This means if the
*  user has one table with 'x:\w89p1' and one with '.\w89p1' we will create
*  TWO connections for them. This is not entirly complete, but MUCH easier
*  than dealing with the UNC conversions. If this is ever changed then it would
*  be nice to implement two methods: one for finding a connection on the same
*  server (for TAdsTable instances), and on for finding an exact connection
*  (for TAdsQuery instances).
*******************************************************************************}
function TDynamicConnList.FindSameDatabasename( strDatabasename : string ) : ADSHANDLE;
var
   i : integer;
   oConn : TDynamicConn;
begin

   {* Enter critical section. *}
   FSync.enter;

   try
      result := 0;

      try
         if ( FItems.Count = 0 ) then
            exit;

         {* just do a linear search *}
         for i := 0 to (FItems.Count-1) do
         begin
            oConn := FItems.Items[i];
            {*
             * Throw in an UPPER so 'x:\w89p1' and 'X:\W89p1' don't grab
             * different connections.
             *}
            if ( UpperCase( oConn.FstrDatabasename ) =
                 UpperCase( strDatabasename ) ) then
            begin
               result := oConn.FhAceConn;
               exit;
            end;
         end;
      except
         on E: Exception do
            {* just keep result at zero, this will flag the caller to raise an exception *}
            result := 0;
      end;

   finally
      {* Leave critical section *}
      FSync.leave;
   end;

end;


{* TACEFieldDefs *}

{**********************************************************
*  Module:  TACEFieldDefs.Create
*  Input:
*  Output:
*  Description: Constructor for ACEFieldDefs collection.
**********************************************************}
constructor TACEFieldDefs.Create( Owner: TPersistent );
begin
  inherited Create( TACEFieldDef );
  FOwner := Owner;
end;



{**********************************************************
*  Module:  TACEFieldDefs.Add
*  Input:
*  Output: new TACEFieldDef object
*  Description: Adds a new TACEFieldDef object to the
*     collection and returns a pointer to it.
**********************************************************}
function TACEFieldDefs.Add: TACEFieldDef;
begin
  Result := TACEFieldDef( inherited Add );
end;



{**********************************************************
*  Module:  TACEFieldDefs.GetOwner
*  Input:
*  Output: owner of this collection
*  Description: returns a pointer to the owner
**********************************************************}
function TACEFieldDefs.GetOwner: TPersistent;
begin
  Result := FOwner;
end;



{**********************************************************
*  Module:  TACEFieldDefs.GetItem
*  Input:  Index - index of item to retrieve
*  Output: pointer to a TACEFieldDef object
*  Description: Returns the TACEFieldDef object in question
**********************************************************}
function TACEFieldDefs.GetItem( Index: Integer ): TACEFieldDef;
begin
  Result := TACEFieldDef( inherited GetItem( Index ) );
end;



{**********************************************************
*  Module:  TACEFieldDefs.SetItem
*  Input:  Index - index to set
*          Value - item to set
*  Output:
*  Description: sets an item
**********************************************************}
procedure TACEFieldDefs.SetItem( Index: Integer; Value: TACEFieldDef );
begin
  inherited SetItem( Index, Value );
end;



{**********************************************************
*  Module:  TACEFieldDefs.IndexOf
*  Input: FieldName : name of object to find
*  Output:
*  Description: return the index into the Items property
*     of the named object.
**********************************************************}
function TACEFieldDefs.IndexOf( const FieldName: string ): Integer;
begin
  for Result := 0 to Count - 1 do
    if AnsiCompareText( TACEFieldDef( Items[Result] ).FieldName, FieldName ) = 0 then Exit;
  Result := -1;
end;


{**********************************************************
*  Module:  MemCopy
*  Input:  pcDestination : starting position of the destination
*          pcSource      : starting position of the source
*          ulCount       : how many bytes to mover
*  Output:
*  Description: There is no range checking, use at ur own risk
**********************************************************}
Procedure MemCopy( pcDestination: PAdsBuffer; pcSource: PAdsBuffer; ulCount : UNSIGNED32 );
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'MemCopy' );
{$ENDIF }

   while ulCount > 0 do
   begin
      dec( ulCount );
      pcDestination[ ulCount ] := pcSource[ ulCount ];
   end;
end;


{**********************************************************
*  Module:  WriteCallTrace
*  Input:  strWrite : string - string to write to the output file
*  Output:
*  Description: Writes a string out to an output file
**********************************************************}
procedure WriteCallTrace( strWrite : String );
var
   hFile : TextFile;
   strFileName : String;
   bFileExists : Boolean;
begin
   {$IFDEF WIN32}
   strFileName := 'c:\Debug.txt';
   {$ENDIF}
   {$IFDEF LINUX}
   strFileName := '/debug.txt';
   {$ENDIF}

   {$I-}
   {  The following is doing a check if I can open the file and reset it }
   {  If I cant reset the file meaning it doesn't exist IOResult will have }
   {  a value. }
   AssignFile( hFile, strFileName );

   {  FileMode is a system variable that indicates the access mode on typed and }
   {  untyped files opened by the  Reset class. }
   {  0 Read only, 1 Write only, 2 Read/Write }
   FileMode := 0;  { Set file access to read only }
   Reset( hFile );
   CloseFile( hFile );
   {$I+}

   {  Make check to see whether or not the file exists.  Non 0 means that file }
   {  doesn't exist }
   bFileExists := ( IOResult = 0 );
   {$IFDEF WIN32}
   AssignFile( hFile, 'c:\Debug.txt' );
   {$ENDIF}
   {$IFDEF LINUX}
   AssignFile( hFile, '/debug.txt' );
   {$ENDIF}

   {  If file exists then Append to what we have otherwise rewrite }
   if bFileExists then
      Append( hFile )
   else
      Rewrite( hFile );

   {  Put the string out to the file }
   writeln( hFile, strWrite );
   CloseFile( hFile );
end;

{ TAdsIndexFiles }
{**********************************************************
*  Module:  TAdsIndexFiles.Create
*  Input:  AOwner - TAdsDataSet is the owner
*  Output:
*  Description: Constructor for the index files
**********************************************************}
constructor TAdsIndexFiles.Create( AOwner: TAdsDataSet );
begin
{$IFDEF CALLTRACE}
   WriteCallTrace( 'TAdsIndexFiles.Create' );
{$ENDIF}

  {* This class must always have an owner, if not it can
   * not function correctly. *}
  if ( AOwner = nil ) then
    raise EADSDatabaseError.Create( nil, AE_TADSDATASET_GENERAL,
      'TAdsIndexFiles instances require a non-nil owner' );

  inherited Create;
  sorted := True;
  Duplicates := dupIgnore;
  mpoOwner := AOwner;
end;

{**********************************************************
*  Module:  TAdsIndexFiles.Add
*  Input:  strValue - String to add to the list
*  Output:
*  Return: Integer - index number
*  Description: Add a index file to the list
**********************************************************}
function TAdsIndexFiles.Add( const strValue: string ): Integer;
begin
{$IFDEF CALLTRACE}
   WriteCallTrace( 'TAdsIndexFiles.Add' );
{$ENDIF}

  with mpoOwner do
  begin
    if Active then
       OpenIndexFile( strValue );

    mpoIndexDefs.Updated := False;
  end;
  Result := inherited Add( strValue );
end;

{**********************************************************
*  Module:  TAdsIndexFiles.Clear
*  Input:
*  Output:
*  Description: Clears out the strings and closes all of the indexes
**********************************************************}
procedure TAdsIndexFiles.Clear;
var
  I: Integer;
begin
{$IFDEF CALLTRACE}
   WriteCallTrace( 'TAdsIndexFiles.Clear' );
{$ENDIF}

  with mpoOwner do
    if Active then
      for I := 0 to Count - 1 do CloseIndexFile( Strings[I] );
  inherited Clear;
end;

{**********************************************************
*  Module:  TAdsIndexFiles.Insert
*  Input:  Index - insert into a certain position a index file
*          S - file name to insert
*  Output:
*  Description: Add a index file to the list
**********************************************************}
procedure TAdsIndexFiles.Insert( Index: Integer; const S: string );
begin
{$IFDEF CALLTRACE}
   WriteCallTrace( 'TAdsIndexFiles.Insert' );
{$ENDIF}

  inherited Insert( Index, S );
  with mpoOwner do
  begin
    if Active then
       OpenIndexFile( S );

    mpoIndexDefs.Updated := False;
  end;
end;

{**********************************************************
*  Module:  TAdsIndexFiles.Delete
*  Input:  Index - specific index to delete
*  Output:
*  Description: remove a index file from the list
**********************************************************}
procedure TAdsIndexFiles.Delete( Index: Integer );
begin
{$IFDEF CALLTRACE}
   WriteCallTrace( 'TAdsIndexFiles.Delete' );
{$ENDIF}

  with mpoOwner do
  begin
    if Active then
       CloseIndexFile( Strings[Index] );

    mpoIndexDefs.Updated := False;
  end;
  inherited Delete( Index );
end;



{**********************************************************
*  Module:  GetIndexExprField
*  Input:    usNum - number of the field to retrieve in the expression
*            pcExpression - the expression of concatenated field
*  Output:
*  Return:   String - field from the expression
*  Description: For the expression parse through the fields
*               to get the right field.  This function does not use any
*               dataset property so it does not need to be part of the
*               TAdsDataSet.  Fields are ; delimited.
**********************************************************}
function GetIndexExprField( usNum : UNSIGNED16; pcExpression : PChar ) : String;
var
   pcEndPos : PChar;
begin
{$IFDEF CALLTRACE}
   WriteCallTrace( 'GetIndexExprField' );
{$ENDIF}


   Result := '';

   {  Find the beginning position first }
   while ( usNum > 1 ) and ( pcExpression <> Nil ) do
   begin
      pcExpression := StrPos( pcExpression, ';' );

      { If we did not find another ';', then there is no more }
      if pcExpression = nil then
         Exit;

      { Set the starting position to the next character }
      pcExpression := pcExpression + 1;
      dec( usNum );
   end;

   {  usNum <> 1 if we either get to the end of the string before hitting enough }
   {  ';' or usNum = 0 to start with }
   if ( usNum <> 1 ) or ( pcExpression = Nil ) then
      Exit;

   {  Find the end position }
   pcEndPos := StrPos( pcExpression, ';' );

   {  If there is no more ';', we return the whole thing}
   if pcEndPos = Nil then
      Result := pcExpression
   else
   begin
      {  Change ';' to #0 and then set it back to ';' before returning }
      pcEndPos^ := #0;
      Result := pcExpression;
      pcEndPos^ := ';';
   end;

end;  { GetIndexExprField }


{**********************************************************
*  Module:  GetFieldIndexFromString
*  Input:    pcFieldName - field name to search for
*            strFieldList - ';' delimited list of field names
*  Output:
*  Return:   1 based index of the field name within the field name list
*  Description: GetFieldIndexFromString( 'abc', 'cde;abc;fgh' ) will return 2
**********************************************************}
function GetFieldIndexFromString( pcFieldName : PAceChar;
                                  const strFieldList : string ) : UNSIGNED16;
var
   pcBeginPos : PAceChar;
   ulCompLen  : UNSIGNED32;
begin
{$IFDEF CALLTRACE}
   WriteCallTrace( 'GetFieldIndexFromString' );
{$ENDIF}

   pcBeginPos := PAceChar( AnsiString( strFieldList ) );
   ulCompLen := StrLen( pcFieldName );

   Result := 0;

   while pcBeginPos <> Nil do
   begin
      inc( Result );

// Ignore "widechar reduced in sets" warning in statement below.
{$IFDEF ADSDELPHI2008_OR_NEWER}
   {$WARN WIDECHAR_REDUCED OFF}
{$ENDIF}

      {  Do a case insensitive compare up to the length of the field name }
      if StrLIComp( pcBeginPos, pcFieldName, ulCompLen ) = 0 then
         if pcBeginPos[ ulCompLen ] in [ ';', #0 ] then
            Exit;

{$IFDEF ADSDELPHI2008_OR_NEWER}
   {$WARN WIDECHAR_REDUCED ON}
{$ENDIF}

      {  Scan to the next field name in the list }
      pcBeginPos := StrPos( pcBeginPos, ';' );
      if pcBeginPos <> Nil then
         pcBeginPos := pcBeginPos + 1;
   end;

   Result := 0;
end;  { GetFieldIndexFromString }



{**********************************************************
*  Module:  TAdsDataSet.CheckEmptyResultSet
*  Input:
*  Output:
*  Return:  Boolean - flag to tell whether or not set is empty
*  Description: Output whether or not the active set is empty
**********************************************************}
function TAdsDataSet.CheckEmptyResultSet : Boolean;
var
   usIsEOF : UNSIGNED16;
   usHoldEOF, usHoldBOF : UNSIGNED16;
   ulholdRecord : UNSIGNED32;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.CheckEmptyResultSet' );
{$ENDIF }

   {  Save the Flags }
   ACECheck( self, ACE.AdsAtEof( Self.Handle, @usHoldEOF ) );
   ACECheck( self, ACE.AdsAtBof( Self.Handle, @usHoldBOF ) );

   {  Save the Record position if not at EOF or BOF }
   if ( usHoldEOF = ADS_FALSE ) And ( usHoldBOF = ADS_FALSE )then
   begin
         ACECheck( self, ACE.AdsGetRecordNum( Self.Handle, ADS_IGNOREFILTERS, @ulholdRecord ) );
   end;

   {  Goto top to check if we are at EOF meaning empty set }
   ACECheck( self, ACE.AdsGotoTop( ActiveHandle ) );
   ACECheck( self, ACE.AdsAtEof( Self.Handle, @usIsEOF ) );

   {  If we are at EOF then return True }
   if ( usIsEOF <> ADS_FALSE ) then
      Result := True
   else
   begin  {  IF we are not at EOF restore the state }
      Result := False;
      {  Restore to EOF }
      if ( usHoldEOF <> ADS_FALSE ) then
      begin
         ACECheck( self, ACE.AdsGotoBottom( ActiveHandle ) );
         ACECheck( self, ACE.AdsSkip( ActiveHandle, 1 ) );
      end
      {  Restore to BOF }
      else if ( usHoldBOF <> ADS_FALSE ) then
      begin
         ACECheck( self, ACE.AdsGotoTop( ActiveHandle ) );
         ACECheck( self, ACE.AdsSkip( ActiveHandle, -1 ) );
      end
      else
         {  Restore to actual record }
         ACECheck( self, ACE.AdsGotoRecord( self.Handle, ulholdRecord ) );
   end;
end;


{$ifdef ADSDELPHI4_OR_NEWER}

{**********************************************************
*  Module:  ACECheck
*  Input:   ulErrorCode - Return code from ACE API calls
*  Output:
*  Description: Exception handler for ACE API errors
**********************************************************}
procedure ACECheck( oDataSet : TAdsDataSet; ulErrorCode: UNSIGNED32 );

   procedure RaiseError;
   var
      acErrorString : array[0..ADS_MAX_ERROR_LEN] of AceChar;
      usErrStringSize : UNSIGNED16;
   begin
      {* get the error string *}
      usErrStringSize := ADS_MAX_ERROR_LEN;
      ACE.AdsGetLastError( @ulErrorCode, @acErrorString, @usErrStringSize );

      raise EADSDatabaseError.Create( oDataSet, ulErrorCode, string( acErrorString ) );
   end;

begin

{$IFDEF CALLTRACE}
   WriteCallTrace( 'ACECheck' );
{$ENDIF}

   if ( ( ulErrorCode <> AE_SUCCESS ) and
        ( not bExceptionSet ) ) then
      RaiseError;

end;

{$ELSE}

{**********************************************************
*  Module:  ACECheck
*  Input:   ulErrorCode - Return code from ACE API calls
*  Output:
*  Description: Exception handler for ACE API errors
**********************************************************}
procedure ACECheck( oDataSet : TAdsDataSet; ulErrorCode: UNSIGNED32 );
var
   acErrorString : array[0..ADS_MAX_ERROR_LEN] of AceChar;
   usErrStringSize : UNSIGNED16;
begin
{$IFDEF CALLTRACE}
   WriteCallTrace( 'ACECheck' );
{$ENDIF}

   {  If Ace returns success or an exception is already raised exit and continue }
   if ( ulErrorCode = AE_SUCCESS ) OR ( bExceptionSet ) then
      exit;

   {* get the error string *}
   usErrStringSize := ADS_MAX_ERROR_LEN;
   ACE.AdsGetLastError( @ulErrorCode, @acErrorString, @usErrStringSize );

   raise EADSDatabaseError.Create( oDataSet, ulErrorCode, acErrorString );

end;

{$ENDIF}  // if ADSDELPHI4_OR_NEWER


{**********************************************************
*  Module:  GetFieldFromList
*  Input:       iIndex : index of the fieldname to retrieve
*               strFieldList : ';' delimited list of fields
*  Output:
*  Description: return field at iIndex (1 based) from
*               strFieldList
*  NOTE: created because GetIndexExprField was causing
*        unexpected results (access violations) if
*        GetActiveIndexFieldnames was not called to get the
*        field list.
**********************************************************}
function GetFieldFromList( iIndex : integer; strFieldList : string ) : string;
var
   i       : integer;
   iCount  : integer;
begin
   if ( iIndex <= 0 ) or ( strFieldList = '' ) then
   begin
      result := '';
      exit;
   end;

   if ( iIndex = 1 ) then
   begin
      i := pos( ';', strFieldList );
      {* send delete the length of the string, including the offest i this
       * will always delete to the end of the string (any number over the
       * length of the string is legal, it will just delete up to the end) *}
      system.delete( strFieldList, i, length( strFieldList ) );
      result := strFieldList;
      exit;
   end
   else
   begin
      i := 0;
      iCount := 1;
      while ( iCount < iIndex ) do
      begin
         i := pos( ';', strFieldList );
         system.delete( strFieldList, 1, i );
         inc( iCount );
      end;
      {* if i = 0 then we passed the index we were looking
       * for and the field doesn't exist *}
      if ( i = 0 ) then
         result := ''
      else
      begin
         {* if there are trailing fields delete them *}
         i := pos( ';', strFieldList );
         if ( i > 0 ) then
            system.delete( strFieldList, i, length( strFieldList ) );
         result := strFieldList;
      end;
   end;
end;   {* GetFieldFromList *}



{**********************************************************
*  Module:  AddUpperExpr
*  Input:
*  Output:
*  Description: add UPPER function to all string fields
**********************************************************}
procedure AddUpperExpr( hTable : ADSHANDLE; var strFields : string );
var
   strTemp  : string;
   i        : integer;
   strFieldname : string;
   usFieldType  : UNSIGNED16;
begin
   strTemp := '';
   i := 1;
   strFieldname := GetFieldFromList( i, strFields );
   while ( strFieldname <> '' ) do
   begin
      ACE.AdsGetFieldType( hTable, PAnsiChar( AnsiString( strFieldname ) ), @usFieldType );
{$IFDEF ADSDELPHI2008_OR_NEWER}
      if ( usFieldType = ADS_STRING ) or ( usFieldType = ADS_VARCHAR_FOX ) or
         ( usFieldType = ADS_NCHAR ) or ( usFieldType = ADS_NVARCHAR ) then
{$ELSE}
      if ( usFieldType = ADS_STRING ) or ( usFieldType = ADS_VARCHAR_FOX ) then
{$ENDIF}
         strTemp := strTemp + 'UPPER(' + strFieldname + ');'
      else
         strTemp := strTemp + strFieldname + ';';
      inc( i );
      strFieldname := GetFieldFromList( i, strFields );
   end;
   {* clean up the final semi-colon *}
   if ( strTemp <> '' ) then
      system.delete( strTemp, length( strTemp ), 1 );
   strFields := strTemp;
end;   {* AddUpperExpr *}


{$IFNDEF ADSDELPHI6_OR_NEWER}
function GetEnvironmentVariable(const Name: string): string;
var
  Len: integer;
begin
  Result := '';
  Len := Windows.GetEnvironmentVariable(PChar(Name), nil, 0);
  if Len > 0 then
  begin
    SetLength(Result, Len - 1);
    Windows.GetEnvironmentVariable(PChar(Name), PChar(Result), Len);
  end;
end;
{$ENDIF}


{**********************************************************
*  Module:  GetAliasPathAndFileName
*  Description: return the current executable's ads.ini file
**********************************************************}
{$ifdef win32}
function GetAliasPathAndFileName : string;
var
   dwRet       : DWORD;
   acFilename  : array[0..MAX_PATH] of Char;
   pcFile      : pChar;
   strAliasSearchPath : string;
   pcPath      : pChar;
begin
   // If the user has specified the environment var adsini_path, then
   // use that path to do the search, otherwise pass nil to use the
   // default search path.
   strAliasSearchPath := GetEnvironmentVariable( 'adsini_path' );
   if ( strAliasSearchPath <> '' ) then
   begin
      strAliasSearchPath := strAliasSearchPath + '\ads.ini';
      if SysUtils.FileExists( strAliasSearchPath ) then
      begin
         Result := strAliasSearchPath;
         Exit;
      end;
      // If we haven't exited, the file isn't present in this directory
      // so fall through to check the default search path.
   end;

   // Use SearchPath to find the ads.ini file to use
   pcPath := nil;
   pcFile := nil;
   dwRet := SearchPath( pcPath,
                        'ads.ini',
                        nil,
                        Length( acFilename ),
                        @acFilename,
                        pcFile );
   if ( dwRet = 0 ) then
      // file might not exist, just use base filename and let TIniFile
      // create it
      Result := 'ads.ini'
   else
      Result := acFilename;
end;
{$endif}
{$ifdef LINUX}
function GetAliasPathAndFileName : string;
var
   i : integer;
begin
   Result := ParamStr( 0 );

   { chop this value at the \ }
   for i := length( Result ) downto 1 do
      if Result[i] = ADS_PATH_DELIMITER then
         break;

   Delete( Result, i, length( Result ) - i + 1 );
   Result := Result + ADS_PATH_DELIMITER + 'ads.ini';

   if ( NOT FileExists( Result ) ) then
   begin
      {*
       * In linux we need to search for the file ourselves, can't just
       * pass TIniFile a base filename and have it do the search like
       * we do in windows. We'll basically do the same search here
       * that linux ace does:
       *
       * 1) current dir (already did that if we got here)
       * 2) environment variable
       * 3) home dir in .ads.ini
       * 4) /etc
       *}
      Result := GetEnvironmentVariable( 'ADSPATH' );
      if ( result <> '' ) then
      begin
         {* Remove slash if it has one. *}
         if ( result[ Length( result ) ] = ADS_PATH_DELIMITER ) then
            delete( result, Length( result ), 1 );

         result := result + '/ads.ini';
         if ( FileExists( result ) ) then
            exit;
      end;

      {* Try the home directory *}
      if ( FileExists( GetEnvironmentVariable( 'HOME' ) + '/.ads.ini' ) ) then
         result := GetEnvironmentVariable( 'HOME' ) + '/.ads.ini'
      else
         result := '/etc/ads.ini';

   end;
end;
{$endif}   {* win32 or linux *}


{**********************************************************
*  Module: GetAliasInfo
*  Input: strAlias -- the alias value to lookup in the .INI file
*  Output strPath  -- the path associated with the alias or '' if the alias
*                     does not exist
*         eTableType -- the table type of the database
*  Return: TRUE if the alias was found and returned, false otherwise
*  Description: Looks up the information for an alias from an ADS.INI
*               file and returns the alias path
**********************************************************}
function GetAliasInfo( strAlias : string; var strPath : string;
                       var eTableType : TAdsTableTypes ) : boolean;
var
   poIniFile : TIniFile;
   sPos : SIGNED16;
begin
{$IFDEF CALLTRACE}
   WriteCallTrace( 'GetAliasInfo' );
{$ENDIF}

   poIniFile := TIniFile.Create( GetAliasPathAndFileName );
   {$IFDEF LINUX}
   poIniFile.CaseSensitive := false;
   {$ENDIF}
   strPath := poIniFile.ReadString( 'Databases', strAlias, '' );
   poIniFile.Free;

   { parse the value stored in strPath to remove the database type }
   sPos := pos( ';', strPath );

   {*
    * Initialize the default driver type to ADT in case driver type isn't found.
    * NOTE: For data dictionary connections the extension will be 'D', and we'll
    * just default to ttAdsADT, since the tabletype will be ignored anyway.
    *}
   eTableType := ttAdsADT;

   if ( sPos <> 0 ) then
   begin
      if ( UpCase( strPath[ sPos+1 ] ) = 'N' ) then
         eTableType := ttAdsNTX
      else if ( UpCase( strPath[ sPos+1 ] ) = 'C' ) then
         eTableType := ttAdsCDX
      else if ( UpCase( strPath[ sPos+1 ] ) = 'V' ) then
         eTableType := ttAdsVFP;


      delete( strPath, sPos, Length( strPath ) );
   end;

   Result := strPath <> '';
end;


{**********************************************************
*  Module:  EADSDatabaseError.GetNativeSQLError
*  Input:  strMsg - Error message
*  Output:
*  Description: Set the NativeSQLError property if the
*     error message passed in is an sql error (7200
*     error).
**********************************************************}
procedure EADSDatabaseError.GetNativeSQLError( strError : string );
var
   iOffset     : integer;
begin

   ulSQLErrorCode := AE_SUCCESS;

   {* Only parse 7200 errors *}
   if ( pos( 'ERROR 7200:', UpperCase( strError ) ) <= 0 ) then
      exit;

   iOffset := pos( 'NATIVEERROR = ', UpperCase( strError ) );
   if ( iOffset = 0 ) then
      exit;

   {* Remove everything before the error code - 'NATIVEERROR =' *}
   Delete( strError, 1, iOffset + 13 );

   {* chop off the string after the error code *}
   iOffset := 1;
   while ( strError[iOffset] <> ';' ) do
      inc( iOffset );

   Delete( strError, iOffset, 6969 );

   {* Finally convert to an integer. *}
   ulSQLErrorCode := StrToInt( strError );

end;



{**********************************************************
*  Module:  EADSDatabaseError.Create
*  Input:  strMsg - Error message
*  Output:
*  Description: Constructor for the exception handler.  Sets
*  a global flag due to the case where multiple exceptions are
*  raised.
**********************************************************}
constructor EADSDatabaseError.Create( oDataSet : TAdsDataSet;
                                      ulErrCode : UNSIGNED32;
                                      const strMsg: String );
var
   iColumnOffset : integer;
begin
{$IFDEF CALLTRACE}
   WriteCallTrace( 'EADSDatabaseError.Create' );
{$ENDIF}

   {*
    * If this next condition is true it's because we generated
    * another exception inside the body of this routine when
    * we were gathering info to fill the error object. To ignore
    * this exception we'll return here, and catch the exception
    * and ignore it in the try/except block below.
    *}
   if ( bExceptionSet = TRUE ) then
      exit;

   {  Set global flag to let everyone know an exception is set }
   bExceptionSet := True;
   ulACEError := ulErrCode;
   try
      try
      {* if oDataSet is not nil then fill the object with some extra info.
       * If it is nil then initialize everything to empty strings. This
       * should be done by Delphi when the object is created but
       * better safe than sorry *}
      if ( oDataSet <> nil ) then
      begin
         strDataSetInstanceName := oDataSet.Name;
         if ( oDataSet.Owner <> nil ) then
            strDataSetInstanceOwner := oDataSet.Owner.Name;
         strDatabaseName := oDataSet.DatabaseName;
         strDatabasePath := oDataSet.GetDatabasePath;
         {* NOTE: if this is a TAdsQuery object then this tablename
          * will be an empty string *}
         strTableName := oDataSet.TableName;
         {* If this is a constraint error let them know which field. *}
         if ( ulACEError = AE_COLUMN_CANNOT_BE_NULL ) or
            ( ulACEError = AE_MAX_CONSTRAINT_VIOLATION ) or
            ( ulACEError = AE_MIN_CONSTRAINT_VIOLATION ) then
         begin
            strColumnName := '';
            {* Look for the string "column \"" *}
            iColumnOffset := pos( 'column "', strMsg );
            if ( iColumnOffset > 0 ) then
            begin
               {* copy from the column to the end of the string. *}
               strColumnName := copy( strMsg, iColumnOffset+8, 900 );
               {* chop it off at the next quote, if there isn't one for some
                * weird reason we'll just get a malformed column *}
               iColumnOffset := pos( '"', strColumnName );
               if ( iColumnOffset > 0 ) then
                  delete( strColumnName, iColumnOffset, 900 );
            end;
         end;
      end
      else
      begin
         strDataSetInstanceName := '';
         strDataSetInstanceOwner := '';
         strDatabaseName := '';
         strDatabasePath := '';
         strTableName := '';
         strColumnName := '';
      end;

      GetNativeSQLError( strMsg );

      except
         {*
          * Ignore all exceptions generated by this routine. We were
          * raised first, so if we generate any exceptions trying to
          * fill our object with information just ignore them and
          * return with as much info as we've gotten so far.
          *}
         on E : Exception do
         begin
         end;
      end;

   finally
      if ( strDataSetInstanceName <> '' ) then
         inherited Create( strDataSetInstanceName + ': ' + strMsg )
      else
         inherited Create( strMsg );

      {*
       * For some reason in Kylix and C++Builder our EADSDatabaseError constructor
       * does not seem to be getting called when in design mode.
       * This means only one exception will show up correctly, then all
       * subsequent exceptions will have blank text. For now just
       * set bExceptionSet to false here.
       *}
      bExceptionSet := FALSE;

   end;

end;

{**********************************************************
*  Module:  EADSDatabaseError.Destroy
*  Input:
*  Output:
*  Description: Destructor for the exception handler.  Sets
*  a global flag due to the case where multiple exceptions are
*  raised.
**********************************************************}
destructor EADSDatabaseError.Destroy;
begin
{$IFDEF CALLTRACE}
   WriteCallTrace( 'EADSDatabaseError.Destroy' );
{$ENDIF}

   {  Unset global flag to let everyone know an exception is not now set }
   bExceptionSet := False;
   inherited Destroy;
end;

{**********************************************************
*  Module:  TAdsDataSet.Create
*  Input: TComponent --- Owner (naming convention specific to Delphi)
*  Output:
*  Description: Constructor for the TAdsDataSet component.
**********************************************************}
constructor TAdsDataSet.Create( AOwner: TComponent );
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.Create' );
{$ENDIF }

   inherited Create( AOwner );

   FACEFieldDefs := TACEFieldDefs.Create( nil );

   {  Initialize the Index Definitions }
   mpoIndexDefs := TIndexDefs.Create( Self );

   {  Initialize and create a TAceDataLink and attach it to the member master link }
   mpoMasterLink := TMasterDataLink.Create( Self );

   {  Initialize the master link event handlers }
   mpoMasterLink.OnMasterChange := MasterChanged;
   mpoMasterLink.OnMasterDisable := MasterDisabled;

   {  Handle gets set with workarea in TAdsDataSet.InternalOpen. }
   mlHandle := INVALID_ACE_HANDLE;
   mlActiveHandle := INVALID_ACE_HANDLE;

   { Initialize Appended EOF and BOF flags to false }
   mbAppendEOF := FALSE;
   mbAppendBOF := FALSE;

   {  Initialize No active index }
   meActiveIndexType := ndxNone;

   {  Initialize default table type to adt }
   meTableType := ttAdsADT;
   musOpenTableType := ADS_ADT;

   {  Initialize various members }
   mstrDatabaseName := '';
   mstrAliasPath := '';
   mbIsSequenced := FALSE;
   meSeqLevel := slStandard;

   {  Initialize and create memory for the Index files }
   mpoIndexFiles := TAdsIndexFiles.Create( self );

   {  Create the table options object }
   mpoAdsTableOptions := TAdsTableOptions.Create;
   mpoAdsTableOptions.SetTableInstance( self );
   mpoAdsTableOptions.AdsRightsCheck := True;
   mpoAdsTableOptions.AdsOptimizedFilters := True;
   mpoAdsTableOptions.AdsIndexPageSize := ADS_DEFAULT;
   mpoAdsTableOptions.AdsRecordCache := rcStandard;
   mpoAdsTableOptions.AdsAOFType := atDynamic;
   mpoAdsTableOptions.AdsAutoKeyFieldCount := False;
   mpoAdsTableOptions.AdsCalcFieldsBeforeFilter := False;
   mpoAdsTableOptions.AdsRecordLockingMode := lmPessimistic;
   mpoAdsTableOptions.AdsPreserveSpaces := False;
   mpoAdsTableOptions.AdsNumericsAsFloats := False;
   mpoAdsTableOptions.AdsCollation := '';
   mpoAdsTableOptions.AdsCachingOption := tcNone;

   {  initialize the setting of the binary field information }
   strBinaryFieldName := '';
   mlBinaryFldLen := 0;

   { indicate that the error message was never displayed }
   mbDisplayedPathNoExistsWarning := FALSE;

   { maintain a list of all TAdsDataSet instances }
   if ( oAdsDatasets = nil ) then
      oAdsDatasets := TThreadList.Create();

   {* Pointer to old record buffer, saved during an edit operation. *}
   FOldRecordBuffer := nil;

   FbStoreActive := TRUE;
   mulSavedCRC := 0;

   oAdsDatasets.Add( self );

end;

{**********************************************************
*  Module:  TAdsDataSet.Destroy
*  Input:
*  Output:
*  Description: Destructor for the TAdsDataSet component.
**********************************************************}
destructor TAdsDataSet.Destroy;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.Destroy' );
{$ENDIF }

   {  Free all list and objects }
   FACEFieldDefs.Free;
   mpoMasterLink.Free;
   mpoIndexDefs.Free;
   mpoIndexFiles.Free;
   mpoAdsTableOptions.Free;

   { In order to handle the on the fly deletions of tables remove the table
     from the connection component if it is connected to one }
   if mpoAdsConnection <> nil then
   begin
      mpoAdsConnection.RemoveTableFromConnectList( self );
      mpoAdsConnection := nil;
   end;

   FreeOldRecordBuffer;

   inherited Destroy;

   if assigned( oAdsDataSets ) then
   begin
      oAdsDatasets.Remove( self );
      with LockAdsDataSetList do
      begin
         try
            Pack;
         finally
            UnlockAdsDataSetList;
         end;
      end;
   end;

end;


{**********************************************************
*  Module:  GetFieldClass
*  Description: Overloaded so we can use our own custom
*    string class that descends from TStringField.
**********************************************************}
function TAdsDataSet.GetFieldClass(FieldType: TFieldType): TFieldClass;
begin
  if ( FieldType = ftString ) then
     result := TAdsStringField
  else if ( FieldType = ftBCD ) then
     result := TAdsBCDField
  else
     result := inherited GetFieldClass( FieldType );
end;


{**********************************************************
*  Module:  FindMatchingParen
*  Input:   pcStr : Character pointer being examined
*           usCurPos : Current position (at open paren)
*           usStrLen : length of pcStr
*
*  Return:  Position of closing paren
*
*  Description: This is used by the parse function to find
*               the paren that matches an opening paren.
*               It skips over string constants in the string.
**********************************************************}
function TAdsDataSet.FindMatchingParen( pcStr : PAceChar;
                                        usCurPos : UNSIGNED16;
                                        usStrLen : UNSIGNED16 ) : UNSIGNED16;
var
   lStrPos : SIGNED32;
   lEndPos : SIGNED32;
   lParens : SIGNED32;
   cMatch  : AceChar;
   pcPos   : PAceChar;

begin
{$IFDEF CALLTRACE}
   WriteCallTrace( 'TAdsDataSet.FindMatchingParen' );
{$ENDIF}

   { initialize return value to current position in case we bail }
   result := usCurPos;

   { If not on an opening paren, just return current position }
   if pcStr[usCurPos] <> '(' then
      exit;

   lStrPos := usCurPos;
   lParens := 0;    { total open paren count - tracks nesting }
   lEndPos := usStrLen;

   repeat
      case pcStr[ lStrPos ] of
         '(':
            { increment the open paren count }
            inc( lParens );

         ')':
            { closing paren - decrement the count }
            dec( lParens );

         '"', '''', '[' :  { the three quote characters }
         begin
            { found opening quote - spin to the closing quote }
            if pcStr[ lStrPos ] = '[' then
               cMatch := ']'
            else
               cMatch := pcStr[ lStrPos ];

            { Find the ending quote }
            pcPos := StrScan( @pcStr[ lStrPos + 1 ], cMatch );

            if pcPos = nil then
               { Did not find closing quote - bail out }
               exit;

            { compute the offset of the located character }
            lStrPos := SIGNED32( pcPos - pcStr );
         end;

      end; { case }

      inc( lStrPos );

   until (( lParens = 0 ) or ( lStrPos >= lEndPos ));


   if lParens = 0 then
      { Found the closing paren - update the return value }
      result := lStrPos - 1;


end;  { FindMatchingParen }



{**********************************************************
*  Module:  ParseFilterExpression
*  Input:   strFilter : Delphi style filter expression which
*                       can have wild card
*
*  Output:  strAdsFilter : ACE filter expression
*           usExact : ACE exact setting in order to have the
*                     filter work the way Delphi expected.
*
*  Description: Parse Delphi filter expression for wild card
*               characters.
*  Note: The character '*' will be considered to be a wild
*        card only if it is the last character in a string
*        constant.
**********************************************************}
procedure TAdsDataSet.ParseFilterExpression( var strAdsFilter : string;
                                             var usExact      : UNSIGNED16 );
var
   ucQuoteChar : AceChar;
   bOpenQuote  : Boolean;
   pcCheckChar : PAceChar;
   pcResultStr : PAceChar;
   usStrLen    : UNSIGNED16;
   usCurrPos   : UNSIGNED16;
   usPosIndex  : UNSIGNED16;
   ulReturnVal : UNSIGNED32;
   strFilter   : AnsiString;
begin
{$IFDEF CALLTRACE}
   WriteCallTrace( 'TAdsDataSet.ParseFilterExpression' );
{$ENDIF}

   usExact := ADS_TRUE;

   {*
    *  Copy the filter string into our working buffer first. In some cases the
    *  expression will get longer not shorter. Example, Field 'A' is the 150th field
    * it gets changed to F150 which is 3 characters longer then an 'A'. Make
    * the rusult string larger just in case there is a lot of short field names
    * in the expression. I chose 50 out of the hat.
    *}
   usStrLen := Length( Filter ) + 1 + 50;
   pcResultStr := AnsiStrAlloc( usStrLen );

   {*
    * For Unicode Delphis, convert the string to UTF8, so we don't lose any
    * Unicode Character literals in parsing.  We'll convert back when we're done.
    *}
{$IFDEF ADSDELPHI2008_OR_NEWER}
   strFilter := AnsiString( UTF8String( Filter ) );
{$ELSE}
   strFilter := AnsiString( Filter );
{$ENDIF}

   if musOpenTableType = ADS_ADT then
   begin
      ulReturnVal := ACEUNPUB.AdsExpressionLongToShort( Handle,
                                                        PAceChar( strFilter ),
                                                        pcResultStr,
                                                        @usStrLen );
      if AE_SUCCESS <>ulReturnVal then
      begin
         strDispose( pcResultStr );
         ACECheck( self, ulReturnVal );
      end;
   end
   else
      StrPCopy( pcResultStr, strFilter );

   {  Loop through each character of the expression looking for special }
   {  character such as *, ', or " }
   bOpenQuote := False;
   ucQuoteChar := ' ';
   usCurrPos := 0;
   while usCurrPos < usStrLen do
   begin

      { Skip over CONTAINS() functions.  They have asterisks in them as wild cards }
      { that need to be kept - the server wants them.  Note - if it's not obvious, }
      { the hard-coded 8 is the length of 'CONTAINS'.   }
      if ( usCurrPos + 8 < usStrLen ) and
         ( AnsiStrLIComp( @pcResultStr[usCurrPos], PAnsiChar( AnsiString( 'CONTAINS' ) ), 8 ) = 0 ) then
      begin
         { It is "contains" - make sure it is the scalar call (look for opening paren) }
         usPosIndex := usCurrPos + 8;
         while ( usPosIndex < usStrLen ) and ( pcResultStr[ usPosIndex ] = ' ' ) do
            inc( usPosIndex );

         if ( usPosIndex < usStrLen ) and ( pcResultStr[ usPosIndex ] = '(' ) then
            { This must be a CONTAINS() call - skip to closing paren }
            usCurrPos := FindMatchingParen( pcResultStr, usPosIndex, usStrLen );

      end;  { if CONTAINS }


      case pcResultStr[ usCurrPos ] of
      '"', '''' :
         if not bOpenQuote then
         begin
            bOpenQuote := True;
            ucQuoteChar := pcResultStr[ usCurrPos ];
         end
         else if bOpenQuote and ( ucQuoteChar = pcResultStr[ usCurrPos ] ) then
            bOpenQuote := False;

        {  Otherwise we have an open quote which is different from the current }
        {  quote character so we ignore this one }

      '*' : {  If the * is the last character before the closing quote, we need to }
            {  verify whether it is a wild card character }
         if bOpenQuote and ( pcResultStr[ usCurrPos + 1 ] = ucQuoteChar ) then
         begin
            {  If there are other character character in string other than *, then }
            {  this * is a while card character.}
            pcCheckChar := @pcResultStr[ usCurrPos - 1];
            while ( pcCheckChar^ <> ucQuoteChar ) and ( pcCheckChar^ = '*' ) do
               dec( pcCheckChar );

            {  If pcStartPos is not locate on the open quote then the literal string }
            {  has other characters }
            if pcCheckChar^ <> ucQuoteChar then
            begin
               {  This is a non-EXACT filter }
               usExact := ADS_FALSE;

               {  Remove the wild card character by shifting everything to the left by 1 }
               {  including the NULL at the end. }
               for usPosIndex := usCurrPos to usStrLen - 1 do
                  pcResultStr[ usPosIndex ] := pcResultStr[ usPosIndex + 1 ];

               {  Since we removed one character, the length of the string is 1 less }
               dec( usStrLen );

               {  The usCurrPos is on the closing quote, the next character we look at }
               {  will not be the closing quote so we close the quote right now. }
               bOpenQuote := False;
            end;
         end;
      end;  { Case pcResultStr[ usCurrPos ] }

      {  Go to next character }
      inc( usCurrPos );
   end;  {  usCurrPos < usStrLne  }

   {  Get our new string }
   strAdsFilter := string( pcResultStr );

   ulReturnVal := AE_SUCCESS;

   {  For ADT table, we have to convert the filter expression back to long expression }
   if musOpenTableType = ADS_ADT then
   begin
      {  Use the same buffer allocated before, it should be enough because we only }
      {  remove characters from the original expression }
      usStrLen := Length( Filter ) + 1 + 50;
      ulReturnVal := ACEUNPUB.AdsExpressionShortToLong( Handle, PAceChar( AnsiString( strAdsFilter ) ),
                                                        pcResultStr, @usStrLen );
   end;

   // For Delphi 2009 & greater, we need to convert the UTF8 string back to Unicode.
   if AE_SUCCESS = ulReturnVal then
{$IFDEF ADSDELPHI2008_OR_NEWER}
      strAdsFilter := UTF8ToUnicodeString( pcResultStr );
{$ELSE}
      strAdsFilter := string( pcResultStr );
{$ENDIF}

   StrDispose( pcResultStr );   {  Free allocated memory }

   ACECheck( self, ulReturnVal );
end;  {  ParseFilterExpression }


{**********************************************************
*  Module:  TAdsDataSet.GetVersionInfo
*  Input:
*  Output:
*  Description: returns version info for display in the
*               Version property
**********************************************************}
function TAdsDataSet.GetVersionInfo : String;
var
   strTDSBuffer    : string;
   strAceString    : string;
   ulMajor         : UNSIGNED32;
   ulMinor         : UNSIGNED32;
   cLetter         : char;
   usLen           : UNSIGNED16;
begin
   strTDSBuffer := adsver.gpcIdAxsVer;
   {* "EsIAx!@#" is at the beginning of the version information, so
    * skip past that string *}
   system.delete( strTDSBuffer, 1, ESIAX_LENGTH );

   {* Get the version of the ACE dll we currently have loaded *}
   usLen := 0;
   ACECheck( self, AdsGetVersion( @ulMajor, @ulMinor, @cLetter, nil, @usLen ) );

   {* The minor version is "out of 100", so if we got back 6, this is version
    * X.06, and if we got back 60 this is version X.60 *}
   if ( ulMinor < 10 ) then
      strAceString := 'ACE ' + inttostr( ulMajor ) + '.0' + inttostr( ulMinor )
   else
      strAceString := 'ACE ' + inttostr( ulMajor ) + '.' + inttostr( ulMinor );
   if ( cLetter <> ' ' ) then
      strAceString := strAceString + cLetter;

   Result := strTDSBuffer + ' (' + strAceString + ')';
end;




{**********************************************************
*  Module:  TAdsDataSet.WriteVersionInfo
*  Input:
*  Output:
*  Description: unresolved. make version property read-only
*               and remove this method
**********************************************************}
{$IFDEF FPC}{$HINTS OFF}{$ENDIF}
procedure TAdsDataSet.WriteVersionInfo( value : string );
begin
   {*
    * no-op. Delphi requires the write method otherwise it
    * won't show the property in the object inspector, but
    * we want it to be there.
    *}
end;
{$IFDEF FPC}{$HINTS ON}{$ENDIF}



{**********************************************************
*  Module:  TAdsDataSet.BuildAOFOptions
*  Input:
*  Output:  options flag that can be used in a call to
*           AdsSetAOF
*  Description:
**********************************************************}
function TAdsDataSet.BuildAOFOptions : UNSIGNED16;
begin
   {* Build the correct options flag *}
   if ( AdsTableOptions.AdsAOFType = atDynamic ) then
      Result := ADS_DEFAULT
   else if ( AdsTableOptions.AdsAOFType = atFixed ) then
      Result := ADS_FIXED_AOF
   else
      Result := ADS_KEYSET_AOF;

   {* Or the options with the resolution type, and call AdsSetAOF *}
   if ( AdsTableOptions.AdsAOFResolveImmediate ) then
      Result := Result or ADS_RESOLVE_IMMEDIATE
   else
      Result := Result or ADS_RESOLVE_DYNAMIC;

{$IFDEF ADSDELPHI2008_OR_NEWER}
   // For Unicode-capable Delphis, send the AOF string as UTF16.
   Result := Result or ADS_ENCODE_UTF16;
{$ENDIF}

end;


{**********************************************************
*  Module:  TAdsDataSet.ActivateFilters
*  Input:
*  Output:
*  Description: A call to instantiate the filters
**********************************************************}
procedure TAdsDataSet.ActivateFilters;
var
   strAdsFilter : string;
   usExact      : UNSIGNED16;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.ActivateFilters' );
{$ENDIF }

   {  If the filter string is blank then deactivate the filters }
   {  This is so that TAdsDataSet compatible with TTable }
   if Filter = '' then
   begin
      DeactivateFilters
   end
   else
   begin
      strAdsFilter := '';
      usExact := Word( False );
      {  Get the actual filter string to use, and the EXACT flag for the filter }
      ParseFilterExpression( strAdsFilter, usExact );
      ACECheck( self, ACE.AdsSetExact22( Handle, usExact ) );

{$IFDEF ADSDELPHI2008_OR_NEWER}
      if ( AdsTableOptions.AdsOptimizedFilters ) then
         ACECheck( self, ACE.AdsSetAOF100( Handle, PWideChar( strAdsFilter ), BuildAOFOptions ) )
      else
         ACECheck( self, ACE.AdsSetFilter100( Handle, PWideChar( strAdsFilter ), ADS_ENCODE_UTF16 ) );
{$ELSE}
      if ( AdsTableOptions.AdsOptimizedFilters ) then
         ACECheck( self, ACE.AdsSetAOF( Handle, PAceChar( AnsiString( strAdsFilter ) ), BuildAOFOptions ) )
      else
         ACECheck( self, ACE.AdsSetFilter( Handle, PAceChar( AnsiString( strAdsFilter ) ) ) );
{$ENDIF}
   end;

end;  {  TAdsDataSet.ActivateFilters }


{**********************************************************
*  Module:  TAdsDataSet.DeactivateFilters
*  Input:
*  Output:
*  Description: A call to undo the filters
**********************************************************}
procedure TAdsDataSet.DeactivateFilters;
var
   ulRetVal : UNSIGNED32;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.Deactivatefilters' );
{$ENDIF }

   {  if AdsOptimizedFilters is true then try to use the optimized filters }
   if ( AdsTableOptions.AdsOptimizedFilters ) then
   begin
      ulRetVal := ACE.AdsClearAOF( Handle );

      {  if there is no filter set that is fine don't raise an exception }
      if (( ulRetVal <> AE_SUCCESS ) And ( ulRetVal <> AE_NO_FILTER )) then
         ACECheck( self, ulRetVal );
   end
   else
   begin
      {  Call clear the filter }
      ulRetVal := ACE.AdsClearFilter( Handle );

      {  if there is no filter set that is fine don't raise an exception }
      if (( ulRetVal <> AE_SUCCESS ) And ( ulRetVal <> AE_NO_FILTER )) then
         ACECheck( self, ulRetVal );
   end;
end;  {  TAdsDataSet.DeactivateFilters }


{**********************************************************
*  Module:  TAdsDataSet.ActivateScope
*  Input:
*  Output:
*  Description: A call to instantiate scopes
**********************************************************}
procedure TAdsDataSet.ActivateScope;
var
   acScope :    array[0..ADS_MAX_KEY_LENGTH - 1] of AceChar;
   usScopeLen : UNSIGNED16;
begin
   {*
    * This function is not Unicode-data safe (for Delphi 2009 & greater).  Using a StringKey
    * with a unicode column will not work at present.  Instead of using a scope, use a Range
    * (via .SetRange) instead, which will build a rawkey.
    *}

{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.ActivateScope' );
{$ENDIF }

   { Make sure an index is selected }
   if Handle = ActiveHandle then
      raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL,
                                      'Cannot activate scope when there is no active index.' );


   { Make sure we do not have a range active }
   usScopeLen := ADS_MAX_KEY_LENGTH;
   if AE_SUCCESS = ACE.AdsGetScope( ActiveHandle, ADS_TOP, @acScope, @usScopeLen ) Then
      raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL,
                                      'Cannot activate scope when there is an active range.' );

   if AE_SUCCESS = ACE.AdsGetScope( ActiveHandle, ADS_BOTTOM, @acScope, @usScopeLen ) Then
      raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL,
                                      'Cannot activate scope when there is an active range.' );

   {  Set the top scope if not blank }
   if ( ScopeStart <> '' ) then
   begin

{$IFDEF ADSDELPHI2008_OR_NEWER }
      usScopeLen := Length( ScopeStart ) * sizeof( WCHAR );
      ACECheck( self, ACE.AdsSetScope( ActiveHandle, ADS_TOP, PAceChar( PWideChar( ScopeStart ) ), usScopeLen,
                                       ADS_WSTRINGKEY ) );
{$ELSE}
      usScopeLen := Length( ScopeStart );
      ACECheck( self, ACE.AdsSetScope( ActiveHandle, ADS_TOP, PAceChar( AnsiString( ScopeStart ) ), usScopeLen,
                                       ADS_STRINGKEY ) );
{$ENDIF}
   end;

   {  Set the bottom scope if not blank }
   if ( ScopeEnd <> '' ) then
   begin
{$IFDEF ADSDELPHI2008_OR_NEWER }
      usScopeLen := Length( ScopeEnd ) * sizeof( WCHAR );
      ACECheck( self, ACE.AdsSetScope( ActiveHandle, ADS_BOTTOM, PAceChar( PWideChar( ScopeEnd ) ), usScopeLen,
                                       ADS_WSTRINGKEY ) );
{$ELSE}
      usScopeLen := Length( ScopeEnd );
      ACECheck( self, ACE.AdsSetScope( ActiveHandle, ADS_BOTTOM, PAceChar( AnsiString( ScopeEnd ) ), usScopeLen,
                                       ADS_STRINGKEY ) );
{$ENDIF}
   end;
end;

{**********************************************************
*  Module:  TAdsDataSet.DeactivateScope
*  Input:
*  Output:
*  Description: A call to undo the scope
**********************************************************}
procedure TAdsDataSet.DeactivateScope;
var
   ulRetVal : UNSIGNED32;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.DeactivateScope' );
{$ENDIF }

   if ( ActiveHandle <> Handle ) then
   begin

      {  Clear the Top Scope }
      ulRetVal := ACE.AdsClearScope( ActiveHandle, ADS_TOP );

      {  if there is no scope set that is fine don't raise an exception }
      if (( ulRetVal <> AE_SUCCESS ) And ( ulRetVal <> AE_NO_SCOPE )) then
         ACECheck( self, ulRetVal );

      {  Clear the Bottom Scope }
      ulRetVal := ACE.AdsClearScope( ActiveHandle, ADS_BOTTOM );

      {  if there is no scope set that is fine don't raise an exception }
      if (( ulRetVal <> AE_SUCCESS ) And ( ulRetVal <> AE_NO_SCOPE )) then
         ACECheck( self, ulRetVal );

   end;
end;

{**********************************************************
*  Module:  TAdsDataSet.LockTable
*  Input:
*  Output:
*  Description: Lock the table.
**********************************************************}
procedure TAdsDataSet.LockTable;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.LockTable' );
{$ENDIF }

   {  if the table is not active or exclusive don't lock the table }
   if ( ( Not Active ) Or ( Exclusive ) )then
      exit;

   {  Lock the table }
   ACECheck( self, ACE.AdsLockTable( Self.Handle ) );
end;

{**********************************************************
*  Module:  TAdsDataSet.UnLockTable
*  Input:
*  Output:
*  Description: UnLock the table.
**********************************************************}
procedure TAdsDataSet.UnLockTable;
var
   ulRetVal : UNSIGNED32;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.UnLockTable' );
{$ENDIF }

   {  if the table is not active or exclusive don't lock the table }
   if ( ( Not Active ) Or ( Exclusive ) ) then
      exit;

   {  Unlock the table but don't raise an exception if the table is already unlocked }
   ulRetVal := ACE.AdsUnLockTable( Self.Handle );
   if ( ( ulRetVal <> AE_SUCCESS ) And ( ulRetVal <> AE_TABLE_NOT_LOCKED ) ) then
      ACECheck( self, ulRetVal );
end;

{**********************************************************
*  Module:  TAdsDataSet.DeleteTable
*  Input:
*  Output:
*  Description: Deletes the table
**********************************************************}
procedure TAdsDataSet.DeleteTable;
var
   hHoldHandle : ADSHANDLE;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.DeleteTable' );
{$ENDIF }

   {  make sure the data set is inactive.  Check inactive will raise exception }
   {  if the table is active }
   CheckInactive;

   {  Since the dataset is inactive we need to reopen the table }
   hHoldHandle := OpenAdvantageFiles;

   {  Delete the table. }
   try
      ACECheck( self, ACEUNPUB.AdsDeleteTable( hHoldHandle ) );
   except
      {* If there was an exception then it is likely the table
       * did not get closed. Try to do so here, but don't worry about errors. *}
      ACE.AdsCloseTable( hHoldHandle );
      raise;
   end;
end;

{**********************************************************
*  Module:  TAdsDataSet.EmptyTable
*  Input:
*  Output:
*  Description: Empty (or zaps) the table.
**********************************************************}
procedure TAdsDataSet.EmptyTable;
var
   hHoldHandle : ADSHANDLE;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.EmptyTable' );
{$ENDIF }

   if Active then
   begin
      {  Make sure we are in browse mode or raise exception }
      CheckBrowseMode;
      {  If the table is active then use the active handle and zap }
      ACECheck( self, ACE.AdsZapTable( self.Handle ) );
      {  Clear all buffers }
      ClearBuffers;
      {  Cause a dataevent to let event handler know that the DataSet has changed }
      DataEvent( deDataSetChange, 0 );
   end
   else
   begin
      hHoldHandle := OpenAdvantageFiles;
      try
         {  Open a temporary table and zap the table }
         ACECheck( self, ACE.AdsZapTable( hHoldHandle ) );
      except
         ACECheck( self, ACE.AdsCloseTable( hHoldHandle ) );
         raise;
      end;
      ACECheck( self, ACE.AdsCloseTable( hHoldHandle ) );
   end;
end;

{**********************************************************
*  Module:  TAdsDataSet.AddIndex
*  Input:    strName : the tag name of the index
*            strFields : the expression for the index
*            poOptions : the options for the index
*  Output:
*  Description: Creates an index for the given table.
**********************************************************}
procedure TAdsDataSet.AddIndex( const strName : string;
                                strFields: string;
                                poOptions: TIndexOptions );
var
   ulOptions :     UNSIGNED32;
   hHoldHandle :   ADSHANDLE;
   hTempIndex :    ADSHANDLE;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.AddIndex' );
{$ENDIF }

   ulOptions := 0;
   {  Only support unique and descending from the TIndexOptions of TDataSet for Ace }
   if ( ixUnique in poOptions ) then
   begin
      if ( TableType = ttAdsVFP ) then
         ulOptions := ADS_CANDIDATE
      else
         ulOptions := ADS_UNIQUE;
   end;

   if ( ixDescending in poOptions ) then
      ulOptions := ulOptions or ADS_DESCENDING;

   {  If the table is a FoxPro table then we need to put the new index into the }
   {  structural CDX }
   if ( TableType = ttAdsCDX ) or ( TableType = ttAdsADT ) or ( TableType = ttAdsVFP ) then
      ulOptions := ulOptions or ADS_COMPOUND;

   if Active then
      hHoldHandle := Handle
   else
      hHoldHandle := OpenAdvantageFiles;

   {  if ixCaseInsensive was specified add the UPPER function to all  }
   {  string fields  }
   if ( ixCaseInsensitive in poOptions ) then
      if ( ixExpression in poOptions ) then
         raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL,
            'ixCaseInsensitive is not supported with ixExpression indexes' )
      else
         AddUpperExpr( hHoldHandle, strFields );

   {  find all semi-colons and replace with plus signs for expression convention
      when using DBFs.  Leave the semi-colon for ADTs
   }
   if ( TableType <> ttAdsADT ) then
      while Pos( ';', strFields ) > 0 do
         strFields[ Pos( ';', strFields ) ] := '+';

   Try
      {  If the table is open use the open handle and create the index }
      if ( TableType = ttAdsCDX ) or ( TableType = ttAdsVFP ) or ( TableType = ttAdsADT ) then
         ACECheck( self, ACE.AdsCreateIndex90( hHoldHandle, nil, PAceChar( AnsiString( strName ) ) ,
                   PAceChar( AnsiString( strFields ) ), nil, nil, ulOptions, mpoAdsTableOptions.AdsIndexPageSize,
                   PAceChar( AnsiString( GetEffectiveCollation() ) ), @hTempIndex ) )
      else
         ACECheck( self, ACE.AdsCreateIndex90( hHoldHandle, PAceChar( AnsiString( strName ) ), nil,
                   PAceChar( AnsiString( strFields ) ), nil, nil, ulOptions, mpoAdsTableOptions.AdsIndexPageSize,
                   PAceChar( AnsiString( GetEffectiveCollation() ) ), @hTempIndex ) );
   Finally

      {  If we open the table locally, then close the table }
      if hHoldHandle <> Handle then
         ACECheck( self, ACE.AdsCloseTable( hHoldHandle ) );
   End;

   mpoIndexDefs.Updated := False;
end;  {  TAdsDataSet.AddIndex }



{**********************************************************
*  Module:  TAdsDataSet.AddIndexEx
*  Input:    strFileName : the name of the index file
*            strIndexName : the name of the tag to create
*            strFields : the expression for the index
*            poOptions : the options for the index
*  Output:
*  Description: Creates an index and lets the user specify the
*    index filename (which is what makes this method different
*    than AddIndex).
**********************************************************}
procedure TAdsDataSet.AddIndexEx( strFileName  : string;
                                  strIndexName : string;
                                  strFields    : string;
                                  poOptions    : TIndexOptions );
var
   ulOptions :     UNSIGNED32;
   hHoldHandle :   ADSHANDLE;
   hTempIndex :    ADSHANDLE;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.AddIndexEx' );
{$ENDIF }

   ulOptions := 0;
   {  Only support unique and descending from the TIndexOptions of TDataSet for Ace }
   if ( ixUnique in poOptions ) then
   begin
      if ( TableType = ttAdsVFP ) then
         ulOptions := ADS_CANDIDATE
      else
         ulOptions := ADS_UNIQUE;
   end;

   if ( ixDescending in poOptions ) then
      ulOptions := ulOptions or ADS_DESCENDING;

   {  If the table is a FoxPro table then we need to put the new index into the }
   {  structural CDX }
   if ( TableType = ttAdsCDX ) or ( TableType = ttAdsVFP ) or ( TableType = ttAdsADT ) then
      ulOptions := ulOptions or ADS_COMPOUND;

   if Active then
      hHoldHandle := Handle
   else
      hHoldHandle := OpenAdvantageFiles;

   {  if ixCaseInsensive was specified add the UPPER function to all  }
   {  string fields  }
   if ( ixCaseInsensitive in poOptions ) then
      if ( ixExpression in poOptions ) then
         raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL,
            'ixCaseInsensitive is not supported with ixExpression indexes' )
      else
         AddUpperExpr( hHoldHandle, strFields );

   {  find all semi-colons and replace with plus signs for expression convention
      when using DBFs.  Leave the semi-colon for ADTs
   }
   if ( TableType <> ttAdsADT ) then
      while Pos( ';', strFields ) > 0 do
         strFields[ Pos( ';', strFields ) ] := '+';

   Try
      {  If the table is open use the open handle and create the index }
      if ( TableType = ttAdsCDX ) or ( TableType = ttAdsVFP ) or ( TableType = ttAdsADT ) then
         ACECheck( self, ACE.AdsCreateIndex90( hHoldHandle, PAceChar( AnsiString( strFileName ) ), PAceChar( AnsiString( strIndexName ) ) ,
                   PAceChar( AnsiString( strFields ) ), nil, nil, ulOptions, mpoAdsTableOptions.AdsIndexPageSize,
                   PAceChar( AnsiString( GetEffectiveCollation() ) ), @hTempIndex ) )
      else
         ACECheck( self, ACE.AdsCreateIndex90( hHoldHandle, PAceChar( AnsiString( strIndexName ) ), nil,
                   PAceChar( AnsiString( strFields ) ), nil, nil, ulOptions, mpoAdsTableOptions.AdsIndexPageSize,
                   PAceChar( AnsiString( GetEffectiveCollation() ) ), @hTempIndex ) );
   Finally

      {  If we open the table locally, then close the table }
      if hHoldHandle <> Handle then
         ACECheck( self, ACE.AdsCloseTable( hHoldHandle ) );
   End;

   mpoIndexDefs.Updated := False;
end;  {  TAdsDataSet.AddIndexEx }



{**********************************************************
*  Module:  TAdsDataSet.DeleteIndex
*  Input:  strName - string of the index name to delete
*  Output:
*  Description: Delete the specified index.  Must be the tag
*  name of the index.
**********************************************************}
procedure TAdsDataSet.DeleteIndex( const strName: string );
var
   hHoldHandle : ADSHANDLE;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.DeleteIndex' );
{$ENDIF }

   {  Make sure the table is open and exclusive.  Compatibility with TTable }
   if ( Not ( Active and Exclusive ) ) then
      raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL,
                                      'Table must be Active and Exclusive.' );

   {  Get the Index handle }
   ACECheck( self, ACE.AdsGetIndexHandle( Handle, PAceChar( AnsiString( strName ) ), @hHoldHandle ) );

   {  Make sure that this is not trying to delete the active index }
   {  Compatibility with TTable }
   if hHoldHandle = ActiveHandle then
      raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL,
                                      'Cannot delete the active index!' );

   {  Delete the Index }
   ACECheck( self, ACE.AdsDeleteIndex( hHoldHandle ) );
   mpoIndexDefs.Updated := False;
end;

{**********************************************************
*  Module:  TAdsDataSet.SetDatabaseName
*  Input:   strValue : String that is the database path
*  Output:
*  Description: Sets the database name for the table
*  Note: if the value passed in does not contain a \
*        then it is assumed an alias.
**********************************************************}
procedure TAdsDataSet.SetDatabaseName( strValue: String );
var
   lPos : SIGNED32;
   eTableType : TAdsTableTypes;
   strAliasPath : string;
   iIndex : Integer;
   poAdsConnect : TAdsConnection;
begin
{$IFDEF CALLTRACE}
   WriteCallTrace( 'TAdsDataSet.SetDatabaseName' );
{$ENDIF}

   strAliasPath := '';
   eTableType := ttAdsNTX;

   {  If the table is open raise the exception }
   if Active then
      raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL,
                                      'Cannot perform this operation on an open dataset' );

   {  clear the value so that a warning may be displayed again in GetFiles}
   mbDisplayedPathNoExistsWarning := FALSE;

   {  Find out the length of the string }
   lPos := Length( strValue );

   {  if the length is zero means it is being nulled out set empty string and exit }
   if ( lPos = 0 ) then
   begin
      mstrDatabaseName := strValue;
      mstrAliasPath := '';
      GetDataBasePath;  { this will copy the connections table type if need be }
      exit;
   end;

   {
      first check if this is an AdsConnection Component
   }
   if ( GetConnectionList <> nil ) then
   begin
      { iterate through all components and check the name, owner, & threadID }
      {*
       * First search for a connection with the same name,
       * the same owner, and the same threadID as us
       *}
      with LockConnectionList do
      begin
         try
         for iIndex := 0 to Count - 1 do
            begin
               poAdsConnect := TAdsConnection( Items[ iIndex ] );
               if ( UpperCase( strValue ) = UpperCase( poAdsConnect.Name ) ) and
               ( self.owner = poAdsConnect.owner ) and
               ( GetThreadID = poAdsConnect.ConnectionThreadID ) then
               begin
                  mstrDatabaseName := strValue;
                  mstrAliasPath := '';
                  { this routine does all of the busy work }
                  SetAdsConnection( poAdsConnect );
                  exit;
               end;
            end;

            {*
             * Next check for same name and same threadID
             *}
            for iIndex := 0 to Count - 1 do
            begin
               poAdsConnect := TAdsConnection( Items[ iIndex ] );
               if ( UpperCase( strValue ) = UpperCase( poAdsConnect.Name ) ) and
               ( GetThreadID = poAdsConnect.ConnectionThreadID ) then
               begin
                  mstrDatabaseName := strValue;
                  mstrAliasPath := '';
                  { this routine does all of the busy work }
                  SetAdsConnection( poAdsConnect );
                  exit;
               end;
            end;

            {*
             * Next check for same name and same owner.
             *}
            for iIndex := 0 to Count - 1 do
            begin
               poAdsConnect := TAdsConnection( Items[ iIndex ] );
               if ( UpperCase( strValue ) = UpperCase( poAdsConnect.Name ) ) and
               ( self.owner = poAdsConnect.owner ) then
               begin
                  mstrDatabaseName := strValue;
                  mstrAliasPath := '';
                  { this routine does all of the busy work }
                  SetAdsConnection( poAdsConnect );
                  exit;
               end;
            end;

            {*
             * If we haven't found a complete match yet, just search for
             * a connection with the same name (last resort).
             *}
            for iIndex := 0 to Count - 1 do
            begin
               poAdsConnect := TAdsConnection( Items[ iIndex ] );
               if ( UpperCase( strValue ) = UpperCase( poAdsConnect.Name ) ) or
                  ( ( poAdsConnect.Owner <> nil ) and ( UpperCase( strValue ) =
                    UpperCase( poAdsConnect.Owner.Name + '.' + poAdsConnect.Name ) ) ) then
               begin
                  mstrDatabaseName := strValue;
                  mstrAliasPath := '';
                  { this routine does all of the busy work }
                  SetAdsConnection( poAdsConnect );
                  exit;
               end;

            end; { for }
         finally
            UnlockConnectionList;
         end;   { try/finally }
      end;   { with LockConnectionList }

   end; { if a list exists }


   {
     is this a path or an alias -- if it does not have a slash then it is assumed
     an alias
   }
   if not SlashInStr( strValue ) then
   begin
      {
        it is an alias if an alias exists with that name, otherwise it could
        be a relative path
      }
      if ( GetAliasInfo( strValue, strAliasPath, eTableType ) ) then
      begin
         { it is an alias }
         mstrDatabaseName := strValue;
         mstrAliasPath := strAliasPath;
         TableType := eTableType;
         exit;
      end;
   end;

   {  strValue must contain a path }
   {  set the object member value of the value passed in }
   mstrDatabaseName := strValue;
   mstrAliasPath := '';
end;


{**********************************************************
*  Module:  TAdsDataSet.GetFiles
*  Description: Get tables in the Databasename dir
**********************************************************}
procedure TAdsDataSet.GetFiles( var poCurrList : TStringList );
var
   lFindHandle       : SIGNED32;
   strFileName       : String;
   strMask           : String;
   hConn             : ADSHANDLE;
   ulRetVal          : UNSIGNED32;
   usLen             : UNSIGNED16;
   acFile            : array[0..ADS_MAX_PATH] of AceChar;
   strPathAndMask    : String;
   bForcedConnection : Boolean;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'GetFiles' );
{$ENDIF }

   bForcedConnection := FALSE;
   lFindHandle       := 0;
   hConn             := 0;

   { if no directory name is provided, skip the check }
   strPathAndMask := GetNativeDatabasePath;
   if ( strPathAndMask = '' ) then
      exit;

   if ( TableType = ttAdsADT ) then
      strMask := '*.adt'
   else
      strMask := '*.dbf';

   try
      {*
       * Verify we have a connection, if not then get one.
       *}
      if Assigned( AdsConnection ) then
      begin
         if not AdsConnection.IsConnected then       // NOTE: This will change the TAdsConnection IsConnected property to true
            AdsConnection.IsConnected := TRUE;       //       and leave it that way, even once we're finished. Seems goofy, but
                                                     //       that's how TDatabase behaves as well.
         hConn := AdsConnection.ConnectionHandle;
      end
      else
      begin
         hConn := GetAceConnectionHandle;
         if ( hConn = 0 ) then
         begin
            {*
             * Just use a normal connect here, vs. an AdsConnect60. Since this dataset is not
             * connected to an AdsConnection component we know we shouldn't be getting a
             * data dictionary connection, because we force the use of a TAdsConnection
             * components when using the data dictionary.
             *}
            ACECheck( self, AdsConnect( PAceChar( AnsiString( GetDatabasePath ) ), @hConn ) );
            bForcedConnection := TRUE;
         end;
      end;

      {* Verify we got a connection handle *}
      if (( hConn = 0 ) or ( hConn = INVALID_ACE_HANDLE )) then
         raise EADSDatabaseError.Create( self, AE_TADSDATASET_GENERAL, 'Internal error getting connection handle' );

      strPathAndMask := strPathAndMask + ADS_PATH_DELIMITER + strMask;

      {*
       * If this dataset is attached to a TAdsConnection component, and that component
       * is on a dictionary connection, then modify the pathmask. Sending an empty string
       * signals FindFirstFile that this is a dictionary.
       *}
      if Assigned( AdsConnection ) then
         if AdsConnection.IsDictionaryConn then
            strPathAndMask := '';

      {  Find the first file in the passed in subdirectory }
      usLen := ADS_MAX_PATH;
      ulRetVal := AdsFindFirstTable( hConn, PAceChar( AnsiString( strPathAndMask ) ), @acFile, @usLen, @lFindHandle );
      if ( ulRetVal <> AE_SUCCESS ) and ( ulRetVal <> AE_NO_FILE_FOUND ) then
         ACECheck( self, ulRetVal );

      {  while more files found, add them to the StringList }
      while ( ulRetVal <> AE_NO_FILE_FOUND ) do
      begin
         strFileName := string( StrPas( acFile ) );
         poCurrList.Add( strFileName );
         usLen := ADS_MAX_PATH;
         ulRetVal := AdsFindNextTable( hConn, lFindHandle, @acFile, @usLen );
         if ( ulRetVal <> AE_SUCCESS ) and ( ulRetVal <> AE_NO_FILE_FOUND ) then
            ACECheck( self, ulRetVal );
      end;

   finally
      if lFindHandle <> 0 then
         ACECheck( self, AdsFindClose( hConn, lFindHandle ) );

      if bForcedConnection then
         ACECheck( self, AdsDisconnect( hConn ) );

   end;   {* try/finally block *}

end;


{**********************************************************
*  Module:  TAdsDataSet.GetDatabasePath
*  Input:
*  Output: return the database name
*  Description: returns the database name for the table, which
*               is either the value stored in mstrDatabaseName,
*               referenced by the alias stored in mstrDatabaseName,
*               or, if mstrDatabaseName is blank, stored in the
*               connection component.
**********************************************************}
function TAdsDataSet.GetDatabasePath : String;
var
   eType : TAdsTableTypes;
   lPos : SIGNED32;
   bIsConnection : boolean;

begin
{$IFDEF CALLTRACE}
   WriteCallTrace( 'TAdsDataSet.GetDatabasePath : String' );
{$ENDIF}

   Result := '';
   bIsConnection := FALSE;
   eType := ttAdsNTX;

   if mstrAliasPath <> '' then
      Result := mstrAliasPath
   else
   begin
      if ( mstrDatabaseName = '' ) then
         bIsConnection := TRUE
      else
         { it could be the name of a connection component }
         if ( mpoAdsConnection <> nil ) and
            (( UpperCase( mstrDatabaseName ) = UpperCase( mpoAdsConnection.Name )) or
             ( ( mpoAdsConnection.Owner<> nil ) and ( UpperCase( mstrDatabaseName ) =
               UpperCase ( mpoAdsConnection.Owner.Name + '.' + mpoAdsConnection.Name ))) ) then
            bIsConnection := TRUE;

      if bIsConnection then
      begin
         if ( mpoAdsConnection <> nil ) then
         begin
            Result := mpoAdsConnection.GetConnectionPath;

            { retrieve the table type }
            case mpoAdsConnection.GetAdsTableType of
               ttAdsConnectADT : if ( TableType <> ttAdsADT ) then TableType := ttAdsADT;
               ttAdsConnectNTX : if ( TableType <> ttAdsNTX ) then TableType := ttAdsNTX;
               ttAdsConnectCDX : if ( TableType <> ttAdsCDX ) then TableType := ttAdsCDX;
               ttAdsConnectVFP : if ( TableType <> ttAdsVFP ) then TableType := ttAdsVFP;
               ttAdsConnectUnspecified : { do nothing }
            end;
         end;
      end
      else
         begin
            { the mstrDatabaseName contains either the database path or an alias }
            { a database path must contain at least one backslash }
            if SlashInStr( mstrDatabaseName ) then
               Result := mstrDatabaseName
            else
            begin
               if GetAliasInfo( mstrDatabaseName, Result, eType ) then
               begin
                  { it is an alias }
                  mstrAliasPath := Result;
                  if ( TableType <> eType ) then TableType := eType;
               end
               else
                  { it is not an alias, assume that it is a database path }
                  Result := mstrDatabaseName;
            end
         end
   end;

   {  strValue must contain a path if the last character is a slash remove it }
   {  unless it's a lone slash, in that case we'll keep it around             }
   lPos := Length( Result );
   if ( ( lPos > 0 ) and ( IsSlash( Result[ lPos ] ) ) and ( lPos <> 1 ) ) then
      System.Delete( Result, lPos, 1 );

end;



{$IFDEF LINUX}
{**********************************************************
*  Module:  TAdsDataSet.ResolveUNCServerName
*  Input:   server name to look up
*  Output:  replacement path for the server name
*  Description: Look in ads.ini for a server name and get
*               the path associated with that server name
*               Only do this if the servername isn't the
*               same as the machine we're running on.
**********************************************************}
function ResolveUNCServerName( strServer : string ) : string;
var
   oIniFile : TIniFile;
   strTemp  : string;
   acHost   : array[0..ADS_MAX_PATH] of AceChar;
   iIndex   : integer;
begin
   Result := '/';

   {* If the server in question is the machine we are on then just
    * return "/" *}
   GetHostName( acHost, ADS_MAX_PATH );
   {* If we got a host name like "ibm.extendsys.com" then remove the domain *}
   iIndex := pos( '.', string(acHost) );
   if ( iIndex > 0 ) then
      acHost[iIndex-1] := #0;

   {* See if this is the machine we're running on. *}
   if ( CompareText( string( acHost ), strServer ) = 0 ) then
      exit;

   oIniFile := TIniFile.Create( GetAliasPathAndFileName );
   if not assigned( oIniFile ) then
      exit;

   {$IFDEF ADSDELPHI6_OR_NEWER}
   oIniFile.CaseSensitive := false;
   {$ENDIF}

   {* We found the file, now look for this key *}
   try
      strTemp := oIniFile.ReadString( 'REPLACE_UNC_SERVER', strServer, 'not_found' );
      if ( strTemp = 'not_found' ) then
         exit
      else
      begin
         Result := strTemp;
         {* Always return a string with a slash on the end *}
         if ( Result[ Length( Result ) ] <> ADS_PATH_DELIMITER ) then
            Result := Result + ADS_PATH_DELIMITER;
      end;

   finally
      FreeAndNil( oIniFile );
   end;

end;  {* ResolveUNCServerName *}
{$ENDIF}



{**********************************************************
*  Module:  TAdsDataSet.GetNativeDatabasePath
*  Input:
*  Output:  native path to database dir, if linux it
*           converts unc to an absolute path.
*  Description:
**********************************************************}
function TAdsDataSet.GetNativeDatabasePath : String;
{$IFDEF LINUX}
var
   lPos        : SIGNED32;
   i           : integer;
   strTemp     : string;
   strServer   : string;
{$ENDIF}
begin
{$IFDEF CALLTRACE}
   WriteCallTrace( 'TAdsDataSet.GetNativeDatabasePath : String' );
{$ENDIF}

   Result := GetDatabasePath;

   {$IFDEF LINUX}
   {* If UNC remove (or replace) the server name, and convert all \ to / *}
   if ( Length( Result ) > 3 ) and
      ( ( Result[1] = '\' ) or ( Result[1] = '/' ) ) and
      ( ( Result[2] = '\' ) or ( Result[2] = '/' ) ) then
   begin
      {* axe the first two slases *}
      system.Delete( result, 1, 2 );

      strTemp := copy( result, 1, 6900 );

      {* Find out where the path part starts. *}
      lPos := pos( '\', strTemp );
      if ( lPos <= 0 ) then
         lPos := pos( '/', strTemp );
      if ( lPos <= 0 ) then
         exit;

      {* Get the server name *}
      strServer := Copy( Result, 1, lPos - 1 );
      Result := ResolveUNCServerName( strServer );

      {* ResolveUNCServerName always returns a string with a slash on the end, so now
       * we can just append the rest of the path. *}
      Result := Result + Copy( strTemp, lPos + 1, 6900 );

      {* now change any \ to / *}
      for i := 1 to Length( Result ) do
         if ( Result[i] = '\' ) then
            Result[i] := '/';

      {* And finally remove a trailing slash if it exists. *}
      if ( Result[ Length( Result ) ] = ADS_PATH_DELIMITER ) then
         system.Delete( Result, Length( Result ), 1 );

   end;
   {$ENDIF}
end;


{**********************************************************
*  Module:  TAdsDataSet.CloseTableAndIndex
*  Input:  hHandle - handle to close
*  Output:
*  Description: Closes the table and the associated indexes
**********************************************************}
procedure TAdsDataSet.CloseTableAndIndexes( hHandle : ADSHANDLE );
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.CloseTableAndIndexes' );
{$ENDIF }

   ACECheck( self, ACE.AdsCloseTable( hHandle ) );
end;


{*******************************************************************************
*  Module:  TAdsDataSet.ConnectAndGetHandle
*  Output:  ace connection handle
*  Description: Get a connection handle for this table or query
*******************************************************************************}
function TAdsDataSet.ConnectAndGetHandle : ADSHANDLE;
var
   strPath : string;
begin
   if Assigned( AdsConnection ) then
   begin
      if Not AdsConnection.IsConnected then
         AdsConnection.IsConnected := True;
      Result := AdsConnection.ConnectionHandle;
   end
   else
   begin
      {*
       * If no connection was explicitly assigned then try to find one
       * in our list of dynamically created connections (connections
       * we've created ourselves on behalf of the dataset object).
       *}

      { If this is just a drive letter colon, add a backslash to it. }
      { NOTE: Not sure about this logic, modified it to only happen if }
      {       there is actually a colon. At least now it won't happen  }
      {       for short paths like "/" in linux.                       }
      strPath := GetDatabasePath;
      if ( ( Length( strPath ) < 3 ) and
           ( Length( strPath ) > 1 ) and
           ( strPath[2] = ':' ) ) then
         strPath := strPath + ADS_PATH_DELIMITER;

      { find an existing connection }
      Result := goDynamicConnList.FindSameDatabasename( strPath );
      if ( Result = 0 ) then
         {* we didn't find one, so add one *}
         Result := goDynamicConnList.Add( strPath );
   end;
end;


{**********************************************************
*  Module:  TAdsDataSet.OpenIndexFile
*  Input: strIndexName : string of the index name to open
*  Output:
*  Description: Opens the specified index file in the specific
*  database directory
**********************************************************}
procedure TAdsDataSet.OpenIndexFile( const strIndexName: string );
var
   phIndexArray   : PADSHandleArray;
   usArrayLen     : UNSIGNED16;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.OpenIndexFile' );
{$ENDIF }

   if Not Active then
      raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL, 'Table must be Active.' );

   usArrayLen := ARRAY_NDX;
   {  If only the basename is given, then we pre-pend the basename with the }
   {  DatabaseName.  Otherwise, assume fullname is given }
{$IFDEF FPC}
   phIndexArray := nil;
{$ENDIF}
   GetMem( phIndexArray, usArrayLen * sizeof( ADSHANDLE )  );
   try

      if not SlashInStr( strIndexName ) then
      begin
         {  Open the index with the specified name }
         ACECheck( self, ACE.AdsOpenIndex( Handle, PAceChar( AnsiString( GetDatabasePath + ADS_PATH_DELIMITER + strIndexName ) ),
                                     @( phIndexArray[0] ), @usArrayLen ) );
      end
      else
      begin
         {  Open the index with the specified name }
         ACECheck( self, ACE.AdsOpenIndex( Handle, PAceChar( AnsiString( strIndexName ) ), @( phIndexArray[0] ), @usArrayLen ) );
      end;

   finally
      FreeMem( phIndexArray );
   end;

   mpoIndexDefs.Updated := FALSE;

end;

{**********************************************************
*  Module:  TAdsDataSet.CloseIndexFile
*  Input: IndexName : string of the index name to close
*  Output:
*  Description: Closes the specified index file in the specific
*  database directory
**********************************************************}
procedure TAdsDataSet.CloseIndexFile( const strIndexName: string );
var
   sArrayCount          : SIGNED16;
   phIndexArray         : PADSHandleArray;
   usArrayLength, usNameLength : UNSIGNED16;
   acFileName           : array[0..ADS_MAX_PATH] of AceChar;
   strIndexFileName     : String;
   bActiveIndexInFile   : boolean;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.CloseIndexFile' );
{$ENDIF }

   if Not Active then
      raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL, 'Table must be Active.' );

   strIndexFileName := ExtractFileName( strIndexName );

   {  Determine whether we should set to natural order after closing the file }
   bActiveIndexInFile := False;
   if ActiveHandle <> Handle then
   begin
      usNameLength := ADS_MAX_PATH;
      ACECheck( self, ACE.AdsGetIndexFileName( ActiveHandle, ADS_BASENAMEANDEXT,
                                         @acFileName, @usNameLength ) );

      if UpperCase( strIndexFileName ) = UpperCase( string( StrPas( acFileName ) ) ) then
         bActiveIndexInFile := True;
   end;

   {  Get all of the open indexes into an array }
   ACECheck( self, ACE.AdsGetNumIndexes( self.Handle, @usArrayLength ) );
{$IFDEF FPC}
   phIndexArray := nil;
{$ENDIF}
   GetMem( phIndexArray, usArrayLength * sizeof( ADSHANDLE )  );

   try

      ACECheck( self, ACE.AdsGetAllIndexes( self.Handle, @( phIndexArray[0] ), @usArrayLength ) );

      {  Loop through the index array }
      for sArrayCount := 0 to usArrayLength -1 do
      begin
         usNameLength := ADS_MAX_PATH;

         {  Get the individual index file name and compare it to the file name passed in }
         ACECheck( self, ACE.AdsGetIndexFileName( phIndexArray[sArrayCount], ADS_BASENAMEANDEXT,
                   @acFileName, @usNameLength ) );

         if UpperCase( strIndexFileName ) = UpperCase( string( StrPas( acFileName ) ) ) then
         begin
            {  with the index handle close the index }
            ACECheck( self, ACE.AdsCloseIndex( phIndexArray[sArrayCount] ) );

            if bActiveIndexInFile then
               IndexName := '';

            {  Only need to close once so break out }
            break;

         end;
      end;
   finally

      Dispose( phIndexArray );

   end; {* Try *}

end;  {  TAdsDataSet.CloseIndexFile }

{**********************************************************
*  Module:  TAdsDataSet.SetExclusive
*  Input: bValue : Boolean
*  Output:
*  Description: Sets the exclusive flag if no one else is to
*  touch the table
**********************************************************}
procedure TAdsDataSet.SetExclusive( bValue: Boolean );
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.SetExclusive' );
{$ENDIF }

  {  Make sure the table is not active }
  CheckInactive;

  {  Set value }
  mbExclusive := bValue;
end;

{**********************************************************
*  Module:  TAdsDataSet.GetCurrentKeySize
*  Input:
*  Output:
*  Return:  UNSIGNED16 - Returns Current key size
*  Description: Gets the size of the current key
**********************************************************}
function TAdsDataSet.GetCurrentKeySize : UNSIGNED16;
var
   usSize : UNSIGNED16;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.GetCurrentKeySize' );
{$ENDIF }

   {  make sure an index has been set }
   if ActiveHandle = Handle then
   begin
      Result := 0;
      exit;
   end;

   {  get the key size of the current index and return it in the result }
   ACECheck( self, ACE.AdsGetKeyLength( ActiveHandle, @usSize ) );
   Result := usSize;
end;



{**********************************************************
*  Module:  TAdsDataSet.UpdateDefaultIndex
*  Input:
*  Output:
*  Description: Sets the default index if this is a table
*      on a dictionary connection. This is currently called
*      when the tablename is set and also when the connection
*      goes active. A call when the connection goes active
*      is necessary because when the form is loading the
*      table may be loaded before the connection, which would
*      have made the first call to this function do nothing.
*      When it's called the second time the connection will
*      be active and this will refresh the indexname.
**********************************************************}
procedure TAdsDataSet.UpdateDefaultIndex;
var
   ulRetVal        : UNSIGNED32;
   aucDefaultIndex : array [0..ADS_DD_MAX_OBJECT_NAME_LEN] of AceChar;
   usLen           : UNSIGNED16;
begin

   {* Don't do this for TAdsQuery objects *}
   if self is TAdsQuery then
      exit;

   {* If this is a dictionary connection then set the default index *}
   if ( mpoAdsConnection <> nil ) then
   begin
      if ( mpoAdsConnection.IsDictionaryConn ) then
      begin
         usLen := ADS_DD_MAX_OBJECT_NAME_LEN;
         ulRetVal := ACE.AdsDDGetTableProperty( mpoAdsConnection.ConnectionHandle,
                                                PAceChar( AnsiString( mstrTableName ) ),
                                                ADS_DD_TABLE_DEFAULT_INDEX,
                                                @aucDefaultIndex,
                                                @usLen );
         {* Either set the property or clear it, ignore any other errors *}
         if ( ( ulRetVal = AE_SUCCESS ) or ( ulRetVal = AE_PROPERTY_NOT_SET ) ) then
         begin
            if ( ulRetVal = AE_PROPERTY_NOT_SET ) then
            begin
               if ( IndexName = 'ADS_DEFAULT' ) then
                  IndexName := '';
            end
            else
            begin
               {* Save the default index name no matter what. It will be used in the IndexName
                * property editor to determine if there is a default index assigned to this table. *}
               mstrDefaultIndex := string( aucDefaultIndex );

               {* If the stored value in the form was ADS_DEFAULT, or if the IndexName property is
                * empty and we're not loading from a dfm (which means this is the first time this
                * table has ever been created) we'll assign the default index as the active index. *}
               if ( ( IndexName = 'ADS_DEFAULT' ) or
                    ( IndexName = '' ) and not ( csLoading in componentstate ) ) then
               begin
                  meActiveIndexType := ndxDefault;
                  mstrIndexName := 'ADS_DEFAULT';
               end;
            end;
         end;

      end;  {* If IsDictionaryConn *}
   end;

end;



{**********************************************************
*  Module:  TAdsDataSet.SetTableName
*  Input:  strValue : String of the table name to set
*  Output:
*  Description: Sets the table name for the table name property
**********************************************************}
procedure TAdsDataSet.SetTableName( strValue: String );
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.SetTableName' );
{$ENDIF }
   {  If the table is open raise the exception }
   if Active then
      raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL,
                                      'Cannot perform this operation on an open dataset' );

   {  If any index files were associated remove them.  Make sure we don't remove them }
   {  if we are in the middle of streaming in data to them if the component is trying }
   {  to populate values for properties.  Also only clear index files if we change the }
   {  table name }
   if ( Not ( csReading in ComponentState ) ) and
      ( mstrTableName <> strValue ) then IndexFiles.Clear;

   mstrTableName := strValue;

   {* See if this is a dictionary table, and if so set its default index. *}
   UpdateDefaultIndex;

   {  This is to send a message to TDataSet property change event.  This inparticular }
   {  causes the FieldDefs to update themselves }
   DataEvent( dePropertyChange, 0 );
end;

{**********************************************************
*  Module:  TAdsDataSet.SetTableType
*  Input: eValue : eTableType
*  Output:
*  Description: Sets the appropriate table type for the property
**********************************************************}
procedure TAdsDataSet.SetTableType( eValue: TAdsTableTypes );
var
   eType : TAdsTableTypes;
   strAliasPath : string;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.SetTableType' );
{$ENDIF }

   {  If the table is active raise an exception }
   if Active then
      raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL,
                                      'Cannot perform this operation on an open dataset' );

   strAliasPath := '';
   eType := ttAdsNTX;

   { ensure that the table type does not differ from that of an alias }
   if ( DatabaseName <> '' ) then
   begin
      { the mstrDatabaseName contains either the database path or an alias }
      { a database path must contain at least one slash }
      if not SlashInStr( DatabaseName ) then
         { it could be an alias, look it up }
         if GetAliasInfo( DatabaseName, strAliasPath, eType ) then
            if eType <> eValue then
               raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL,
               'The table type must remain identical to the table type associated with the alias.' );
   end
   else { it is empty, maybe there is a TAdsConnection and it has an alias }
   begin
      if ( AdsConnection <> nil ) then
         { retrieve the table type }
         if (( AdsConnection.GetAdsTableType = ttAdsConnectADT ) and
             ( eValue <> ttAdsADT )) or
            (( AdsConnection.GetAdsTableType = ttAdsConnectNTX ) and
             ( eValue <> ttAdsNTX )) or
            (( AdsConnection.GetAdsTableType = ttAdsConnectCDX ) and
             ( eValue <> ttAdsCDX )) or
            (( AdsConnection.GetAdsTableType = ttAdsConnectVFP ) and
             ( eValue <> ttAdsVFP )) then
            raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL,
            'The table type must remain identical to the table type associated with the alias.' );
   end;

   { change the table type }
   meTableType := eValue;

   {  Take the enumerated type and set the Objects mlOpenTableType. }
   {  mlOpenTableType can be used now for any index specific operations }
   {  Assured it will change any time the developer changes the enumerated type }
   if meTableType = ttAdsCDX then
      musOpenTableType := ADS_CDX
   else if meTableType = ttAdsNTX then
      musOpenTableType := ADS_NTX
   else if meTableType = ttAdsVFP then
      musOpenTableType := ADS_VFP
   else
      musOpenTableType := ADS_ADT;
end;


{**********************************************************
*  Module:  TAdsDataSet.SetIndexFieldNames
*  Input: strValue : string for the index field names associated to the expression
*  Output:
*  Description: Sets the index field names and gets the index handle
**********************************************************}
procedure TAdsDataSet.SetIndexFieldNames( const strValue: string );
var
   strTrimValue : String;
   strTempValue : String;
   eTempIndexType : TAdsIndexTypes;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.SetIndexFieldNames' );
{$ENDIF }

   if Active then
      CheckBrowseMode;

   {  Make sure that the developer clears the scope before changing the index }
   if Scoped then
      Scoped := False;

   {  make sure passed in expression is compact and no spaces }
   if strValue <> '' then
      strTrimValue := AllTrim( strValue )
   else
      strTrimValue := '';

   {  store previous Index name and Active index type in case of an exception }
   strTempValue := mstrIndexFieldNames;
   eTempIndexType := meActiveIndexType;

   {  set the data member with the passed in value }
   mstrIndexFieldNames := strTrimValue;

   {  Due to mutual exclusion we need to blank out IndexName }
   mstrIndexName := '';

   if strTrimValue = '' then
      {  If the index is blank then we are setting index type to natural order }
      meActiveIndexType := ndxNone
   else
      {  We are setting this index type to Index field }
      meActiveIndexType := ndxIndexField;

   if self.handle = INVALID_ACE_HANDLE then
      exit;

   try
      {  Switch the index handle }
      SwitchToIndex;
   except
      mstrIndexFieldNames := strTempValue;
      meActiveIndexType := eTempIndexType;
      raise;
   end;

   {  Resync all controls }
   if Active then
      Resync( [] );
end;

{**********************************************************
*  Module:  TAdsDataSet.SetIndexName
*  Input: strValue : string of the index name to set
*  Output:
*  Description: Sets the index name and gets the index handle
**********************************************************}
procedure TAdsDataSet.SetIndexName( const strValue: string );
var
   strTempValue : String;
   eTempIndexType : TAdsIndexTypes;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.SetIndexName' );
{$ENDIF }

   if Active then
      CheckBrowseMode;

   {  store previous Index name and Active index type in case of an exception }
   strTempValue := mstrIndexName;
   eTempIndexType := meActiveIndexType;

   {  set the data member with the passed in value }
   mstrIndexName := strValue;

   {  Due to mutual exclusion we need to blank out IndexField }
   mstrIndexFieldNames := '';

   if strValue = '' then
      {  If the index is blank then we are setting index type to natural order }
      meActiveIndexType := ndxNone
   else
      {  We are setting this index type to Index Name }
      meActiveIndexType := ndxIndexName;

   {* set to default index value if that's what was asked for. *}
   if ( UpperCase( strValue ) = 'ADS_DEFAULT' ) then
      meActiveIndexType := ndxDefault;

   if self.handle = INVALID_ACE_HANDLE then
      exit;

   try

      {  Make sure that the developer clears the scope before changing the index }
      if Scoped then
         Scoped := False
      else
         ResetCursorRange;   { Clear range if one has been set }

      {  Switch the index handle }
      SwitchToIndex;
   except
      mstrIndexName := strTempValue;
      meActiveIndexType := eTempIndexType;
      raise;
   end;

   {  Reset all controls }
   if Active then
   begin
      if ( mpoMasterLink.Active ) and ( mpoMasterLink.Fields.Count > 0 ) then
         MasterChanged( self );
      Resync( [] );
   end;

end;


{**********************************************************
*  Module:  TAdsDataSet.SwitchToIndex
*  Input:
*  Output:
*  Description: Switches index handles by doing a case statement
*  on the enumerated type meActiveIndexType.  The enumerated type
*  was to have been set in the calling routine.
**********************************************************}
procedure TAdsDataSet.SwitchToIndex;
var
   hHoldHandle : ADSHANDLE;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.SwitchToIndex' );
{$ENDIF }

   if Active then
      CheckBrowseMode;

   UpdateCursorPos;
   {  Depending on what Active Index Type is set lets put the handle in IndexHandle }
   case meActiveIndexType of
      {  if none then natural order }
      ndxNone:
      begin
         {  Assign natural order handle and invalidate the index handle }
         Activehandle := Handle;
      end;

      {  if IndexName then get the index handle and assign it to the IndexHandle }
      {  and active handle }
      ndxIndexName:
      begin
         ACECheck( self, ACE.AdsGetIndexHandle( Handle, PAceChar( AnsiString( IndexName ) ), @hHoldHandle ) );
         {  Make the index handle the active handle }
         ActiveHandle := hHoldHandle;
      end;

      {  if IndexField then get the index handle and assign it to the IndexHandle }
      {  and active handle }
      ndxIndexField:
      begin
         if Not FieldsAreIndexed( IndexFieldNames, hHoldHandle ) then
            raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL,
                                            'Not a valid index field name:' + IndexFieldNames );

         {  Make the index handle the active handle }
         ActiveHandle := hHoldHandle;
      end;

      ndxDefault:
      begin
         ACECheck( self, ACE.AdsGetIndexHandle( Handle, PAceChar( AnsiString( mstrDefaultIndex ) ), @hHoldHandle ) );
         {  Make the index handle the active handle }
         ActiveHandle := hHoldHandle;
      end;

   end;

   {  The following is Delphi specific reinitialization of buffers }
   SetBufListSize( 0 );
   InitBufferPointers;
   try
      SetBufListSize( BufferCount + 1 );
   except
      SetState( dsInactive );
      CloseCursor;
      raise;
   end;
end;


{**********************************************************
*  Module:  TAdsDataSet.GetRecordCount
*  Input:
*  Output:
*  Return:  Integer -- Record count in dataset (overridden type)
*  Description: Overridden function to get the total record count
*  of the database.  If the index handle is set in ActiveHandle then the
*  index handle is what is getting passed.  If filters are respected
*  then the record count will reflect that for natural order or index
*  order.
**********************************************************}
function TAdsDataSet.GetRecordCount: Integer;
var
   ulFlags       : UNSIGNED32;
   ulRecordCount : UNSIGNED32;
   usOption      : UNSIGNED16;
   usLen         : UNSIGNED16;
   bUseIndex     : BOOLEAN;
   acExpr        : array[0..ADS_MAX_INDEX_EXPR_LEN] of AceChar;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.GetRecordCount' );
{$ENDIF }

   CheckActive;

   {* use activehandle (index handle) unless determined otherwise later *}
   bUseIndex := TRUE;

   {* sort out the count options *}
   if ( mpoAdsTableOptions.AdsFilterOptions = RESPECT_WHEN_COUNTING ) then
      usOption := ADS_RESPECTFILTERS
   else if ( mpoAdsTableOptions.AdsScopeOptions = RESPECT_SCOPES_WHEN_COUNTING ) then
      usOption := ADS_RESPECTSCOPES
   else
      usOption := ADS_IGNOREFILTERS;

   {* if respecting filters and there are not any scopes set then use the
    * table handle in the call to AdsGetRecordCount, this is faster than
    * using the index handle (don't read index pages) *}
   if ( usOption = ADS_RESPECTFILTERS ) and ( Handle <> ActiveHandle ) then
   begin
      {* if the index is unique and this is a dbf then we need to
       * use the index handle (unique in dbf really isn't unique)*}
      ACECheck( self, ACEUNPUB.AdsGetIndexFlags( ActiveHandle, @ulFlags ) );
      if ( ( TableType <> ttAdsADT ) and ( (ulFlags and ADS_UNIQUE) <> ADS_UNIQUE ) ) or
         ( TableType = ttAdsADT ) then
      begin
         {* if the index is conditional then we need to stick with using
          * the index handle *}
         usLen := ADS_MAX_INDEX_EXPR_LEN;
         ACECheck( self, ACE.AdsGetIndexCondition( ActiveHandle, @acExpr, @usLen ) );
         if ( usLen = 0 ) then   {* no conditional index *}
         begin
            {* by checking ACE's scope top and scope bottom we can find if a
             * range has been set, if the scoped option is true, or if this
             * is the child of a master/detail, all at one point *}
            if not IsAceScopeSet then
               bUseIndex := FALSE;
         end;
      end;
   end;

   if ( mpoAdsTableOptions.mbRefreshCount = TRUE ) then
      usOption := usOption or ADS_REFRESHCOUNT;

   if ( bUseIndex = TRUE ) then
      ACECheck( self, ACE.AdsGetRecordCount( ActiveHandle, usOption, @ulRecordCount ) )
   else
      ACECheck( self, ACE.AdsGetRecordCount( Handle, usOption, @ulRecordCount ) );

   Result := ulRecordCount;
end;

{**********************************************************
*  Module:  TAdsDataSet.SetRecNo
*  Input:  Integer -- Record number in dataset (overridden type)
*  Output:
*  Return:
*  Description: Overridden function to get the current record number.
*  The record number is retrieved from the activebuffer due to the
*  fact that the activebuffer and the cursor position are not always
*  in sync.
**********************************************************}
procedure TAdsDataSet.SetRecNo( Value: Integer );
var
   ulRecCount : UNSIGNED32;
   dPos : Double;
   ulRetVal : UNSIGNED32;
begin
{$IFDEF CALLTRACE}
   WriteCallTrace( 'TAdsDataSet.SetRecNo' );
{$ENDIF}

   CheckBrowseMode;
   DoBeforeScroll;

   // If sequencedlevel is exact, then we con't do a goto, we need to
   // correctly position on the exact logical record. The only way to do
   // that is to gotop and skip, letting the server correctly filter the
   // records and leave us on the exact logical record number requested.
   if sequenced and ( sequencedlevel = slExact ) then
   begin
      ACECheck( self, ACE.AdsGotoTop( ActiveHandle ) );
      ACECheck( self, ACE.AdsSkip( ActiveHandle, ( Value - 1 ) ) );
   end
   else if ( meActiveIndexType = ndxNone ) then
   begin
      {  no index is active }
      if filtered then
      begin
         ACECheck( self, ACE.AdsGotoTop( Self.Handle ) );
         ACECheck( self, ACE.AdsSkip( Self.Handle, ( Value - 1 ) ) );
      end
      else
      begin
         ulRetVal := ACE.AdsGotoRecord( Self.Handle, Value );
         // This could fail with a 5022 error if there are deleted records in
         // the dataset. If that happens, resort to the same gotop/skip method
         // used above if the dataset is filtered. Only do this if the dataset
         // is sequenced. If it isn't, and the user directly requests to go to
         // a record that is deleted, I think we should still raise the 5022.
         //  See bug 3055.
         if sequenced and ( ulRetVal = AE_INVALID_RECORD_NUMBER ) then
         begin
            ACECheck( self, ACE.AdsGotoTop( Self.Handle ) );
            ACECheck( self, ACE.AdsSkip( Self.Handle, ( Value - 1 ) ) );
         end
         else
            ACECheck( self, ulRetVal );
      end;
   end
   else
   begin
      ACECheck( self, ACE.AdsGetRecordCount( Self.Handle, ADS_IGNOREFILTERS, @ulRecCount ) );
      if ( ulRecCount = 0 ) then
         dPos := 0
      else
         dPos := value / ulRecCount;

      if ( dPos >= 1.0 ) then
         dPos := 1.0;

      ACECheck( self, ACE.AdsSetRelKeyPos( ActiveHandle, dPos ) );
   end;
   Resync( [rmCenter] );
   DoAfterScroll;
end;

{**********************************************************
*  Module:  TAdsDataSet.GetRecNo
*  Input:
*  Output:
*  Return:  Integer -- Record number in dataset (overridden type)
*  Description: Overridden function to get the current record number.
*  The record number is retrieved from the activebuffer due to the
*  fact that the activebuffer and the cursor position are not always
*  in sync.
**********************************************************}
function TAdsDataSet.GetRecNo: Integer;
var
  BufPtr: PAdsBuffer;

begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.GetRecordNo' );
{$ENDIF }

   CheckActive;

   {  If we are dealing with calculated buffers then the active buffer is the }
   {  calculated buffer otherwise it is the Activebuffer. }
   if State = dsCalcFields then
   begin
      {* db.pas ends up using the same buffer pointer but we will
       * distinguish between CalcBuffer and ActiveBuffer for completeness *}
      BufPtr := CalcBuffer;
      {* always return the physical record number if calculating fields,
       * see description of bug #595 for details *}
      Result := PUNSIGNED32( BufPtr + musBookmarkOfs )^;
   end
   else
   begin
      if IsEmpty then
      begin
         Result := 0;
         exit;
      end;

      BufPtr := ActiveBuffer;
      Result := PRecInfo( BufPtr + musRecInfoOfs ).LogicalRecNumber;
   end;

end;   {  TAdsDataSet.GetRecNo }


{$IFNDEF FPC}
{**********************************************************
*  Module:  TAdsDataSet.GetStateFieldValue
*  Input:   State: TDataSetState; Field: TField
*  Output:
*  Return:  Variant
*  Description: Overridden function to see if it is being called
**********************************************************}
function TAdsDataSet.GetStateFieldValue( State: TDataSetState; Field: TField ): Variant;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.GetStateFieldValue' );
{$ENDIF }
   Result := inherited GetStateFieldValue(State, Field);
end;
{$ENDIF}

{**********************************************************
*  Module:  TAdsDataSet.GetBookmarkFlag
*  Input:  Buffer: PChar - pointer to active record buffer (overridden type)
*  Output:
*  Return:  TBookmarkFlag
*  Description: Gets the bookmark flag from the Buffer
**********************************************************}
function TAdsDataSet.GetBookmarkFlag( Buffer: PAdsBuffer ): TBookmarkFlag;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.GetBookmarkFlag' );
{$ENDIF }

   {  Bookmark flag is what was set in GetRecord, and is retrieved from the }
   {  record info structure }
   Result := PRecInfo( Buffer + musRecInfoOfs ).BookmarkFlag;
end;

{**********************************************************
*  Module:  TAdsDataSet.InitBufferPointers
*  Input:
*  Output:
*  Description: Initializes some internal data members of
*  TAdsDataSet
**********************************************************}
procedure TAdsDataSet.InitBufferPointers;
var
   ulBookmarkSize : UNSIGNED32;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.InitBufferPointers' );
{$ENDIF }
   {  Offset of the blob cache in the buffer }
   musBlobCacheOfs := musRecordSize + CalcFieldsSize;

   {  Offset of the record information structure in the record buffer }
   musRecInfoOfs := musBlobCacheOfs + BlobFieldCount * SizeOf( Pointer );

   {  Offset of the bookmark in the record buffer }
   musBookmarkOfs := musRecInfoOfs + SizeOf( TRecInfo );

   {  The entire record buffer size }
   if (( ActiveHandle <> INVALID_ACE_HANDLE ) and ( ActiveHandle <> 0 )) then
      ACECHECK( self, ACE.AdsGetBookmarkLength( ActiveHandle, @ulBookmarkSize ) )
   else
      ACECHECK( self, ACE.AdsGetBookmarkLength( Handle, @ulBookmarkSize ) );

   BookmarkSize := ulBookmarkSize;

   musRecBufSize := musBookmarkOfs + BookmarkSize;
end;


{**********************************************************
*  Module:  TAdsDataSet.ReadTranslatedRecord
*  Input:    pucRec - pointer to the record buffer to fill
*            pulLength - Length of the given buffer
*            bCalcFields - true if want to update calc fields
*            Sent as true from InternalEdit, false from
*            GetCurTranslatedRecord because it's going to take
*            care of the calc fields itself after filtering
*            records.
*  Output:   pucRec - Pointer for the result record
*  Description: Retrieves the specified record from table and
*  passes it back through the Buffer.  This function is to
*  make sure that the OEM data gets put into the buffer
**********************************************************}
procedure TAdsDataSet.ReadTranslatedRecord( pucRec: PAdsBuffer;
                                            pulLen: pUNSIGNED32;
                                            bCalcFields: boolean );
var
   usFieldCount   : UNSIGNED16;
   usNumFields    : UNSIGNED16;
   pcFieldName    : PAceChar;
   usFieldType    : UNSIGNED16;
   ulOffset       : UNSIGNED32;
   ulFieldLength  : UNSIGNED32;
   cSavedChar     : AdsBufferItem;
   pcSavedCharPos : PAdsBuffer;
   bIsBlobEmpty   : UNSIGNED16;
   bIsBlobNull    : UNSIGNED16;
begin
   {  Get number of fields so we can do some processing on memo field and string }
   {  fields.  Do not use TDataset.FieldCount because there may be calculated fields. }
   ACECheck( self, ACE.AdsGetNumFields( Handle, @usNumFields ) );

   ACECheck( self, ACE.AdsGetRecord( Handle, PAceChar( pucRec ), pulLen ) );

   {  Add bookmark to the end  of the record buffer }
   if (( ActiveHandle <> INVALID_ACE_HANDLE ) and ( ActiveHandle <> 0 )) then
      ACECHECK( self, ACE.AdsGetBookmark60( ActiveHandle, PAceChar( pucRec + musBookmarkOfs ), @BookmarkSize ) )
   else
      ACECHECK( self, ACE.AdsGetBookmark60( Handle, PAceChar( pucRec + musBookmarkOfs ), @BookmarkSize ) );

   {  We will store the blankness of memo field in the record buffer }
   if BlobFieldCount > 0 then
   begin
      for usFieldCount := 1 to usNumFields do
      begin
{$IFDEF FPC} {$WARNINGS OFF} {$ENDIF}
         pcFieldName := ADSFIELD( usFieldCount );
{$IFDEF FPC} {$WARNINGS ON} {$ENDIF}
         usFieldType := FACEFieldDefs[ usFieldCount -1 ].FieldType;

{$IFDEF ADSDELPHI2008_OR_NEWER}
         if usFieldType in [ ADS_VARCHAR, ADS_MEMO, ADS_NMEMO, ADS_BINARY, ADS_IMAGE ] then
{$ELSE}
         if usFieldType in [ ADS_VARCHAR, ADS_MEMO, ADS_BINARY, ADS_IMAGE ] then
{$ENDIF}

         begin
            ulOffset := FACEFieldDefs[ usFieldCount -1 ].Offset;
            ACECheck( self, ACE.AdsIsEmpty( Handle, pcFieldName, @bIsBlobEmpty ) );
            ACECheck( self, ACE.AdsIsNull( Handle, pcFieldName, @bIsBlobNull ));

            if ( bIsBlobEmpty <> 0 ) or ( bIsBlobNull <> 0 ) then
               pUNSIGNED32( pucRec + ulOffset )^ := 0
            else
               PUNSIGNED32( pucRec + ulOffset )^ := $FFFFFFFF;
         end;   { if usFieldType in .. }
      end;   { for sFieldCount := 1 to .. }

      {  Clear all the blob cache.  If we are not in one of the states listed below,  }
      {  we do not care about the blob field, and should not try to access them. Otherwise, }
      {  bad things are going to happend. }
      if state in [dsBrowse, dsEdit, dsInsert, dsNewValue, dsCalcFields] then
         for usFieldCount := 0 to BlobFieldCount - 1 do
            TAdsBlobCache( PBlobDataArray( pucRec + musBlobCacheOfs )[usFieldCount] ).ClearCache;
   end;

   {  Due to the fact of getting the entire record, if the Char type is OEM then }
   {  we need to get each field for the conversion to take place through ACE }
   if ( musOpenCharType = ADS_OEM ) then
   begin
      for usFieldCount := 1 to usNumFields do
      begin
{$IFDEF FPC} {$HINTS OFF} {$ENDIF} { Disable FPC hints to avoid ptr Conversion hint }
         pcFieldName := PAceChar( UNSIGNED32( usFieldCount ) );
{$IFDEF FPC} {$HINTS ON} {$ENDIF}
         usFieldType := FACEFieldDefs[ usFieldCount - 1 ].FieldType;

         {  Only need to do this for string fields.  Memos are handled on their own }
         {  elsewhere and not in this buffer.  ONLY data fields. }
         if ( usFieldType = ADS_STRING ) or ( usFieldType = ADS_CISTRING ) or
{$IFDEF ADSDELPHI2008_OR_NEWER}
            ( usFieldType = ADS_NCHAR ) or ( usFieldType = ADS_NVARCHAR ) or
{$ENDIF}
            ( usFieldType = ADS_VARCHAR_FOX ) then
         begin
            {  Get the Field offset and length }
            ulOffset := FACEFieldDefs[ usFieldCount - 1 ].Offset;
            ulFieldLength := FACEFieldDefs[ usFieldCount - 1 ].Length;

            pcSavedCharPos := pucRec + ulOffset + ulFieldLength;
            cSavedChar := pcSavedCharPos^;
            Inc( ulFieldLength );

            Try
{$IFDEF ADSDELPHI2008_OR_NEWER}
               if ( usFieldType = ADS_NCHAR ) or ( usFieldType = ADS_NVARCHAR ) then
               begin
                  Inc( ulFieldLength );
                  ulFieldLength := TRUNC( ulFieldLength / 2 ); // Field length is in bytes, change to CodeUnits.
                  ACECheck( self, ACE.AdsGetFieldW( Handle, pcFieldName, PWideChar( PAceChar( pucRec ) + ulOffset ),
                                             @ulFieldLength, ADS_NONE ) );
               end
               else
                  ACECheck( self, ACE.AdsGetField( Handle, pcFieldName, PAceChar( pucRec ) + ulOffset,
                           @ulFieldLength, ADS_NONE ) );

{$ELSE}
               ACECheck( self, ACE.AdsGetField( Handle, pcFieldName, PAceChar( pucRec ) + ulOffset,
                                          @ulFieldLength, ADS_NONE ) );
{$ENDIF}
            Finally
               pcSavedCharPos^ := cSavedChar;
            End;  { Try }
         end;
      end;
   end;

   if bCalcFields then
      GetCalcFields( pucRec );
end;


{**********************************************************
*  Module:  TAdsDataSet.GetCurTranslatedRecord
*  Input:    pucRec - pointer to a Char of the record buffer to fill
*            pulLength - Length of the given buffer
*            GetMode   - Determines forward and backward movement
*  Output:   pucRec - Pointer for the result record
*  Description: Retrieves the specified record from table and
*  passes it back through the Buffer.  This function is to
*  make sure that the OEM data gets put into the buffer
**********************************************************}
function TAdsDataSet.GetCurTranslatedRecord( pucRec: PAdsBuffer;
                                             pulLen: pUNSIGNED32;
                                             GetMode : TGetMode ) : TGetResult;
var
   bIsBOF         : UNSIGNED16;
   bIsEOF         : UNSIGNED16;
   bGotFilteredRec : Boolean;
   bVisible        : UNSIGNED16;
   ulRetVal        : UNSIGNED32;

begin

{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.GetCurTranslatedRecord' );
{$ENDIF }

   bGotFilteredRec := False;

   Result := grOK;

   while not bGotFilteredRec do
   begin
      {  Check to see if we are out of range first }
      ACECheck( self, ACE.AdsAtEof( Handle, @bIsEOF ) );
      if ( bIsEOF <> 0 ) and ( GetMode in [ gmNext, gmCurrent ] ) then
      begin
         Result := grEOF;
         Exit;
      end;

      ACECheck( self, ACE.AdsAtBof( Handle, @bIsBOF ) );
      if ( bIsBOF <> 0 ) and ( GetMode in [ gmPrior, gmCurrent ] ) then
      begin
         Result := grBOF;
         Exit;
      end;

      {  See if this record is visible, if not then return grError so  }
      {  Delphi will not display this record  }
      ulRetVal := ACE.AdsIsRecordVisible( ActiveHandle, @bVisible );
      if ( ulRetVal <> AE_NO_CURRENT_RECORD ) then
         ACECheck( self, ulRetVal );
      if ( bVisible = ADS_FALSE ) then
      begin
         if ( GetMode = gmCurrent ) then
         begin
            Result := grError;
            exit;
         end
         else
         begin
            if ( GetMode = gmPrior ) then
               {  Skip backward }
               ACECheck( self, ACE.AdsSkip( ActiveHandle, -1 ) )
            else
               {  Skip forward for gmCurrent and gmNext }
               ACECheck( self, ACE.AdsSkip( ActiveHandle, 1 ) );
            Continue;
         end;
      end;

      {  Get the record }
      ReadTranslatedRecord( pucRec, pulLen, false );

      bGotFilteredRec := True;

      if mpoAdsTableOptions.AdsCalcFieldsBeforeFilter then
         GetCalcFields( pucRec );

      {  The following will handle the OnFilterRecord event if a developer has }
      {  written a handler for the event and has the Filtered property set to true }
      if Assigned( OnFilterRecord ) and Filtered and ( not RecordFilter( pucRec ) ) then
      begin
         bGotFilteredRec := False;

         if ( GetMode = gmCurrent ) then
         begin
            Result := grError;
            exit;
         end;

         {  Since the current record did not met the user defined filter function, }
         {  we have to skip in the correct direction to get the next record }
         if ( GetMode = gmPrior ) then
            {  Skip backward }
            ACECheck( self, ACE.AdsSkip( ActiveHandle, -1 ) )
         else
            {  Skip forward for gmNext }
            ACECheck( self, ACE.AdsSkip( ActiveHandle, 1 ) );
      end
      else
      begin
         { Either there are no user filter events, or it passed, so now populate the other fields }
         if not mpoAdsTableOptions.AdsCalcFieldsBeforeFilter then
            GetCalcFields( pucRec );
      end;

   end;

end;   {  TAdsDataSet.GetCurTranslatedRecord }


function TAdsDataSet.CalculateSequenceNumber : UNSIGNED32;
var
   ulRecNum     :   UNSIGNED32;
   ulRecCount   :   UNSIGNED32;
   dPos         :   Double;
   ulRetVal     :   UNSIGNED32;
begin
   {  The logical record number of the record buffer
      This value is equal to the physical record number if not index is
      active or if Sequenced is false.
      The value is an approximate of the key value if both an index is
      active and Sequenced is TRUE
   }
   if ( ( ( IndexName = '' ) and ( IndexFieldNames = '' ) ) Or ( NOT( Sequenced ) ) ) then
      ACECheck( self, ACE.AdsGetRecordNum( Handle, ADS_IGNOREFILTERS, @ulRecNum ) )
   else
   begin
      {* If sequenced level is exact, use the slower (but more accurate)
       * API AdsGetKeyNum. Otherwise use AdsGetRelKey pos which provides
       * better performance. *}
      if ( meSeqLevel = slExact ) then
      begin
        {* NOTE: In the future we could add a different sequenced level and not
         * pass ADS_RESPECTFILTERS all the time. *}
        ACECheck( self, ACE.AdsGetKeyNum( ActiveHandle, ADS_RESPECTFILTERS, @ulRecNum ) );
      end
      else
      begin
         ACECheck( self, ACE.AdsGetRecordCount( Handle, ADS_IGNOREFILTERS,
                                                @ulRecCount ) );
         ulRetVal := ACE.AdsGetRelKeyPos( ActiveHandle, @dPos );

         {  If the position was not found then it is zero }
         if ( ulRetVal <> AE_NOT_FOUND ) then
            ACECheck( self, ulRetVal )
         else
            dPos := 0;

         ulRecNum := Trunc( dPos * ulRecCount );
      end;
   end;

   Result := ulRecNum;
end; { TAdsTable.CalculateSequenceNumber }


{**********************************************************
*  Module:  TAdsDataSet.GetRecord
*  Input:    Buffer  - Pointer for result record
*            GetMode - Direction from cursor
*            DoCheck - Whether to throw exception
*  Output:   Buffer - Pointer for the result record
*  Return:   TGetResult
*  Description: Retrieves the specified record from table and
*  passes it back through the Buffer
**********************************************************}
{$IFDEF FPC}{$HINTS OFF}{$ENDIF}
function TAdsDataSet.GetRecord( Buffer: PAdsBuffer; GetMode: TGetMode;
                                DoCheck: Boolean ): TGetResult;
var
   ulBufferLen  :   UNSIGNED32;
   ulTempRecNum :   UNSIGNED32;
begin
{$IFDEF CALLTRACE }
   case GetMode of
   gmNext   :  WriteCallTrace( 'TAdsDataSet.GetRecord( Next )' );
   gmPrior  :  WriteCallTrace( 'TAdsDataSet.GetRecord( Prior )' );
   gmCurrent:  WriteCallTrace( 'TAdsDataSet.GetRecord( Current )' );
   end;
{$ENDIF }

   {  Check for valid handle.  If the table has already been closed, its handle will }
   {  be INVALID_ACE_HANDLE; }
   Result := grERROR;
   if Handle = INVALID_ACE_HANDLE then
      exit;

   {  If we are in insert state we had better not be moving around in the dataset. }
   if ( State = dsInsert ) then
      exit;

   case GetMode of
      gmNext: ACECheck( self, ACE.AdsSkip( ActiveHandle, 1 ) );
      gmPrior: ACECheck( self, ACE.AdsSkip( ActiveHandle, -1 ) );
      gmCurrent: { do nothing };
      else
      begin
         {  if any other mode then error }
         result := grERROR;
         exit;
      end;

   end;{  case }

   {  Get current record respecting UDF filter }
   ulBufferLen := musRecBufSize;
   Result := GetCurTranslatedRecord( Buffer, @ulBufferLen, GetMode );
   if ( Result <> grOK ) then
      exit;

   {  Add to the end of the buffer record information }
   {  AW Unresolved, This may need to be move to inside the loop in GetCurTranslateRecord }
   with PRecInfo( Buffer + musRecInfoOfs )^ do
   begin
      {  Status of the record buffer }
      UpdateStatus := usUnmodified;

      {  Bookmark flag of the record buffer }
      BookmarkFlag := bfCurrent;

      { determine the sequence number }
      ulTempRecNum := CalculateSequenceNumber();
      LogicalRecNumber := ulTempRecNum;
   end;

end;   {  TAdsDataSet.GetRecord }
{$IFDEF FPC}{$HINTS ON}{$ENDIF}


{**********************************************************
*  Module:  TAdsDataSet.InternalOpen
*  Input:
*  Output:
*  Description: Overridden procedure of TDataSet to open the
*  database and initialize
**********************************************************}
procedure TAdsDataSet.InternalOpen;
var
   ulTempRecSize    : UNSIGNED32;
   ulBookmarkSize   : UNSIGNED32;
   hTempIndexHandle : ADSHANDLE;
   usLen            : UNSIGNED16;
   ulRetVal         : UNSIGNED32;
   ulIndexPageSize  : UNSIGNED32;
   i                : integer;
   iACEField        : integer;
   ucIsLive         : UNSIGNED8;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.InternalOpen' );
{$ENDIF }

   {  If handle has a valid value it means that table is still open. }
   if Handle <> INVALID_ACE_HANDLE then
      raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL, 'Table is already open.' );

   {*
    * Open the table and associated indexes. At this point mlActiveHandle will be INVALID_ACE_HANDLE,
    * unless the SetHandle method was used to set an active cursor/table handle for an existing dataset.
    * In this case don't call OpenAdvantageFiles, just use the handle that SetHandle put in mlActiveHandle.
    *}
   if ( mlActiveHandle <> INVALID_ACE_HANDLE ) then
   begin
      mlHandle := mlActiveHandle;
      {*
       * Get the table type of the actual opened table. This may be different from
       * the musOpenTableType which is set by the user. NOTE: This is done in
       * OpenAdvantageFiles if the handle is not currently active.
       *}
      ACECheck( self, ACE.AdsGetTableType( mlHandle, @musAceTableType ) );
   end
   else
      mlHandle := OpenAdvantageFiles;

   {  Get rec size from ACE. }
   ACECheck( self, ACE.AdsGetRecordLength( Handle, @ulTempRecSize ) );

   { Initialize the can modify flag. }
   ACECheck( self, Ace.AdsGetTableOpenOptions( Handle, @mulTableOptions ));

   { set the mbCanModify flag according the actual table open option }
   if  ( mulTableOptions AND ADS_READONLY ) = ADS_READONLY then
      mbCanModify := FALSE
   else
      mbCanModify := TRUE;

   { See if this is an updatable static view }
   if ( mbCanModify and (( mulTableOptions AND ADS_EXCLUSIVE ) = ADS_EXCLUSIVE )) then
   begin
      ulRetVal := ACEUNPUB.AdsSqlPeekStatement( Handle, @ucIsLive );
      if (( ulRetVal = AE_SUCCESS ) and ( ucIsLive = 0 )) then
         {*
          * Updatable static views are always opened exclusive, even if they
          * weren't requested to be.  So set the Exclusive property to TRUE
          * so we won't try to lock records (a no-no in ACE).
          *}
         SetExclusive( TRUE );
   end;

   {*
    * Set the record caching level.  Note that we only set it for rcNone and
    * rcAggressive.  If rcStandard is used, then just allow the Advantage Client
    * Engine to set its default level, which is the lesser of 10 records or the
    * number of records that will fit in a single data burst.
    *}
   case AdsTableOptions.meAdsRecordCache of
      rcNone: ACECheck( self, ACE.AdsCacheRecords( Handle, 0 ) );  { no caching }
      rcAggressive: ACECheck( self, ACE.AdsCacheRecords( Handle, ADS_AGGRESSIVE_RA_CACHE_SIZE ) );
   end;

   {*
    * Get index page size from ace. This needs an index handle. Just try to get any index handle
    * from ACE and use it to find out the size. This won't work correctly if they have multiple
    * adi files associated with one adt, and each adi has a different page size, but that would
    * be fairly silly.
    * NOTE : Not checking for any errors here, don't want to get caught raising an unexpected
    * exception that 99.69% of people don't care about.
    *}
   usLen := 1;
   hTempIndexHandle := 0;
   ulRetVal := AdsGetAllIndexes( Handle, @hTempIndexHandle, @usLen );
   if (( ulRetVal = AE_SUCCESS ) or ( ulRetVal = AE_INSUFFICIENT_BUFFER )) then
   begin
      ulRetVal := AdsGetIndexPageSize( hTempIndexHandle, @ulIndexPageSize );
      if ( ulRetVal = AE_SUCCESS ) then
         mpoAdsTableOptions.AdsIndexPageSize := ulIndexPageSize;
   end;

   if ( ulRetVal <> AE_SUCCESS ) then
      mpoAdsTableOptions.AdsIndexPageSize := ADS_DEFAULT;

   {  Set record, buffer, and bookmark sizes }
   musRecBufSize := ulTempRecSize;
   musRecordSize := ulTempRecSize;

   if (( ActiveHandle <> INVALID_ACE_HANDLE ) and ( ActiveHandle <> 0 )) then
      ACECHECK( self, ACE.AdsGetBookmarkLength( ActiveHandle, @ulBookmarkSize ) )
   else
      ACECHECK( self, ACE.AdsGetBookmarkLength( Handle, @ulBookmarkSize ) );
   BookmarkSize := ulBookmarkSize;

   {  Allocate the key buffers for lookups and seeks }
   AllocKeyBuffers;

{$ifdef ADSCBUILDER3_OR_NEWER}
   {  Initialize the field definitions }
   FieldDefs.Updated := False;
   FieldDefs.Update;
{$else}
   {  Initialize the field definitions }
   InternalInitFieldDefs;
{$endif}

   {  If we are using the default fields then create fields }
   if DefaultFields then
   begin
      CreateFields;
   end;

{$IFDEF ADSDELPHI4_OR_NEWER}
   for i := 0 to ( Fields.Count - 1 ) do
{$ELSE}
   for i := 0 to ( FieldCount - 1 ) do
{$ENDIF}
   begin
      {  With calculated and lookup fields we can't index directly into the collection,  }
      {  because there might be more or less ACE field defs than there are Fields in     }
      {  this dataset.                                                                   }
      iACEField := FACEFieldDefs.IndexOf( Fields[i].FieldName );

      {*
       * This next line is for backwards compatibility. In 7.0 we always changed bcd fields
       * currency property to true here. This wasn't always correct because if the user
       * declared a persistent field and manually set currency to false, we would still
       * switch it back to true here. As of 7.1 persistent bcd fields have a default
       * currency value of true, but it can be changed to false. 7.1 and newer use
       * TAdsBCDFields. We still need old apps that have TBCDFields in their DFMs to work
       * like they always have, though.
       *
       * 8.0 addition: Since ADS_ROWVERSION fields use the ftBCD type, turn the currency
       * flag off for them.
       *}
      if ( Fields[i].DataType = ftBCD ) then
      begin
         if not ( Fields[i] is TAdsBCDField ) then
            TBCDField( Fields[i] ).Currency := TRUE { old 7.1 functionality }
         else if (( iACEField <> -1 ) and
                  (( FACEFieldDefs[iACEField].FieldType = ADS_ROWVERSION ) or
                   ( FACEFieldDefs[iACEField].FieldType = ADS_NUMERIC ))) then
            TAdsBCDField( Fields[i] ).Currency := FALSE; { 8.0 rowversion handling }
      end;

      {  Set CaseInsensitive property for any fields that are based on an ADS_CISTRING field  }
      if ( Fields[i].DataType = ftString ) and
         ( iACEField <> -1 ) and
         ( FACEFieldDefs[iACEField].FieldType = ADS_CISTRING ) and
         ( Fields[i] is TAdsStringField ) then
         TAdsStringField( Fields[i] ).FCaseInsensitive := TRUE;

   end;

   {  Bind the fields }
   BindFields( True );

   {  Initialize the buffer pointers.  i.e. pointer offsets into record buffers }
   InitBufferPointers;

   mpoIndexDefs.Updated := False;
   mpoIndexDefs.Update;

   {  if our handle is not 0 then switch to our current index order }
   if Handle <> 0 then
      SwitchToIndex;

   {  if scoped or filtered make sure to activate them }
   if Scoped then
      ActivateScope;

   if Filtered then
      ActivateFilters;

   {  if our handle is not 0 then go top }
   if Handle <> 0 then
      InternalFirst;

end;

{**********************************************************
*  Module:  TAdsDataSet.InternalAddRecord
*  Input:  Buffer, Append
*  Output:
*  Description: This function is called by the Append() functions after the
*               buffer is populated.  The Buffer parameter should be the same
*               as the ActiveBuffer.  If not, we are in trouble.
**********************************************************}
{$IFDEF FPC}{$HINTS OFF}{$ENDIF}
procedure TAdsDataSet.InternalAddRecord( Buffer: Pointer; Append: Boolean );
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.InternalAddRecord' );
{$ENDIF }
   if Buffer <> ActiveBuffer then
      raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL,
                                      'Unexpected error in InternalAddRecord.' );

   { Simply call the post function }
   InternalPost;
end;
{$IFDEF FPC}{$HINTS ON}{$ENDIF}

{**********************************************************
*  Module:  TAdsDataSet.InternalClose
*  Input:
*  Output:
*  Description: Overridden procedure of TDataSet to close the
*  database and free variables
**********************************************************}
procedure TAdsDataSet.InternalClose;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.InternalClose' );
{$ENDIF }

   { if in design mode, make sure table caching is never performed }
   if csDesigning in ComponentState then
   begin
      ACECheck( self, AdsCacheOpenTables( 0 ) );
      ACECheck( self, AdsCacheOpenCursors( 0 ) );
   end;

   {  Unbind the fields }
   BindFields( False );

   {  if we had default fields then destroy them }
   if DefaultFields then
      DestroyFields;

   {  Free the allocated key buffers }
   FreeKeybuffers;

   {* Free bufer used to save old record buffer on edit operations, because this
    * table object might get re-opened with a new table that has a larger
    * record size. *}
   FreeOldRecordBuffer;

   try
      if Handle <> INVALID_ACE_HANDLE then
         {  Close the table }
         ACECheck( self, ACE.AdsCloseTable( Self.Handle ) );
   except on E : Exception Do
      begin
      {* Do nothing since the table is still closed. Just continue.*}
      end
   end;

   {  Now that the table is closed invalidate all handles }
   mlHandle := INVALID_ACE_HANDLE;
   ActiveHandle := INVALID_ACE_HANDLE;

   {  we now obviously cannot modify anything }
   mbCanModify := False;
end;

{**********************************************************
*  Module:  TAdsDataSet.IsCursorOpen
*  Input:
*  Output:
*  Return: booelan - Indicator whether the cursor is open
*  Description: Overridden function to see if the cursor is
*  open.  True if it is and False if not.
**********************************************************}
function TAdsDataSet.IsCursorOpen: boolean;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.IsCursorOpen' );
{$ENDIF }

   {  if our cursor is not invalid then return true otherwise false }
   If Self.Handle <> INVALID_ACE_HANDLE then
      Result := True
   else
      Result := False;
end;

{**********************************************************
*  Module:  TAdsDataSet.AllocRecordBuffer
*  Input:
*  Output:
*  Return:  PChar - Pointer to Allocated record buffer
*  Description: Overridden function to allocate space for internal
*  TDataSet Buffers
**********************************************************}
function TAdsDataSet.AllocRecordBuffer: PAdsBuffer;
var
   iBlobCount : integer;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.AllocRecordBuffer' );
{$ENDIF }

   {  Allocate the buffer and pass it back }
   Result := PAdsBuffer( AnsiStrAlloc( musRecBufSize ) );

   {  if we have BLOB fields then initialize the blob cache array }
   for iBlobCount := 0 to BlobFieldCount - 1 do
      {  Initialize a dynamically allocated variable. }
      PBlobDataArray( Result + musBlobCacheOfs )[iBlobCount] := TAdsBlobCache.Create;
end;

{**********************************************************
*  Module:  TAdsDataSet.FreeRecordBuffer
*  Input:   Buffer - pointer to the buffer to free
*  Output:  Buffer
*  Description: Overridden procedure to free space for internal
*  TDataSet Buffers
**********************************************************}
procedure TAdsDataSet.FreeRecordBuffer( var Buffer: PAdsBuffer );
var
   iBlobCount : integer;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.FreeRecordBuffer' );
{$ENDIF }

{$IFDEF FPC}
   { SetBufListSize(0) sends in null pointer }
   if ( Buffer = nil ) then
      Exit;
{$ENDIF}

   {  if we have BLOB fields then free the blob cache array }
   for iBlobCount := 0 to BlobFieldCount - 1 do
      {  Initialize a dynamically allocated variable. }
      TAdsBlobCache( PBlobDataArray( Buffer + musBlobCacheOfs )[iBlobCount] ).destroy;

   {  Free the buffer }
   StrDispose( PAnsiChar( Buffer ) );
end;

{**********************************************************
*  Module:  TAdsDataSet.GetBookmarkData
*  Input:  Buffer - record buffer of the data to retrieve
*          Data - buffer to return the bookmark data in
*  Output: Data - same as above
*  Description: Overridden procedure that retrieves the bookmark
*  data by moving the bookmark into the data buffer
**********************************************************}
procedure TAdsDataSet.GetBookmarkData( Buffer: PAdsBuffer; Data: Pointer );
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.GetBookmarkData' );
{$ENDIF }

   {  move what is at the bookmark offset into the supplied data buffer }
   {  through the data pointer length of the Bookmark }
   Move( Buffer[musBookmarkOfs], Data^, BookmarkSize );
end;

{**********************************************************
*  Module:  TAdsDataSet.GetFieldData
*  Input:   Field - Field to get data from
*           Buffer - To return Data in
*  Output:  Buffer - same as above
*  Return:  Boolean - Successful
*  Description: Overridden function to retrieve data from current
*  record.
**********************************************************}
function TAdsDataSet.GetFieldData( Field: TField; Buffer: Pointer ): Boolean;
var
   bIsBlank: boolean;
   pRecBuf: PAdsBuffer;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.GetFieldData' );
{$ENDIF }

   Result := False;
   pRecBuf := nil;
   bIsBlank := false;

   {  Get the active record buffer }
   if not GetActiveRecBuf( pRecBuf ) then Exit;
   with Field do
   begin
      {  Make sure the field number is greater than zero }
      if FieldNo > 0 then
      begin
         {  Get the field given Active record buffer, return buffer and field info }
         ADSGetDataField( Field, pRecBuf, Buffer, bIsBlank );
         Result := not bIsBlank;
      end
      else
      begin
         {  if Calc or lookup field }
         if State in [dsBrowse, dsEdit, dsInsert, dsCalcFields, dsFilter] then
         begin
            {  Delphi Construct }
            Inc( pRecBuf, musRecordSize + Offset );
            Result := Boolean( pRecBuf[0] );
            if Result and ( Buffer <> nil ) then
               Move( pRecBuf[1], Buffer^, DataSize );
         end;
      end;
   end;
end;

{/*****************************************************************************
* Module     : GetCompactDate
* Global Vars:
* Return Val :
* Desc       : Converts a compacted three byte date value into string in the format
*              'YYYYMMDD'
****************************************************************************/}
function GetCompactDate( pc3ByteDate : PAdsBuffer { (I) 3-byte date to extract } ) : string;
var
   usYear : UNSIGNED16;  // year */
   usMonth : UNSIGNED16; // month */
   usDay : UNSIGNED16;   // day */
   usWordHold : UNSIGNED16;
begin
{$IFDEF CALLTRACE}
   WriteCallTrace( 'GetCompactDate' );
{$ENDIF}

   usWordHold := PByte( pc3ByteDate )^ * 256 + PByte( pc3ByteDate + 1 )^;
   usYear := ( usWordHold AND $FFFE ) shr 1;

   usWordHold := usWordHold AND $0001;
   usMonth := usWordHold shl 3;
   usWordHold := PByte( pc3ByteDate + 2 )^ AND $E0;
   usWordHold := usWordHold shr 5;
   usMonth := usWordHold OR usMonth;

   usDay := PByte( pc3ByteDate + 2 )^ AND $1F;

   Result := '0000' + IntToStr( usYear );
   Result := Copy( Result, Length( Result ) - 3, 4 );

   if usMonth < 10 then
      result := result + '0' + IntToStr( usMonth )
   else
      result := result + IntToStr( usMonth );

   if usDay < 10 then
      result := result + '0' + IntToStr( usDay )
   else
      result := result + IntToStr( usDay );

end; // GetCompactDate */



{**********************************************************
*  Module:  TAdsDataSet.IsBlobBlank
*  Input:
*  Output:
*  Return: True if the data is considerred to be blank
*  Description: function to determine if the blob field is blank
**********************************************************}
function TAdsDataSet.IsBlobBlank
(
   pRecBuf       : PAdsBuffer;          // (I) pointer to active buffer
   Field         : TBlobField;     // (I) the blob field
   pcData        : PAdsBuffer;          // (I) pointer to data
   usADSDataType : UNSIGNED16      // (I) Ads field type
)  : Boolean;

var
   oAdsBlobCache : TAdsBlobCache;
Begin
{$IFDEF CALLTRACE}
   WriteCallTrace( 'IsBlobBlank' );
{$ENDIF}

   {  Get the blob cache object from the active record buffer }
   oAdsBlobCache := TAdsBlobCache( PBlobDataArray( pRecBuf + musBlobCacheOfs )[ Field.Offset ] );

   {*
    * If the cache has been modified then get the "blank" value from
    * the blobcache, o/w get it from the record buffer.
    *}
   if ( oAdsBlobCache.mbBlobModified = TRUE ) then
   begin
      if ( oAdsBlobCache.size > 0 ) then
         Result := False
      else
         Result := True;
   end
   else
      Result := IsFieldBlank( pcData, 0 { Not used by the function }, usADSDataType,
                              pRecBuf, Field As TField );

end; //end IsBlobBlank



{**********************************************************
*  Module:  TAdsDataSet.IsFieldBlank
*  Input:
*  Output:
*  Return: True if the data is considerred to be blank
*  Description: function to determine if the data field is blank
**********************************************************}
function TAdsDataSet.IsFieldBlank
(
   pcData         : PAdsBuffer;          // (I) pointer to data
   ulDataLen      : UNSIGNED32;     // (I) Length of data
   usAdsDataType  : UNSIGNED16;     // (I) Type of data
   pRecBuf        : PAdsBuffer;          // (I/O) Pointer to active buffer
   Field          : TField          // (I) Field Object
) : Boolean;
Var
   ulCounter : UNSIGNED32;
   bNull     : WordBool;
Begin
{$IFDEF CALLTRACE}
   WriteCallTrace( 'IsFieldBlank' );
{$ENDIF}

   Result := False;   // default to return False

   if musAceTableType = ADS_ADT then
      case usAdsDataType of
         ADS_LOGICAL :
            { empty if space }
            begin
               Result := pcData^ = AdsBufferItem( ' ' );
               exit;
            end;

         ADS_NUMERIC,
         ADS_DATE,
         ADS_STRING,
         ADS_CISTRING,
         ADS_COMPACTDATE,
{$IFDEF ADSDELPHI2008_OR_NEWER}
         ADS_NCHAR,
{$ENDIF}
         ADS_RAW:
            { empty if all 0's }
            for ulCounter := 0 to ulDataLen - 1 do
               if ( pcData[ ulCounter ] <> AdsBufferItem( #0 ) ) then
                  Exit;

         ADS_MEMO,
         ADS_BINARY,
         ADS_IMAGE,
{$IFDEF ADSDELPHI2008_OR_NEWER}
         ADS_NMEMO,
{$ENDIF}
         ADS_VARCHAR :
         Begin
            Result := ( pUNSIGNED32( pcData )^ = 0 );
            Exit;
         End;

         ADS_CURDOUBLE,
         ADS_DOUBLE:
            { empty if using this byte sequence
              \x020\x000\x000\x000\x000\x000\x000\x080
              The checks below are goofy because of Endian changes and
              I checked it against two sets of 4 bytes
            }
            if ( pUNSIGNED32( pcData )^ <> $00000020 ) then
               exit
            else if ( pUNSIGNED32( pcData + 4 )^ <> $80000000 ) then
               exit;

{$IFDEF ADSDELPHI5_OR_NEWER }
         ADS_MONEY,
         ADS_ROWVERSION:
            if ( pSIGNED64 ( pcData )^ <> $8000000000000000 ) then
               exit;
{$ENDIF}

         ADS_INTEGER:
            { empty if using this byte sequence
              \x000\x000\x000\x080
              The checks below are goofy because of Endian changes
            }
            if ( pUNSIGNED32( pcData )^ <> $80000000 ) then
               exit;

         ADS_SHORTINT:
            { empty if using this byte sequence
              \x000\x080
              The checks below are goofy because of Endian changes
            }
            if ( pUNSIGNED16( pcData )^ <> $8000 ) then
               exit;

         ADS_TIME:
            { empty if using this byte sequence
              \x0ff\x0ff\x0ff\x0ff
              The checks below are goofy because of Endian changes
            }
            if ( pUNSIGNED32( pcData )^ <> $FFFFFFFF ) then
               exit;

         ADS_TIMESTAMP,
         ADS_MODTIME:
            { empty if using this byte sequence
              \x000\x000\x000\x000\x0ff\x0ff\x0ff\x0ff
              Only check the first 4 bytes so that nulls written prior to
              version 5.5 still work
              The checks below are goofy because of Endian changes and
              I checked it against two sets of 4 bytes
            }
            if ( pUNSIGNED32( pcData )^ <> $00000000 ) then
               exit;

         ADS_AUTOINC :
            Begin
               {  empty if all 0xFF's }
               Result := ( pUNSIGNED32( pcData )^ = $FFFFFFFF );
               Exit;
            end;

         ADS_VARCHAR_FOX,
{$IFDEF ADSDELPHI2008_OR_NEWER}
         ADS_NVARCHAR,
{$ENDIF}
         ADS_VARBINARY_FOX :
         begin
            {*
             * Empty if the length portion of the field is $FFFF or 0.
             * Note:  ADT Var*Fox fields have two bytes following the data that
             * contain the length
             *}
            Result := ( pUNSIGNED16( pcData + ulDataLen )^ = $FFFF ) or
                      ( pUNSIGNED16( pcData + ulDataLen )^ = $0 );
            Exit;

         end; { ads_varbinary_fox }

      End {  Case }

   else if musAceTableType = ADS_VFP then
   begin
      // For most fields, Return True if the field can be and is NULL.  There are a few exceptions...
      // for these fields, the empty field value can is not recognized as a valid value for the field
      // type, so return the field value as "null".
      case usAdsDataType of
         ADS_LOGICAL,
         ADS_NUMERIC,
         ADS_DATE :
         Begin
            {  empty if all spaces }
            Result := True;
            for ulCounter := 0 to ulDataLen - 1 do
               if pcData[ ulCounter ] <> AdsBufferItem( ' ' ) then
               begin
                  Result := False;
                  break;
               end;
         End;

{$IFDEF ADSDELPHI2008_OR_NEWER}
         ADS_NVARCHAR:
            {*
             * Empty if the length portion of the field is $FFFF or 0.
             *}
            Result := ( pUNSIGNED16( pcData + ulDataLen )^ = $FFFF ) or
                      ( pUNSIGNED16( pcData + ulDataLen )^ = $0 );


         ADS_NMEMO,
{$ENDIF}
         ADS_MEMO,
         ADS_BINARY,
         ADS_IMAGE:
            {The record buffer already indicates null/emptiness for these fields}
            Result := ( pUNSIGNED32( pcData )^ = 0 );

         ADS_TIMESTAMP:
            { empty if the first four bytes are 0's }
            if ( pUNSIGNED32( pcData )^ = $00000000 ) then
               Result := True

      End; { case }

      // If we already know the field is blank, go ahead and exit.
      if Result = True then
         Exit;

      // Return true at this point IFF the field can be and is indeed null.
      if FACEFieldDefs[ Field.FieldNo - 1 ].Nullable then
      begin
         // Retrieve the Null Flag for this field.
         ACECHECK( self, ACEUNPUB.AdsAccessVfpSystemField( mlHandle,
{$IFDEF FPC} {$HINTS OFF} {$ENDIF} { Disable FPC hints to avoid ptr Conversion hint }
                                                           ADSFIELD( UNSIGNED32( FACEFieldDefs[ Field.FieldNo - 1 ].FieldNumber )),
{$IFDEF FPC} {$HINTS ON} {$ENDIF}
                                                           PAceChar( pRecBuf ),
                                                           ADS_RETRIEVE_NULL_FLAG,
                                                           @bNull ));
         // The return value should be whatever bNull is
         Result := bNull;
      end;

      Exit;
   end { if musAceTableType = ADS_VFP }


   else { table type is DBF }
      case usAdsDataType of
         ADS_LOGICAL,
         ADS_NUMERIC,
         ADS_STRING :
         Begin
            {  empty if all spaces or 0's }
            for ulCounter := 0 to ulDataLen - 1 do
               if ( pcData[ ulCounter ] <> AdsBufferItem( #0 ) ) And ( pcData[ ulCounter ] <> AdsBufferItem( ' ' ) ) then
                  Exit;
         End;

{$IFDEF ADSDELPHI2008_OR_NEWER}
         ADS_NCHAR:
         begin
            { empty if all spaces or 0's -- but must compare double-byte chars }
            for ulCounter := 0 to TRUNC( ulDataLen / 2 )- 1 do
               if ( WideChar( pcData[ ulCounter ] ) <> WideChar( #0 )) and ( WideChar( pcData[ ulCounter ] ) <> WideChar( ' ' )) then
                  Exit;
         end;

         ADS_NVARCHAR:
         begin
            Result := ( pUNSIGNED16( pcData + ulDataLen )^ = $FFFF ) or
                      ( pUNSIGNED16( pcData + ulDataLen )^ = $0 );
            Exit;
         end;
{$ENDIF}

         ADS_COMPACTDATE :
            {  empty if all 0's }
            for ulCounter := 0 to ulDataLen - 1 do
               if pcData[ ulCounter ] <> AdsBufferItem( #0 ) then
                  Exit;

         ADS_DATE :
         begin
            {  For table type ADS_ADT, the ADS_DATE field is a 4 byte julian date and we }
            {  consider it blank if it is 0 }
            if ulDataLen = 4 then
            begin
               Result := ( pUNSIGNED32( pcData )^ = 0 );
               Exit;
            end;

            {  For classic date field, we say it is blank if they are all 0's or spaces }
            for ulCounter := 0 to ulDataLen - 1 do
               if ( pcData[ ulCounter ] <> AdsBufferItem( #0 ) ) And ( pcData[ ulCounter ] <> AdsBufferItem( ' ' ) ) then
                  Exit;
         end;

         ADS_DOUBLE,
         ADS_CURDOUBLE,
         ADS_INTEGER,
         ADS_SHORTINT :
            Exit;  // these field types are never blank

{$IFDEF ADSDELPHI2008_OR_NEWER}
         ADS_NMEMO,
{$ENDIF}
         ADS_MEMO,
         ADS_BINARY,
         ADS_IMAGE,
         ADS_VARCHAR :
         Begin
            Result := ( pUNSIGNED32( pcData )^ = 0 );
            Exit;
         End;
      End; {  Case }


   Result := True;
End;  { IsFieldBlank }


{**********************************************************
*  Module:  TAdsDataSet.ADSGetDataField
*  Input:
*           sFieldNo         - field number
*           eDelphiFieldType - data type of the field
*           pRecBuf          - Active record buffer
*           pBuffer          - Return buffer for retrieved data
*           bIsBlank          - whether the field is blank or not
*  Output:  bIsBlank
*           pBuffer
*  Return:  True if function is successful
*  Description: Procedure to retrieve a field
**********************************************************}
function TAdsDataSet.ADSGetDataField( Field            : TField;
                                      pRecBuf          : PAdsBuffer;
                                      pBuffer          : Pointer;
                                      var bIsBlank     : Boolean ) : Boolean;
var
   usAdsFieldType  : UNSIGNED16;
   pcData          : PAdsBuffer;
   ulOffset        : UNSIGNED32;
   ulFieldLength   : UNSIGNED32;

   pcSavedCharPos  : PAdsBuffer;
   cSavedChar      : AdsBufferItem;
   sCount          : SIGNED16;
   dDate           : Double;
   strTemp         : string;
   usDataLength    : UNSIGNED16;
   bFull           : WordBool;
{$IFDEF ADSDELPHI2008_OR_NEWER}
   ulCodeUnits     : UNSIGNED32;
{$ENDIF}
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.ADSGetDataField' );
{$ENDIF }

   Result := False;

   {  Get the field type, offset and length }
   usAdsFieldType := FACEFieldDefs[ Field.FieldNo - 1 ].FieldType;
   ulOffset := FACEFieldDefs[ Field.FieldNo - 1 ].Offset;
   ulFieldLength := FACEFieldDefs[ Field.FieldNo - 1 ].Length;

   {  Point to the right place in the record buffer to retrieve data }
   pcData := pRecBuf + ulOffset;

   if ( state in [ dsEdit, dsInsert ] ) And
{$IFDEF ADSDELPHI2008_OR_NEWER}
      ( usAdsFieldType in  [ ADS_MEMO, ADS_BINARY, ADS_VARCHAR, ADS_IMAGE, ADS_NMEMO ] ) then
{$ELSE}
      ( usAdsFieldType in  [ ADS_MEMO, ADS_BINARY, ADS_VARCHAR, ADS_IMAGE ] ) then
{$ENDIF}
      bIsBlank := IsBlobBlank( pRecBuf, Field as TBlobField, pcData, usAdsFieldType )
   else
      bIsBlank := IsFieldBlank( pcData, ulFieldLength, usAdsFieldType, pRecBuf,
                                Field );

{$IFDEF CALLTRACE }
   if bIsBlank and ( eDelphiFieldType = ftSmallInt ) then
      bIsBlank := bIsBlank;
{$ENDIF }
   {  There are times when the buffer passed in is nil for field data we are }
   {  not concerned with.  We don't need to get any thing just return true }
   if ( pBuffer = nil ) Or bIsBlank then
   begin
      Result := True;
      exit;
   end;

   Case usAdsFieldType of
      ADS_STRING,
      ADS_CISTRING :
      begin
         {  Get field data from current record buffer }
         for sCount := 0 to ulFieldLength - 1 do
            PAdsBuffer( pBuffer )[sCount] := pcData[ sCount ];

         {  null terminate the string }
         PAceChar( pBuffer )[ulFieldLength] := #0;

         {  Right trim the string }
         dec( ulFieldLength );
         while ulFieldLength <> 0 do
         begin
            if PAceChar( pBuffer )[ulFieldLength] = ' ' then
               PAceChar( pBuffer )[ulFieldLength] := #0
            else
               Exit;

            dec( ulFieldLength );
         end;

         if PAceChar( pBuffer )[ulFieldLength] = ' ' then
            PAceChar( pBuffer )[ulFieldLength] := #0
      end;

{$IFDEF ADSDELPHI2008_OR_NEWER}
      ADS_NCHAR,
      ADS_NVARCHAR:
      begin

         // These two types store length differently.
         if ADS_NVARCHAR = usAdsFieldType then
         begin
            // For NVarChar, the actual length is in the last two bytes
            ulCodeUnits := UNSIGNED32( PUNSIGNED16( pcData + ulFieldLength )^ );

            // Also, initialize the buffer.
            FillMemory( pBuffer, ulFieldLength, Byte( #0 ) );
         end
         else // The field is an NCHAR.
            ulCodeUnits := TRUNC( ulFieldLength / 2 );

         for sCount := 0 to ulCodeUnits - 1 do
            PWideChar( pBuffer )[sCount] := PWideChar( pcData )[sCount];

         { null terminate the string }
         PWideChar( pBuffer )[ulCodeUnits] := #0;

         { Right Trim the string }
         dec( ulCodeUnits );

         while ulCodeUnits <> 0 do
         begin
            if PWideChar( pBuffer )[ulCodeUnits] = WideChar( ' ' ) then
               PWideChar( pBuffer )[ulCodeUnits] := #0
            else
               Exit;

            dec( ulCodeUnits );
         end;

         if PWideChar( pBuffer )[ulCodeUnits] = WideChar( ' ' ) then
            PWideChar( pBuffer )[ulCodeUnits] := #0;


      end;

{$ENDIF}

      ADS_INTEGER,
      ADS_AUTOINC :
         PInteger( pBuffer )^ := PInteger( pcData )^;

      ADS_SHORTINT :
         PSIGNED16( pBuffer )^ := PSIGNED16( pcData )^;

      ADS_CURDOUBLE,
      ADS_DOUBLE :
      begin
         PDouble( pBuffer )^ := PDouble( pcData )^;
      end;

{$IFDEF ADSDELPHI5_OR_NEWER }
      ADS_MONEY :
         {* Convert the currency field value to BCD, then TDataSet will
            convert it back to currency for us *}
         CurrToBCD( PCurrency( pcData )^, TBcd( pBuffer^), 20, 4 );

      ADS_ROWVERSION:
         PBcd( pBuffer )^ := StrToBcd( IntToStr( PSIGNED64( pcData )^ ));
{$ENDIF}

      ADS_NUMERIC :
      begin
         pcSavedCharPos := pcData + ulFieldLength;
         cSavedChar := pcSavedCharPos^;
         Try
            {  NULL terminate the buffer so we can use Delphi function }
            pcSavedCharPos^ := AdsBufferItem( #0 );

            Try

               // Note: Return the data based on the field's data type. BCD types are
               // only available in Delphi 6 and new
{$IFDEF ADSDELPHI6_OR_NEWER }
               if ( Field.DataType = ftFMTBcd ) or ( Field.DataType = ftBcd ) then
               begin
                  // Skip leading blanks
                  while pcData[0] = AdsBufferItem( ' ' ) do
                     inc( pcData );

                  strTemp := StringReplace( string( PAceChar( pcData ) ), '.', DecimalSeparator, [] );
                  PBcd( pBuffer )^ := StrToBcd( strTemp );
               end
               else
{$ENDIF}
               if Field.DataType = ftSmallInt then
                  pSIGNED16( pBuffer )^ := StrToInt( string( PAceChar( pcData ) ) )
               else
               begin
                  {  Replace our . with the current delphi decimal global before calling }
                  {  the delphi conversion function. }
                  strTemp := StringReplace( string( PAceChar( pcData ) ), '.', DecimalSeparator, [] );
                  pDouble( pBuffer )^ := StrToFloat( strTemp );
               end;
            Except On EConvertError Do;
               { Catch conversion error here because it maybe due to encrypted record }
            End;

         Finally
            pcSavedCharPos^ := cSavedChar;
         End;  { Try }
      end;

      ADS_DATE :
         {  ADT date field is already in the 4 byte integer format }
         if ulFieldLength = 4 then
            pTDateTimeRec( pBuffer )^.Date := pUNSIGNED32( pcData )^ - JULIAN_TO_DELPHI_DATE
         else
         begin
            {  For classic DBF, we need to convert the string to Julian first }
            pcSavedCharPos := pcData + ulFieldLength;
            cSavedChar := pcSavedCharPos^;

            {  NULL terminate the buffer so we can use ACE function }
            pcSavedCharPos^ := AdsBufferItem( #0 );

            Try
               {  convert string to julian for manipulation.  Assume YYYYMMDD and parse out }
               {  The conversion may fail due to encryption, and we do not want to throw exception }
               {  in here, so we simply igore any error returned by ACE. }
               ACEUNPUB.AdsConvertStringToJulian( PAceChar( pcData ), ulFieldLength, @dDate );

               {  Convert the TimeStamp to a TDateTimeRec }
               pTDateTimeRec( pBuffer )^.Date := trunc( dDate - JULIAN_TO_DELPHI_DATE );

            Finally
               pcSavedCharPos^ := cSavedChar;
            End;  { Try }
         end;

      ADS_LOGICAL :
         {  If there is a T then the value is true, Delphi uses 2 byte bool }

         // Ignore "widechar reduced in sets" warning in statement below.
         {$IFDEF ADSDELPHI2008_OR_NEWER}
            {$WARN WIDECHAR_REDUCED OFF}
         {$ENDIF}

         pWordBool( pBuffer )^ :=  Char( pcData^ ) in [ 'T', 't', 'Y', 'y', '1' ];

         {$IFDEF ADSDELPHI2008_OR_NEWER}
            {$WARN WIDECHAR_REDUCED ON}
         {$ENDIF}

      ADS_TIME :
         pTDateTimeRec( pBuffer )^.Time := PUNSIGNED32( pcData )^;

      ADS_TIMESTAMP,
      ADS_MODTIME :
         begin

         { For VFP tables, the number of milliseconds must be increased by 1, unless
           the number of milliseconds is zero -- in which case, the same calculation
           that is employed for ADT tables will work here, too. }
         if ( musAceTableType = ADS_VFP ) and ( PUNSIGNED32( pcData + 4 )^ <> 0 ) then

            { The value returned must be a double. The double contains the number of
              millisecs since Jan 0, 0000
              Need the 1.0 to convert it to a float }
            pDouble( pBuffer )^ := ( 1.0 * pUNSIGNED32( pcData )^ -
                                   JULIAN_TO_DELPHI_DATE ) * MSEC_PER_DAY +
                                   ( PUNSIGNED32( pcData + 4 )^ + 1 )
         else

            { The value returned must be a double. The double contains the number of
              millisecs since Jan 0, 0000
              Need the 1.0 to convert it to a float }
            pDouble( pBuffer )^ := ( 1.0 * pUNSIGNED32( pcData )^ -
                                   JULIAN_TO_DELPHI_DATE ) * MSEC_PER_DAY +
                                   PUNSIGNED32( pcData + 4 )^;

         if pDouble( pBuffer )^ < 0 then
            pDouble( pBuffer )^ := 0;
         end;

      ADS_RAW :
         {  Get field data from current record buffer }
         for sCount := 0 to ulFieldLength - 1 do
            PAdsBuffer( pBuffer )[sCount] := pcData[ sCount ];

      ADS_COMPACTDATE :
      begin
         {  The conversion may fail due to encryption, and we do not want to throw exception }
         {  in here, so we simply igore any error returned by ACE. }
         ACEUNPUB.AdsConvertStringToJulian( PAceChar( AnsiString( GetCompactDate( pcData ) ) ), 8, @dDate );

         {  Convert the TimeStamp to a TDateTimeRec }
         pTDateTimeRec( pBuffer )^.Date := trunc( dDate - JULIAN_TO_DELPHI_DATE );
      end;

      ADS_VARCHAR_FOX,
      ADS_VARBINARY_FOX :
      begin
         FillMemory( pBuffer, ulFieldLength, Byte( #0 ));

         // initialize usDataLength to prevent warning
         usDataLength := ulFieldLength;

         // Get the actual data length
         if musAceTableType = ADS_ADT then
            // Actual Data Len is in the last two bytes
            usDataLength := PUNSIGNED16( pcData + ulFieldLength )^
         else if musAceTableType = ADS_VFP then
         begin
            ACECHECK( self, ACEUNPUB.AdsAccessVfpSystemField( mlHandle,
{$IFDEF FPC} {$HINTS OFF} {$ENDIF} { Disable FPC hints to avoid ptr Conversion hint }
                                                              ADSFIELD( UNSIGNED32( FACEFieldDefs[ Field.FieldNo - 1].FieldNumber )),
{$IFDEF FPC} {$HINTS ON} {$ENDIF}
                                                              PAceChar( pRecBuf ),
                                                              ADS_RETRIEVE_FULL_FLAG,
                                                              @bFull ));

            { If the field is full, the data length is the field length.  otherwise, it is stored
              in the last byte of the field buffer. }
            if bFull = True then
               usDataLength := ulFieldLength
            else
               usDataLength := UNSIGNED16( pcData[ ulFieldLength - 1 ] );
         end; { if musAceTableType... }

         // ftVarBytes fields do some weird stuff with the length; so handle VarBinary separately
         if usAdsFieldType = ADS_VARBINARY_FOX then
         begin
            { ftVarBytes fields have the data length as the first two bytes. }
            PUNSIGNED16( pBuffer )^ := usDataLength;

            {  Get field data from current record buffer }
            for sCount := 0 to usDataLength - 1 do
               PAdsBuffer( pBuffer )[sCount + 2] := pcData[ sCount ];
         end
         else if usAdsFieldType = ADS_VARCHAR_FOX then
         begin
            {  Get field data from current record buffer }
            for sCount := 0 to usDataLength - 1 do
               PAdsBuffer( pBuffer )[sCount] := pcData[ sCount ];

            PAceChar( pBuffer )[usDataLength] := #0;

            { Right-trim the string if it's not empty. }
            if usDataLength <> 0 then
               begin
                  dec( usDataLength );
                  while usDataLength <> 0 do
                  begin
                     if PAceChar( pBuffer )[usDataLength] = ' ' then
                        PAceChar( pBuffer )[usDataLength] := #0
                     else
                        Break;

                     dec( usDataLength );
                  end;

                  if PAceChar( pBuffer )[usDataLength] = ' ' then
                     PAceChar( pBuffer )[usDataLength] := #0;
               end; { usDataLen > 0 }
         end; { ADS_VARCHAR_FOX }

      end;  { ADS_VARCHAR_FOX/ADS_VARBINARY_FOX }

   end;{  Case }
end;  { TAdsDataSet.ADSGetDataField }

{**********************************************************
*  Module:  TAdsDataSet.GetActiveRecBuf
*  Input:   RecBuf - The buffer to return active record buffer
*  Output:  RecBuf
*  Return:  Boolean - Successful
*  Description: Given certain state get TDataSets Active record
*  buffer
**********************************************************}
function TAdsDataSet.GetActiveRecBuf( var pRecBuf: PAdsBuffer ): Boolean;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.GetActiveRecBuf' );
{$ENDIF }

   {  This will return the appropriate buffer on the GetActiveRecBuf call }
   {  The buffer returned is determined by the State of the DataSet }
   case State of
{$IFDEF ADSDELPHI4_OR_NEWER}
      dsBlockRead,   {* dsBlockRead is used when filling a TClientDataSet and the
                      * PacketRecords property <> -1 *}
{$ENDIF}
      dsBrowse:
      begin
         if IsEmpty then
            pRecBuf := nil
         else
            pRecBuf := ActiveBuffer();
      end;
      dsEdit, dsInsert:
         pRecBuf := ActiveBuffer();
      dsSetKey:
         pRecBuf := PAdsBuffer( mpstKeyBuffer ) + SizeOf( TAdsKeyBuffer );
      dsNewValue:
         pRecBuf := ActiveBuffer;
      dsOldValue:
         pRecBuf := FOldRecordBuffer;
      dsCalcFields:
         pRecBuf := CalcBuffer;
      dsFilter:
         pRecBuf := mpFilterBuffer;
   else
      pRecBuf := nil;
   end;

   {  if the recbuf is not equal to nil then return true }
   Result := pRecBuf <> nil;

end;  { GetActiveRecBuf }

{**********************************************************
*  Module:  TAdsDataSet.GetRecordSize
*  Input:
*  Output:
*  Return:  Word
*  Description: Overridden function that returns the object members
*  record size that was generated on open
**********************************************************}
function TAdsDataSet.GetRecordSize: Word;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.GetRecordSize' );
{$ENDIF }

   Result := musRecordSize;
end;

{**********************************************************
*  Module:  TAdsDataSet.InternalFirst
*  Input:
*  Output:
*  Description: Overridden procedure to set cursor to the
*  beginning of the dataset
**********************************************************}
procedure TAdsDataSet.InternalFirst;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.InternalFirst' );
{$ENDIF }

   {  first needs to set us one before the first record }
   ACECheck( self, ACEUNPUB.AdsGotoBOF( ActiveHandle ));

end;

{**********************************************************
*  Module:  TAdsDataSet.InternalGotoBookmark
*  Input:  Bookmark - record number
*  Output:
*  Description: Overridden procedure to go right to bookmark
*  record
**********************************************************}
procedure TAdsDataSet.InternalGotoBookmark( Bookmark: Pointer );
var
   ulRetVal : UNSIGNED32;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.InternalGotoBookmark' );
{$ENDIF }

   {  if we are in insert state then we need to act like an append }
   if Not ( State = dsInsert ) then
   begin
      {  This will seek the cursor to the record number held by the integer value }
      {  in the variable Bookmark }
      ulRetVal := ACE.AdsGotoBookmark( Handle, PUNSIGNED32( Bookmark )^ );
      if ( ulRetVal <> AE_INVALID_RECORD_NUMBER ) then
         ACECheck( self, ulRetVal );
   end;
end;


{**********************************************************
*  Module:  TAdsDataSet.InternalHandleException
*  Input:
*  Output:
*  Description: Overridden procedure to see if it is being called
**********************************************************}
procedure TAdsDataSet.InternalHandleException;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.InternalHandleException' );
{$ENDIF }

   {*
    * If this is a design-time error we will have the function
    * pointer available and call TApplication.HandleException.
    * If not then don't do anything. From what I can tell this
    * is only called by TDataSet when it gets an exception at
    * design-time.
    *}
   if assigned( HandleExceptionProc ) then
      HandleExceptionProc(Self);

end;

{**********************************************************
*  Module:  TAdsDataSet.InternalInsert
*  Input:
*  Output:
*  Description: This function get called after the dataset finish append/insert
*               a new record and initialized the record buffer.  It is overridden
*               because the dataset's insert (but not append) procedure copies
*               the bookmark from the old record buffer to the new record buffer
*               causing our blob stream to display wrong data.
**********************************************************}
procedure TAdsDataSet.InternalInsert;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.InternalInsert' );
{$ENDIF }

   PUNSIGNED32( ActiveBuffer + musBookmarkOfs )^ := 0;

   {* Free old record buffer used to return TField.OldValue, so we don't
    * read old field values from the previous record we were on. *}
   FreeOldRecordBuffer;

end;  {  TAdsDataSet.InternalInsert }


{**********************************************************
*  Module:  TAdsDataSet.InternalInitFieldDefs
*  Input:
*  Output:
*  Description: Overridden procedure to set up the field definitions
**********************************************************}
procedure TAdsDataSet.InternalInitFieldDefs;
var
   sCount : SIGNED16;
   usFieldCount : UNSIGNED16;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.InternalInitFieldDefs' );
{$ENDIF }

   {  Get number of fields. }
   ACECheck( self, ACE.AdsGetNumFields( self.Handle, @usFieldcount ) );
   FieldDefs.Clear;
   FACEFieldDefs.Clear;

   {  Create field definitions. }
   for sCount := 1 to usFieldCount do
   begin
      AddFieldDesc( self.Handle, sCount );
   end;
end;

{**********************************************************
*  Module:  TAdsDataSet.AddFieldDesc
*  Input:
*  Output:
*  Description: Procedure to add a field definition
**********************************************************}
procedure TAdsDataSet.AddFieldDesc( hTableHandle : ADSHANDLE;  // (I) Table Handle
                                    sFieldNum : SIGNED16       // (I) Field Number
                                  );
var
   usFieldType    : UNSIGNED16;
   ulFieldSize    : UNSIGNED32;
   usFieldDecimal : UNSIGNED16;
   pcFieldName    : PAnsiChar;
   acFieldName    : array[0..ADS_MAX_FIELD_NAME] of ansichar;
   usFieldNameLen : UNSIGNED16;

   poFieldType    : TFieldType;  // Delphi field type
   usDelphiSize   : UNSIGNED16;  // Delphi field size
   usNullable     : UNSIGNED16;  // NullableField
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.AddFieldDesc' );
{$ENDIF }

   usDelphiSize   := 0;
   usFieldDecimal := 0;

{$IFDEF FPC} {$HINTS OFF} {$ENDIF} { Disable FPC hints to avoid ptr Conversion hint }
   pcFieldName := PAnsiChar( UNSIGNED32( sFieldNum ) );
{$IFDEF FPC} {$HINTS ON} {$ENDIF}

   {  Get the field type }
   ACECheck( self, ACE.AdsGetFieldType( hTableHandle, pcFieldName, @usFieldType ) );

   {  Get the field length }
   ACECheck( self, ACE.AdsGetFieldLength( hTableHandle, pcFieldName, @ulFieldSize ) );

   {  Key off of the field type to determine the correct Delphi field type for the }
   {  TDataSets list of field descriptions }
   {  Except for BCE, Blob and string types, all other type should have size = 0 }
   case usFieldType of
      ADS_LOGICAL    : poFieldType := ftBoolean;

      ADS_DOUBLE     : poFieldType := ftFloat;

      ADS_CURDOUBLE  : poFieldType := ftCurrency;

{$IFDEF ADSDELPHI5_OR_NEWER }
      ADS_MONEY      :
      begin
         poFieldType := ftBCD;
         usDelphiSize := 4; {* 4 implied decimals *}
      end;

      ADS_ROWVERSION :
      begin
         poFieldType := ftBCD;
         usDelphiSize := 0;
      end;
{$ENDIF}

      ADS_INTEGER    : poFieldType := ftInteger;

      ADS_SHORTINT   : poFieldType := ftSmallInt;

      ADS_AUTOINC    : poFieldType := ftAutoInc;

      ADS_RAW        :
      begin
         poFieldType := ftBytes;
         usDelphiSize := ulFieldSize;
      end;

      ADS_TIME       : poFieldType := ftTime;

      ADS_TIMESTAMP, ADS_MODTIME : poFieldType := ftDateTime;

      ADS_DATE, ADS_COMPACTDATE : poFieldType := ftDate;

      ADS_NUMERIC :
      begin
         ACECheck( self, ACE.AdsGetFieldDecimals( hTableHandle, pcFieldName, @usFieldDecimal ) );

         {*
          * Delphi 6 and newer have true BCD support so we will use that to support the ADT numeric field
          * type. For DBF, we still use the old method for backward compatibility. For Delphi 5 and
          * earlier, we have no choice but to use the old method even for ADT table
          *}

{$IFDEF ADSDELPHI6_OR_NEWER }

         if ( musAceTableType = ADS_ADT ) and not mpoAdsTableOptions.mbNumericsAsFloats then
         begin
            usDelphiSize := usFieldDecimal;

            if  ( usFieldDecimal > 4 ) or ( ulFieldSize >= 19 ) then
               poFieldType := ftFmtBcd
            else
               poFieldType := ftBcd;   // this is suppose to be more efficient.
         end
         else
{$ENDIF}
         if 0 <> usFieldDecimal then
            poFieldType := ftFloat
         else
         begin
            {  if physical field length is 4 or less, then we can put in a 16 bit int }
            if ulFieldSize < 5 then
               poFieldType := ftSmallint
            {  This is more accurate but commented out to match BDE behaviors
            else if ulFieldSize < 10 then
               poFieldType = ftInteger
            }
            else
               poFieldType := ftFloat;
         end;
      end;

      ADS_STRING,
      ADS_CISTRING :
      begin
         poFieldType := ftString;
         usDelphiSize := ulFieldSize;
      end;

      ADS_BINARY, ADS_IMAGE :
      begin
         poFieldType := ftBlob;
         usDelphiSize := 1;
      end;

      ADS_VARCHAR, ADS_MEMO :
      begin
         poFieldType := ftMemo;
         usDelphiSize := 1;
      end;

      ADS_VARCHAR_FOX :
      begin
         poFieldType := ftString;
         usDelphiSize := ulFieldSize;
      end; { ads_varchar_fox }

      ADS_VARBINARY_FOX :
      begin
         poFieldType := ftVarBytes;
         usDelphiSize := ulFieldSize;

      end; { ads_varbinary_fox }

      ADS_FOXGENERAL, ADS_FOXPICTURE :
      begin
        poFieldType := ftBLOB;
        usDelphiSize := 1;
      end; { ads_foxgeneral, ads_foxpicture }

{$IFDEF ADSDELPHI2008_OR_NEWER }
      ADS_NCHAR, ADS_NVARCHAR :
      begin
         poFieldType := ftWideString;

         // The field length is returned in code units
         usDelphiSize := ulFieldSize;
         // Internally, we want the physical length in our field defs collection
         ulFieldSize := ulFieldSize * 2;
      end;

      ADS_NMEMO :
      begin
         poFieldType := ftWideMemo;
         usDelphiSize := 1;
      end;
{$ELSE}
      ADS_NCHAR, ADS_NVARCHAR, ADS_NMEMO :
      begin
         {*
          * This shouldn't happen unless someone uses a newer version of ACE with an
          * older version of the delphi client. In that case ACE might know about new
          * Unicode field types that this client does not.  Return a useful error string.
          *}
          raise EADSDatabaseError.Create( self, AE_TADSDATASET_GENERAL,
             'Unicode field type (' + IntToStr( usFieldType ) + ') encountered.  Unicode field support requires Delphi 2009 or newer.' );
      end;
{$ENDIF}

      else
         {*
          * This shouldn't happen unless someone uses a newer version of ACE with an
          * older version of the delphi client. In that case ACE might know about new
          * field types that this client does not.
          *}
         raise EADSDatabaseError.Create( self, AE_TADSDATASET_GENERAL,
            'Unknown field type (' + IntToStr( usFieldType ) + ') encountered.' );
   end;

   {  Get the field name given the field number }
   usFieldNameLen := SizeOf( acFieldName );
   ACECheck( self, ACE.AdsGetFieldName( hTableHandle, sFieldNum, @acFieldName, @usFieldNameLen ) );

   {  Create the field definition. }
   if poFieldType <> ftUnknown then
   begin
      FieldDefs.Add( string( acFieldName ), poFieldType, usDelphiSize, False );


{$IFDEF ADSDELPHI5_OR_NEWER }

      {* As the ADS_MONEY field is mapped to ftBCD, the precision must be set to
       * 20.  This may need to change if ftBCD is used for anything else.
       * For ADS_NUMERIC field in ADT table, if it is mapped to one of the BCD type,
       * then set the precision to match the field length.
       *}
{$IFDEF ADSDELPHI6_OR_NEWER }
      if ( usFieldType = ADS_NUMERIC ) and
         (( poFieldType = ftBCD ) or ( poFieldType = ftFMTBcd )) then
      begin
         try
            if usFieldDecimal <> 0 then
               FieldDefs.Find( string( acFieldName ) ).Precision := ulFieldSize - 2
            else
               FieldDefs.Find( string( acFieldName ) ).Precision := ulFieldSize - 1;
         except
            {* This really should never fail, but just in case... *}
         end;
      end
      else
{$ENDIF}
      if poFieldType = ftBCD then
      begin
         try
            FieldDefs.Find( string( acFieldName ) ).Precision := 20;
         except
            {* This really should never fail, but just in case... *}
         end;
      end;
{$ENDIF}


      {  Determine if the field is nullable }

      ACECheck( self, ACE.AdsIsNullable( hTableHandle, acFieldName, @usNullable ));

      {* Also maintain our own list of field objects with ACE-specific info. *}
      with ( FACEFieldDefs.Add ) do
      begin
         FieldName := string( acFieldName );
         FieldNumber := sFieldNum;
         Length := ulFieldSize;
         FieldType := usFieldType;
         Decimals := usFieldDecimal;
         Nullable := Boolean( usNullable );
         ACECheck( self, ACE.AdsGetFieldOffset( hTableHandle, pcFieldName, @Offset ) );
         ACECheck( self, ACEUNPUB.AdsGetColumnPermissions( hTableHandle, UNSIGNED16( sFieldNum ),
                                                           @Permissions ));
         Modified := FALSE;
      end;
   end;

end;  { TAdsDataSet.AddFieldDesc }

{**********************************************************
*  Module:  TAdsDataSet.InternalInitRecord
*  Input:   Buffer - the buffer to initialize
*  Output:  Buffer
*  Description: Overridden procedure to initialize a record buffer
**********************************************************}
procedure TAdsDataSet.InternalInitRecord( Buffer: PAdsBuffer );
var
   usFieldCount:     UNSIGNED16;
   usAdsFieldType:   UNSIGNED16;
   ulOffset:         UNSIGNED32;
   usNumFields:      UNSIGNED16;
   Field:            TField;
   strExpression:    String;
   dVal:             Double;
   bVal:             WORDBOOL;
   iVal:             Integer;
   stDateTime:       TDateTime;
   stDateTimeRec:    TDateTimeRec;
   strFieldName:     string;
{$IFDEF ADSDELPHI5_OR_NEWER }
   bcdVal:           TBcd;
{$ENDIF}

begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.InternalInitRecord' );
{$ENDIF }
   ACECheck( self, ACEUNPUB.AdsClearRecordBuffer( Handle, PAceChar( Buffer ), UNSIGNED32( musRecordSize ) ) );


   {
      Set the autoinc field to "empty" so that it is blank.  A value will replace
      it once the record is posted.
   }
   ACECheck( self, ACE.AdsGetNumFields( Handle, @usNumFields ) );

   for usFieldCount := 1 to usNumFields do
   begin
      {* If we are in edit state then this code was called from the
       * TDataSet.ClearFields method, which means we need to mark all of the
       * fields as being modified, so they are written later when the user
       * calls Post. *}
      if State = dsEdit then
         FACEFieldDefs[ usFieldCount - 1 ].Modified := TRUE
      else
         FACEFieldDefs[ usFieldCount - 1 ].Modified := FALSE;

      {  Get the field type }
      usAdsFieldType := FACEFieldDefs[ usFieldCount - 1 ].FieldType;
      ulOffset := FACEFieldDefs[ usFieldCount - 1 ].Offset;

      if usAdsFieldType = ADS_AUTOINC then
      begin
         if musAceTableType = ADS_ADT then
            PUNSIGNED32( Buffer + ulOffset )^ := $FFFFFFFF
         else if musAceTableType = ADS_VFP then
            PUNSIGNED32( Buffer + ulOffset )^ := $00000000;
      end
{$IFDEF ADSDELPHI2008_OR_NEWER}
      else if Not( usAdsFieldType in [ ADS_MEMO, ADS_IMAGE, ADS_BINARY, ADS_VARCHAR, ADS_NMEMO ] ) then
{$ELSE}
      else if Not( usAdsFieldType in [ ADS_MEMO, ADS_IMAGE, ADS_BINARY, ADS_VARCHAR ] ) then
{$ENDIF}
      begin
         {
         * Check to see if there is any default value set for the field.  Delphi documentation states
         * that the expression can be any SQL expression not involving field.  ADS version will only
         * take constant value.
         }
         strFieldName := FACEFieldDefs[ usFieldCount - 1 ].FieldName;

         Field := FindField( strFieldName );
         if ( Field <> nil ) and ( Field.DefaultExpression <> '' ) then
         begin
            strExpression := Trim( Field.DefaultExpression );
            try
               case usAdsFieldType of
                  ADS_STRING,
                  ADS_CISTRING,
                  ADS_VARCHAR_FOX:
                     if ( strExpression[1] = '''' ) and
                        ( strExpression[ Length( strExpression ) ] = '''' ) then
                     begin
                        strExpression := Copy( strExpression, 2, Length( strExpression ) - 2 );
                        ADSPutField( usFieldCount, ftString, Buffer, PAceChar( AnsiString( strExpression ) ));
                     end;

{$IFDEF ADSDELPHI2008_OR_NEWER }
                  ADS_NCHAR,
                  ADS_NVARCHAR:
                     if ( strExpression[1] = '''' ) and
                        ( strExpression[ Length( strExpression ) ] = '''' ) then
                     begin
                        strExpression := Copy( strExpression, 2, Length( strExpression ) - 2 );
                        AdsPutField( usFieldCount, ftWideString, Buffer, PWideChar( strExpression ));
                     end;
{$ENDIF}

                  ADS_LOGICAL:
                     begin
                        strExpression := UpperCase( strExpression );
                        if ( strExpression = 'TRUE' ) OR ( strExpression = 'T' ) OR
                           ( strExpression = '.T.' ) OR ( strExpression = '1' ) then
                           bVal := True
                        else
                           bVal := False;

                        ADSPutField( usFieldCount, ftBoolean, Buffer, @bVal );
                     end;

                  ADS_NUMERIC:
{$IFDEF ADSDELPHI6_OR_NEWER}
                     if ( musAceTableType = ADS_ADT ) and not mpoAdsTableOptions.mbNumericsAsFloats then
                     begin
                        bcdVal := StrToBcd( strExpression );
                        ADSPutField( usFieldCount, ftBCD, Buffer, @bcdVal );
                     end
                     else
{$ENDIF}
                     begin
                        dVal := StrToFloat( strExpression );
                        ADSPutField( usFieldCount, ftFloat, Buffer, @dVal );
                     end;

                  ADS_DOUBLE, ADS_CURDOUBLE:
                     begin
                        dVal := StrToFloat( strExpression );
                        ADSPutField( usFieldCount, ftFloat, Buffer, @dVal );
                     end;

                  {
                  * Short in and integer are both passed as integer.  There appear to be bug
                  * in AdsPutField which decodes the short int as PSIGNED16.  It is OK on
                  * x86 platform because of big-endien or whatever.
                  }
                  ADS_INTEGER, ADS_SHORTINT :
                  begin
                     iVal := StrToInt( strExpression );
                     if (( usAdsFieldType = ADS_SHORTINT ) And
                         (( iVal > High( smallint )) or ( iVal <= Low( smallint )))) or
                        ( iVal = Low( integer )) then
                        raise EADSDatabaseError.Create( self, 0, 'Numeric out of range:' + strExpression );

                     AdsPutField( usFieldCount, ftInteger, Buffer, @iVal );
                  end;

{$IFDEF ADSDELPHI5_OR_NEWER }
                  ADS_MONEY,
                  ADS_ROWVERSION:
                  begin
                     bcdVal := StrToBcd( strExpression );
                     AdsPutField( usFieldCount, ftBCD, Buffer, @bcdVal );
                  end;
{$ENDIF}
                  ADS_DATE, ADS_COMPACTDATE:
                  begin
                     stDateTime := StrToDate( strExpression );
                     stDateTimeRec.Date := Integer( Trunc( stDateTime )) + DateDelta;
                     AdsPutField( usFieldCount, ftDate, Buffer, @stDateTimeRec );
                  end;

                  ADS_TIME:
                  begin
                     stDateTime := StrToTime( strExpression );
                     stDateTimeRec.Time := Integer(Round(Frac( stDateTime ) * MSecsPerDay ));
                     AdsPutField( usFieldCount, ftTime, Buffer, @stDateTimeRec );
                  end;

                  ADS_TIMESTAMP, ADS_MODTIME:
                  begin
                     stDateTime := strToDateTime( strExpression );
                     stDateTimeRec.DateTime := ( stDateTime + DateDelta ) * MSecsPerDay;
                     AdsPutField( usFieldCount, ftDateTime, Buffer, @stDateTimeRec );
                  end;

               end;  { case usAdsFieldType of }

            except
               on E: EADSDatabaseError do
                  raise EADSDatabaseError.Create( self, 0,
                                                  'Error setting default field value. (' + Field.DisplayName + ')' + #13 + #10 + E.Message );
               on E: EConvertError do
                  raise EADSDatabaseError.Create( self, 0,
                                                  'Error setting default field value. (' + Field.DisplayName + ')' + #13 + #10 + E.Message );
            end;  { Try }

            {* Mark the field as modified, so it will get posted *}
            FACEFieldDefs[ usFieldCount - 1 ].Modified := TRUE;

         end;  { if ( Field <> nil ) and ( Field.DefaultExpression <> '' ) then }

      end;  { else if Not( usAdsFieldType in [ ADS_MEMO, ADS_IMAGE, ADS_BINARY, ADS_VARCHAR ] ) then }

   end;  { for usFieldCount := 1 to usNumFields do }

   {  Clear all the blob cache.  If we are not in one of the states listed below,  }
   {  we do not care about the blob field, and should not try to access them. Otherwise, }
   {  bad things are going to happend. }
   if ( BlobFieldcount > 0 ) And
      ( state in [dsBrowse, dsEdit, dsInsert, dsNewValue, dsCalcFields] ) then
      for usFieldCount := 0 to BlobFieldCount - 1 do
         TAdsBlobCache( PBlobDataArray( Buffer + musBlobCacheOfs )[usFieldCount] ).ClearCache;

end;  {  InternalInitRecord }


{**********************************************************
*  Module:  TAdsDataSet.InternalLast
*  Input:
*  Output:
*  Description: Overridden procedure to seek the cursor to the
*  end of the dataset
**********************************************************}
procedure TAdsDataSet.InternalLast;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.InternalLast' );
{$ENDIF }

   {  Goto the bottom of the dataset }

   {  EOF for Delphi is one below the last record so skip 1 off the end }
   {  Do not need to check for EOF due to the resync that take place right }
   {  after this call that will handle empty set }
   ACECheck( self, ACEUNPUB.AdsGotoEOF( ActiveHandle ));

end;

{**********************************************************
*  Module:  TAdsDataSet.InternalSetToRecord
*  Input:   Buffer - ActiveBuffer
*  Output:
*  Description: Overridden procedure to set the cursor to the
*  specified bookmark
**********************************************************}
procedure TAdsDataSet.InternalSetToRecord( Buffer: PAdsBuffer );
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.InternalSetToRecord to : ' +
                   IntToStr( PUNSIGNED32( Buffer + musBookmarkOfs )^ ) );
{$ENDIF }

   {  Call the internalgotobookmark to set to the record }
   InternalGotoBookmark( Buffer + musBookmarkOfs );
end;

{**********************************************************
*  Module:  TAdsDataSet.SetBookmarkFlag
*  Input:   Buffer - Record buffer
*           Value - Value to set to the record info's bookmark flag
*  Output:  Buffer
*  Description: Overridden procedure to set the value passed in to the
*  record info structure on the end of the record buffers bookmark
*  flag value.
**********************************************************}
procedure TAdsDataSet.SetBookmarkFlag( Buffer: PAdsBuffer; Value: TBookmarkFlag );
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.SetBookmarkFlag' );
{$ENDIF }

   PRecInfo( Buffer + musRecInfoOfs ).BookmarkFlag := Value;
end;

{**********************************************************
*  Module:  TAdsDataSet.SetBookmarkData
*  Input:   Buffer, Data
*  Output:
*  Description: Overridden procedure to see if it is being called
**********************************************************}
procedure TAdsDataSet.SetBookmarkData( Buffer: PAdsBuffer; Data: Pointer );
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.SetBookmarkData' );
{$ENDIF }

   {  move what is in the supplied bookmark data buffer }
   {  into the record buffer's bookmark storage location }
   Move( Data^, Buffer[musBookmarkOfs], BookmarkSize );
end;

{**********************************************************
*  Module:  TAdsDataSet.SetFieldData
*  Input:   Field  - Field to set data to
*           Buffer - The buffer of data to set
*  Output:  Buffer
*  Description: Overridden procedure to change the data at
*  the current buffer
**********************************************************}
procedure TAdsDataSet.SetFieldData( Field: TField; Buffer: Pointer );
var
  pcRecBuf     : PAdsBuffer;
  pusFieldLens : PKeyFieldLenArray;
  SErrMsg      : string;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.SetFieldData' );
{$ENDIF }

   with Field do
   begin
      {  if the State of the DataSet is not in a write mode then give exception }
      if not ( State in dsWriteModes ) then
         raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL, SNotEditing );

      {  if the State is SetKey and there aren't any fields associated }
      {  then give an exception - This is Delphi specific functionality }
      if ( State = dsSetKey ) and
         ( ( FieldNo < 0 ) or ( IndexFieldCount > 0 ) and not IsIndexField ) then
         DatabaseErrorFmt(SNotIndexField, [DisplayName]);

      {  Get the Active record buffer }
      pcRecBuf := nil;
      GetActiveRecBuf( pcRecBuf );

      {  The following is Delphi specific checks to make sure that the DataSet State and }
      {  readonly flags have not been set }
      if FieldNo > 0 then
      begin
         if State = dsCalcFields then
            raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL, SNotEditing );
         if ReadOnly and not ( State in [dsSetKey, dsFilter] ) then
            DatabaseErrorFmt( SFieldReadOnly, [DisplayName] );
         if ( State in [dsEdit, dsInsert] ) then
            Validate( Buffer );

         if FieldKind <> fkInternalCalc then
         begin

            { Check for permission to update field }
            if  state = dsEdit then
            begin
               if 0 = ( FACEFieldDefs[ FieldNo - 1].Permissions And ADS_DD_COLUMN_PERMISSION_UPDATE ) then
               begin
                  SErrMsg := SNoUpdatePermission + FieldName + '.';
                  ACECheck( self, ACEUNPUB.AdsSetLastError( AE_PERMISSION_DENIED, PAceChar( AnsiString( SErrMsg ) )));
               end;
            end
            else if state = dsInsert then
            begin
               if 0 = ( FACEFieldDefs[ FieldNo - 1].Permissions And ADS_DD_COLUMN_PERMISSION_INSERT ) then
               begin
                  SErrMsg := SNoInsertPermission + FieldName + '.';
                  ACECheck( self, ACEUNPUB.AdsSetLastError( AE_PERMISSION_DENIED, PAceChar( AnsiString( SErrMsg ) )));
               end;
            end;

            {  put the field to the given buffer and to the database }
            ADSPutField( FieldNo, DataType, pcRecBuf, Buffer );

            FACEFieldDefs[ FieldNo - 1 ].Modified := TRUE;
         end;

         {  If we are in SetKey state, we update the keyfieldcount }
         if state = dsSetKey then
         begin
            {  pusFieldLens is to point at the first byte after the record buffer }
            pusFieldLens := PKeyFieldLenArray ( pcRecBuf + musRecordSize );
            if DataType = ftString then
               pusFieldLens^[ FieldNo ] := Length( PAceChar( Buffer ) )
{$IFDEF ADSDELPHI2008_OR_NEWER}
            else if DataType = ftWideString then
               pusFieldLens^[ FieldNo ] := Length( PWideChar( Buffer ) )
{$ENDIF}
            else
               pusFieldLens^[ FieldNo ] := 1;
         end;

      end else {fkCalculated, fkLookup}
      begin
         Inc( pcRecBuf, musRecordSize + Offset );
{$IFDEF FPC} {$HINTS OFF} {$ENDIF} { Disable FPC hints to avoid ptr Conversion hint }
         Boolean( pcRecBuf[0] ) := LongBool( Buffer );
{$IFDEF FPC} {$HINTS ON} {$ENDIF}
         if Boolean( pcRecBuf[0] ) then Move( Buffer^, pcRecBuf[1], DataSize );
      end;
      if not ( State in [dsCalcFields, dsFilter, dsNewValue] ) then
         DataEvent( deFieldChange, Longint( Field ) );
   end;
end;


{/****************************************************************************
* Module     : SetCompactDate
* Return Val : none
* Desc       : Converts year, month, and day values from 3 WORDs to a
*              compacted three byte date value to go in a compact date field
****************************************************************************/}
procedure SetCompactDate
(
   pc3ByteDate : PAdsBuffer;       //  (O) store date in these 3 bytes
   pcLongDate  : PAdsBuffer        //  (I) 8 character date in YYYYMMDD format, NULL terminated
);
var
   usYear : UNSIGNED16;
   usMonth : UNSIGNED16;
   ucDay : UNSIGNED8;
   usWordHold1, usWordHold2 : UNSIGNED16;
   ucByteHold : UNSIGNED8;
begin
{$IFDEF CALLTRACE}
   WriteCallTrace( 'SetCompactDate' );
{$ENDIF}

   usYear := StrToInt( Copy( string( PAnsiChar( pcLongDate ) ), 1, 4 ) );
   usMonth := strToInt( Copy( string( PAnsiChar( pcLongDate ) ), 5, 2 ) );
   ucDay := strToInt( Copy( string( PAnsiChar( pcLongDate ) ), 7, 2 ) );

   { Store the date }
   usWordHold1 := usYear shl 1;
   usWordHold2 := usMonth shr 3;
   usWordHold1 := usWordHold1 or usWordHold2;

   pByte( pc3ByteDate )^ := Byte( usWordHold1 shr 8 );
   pByte( pc3ByteDate + 1 )^ := Byte( usWordHold1 and $00FF );

   ucByteHold := Byte( usMonth shl 5 );

   pByte( pc3ByteDate + 2 )^ := Byte( ucByteHold or ucDay );

end; // /* SetCompactDate */



{**********************************************************
*  Module:  TAdsDataSet.ADSPutField
*  Input:  usFieldNo - field number
*          eDelphiFieldType -
*          pRecBuf   - Active record buffer
*          pBuffer   - data to put
*  Output:
*  Description: Procedure to put data to the table and the viewable
*  buffer.  Through out the code if we are putting fields into
*  a key buffer then we do not need to update the database.  That is
*  why if we are not in SetKey State we will update the database with
*  the changes.
**********************************************************}
procedure TAdsDataSet.ADSPutField( usFieldNo        : UNSIGNED16;
                                   eDelphiFieldType : TFieldType;
                                   pRecBuf          : PAdsBuffer;
                                   pBuffer          : Pointer );
var
   {  These variables are defined on the table }
   usFieldType    : UNSIGNED16;
   ulFieldLength  : UNSIGNED32;
   ulOffset       : UNSIGNED32;
   usDecimals     : UNSIGNED16;

   {  These variables are used internally for intermedia data }
   dDate          : Double;
   acDate         : array[0..ADS_MAX_DATEMASK] of AceChar;  // this has a extra byte for null terminator
   usLen          : UNSIGNED16;
   strNumString   : String;
   pcData         : PAdsBuffer;
   ulDays         : longint;
   bNull          : WordBool;
   bFull          : WordBool;
   usDataLen      : UNSIGNED16;

begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.ADSPutField' );
{$ENDIF }

   bNull := False;

   {  Get the field type, offset, and length.  }
   usFieldType   := FACEFieldDefs[ usFieldNo - 1 ].FieldType;
   ulOffset      := FACEFieldDefs[ usFieldNo - 1 ].Offset;
   ulFieldLength := FACEFieldDefs[ usFieldNo - 1 ].Length;

   pcData := pRecBuf + ulOffset;

   {  if the pBuffer is nil then blank buffer }
   if ( Not Assigned( pBuffer ) ) then
   begin
      if musAceTableType = ADS_ADT then
         case usFieldType of
            ADS_LOGICAL :
               { empty if space }
               pcData^ := AdsBufferItem( ' ' );

            ADS_NUMERIC,
            ADS_DATE,
            ADS_STRING,
            ADS_CISTRING,
            ADS_MEMO,
            ADS_BINARY,
            ADS_IMAGE,
            ADS_VARCHAR,
            ADS_COMPACTDATE,
{$IFDEF ADSDELPHI2008_OR_NEWER}
            ADS_NCHAR,
            ADS_NMEMO,
{$ENDIF}
            ADS_RAW:
               { set to all 0's }
               FillMemory( pcData, ulFieldLength, Byte( #0 ) );

            ADS_CURDOUBLE,
            ADS_DOUBLE:
               { empty if using this byte sequence
                 \x020\x000\x000\x000\x000\x000\x000\x080
                 The below code is goofy because of Endian changes and
                 I used two sets of 4 bytes
               }
               begin
                  pUNSIGNED32( pcData )^ := $00000020;
                  pUNSIGNED32( pcData + 4 )^ := $80000000;
               end;

{$IFDEF ADSDELPHI5_OR_NEWER }
            ADS_MONEY,
            ADS_ROWVERSION:
               PSIGNED64( pcData )^ := $8000000000000000;
{$ENDIF}

            ADS_INTEGER:
               { empty if using this byte sequence
                 \x000\x000\x000\x080
                 The below code is goofy because of Endian changes
               }
               pUNSIGNED32( pcData )^ := $80000000;

            ADS_SHORTINT:
               { empty if using this byte sequence
                 \x000\x080
                 The below code is goofy because of Endian changes
               }
               pUNSIGNED16( pcData )^ := $8000;

            ADS_AUTOINC,
            ADS_TIME:
               { empty if using this byte sequence
                 \x0ff\x0ff\x0ff\x0ff
                 The below code is goofy because of Endian changes
               }
               pUNSIGNED32( pcData )^ := $FFFFFFFF;

            ADS_TIMESTAMP,
            ADS_MODTIME:
               { empty if using this byte sequence
                 \x000\x000\x000\x000\x0ff\x0ff\x0ff\x0ff
                 The below code is goofy because of Endian changes and
                 I used two sets of 4 bytes
               }
               begin
                  pUNSIGNED32( pcData )^ := $00000000;
                  pUNSIGNED32( pcData + 4 )^ := $FFFFFFFF;
               end;

{$IFDEF ADSDELPHI2008_OR_NEWER}
            ADS_NVARCHAR,
{$ENDIF}
            { VarCharFox & VarBinaryFox were missing.  I added them;
            but there may be a good reason for them to be omitted }
            ADS_VARCHAR_FOX,
            ADS_VARBINARY_FOX:
               pUNSIGNED16( pcData + ulFieldLength )^ := $FFFF;

         End {  Case }

      else if musAceTableType = ADS_VFP then
      begin
         case usFieldType of
{$IFDEF ADSDELPHI2008_OR_NEWER}
            ADS_NCHAR:
               CopyMemory( pcData, PWideChar( StringOfChar( WideChar( ' ' ), TRUNC( ulFieldLength / 2 ))), ulFieldLength );

            ADS_NVARCHAR:
            begin
               CopyMemory( pcData, PWideChar( StringOfChar( WideChar( ' ' ), TRUNC( ulFieldLength / 2 ))), ulFieldLength );
               pUNSIGNED16( pcData + ulFieldLength )^ := $FFFF;
            end;
{$ENDIF}

            ADS_NUMERIC,
            ADS_STRING,
            ADS_DATE,
            ADS_LOGICAL,
            ADS_VARCHAR_FOX,
            ADS_VARBINARY_FOX :
               { empty if all spaces }
               FillMemory( pcData, ulFieldLength, Byte( ' ' ));

{$IFDEF ADSDELPHI5_OR_NEWER }
            ADS_MONEY,
{$ENDIF}
{$IFDEF ADSDELPHI2008_OR_NEWER}
            ADS_NMEMO,
{$ENDIF}
            ADS_TIMESTAMP,
            ADS_DOUBLE,
            ADS_CURDOUBLE,
            ADS_SHORTINT,
            ADS_AUTOINC,
            ADS_MEMO,
            ADS_BINARY,
            ADS_IMAGE,
            ADS_INTEGER,
            ADS_FOXGENERAL,
            ADS_FOXPICTURE :
               FillMemory( pcData, ulFieldLength, Byte( #0 ));

         End; { case }

         { If the field is nullable, go ahead and set it to null }
         if FACEFieldDefs[ usFieldNo - 1 ].Nullable then
         begin
           bNull := True;
           ACECHECK( self, ACEUNPUB.AdsAccessVfpSystemField( mlHandle,
{$IFDEF FPC} {$HINTS OFF} {$ENDIF} { Disable FPC hints to avoid ptr Conversion hint }
                                                             ADSFIELD( UNSIGNED32( FACEFieldDefs[ usFieldNo - 1 ].FieldNumber )),
{$IFDEF FPC} {$HINTS ON} {$ENDIF}
                                                             PAceChar( pRecBuf ),
                                                             ADS_UPDATE_NULL_FLAG,
                                                             @bNull ));
         end;

      end { if musAceTableType = ADS_VFP }
      else { table type is DBF }
         { Set the field to NULL }
         if ( usFieldType in [ ADS_MEMO, ADS_BINARY, ADS_IMAGE, ADS_DOUBLE,
                               ADS_CURDOUBLE, ADS_INTEGER, ADS_SHORTINT,
{$IFDEF ADSDELPHI2008_OR_NEWER}
                               ADS_NMEMO,
{$ENDIF}
                               ADS_COMPACTDATE, ADS_VARCHAR ] ) then
            FillMemory( pcData, ulFieldLength, Byte( #0 ) )
{$IFDEF ADSDELPHI2008_OR_NEWER}
         else if ( usFieldType in [ ADS_NCHAR, ADS_NVARCHAR ] ) then
         begin
            CopyMemory( pcData, PWideChar( StringOfChar( WideChar( ' ' ), TRUNC( ulFieldLength / 2 ))), ulFieldLength );

            if ( usFieldType = ADS_NVARCHAR ) then
               pUNSIGNED16( pcData + ulFieldLength )^ := $FFFF;
         end
{$ENDIF}
         else
            FillMemory( pcData, ulFieldLength, Byte( ' ' ) );

      exit;
   end; { if Assigned( pBuffer ) ) }

   { key off of the field type to know what type of data to put.  We put the }
   { data in the active record buffer first, do not call AdsSetField. }
   case usFieldType of
      ADS_LOGICAL:
         {  Update the internal buffers for view, Delphi uses 2-byte bool }
         if pWordBool( pBuffer )^ then
            pcData^ := AdsBufferItem( 'T' )
         else
            pcData^ := AdsBufferItem( 'F' );

      ADS_CURDOUBLE,
      ADS_DOUBLE:
         PDouble( pcData )^ := pDouble( pBuffer )^;

{$IFDEF ADSDELPHI5_OR_NEWER }
      ADS_MONEY:
         BCDToCurr( TBcd( pBuffer^ ), Currency( PCurrency(pcData)^ ));

      ADS_ROWVERSION:
         pSIGNED64( pcData )^ := StrToInt64( BcdToStr( TBcd( pBuffer^ )));
{$ENDIF}

      ADS_AUTOINC,
      ADS_INTEGER:
         PSIGNED32( pcData )^ := pSIGNED32( pBuffer )^;

      ADS_SHORTINT:
         PSIGNED16( pcData )^ := pSIGNED16( pBuffer )^;

      ADS_TIME:
         PUNSIGNED32( pcData )^ := pTDateTimeRec( pBuffer )^.Time;

      ADS_TIMESTAMP,
      ADS_MODTIME:
      begin
         { The value in pBuffer^ is a double--delphi has about 2billion bugs
           in this code.  The double contains the number of millisecs
           since 1 + Jan 1, 0001.  Sore the number of days in the first
           long int in pcData^ and the number of millisecs in the following
           long int at (pcData+4)^ }
         ulDays := TRUNC( pDouble( pBuffer )^ / MSEC_PER_DAY );
         PUNSIGNED32( pcData )^ := ulDays + JULIAN_TO_DELPHI_DATE;
         { need the 1.0 to convert to a double *}
         PUNSIGNED32( pcData + 4 )^ := ROUND( pDouble( pBuffer )^ -
                                       1.0 * ulDays * MSEC_PER_DAY );
      end;

      ADS_DATE:
      begin
         {  ADT has 4 byte date field }
         if ulFieldLength = 4 then
            PUNSIGNED32( pcData )^ := pTDateTimeRec( pBuffer )^.Date + JULIAN_TO_DELPHI_DATE
         else
         begin
            {  Convert the datetimerec to a time stamp }
            dDate := pTDateTimeRec( pBuffer )^.Date + JULIAN_TO_DELPHI_DATE;
            usLen := ADS_MAX_DATEMASK + 1;
            ACECheck( self, ACEUNPUB.AdsConvertJulianToString( dDate, @acDate, @usLen ) );
            if usLen > ulFieldLength then
               raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL,
                                               'Something''s wrong with ADS date functions' );

            {  Now need to update the internal buffers for view }
            {  Format the date appropriately }
            MemCopy( pcData, PAdsBuffer( @acDate ), usLen );
         end;
      end;

      ADS_NUMERIC:
      begin
         if eDelphiFieldType = ftSmallInt then
            strNumString := IntToStr( pSIGNED16( pBuffer )^ )
         else
         begin
            {  Get the number of decimals }
            usDecimals := FACEFieldDefs[ usFieldNo - 1 ].Decimals;

{$IFDEF ADSDELPHI6_OR_NEWER }
            if ( eDelphiFieldType = ftBcd ) or ( eDelphiFieldType = ftFMTBcd ) then
            begin
               if  usDecimals = 0 then
                  strNumString := BcdToStrF( PBCD( pBuffer )^, ffFixed, ulFieldLength - 1, 0 )
               else
               begin
                  strNumString := BcdToStrF( PBCD( pBuffer )^, ffFixed, ulFieldLength - 2, usDecimals );

                  {  Replace Delphi decimal separator with a dot, which we use internally. }
                  strNumString := StringReplace( strNumString, DecimalSeparator, '.', [] );
               end;

               { I found that the BcdToStrF is not very robust. It may return an empty string when
                 it cannot convert a number to the specified precision }
               if Length( strNumString ) = 0 then
                  raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL, 'Numeric out of range.' );

               { For ADT table, a byte must be reserved for the sign }
               if ( UNSIGNED32( Length( strNumString ) ) = ulFieldLength ) and
                  ( LeftStr( strNumString, 1 ) <> '-' ) then
                  raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL, 'Numeric out of range.' );

            end
            else
{$ENDIF}
            {  If there is a decimal, we need to minus 1 for the decimal point }
            if usDecimals > 0 then
            begin
               strNumString := FloatToStrF( pDouble( pBuffer )^, ffFixed, ulFieldLength - 1,
                                            usDecimals );
               {  Replace Delphi decimal separator with a dot, which we use internally. }
               strNumString := StringReplace( strNumString, DecimalSeparator, '.', [] );
            end
            else
               strNumString := FloatToStrF( pDouble( pBuffer )^, ffFixed, ulFieldLength, 0 );

            {  If the specified precision is not obtainable, the returned string will be }
            {  scientific notation with an 'E' in it. }
         end;

         if ( UNSIGNED32( Length( strNumString ) ) > ulFieldLength ) Or ( Pos( 'E', strNumString ) > 0 ) then
            raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL, 'Numeric out of range.' );

         {  right justify the numeric string }
         while UNSIGNED32( Length( strNumString ) ) < ulFieldLength do
               strNumString := ' ' + strNumString;

{$IFDEF ADSDELPHI6_OR_NEWER }
         { D6 uses BCD type so the check for out of range data is already done above }
{$ELSE}
         {* ADT numeric field has one less byte for positive number. The first character is reserved
          * for the sign. If it is not the negative sign or space than it is too big for the field.
          * ACE will fail anyway but it doesn't hurt to check it here.
          *}
         if ( musAceTableType = ADS_ADT ) and ( strNumString[1] <> ' ' ) and ( strNumString[1] <> '-' ) then
            raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL, 'Numeric out of range.' );
{$ENDIF}

         {  We copy the whole string }
         MemCopy( pcData, PAdsBuffer( AnsiString( strNumString ) ), ulFieldLength );
      end;

{$IFDEF ADSDELPHI2008_OR_NEWER}
      ADS_NCHAR,
      ADS_NVARCHAR:
      begin
         if ( not mpoAdsTableOptions.AdsPreserveSpaces ) and
            ( PWideChar(pBuffer)[0] = #0 ) and
            ( TableType = ttAdsADT ) then
            FillMemory( pcData, ulFieldLength, Byte( #0 ))
         else
            CopyMemory( pcData, PWideChar( StringOfChar( WideChar( ' ' ), TRUNC( ulFieldLength / 2 ))), ulFieldLength );

         { Store the size in bytes of the WideString representation of pBuffer }
         MemCopy( pcData, PAdsBuffer( pBuffer ), Length( PWideChar( pBuffer )) * Sizeof( WideChar ) );

         // For NVarChar, store the (codepoint) length
         if ( usFieldType = ADS_NVARCHAR ) then
            PUNSIGNED16( pcData + ulFieldLength )^ := Length( PWideChar( pBuffer ));
      end;
{$ENDIF}

      ADS_STRING,
      ADS_CISTRING:
      begin
         {  Update the internal buffers for view }
         {* if the user sent an empty string then clear this buffer *}
         if ( not mpoAdsTableOptions.AdsPreserveSpaces ) and
            ( PAceChar(pBuffer)[0] = #0 ) and
            ( TableType = ttAdsADT ) then
            FillMemory( pcData, ulFieldLength, Byte( #0 ) )
         else
            FillMemory( pcData, ulFieldLength, Byte( ' ' ));
         {$IFDEF ADSDELPHI4_OR_NEWER }
         MemCopy( pcData, PAdsBuffer( pBuffer ), Min( Length( PAceChar( pBuffer )), ulFieldLength ));
         {$ELSE}
         MemCopy( pcData, PAdsBuffer( pBuffer ), Length( PAceChar( pBuffer )));
         {$ENDIF}
      end;

      ADS_RAW: MemCopy( pcData, PAdsBuffer( pBuffer ), ulFieldLength );

      ADS_VARCHAR_FOX :
      begin
         FillMemory( pcData, ulFieldLength, Byte( ' ' ));

         {$IFDEF ADSDELPHI4_OR_NEWER}
         usDataLen := Min( Length( PAceChar( pBuffer )), ulFieldLength );
         {$ELSE}
         usDataLen := Length( PAceChar( pBuffer ));
         {$ENDIF}

         // Copy the data into the RecordBuffer
         MemCopy( pcData, PAdsBuffer( pBuffer ), usDataLen );

         if musAceTableType = ADS_ADT then
            // copy the data length into the two bytes following the field data.
            PUNSIGNED16( pcData + ulFieldLength )^ := usDataLen
         else if musAceTableType = ADS_VFP then
         begin
            // if the field is not full, we need to store the data length in the last byte
            if usDataLen < ulFieldLength then
            begin
               pcData[ ulFieldLength - 1 ] := AdsBufferItem( usDataLen );

               bFull := False;
            end
            else
               // The field is full -- set the Full flag.
               bFull := True;

            ACECHECK( self, ACEUNPUB.AdsAccessVfpSystemField( mlHandle,
{$IFDEF FPC} {$HINTS OFF} {$ENDIF} { Disable FPC hints to avoid ptr Conversion hint }
                                                              ADSFIELD( UNSIGNED32( FACEFieldDefs[ usFieldNo - 1].FieldNumber )),
{$IFDEF FPC} {$HINTS ON} {$ENDIF}
                                                              PAceChar( pRecBuf ),
                                                              ADS_UPDATE_FULL_FLAG,
                                                              @bFull ));
         end;
      end;

      ADS_VARBINARY_FOX :
      begin
         FillMemory( pcData, ulFieldLength, Byte( ' ' ));

         // The Data Length is stored in the first two bytes of the buffer.
         usDataLen := PUNSIGNED16( pBuffer )^;

         // Copy the data into the RecordBuffer (starting at the third byte)
         MemCopy( pcData, (PAdsBuffer( pBuffer ) + 2), usDataLen );

         if musAceTableType = ADS_ADT then
            // copy the data length into the two bytes following the field data.
            PUNSIGNED16( pcData + ulFieldLength )^ := usDataLen
         else if musAceTableType = ADS_VFP then
         begin
            // If the field is not full, store the length in the last byte
            if usDataLen < ulFieldLength then
            begin
               pcData[ ulFieldLength - 1 ] := AdsBufferItem( usDataLen );
               bFull := False;
            end
            else
               bFull := True;

            ACECHECK( self, ACEUNPUB.AdsAccessVfpSystemField( mlHandle,
{$IFDEF FPC} {$HINTS OFF} {$ENDIF} { Disable FPC hints to avoid ptr Conversion hint }
                                                              ADSFIELD( UNSIGNED32( FACEFieldDefs[ usFieldNo - 1].FieldNumber )),
{$IFDEF FPC} {$HINTS ON} {$ENDIF}
                                                              PAceChar( pRecBuf ),
                                                              ADS_UPDATE_FULL_FLAG,
                                                              @bFull ));
         end; { if mucAceTableType... }
      end; { ads_varbinary_fox }

      {  Not supported }
      ADS_COMPACTDATE:
      begin
         {  Convert the datetimerec to a time stamp }
         dDate := pTDateTimeRec( pBuffer )^.Date + JULIAN_TO_DELPHI_DATE;
         usLen := ADS_MAX_DATEMASK + 1;
         ACECheck( self, ACEUNPUB.AdsConvertJulianToString( dDate, @acDate, @usLen ) );

         // NULL terminate
         acDate[ ADS_MAX_DATEMASK ] := Char( 0 );

         SetCompactDate( pcData, @acDate );
      end;
   end;

   // We've just written a value.  We need to make sure that The system field indicates this }
   if ( musAceTableType = ADS_VFP ) and ( FACEFieldDefs[ usFieldNo - 1].Nullable ) then
   begin
      bNull := False;
      ACECHECK( self, ACEUNPUB.AdsAccessVfpSystemField( mlHandle,
{$IFDEF FPC} {$HINTS OFF} {$ENDIF} { Disable FPC hints to avoid ptr Conversion hint }
                                                        ADSFIELD( UNSIGNED32( FACEFieldDefs[ usFieldNo - 1 ].FieldNumber )),
{$IFDEF FPC} {$HINTS ON} {$ENDIF}
                                                        PAceChar( pRecBuf ),
                                                        ADS_UPDATE_NULL_FLAG,
                                                        @bNull ));
   end;

   {  Data are not written to the ACE until the InternalPost is called }
end;  { TAdsDataSet.AdsPutField }


{**********************************************************
*  Module:  TAdsDataSet.InternalEdit
*  Input:
*  Output:
*  Description: Overridden procedure of TDataSet to set table
*  into edit mode
**********************************************************}
procedure TAdsDataSet.InternalEdit;
var
   ulRecTemp      : UNSIGNED32;
   ulRecordLength : UNSIGNED32;
   ulRetVal       : UNSIGNED32;
   lFieldIdx      : integer;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.InternalEdit' );
{$ENDIF }

   { Check the table update permission }
   if  0 = ( mulTableOptions And ADS_TABLE_PERM_UPDATE ) then
      ACECheck( self, ACEUNPUB.AdsSetLastError( AE_PERMISSION_DENIED, 'Update permission not granted on this table.' ));

   {  Get the Active buffers record number from the record info section of the buffer }
   ulRecTemp := PUNSIGNED32( ActiveBuffer + musBookmarkOfs )^;
   ulRecordLength := musRecordSize;

   {  If we are not in exclusive mode then we need to lock the record }
   if ( Not Exclusive ) and ( AdsTableOptions.AdsRecordLockingMode = lmPessimistic ) then
   begin
      ulRetVal := ACE.AdsLockRecord( self.Handle, ulRecTemp );
      {* If we get an AE_TABLE_NOT_SHARED error it's because this table has actually
       * opened an underlying VIEW that generates a static cursor. Give the user
       * a nicer error. *}
      if ( ulRetVal = AE_TABLE_NOT_SHARED ) then
         raise EADSDatabaseError.Create( self, ulRetVal, 'This table is based on a static VIEW. Static VIEWs can not be updated.' )
      else
         ACECheck( self, ulRetVal );
   end;

   {  re-get the record so we have the latest version of the data }
   ReadTranslatedRecord( ActiveBuffer, @ulRecordLength, true );

   {* If using optimistic locking, get a crc so we can tell at post time if this
    * record was updated by some other user. *}
   if ( Not Exclusive ) and ( AdsTableOptions.AdsRecordLockingMode = lmOptimistic ) then
      ACECheck( self, ACE.AdsGetRecordCRC( Handle, @mulSavedCRC, ADS_DEFAULT ) );

   {* Save record buffer before user starts editing it, so we can return
    * old field values if they are requested through the TField.OldValue
    * property. *}
   if ( FOldRecordBuffer = nil  ) then
   begin
      {* AllocateMemory *}
      FOldRecordBuffer := PAdsBuffer( AnsiStrAlloc( ulRecordLength + 1 ) );
   end;
   MemCopy( FOldRecordBuffer, ActiveBuffer, ulRecordLength );

   for lFieldIdx := 0 to FACEFieldDefs.Count - 1 do
      FACEFieldDefs[ lFieldIdx ].Modified := FALSE;

end; { TAdsDataSet.InternalEdit }

{**********************************************************
*  Module:  TAdsDataSet.InternalPost
*  Input:
*  Output:
*  Description: Overridden procedure of TDataSet to post the
*  data
*  Note: This procedure should only be called when the
*        dataset is in dsInsert or dsEdit state.
**********************************************************}
procedure TAdsDataSet.InternalPost;
var
   usFieldNums   : UNSIGNED16;
   usFieldType   : UNSIGNED16;
   ulFieldOffset : UNSIGNED32;
   ulFieldLen    : UNSIGNED32;
   pRecBuffer    : PAdsBuffer;
   iBlobCounter  : integer;
   oBlobCach     : TAdsBlobCache;
   ulOffset      : UNSIGNED32;
   ulTempCRC     : UNSIGNED32;
   bNeedToUnlock : boolean;
   ulDataLen     : UNSIGNED32;
   bIsFull       : boolean;
   bIsNull       : boolean;
   bIsNullable   : boolean;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.InternalPost' );
{$ENDIF }

   {* NOTE: No need to raise an error here. Usually code in db.pas will find this state and
    * return an error. Other times I've seen this code hit is if the user has an OnPost
    * event that cancels the update. It works fine if the post was called in code, but if
    * the post was caused by a DBNavigator control it somehow still gets into here, and
    * we need to just ignore the post. *}
   if not ( State in [dsEdit, dsInsert] ) then
      exit;

{$IFDEF ADSDELPHI6_OR_NEWER }
   {*
    * For Delphi 6 and newer this has to be called so that
    * required fields can be checked.
    *}
   inherited;
{$ENDIF }

   bNeedToUnlock := FALSE;
   pRecBuffer := ActiveBuffer;

   try
      {  If in Edit state, we goto the correct record in ACE.  This is required because Delphi }
      {  CAN actually refreshes the grid while in Edit state }
      if state = dsEdit then
      begin
         ACECheck( self, ACE.AdsGotoRecord( Handle, PUNSIGNED32( pRecBuffer + musBookmarkOfs )^ ) );

         if ( Not Exclusive ) and ( AdsTableOptions.AdsRecordLockingMode = lmOptimistic ) then
         begin
            {* If optimistic locking, we haven't gotten the lock yet, so get it here. *}
            ACECheck( self, ACE.AdsLockRecord( Handle, 0 ) );

            {* From this point on, we need to unlock this record if there is an exception. *}
            bNeedToUnlock := TRUE;

            {* See if the crc has changed. *}
            ACECheck( self, ACE.AdsGetRecordCRC( Handle, @ulTempCRC, ADS_DEFAULT ) );
            if ( mulSavedCRC <> ulTempCRC ) then
               {*
                * Raise with AE_OLD_RECORD as the error code. Won't be in error string, but
                * will be in the exception object so the user can check it.
                *}
               raise EADSDatabaseError.Create( self, AE_OLD_RECORD,
                                               'Record was changed by another user.' );
         end;

      end
      else if State = dsInsert then
      begin
         {  If the dataset is in insert state, make sure we appended a record }
         if GetBookmarkFlag( pRecBuffer )<> bfInserted then
         begin
            ACECheck( self, ACE.AdsAppendRecord( Handle ) );
            {  Set flag to indicate that the record has been appended }
            SetBookmarkFlag( pRecBuffer, bfInserted );

            {  Fill in the correct record number in the record buffer }
            ACECheck( self, ACE.AdsGetRecordNum( Handle, ADS_IGNOREFILTERS,
                                           PUNSIGNED32( pRecBuffer + musBookmarkOfs ) ) );
         end;
      end;

      {  Update each field }
      ACECheck( self, ACE.AdsGetNumFields( Handle, @usFieldNums ) );
      while usFieldNums > 0 do
      begin
         if ( FACEFieldDefs[ usFieldNums - 1 ].Modified ) then
         begin
            { Before we do anything else, we need to make sure the field isn't null/empty for VFP tables }
            if musAceTableType = ADS_VFP then
            begin
               ACECHECK( self, ACEUNPUB.AdsAccessVfpSystemField( mlHandle,
{$IFDEF FPC} {$HINTS OFF} {$ENDIF} { Disable FPC hints to avoid ptr Conversion hint }
                                                                 ADSFIELD( UNSIGNED32( usFieldNums )),
{$IFDEF FPC} {$HINTS ON} {$ENDIF}
                                                                 PAceChar( pRecBuffer ),
                                                                 ADS_RETRIEVE_NULL_FLAG,
                                                                 @bIsNull ));

               if bIsNull then
               begin
                  ACECHECK( self, ACE.AdsIsNullable( mlHandle,
{$IFDEF FPC} {$HINTS OFF} {$ENDIF} { Disable FPC hints to avoid ptr Conversion hint }
                                                     ADSFIELD( UNSIGNED32( usFieldNums )),
{$IFDEF FPC} {$HINTS ON} {$ENDIF}
                                                     @bIsNullable ));

                  // If the field is null, set it to Null if the field supports nulls,
                  // otherwise, set it to empty.
                  if ( bIsNullable = True ) and ( not mpoAdsTableOptions.AdsPreserveSpaces ) then
                     ACECHECK( self, ACE.AdsSetNull( mlHandle,
{$IFDEF FPC} {$HINTS OFF} {$ENDIF} { Disable FPC hints to avoid ptr Conversion hint }
                                                     ADSFIELD( UNSIGNED32( usFieldNums ))))
{$IFDEF FPC} {$HINTS ON} {$ENDIF}
                  else
                     ACECHECK( self, ACE.AdsSetEmpty( mlHandle,
{$IFDEF FPC} {$HINTS OFF} {$ENDIF} { Disable FPC hints to avoid ptr Conversion hint }
                                                      ADSFIELD( UNSIGNED32( usFieldNums ))));
{$IFDEF FPC} {$HINTS ON} {$ENDIF}

                  // The field is null, so the rest of this check doesn't need to happen.
                  dec( usFieldNums );
                  Continue;
               end; { if bIsNull }
            end; { if musAceTAbleType = ADS_VFP }

            {  Get the field type }
            usFieldType := FACEFieldDefs[ usFieldNums - 1 ].FieldType;

{$IFDEF ADSDELPHI2008_OR_NEWER}
            if not ( usFieldType in [ ADS_AUTOINC, ADS_MEMO, ADS_BINARY,
                                      ADS_IMAGE, ADS_VARCHAR, ADS_NMEMO ] ) then
{$ELSE}
            if not ( usFieldType in [ ADS_AUTOINC, ADS_MEMO, ADS_BINARY,
                                      ADS_IMAGE, ADS_VARCHAR ] ) then
{$ENDIF}
            begin
               {  Get the field offset }
               ulFieldOffset := FACEFieldDefs[ usFieldNums - 1 ].Offset;

               {  Get the field length }
               ulFieldLen := FACEFieldDefs[ usFieldNums - 1 ].Length;

               { Set the length of the data to be written to the field length }
               ulDataLen := ulFieldLen;

               { VarChar/VarBinary fields may write less then ulFieldLen data.  Determine how much to write. }
               if usFieldType in [ ADS_VARCHAR_FOX, ADS_VARBINARY_FOX ] then
               begin
                  // ADT Tables store the data length in 2 bytes immediately following the data
                  if musAceTableType = ADS_ADT then
                     ulDataLen := UNSIGNED32( PUNSIGNED16( pRecBuffer + ulFieldOffset + ulDataLen )^ )
                  else if musAceTableType = ADS_VFP then
                  begin
                     ACECHECK( self, ACEUNPUB.AdsAccessVfpSystemField( mlHandle,
{$IFDEF FPC} {$HINTS OFF} {$ENDIF} { Disable FPC hints to avoid ptr Conversion hint }
                                                                       ADSFIELD( UNSIGNED32( usFieldNums )),
{$IFDEF FPC} {$HINTS ON} {$ENDIF}
                                                                       PAceChar( pRecBuffer ),
                                                                       ADS_RETRIEVE_FULL_FLAG,
                                                                       @bIsFull ));

                     { If the field is full, the data length is the field length.  otherwise, it is stored
                       in the last byte of the field buffer. }
                     if bIsFull = True then
                        ulDataLen := ulFieldLen
                     else
                        ulDataLen := UNSIGNED32( pRecBuffer[ UNSIGNED32( ulFieldOffset ) + UNSIGNED32( ulFieldLen - 1 ) ] );
                  end;
               end;

               { use set field for strings so that the OEM conversion occurs }
               if ( ADS_STRING = usFieldType ) or ( ADS_CISTRING = usFieldType ) or ( ADS_VARCHAR_FOX = usFieldType ) then
               begin
                  if not mpoAdsTableOptions.AdsPreserveSpaces then
                  begin
                     {* if this string is all spaces then set the field to
                      * null, o/w just right the string *}
                     ulOffset := ulFieldOffset;
                     while ( pRecBuffer[ulOffset] = AdsBufferItem( ' ' ) ) and
                           ( ulOffset < ulFieldOffset+ulFieldLen ) do
                        inc(ulOffset);

                     if ( ulOffset = ulFieldOffset+ulFieldLen ) then
{$IFDEF FPC} {$HINTS OFF} {$ENDIF} { Disable FPC hints to avoid ptr Conversion hint }
                        ACECheck( self, ACE.AdsSetEmpty( Handle, ADSFIELD( UNSIGNED32( usFieldNums ) )))
{$IFDEF FPC} {$HINTS ON} {$ENDIF}
                     else
                        ACECheck( self, ACE.AdsSetField( Handle,
{$IFDEF FPC} {$HINTS OFF} {$ENDIF} { Disable FPC hints to avoid ptr Conversion hint }
                                                         ADSFIELD( UNSIGNED32( usFieldNums )),
{$IFDEF FPC} {$HINTS ON} {$ENDIF}
                                                         @pRecBuffer[ulFieldOffset], ulDataLen ));
                  end
                  else
                     ACECheck( self, ACE.AdsSetField( Handle,
{$IFDEF FPC} {$HINTS OFF} {$ENDIF} { Disable FPC hints to avoid ptr Conversion hint }
                                                      ADSFIELD( UNSIGNED32( usFieldNums )),
{$IFDEF FPC} {$HINTS ON} {$ENDIF}
                                                      @pRecBuffer[ulFieldOffset],
                                                      ulDataLen ));
               end
{$IFDEF ADSDELPHI2008_OR_NEWER}
               else if ( ADS_NCHAR = usFieldType ) then
               begin
                  if not mpoAdsTableOptions.AdsPreserveSpaces then
                  begin
                     ulOffset := ulFieldOffset;
                     while ( WideChar( pRecBuffer[ulOffset] ) = WideChar( ' ' ) ) and
                           ( ulOffset < ulFieldOffset + ulFieldLen ) do
                        inc( ulOffset );

                     if ( ulOffset = ulFieldOffset + ulFieldLen ) then
                        ACECheck( self, ACE.AdsSetEmpty( Handle, ADSFIELD( usFieldNums )))
                     else
                        ACECheck( self, ACE.AdsSetFieldW( Handle, ADSFIELD( usFieldNums ),
                                                          PWideChar( @pRecBuffer[ulFieldOffset] ), TRUNC( ulDataLen / 2 ) ) );
                  end
                  else
                     ACECheck( self, ACE.AdsSetFieldW( Handle, ADSFIELD( usFieldNums ),
                                                       PWideChar( @pRecBuffer[ulFieldOffset] ), TRUNC( ulDataLen / 2 ) ) );
               end
               else if ( ADS_NVARCHAR = usFieldType ) then
               begin
                  // The Data Length is held in two bytes following the field.
                  ulDataLen := UNSIGNED32( PUNSIGNED16( pRecBuffer + ulFieldOffset + ulDataLen )^ );

                  // Need to check for Null magic value.
                  if ulDataLen = $FFFF then
                     ACECheck( self, ACE.AdsSetEmpty( Handle, ADSFIELD( usFieldNums )))
                  else
                  begin
                     if not mpoAdsTableOptions.AdsPreserveSpaces then
                     begin
                        ulOffset := ulFieldOffset;
                        while ( WideChar( pRecBuffer[ulOffset] ) = WideChar( ' ' ) ) and
                              ( ulOffset < ulFieldOffset + ulFieldLen ) do
                           inc( ulOffset );

                        if ( ulOffset = ulFieldOffset + ulFieldLen ) then
                           ACECheck( self, ACE.AdsSetEmpty( Handle, ADSFIELD( usFieldNums )))
                        else
                           ACECheck( self, ACE.AdsSetFieldW( Handle, ADSFIELD( usFieldNums ),
                                                             PWideChar( @pRecBuffer[ulFieldOffset] ), ulDataLen ) );
                     end
                     else
                        ACECheck( self, ACE.AdsSetFieldW( Handle, ADSFIELD( usFieldNums ),
                                                          PWideChar( @pRecBuffer[ulFieldOffset] ), ulDataLen ) );
                  end { else }
               end { if usFieldType = ADS_NVARCHAR }
{$ENDIF}
               else
                  {  Set field raw }
                  ACECheck( self, ACEUNPUB.AdsSetFieldRaw( Handle,
{$IFDEF FPC} {$HINTS OFF} {$ENDIF} { Disable FPC hints to avoid ptr Conversion hint }
                                                           ADSFIELD( UNSIGNED32( usFieldNums )),
{$IFDEF FPC} {$HINTS ON} {$ENDIF}
                                                           @pRecBuffer[ulFieldOffset], ulDataLen ));
            end;

         end;  // if  FACEFieldDefs[ usFieldNums - 1 ].Modified then

         dec( usFieldNums );
      end;  // while usFieldNums > 0 do

      { All blob fields are cached, so we need to write them out }
      for iBlobCounter := 0 to BlobFieldCount - 1 do
      begin
         oBlobCach := TAdsBlobCache( PBlobDataArray( pRecBuffer + musBlobCacheOfs )[iBlobCounter] );

         if oBlobCach.IsCacheModified then
         begin
            ulOffset := FACEFieldDefs[ oBlobCach.mulFieldNo - 1 ].Offset;
            if oBlobCach.Size = 0 then
               pUNSIGNED32( pRecBuffer + ulOffset )^ := 0
            else
               PUNSIGNED32( pRecBuffer + ulOffset )^ := $FFFFFFFF;

            oBlobCach.Flush();
         end;
      end;

      {  Call the write record function to flush the update to the server }
      ACECheck( self, ACE.AdsWriteRecord( Handle ) );

      {  if we are in edit state and not in exclusive mode then we need to unlock the record }
      if ( state = dsEdit ) and Not Exclusive then
         {  Get the Active buffers record number from the record info section of the buffer }
         ACECheck( self, ACE.AdsUnlockRecord( Handle, PUNSIGNED32( pRecBuffer + musBookmarkOfs )^ ) );


   except
      on E : exception do
      begin
         if bNeedToUnlock then
            AdsUnlockRecord( Handle, PUNSIGNED32( pRecBuffer + musBookmarkOfs )^ );
         raise;
      end;
   end;
end;

{**********************************************************
*  Module:  TAdsDataSet.InternalDelete
*  Input:
*  Output:
*  Description: Overridden procedure to delete current record
**********************************************************}
procedure TAdsDataSet.InternalDelete;
var
   bShowDeleted   : UNSIGNED16;

begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.InternalDelete' );
{$ENDIF }

   {  Delete the record }
   try
      ACECheck( self, ACE.AdsDeleteRecord( self.Handle ) );
      ACECheck( self, ACE.AdsWriteRecord( Self.Handle ) );
   except
      on E : Exception do
      begin
         {* Cancel the pending update in ACE, ignore errors. *}
         ACE.AdsCancelUpdate( self.Handle );
         {* re-raise the exception *}
         raise;
      end;

   end;

   {
     skip to the next record if we are not displaying deleted records.  With
     ADTs, deleted records can not be shown ever.
   }
   ACECheck( self, AdsGetDeleted( @bShowDeleted ) );
   if ( bShowDeleted = ADS_FALSE ) then
      ACECheck( self, ACE.AdsSkip( ActiveHandle, 1 ) );
end;

{**********************************************************
*  Module:  TAdsDataSet.InternalCancel
*  Input:
*  Output:
*  Description: Overridden procedure to cancel the changes to
*  a record.
**********************************************************}
procedure TAdsDataSet.InternalCancel;
var
   ulRecTemp, ulRecordLength : UNSIGNED32;
   hBookmark : UNSIGNED32;
   ulRetCode : UNSIGNED32;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.InternalCancel' );
{$ENDIF }

   {  Cancel the pending update }
   ulRetCode := ACE.AdsCancelUpdate( self.Handle );

   {  We trap some expected errors }
   if ( ulRetCode = AE_SUCCESS ) or ( ulRetCode = AE_NO_CURRENT_RECORD ) or
      ( ulRetCode = AE_NO_PENDING_UPDATE ) then
   else
      ACECheck( self, ulRetCode );

   {  We need to worry about EOF and BOF. }
   {  If the insertion has been canceled then we need to stay put }
   {  No else is needed because we are where we need to be if we posted }
   if state = dsInsert then
   begin
      if EOF then
      begin
         InternalLast;
         exit;
      end
      else
      begin
         {  If we are at the end of the set there is a + 1 there }
         hBookmark := PUNSIGNED32( Buffers[ ActiveRecord + 1 ] + musBookmarkOfs )^;
         ACECheck( self, ACE.AdsGotoBookmark( Handle, hBookmark ) );
      end;
   end;

   {  Get the Active buffers record number from the record info section of the buffer }
   ulRecTemp := PUNSIGNED32( ActiveBuffer + musBookmarkOfs )^;
   ulRecordLength := musRecordSize;

   {  Get the latest record and refresh the data }
   GetCurTranslatedRecord( ActiveBuffer, @ulRecordLength, gmCurrent );

   {*
    * If we are in edit state and not in exclusive mode then we need to unlock the
    * record. If we are using optimistic locking, the record was unlocked if
    * necessary inside InternalPost, so we don't need to call AdsUnlockRecord here.
    *}
   if ( ( State = dsEdit ) and ( Not Exclusive ) and
        ( AdsTableOptions.AdsRecordLockingMode <> lmOptimistic ) ) then
      ACECheck( self, ACE.AdsUnlockRecord( Handle, ulRecTemp ) );
end;  {  TAdsDataSet.InternalCancel }


{**********************************************************
*  Module:  TAdsDataSet.GetIndexNames
*  Input: poList - List for index names
*  Output: poList
*  Description: Returns the list of index names that are open
**********************************************************}
procedure TAdsDataSet.GetIndexNames( poList: TStrings );
var
   sIndexCount: SIGNED16;
   phIndexArray : PADSHandleArray;
   acIndexName : array[0..ADS_MAX_PATH] of acechar;
   usArrayLength : UNSIGNED16;
   usNameLength : UNSIGNED16;
   hHoldHandle : ADSHANDLE;
begin
{$IFDEF CALLTRACE}
   WriteCallTrace( 'TAdsDataSet.GetIndexNames' );
{$ENDIF}

{$IFDEF FPC}
   phIndexArray := nil;
{$ENDIF}

   if Not Active then
      hHoldHandle := OpenAdvantageFiles
   else
      {  if component is active use the already existing table handle }
      hHoldHandle := Handle;

   {* Get memory for the index handles to go in. *}
   ACECheck( self, ACE.AdsGetNumIndexes( hHoldHandle, @usArrayLength ) );
   GetMem( phIndexArray, usArrayLength * sizeof( ADSHANDLE )  );

   try

      ACECheck( self, ACE.AdsGetAllIndexes( hHoldHandle, @(phIndexArray[0]), @usArrayLength ) );

      poList.Clear;
      for sIndexCount := 0 to usArrayLength - 1 do
      begin
         usNameLength := ADS_MAX_PATH;
         ACECheck( self, ACE.AdsGetIndexName( phIndexArray[sIndexCount], @acIndexName,
                   @usNameLength ) );
         poList.Add( string( StrPas( acIndexName ) ) )
      end;
   finally
      Dispose( phIndexArray );

      if not Active then
         ACECheck( self, ACE.AdsCloseTable( hHoldHandle ) );
   end;


   {* Add the default index to the list if this a dictionary connection. *}
   if ( mpoAdsConnection <> nil ) then
   begin
      if ( mpoAdsConnection.IsDictionaryConn ) then
      begin
         {*
          * mstrDefaultIndex stores the actual Index Name which is already in the
          * list, so add the generic identifier ADS_DEFAULT instead.
          *}
         if ( mstrDefaultIndex <> '' ) then
         begin
            poList.Add( 'ADS_DEFAULT' );
         end;
      end;
   end;

end;


{**********************************************************
*  Module:  TAdsDataSet.GetFTSIndexNames
*  Input: poList - List for index names
*  Output: poList
*  Description: Returns the list of FTS index names that are open
*               This does not clear the given list.  It adds
*               to the existing values.
**********************************************************}
procedure TAdsDataSet.GetFTSIndexNames( poList: TStrings );
var
   sIndexCount: SIGNED16;
   phIndexArray : PADSHandleArray;
   acIndexName : array[0..ADS_MAX_PATH] of AceChar;
   usArrayLength : UNSIGNED16;
   usNameLength : UNSIGNED16;
   hHoldHandle : ADSHANDLE;
begin
{$IFDEF CALLTRACE}
   WriteCallTrace( 'TAdsDataSet.GetFTSIndexNames' );
{$ENDIF}

{$IFDEF FPC}
   phIndexArray := nil;
{$ENDIF}

   if Not Active then
      hHoldHandle := OpenAdvantageFiles
   else
      {  if component is active use the already existing table handle }
      hHoldHandle := Handle;

   ACECheck( self, ACE.AdsGetNumFTSIndexes( self.Handle, @usArrayLength ) );
   GetMem( phIndexArray, usArrayLength * sizeof( ADSHANDLE )  );

   try
      ACECheck( self, ACE.AdsGetFTSIndexes( hHoldHandle, @(phIndexArray[0]), @usArrayLength ) );

      for sIndexCount := 0 to usArrayLength - 1 do
      begin
         usNameLength := ADS_MAX_PATH;
         ACECheck( self, ACE.AdsGetIndexName( phIndexArray[sIndexCount], @acIndexName,
                   @usNameLength ) );
         poList.Add( string( StrPas( acIndexName ) ) )
      end;
   finally

      Dispose( phIndexArray );

      if not Active then
         ACECheck( self, ACE.AdsCloseTable( hHoldHandle ) );
   end;


end;


{**********************************************************
*  Module:  TAdsDataSet.AllocKeyBuffers
*  Input:
*  Output:
*  Description: Allocates the Key buffers for seeks and ranges
**********************************************************}
procedure TAdsDataSet.AllocKeyBuffers;
var
  poKeyIndex   : TKeyIndex;
  usNumFields  : UNSIGNED16;
  ulBufferSize : UNSIGNED32;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.AllocKeybuffers' );
{$ENDIF }

   {  Initialize everything to Nil first }
   for poKeyIndex := Low( TKeyIndex ) to High( TKeyIndex ) do
      mapKeyBuffers[ poKeyIndex ] := Nil;

   ACECheck( self, ACE.AdsGetNumFields( Handle, @usNumFields ) );

   {*
    * The key buffer consisted of 3 parts:
    * [ TAdsKeyBuffer ][ Record buffer ][ Field Length Array ]
    * The field length array are an array of UNSIGNED16 integers.
    *}
   { Note:  Cast both operands of the addition to Unsigned32 to prevent FPC warning }
   ulBufferSize := SizeOf( TAdsKeyBuffer ) + UNSIGNED32( musRecordSize ) +
                   UNSIGNED32( usNumFields * SizeOf( UNSIGNED16 ));

   try
      {  for all of the key buffers initialize them }
      for poKeyIndex := Low( TKeyIndex ) to High( TKeyIndex ) do
      begin
         mapKeyBuffers[ poKeyIndex ] := AllocMem( ulBufferSize );

         mapKeyBuffers[ poKeyIndex ]^.BufferSize := ulBufferSize;

         InitKeyBuffer( mapKeyBuffers[ poKeyIndex ] );
      end;

   except
      {  If an exception occurs then free the buffers }
      FreeKeyBuffers;
      {  after the buffers are clear reraise the exception }
      raise;
   end;
end;

{**********************************************************
*  Module:  TAdsDataSet.FreeKeyBuffers
*  Input:
*  Output:
*  Description: Frees the Key buffers
**********************************************************}
procedure TAdsDataSet.FreeKeyBuffers;
var
  poKeyIndex  : TKeyIndex;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.FreeKeyBuffers' );
{$ENDIF }

   {  for all of the key buffers dispose of them }
   for poKeyIndex := Low( TKeyIndex ) to High( TKeyIndex ) do
      if mapKeyBuffers[ poKeyIndex ] <> Nil then
      begin
         DisposeMem( mapKeyBuffers[ poKeyIndex ], mapKeyBuffers[ poKeyIndex ]^.BufferSize );
         mapKeyBuffers[ poKeyIndex ] := nil;
      end;
end;


{**********************************************************
*  Module:  TAdsDataSet.InitKeyBuffer
*  Input:  pBuffer - the buffer to be initialized
*  Output:
*  Return: PAdsKeyBuffer
*  Description: Initializes the passed in buffer to blanks
*  Note: The structure of the key buffer is like the following:
*        [ TAdsKeyBuffer ][ Record buffer ][ Field Length Array ]
*
**********************************************************}
function TAdsDataSet.InitKeyBuffer( pBuffer: PAdsKeyBuffer ): PAdsKeyBuffer;
var
   usFieldNums  : UNSIGNED16;
   pusFieldLens : pointer;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.InitKeyBuffer' );
{$ENDIF }

   pBuffer.Modified := FALSE;
   pBuffer.FieldCount := 0;
   pBuffer.Exclusive := FALSE;

   ACECheck( self, ACE.AdsGetNumFields( Handle, @usFieldNums ) );

   { Get the pointer to the field length array }
   pusFieldLens := PAceChar( pBuffer ) + SizeOf( TAdsKeyBuffer ) + musRecordSize;

   {  Initialize all logical field length to FFFF }
   FillMemory( pusFieldLens, usFieldNums * SizeOf( UNSIGNED16 ), Byte( $FF ) );

   {  Initialize key logical record buffer }
   ACECheck( self, ACEUNPUB.AdsGetNullRecord( Handle,
                                              PAceChar( pBuffer ) +  SizeOf( TAdsKeyBuffer ),
                                              UNSIGNED32( musRecordSize ) ) );

   Result := pBuffer;
end;

{**********************************************************
*  Module:  TAdsDataSet.CheckSetKeyMode
*  Input:
*  Output:
*  Description: Makes sure the mode is dsSetKey.  If not raise exception
**********************************************************}
procedure TAdsDataSet.CheckSetKeyMode;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.CheckSetKeyMode' );
{$ENDIF }

   {  if the State is not dsSetKey then raise exception }
   if State <> dsSetKey then
      DatabaseError( SNotEditing );
end;

{**********************************************************
*  Module:  TAdsDataSet.SetKeyBuffer
*  Input:  poKeyIndex - enumerated type pointer to a specific buffer
*          bClear - flag to tell whether or not to clear out the buffer
*  Output:
*  Description: Takes the passed in type of key buffer and
*  sets the header information and state
**********************************************************}
procedure TAdsDataSet.SetKeyBuffer( poKeyIndex: TKeyIndex; bClear: Boolean );
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.SetKeyBuffer' );
{$ENDIF }

   {  if there is no active index handle then raise exception }
   if ActiveHandle = Handle then
      raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL, 'Index is not set.' );

   {  Make sure we are in browse mode }
   CheckBrowseMode;

   {  set the keybuffer to the key index that was passed into the funciton }
   mpstKeyBuffer := mapKeyBuffers[poKeyIndex];

   {  move the key buffer into a save position }
   Move( mpstKeyBuffer^, mapKeyBuffers[kiSave]^, mpstKeyBuffer^.BufferSize );

   {  if we are to clear the buffer to start clean then initialize the key buffer }
   if bClear then
   begin
      InitKeyBuffer( mpstKeyBuffer );
      mpstKeyBuffer.FieldCount := 0;
   end;

   {  Set the DataSet in to dsSetKey state }
   SetState( dsSetKey );

   {  set the modified flag to true }
   mpstKeyBuffer.Modified := True;
   SetModified( mpstKeyBuffer.Modified );

   {  cause data event }
   DataEvent( deDataSetChange, 0 );

end;  {  TAdsDataSet.SetKeyBuffer }


{**********************************************************
*  Module:  TAdsDataSet.SetKey
*  Input:
*  Output:
*  Description: Initializes key values for the developer to
*  begin setting for Lookup.  Resets key.
**********************************************************}
procedure TAdsDataSet.SetKey;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.SetKey' );
{$ENDIF }

   {  Set the keybuffer kiLookup to the active key buffer and clear it }
   SetKeyBuffer( kiLookup, True );
end;

{**********************************************************
*  Module:  TAdsDataSet.EditKey
*  Input:
*  Output:
*  Description: Initializes key values for the developer to
*  begin setting for Lookup.  Modifies existing key values.
**********************************************************}
procedure TAdsDataSet.EditKey;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.EditKey' );
{$ENDIF }

   {  Set the keybuffer kiLookup to the active key buffer and don't clear it }
   SetKeyBuffer( kiLookup, False );
end;


{**********************************************************
*  Module:  TAdsDataSet.GetKeyBuffer
*  Input:    poKeyIndex - enumerated type pointer to the buffer
*  Output:
*  Return: PAdsKeyBuffer - pointer to a key buffer
*  Description: Returns the current Key buffer from type passed in
**********************************************************}
function TAdsDataSet.GetKeyBuffer( poKeyIndex: TKeyIndex ): PAdsKeyBuffer;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.GetKeyBuffer' );
{$ENDIF }

   {  return the enumerated type pointer to the buffer }
   Result := mapKeyBuffers[ poKeyIndex ];
end;  {  TAdsDataSet.GetKeyBuffer }


{**********************************************************
*  Module:  TAdsDataSet.GetActiveIndexFieldsNames
*  Input:
*  Output:
*  Return: ';' delimited string of field names in the active index
*  Description:
*  Note:  The dataset must have an active index.  Unless you really
*         need the ';' delimited field name list, consider the
*         alternative, ACEUNPUB.AdsGetSegmentFieldName.
**********************************************************}
function TAdsDataSet.GetActiveIndexFieldNames : string;
var
  iIndexDef     : integer;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.GetActiveIndexFieldsNames' );
{$ENDIF }

   {  Found current index field list }
   case meActiveIndexType of

      {  if IndexField then we just use the IndexFieldNames property }
      ndxIndexField :
         Result := IndexFieldNames;

      {  if IndexName then get the field name list from the active index def }
      ndxIndexName:
      begin
         iIndexDef := mpoIndexDefs.IndexOf( IndexName );
         if iIndexDef >= 0 then
            Result := mpoIndexDefs.Items[ iIndexDef ].fields
         else
            Result := '';
      end;

      {  if DefaultIndex then get the field name list from the default index }
      ndxDefault:
      begin
         iIndexDef := mpoIndexDefs.IndexOf( mstrDefaultIndex );
         if iIndexDef >= 0 then
            Result := mpoIndexDefs.Items[ iIndexDef ].fields
         else
            Result := '';
      end;

      {  Should not happend }
      ndxNone: Result := '';
   end;
end;  {  TAdsDataSet.GetActiveIndexFieldNames }


{**********************************************************
*  Module:  TAdsDataSet.SetKeyFields
*  Input:  poKeyIndex - Which index buffer to set
*          aValues - Array of values to insert for the current index
*  Output:
*  Description: Takes an array of values and puts them into the key buffer
*               by way of the TField.AssignValue.
*               AW. The old implementation causes excessive dataevent, this
*               implementation is adoptated from D4.
**********************************************************}
procedure TAdsDataSet.SetKeyFields( poKeyIndex: TKeyIndex; const aValues: array of const );
var
   sIndexCount   : SIGNED16;
   strFieldNames : string;
   strIndexField : string;
   SaveState     : TDataSetState;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.SetKeyFields' );
{$ENDIF }

   { Make sure we have the latest index definition }
   mpoIndexDefs.Update;

   {  Verify that current index can be set by field names }
   strFieldNames := GetActiveIndexFieldNames;

   if strFieldNames = '' then
      raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL,
         'An index must be active to perform this operation. Set the IndexName property.' );

   {  Verify the number of passed in value is equal or less than number of fields }
   {  in the index field names list }
   strIndexField := GetIndexExprField( High( aValues ) + 1, PChar( strFieldNames ) );
   if '' = strIndexField then
      raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL,
                                      'Too many values given for current index' );

   SaveState := SetTempState( dsSetKey );
   try
      {  set the keybuffer to the key index that was passed into the funciton }
      mpstKeyBuffer := InitKeyBuffer( mapKeyBuffers[poKeyIndex] );
      for sIndexCount := High( aValues ) downto 0 do
      begin
         FieldByName( strIndexField ).AssignValue( aValues[ sIndexCount ] );

         {  Get the next field name in the index }
         strIndexField := GetIndexExprField( sIndexCount, PChar( strFieldNames ) );
      end;

      mpstKeyBuffer.FieldCount := High( aValues ) + 1;
      mpstKeyBuffer.Modified := Modified;
   finally
     RestoreState( SaveState );
   end;

end;  {  TAdsDataSet.SetKeyFields }


{**********************************************************
*  Module:  TAdsDataSet.FindKey
*  Input:  KeyValues - Values passed to set the key fields in the key buffer
*  Output:
*  Return: Boolean - Was the entry found
*  Description: Finds the record by key values passed in
**********************************************************}
function TAdsDataSet.FindKey( const KeyValues: array of const ): Boolean;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.FindKey' );
{$ENDIF }

   CheckBrowseMode;

   {  Set the values in the key buffer }
   SetKeyFields( kiLookup, KeyValues );

   {  Call Gotokey and return the result }
   result := GotoKey;
end;

{**********************************************************
*  Module:  TAdsDataSet.FindNearest
*  Input:  KeyValues - Values passed to set the key fields in the key buffer
*  Output:
*  Description:  Does a soft seek from key values passed in for
*  the active index
**********************************************************}
procedure TAdsDataSet.FindNearest( const KeyValues: array of const );
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.FindNearest' );
{$ENDIF }

   CheckBrowseMode;

   {  Set the values in the key buffer }
   SetKeyFields( kiLookup, KeyValues );

   {  Call GotoNearest to soft seek to the key }
   GotoNearest;
end;


{**********************************************************
*  Module:  TAdsDataSet.BuildRawKey
*  Input:
*  Output:
*  Description: Build the raw key based on the contain of the
*               specified key buffer
**********************************************************}
procedure TAdsDataSet.BuildRawKey( poKeyIndex  : TKeyIndex;  { (I) Key buffer index }
                                   bPartial    : Boolean;    { (I) Set partial on Char field }
                                   pcKeyBuffer : PChar;      { (O) Returns Raw key  }
                                   pusLen      : pWord );    { (IO) Length of buffer on input }
                                                             {      Length of raw key on output }
var
   poKeyBuffer   : PAdsKeyBuffer;
   pcRecBuffer   : PAdsBuffer;
   pusFieldLens  : PKeyFieldLenArray;
   acFieldName   : array[0..ADS_MAX_FIELD_NAME] of AceChar;
   usExprLen     : UNSIGNED16;
   sSegmentCount : SIGNED16;
   ulFieldOffset : UNSIGNED32;
   ulFieldLength : UNSIGNED32;
   usFieldType   : UNSIGNED16;
   usFieldNum    : UNSIGNED16;
begin
{$IFDEF CALLTRACE}
   WriteCallTrace( 'TAdsDataSet.BuildRawKey' );
{$ENDIF}

   poKeyBuffer := GetKeyBuffer( poKeyIndex );

   {  pcRecBuffer is to point at the record buffer portion minus the header TAdsKeyBuffer }
   pcRecBuffer := PAdsBuffer( poKeyBuffer ) + SizeOf( TAdsKeyBuffer );

   {  pusFieldLens is to point at the first byte after the record buffer }
   pusFieldLens := PKeyFieldLenArray ( pcRecBuffer + musRecordSize );

   {  Use the ACE to build the raw key based on the number of fields that's been set }
   ACECheck( self, ACE.AdsInitRawKey( ActiveHandle ) );

   {  For each field in the current index, we get the data from the key buffer and set it }
   {  in ACE's key buffer }
   usExprLen := ADS_MAX_FIELD_NAME + 1;
   sSegmentCount := 0;

   while AE_SUCCESS = ACEUNPUB.AdsGetSegmentFieldName( ActiveHandle, sSegmentCount,
                                                       @acFieldName, @usExprLen ) do
   begin
      usFieldNum := FACEFieldDefs[ FACEFieldDefs.IndexOf( string( acFieldName ) ) ].FieldNumber;

      {*
       * If the field has been set, we set it in ACE. Also, if the key buffer
       * field count is zero then we need to set all segment values, not just
       * the ones that are not NULL. See bug 978 for details. We modified this
       * in 7.0 to make it configurable. See the AdsAutoKeyFieldCount property
       * and bug 1702 for details.
       *}
      if ( pusFieldLens^[ usFieldNum ] <> $FFFF ) or
         ( ( mpoAdsTableOptions.mbAutoKeyFieldCount = False ) and ( (poKeyBuffer^).FieldCount = 0 ) ) then
      begin

         if ( pusFieldLens^[ usFieldNum ] = $FFFF ) then
            ACECheck( self, AdsSetEmpty( ActiveHandle, @acFieldName ) )
         else
         begin
            usFieldType := FACEFieldDefs[ usFieldNum - 1 ].FieldType;
            ulFieldOffset := FACEFieldDefs[ usFieldNum - 1 ].Offset;

            if bPartial then
            begin
               if ( ADS_STRING = usFieldType ) or ( ADS_CISTRING = usFieldType ) or
                  ( ADS_VARCHAR_FOX = usFieldType) then
                  ulFieldLength := pusFieldLens^[ usFieldNum ]
               else
                  ulFieldLength := FACEFieldDefs[ usFieldNum - 1 ].Length;
            end
            else
               ulFieldLength := FACEFieldDefs[ usFieldNum - 1 ].Length;


            { use set field for strings so that the OEM conversion occurs }
            if ( ADS_STRING = usFieldType ) or ( ADS_CISTRING = usFieldType ) or ( ADS_VARCHAR_FOX = usFieldType ) then
               ACECheck( self, ACE.AdsSetField( ActiveHandle, @acFieldName,
                                          @pcRecBuffer[ulFieldOffset], ulFieldLength ) )
{$IFDEF ADSDELPHI2008_OR_NEWER}
            else if ( ADS_NCHAR = usFieldType ) or ( ADS_NVARCHAR = usFieldType ) then
               ACECheck( self, ACE.AdsSetFieldW( ActiveHandle, @acFieldName,
                                                 PWideChar( @pcRecBuffer[ulFieldOffset] ), TRUNC( ulFieldLength / 2 ) ) )
{$ENDIF}
            else
               {  Set field raw }
               ACECheck( self, ACEUNPUB.AdsSetFieldRaw( ActiveHandle, @acFieldName,
                                                  @pcRecBuffer[ulFieldOffset], ulFieldLength ) );
         end;   { If not NULL }

      end;

      {  Increment segment to work on the next field }
      inc( sSegmentCount );
      usExprLen := ADS_MAX_FIELD_NAME + 1;
   end;

   {  Build the key }
   ACECheck( self, ACE.AdsBuildRawKey( ActiveHandle, PAceChar( pcKeyBuffer ), pusLen ) );

end;  {  TAdsDataSet.BuildRawKey }


{**********************************************************
*  Module:  TAdsDataSet.GotoNearest
*  Input:
*  Output:
*  Description: Takes the filled out key buffer and does a
*  build to a seek key and does a soft seek
**********************************************************}
procedure TAdsDataSet.GotoNearest;
var
  acKeyBuffer   : array[0..ADS_MAX_KEY_LENGTH] of AceChar;
  usFound       : UNSIGNED16;
  usKeyBufLen   : UNSIGNED16;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.GotoNearest' );
{$ENDIF }

   {  Set our browse mode }
   CheckBrowseMode;
   DoBeforeScroll;
   CursorPosChanged;

   {  Build the raw key based on the kiLookup key buffer }
   usKeyBufLen := ADS_MAX_KEY_LENGTH + 1;
   BuildRawKey( kiLookup, True { Partial field }, @acKeyBuffer, @usKeyBufLen );

   {  Do the SOFTSEEK }
   ACECheck( self, ACE.AdsSeek( ActiveHandle, @acKeyBuffer, usKeyBufLen, ADS_RAWKEY,
                          ADS_SOFTSEEK, @usFound ) );

   SetFound( usFound <> 0 );

   {  Set the state back into browse mode and resync with the cursor on the }
   {  found record in the center }
   SetState( dsBrowse );
   Resync( [rmCenter] );
   DoAfterScroll;

end;  {  TAdsDataSet.GotoNearest }


{**********************************************************
*  Module:  TAdsDataSet.GotoKey
*  Input:
*  Output:
*  Return: boolean - seek record found
*  Description: Takes the filled out key buffer and doex a
*  build to a seek key and does a hard seek
**********************************************************}
function TAdsDataSet.GotoKey: Boolean;
var
  ulSaveRecNo : UNSIGNED32;
  ulRetVal    : UNSIGNED32;
  usFound: UNSIGNED16;
  acKeyBuffer : array[0..ADS_MAX_KEY_LENGTH] of AceChar;
  usKeyBufLen : UNSIGNED16;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.GotoKey' );
{$ENDIF }
   {  Set our browse mode }
   CheckBrowseMode;
   DoBeforeScroll;
   CursorPosChanged;

   {  Save the current record so we can come back if seek is unsuccessful }
   ulSaveRecNo := PUNSIGNED32( ActiveBuffer + musBookmarkOfs )^;

   {  Build the raw key based on the kiLookup key buffer }
   usKeyBufLen := ADS_MAX_KEY_LENGTH;
   BuildRawKey( kiLookup, False { No partial field in GotoKey }, @acKeyBuffer, @usKeyBufLen );

   {  Delphi expect GotoKey to work if only a subset of field is given on a multi-field }
   {  index, so we use the key size from the build instead of the full key length. }
   {  Use ADS_HARDSEEK here it is a little bit more efficient than ADS_SOFTSEEK. }
   if Assigned( OnFilterRecord ) and Filtered then
      EvalClientFilteredSeek( @acKeyBuffer, usKeyBufLen, ADS_RAWKEY, @usFound )
   else
      ACECheck( self, ACE.AdsSeek( ActiveHandle, @acKeyBuffer, usKeyBufLen, ADS_RAWKEY,
                ADS_HARDSEEK, @usFound ) );

   Result := ( usFound <> 0 );
   SetFound( Result );

   {  If the key was found then stay where we are and resync }
   if Result then
   begin
      Resync( [rmExact, rmCenter] );
      DoAfterScroll;
   end
   else
   begin
      {  If the key was not found and we are at EOF then instead of going to an }
      {  invalid record goto the end.  Do the same for BOF in visa versa }
      if EOF then
         Last
      else if BOF then
         First
      else
      begin
         {  Otherwise goto the saved record if the seek key was not found }
         ulRetVal := ACE.AdsGotoRecord( Handle, ulSaveRecNo );
         {* if the saved record had been deleted since we saved the recno
          * in an adt table we will get a 5022 here *}
         if ( ulRetVal = AE_INVALID_RECORD_NUMBER ) then
            Last
         else
            ACECheck( self, ulRetVal );
      end;
   end;
end;  {  TAdsDataSet.GotoKey }


{**********************************************************
*  Module:  TAdsDataSet.GetKeyExclusive
*  Input:
*  Output:
*  Return: Boolean - Whether the key buffer is exclusive or not
*  Description:
**********************************************************}
function TAdsDataSet.GetKeyExclusive: Boolean;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.GetKeyExclusive' );
{$ENDIF }

  CheckSetKeyMode;
  Result := mpstKeyBuffer.Exclusive;
end;



{**********************************************************
*  Module:  TAdsDataSet.GetRefreshProperty
*  Input:
*  Output:
*  Return: Boolean - contents of mbRefreshCount
*  Description:
**********************************************************}
function  TAdsDataSet.GetRefreshProperty : Boolean;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.GetRefreshProperty' );
{$ENDIF }
   Result := mpoAdsTableOptions.mbRefreshCount;
end;


{**********************************************************
*  Module:  TAdsDataSet.SetKeyExclusive
*  Input: bValue - Whether the key buffer is exclusive or not
*  Output:
*  Description:
*  SPECIAL NOTE: Compatibility only.  The functionality will not
*  work.  Functionality states that Exclusive should excluse the
*  seek key value from the returned data set.
**********************************************************}
procedure TAdsDataSet.SetKeyExclusive( bValue: Boolean );
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.SetKeyExclusive' );
{$ENDIF }

  CheckSetKeyMode;
  mpstKeyBuffer.Exclusive := bValue;
end;

{**********************************************************
*  Module:  TAdsDataSet.GetKeyFieldCount
*  Input:
*  Output:
*  Return: SIGNED16 - the field count from current KeyBuffer
*  Description: Returns the field count from the current
*  KeyBuffer.
**********************************************************}
function TAdsDataSet.GetKeyFieldCount: SIGNED16;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.GetKeyFieldCount' );
{$ENDIF }

  CheckSetKeyMode;
  Result := mpstKeyBuffer.FieldCount;
end;

{**********************************************************
*  Module:  TAdsDataSet.SetKeyFieldCount
*  Input:  sValue - set the key field count to the current key buffer
*  Output:
*  Description: Sets the key field count to the current key buffer
**********************************************************}
procedure TAdsDataSet.SetKeyFieldCount( sValue: SIGNED16 );
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.SetKeyFieldCount' );
{$ENDIF }

  CheckSetKeyMode;
  mpstKeyBuffer.FieldCount := sValue;
end;

{**********************************************************
*  Module:  TAdsDataSet.SetReadOnly
*  Input:  bValue - whether read only or not
*  Output:
*  Description: Sets the read only data member of the TAdsDataSet
*  from the property ReadOnly
**********************************************************}
procedure TAdsDataSet.SetReadOnly( bValue: Boolean );
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.SetReadOnly' );
{$ENDIF }

  CheckInactive;
  mbReadOnly := bValue;
end;

{**********************************************************
*  Module:  TAdsDataSet.DoAfterInsert
*  Input:
*  Output:
*  Description:  Event handler for the developer
**********************************************************}
procedure TAdsDataSet.DoAfterInsert;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.DoAfterInsert' );
{$ENDIF }

   {  Call the inherited DoBeforeInsert that the developer may overload }
   inherited DoAfterInsert;
end;

{**********************************************************
*  Module:  TAdsDataSet.DoBeforeCancel
*  Input:
*  Output:
*  Description:  Event handler for the developer
**********************************************************}
procedure TAdsDataSet.DoBeforeCancel;

begin

{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.DoBeforeCancel' );
{$ENDIF }

   {  Call the inherited DoBeforeCancel that the developer may overload }
   inherited DoBeforeCancel;

{$IFDEF ADSDELPHI3}
   {  Delphi 3 has a bug in the cancel routine that causes not calling }
   {  the internal cancel when in insert mode, so we do it here instead.  }
   if State = dsInsert then
      InternalCancel;
{$ENDIF}

end;

{**********************************************************
*  Module:  TAdsDataSet.RecordFilter
*  Input:  RecBuf - Current Record Buffer
*          RecNo - Current Record numer
*  Output:
*  Return:  Whether or not to accept the record
*  Description:  Event handler for the developer
**********************************************************}
function TAdsDataSet.RecordFilter( RecBuf: Pointer ): Boolean;
var
   Accept: Boolean;
   SaveState: TDataSetState;
begin
{$IFDEF CALLTRACE}
   WriteCallTrace( 'TAdsDataSet.RecordFilter' );
{$ENDIF}

   SaveState := SetTempState( dsFilter );
   mpFilterBuffer := RecBuf;

   try
      Accept := True;
      OnFilterRecord( Self, Accept );
   except
      if assigned( HandleExceptionProc ) then
         HandleExceptionProc( self )
      else
         raise;
   end;

   RestoreState( SaveState );
   Result := Accept;
end;

{**********************************************************
*  Module:  TAdsDataSet.DoOnNewRecord
*  Input:
*  Output:
*  Description:  Event handler for the developer
**********************************************************}
procedure TAdsDataSet.DoOnNewRecord;
var
   bEOF : Word;
   bBOF : Word;
   i : integer;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.DoOnNewRecord' );
{$ENDIF }

   if State = dsInsert then
   begin
      { Check the table insert permission }
      if  0 = ( mulTableOptions And ADS_TABLE_PERM_INSERT ) then
         ACECheck( self, ACEUNPUB.AdsSetLastError( AE_PERMISSION_DENIED, 'Insert permission not granted on this table.' ));

      { Due to a special case where an empty table is openned and the set record
        function is going to try to rely on delphi's EOF and BOF, it is not a good
        thing.  This will be the correct EOF and BOF to work from }
      AdsAtEOF( self.Handle, @bEOF );
      AdsAtBOF( self.Handle, @bBOF );
      mbAppendEOF := Boolean( bEOF );
      mbAppendBOF := Boolean( bBOF );
{$IFNDEF ADSDELPHI4_OR_NEWER}    { Delphi 3 and CBuilder 3 }
      { Delphi 3 does not have the virtual function InternalInsert so we do it }
      { here.  }
      InternalInsert;
{$ENDIF}

   end;

   {* Automatically set the detail fields to the value of the master fields *}
   if mpoMasterLink.Active and ( mpoMasterLink.Fields.Count > 0 ) then
      for i := 0 to mpoMasterLink.Fields.Count - 1 do
         IndexFields[i] := TField( mpoMasterLink.Fields[i] );

  inherited DoOnNewRecord;
end;


{**********************************************************
*  Module:  TAdsDataSet.DoAfterOpen
*  Input:
*  Output:
*  Description: Event Handler
**********************************************************}
procedure TAdsDataSet.DoAfterOpen;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.DoAfterOpen' );
{$ENDIF }

  {* call the inherited DoAfterOpen before firing the MasterChanged
   * event. This way if the user is enabling encryption in the
   * AfterOpen even it will be fired before we fire MasterChanged *}
  inherited DoAfterOpen;


  {*check to make sure that there is a master source,
   *then check to make sure that a data set is associated with it *}
  if ( MasterSource <> nil ) then
     if ( mpoMasterLink.DataSource.DataSet <> nil ) then
        if ( Assigned( MasterSource )) and ( mpoMasterLink.DataSource.DataSet.Active ) then
           MasterChanged( self );

end;

{**********************************************************
*  Module:  TAdsDataSet.SetScoped
*  Input: bValue - Whether to Activate or deactivate the scope
*  Output:
*  Description:  Activates or deactivates the scope
**********************************************************}
procedure TAdsDataSet.SetScoped( bValue : Boolean );
var
   ulRecNum : integer;
   bVisible : UNSIGNED16;
   ulRetVal : UNSIGNED32;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.SetScoped' );
{$ENDIF }

   { No op if same value passed in }
   if ( bValue = mbScoped ) then
      exit;

   {  if the table doex not have a valid handle yet then don't activate or }
   {  deactivate the scopes yet }
   if Active then
   begin
      ulRecNum := PUNSIGNED32( ActiveBuffer + musBookmarkOfs )^;

      if bValue then
      begin
         ActivateScope;

         {  if the current record in the grid is still visible inside the scope, }
         {  we can stay where we were. }
         ulRetVal := ACE.AdsIsRecordVisible( ActiveHandle, @bVisible );
         if ( ulRetVal <> AE_NO_CURRENT_RECORD ) then
            ACECheck( self, ulRetVal )
         else
            {* AdsIsRecordVisible probably returns false when it returns
             * an error, but we'll set bVisible to false just to be safe *}
            bVisible := ADS_FALSE;

         if ( bVisible = ADS_TRUE ) then
            Resync( [] )
         else
            First;
      end
      else
      begin
         {  Scoped is set to False }
         DeactivateScope;

         {  if we have an empty set with the scope set, we need to go to the first }
         {  record to refresh the grid.  Otherwise, we can stay where we were. }
         if Bof And Eof then
            First
         else
         begin
            ulRetVal := ACE.AdsGotoRecord( Handle, ulRecNum );
            {* record could have been deleted out from under us }
            if ( ulRetVal = AE_INVALID_RECORD_NUMBER ) then
               next;
            Resync( [] );
         end;
      end;
   end;

   {  Set the data member }
   mbScoped := bValue;
end;

{**********************************************************
*  Module:  TAdsDataSet.GotoCurrent
*  Input: poTable - Table instance to syncronize with
*  Output:
*  Description: Call GotoCurrent to synchronize the cursor
*  position for this table based on the cursor position in
*  another dataset that uses a different data source component,
*  but which is connected to the same underlying database table.
*  Table is the name of the table component whose cursor position
*  to use for synchronizing.
**********************************************************}
procedure TAdsDataSet.GotoCurrent( poTable: TAdsDataSet );
var
   ulRetVal : UNSIGNED32;
   strDatabase1 : string;
   strDatabase2 : string;
   ulGotoRecord : UNSIGNED32;
begin
{$IFDEF CALLTRACE}
   WriteCallTrace( 'TAdsDataSet.GotoCurrent' );
{$ENDIF}

   {  Make sure we are in browse mode }
   CheckBrowseMode;

   {  Make sure the table passed in is in browse mode }
   poTable.CheckBrowseMode;

   {  Make sure the table names are the same }

   {* check to see if they have a connection component instead
    * of database name. otherwise check for the database name in
    * the AdsTable component *}
   if ( AdsConnection <> nil ) then
   begin
      if ( AdsConnection.ConnectPath <> '' ) then
         strDatabase1 := AdsConnection.ConnectPath
      else
         strDatabase1 := AdsConnection.AliasName;
   end
   else
      strDatabase1 := DatabaseName;

   if ( poTable.AdsConnection <> nil ) then
   begin
      if ( poTable.AdsConnection.ConnectPath <> '' ) then
         strDatabase2 := poTable.AdsConnection.ConnectPath
      else
         strDatabase2 := poTable.AdsConnection.AliasName;
   end
   else
      strDatabase2 := poTable.DatabaseName;

   if ( AnsiCompareText( strDatabase1, strDatabase2 ) <> 0 ) or
      ( AnsiCompareText( TableName, poTable.TableName ) <> 0 ) then
      DatabaseError( STableMismatch );

   {  Update the passed in tables cursor position }
   poTable.UpdateCursorPos;

   {*  goto the physical record number that the table passed in is currently on,
    *  don't use poTable.RecNo, because if the sequenced property is TRUE that
    *  number is just an estimated record position, not a record number. *}
   ACECheck( self, ACE.AdsGetRecordNum( poTable.Handle, ADS_IGNOREFILTERS, @ulGotoRecord ) );
   ulRetVal := ACE.AdsGotoRecord( self.Handle, ulGotoRecord );
   if ( ulRetVal = AE_INVALID_RECORD_NUMBER ) then
      Last
   else
      ACECheck( self, ulRetVal );

   {  Resync controls }
   DoBeforeScroll;
   Resync( [rmExact, rmCenter] );
   DoAfterScroll;
end;


{**********************************************************
*  Module:  TAdsDataSet.SetCursorRange
*  Input:
*  Output:
*  Return: Boolean - Successful or not
*  Description: Sets a scope on the top and bottom of the
*  data set for the given top and bottom range buffers
**********************************************************}
function TAdsDataSet.SetCursorRange: Boolean;
var
   poRangeKey  : PAdsKeyBuffer;
   acKeyBuffer : array[0..ADS_MAX_KEY_LENGTH] of AceChar;
   usKeyBufLen : UNSIGNED16;
   usKeyLen    : UNSIGNED16;
begin
{$IFDEF CALLTRACE}
   WriteCallTrace( 'TAdsDataSet.SetCursorRange: Boolean' );
{$ENDIF}

   Result := False;

   { Scope and range are mutually exclusive, if scope is set, range cannot be set }
   if scoped then
      raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL,
         'Cannot set range on table when there is an active scope.' );

   {  After the range has been set, the key buffers kiRangeStart and kiRangeEnd are saved in }
   {  kiCurRangeStart and kiCurRangeEnd respectively.  If the newly specified range (as in }
   {  kiRangeStart and kiRangeEnd) are identical to previous set range (as in kiCurRangeStart }
   {  and kiCurRangeEnd), then there is no need to rebuild the key to set the range again }
   if not ( BuffersEqual( mapKeyBuffers[kiRangeStart],
                          mapKeyBuffers[kiCurRangeStart],
                          SizeOf( TAdsKeyBuffer ) + musRecordSize ) and
            BuffersEqual( mapKeyBuffers[kiRangeEnd],
                          mapKeyBuffers[kiCurRangeEnd],
                          SizeOf( TAdsKeyBuffer ) + musRecordSize ) ) then
   begin

      {  Get the length of the complete key }
      ACECheck( self, ACE.AdsGetKeyLength( ActiveHandle, @usKeyLen ) );

      {  Get a pointer to the Range start key buffer }
      poRangeKey := mapKeyBuffers[kiRangeStart];

      {  If the value in the buffer has been modified then set }
      if poRangeKey.Modified then
      begin
         {  Build the raw key based on the kiRangeStart key buffer }
         usKeyBufLen := ADS_MAX_KEY_LENGTH + 1;
         BuildRawKey( kiRangeStart, False, { No partial field } @acKeyBuffer, @usKeyBufLen );

         {  Exclude the top key if KeyExclusive is specified }
         if ( poRangeKey.Exclusive ) and ( musOpenTableType = ADS_ADT ) then
         begin
            {  We need to increment the full key.  If the last field is not an character }
            {  field, this may not work as expected. For example, Index on LastName;Salary, }
            {  and only LN = 'Coles' is given, then this algorithm will basically set the }
            {  top key at LN = 'Coles' and Salary > 0.  This is because integer/float field }
            {  are initialized to zero }
            ACECheck( self, ACE.AdsGetKeyLength( ActiveHandle, @usKeyBufLen ) );

            {  If the rawkey does not have the full length, we use the full key }
            ACECheck( self, AdsStepIndexKey( ActiveHandle, @acKeyBuffer, usKeyBufLen, +1 ));
         end;

         {  Set the scope on the key buffer }
         ACECheck( self, ACE.AdsSetScope( ActiveHandle, ADS_TOP, @acKeyBuffer, usKeyBufLen, ADS_RAWKEY ) );

         {  Save the values so when we come back in we will know if this }
         {  Range has already been set }
         Move( mapKeyBuffers[kiRangeStart]^, mapKeyBuffers[kiCurRangeStart]^,
               poRangeKey.BufferSize );
      end;

      {  Get a pointer to the Range end key buffer }
      poRangeKey := mapKeyBuffers[kiRangeEnd];

      {  If the value in the buffer has been modified then set }
      if poRangeKey.Modified then
      begin
         {  Build the raw key based on the kiRangeStart key buffer }
         usKeyBufLen := ADS_MAX_KEY_LENGTH + 1;
         BuildRawKey( kiRangeEnd, False, { No Partial field } @acKeyBuffer, @usKeyBufLen );

         {  Decrement the bottom key if KeyExclusive is specified }
         if ( poRangeKey.Exclusive ) and ( musOpenTableType = ADS_ADT ) then
         begin
            {  We need to decrement the full key.  If the last field is not an character }
            {  field, this may not work as expected. For example, Index on LastName;Salary, }
            {  and only LN = 'Coles' is given, then this algorithm will basically set the }
            {  top key at LN = 'Coles' and Salary > 0.  This is because integer/float field }
            {  are initialized to zero }
            ACECheck( self, ACE.AdsGetKeyLength( ActiveHandle, @usKeyBufLen ) );
            ACECheck( self, AdsStepIndexKey( ActiveHandle, @acKeyBuffer, usKeyBufLen, -1 ));
         end;

         {  Set the scope on the key buffer }
         ACECheck( self, ACE.AdsSetScope( ActiveHandle, ADS_BOTTOM, @acKeyBuffer, usKeyBufLen, ADS_RAWKEY ) );

         {  Save the values so when we come back in we will know if this }
         {  Range has already been set }
         Move( mapKeyBuffers[kiRangeEnd]^, mapKeyBuffers[kiCurRangeEnd]^, poRangeKey.BufferSize );
      end;

      {  Set the result to true and state back to browse mode }
      Result := True;
      SetState( dsBrowse );
   end;
end;  { TAdsDataSet.SetCursorRange }


{**********************************************************
*  Module:  TAdsDataSet.ResetCursorRange
*  Input:
*  Output:
*  Return: Boolan - Successful
*  Description: Undoes the scopes and clears the save buffers
**********************************************************}
function TAdsDataSet.ResetCursorRange: Boolean;
var
   usHoldEOF : UNSIGNED16;
   usHoldBOF : UNSIGNED16;
begin
{$IFDEF CALLTRACE}
   WriteCallTrace( 'TAdsDataSet.ResetCursorRange: Boolean' );
{$ENDIF}

   { if scope is set, range must not be set }
   if scoped then
   begin
      result := True;
      exit;
   end;

   Result := False;

   if mapKeyBuffers[kiCurRangeStart].Modified or
      mapKeyBuffers[kiCurRangeEnd].Modified then
   begin
      {  Clears all of the scopes }
      ACECheck( self, ACE.AdsClearAllScopes( Handle ) );

      {  If the Scopes are cleared and we are dealing with an empty set }
      {  due to the scope presented, we need to go top on the new set because }
      {  the resync to follow will think it is dealing with an empty set }
      ACECheck( self, ACE.AdsAtEof( Handle, @usHoldEOF ) );
      ACECheck( self, ACE.AdsAtBof( Handle, @usHoldBOF ) );

      {  Save the Record position if not at EOF or BOF }
      if ( usHoldEOF <> ADS_FALSE ) And ( usHoldBOF <> ADS_FALSE )then
      begin
         {  Activate the clearing of the scopes and init data set }
         ACECheck( self, ACE.AdsGotoTop( ActiveHandle ) );
      end;

      {  Initialize the holds for the current range because there isn't a current }
      {  range any more }
      InitKeyBuffer( mapKeyBuffers[kiCurRangeStart] );
      InitKeyBuffer( mapKeyBuffers[kiCurRangeEnd] );

      {  Success }
      Result := True;
   end;
end;

{**********************************************************
*  Module:  TAdsDataSet.SetRangeEnd
*  Input:
*  Output:
*  Description: Initializes the keybuffer and passes true
*  to clear the buffer
**********************************************************}
procedure TAdsDataSet.SetRangeEnd;
begin
{$IFDEF CALLTRACE}
   WriteCallTrace( 'TAdsDataSet.SetRangeEnd' );
{$ENDIF}

  SetKeyBuffer( kiRangeEnd, True );
end;

{**********************************************************
*  Module:  TAdsDataSet.SetRangeStart
*  Input:
*  Output:
*  Description: Initializes the keybuffer and passes true
*  to clear the buffer
**********************************************************}
procedure TAdsDataSet.SetRangeStart;
begin
{$IFDEF CALLTRACE}
   WriteCallTrace( 'TAdsDataSet.SetRangeStart' );
{$ENDIF}

  SetKeyBuffer( kiRangeStart, True );
end;

{**********************************************************
*  Module:  TAdsDataSet.SetRange
*  Input:   aStartValues - array of values to set for top scope
*           aEndValues - array of values to set for the bottom scope
*  Output:
*  Description: Sets both the top and bottom range for the
*  passed in values
**********************************************************}
procedure TAdsDataSet.SetRange( const aStartValues, aEndValues: array of const );
begin
{$IFDEF CALLTRACE}
   WriteCallTrace( 'TAdsDataSet.SetRange' );
{$ENDIF}

   CheckBrowseMode;

   SetKeyFields( kiRangeStart, aStartValues );

   SetKeyFields( kiRangeEnd, aEndValues );

   ApplyRange;
end;

{**********************************************************
*  Module:  TAdsDataSet.EditRangeEnd
*  Input:
*  Output:
*  Description: Initializes the keybuffer and passes false
*  to keep existing buffer values while updating with new ones
**********************************************************}
procedure TAdsDataSet.EditRangeEnd;
begin
{$IFDEF CALLTRACE}
   WriteCallTrace( 'TAdsDataSet.EditRangeEnd' );
{$ENDIF}

  SetKeyBuffer( kiRangeEnd, False );
end;

{**********************************************************
*  Module:  TAdsDataSet.EditRangeStart
*  Input:
*  Output:
*  Description: Initializes the keybuffer and passes false
*  to keep existing buffer values while updating with new ones
**********************************************************}
procedure TAdsDataSet.EditRangeStart;
begin
{$IFDEF CALLTRACE}
   WriteCallTrace( 'TAdsDataSet.EditRangeStart' );
{$ENDIF}

  SetKeyBuffer( kiRangeStart, False );
end;

{**********************************************************
*  Module:  TAdsDataSet.ApplyRange
*  Input:
*  Output:
*  Description: Activate the ranges and resync controls to first
**********************************************************}
procedure TAdsDataSet.ApplyRange;
begin
{$IFDEF CALLTRACE}
   WriteCallTrace( 'TAdsDataSet.ApplyRange' );
{$ENDIF}

   CheckBrowseMode;

   {  Activate the ranges and resync controls to first }
   if SetCursorRange then First;
end;

{**********************************************************
*  Module:  TAdsDataSet.CancelRange
*  Input:
*  Output:
*  Description: Deactivate the ranges and resync controls
**********************************************************}
procedure TAdsDataSet.CancelRange;
begin
{$IFDEF CALLTRACE}
   WriteCallTrace( 'TAdsDataSet.CancelRange' );
{$ENDIF}

   CheckBrowseMode;
   UpdateCursorPos;

   {  Deactivate the ranges and resync controls }
   if ResetCursorRange then Resync( [] );
end;


{  Section of test methods to make sure all virtual functions show if being called }

{$ifndef ADSDELPHI5_OR_NEWER} { Delphi 3,4 and CBuilder 3,4 }
{**********************************************************
*  Module:  TAdsDataSet.BCDToCurr
*  Input:
*  Output:
*  Description: Not yet implemented
**********************************************************}
function TAdsDataSet.BCDToCurr( BCD: Pointer; var Curr: Currency ): Boolean;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.BCDToCurr' );
{$ENDIF }

   Result := False;
end;

{**********************************************************
*  Module:  TAdsDataSet.CurrToBCD
*  Input:
*  Output:
*  Description:  Not yet implemented
**********************************************************}
function TAdsDataSet.CurrToBCD( const Curr: Currency; BCD: Pointer; Precision,
                                Decimals: Integer ): Boolean;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.CurrToBCD' );
{$ENDIF }

   Result := False;
end;
{$endif}


{**********************************************************
*  Module:  TAdsDataSet.ClearCalcFields
*  Input:
*  Output:
*  Description:  Initializes the calculated fields for the
*  record buffer
**********************************************************}
procedure TAdsDataSet.ClearCalcFields( Buffer: PAdsBuffer );
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.ClearCalcFields' );
{$ENDIF }

   {  Initialize the calculated fields for the record buffer }
   FillChar( Buffer[RecordSize], CalcFieldsSize, 0 );
end;

{**********************************************************
*  Module:  TAdsDataSet.CloseBlob
*  Input:
*  Output:
*  Description: Not yet Implemented
**********************************************************}
{$IFDEF FPC}{$HINTS OFF}{$ENDIF}
procedure TAdsDataSet.CloseBlob( Field: TField );
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.CloseBlob' );
{$ENDIF }
end;
{$IFDEF FPC}{$HINTS ON}{$ENDIF}

{**********************************************************
*  Module:  TAdsDataSet.CloseCursor
*  Input:
*  Output:
*  Description:  Calls TDataSets CloseCursor
**********************************************************}
procedure TAdsDataSet.CloseCursor;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.CloseCursor' );
{$ENDIF }

   inherited CloseCursor;
end;

{**********************************************************
*  Module:  TAdsDataSet.CreateBlobStream
*  Input: Field - Field object that is the blob
*         Mode - read, write, or readwrite
*  Output:
*  Return:  TStream - handle to the created object
*  Description:  Create a blob stream object and pass
*  back the handle to it.
**********************************************************}
function TAdsDataSet.CreateBlobStream( Field: TField; Mode: TBlobStreamMode ): TStream;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.CreateBlobStream' );
{$ENDIF }

   {  if the global binary field name matches the field name then set the field type }
   {  be of Blob type }
   if ( Field.DataType = ftBlob ) then
      Field.SetFieldType( ftBlob );

   if ( ( UpperCase( Field.FieldName ) = UpperCase( strBinaryFieldName ) )
      And ( strBinaryFieldName <> '' ) )then
      Field.SetFieldType( ftBlob );

   {  Make sure that we are in the correct state for the blob mode }
   if ( Mode in [ bmReadWrite, bmWrite ] ) and Not ( state in [ dsInsert, dsEdit ] ) then
      raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL,
         'Table must be in Edit or Insert state to open blob stream in Write Mode.' );

   {  Create the blob stream }
   Result := TAdsBlobStream.Create( Field as TBlobField, Mode );

end;


{**********************************************************
*  Module:  TAdsDataSet.DataEvent
*  Input: Event - enumeration of different events
*         Info - any information you want to give to the dataevent
*  Output:
*  Description: Call inherited TDataSet dataEvent
**********************************************************}
procedure TAdsDataSet.DataEvent( Event: TDataEvent; Info: Longint );
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.DataEvent' );
{$ENDIF }

   if Event = dePropertyChange then mpoIndexDefs.Updated := False;

   inherited DataEvent( Event, Info );
end;

{**********************************************************
*  Module:  TAdsDataSet.FindRecord
*  Input:  Restart - whether or not to start from the beginning
*          GoForward - whether or not to go forward or backward
*  Output:
*  Return: Boolean - Found
*  Description: Working with a filter the find record will
*  locate records within the filter in the forward or backward
*  direction from current position or from beginning on the filtered set
**********************************************************}
function TAdsDataSet.FindRecord( Restart, GoForward: Boolean ): Boolean;
var
   bIsEOF, bIsBOF : UNSIGNED16;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.FindRecord' );
{$ENDIF }

   {  Initialize the eof and bof flags }
   bIsEOF := 0;
   bIsBOF := 0;

   {  Check and initialize for compatibility }
   CheckBrowseMode;
   DoBeforeScroll;
   SetFound( False );
   UpdateCursorPos;
   CursorPosChanged;

   {  If the dataset is not filtered then activate the filters for this operation }
   if not Filtered then ActivateFilters;
   try
      if GoForward then
      begin
         if Restart then
            ACECheck( self, ACE.AdsGotoTop( ActiveHandle ) )
         else
            ACECheck( self, ACE.AdsSkip( ActiveHandle, 1 ) );
         ACECheck( self, ACE.AdsAtEof( Self.Handle, @bIsEOF ) );

         if ( bIsEOF = 0 ) and Assigned( OnFilterRecord ) then
         begin
            if EvalClientFilter( true {* forward *} ) then
               bIsEOF := 0
            else
               bIsEOF := 1;
         end;
      end
      else
      begin
         if Restart then
            ACECheck( self, ACE.AdsGotoBottom( ActiveHandle ) )
         else
            ACECheck( self, ACE.AdsSkip( ActiveHandle, -1 ) );
         ACECheck( self, ACE.AdsAtBof( Self.Handle, @bIsBOF ) );

         if ( bIsBOF = 0 ) and Assigned( OnFilterRecord ) then
         begin
            if EvalClientFilter( false {* backwards *} ) then
               bIsBOF := 0
            else
               bIsBOF := 1;
         end;
      end;
   finally
      {  If the dataset is not filtered then deactivate the filters before we }
      {  return from this operation }
      if not Filtered then DeactivateFilters;
   end;

   {  If dataset is not at eof or bof then resync controls to the found record }
   {  and set found to true otherwise don't move and set found to false }
   if ( bIsBOF = 0 ) and ( bIsEOF = 0 ) then
   begin
      Resync( [rmExact, rmCenter] );
      SetFound( True );
   end;
   Result := Found;
   if Result then DoAfterScroll;
end;

{**********************************************************
*  Module:  TAdsDataSet.GetCanModify
*  Input:
*  Output:
*  Return:  Boolean - Can we modify the data set?
*  Description: If dataset can modify and not in read only
*  mode then return true else false
**********************************************************}
function TAdsDataSet.GetCanModify: Boolean;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.GetCanModify' );
{$ENDIF }

   Result := mbCanModify and not ReadOnly;
end;

{**********************************************************
*  Module:  TAdsTableOptions.SetTableInstance
*  Input:  poAdsTable - The instance to set for the
*  Output:
*  Description:  Sets the data member for the character type
**********************************************************}
procedure TAdsTableOptions.SetTableInstance( poAdsTable : TAdsDataSet );
begin
{$IFDEF CALLTRACE}
   WriteCallTrace( 'TAdsTableOptions.SetTableInstance' );
{$ENDIF}

   mpoAdsTable := poAdsTable;
end;

{**********************************************************
*  Module:  TAdsTableOptions.SetAdsCharType
*  Input:  eValue - enumerated value for the character set type
*  Output:
*  Description:  Sets the data member for the character type
**********************************************************}
procedure TAdsTableOptions.SetAdsCharType( eValue: TAdsCharTypes );
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.SetAdsCharType' );
{$ENDIF }

   {  make sure the dataset is not active }
   if mpoAdsTable.Active then
      raise EADSDatabaseError.create( mpoAdsTable, AE_TADSDATASET_GENERAL,
                                      'Table must not be Active.' );

   // I don't think the ACE error string is very clear if a language is
   // set that the table type does not support, so we will catch that
   // case here and raise a more descriptive error. In theory this should be hard
   // to hit, because we filter the char types at design time.
   if ( ( mpoAdsTable.TableType = ttAdsNTX ) or ( mpoAdsTable.TableType = ttAdsCDX ) ) and
      ( eValue > OEM ) then
      raise EADSDatabaseError.create( mpoAdsTable, AE_TADSDATASET_GENERAL,
         'ttAdsCDX and ttAdsNTX table types only support an AdsCharType of ANSI or OEM.' );

   if ( integer(eValue) > High( TAdsCharTypeMap ) ) then
      raise EADSDatabaseError.create( mpoAdsTable, AE_TADSDATASET_GENERAL,
         'Invalid or unknown character type.' );

   meAdsCharType := eValue;

end;

{**********************************************************
*  Module:  TAdsTableOptions.SetAdsLockType
*  Input: eValue - enumerated type for the table lock type
*  Output:
*  Description: Sets the data member for the lock type
**********************************************************}
procedure TAdsTableOptions.SetAdsLockType( eValue: TAdsLockTypes );
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.SetAdsLockType' );
{$ENDIF }

   {  Make sure the table is not active }
   if mpoAdsTable.Active then
      raise EADSDatabaseError.create( mpoAdsTable, AE_TADSDATASET_GENERAL,
                                      'Table must not be Active.' );

   meAdsLockType := eValue;
end;

{**********************************************************
*  Module:  TAdsTableOptions.SetAdsCachingOption
*  Input: eValue - enumerated type for the table caching option
*  Output:
*  Description: Sets the data member for the caching option
**********************************************************}
procedure TAdsTableOptions.SetAdsCachingOption( eValue: TAdsTableCachingOption );
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.SetAdsCachingOption' );
{$ENDIF }

   {  Make sure the table is not active }
   if mpoAdsTable.Active then
      raise EADSDatabaseError.create( mpoAdsTable, AE_TADSDATASET_GENERAL,
                                      'Table must not be Active.' );

   meAdsCachingOption := eValue;
end;

{**********************************************************
*  Module:  TAdsTableOptiosn.SetAdsRecordCache
*  Input: eValue - enumerated type for the read-ahead record
*                  cache level.
*  Output:
*  Description: Sets the read-ahead record caching level.
*               This essentially provides more visible
*               access to the AdsCacheRecords API.
**********************************************************}
procedure TAdsTableOptions.SetAdsRecordCache( eValue: TAdsRecordCacheTypes );
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.SetAdsRecordCache' );
{$ENDIF }


   {  If the table is active, then change the cache level on the active handle }
   if mpoAdsTable.Active then
   begin
      case eValue of
         rcNone: ACECheck( mpoAdsTable, ACE.AdsCacheRecords( mpoAdsTable.Handle, 0 ) );  { no caching }
         rcStandard: ACECheck( mpoAdsTable, ACE.AdsCacheRecords( mpoAdsTable.Handle, ADS_NORMAL_RA_CACHE_SIZE ) );
         rcAggressive: ACECheck( mpoAdsTable, ACE.AdsCacheRecords( mpoAdsTable.Handle, ADS_AGGRESSIVE_RA_CACHE_SIZE ) );
      end;
   end;

   meAdsRecordCache := eValue;
end;

{**********************************************************
*  Module:  TAdsTableOptions.SetAdsRightsCheck
*  Input: bValue - flag to check rights or not
*  Output:
*  Description:  Sets the table member from the property value
*  for whether rights are to be checked or not
**********************************************************}
procedure TAdsTableOptions.SetAdsRightsCheck( bValue: Boolean );
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.SetAdsRightsCheck' );
{$ENDIF }

   {  if the table is active this is an illegal operation }
   if mpoAdsTable.Active then
      raise EADSDatabaseError.create( mpoAdsTable, AE_TADSDATASET_GENERAL,
                                      'Table must not be Active.' );

   mbAdsRightsCheck := bValue;
end;

{**********************************************************
*  Module:  TAdsTableOptions.SetAdsOptimizedFilters
*  Input: bValue - flag to set optimized filters
*  Output:
*  Description:  Sets AOF on or off
**********************************************************}
procedure TAdsTableOptions.SetAdsOptimizedFilters( bValue: Boolean );
var
   bHoldValue : Boolean;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.SetAdsOptimizedFilters' );
{$ENDIF }

   { Initialize the hold value }
   bHoldValue := mbAdsOptimizedFilters;

   if ( bValue <> mbAdsOptimizedFilters ) then
   begin
      if ( mpoAdsTable.Active ) AND Not( csLoading in mpoAdsTable.ComponentState ) AND
         ( mpoAdsTable.Filtered ) then
      begin
         try
            mpoAdsTable.DeactivateFilters;
            mbAdsOptimizedFilters := bValue;
            mpoAdsTable.ActivateFilters;
            mpoAdsTable.First;
         except
            mbAdsOptimizedFilters := bHoldValue;
            raise;
         end;
      end
      else
         mbAdsOptimizedFilters := bValue;
   end;
end;

{**********************************************************
*  Module:  TAdsDataSet.SetAdsConnection
*  Input: poValue - pointer to the connection object
*  Output:
*  Description: Sets a pointer to the connection component object
**********************************************************}
procedure TAdsDataSet.SetAdsConnection( poValue: TAdsConnection );
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.SetAdsConnection' );
{$ENDIF }

   {  illegal operation if the table is active }
   if Active then
      raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL,
                                      'Table must not be Active.' );

   {  clear the value so that a warning may be displayed again in GetFiles}
   mbDisplayedPathNoExistsWarning := FALSE;

   {  If the value is nil then the instance is being removed so remove the }
   {  table from the connections list, otherwise add the table to the }
   {  connections list }

   if ( poValue <> mpoAdsConnection ) then
   begin
      if mpoAdsConnection <> nil then
         mpoAdsConnection.RemoveTableFromConnectList( self );
      if poValue <> nil then
         poValue.AddTableToConnectList( self );
   end;

   {  Set the value }
   mpoAdsConnection := poValue;

   { if no database value is set, then copy information from the connection
     by calling the GetDatabasePath function }
   GetDatabasePath;
end;

{**********************************************************
*  Module:  TAdsDataSet.GetAdsConnection
*  Input:
*  Output:
*  Return: TAdsConnection - handle to the connection object
*  Description:  Returns the AdsConnection handle to the object
**********************************************************}
function TAdsDataSet.GetAdsConnection: TAdsConnection;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.GetAdsConnection' );
{$ENDIF }

   Result := mpoAdsConnection;
end;


{**********************************************************
*  Module:  TAdsDataSet.GetDataSource
*  Input:
*  Output:
*  Return:  TDataSource - pointer to the datasource object of Master link
*  Description:  Returns a pointer to the datasource object of Master link
**********************************************************}
function TAdsDataSet.GetDataSource: TDataSource;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.GetDataSource' );
{$ENDIF }
   Result := mpoMasterLink.DataSource;
end;

{**********************************************************
*  Module:  TAdsDataSet.GetMasterFields
*  Input:
*  Output:
*  Return: String - the field name of the master field to link on
*  Description:  Returns the field name of the master field to link on
**********************************************************}
{$IFDEF FPC}{$HINTS OFF}{$ENDIF}
function TAdsDataSet.GetMasterFields: string;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.GetMasterFields' );
{$ENDIF }

   Result := mstrMasterField;
end;

{**********************************************************
*  Module:  TAdsDataSet.MasterChanged
*  Input:  poSender - Owner
*  Output:
*  Description: Event handler when the master table has changed for the
*  updating of the relation for the detail/child table
**********************************************************}
procedure TAdsDataSet.MasterChanged( poSender: TObject );
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.MasterChanged' );
{$ENDIF }

  CheckBrowseMode;
  UpdateRange;
  ApplyRange;

end;  {  TAdsDataSet.MasterChanged }
{$IFDEF FPC}{$HINTS ON}{$ENDIF}


{**********************************************************
*  Module:  TAdsDataSet.SetLinkRanges
*  Input:  MasterFields - list of fields master/detail is
*          set on.
*  Output:
*  Description: updates range key buffers
*  Notes: highly leveraged from dbtables.pas
**********************************************************}
procedure TAdsDataSet.SetLinkRanges( MasterFields: TList );
var
  I: Integer;
  SaveState: TDataSetState;
begin
  SaveState := SetTempState( dsSetKey );
  try
    mpstKeyBuffer := InitKeyBuffer( mapKeyBuffers[kiRangeStart] );
    mpstKeyBuffer^.Modified := True;
    for I := 0 to MasterFields.Count - 1 do
      GetIndexField( I ).Assign( TField( MasterFields[I] ) );
    mpstKeyBuffer^.FieldCount := MasterFields.Count;
  finally
    RestoreState( SaveState );
  end;
  Move( mapKeyBuffers[kiRangeStart]^, mapKeyBuffers[kiRangeEnd]^,
    mapKeyBuffers[kiRangeStart]^.BufferSize );
end;   {* TAdsDataSet.SetLinkRanges *}



{**********************************************************
*  Module:  TAdsDataSet.CheckMasterRange
*  Input:
*  Output:
*  Description:
*  Notes: not currently used. leveraged from dbtables.pas,
*         and may be necessary in the future.
**********************************************************}
{$ifdef 0}
procedure TAdsDataSet.CheckMasterRange;
begin
  if mpoMasterLink.Active and ( mpoMasterLink.Fields.Count > 0 ) then
  begin
    SetLinkRanges( mpoMasterLink.Fields );
    SetCursorRange;
  end;
end;   {* TAdsDataSet.CheckMasterRange *}
{$endif}


{**********************************************************
*  Module:  TAdsDataSet.UpdateRange
*  Input:
*  Output:
*  Description: updates the keys for the range used in
*               master/detail
*  Notes: leveraged from dbtables.pas
**********************************************************}
procedure TAdsDataSet.UpdateRange;
begin
  SetLinkRanges( mpoMasterLink.Fields );
end;


{**********************************************************
*  Module:  TAdsDataSet.MasterDisabled
*  Input: poSender - Owner
*  Output:
*  Description: Event handler when the master becomes inactive
**********************************************************}
{$IFDEF FPC}{$HINTS OFF}{$ENDIF}
procedure TAdsDataSet.MasterDisabled( poSender: TObject );
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.MasterDisabled' );
{$ENDIF }

   CancelRange;
end;
{$IFDEF FPC}{$HINTS ON}{$ENDIF}


{**********************************************************
*  Module:  TAdsDataSet.SetMasterFields
*  Input:  strValue - master field value to set
*  Output:
*  Description: Sets the member value and causes the master link to
*  take affect.
**********************************************************}
procedure TAdsDataSet.SetMasterFields( const strValue: string );
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.SetMasterFields' );
{$ENDIF }

   mpoMasterLink.FieldNames := strValue;
   mstrMasterField := strValue;

end;


{**********************************************************
*  Module:  TAdsDataSet.SetDataSource
*  Input:  poValue - Data source to set for the master link
*  Output:
*  Description: Set the data source for the master link
**********************************************************}
procedure TAdsDataSet.SetDataSource( poValue: TDataSource );
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.SetDataSource' );
{$ENDIF }

   {  Do not allow circular links }
   if IsLinkedTo( poValue ) then
      raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL,
                                      'Circular Data Link' );

   {  set the data source for the master link }
   mpoMasterLink.DataSource := poValue;

   {  if the value is nil then blank out the master field }
   if poValue = nil then
      MasterFields := '';
end;



{**********************************************************
*  Module:  TAdsDataSet.GetSegmentFieldNum
*  Input:
*  Output:
*  Description:   Take a segment number and return
*                 the field number.
**********************************************************}
function TAdsDataSet.GetSegmentFieldNum( iSegment : integer ) : integer;
var
   acFieldName : array[0..ADS_MAX_FIELD_NAME] of AceChar;
   usLen       : UNSIGNED16;
begin
   if ( ActiveHandle = Handle ) then
      raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL,
                                      'Internal Error: GetSegmentFieldNum : No Active Index' );

   {* First get the field name from the segment number *}
   usLen := ADS_MAX_FIELD_NAME;
   ACECHECK( self, ACEUNPUB.AdsGetSegmentFieldName( ActiveHandle, iSegment, @acFieldName, @usLen ) );

   {* Then the field number from the field name *}
   Result := FACEFieldDefs[ FACEFieldDefs.IndexOf( string( acFieldName ) ) ].FieldNumber;
end;



{**********************************************************
*  Module:  TAdsDataSet.GetIsIndexField
*  Input:
*  Output:
*  Description:
**********************************************************}
function TAdsDataSet.GetIsIndexField( Field: TField ): Boolean;
var
   I : integer;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.GetIsIndexField' );
{$ENDIF }

   if (State = dsSetKey) and (IndexFieldCount = 0) then
      Result := True
   else
   begin
      Result := False;
      with Field do
      if FieldNo > 0 then
         for I := 0 to IndexFieldCount - 1 do
            if GetSegmentFieldNum(I) = FieldNo then
            begin
               Result := True;
               Exit;
            end;
   end;
end;   {* TAdsDataSet.GetIsIndexField *}



{**********************************************************
*  Module:  TAdsDataSet.InitFieldDefs
*  Input:
*  Output:
*  Description: Initialize the field definitions
**********************************************************}
procedure TAdsDataSet.InitFieldDefs;
var
   sCount : SIGNED16;
   usFieldCount : UNSIGNED16;
   bTempHandle : Boolean;
   hHoldHandle : ADSHANDLE;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.InitFieldDefs' );
{$ENDIF }

   {  if the table is not active then open a temporary table handle }
   {  otherwise get the active table handle }
   if ( Active ) OR ( Handle <> INVALID_ACE_HANDLE ) then
   begin
      bTempHandle := False;
      hHoldHandle := self.Handle;
   end
   else
   begin
      bTempHandle := True;
      hHoldHandle := OpenAdvantageFiles;
   end;

   {  Get number of fields. }
   ACECheck( self, ACE.AdsGetNumFields( hHoldHandle, @usFieldcount ) );
   FieldDefs.Clear;
   FACEFieldDefs.Clear;

   {  Get field definitions. }
   for sCount := 1 to usFieldCount do
   begin
      AddFieldDesc( hHoldHandle, sCount );
   end;

   {  if a temporary handle was opened then close it }
   if bTempHandle then
      ACECheck( self, ACE.AdsCloseTable( hHoldHandle ) );

end;

{**********************************************************
*  Module:  TAdsDataSet.InitRecord
*  Input:  Buffer - Buffer to initialize
*  Output:
*  Description: Call the inherited init record and init the rec info
**********************************************************}
procedure TAdsDataSet.InitRecord( Buffer: PAdsBuffer );
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.InitRecord' );
{$ENDIF }

   {  Call the inherited init record buffer }
   inherited InitRecord( Buffer );

   {  initialize the record information }
   with PRecInfo( Buffer + musRecInfoOfs )^ do
   begin
     UpdateStatus := usUnmodified;
     BookMarkFlag := bfCurrent;
     LogicalRecNumber := -1;
   end;

   PUNSIGNED32( Buffer + musBookmarkOfs )^ := 0;
end;

{**********************************************************
*  Module:  TAdsDataSet.InternalRefresh
*  Input:
*  Output:
*  Description:  Not yet Implemnted
**********************************************************}
procedure TAdsDataSet.InternalRefresh;
var
   ulRetCode : UNSIGNED32;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.InternalRefresh' );
{$ENDIF }

   ulRetCode := ACE.AdsRefreshRecord( Self.Handle );
   if ulRetCode <> AE_NO_CURRENT_RECORD then
      ACECheck( self, ulRetCode );
end;

{**********************************************************
*  Module:  TAdsDataSet.OpenCursor
*  Input: InfoQuery : Boolean
*  Output:
*  Description: No op.  Call inherited method
**********************************************************}
procedure TAdsDataSet.OpenCursor( InfoQuery: Boolean );
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.OpenCursor' );
{$ENDIF }

   {  call inherited open cursor }
   inherited OpenCursor( InfoQuery );
end;

{**********************************************************
*  Module:  TAdsDataSet.SetFiltered
*  Input:  Value : Boolean whether to activate or deactivate filters
*  Output:
*  Description:  Activates or deactivates filters.  calls inherited
*  method as well
**********************************************************}
procedure TAdsDataSet.SetFiltered( Value: Boolean );
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.SetFiltered' );
{$ENDIF }

   {  Call TDataSets SetFiltered }
   inherited SetFiltered( Value );

   if Handle <> INVALID_ACE_HANDLE then
   begin
      {  if true activate else false deactivate }
      if Value then
      begin
         ActivateFilters;
      end
      else
         DeactivateFilters;
      if Active then
         First;
   end;
end;

{**********************************************************
*  Module:  TAdsDataSet.SetFilterText
*  Input:  Value : String of filter text
*  Output:
*  Description: If active and filtered then call set filtered true, and
*  call the inherited setfilteredtext
**********************************************************}
procedure TAdsDataSet.SetFilterText( const Value: string );
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.SetFilterText' );
{$ENDIF }

   {  call the inherited SetFilterText and pass in the value }
   inherited SetFilterText( Value );

   if active and filtered then
      SetFiltered( True );

end;  {  TAdsDataSet.SetFilterText }

{**********************************************************
*  Module:  TAdsDataSet.SetScopeStart
*  Input:  Value : String of scope start
*  Output:
*  Description: Sets the scope beginning string
**********************************************************}
procedure TAdsDataSet.SetScopeStart( strValue: string );
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.SetScopeStart' );
{$ENDIF }

   {  If Value is greater than scope length - 1 then generate exception }
   {  -1 for the null that will need to be there for character arrays passed to ACE }
   if ( ( Length( strValue ) - 1 ) > ADS_MAX_KEY_LENGTH ) then
      raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL,
         'Scope text length exceeded ' + Inttostr( ADS_MAX_KEY_LENGTH ) );

   mstrScopeStart := strValue;
end;

{**********************************************************
*  Module:  TAdsDataSet.SetScopeEnd
*  Input:  strValue : String of scope end
*  Output:
*  Description: Sets the scope ending string
**********************************************************}
procedure TAdsDataSet.SetScopeEnd( strValue: string );
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.SetScopeEnd' );
{$ENDIF }

   {  If Value is greater than scope length - 1 then generate exception }
   {  -1 for the null that will need to be there for character arrays passed to ACE }
   if ( ( Length( strValue ) - 1 ) > ADS_MAX_KEY_LENGTH ) then
      raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL,
         'Scope text length exceeded ' + Inttostr( ADS_MAX_KEY_LENGTH ) );

   mstrScopeEnd := strValue;
end;


{**********************************************************
*  Module:  TAdsDataSet.SetOnFilterRecord
*  Input:
*  Output:
*  Description:  Not yet implemented
**********************************************************}
procedure TAdsDataSet.SetOnFilterRecord( const Value: TFilterRecordEvent );
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.SetOnFilterRecord' );
{$ENDIF }

   inherited SetOnFilterRecord( Value );
end;

{**********************************************************
*  Module:  TAdsDataSet.UpdateIndexDefs
*  Input:
*  Output:
*  Description:
**********************************************************}
procedure TAdsDataSet.UpdateIndexDefs;
var
   sArrayCount :       SIGNED16;
   sSegmentCount :     SIGNED16;
   phIndexArray :      PADSHandleArray;
   usSegments :        UNSIGNED16;
   usArrayLength :     UNSIGNED16;
   usExprLength :      UNSIGNED16;
   usIndexNameLength : UNSIGNED16;
   acExpression :      array[0..ADS_MAX_INDEX_EXPR_LEN - 1] of AceChar;
   acIndexName :       array[0..ADS_MAX_PATH - 1] of AceChar;
   strFields :         String;
   strIndexName :      String;
   hHoldHandle :       ADSHANDLE;
   oIndexOptions :     TIndexOptions;
   usBoolOption :      UNSIGNED16;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.UpdateIndexDefs' );
{$ENDIF }

   if not mpoIndexDefs.Updated then
   begin
      if Self.Handle = INVALID_ACE_HANDLE then
         hHoldHandle := OpenAdvantageFiles
      else {  if component is active use the already existing table handle }
      begin
         hHoldHandle := Self.Handle;
      end;

      {* Initialize to nil, to prevent problems if the clear call fails. *}
      phIndexArray := nil;

      try
         mpoIndexDefs.Clear;

         {  Get an array of all of the active indexes }
         ACECheck( self, ACE.AdsGetNumIndexes( hHoldHandle, @usArrayLength ) );
         GetMem( phIndexArray, usArrayLength * sizeof( ADSHANDLE )  );

         ACECheck( self, ACE.AdsGetAllIndexes( hHoldHandle, @(phIndexArray[0]), @usArrayLength ) );

         for sArrayCount := 0 to usArrayLength -1 do
         begin
            {  clear TIndexOptions set }
            oIndexOptions := [];

            usIndexNameLength := ADS_MAX_PATH;
            {  Get the index name of the ith index }
            ACECheck( self, ACE.AdsGetIndexName( phIndexArray[sArrayCount], @acIndexName,
                                           @usIndexNameLength ) );
            strIndexName := string( acIndexName );

            { Ace can parse the expression get the number of segments in the expression }
            ACECheck( self, ACEUNPUB.AdsGetNumSegments( phIndexArray[sArrayCount], @usSegments ) );

            strFields := '';

            {  For all of the segments build an expression }
            for sSegmentCount := 0 to usSegments - 1 do
            begin
               usExprLength := ADS_MAX_INDEX_EXPR_LEN;
               ACECheck( self, ACEUNPUB.AdsGetSegmentFieldName( phIndexArray[sArrayCount],
                                                          sSegmentCount, @acExpression,
                                                          @usExprLength ) );

               {  Make the expression a semi-colon delimited string }
               if strFields = '' then
                  strFields := string( acExpression )
               else
                  strFields := strFields + ';' + string( acExpression );
            end;

            {  build indexoptions set }
            ACECheck( self, ACE.AdsIsIndexDescending( phIndexArray[sArrayCount],
                                                      @usBoolOption ) );
            if ( usBoolOption = 1 ) then
               Include( oIndexOptions, ixDescending );

            ACECheck( self, ACE.AdsIsIndexUnique( phIndexArray[sArrayCount],
                                                  @usBoolOption ) );
            if ( usBoolOption = 1 ) then
               Include( oIndexOptions, ixUnique );

            if ( TableType = ttAdsVFP ) then
            begin
               ACECheck( self, ACE.AdsIsIndexCandidate( phIndexArray[sArrayCount],
                                                        @usBoolOption ) );
               if ( usBoolOption = 1 ) then
                  Include( oIndexOptions, ixUnique );
            end;

            ACECheck( self, ACE.AdsIsIndexPrimaryKey( phIndexArray[sArrayCount],
                                                      @usBoolOption ) );
            if ( usBoolOption = 1 ) then
               Include( oIndexOptions, ixPrimary );

            mpoIndexDefs.Add( strIndexName, UpperCase( strFields ), oIndexOptions );
         end;

         IndexDefs.Updated := True;

      finally

         if ( phIndexArray <> nil ) then
            Dispose( phIndexArray );

         { Always close table if opened locally }
         if Self.Handle <> hHoldHandle then
            ACECheck( self, ACE.AdsCloseTable( hHoldHandle ) );
      end;
   end;
end;

{**********************************************************
*  Module:  TAdsDataSet.BookmarkValid
*  Input:
*  Output:
*  Return: Boolean - Successful
*  Description:  Checks the passed in bookmark to see if the
*  bookmark(record number) is a valid bookmark (record number)
**********************************************************}
function TAdsDataSet.BookmarkValid( Bookmark: TBookmark ): Boolean;
var
   ulRetVal : UNSIGNED32;
   usEOF    : UNSIGNED16;
   bShowDeleted   : UNSIGNED16;
   bIsDeleted     : UNSIGNED16;

begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.BookmarkValid' );
{$ENDIF }

   {  If the table is not active then can't check bookmarks }
   Result := False;
   if ( Not Active ) OR ( Bookmark = nil ) then
      exit;

   CursorPosChanged;
   {  Hold a temporary positon to current cursor position while bookmark is checked }
   ulRetVal := ACE.AdsGotoBookmark( Handle, Integer( Pointer( Bookmark )^ ) );

   {  If not success in trying to goto the bookmark then it is not valid }
   if ulRetVal <> AE_SUCCESS then
      exit;

   {  If at EOF then it is not valid }
   ulRetVal := ACE.AdsAtEOF( Handle, @usEOF );

   if ( ulRetVal = AE_SUCCESS ) and ( usEOF = 0 ) then
      Result := True;

   { make sure that the record has not been deleted }
   if ( Result ) and (( meTableType = ttAdsVFP ) or ( meTableType = ttAdsCDX ) or ( meTableType = ttAdsNTX )) then
   begin
      ACECheck( self, ACE.AdsIsRecordDeleted( Handle, @bIsDeleted ) );
      if ( bIsDeleted = ADS_TRUE ) then
      begin
         ACECheck( self, AdsGetDeleted( @bShowDeleted ) );
         if ( bShowDeleted = ADS_FALSE ) then
         begin
            // the record is deleted and show deleted is false, so the
            // bookmark is invalid
            Result := FALSE;
         end;
      end;
   end;
end;  {  TAdsDataSet.BookmarkValid }


{**********************************************************
*  Module:  TAdsDataSet.Cancel
*  Input:
*  Output:
*  Description: Calls the inherited Cancel
**********************************************************}
procedure TAdsDataSet.Cancel;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.Cancel' );
{$ENDIF }

   inherited Cancel;

   {  if the state is in dsSetKey then restore the save buffer }
   if State = dsSetKey then
      PostKeyBuffer( False );
end;

{**********************************************************
*  Module:  TAdsDataSet.CompareBookmarks
*  Input:
*  Output:
*  Return:  Integer
*  Description:  Compares the two bookmarks for similarity
*  the following is the BDE definition:
*
*  type
*     PCMPBkMkRslt = ^CMPBkMkRslt;
*     CMPBkMkRslt = TypedEnum;
*  const
*     CMPLess           = -1;     Bkm1 < Bkm2
*     CMPEql            = 0;      BookMarks are exactly the same
*     CMPGtr            = 1;      Bkm1 > Bkm2
*     CMPKeyEql         = 2;      Only Bkm1.key_val = Bkm2.key_val
**********************************************************}
function TAdsDataSet.CompareBookmarks( Bookmark1, Bookmark2: TBookmark ): Integer;
const
   RetCodes: array[Boolean, Boolean] of ShortInt = ((CMPKeyEql,CMPLess),(CMPGtr,CMPEql));
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.CompareBookmarks' );
{$ENDIF }

   { Check for uninitialized bookmarks }
   Result := RetCodes[Bookmark1 = nil, Bookmark2 = nil];
   if Result = 2 then
         ACECheck( self, ACE.AdsCompareBookmarks( Pointer(Bookmark1), Pointer(Bookmark2), @Result ) );

end;  { TAdsDataSet.CompareBookmarks }

{**********************************************************
*  Module:  TAdsDataSet.GetCurrentRecord
*  Input: Buffer -  buffer to hold the returned current record
*  Output: Buffer - same
*  Return: Boolean - successful
*  Description: Get the current record
**********************************************************}
function TAdsDataSet.GetCurrentRecord( Buffer: PAdsBuffer ): Boolean;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.GetCurrentRecord' );
{$ENDIF }
   Result := False;

   {  if the dataset is not empty and the bookmark flag is current }
   if not IsEmpty and ( GetBookmarkFlag( ActiveBuffer ) = bfCurrent ) then
   begin
      UpdateCursorPos;
      {  Copy the record from the active buffer into the user buffer }
      MemCopy( Buffer, ActiveBuffer, musRecordSize );
      Result := True;
   end;
end;


{**********************************************************
*  Module:  TAdsDataSet.IsSequenced
*  Input:
*  Output:
*  Return: Boolean - Let the user know if the data set is sequenced
*  Description:  This function will always return false for
*  compatability sake.  Dbase cannot be sequenced, however Paradox
*  can but Paradox is not supported
**********************************************************}
function TAdsDataSet.IsSequenced: Boolean;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.IsSequenced' );
{$ENDIF }
   if mbIsSequenced then
      Result := True
   else
      Result := False;
end;


{**********************************************************
*  Module:  TAdsDataSet.FieldsAreIndexed
*  Input:  strKeyFields - String of ';' delimited key fields
*  Output: hIndexField  - index handle
*  Return: Boolean - true if field is indexed
*  Description:  Finds out whether or not a field or group of fields are
*  indexed on or not.
**********************************************************}
function TAdsDataSet.FieldsAreIndexed( const strKeyFields: string;
                                       var hIndexField : ADSHANDLE ) : Boolean;
var
   poIndexDef : TIndexDef;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.FieldsAreIndexed' );
{$ENDIF }
   {  Get the lastest index defs }
   mpoIndexDefs.Update;

   hIndexField := INVALID_ACE_HANDLE;

   poIndexDef := mpoIndexDefs.GetIndexForFields( strKeyFields, FALSE { not case insensitive } );

   if Nil = poIndexDef then
      Result := False
   else
   begin
      ACECheck( self, ACE.AdsGetIndexHandle( handle, PAceChar( AnsiString( poIndexDef.Name ) ), @hIndexField ) );
      Result := True;
   end;

end;  {  TAdsDataSet.FieldsAreIndexed }



{**********************************************************
*  Module:  TAdsDataSet.BuildFilterString
*  Input:   poFields - list of fields to use
*  Output:
*  Return:  filter string
*  Description: build a filter string based on the fields given
*               in poFields and the filter buffer.
*  Note: Private
**********************************************************}
function TAdsDataSet.BuildFilterString( poFields : TList;
                                        bExactCompare : Boolean;
                                        bCaseInsensitive : Boolean ) : string;
var
   sFieldCount    : SIGNED16;
   usFieldType    : UNSIGNED16;
   strFieldName   : string;
   strFieldValue  : string;
   strCompare     : string;
   strTemp        : string;
   ulFieldLength  : UNSIGNED32;
   strUpperStart  : string;
   strUpperEnd    : string;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.BuildFilterString' );
{$ENDIF }
   Result := '';

   if bExactCompare then
      strCompare := '=='
   else
      strCompare := '=';

   if bCaseInsensitive then
   begin
      strUpperStart := 'UPPER(';
      strUpperEnd   := ')';
   end
   else
   begin
      strUpperStart := '';
      strUpperEnd   := '';
   end;

   if state <> dsFilter then
      raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL,
         'Internal Error, << BuildFilterString >>' );

   {  Build the filter string first }
   for sFieldCount := 0 to poFields.Count - 1 do
   begin
      {  Get the field and the corrosponding data value }
      strFieldName := TField( poFields[sFieldCount] ).FieldName;

      {  Need to get the field type to know if we need to put quotes around the value }
      usFieldType := FACEFieldDefs[ FACEFieldDefs.IndexOf( TField( poFields[sFieldCount] ).FieldName ) ].FieldType;

      if ( FieldByName( strFieldName ).IsNULL ) then
      begin
         if ( sFieldCount = 0 ) then
            Result := '(empty(' + strFieldName + '))'
         else
            Result := Result + ' AND ' + '(empty(' + strFieldName + '))';
      end
      else
      begin
         strFieldValue := FieldByName( strFieldName ).AsString;

         case( usFieldType ) of

            ADS_NUMERIC,
            ADS_DOUBLE,
            ADS_CURDOUBLE,
            ADS_MONEY:
            begin
               // strFieldValue currently is formatted using Delphi's decimal separator. ACE only
               // knows to use the dot (.).
               // The ThousandsSeparator never gets here (AsString seems to eliminate it), so we
               // don't worry about it.
               strFieldValue := StringReplace( strFieldValue, DecimalSeparator, '.', [rfReplaceAll] );
            end;

            ADS_LOGICAL:
            begin
               {* AsString method called above returns environment-specific string, which will be
               * different for different languages. Call AsBoolean method to get the real value. *}
               if ( FieldByName( strFieldName ).AsBoolean ) then
                  strFieldValue := '.TRUE.'
               else
                  strFieldValue := '.FALSE.';
            end;

            ADS_DATE:
            begin
               {* NOTE: If the Delphi ShortDateFormat variable is different than the ADS date format this
                * next call can fail, because ctod expects a string formatted according to the ADS
                * date format. *}
               strFieldValue := 'ctod("' + strFieldValue + '")';
            end;

            ADS_TIME:
               {* See NOTE above *}
               strFieldValue := 'ctot("' + strFieldValue + '")';

            ADS_TIMESTAMP,
            ADS_MODTIME:
               {* See NOTE above *}
               strFieldValue := 'ctots("' + strFieldValue + '")';

            ADS_STRING,
            ADS_CISTRING,
{$IFDEF ADSDELPHI2008_OR_NEWER}
            ADS_NCHAR,
            ADS_NVARCHAR,
{$ENDIF}
            ADS_VARCHAR_FOX:
            begin
               {  Since delphi always trims the string field, we must pad the string field }
               {  to exact size for the compare }
               if bExactCompare then
               begin
                  ulFieldLength := FACEFieldDefs[ sFieldCount ].Length;

                  if ( longint( ulFieldLength ) > Length( strFieldValue ) ) then
                  begin
                     strTemp := Format( '%-*s', [ ulFieldLength, strFieldValue ] );
                     strFieldValue := strTemp;
                  end;
               end;
               {*
                * We can't simply put quotes around the string since the string can contain quotes.
                * Instead find all quotes in the string and replace it with "CHR(34)". Putting
                * CHR(34) in quotes fixes the quotes in quotes issue since the expression engine
                * can keep the multiple quotes seperate. (In the ASCII chart, 34 is the quote).
                *}
               strFieldValue := #34 + StringReplace( strFieldValue, '"', #34'+ Chr(34) + '#34, [rfReplaceAll] ) + #34;
            end;
         end;


         if ( sFieldCount = 0 ) then
         begin
{$IFDEF ADSDELPHI2008_OR_NEWER}
            if ( usFieldType = ADS_STRING ) or ( usFieldType = ADS_CISTRING ) or ( usFieldType = ADS_VARCHAR_FOX ) or
               ( usFieldType = ADS_NCHAR ) or ( usFieldType = ADS_NVARCHAR ) then
{$ELSE}
            if ( usFieldType = ADS_STRING ) or ( usFieldType = ADS_CISTRING ) or ( usFieldType = ADS_VARCHAR_FOX ) then
{$ENDIF}
               Result := '(' + strUpperStart + strFieldName + strUpperEnd +
                               strCompare +
                               strUpperStart + strFieldValue + strUpperEnd + ')'
            else
               Result := '(' + strFieldName + strCompare + strFieldValue + ')';
         end
         else
         begin
{$IFDEF ADSDELPHI2008_OR_NEWER}
            if ( usFieldType = ADS_STRING ) or ( usFieldType = ADS_CISTRING ) or ( usFieldType = ADS_VARCHAR_FOX ) or
               ( usFieldType = ADS_NCHAR ) or ( usFieldType = ADS_NVARCHAR ) then
{$ELSE}
            if ( usFieldType = ADS_STRING ) or ( usFieldType = ADS_CISTRING ) or ( usFieldType = ADS_VARCHAR_FOX ) then
{$ENDIF}
               Result := Result + ' AND ' + '(' + strUpperStart + strFieldName + strUpperEnd +
                                                  strCompare +
                                                  strUpperStart + strFieldValue + strUpperEnd + ')'
            else
               Result := Result + ' AND ' + '(' + strFieldName + strCompare + strFieldValue + ')';
         end;

      end;   {* If field is NULL *}

   end;  {  For sFieldCount := ...}

end;  {  TAdsDataSet.BuildFilterString }


{**********************************************************
*  Module:  FieldsMatchPartial
*  Input:   strKeyFields - string of ';' delimited fields in the index key
*           pcLookupFields - string of ';' fields to lookup
*  Output:  strLastMatch - last field in the strKeyFields that is also in strLookupFields
*  Return:  Boolean - If look up field matches fully or partially with the key fields.
*  Description: for a given set of look up fields, the function will return TRUE if
*               the lookup field matched all fields in the key fields or if the lookup
*               fields matched the first n consecutive fields in the key fields list.
*               example: FieldsMatchPartial( 'a;b;c;d', 'c;b;a', R ) returns True and R = 'c'
*                        FieldsMatchPartial( 'a;b;c;d', 'd;c;a;b', R ) returns True with R = 'd'
*                        FieldsMatchPartial( 'a;b;c;d', 'b;c', R ) returns False
*  Note: strLastMatch should return in all upper case letters.
**********************************************************}
function FieldsMatchPartial( const strKeyFields  : string;
                             const pcLookupFields : PAceChar;
                             var strLastMatch : string ) : boolean;
var
   aucKeyFields    : array[1..100] of Byte;  { assume they will never have more than 100 fields }
                                             { in a single index tag }
   usLastField     : UNSIGNED16;

   pcFieldBegin, pcFieldEnd : PAceChar;
   usFieldIndex    : UNSIGNED16;
   acField         : array[ 0..ADS_MAX_FIELD_NAME ] of AceChar;
begin
{$IFDEF CALLTRACE}
   WriteCallTrace( 'FieldsMatchPartial' );
{$ENDIF}

   usLastField := 0;
   FillMemory( @aucKeyFields[1], 100, Byte( #0 ) );

   pcFieldBegin := pcLookupFields;

   Result := False;

   repeat
      pcFieldEnd := StrPos( pcFieldBegin, ';' );

      {  if there is no more ';', copy the entire string into the field name }
      if pcFieldEnd = Nil then
         strcopy( acField, pcFieldBegin )
      else
      begin
         {  Copy from the begin position to end position - 1, then set the }
         {  begin position to end position + 1 }
         strLcopy( acField, pcFieldBegin, pcFieldEnd - pcFieldBegin );
         pcFieldBegin := pcFieldEnd + 1;
      end;

      usFieldIndex := GetFieldIndexFromString( acField, strKeyFields );

      {  If the field is not in the index field list then no need to go further }
      if ( usFieldIndex = 0 ) or ( usFieldIndex > 100 ) then
         exit;

      aucKeyFields[ usFieldIndex ] := 1;

      {  Update the last matched field }
      if usFieldIndex > usLastField then
         usLastField := usFieldIndex;

   until pcFieldEnd = Nil;

   {  If there is no hole from the last matched field to the first field, then we have }
   {  a partially matched field list }
   for usFieldIndex := 1 to usLastField do
      if aucKeyFields[ usFieldIndex ] = 0 then
         exit;

   {  Return the correct results }
   Result := True;
   strLastMatch := UpperCase( GetIndexExprField( usLastField, PChar( strKeyFields ) ) );
end;  {  FieldsMatchPartial }



{**********************************************************
*  Module:  TAdsDataSet.LocateLocally
*  Input:   strFilter : filter string to use in eval
*  Output:
*  Return:  Boolean - If the locate found anything
*  Description: Used to evaluate filter locally if for
*    some weird reason the user has both an aof and a
*    std filter set and then calls the locate function.
**********************************************************}
function TAdsDataSet.LocateLocally( strFilter : string ) : boolean;
var
   usIsEOF  : UNSIGNED16;
   usPassed : UNSIGNED16;
begin
   {*
    * multiple filters set, gotop and evaluate locate filter until we
    * find a record that passes is.
    *}
   usPassed := 0;
   ACECheck( self, ACE.AdsGotoTop( ActiveHandle ) );
   ACECheck( self, ACE.AdsAtEof( Handle, @usIsEOF ) );

   while ( usIsEOF = 0 ) do
   begin
      ACECheck( self, ACE.AdsEvalLogicalExpr( ActiveHandle, PAceChar( AnsiString( strFilter )), @usPassed ) );
      if ( usPassed = 1 ) then
         break;

      ACECheck( self, ACE.AdsSkip( ActiveHandle, 1 ) );
      ACECheck( self, ACE.AdsAtEOF( Handle, @usIsEOF ) );
   end;

   Result := ( usPassed = 1 );
end;   {* TAdsDataSet.LocateLocally *}



{**********************************************************
*  Module:  TAdsDataSet.EvalClientFilteredSeek
*  Return:  Boolean - If any records pass the filter
*  Description:
**********************************************************}
procedure TAdsDataSet.EvalClientFilteredSeek( pcKey     : PChar;
                                              usKeyLen  : UNSIGNED16;
                                              usKeyType : UNSIGNED16;
                                              pusFound  : PUNSIGNED16 );
var
   usEOF        : UNSIGNED16;
   usLocalFound : UNSIGNED16;
   bAccept      : boolean;
   pucRecord    : PAdsBuffer;
   ulRecLen     : UNSIGNED32;
   pcNewKey     : PAdsBuffer;
   usNewKeyLen  : UNSIGNED16;
   usFullKeyLen : UNSIGNED16;
   bGotKeyMem   : boolean;
begin
   pusFound^  := 0;
   usEOF      := 0;
   bAccept    := false;
   bGotKeyMem := false;
   pcNewKey   := nil;

   {* Should only be in here if the user has a client-side filter. *}
   if not Assigned( OnFilterRecord ) then
      raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL,
                                      'Expected OnFilterRecord event.' );

   ACECheck( self, ACE.AdsSeek( ActiveHandle, PAceChar( pcKey ), usKeyLen, usKeyType,
             ADS_HARDSEEK, @usLocalFound ) );

   {* If we didn't find a record, we're done. *}
   if ( usLocalFound = 0 ) then
      exit;

   {* Find a record that also passes the client-side filter. *}
   pucRecord := AllocRecordBuffer;

   try
      ulRecLen := musRecBufSize;
      ACECheck( self, AdsGetRecord( Handle, PAceChar( pucRecord ), @ulRecLen ) );

      while ( ( bAccept = false ) and ( usEOF <> 1 ) ) do
      begin
         if mpoAdsTableOptions.AdsCalcFieldsBeforeFilter then
            GetCalcFields( pucRecord );

         bAccept := RecordFilter( pucRecord );

         {* If it doesn't pass, move ahead and try the next record. *}
         if not bAccept then
         begin
            ACECheck( self, ACE.AdsSkip( ActiveHandle, 1 ) );
            ACECheck( self, ACE.AdsAtEof( Handle, @usEOF ) );

            {* If we're not at eof, get the key for this record and
             * make sure it's the same as the key we did the initial
             * seek for. If not, then we're done. *}
            if ( usEOF = 0 ) then
            begin
               ulRecLen := musRecBufSize;
               ACECheck( self, AdsGetRecord( Handle, PAceChar( pucRecord ), @ulRecLen ) );

               if not bGotKeyMem then
               begin
                  ACECheck( self, ACE.AdsGetKeyLength( ActiveHandle, @usFullKeyLen ) );
                  GetMem( pcNewKey, usFullKeyLen );
                  bGotKeyMem := true;
               end;

               usNewKeyLen := usFullKeyLen;
               ACECheck( self, ACEUNPUB.AdsBuildKeyFromRecord( ActiveHandle,
                                                               PAceChar( pucRecord ),
                                                               ulRecLen,
                                                               PAceChar( pcNewKey ),
                                                               @usNewKeyLen ) );

               {* Key should be bigger or equal to the key we got from the caller. *}
               if ( usNewKeyLen < usKeyLen ) then
                  raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL,
                                                  'Invalid key size.' );

               {* Do the comparison. *}
               if not CompareMem( pcKey, pcNewKey, usKeyLen ) then
                  exit;
            end;

         end;
      end;
   finally
      FreeRecordBuffer( pucRecord );
      if bGotKeyMem then
         FreeMem( pcNewKey );
   end;

   if bAccept then
      pusFound^ := 1;

end;  {* EvalClientFilteredSeek *}


{**********************************************************
*  Module:  TAdsDataSet.EvalClientFilter
*  Return:  Boolean - If any records pass the filter
*  Description: An ACE filter or scope is expected to be
*  set. This function will then evaluate the client filter
*  to further filter the dataset and verify we position on
*  a record that both ADS and the client-side filter
*  accept.
**********************************************************}
function TAdsDataSet.EvalClientFilter( bForward : boolean ) : boolean;
var
   usEOF       : UNSIGNED16;
   pucRecord   : PAdsBuffer;
   ulRecLen    : UNSIGNED32;
begin
   usEOF := 0;
   Result := false;

   {* Should only be in here if the user has a client-side filter. *}
   if not Assigned( OnFilterRecord ) then
      raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL,
                                      'Expected OnFilterRecord event.' );

   pucRecord := AllocRecordBuffer;

   try
      while ( ( Result = false ) and ( usEOF <> 1 ) ) do
      begin
         ulRecLen := musRecBufSize;
         ACECheck( self, AdsGetRecord( Handle, PAceChar( pucRecord ), @ulRecLen ) );

         if mpoAdsTableOptions.AdsCalcFieldsBeforeFilter then
            GetCalcFields( pucRecord );

         Result := RecordFilter( pucRecord );

         {* If it doesn't pass, move and try the next record. *}
         if not Result then
         begin
            if bForward then
            begin
               ACECheck( self, ACE.AdsSkip( ActiveHandle, 1 ) );
               ACECheck( self, ACE.AdsAtEof( Handle, @usEOF ) );
            end
            else
            begin
               ACECheck( self, ACE.AdsSkip( ActiveHandle, -1 ) );
               ACECheck( self, ACE.AdsAtBof( Handle, @usEOF ) );
            end;
         end;
      end;
   finally
      FreeRecordBuffer( pucRecord );
   end;

end;   {* EvalClientFilter *}



{**********************************************************
*  Module:  TAdsDataSet.LocateRecord
*  Input:   KeyFields - string of ';' delimited fields
*           KeyValues - string of ';' delimited values
*           Options - case and partial key
*  Output:
*  Return:  Boolean - If the locate found anything
*  Description: for a given set of fields with corrosponding values
*  find the instance of it in the dataset
**********************************************************}
function TAdsDataSet.LocateRecord( const KeyFields: string;
                                   const KeyValues: Variant;
                                   Options: TLocateOptions ): Boolean;
var
   poFields       : TList;
   bIsEOF         : UNSIGNED16;
   bFound         : UNSIGNED16;
   strFilter      : String;
   strLastField   : String;
   usKeyLength    : UNSIGNED16;
   usFilterLength : UNSIGNED16;
   acKey          : array[0..ADS_MAX_KEY_LENGTH - 1] of AceChar;
   usFieldCount   : UNSIGNED16;
   ulRetVal       : UNSIGNED32;
   usCurrExact    : UNSIGNED16;
   ulFieldOffset  : UNSIGNED32;
   ulFieldLength  : UNSIGNED32;
   usFieldType    : UNSIGNED16;
   hACEBookmark   : ADSHANDLE;
   strFieldNames  : String;
   usLength       : UNSIGNED16;
   usNumSegs      : UNSIGNED16;
   sSegmentCount  : SIGNED16;
   usExprLength   : UNSIGNED16;
   acExpression   : array[0..ADS_MAX_INDEX_EXPR_LEN - 1] of AceChar;
   usIndexCount   : UNSIGNED16;
   phIndexArray   : PADSHandleArray;
   acIndexName    : Array[0..ADS_MAX_TAG_NAME - 1] of AceChar;
   usNameLength   : UNSIGNED16;
   bFieldsMatch   : Boolean;
   hUseHandle     : ADSHANDLE;
   bCaseInsensitive : Boolean;
   bAOFActive     : Boolean;
   bFilterActive  : Boolean;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.LocateRecord' );
{$ENDIF }

   CheckBrowseMode;
   Result := False;
   bAOFActive := False;
   bFilterActive := False;
{$IFDEF FPC}
   phIndexArray := nil;
{$ENDIF}
   strLastField := '';

   {  Save the current ACE record number so we can reposition back if the locate fails }
   ACECheck( self, ACE.AdsGetBookMark( Handle, @hACEBookmark ) );

   poFields := TList.Create;
   try  { Use this try block to free the poFields object }

      GetFieldList( poFields, KeyFields );

      {  Put all fields values into the FILTER buffer for use to build key or filter }
      SetTempState( dsFilter );

      try  {  Use this try block to set the state back }

         {  Since we set the temporary state to dsFilter, the mpFilterBuffer  }
         {  will receive all the sets and gets }
         mpFilterBuffer := TempBuffer;
         InternalInitRecord( mpFilterBuffer );

         {  With variants data type, a single value must be retrieved with variable name.  }
         {  Multiple values has to be retrieved using the array convention }
         if poFields.Count = 1 then
         begin
            if VarIsArray( KeyValues ) then
               TField( poFields.First).Value := KeyValues[0]
            else
               TField( poFields.First ).Value := KeyValues;
         end
         else
            for usFieldCount := 0 to poFields.Count - 1 do
               TField( poFields[usFieldCount] ).Value := KeyValues[usFieldCount];

         { Initialize }
         bFieldsMatch := False;
         hUseHandle := INVALID_ACE_HANDLE;

         if ( loCaseInsensitive in Options ) then
         begin
            {*
             * Don't do a seek, could find an index that is not case insensitive,
             * then the seek would fail. Set bFieldsMatch to False so we'll set
             * an AOF instead.
             *}
            bFieldsMatch := False;
         end
         else if Assigned( OnFilterRecord ) and Filtered then
         begin
            {*
             * Don't do a seek, need to do key comparisons and skips while
             * evaluating the client-side filter. Softseek used below makes
             * this complicated. AOF performance will be good.
             *}
            bFieldsMatch := False;
         end
         else if IsAceScopeSet or
                 IsAceIndexConditional or
                 IsAceIndexUniqueDBF or
                 IsAceIndexCustom then
         begin
            {*
             * If there is a scope set, the index is conditional, the index is
             * a unique index on a dbf, or the index is custom then we
             * only want to check the ActiveIndex for a match of key fields.
             *}
            if FieldsMatchPartial( GetActiveIndexFieldNames,
                                   PAceChar( AnsiString( KeyFields ) ), strLastField ) then
            begin
               bFieldsMatch := True;
               hUseHandle := ActiveHandle;
            end;
         end
         else
         begin
            {*
             * If the key fields matches any index exactly or partially, we
             * can optimize the locate to perform a seek on that index.
             * strLastField is expected to be in all upper case.
             *}
            ACECheck( self, ACE.AdsGetNumIndexes( self.Handle, @usLength ) );
            GetMem( phIndexArray, usLength * sizeof( ADSHANDLE )  );

            {*
             * Quick check to see if there is an index active right now, if so
             * and it will work for this search, use it instead of looping
             * through all the other indexes. See bug 1954 for details
             *}
            if ( ( ActiveHandle <> Handle ) and
                 FieldsMatchPartial( GetActiveIndexFieldNames,
                                     PAceChar( AnsiString( KeyFields ) ), strLastField ) ) then
            begin
               {* Setting bFieldsMatch to true will make the loop below bail out right away. *}
               bFieldsMatch := True;
               hUseHandle := ActiveHandle;
            end;

            try

               ACECheck( self, ACE.AdsGetAllIndexes( Handle, @(phIndexArray[0]), @usLength ));

               { Check fields in each index for full or partial match }
               usIndexCount := 0;
               while (( NOT bFieldsMatch ) AND ( usIndexCount < usLength )) do
               begin
                  { Create a ; seperated string of field names that make up the index }
                  usNameLength := ADS_MAX_TAG_NAME;
                  ACECheck( self, ACE.AdsGetIndexName( phIndexArray[ usIndexCount ],
                                                       @acIndexName, @usNameLength ));

                  ACECheck( self, ACEUNPUB.AdsGetNumSegments( phIndexArray[usIndexCount], @usNumSegs ));

                  strFieldNames := '';

                  for sSegmentCount := 0 to usNumSegs - 1 do
                  begin
                     usExprLength := ADS_MAX_INDEX_EXPR_LEN;
                     ACECheck( self, ACEUNPUB.AdsGetSegmentFieldName( phIndexArray[usIndexCount],
                                                             sSegmentCount, @acExpression,
                                                             @usExprLength ));

                     if strFieldNames = '' then
                        strFieldNames := string( acExpression )
                     else
                        strFieldNames := strFieldNames + ';' + string( acExpression );
                  end;

                  if ( ( FieldsMatchPartial( strFieldNames,
                                         PAceChar( AnsiString( KeyFields ) ),
                                         strLastField ) ) and
                       IndexIsLocateFriendly( phIndexArray[usIndexCount] ) ) then
                  begin
                     { Match found, save index handle and set bFieldsMatch flag }
                     bFieldsMatch := True;
                     hUseHandle := phIndexArray[ usIndexCount ];
                  end
                  else
                     usIndexCount := usIndexCount + 1;
               end; {while  NOT bFieldsMatch }
            finally
               Dispose( phIndexArray );
            end; {* try finally *}
         end; {else (bScopeSet = FALSE) }

         { If we found a match do a seek else create an AOF }
         if ( bFieldsMatch = True ) then
         begin
            {  We use ACE to set each key field }
            ACECheck( self, ACE.AdsInitRawKey( hUseHandle ) );

            for usFieldCount := 0 to poFields.Count - 1 do
               With TField( poFields[usFieldCount] ) do
               begin
                  ulFieldOffset := FACEFieldDefs[ FACEFieldDefs.IndexOf( TField( poFields[usFieldCount] ).FieldName ) ].Offset;
                  ulFieldLength := FACEFieldDefs[ FACEFieldDefs.IndexOf( TField( poFields[usFieldCount] ).FieldName ) ].Length;
                  usFieldType := FACEFieldDefs[ FACEFieldDefs.IndexOf( TField( poFields[usFieldCount] ).FieldName ) ].FieldType;

                  {  If partial key is specified, we need to trim the last character field }
                  if ( ( ADS_STRING = usFieldType ) or ( ADS_CISTRING = usFieldType ) or ( ADS_VARCHAR_FOX = usFieldType )) And
                       ( loPartialKey in Options ) And
                       ( UpperCase( FieldName ) = strLastField ) then
{$IFDEF FPC}{$HINTS OFF}{$ENDIF}
                     while ( ulFieldLength > 0 ) and
                           ( mpFilterBuffer[ ulFieldOffset + ulFieldLength - 1] = AdsBufferItem( ' ' ) ) do
                        dec( ulFieldLength );
{$IFDEF FPC}{$HINTS ON}{$ENDIF}

                  { use set field for strings so that the OEM conversion occurs }
                  if ( ADS_STRING = usFieldType ) or ( ADS_CISTRING = usFieldType ) or ( ADS_VARCHAR_FOX = usFieldType ) then
                     ACECheck( self, ACE.AdsSetField( hUseHandle, PAceChar( AnsiString( FieldName ) ),
                                                @mpFilterBuffer[ulFieldOffset],
                                                ulFieldLength ) )
{$IFDEF ADSDELHPI2008_OR_NEWER}
                  else if ( ADS_NCHAR = usFieldType ) or ( ADS_NVARCHAR= usFieldType ) then
                     ACECheck( self, ACE.AdsSetFieldW( hUseHandle, PAceChar( AnsiString( FieldName )),
                                                       PWideChar( @mpFilterBuffer[ulFieldOffset] ),
                                                       TRUNC( ulFieldLength / 2 ) ));
{$ENDIF}
                  else
                     {  Set field raw }
                     ACECheck( self, ACEUNPUB.AdsSetFieldRaw( hUseHandle, PAceChar( AnsiString( FieldName ) ),
                                                        @mpFilterBuffer[ulFieldOffset],
                                                        ulFieldLength ) );
               end;

            {  Build the key }
            usKeyLength := ADS_MAX_KEY_LENGTH;
            ACECheck( self, ACE.AdsBuildRawKey( hUseHandle, @acKey, @usKeyLength ) );

            {  Always do a soft seek since the partial key is already taken care }
            {  of in the For loop }
            ACECheck( self, ACE.AdsSeek( hUseHandle, @acKey, usKeyLength, ADS_RAWKEY, ADS_SOFTSEEK, @bFound ) );

            Result := ( 0 <> bFound );

         end { if ( bFieldsMatch = True ) }
         else
         begin
            {  if we cannot use current index, we will use a filter  }

            {* check for the loCaseInsensitive option *}
            if loCaseInsensitive in Options then
               bCaseInsensitive := true
            else
               bCaseInsensitive := false;

            {  Always do non-exact compare }
            strFilter := BuildFilterString( poFields,
                                            False { Not exact compare },
                                            bCaseInsensitive );

            {*
             * If an aof is already active, set a standard filter on top of it. If we are just
             * using regular filter, then we don't have to worry about it, because the AOF will
             * stack on top of the regular filter. Using a reg filter should be fine, if not
             * faster, because we've already determined that there is likely no index that
             * will help with this search.
             *}
            usFilterLength := 0;

            {  See if there's an aof active right now.  }
            ulRetVal := ACE.AdsGetAOF( Handle, nil, @usFilterLength );
            if ulRetVal <> AE_NO_FILTER then
            begin
               {  We expect to get AE_INSUFFICIENT_BUFFER, but a conversion error is possible }
{$IFDEF ADSDELPHI2008_OR_NEWER}
               if ( ulRetVal = AE_INSUFFICIENT_BUFFER ) or ( ulRetVal = AE_UNICODE_CONVERSION ) then
{$ELSE}
               if ulRetVal = AE_INSUFFICIENT_BUFFER then
{$ENDIF}
                  bAOFActive := true
               else
                  ACECheck( self, ulRetVal );
            end;

            {  See if there's a filter active right now.  }
            usFilterLength := 0;
            ulRetVal := ACE.AdsGetFilter( Handle, nil, @usFilterLength );
            if ulRetVal <> AE_NO_FILTER then
            begin
               {  We expect to get AE_INSUFFICIENT_BUFFER, but a conversion error is possible }
{$IFDEF ADSDELPHI2008_OR_NEWER}
               if ( ulRetVal = AE_INSUFFICIENT_BUFFER ) or ( ulRetVal = AE_UNICODE_CONVERSION ) then
{$ELSE}
               if ulRetVal = AE_INSUFFICIENT_BUFFER then
{$ENDIF}
                  bFilterActive := true
               else
                  ACECheck( self, ulRetVal );
            end;

            {  Save current exact setting. }
            ACECheck( self, ACE.AdsGetExact22( Handle, @usCurrExact ) );

            try
               {  Build the filter string based on the fields given, and the Options }
               if loPartialKey in Options then
                  ACECheck( self, ACE.AdsSetExact22( Handle, ADS_FALSE ) )
               else
                  ACECheck( self, ACE.AdsSetExact22( Handle, ADS_TRUE ) );

               {*
                * Set the filter.
                * Corner case: If using extended methods a user could set both an
                * AOF and a filter. If that's the case we don't want to go back to the
                * old method of ORing the locate filter into the existing aof, because
                * of exact setting problems, etc. In this case call a method that will
                * evaluate the locate expression on the client.
                *}
               if ( bAOFActive and bFilterActive ) then
                  Result := LocateLocally( strFilter )
               else
               begin
{$IFDEF ADSDELPHI2008_OR_NEWER}
                  if bAOFActive then
                     ACECheck( self, ACE.AdsSetFilter100( Handle, PWideChar( strFilter ), ADS_ENCODE_UTF16 ) )
                  else
                     ACECheck( self, ACE.AdsSetAOF100( Handle, PWideChar( strFilter ), ADS_RESOLVE_DYNAMIC or ADS_ENCODE_UTF16 ) );
{$ELSE}
                  if bAOFActive then
                     ACECheck( self, ACE.AdsSetFilter( Handle, PAceChar( AnsiString( strFilter ) ) ) )
                  else
                     ACECheck( self, ACE.AdsSetAOF( Handle, PAceChar( AnsiString( strFilter ) ), ADS_RESOLVE_DYNAMIC ) );
{$ENDIF}


                  {  Activate filter by gotop using current active handle }
                  ACECheck( self, ACE.AdsGotoTop( ActiveHandle ) );
                  ACECheck( self, ACE.AdsAtEof( Handle, @bIsEOF ) );

                  {  if EOF is false then not an empty dataset so we found the value }
                  Result := ( bIsEOF = 0 );

                  {  If we found something, we still might need to see if it passes }
                  {  a client-side filter. }
                  if Result and Assigned( OnFilterRecord ) and Filtered then
                     Result := EvalClientFilter( true {* forward *} );
               end;

            finally
               {  Set exact back to what it was so client-side evaluations have the  }
               {  same exact setting they did before.                                }
               ACE.AdsSetExact22( Handle, usCurrExact );

               if not bAOFActive then
                  {  Clear AOF used for locate, as there wasn't one set before }
                  AdsClearAOF( Handle )
               else if not bFilterActive then
                  {  If there was an aof before, we set a standard filter, clear it.    }
                  ACE.AdsClearFilter( Handle );

            end;  {  Try set AOF, etc }
         end; { else (bFieldsMatch = False) }

      finally
         RestoreState( dsBrowse );
      end;  { Try after setting state to dsFilter }

   finally
      poFields.Free;

      {  reposition back if the locate fails--ignore errors }
      if not Result then
         ACE.AdsGotoBookMark( Handle, hACEBookmark );

   end;  { Try after poFields.Create }

end;  {  TAdsDataSet.LocateRecord }


{**********************************************************
*  Module:  TAdsDataSet.Lookup
*  Input:   KeyFields - ';' delimited list of fields
*           KeyValues - corresponding values for the fields
*           ResultFields - Names of the fields whose values are
*                          to be returned.
*  Output:
*  return: An array of values
*  Description: for a given set of fields with corrosponding values
*  find the instance of it in the dataset.  If found, the value of the
*  specified fields are returned.
**********************************************************}
function TAdsDataSet.Lookup( const KeyFields: string; const KeyValues: Variant;
                             const ResultFields: string ): Variant;
var
   pcTemp : PAdsBuffer;
   ulLen : UNSIGNED32;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.Lookup' );
{$ENDIF }

   Result := Null;

   {  if a null is passed in then return Null back due to obviously no matching }
   {  records for null }
   if ( VarIsNull( KeyValues ) ) then
         exit;

   if LocateRecord( KeyFields, KeyValues, [] ) then
   begin
      SetTempState( dsCalcFields );
      pcTemp := AllocRecordBuffer;
      try
         ulLen := musRecBufSize + 1;
         GetCurTranslatedRecord( pcTemp, @ulLen, gmCurrent );
         CalculateFields( pcTemp );
         Result := FieldValues[ResultFields];
      finally
         FreeRecordBuffer( pcTemp );
         RestoreState( dsBrowse );
      end;
   end;
   CursorPosChanged;
end;  {  TAdsDataSet.Lookup }

{**********************************************************
*  Module:  TAdsDataSet.Locate
*  Input:   KeyFields - string of ';' delimited fields
*           KeyValues - string of ';' delimited values
*           Options - case and partial key
*  Output:
*  Return:  Boolean - If the locate found anything
*  Description: for a given set of fields with corrosponding values
*  find the instance of it in the dataset
**********************************************************}
function TAdsDataSet.Locate( const KeyFields: string; const KeyValues: Variant;
                             Options: TLocateOptions ): Boolean;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.Locate' );
{$ENDIF }
   DoBeforeScroll;
   Result := LocateRecord( KeyFields, KeyValues, Options );
   {  if the value was found resync the controls }
   if ( Result ) then
   begin
      Resync( [rmExact, rmCenter] );
      DoAfterScroll;
   end;
end;

{**********************************************************
*  Module:  TAdsDataSet.IsAceScopeSet
*  Input:
*  Output:
*  Return:  Boolean - If there is a scope set
*  Description: Check to see if any scope is set
**********************************************************}
function TAdsDataSet.IsAceScopeSet : Boolean;
var
   ulRetVal      : UNSIGNED32;
   usLen         : UNSIGNED16;
   acScope       : array[0..ADS_MAX_KEY_LENGTH - 1] of AceChar;

begin
   Result := True;

   { If there is no active index than there cannot be a scope set so return false }
   if ( Handle = ActiveHandle ) then
      Result := False
   else
   begin
      { Check for a top scope }
      usLen := ADS_MAX_KEY_LENGTH;
      ulRetVal := ACE.AdsGetScope( ActiveHandle, ADS_TOP, @acScope, @usLen );
      if ( ulRetVal = AE_NO_SCOPE ) then
      begin
         { there was no top scope, now check for a bottom scope }
         usLen := ADS_MAX_KEY_LENGTH;
         ulRetVal := ACE.AdsGetScope( ActiveHandle, ADS_BOTTOM, @acScope, @usLen );
         if ( ulRetVal = AE_NO_SCOPE ) then
            { no scope is set }
            Result := False
         else
            ACECheck( self, ulRetVal );
      end
      else
         ACECheck( self, ulRetVal );
   end;
end; { TAdsDataSet.IsAceScopeSet }



{**********************************************************
*  Module:  TAdsDataSet.IsAceIndexConditional
*  Input:
*  Output:
*  Return:  Boolean - If there is a conditional index active
*  Description: Return true of the index is condional (has a for clause).
**********************************************************}
function TAdsDataSet.IsAceIndexConditional : Boolean;
var
   usLen         : UNSIGNED16;
   ulRetVal      : UNSIGNED32;
   acCondition   : array[0..10] of acechar;

begin
   { If there is no active index return false }
   if ( Handle = ActiveHandle ) then
      Result := False
   else
   begin
      usLen := 10;
      ulRetVal := ACE.AdsGetIndexCondition( ActiveHandle, acCondition, @usLen );
      if ( ulRetVal <> AE_INSUFFICIENT_BUFFER ) then
         AceCheck( self, ulRetVal );
      Result := usLen <> 0;
   end;
end; { TAdsDataSet.IsAceIndexConditional }



{**********************************************************
*  Module:  TAdsDataSet.IsAceIndexUniqueDBF
*  Input:
*  Output:
*  Return:  Boolean - If there is a unique index on a dbf
*  Description: Return true of the index is condional (has a for clause).
**********************************************************}
function TAdsDataSet.IsAceIndexUniqueDBF : Boolean;
var
   bUnique : UNSIGNED16;
begin
   Result := False;
   { If there is no active index return false }
   if ( ( Handle = ActiveHandle ) or ( meTableType = ttAdsADT ) ) then
      exit
   else
   begin
      ACECheck( self, ACE.AdsIsIndexUnique( ActiveHandle, @bUnique ) );
      if ( bUnique = 1 ) then
         Result := True;
   end;
end;   {* TAdsDataSet.IsAceIndexUniqueDBF *}



{**********************************************************
*  Module:  TAdsDataSet.IsAceIndexCustom
*  Input:
*  Output:
*  Return:  Boolean - If there is a custom index
*  Description: Return true of the index is custom.
**********************************************************}
function TAdsDataSet.IsAceIndexCustom : Boolean;
var
   bCustom  : UNSIGNED16;
   ulRetVal : UNSIGNED32;
begin
   Result := False;
   bCustom := 0;
   { If there is no active index return false }
   if ( Handle = ActiveHandle ) then
      exit
   else
   begin
      ulRetVal := ACE.AdsIsIndexCustom( ActiveHandle, @bCustom );
      // ignore this error that is returned on NTX indexes
      if ( ulRetVal <> AE_INVALID_INDEX_TYPE ) then
         ACECheck( self, ulRetVal );
      if ( bCustom = 1 ) then
         Result := True;
   end;
end;   {* TAdsDataSet.IsAceIndexCustom *}




{*********************************************************
*  Module:  TAdsDataSet.IndexIsLocateFriendly
*  Input:
*  Output:
*  Return:  Boolean
*  Description: Return True of the index is not conditional,
*     doesn't have a while clause, is not a DBF uniqe index,
*     isn't scoped, and isn't custom. o/w return False.
**********************************************************}
function TAdsDataSet.IndexIsLocateFriendly( hIndex : ADSHANDLE ) : Boolean;
var
   ulRetVal      : UNSIGNED32;
   usLen         : UNSIGNED16;
   acScope       : array[0..ADS_MAX_KEY_LENGTH - 1] of acechar;
   acCondition   : array[0..10] of acechar;
   usUnique      : UNSIGNED16;
   usCustom      : UNSIGNED16;
begin
   Result := False;

   {*
    * 1. See if a scope is set. This should only come back true if the
    *    handle passed in is to the active index, as the descendant should
    *    only have a scope set on the active index, not on any other indexes.
    *}
   usLen := ADS_MAX_KEY_LENGTH;
   ulRetVal := ACE.AdsGetScope( hIndex, ADS_TOP, @acScope, @usLen );
   if ( ulRetVal = AE_NO_SCOPE ) then
   begin
      { there was no top scope, now check for a bottom scope }
      usLen := ADS_MAX_KEY_LENGTH;
      ulRetVal := ACE.AdsGetScope( hIndex, ADS_BOTTOM, @acScope, @usLen );
      if ( ulRetVal = AE_NO_SCOPE ) then
         { no scope is set, so leave result at False for now }
         Result := False
      else
      begin
         ACECheck( self, ulRetVal );
         if ( usLen > 0 ) then
            {* bottom scope is set, exit with result as false *}
            exit;
      end;
   end
   else
   begin
      ACECheck( self, ulRetVal );
      if ( usLen > 0 ) then
         {* top scope is set, exit with result as false *}
         exit;
   end;

   {* 2. Check for a conditional index *}
   usLen := 10;
   ulRetVal := ACE.AdsGetIndexCondition( hIndex, acCondition, @usLen );
   if ( ulRetVal <> AE_INSUFFICIENT_BUFFER ) then
      AceCheck( self, ulRetVal );
   if ( usLen > 0 ) then
      {* conditional index, exit with result false *}
      exit;

   {* 3. Check for a uniqe dbf index *}
   if ( meTableType <> ttAdsADT ) then
   begin
      {* Check the index option *}
      ACECheck( self, ACE.AdsIsIndexUnique( hIndex, @usUnique ) );
      if ( usUnique = 1 ) then
         {* uniqe dbf index, exit with result false *}
         exit;
   end;

   {* 4. Check for a custom index *}
   usCustom := 0;
   ulRetVal := ACE.AdsIsIndexCustom( hIndex, @usCustom );
   // ignore this error that is returned on NTX indexes
   if ( ulRetVal <> AE_INVALID_INDEX_TYPE ) then
      ACECheck( self, ulRetVal );
   if ( usCustom = 1 ) then
      {* custom index, exit with result false *}
      exit;

   {* If we got here then this index is officially "locate friendly" *}
   Result := True;

end;   {* TAdsDataSet.IndexIsLocateFriendly *}



{**********************************************************
*  Module:  TAdsDataSet.PostKeyBuffer
*  Input:  bCommit - Boolean to commit the buffer or not
*  Output:
*  Description:  Posts the key buffer to the buffers and
*  resets the browse state while causing dataevents for the
*  dataset changed
**********************************************************}
procedure TAdsDataSet.PostKeyBuffer( bCommit: Boolean );
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.PostKeyBuffer' );
{$ENDIF }
   {  DataEvent to check Browse mode }
   DataEvent( deCheckBrowseMode, 0 );
   {  if commit then move the key buffer into the array of key buffers }
   if bCommit then
      mpstKeyBuffer.Modified := Modified
   else
      Move( mapKeyBuffers[kiSave]^, mpstKeyBuffer^, mapKeyBuffers[kiSave]^.BufferSize );

   {  set the state of the dataset to browse and cause dataevent }
   SetState( dsBrowse );
   DataEvent( deDataSetChange, 0 );
end;

{**********************************************************
*  Module:  TAdsDataSet.Post
*  Input:
*  Output:
*  Description: Post method that calls back to the inherited
*  TDataSets post but need to post key buffer.
**********************************************************}
procedure TAdsDataSet.Post;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.Post' );
{$ENDIF }

   {  Call TDataSets post }
   inherited Post;

   {  if the state is in dsSetKey then post the buffer }
   if State = dsSetKey then
      PostKeyBuffer( True );
end;  {  TAdsDataSet.Post }

{  end of test methods to make sure all virtual functions show if being called }


{**********************************************************
*  Module:  TAdsDataSet.PackTable
*  Input:
*  Output:
*  Description: Packs the given table
**********************************************************}
procedure TAdsDataSet.PackTable;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.PackTable' );
{$ENDIF }
   if Active then
   begin
      ACECheck( self, ACE.AdsPackTable( Self.Handle ) );
      Resync( [] );
   end;
end;

{**********************************************************
*  Module:  TAdsDataSet.ADSGetBinaryFieldLen
*  Input:
*  Output:
*  Return: Longint - size of the global binary field
*  Description: Returns the size of the binary field that
*  is specified globally.
**********************************************************}
function TAdsDataSet.ADSGetBinaryFieldLen : Longint;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.ADSGetBinaryFieldLen' );
{$ENDIF }
   Result := mlBinaryFldLen;
end;

{**********************************************************
*  Module:  TAdsDataSet.ADSSetBinaryFieldLen
*  Input: lValue - Size of the global binary field
*  Output:
*  Description: Sets the size of the binary field that
*  is specified globally.
**********************************************************}
procedure TAdsDataSet.ADSSetBinaryFieldLen( lValue : Longint );
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.ADSSetBinaryFieldLen' );
{$ENDIF }
   mlBinaryFldLen := lValue;
end;

{**********************************************************
*  Module:  TAdsDataSet.ADSSetFieldToBinary
*  Input:  strFieldName - field to set field type to binary from memo
*  Output:
*  Description: Sets a global variable for a field to be recognized as
*  an image and calls the update method of the field defs
**********************************************************}
procedure TAdsDataSet.ADSSetFieldToBinary( strFieldName : String );
var
   sFieldCount : SIGNED16;
   poCurFieldDef : TFieldDef;
   bFound : Boolean;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.ADSSetFieldToBinary' );
{$ENDIF }
   bFound := False;
   poCurFieldDef := nil;

   if Not Active then
      raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL,
                                      'Table must be Active.' );

   {  Search through all of the field definitions for the matching field name }
   for sFieldCount := 0 to FieldDefs.Count - 1 do
   begin
      poCurFieldDef := FieldDefs[sFieldCount];
      if ( UpperCase( poCurFieldDef.Name ) = UpperCase( strFieldName ) ) then
      begin
         bFound := True;
         break;
      end;
   end;

   if Not bFound then
      raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL,
                                      'Invalid field name for the given table' );

   {  if field wasn't memo or binary to begin with then give exception }
   if ( ( poCurFieldDef.DataType <> ftBlob ) And ( poCurFieldDef.DataType <> ftMemo ) )then
      raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL,
                                      'Invalid field type to begin with to change to binary' );

   {  If past all exceptions now set global field name to set to binary and }
   {  call update to the field defs }
   strBinaryFieldName := strFieldName;
   FieldDefs.Update;
end;

{**********************************************************
*  Module:  TAdsDataSet.IndexFieldCount
*  Input:
*  Output:
*  Return : UNSIGNED16 - count of the number of indexed fields
*  for the current index
*  Description: Returns the number of segments for the current
*  index
**********************************************************}
function TAdsDataSet.IndexFieldCount : UNSIGNED16;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.IndexFieldCount' );
{$ENDIF }
   { if the active handle is the same as the table handle, then there }
   { is no active index }
   if Handle = ActiveHandle then
      Result := 0
   else
      ACECheck( self, ACEUNPUB.AdsGetNumSegments( ActiveHandle, @Result ) );
end;


{**********************************************************
*  Module:  InternalAddIndex
*  Input:
*  Output:
*  Description: Add an index to the previously opened table
**********************************************************}
procedure InternalAddIndex( hTable   : ADSHANDLE;
                            usTableType : UNSIGNED16;
                            oIndexDef   : TIndexDef;
                            ulPageSize  : TAdsIndexPageSizes;
                            strCollation : string );
var
   strIndexExpr  : string;
   ulOptions : UNSIGNED32;
   strIndexName  : string;
   strTagName : string;
   hIndex     : ADSHANDLE;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.InternalAddIndex' );
{$ENDIF }

   {  set up index options based on the oIndexDef }
   ulOptions := ADS_DEFAULT;
   with oIndexDef do
   begin
      {  ixExpression and ixCaseInsensitive are not supported together in an  }
      {  index.  }
      if (( ixExpression in Options ) and ( ixCaseInsensitive in Options )) then
         raise EADSDatabaseError.create( nil, AE_TADSDATASET_GENERAL,
               'ixCaseInsensitive is not supported with ixExpression indexes' );
      if ixUnique in Options then
      begin
         if ( usTableType = ADS_VFP ) then
            ulOptions := ulOptions or ADS_CANDIDATE
         else
            ulOptions := ulOptions or ADS_UNIQUE;
      end;

      if ixDescending in Options then
         ulOptions := ulOptions or ADS_DESCENDING;
   end;

   {  Depending on the table type, we create either a compound structurally }
   {  index tag or a stand alone index file }

   if usTableType = ADS_NTX then
   begin
      strIndexName := oIndexDef.Name;
      strTagName := '';
   end
   else
   begin
      strIndexName := '';
      strTagName := oIndexDef.Name;
      ulOptions := ulOptions or ADS_COMPOUND;
   end;

   {  Get the index expression }
   if ixExpression in oIndexDef.Options then
      strIndexExpr := oIndexDef.Expression
   else
   begin
      strIndexExpr := oIndexDef.Fields;
      {  resolve ixCaseInsensitive before we add '+'s  }
      if ( ixCaseInsensitive in oIndexDef.Options ) then
            AddUpperExpr( hTable, strIndexExpr );

      {  If this is not ADT table type, we may have to convert the; delimited field }
      {  list into fieldName1 + fieldName2 + ... }
      if usTableType <> ADS_ADT then
         while Pos( ';', strIndexExpr ) > 0 do
            strIndexExpr[ Pos( ';', strIndexExpr ) ] := '+';
   end;

   ACECheck( nil, ACE.AdsCreateIndex90( hTable, PAceChar( AnsiString( strIndexName ) ),
                                 PAceChar( AnsiString( strTagName ) ), PAceChar( AnsiString( strIndexExpr ) ),
                                 Nil, Nil, ulOptions, ulPageSize,
                                 PAceChar( AnsiString( strCollation ) ),@hIndex ) );
end;  {  InternalAddIndex }



{**********************************************************
*  Module:  TAdsDataSet.InternalCreateTable
*  Input:  eOptions - Create table options
*  Output:
*  Description: Internal function to create a table given
*               the FieldDefs.  Set ulOptions to
*               ADS_DICTIONARY_BOUND_TABLE to add the new
*               table to the connection's dictionary.
**********************************************************}
procedure TAdsDataSet.InternalCreateTable( eOptions : TAdsCreateTableOptions );
var
   sDef           : SIGNED16;
   strFieldsList  : String;
   poCurFieldDef  : TFieldDef;
   usCharType     : UNSIGNED16;
   usLockType     : UNSIGNED16;
   usRights       : UNSIGNED16;
   hConnect       : ADSHANDLE;
   hNewTable      : ADSHANDLE;
   strFileName    : String;
   ulOptions      : UNSIGNED32;
   bInDictionary  : Boolean;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.InternalCreateTable' );
{$ENDIF }

   { Convert the option to what ACE wants }
   ulOptions := ADS_DEFAULT;
   if ( ctFreeTable in eOptions )  then
      ulOptions := ulOptions OR ADS_FREE_TABLE;

   if ( ctDictionaryTable in eOptions )  then
      ulOptions := ulOptions OR ADS_DICTIONARY_BOUND_TABLE;

   { Set the table caching option }
   if mpoAdsTableOptions.AdsCachingOption = tcReads then
      ulOptions := ulOptions OR ADS_CACHE_READS
   else if mpoAdsTableOptions.AdsCachingOption = tcWrites then
      ulOptions := ulOptions OR ADS_CACHE_WRITES;

   {  Make sure the table is not active }
   CheckInactive;

   {  Get the file name and full path, unless this is a dictionary conn.  }
   {  For a dictionary connection we want to just use the base tablename, }
   {  which will signal to ACE to put the table in the dictionary         }
   {  default path.                                                       }
   if ( ( Assigned( AdsConnection ) ) and ( AdsConnection.IsDictionaryConn ) ) then
      bInDictionary := TRUE
   else
      bInDictionary := FALSE;

   if ( bInDictionary ) then
      strFileName := TableName
   else
      strFileName := GetDatabasePath + ADS_PATH_DELIMITER + TableName;

   {  Create field defs from persistent fields if necessary.  }
{$IFDEF ADSDELPHI4_OR_NEWER}
   InitFieldDefsFromFields;
{$ENDIF}

   {  build the list of fields to create in the table.  This is the string }
   {  to pass to the ACE engine for the columns to create in the table }
   strFieldsList := '';
   for sDef := 0 to FieldDefs.Count - 1 do
   begin
      poCurFieldDef := FieldDefs[sDef];

      {  Add the field name to the string }
      strFieldsList :=  strFieldsList + poCurFieldDef.Name + ',';

      {  Add the data type to the string }
      case poCurfieldDef.DataType of
         ftBytes :
            if musOpenTableType = ADS_ADT then
               strFieldsList := strFieldsList + 'Raw,' + IntToStr( poCurFieldDef.Size ) + ';'
            else  // ??? AW TBD: BDE dBase driver converts this type to memo/binary
               strFieldsList := strFieldsList + 'Char,' + IntToStr( poCurFieldDef.Size ) + ';';

         ftString :
            {*
             * Currenlty can't create case-insensitive fields using the CreateTable
             * method. TFieldDef doesn't have anywhere for a user to stuff the fact
             * that they want a ci field. In the future we could possibly expose an
             * Advantage-specific list of fielddefs where users could specify more
             * field properties.
             *}
            strFieldsList :=  strFieldsList + 'Char,' + IntToStr( poCurFieldDef.Size ) + ';';

{$IFDEF ADSDELPHI2008_OR_NEWER }
         ftWideString :
            strFieldsList :=  strFieldsList + 'NChar,' + IntToStr( poCurFieldDef.Size ) + ';';

         ftWideMemo :
            strFieldsList :=  strFieldsList + 'NMemo;';
{$ENDIF}

         ftSmallint, ftWord :
            if musOpenTableType = ADS_ADT then
               strFieldsList := strFieldsList + 'ShortInt;'
            else
               strFieldsList := strFieldsList + 'Num,6,0;'; // This is how BDE does it

         ftInteger :
            if musOpenTableType = ADS_ADT then
               strFieldsList := strFieldsList + 'Integer;'
            else
               strFieldsList := strFieldsList + 'Num,11,0;'; // This is how BDE does it

         ftFloat :
            if musOpenTableType = ADS_ADT then
               strFieldsList := strFieldsList + 'Double,6;'
            else
               strFieldsList := strFieldsList + 'Num,20,4;'; // This is how BDE does it

         ftBoolean :
            strFieldsList :=  strFieldsList + 'Logical;';

         ftDate :
            strFieldsList :=  strFieldsList + 'Date;';

         ftTypedBinary, ftBlob, ftVarBytes :
            strFieldsList :=  strFieldsList + 'Binary;';

         ftFmtMemo, ftMemo :
            strFieldsList :=  strFieldsList + 'Memo;';

         ftGraphic :
            strFieldsList :=  strFieldsList + 'Image;';

         ftAutoInc:
            if musOpenTableType = ADS_ADT then
               strFieldsList := strFieldsList + 'AutoInc;'
            else
               raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL,
                  'ftAutoInc is not a supported field type.' );

         ftTime:
            if musOpenTableType = ADS_ADT then
               strFieldsList := strFieldsList + 'Time;'
            else
               raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL,
                  'ftTime is not a supported field type.' );

         ftDateTime:
            if musOpenTableType = ADS_ADT then
               strFieldsList := strFieldsList + 'TimeStamp;'
            else
               raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL,
                  'ftDateTime is not a supported field type.' );

         ftCurrency:
            if musOpenTableType = ADS_ADT then
               strFieldsList := strFieldsList + 'CurDouble,6;'
            else
               raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL,
                  'ftCurrency is not a supported field type.' );

         {  not supported field types }
         ftParadoxOle:
            raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL,
               'ftParadoxOle is not a supported field type.' );

         ftDBaseOle:
            raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL,
               'ftDBaseOle is not a supported field type.' );

{$IFDEF ADSDELPHI5_OR_NEWER}
         ftBCD:
            {* BCD corresponds to the ADT MONEY field type *}
            if musOpenTableType = ADS_ADT then
               strFieldsList := strFieldsList + 'Money;'
            else
            raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL,
               'ftBCD is not a supported field type.' );
{$ENDIF}

{$IFDEF ADSDELPHI6_OR_NEWER }
         ftFMTBCD:
            {* ADT Numeric fields reserve up to two bytes for the sign & decimal point.  Add
               the appropriate padding to the field definition *}
            if poCurFieldDef.Size <> 0 then
               strFieldsList := strFieldsList + 'Num,' + IntToStr( poCurFieldDef.Precision + 2 )
                  + ',' + IntToStr( poCurFieldDef.Size ) + ';'
            else
               strFieldsList := strFieldsList + 'Num,' + IntToStr( poCurFieldDef.Precision + 1 )
                  + ',' + IntToStr( poCurFieldDef.Size ) + ';';
{$ENDIF}

         ftUnknown:
            raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL,
               'ftUnknown is not a supported field type.' );
         {  end not supported field types }
      end;
   end;

   {  Set the Lock type from the properties associated to the table }
   if mpoAdsTableOptions.AdsLockType = Proprietary then
      usLockType := ADS_PROPRIETARY_LOCKING
   else
      usLockType := ADS_COMPATIBLE_LOCKING;

   {  Set the Character type from the properties associated to the table. The }
   {  enumeration is zero based, but the ace constants are 1 based, so add one }
   usCharType := UNSIGNED16( mpoAdsTableOptions.AdsCharType ) + 1;

   {  Set the Rights checking from the property associated to the table }
   if mpoAdsTableOptions.AdsRightsCheck then
      usRights := ADS_CHECKRIGHTS
   else
      usRights := ADS_IGNORERIGHTS;

   {  if connection is not assigned set it to 0 otherwise make sure its open and use it }
   if Assigned( AdsConnection ) then
   begin
      if Not AdsConnection.IsConnected then
      begin
         try
            AdsConnection.IsConnected := True;
         except
            raise;
         end;
      end;
      hConnect := AdsConnection.ConnectionHandle;
   end
   else
   begin
      hConnect := 0;
   end;

   {*  Create the table, use 0 for memo block size, ACE will determine the optimal value *}
   ACECheck( self, ACE.AdsCreateTable90( hConnect, PAceChar( AnsiString( strFileName ) ), nil, musOpenTableType,
                                 usCharType, usLockType, usRights, 0, PAceChar( AnsiString( strFieldsList ) ),
                                 ulOptions, PAceChar( AnsiString( GetEffectiveCollation() ) ), @hNewTable ) );

   {*
    * Create the indexes. If this user has rights to create indexes, they will automatically be
    * added to the dictionary, but only if the table is already part of the dictionary.
    *}
   Try
      for sDef := 0 to IndexDefs.Count - 1 Do
      begin
         {* ixPrimary implies unique, so set the option flag in case the user didn't. *}
         {$IFDEF ADSDELPHI4_OR_NEWER}
         if ( ( bInDictionary ) and
              ( ixPrimary in IndexDefs.Items[sDef].Options ) and
              ( not ( ctFreeTable in eOptions ) ) and
              ( musOpenTableType = ADS_ADT ) ) then
            IndexDefs.Items[sDef].Options := IndexDefs.Items[sDef].Options + [ixUnique];
         {$ENDIF}

         InternalAddIndex( hNewTable, musOpenTableType, IndexDefs.Items[sDef], mpoAdsTableOptions.AdsIndexPageSize,
                           GetEffectiveCollation() );

         {* If dd and primary, make it so... *}
         {$IFDEF ADSDELPHI4_OR_NEWER}
         if ( ( bInDictionary ) and
              ( ixPrimary in IndexDefs.Items[sDef].Options ) and
              ( not ( ctFreeTable in eOptions ) ) and
              ( musOpenTableType = ADS_ADT ) ) then
         begin
            try
               AdsConnection.Execute( Format( 'EXECUTE PROCEDURE sp_ModifyTableProperty( %s, %s, %s, %s, %s )',
                                              [QuotedStr( strFileName ),
                                               QuotedStr( 'TABLE_PRIMARY_KEY' ),
                                               QuotedStr( IndexDefs.Items[sDef].Name ),
                                               QuotedStr( 'NO_VALIDATE' ),
                                               'NULL'] ) );
            except
               on E : EADSDatabaseError do
                  {*
                   * If the user doesn't have rights to add tables to the dd, the table is
                   * created as a free table, in which case setting the primary key will
                   * fail. If so, ignore the failure.
                   *}
                  if ( E.ulSQLErrorCode <> AE_INVALID_OBJECT_NAME ) then
                     raise;
            end;
         end;
         {$ENDIF}
      end;
   Finally
      ACECheck( self, ACE.AdsCloseTable( hNewTable ) );
   End;
end;  {  TAdsDataSet.InternalCreateTable }


{**********************************************************
*  Module:  TAdsDataSet.CreateTable
*  Input:
*  Output:
*  Description: Creates a table given the FieldDefs
**********************************************************}
procedure TAdsDataSet.CreateTable;
var
   eOptions : TAdsCreateTableOptions;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.CreateTable' );
{$ENDIF }

   eOptions := []; {* No options set *}
   InternalCreateTable( eOptions );

end;  {  TAdsDataSet.CreateTable }


{$IFDEF ADSDELPHI4_OR_NEWER}
{**********************************************************
*  Module:  TAdsDataSet.CreateTable
*  Input: eOptions - Create table options
*  Output:
*  Description: Creates a table given the FieldDefs, takes
*               create table options as input so the user
*               can specify free or dictionary table.
**********************************************************}
procedure TAdsDataSet.CreateTable( eOptions : TAdsCreateTableOptions );
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.CreateTable' );
{$ENDIF }

   InternalCreateTable( eOptions );

end;  {  TAdsDataSet.CreateTable }
{$ENDIF}


{**********************************************************
*  Module:  TAdsDataSet.RenameTable
*  Input:   new table name
*  Description: If this is a dd table, call the rename
*  table API.
**********************************************************}
procedure TAdsDataSet.RenameTable( const NewTableName: string );
begin
{$IFDEF CALLTRACE }
    WriteCallTrace( 'TAdsDataSet.RenameTable' );
{$ENDIF }
   if ( ( Assigned( AdsConnection ) ) and ( AdsConnection.IsDictionaryConn ) ) then
   begin
      CheckInactive;

      ACECheck( self, ACE.AdsDDRenameObject( AdsConnection.Handle, PAceChar( AnsiString( TableName ) ),
                PAceChar( AnsiString( NewTableName ) ), ADS_DD_TABLE_OBJECT, ADS_DEFAULT ) );

      TableName := NewTableName;
   end
   else
      raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL,
         'The method RenameTable in TAdsDataSet is not supported on free tables.' );
end;


{**********************************************************
*  Module:  TAdsDataSet.AdsActiveRecord
*  Input:
*  Output:
*  Return:
*  Description: This function stores the current position of ACE and moves
*               ACE to TTable's active record.  It then returns the old
*               current position of ACE
**********************************************************}
function TAdsDataSet.AdsActiveRecord : ADSHANDLE;
var
   bFlag    : UNSIGNED16;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.AdsActiveRecord' );
{$ENDIF }
   CheckActive;

   if ( State = dsCalcFields ) then
   begin
      Result := 0;
      exit;
   end;

   ACECheck( self, ACE.AdsGetBookmark( Handle, @Result ) );

   {  Goto the active record number }
   try
      ACECheck( self, ACE.AdsGotoRecord( Handle, PUNSIGNED32( ActiveBuffer + musBookmarkOfs )^ ));
   except
      On E : EADSDatabaseError Do
      Begin
         if ( E.ACEErrorCode <> AE_INVALID_RECORD_NUMBER ) then
            raise;

         {* if ACE is at eof and bof ignore this error, o/w raise it *}
         if AE_SUCCESS <> ACE.AdsAtBOF( Handle, @bFlag ) then
            raise;

         if  bFlag <> ADS_TRUE then
            raise;

         if AE_SUCCESS <> ACE.AdsAtEOF( Handle, @bFlag ) then
            raise;

         if bFlag <> ADS_TRUE then
            raise;
      End;
   end;

   { inform Dataset that the underlying record position has changed }
   CursorPosChanged;
end;  {  TAdsDataSet.AdsActiveRecord }


{ TAdsBlobCache }
{  This is the blob cach object for reading and writing Memos and Images or any binary }
{**********************************************************
*  Module:  TAdsBlobCache.Create
*  Input:
*  Output:
*  Description: Internally called in TAdsDataSet by TDataSet to
*  set up a Blob blob cach
**********************************************************}
constructor TAdsBlobCache.Create();
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsBlobCache.Create' );
{$ENDIF }

   inherited Create;

   { Initialize member variables }
   mhAdsTable := INVALID_ACE_HANDLE;
   mulFieldNo := 0;
   mulRecNum := 0;
   mbBlobModified := False;   {  Flag if modified }
end;  { TAdsBlobCache.Create }


{**********************************************************
*  Module:  TAdsBlobCache.Destroy
*  Input:
*  Output:
*  Description: Internally called in TAdsDataSet by TDataSet to
*  set up a Blob blob cach
**********************************************************}
destructor TAdsBlobCache.Destroy;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsBlobCache.Destroy' );
{$ENDIF }

   {  call inherited destroy }
   inherited Destroy;
end;  { TAdsBlobCache.Destroy }


{**********************************************************
*  Module:  TAdsBlobCache.Flush
*  Input:
*  Output:
*  Description: Internally called in TAdsDataSet by TDataSet to
*  set up a Blob blob cach
**********************************************************}
Procedure TAdsBlobCache.Flush;
{$IFDEF ADSDELPHI2008_OR_NEWER}
var
   usFieldType : UNSIGNED16;
{$ENDIF}
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsBlobCache.Flush' );
{$ENDIF }

   if mbBlobModified then
   begin
      {  We do not need to do a goto here, this is called from internal post }
      {  and we are on the right record }
{$IFDEF ADSDELPHI2008_OR_NEWER}
      ACECheck( nil, ACE.AdsGetFieldType( mhAdsTable, ADSFIELD( mulFieldNo ), @usFieldType ) );

      // If the field is an ADS_MEMO, use AdsSetFieldW
      if ( usFieldType = ADS_NMEMO ) then
         ACECheck( nil, ACE.AdsSetFieldW( mhAdsTable, ADSFIELD( mulFieldNo ), PWideChar( Memory ), TRUNC( Size / 2 ) ) )
      else
         ACECheck( nil, ACE.AdsSetField( mhAdsTable, ADSFIELD( mulFieldNo ), Memory, Size ) );
{$ELSE}
      ACECheck( nil, ACE.AdsSetField( mhAdsTable,
{$IFDEF FPC} {$HINTS OFF} {$ENDIF} { Disable FPC hints to avoid ptr Conversion hint }
                                      ADSFIELD( mulFieldNo ),
{$IFDEF FPC} {$HINTS ON} {$ENDIF}
                                      Memory, Size ) );
{$ENDIF}

      mbBlobModified := False;
   end;
end;  { TAdsBlobCache.Flush }


{**********************************************************
*  Module:  TAdsBlobCache.RefreshCache
*  Input:       hAdsTable - ACE table handle
*               ulFieldNo - FieldNo of the blob
*               ulRecNo - Record number in the table
*               bForceReread - whether to reread on any occasion
*  Output:
*  Description: Internally called by TAds.Create
**********************************************************}
procedure TAdsBlobCache.RefreshCache( hAdsTable    : ADSHANDLE;
                                    ulFieldNo    : UNSIGNED32;
                                    ulRecNo      : UNSIGNED32;
                                    bForceReread : Boolean );
var
   usFieldType : UNSIGNED16;
   ulSize      : UNSIGNED32;
   bBlobIsMemo : Boolean;
   ulCurrACERec: UNSIGNED32;
   ulRetCode   : UNSIGNED32;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.RefreshCache' );
   WriteCallTrace( '--Parameters ulFieldNo: ' + IntToStr( ulFieldNo ) );
   WriteCallTrace( '             ulRecNo: ' + IntToStr( ulRecNo ) );
   if bForceReread then
      WriteCallTrace( '             bForceReread: True' )
   else
      WriteCallTrace( '             bForceReread: False' );
{$ENDIF }
   { Check to see if we need to read the blob }
   if not bForceReread then
      if ( hAdsTable <> mhAdsTable ) or ( mulRecNum <> ulRecNo )
         or ( mulFieldNo <> ulFieldNo ) then
         bForceReread := True;

   if not bForceReread then
   begin
      Seek( 0, soFromBeginning );
      exit;
   end;

   { clear old data }
   clear;

   { Set member variables }
   mhAdsTable := hAdsTable;
   mulRecNum := ulRecNo;
   mulFieldNo := ulFieldNo;
   mbBlobModified :=  False;

   {  If this is an just inserted record, then we are all done }
   if mulRecNum = 0 then
      Exit;

   Try
      {  Get the record number of the current cursor position, this is somewhat }
      {  redundant but there is a minor problem with ACE which flushes the record }
      {  even when perform a goto on current record }
      ACECheck( nil, ACE.AdsGetRecordNum( hAdsTable, ADS_IGNOREFILTERS, @ulCurrACERec ) );

      {  Goto the record number for the blob }
      if ulCurrACERec <> mulRecNum then
         ACECheck( nil, ACE.AdsGotoRecord( hAdsTable, mulRecNum ) );

{$IFDEF FPC} {$HINTS OFF} {$ENDIF} { Disable FPC hints to avoid ptr Conversion hint }
      ACECheck( nil, ACE.AdsGetFieldType( hAdsTable, ADSFIELD( ulFieldNo ), @usFieldType ) );
{$IFDEF FPC} {$HINTS ON} {$ENDIF}

      {  Get what type of data current record holds };
      bBlobIsMemo := TRUE;
      if usFieldType in [ ADS_BINARY, ADS_IMAGE ] then
         bBlobIsMemo := FALSE
      else if usFieldType = ADS_MEMO then
      begin
         ACECheck( nil, ACE.AdsGetMemoDataType( hAdsTable,
{$IFDEF FPC} {$HINTS OFF} {$ENDIF} { Disable FPC hints to avoid ptr Conversion hint }
                                                ADSFIELD( ulFieldNo ),
{$IFDEF FPC} {$HINTS ON} {$ENDIF}
                                                @usFieldType ) );
         if usFieldType <> ADS_MEMO then
            bBlobIsMemo := FALSE;
      end;

      if bBlobIsMemo = TRUE then
      begin
         { use GetDataLength so we can retrieve length in bytes for all types }
         ulRetCode := ACE.AdsGetDataLength( hAdsTable,
{$IFDEF FPC} {$HINTS OFF} {$ENDIF} { Disable FPC hints to avoid ptr Conversion hint }
                                            ADSFIELD( ulFieldNo ),
{$IFDEF FPC} {$HINTS ON} {$ENDIF}
                                            ACE.ADS_CODEUNIT_LENGTH,
                                            @ulSize );
         inc( ulSize );
      end
      else
{$IFDEF FPC} {$HINTS OFF} {$ENDIF} { Disable FPC hints to avoid ptr Conversion hint }
         ulRetCode := ACE.AdsGetBinaryLength( hAdsTable, ADSFIELD( ulFieldNo ), @ulSize );
{$IFDEF FPC} {$HINTS ON} {$ENDIF}

      {  if we get AE_NO_CURRENT_RECORD, then the table/set must be empty }
      if ulRetCode = AE_NO_CURRENT_RECORD then
      begin
         mulRecNum := 0;
         exit;
      end;

      ACECheck( nil, ulRetCode );

{$IFDEF ADSDELPHI2008_OR_NEWER}
      { Before Allocating the buffer, adjust the size in CodeUnits to bytes for NMemo fields }
      if usFieldType = ADS_NMEMO then
         ulSize := ulSize * 2;
{$ENDIF}

      {  Allocate buffer for the blob data }
      setSize( ulSize );

      {  Read the data into the memory }
      if ( bBlobIsMemo = TRUE ) then
      begin
{$IFDEF ADSDELPHI2008_OR_NEWER}
         if usFieldType = ADS_NMEMO then
         begin
            { For NMemo fields, the size has been doubled for allocation, restore it to codeunits }
            ulSize := ulSize div 2;
            ACECheck( nil, ACE.AdsGetFieldW( hAdsTable, ADSFIELD( ulFieldNo ), Memory, @ulSize, ADS_NONE ) );

            // ulSize is the size in CodeUnits.  Adjust that size to bytes.
            ulSize := ulSize * 2;
         end
         else
            ACECheck( nil, ACE.AdsGetField( hAdsTable, ADSFIELD( ulFieldNo ), Memory, @ulSize, ADS_NONE ) );
{$ELSE}
         ACECheck( nil, ACE.AdsGetField( hAdsTable,
{$IFDEF FPC} {$HINTS OFF} {$ENDIF} { Disable FPC hints to avoid ptr Conversion hint }
                                         ADSFIELD( ulFieldNo ),
{$IFDEF FPC} {$HINTS ON} {$ENDIF}
                                         Memory, @ulSize, ADS_NONE ) );
{$ENDIF}
      end
      else
      begin
         ACECheck( nil, ACE.AdsGetBinary( hAdsTable,
{$IFDEF FPC} {$HINTS OFF} {$ENDIF} { Disable FPC hints to avoid ptr Conversion hint }
                                          ADSFIELD( ulFieldNo ),
{$IFDEF FPC} {$HINTS ON} {$ENDIF}
                                          0, Memory, @ulSize ) );
      end;



      {  ACE returns the actual size readed }
      if ulSize <> UNSIGNED32( Size ) then
         SetSize( ulSize );

   Except
      {  These exception is necessary to trap some unexpected error, but should }
      {  rarely happend }
      On E : EADSDatabaseError Do
      Begin
         mulRecNum := 0;
         if ( E.ACEErrorCode <> AE_NO_CURRENT_RECORD ) and
            ( E.ACEErrorCode <> AE_INVALID_RECORD_NUMBER ) then
            raise;
      End;
   End;
end;  { TAdsBlobCache.RefreshCache }


{**********************************************************
*  Module:  TAdsBlobCache.Read
*  Input:   Buffer - Return Buffer
*           Count - how much to read
*  Output:
*  Return: longint - how much read
*  Description: Return data from the cach
**********************************************************}
function TAdsBlobCache.Read( var Buffer; Count: Longint ): Longint;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsBlobCache.Read' );
{$ENDIF }

   Result := inherited Read( Buffer, Count );
end;  { TAdsBlobCache.Read }


{**********************************************************
*  Module:  TAdsBlobCache.Write
*  Input:  Buffer - Buffer to write
*          Count - size of buffer to write
*  Output:
*  Return: longint - size of buffer written
*  Description: Writes to the blob cach
**********************************************************}
function TAdsBlobCache.Write( const Buffer; Count: Longint ): Longint;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsBlobCache.Write' );
{$ENDIF }

   Result := inherited Write( Buffer, Count );

   mbBlobModified := True;
end;  { TAdsBlobCache.Write }


{**********************************************************
*  Module:  TAdsBlobCache.Truncate
*  Input:
*  Output:
*  Return:
*  Description: overridden method that will truncate the blob cach
**********************************************************}
procedure TAdsBlobCache.Truncate;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsBlobCache.Truncate' );
{$ENDIF }

   clear;

   mbBlobModified := True;
end;  { TAdsBlobCache.Truncate }


{**********************************************************
*  Module:  TAdsBlobCache.Clear
*  Input:
*  Output:
*  Return:
*  Description: overridden method that will clear the blob cach
**********************************************************}
procedure TAdsBlobCache.ClearCache;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsBlobCache.Clear' );
{$ENDIF }

   clear;

   mhAdsTable := INVALID_ACE_HANDLE;
   mulFieldNo := 0;
   mulRecNum := 0;
   mbBlobModified := False;   {  Flag if modified }
end;  { TAdsBlobCache.Truncate }


{**********************************************************
*  Module:  TAdsBlobCache.IsCacheModified
*  Input:
*  Output:
*  Return:  True if cach has been modified
*  Description: overridden method that will truncate the blob cach
**********************************************************}
function TAdsBlobCache.IsCacheModified : Boolean;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsBlobCache.IsCacheModified' );
{$ENDIF }

   Result := mbBlobModified;
end;  { TAdsBlobCache.IsCacheModified }


{ TBlobStream }

{  This entire BLOB object is a recreation of a TTable BLOB }
{  All of the following declairations of the object members are }
{  strictly as they have been referrenced by Delphi }



{**********************************************************
*  Module:  TAdsBlobStream.Create
*  Input:       Field - The BlobField
*               Mode - Reading or Writing
*  Output:
*  Description: Internally called in TAdsDataSet by TDataSet to
*  set up a Blob stream
**********************************************************}
constructor TAdsBlobStream.Create( Field: TBlobField; Mode: TBlobStreamMode );
var
  oAdsDataSet:     TAdsDataSet;
  pcActiveBuf:     PAdsBuffer;
  ulFieldNo:       UNSIGNED32;
  usFieldType:     UNSIGNED16;
  ulRecNo:         UNSIGNED32;
  bRefreshCache:   Boolean;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsBlobStream.Create' );
{$ENDIF }

   inherited Create;

   {  Sets the mode reading or writing to an internal object member variable }
   moMode := Mode;

   moField := Field;

   mbModified := FALSE;

   {  get the fields dataset of TAdsDataSet }
   oAdsDataset := Field.DataSet As TAdsDataSet;

   {  get the field number }
   ulFieldNo := Field.FieldNo;

   {  If the dataset is in dsSetKey state, we do not support reading/writing memo field. }
   {  Currently we only support reading/writing memo field when the dataset is in the }
   {  following 5 states.  However, instead of raise an exception, we simply create an }
   {  empty blob stream, i.e. nothing to read and not allowed to write. }
   if not ( oAdsDataset.state in [dsBrowse, dsEdit, dsInsert, dsNewValue, dsCalcFields ] ) then
   begin
     {  Setting moAdsBlobCach to nil allows us to ignore all other operation on the blob stream. }
      moAdsBlobCach := nil;
      exit;
   end;

   {* Initialize pcActiveBuf *}
   pcActiveBuf := nil;

   {  If there is no active record buffer, then the dataset is empty }
   if not oAdsDataset.GetActiveRecBuf( pcActiveBuf ) then
   begin
      moAdsBlobCach := nil;
      exit;
   end;

   {  Get the field type and make sure we are dealing with a blob field, this may not be }
   {  necessary since tdataset should taken cared of it }
{$IFDEF FPC} {$HINTS OFF} {$ENDIF} { Disable FPC hints to avoid ptr Conversion hint }
   ACECheck( oAdsDataSet, ACE.AdsGetFieldType( oAdsDataset.Handle, ADSFIELD( ulFieldNo ), @usFieldType ) );
{$IFDEF FPC} {$HINTS ON} {$ENDIF}
{$IFDEF ADSDELPHI2008_OR_NEWER}
   if not ( usFieldType in [ ADS_VARCHAR, ADS_BINARY, ADS_IMAGE, ADS_MEMO, ADS_NMEMO, ADS_FOXGENERAL, ADS_FOXPICTURE ] ) then
{$ELSE}
   if not ( usFieldType in [ ADS_VARCHAR, ADS_BINARY, ADS_IMAGE, ADS_MEMO, ADS_FOXGENERAL, ADS_FOXPICTURE ] ) then
{$ENDIF}
      raise EADSDatabaseError.create( oAdsDataSet, AE_TADSDATASET_GENERAL, 'Invalid blob open on non-blob field.' );

   { Get the field's blob cache object }
   moAdsBlobCach :=
      TAdsBlobCache( PBlobDataArray( pcActiveBuf + oAdsDataset.musBlobCacheOfs )[ Field.Offset ] );

   {  Get the record number of the active buffer so we can sync up the active record }
   {  with the blob we are to deal with }
   ulRecNo := PUNSIGNED32( pcActiveBuf + oAdsDataset.musBookmarkOfs )^;

   { If we are going to modified the cach, we refresh it first }
   if ( oAdsDataset.State in [ dsInsert, dsEdit ] ) and ( Mode = bmReadWrite ) and
      ( moAdsBlobCach.IsCacheModified = False ) then
      bRefreshCache := True
   else
      bRefreshCache := False;

   Try
      {  Call blob cach object to make sure we have the correct cach }
      moAdsBlobCach.RefreshCache( oAdsDataset.Handle, ulFieldNo, ulRecNo, bRefreshCache );

      {  If mode is write, then start with a truncated buffer }
      If mode = bmWrite Then
      Begin
         moAdsblobCach.Truncate;
         mbModified := True;
      End;

   finally
      {* let Delphi know the engines position has changed *}
      oAdsDataset.CursorPosChanged;
   end;
end;  { TAdsBlobStream.Create }


{**********************************************************
*  Module:  TAdsBlobStream.Destroy
*  Input:
*  Output:
*  Description: Destructor
**********************************************************}
destructor TAdsBlobStream.Destroy;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsBlobStream.Destroy' );
{$ENDIF }
   if mbModified then
   begin
      moField.Modified := true;
      TAdsDataSet( moField.DataSet ).DataEvent( deFieldChange, Longint( moField ) );
   end;

   {  call inherited destroy }
   inherited Destroy;
end;  { TAdsBlobStream.destroy }


{**********************************************************
*  Module:  TAdsBlobStream.GetBlobSize
*  Input:
*  Output:
*  Return: Size of the blob
*  Description: Get the size of the blob, this function is called
*               when the stream is on a memo field.
**********************************************************}
function TAdsBlobStream.GetBlobSize: LongInt;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsBlobStream.GetBlobCachSize' );
{$ENDIF }

   {  If the dataset is in dsSetKey state, moAdsBlobCach will be nil }
   if moAdsBlobCach = nil then
      result := 0
   else
      Result := moAdsBlobCach.Size;

end;  {  TAdsBlobStream.GetBlobSize }

{**********************************************************
*  Module:  TAdsBlobStream.Read
*  Input:   Buffer - Return Buffer
*           Count - how much to read
*  Output:
*  Return: longint - how much read
*  Description: Reads in the blob in to buffer
*  SPECIAL NOTE: The read will page in the memos 2048 at a time
*  images will call read multiple times as well due to the reading of
*  the header and pallate information as well as the data
**********************************************************}
function TAdsBlobStream.Read( var Buffer; Count: Longint ): Longint;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsBlobStream.Read' );
{$ENDIF }

   {  If the dataset is in dsSetKey state, moAdsBlobCach will be nil }
   if moAdsBlobCach = nil then
      Result := 0
   else
      Result := moAdsBlobCach.Read( Buffer, Count );
end;


{**********************************************************
*  Module:  TAdsBlobStream.Write
*  Input:  Buffer - Buffer to write
*          Count - size of buffer to write
*  Output:
*  Return: longint - size of buffer written
*  Description: Writes the blob
**********************************************************}
function TAdsBlobStream.Write( const Buffer; Count: Longint ): Longint;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsBlobStream.Write' );
{$ENDIF }

   if not ( moMode in [ bmWrite, bmReadWrite ] ) then
      raise EADSDatabaseError.create( nil, AE_TADSDATASET_GENERAL,
                                      'Error modifying read only blob.' );

   {  If the dataset is in dsSetKey state, moAdsBlobCach will be nil }
   if moAdsBlobCach = nil then
      raise EADSDatabaseError.create( nil, AE_TADSDATASET_GENERAL,
                                      'Cannot write to blob in current state.' );

   Result := moAdsBlobCach.Write( Buffer, Count );
   mbModified := True;
end;


{**********************************************************
*  Module:  TAdsBlobStream.Truncate
*  Input:
*  Output:
*  Description: overridden method that will truncate the blob
**********************************************************}
procedure TAdsBlobStream.Truncate;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsBlobStream.Truncate' );
{$ENDIF }

   if not ( moMode in [ bmWrite, bmReadWrite ] ) then
      raise EADSDatabaseError.create( nil, AE_TADSDATASET_GENERAL,
                                      'Error modifying read only blob.' );

   {  If the dataset is in dsSetKey state, moAdsBlobCach will be nil }
   if moAdsBlobCach = nil then
      raise EADSDatabaseError.create( nil, AE_TADSDATASET_GENERAL,
                                      'Cannot write to blob in current state.' );

   moAdsBlobCach.Truncate;
   mbModified := True;
end;


{**********************************************************
*  Module:  TAdsBlobStream.Seek
*  Input:
*  Output:
*  Description: overridden method that will truncate the blob
**********************************************************}
function TAdsBlobStream.Seek( Offset: Longint; Origin: Word ): Longint;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsBlobStream.Seek' );
{$ENDIF }

   {  If the dataset is in dsSetKey state, moAdsBlobCach will be nil }
   if moAdsBlobCach = nil then
      result := 0
   else
      Result := moAdsBlobCach.Seek( Offset, Origin );
end;



{  The following are stubs for public methods and procedures that will raise exceptions }
{  if they are called.  This will help in debugging why something is not working for }
{  third party controls. }
{**********************************************************
*  Module:  TAdsDataSet.GetIndexDefs
*  Input:
*  Output:
*  Return:
*  Description: This is a special stub function that raises
*  an exception to let the user know that this function is
*  not supported.  The meaning behind this is that the user
*  if trying to convert TTable code or if using third party
*  controls will know that the method is not supported.
**********************************************************}
//function  TAdsDataSet.GetIndexDefs : TIndexDefs;
//var
//   strErr : String;
//begin
{$IFDEF CALLTRACE }
//    WriteCallTrace( 'TAdsDataSet.GetIndexdefs' );
{$ENDIF }

//    strErr := 'The method GetIndexDefs in TAdsDataSet is not supported.';
//    raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL, strErr );
//end;

{**********************************************************
*  Module:  TAdsDataSet.GetTableLevel
*  Input:
*  Output:
*  Return:
*  Description: This is a special stub function that raises
*  an exception to let the user know that this function is
*  not supported.  The meaning behind this is that the user
*  if trying to convert TTable code or if using third party
*  controls will know that the method is not supported.
**********************************************************}
function TAdsDataSet.GetTableLevel : Integer;
begin
{$IFDEF CALLTRACE }
    WriteCallTrace( 'TAdsDataSet.GetTableLevel' );
{$ENDIF }

{$IFDEF FPC}
    {* Set function return to prevent warning. *}
    Result := AE_SUCCESS;
{$ENDIF}

    raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL,
       'The method GetTableLevel in TAdsDataSet is not supported.' );
end;
{**********************************************************
*  Module:  TAdsDataSet.GetDBDataBase
*  Input:
*  Output:
*  Return:
*  Description: This is a special stub function that raises
*  an exception to let the user know that this function is
*  not supported.  The meaning behind this is that the user
*  if trying to convert TTable code or if using third party
*  controls will know that the method is not supported.
**********************************************************}
function TAdsDataSet.GetDBDataBase : Variant;
begin
{$IFDEF CALLTRACE }
    WriteCallTrace( 'TAdsDataSet.GetDBDataBase' );
{$ENDIF }

{$IFDEF FPC}
    {* Set function return to prevent warning. *}
    Result := AE_SUCCESS;
{$ENDIF}

    raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL,
       'The method GetDBDatabase in TAdsDataSet is not supported.' );
end;
{**********************************************************
*  Module:  TAdsDataSet.GetDBHandle
*  Input:
*  Output:
*  Return:
*  Description: This is a special stub function that raises
*  an exception to let the user know that this function is
*  not supported.  The meaning behind this is that the user
*  if trying to convert TTable code or if using third party
*  controls will know that the method is not supported.
**********************************************************}
function TAdsDataSet.GetDBHandle : Variant;
begin
{$IFDEF CALLTRACE }
    WriteCallTrace( 'TAdsDataSet.GetDBHandle' );
{$ENDIF }

{$IFDEF FPC}
    {* Set function return to prevent warning. *}
    Result := AE_SUCCESS;
{$ENDIF}

    raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL,
       'The method GetDBHandle in TAdsDataSet is not supported.' );
end;
{**********************************************************
*  Module:  TAdsDataSet.GetDBLocale
*  Input:
*  Output:
*  Return:
*  Description: This is a special stub function that raises
*  an exception to let the user know that this function is
*  not supported.  The meaning behind this is that the user
*  if trying to convert TTable code or if using third party
*  controls will know that the method is not supported.
**********************************************************}
function TAdsDataSet.GetDBLocale : Variant;
begin
{$IFDEF CALLTRACE }
    WriteCallTrace( 'TAdsDataSet.GetDBLocale' );
{$ENDIF }

{$IFDEF FPC}
    {* Set function return to prevent warning. *}
    Result := AE_SUCCESS;
{$ENDIF}

    raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL,
       'The method GetDBLocale in TAdsDataSet is not supported.' );
end;
{**********************************************************
*  Module:  TAdsDataSet.GetDBSession
*  Input:
*  Output:
*  Return:
*  Description: This is a special stub function that raises
*  an exception to let the user know that this function is
*  not supported.  The meaning behind this is that the user
*  if trying to convert TTable code or if using third party
*  controls will know that the method is not supported.
**********************************************************}
function TAdsDataSet.GetDBSession : Variant;
begin
{$IFDEF CALLTRACE }
    WriteCallTrace( 'TAdsDataSet.GetDBSession' );
{$ENDIF }

{$IFDEF FPC}
    {* Set function return to prevent warning. *}
    Result := AE_SUCCESS;
{$ENDIF}

    raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL,
       'The method GetDBSession in TAdsDataSet is not supported.' );
end;
{**********************************************************
*  Module:  TAdsDataSet.GetProvider
*  Input:
*  Output:
*  Return:
*  Description: This is a special stub function that raises
*  an exception to let the user know that this function is
*  not supported.  The meaning behind this is that the user
*  if trying to convert TTable code or if using third party
*  controls will know that the method is not supported.
**********************************************************}
function TAdsDataSet.GetProvider : Variant;
begin
{$IFDEF CALLTRACE }
    WriteCallTrace( 'TAdsDataSet.GetProvider' );
{$ENDIF }

{$IFDEF FPC}
    {* Set function return to prevent warning. *}
    Result := AE_SUCCESS;
{$ENDIF}

    raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL,
       'The method GetProvider in TAdsDataSet is not supported.' );
end;
{**********************************************************
*  Module:  TAdsDataSet.GetSessionName
*  Input:
*  Output:
*  Return:
*  Description: This is a special stub function that raises
*  an exception to let the user know that this function is
*  not supported.  The meaning behind this is that the user
*  if trying to convert TTable code or if using third party
*  controls will know that the method is not supported.
**********************************************************}
function TAdsDataSet.GetSessionName : String;
begin
{$IFDEF CALLTRACE }
    WriteCallTrace( 'TAdsDataSet.GetSessionName' );
{$ENDIF }

{$IFDEF FPC}
    {* Set function return to prevent warning. *}
    Result := '';
{$ENDIF}

    raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL,
       'The method GetSessionName in TAdsDataSet is not supported.' );
end;

{**********************************************************
*  Module:  TAdsDataSet.GetCacheBlobs
*  Input:
*  Output:
*  Return:
*  Description: This is a special stub function that raises
*  an exception to let the user know that this function is
*  not supported.  The meaning behind this is that the user
*  if trying to convert TTable code or if using third party
*  controls will know that the method is not supported.
**********************************************************}
function TAdsDataSet.GetCacheBlobs : Boolean;
begin
{$IFDEF CALLTRACE }
    WriteCallTrace( 'TAdsDataSet.GetCacheBlobs' );
{$ENDIF }

{$IFDEF FPC}
    {* Set function return to prevent warning. *}
    Result := False;
{$ENDIF}

    raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL,
       'The method GetCacheBlobs in TAdsDataSet is not supported.' );
end;
{**********************************************************
*  Module:  TAdsDataSet.GetCachedUpdates
*  Input:
*  Output:
*  Return:
*  Description: This is a special stub function that raises
*  an exception to let the user know that this function is
*  not supported.  The meaning behind this is that the user
*  if trying to convert TTable code or if using third party
*  controls will know that the method is not supported.
**********************************************************}
function TAdsDataSet.GetCachedUpdates : Boolean;
begin
{$IFDEF CALLTRACE }
    WriteCallTrace( 'TAdsDataSet.GetCachedUpdates' );
{$ENDIF }

{$IFDEF FPC}
    {* Set function return to prevent warning. *}
    Result := False;
{$ENDIF}

    raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL,
       'The method GetCachedUpdates in TAdsDataSet is not supported.' );
end;
{**********************************************************
*  Module:  TAdsDataSet.GetExpIndex
*  Input:
*  Output:
*  Return:
*  Description: This is a special stub function that raises
*  an exception to let the user know that this function is
*  not supported.  The meaning behind this is that the user
*  if trying to convert TTable code or if using third party
*  controls will know that the method is not supported.
**********************************************************}
function TAdsDataSet.GetExpIndex : Boolean;
begin
{$IFDEF CALLTRACE }
    WriteCallTrace( 'TAdsDataSet.GetExpIndex' );
{$ENDIF }

{$IFDEF FPC}
    {* Set function return to prevent warning. *}
    Result := False;
{$ENDIF}

    raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL,
       'The method GetExpIndex in TAdsDataSet is not supported.' );
end;
{**********************************************************
*  Module:  TAdsDataSet.GetLocale
*  Input:
*  Output:
*  Return:
*  Description: This is a special stub function that raises
*  an exception to let the user know that this function is
*  not supported.  The meaning behind this is that the user
*  if trying to convert TTable code or if using third party
*  controls will know that the method is not supported.
**********************************************************}
function TAdsDataSet.GetLocale : Variant;
begin
{$IFDEF CALLTRACE }
    WriteCallTrace( 'TAdsDataSet.GetLocale' );
{$ENDIF }

{$IFDEF FPC}
    {* Set function return to prevent warning. *}
    Result := False;
{$ENDIF}

    raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL,
       'The method GetLocale in TAdsDataSet is not supported.' );
end;
{**********************************************************
*  Module:  TAdsDataSet.GetUpdateObject
*  Input:
*  Output:
*  Return:
*  Description: This is a special stub function that raises
*  an exception to let the user know that this function is
*  not supported.  The meaning behind this is that the user
*  if trying to convert TTable code or if using third party
*  controls will know that the method is not supported.
**********************************************************}
function TAdsDataSet.GetUpdateObject : Variant;
begin
{$IFDEF CALLTRACE }
    WriteCallTrace( 'TAdsDataSet.GetUpdateObject' );
{$ENDIF }

{$IFDEF FPC}
    {* Set function return to prevent warning. *}
    Result := False;
{$ENDIF}

    raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL,
       'The method GetUpdateObject in TAdsDataSet is not supported.' );
end;
{**********************************************************
*  Module:  TAdsDataSet.GetUpdatesPending
*  Input:
*  Output:
*  Return:
*  Description: This is a special stub function that raises
*  an exception to let the user know that this function is
*  not supported.  The meaning behind this is that the user
*  if trying to convert TTable code or if using third party
*  controls will know that the method is not supported.
**********************************************************}
function TAdsDataSet.GetUpdatesPending : Boolean;
begin
{$IFDEF CALLTRACE }
    WriteCallTrace( 'TAdsDataSet.GetUpdatesPending' );
{$ENDIF }

{$IFDEF FPC}
    {* Set function return to prevent warning. *}
    Result := False;
{$ENDIF}

    raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL,
       'The method GetUpdatesPending in TAdsDataSet is not supported.' );
end;
{**********************************************************
*  Module:  TAdsDataSet.GetUpdateRecordSet
*  Input:
*  Output:
*  Return:
*  Description: This is a special stub function that raises
*  an exception to let the user know that this function is
*  not supported.  The meaning behind this is that the user
*  if trying to convert TTable code or if using third party
*  controls will know that the method is not supported.
**********************************************************}
function TAdsDataSet.GetUpdateRecordSet : Variant;
begin
{$IFDEF CALLTRACE }
    WriteCallTrace( 'TAdsDataSet.GetUpdateRecordSet' );
{$ENDIF }

{$IFDEF FPC}
    {* Set function return to prevent warning. *}
    Result := False;
{$ENDIF}

    raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL,
       'The method GetUpdateRecordSet in TAdsDataSet is not supported.' );
end;

{$IFDEF FPC}{$HINTS OFF}{$ENDIF}
{**********************************************************
*  Module:  TAdsDataSet.SetTableLevel
*  Input:
*  Output:
*  Return:
*  Description: This is a special stub function that raises
*  an exception to let the user know that this function is
*  not supported.  The meaning behind this is that the user
*  if trying to convert TTable code or if using third party
*  controls will know that the method is not supported.
**********************************************************}
procedure TAdsDataSet.SetTableLevel( Value : Integer );
begin
{$IFDEF CALLTRACE }
    WriteCallTrace( 'TAdsDataSet.SetTableLevel' );
{$ENDIF }

    raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL,
       'The method SetTableLevel in TAdsDataSet is not supported.' );
end;
{**********************************************************
*  Module:  TAdsDataSet.SetSessionName
*  Input:
*  Output:
*  Return:
*  Description: This is a special stub function that raises
*  an exception to let the user know that this function is
*  not supported.  The meaning behind this is that the user
*  if trying to convert TTable code or if using third party
*  controls will know that the method is not supported.
**********************************************************}
procedure TAdsDataSet.SetSessionName( Value : String );
begin
{$IFDEF CALLTRACE }
    WriteCallTrace( 'TAdsDataSet.SetSessionName' );
{$ENDIF }
    raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL,
       'The method SetSessionName in TAdsDataSet is not supported.' );
end;
{**********************************************************
*  Module:  TAdsDataSet.SetCacheBlobs
*  Input:
*  Output:
*  Return:
*  Description: This is a special stub function that raises
*  an exception to let the user know that this function is
*  not supported.  The meaning behind this is that the user
*  if trying to convert TTable code or if using third party
*  controls will know that the method is not supported.
**********************************************************}
procedure TAdsDataSet.SetCacheBlobs( Value : Boolean );
var
   strErr : String;
begin
{$IFDEF CALLTRACE }
    WriteCallTrace( 'TAdsDataSet.SetCacheBlobs' );
{$ENDIF }

    strErr := 'The method SetCacheBlobs in TAdsDataSet is not supported.';
    raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL, strErr );
end;
{**********************************************************
*  Module:  TAdsDataSet.SetCachedUpdates
*  Input:
*  Output:
*  Return:
*  Description: This is a special stub function that raises
*  an exception to let the user know that this function is
*  not supported.  The meaning behind this is that the user
*  if trying to convert TTable code or if using third party
*  controls will know that the method is not supported.
**********************************************************}
procedure TAdsDataSet.SetCachedUpdates( Value : Boolean );
begin
{$IFDEF CALLTRACE }
    WriteCallTrace( 'TAdsDataSet.SetCachedUpdates' );
{$ENDIF }
    raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL,
       'The method SetCachedUpdates in TAdsDataSet is not supported.' );
end;

{**********************************************************
*  Module:  TAdsDataSet.SetUpdateObject
*  Input:
*  Output:
*  Return:
*  Description: This is a special stub function that raises
*  an exception to let the user know that this function is
*  not supported.  The meaning behind this is that the user
*  if trying to convert TTable code or if using third party
*  controls will know that the method is not supported.
**********************************************************}
procedure TAdsDataSet.SetUpdateObject( Value : Variant );
begin
{$IFDEF CALLTRACE }
    WriteCallTrace( 'TAdsDataSet.SetUpdateObject' );
{$ENDIF }
    raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL,
       'The method SetUpdateObject in TAdsDataSet is not supported.' );
end;
{**********************************************************
*  Module:  TAdsDataSet.SetUpdateRecordSet
*  Input:
*  Output:
*  Return:
*  Description: This is a special stub function that raises
*  an exception to let the user know that this function is
*  not supported.  The meaning behind this is that the user
*  if trying to convert TTable code or if using third party
*  controls will know that the method is not supported.
**********************************************************}
procedure TAdsDataSet.SetUpdateRecordSet( Value : Variant );
begin
{$IFDEF CALLTRACE }
    WriteCallTrace( 'TAdsDataSet.SetUpdateRecordSet' );
{$ENDIF }

    raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL,
       'The method SetUpdateRecordSet in TAdsDataSet is not supported.' );
end;

{**********************************************************
*  Module:  TAdsDataSet.BatchMove
*  Input:
*  Output:
*  Return:
*  Description: This is a special stub function that raises
*  an exception to let the user know that this function is
*  not supported.  The meaning behind this is that the user
*  if trying to convert TTable code or if using third party
*  controls will know that the method is not supported.
**********************************************************}
function TAdsDataSet.BatchMove( ASource: Variant; AMode: Variant ): Longint;
begin
{$IFDEF CALLTRACE }
    WriteCallTrace( 'TAdsDataSet.BatchMove' );
{$ENDIF }

{$IFDEF FPC}
    {* Set function return to prevent warning. *}
    Result := AE_SUCCESS;
{$ENDIF}

    raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL,
       'The method BatchMove in TAdsDataSet is not supported.' );
end;

{**********************************************************
*  Module:  TAdsDataSet.CheckOpen
*  Input:
*  Output:
*  Return:
*  Description: This is a special stub function that raises
*  an exception to let the user know that this function is
*  not supported.  The meaning behind this is that the user
*  if trying to convert TTable code or if using third party
*  controls will know that the method is not supported.
**********************************************************}
function TAdsDataSet.CheckOpen( Status: Variant ): Boolean;
begin
{$IFDEF CALLTRACE }
    WriteCallTrace( 'TAdsDataSet.CheckOpen' );
{$ENDIF }

{$IFDEF FPC}
    {* Prevent an FPC Warning *}
    Result := False;
{$ENDIF}

    raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL,
       'The method CheckOpen in TAdsDataSet is not supported.' );
end;
{$IFDEF FPC}{$HINTS ON}{$ENDIF}

{**********************************************************
*  Module:  TAdsDataSet.ApplyUpdates
*  Input:
*  Output:
*  Return:
*  Description: This is a special stub function that raises
*  an exception to let the user know that this function is
*  not supported.  The meaning behind this is that the user
*  if trying to convert TTable code or if using third party
*  controls will know that the method is not supported.
**********************************************************}
procedure TAdsDataSet.ApplyUpdates;
begin
{$IFDEF CALLTRACE }
    WriteCallTrace( 'TAdsDataSet.ApplyUpdates' );
{$ENDIF }

    raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL,
       'The method ApplyUpdates in TAdsDataSet is not supported.' );
end;
{**********************************************************
*  Module:  TAdsDataSet.CancelUpdates
*  Input:
*  Output:
*  Return:
*  Description: This is a special stub function that raises
*  an exception to let the user know that this function is
*  not supported.  The meaning behind this is that the user
*  if trying to convert TTable code or if using third party
*  controls will know that the method is not supported.
**********************************************************}
procedure TAdsDataSet.CancelUpdates;
begin
{$IFDEF CALLTRACE }
    WriteCallTrace( 'TAdsDataSet.CancelUpdates' );
{$ENDIF }
    raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL,
       'The method CancelUpdates in TAdsDataSet is not supported.' );
end;
{**********************************************************
*  Module:  TAdsDataSet.CommitUpdates
*  Input:
*  Output:
*  Return:
*  Description: This is a special stub function that raises
*  an exception to let the user know that this function is
*  not supported.  The meaning behind this is that the user
*  if trying to convert TTable code or if using third party
*  controls will know that the method is not supported.
**********************************************************}
procedure TAdsDataSet.CommitUpdates;
begin
{$IFDEF CALLTRACE }
    WriteCallTrace( 'TAdsDataSet.CommitUpdates' );
{$ENDIF }
    raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL,
       'The method CommitUpdates in TAdsDataSet is not supported.' );
end;
{**********************************************************
*  Module:  TAdsDataSet.ConstraintsDisabled
*  Input:
*  Output:
*  Return:
*  Description: This is a special stub function that raises
*  an exception to let the user know that this function is
*  not supported.  The meaning behind this is that the user
*  if trying to convert TTable code or if using third party
*  controls will know that the method is not supported.
**********************************************************}
function TAdsDataSet.ConstraintsDisabled: Boolean;
begin
{$IFDEF CALLTRACE }
    WriteCallTrace( 'TAdsDataSet.ConstraintsDisabled' );
{$ENDIF }

{$IFDEF FPC}
    {* Set the function result to prevent warning in FPC *}
    Result := False;
{$ENDIF}

    raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL,
       'The method ConstraintsDisabled in TAdsDataSet is not supported.' );
end;
{**********************************************************
*  Module:  TAdsDataSet.DisableConstriants
*  Input:
*  Output:
*  Return:
*  Description: This is a special stub function that raises
*  an exception to let the user know that this function is
*  not supported.  The meaning behind this is that the user
*  if trying to convert TTable code or if using third party
*  controls will know that the method is not supported.
**********************************************************}
procedure TAdsDataSet.DisableConstraints;
begin
{$IFDEF CALLTRACE }
    WriteCallTrace( 'TAdsDataSet.DisableConstraints' );
{$ENDIF }
    raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL,
       'The method DisableConstraints in TAdsDataSet is not supported.' );
end;
{**********************************************************
*  Module:  TAdsDataSet.EnableConstraints
*  Input:
*  Output:
*  Return:
*  Description: This is a special stub function that raises
*  an exception to let the user know that this function is
*  not supported.  The meaning behind this is that the user
*  if trying to convert TTable code or if using third party
*  controls will know that the method is not supported.
**********************************************************}
procedure TAdsDataSet.EnableConstraints;
begin
{$IFDEF CALLTRACE }
    WriteCallTrace( 'TAdsDataSet.EnableConstraints' );
{$ENDIF }
    raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL,
       'The method EnableConstraints in TAdsDataSet is not supported.' );
end;
{**********************************************************
*  Module:  TAdsDataSet.FetchAll
*  Input:
*  Output:
*  Return:
*  Description: This is a special stub function that raises
*  an exception to let the user know that this function is
*  not supported.  The meaning behind this is that the user
*  if trying to convert TTable code or if using third party
*  controls will know that the method is not supported.
**********************************************************}
procedure TAdsDataSet.FetchAll;
begin
{$IFDEF CALLTRACE }
    WriteCallTrace( 'TAdsDataSet.FetchAll' );
{$ENDIF }
    raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL,
       'The method FetchAll in TAdsDataSet is not supported.' );
end;
{**********************************************************
*  Module:  TAdsDataSet.GetIndexInfo
*  Input:
*  Output:
*  Return:
*  Description: This is a special stub function that raises
*  an exception to let the user know that this function is
*  not supported.  The meaning behind this is that the user
*  if trying to convert TTable code or if using third party
*  controls will know that the method is not supported.
**********************************************************}
procedure TAdsDataSet.GetIndexInfo;
begin
{$IFDEF CALLTRACE }
    WriteCallTrace( 'TAdsDataSet.GetIndexInfo' );
{$ENDIF }
    raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL,
       'The method GetIndexInfo in TAdsDataSet is not supported.' );
end;
{**********************************************************
*  Module:  TAdsDataSet.RevertRecord
*  Input:
*  Output:
*  Return:
*  Description: This is a special stub function that raises
*  an exception to let the user know that this function is
*  not supported.  The meaning behind this is that the user
*  if trying to convert TTable code or if using third party
*  controls will know that the method is not supported.
**********************************************************}
procedure TAdsDataSet.RevertRecord;
begin
{$IFDEF CALLTRACE }
    WriteCallTrace( 'TAdsDataSet.RevertRecord' );
{$ENDIF }
    raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL,
       'The method RevertRecord in TAdsDataSet is not supported.' );
end;
{**********************************************************
*  Module:  TAdsDataSet.UpdateStatus
*  Input:
*  Output:
*  Return:
*  Description: This is a special stub function that raises
*  an exception to let the user know that this function is
*  not supported.  The meaning behind this is that the user
*  if trying to convert TTable code or if using third party
*  controls will know that the method is not supported.
**********************************************************}
function TAdsDataSet.UpdateStatus: TUpdateStatus;
begin
{$IFDEF CALLTRACE }
    WriteCallTrace( 'TAdsDataSet.UpdateStatus' );
{$ENDIF }

{$IFDEF FPC}
    {* Set the result to prevent warning *}
    Result := usUnmodified;
{$ENDIF}

    raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL,
       'The method UpdateStatus in TAdsDataSet is not supported.' );
end;

{  The end of the stubs for public methods and procedures that will raise exceptions }
{  if they are called.  This will help in debugging why something is not working for }
{  third party controls. }


{**********************************************************
*  Module:  TAdsDataSet.FlushBuffers
*  Input:
*  Output:
*  Return:
*  Description: Flush file buffers
**********************************************************}
procedure TAdsDataSet.FlushBuffers;
begin
{$IFDEF CALLTRACE }
    WriteCallTrace( 'TAdsDataSet.FlushBuffers' );
{$ENDIF }
    CheckBrowseMode;
    {* Ignore any errors this might return (readonly for ex) *}
    ACE.AdsFlushFileBuffers( Handle );
end;


{**********************************************************
*  Module:  TAdsDataSet.GetAceConnectionHandle
*  Input:
*  Output:
*  Return:      The ACE connection handle for this instance of TAdsDataSet
*  Description:
**********************************************************}
function TAdsDataSet.GetAceConnectionHandle : ADSHANDLE;
var
   ulRetVal : UNSIGNED32;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.GetAceConnectionHandle' );
{$ENDIF }
   ulRetVal := ACE.AdsGetTableConnection( self.handle, @Result );
   if ( ulRetVal = AE_INVALID_TABLE_HANDLE ) then
      Result := 0
   else
      ACECheck( self, ulRetVal );
end;


{**********************************************************
*  Module:  TAdsDataSet.GetAceTableHandle
*  Input:
*  Output:
*  Return:      The ACE table handle for this instance of TAdsDataSet
*  Description: Raises an Exception if any sort of error occurs
**********************************************************}
function TAdsDataSet.GetAceTableHandle : ADSHANDLE;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.GetAceTableHandle' );
{$ENDIF }
   Result := Self.Handle;
end;

{**********************************************************
*  Module:  TAdsDataSet.GetAceIndexHandle
*  Input:
*  Output:
*  Return:      The ACE handle for the current index in this instance of TAdsDataSet
*               or 0 if no index is active
*  Description: Raises an Exception if any sort of error occurs
**********************************************************}
function TAdsDataSet.GetAceIndexHandle : ADSHANDLE;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.GetAceIndexHandle' );
{$ENDIF }
   if Handle = ActiveHandle then
      Result := INVALID_ACE_HANDLE
   else
      Result := ActiveHandle;
end;

{**********************************************************
*  Module:  TAdsDataSet.GetAceOrderHandle
*  Input:
*  Output:
*  Return:      The ACE table handle to be used as the order for this instance
*               of TAdsDataSet.  The order handle may be either an index handle
*               or a table handle for natural order.  This value should be used
*               with AdsSkip, etc.
*  Description: Raises an Exception if any sort of error occurs
**********************************************************}
function TAdsDataSet.GetAceOrderHandle : ADSHANDLE;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.GetAceOrderHandle' );
{$ENDIF }
   Result := ActiveHandle;
end;



{**********************************************************
*  Module:  TAdsDataSet.SetIndexField
*  Input:
*  Output:
*  Return:      Same as TTable.SetIndexField.  Implemented for completeness.
*  Description:
**********************************************************}
procedure TAdsDataSet.SetIndexField( Index: Integer; Value: TField );
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.SetIndexField' );
{$ENDIF }
   { this code is identical to TTable's }
   GetIndexField( Index ).Assign( Value );
end;

{$IFDEF ADSCBUILDER3_OR_NEWER }
{**********************************************************
*  Module:  TAdsDataSet.SetIndexDefs
*  Input:
*  Output:
*  Return:      Same as TTable.SetIndexDefs.  Implemented for completeness.
*  Description:
**********************************************************}
procedure TAdsDataSet.SetIndexDefs( Value: TIndexDefs );
begin
{$IFDEF CALLTRACE}
   WriteCallTrace( 'TAdsDataSet.SetIndexDefs' );
{$ENDIF}

  IndexDefs.Assign( Value );
end;

{$ENDIF}

{**********************************************************
*  Module:  TAdsDataSet.GetIndexField
*  Input:
*  Output:
*  Return:      Same as TTable.GetIndexField.  Implemented for completeness.
*  Description:
**********************************************************}
function TAdsDataSet.GetIndexField( Index: Integer ): TField;
var
   sSegmentCount : SIGNED16;
   usExprLength : UNSIGNED16;
   acFieldName: array[0..ADS_MAX_FIELD_NAME] of AceChar;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsDataSet.GetIndexField' );
{$ENDIF }

   sSegmentCount := Index;
   usExprLength := sizeof( acFieldName );

   ACECheck( self, ACEUNPUB.AdsGetSegmentFieldName( ActiveHandle, sSegmentCount,
                                              @acFieldName, @usExprLength ) );

   Result := FieldByName( string( StrPas( acFieldName ) ) );
end;


{$IFDEF ADSDELPHI5_OR_NEWER}
{$IFNDEF FPC}

{ TAdsDataSet.IProviderSupport}

{****************************************************************************************
*  Module:  TAdsDataSet.PSIsSQLSupported
*  Input:
*  Output:
*  Return:  TRUE
*  Description: PSIsSQLSupported indicates whether the provider can call
*               PSExecuteStatement to execute an SQL statement.
****************************************************************************************}
function TAdsDataSet.PSIsSQLSupported: Boolean;
begin
  Result := True;
end;



{****************************************************************************************
*  Module:  TAdsDataSet.PSReset
*  Input:
*  Output:
*  Return:
*  Description: Resets the dataset so that it is positioned on the first record.
****************************************************************************************}
procedure TAdsDataSet.PSReset;
begin
  inherited PSReset;
  {*
   * NOTE: The help file for PSReset says it is used to reset the dataset on the first
   * record. The TBDEDataset implementation, however, just calls DbiForceReread, which
   * is documented as refreshing all buffers for the table associated with the cursor.
   * Sounds like a gotop will be fine for us, but I'm not sure. If there are ever
   * questions regarding the freshness of our data this would be a good place to start
   * looking. Following is what TBDEDataSet would do:
   *     if Handle <> nil then
   *       DbiForceReread( Handle );
   *}
   if Active then
   begin
      ACECHECK( self, ACE.AdsGotoTop( Handle ) );
      CursorPosChanged;
   end;

end;



{****************************************************************************************
*  Module:  TAdsDataSet.PSUpdateRecord
*  Input:
*  Output:
*  Return:
*  Description: Before the provider generates SQL statements to apply an update, it
*               calls PSUpdateRecord to let the dataset apply the update in some other
*               fashion.
****************************************************************************************}
function TAdsDataSet.PSUpdateRecord( UpdateKind: TUpdateKind; Delta: TDataSet ): Boolean;
var
  UpdateAction: TUpdateAction;
begin

  Result := False;

  if Assigned( OnUpdateRecord ) then
  begin
    UpdateAction := uaFail;
    if Assigned( FOnUpdateRecord ) then
    begin
      FOnUpdateRecord( Delta, UpdateKind, UpdateAction );
      Result := UpdateAction = uaApplied;
    end;
  end;

  {*
   * NOTE: BDE will actually attempt to update the record if the users OnUpdateRecord event does not
   * apply the record update. We're not going to do that. If we return false here then the provider
   * will build an SQL statement and call PSExecuteStatement. In the future if we have issues with
   * the statement automatically generated by the provider then we may need to apply the update here
   * instead.
   *}

end;



{****************************************************************************************
*  Module:  TAdsDataSet.PSIsSQLBased
*  Input:
*  Output:
*  Return:  TRUE
*  Description: Indicates whether the dataset includes native SQL support.
****************************************************************************************}
function TAdsDataSet.PSIsSQLBased: Boolean;
begin
   Result := TRUE;
end;



{****************************************************************************************
*  Module:  TAdsDataSet.PSGetQuoteChar
*  Input:
*  Output:
*  Return:
*  Description: Returns the character or characters to use in generated SQL statements
*               to enclose quoted strings.
****************************************************************************************}
function TAdsDataSet.PSGetQuoteChar: string;
begin
   Result := '"';
end;



{****************************************************************************************
*  Module:  TAdsDataSet.PSInTransaction
*  Input:
*  Output:
*  Return:  TRUE if in transaction, o/w FALSE
*  Description: Indicates whether actions against the dataset occur in the context
*               of a transaction.
****************************************************************************************}
function TAdsDataSet.PSInTransaction: Boolean;
begin
  if not Assigned( mpoAdsConnection ) or not mpoAdsConnection.IsConnected then
     Result := False
  else
     Result := mpoAdsConnection.TransactionActive;
end;



{****************************************************************************************
*  Module:  TAdsDataSet.PSStartTransaction
*  Input:
*  Output:
*  Return:
*  Description: Starts a transaction that encapsulates all activity until a call
*               to PSEndTransaction.
****************************************************************************************}
procedure TAdsDataSet.PSStartTransaction;
begin
   if Assigned( mpoAdsConnection ) then
      mpoAdsConnection.BeginTransaction;
end;



{****************************************************************************************
*  Module:  TAdsDataSet.PSEndTransaction
*  Input:   Commit : true if commit, o/w rollback
*  Output:
*  Return:
*  Description: Ends a transaction that was started by a call to PSStartTransaction
****************************************************************************************}
procedure TAdsDataSet.PSEndTransaction( Commit: Boolean );
begin
   if Assigned( mpoAdsConnection ) then
   begin
      if ( Commit = TRUE ) then
         mpoAdsConnection.Commit
      else
         mpoAdsConnection.Rollback;
   end;
end;



{****************************************************************************************
*  Module:  TAdsDataSet.PSExecuteStatement
*  Input:   ASQL      - statement to execute
*           AParams   - parameters (if any) for the statement
*           ResultSet - if not nil a pointer to the dataset for the SELECT results
*  Output:
*  Return:
*  Description: Executes a specified SQL command.
****************************************************************************************}
function TAdsDataSet.PSExecuteStatement( const ASQL: string; AParams: TParams;
  ResultSet: Pointer = nil ): Integer;
var
   Cursor : ADSHANDLE;
   oAdsDatasetOptions : TAdsDatasetOptions;
begin

   if not Assigned( mpoAdsConnection ) then
   begin
      raise EADSDatabaseError.Create( self, AE_TADSDATASET_GENERAL,
         'A TAdsConnection component is required for TClientDataSet/IProvider support. Use either the AdsConnection ' +
         ' property or the Database property to specify a TAdsConnection instance.' );
   end;

   { Setup the dataset options }
   if ( mpoAdsTableOptions.meAdsLockType = Proprietary )  then
      oAdsDatasetOptions.musAdsLockType := ADS_PROPRIETARY_LOCKING
   else
      oAdsDatasetOptions.musAdsLockType := ADS_COMPATIBLE_LOCKING;

   { Add one, enumeration is zero based, but ace constants are one based }
   oAdsDatasetOptions.musAdsCharType := UNSIGNED16( mpoAdsTableOptions.meAdsCharType ) + 1;

   if ( mpoAdsTableOptions.mbAdsRightsCheck )  then
      oAdsDatasetOptions.musAdsRightsCheck := ADS_CHECKRIGHTS
   else
      oAdsDatasetOptions.musAdsRightsCheck := ADS_IGNORERIGHTS;

   oAdsDatasetOptions.musAdsTableType := musOpenTableType;

   if Assigned(ResultSet) then
   begin
     Result := mpoAdsConnection.Execute( oAdsDatasetOptions, ASQL, AParams, True, @Cursor );
     TDataSet(ResultSet^) := TAdsQuery.Create( nil );
     TAdsDataSet(ResultSet^).SetHandle( Cursor );
   end else
     Result := mpoAdsConnection.Execute( oAdsDatasetOptions, ASQL, AParams, True, nil );

end;

{$ENDIF}   {* IFNDEF FPC *}
{$ENDIF}   {* IFDEF ADSDELPHI5_OR_NEWER *}

{****************************************************************************************
*  Module:  TAdsDataSet.SetHandle
*  Input:   open cursor or table handle
*  Output:
*  Return:
*  Description: Sets the cursor/table handle in a dataset and opens/reopens the dataset
****************************************************************************************}
procedure TAdsDataSet.SetHandle( Value: ADSHANDLE );
begin
   Close;
   mlActiveHandle := Value;
   if ( Value <> 0 ) and ( Value <> INVALID_ACE_HANDLE ) then
   try
     Open;
   except
     mlActiveHandle := INVALID_ACE_HANDLE;
     raise;
   end;
end;



procedure TAdsDataSet.FreeOldRecordBuffer;
begin
   if FOldRecordBuffer <> nil then
   begin
      StrDispose( PAnsiChar( FOldRecordBuffer ) );
      FOldRecordBuffer := nil;
   end;
end;



{*******************************************************************************
*  Module:  TAdsDataSet.InvalidateAceHandles
*  Input:
*  Output:
*  Description: Invalidates ace handles in the component. Called by a
*   TAdsConnection component when disconnecting. This way the query or proc
*   component won't have invalid statement handles referenced inside it (since
*   the connection component destroyed them when it closed).
*******************************************************************************}
procedure TAdsDataSet.InvalidateAceHandles;
begin
   {* overridden in TAdsQuery and TAdsStoredProc *}
end;


{*******************************************************************************
*  Module:  TAdsDataSet.GetCharTypeAfterOpen
*  Description: Gets the char type ace used to open the handle. Save it so later
*    we can decide if we need to do ANSI/OEM conversions. Also check the table
*    collation, and if it has not been set explicitly to a lang other than our
*    old ANSI or OEM constants, then set AdsCharType to match it. Otherwise
*    the user already set AdsCharType to get the new collation, and we don't
*    want to overwrite that value here.
*  NOTE: This is called before the objects Handle property is set, so it has
*    to use the handle passed in, rather than its member variable
*******************************************************************************}
procedure TAdsDataSet.GetCharTypeAfterOpen( hDataSet : ADSHANDLE );
var
   acCollation : array [0..100] of acechar;
   usLen       : UNSIGNED16;
   ulRetVal    : UNSIGNED32;
begin
   ACECheck( self, AdsGetTableCharType( hDataSet, @musOpenCharType ) );

   // If the language is an "old" ansi or oem lang, then stick to our old behavior
   // and update the AdsCharType member. If it is one of the newer languages
   // then the AdsCharType by definition should already be set to that language
   // so don't set it to usOpenCharType here or we will overwrite the users
   // explicit language selection.
   usLen := sizeof( acCollation );
   ulRetVal := AdsGetTableCollation( hDataSet, acCollation, @usLen );

   // If the return code is AE_INVALID_TABLETYPE, then this is not a table that
   // supports more collations, so go ahead and set AdsCharType. If the name
   // is empty, then it hasn't been set, so continue to set AdsCharType for
   // this case as well.
   if ( usLen = 0 ) or ( ulRetVal = AE_INVALID_TABLETYPE ) then
      // ACE char type is 1-based, our enum is zero based, so subtract one
      self.AdsTableOptions.AdsCharType := TAdsCharTypes( musOpenCharType - 1 );

   // Only expect AE_INVALID_TABLETYPE error
   if ( ulRetVal <> AE_INVALID_TABLETYPE ) then
      ACECheck( self, ulRetVal );
end;


{**********************************************************
*  Module:  TAdsDataSet.GetEffectiveCollation
*  Date Created:  04/14/2009
*  Description: Returns the effective collation for the  DataSet.
*  Note:  We always use the DataSet's collation (if set),
*         otherwise we use the Connection's collation (if set)
**********************************************************}
function TAdsDataSet.GetEffectiveCollation;
begin

   if mpoAdsTableOptions.AdsCollation <> '' then
      Result := mpoAdsTableOptions.AdsCollation
   else if ( Assigned( AdsConnection ) ) and ( AdsConnection.AdsCollation <> '' ) then
      Result := AdsConnection.AdsCollation
   else
      // default to the old char type
      Result := TAdsCharTypeMap[ integer( mpoAdsTableOptions.AdsCharType )];

end;


{* FreeAndNil frees the given TObject instance and sets the variable reference
 * to nil.  Be careful to only pass TObjects to this routine. *}
{$IFNDEF ADSDELPHI5_OR_NEWER}
procedure FreeAndNil( var Obj );
var
  P: TObject;
begin
  P := TObject( Obj );
  TObject( Obj ) := nil;  // clear the reference before destroying the object
  P.Free;
end;
{$ENDIF}


{ TAdsStringField }

constructor TAdsStringField.Create(AOwner: TComponent);
begin
   inherited;
   FCaseInsensitive := FALSE;
end;

{ TAdsBCDField }

constructor TAdsBCDField.Create(AOwner: TComponent);
begin
  inherited;

  {* Default Currency to true, don't overwrite what's in the dfm though. *}
  if assigned( Owner ) then
  begin
     if not ( csLoading in Owner.ComponentState ) then
        Currency := TRUE;
  end
  else
     Currency := TRUE;
end;

{$IFDEF ADSDELPHI5}
{$OPTIMIZATION OFF}
{* Brought in these utility functions for use with ADS_ROWVERSION & D5 *}
function FractionToStr(const pIn: PChar; count: SmallInt;
         DecPosition: ShortInt; Negative: Boolean;
         StartWithDecimal: Boolean): string;
var
  NibblesIn, BytesIn, DigitsOut: Integer;
  P, POut: PChar;
  Dot: Char;

  procedure AddOneChar(Value: Char);
  begin
    P[0] := Value;
    Inc(P);
    Inc(DigitsOut);
  end;
  procedure AddDigit(Value: Char);
  begin
    if ((DecPosition > 0) and (NibblesIn  = DecPosition)) or
       ((NibblesIn = 0) and StartWithDecimal) then
    begin
      if DigitsOut = 0 then AddOneChar('0');
      AddOneChar(Dot);
    end;
    if (Value > #0) or (DigitsOut > 0) then
      AddOneChar(Char(Integer(Value)+48));
    Inc(NibblesIn);
  end;

begin
  POut := AllocMem(Count + 3);  // count + negative/decimal/zero
  try
    Dot := DecimalSeparator;
    P := POut;
    DigitsOut := 0;
    BytesIn := 0;
    NibblesIn := 0;
    while NibblesIn < Count do
    begin
      AddDigit(Char(Integer(pIn[BytesIn]) SHR 4));
      if NibblesIn < Count then
        AddDigit(Char(Integer(pIn[BytesIn]) AND 15));
      Inc(BytesIn);
    end;
    while (DecPosition > 0) and (NibblesIn  > DecPosition) and (DigitsOut > 1) do
    begin
      if POut[DigitsOut-1] = '0' then
      begin
        Dec(DigitsOut);
        POut[DigitsOut] := #0;
      end else
        break;
    end;
    if POut[DigitsOut-1] = Dot then
      Dec(DigitsOut);
    POut[DigitsOut] := #0;
    SetString(Result, POut, DigitsOut);
  finally
    FreeMem(POut, Count + 2);
  end;
  if Result = '' then Result := '0'
  else if Negative then Result := '-' + Result;
end;

function BcdToStr(const Bcd: TBcd): string;
var
  NumDigits: Integer;
  pStart: PChar;
  DecPos: SmallInt;
  Negative: Boolean;
begin
  if ( Bcd.Precision = 0 ) or ( Bcd.Precision > 64 ) then
    raise Exception.Create('BCD value overflow' )
  else
  begin
    Negative := Bcd.SignSpecialPlaces and (1 shl 7) <> 0;
    NumDigits := Bcd.Precision;
    pStart := pCHAR(@Bcd.Fraction);   // move to fractions
    // use lower 6 bits of iSignSpecialPlaces.
    if (Bcd.SignSpecialPlaces and 63) > 0 then
    begin
      DecPos := ShortInt(NumDigits - (Bcd.SignSpecialPlaces and 63));
    end else
      DecPos := NumDigits + 1;     // out of range
    Result := FractionToStr(pStart, NumDigits, DecPos, Negative,
           (NumDigits = Bcd.SignSpecialPlaces and 63));
    if Result[1] in ['0', '-'] then
      if (Result = '-0') or (Result = '0.0') or (Result = '-0.0') then Result := '0';
  end;
end;

procedure StrToFraction(pTo: PChar; pFrom: PChar; count: SmallInt); pascal;
var
  Dot: Char;
begin
  Dot := DecimalSeparator;
  asm
   // From bytes to nibbles, both left aligned
        PUSH    ESI
        PUSH    EDI
        PUSH    EBX
        MOV     ESI,pFrom  // move pFrom to ESI
        MOV     EDI,pTo    // move pTo to EDI
        XOR     ECX,ECX    // set ECX to 0
        MOV     CX,count   // store count in CX
        MOV     DL,0       // Flag: when to store
        CLD
@@1:    LODSB              // moves [ESI] into al
        CMP     AL,Dot
        JE      @@4
        SUB     AL,'0'
        CMP     DL,0
        JNE     @@2
        SHL     AL,4
        MOV     AH,AL
        JMP     @@3
@@2:    OR      AL,AH     // takes AH and ors in AL
        STOSB             // always moves AL into [EDI]
@@3:    NOT     dl        // flip all bits
@@4:    LOOP    @@1       // decrements cx and checks if it's 0
        CMP     DL,0      // are any bytes left unstored?
        JE      @@5
        MOV     AL,AH     // if so, move to al
        STOSB             // and store to [EDI]
@@5:    POP     EBX
        POP     EDI
        POP     ESI
  end;
end;

function InvalidBcdString(PValue: PChar): Boolean;
var
  Dot: Char;
  P: PChar;
begin
  Dot := DecimalSeparator;
  P := PValue;
  Result := False;
  while P^ <> #0 do
  begin
    if not (P^ in ['0'..'9', '-', Dot]) then
    begin
      Result := True;
      break;
    end;
    Inc(P);
  end;
end;

function TryStrToBcd(const AValue: string; var Bcd: TBcd): Boolean;
const
  spaceChars: set of AceChar = [ ' ', #6, #10, #13, #14];
  digits: set of AceChar = ['0'..'9'];
var
  Neg: Boolean;
  NumDigits, DecimalPos: Word;
  pTmp, pSource: PChar;
  Dot : Char;
begin
  Dot := DecimalSeparator;
  if InvalidBcdString(PChar(AValue)) then
  begin
    Result := False;
    exit;
  end;
  if (AValue = '0') or (AValue = '') then
  begin
    Result := True;
    Bcd.Precision := 8;
    Bcd.SignSpecialPlaces := 2;
    pSource := PChar(@Bcd.Fraction);
    FillChar(PSource^, SizeOf(Bcd.Fraction), 0);
    Exit
  end;
  Result := True;
  Neg := False;
  DecimalPos := Pos(Dot, AValue);

  pSource := pCHAR(AValue);
  { Strip leading whitespace }
  while (pSource^ in spaceChars) or (pSource^ = '0') do
  begin
    Inc(pSource);
    if DecimalPos > 0 then Dec(DecimalPos);
  end;

  { Strip trailing whitespace }
  pTmp := @pSource[ StrLen( pSource ) -1 ];
  while pTmp^ in spaceChars do
  begin
    pTmp^ := #0;
    Dec(pTmp);
  end;

  { Is the number negative? }
  if pSource^ = '-' then
  begin
    Neg := TRUE;
    if DecimalPos > 0 then Dec(DecimalPos);
  end;
  if (pSource^ = '-') or (pSource^ ='+') then
    Inc(pSource);

  { Clear structure }
  pTmp := pCHAR(@Bcd.Fraction);
  FillChar(pTmp^, SizeOf(Bcd.Fraction), 0);
  if (pSource[0] = '0') then
  begin
    Inc(PSource);  // '0.' scenario
    if DecimalPos > 0 then Dec(DecimalPos);
  end;
  NumDigits := StrLen(pSource);
  if (NumDigits > 64) then
  begin
    if (DecimalPos > 0) and (DecimalPos <= 64) then
      NumDigits := 64 // truncate to 64
    else begin
      Bcd.Precision := NumDigits;
      Exit;
    end;
  end;

  if NumDigits > 0 then
    StrToFraction(pTmp, pSource, SmallInt(NumDigits))
  else begin
    Bcd.Precision := 10;
    Bcd.SignSpecialPlaces := 2;
  end;

  if DecimalPos > 0 then
  begin
    Bcd.Precision := Byte(NumDigits-1);
    if Neg then
      Bcd.SignSpecialPlaces := ( 1 shl 7 ) + (BYTE(NumDigits - DecimalPos))
    else
      Bcd.SignSpecialPlaces := ( 0 shl 7 ) + (BYTE(NumDigits - DecimalPos));
  end else
  begin
    Bcd.Precision := Byte(NumDigits);
    if Neg then
      Bcd.SignSpecialPlaces := (1 shl 7)
    else
      Bcd.SignSpecialPlaces := (0 shl 7);
  end;
end;

function StrToBcd(const AValue: string): TBcd;
var
  Success: Boolean;
begin
  Success := TryStrToBcd(AValue, Result);
  if not Success then
    raise Exception.Create('Invalid BCD value' );
end;
{$OPTIMIZATION ON}

{$ENDIF} {* IFDEF ADSDELPHI5 *}

initialization
bExceptionSet := False;
goDynamicConnList := TDynamicConnList.Create;

finalization

if ( oAdsDatasets <> nil ) then
   FreeAndNil( oAdsDatasets );

goDynamicConnList.Free;

end.
