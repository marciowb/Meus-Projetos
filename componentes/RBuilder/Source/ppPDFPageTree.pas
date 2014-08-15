{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2003                    BBBBB   }

unit ppPDFPageTree;

interface

uses
  Classes,
  SysUtils,
  ppPDFObject;

type

  {@TppPDFPageTree

    Each PDF File needs one page tree. The page tree needs references to each
    page in the PDF File so it cannot be written to file directly.  Therefor
    the page tree is saved to a memory stream first and updated as new pages
    are added to the PDF file.  Once all pages have been generated and written
    to the PDF file, the memory stream is saved to the main file stream. }

  {@TppPDFPageTree.MemoryStream

    Memory Stream used to temporarily hold the Page Tree instructions while
    pages are being created. }
    
  TppPDFPageTree = class(TppPDFObject)
    private
      FMemoryStream: TMemoryStream;
      FPageCount: Integer;

    public
      procedure AddPageChild(aReference: Integer);
      procedure EndPageTree;
      procedure StartPageTree;
      procedure Write(aOutputStream: TStream; aReferenceNumber: Integer); override;

      property MemoryStream: TMemoryStream read FMemoryStream;

  end;


implementation

{@TppPDFPageTree.AddPageChild

  Call this routine to add a page reference to the page tree given the page
  reference from the page created. }

procedure TppPDFPageTree.AddPageChild(aReference: Integer);
begin
  WriteMSLine(FMemoryStream, IntToStr(aReference) + ' 0 R');
  FPageCount := FPageCount + 1;
end;

{@TppPDFPageTree.EndPageTree

  Call to end the page tree and write the contents of the memory stream to the
  main file stream. }

procedure TppPDFPageTree.EndPageTree;
begin
  WriteMSLine(FMemoryStream, ']');
  WriteMSLine(FMemoryStream, '/Count ' + IntToStr(FPageCount));
  WriteMSLine(FMemoryStream, '>>');
  WriteMSLine(FMemoryStream, 'endobj');

  {Set new byte offset}
  ByteOffset := OutputStream.Position;

  {Save Memory stream to output stream}
  FMemoryStream.SaveToStream(TStream(OutputStream));

  FMemoryStream.Free;
  
end;

{@TppPDFPageTree.StartPageTree

  Call to start the page tree for the PDF File.  NOTE:  This method should only
  be called once per file. }

procedure TppPDFPageTree.StartPageTree;
begin
  FMemoryStream := TMemoryStream.Create;

  WriteMSLine(FMemoryStream, IntToStr(ReferenceNumber) + ' 0 obj');
  WriteMSLine(FMemoryStream, '<< /Type /Pages');
  WriteMSLine(FMemoryStream, '/Kids[');

end;

{@TppPDFPageTree.Write}

procedure TppPDFPageTree.Write(aOutputStream: TStream; aReferenceNumber: Integer);
begin
  inherited;

end;


end.
