{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2009                    BBBBB   }

unit ppPNG;

interface

{$I ppIfDef.pas}

uses
  ppCtrls,
  PNGImage;  // Delphi 2009 and later have PNGImage

implementation

{******************************************************************************
 *
 ** I N I T I A L I Z A T I O N   /   F I N A L I Z A T I O N
 *
{******************************************************************************}

initialization

  ppRegisterGraphicClass('PNG', TPNGImage);

finalization

  ppUnRegisterGraphicClass(TPNGImage);

end.
 
