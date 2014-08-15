{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2008                    BBBBB   }

unit ppEnum;

interface

{$I ppIfDef.pas}

uses
  Classes,
  TypInfo,
  SysUtils,
  Graphics,
  ExtCtrls,
  Printers,
  ppUtils,
  ppTypes;

  function raIsEnumValue(aWord: String; var aTypeName: String; var aValue: Integer): Boolean;
  function raEnumNameForValue(const aTypeName: String; aValue: Integer): String;
  function raEnumTypes: TStringList;
  function raEnumTypeInfo(aTypeName: String): PTypeInfo;
  function raEnumOrdType(aTypeName: String): TOrdType;

  {use to register enumerated type info}
  procedure raRegisterEnum(const aTypeName: String; aTypeInfo: Pointer);
  procedure raUnRegisterEnum(const aTypeName: String);

implementation

var
  FEnumTypeList: TStringList = nil;
  FEnumValueList: TStringList = nil;

{------------------------------------------------------------------------------}
{ raEnumValues }

function raEnumValues: TStringList;
var
  liEnumTypeIndex: Integer;
  liIndex: Integer;
  lTypeInfo: PTypeInfo;
  lList: TStrings;
begin

  {create string list}
  if (FEnumValueList = nil) then
    begin
      FEnumValueList := TStringList.Create;

      {add literal values for each type to enum value list}
      liEnumTypeIndex := 0;
      lList := TStringList.Create;

      while (liEnumTypeIndex < raEnumTypes.Count) do
        begin
          lTypeInfo := PTypeInfo(raEnumTypes.Objects[liEnumTypeIndex]);
          lList.Clear;

          ppGetEnumNames(lTypeInfo, lList);

          for liIndex := 0 to lList.Count - 1 do
            lList.Objects[liIndex] := TObject(liEnumTypeIndex);

          FEnumValueList.AddStrings(lList);

          Inc(liEnumTypeIndex);
        end;

      lList.Free;
    end;
    
  Result := FEnumValueList;


end; {function, raEnumValues}

{------------------------------------------------------------------------------}
{ raEnumTypes }

function raEnumTypes: TStringList;
begin

  if (FEnumTypeList = nil) then
    FEnumTypeList := TStringList.Create;

  Result := FEnumTypeList;

end; {function, raEnumTypes}

{------------------------------------------------------------------------------}
{ raRegisterEnum }

procedure raRegisterEnum(const aTypeName: String; aTypeInfo: Pointer);
var
  liIndex: Integer;
  lEnums: TStringList;

begin
  lEnums := raEnumTypes;

  liIndex := lEnums.IndexOf(aTypeName);

  if liIndex < 0 then
    lEnums.AddObject(aTypeName, aTypeInfo)
  else
    lEnums.Objects[liIndex] := aTypeInfo;

end; {procedure, raRegisterEnum}

{------------------------------------------------------------------------------}
{ raUnRegisterEnum }

procedure raUnRegisterEnum(const aTypeName: String);
var
  liIndex: Integer;
begin

  liIndex := raEnumTypes.IndexOf(aTypeName);

  if (liIndex >= 0) then
    raEnumTypes.Delete(liIndex);

end; {procedure, raUnRegisterEnum}

{------------------------------------------------------------------------------}
{ raEnumNameForValue }

function raEnumNameForValue(const aTypeName: String; aValue: Integer): String;
var
  liIndex: Integer;
  lTypeInfo: PTypeInfo;
begin

  liIndex := raEnumTypes.IndexOf(Lowercase(aTypeName));

  if (liIndex <> -1) then
    begin
      lTypeInfo := PTypeInfo(raEnumTypes.Objects[liIndex]);

      Result := TypInfo.GetEnumName(lTypeInfo, aValue);
    end;

end; {function, raEnumNameForValue}

{------------------------------------------------------------------------------}
{ raIsEnumValue }

function raIsEnumValue(aWord: String; var aTypeName: String; var aValue: Integer): Boolean;
var
  liIndex: Integer;
  liEnumTypeIndex: Integer;
  lTypeInfo: PTypeInfo;
begin

  Result := False;
  aTypeName := '';
  aValue := 0;

  liIndex := raEnumValues.IndexOf(aWord);

  if (liIndex <> -1) then
    begin
      liEnumTypeIndex := Integer(raEnumValues.Objects[liIndex]);

      lTypeInfo := PTypeInfo(raEnumTypes.Objects[liEnumTypeIndex]);

      aTypeName := raEnumTypes[liEnumTypeIndex];
      aValue := TypInfo.GetEnumValue(lTypeInfo, aWord);

      Result := True;
    end;

end; {function, raIsEnumValue}

{------------------------------------------------------------------------------}
{ raEnumTypeInfo }

function raEnumTypeInfo(aTypeName: String): PTypeInfo;
var
  liIndex: Integer;
begin

  liIndex := raEnumTypes.IndexOf(Lowercase(aTypeName));

  if (liIndex >= 0) then
    Result := PTypeInfo(raEnumTypes.Objects[liIndex])
  else
    Result := nil;


end;

{------------------------------------------------------------------------------}
{ raEnumOrdType }

function raEnumOrdType(aTypeName: String): TOrdType;
var
  lPTypeInfo: PTypeInfo;
  lPTypeData: PTypeData;
begin

  lPTypeInfo := raEnumTypeInfo(aTypeName);

  if lPTypeInfo <> nil then
    lPTypeData := TypInfo.GetTypeData(lPTypeInfo)
  else
    lPTypeData := nil;

  if lPTypeData <> nil then
    Result := lPTypeData.OrdType
  else
    Result := otUByte;

end;


{******************************************************************************
 *
 ** I N I T I A L I Z A T I O N   /   F I N A L I Z A T I O N
 *
{******************************************************************************}

initialization

  {enumerated type info}
  raRegisterEnum('Boolean', TypeInfo(Boolean));
  raRegisterEnum('TBrushStyle', TypeInfo(TBrushStyle));
  raRegisterEnum('TPenStyle', TypeInfo(TPenStyle));
  raRegisterEnum('TAlignment', TypeInfo(TAlignment));
  raRegisterEnum('TppBarCodeType', TypeInfo(TppBarCodeType));
  raRegisterEnum('TppBarCodeOrientation', TypeInfo(TppBarCodeOrientation));
  raRegisterEnum('Tpp2DBarCodeType', TypeInfo(Tpp2DBarCodeType));
  raRegisterEnum('TppBreakType', TypeInfo(TppBreakType));
  raRegisterEnum('TppCalcType', TypeInfo(TppCalcType));
  raRegisterEnum('TppDataType', TypeInfo(TppDataType));
  raRegisterEnum('TppDatabaseType', TypeInfo(TppDatabaseType));
  raRegisterEnum('TppDBCalcType', TypeInfo(TppDBCalcType));
  raRegisterEnum('TppDuplexType', TypeInfo(TppDuplexType));
  raRegisterEnum('TppFileType', TypeInfo(TppFileType));
  raRegisterEnum('TppFormatType', TypeInfo(TppFormatType));
  raRegisterEnum('TppLanguageType', TypeInfo(TppLanguageType));
  raRegisterEnum('TppLinePositionType', TypeInfo(TppLinePositionType));
  raRegisterEnum('TppLineStyleType', TypeInfo(TppLineStyleType));
  raRegisterEnum('TppOutlineNodeType', TypeInfo(TppOutlineNodeType));
  raRegisterEnum('TppPassSettingType', TypeInfo(TppPassSettingType));
  raRegisterEnum('TppPrintBehaviorType', TypeInfo(TppPrintBehaviorType));
  raRegisterEnum('TppPrintHeightType', TypeInfo(TppPrintHeightType));
  raRegisterEnum('TppRangeBeginType', TypeInfo(TppRangeBeginType));
  raRegisterEnum('TppRangeEndType', TypeInfo(TppRangeEndType));
  raRegisterEnum('TppSaveToType', TypeInfo(TppSaveToType));
  raRegisterEnum('TppSearchOperatorType', TypeInfo(TppSearchOperatorType));
  raRegisterEnum('TShapeType', TypeInfo(TShapeType));
  raRegisterEnum('TppSortOrderType', TypeInfo(TppSortOrderType));
  raRegisterEnum('TppTextAlignment', TypeInfo(TppTextAlignment));
  raRegisterEnum('TppUnitType', TypeInfo(TppUnitType));
  raRegisterEnum('TppVarEventType', TypeInfo(TppVarEventType));
  raRegisterEnum('TppVarType', TypeInfo(TppVarType));
  raRegisterEnum('TPrinterOrientation', TypeInfo(TPrinterOrientation));
  raRegisterEnum('TppDeviceStateType', TypeInfo(TppDeviceStateType));

 { raRegisterEnum('TraDataType', TypeInfo(TraDataType));}

finalization


  {enumerated type info}
  raUnRegisterEnum('Boolean');
  raUnRegisterEnum('TBrushStyle');
  raUnRegisterEnum('TPenStyle');
  raUnRegisterEnum('TAlignment');
  raUnRegisterEnum('TppBarCodeType');
  raUnRegisterEnum('TppBarCodeOrientation');
  raUnRegisterEnum('Tpp2DBarCodeType');
  raUnRegisterEnum('TppBreakType');
  raUnRegisterEnum('TppCalcType');
  raUnRegisterEnum('TppDataType');
  raUnRegisterEnum('TppDatabaseType');
  raUnRegisterEnum('TppDBCalcType');
  raUnRegisterEnum('TppDuplexType');
  raUnRegisterEnum('TppFileType');
  raUnRegisterEnum('TppFormatType');
  raUnRegisterEnum('TppLanguageType');
  raUnRegisterEnum('TppLinePositionType');
  raUnRegisterEnum('TppLineStyleType');
  raUnRegisterEnum('TppPassSettingType');
  raUnRegisterEnum('TppPrintBehaviorType');
  raUnRegisterEnum('TppPrintHeightType');
  raUnRegisterEnum('TppRangeBeginType');
  raUnRegisterEnum('TppRangeEndType');
  raUnRegisterEnum('TppSaveToType');
  raUnRegisterEnum('TppSearchOperatorType');
  raUnRegisterEnum('TShapeType');
  raUnRegisterEnum('TppSortOrderType');
  raUnRegisterEnum('TppTextAlignment');
  raUnRegisterEnum('TppUnitType');
  raUnRegisterEnum('TppVarEventType');
  raUnRegisterEnum('TppVarType');
  raUnRegisterEnum('TPrinterOrientation');
  raUnRegisterEnum('TppDeviceStateType');


  FEnumTypeList.Free;
  FEnumTypeList := nil;

  FEnumValueList.Free;
  FEnumValueList := nil;

end.
