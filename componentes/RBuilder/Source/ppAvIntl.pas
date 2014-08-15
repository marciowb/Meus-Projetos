{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit ppAvIntl;

interface

{$I ppIfDef.pas}

uses
  ppLabelDef;

type

  {@TppAveryA4A5LaserJetLabels}
  TppAveryA4A5LaserJetLabels = class(TppLaserJetLabels)
    protected
      class function GetLabelDef(aIndex: Integer): String; override;

    public
      class function Product: String; override;
      class function Count: Integer; override;

    end; {class, TppAveryA4A5LaserJetLabels}
    

  {@TppAveryUKDotMatrixLabels}
  TppAveryUKDotMatrixLabels = class(TppDotMatrixLabels)
    protected
      class function GetLabelDef(aIndex: Integer): String; override;

    public
      class function Product: String; override;
      class function Count: Integer; override;

    end; {class, TppAveryUKDotMatrixLabels}


  {@TppAveryFranceDotMatrixLabels}
  TppAveryFranceDotMatrixLabels = class(TppDotMatrixLabels)
    protected
      class function GetLabelDef(aIndex: Integer): String; override;

    public
      class function Product: String; override;
      class function Count: Integer; override;

    end; {class, TppAveryFranceDotMatrixLabels}




implementation


const
  caAveryA4A5Sizes: array [0..101] of String = (

  {LabelType, Name,
     Width, Height, MarginTop, MarginBottom, MarginLeft, MarginRight,
     Orientation, RowSpacing, Units, Columns, ColumnPositions }

'Mini-Address,L2160,2.63,1,4.25,5,0.5,0,0.81,0,0,0,1,0',
'Mini-Address,L2162,3.75,1.33,4.25,5,0.5,0,0.25,0,0,0,1,0',
'Mini-Parcel,L2163,3.75,2,4.25,5,0.5,0,0.25,0,0,0,1,0',
'Mini-Diskette,L2186,2.75,2,4.25,5,0.5,0,0.75,0,0,0,1,0',
'Address,L7159,2.52,1.33,8.2708,11.6979,0.54,0,0.25,0,0,0,1,3,0.25,2.88,5.51',
'Address,L7160,2.5,1.5,8.2708,11.6979,0.63,0,0.28,0,0,0,1,3,0.28,2.88,5.48',
'Address,L7161,2.5,1.83,8.2708,11.6979,0.38,0,0.28,0,0,0,1,3,0.28,2.88,5.48',
'Address,L7162,3.9,1.33,8.2708,11.6979,0.54,0,0.18,0,0,0,1,2,0.18,4.18',
'Address,L7163,3.9,1.5,8.2708,11.6979,0.63,0,0.18,0,0,0,1,2,0.18,4.18',
'Address,L7164,2.5,2.83,8.2708,11.6979,0.21,0,0.28,0,0,0,1,3,0.28,2.88,5.48',
'Parcel,L7165,3.9,2.67,8.2708,11.6979,0.54,0,0.18,0,0,0,1,2,0.18,4.18',
'Parcel,L7166,3.9,3.67,8.2708,11.6979,0.38,0,0.18,0,0,0,1,2,0.18,4.18',
'Shipping,L7167,7.86,11.38,8.2708,11.6979,0.18,0,0.2,0,0,0,1,0',
'Shipping,L7168,7.86,5.65,8.2708,11.6979,0.22,0,0.18,0,0,0,1,0',
'Parcel,L7169,5.47,3.9,11.6979,8.2708,0.18,0,0.4,0,0,0.1,1,2,0.4,5.87',
'Eurofolio,L7170,5.28,0.43,8.2708,11.6979,0.68,0.5,1.5,0,0,0,1,0',
'Level Arch,L7171,2.36,7.88,11.6979,8.2708,0.2,0,1.15,0,0,0,1,4,1.15,3.51,5.87,8.23',
'Ring Binder,L7172,3.94,1.18,8.2708,11.6979,0.56,0,0.15,0,0,0,1,2,0.15,4.19',
'Shipping,L7173,3.9,2.24,8.2708,11.6979,0.26,0,0.18,0,0,0,1,2,0.18,4.18',
'Address,L7263,3.9,1.5,8.2708,11.6979,0.63,0,0.18,0,0,0,1,2,0.18,4.18',
'Information,L7410-5M_L - Index Maker Contents,3.27,2.17,8.2708,11.6979,0.2,0,4.33,0,0,0.11,1,0',
'Information,L7410-5M_C - Index Maker Labels,2.17,0.5,8.2708,11.6979,1.88,1,1,0,0,0.33,1,2,1,5.1',
'Information,L7410-6M_L - Index Maker Contents,3.27,1.77,8.2708,11.6979,0.2,0,4.33,0,0,0.12,1,0',
'Information,L7410-6M_C - Index Maker Labels,1.77,0.5,8.2708,11.6979,1.96,1.5,1.2,0,0,0.17,1,2,1.2,5.3',
'Information,L7410-10M_L - Index Maker Contents,3.27,1.02,8.2708,11.6979,0.2,0,4.33,0,0,0.12,1,0',
'Information,L7410-10M_C - Index Maker Labels,1,0.5,8.2708,11.6979,1.88,1,0.79,0,0,0.33,1,4,0.79,2.69,4.59,6.49',
'Information,L7410-12M_L - Index Maker Contents,3.27,0.83,8.2708,11.6979,0.2,0,4.33,0,0,0.12,1,0',
'Information,L7410-12M_C - Index Maker Labels,0.87,0.5,8.2708,11.6979,1.96,1.5,1,0,0,0.17,1,4,1,2.8,4.6,6.4',
'Information,L7411-5R - Ready Index ,2.76,2.25,8.2708,11.6979,0.22,0,5.25,0,0,0.01,1,0',
'Information,L7411-6R - Ready Index ,2.76,1.77,8.2708,11.6979,0.2,0,5.25,0,0,0.12,1,0',
'Information,L7411-10R - Ready Index ,2.76,1.1,8.2708,11.6979,0.18,0,5.25,0,0,0.04,1,0',
'Information,L7411-12R - Ready Index ,2.76,0.95,8.2708,11.6979,0.12,0,5.25,0,0,0,1,0',
'Information,L7417-5R - Ready Index ,2.76,2.25,8.2708,11.6979,0.22,0,5.25,0,0,0.01,1,0',
'Information,L7417-6R - Ready Index ,2.76,1.77,8.2708,11.6979,0.2,0,5.25,0,0,0.12,1,0',
'Business Card,L7413 ,3.54,2,8.2708,11.6979,0.85,0,0.59,0,0,0,1,2,0.85,4.39',
'Information,L7414 ,3.54,2.05,8.2708,11.6979,0.73,0,0.59,0,0,0,1,2,0.73,4.27',
'Information,L7415 ,3.54,2.05,8.2708,11.6979,0.73,0,0.59,0,0,0,1,2,0.73,4.27',
'Information,L7417 ,3.54,2.13,8.2708,11.6979,0.53,0,0.59,0,0,0,1,2,0.73,4.27',
'Name Badge,L7418 ,3.39,2.17,8.2708,11.6979,1.52,0,0.75,0,0,0,1,2,0.75,4.14',
'Business Card,L7419 ,3.54,2.13,8.2708,11.6979,0.53,0,0.59,0,0,0,1,2,0.59,4.13',
'Post Card,L7421 ,5.49,3.83,11.6979,8.2708,0.31,0,0.37,0,0,0,1,2,0.37,5.86',
'Address,L7551 ,1.5,0.83,8.2708,11.6979,0.46,0,0.18,0,0,0,1,5,0.18,1.78,3.38,4.98,6.58',
'Petite,L7552 ,2.17,0.5,8.2708,11.6979,1.88,1,1,0,0,0.33,1,2,1,5.1',
'Petite,L7553 ,0.87,0.5,8.2708,11.6979,1.96,1.5,1,0,0,0.17,1,4,1,2.8,4.6,6.4',
'Address,L7560 ,2.5,1.5,8.2708,11.6979,0.63,0,0.28,0,0,0,1,3,0.28,2.88,5.48',
'Address,L7562 ,3.9,1.33,8.2708,11.6979,0.54,0,0.18,0,0,0,1,2,0.18,4.18',
'Address,L7563 ,3.9,1.5,8.2708,11.6979,0.63,0,0.18,0,0,0,1,2,0.18,4.18',
'Parcel,L7565 ,3.9,2.67,8.2708,11.6979,0.54,0,0.18,0,0,0,1,2,0.18,4.18',
'Address,L7651 ,1.5,0.83,8.2708,11.6979,0.46,0,0.18,0,0,0,1,5,0.18,1.76,3.36,4.96,6.56',
'Audio Cassette,L7655 ,3.5,1.65,8.2708,11.6979,0.92,0,0.58,0,0,0,1,2,0.58,4.18',
'35MM Slide,L7656 ,1.81,0.44,8.2708,11.6979,0.66,0.5,0.22,0,0,0.06,1,4,0.22,2.22,4.22,6.22',
'Diskette,L7664 ,2.76,2.83,8.2708,11.6979,0.21,0,0.7,0,0,0,1,2,0.7,4.8',
'Data Cartridge,L7665 ,2.83,0.83,8.2708,11.6979,0.89,0.5,0.87,0,0,0,1,2,0.87,4.57',
'Diskette,L7666 ,2.76,2.05,8.2708,11.6979,0.76,0,0.92,0,0,0,1,2,0.92,4.59',
'Data Cartridge,L7667 ,5.24,1.17,8.2708,11.6979,0.63,0,1.52,0,0,0,1,0',
'Video Face,L7671 ,3,1.83,8.2708,11.6979,0.38,0,1.08,0,0,0,1,2,0.38,3.48',
'Video Spine,L7674 ,5.71,0.67,8.2708,11.6979,0.54,0,1.28,0,0,0,1,0',
'Address,L7680 ,1.5,0.83,8.2708,11.6979,0.46,0,0.18,0,0,0,1,5,0.18,1.78,3.38,4.98,6.58',
'Address,L7690 ,1.5,0.83,8.2708,11.6979,0.46,0,0.18,0,0,0,1,5,0.18,1.78,3.38,4.98,6.58',
'Level Arch,L7701 ,2.44,7.56,11.6979,8.2708,0.35,0,0.99,0,0,0,1,4,0.99,3.43,5.87,8.31',
'Level Arch,L7702 ,1.54,7.56,11.6979,8.2708,0.35,0,0.5,0,0,0,1,7,0.5,2.04,3.58,5.12,6.66,8.2,9.74',
'Address,J8159 ,2.52,1.33,8.2708,11.6979,0.54,0,0.25,0,0,0,1,3,0.25,2.88,5.51',
'Address,J8160 ,2.5,1.5,8.2708,11.6979,0.63,0,0.28,0,0,0,1,3,0.28,2.88,5.48',
'Address,J8161 ,2.5,1.83,8.2708,11.6979,0.38,0,0.28,0,0,0,1,3,0.28,2.88,5.48',
'Address,J8162 ,3.9,1.33,8.2708,11.6979,0.54,0,0.18,0,0,0,1,2,0.18,4.18',
'Address,J8163 ,3.9,1.5,8.2708,11.6979,0.63,0,0.18,0,0,0,1,2,0.18,4.18',
'Address,J8164 ,2.5,2.83,8.2708,11.6979,0.21,0,0.28,0,0,0,1,3,0.28,2.88,5.48',
'Parcel,J8165 ,3.9,2.67,8.2708,11.6979,0.54,0,0.18,0,0,0,1,2,0.18,4.18',
'Parcel,J8166 ,3.9,3.67,8.2708,11.6979,0.38,0,0.18,0,0,0,1,2,0.18,4.18',
'Shipping,J8167 ,7.86,11.38,8.2708,11.6979,0.18,0,0.2,0,0,0,1,0',
'Shipping,J8168 ,7.86,5.65,8.2708,11.6979,0.22,0,0.18,0,0,0,1,0',
'Parcel,J8169 ,5.47,3.9,11.6979,8.2708,0.18,0,0.4,0,0,0.1,1,2,0.4,5.87',
'Lever Arch,J8171 ,2.36,7.88,11.6979,8.2708,0.2,0,1.15,0,0,0,1,4,1.15,3.51,5.87,8.23',
'Address,J8360 ,2.5,1.5,8.2708,11.6979,0.63,0,0.28,0,0,0,1,3,0.28,2.88,5.48',
'Address,J8362 ,3.9,1.33,8.2708,11.6979,0.54,0,0.18,0,0,0,1,2,0.18,4.18',
'Address,J8363 ,3.9,1.5,8.2708,11.6979,0.63,0,0.18,0,0,0,1,2,0.18,4.18',
'Parcel,J8365 ,3.9,2.67,8.2708,11.6979,0.54,0,0.18,0,0,0,1,2,0.18,4.18',
'Shipping,J8367 ,7.86,11.38,8.2708,11.6979,0.18,0,0.2,0,0,0,1,0',
'Shipping,J8368 ,7.86,5.65,8.2708,11.6979,0.22,0,0.18,0,0,0,1,0',
'Address,J8560 ,2.5,1.5,8.2708,11.6979,0.63,0,0.28,0,0,0,1,3,0.28,2.88,5.48',
'Address,J8562 ,3.9,1.33,8.2708,11.6979,0.54,0,0.18,0,0,0,1,2,0.18,4.18',
'Address,J8563 ,3.9,1.5,8.2708,11.6979,0.63,0,0.18,0,0,0,1,2,0.18,4.18',
'Parcel,J8565 ,3.9,2.67,8.2708,11.6979,0.54,0,0.18,0,0,0,1,2,0.18,4.18',
'Address,J8651 ,1.5,0.83,8.2708,11.6979,0.46,0,0.18,0,0,0,1,5,0.18,1.78,3.38,4.98,6.58',
'Audio Cassette,J8655 ,3.5,1.65,8.2708,11.6979,0.92,0,0.58,0,0,0,1,2,0.58,4.18',
'35MM Slide,J8657 ,1.81,0.44,8.2708,11.6979,2.41,2,1.23,0,0,0.06,1,3,1.23,3.23,5.23',
'Diskette,J8666 ,2.76,2.05,8.2708,11.6979,0.76,0,0.92,0,0,0,1,2,0.92,4.59',
'Video Face,J8671 ,3,1.83,8.2708,11.6979,0.38,0,1.08,0,0,0,1,2,1.08,4.18',
'Video Spine,J8674 ,5.71,0.67,8.2708,11.6979,0.54,0,1.28,0,0,0,1,0',
'Diskette,J8766 ,2.76,2.05,8.2708,11.6979,0.76,0,0.92,0,0,0,1,2,0.92,4.59',
'Address,L30063 ,3.9,1.5,8.2708,11.6979,0.94,4,2.18,0,0,1,1,0',
'Parcel,L30065 ,3.9,2.67,8.2708,11.6979,1.6,0,0.23,0,0,0,1,2,0.23,4.13',
'Diskette,L300DK ,2.76,2.05,8.2708,11.6979,1.92,6,1.38,0,0,0,1,2,1.38,4.14',
'35MM Slide,L300SL ,1.81,0.44,8.2708,11.6979,0.72,5,0.51,0,0,0.89,1,4,0.72,2.53,4.34,6.15',
'Video Face,L300VF ,3,1.83,8.2708,11.6979,0.6,4,2.64,0,0,1,1,0',
'Video Spine,L300VS ,5.71,0.67,8.2708,11.6979,0.83,6,1.28,0,0,0.5,1,0',
'Address,J40063 ,3.9,1.5,8.2708,11.6979,0.94,4,2.18,0,0,1,1,0',
'Parcel,J40065 ,3.9,2.67,8.2708,11.6979,1.6,6,0.23,0,0,0,1,2,0.23,4.13',
'Diskette,J400DK ,2.76,2.05,8.2708,11.6979,1.92,6,1.38,0,0,0,1,2,1.38,4.14',
'35MM Slide,J400SL ,1.81,0.44,8.2708,11.6979,0.72,5,0.51,0,0,0.89,1,4,0.51,2.32,4.13,5.94',
'Video Face,J400VF ,3,1.83,8.2708,11.6979,0.6,4,2.64,0,0,1,1,0',
'Video Spine,J400VS ,5.71,0.67,8.2708,11.6979,0.83,6,1.28,0,0,0.5,1,0'
);

  caAveryIntlUK: array [0..9] of String = (

'Address,EAL04,3.5,1.44,4.48,1.55,0,0,0.49,0,0,0,1,0',
'Name Badge,FAB03,2.75,1.44,3.73,1.52,0,0,0.49,0,0,0,1,0',
'Diskette,OML099,2.75,1.94,3.73,2.03,0,0,0.49,0,0,0,1,0',
'Diskette,OML101,4,0.94,4.98,1.04,0,0,0.49,0,0,0,1,0',
'Address,OML102,4,1.44,4.98,1.55,0,0,0.49,0,0,0,1,0',
'Address,OML103,4,1.94,4.98,2.03,0,0,0.49,0,0,0,1,0',
'Address,OML104,5,1.44,5.98,1.55,0,0,0.49,0,0,0,1,0',
'Shipping,OML105,5,1.94,5.98,2.03,0,0,0.49,0,0,0,1,0',
'Address,OML202,4,1.44,9.06,1.55,0,0,0.49,0,0,0,1,2,0.49,4.57',
'Address,OML203,4,1.94,9.06,2.03,0,0,0.49,0,0,0,1,2,0.49,4.57'
);

  caAveryIntlFrance: array [0..11] of String = (

'Shipping,EXPE 120.74,4.73,2.91,5.51,3,0,0,0.39,0,0,0,1,0',
'Name Badge,Tab1 85.108,3.35,4.25,4.33,5,0,0,0.49,0,0,0,1,0',
'Address,Tab1 89.23,3.5,0.92,4.49,1,0,0,0.49,0,0,0,1,0',
'Address,Tab1 89.36,3.5,1.44,4.49,1.52,0,0,0.49,0,0,0,1,0',
'Diskette,Tab1 102.36,4.02,1.44,5,1.52,0,0,0.49,0,0,0,1,0',
'Address,Tab1 107.23,4.02,1.44,5,1,0,0,0.49,0,0,0,1,0',
'Address,Tab1 107.36,4.21,1.44,5,1.52,0,0,0.39,0,0,0,1,0',
'Address,Tab1 107.49,4.21,0.92,5,2,0,1,0.39,0,0,0,1,0',
'Address,Tab1 125.74,4.92,2.91,5.71,3,0,0,0.39,0,0,0,1,0',
'Address,Tab2 89.23,3.5,0.92,8.19,1,0,0,0.49,0,0,0,1,2,0.49,4.19',
'Address,Tab2 89.36,3.5,1.44,8.19,1.52,0,0,0.49,0,0,0,1,2,0.49,4.19',
'Address,Tab2 107.23,4.21,0.92,9.41,1,0,0,0.39,0,0,0,1,2,0.39,4.8'

);

{******************************************************************************
 *
 ** A V E R Y  A 4 / A 5   L A S E R J E T
  *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppAveryA4A5LaserJetLabels.Product }

class function TppAveryA4A5LaserJetLabels.Product: String;
begin
  Result := 'Avery A4 and A5 sizes';
end; {class function, Product}

{------------------------------------------------------------------------------}
{ TppAveryA4A5LaserJetLabels.Count }

class function TppAveryA4A5LaserJetLabels.Count: Integer;
begin
  Result := High(caAveryA4A5Sizes) + 1;
end; {class function, Count}

{------------------------------------------------------------------------------}
{ TppAveryA4A5LaserJetLabels.GetLabelDef }

class function TppAveryA4A5LaserJetLabels.GetLabelDef(aIndex: Integer): String;
begin
  Result := caAveryA4A5Sizes[aIndex];
end; {class function, GetLabelDef}

{******************************************************************************
 *
 ** A V E R Y  UK   D O T M A T R I X
  *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppAveryUKDotMatrixLabels.Product }

class function TppAveryUKDotMatrixLabels.Product: String;
begin
  Result := 'Avery International (UK)';
end; {class function, Product}

{------------------------------------------------------------------------------}
{ TppAveryUKDotMatrixLabels.Count }

class function TppAveryUKDotMatrixLabels.Count: Integer;
begin
  Result := High(caAveryIntlUK) + 1;
end; {class function, Count}

{------------------------------------------------------------------------------}
{ TppAveryUKDotMatrixLabels.GetLabelDef }

class function TppAveryUKDotMatrixLabels.GetLabelDef(aIndex: Integer): String;
begin
  Result := caAveryIntlUK[aIndex];
end; {class function, GetLabelDef}


{******************************************************************************
 *
 ** A V E R Y  France   D O T M A T R I X
  *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppAveryFranceDotMatrixLabels.Product }

class function TppAveryFranceDotMatrixLabels.Product: String;
begin
  Result := 'Avery International (France)';
end; {class function, Product}

{------------------------------------------------------------------------------}
{ TppAveryFranceDotMatrixLabels.Count }

class function TppAveryFranceDotMatrixLabels.Count: Integer;
begin
  Result := High(caAveryIntlFrance) + 1;
end; {class function, Count}

{------------------------------------------------------------------------------}
{ TppAveryFranceDotMatrixLabels.GetLabelDef }

class function TppAveryFranceDotMatrixLabels.GetLabelDef(aIndex: Integer): String;
begin
  Result := caAveryIntlFrance[aIndex];
end; {class function, GetLabelDef}



initialization
  ppRegisterLabelSet(TppAveryA4A5LaserJetLabels);
  ppRegisterLabelSet(TppAveryUKDotMatrixLabels);
  ppRegisterLabelSet(TppAveryFranceDotMatrixLabels);

finalization
  ppUnRegisterLabelSet(TppAveryA4A5LaserJetLabels);
  ppUnRegisterLabelSet(TppAveryUKDotMatrixLabels);
  ppUnRegisterLabelSet(TppAveryFranceDotMatrixLabels);


end.
 
