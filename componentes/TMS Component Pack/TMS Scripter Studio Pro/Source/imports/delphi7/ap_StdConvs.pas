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
unit ap_StdConvs;

interface

uses
  SysUtils,
  ConvUtils,
  StdConvs,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatStdConvsLibrary = class(TatScripterLibrary)
    procedure __FahrenheitToCelsius(AMachine: TatVirtualMachine);
    procedure __CelsiusToFahrenheit(AMachine: TatVirtualMachine);
    procedure __InitStdConvs(AMachine: TatVirtualMachine);
    procedure __GetcbDistance(AMachine: TatVirtualMachine);
    procedure __SetcbDistance(AMachine: TatVirtualMachine);
    procedure __GetduMicromicrons(AMachine: TatVirtualMachine);
    procedure __SetduMicromicrons(AMachine: TatVirtualMachine);
    procedure __GetduAngstroms(AMachine: TatVirtualMachine);
    procedure __SetduAngstroms(AMachine: TatVirtualMachine);
    procedure __GetduMillimicrons(AMachine: TatVirtualMachine);
    procedure __SetduMillimicrons(AMachine: TatVirtualMachine);
    procedure __GetduMicrons(AMachine: TatVirtualMachine);
    procedure __SetduMicrons(AMachine: TatVirtualMachine);
    procedure __GetduMillimeters(AMachine: TatVirtualMachine);
    procedure __SetduMillimeters(AMachine: TatVirtualMachine);
    procedure __GetduCentimeters(AMachine: TatVirtualMachine);
    procedure __SetduCentimeters(AMachine: TatVirtualMachine);
    procedure __GetduDecimeters(AMachine: TatVirtualMachine);
    procedure __SetduDecimeters(AMachine: TatVirtualMachine);
    procedure __GetduMeters(AMachine: TatVirtualMachine);
    procedure __SetduMeters(AMachine: TatVirtualMachine);
    procedure __GetduDecameters(AMachine: TatVirtualMachine);
    procedure __SetduDecameters(AMachine: TatVirtualMachine);
    procedure __GetduHectometers(AMachine: TatVirtualMachine);
    procedure __SetduHectometers(AMachine: TatVirtualMachine);
    procedure __GetduKilometers(AMachine: TatVirtualMachine);
    procedure __SetduKilometers(AMachine: TatVirtualMachine);
    procedure __GetduMegameters(AMachine: TatVirtualMachine);
    procedure __SetduMegameters(AMachine: TatVirtualMachine);
    procedure __GetduGigameters(AMachine: TatVirtualMachine);
    procedure __SetduGigameters(AMachine: TatVirtualMachine);
    procedure __GetduInches(AMachine: TatVirtualMachine);
    procedure __SetduInches(AMachine: TatVirtualMachine);
    procedure __GetduFeet(AMachine: TatVirtualMachine);
    procedure __SetduFeet(AMachine: TatVirtualMachine);
    procedure __GetduYards(AMachine: TatVirtualMachine);
    procedure __SetduYards(AMachine: TatVirtualMachine);
    procedure __GetduMiles(AMachine: TatVirtualMachine);
    procedure __SetduMiles(AMachine: TatVirtualMachine);
    procedure __GetduNauticalMiles(AMachine: TatVirtualMachine);
    procedure __SetduNauticalMiles(AMachine: TatVirtualMachine);
    procedure __GetduAstronomicalUnits(AMachine: TatVirtualMachine);
    procedure __SetduAstronomicalUnits(AMachine: TatVirtualMachine);
    procedure __GetduLightYears(AMachine: TatVirtualMachine);
    procedure __SetduLightYears(AMachine: TatVirtualMachine);
    procedure __GetduParsecs(AMachine: TatVirtualMachine);
    procedure __SetduParsecs(AMachine: TatVirtualMachine);
    procedure __GetduCubits(AMachine: TatVirtualMachine);
    procedure __SetduCubits(AMachine: TatVirtualMachine);
    procedure __GetduFathoms(AMachine: TatVirtualMachine);
    procedure __SetduFathoms(AMachine: TatVirtualMachine);
    procedure __GetduFurlongs(AMachine: TatVirtualMachine);
    procedure __SetduFurlongs(AMachine: TatVirtualMachine);
    procedure __GetduHands(AMachine: TatVirtualMachine);
    procedure __SetduHands(AMachine: TatVirtualMachine);
    procedure __GetduPaces(AMachine: TatVirtualMachine);
    procedure __SetduPaces(AMachine: TatVirtualMachine);
    procedure __GetduRods(AMachine: TatVirtualMachine);
    procedure __SetduRods(AMachine: TatVirtualMachine);
    procedure __GetduChains(AMachine: TatVirtualMachine);
    procedure __SetduChains(AMachine: TatVirtualMachine);
    procedure __GetduLinks(AMachine: TatVirtualMachine);
    procedure __SetduLinks(AMachine: TatVirtualMachine);
    procedure __GetduPicas(AMachine: TatVirtualMachine);
    procedure __SetduPicas(AMachine: TatVirtualMachine);
    procedure __GetduPoints(AMachine: TatVirtualMachine);
    procedure __SetduPoints(AMachine: TatVirtualMachine);
    procedure __GetcbArea(AMachine: TatVirtualMachine);
    procedure __SetcbArea(AMachine: TatVirtualMachine);
    procedure __GetauSquareMillimeters(AMachine: TatVirtualMachine);
    procedure __SetauSquareMillimeters(AMachine: TatVirtualMachine);
    procedure __GetauSquareCentimeters(AMachine: TatVirtualMachine);
    procedure __SetauSquareCentimeters(AMachine: TatVirtualMachine);
    procedure __GetauSquareDecimeters(AMachine: TatVirtualMachine);
    procedure __SetauSquareDecimeters(AMachine: TatVirtualMachine);
    procedure __GetauSquareMeters(AMachine: TatVirtualMachine);
    procedure __SetauSquareMeters(AMachine: TatVirtualMachine);
    procedure __GetauSquareDecameters(AMachine: TatVirtualMachine);
    procedure __SetauSquareDecameters(AMachine: TatVirtualMachine);
    procedure __GetauSquareHectometers(AMachine: TatVirtualMachine);
    procedure __SetauSquareHectometers(AMachine: TatVirtualMachine);
    procedure __GetauSquareKilometers(AMachine: TatVirtualMachine);
    procedure __SetauSquareKilometers(AMachine: TatVirtualMachine);
    procedure __GetauSquareInches(AMachine: TatVirtualMachine);
    procedure __SetauSquareInches(AMachine: TatVirtualMachine);
    procedure __GetauSquareFeet(AMachine: TatVirtualMachine);
    procedure __SetauSquareFeet(AMachine: TatVirtualMachine);
    procedure __GetauSquareYards(AMachine: TatVirtualMachine);
    procedure __SetauSquareYards(AMachine: TatVirtualMachine);
    procedure __GetauSquareMiles(AMachine: TatVirtualMachine);
    procedure __SetauSquareMiles(AMachine: TatVirtualMachine);
    procedure __GetauAcres(AMachine: TatVirtualMachine);
    procedure __SetauAcres(AMachine: TatVirtualMachine);
    procedure __GetauCentares(AMachine: TatVirtualMachine);
    procedure __SetauCentares(AMachine: TatVirtualMachine);
    procedure __GetauAres(AMachine: TatVirtualMachine);
    procedure __SetauAres(AMachine: TatVirtualMachine);
    procedure __GetauHectares(AMachine: TatVirtualMachine);
    procedure __SetauHectares(AMachine: TatVirtualMachine);
    procedure __GetauSquareRods(AMachine: TatVirtualMachine);
    procedure __SetauSquareRods(AMachine: TatVirtualMachine);
    procedure __GetcbVolume(AMachine: TatVirtualMachine);
    procedure __SetcbVolume(AMachine: TatVirtualMachine);
    procedure __GetvuCubicMillimeters(AMachine: TatVirtualMachine);
    procedure __SetvuCubicMillimeters(AMachine: TatVirtualMachine);
    procedure __GetvuCubicCentimeters(AMachine: TatVirtualMachine);
    procedure __SetvuCubicCentimeters(AMachine: TatVirtualMachine);
    procedure __GetvuCubicDecimeters(AMachine: TatVirtualMachine);
    procedure __SetvuCubicDecimeters(AMachine: TatVirtualMachine);
    procedure __GetvuCubicMeters(AMachine: TatVirtualMachine);
    procedure __SetvuCubicMeters(AMachine: TatVirtualMachine);
    procedure __GetvuCubicDecameters(AMachine: TatVirtualMachine);
    procedure __SetvuCubicDecameters(AMachine: TatVirtualMachine);
    procedure __GetvuCubicHectometers(AMachine: TatVirtualMachine);
    procedure __SetvuCubicHectometers(AMachine: TatVirtualMachine);
    procedure __GetvuCubicKilometers(AMachine: TatVirtualMachine);
    procedure __SetvuCubicKilometers(AMachine: TatVirtualMachine);
    procedure __GetvuCubicInches(AMachine: TatVirtualMachine);
    procedure __SetvuCubicInches(AMachine: TatVirtualMachine);
    procedure __GetvuCubicFeet(AMachine: TatVirtualMachine);
    procedure __SetvuCubicFeet(AMachine: TatVirtualMachine);
    procedure __GetvuCubicYards(AMachine: TatVirtualMachine);
    procedure __SetvuCubicYards(AMachine: TatVirtualMachine);
    procedure __GetvuCubicMiles(AMachine: TatVirtualMachine);
    procedure __SetvuCubicMiles(AMachine: TatVirtualMachine);
    procedure __GetvuMilliLiters(AMachine: TatVirtualMachine);
    procedure __SetvuMilliLiters(AMachine: TatVirtualMachine);
    procedure __GetvuCentiLiters(AMachine: TatVirtualMachine);
    procedure __SetvuCentiLiters(AMachine: TatVirtualMachine);
    procedure __GetvuDeciLiters(AMachine: TatVirtualMachine);
    procedure __SetvuDeciLiters(AMachine: TatVirtualMachine);
    procedure __GetvuLiters(AMachine: TatVirtualMachine);
    procedure __SetvuLiters(AMachine: TatVirtualMachine);
    procedure __GetvuDecaLiters(AMachine: TatVirtualMachine);
    procedure __SetvuDecaLiters(AMachine: TatVirtualMachine);
    procedure __GetvuHectoLiters(AMachine: TatVirtualMachine);
    procedure __SetvuHectoLiters(AMachine: TatVirtualMachine);
    procedure __GetvuKiloLiters(AMachine: TatVirtualMachine);
    procedure __SetvuKiloLiters(AMachine: TatVirtualMachine);
    procedure __GetvuAcreFeet(AMachine: TatVirtualMachine);
    procedure __SetvuAcreFeet(AMachine: TatVirtualMachine);
    procedure __GetvuAcreInches(AMachine: TatVirtualMachine);
    procedure __SetvuAcreInches(AMachine: TatVirtualMachine);
    procedure __GetvuCords(AMachine: TatVirtualMachine);
    procedure __SetvuCords(AMachine: TatVirtualMachine);
    procedure __GetvuCordFeet(AMachine: TatVirtualMachine);
    procedure __SetvuCordFeet(AMachine: TatVirtualMachine);
    procedure __GetvuDecisteres(AMachine: TatVirtualMachine);
    procedure __SetvuDecisteres(AMachine: TatVirtualMachine);
    procedure __GetvuSteres(AMachine: TatVirtualMachine);
    procedure __SetvuSteres(AMachine: TatVirtualMachine);
    procedure __GetvuDecasteres(AMachine: TatVirtualMachine);
    procedure __SetvuDecasteres(AMachine: TatVirtualMachine);
    procedure __GetvuFluidGallons(AMachine: TatVirtualMachine);
    procedure __SetvuFluidGallons(AMachine: TatVirtualMachine);
    procedure __GetvuFluidQuarts(AMachine: TatVirtualMachine);
    procedure __SetvuFluidQuarts(AMachine: TatVirtualMachine);
    procedure __GetvuFluidPints(AMachine: TatVirtualMachine);
    procedure __SetvuFluidPints(AMachine: TatVirtualMachine);
    procedure __GetvuFluidCups(AMachine: TatVirtualMachine);
    procedure __SetvuFluidCups(AMachine: TatVirtualMachine);
    procedure __GetvuFluidGills(AMachine: TatVirtualMachine);
    procedure __SetvuFluidGills(AMachine: TatVirtualMachine);
    procedure __GetvuFluidOunces(AMachine: TatVirtualMachine);
    procedure __SetvuFluidOunces(AMachine: TatVirtualMachine);
    procedure __GetvuFluidTablespoons(AMachine: TatVirtualMachine);
    procedure __SetvuFluidTablespoons(AMachine: TatVirtualMachine);
    procedure __GetvuFluidTeaspoons(AMachine: TatVirtualMachine);
    procedure __SetvuFluidTeaspoons(AMachine: TatVirtualMachine);
    procedure __GetvuDryGallons(AMachine: TatVirtualMachine);
    procedure __SetvuDryGallons(AMachine: TatVirtualMachine);
    procedure __GetvuDryQuarts(AMachine: TatVirtualMachine);
    procedure __SetvuDryQuarts(AMachine: TatVirtualMachine);
    procedure __GetvuDryPints(AMachine: TatVirtualMachine);
    procedure __SetvuDryPints(AMachine: TatVirtualMachine);
    procedure __GetvuDryPecks(AMachine: TatVirtualMachine);
    procedure __SetvuDryPecks(AMachine: TatVirtualMachine);
    procedure __GetvuDryBuckets(AMachine: TatVirtualMachine);
    procedure __SetvuDryBuckets(AMachine: TatVirtualMachine);
    procedure __GetvuDryBushels(AMachine: TatVirtualMachine);
    procedure __SetvuDryBushels(AMachine: TatVirtualMachine);
    procedure __GetvuUKGallons(AMachine: TatVirtualMachine);
    procedure __SetvuUKGallons(AMachine: TatVirtualMachine);
    procedure __GetvuUKPottles(AMachine: TatVirtualMachine);
    procedure __SetvuUKPottles(AMachine: TatVirtualMachine);
    procedure __GetvuUKQuarts(AMachine: TatVirtualMachine);
    procedure __SetvuUKQuarts(AMachine: TatVirtualMachine);
    procedure __GetvuUKPints(AMachine: TatVirtualMachine);
    procedure __SetvuUKPints(AMachine: TatVirtualMachine);
    procedure __GetvuUKGills(AMachine: TatVirtualMachine);
    procedure __SetvuUKGills(AMachine: TatVirtualMachine);
    procedure __GetvuUKOunces(AMachine: TatVirtualMachine);
    procedure __SetvuUKOunces(AMachine: TatVirtualMachine);
    procedure __GetvuUKPecks(AMachine: TatVirtualMachine);
    procedure __SetvuUKPecks(AMachine: TatVirtualMachine);
    procedure __GetvuUKBuckets(AMachine: TatVirtualMachine);
    procedure __SetvuUKBuckets(AMachine: TatVirtualMachine);
    procedure __GetvuUKBushels(AMachine: TatVirtualMachine);
    procedure __SetvuUKBushels(AMachine: TatVirtualMachine);
    procedure __GetcbMass(AMachine: TatVirtualMachine);
    procedure __SetcbMass(AMachine: TatVirtualMachine);
    procedure __GetmuNanograms(AMachine: TatVirtualMachine);
    procedure __SetmuNanograms(AMachine: TatVirtualMachine);
    procedure __GetmuMicrograms(AMachine: TatVirtualMachine);
    procedure __SetmuMicrograms(AMachine: TatVirtualMachine);
    procedure __GetmuMilligrams(AMachine: TatVirtualMachine);
    procedure __SetmuMilligrams(AMachine: TatVirtualMachine);
    procedure __GetmuCentigrams(AMachine: TatVirtualMachine);
    procedure __SetmuCentigrams(AMachine: TatVirtualMachine);
    procedure __GetmuDecigrams(AMachine: TatVirtualMachine);
    procedure __SetmuDecigrams(AMachine: TatVirtualMachine);
    procedure __GetmuGrams(AMachine: TatVirtualMachine);
    procedure __SetmuGrams(AMachine: TatVirtualMachine);
    procedure __GetmuDecagrams(AMachine: TatVirtualMachine);
    procedure __SetmuDecagrams(AMachine: TatVirtualMachine);
    procedure __GetmuHectograms(AMachine: TatVirtualMachine);
    procedure __SetmuHectograms(AMachine: TatVirtualMachine);
    procedure __GetmuKilograms(AMachine: TatVirtualMachine);
    procedure __SetmuKilograms(AMachine: TatVirtualMachine);
    procedure __GetmuMetricTons(AMachine: TatVirtualMachine);
    procedure __SetmuMetricTons(AMachine: TatVirtualMachine);
    procedure __GetmuDrams(AMachine: TatVirtualMachine);
    procedure __SetmuDrams(AMachine: TatVirtualMachine);
    procedure __GetmuGrains(AMachine: TatVirtualMachine);
    procedure __SetmuGrains(AMachine: TatVirtualMachine);
    procedure __GetmuLongTons(AMachine: TatVirtualMachine);
    procedure __SetmuLongTons(AMachine: TatVirtualMachine);
    procedure __GetmuTons(AMachine: TatVirtualMachine);
    procedure __SetmuTons(AMachine: TatVirtualMachine);
    procedure __GetmuOunces(AMachine: TatVirtualMachine);
    procedure __SetmuOunces(AMachine: TatVirtualMachine);
    procedure __GetmuPounds(AMachine: TatVirtualMachine);
    procedure __SetmuPounds(AMachine: TatVirtualMachine);
    procedure __GetmuStones(AMachine: TatVirtualMachine);
    procedure __SetmuStones(AMachine: TatVirtualMachine);
    procedure __GetcbTemperature(AMachine: TatVirtualMachine);
    procedure __SetcbTemperature(AMachine: TatVirtualMachine);
    procedure __GettuCelsius(AMachine: TatVirtualMachine);
    procedure __SettuCelsius(AMachine: TatVirtualMachine);
    procedure __GettuKelvin(AMachine: TatVirtualMachine);
    procedure __SettuKelvin(AMachine: TatVirtualMachine);
    procedure __GettuFahrenheit(AMachine: TatVirtualMachine);
    procedure __SettuFahrenheit(AMachine: TatVirtualMachine);
    procedure __GettuRankine(AMachine: TatVirtualMachine);
    procedure __SettuRankine(AMachine: TatVirtualMachine);
    procedure __GettuReaumur(AMachine: TatVirtualMachine);
    procedure __SettuReaumur(AMachine: TatVirtualMachine);
    procedure __GetcbTime(AMachine: TatVirtualMachine);
    procedure __SetcbTime(AMachine: TatVirtualMachine);
    procedure __GettuMilliSeconds(AMachine: TatVirtualMachine);
    procedure __SettuMilliSeconds(AMachine: TatVirtualMachine);
    procedure __GettuSeconds(AMachine: TatVirtualMachine);
    procedure __SettuSeconds(AMachine: TatVirtualMachine);
    procedure __GettuMinutes(AMachine: TatVirtualMachine);
    procedure __SettuMinutes(AMachine: TatVirtualMachine);
    procedure __GettuHours(AMachine: TatVirtualMachine);
    procedure __SettuHours(AMachine: TatVirtualMachine);
    procedure __GettuDays(AMachine: TatVirtualMachine);
    procedure __SettuDays(AMachine: TatVirtualMachine);
    procedure __GettuWeeks(AMachine: TatVirtualMachine);
    procedure __SettuWeeks(AMachine: TatVirtualMachine);
    procedure __GettuFortnights(AMachine: TatVirtualMachine);
    procedure __SettuFortnights(AMachine: TatVirtualMachine);
    procedure __GettuMonths(AMachine: TatVirtualMachine);
    procedure __SettuMonths(AMachine: TatVirtualMachine);
    procedure __GettuYears(AMachine: TatVirtualMachine);
    procedure __SettuYears(AMachine: TatVirtualMachine);
    procedure __GettuDecades(AMachine: TatVirtualMachine);
    procedure __SettuDecades(AMachine: TatVirtualMachine);
    procedure __GettuCenturies(AMachine: TatVirtualMachine);
    procedure __SettuCenturies(AMachine: TatVirtualMachine);
    procedure __GettuMillennia(AMachine: TatVirtualMachine);
    procedure __SettuMillennia(AMachine: TatVirtualMachine);
    procedure __GettuDateTime(AMachine: TatVirtualMachine);
    procedure __SettuDateTime(AMachine: TatVirtualMachine);
    procedure __GettuJulianDate(AMachine: TatVirtualMachine);
    procedure __SettuJulianDate(AMachine: TatVirtualMachine);
    procedure __GettuModifiedJulianDate(AMachine: TatVirtualMachine);
    procedure __SettuModifiedJulianDate(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;




implementation



procedure TatStdConvsLibrary.__FahrenheitToCelsius(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := StdConvs.FahrenheitToCelsius(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatStdConvsLibrary.__CelsiusToFahrenheit(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := StdConvs.CelsiusToFahrenheit(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatStdConvsLibrary.__InitStdConvs(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.InitStdConvs;
  end;
end;

procedure TatStdConvsLibrary.__GetcbDistance(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.cbDistance));
  end;
end;

procedure TatStdConvsLibrary.__SetcbDistance(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.cbDistance:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetduMicromicrons(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.duMicromicrons));
  end;
end;

procedure TatStdConvsLibrary.__SetduMicromicrons(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.duMicromicrons:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetduAngstroms(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.duAngstroms));
  end;
end;

procedure TatStdConvsLibrary.__SetduAngstroms(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.duAngstroms:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetduMillimicrons(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.duMillimicrons));
  end;
end;

procedure TatStdConvsLibrary.__SetduMillimicrons(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.duMillimicrons:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetduMicrons(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.duMicrons));
  end;
end;

procedure TatStdConvsLibrary.__SetduMicrons(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.duMicrons:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetduMillimeters(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.duMillimeters));
  end;
end;

procedure TatStdConvsLibrary.__SetduMillimeters(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.duMillimeters:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetduCentimeters(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.duCentimeters));
  end;
end;

procedure TatStdConvsLibrary.__SetduCentimeters(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.duCentimeters:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetduDecimeters(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.duDecimeters));
  end;
end;

procedure TatStdConvsLibrary.__SetduDecimeters(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.duDecimeters:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetduMeters(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.duMeters));
  end;
end;

procedure TatStdConvsLibrary.__SetduMeters(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.duMeters:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetduDecameters(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.duDecameters));
  end;
end;

procedure TatStdConvsLibrary.__SetduDecameters(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.duDecameters:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetduHectometers(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.duHectometers));
  end;
end;

procedure TatStdConvsLibrary.__SetduHectometers(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.duHectometers:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetduKilometers(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.duKilometers));
  end;
end;

procedure TatStdConvsLibrary.__SetduKilometers(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.duKilometers:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetduMegameters(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.duMegameters));
  end;
end;

procedure TatStdConvsLibrary.__SetduMegameters(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.duMegameters:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetduGigameters(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.duGigameters));
  end;
end;

procedure TatStdConvsLibrary.__SetduGigameters(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.duGigameters:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetduInches(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.duInches));
  end;
end;

procedure TatStdConvsLibrary.__SetduInches(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.duInches:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetduFeet(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.duFeet));
  end;
end;

procedure TatStdConvsLibrary.__SetduFeet(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.duFeet:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetduYards(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.duYards));
  end;
end;

procedure TatStdConvsLibrary.__SetduYards(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.duYards:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetduMiles(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.duMiles));
  end;
end;

procedure TatStdConvsLibrary.__SetduMiles(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.duMiles:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetduNauticalMiles(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.duNauticalMiles));
  end;
end;

procedure TatStdConvsLibrary.__SetduNauticalMiles(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.duNauticalMiles:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetduAstronomicalUnits(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.duAstronomicalUnits));
  end;
end;

procedure TatStdConvsLibrary.__SetduAstronomicalUnits(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.duAstronomicalUnits:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetduLightYears(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.duLightYears));
  end;
end;

procedure TatStdConvsLibrary.__SetduLightYears(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.duLightYears:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetduParsecs(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.duParsecs));
  end;
end;

procedure TatStdConvsLibrary.__SetduParsecs(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.duParsecs:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetduCubits(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.duCubits));
  end;
end;

procedure TatStdConvsLibrary.__SetduCubits(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.duCubits:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetduFathoms(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.duFathoms));
  end;
end;

procedure TatStdConvsLibrary.__SetduFathoms(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.duFathoms:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetduFurlongs(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.duFurlongs));
  end;
end;

procedure TatStdConvsLibrary.__SetduFurlongs(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.duFurlongs:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetduHands(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.duHands));
  end;
end;

procedure TatStdConvsLibrary.__SetduHands(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.duHands:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetduPaces(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.duPaces));
  end;
end;

procedure TatStdConvsLibrary.__SetduPaces(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.duPaces:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetduRods(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.duRods));
  end;
end;

procedure TatStdConvsLibrary.__SetduRods(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.duRods:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetduChains(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.duChains));
  end;
end;

procedure TatStdConvsLibrary.__SetduChains(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.duChains:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetduLinks(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.duLinks));
  end;
end;

procedure TatStdConvsLibrary.__SetduLinks(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.duLinks:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetduPicas(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.duPicas));
  end;
end;

procedure TatStdConvsLibrary.__SetduPicas(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.duPicas:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetduPoints(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.duPoints));
  end;
end;

procedure TatStdConvsLibrary.__SetduPoints(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.duPoints:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetcbArea(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.cbArea));
  end;
end;

procedure TatStdConvsLibrary.__SetcbArea(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.cbArea:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetauSquareMillimeters(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.auSquareMillimeters));
  end;
end;

procedure TatStdConvsLibrary.__SetauSquareMillimeters(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.auSquareMillimeters:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetauSquareCentimeters(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.auSquareCentimeters));
  end;
end;

procedure TatStdConvsLibrary.__SetauSquareCentimeters(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.auSquareCentimeters:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetauSquareDecimeters(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.auSquareDecimeters));
  end;
end;

procedure TatStdConvsLibrary.__SetauSquareDecimeters(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.auSquareDecimeters:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetauSquareMeters(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.auSquareMeters));
  end;
end;

procedure TatStdConvsLibrary.__SetauSquareMeters(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.auSquareMeters:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetauSquareDecameters(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.auSquareDecameters));
  end;
end;

procedure TatStdConvsLibrary.__SetauSquareDecameters(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.auSquareDecameters:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetauSquareHectometers(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.auSquareHectometers));
  end;
end;

procedure TatStdConvsLibrary.__SetauSquareHectometers(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.auSquareHectometers:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetauSquareKilometers(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.auSquareKilometers));
  end;
end;

procedure TatStdConvsLibrary.__SetauSquareKilometers(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.auSquareKilometers:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetauSquareInches(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.auSquareInches));
  end;
end;

procedure TatStdConvsLibrary.__SetauSquareInches(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.auSquareInches:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetauSquareFeet(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.auSquareFeet));
  end;
end;

procedure TatStdConvsLibrary.__SetauSquareFeet(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.auSquareFeet:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetauSquareYards(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.auSquareYards));
  end;
end;

procedure TatStdConvsLibrary.__SetauSquareYards(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.auSquareYards:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetauSquareMiles(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.auSquareMiles));
  end;
end;

procedure TatStdConvsLibrary.__SetauSquareMiles(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.auSquareMiles:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetauAcres(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.auAcres));
  end;
end;

procedure TatStdConvsLibrary.__SetauAcres(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.auAcres:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetauCentares(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.auCentares));
  end;
end;

procedure TatStdConvsLibrary.__SetauCentares(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.auCentares:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetauAres(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.auAres));
  end;
end;

procedure TatStdConvsLibrary.__SetauAres(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.auAres:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetauHectares(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.auHectares));
  end;
end;

procedure TatStdConvsLibrary.__SetauHectares(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.auHectares:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetauSquareRods(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.auSquareRods));
  end;
end;

procedure TatStdConvsLibrary.__SetauSquareRods(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.auSquareRods:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetcbVolume(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.cbVolume));
  end;
end;

procedure TatStdConvsLibrary.__SetcbVolume(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.cbVolume:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetvuCubicMillimeters(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.vuCubicMillimeters));
  end;
end;

procedure TatStdConvsLibrary.__SetvuCubicMillimeters(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.vuCubicMillimeters:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetvuCubicCentimeters(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.vuCubicCentimeters));
  end;
end;

procedure TatStdConvsLibrary.__SetvuCubicCentimeters(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.vuCubicCentimeters:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetvuCubicDecimeters(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.vuCubicDecimeters));
  end;
end;

procedure TatStdConvsLibrary.__SetvuCubicDecimeters(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.vuCubicDecimeters:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetvuCubicMeters(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.vuCubicMeters));
  end;
end;

procedure TatStdConvsLibrary.__SetvuCubicMeters(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.vuCubicMeters:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetvuCubicDecameters(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.vuCubicDecameters));
  end;
end;

procedure TatStdConvsLibrary.__SetvuCubicDecameters(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.vuCubicDecameters:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetvuCubicHectometers(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.vuCubicHectometers));
  end;
end;

procedure TatStdConvsLibrary.__SetvuCubicHectometers(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.vuCubicHectometers:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetvuCubicKilometers(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.vuCubicKilometers));
  end;
end;

procedure TatStdConvsLibrary.__SetvuCubicKilometers(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.vuCubicKilometers:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetvuCubicInches(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.vuCubicInches));
  end;
end;

procedure TatStdConvsLibrary.__SetvuCubicInches(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.vuCubicInches:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetvuCubicFeet(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.vuCubicFeet));
  end;
end;

procedure TatStdConvsLibrary.__SetvuCubicFeet(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.vuCubicFeet:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetvuCubicYards(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.vuCubicYards));
  end;
end;

procedure TatStdConvsLibrary.__SetvuCubicYards(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.vuCubicYards:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetvuCubicMiles(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.vuCubicMiles));
  end;
end;

procedure TatStdConvsLibrary.__SetvuCubicMiles(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.vuCubicMiles:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetvuMilliLiters(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.vuMilliLiters));
  end;
end;

procedure TatStdConvsLibrary.__SetvuMilliLiters(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.vuMilliLiters:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetvuCentiLiters(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.vuCentiLiters));
  end;
end;

procedure TatStdConvsLibrary.__SetvuCentiLiters(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.vuCentiLiters:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetvuDeciLiters(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.vuDeciLiters));
  end;
end;

procedure TatStdConvsLibrary.__SetvuDeciLiters(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.vuDeciLiters:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetvuLiters(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.vuLiters));
  end;
end;

procedure TatStdConvsLibrary.__SetvuLiters(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.vuLiters:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetvuDecaLiters(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.vuDecaLiters));
  end;
end;

procedure TatStdConvsLibrary.__SetvuDecaLiters(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.vuDecaLiters:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetvuHectoLiters(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.vuHectoLiters));
  end;
end;

procedure TatStdConvsLibrary.__SetvuHectoLiters(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.vuHectoLiters:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetvuKiloLiters(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.vuKiloLiters));
  end;
end;

procedure TatStdConvsLibrary.__SetvuKiloLiters(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.vuKiloLiters:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetvuAcreFeet(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.vuAcreFeet));
  end;
end;

procedure TatStdConvsLibrary.__SetvuAcreFeet(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.vuAcreFeet:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetvuAcreInches(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.vuAcreInches));
  end;
end;

procedure TatStdConvsLibrary.__SetvuAcreInches(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.vuAcreInches:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetvuCords(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.vuCords));
  end;
end;

procedure TatStdConvsLibrary.__SetvuCords(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.vuCords:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetvuCordFeet(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.vuCordFeet));
  end;
end;

procedure TatStdConvsLibrary.__SetvuCordFeet(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.vuCordFeet:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetvuDecisteres(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.vuDecisteres));
  end;
end;

procedure TatStdConvsLibrary.__SetvuDecisteres(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.vuDecisteres:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetvuSteres(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.vuSteres));
  end;
end;

procedure TatStdConvsLibrary.__SetvuSteres(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.vuSteres:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetvuDecasteres(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.vuDecasteres));
  end;
end;

procedure TatStdConvsLibrary.__SetvuDecasteres(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.vuDecasteres:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetvuFluidGallons(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.vuFluidGallons));
  end;
end;

procedure TatStdConvsLibrary.__SetvuFluidGallons(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.vuFluidGallons:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetvuFluidQuarts(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.vuFluidQuarts));
  end;
end;

procedure TatStdConvsLibrary.__SetvuFluidQuarts(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.vuFluidQuarts:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetvuFluidPints(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.vuFluidPints));
  end;
end;

procedure TatStdConvsLibrary.__SetvuFluidPints(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.vuFluidPints:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetvuFluidCups(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.vuFluidCups));
  end;
end;

procedure TatStdConvsLibrary.__SetvuFluidCups(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.vuFluidCups:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetvuFluidGills(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.vuFluidGills));
  end;
end;

procedure TatStdConvsLibrary.__SetvuFluidGills(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.vuFluidGills:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetvuFluidOunces(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.vuFluidOunces));
  end;
end;

procedure TatStdConvsLibrary.__SetvuFluidOunces(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.vuFluidOunces:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetvuFluidTablespoons(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.vuFluidTablespoons));
  end;
end;

procedure TatStdConvsLibrary.__SetvuFluidTablespoons(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.vuFluidTablespoons:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetvuFluidTeaspoons(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.vuFluidTeaspoons));
  end;
end;

procedure TatStdConvsLibrary.__SetvuFluidTeaspoons(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.vuFluidTeaspoons:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetvuDryGallons(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.vuDryGallons));
  end;
end;

procedure TatStdConvsLibrary.__SetvuDryGallons(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.vuDryGallons:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetvuDryQuarts(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.vuDryQuarts));
  end;
end;

procedure TatStdConvsLibrary.__SetvuDryQuarts(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.vuDryQuarts:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetvuDryPints(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.vuDryPints));
  end;
end;

procedure TatStdConvsLibrary.__SetvuDryPints(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.vuDryPints:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetvuDryPecks(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.vuDryPecks));
  end;
end;

procedure TatStdConvsLibrary.__SetvuDryPecks(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.vuDryPecks:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetvuDryBuckets(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.vuDryBuckets));
  end;
end;

procedure TatStdConvsLibrary.__SetvuDryBuckets(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.vuDryBuckets:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetvuDryBushels(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.vuDryBushels));
  end;
end;

procedure TatStdConvsLibrary.__SetvuDryBushels(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.vuDryBushels:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetvuUKGallons(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.vuUKGallons));
  end;
end;

procedure TatStdConvsLibrary.__SetvuUKGallons(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.vuUKGallons:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetvuUKPottles(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.vuUKPottles));
  end;
end;

procedure TatStdConvsLibrary.__SetvuUKPottles(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.vuUKPottles:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetvuUKQuarts(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.vuUKQuarts));
  end;
end;

procedure TatStdConvsLibrary.__SetvuUKQuarts(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.vuUKQuarts:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetvuUKPints(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.vuUKPints));
  end;
end;

procedure TatStdConvsLibrary.__SetvuUKPints(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.vuUKPints:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetvuUKGills(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.vuUKGills));
  end;
end;

procedure TatStdConvsLibrary.__SetvuUKGills(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.vuUKGills:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetvuUKOunces(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.vuUKOunces));
  end;
end;

procedure TatStdConvsLibrary.__SetvuUKOunces(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.vuUKOunces:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetvuUKPecks(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.vuUKPecks));
  end;
end;

procedure TatStdConvsLibrary.__SetvuUKPecks(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.vuUKPecks:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetvuUKBuckets(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.vuUKBuckets));
  end;
end;

procedure TatStdConvsLibrary.__SetvuUKBuckets(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.vuUKBuckets:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetvuUKBushels(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.vuUKBushels));
  end;
end;

procedure TatStdConvsLibrary.__SetvuUKBushels(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.vuUKBushels:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetcbMass(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.cbMass));
  end;
end;

procedure TatStdConvsLibrary.__SetcbMass(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.cbMass:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetmuNanograms(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.muNanograms));
  end;
end;

procedure TatStdConvsLibrary.__SetmuNanograms(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.muNanograms:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetmuMicrograms(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.muMicrograms));
  end;
end;

procedure TatStdConvsLibrary.__SetmuMicrograms(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.muMicrograms:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetmuMilligrams(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.muMilligrams));
  end;
end;

procedure TatStdConvsLibrary.__SetmuMilligrams(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.muMilligrams:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetmuCentigrams(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.muCentigrams));
  end;
end;

procedure TatStdConvsLibrary.__SetmuCentigrams(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.muCentigrams:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetmuDecigrams(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.muDecigrams));
  end;
end;

procedure TatStdConvsLibrary.__SetmuDecigrams(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.muDecigrams:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetmuGrams(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.muGrams));
  end;
end;

procedure TatStdConvsLibrary.__SetmuGrams(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.muGrams:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetmuDecagrams(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.muDecagrams));
  end;
end;

procedure TatStdConvsLibrary.__SetmuDecagrams(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.muDecagrams:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetmuHectograms(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.muHectograms));
  end;
end;

procedure TatStdConvsLibrary.__SetmuHectograms(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.muHectograms:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetmuKilograms(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.muKilograms));
  end;
end;

procedure TatStdConvsLibrary.__SetmuKilograms(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.muKilograms:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetmuMetricTons(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.muMetricTons));
  end;
end;

procedure TatStdConvsLibrary.__SetmuMetricTons(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.muMetricTons:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetmuDrams(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.muDrams));
  end;
end;

procedure TatStdConvsLibrary.__SetmuDrams(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.muDrams:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetmuGrains(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.muGrains));
  end;
end;

procedure TatStdConvsLibrary.__SetmuGrains(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.muGrains:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetmuLongTons(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.muLongTons));
  end;
end;

procedure TatStdConvsLibrary.__SetmuLongTons(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.muLongTons:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetmuTons(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.muTons));
  end;
end;

procedure TatStdConvsLibrary.__SetmuTons(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.muTons:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetmuOunces(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.muOunces));
  end;
end;

procedure TatStdConvsLibrary.__SetmuOunces(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.muOunces:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetmuPounds(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.muPounds));
  end;
end;

procedure TatStdConvsLibrary.__SetmuPounds(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.muPounds:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetmuStones(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.muStones));
  end;
end;

procedure TatStdConvsLibrary.__SetmuStones(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.muStones:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetcbTemperature(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.cbTemperature));
  end;
end;

procedure TatStdConvsLibrary.__SetcbTemperature(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.cbTemperature:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GettuCelsius(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.tuCelsius));
  end;
end;

procedure TatStdConvsLibrary.__SettuCelsius(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.tuCelsius:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GettuKelvin(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.tuKelvin));
  end;
end;

procedure TatStdConvsLibrary.__SettuKelvin(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.tuKelvin:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GettuFahrenheit(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.tuFahrenheit));
  end;
end;

procedure TatStdConvsLibrary.__SettuFahrenheit(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.tuFahrenheit:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GettuRankine(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.tuRankine));
  end;
end;

procedure TatStdConvsLibrary.__SettuRankine(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.tuRankine:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GettuReaumur(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.tuReaumur));
  end;
end;

procedure TatStdConvsLibrary.__SettuReaumur(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.tuReaumur:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GetcbTime(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.cbTime));
  end;
end;

procedure TatStdConvsLibrary.__SetcbTime(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.cbTime:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GettuMilliSeconds(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.tuMilliSeconds));
  end;
end;

procedure TatStdConvsLibrary.__SettuMilliSeconds(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.tuMilliSeconds:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GettuSeconds(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.tuSeconds));
  end;
end;

procedure TatStdConvsLibrary.__SettuSeconds(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.tuSeconds:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GettuMinutes(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.tuMinutes));
  end;
end;

procedure TatStdConvsLibrary.__SettuMinutes(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.tuMinutes:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GettuHours(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.tuHours));
  end;
end;

procedure TatStdConvsLibrary.__SettuHours(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.tuHours:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GettuDays(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.tuDays));
  end;
end;

procedure TatStdConvsLibrary.__SettuDays(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.tuDays:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GettuWeeks(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.tuWeeks));
  end;
end;

procedure TatStdConvsLibrary.__SettuWeeks(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.tuWeeks:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GettuFortnights(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.tuFortnights));
  end;
end;

procedure TatStdConvsLibrary.__SettuFortnights(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.tuFortnights:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GettuMonths(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.tuMonths));
  end;
end;

procedure TatStdConvsLibrary.__SettuMonths(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.tuMonths:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GettuYears(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.tuYears));
  end;
end;

procedure TatStdConvsLibrary.__SettuYears(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.tuYears:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GettuDecades(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.tuDecades));
  end;
end;

procedure TatStdConvsLibrary.__SettuDecades(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.tuDecades:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GettuCenturies(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.tuCenturies));
  end;
end;

procedure TatStdConvsLibrary.__SettuCenturies(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.tuCenturies:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GettuMillennia(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.tuMillennia));
  end;
end;

procedure TatStdConvsLibrary.__SettuMillennia(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.tuMillennia:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GettuDateTime(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.tuDateTime));
  end;
end;

procedure TatStdConvsLibrary.__SettuDateTime(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.tuDateTime:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GettuJulianDate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.tuJulianDate));
  end;
end;

procedure TatStdConvsLibrary.__SettuJulianDate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.tuJulianDate:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.__GettuModifiedJulianDate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdConvs.tuModifiedJulianDate));
  end;
end;

procedure TatStdConvsLibrary.__SettuModifiedJulianDate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdConvs.tuModifiedJulianDate:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdConvsLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('FahrenheitToCelsius',1,tkVariant,nil,__FahrenheitToCelsius,false,0);
    DefineMethod('CelsiusToFahrenheit',1,tkVariant,nil,__CelsiusToFahrenheit,false,0);
    DefineMethod('InitStdConvs',0,tkNone,nil,__InitStdConvs,false,0);
    DefineProp('cbDistance',tkInteger,__GetcbDistance,__SetcbDistance,nil,false,0);
    DefineProp('duMicromicrons',tkInteger,__GetduMicromicrons,__SetduMicromicrons,nil,false,0);
    DefineProp('duAngstroms',tkInteger,__GetduAngstroms,__SetduAngstroms,nil,false,0);
    DefineProp('duMillimicrons',tkInteger,__GetduMillimicrons,__SetduMillimicrons,nil,false,0);
    DefineProp('duMicrons',tkInteger,__GetduMicrons,__SetduMicrons,nil,false,0);
    DefineProp('duMillimeters',tkInteger,__GetduMillimeters,__SetduMillimeters,nil,false,0);
    DefineProp('duCentimeters',tkInteger,__GetduCentimeters,__SetduCentimeters,nil,false,0);
    DefineProp('duDecimeters',tkInteger,__GetduDecimeters,__SetduDecimeters,nil,false,0);
    DefineProp('duMeters',tkInteger,__GetduMeters,__SetduMeters,nil,false,0);
    DefineProp('duDecameters',tkInteger,__GetduDecameters,__SetduDecameters,nil,false,0);
    DefineProp('duHectometers',tkInteger,__GetduHectometers,__SetduHectometers,nil,false,0);
    DefineProp('duKilometers',tkInteger,__GetduKilometers,__SetduKilometers,nil,false,0);
    DefineProp('duMegameters',tkInteger,__GetduMegameters,__SetduMegameters,nil,false,0);
    DefineProp('duGigameters',tkInteger,__GetduGigameters,__SetduGigameters,nil,false,0);
    DefineProp('duInches',tkInteger,__GetduInches,__SetduInches,nil,false,0);
    DefineProp('duFeet',tkInteger,__GetduFeet,__SetduFeet,nil,false,0);
    DefineProp('duYards',tkInteger,__GetduYards,__SetduYards,nil,false,0);
    DefineProp('duMiles',tkInteger,__GetduMiles,__SetduMiles,nil,false,0);
    DefineProp('duNauticalMiles',tkInteger,__GetduNauticalMiles,__SetduNauticalMiles,nil,false,0);
    DefineProp('duAstronomicalUnits',tkInteger,__GetduAstronomicalUnits,__SetduAstronomicalUnits,nil,false,0);
    DefineProp('duLightYears',tkInteger,__GetduLightYears,__SetduLightYears,nil,false,0);
    DefineProp('duParsecs',tkInteger,__GetduParsecs,__SetduParsecs,nil,false,0);
    DefineProp('duCubits',tkInteger,__GetduCubits,__SetduCubits,nil,false,0);
    DefineProp('duFathoms',tkInteger,__GetduFathoms,__SetduFathoms,nil,false,0);
    DefineProp('duFurlongs',tkInteger,__GetduFurlongs,__SetduFurlongs,nil,false,0);
    DefineProp('duHands',tkInteger,__GetduHands,__SetduHands,nil,false,0);
    DefineProp('duPaces',tkInteger,__GetduPaces,__SetduPaces,nil,false,0);
    DefineProp('duRods',tkInteger,__GetduRods,__SetduRods,nil,false,0);
    DefineProp('duChains',tkInteger,__GetduChains,__SetduChains,nil,false,0);
    DefineProp('duLinks',tkInteger,__GetduLinks,__SetduLinks,nil,false,0);
    DefineProp('duPicas',tkInteger,__GetduPicas,__SetduPicas,nil,false,0);
    DefineProp('duPoints',tkInteger,__GetduPoints,__SetduPoints,nil,false,0);
    DefineProp('cbArea',tkInteger,__GetcbArea,__SetcbArea,nil,false,0);
    DefineProp('auSquareMillimeters',tkInteger,__GetauSquareMillimeters,__SetauSquareMillimeters,nil,false,0);
    DefineProp('auSquareCentimeters',tkInteger,__GetauSquareCentimeters,__SetauSquareCentimeters,nil,false,0);
    DefineProp('auSquareDecimeters',tkInteger,__GetauSquareDecimeters,__SetauSquareDecimeters,nil,false,0);
    DefineProp('auSquareMeters',tkInteger,__GetauSquareMeters,__SetauSquareMeters,nil,false,0);
    DefineProp('auSquareDecameters',tkInteger,__GetauSquareDecameters,__SetauSquareDecameters,nil,false,0);
    DefineProp('auSquareHectometers',tkInteger,__GetauSquareHectometers,__SetauSquareHectometers,nil,false,0);
    DefineProp('auSquareKilometers',tkInteger,__GetauSquareKilometers,__SetauSquareKilometers,nil,false,0);
    DefineProp('auSquareInches',tkInteger,__GetauSquareInches,__SetauSquareInches,nil,false,0);
    DefineProp('auSquareFeet',tkInteger,__GetauSquareFeet,__SetauSquareFeet,nil,false,0);
    DefineProp('auSquareYards',tkInteger,__GetauSquareYards,__SetauSquareYards,nil,false,0);
    DefineProp('auSquareMiles',tkInteger,__GetauSquareMiles,__SetauSquareMiles,nil,false,0);
    DefineProp('auAcres',tkInteger,__GetauAcres,__SetauAcres,nil,false,0);
    DefineProp('auCentares',tkInteger,__GetauCentares,__SetauCentares,nil,false,0);
    DefineProp('auAres',tkInteger,__GetauAres,__SetauAres,nil,false,0);
    DefineProp('auHectares',tkInteger,__GetauHectares,__SetauHectares,nil,false,0);
    DefineProp('auSquareRods',tkInteger,__GetauSquareRods,__SetauSquareRods,nil,false,0);
    DefineProp('cbVolume',tkInteger,__GetcbVolume,__SetcbVolume,nil,false,0);
    DefineProp('vuCubicMillimeters',tkInteger,__GetvuCubicMillimeters,__SetvuCubicMillimeters,nil,false,0);
    DefineProp('vuCubicCentimeters',tkInteger,__GetvuCubicCentimeters,__SetvuCubicCentimeters,nil,false,0);
    DefineProp('vuCubicDecimeters',tkInteger,__GetvuCubicDecimeters,__SetvuCubicDecimeters,nil,false,0);
    DefineProp('vuCubicMeters',tkInteger,__GetvuCubicMeters,__SetvuCubicMeters,nil,false,0);
    DefineProp('vuCubicDecameters',tkInteger,__GetvuCubicDecameters,__SetvuCubicDecameters,nil,false,0);
    DefineProp('vuCubicHectometers',tkInteger,__GetvuCubicHectometers,__SetvuCubicHectometers,nil,false,0);
    DefineProp('vuCubicKilometers',tkInteger,__GetvuCubicKilometers,__SetvuCubicKilometers,nil,false,0);
    DefineProp('vuCubicInches',tkInteger,__GetvuCubicInches,__SetvuCubicInches,nil,false,0);
    DefineProp('vuCubicFeet',tkInteger,__GetvuCubicFeet,__SetvuCubicFeet,nil,false,0);
    DefineProp('vuCubicYards',tkInteger,__GetvuCubicYards,__SetvuCubicYards,nil,false,0);
    DefineProp('vuCubicMiles',tkInteger,__GetvuCubicMiles,__SetvuCubicMiles,nil,false,0);
    DefineProp('vuMilliLiters',tkInteger,__GetvuMilliLiters,__SetvuMilliLiters,nil,false,0);
    DefineProp('vuCentiLiters',tkInteger,__GetvuCentiLiters,__SetvuCentiLiters,nil,false,0);
    DefineProp('vuDeciLiters',tkInteger,__GetvuDeciLiters,__SetvuDeciLiters,nil,false,0);
    DefineProp('vuLiters',tkInteger,__GetvuLiters,__SetvuLiters,nil,false,0);
    DefineProp('vuDecaLiters',tkInteger,__GetvuDecaLiters,__SetvuDecaLiters,nil,false,0);
    DefineProp('vuHectoLiters',tkInteger,__GetvuHectoLiters,__SetvuHectoLiters,nil,false,0);
    DefineProp('vuKiloLiters',tkInteger,__GetvuKiloLiters,__SetvuKiloLiters,nil,false,0);
    DefineProp('vuAcreFeet',tkInteger,__GetvuAcreFeet,__SetvuAcreFeet,nil,false,0);
    DefineProp('vuAcreInches',tkInteger,__GetvuAcreInches,__SetvuAcreInches,nil,false,0);
    DefineProp('vuCords',tkInteger,__GetvuCords,__SetvuCords,nil,false,0);
    DefineProp('vuCordFeet',tkInteger,__GetvuCordFeet,__SetvuCordFeet,nil,false,0);
    DefineProp('vuDecisteres',tkInteger,__GetvuDecisteres,__SetvuDecisteres,nil,false,0);
    DefineProp('vuSteres',tkInteger,__GetvuSteres,__SetvuSteres,nil,false,0);
    DefineProp('vuDecasteres',tkInteger,__GetvuDecasteres,__SetvuDecasteres,nil,false,0);
    DefineProp('vuFluidGallons',tkInteger,__GetvuFluidGallons,__SetvuFluidGallons,nil,false,0);
    DefineProp('vuFluidQuarts',tkInteger,__GetvuFluidQuarts,__SetvuFluidQuarts,nil,false,0);
    DefineProp('vuFluidPints',tkInteger,__GetvuFluidPints,__SetvuFluidPints,nil,false,0);
    DefineProp('vuFluidCups',tkInteger,__GetvuFluidCups,__SetvuFluidCups,nil,false,0);
    DefineProp('vuFluidGills',tkInteger,__GetvuFluidGills,__SetvuFluidGills,nil,false,0);
    DefineProp('vuFluidOunces',tkInteger,__GetvuFluidOunces,__SetvuFluidOunces,nil,false,0);
    DefineProp('vuFluidTablespoons',tkInteger,__GetvuFluidTablespoons,__SetvuFluidTablespoons,nil,false,0);
    DefineProp('vuFluidTeaspoons',tkInteger,__GetvuFluidTeaspoons,__SetvuFluidTeaspoons,nil,false,0);
    DefineProp('vuDryGallons',tkInteger,__GetvuDryGallons,__SetvuDryGallons,nil,false,0);
    DefineProp('vuDryQuarts',tkInteger,__GetvuDryQuarts,__SetvuDryQuarts,nil,false,0);
    DefineProp('vuDryPints',tkInteger,__GetvuDryPints,__SetvuDryPints,nil,false,0);
    DefineProp('vuDryPecks',tkInteger,__GetvuDryPecks,__SetvuDryPecks,nil,false,0);
    DefineProp('vuDryBuckets',tkInteger,__GetvuDryBuckets,__SetvuDryBuckets,nil,false,0);
    DefineProp('vuDryBushels',tkInteger,__GetvuDryBushels,__SetvuDryBushels,nil,false,0);
    DefineProp('vuUKGallons',tkInteger,__GetvuUKGallons,__SetvuUKGallons,nil,false,0);
    DefineProp('vuUKPottles',tkInteger,__GetvuUKPottles,__SetvuUKPottles,nil,false,0);
    DefineProp('vuUKQuarts',tkInteger,__GetvuUKQuarts,__SetvuUKQuarts,nil,false,0);
    DefineProp('vuUKPints',tkInteger,__GetvuUKPints,__SetvuUKPints,nil,false,0);
    DefineProp('vuUKGills',tkInteger,__GetvuUKGills,__SetvuUKGills,nil,false,0);
    DefineProp('vuUKOunces',tkInteger,__GetvuUKOunces,__SetvuUKOunces,nil,false,0);
    DefineProp('vuUKPecks',tkInteger,__GetvuUKPecks,__SetvuUKPecks,nil,false,0);
    DefineProp('vuUKBuckets',tkInteger,__GetvuUKBuckets,__SetvuUKBuckets,nil,false,0);
    DefineProp('vuUKBushels',tkInteger,__GetvuUKBushels,__SetvuUKBushels,nil,false,0);
    DefineProp('cbMass',tkInteger,__GetcbMass,__SetcbMass,nil,false,0);
    DefineProp('muNanograms',tkInteger,__GetmuNanograms,__SetmuNanograms,nil,false,0);
    DefineProp('muMicrograms',tkInteger,__GetmuMicrograms,__SetmuMicrograms,nil,false,0);
    DefineProp('muMilligrams',tkInteger,__GetmuMilligrams,__SetmuMilligrams,nil,false,0);
    DefineProp('muCentigrams',tkInteger,__GetmuCentigrams,__SetmuCentigrams,nil,false,0);
    DefineProp('muDecigrams',tkInteger,__GetmuDecigrams,__SetmuDecigrams,nil,false,0);
    DefineProp('muGrams',tkInteger,__GetmuGrams,__SetmuGrams,nil,false,0);
    DefineProp('muDecagrams',tkInteger,__GetmuDecagrams,__SetmuDecagrams,nil,false,0);
    DefineProp('muHectograms',tkInteger,__GetmuHectograms,__SetmuHectograms,nil,false,0);
    DefineProp('muKilograms',tkInteger,__GetmuKilograms,__SetmuKilograms,nil,false,0);
    DefineProp('muMetricTons',tkInteger,__GetmuMetricTons,__SetmuMetricTons,nil,false,0);
    DefineProp('muDrams',tkInteger,__GetmuDrams,__SetmuDrams,nil,false,0);
    DefineProp('muGrains',tkInteger,__GetmuGrains,__SetmuGrains,nil,false,0);
    DefineProp('muLongTons',tkInteger,__GetmuLongTons,__SetmuLongTons,nil,false,0);
    DefineProp('muTons',tkInteger,__GetmuTons,__SetmuTons,nil,false,0);
    DefineProp('muOunces',tkInteger,__GetmuOunces,__SetmuOunces,nil,false,0);
    DefineProp('muPounds',tkInteger,__GetmuPounds,__SetmuPounds,nil,false,0);
    DefineProp('muStones',tkInteger,__GetmuStones,__SetmuStones,nil,false,0);
    DefineProp('cbTemperature',tkInteger,__GetcbTemperature,__SetcbTemperature,nil,false,0);
    DefineProp('tuCelsius',tkInteger,__GettuCelsius,__SettuCelsius,nil,false,0);
    DefineProp('tuKelvin',tkInteger,__GettuKelvin,__SettuKelvin,nil,false,0);
    DefineProp('tuFahrenheit',tkInteger,__GettuFahrenheit,__SettuFahrenheit,nil,false,0);
    DefineProp('tuRankine',tkInteger,__GettuRankine,__SettuRankine,nil,false,0);
    DefineProp('tuReaumur',tkInteger,__GettuReaumur,__SettuReaumur,nil,false,0);
    DefineProp('cbTime',tkInteger,__GetcbTime,__SetcbTime,nil,false,0);
    DefineProp('tuMilliSeconds',tkInteger,__GettuMilliSeconds,__SettuMilliSeconds,nil,false,0);
    DefineProp('tuSeconds',tkInteger,__GettuSeconds,__SettuSeconds,nil,false,0);
    DefineProp('tuMinutes',tkInteger,__GettuMinutes,__SettuMinutes,nil,false,0);
    DefineProp('tuHours',tkInteger,__GettuHours,__SettuHours,nil,false,0);
    DefineProp('tuDays',tkInteger,__GettuDays,__SettuDays,nil,false,0);
    DefineProp('tuWeeks',tkInteger,__GettuWeeks,__SettuWeeks,nil,false,0);
    DefineProp('tuFortnights',tkInteger,__GettuFortnights,__SettuFortnights,nil,false,0);
    DefineProp('tuMonths',tkInteger,__GettuMonths,__SettuMonths,nil,false,0);
    DefineProp('tuYears',tkInteger,__GettuYears,__SettuYears,nil,false,0);
    DefineProp('tuDecades',tkInteger,__GettuDecades,__SettuDecades,nil,false,0);
    DefineProp('tuCenturies',tkInteger,__GettuCenturies,__SettuCenturies,nil,false,0);
    DefineProp('tuMillennia',tkInteger,__GettuMillennia,__SettuMillennia,nil,false,0);
    DefineProp('tuDateTime',tkInteger,__GettuDateTime,__SettuDateTime,nil,false,0);
    DefineProp('tuJulianDate',tkInteger,__GettuJulianDate,__SettuJulianDate,nil,false,0);
    DefineProp('tuModifiedJulianDate',tkInteger,__GettuModifiedJulianDate,__SettuModifiedJulianDate,nil,false,0);
    AddConstant('MetersPerInch',MetersPerInch);
    AddConstant('MetersPerFoot',MetersPerFoot);
    AddConstant('MetersPerYard',MetersPerYard);
    AddConstant('MetersPerMile',MetersPerMile);
    AddConstant('MetersPerNauticalMiles',MetersPerNauticalMiles);
    AddConstant('MetersPerAstronomicalUnit',MetersPerAstronomicalUnit);
    AddConstant('MetersPerLightSecond',MetersPerLightSecond);
    AddConstant('MetersPerLightYear',MetersPerLightYear);
    AddConstant('MetersPerParsec',MetersPerParsec);
    AddConstant('MetersPerCubit',MetersPerCubit);
    AddConstant('MetersPerFathom',MetersPerFathom);
    AddConstant('MetersPerFurlong',MetersPerFurlong);
    AddConstant('MetersPerHand',MetersPerHand);
    AddConstant('MetersPerPace',MetersPerPace);
    AddConstant('MetersPerRod',MetersPerRod);
    AddConstant('MetersPerChain',MetersPerChain);
    AddConstant('MetersPerLink',MetersPerLink);
    AddConstant('MetersPerPoint',MetersPerPoint);
    AddConstant('MetersPerPica',MetersPerPica);
    AddConstant('SquareMetersPerSquareInch',SquareMetersPerSquareInch);
    AddConstant('SquareMetersPerSquareFoot',SquareMetersPerSquareFoot);
    AddConstant('SquareMetersPerSquareYard',SquareMetersPerSquareYard);
    AddConstant('SquareMetersPerSquareMile',SquareMetersPerSquareMile);
    AddConstant('SquareMetersPerAcre',SquareMetersPerAcre);
    AddConstant('SquareMetersPerSquareRod',SquareMetersPerSquareRod);
    AddConstant('CubicMetersPerCubicInch',CubicMetersPerCubicInch);
    AddConstant('CubicMetersPerCubicFoot',CubicMetersPerCubicFoot);
    AddConstant('CubicMetersPerCubicYard',CubicMetersPerCubicYard);
    AddConstant('CubicMetersPerCubicMile',CubicMetersPerCubicMile);
    AddConstant('CubicMetersPerAcreFoot',CubicMetersPerAcreFoot);
    AddConstant('CubicMetersPerAcreInch',CubicMetersPerAcreInch);
    AddConstant('CubicMetersPerCord',CubicMetersPerCord);
    AddConstant('CubicMetersPerCordFoot',CubicMetersPerCordFoot);
    AddConstant('CubicMetersPerUSFluidGallon',CubicMetersPerUSFluidGallon);
    AddConstant('CubicMetersPerUSFluidQuart',CubicMetersPerUSFluidQuart);
    AddConstant('CubicMetersPerUSFluidPint',CubicMetersPerUSFluidPint);
    AddConstant('CubicMetersPerUSFluidCup',CubicMetersPerUSFluidCup);
    AddConstant('CubicMetersPerUSFluidGill',CubicMetersPerUSFluidGill);
    AddConstant('CubicMetersPerUSFluidOunce',CubicMetersPerUSFluidOunce);
    AddConstant('CubicMetersPerUSFluidTablespoon',CubicMetersPerUSFluidTablespoon);
    AddConstant('CubicMetersPerUSFluidTeaspoon',CubicMetersPerUSFluidTeaspoon);
    AddConstant('CubicMetersPerUSDryGallon',CubicMetersPerUSDryGallon);
    AddConstant('CubicMetersPerUSDryQuart',CubicMetersPerUSDryQuart);
    AddConstant('CubicMetersPerUSDryPint',CubicMetersPerUSDryPint);
    AddConstant('CubicMetersPerUSDryPeck',CubicMetersPerUSDryPeck);
    AddConstant('CubicMetersPerUSDryBucket',CubicMetersPerUSDryBucket);
    AddConstant('CubicMetersPerUSDryBushel',CubicMetersPerUSDryBushel);
    AddConstant('CubicMetersPerUKGallon',CubicMetersPerUKGallon);
    AddConstant('CubicMetersPerUKPottle',CubicMetersPerUKPottle);
    AddConstant('CubicMetersPerUKQuart',CubicMetersPerUKQuart);
    AddConstant('CubicMetersPerUKPint',CubicMetersPerUKPint);
    AddConstant('CubicMetersPerUKGill',CubicMetersPerUKGill);
    AddConstant('CubicMetersPerUKOunce',CubicMetersPerUKOunce);
    AddConstant('CubicMetersPerUKPeck',CubicMetersPerUKPeck);
    AddConstant('CubicMetersPerUKBucket',CubicMetersPerUKBucket);
    AddConstant('CubicMetersPerUKBushel',CubicMetersPerUKBushel);
    AddConstant('GramsPerPound',GramsPerPound);
    AddConstant('GramsPerDrams',GramsPerDrams);
    AddConstant('GramsPerGrains',GramsPerGrains);
    AddConstant('GramsPerTons',GramsPerTons);
    AddConstant('GramsPerLongTons',GramsPerLongTons);
    AddConstant('GramsPerOunces',GramsPerOunces);
    AddConstant('GramsPerStones',GramsPerStones);
  end;
end;

class function TatStdConvsLibrary.LibraryName: string;
begin
  result := 'StdConvs';
end;

initialization
  RegisterScripterLibrary(TatStdConvsLibrary, True);

{$WARNINGS ON}

end.

