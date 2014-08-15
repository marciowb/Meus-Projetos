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
* Source File : CollationPicker.pas
* Description : This unit contains the Advantage Collation String Generator
* Notes       :
*******************************************************************************}
unit CollationPicker;

{$IFDEF FPC}
   {$MODE DELPHI}{$H+}
{$ENDIF}

{* Override any compiler directives we don't want, but that that user might have
 * defined in their project. *}
{$T-}   // turns off typed @ operator
{$B-}   // use short-circuit boolean expressions
{$R-}   // no range checking
{$V-}   // no var-string checking

interface

uses
{$INCLUDE versions.inc}

{$ifdef WIN32}
  {$IFNDEF FPC}
    Windows,
    Messages,
  {$ENDIF}
  SysUtils,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  StdCtrls,
{$endif}

{$IFDEF FPC}
  LResources,
{$ENDIF}

{$ifdef LINUX}
{$IFNDEF FPC}
  QGraphics,
  QControls,
  QForms,
  QDialogs,
  QStdCtrls,
{$ELSE}
  Graphics,
  Forms,
  Dialogs,
  StdCtrls,
  Controls,
  SysUtils,
{$ENDIF}
{$endif}
  Classes,
  adsdata,
  ace;

type
  TCollationPicker = class(TForm)
    comboCharType: TComboBox;
    Label1: TLabel;
    btnOK: TButton;
    btnCancel: TButton;
    comboLocale: TComboBox;
    Label2: TLabel;
    cbCaseInsensitive: TCheckBox;

    procedure btnCancelClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure LoadCharType;
    procedure LoadLocales;
{$IFDEF WIN32}
{$IFDEF ADSDELPHI5_OR_NEWER}
    procedure LoadLastUsedSettings;
    procedure SaveSettings;
{$ENDIF}
{$ENDIF}
    procedure comboLocaleChange(Sender: TObject);

  private
    { Private declarations }
    iTableType     : Integer;

  public
    { Public declarations }
    strCollation : String;  { This is the result }

    constructor Create( AOwner : TComponent;
                        TableType : UNSIGNED16 ); reintroduce;
    procedure SetExistingValues( strCollation : string );
  end;

implementation

{$IFDEF WIN32}
{$IFDEF ADSDELPHI5_OR_NEWER}
uses
   Registry;
{$ENDIF}
{$endif}

{$IFNDEF FPC}
   {$R *.dfm}
{$ENDIF}

type
  TStringOption = ( soCASE_INSENSITIVE );
  TStringOptions = set of TStringOption;
  TRemoveSubOption = ( roREMOVE_FIRST,
                           roREMOVE_ALL );

{**********************************************************
*  Module: TCollationPicker.btnCancelClick
*  Description: Cancel updates and close the form
**********************************************************}
procedure TCollationPicker.btnCancelClick(Sender: TObject);
begin
  strCollation := '';
end;

{**********************************************************
*  Module: TCollationPicker.btnOKClick
*  Description: Construct & return ADSCollation String and
*               save components for next launch of form.
**********************************************************}
procedure TCollationPicker.btnOKClick(Sender: TObject);
begin
  if comboLocale.Text = '' then
    strCollation := comboCharType.Text
  else
  begin
     if ( cbCaseInsensitive.Checked ) and ( cbCaseInsensitive.Enabled ) then
        strCollation := comboCharType.Text + ':' + comboLocale.Text + '_ADS_CI'
     else
        strCollation := comboCharType.Text + ':' + comboLocale.Text;
  end;

  // Now we also need to save the settings for the next run.
{$IFDEF WIN32}
{$IFDEF ADSDELPHI5_OR_NEWER}
  SaveSettings();
{$ENDIF}
{$ENDIF}
end;


{**********************************************************
*  Module: TCollationPicker.comboLocaleChange
*  Description: Toggle the "enabled" state of the "Unicode
*               Case Sensitive" checkbox based on the Locale
*               selected (if appropriate.
**********************************************************}
procedure TCollationPicker.comboLocaleChange(Sender: TObject);
begin
   if ( comboLocale.Text = '' ) or ( comboLocale.Text = 'ads_ascii' ) then
      cbCaseInsensitive.Enabled := False
   else
      cbCaseInsensitive.Enabled := True;
end;


{**********************************************************
*  Module: TCollationPicker.LoadCharType
*  Description: Load the Character Type combobox
**********************************************************}
procedure TCollationPicker.LoadCharType();
var
  iMaxLoad : Integer;
  i        : Integer;
begin
  comboCharType.Items.Clear;

  if (( iTableType = ADS_NTX ) or ( iTableType = ADS_CDX )) then
    iMaxLoad := 2
  else
    iMaxLoad := ADS_MAX_CHAR_SETS;

  for i := 0 to iMaxLoad - 1 do
    comboCharType.Items.Add( TAdsCharTypeMap[i] );
end;


{**********************************************************
*  Module: TCollationPicker.LoadLocales
*  Description: Load the Unicode Locale combobox
**********************************************************}
procedure TCollationPicker.LoadLocales();
var
  i        : Integer;
begin
  {*
   * We need to add an empty string to the drop-down, as a user should be able
   * to select a table language with no Locale (adding the empty selection
   * enables a user to clear a previously-set locale).
   *}
  comboLocale.Items.Add( '' );
  for i := 0 to ADS_MAX_UNICODE_LOCALES - 1 do
  begin
    comboLocale.Items.Add( TAdsUnicodeLocales[i] );
  end;
end;


// Some utility functions. Also in arc\sutils.pas, but didn't want the TDataSet
// Descendant to require that unit.
function RemoveSubstr( strSubToRemove,
                       strTarget: string;
                       RemoveOption: TRemoveSubOption;
                       setOptions: TStringOptions ): string;
begin
   if( soCASE_INSENSITIVE in setOptions ) then
   begin
      if RemoveOption = roREMOVE_ALL then
         while Pos( UpperCase( strSubToRemove ), UpperCase( strTarget ) ) > 0 do
            Delete( strTarget,
                    Pos( UpperCase( strSubToRemove ), UpperCase( strTarget ) ),
                    Length( strSubToRemove ) )
      else
         if Pos( UpperCase( strSubToRemove ), UpperCase( strTarget ) ) > 0 then
            Delete( strTarget,
                    Pos( UpperCase( strSubToRemove ), UpperCase( strTarget ) ),
                    Length( strSubToRemove ) );
      Result := strTarget;
   end

   else
   begin
      if RemoveOption = roREMOVE_ALL then
         while Pos( strSubToRemove, strTarget ) > 0 do
            Delete( strTarget,
                    Pos( strSubToRemove, strTarget ),
                    Length( strSubToRemove ) )
      else
         if Pos( strSubToRemove, strTarget ) > 0 then
            Delete( strTarget,
                    Pos( strSubToRemove, strTarget ),
                    Length( strSubToRemove ) );
      Result := strTarget;
   end
end;

function StrBeforeToken( strToken,
                         strTarget: string;
                         setOptions: TStringOptions ): string;
var
   iTokenPos: Integer;
begin
   if( soCASE_INSENSITIVE in setOptions ) then
      iTokenPos := Pos( UpperCase( strToken ), UpperCase( strTarget ) )
   else
      iTokenPos := Pos( strToken, strTarget );

   result := Copy( strTarget, 0, iTokenPos - 1 );
end;


procedure StrToList( strDelimiter: string;
                     strSource: string;
                     TargetList: TStrings );
begin
   while Pos( strDelimiter, strSource ) <> 0 do
   begin
      TargetList.Add( StrBeforeToken( strDelimiter, strSource, [] ) );
      strSource := RemoveSubStr( StrBeforeToken( strDelimiter, strSource, [] ) + strDelimiter,
                                 strSource,
                                 roREMOVE_FIRST,
                                 [] );
   end;
   if( Trim( strSource ) <> '' ) then
      TargetList.Add( Trim( strSource ) );
end;

function EndsWith( strBuffer : string; strEnds : string ) : boolean;
var
   iLen1 : integer;
   iLen2 : integer;
begin
   Result := false;
   iLen1 := Length( strBuffer );
   iLen2 := Length( strEnds );

   if ( iLen2 > iLen1 ) then
      exit;

   Delete( strBuffer, 1, iLen1 - iLen2 );

   if ( UpperCase( strBuffer ) = UpperCase( strEnds ) ) then
      Result := true;
end;


{**********************************************************
*  Module: TCollationPicker.SetExistingValues
*  Description: Take a free-form string representation of
*  the collation and strip it into its individual parts
*  and set the combo box text values accordingly. Can be
*  used to initialize the combox for an object that
*  already has a collation.
**********************************************************}
procedure TCollationPicker.SetExistingValues( strCollation : string );
var
   oParts : TStringList;
begin
   // If nothing at all, then just use the "last values" we read from the registry.
   if strCollation = '' then
      exit;

   // split into parts, either one or two if split by :
   oParts := TStringList.Create;
   try
      StrToList( ':', strCollation, oParts );

      // Clear these, as the load from the registry might have set them and
      // we don't want those values.
      cbCaseInsensitive.Enabled := false;
      cbCaseInsensitive.Checked := false;

      // For now, only expect 1 or 2 parts
      if ( ( oParts.Count < 1 ) or ( oParts.Count > 2 ) ) then
         raise Exception.Create( 'Unexpected starting values in SetExistingValues: ' + strCollation );

      // Set the comboCharType value no matter what
      comboCharType.ItemIndex := comboCharType.Items.IndexOf( oParts[0] );

      // If unicode locale is given, set it too
      if ( oParts.Count > 1 ) then
      begin
         // Enable the case insensitive checkbox for unicode, but not if 'ads_ascii',
         // which doesn't support case insensitive.
         if ( UpperCase( oParts[1] ) <> 'ADS_ASCII' ) then
         begin
            cbCaseInsensitive.Enabled := true;

            // See if it ends with _ADS_CI, in which case we need to set up the case insensitive checkbox
            if EndsWith( oParts[1], '_ADS_CI' ) then
            begin
               cbCaseInsensitive.Checked := true;

               // Strip off _ADS_CI before setting text in the combo box
               oParts[1] := RemoveSubStr( '_ADS_CI', oParts[1], roREMOVE_FIRST, [soCASE_INSENSITIVE] );
            end;
         end;

         comboLocale.ItemIndex := comboLocale.Items.IndexOf( oParts[1] );
      end
      else
         // Clear it out, as they did not have one set in the past
         comboLocale.ItemIndex := -1;
   finally
      oParts.Free;
   end;

end;


{**********************************************************
*  Module: TCollationPicker.LoadLastUsedSettings
*  Description: Retrieve the last-used settings from the
*               registry and set the appropriate ItemIndex
*               properties of the Locale/CharSet comboboxes
**********************************************************}
{$IFDEF WIN32}
{$IFDEF ADSDELPHI5_OR_NEWER}
procedure TCollationPicker.LoadLastUsedSettings();
var
  oReg             : TRegistry;
  strCharType      : String;
  strLocale        : String;
  strCaseInsensitive : String;
begin
  strCharType := '';
  strLocale := '';

  oReg := TRegistry.Create();
  try  {finally}
    try
       oReg.Access := KEY_READ;
       oReg.RootKey := HKEY_CURRENT_USER;

       oReg.OpenKey( '\Software\Advantage Collations\' + IntToStr( iTableType ),
                      True );
       strCharType := oReg.ReadString( 'CharType' );
       strLocale := oReg.ReadString( 'Locale' );
       strCaseInsensitive := oReg.ReadString( 'CaseInsensitive' );
       oReg.CloseKey;
    except
       on E: ERegistryException do
         begin
            strCharType := '';
            strLocale := '';
            strCaseInsensitive := '';
         end;
    end;

  finally
    oReg.Free;
  end;

  if strChartype = '' then
    // Set the default CharType to ANSI -- and that's all
    comboCharType.ItemIndex := 0
  else
    comboCharType.ItemIndex := comboCharType.Items.IndexOf( strCharType );

  if strLocale <> '' then
    comboLocale.ItemIndex := comboLocale.Items.IndexOf( strLocale );

  if strCaseInsensitive = 'true' then
    cbCaseInsensitive.Checked := true
  else
    // Treat anything else as false
    cbCaseInsensitive.Checked := false;

end;


{**********************************************************
*  Module: TCollationPicker.SaveSettings
*  Description: Save all settings for the next execution of the form.
**********************************************************}
procedure TCollationPicker.SaveSettings();
var
  oReg  : TRegistry;
begin

  oReg := TRegistry.Create();
  try  { finally }
     try  { except }
        oReg.Access := KEY_WRITE;
        oReg.RootKey := HKEY_CURRENT_USER;

        oReg.OpenKey( 'Software\Advantage Collations\' + IntToStr( iTableType ),
                      True );
        oReg.WriteString( 'CharType', comboCharType.Text );
        oReg.WriteString( 'Locale', comboLocale.Text );

        if ( ( cbCaseInsensitive.Checked ) and ( cbCaseInsensitive.Enabled ) ) then
           oReg.WriteString( 'CaseInsensitive', 'true' )
        else
           oReg.WriteString( 'CaseInsensitive', 'false' );

        oReg.CloseKey;
     except
        on E: ERegistryException do oReg.CloseKey;
     end;
  finally
    oReg.Free;
  end;

end;
{$ENDIF}
{$ENDIF} // {$IFDEF WIN32}


{**********************************************************
*  Module: TCollationPicker.Create
*  Description: Create the Collation Picker form.
**********************************************************}
constructor TCollationPicker.Create(AOwner: TComponent; TableType: UNSIGNED16 );
begin
  inherited create( AOwner );

  iTableType := integer(TableType);

  LoadCharType;
  LoadLocales;

  // Set the default drop-downs based on last-used settings.
{$IFDEF WIN32}
{$IFDEF ADSDELPHI5_OR_NEWER}
  LoadLastUsedSettings;

  if ( ( comboLocale.Text = '' ) or ( comboLocale.Text = 'ads_ascii' ) ) then
     cbCaseInsensitive.Enabled := False
  else
     cbCaseInsensitive.Enabled := True;
{$ENDIF}
{$ENDIF} // WIN32

  // Set default ADS CharType to ANSI.
  if ( comboCharType.Text = '' ) then
     comboCharType.ItemIndex := 0;

end;

{$IFDEF FPC}
initialization
   {$I CollationPicker.lrs}
{$ENDIF}

end.
