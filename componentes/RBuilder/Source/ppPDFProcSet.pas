{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2003                    BBBBB   }

unit ppPDFProcSet;

interface

uses
  Classes,
  SysUtils,
  ppPDFObject;

type
  TppPDFProcSet = class(TppPDFObject)
    private

    public
      procedure Write(aOutputStream: TStream; aReferenceNumber: Integer); override;
      
  end;

implementation

{@TppPDFProcSet.Write}

procedure TppPDFProcSet.Write(aOutputStream: TStream; aReferenceNumber: Integer);
begin
  inherited;

  WriteLine(IntToStr(ReferenceNumber) + ' 0 obj');
  WriteLine('[/PDF /Text /ImageB /ImageC]');
  WriteLine('endobj');

end;

end.
