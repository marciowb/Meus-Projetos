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
* Source File : adsparam.pas
* Date Created: 04/26/99
* Description : This is the source for the TAdsQuery parameter editor
* Notes       :
*******************************************************************************}

unit AdsParam;

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
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, AdsTable, ACE, DBLookup, DBTables, DB;

type
    TQueryParamsEditor = class(TForm)
    gbGroupBox1: TGroupBox;
    labParameterName: TLabel;
    lbParams: TListBox;
    labDataType: TLabel;
    labValue: TLabel;
    edValue: TEdit;
    cbNullValue: TCheckBox;
    btOK: TButton;
    btCancel: TButton;
    cbDataType: TComboBox;
    procedure lbParamsClick(Sender: TObject);
    procedure btOKClick(Sender: TObject);
    procedure btCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cbDataTypeChange(Sender: TObject);
    procedure edValueChange(Sender: TObject);
    procedure cbNullValueClick(Sender: TObject);
    procedure lbParamsKeyPress(Sender: TObject; var Key: Char);

  private
    { Private declarations }
    moDataset: TComponent;
    moParams : TParams;
    mlActiveItem : SIGNED32;
    bAnythingModified : boolean;

    procedure StoreOldSelection;

  public
    { Public declarations }
    procedure InitValues( oDataSet : TComponent );
  end;


implementation

uses
   AdsData;


{$R *.DFM}

{*******************************************************************************
*  Module:  TQueryParamsEditor.InitValues
*  Date Created:  4/1/99
*  Last Modified:
*  Input:       a TAdsQuery component reference
*  Output:
*  Description: store a reference to the TAdsQuery component
*******************************************************************************}
procedure TQueryParamsEditor.InitValues( oDataSet : TComponent );
var
   ulItem : UNSIGNED32;

begin
   { store the query object reference }
   moDataSet := oDataSet;

   { set the forms caption }
   Caption := moDataSet.Owner.Name + '.' + moDataSet.Name + ' Parameters';

   { make a copy of the parameter list }
   if ( oDataset is TAdsQuery ) then
   begin
      moParams.Assign( TAdsQuery(moDataSet).Params );
      moParams.AssignValues( TAdsQuery(moDataSet).Params );
   end
   else if ( oDataset is TAdsStoredProc ) then
   begin
      moParams.Assign( TAdsStoredProc(moDataSet).Params );
      moParams.AssignValues( TAdsStoredProc(moDataSet).Params );
   end
   else
      raise Exception.Create( 'unknown dataset type sent to param editor.' );

   { set the old select value -- set to none selected }
   mlActiveItem := -1; { the value that the check box returns if none is selected }

   { copy all of the parameter names into the list box  }
   lbParams.Items.Clear;
   for ulItem := 0 to moParams.Count - 1 do
      lbParams.Items.Add( moParams.Items[ ulItem ].Name );

   { clear the data in the current box }
   edValue.Text := '';
   cbDataType.ItemIndex := -1;
   cbNullValue.Checked := FALSE;
   bAnythingModified := FALSE;
end;




{*******************************************************************************
*  Module:  TQueryParamsEditor.StoreOldSelection
*  Date Created:  4/1/99
*  Last Modified:
*  Input:
*  Output:
*  Description: store the information from the forms components into the
*               moParams member
*******************************************************************************}
procedure TQueryParamsEditor.StoreOldSelection;
var
   oParam       : TParam;

begin
   if NOT bAnythingModified then
      exit;

   try
      if mlActiveItem = -1 then
         raise EADSDatabaseError.create( nil, AE_TADSDATASET_GENERAL,
                                         'No parameter name was selected.' );

      if cbDataType.ItemIndex = -1 then
         raise EADSDatabaseError.create( nil, AE_TADSDATASET_GENERAL,
                                         'A parameter data type was not selected.' );

      { there was a parameter data type selected }
      oParam := moParams.ParamByName( lbParams.Items.Strings[ mlActiveItem ] );

      if cbNullValue.Checked or (( NOT bAnythingModified ) and ( edValue.Text = '' )) then
      begin
         oParam.Clear;
         cbNullValue.Checked := FALSE;
      end
      else
      begin
         try
            oParam.Text := edValue.Text;

         except
            On E : EVariantError Do
            begin
               if edValue.Text = '' then
                  oParam.Clear
               else
                  raise;
            end
         end; { try }
      end; { else if ( bAnythingModified ) then }

      bAnythingModified := FALSE;

   except
      { if any exception happens, restore the old selected value }
      lbParams.ItemIndex := mlActiveItem;
      raise;
   end;
end;  { TQueryParamsEditor.StoreOldSelection }



{*******************************************************************************
*  Module:  TQueryParamsEditor.lbParamsClick
*  Date Created:  4/1/99
*  Last Modified:
*  Input:       The object that is calling this function
*  Output:
*  Description: Handle a click in the parameter list component
*******************************************************************************}
procedure TQueryParamsEditor.lbParamsClick( Sender: TObject );
var
   strParamName : string;

begin
   { -1 is the value that is returned if no item is selected }
   if ( mlActiveItem <> -1 ) and ( mlActiveItem <> lbParams.ItemIndex ) then
      StoreOldSelection;

   { is an item selected }
   if lbParams.ItemIndex >= 0 then
   begin
      { deal with the new selected item }
      mlActiveItem := lbParams.ItemIndex; { store the selected item }
      strParamName := lbParams.Items.Strings[ mlActiveItem ];

      { the itemindex value directly corresponds with the data in the Items member }
      { of the cbDataType member.  Be careful of changing that value.  This was }
      { the only way I could figure out how to do this. }

      case moParams.ParamByName( strParamName ).DataType of
         ftBCD      : cbDataType.ItemIndex := 0;  { BCD }
         ftBlob     : cbDataType.ItemIndex := 1;  { Blob }
         ftBoolean  : cbDataType.ItemIndex := 2;  { Boolean }
         ftCurrency : cbDataType.ItemIndex := 3;  { Currency }
         ftDate     : cbDataType.ItemIndex := 4;  { Date }
         ftDateTime : cbDataType.ItemIndex := 5;  { DateTime }
         ftFloat    : cbDataType.ItemIndex := 6;  { Float }
         ftGraphic  : cbDataType.ItemIndex := 7;  { Graphic }
         ftInteger  : cbDataType.ItemIndex := 8;  { Integer }
{$IFDEF ADSDELPHI5_OR_NEWER}
         ftLargeInt : cbDataType.ItemIndex := 9;  { LargeInt }
{$ENDIF}
         ftMemo     : cbDataType.ItemIndex := 10; { Memo }
         ftSmallint : cbDataType.ItemIndex := 11; { Smallint }
         ftString   : cbDataType.ItemIndex := 12; { String }
         ftTime     : cbDataType.ItemIndex := 13; { Time }
         ftWord     : cbDataType.ItemIndex := 14; { Word }
{$IFDEF ADSDELPHI2008_OR_NEWER}
         ftWideString : cbDataType.ItemIndex := 15; {WideString}
         ftWideMemo : cbDataType.ItemIndex := 16; { WideMemo }
{$ENDIF}
         ftUnknown  : cbDataType.ItemIndex := -1;
         else
            raise EADSDatabaseError.create( nil, AE_TADSDATASET_GENERAL,
                                            'Invalid parameter data type.' );
      end;

      if moParams.ParamByName( strParamName ).DataType <> ftUnknown then
         edValue.Text := moParams.ParamByName( strParamName ).AsString
      else
         edValue.Text := '';

      cbNullValue.Checked := moParams.ParamByName( strParamName ).IsNull;
   end
   else
   begin
      { an item is not selected }
      edValue.Text := '';
      cbDataType.ItemIndex := -1;
      cbNullValue.Checked := FALSE;
   end;

   bAnythingModified := FALSE;
end;



{*******************************************************************************
*  Module:  TQueryParamsEditor.cbDataTypeChange
*  Date Created:  4/1/99
*  Last Modified:
*  Input:       The object that is calling this function
*  Output:
*  Description: Handle the value of the DataType data being changed. Store
*               the newly selected datatype into the parameter object
*******************************************************************************}
procedure TQueryParamsEditor.cbDataTypeChange(Sender: TObject);
var
   oParam       : TParam;

begin
   { there was a parameter data type selected }
   oParam := moParams.ParamByName( lbParams.Items.Strings[ mlActiveItem ] );

   if ( cbDataType.Text = 'BCD'      ) then
      oParam.DataType := ftBCD
   else if ( cbDataType.Text = 'Blob'     ) then
      oParam.DataType := ftBlob
   else if ( cbDataType.Text = 'Boolean'  ) then
      oParam.DataType := ftBoolean
   else if ( cbDataType.Text = 'Currency' ) then
      oParam.DataType := ftCurrency
   else if ( cbDataType.Text = 'Date'     ) then
      oParam.DataType := ftDate
   else if ( cbDataType.Text = 'DateTime' ) then
      oParam.DataType := ftDateTime
   else if ( cbDataType.Text = 'Float'    ) then
      oParam.DataType := ftFloat
   else if ( cbDataType.Text = 'Graphic'  ) then
      oParam.DataType := ftGraphic
   else if ( cbDataType.Text = 'Integer'  ) then
      oParam.DataType := ftInteger
   else if ( cbDataType.Text = 'Memo'     ) then
      oParam.DataType := ftMemo
   else if ( cbDataType.Text = 'Smallint' ) then
      oParam.DataType := ftSmallint
   else if ( cbDataType.Text = 'String'   ) then
      oParam.DataType := ftString
   else if ( cbDataType.Text = 'Time'     ) then
      oParam.DataType := ftTime
   else if ( cbDataType.Text = 'Word'     ) then
      oParam.DataType := ftWord
{$IFDEF ADSDELPHI2008_OR_NEWER}
   else if ( cbDataType.Text = 'WideString' ) then
      oParam.DataType := ftWideString
   else if ( cbDataType.Text = 'WideMemo' ) then
      oParam.DataType := ftWideMemo
{$ENDIF}
   else if ( cbDataType.Text = 'LargeInt' ) then
{$IFDEF ADSDELPHI5_OR_NEWER}
      oParam.DataType := ftLargeInt;
{$ELSE}
      oParam.DataType := ftInteger;
{$ENDIF}

   bAnythingModified := True;
end;


{*******************************************************************************
*  Module:  TQueryParamsEditor.btOKClick
*  Date Created:  4/1/99
*  Last Modified:
*  Input:       The object that is calling this function
*  Output:
*  Description: Handle a the OK button click -- store the params into
*               TAdsQuery and return
*******************************************************************************}
procedure TQueryParamsEditor.btOKClick( Sender: TObject );
begin
   { take care of newly entered values }
   if ( mlActiveItem <> -1 ) then
      StoreOldSelection;

   { store the local parameter list into the query's }
   if ( moDataSet is TAdsQuery ) then
   begin
      TAdsQuery(moDataSet).Params.Assign( moParams );
      TAdsQuery(moDataSet).Params.AssignValues( moParams );
   end
   else if ( moDataset is TAdsStoredProc ) then
   begin
      TAdsStoredProc(moDataSet).Params.Assign( moParams );
      TAdsStoredProc(moDataSet).Params.AssignValues( moParams );
   end
   else
      raise Exception.Create( 'unknown dataset type sent to param editor.' );

   { zap all of the params in the local copy }
   moParams.Clear;

   ModalResult := mrOK;
end;



{******************************************************************************}
{******************************************************************************}

{*******************************************************************************
*  Date Created:  4/1/99
*  Last Modified:
*  Input:       The object that is calling this function
*  Output:
*  Description: Handle various windows components
*******************************************************************************}

procedure TQueryParamsEditor.btCancelClick( Sender: TObject );
begin
   { close with a cancel }
   ModalResult := mrCancel;
end;

procedure TQueryParamsEditor.FormCreate( Sender: TObject );
begin
   { create the moParams object reference }
   moParams := TParams.Create;
end;

procedure TQueryParamsEditor.FormDestroy( Sender: TObject );
begin
   { free the moParams object reference }
   moParams.Free;
end;

procedure TQueryParamsEditor.edValueChange(Sender: TObject);
begin
   { the user entered parameter data }
   bAnythingModified := True;
   if ( edValue.Text <> '' ) then
      cbNullValue.Checked := FALSE;
end;

procedure TQueryParamsEditor.cbNullValueClick(Sender: TObject);
begin
   { the user clicked on the IsNULL object }
   bAnythingModified := True;
   if ( cbNullValue.Checked ) then
      edValue.Text := ''; { if NULL then no data }
end;



procedure TQueryParamsEditor.lbParamsKeyPress(Sender: TObject;
  var Key: Char);
begin
   lbParamsClick( Sender );
end;

end.

