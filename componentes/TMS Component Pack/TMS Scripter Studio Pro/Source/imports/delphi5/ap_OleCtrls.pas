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
unit ap_OleCtrls;

interface

uses
  Windows,
  Messages,
  ActiveX,
  SysUtils,
  Classes,
  Controls,
  Forms,
  Menus,
  Graphics,
  ComObj,
  AxCtrls,
  OleCtrls,
  atScript;

{$WARNINGS OFF}

type
  TatOleCtrlsLibrary = class(TatScripterLibrary)
    procedure __TEventDispatchCreate(AMachine: TatVirtualMachine);
    procedure __TEnumPropDescDestroy(AMachine: TatVirtualMachine);
    procedure __TEnumPropDescStringToValue(AMachine: TatVirtualMachine);
    procedure __TEnumPropDescValueToString(AMachine: TatVirtualMachine);
    procedure __TOleControlCreate(AMachine: TatVirtualMachine);
    procedure __TOleControlDestroy(AMachine: TatVirtualMachine);
    procedure __TOleControlBrowseProperties(AMachine: TatVirtualMachine);
    procedure __TOleControlDefaultHandler(AMachine: TatVirtualMachine);
    procedure __TOleControlDoObjectVerb(AMachine: TatVirtualMachine);
    procedure __TOleControlGetEnumPropDesc(AMachine: TatVirtualMachine);
    procedure __TOleControlGetHelpContext(AMachine: TatVirtualMachine);
    procedure __TOleControlGetObjectVerbs(AMachine: TatVirtualMachine);
    procedure __TOleControlGetPropDisplayString(AMachine: TatVirtualMachine);
    procedure __TOleControlGetPropDisplayStrings(AMachine: TatVirtualMachine);
    procedure __TOleControlIsCustomProperty(AMachine: TatVirtualMachine);
    procedure __TOleControlIsPropPageProperty(AMachine: TatVirtualMachine);
    procedure __TOleControlSetBounds(AMachine: TatVirtualMachine);
    procedure __TOleControlSetPropDisplayString(AMachine: TatVirtualMachine);
    procedure __TOleControlShowAboutBox(AMachine: TatVirtualMachine);
    procedure __GetTOleControlOleObject(AMachine: TatVirtualMachine);
    procedure __FontToOleFont(AMachine: TatVirtualMachine);
    procedure __OleFontToFont(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TEventDispatchClass = class of TEventDispatch;
  TEnumPropDescClass = class of TEnumPropDesc;
  TOleControlClass = class of TOleControl;
  EOleCtrlErrorClass = class of EOleCtrlError;


  TEnumValueWrapper = class(TatRecordWrapper)
  private
    FValue: Longint;
    FIdent: string;
  public
    constructor Create(ARecord: TEnumValue);
    function ObjToRec: TEnumValue;
  published
    property Value: Longint read FValue write FValue;
    property Ident: string read FIdent write FIdent;
  end;
  
  TControlDataWrapper = class(TatRecordWrapper)
  private
    FEventCount: Longint;
    FFlags: DWORD;
    FVersion: Integer;
    FFontCount: Integer;
    FPictureCount: Integer;
    FReserved: Integer;
    FInstanceCount: Integer;
    FEnumPropDescs: TList;
  public
    constructor Create(ARecord: TControlData);
    function ObjToRec: TControlData;
  published
    property EventCount: Longint read FEventCount write FEventCount;
    property Flags: DWORD read FFlags write FFlags;
    property Version: Integer read FVersion write FVersion;
    property FontCount: Integer read FFontCount write FFontCount;
    property PictureCount: Integer read FPictureCount write FPictureCount;
    property Reserved: Integer read FReserved write FReserved;
    property InstanceCount: Integer read FInstanceCount write FInstanceCount;
    property EnumPropDescs: TList read FEnumPropDescs write FEnumPropDescs;
  end;
  
  TControlData2Wrapper = class(TatRecordWrapper)
  private
    FEventCount: Longint;
    FFlags: DWORD;
    FVersion: Integer;
    FFontCount: Integer;
    FPictureCount: Integer;
    FReserved: Integer;
    FInstanceCount: Integer;
    FEnumPropDescs: TList;
    FFirstEventOfs: Cardinal;
  public
    constructor Create(ARecord: TControlData2);
    function ObjToRec: TControlData2;
  published
    property EventCount: Longint read FEventCount write FEventCount;
    property Flags: DWORD read FFlags write FFlags;
    property Version: Integer read FVersion write FVersion;
    property FontCount: Integer read FFontCount write FFontCount;
    property PictureCount: Integer read FPictureCount write FPictureCount;
    property Reserved: Integer read FReserved write FReserved;
    property InstanceCount: Integer read FInstanceCount write FInstanceCount;
    property EnumPropDescs: TList read FEnumPropDescs write FEnumPropDescs;
    property FirstEventOfs: Cardinal read FFirstEventOfs write FFirstEventOfs;
  end;
  

implementation

constructor TEnumValueWrapper.Create(ARecord: TEnumValue);
begin
  inherited Create;
  FValue := ARecord.Value;
  FIdent := ARecord.Ident;
end;

function TEnumValueWrapper.ObjToRec: TEnumValue;
begin
  result.Value := FValue;
  result.Ident := FIdent;
end;

constructor TControlDataWrapper.Create(ARecord: TControlData);
begin
  inherited Create;
  FEventCount := ARecord.EventCount;
  FFlags := ARecord.Flags;
  FVersion := ARecord.Version;
  FFontCount := ARecord.FontCount;
  FPictureCount := ARecord.PictureCount;
  FReserved := ARecord.Reserved;
  FInstanceCount := ARecord.InstanceCount;
  FEnumPropDescs := ARecord.EnumPropDescs;
end;

function TControlDataWrapper.ObjToRec: TControlData;
begin
  result.EventCount := FEventCount;
  result.Flags := FFlags;
  result.Version := FVersion;
  result.FontCount := FFontCount;
  result.PictureCount := FPictureCount;
  result.Reserved := FReserved;
  result.InstanceCount := FInstanceCount;
  result.EnumPropDescs := FEnumPropDescs;
end;

constructor TControlData2Wrapper.Create(ARecord: TControlData2);
begin
  inherited Create;
  FEventCount := ARecord.EventCount;
  FFlags := ARecord.Flags;
  FVersion := ARecord.Version;
  FFontCount := ARecord.FontCount;
  FPictureCount := ARecord.PictureCount;
  FReserved := ARecord.Reserved;
  FInstanceCount := ARecord.InstanceCount;
  FEnumPropDescs := ARecord.EnumPropDescs;
  FFirstEventOfs := ARecord.FirstEventOfs;
end;

function TControlData2Wrapper.ObjToRec: TControlData2;
begin
  result.EventCount := FEventCount;
  result.Flags := FFlags;
  result.Version := FVersion;
  result.FontCount := FFontCount;
  result.PictureCount := FPictureCount;
  result.Reserved := FReserved;
  result.InstanceCount := FInstanceCount;
  result.EnumPropDescs := FEnumPropDescs;
  result.FirstEventOfs := FFirstEventOfs;
end;



procedure TatOleCtrlsLibrary.__TEventDispatchCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TEventDispatchClass(CurrentClass.ClassRef).Create(TOleControl(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOleCtrlsLibrary.__TEnumPropDescDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TEnumPropDesc(CurrentObject).Destroy;
  end;
end;

procedure TatOleCtrlsLibrary.__TEnumPropDescStringToValue(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TEnumPropDesc(CurrentObject).StringToValue(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOleCtrlsLibrary.__TEnumPropDescValueToString(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TEnumPropDesc(CurrentObject).ValueToString(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOleCtrlsLibrary.__TOleControlCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TOleControlClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOleCtrlsLibrary.__TOleControlDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TOleControl(CurrentObject).Destroy;
  end;
end;

procedure TatOleCtrlsLibrary.__TOleControlBrowseProperties(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TOleControl(CurrentObject).BrowseProperties;
  end;
end;

procedure TatOleCtrlsLibrary.__TOleControlDefaultHandler(AMachine: TatVirtualMachine);
  var
  Param0: Variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
    TOleControl(CurrentObject).DefaultHandler(Param0);
    SetInputArg(0,Param0);
  end;
end;

procedure TatOleCtrlsLibrary.__TOleControlDoObjectVerb(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TOleControl(CurrentObject).DoObjectVerb(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatOleCtrlsLibrary.__TOleControlGetEnumPropDesc(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TOleControl(CurrentObject).GetEnumPropDesc(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOleCtrlsLibrary.__TOleControlGetHelpContext(AMachine: TatVirtualMachine);
  var
  Param1: Integer;
  Param2: string;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
Param2 := GetInputArg(2);
AResult := TOleControl(CurrentObject).GetHelpContext(GetInputArg(0),Param1,Param2);
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
    SetInputArg(2,Param2);
  end;
end;

procedure TatOleCtrlsLibrary.__TOleControlGetObjectVerbs(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TOleControl(CurrentObject).GetObjectVerbs(TStrings(Integer(GetInputArg(0))));
  end;
end;

procedure TatOleCtrlsLibrary.__TOleControlGetPropDisplayString(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TOleControl(CurrentObject).GetPropDisplayString(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOleCtrlsLibrary.__TOleControlGetPropDisplayStrings(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TOleControl(CurrentObject).GetPropDisplayStrings(VarToInteger(GetInputArg(0)),TStrings(Integer(GetInputArg(1))));
  end;
end;

procedure TatOleCtrlsLibrary.__TOleControlIsCustomProperty(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TOleControl(CurrentObject).IsCustomProperty(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOleCtrlsLibrary.__TOleControlIsPropPageProperty(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TOleControl(CurrentObject).IsPropPageProperty(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOleCtrlsLibrary.__TOleControlSetBounds(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TOleControl(CurrentObject).SetBounds(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)));
  end;
end;

procedure TatOleCtrlsLibrary.__TOleControlSetPropDisplayString(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TOleControl(CurrentObject).SetPropDisplayString(VarToInteger(GetInputArg(0)),GetInputArg(1));
  end;
end;

procedure TatOleCtrlsLibrary.__TOleControlShowAboutBox(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TOleControl(CurrentObject).ShowAboutBox;
  end;
end;

procedure TatOleCtrlsLibrary.__GetTOleControlOleObject(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TOleControl(CurrentObject).OleObject);
  end;
end;

procedure TatOleCtrlsLibrary.__FontToOleFont(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := OleCtrls.FontToOleFont(TFont(Integer(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOleCtrlsLibrary.__OleFontToFont(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OleCtrls.OleFontToFont(GetInputArg(0),TFont(Integer(GetInputArg(1))));
  end;
end;

procedure TatOleCtrlsLibrary.Init;
begin
  With Scripter.DefineClass(TEventDispatch) do
  begin
    DefineMethod('Create',1,tkClass,TEventDispatch,__TEventDispatchCreate,true,0);
  end;
  With Scripter.DefineClass(TEnumPropDesc) do
  begin
    DefineMethod('Destroy',0,tkNone,nil,__TEnumPropDescDestroy,false,0);
    DefineMethod('StringToValue',1,tkInteger,nil,__TEnumPropDescStringToValue,false,0);
    DefineMethod('ValueToString',1,tkVariant,nil,__TEnumPropDescValueToString,false,0);
  end;
  With Scripter.DefineClass(TOleControl) do
  begin
    DefineMethod('Create',1,tkClass,TOleControl,__TOleControlCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TOleControlDestroy,false,0);
    DefineMethod('BrowseProperties',0,tkNone,nil,__TOleControlBrowseProperties,false,0);
    DefineMethod('DefaultHandler',1,tkNone,nil,__TOleControlDefaultHandler,false,0).SetVarArgs([0]);
    DefineMethod('DoObjectVerb',1,tkNone,nil,__TOleControlDoObjectVerb,false,0);
    DefineMethod('GetEnumPropDesc',1,tkClass,TEnumPropDesc,__TOleControlGetEnumPropDesc,false,0);
    DefineMethod('GetHelpContext',3,tkVariant,nil,__TOleControlGetHelpContext,false,0).SetVarArgs([1,2]);
    DefineMethod('GetObjectVerbs',1,tkNone,nil,__TOleControlGetObjectVerbs,false,0);
    DefineMethod('GetPropDisplayString',1,tkVariant,nil,__TOleControlGetPropDisplayString,false,0);
    DefineMethod('GetPropDisplayStrings',2,tkNone,nil,__TOleControlGetPropDisplayStrings,false,0);
    DefineMethod('IsCustomProperty',1,tkVariant,nil,__TOleControlIsCustomProperty,false,0);
    DefineMethod('IsPropPageProperty',1,tkVariant,nil,__TOleControlIsPropPageProperty,false,0);
    DefineMethod('SetBounds',4,tkNone,nil,__TOleControlSetBounds,false,0);
    DefineMethod('SetPropDisplayString',2,tkNone,nil,__TOleControlSetPropDisplayString,false,0);
    DefineMethod('ShowAboutBox',0,tkNone,nil,__TOleControlShowAboutBox,false,0);
    DefineProp('OleObject',tkVariant,__GetTOleControlOleObject,nil,nil,false,0);
    DefineProp('TabStop',tkVariant,nil,nil,nil,false,0);
  end;
  With Scripter.DefineClass(EOleCtrlError) do
  begin
  end;
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('FontToOleFont',1,tkVariant,nil,__FontToOleFont,false,0);
    DefineMethod('OleFontToFont',2,tkNone,nil,__OleFontToFont,false,0);
  end;
end;

class function TatOleCtrlsLibrary.LibraryName: string;
begin
  result := 'OleCtrls';
end;

initialization
  RegisterScripterLibrary(TatOleCtrlsLibrary, True);

{$WARNINGS ON}

end.

