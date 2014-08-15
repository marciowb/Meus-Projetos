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
////////////////////////////////////////////////////////////////////////////////
// Source File   : adsstrng.pas
// Date Created  : 1/1/96
// Description   : String utilities.
// Notes         :
////////////////////////////////////////////////////////////////////////////////
unit adsstrng;

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

interface

uses
{$ifdef WIN32}
   Windows,
   {$IFNDEF FPC}
   Messages,
   {$ENDIF}
{$endif}

{$ifdef LINUX}
   {$IFDEF FPC}
   LCLIntf,
   {$ENDIF}
{$endif}

   SysUtils,
   Classes;

   function FindReplace( cFind,
                         cReplace: Char;
                         strTarget: string ): string;

   function StrBeforeToken( strToken,
                            strTarget: string ): string;

   function StrAfterToken( strToken,
                           strTarget: string ): string;

   function AllTrim( strTarget: string ): string;

   function Pad( strTarget: string;
                 iStringLength: Integer;
                 cPadChar: Char ): string;

   procedure RemoveSubstr( strSubToRemove: string;
                           var strTarget: string );

   procedure StrToArray( strTarget: String;
                         pBuffer: Pointer;
                         iSizeBuffer: Integer );

   function DOW( TheDate: TDateTime ): string;

   procedure BinToStr( pBuffer: Pointer;
                       iSizeBuffer: Integer;
                       var strResult: String );

   procedure NonNullCopy( var pucDest: PChar;
                          pucSource : PChar;
                          iOffset,
                          iLength : integer ) ;

   function EmptyString( pucSource: PChar;
                         iLength : integer ) : Boolean ;

implementation

{* use Libc for a memset operation. *}
{$ifdef LINUX }
uses
   Libc;
{$endif}


procedure BinToStr( pBuffer: Pointer;
                    iSizeBuffer: Integer;
                    var strResult: String );
type
   TArray = packed array[0..4095] of Byte;
var
   i: Integer;
begin
   for i := 0 to iSizeBuffer - 1 do
      strResult := strResult + IntToStr( TArray( pBuffer^ )[i] ) + '.';
   //remove the last uneeded '.'
   Delete( strResult, Length( strResult ), 1 );

end;



procedure StrToArray( strTarget: String;
                      pBuffer: Pointer;
                      iSizeBuffer: Integer );
type
   TArray = packed array[0..4095] of Byte;

var
   ii: Integer;
begin
   //Init the array.
   {$ifdef WIN32}
   ZeroMemory( pBuffer, iSizeBuffer );
   {$else}
   memset( pBuffer, 0, iSizeBuffer );
   {$endif}

   //convert
   for ii := 0 to Length( strTarget ) - 1 do
      TArray( pBuffer^ )[ii] := Byte( strTarget[ii + 1] );
end;




//this function does a search and replace
function FindReplace( cFind,
                      cReplace:Char;
                      strTarget:String ): string;
begin
   while Pos( cFind, strTarget ) > 0 do
   strTarget[ Pos( cFind, strTarget ) ] := cReplace;
   result := strTarget;
end;


procedure RemoveSubstr( strSubToRemove: string;
                        var strTarget: string );
begin
   while Pos( strSubToRemove, strTarget ) > 0 do
      Delete( strTarget,
              Pos( strSubToRemove, strTarget ),
              Length( strSubToRemove ) );
end;


function StrBeforeToken( strToken,
                         strTarget: string ): string;
var
   iTokenPos: Integer;
begin
   iTokenPos := Pos( strToken, strTarget );
   result := Copy( strTarget, 0, iTokenPos - 1 );
end;


function StrAfterToken( strToken,
                        strTarget: string ): string;
var
   iTokenPos:Integer;
begin
   iTokenPos := Pos( strToken, strTarget );
   result := Copy( strTarget,
                   iTokenPos + 1,
                   Length( strTarget ) );
end;



function AllTrim( strTarget: string ): string;
var
  ii: Integer;
  bFinished: boolean;
begin

   //Remove spaces from front of string.
   for ii := 1 to Length( strTarget ) do
   begin
      while strTarget[ii] = ' ' do
         Delete( strTarget, ii, 1 );
      break;
   end;


   //Remove spaces from end of string.
   bFinished := false;
   while not bFinished do
   begin
      ii := Length( strTarget );
      if strTarget[ii] = ' ' then
         Delete( strTarget, ii, 1 )
      else
         bFinished := true;
   end;

  result := strTarget;
end;


function Pad( strTarget: string;
              iStringLength: Integer;
              cPadChar: Char ): string;
var
   ii: Integer;
begin
   Result := strTarget;
   if Length( strTarget ) < iStringLength then
   for ii := 0 to ( Length( strTarget ) - iStringLength ) - 1 do
      result := result + cPadChar;
end;


function DOW( TheDate: TDateTime ):String;
var
   iDayInteger: Integer;
begin
   iDayInteger := DayOfWeek( TheDate );

   Case iDayInteger of
      1: DOW := 'Sunday';
      2: DOW := 'Monday';
      3: DOW := 'Tuesday';
      4: DOW := 'Wednesday';
      5: DOW := 'Thursday';
      6: DOW := 'Friday';
      7: DOW := 'Saturday';
   else
      DOW := 'Error';
   end;//case
end;


procedure NonNullCopy( var pucDest : PChar;
                       pucSource : PChar;
                       iOffset,
                       iLength : integer ) ;
var
   ii : integer ;
begin
   for ii := 0 to iLength - 1 do
      pucDest[ iOffset + ii ] := pucSource[ii] ;
end;



function EmptyString( pucSource : PChar;
                      iLength : integer ) : Boolean ;
var
   ii : integer ;
begin
   result := True ;
   for ii := 0 to iLength - 1 do
   begin
      if pucSource[ii] <> ' ' then
      begin
         result := False ;
         exit;
      end;
   end;
end;

end.
