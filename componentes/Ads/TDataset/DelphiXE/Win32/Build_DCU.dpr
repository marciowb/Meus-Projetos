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
* Source File : Build_DCU.dpr
* Description : This is a simple "shim" for the compilation of all Advantage .dcu
*               files during TDataSet installation on Windows versions with UAC
*               enabled.
* Notes       :
*******************************************************************************}

program Build_DCU;

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

uses
  Windows,
  Messages,
  SysUtils,
{$IFDEF ADSDELPHI6_OR_NEWER}
  Variants,
{$ENDIF}
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  AdsEventHandler,
  AdsBatchMove,
  adsset,
  adsdictionary,
  adstable,
  DB,
  adsdata,
  adsfunc,
  adscnnct,
  AdsAEPSessionMgr,
  adsparam,
  adsstrng,
  adsver,
  CollationPicker,
  indexdlg,
  infoexp,
  infostru;


begin
  try
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
