{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2006                    BBBBB   }

unit ppChReg;

interface

{$I ppIfDef.pas}
{$I ppIfDefTee.pas}

uses

  ppChrtDP,

  {$IFDEF Delphi6}DesignIntf, DesignEditors, {$ELSE} DsgnIntf, {$ENDIF}
  Classes, ExtCtrls, SysUtils, Chart, TeEngine, TeExport,
  ppClass, ppCtrls, ppTypes, ppUtils, ppChrt, ppChrtUI;

type

  {@TppTeeChartProperty }
  TppTeeChartProperty = class(TClassProperty)
    public
      procedure Edit; override;
      function GetValue: string; override;
      function GetAttributes : TPropertyAttributes; override;
  end; {class, TppTeeChartProperty}


procedure Register;

implementation

{******************************************************************************
 *
 ** C H A R T   P R O P E R T Y   E D I T O R
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppTeeChartProperty.Edit }

procedure TppTeeChartProperty.Edit;
var
  lChartComponent: TppCustomTeeChart;
begin

  lChartComponent := TppCustomTeeChart(GetComponent(0));

  lChartComponent.Edit;

  Designer.Modified;
end;

{------------------------------------------------------------------------------}
{ TppTeeChartProperty.GetAttributes }

function TppTeeChartProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog];
end;

{------------------------------------------------------------------------------}
{ TppTeeChartProperty.GetValue }

function TppTeeChartProperty.GetValue: string;
begin
  FmtStr(Result, '(%s)', [GetPropType^.Name]);
end;

{******************************************************************************
 *
 ** R E G I S T E R
 *
{******************************************************************************}

procedure Register;
begin
{$IFDEF Delphi9}
  ForceDemandLoadState(dlDisable);
{$ENDIF}

  RegisterNoIcon([TppTeeChart]);

  RegisterPropertyEditor(TypeInfo(TCustomChart), TppTeeChart, 'Chart', TppTeeChartProperty);

{$IFDEF Tee40}
  RegisterNoIcon([TppDPTeeChart]);

  RegisterPropertyEditor(TypeInfo(TCustomChart), TppDPTeeChart, 'Chart', TppTeeChartProperty);
{$ENDIF}

end;



end.
