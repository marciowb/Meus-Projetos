{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2004                    BBBBB   }

unit ppPDFGState;

interface

uses
  Classes,
  SysUtils,
  ppPDFObject;

type
  TppPDFGState = class(TppPDFObject)
    private

    public
      procedure Write(aOutputStream: TStream; aReferenceNumber: Integer); override;
      
  end;

implementation

{@TppPDFProcSet.Write}

procedure TppPDFGState.Write(aOutputStream: TStream; aReferenceNumber: Integer);
begin
  inherited;

  WriteLine(IntToStr(ReferenceNumber) + ' 0 obj');
  WriteLine('<< /Type /ExtGState');
  WriteLine('/SA true');
  WriteLine('>>');
  WriteLine('endobj');

end;

end.
 
