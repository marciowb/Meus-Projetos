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
* Source File : AdsAEPSessionMgr.pas
* Description : Small class to help manage data modules used in Advantage
*               Extended Procedures (AEP's).
* Notes       :
*******************************************************************************}
unit AdsAEPSessionMgr;

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
{$IFDEF WIN32}
   {$IFNDEF FPC}
   Windows, Messages,
   {$ENDIF}
   Graphics, Controls, Forms, Dialogs,
{$ENDIF}

   SysUtils, Classes

{$IFDEF ADSDELPHI4_OR_NEWER}
   ,syncobjs
{$ENDIF}
   ;

type

   {* Delphi 3 didn't have the syncobjs unit with TCriticalSection in it, if
    * this is Delphi 3 declare it here. *}
{$IFNDEF ADSDELPHI4_OR_NEWER}
   TCriticalSection = class(TObject)
   private
      FSection: TRTLCriticalSection;
   public
      constructor Create;
      destructor Destroy; override;
      procedure Acquire;
      procedure Release;
      procedure Enter;
      procedure Leave;
   end;
{$ENDIF}

   TAdsAEPSessionObject = class
      id : integer;
      dm : TDataModule;
   end;

   TAdsAEPSessionMgr = class(TComponent)
   protected
      Items    : TList;
      ItemsCS  : TCriticalSection;
      function  GetItem( id : integer ) : TAdsAEPSessionObject;
   public
      constructor Create( AOwner : TComponent ); override;
      destructor Destroy; override;
      procedure AddDM( id : integer; dm : TDataModule );
      function  GetDM( id : integer ) : TDataModule;
      procedure FreeDM( id : integer );
   published

   end;

implementation

uses
   adsdata,
   ace;

{ TAdsAEPSessionMgr }


{*******************************************************************************
*  Module         :  TAdsAEPSessionMgr.AddDM
*  Parameters     :  id - unique identifier
*                    dm - pointer to a data module
*  Returns        :
*  Description    :  Add a data module to the linked list.
*******************************************************************************}
procedure TAdsAEPSessionMgr.AddDM(id: integer; dm: TDataModule);
var
   NewItem : TAdsAEPSessionObject;
begin
   NewItem := TAdsAEPSessionObject.Create;

   NewItem.id := id;
   NewItem.dm := dm;

   ItemsCS.Enter;
   try
      Items.Add( NewItem );
   finally
      ItemsCS.Leave;
   end;
end;



{*******************************************************************************
*  Module         :  TAdsAEPSessionMgr.Create
*  Parameters     :  AOwner - component
*  Returns        :
*  Description    :  constructor
*******************************************************************************}
constructor TAdsAEPSessionMgr.Create(AOwner: TComponent);
begin
   inherited;

   Items   := TList.Create;
   ItemsCS := TCriticalSection.Create;
end;



{*******************************************************************************
*  Module         :  TAdsAEPSessionMgr.Destroy
*  Parameters     :
*  Returns        :
*  Description    :  destructor
*******************************************************************************}
destructor TAdsAEPSessionMgr.Destroy;
begin
   inherited;

   Items.Free;
   ItemsCS.Free;
end;



{*******************************************************************************
*  Module         :  TAdsAEPSessionMgr.FreeDM
*  Parameters     :  id - node to free
*  Returns        :
*  Description    :  locates and frees the item referenced by id
*******************************************************************************}
procedure TAdsAEPSessionMgr.FreeDM(id: integer);
var
   ItemToFree : TAdsAEPSessionObject;
begin

   ItemToFree := GetItem( id );

   if assigned( ItemToFree.dm ) then
      (ItemToFree.dm).Free;

   ItemsCS.Enter;
   try
      Items.Remove( ItemToFree );
   finally
      ItemsCS.Leave;
   end;
   ItemToFree.Free;

end;



{*******************************************************************************
*  Module         :  TAdsAEPSessionMgr.GetDM
*  Parameters     :  id - node to get
*  Returns        :  pointer to the data module associated with ID
*  Description    :  Gets the data module associated with the passed in ID.
*******************************************************************************}
function TAdsAEPSessionMgr.GetDM(id: integer): TDataModule;
begin

   Result := TAdsAEPSessionObject( GetItem( id ) ).dm;

end;



{*******************************************************************************
*  Module         :  TAdsAEPSessionMgr.GetItem
*  Parameters     :  id - node to get
*  Returns        :  TAdsAEPSessionObject
*  Description    :  Returns a pointer to the node identified by ID
*******************************************************************************}
function TAdsAEPSessionMgr.GetItem(id: integer): TAdsAEPSessionObject;
var
   i : integer;
begin

   Result := nil;

   ItemsCS.Enter;

   try
      {* linear search through all items. *}
      for i := 0 to ( Items.Count - 1 ) do
         if ( TAdsAEPSessionObject(Items[i]).id = id ) then
         begin
            Result := TAdsAEPSessionObject(Items[i]);
            exit;
         end;

      {* If we got here we didn't find it, raise an exception. *}
      raise EADSDatabaseError.Create( nil, AE_TADSDATASET_GENERAL,
                                      'Session not found.' );

   finally
      ItemsCS.Leave;
   end;

end;


{$IFNDEF ADSDELPHI4_OR_NEWER}

{ TCriticalSection }

constructor TCriticalSection.Create;
begin
  inherited Create;
  InitializeCriticalSection(FSection);
end;

destructor TCriticalSection.Destroy;
begin
  DeleteCriticalSection(FSection);
  inherited Destroy;
end;

procedure TCriticalSection.Acquire;
begin
  EnterCriticalSection(FSection);
end;

procedure TCriticalSection.Release;
begin
  LeaveCriticalSection(FSection);
end;

procedure TCriticalSection.Enter;
begin
  Acquire;
end;

procedure TCriticalSection.Leave;
begin
  Release;
end;

{$ENDIF}

end.
