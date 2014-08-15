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
* Source File : InfoExp.PAS
* Date Created: 05/20/97
* Description : Implementation of info expression dialog.
* Notes       :
*******************************************************************************}
unit infoexp;

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
   Controls,
   Forms,
   StdCtrls,
   Grids,
   Buttons,
   ExtCtrls,
{$ENDIF}
{$endif}

{$IFDEF FPC}
   LResources,
{$ENDIF}
   SysUtils,
   Classes,
   adsdata,
   ACE;

const
   MAX_FIELD_NAME = 10;
   MAX_INDEX_EXPR = 1024;

type
  TExpressionForm = class(TForm)
    CloseBtn: TBitBtn;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    RecNoLabel: TLabel;
    poStructGrid: TStringGrid;
    procedure CloseBtnClick(Sender: TObject);
//    {$IFDEF FPC}{$HINTS OFF}{$ENDIF}
    procedure poStructGridSelectCell(Sender: TObject; Col, Row: Longint;
      var CanSelect: Boolean);
//    {$IFDEF FPC}{$HINTS ON}{$ENDIF}
    procedure FillGrid;
    procedure FormActivate(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
     hExpTableHandle: ADSHANDLE;
     strExpFileName: string;
  end;


var
  ExpressionForm: TExpressionForm;

implementation

{$IFNDEF FPC}
   {$IFDEF WIN32}
   {$R *.dfm}
   {$ENDIF}
   {$IFDEF LINUX}
   {$R *.xfm}
   {$ENDIF}
{$ENDIF}


procedure TExpressionForm.CloseBtnClick(Sender: TObject);
begin
   ModalResult := mrOK;
end;

{$IFNDEF ADSDELPHI2008_OR_NEWER}
function AnsiStrAlloc(Size: Cardinal): PChar;
begin
  Result := StrAlloc( Size );
end;
{$ENDIF}

{$IFDEF FPC}{$HINTS OFF}{$ENDIF}
procedure TExpressionForm.poStructGridSelectCell(Sender: TObject; Col,
  Row: Longint; var CanSelect: Boolean);
begin
   RecNoLabel.Caption := IntToStr( Row ) + ' / ' + IntToStr( poStructGrid.RowCount - 1 );
end;
{$IFDEF FPC}{$HINTS ON}{$ENDIF}


procedure TExpressionForm.FillGrid;
var
   poDataStructList  : TList;
   usBufLen, usRowNum, usIndexArrLen, usExprLen: Word;
   pucIndexName      : PAceChar;
   bCanSelect        : boolean;
   phIndexArray      : PADSHandleArray;
   aucIndexExpr      : array [0..MAX_INDEX_EXPR] of AceChar;

begin
   Caption := 'Expressions of:  ' + strExpFileName;

   {*
    *Prevent problems with pucIndexName and poDataStructList when
    * AdsGetAllIndexes fails by initializing them to nil.
    *}
   poDataStructList := nil;
   pucIndexName := nil;
{$IFDEF FPC}
   phIndexArray := nil;
{$ENDIF}

   ACECheck( nil, ACE.AdsGetNumIndexes( hExpTableHandle, @usIndexArrLen ) );
   GetMem( phIndexArray, usIndexArrLen * sizeof( ADSHANDLE )  );

   try

      ACE.AdsGetAllIndexes( hExpTableHandle, @(phIndexArray[0]), @usIndexArrLen );

      pucIndexName := AnsiStrAlloc( MAX_FIELD_NAME + 1 );
      poDataStructList := TList.Create;
      with poStructGrid do
      begin
         RowCount := usIndexArrLen + 1;

         { Build grid column labels. }
         Cells[ 0, 0 ] := 'Index Name';
         Cells[ 1, 0 ] := 'Expression';

         { Get the field definitions and use those to build the fieldstruct table }
         for usRowNum := 1 to usIndexArrLen do
         begin
            usBufLen := MAX_FIELD_NAME + 1;
            ACE.AdsGetIndexName( phIndexArray[usRowNum - 1],
                                 pucIndexName,
                                 @usBufLen );

            usExprLen := MAX_INDEX_EXPR;
            ACE.AdsGetIndexExpr( phIndexArray[usRowNum - 1],
                                 @aucIndexExpr,
                                 @usExprLen );

            { Populate InfoStructForm grid. }
            Cells[ 0, usRowNum ] := string( StrPas( pucIndexName ) );
            Cells[ 1, usRowNum ] := string( StrPas( aucIndexExpr ) );

         end;{ for usFieldNum }
      end;{ with }
   finally
      Dispose( phIndexArray );

      if ( Assigned( poDatastructList ) ) then
         poDataStructList.Free;

      if ( Assigned( pucIndexName ) ) then
         StrDispose( pucIndexName );

   end;

   bCanSelect := true;
   poStructGridSelectCell( nil,
                           1,
                           1,
                           bCanSelect );
end;



procedure TExpressionForm.FormActivate(Sender: TObject);
begin
   poStructGrid.SetFocus;
end;

{$IFDEF FPC}
initialization
   {$I infoexp.lrs}
{$ENDIF}

end.
