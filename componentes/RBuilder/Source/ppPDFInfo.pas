{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2010                    BBBBB   }

unit ppPDFInfo;

interface

uses
  Classes,
  SysUtils,
  ppPDFObject;

type

  {@TppPDFInfo

    Writes the Info object to the PDF File.  The info object hold information
    about the PDF document such as the author, creator, creation data, keywords,
    subject and title. }

  {@TppPDFInfo.Author

    The name of the person who created the document. }

  {@TppPDFInfo.Keywords

    Keywords associated with the document. }

  {@TppPDFInfo.Subject

    The Subject of the document. }

  {@TppPDFInfo.Title

    The document's title. }

  TppPDFInfo = class(TppPDFObject)
    private
      FAuthor: String;
      FCreator: string;
      FKeywords: String;
      FSubject: String;
      FTitle: String;
      
      procedure SetAuthor(const Value: String);
      procedure SetCreator(const Value: string);
      procedure SetKeywords(const Value: String);
      procedure SetSubject(const Value: String);
      procedure SetTitle(const Value: String);

    public
      procedure Write(aOutputStream: TStream; aReferenceNumber: Integer); override;

      function CreationDate: String;

      property Author: String read FAuthor write SetAuthor;
      property Creator: string read FCreator write SetCreator;
      property Keywords: String read FKeywords write SetKeywords;
      property Subject: String read FSubject write SetSubject;
      property Title: String read FTitle write SetTitle;

  end;

implementation

uses
  ppPDFUtils;

{@TppPDFInfo.CreationDate

  Returns the current date in a format that PDF can read (yyyymmddhhnnss)}

function TppPDFInfo.CreationDate: String;
begin
  Result := FormatDateTime('yyyymmddhhnnss', Now());

end;

{@TppPDFInfo.Write

  Write instructions in PDF code to the PDF File Stream to create the Info
  object.}

procedure TppPDFInfo.Write(aOutputStream: TStream; aReferenceNumber: Integer);
begin
  inherited;

  WriteLine(IntToStr(ReferenceNumber) + ' 0 obj');
  WriteLine('<< /Creator <' + TppPDFUtils.StrToHex(TppPDFUtils.EncryptString(TppPDFUtils.ProcessText(Creator), EncryptionKey, ReferenceNumber, 0)) + '>');
  WriteLine('/CreationDate <' + TppPDFUtils.StrToHex(TppPDFUtils.EncryptString('D:' + CreationDate, EncryptionKey, ReferenceNumber, 0)) + '>');
  WriteLine('/Title <' + TppPDFUtils.StrToHex(TppPDFUtils.EncryptString(TppPDFUtils.ProcessText(Title), EncryptionKey, ReferenceNumber, 0)) + '>');
  WriteLine('/Author <' + TppPDFUtils.StrToHex(TppPDFUtils.EncryptString(TppPDFUtils.ProcessText(Author), EncryptionKey, ReferenceNumber, 0)) + '>');
  WriteLine('/Producer <' + TppPDFUtils.StrToHex(TppPDFUtils.EncryptString('ReportBuilder', EncryptionKey, ReferenceNumber, 0)) + '>');
  WriteLine('/Keywords <' + TppPDFUtils.StrToHex(TppPDFUtils.EncryptString(TppPDFUtils.ProcessText(Keywords), EncryptionKey, ReferenceNumber, 0)) + '>');
  WriteLine('/Subject <' + TppPDFUtils.StrToHex(TppPDFUtils.EncryptString(TppPDFUtils.ProcessText(Subject), EncryptionKey, ReferenceNumber, 0)) + '> >>');
  WriteLine('endobj');
end;

procedure TppPDFInfo.SetAuthor(const Value: String);
begin
  FAuthor := Value;
end;

procedure TppPDFInfo.SetCreator(const Value: string);
begin
  FCreator := Value;
end;

procedure TppPDFInfo.SetKeywords(const Value: String);
begin
  FKeywords := Value;
end;

procedure TppPDFInfo.SetSubject(const Value: String);
begin
  FSubject := Value;
end;

procedure TppPDFInfo.SetTitle(const Value: String);
begin
  FTitle := Value;
end;


end.
