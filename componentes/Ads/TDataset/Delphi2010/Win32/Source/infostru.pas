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
* Source File : infostru.pas
* Date Created: 05/20/97
* Description : Implementation of info structure dialog.
* Notes       :
*******************************************************************************}
unit infostru;

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
   Controls,
   Forms,
   Dialogs,
   StdCtrls,
   Grids,
   Buttons,
   ExtCtrls,
{$endif}

{$ifdef LINUX}
{$IFNDEF FPC}
   QControls,
   QForms,
   QDialogs,
   QStdCtrls,
   QGrids,
   QButtons,
   QExtCtrls,
{$ELSE}
   Forms,
   Buttons,
   ExtCtrls,
   StdCtrls,
   Grids,
   Controls,
{$ENDIF}
{$endif}

   {$IFDEF FPC}
   LResources,
   {$ENDIF}
   SysUtils,
   Classes,
   ACE;

type
  TInfoStructForm = class( TForm )
    CloseBtn: TBitBtn;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    RecNoLabel: TLabel;
    poStructGrid: TStringGrid;
    procedure CloseBtnClick( Sender: TObject );
    procedure poStructGridSelectCell( Sender: TObject; Col, Row: Longint;
                                      var CanSelect: Boolean );
    procedure FillGrid;
    procedure FormActivate( Sender: TObject );

  private
    { Private declarations }
  public
    { Public declarations }
     hInfoTableHandle: ADSHANDLE;
     strInfoFileName: string;
  end;


var
  InfoStructForm: TInfoStructForm;

implementation

{$IFNDEF FPC}
   {$IFDEF WIN32}
   {$R *.dfm}
   {$ENDIF}
   {$IFDEF LINUX}
   {$R *.xfm}
   {$ENDIF}
{$ENDIF}


{$IFNDEF ADSDELPHI2008_OR_NEWER}
function AnsiStrAlloc(Size: Cardinal): PChar;
begin
  Result := StrAlloc( Size );
end;
{$ENDIF}

procedure TInfoStructForm.CloseBtnClick( Sender: TObject );
begin
   ModalResult := mrOK;
end;


{$IFDEF FPC}{$HINTS OFF}{$ENDIF}
procedure TInfoStructForm.poStructGridSelectCell( Sender: TObject; Col,
                                                  Row: Longint; var CanSelect: Boolean );
begin
   RecNoLabel.Caption := IntToStr( Row ) + ' / ' + IntToStr( poStructGrid.RowCount - 1 );
end;
{$IFDEF FPC}{$HINTS ON}{$ENDIF}



procedure TInfoStructForm.FillGrid;
var
   poDataStructList: TList;
   usBufLen, usRowNum, usFieldCount, usType: Word;
   pucFieldName: PAceChar;
   strFieldType: string;
   ulFieldLength, ulFieldDecimals: ADSHANDLE;
   bCanSelect: boolean;

begin
   Caption := 'Structure of:  ' + strInfoFileName;
   ACE.AdsGetNumFields( hInfoTableHandle, @usFieldCount );
   pucFieldName := AnsiStrAlloc( ADS_MAX_FIELD_NAME + 1 );
   poDataStructList := TList.Create;

   with poStructGrid do
   begin
      RowCount := usFieldCount + 1;

      { Build grid column labels. }
      Cells[ 0, 0 ] := 'Field Name';
      Cells[ 1, 0 ] := 'Type';
      Cells[ 2, 0 ] := 'Size';
      Cells[ 3, 0 ] := 'Decimals';

      { Get the field definitions and use those to build the fieldstruct table }
      for usRowNum := 1 to usFieldCount do
      begin
         usBufLen := ADS_MAX_FIELD_NAME + 1;
         ulFieldDecimals := 0;

         ACE.AdsGetFieldName( hInfoTableHandle,
                              usRowNum,
                              pucFieldName,
                              @usBufLen );

         ACE.AdsGetFieldType( hInfoTableHandle,
                              pucFieldName,
                              @usType );
         case usType of
            ADS_LOGICAL    : strFieldType := 'LOGICAL';
            ADS_NUMERIC    : strFieldType := 'NUMERIC';
            ADS_DATE       : strFieldType := 'DATE';
            ADS_STRING     : strFieldType := 'CHAR';
            ADS_CISTRING   : strFieldType := 'CICHAR';
            ADS_MEMO       : strFieldType := 'MEMO';
            ADS_INTEGER    : strFieldType := 'INTEGER';
            ADS_DOUBLE     : strFieldType := 'DOUBLE';
            ADS_CURDOUBLE  : strFieldType := 'CURDOUBLE';
            ADS_BINARY     : strFieldType := 'MEMO (BINARY)';
            ADS_IMAGE      : strFieldType := 'MEMO (IMAGE)';
            ADS_VARCHAR    : strFieldType := 'VARCHAR';
            ADS_COMPACTDATE: strFieldType := 'COMPACTDATE';
            ADS_SHORTINT   : strFieldType := 'SHORTINT';
            ADS_TIME       : strFieldType := 'TIME';
            ADS_TIMESTAMP  : strFieldType := 'TIMESTAMP';
            ADS_AUTOINC    : strFieldType := 'AUTOINC';
            ADS_RAW        : strFieldType := 'RAW';
{$IFDEF ADSDELPHI5_OR_NEWER }
            ADS_MONEY      : strFieldType := 'MONEY';
            ADS_ROWVERSION : strFieldType := 'ROWVERSION';
{$ENDIF}
            ADS_MODTIME    : strFieldType := 'MODTIME';
            ADS_VARCHAR_FOX: strFieldType := 'VARCHARFOX';
            ADS_VARBINARY_FOX: strFieldType := 'VARBINARYFOX';
{$IFDEF ADSDELPHI2008_OR_NEWER}
            ADS_NCHAR      : strFieldType := 'NCHAR';
            ADS_NVARCHAR   : strFieldType := 'NVARCHAR';
            ADS_NMEMO      : strFieldType := 'NMEMO';
{$ENDIF}

            else
               strFieldType := 'UNKNOWN';
         end;{ case }


         ACE.AdsGetFieldLength( hInfoTableHandle,
                                pucFieldName,
                                @ulFieldLength );

         ACE.AdsGetFieldDecimals( hInfoTableHandle,
                                  pucFieldName,
                                  @ulFieldDecimals );

         { Populate InfoStructForm grid. }
         Cells[ 0, usRowNum ] := string( StrPas( pucFieldName ) );
         Cells[ 1, usRowNum ] := strFieldType;
         Cells[ 2, usRowNum ] := IntToStr( ulFieldLength );
         Cells[ 3, usRowNum ] := IntToStr( ulFieldDecimals );

      end;{ for usFieldNum }
   end;{ with }

   poDataStructList.free;
   StrDispose( pucFieldName );
   bCanSelect := true;
   poStructGridSelectCell( nil, 1, 1, bCanSelect );
end;



procedure TInfoStructForm.FormActivate( Sender: TObject );
begin
   poStructGrid.SetFocus;
end;

{$IFDEF FPC}
initialization
   {$I infostru.lrs}
{$ENDIF}


end.
