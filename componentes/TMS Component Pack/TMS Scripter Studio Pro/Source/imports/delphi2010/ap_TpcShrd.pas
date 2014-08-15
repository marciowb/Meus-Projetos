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
unit ap_TpcShrd;

interface

uses
  Windows,
  TpcShrd,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatTpcShrdLibrary = class(TatScripterLibrary)
    procedure Init; override;
    class function LibraryName: string; override;
  end;



  tagXFORMWrapper = class(TatRecordWrapper)
  private
    FeM11: Single;
    FeM12: Single;
    FeM21: Single;
    FeM22: Single;
    FeDx: Single;
    FeDy: Single;
  public
    constructor Create(ARecord: tagXFORM);
    function ObjToRec: tagXFORM;
  published
    property eM11: Single read FeM11 write FeM11;
    property eM12: Single read FeM12 write FeM12;
    property eM21: Single read FeM21 write FeM21;
    property eM22: Single read FeM22 write FeM22;
    property eDx: Single read FeDx write FeDx;
    property eDy: Single read FeDy write FeDy;
  end;
  
  SYSTEM_EVENT_DATAWrapper = class(TatRecordWrapper)
  private
    FbModifier: Byte;
    FxPos: Integer;
    FyPos: Integer;
    FbCursorMode: Byte;
    FdwButtonState: DWORD;
  public
    constructor Create(ARecord: SYSTEM_EVENT_DATA);
    function ObjToRec: SYSTEM_EVENT_DATA;
  published
    property bModifier: Byte read FbModifier write FbModifier;
    property xPos: Integer read FxPos write FxPos;
    property yPos: Integer read FyPos write FyPos;
    property bCursorMode: Byte read FbCursorMode write FbCursorMode;
    property dwButtonState: DWORD read FdwButtonState write FdwButtonState;
  end;
  
  STROKE_RANGEWrapper = class(TatRecordWrapper)
  private
    FiStrokeBegin: Cardinal;
    FiStrokeEnd: Cardinal;
  public
    constructor Create(ARecord: STROKE_RANGE);
    function ObjToRec: STROKE_RANGE;
  published
    property iStrokeBegin: Cardinal read FiStrokeBegin write FiStrokeBegin;
    property iStrokeEnd: Cardinal read FiStrokeEnd write FiStrokeEnd;
  end;
  
  PROPERTY_METRICSWrapper = class(TatRecordWrapper)
  private
    FnLogicalMin: Integer;
    FnLogicalMax: Integer;
    FUnits: PROPERTY_UNITS;
    FfResolution: Single;
  public
    constructor Create(ARecord: PROPERTY_METRICS);
    function ObjToRec: PROPERTY_METRICS;
  published
    property nLogicalMin: Integer read FnLogicalMin write FnLogicalMin;
    property nLogicalMax: Integer read FnLogicalMax write FnLogicalMax;
    property Units: PROPERTY_UNITS read FUnits write FUnits;
    property fResolution: Single read FfResolution write FfResolution;
  end;
  
  PACKET_PROPERTYWrapper = class(TatRecordWrapper)
  private
    Fguid: TGUID;
  public
    constructor Create(ARecord: PACKET_PROPERTY);
    function ObjToRec: PACKET_PROPERTY;
  published
    property guid: TGUID read Fguid write Fguid;
  end;
  

implementation

constructor tagXFORMWrapper.Create(ARecord: tagXFORM);
begin
  inherited Create;
  FeM11 := ARecord.eM11;
  FeM12 := ARecord.eM12;
  FeM21 := ARecord.eM21;
  FeM22 := ARecord.eM22;
  FeDx := ARecord.eDx;
  FeDy := ARecord.eDy;
end;

function tagXFORMWrapper.ObjToRec: tagXFORM;
begin
  result.eM11 := FeM11;
  result.eM12 := FeM12;
  result.eM21 := FeM21;
  result.eM22 := FeM22;
  result.eDx := FeDx;
  result.eDy := FeDy;
end;

constructor SYSTEM_EVENT_DATAWrapper.Create(ARecord: SYSTEM_EVENT_DATA);
begin
  inherited Create;
  FbModifier := ARecord.bModifier;
  FxPos := ARecord.xPos;
  FyPos := ARecord.yPos;
  FbCursorMode := ARecord.bCursorMode;
  FdwButtonState := ARecord.dwButtonState;
end;

function SYSTEM_EVENT_DATAWrapper.ObjToRec: SYSTEM_EVENT_DATA;
begin
  result.bModifier := FbModifier;
  result.xPos := FxPos;
  result.yPos := FyPos;
  result.bCursorMode := FbCursorMode;
  result.dwButtonState := FdwButtonState;
end;

constructor STROKE_RANGEWrapper.Create(ARecord: STROKE_RANGE);
begin
  inherited Create;
  FiStrokeBegin := ARecord.iStrokeBegin;
  FiStrokeEnd := ARecord.iStrokeEnd;
end;

function STROKE_RANGEWrapper.ObjToRec: STROKE_RANGE;
begin
  result.iStrokeBegin := FiStrokeBegin;
  result.iStrokeEnd := FiStrokeEnd;
end;

constructor PROPERTY_METRICSWrapper.Create(ARecord: PROPERTY_METRICS);
begin
  inherited Create;
  FnLogicalMin := ARecord.nLogicalMin;
  FnLogicalMax := ARecord.nLogicalMax;
  FUnits := ARecord.Units;
  FfResolution := ARecord.fResolution;
end;

function PROPERTY_METRICSWrapper.ObjToRec: PROPERTY_METRICS;
begin
  result.nLogicalMin := FnLogicalMin;
  result.nLogicalMax := FnLogicalMax;
  result.Units := FUnits;
  result.fResolution := FfResolution;
end;

constructor PACKET_PROPERTYWrapper.Create(ARecord: PACKET_PROPERTY);
begin
  inherited Create;
  Fguid := ARecord.guid;
end;

function PACKET_PROPERTYWrapper.ObjToRec: PACKET_PROPERTY;
begin
  result.guid := Fguid;
end;



procedure TatTpcShrdLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    AddConstant('MICROSOFT_TABLETPENSERVICE_PROPERTY',MICROSOFT_TABLETPENSERVICE_PROPERTY);
    AddConstant('TABLET_DISABLE_PRESSANDHOLD',TABLET_DISABLE_PRESSANDHOLD);
    AddConstant('TABLET_DISABLE_PENTAPFEEDBACK',TABLET_DISABLE_PENTAPFEEDBACK);
    AddConstant('TABLET_DISABLE_PENBARRELFEEDBACK',TABLET_DISABLE_PENBARRELFEEDBACK);
    AddConstant('TABLET_DISABLE_TOUCHUIFORCEON',TABLET_DISABLE_TOUCHUIFORCEON);
    AddConstant('TABLET_DISABLE_TOUCHUIFORCEOFF',TABLET_DISABLE_TOUCHUIFORCEOFF);
    AddConstant('TABLET_DISABLE_TOUCHSWITCH',TABLET_DISABLE_TOUCHSWITCH);
    AddConstant('TABLET_DISABLE_FLICKS',TABLET_DISABLE_FLICKS);
    AddConstant('TABLET_ENABLE_FLICKSONCONTEXT',TABLET_ENABLE_FLICKSONCONTEXT);
    AddConstant('TABLET_ENABLE_FLICKLEARNINGMODE',TABLET_ENABLE_FLICKLEARNINGMODE);
    AddConstant('TABLET_DISABLE_SMOOTHSCROLLING',TABLET_DISABLE_SMOOTHSCROLLING);
    AddConstant('TABLET_DISABLE_FLICKFALLBACKKEYS',TABLET_DISABLE_FLICKFALLBACKKEYS);
    AddConstant('TABLET_ENABLE_MULTITOUCHDATA',TABLET_ENABLE_MULTITOUCHDATA);
    AddConstant('MAX_PACKET_PROPERTY_COUNT',MAX_PACKET_PROPERTY_COUNT);
    AddConstant('MAX_PACKET_BUTTON_COUNT',MAX_PACKET_BUTTON_COUNT);
    AddConstant('IP_CURSOR_DOWN',IP_CURSOR_DOWN);
    AddConstant('IP_INVERTED',IP_INVERTED);
    AddConstant('IP_MARGIN',IP_MARGIN);
    AddConstant('PROPERTY_UNITS_DEFAULT',PROPERTY_UNITS_DEFAULT);
    AddConstant('PROPERTY_UNITS_INCHES',PROPERTY_UNITS_INCHES);
    AddConstant('PROPERTY_UNITS_CENTIMETERS',PROPERTY_UNITS_CENTIMETERS);
    AddConstant('PROPERTY_UNITS_DEGREES',PROPERTY_UNITS_DEGREES);
    AddConstant('PROPERTY_UNITS_RADIANS',PROPERTY_UNITS_RADIANS);
    AddConstant('PROPERTY_UNITS_SECONDS',PROPERTY_UNITS_SECONDS);
    AddConstant('PROPERTY_UNITS_POUNDS',PROPERTY_UNITS_POUNDS);
    AddConstant('PROPERTY_UNITS_GRAMS',PROPERTY_UNITS_GRAMS);
    AddConstant('PROPERTY_UNITS_SILINEAR',PROPERTY_UNITS_SILINEAR);
    AddConstant('PROPERTY_UNITS_SIROTATION',PROPERTY_UNITS_SIROTATION);
    AddConstant('PROPERTY_UNITS_ENGLINEAR',PROPERTY_UNITS_ENGLINEAR);
    AddConstant('PROPERTY_UNITS_ENGROTATION',PROPERTY_UNITS_ENGROTATION);
    AddConstant('PROPERTY_UNITS_SLUGS',PROPERTY_UNITS_SLUGS);
    AddConstant('PROPERTY_UNITS_KELVIN',PROPERTY_UNITS_KELVIN);
    AddConstant('PROPERTY_UNITS_FAHRENHEIT',PROPERTY_UNITS_FAHRENHEIT);
    AddConstant('PROPERTY_UNITS_AMPERE',PROPERTY_UNITS_AMPERE);
    AddConstant('PROPERTY_UNITS_CANDELA',PROPERTY_UNITS_CANDELA);
  end;
end;

class function TatTpcShrdLibrary.LibraryName: string;
begin
  result := 'TpcShrd';
end;

initialization
  RegisterScripterLibrary(TatTpcShrdLibrary, True);

{$WARNINGS ON}

end.

