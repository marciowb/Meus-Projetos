{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2005                    BBBBB   }

unit ppPDFImage;

interface

uses
  Classes;

type

  {@TppPDFImage

   }

  {@TppPDFImage.FirstImage

    Boolean value true if this is the first instance of the image being
    displayed. }

  {@TppPDFImage.ImagePage

    Page number in the Report that the image resides on. }

  {@TppPDFImage.ImageName

    Unique name for the image. }

  TppPDFImage = class
    private
      FFirstImage: Boolean;
      FImageName: String;
      FImagePage: Integer;
      FReferenceNumber: Integer;
      
      procedure SetFirstImage(const Value: Boolean);
      procedure SetImageName(const Value: String);
      procedure SetImagePage(const Value: Integer);
      procedure SetReferenceNumber(const Value: Integer);

    public
      constructor Create;

      property FirstImage: Boolean read FFirstImage write SetFirstImage;
      property ImagePage: Integer read FImagePage Write SetImagePage;
      property ImageName: String read FImageName write SetImageName;
      property ReferenceNumber: Integer read FReferenceNumber write SetReferenceNumber;
  end;

implementation

constructor TppPDFImage.Create;
begin
  inherited;

  FFirstImage := False;
  
end;

procedure TppPDFImage.SetFirstImage(const Value: Boolean);
begin
  FFirstImage := Value;
end;

procedure TppPDFImage.SetImageName(const Value: String);
begin
  FImageName := Value;
end;

procedure TppPDFImage.SetImagePage(const Value: Integer);
begin
  FImagePage := Value;
end;

procedure TppPDFImage.SetReferenceNumber(const Value: Integer);
begin
  FReferenceNumber := Value;
end;

end.
