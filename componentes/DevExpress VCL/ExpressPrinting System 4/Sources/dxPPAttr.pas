{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressPrinting System COMPONENT SUITE                      }
{                                                                   }
{       Copyright (C) 1998-2010 Developer Express Inc.              }
{       ALL RIGHTS RESERVED                                         }
{                                                                   }
{   The entire contents of this file is protected by U.S. and       }
{   International Copyright Laws. Unauthorized reproduction,        }
{   reverse-engineering, and distribution of all or any portion of  }
{   the code contained in this file is strictly prohibited and may  }
{   result in severe civil and criminal penalties and will be       }
{   prosecuted to the maximum extent possible under the law.        }
{                                                                   }
{   RESTRICTIONS                                                    }
{                                                                   }
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES           }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE    }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS   }
{   LICENSED TO DISTRIBUTE THE EXPRESSPRINTINGSYSTEM AND            }
{   ALL ACCOMPANYING VCL CONTROLS AS PART OF AN                     }
{   EXECUTABLE PROGRAM ONLY.                                        }
{                                                                   }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED      }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE        }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE       }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT  }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                      }
{                                                                   }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON       }
{   ADDITIONAL RESTRICTIONS.                                        }
{                                                                   }
{*******************************************************************}

unit dxPpAttr;

interface

{$I cxVer.inc}

uses
  Classes, Windows;

type
  TFloatSize = record
    cx: Extended;
    cy: Extended;
  end;

  TdxPaper = class(TPersistent)
  private
    FName: string;
    FShortName: string;
    FSize: TPoint;
    FDMPaper: Integer;
    function GetHeight: Integer;
    function GetWidth: Integer;
    procedure SetHeight(Value: Integer);
    procedure SetWidth(Value: Integer);
  public                                  
    constructor Create(const AName, AShortName: string; 
      AWidth, AHeight: Integer; ADMPaper: Integer);
    procedure Assign(Source: TPersistent); override;
    function Clone: TdxPaper;
    
    property DMPaper: Integer read FDMPaper;
    property Height: Integer read GetHeight write SetHeight;
    property Name: string read FName;
    property ShortName: string read FShortName;
    property Size: TPoint read FSize write FSize;
    property Width: Integer read GetWidth write SetWidth;
  end;

  TdxPapers = class(TPersistent)
  private
    FPapers: TList;
    function GetCount: Integer;
    function GetPaper(Index: Integer): TdxPaper;
  protected
    procedure AddPapers; virtual;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;

    procedure Clear;
    procedure Delete(AIndex: Integer);
    function FindByDMPaper(ADMPaper: Integer): Integer;
    function FindByName(const AName: string): Integer;
    function FindByShortName(const AShortName: string): Integer;
    function FindBySize(AWidth, AHeight: Integer): Integer;
    procedure Refresh;

    property Count: Integer read GetCount;
    property Papers[Index: Integer]: TdxPaper read GetPaper; default;
  end;

  TdxBin = class(TPersistent)
  private
    FName: string;
    FValue: Integer;
  public
    constructor Create(AValue: Integer; const AName: string); virtual;
    procedure Assign(Source: TPersistent); override;

    property Name: string read FName;
    property Value: Integer read FValue;
  end;

  TdxBins = class(TPersistent)
  private
    FBins: TList;
    function GetBin(Index: Integer): TdxBin;
    function GetCount: Integer;
  protected
    procedure AddBins; virtual;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;

    procedure Clear;
    procedure Delete(Index: Integer);
    function FindByName(const AName: string): Integer;
    function FindByValue(AValue: Integer): Integer;
    function IndexOf(ABin: TdxBin): Integer;
    procedure Refresh;

    property Bins[Index: Integer]: TdxBin read GetBin; default;
    property Count: Integer read GetCount;
  end;

function Bins: TdxBins;
function Papers: TdxPapers;
function SetBins(Value: TdxBins): TdxBins;
function SetPapers(Value: TdxPapers): TdxPapers;

implementation

uses
  SysUtils, dxPSUtl;

var
  FPapers: TdxPapers = nil;
  FBins: TdxBins = nil;

function Bins: TdxBins;
begin
  if FBins = nil then FBins := TdxBins.Create;
  Result := FBins;
end;

function Papers: TdxPapers;
begin
  if FPapers = nil then FPapers := TdxPapers.Create;
  Result := FPapers;
end;

function SetBins(Value: TdxBins): TdxBins;
begin
  Result := FBins;
  FBins := Value;
end;

function SetPapers(Value: TdxPapers): TdxPapers;
begin
  Result := FPapers;
  FPapers := Value;
end;

function InchToLoMetric(Value: Extended): Integer;
begin
  Result := Round(Value * 254);
end;

{ TdxPaper }

constructor TdxPaper.Create(const AName, AShortName: string;
  AWidth, AHeight: Integer; ADMPaper: Integer);
begin
  inherited Create;
  FName := AName;
  FShortName := AShortName;
  FSize.X := AWidth;
  FSize.Y := AHeight;
  FDMPaper := ADMPaper;
end;

procedure TdxPaper.Assign(Source: TPersistent);
begin
  if Source is TdxPaper then
    with TdxPaper(Source) do 
    begin
      Self.FName := Name;
      Self.FShortName := ShortName;
      Self.FSize := Size;
      Self.FDMPaper := DMPaper;
    end
  else
    inherited;
end;

function TdxPaper.Clone: TdxPaper;
begin
  Result := TdxPaper.Create(Name, ShortName, Width, Height, DMPaper);
end;

function TdxPaper.GetHeight: Integer;
begin
  Result := FSize.Y;
end;

function TdxPaper.GetWidth: Integer;
begin
  Result := FSize.X;
end;

procedure TdxPaper.SetHeight(Value: Integer);
begin
  FSize.Y := Value;
end;

procedure TdxPaper.SetWidth(Value: Integer);
begin
  FSize.X := Value;
end;

{ TdxPapers }

constructor TdxPapers.Create;
begin
  inherited;
  FPapers := TList.Create;
  Refresh;
end;

destructor TdxPapers.Destroy;
begin
  Clear;
  FreeAndNil(FPapers);
  inherited;
end;

procedure TdxPapers.Assign(Source: TPersistent);
var
  I: Integer;
begin
  if (Source = nil) or (Source is TdxPapers) then
    with TdxPapers(Source) do
    begin
      Self.Clear;
      if Source <> nil then
        for I := 0 to Count - 1 do
          Self.FPapers.Add(Papers[I].Clone);
     end
  else
    inherited;
end;

procedure TdxPapers.Clear;
begin
  while Count > 0 do Delete(Count - 1);
end;

procedure TdxPapers.Delete(AIndex: Integer);
begin
  TObject(FPapers[AIndex]).Free;
  FPapers.Delete(AIndex);
end;

function TdxPapers.FindByDMPaper(ADMPaper: Integer): Integer;
begin
  for Result := 0 to Count - 1 do
    if Papers[Result].DMPaper = ADMPaper then Exit;
  Result := -1;
end;

function TdxPapers.FindByName(const AName: string): Integer;
begin
  for Result := 0 to Count - 1 do
    if dxSameText(Papers[Result].Name, AName) then 
      Exit;
  Result := -1;       
end;

function TdxPapers.FindByShortName(const AShortName: string): Integer;
begin
  for Result := 0 to Count - 1 do
    if dxSameText(Papers[Result].ShortName, AShortName) then 
      Exit;
  Result := -1;
end;

function TdxPapers.FindBySize(AWidth, AHeight: Integer): Integer;
begin
  for Result := 0 to Count - 1 do
    if (Abs(Papers[Result].Width - AWidth) < 2) and (Abs(Papers[Result].Height - AHeight) < 2) then 
      Exit;
  Result := -1;
end;

procedure TdxPapers.Refresh;
begin
  Clear;
  AddPapers;
end;

procedure TdxPapers.AddPapers;

  procedure Add(const AName, AShortName: string; AWidth, AHeight: Integer; DMPaper: Integer);
  begin
    FPapers.Add(TdxPaper.Create(AName, AShortName, AWidth, AHeight, DMPaper));
  end;
  
begin  
  Add('Letter 8 1/2 x 11 in', 'Letter', InchToLoMetric(8.5), InchToLoMetric(11), DMPAPER_LETTER);
  Add('Letter Small 8 1/2 x 11 in ', 'Letter Small', InchToLoMetric(8.5), InchToLoMetric(11), DMPAPER_LETTERSMALL);
  Add('Tabloid 11 x 17 in', 'Tabloid', InchToLoMetric(11), InchToLoMetric(17), DMPAPER_TABLOID);
  Add('Ledger 17 x 11 in', 'Ledger', InchToLoMetric(17), InchToLoMetric(11), DMPAPER_LEDGER);
  Add('Legal 8 1/2 x 14 in', 'Legal', InchToLoMetric(8.5), InchToLoMetric(14), DMPAPER_LEGAL);
  Add('Statement 5 1/2 x 8 1/2 in', 'Statement', InchToLoMetric(5.5), InchToLoMetric(8.5), DMPAPER_STATEMENT);
  Add('Executive 7 1/4 x 10 1/2 in', 'Executive', InchToLoMetric(7.25), InchToLoMetric(10.5), DMPAPER_EXECUTIVE);
  Add('A3 297 x 420 mm', 'A3', 2970, 4200, DMPAPER_A3);
  Add('A4 210 x 297 mm', 'A4', 2100, 2970, DMPAPER_A4);
  Add('A4 Small 210 x 297 mm', 'A4 Small', 2100, 2970, DMPAPER_A4SMALL);
  Add('A5 148 x 210 mm', 'A5', 1480, 2100, DMPAPER_A5);
  Add('B4 (JIS) 250 x 354', 'B4 (JIS)', 2500, 3540, DMPAPER_B4);
  Add('B5 (JIS) 182 x 257 mm', 'B5 (JIS)', 1820, 2570, DMPAPER_B5);
  Add('Folio 8 1/2 x 13 in', 'Folio', InchToLoMetric(8.5), InchToLoMetric(13), DMPAPER_FOLIO);
  Add('Quarto 215 x 275 mm', 'Quarto', 2150, 2750, DMPAPER_QUARTO);
  Add('10x14 in', '10x14 in', InchToLoMetric(10), InchToLoMetric(14), DMPAPER_10X14);
  Add('11x17 in', '11x17 in', InchToLoMetric(11), InchToLoMetric(17), DMPAPER_11X17);
  Add('Note 8 1/2 x 11 in', 'Note', InchToLoMetric(8.5), InchToLoMetric(11), DMPAPER_NOTE);
  Add('Envelope #9 3 7/8 x 8 7/8', 'Envelope #9', InchToLoMetric(3 + 7 / 8), InchToLoMetric(8 + 7 / 8), DMPAPER_ENV_9);
  Add('Envelope #10 4 1/8 x 9 1/2', 'Envelope #10', InchToLoMetric(4 + 1 / 8), InchToLoMetric(9.5), DMPAPER_ENV_10);
  Add('Envelope #11 4 1/2 x 10 3/8', 'Envelope #11', InchToLoMetric(4.5), InchToLoMetric(10 + 3 / 8), DMPAPER_ENV_11);
  Add('Envelope #12 4 3/4 x 11', 'Envelope #12', InchToLoMetric(4 + 3 / 4), InchToLoMetric(11), DMPAPER_ENV_12);
  Add('Envelope #14 5 x 11 1/2', 'Envelope #14', InchToLoMetric(5), InchToLoMetric(11.5), DMPAPER_ENV_14);
  Add('C sheet 17 x 22 in', 'C sheet', InchToLoMetric(17), InchToLoMetric(22), DMPAPER_CSHEET);
  Add('D sheet 22 x 34 in', 'D sheet', InchToLoMetric(22), InchToLoMetric(34), DMPAPER_DSHEET);
  Add('E sheet 34 x 44 in', 'E sheet', InchToLoMetric(34), InchToLoMetric(44), DMPAPER_ESHEET);
  Add('Envelope DL 110 x 220mm', 'Envelope DL', 1100, 2200, DMPAPER_ENV_DL);
  Add('Envelope C5 162 x 229 mm', 'Envelope C5', 1620, 2290, DMPAPER_ENV_C5);
  Add('Envelope C3 324 x 458 mm', 'Envelope C3', 3240, 4580, DMPAPER_ENV_C3);
  Add('Envelope C4 229 x 324 mm', 'Envelope C4', 2290, 3240, DMPAPER_ENV_C4);
  Add('Envelope C6 114 x 162 mm', 'Envelope C6', 1140, 1620, DMPAPER_ENV_C6);
  Add('Envelope C65 114 x 229 mm', 'Envelope 65', 1140, 2290, DMPAPER_ENV_C65);
  Add('Envelope B4 250 x 353 mm', 'Envelope B4', 2500, 3530, DMPAPER_ENV_B4);
  Add('Envelope B5 176 x 250 mm', 'Envelope B5', 1760, 2500, DMPAPER_ENV_B5);
  Add('Envelope B6 176 x 125 mm', 'Envelope B6', 1760, 1250, DMPAPER_ENV_B6);
  Add('Envelope 110 x 230 mm', 'Envelope 110', 1100, 2300, DMPAPER_ENV_ITALY);
  Add('Envelope Monarch 3 7/8 x 7 1/2 in', 'Envelope Monarch', InchToLoMetric(3 + 7 / 8), InchToLoMetric(7.5), DMPAPER_ENV_MONARCH);
  Add('6 3/4 Envelope 3 5/8 x 6 1/2 in', '6 3/4 Envelope', InchToLoMetric(3 + 5 / 8), InchToLoMetric(6.5), DMPAPER_ENV_PERSONAL);
  Add('US Std Fanfold 14 7/8 x 11 in', 'US Std Fanfold', InchToLoMetric(14 + 7 / 8), InchToLoMetric(11), DMPAPER_FANFOLD_US);
  Add('German Std Fanfold 8 1/2 x 12 in', 'German Std Fanfold', InchToLoMetric(8.5), InchToLoMetric(12), DMPAPER_FANFOLD_STD_GERMAN);
  Add('German Legal Fanfold 8 1/2 x 13 in', 'German Legal Fanfold', InchToLoMetric(8.5), InchToLoMetric(13), DMPAPER_FANFOLD_LGL_GERMAN);
  Add('B4 (ISO) 250 x 353 mm', 'B4 (ISO)', 2500, 3530, DMPAPER_ISO_B4);
  Add('Japanese Postcard 100 x 148 mm', 'Japanese Postcard', 1000, 1480, DMPAPER_JAPANESE_POSTCARD);
  Add('9 x 11 in', '9 x 11 in', InchToLoMetric(90), InchToLoMetric(110), DMPAPER_9X11);
  Add('10 x 11 in', '10 x 11 in', InchToLoMetric(10), InchToLoMetric(11), DMPAPER_10X11);
  Add('15 x 11 in', '15 x 11 in', InchToLoMetric(15), InchToLoMetric(11), DMPAPER_15X11);
  Add('Envelope Invite 220 x 220 mm', 'Envelope Invite', 2200, 2200, DMPAPER_ENV_INVITE);
//  DMPAPER_RESERVED_48        = 48;  { RESERVED--DO NOT USE                }
//  DMPAPER_RESERVED_49        = 49;  { RESERVED--DO NOT USE                }
  Add('Letter Extra 9 \275 x 12 in', 'Legal Extra', InchToLoMetric(9 + 1 / 275), InchToLoMetric(12), DMPAPER_LETTER_EXTRA);
  Add('Legal Extra 9 \275 x 15 in', 'Legal Extra', InchToLoMetric(9 + 1 / 275), InchToLoMetric(15), DMPAPER_LEGAL_EXTRA);
  Add('Tabloid Extra 11.69 x 18 in', 'Tabloid Extra', InchToLoMetric(11.69), InchToLoMetric(18), DMPAPER_TABLOID_EXTRA);
  Add('A4 Extra 9.27 x 12.69 in', 'A4 Extra', InchToLoMetric(9.27), InchToLoMetric(12.69), DMPAPER_A4_EXTRA);
  Add('Letter Transverse 8 \275 x 11 in', 'Letter Transverse', InchToLoMetric(8 + 1 / 275), InchToLoMetric(11), DMPAPER_LETTER_TRANSVERSE);
  Add('A4 Transverse 210 x 297 mm', 'A4 Transverse', 2100, 2970, DMPAPER_LETTER_EXTRA_TRANSVERSE);
  Add('Letter Extra Transverse 9\275 x 12 in', 'Letter Extra Transverse', InchToLoMetric(9 + 1 / 275), InchToLoMetric(12), DMPAPER_LETTER_EXTRA_TRANSVERSE);
  Add('SuperASuperAA4 227 x 356 mm', 'SuperASuperAA4', 2270, 3560, DMPAPER_A_PLUS);
  Add('SuperBSuperBA3 305 x 487 mm', 'SuperBSuperBA3', 3050, 4870, DMPAPER_B_PLUS);
  Add('Letter Plus 8.5 x 12.69 in', 'Letter Plus', InchToLoMetric(8.5), InchToLoMetric(12.69), DMPAPER_LETTER_PLUS);
  Add('A4 Plus 210 x 330 mm', 'A4 Plus', 2100, 3300, DMPAPER_A4_PLUS);
  Add('A5 Transverse 148 x 210 mm', 'A5 Transverse', 1480, 2100, DMPAPER_A5_TRANSVERSE);
  Add('B5 (JIS) Transverse 182 x 257 mm', 'B5 (JIS) Transverse', 1820, 2570, DMPAPER_B5_TRANSVERSE);
  Add('A3 Extra 322 x 445 mm', 'A3 Extra', 3220, 4450, DMPAPER_A3_EXTRA);
  Add('A5 Extra 174 x 235 mm', 'A5 Extra', 1740, 2350, DMPAPER_A5_EXTRA);
  Add('B5 (ISO) Extra 201 x 276 mm', 'B5 (ISO) Extra', 2010, 2760, DMPAPER_B5_EXTRA);
  Add('A2 420 x 594 mm', 'A2', 4200, 5940, DMPAPER_A2);
  Add('A3 Transverse 297 x 420 mm', 'A3 Transverse', 2970, 4200, DMPAPER_A3_TRANSVERSE);
  Add('A3 Extra Transverse 322 x 445 mm', 'A3 Extra Transverse', 3220, 4450, DMPAPER_A3_EXTRA_TRANSVERSE);

  if Win32MajorVersion >= 5 then
  begin
    Add('Japanese Double Postcard 200 x 148 mm', 'Japanese Double Postcard', 2000, 148, DMPAPER_DBL_JAPANESE_POSTCARD);
    Add('A6 105 x 148 mm', 'A6', 1050, 1480, DMPAPER_A6);
  //  Add('Japanese Envelope Kaku #2', 'Japanese Envelope Kaku #2', 0, 0, DMPAPER_JENV_KAKU2);
  //  Add('Japanese Envelope Kaku #3', 'Japanese Envelope Kaku #3', 0, 0, DMPAPER_JENV_KAKU3);
  //  Add('Japanese Envelope Chou #3', 'Japanese Envelope Kaku #3', 0, 0, DMPAPER_JENV_CHOU3);
  //  Add('Japanese Envelope Chou #4', 'Japanese Envelope Kaku #4', 0, 0, DMPAPER_JENV_CHOU4);
    Add('Letter Rotated 11 x 8 1/2 11 in', 'Letter Rotated', InchToLoMetric(11), InchToLoMetric(8.5), DMPAPER_LETTER_ROTATED);
    Add('A3 Rotated 420 x 297 mm', 'A3 Rotated', 4200, 2970, DMPAPER_A3_ROTATED);
    Add('A4 Rotated 297 x 210 mm', 'A4 Rotated', 2970, 2100, DMPAPER_A4_ROTATED);
    Add('A5 Rotated 210 x 148 mm', 'A5 Rotated', 2100, 1480, DMPAPER_A5_ROTATED);
    Add('B4 (JIS) Rotated 364 x 257 mm', 'B4 (JIS) Rotated', 3640, 2570, DMPAPER_B4_JIS_ROTATED);
    Add('B5 (JIS) Rotated 257 x 182 mm', 'B5 (JIS) Rotated', 2570, 1820, DMPAPER_B5_JIS_ROTATED);
    Add('Japanese Postcard Rotated 148 x 100 mm', 'Japanese Postcard Rotated', 1480, 1000, DMPAPER_JAPANESE_POSTCARD_ROTATED);
    Add('A6 Rotated 148 x 105 mm', 'A6 Rotated', 1480, 1050, DMPAPER_A6_ROTATED);
  //  Add('Japanese Envelope Kaku #2 Rotated', 'Japanese Envelope Kaku #2 Rotated', 0, 0, DMPAPER_JENV_KAKU2_ROTATED);
  //  Add('Japanese Envelope Kaku #3 Rotated', 'Japanese Envelope Kaku #4 Rotated', 0, 0, DMPAPER_JENV_KAKU3_ROTATED);
  //  Add('Japanese Envelope Chou #3 Rotated', 'Japanese Envelope Chou #3 Rotated', 0, 0, DMPAPER_JENV_CHOU3_ROTATED);
  //  Add('Japanese Envelope Chow #4 Rotated', 'Japanese Envelope Chou #4 Rotated', 0, 0, DMPAPER_JENV_CHOU4_ROTATED);
    Add('B6 (JIS) 128 x 182 mm', 'B6 (JIS)', 1280, 1820, DMPAPER_B6_JIS);
    Add('B6 (JIS) Rotated 182 x 128 mm', 'B6 (JIS) Rotated', 1820, 1280, DMPAPER_B6_JIS_ROTATED);
    Add('12X11 12 x 11 in', '12X11', InchToLoMetric(12), InchToLoMetric(11), DMPAPER_12X11);
  //  Add('Japanese Envelope You #4', 'Japanese Envelope You #4', 0, 0, DMPAPER_JENV_YOU4);
  //  Add('Japanese Envelope You #4 Rotated', 'Japanese Envelope You #4 Rotated', 0, 0, DMPAPER_JENV_YOU4_ROTATED);
    Add('PRC 16K 146 x 215 mm', 'PRC 16K', 1460, 2150, DMPAPER_P16K);
    Add('PRC 32K 97 x 151 mm', 'PRC 32K', 970, 1510, DMPAPER_P32K);
    Add('PRC 32K(Big) 97 x 151 mm', 'PRC 32K(Big)', 970, 1510, DMPAPER_P32KBIG);
    Add('PRC Envelope #1 102 x 165 mm', 'PRC Envelope #1', 1020, 1650, DMPAPER_PENV_1);
    Add('PRC Envelope #2 102 x 176 mm', 'PRC Envelope #2', 1020, 1760, DMPAPER_PENV_2);
    Add('PRC Envelope #3 125 x 176 mm', 'PRC Envelope #3', 1250, 1760, DMPAPER_PENV_3);
    Add('PRC Envelope #4 110 x 208 mm', 'PRC Envelope #4', 1100, 2080, DMPAPER_PENV_4);
    Add('PRC Envelope #5 110 x 220 mm', 'PRC Envelope #5', 2190, 2200, DMPAPER_PENV_5);
    Add('PRC Envelope #6 120 x 230 mm', 'PRC Envelope #6', 1200, 2300, DMPAPER_PENV_6);
    Add('PRC Envelope #7 160 x 230 mm', 'PRC Envelope #7', 1600, 2300, DMPAPER_PENV_7);
    Add('PRC Envelope #8 120 x 309 mm', 'PRC Envelope #8', 1200, 3090, DMPAPER_PENV_8);
    Add('PRC Envelope #9 229 x 324 mm', 'PRC Envelope #9', 2290, 3240, DMPAPER_PENV_9);
    Add('PRC Envelope #10 324 x 458 mm', 'PRC Envelope #10', 3240, 4580, DMPAPER_PENV_10);
    Add('PRC 16K Rotated 146 x 215 mm', 'PRC 16K Rotated', 1460, 2150, DMPAPER_P16K_ROTATED);
    Add('PRC 32K Rotated 97 x 151 mm', 'PRC 32K Rotated', 970, 1510, DMPAPER_P32K_ROTATED);
    Add('PRC 32K(Big) Rotated 97 x 151 mm', 'PRC 32K(Big) Rotated', 970, 1510, DMPAPER_P32KBIG_ROTATED);
    Add('PRC Envelope #1 Rotated 165 x 102 mm', 'PRC Envelope #1 Rotated', 1650, 1020, DMPAPER_PENV_1_ROTATED);
    Add('PRC Envelope #2 Rotated 176 x 102 mm', 'PRC Envelope #2 Rotated', 1760, 1020, DMPAPER_PENV_2_ROTATED);
    Add('PRC Envelope #3 Rotated 176 x 125 mm', 'PRC Envelope #3 Rotated', 1760, 1250, DMPAPER_PENV_3_ROTATED);
    Add('PRC Envelope #4 Rotated 208 x 110 mm', 'PRC Envelope #4 Rotated', 2080, 1100, DMPAPER_PENV_4_ROTATED);
    Add('PRC Envelope #5 Rotated 220 x 110 mm', 'PRC Envelope #5 Rotated', 2200, 2190, DMPAPER_PENV_5_ROTATED);
    Add('PRC Envelope #6 Rotated 230 x 120 mm', 'PRC Envelope #6 Rotated', 2300, 1200, DMPAPER_PENV_6_ROTATED);
    Add('PRC Envelope #7 Rotated 230 x 160 mm', 'PRC Envelope #7 Rotated', 2300, 1600, DMPAPER_PENV_7_ROTATED);
    Add('PRC Envelope #8 Rotated 309 x 120 mm', 'PRC Envelope #8 Rotated', 3090, 1200, DMPAPER_PENV_8_ROTATED);
    Add('PRC Envelope #9 Rotated 324 x 229 mm', 'PRC Envelope #9 Rotated', 3240, 2290, DMPAPER_PENV_9_ROTATED);
    Add('PRC Envelope #10 Rotated 458 x 324 mm', 'PRC Envelope #10 Rotated', 4580, 3240, DMPAPER_PENV_10_ROTATED);
  end;
  Add('Custom', 'Custom', 0, 0, DMPAPER_USER);
end;

function TdxPapers.GetCount: Integer;
begin
  Result := FPapers.Count;
end;

function TdxPapers.GetPaper(Index: Integer): TdxPaper;
begin
  Result := TdxPaper(FPapers[Index]);
end;

{ TdxBin }

constructor TdxBin.Create(AValue: Integer; const AName: string);
begin
  inherited Create;
  FValue := AValue;
  FName := AName;
end;

procedure TdxBin.Assign(Source: TPersistent);
begin
  if Source is TdxBin then
    with TdxBin(Source) do
    begin
      Self.FName := Name;
      Self.FValue := Value;
    end
  else
    inherited;
end;

{ TdxBins }

constructor TdxBins.Create;
begin
  inherited Create;
  FBins := TList.Create;
  Refresh;
end;

destructor TdxBins.Destroy;
begin
  Clear;
  FreeAndNil(FBins);
  inherited;
end;

procedure TdxBins.Assign(Source: TPersistent);
var
  I: Integer;
begin
  if (Source = nil) or (Source is TdxBins) then
    with TdxBins(Source) do 
    begin
     Self.Clear;
      if Source <> nil then
        for I := 0 to Count - 1 do
          with Bins[I] do
            Self.FBins.Add(TdxBin.Create(Value, Name));
    end
  else
    inherited;
end;

procedure TdxBins.Clear;
begin
  while Count > 0 do Delete(Count - 1);
end;

procedure TdxBins.Delete(Index: Integer);
begin
  Bins[Index].Free;
  FBins.Delete(Index);
end;

function TdxBins.FindByName(const AName: string): Integer;
begin
  for Result := 0 to Count - 1 do
    if dxSameText(Bins[Result].Name, AName) then 
      Exit;
  Result := -1;
end;

function TdxBins.FindByValue(AValue: Integer): Integer;
begin
  for Result := 0 to Count - 1 do
    if Bins[Result].Value = AValue then 
      Exit;
  Result := -1;
end;

function TdxBins.IndexOf(ABin: TdxBin): Integer;
begin
  Result := FBins.IndexOf(ABin);
end;

procedure TdxBins.Refresh;
begin
  Clear;
  AddBins;
end;

procedure TdxBins.AddBins;

  procedure Add(AValue: Integer; const AName: string);
  begin
    FBins.Add(TdxBin.Create(AValue, AName));
  end;
  
begin  
  Add(DMBIN_UPPER, 'DMBIN_UPPER');                  // 1
//  Add(DMBIN_ONLYONE, 'DMBIN_ONLYONE');            // 1
  Add(DMBIN_LOWER, 'DMBIN_LOWER');                  // 2
  Add(DMBIN_MIDDLE, 'DMBIN_MIDDLE');                // 3
  Add(DMBIN_MANUAL, 'DMBIN_MANUAL');                // 4
  Add(DMBIN_ENVELOPE, 'DMBIN_ENVELOPE');            // 5
  Add(DMBIN_ENVMANUAL, 'DMBIN_ENVMANUAL');          // 6
  Add(DMBIN_AUTO, 'DMBIN_AUTO');                    // 7
  Add(DMBIN_TRACTOR, 'DMBIN_TRACTOR');              // 8
  Add(DMBIN_SMALLFMT, 'DMBIN_SMALLFMT');            // 9
  Add(DMBIN_LARGEFMT, 'DMBIN_LARGEFMT');            // 10
  Add(DMBIN_LARGECAPACITY, 'DMBIN_LARGECAPACITY');  // 11
  Add(DMBIN_CASSETTE, 'DMBIN_CASSETTE');            // 14
  Add(DMBIN_FORMSOURCE, 'DMBIN_FORMSOURCE');        // 15
  Add(DMBIN_USER, 'DMBIN_USER');                    // $100
end;

function TdxBins.GetBin(Index: Integer): TdxBin;
begin
  Result := TdxBin(FBins[Index]);
end;

function TdxBins.GetCount: Integer;
begin
  Result := FBins.Count;
end;

initialization

finalization
  FreeAndNil(FBins);
  FreeAndNil(FPapers);
  
end.

