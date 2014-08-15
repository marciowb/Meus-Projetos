{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2003                    BBBBB   }

unit ppPDFCatalog;

interface

uses
  Classes,
  SysUtils,
  ppPDFObject;

type

  {TppPDFCatalog

    Writes the Catalog object to the PDF File.  The Catalog contains references
    to other objects in the PDF file.  In this case the Page Tree object only. }

  TppPDFCatalog = class(TppPDFObject)
    private

    public
      procedure Write(aOutputStream: TStream; aReferenceNumber: Integer); override;

  end;

implementation

{TppPDFCatalog.Write }

procedure TppPDFCatalog.Write(aOutputStream: TStream; aReferenceNumber: Integer);
begin
  inherited;

  WriteLine(IntToStr(ReferenceNumber) + ' 0 obj');
  WriteLine('<< /Type /Catalog');
  WriteLine('/Pages ' + IntToStr(aReferenceNumber + 1) + ' 0 R');
  WriteLine('>>');
  WriteLine('endobj');

end;

end.
