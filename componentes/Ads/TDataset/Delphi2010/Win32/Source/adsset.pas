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
* Source File :  adsset.pas
* Description :  Implementation of class for ACESettings component
* Notes       :
*******************************************************************************}
unit adsset;

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
   {$IFNDEF FPC}
   Windows,
   Messages,
   {$ENDIF}
{$endif}

   {$IFDEF FPC}
   LCLIntf,
   {$ENDIF}
   SysUtils,
   Classes,
   ace;

type

   TAdsServerType = ( stADS_REMOTE, stADS_LOCAL, stADS_AIS );
   TAdsServerTypes = set of TAdsServerType;

   {* this class is to raise exceptions on ACE API errors--the extra dummy
    * variable is necessary since the VCL has one class memober to exeption
    * that has the same parameters (one longint) *}
   AdsError = class(Exception)
   public
   constructor Create( ulRetCode:  LongInt;
                       unusedvar : boolean );
   end;  {* AdsError *}


   {* Class for errors in the AdsSettings component *}
   AdsSettingsError = class(Exception)
   public
      constructor Create( acMsg:  String );
   end;  {* AdsSettingsError *}


   {* AdsSettings component declaration *}
   TAdsSettings = class(TComponent)
   protected
      {* Storage for properties *}
      FDateFormat:            String;
      FNumDecimals:           ShortInt;
      FShowDeleted:           Boolean;
      FAdsServerTypes:        TAdsServerTypes;
      FNumCachedTables:       Word;
      FNumCachedCursors:      Word;
      FSavedDelphiDateFormat: String;
      FSetDelphiDate:         Boolean;

      {* Property accessors *}
      function GetDateFormat:  String; virtual;
      procedure SetDateFormat( strDate:  String ); virtual;
      procedure SetNumDecimals( usNewDecimals:  ShortInt ); virtual;
      procedure SetShowDeleted( bShowDeleted:  Boolean ); virtual;

      function GetLastError:  LongInt; virtual;
      function GetNumOpenTables:  SmallInt; virtual;
      procedure SetAdsServerTypes( Value: TAdsServerTypes ); virtual;
      procedure SetNumCachedTables( Value : Word ); virtual;
      procedure SetNumCachedCursors( Value : Word ); virtual;
      procedure SetFSetDelphiDate( Value : boolean ); virtual;

   public
      {* constuctor/destructor for this component *}
      constructor Create( Owner:  TComponent ); override;
      destructor Destroy; override;

      {* runtime properties *}
      property LastError:  LongInt read GetLastError;
      property NumOpenTables:  SmallInt read GetNumOpenTables;

   published
      {* design time properties *}
      property DateFormat:  String read GetDateFormat write SetDateFormat;
      property NumDecimals:  ShortInt read FNumDecimals write SetNumDecimals default 2;
      property SetDelphiDate: Boolean read FSetDelphiDate write SetFSetDelphiDate default True;
      property ShowDeleted:  Boolean read FShowDeleted write SetShowDeleted default True;
      property AdsServerTypes: TAdsServerTypes read FAdsServerTypes write SetAdsServerTypes default [stADS_REMOTE, stADS_AIS];
      property NumCachedTables: Word read FNumCachedTables write SetNumCachedTables default 0;
      property NumCachedCursors: Word read FNumCachedCursors write SetNumCachedCursors default 25;

  end;   {* TAdsSettings *}


var
   {* store the reference to the settings object if the user created one *}
   goAdsSettings : TAdsSettings;
   {$IFDEF WIN32}
   ShowMessageProc : procedure ( const str : string );
   {$ENDIF}
   {$IFDEF LINUX}
   {$IFDEF FPC}
     ShowMessageProc : procedure ( const str : string );
   {$Else}
     ShowMessageProc : procedure ( const str : widestring );
   {$ENDIF}
   {$ENDIF}

implementation

uses
{$IFDEF ADSDELPHI4_OR_NEWER}
   SyncObjs;
{$else}
   AdsAEPSessionMgr;
{$endif}

var
   {* There can only be one settings component. This variable is initialized
    * to zero and maintained in the constructor. *}
   gulNumSettings    : UNSIGNED32;
   goNumSettingsSync : TCriticalSection;


{*******************************************************************************
*  Module         :  TAdsSettings::SetAdsServerTypes
*  Parameters     :
*  Description    :  Sets the server type
*  Notes          :
*******************************************************************************}
procedure TAdsSettings.SetAdsServerTypes( Value: TAdsServerTypes );
var
   usOption : UNSIGNED16;
   ulRetVal : UNSIGNED32;
   stHold : TAdsServerTypes;
begin
   if( FAdsServerTypes <> Value ) then
   begin
      stHold := FAdsServerTypes;
      FAdsServerTypes := Value;

      usOption := 0;

      if stADS_REMOTE in FAdsServerTypes then
         usOption := usOption or ADS_REMOTE_SERVER;

      if stADS_LOCAL in FAdsServerTypes then
         usOption := usOption or ADS_LOCAL_SERVER;

      if stADS_AIS in FAdsServerTypes then
         usOption := usOption or ADS_AIS_SERVER;

      if( usOption = 0 ) then
      begin
         if ( stHold = [] ) then
            FAdsServerTypes := [stADS_REMOTE]
         else
            FAdsServerTypes := stHold;
         raise AdsSettingsError.Create( 'At least one server type must be selected.' );
      end;

      ulRetVal := ACE.AdsSetServerType( usOption );
      if( ulRetVal <> AE_SUCCESS ) then
      begin
         if ( stHold = [] ) then
            FAdsServerTypes := [stADS_REMOTE]
         else
            FAdsServerTypes := stHold;
         raise AdsError.Create( ulRetVal, TRUE );
      end;
   end;
end;



{*******************************************************************************
*  Module:        :  TAdsSettings.SetNumCachedTables
*  Parameters     :  Value - number of tables for ACE to cache
*  Returns        :
*  Description    :
*******************************************************************************}
procedure TAdsSettings.SetNumCachedTables( Value : Word );
var
   ulRetVal : UNSIGNED32;
begin

   if ( FNumCachedTables <> Value ) then
   begin
      FNumCachedTables := Value;

      ulRetVal := ACE.AdsCacheOpenTables( Value );
      if ( ulRetVal <> AE_SUCCESS ) then
         raise AdsError.Create( ulRetVal, TRUE );
   end;

end;   {* TAdsSettings.SetNumCachedTables *}



{*******************************************************************************
*  Module:        :  TAdsSettings.SetNumCachedCursors
*  Parameters     :  Value - number of cursors for ASA to cache
*  Returns        :
*  Description    :
*******************************************************************************}
procedure TAdsSettings.SetNumCachedCursors( Value : Word );
var
   ulRetVal : UNSIGNED32;
begin

   if ( FNumCachedCursors <> Value ) then
   begin
      FNumCachedCursors := Value;

      ulRetVal := ACE.AdsCacheOpenCursors( Value );
      if ( ulRetVal <> AE_SUCCESS ) then
         raise AdsError.Create( ulRetVal, TRUE );
   end;

end;   {* TAdsSettings.SetNumCachedCursors *}


{* AdsError exeption handler class implementation *}

{*******************************************************************************
*  Module:        :  AdsError.Create
*  Parameters     :  ulRetCode - Ads error code
*  Returns        :  void
*  Description    :
*******************************************************************************}
constructor AdsError.Create( ulRetCode:  LongInt;
                             unusedvar : boolean );
var   aucErrMsg:  Array[0..ADS_MAX_ERROR_LEN] of AceChar;
      usErrLen:   Word;
      ulRetVal:   LongInt;
begin
   if unusedvar then
      usErrLen := ADS_MAX_ERROR_LEN
   else
      usErrLen := ADS_MAX_ERROR_LEN;

   ulRetVal := ACE.AdsGetErrorString( ulRetCode, @aucErrMsg, @usErrLen );
   if ( ulRetVal <> AE_SUCCESS ) then
      ACE.AdsShowError( 'Ads Exception Error' )
   else
      Message := string( StrPas( PAnsiChar( @aucErrMsg ) ) );
end;  {* AdsError::Create *}



{* AdsSettingsError exeption handler class implementation *}

{*******************************************************************************
*  Module:        :  AdsSettingsError.Create
*  Parameters     :  Msg - Error message
*  Returns        :  void
*  Description    :
*******************************************************************************}
constructor AdsSettingsError.Create( acMsg:  String );
begin
   Message := acMsg;
end;  {* AdsSettingsError::Create *}


{* TAdsSettings class implementation *}

{*******************************************************************************
*  Module         :  TAdsSettings::Create
*  Parameters     :  None
*  Description    :  Constructor for this component, initializes to Ads Default
*                    settings.
*  Notes          :  Datemask is set to no Century, for better Delphi
*                    compatiblity
*******************************************************************************}
constructor TAdsSettings.Create(Owner: TComponent);
var   ulRetVal      : LongInt;
      usDeleted     : Word;
      strDateFormat : String;
begin
   inherited Create(Owner);             { Initialize inherited parts }

   {* Enter critical section *}
   goNumSettingsSync.enter;
   try
      gulNumSettings := gulNumSettings + 1;
      {* make sure there isn't already a settings component in the app *}
      if ( gulNumSettings > 1 ) and
         not ( csDesigning in ComponentState ) then
         raise Exception.Create(
            'Only one AdsSettings component is allowed per application' );
   finally
      goNumSettingsSync.leave;
   end;

   {* Initialize Ads settings to their defaults *}
   FSetDelphiDate := TRUE;

   {*
    * NOTE: If these defaults ever change there is a note in ctask.h
    * reminding the developer to change these hard-coded values as well
    * as the ACE constants.
    *}
   SetNumCachedTables( 0 );
   SetNumCachedCursors( 25 );

   {* Get Delphi's date format (which it got from the OS) *}
{$IFDEF ADSDELPHIXE_OR_NEWER}
   strDateFormat := FormatSettings.ShortDateFormat;
{$ELSE}
   strDateFormat := ShortDateFormat;
{$ENDIF}

   {*
    * Try to set the ACE date format, if this works then we're set. If it doesn't
    * then default to 'MM/DD/CCYY'.
    *}
   ulRetVal := ACE.AdsSetDateFormat( PAceChar( AnsiString( strDateFormat ) ) );
   if ( ulRetVAl <> AE_SUCCESS ) then
   begin
      {* NOTE: The M is intentional, as m means minutes in some cases, and we
       * don't want that. *}
      strDateFormat := 'MM/dd/ccyy';
      ulRetVal := ACE.AdsSetDateFormat( PAceChar( AnsiString( strDateFormat ) ) );
      if ( ulRetVal <> AE_SUCCESS ) then
         raise AdsError.Create( ulRetVal, TRUE );
   end;

   FDateFormat := strDateFormat;

   {* Get Ads's decimals setting *}
   ulRetVal := ACE.AdsGetDecimals( @FNumDecimals );
   if ( ulRetVal <> AE_SUCCESS ) then
      raise AdsError.Create( ulRetVal, TRUE );

   {* Get the deleted flag setting *}
   ulRetVal := ACE.AdsGetDeleted( @usDeleted );
   if ( ulRetVal <> AE_SUCCESS ) then
      raise AdsError.Create( ulRetVal, TRUE );
   if ( usDeleted > 0 ) then
      FShowDeleted := TRUE
   else
      FShowDeleted := FALSE;

   {* Create the sub-property object *}
   SetAdsServerTypes( [ stADS_REMOTE, stADS_AIS ] );

   {* reference this instance in the global *}
   goAdsSettings := self;


end;  {* TAdsSettings::Create *}



{*******************************************************************************
*  Module         :  TAdsSettings::Destroy
*  Parameters     :
*  Description    :
*  Notes          :
*******************************************************************************}
destructor TAdsSettings.Destroy;
begin
   if assigned( goNumSettingsSync ) then
   begin

      {* Enter critical section *}
      goNumSettingsSync.enter;
      try
         gulNumSettings := gulNumSettings - 1;
      finally
         goNumSettingsSync.leave;
      end;
   end;

   inherited Destroy;
end;  {* TAdsSettings::Destroy *}



{*******************************************************************************
*  Module         :  TAdsSettings::GetDateFormat
*  Parameters     :
*  Returns        :  Current Date format in use by Ads
*  Description    :
*  Notes          :
*******************************************************************************}
function TAdsSettings.GetDateFormat:  String;
begin
   Result := FDateFormat;
end;  {* TAdsSettings::GetDateFormat *}



{*******************************************************************************
*  Module         :  TAdsSettings::SetDateFormat
*  Parameters     :  aucDate - new date format to set
*  Description    :
*  Notes          :
*******************************************************************************}
procedure TAdsSettings.SetDateFormat( strDate:  String );
var   ulRetVal:  LongInt;
      usIndex:   SmallInt;
      aucAdsPtr:  Array[1..ADS_MAX_DATEMASK] of AceChar;
begin
   {* cannot allow a blank string *}
   if ( strDate = '' ) then
      {* NOTE: The M is intentional, as m means minutes in some cases, and we
       * don't want that. *}
      strDate := 'MM/dd/ccyy';

   StrPLCopy( @aucAdsPtr, AnsiString( strDate ), SizeOf(aucAdsPtr)-1 );
   ulRetVal := ACE.AdsSetDateFormat( @aucAdsPtr );
   if ( ulRetVal <> AE_SUCCESS ) then
      raise AdsError.Create( ulRetVal, TRUE );

   FDateFormat := strDate;
   {*
    * I don't think a component should be messing with the
    * users Delphi global. There may be apps written that rely on this setting
    * of ShortDateFormat, however, so we can't remove this call. If the user changed
    * the FSetDelphiDate to FALSE then we won't set it.
    *}
   if ( FSetDelphiDate = TRUE ) then
   begin
      for usIndex := 1 to Length( strDate ) do
      begin
         if ( UpperCase( strDate[usIndex] ) = 'C' ) then
            strDate[usIndex] := 'y';
         if ( UpperCase( strDate[usIndex] ) = 'Y' ) then
            strDate[usIndex] := 'y';
      end;

{$IFDEF ADSDELPHIXE_OR_NEWER}
      FSavedDelphiDateFormat := FormatSettings.ShortDateFormat;
      FormatSettings.ShortDateFormat := strDate;
{$ELSE}
      FSavedDelphiDateFormat := ShortDateFormat;
      ShortDateFormat := strDate;
{$ENDIF}

      {*
       * Get the date separator. It isn't
       * possible to set the separator as an empty char, so formats like
       * CCYYMMDD will not work if handled with the AsString method. Search
       * for the last non-'C', 'Y', 'M', or 'D' character and set that as the separator.
       * It is possible in delphi to use any character you want (even numerics).
       *}
      for usIndex := 1 to Length( strDate ) do
      begin
         if ( UpperCase( strDate[usIndex] ) <> 'C' ) and
            ( UpperCase( strDate[usIndex] ) <> 'Y' ) and
            ( UpperCase( strDate[usIndex] ) <> 'M' ) and
            ( UpperCase( strDate[usIndex] ) <> 'D' ) then
         begin
{$IFDEF ADSDELPHIXE_OR_NEWER}
            FormatSettings.DateSeparator := strDate[usIndex];
{$ELSE}
            DateSeparator := strDate[usIndex];
{$ENDIF}
            break;
         end;

      end;
   end;

end;  {* TAdsSettings::SetDateFormat *}



{*******************************************************************************
*  Module         :  TAdsSettings::SetNumDecimals
*  Parameters     :
*  Returns        :
*  Description    :
*  Notes          :
*******************************************************************************}
procedure TAdsSettings.SetNumDecimals( usNewDecimals:  ShortInt );
var   ulRetVal:  LongInt;
begin
   ulRetVal := ACE.AdsSetDecimals( usNewDecimals );
   if ( ulRetVal <> AE_SUCCESS ) then
      raise AdsError.Create( ulRetVal, TRUE );

   {* update the component on success *}
   FNumDecimals := usNewDecimals;
end;  {* TAdsSettings::SetNumDecimals *}



{*******************************************************************************
*  Module         :  TAdsSettings::SetFSetDelphiDate
*  Parameters     :
*  Returns        :
*  Description    :
*  Notes          :
*******************************************************************************}
procedure TAdsSettings.SetFSetDelphiDate( Value : boolean );
begin
   {* ShortDateFormat was saved an overwritten in the constructor, before
    * we started reading the properties from the form. If this property
    * was FALSE, then set the Delphi ShortDateFormat back to what it was
    * before our constructor changed it. *}
   if not Value then
      if ( csReading in ComponentState ) then
{$IFDEF ADSDELPHIXE_OR_NEWER}
         FormatSettings.ShortDateFormat := FSavedDelphiDateFormat;
{$ELSE}
         ShortDateFormat := FSavedDelphiDateFormat;
{$ENDIF}

   FSetDelphiDate := Value;
end;



{*******************************************************************************
*  Module         :  TAdsSettings::SetShowDeleted
*  Parameters     :
*  Returns        :
*  Description    :
*  Notes          :
*******************************************************************************}
procedure TAdsSettings.SetShowDeleted( bShowDeleted:  Boolean );
var   ulRetVal:  LongInt;
      usShowDeleted:  Word;
begin
   usShowDeleted := Word( bShowDeleted );
   ulRetVal := ACE.AdsShowDeleted( usShowDeleted );
   if ( ulRetVal <> AE_SUCCESS ) then
      raise AdsError.Create( ulRetVal, TRUE );

   FShowDeleted := bShowDeleted;

end;  {* TAdsSettings::SetShowDeleted *}



{*******************************************************************************
*  Module         :  TAdsSettings::GetLastError
*  Parameters     :  None
*  Returns        :  Last Ads error code
*  Description    :  Returns last Ads error that occured
*  Notes          :
*******************************************************************************}
function TAdsSettings.GetLastError:  LongInt;
var   ulRetVal:  LongInt;
      usBufLen:  ShortInt;
begin
   usBufLen := 0;
   ACE.AdsGetLastError( @ulRetVal, NIL, @usBufLen );
   Result := ulRetVal;
end;


{*******************************************************************************
*  Module         :  TAdsSettings::GetNumOpenTables
*  Parameters     :  none
*  Returns        :  Number of open tables in this task
*  Description    :  Gets Number of tables Ads has open
*  Notes          :
*******************************************************************************}
function TAdsSettings.GetNumOpenTables:  SmallInt;
var   ulRetVal:  LongInt;
      usNumTables:  ShortInt;
begin
   ulRetVal := ACE.AdsGetNumOpenTables( @usNumTables );
   if ( ulRetVal <> AE_SUCCESS ) then
      raise AdsError.Create( ulRetVal, TRUE );

   Result := usNumTables;
end;

{$IFNDEF ADSDELPHI5_OR_NEWER}
procedure FreeAndNil(var Obj);
var
  P: TObject;
begin
  P := TObject(Obj);
  TObject(Obj) := nil;  // clear the reference before destroying the object
  P.Free;
end;
{$ENDIF}

initialization
   gulNumSettings := 0;
   goNumSettingsSync := TCriticalSection.Create;
   goAdsSettings := nil;

finalization
   FreeAndNil( goNumSettingsSync );

end.

