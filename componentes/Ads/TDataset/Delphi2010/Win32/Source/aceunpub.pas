// Copyright (c) 2002 Extended Systems, Inc.  ALL RIGHTS RESERVED.
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
* Source File : ACEUNPUB.PAS
* Date Created: 04/23/97
* Description : This is the Delphi 32-bit header file for the Advantage Client
*               Engine unpublished API.
*               This exposes the unpublished ACE API as the pascal unit ACE32.
* Notes       :
*******************************************************************************}
unit aceunpub;

{$IFDEF FPC}
   {$MODE delphi}{$H+}
{$ENDIF}

{$INCLUDE versions.inc}

{$IFDEF ADSDELPHI7}

   {$WARN UNSAFE_TYPE OFF}
   {$WARN UNSAFE_CODE OFF}
   {$WARN UNSAFE_CAST OFF}

{$ENDIF}

interface

uses
   ace;

const
   { Get Index flags }
   ODBC_DO_NOT_USE         = $8000;
   AXS_UNIQUE_INDEX        = $4000;
   AXS_ASCENDING           = $2000;
   AXS_DESCENDING          = $1000;

   ADS_DD_COLUMN_PERMISSION_READ    = $01;
   ADS_DD_COLUMN_PERMISSION_UPDATE  = $02;
   ADS_DD_COLUMN_PERMISSION_INSERT  = $04;

   { the following are extended data types for FoxPro (non-standard dbf) }
   ADS_FOXGENERAL          = 51;    { FoxPro General Field - stores an OLE object }
   ADS_FOXPICTURE          = 52;    { FoxPro Picture Field }

   { Generic command/operation/property items for the AdsSetProperty API }
   ADS_SET_LARGE_BLOCK_READS  =  1;  { Object: connection.  Value: TRUE/FALSE }
   ADS_SET_BATCH_INSERTS      =  2;  { Object: table.  Value: none (the call simply turns it on)
                                       This is a use-at-your-own-risk.  It is only useful
                                       for massive inserts of lots of records and
                                       primarily for local server.  It does not work
                                       * with transactions. }
   ADS_GET_AOF_PLAN           = 56; { Object: table; Value: UNSIGNED8 **  }

   { Define constants for the cache sizes for read-ahead record caching.  Testing
     and a few years of public use have shown 10 to be a reasonable size for the
     default.
     The aggressive cache size is primarily for "forward-only" cursors.  Testing with
     varying record sizes and varying conditions (ALS, ADS, networked, non-networked,
     various client speeds, etc.) generally showed an exponential curve (time versus
     cache size in terms of # of records) when skipping through an entire table.
     The curve generally flattened out at between 50 and 100 records. }
   ADS_NORMAL_RA_CACHE_SIZE    =  10;
   ADS_AGGRESSIVE_RA_CACHE_SIZE = 100;

   { Constants for AdsIsBufferNullOrEmpty }
   ADS_RETRIEVE_NULL_FLAG     =   $00000001;
   ADS_UPDATE_NULL_FLAG       =   $00000002;
   ADS_UPDATE_FULL_FLAG       =   $00000003;
   ADS_RETRIEVE_FULL_FLAG     =   $00000004;

   function AdsGetIndexFlags( hIndex: ADSHANDLE;
                              pulFlags: PUNSIGNED32 ): UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF LINUX}cdecl;{$ENDIF}

   function AdsGetIndexOrderByHandle( hIndex: ADSHANDLE;
                                      pusIndexOrder: PWord ): UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF LINUX}cdecl;{$ENDIF}

   function AdsGetNumSegments( hTag: ADSHANDLE;
                               pusSegments: PWord ): UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF LINUX}cdecl;{$ENDIF}

   function AdsGetSegmentFieldname( hTag: ADSHANDLE;
                                    usSegmentNum: UNSIGNED16;
                                    pucFieldname: PAceChar;
                                    pusFldnameLen: PWord ): UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF LINUX}cdecl;{$ENDIF}

   function AdsDeleteTable( hTable: ADSHANDLE ): UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF LINUX}cdecl;{$ENDIF}

   function AdsBuildKeyFromRecord( hTag: ADSHANDLE;
                                   pucRecBuffer: PAceChar;
                                   ulRecordLen: UNSIGNED32;
                                   pucKey: PAceChar;
                                   pusKeyLen: PWord ): UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF LINUX}cdecl;{$ENDIF}

   function AdsConvertJulianToString( dJulian : Double;
                                      pucJulian : PAceChar;
                                      pusLen : pWord ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF LINUX}cdecl;{$ENDIF}

   function AdsConvertStringToJulian( pucJulian : PAceChar;
                                      usLen : UNSIGNED16;
                                      pdJulian : PDOUBLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF LINUX}cdecl;{$ENDIF}

   function AdsConvertMillisecondsToString( ulMSeconds : UNSIGNED32;
                                            pucTime    : PAceChar;
                                            pusLen     : pWord ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF LINUX}cdecl;{$ENDIF}

   function AdsConvertStringToMilliseconds( pucTime : PAceChar;
                                            usLen : UNSIGNED16;
                                            pulMSeconds : PUNSIGNED32 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF LINUX}cdecl;{$ENDIF}

   function AdsSetFieldRaw( hObj : ADSHANDLE;
                            pucFldName : PAceChar;
                            pucBuf : PAceChar;
                            ulLen : UNSIGNED32 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF LINUX}cdecl;{$ENDIF}

   function AdsSetFlushFlag( hConnect: ADSHANDLE;
                             usFlushEveryUpdate: UNSIGNED16 ): UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF LINUX}cdecl;{$ENDIF}

   function AdsSetTimeStampRaw( hObj : ADSHANDLE;
                                pucFldName : PAceChar;
                                pucBuf : PAceChar;
                                ulLen : UNSIGNED32 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF LINUX}cdecl;{$ENDIF}

   function AdsActivateAOF( hTbl: ADSHANDLE ): UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF LINUX}cdecl;{$ENDIF}

   function AdsDeactivateAOF( hTbl: ADSHANDLE ): UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF LINUX}cdecl;{$ENDIF}

   function AdsExpressionLongToShort( hTbl         : ADSHANDLE;
                                      pucLongExpr  : PAceChar;
                                      pucShortExpr : PAceChar;
                                      pusLen       : pWord ) : UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF LINUX}cdecl;{$ENDIF}

   function AdsExpressionShortToLong( hTbl         : ADSHANDLE;
                                      pucShortExpr : PAceChar;
                                      pucLongExpr  : PAceChar;
                                      pusLen       : pWord ) : UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF LINUX}cdecl;{$ENDIF}

   function AdsExpressionLongToShort90( hTbl         : ADSHANDLE;
                                        pucLongExpr  : PAceChar;
                                        pucShortExpr : PAceChar;
                                        pulLen       : PUNSIGNED32 ) : UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF LINUX}cdecl;{$ENDIF}

   function AdsExpressionShortToLong90( hTbl         : ADSHANDLE;
                                        pucShortExpr : PAceChar;
                                        pucLongExpr  : PAceChar;
                                        pulLen       : PUNSIGNED32 ) : UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF LINUX}cdecl;{$ENDIF}

   function AdsClearRecordBuffer( hTbl   : ADSHANDLE;
                                  pucBuf : PAceChar;
                                  ulLen  : UNSIGNED32 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF LINUX}cdecl;{$ENDIF}

   function AdsStepIndexKey( hIndex : ADSHANDLE;
                             pucKey : PAceChar;
                             usLen : UNSIGNED16;
                             sDirection : SIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF LINUX}cdecl;{$ENDIF}

   function AdsGetIndexPageSize( hIndex: ADSHANDLE;
                                 pulPageSize: PUNSIGNED32 ): UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF LINUX}cdecl;{$ENDIF}

   function AdsSqlPeekStatement( hSQL: ADSHANDLE;
                                 pucIsLive : PAceChar ) : UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF LINUX}cdecl;{$ENDIF}

   function AdsGetSQLStmtParams( pucStatement : PAceChar ) : UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF LINUX}cdecl;{$ENDIF}

   function AdsGetNullRecord( hTbl   : ADSHANDLE;
                              pucBuf : PAceChar;
                              ulLen  : UNSIGNED32 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF LINUX}cdecl;{$ENDIF}

   function AdsSetProperty( hObj        : ADSHANDLE;
                            ulOperation : UNSIGNED32;
                            ulValue     : UNSIGNED32 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF LINUX}cdecl;{$ENDIF}

   function AdsGetColumnPermissions( hTbl           : ADSHANDLE;
                                     usFieldNum     : UNSIGNED16;
                                     pucPermissions : PAceChar ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF LINUX}cdecl;{$ENDIF}

   function AdsSetLastError( ulErrCode    : UNSIGNED32;
                             pucDetails   : PAceChar ) : UNSIGNED32;  {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF LINUX}cdecl;{$ENDIF}

   function AdsGotoBOF( hTbl : ADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF LINUX}cdecl;{$ENDIF}

   function AdsGotoEOF( hTbl : ADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF LINUX}cdecl;{$ENDIF}

   function AdsConvertDateToJulian( hConnect  : ADSHANDLE;
                                    pucDate : PAceChar;
                                    usLen    : UNSIGNED16;
                                    pdJulian : PDOUBLE ) : UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF LINUX}cdecl;{$ENDIF}

   function AdsAccessVfpSystemField( hTable      : ADSHANDLE;
                                     pucFldName  : PAceChar;
                                     pucRecBuf   : PAceChar;
                                     ulOptions   : UNSIGNED32;
                                     pusIsEmpty  : PUNSIGNED16 ) : UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF LINUX}cdecl;{$ENDIF}

implementation

function AdsGetSQLStmtParams; external ACE_LIB name 'AdsGetSQLStmtParams';
function AdsSqlPeekStatement; external ACE_LIB name 'AdsSqlPeekStatement';
function AdsGetIndexFlags; external ACE_LIB name 'AdsGetIndexFlags';
function AdsGetIndexOrderByHandle; external ACE_LIB name 'AdsGetIndexOrderByHandle';
function AdsGetNumSegments; external ACE_LIB name 'AdsGetNumSegments';
function AdsGetSegmentFieldname; external ACE_LIB name 'AdsGetSegmentFieldname';
function AdsDeleteTable; external ACE_LIB name 'AdsDeleteTable';
function AdsBuildKeyFromRecord; external ACE_LIB name 'AdsBuildKeyFromRecord';
function AdsConvertJulianToString; external ACE_LIB name 'AdsConvertJulianToString';
function AdsConvertStringToJulian; external ACE_LIB name 'AdsConvertStringToJulian';
function AdsConvertMillisecondsToString; external ACE_LIB name 'AdsConvertMillisecondsToString';
function AdsConvertStringToMilliseconds; external ACE_LIB name 'AdsConvertStringToMilliseconds';
function AdsSetFieldRaw; external ACE_LIB name 'AdsSetFieldRaw';
function AdsSetFlushFlag; external ACE_LIB name 'AdsSetFlushFlag';
function AdsSetTimeStampRaw; external ACE_LIB name 'AdsSetTimeStampRaw';
function AdsActivateAOF; external ACE_LIB name 'AdsActivateAOF';
function AdsDeactivateAOF; external ACE_LIB name 'AdsDeactivateAOF';
function AdsExpressionLongToShort; external ACE_LIB name 'AdsExpressionLongToShort';
function AdsExpressionShortToLong; external ACE_LIB name 'AdsExpressionShortToLong';
function AdsExpressionLongToShort90; external ACE_LIB name 'AdsExpressionLongToShort90';
function AdsExpressionShortToLong90; external ACE_LIB name 'AdsExpressionShortToLong90';
function AdsClearRecordBuffer; external ACE_LIB name 'AdsClearRecordBuffer';
function AdsStepIndexKey; external ACE_LIB name 'AdsStepIndexKey';
function AdsGetIndexPageSize; external ACE_LIB name 'AdsGetIndexPageSize';
function AdsGetNullRecord; external ACE_LIB name 'AdsGetNullRecord';
function AdsSetProperty; external ACE_LIB name 'AdsSetProperty';
function AdsGetColumnPermissions; external ACE_LIB name 'AdsGetColumnPermissions';
function AdsSetLastError; external ACE_LIB name 'AdsSetLastError';
function AdsGotoBOF; external ACE_LIB name 'AdsGotoBOF';
function AdsGotoEOF; external ACE_LIB name 'AdsGotoEOF';
function AdsConvertDateToJulian; external ACE_LIB name 'AdsConvertDateToJulian';
function AdsAccessVfpSystemField; external ACE_LIB name 'AdsAccessVfpSystemField';

end.

