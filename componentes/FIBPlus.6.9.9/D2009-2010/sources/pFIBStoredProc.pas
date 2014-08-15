{***************************************************************}
{ FIBPlus - component library for direct access to Firebird and }
{ InterBase databases                                           }
{                                                               }
{    FIBPlus is based in part on the product                    }
{    Free IB Components, written by Gregory H. Deatz for        }
{    Hoagland, Longo, Moran, Dunst & Doukas Company.            }
{    mailto:gdeatz@hlmdd.com                                    }
{                                                               }
{    Copyright (c) 1998-2007 Devrace Ltd.                       }
{    Written by Serge Buzadzhy (buzz@devrace.com)               }
{                                                               }
{ ------------------------------------------------------------- }
{    FIBPlus home page: http://www.fibplus.com/                 }
{    FIBPlus support  : http://www.devrace.com/support/         }
{ ------------------------------------------------------------- }
{                                                               }
{  Please see the file License.txt for full license information }
{***************************************************************}


{Special thanks to Vadim Yegorov <zg@matrica.apollo.lv>}

unit pFIBStoredProc;

interface

{$I FIBPlus.inc}
uses
  Classes,pFIBQuery, FIBQuery,FIBDataBase;

type
  TpFIBStoredProc = class(TpFIBQuery)
  private
    FStoredProc: string;
    procedure SetStoredProc(const Value: string);
  protected
    procedure SetDatabase(Value: TFIBDatabase); override;  
  public
    constructor Create(AOwner: TComponent); override;
  published
    property StoredProcName: string read FStoredProc write SetStoredProc;
  end;

implementation

uses
   pFIBDatabase, StrUtil, SysUtils,pFIBDataInfo;

procedure TpFIBStoredProc.SetStoredProc(const Value: string);
var ProcName:string; 
begin
  if (Value <> FStoredProc) then
  begin
   FStoredProc := Value;
   if not (csReading in ComponentState) then
   begin
//     FBase.CheckDatabase;
     if Assigned(Database) then       
     if  IsBlank(Value) then
      SQL.Clear
     else
     begin
      ProcName:=EasyFormatIdentifier(Database.SQLDialect, FStoredProc,
       Database.EasyFormatsStr
      );  
      SQL.Text :=
       ListSPInfo.GetExecProcTxt(Database,
        ProcName
        ,csDesigning in ComponentState
       ); 
     end;
   end;
  end;
end;

constructor TpFIBStoredProc.Create(AOwner: TComponent);
begin
  inherited;
  FStoredProc := '';
end;


procedure TpFIBStoredProc.SetDatabase(Value: TFIBDatabase);
var
  s:string;
begin
  inherited SetDatabase(Value);
  if Assigned(Value) and (Length(FastTrim(SQL.Text))=0)
   and (Length(FStoredProc)>0)
  then
  begin
    s:=FStoredProc;
    FStoredProc:='';
    StoredProcName:=s
  end;
end;

end.

