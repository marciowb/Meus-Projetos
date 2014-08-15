{***************************************************************************}
{ This source code was generated automatically by                           }
{ Pas file import tool for Scripter Studio (Pro)                            }
{                                                                           }
{ Scripter Studio and Pas file import tool for Scripter Studio              }
{ written by TMS Software                                                   }
{            copyright © 1997 - 2010                                        }
{            Email : info@tmssoftware.com                                   }
{            Web : http://www.tmssoftware.com                               }
{***************************************************************************}
unit ap_DBCommonTypes;

interface

uses
  DBCommonTypes,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatDBCommonTypesLibrary = class(TatScripterLibrary)
    procedure Init; override;
    class function LibraryName: string; override;
  end;


  TatDBCommonTypesDispatcher = class(TatEventDispatcher)
  private
    procedure __TLoginEvent( Sender: TObject;  Username: string;  Password: string);
  end;


implementation



procedure TatDBCommonTypesDispatcher.__TLoginEvent( Sender: TObject;  Username: string;  Password: string);
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TLoginEvent(BeforeCall)(Sender,Username,Password);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,Username,Password]);
    if AssignedMethod(AfterCall) then
      TLoginEvent(AfterCall)(Sender,Username,Password);
  end;
end;

procedure TatDBCommonTypesLibrary.Init;
begin
  DefineEventAdapter(TypeInfo(TLoginEvent), TatDBCommonTypesDispatcher, @TatDBCommonTypesDispatcher.__TLoginEvent);
  With Scripter.DefineClass(ClassType) do
  begin
    AddConstant('fldvNOCHECKS',fldvNOCHECKS);
    AddConstant('fldvHASCHECKS',fldvHASCHECKS);
    AddConstant('fldvUNKNOWN',fldvUNKNOWN);
    AddConstant('fldrREADWRITE',fldrREADWRITE);
    AddConstant('fldrREADONLY',fldrREADONLY);
    AddConstant('fldrNONE',fldrNONE);
    AddConstant('fldrUNKNOWN',fldrUNKNOWN);
    AddConstant('cbGENERAL',cbGENERAL);
    AddConstant('cbRESERVED1',cbRESERVED1);
    AddConstant('cbRESERVED2',cbRESERVED2);
    AddConstant('cbINPUTREQ',cbINPUTREQ);
    AddConstant('cbRESERVED4',cbRESERVED4);
    AddConstant('cbRESERVED5',cbRESERVED5);
    AddConstant('cbBATCHRESULT',cbBATCHRESULT);
    AddConstant('cbRESERVED7',cbRESERVED7);
    AddConstant('cbRESTRUCTURE',cbRESTRUCTURE);
    AddConstant('cbRESERVED9',cbRESERVED9);
    AddConstant('cbRESERVED10',cbRESERVED10);
    AddConstant('cbRESERVED11',cbRESERVED11);
    AddConstant('cbRESERVED12',cbRESERVED12);
    AddConstant('cbRESERVED13',cbRESERVED13);
    AddConstant('cbRESERVED14',cbRESERVED14);
    AddConstant('cbRESERVED15',cbRESERVED15);
    AddConstant('cbRESERVED16',cbRESERVED16);
    AddConstant('cbRESERVED17',cbRESERVED17);
    AddConstant('cbTABLECHANGED',cbTABLECHANGED);
    AddConstant('cbRESERVED19',cbRESERVED19);
    AddConstant('cbCANCELQRY',cbCANCELQRY);
    AddConstant('cbSERVERCALL',cbSERVERCALL);
    AddConstant('cbRESERVED22',cbRESERVED22);
    AddConstant('cbGENPROGRESS',cbGENPROGRESS);
    AddConstant('cbDBASELOGIN',cbDBASELOGIN);
    AddConstant('cbDELAYEDUPD',cbDELAYEDUPD);
    AddConstant('cbFIELDRECALC',cbFIELDRECALC);
    AddConstant('cbTRACE',cbTRACE);
    AddConstant('cbDBLOGIN',cbDBLOGIN);
    AddConstant('cbDETACHNOTIFY',cbDETACHNOTIFY);
    AddConstant('cbNBROFCBS',cbNBROFCBS);
    AddConstant('cbrUSEDEF',cbrUSEDEF);
    AddConstant('cbrCONTINUE',cbrCONTINUE);
    AddConstant('cbrABORT',cbrABORT);
    AddConstant('cbrCHKINPUT',cbrCHKINPUT);
    AddConstant('cbrYES',cbrYES);
    AddConstant('cbrNO',cbrNO);
    AddConstant('cbrPARTIALASSIST',cbrPARTIALASSIST);
    AddConstant('cbrSKIP',cbrSKIP);
    AddConstant('cbrRETRY',cbrRETRY);
    AddConstant('kiLookup',kiLookup);
    AddConstant('kiRangeStart',kiRangeStart);
    AddConstant('kiRangeEnd',kiRangeEnd);
    AddConstant('kiCurRangeStart',kiCurRangeStart);
    AddConstant('kiCurRangeEnd',kiCurRangeEnd);
    AddConstant('kiSave',kiSave);
  end;
end;

class function TatDBCommonTypesLibrary.LibraryName: string;
begin
  result := 'DBCommonTypes';
end;

initialization
  RegisterScripterLibrary(TatDBCommonTypesLibrary, True);

{$WARNINGS ON}

end.

