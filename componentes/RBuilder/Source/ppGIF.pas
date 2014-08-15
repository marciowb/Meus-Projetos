{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit ppGIF;

interface

{$I ppIfDef.pas}

uses
  ppCtrls, ppGIFImage;

implementation

{******************************************************************************
 *
 ** I N I T I A L I Z A T I O N   /   F I N A L I Z A T I O N
 *
{******************************************************************************}

initialization

  ppRegisterGraphicClass('GIF', TGIFImage);

finalization

  ppUnRegisterGraphicClass(TGIFImage);

end.
 
