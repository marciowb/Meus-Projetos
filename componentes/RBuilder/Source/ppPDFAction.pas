{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2009                    BBBBB   }

unit ppPDFAction;

interface

uses
  Classes,
  SysUtils,
  Types,
  ppPDFObject;

type

  {@TppPDFAction

    The TppPDFAction class writes a URI Action type Annotation to the PDF file.
    This allows clickable navigation links to be added to a PDF document.}

  TppPDFAction = class(TppPDFObject)

    private
      FActionBounds: TRect;
      FActionpage: Integer;
      FHyperLink: string;
      FPageHeight: Double;

      procedure CreateAction;
      procedure SetHyperLink(const Value: string);

    public
      constructor Create; override;

      procedure Write(aOutputStream: TStream; aReferenceNumber: Integer); override;
      procedure SaveAction(aPosition: Integer);

      property ActionBounds: TRect read FActionBounds write FActionBounds;
      property ActionPage:  Integer read FActionPage write FActionPage;
      property HyperLink: string read FHyperLink write SetHyperLink;
      property PageHeight: Double read FPageHeight write FPageHeight;

  end;


implementation

uses
  ppPDFUtils;

{ TppPDFAction }

constructor TppPDFAction.Create;
begin
  FActionBounds := Rect(0,0,0,0);
  FHyperLink := '';

end;

procedure TppPDFAction.CreateAction;
var
  lsLeft: String;
  lsTop: String;
  lsRight: String;
  lsBottom: String;
begin

  lsLeft := ExtToStr(TppPDFUtils.MicronsToPoints(FActionBounds.Left));
  lsTop := ExtToStr(PageHeight - TppPDFUtils.MicronsToPoints(FActionBounds.Top));
  lsRight := ExtToStr(TppPDFUtils.MicronsToPoints(FActionBounds.Right));
  lsBottom := ExtToStr(PageHeight - TppPDFUtils.MicronsToPoints(FActionBounds.Bottom));

  WriteLine(IntToStr(ReferenceNumber) + ' 0 obj');
  WriteLine('<< /Type /Annot');
  WriteLine('/Subtype /Link');
  WriteLine('/Rect [' + lsLeft + ' ' + lsBottom + ' ' + lsRight + ' ' + lsTop + ']');
  WriteLine('/Border [0 0 0]');
  WriteLine('/A << /Type /Action');
  WriteLine('/S /URI');
  WriteLine('/URI <' + TppPDFUtils.StrToHex(TppPDFUtils.EncryptString(TppPDFUtils.ProcessText(HyperLink), EncryptionKey, ReferenceNumber, 0)) + '>');
  WriteLine('>>');
  WriteLine('>>');
  WriteLine('endobj');

end;

procedure TppPDFAction.SetHyperLink(const Value: string);
begin
  FHyperLink := Value;
end;

procedure TppPDFAction.Write(aOutputStream: TStream; aReferenceNumber: Integer);
begin
  inherited;

end;

procedure TppPDFAction.SaveAction(aPosition: Integer);
begin
  ByteOffset := aPosition;

  CreateAction;
end;

end.
