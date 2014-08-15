{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2009                    BBBBB   }

unit ppPDFEncoding;

interface

uses
  Classes,
  SysUtils,
  Graphics,
  ppPDFObject;

type
  TppPDFEncoding = class(TppPDFObject)
  private
    FFont: TFont;
    FFontCharSet: TFontCharSet;
    FTempEncodingStream: TMemoryStream;

    procedure SetFont(Value: TFont);

  protected
    procedure CreatePDFEncoding; virtual;
    procedure RetrieveCharSet; virtual;

    procedure ArabicDifferences; virtual;
    procedure EastEuropeDifferences; virtual;
    procedure GreekDifferences; virtual;
    procedure HebrewDifferences; virtual;
    procedure CyrillicDifferences; virtual;

  public
    constructor Create; override;
    destructor Destroy; override;

    procedure SaveEncoding(aPosition: Integer);
    procedure Write(aOutputStream: TStream; aReferenceNumber: Integer); override;

    property Font: TFont read FFont write SetFont;

  end;

implementation

uses
  Windows;

constructor TppPDFEncoding.Create;
begin
  inherited;
  FTempEncodingStream := TMemoryStream.Create;
end;

destructor TppPDFEncoding.Destroy;
begin
  FTempEncodingStream.Free;

  inherited;
  
end;

procedure TppPDFEncoding.CreatePDFEncoding;
begin

  case FFontCharSet of
    161:   GreekDifferences;
    177:   HebrewDifferences;
    178:   ArabicDifferences;
    204:   CyrillicDifferences;
    238:   EastEuropeDifferences;
  end;

end;

procedure TppPDFEncoding.RetrieveCharSet;
var
  liAPICharSet: Integer;
begin

  FFontCharSet := FFont.Charset;

  if FFontCharSet = 1 then        //Default Charset (use regional settings)
    begin
      liAPICharSet := GetACP;     //Get the default code page using the Windows API

      case liAPICharSet of
       1252: FFontCharSet := 0;   //ANSI
       1253: FFontCharSet := 161; //Greek
       1255: FFontCharSet := 177; //Hebrew
       1256: FFontCharSet := 178; //Arabic
       1251: FFontCharSet := 204; //Cyrillic
       1250: FFontCharSet := 238; //East European

      else
        FFontCharSet := 0;
      end;

    end;

end;

{@TppPDFFont.SaveEncoding

  Copies the TppPDFEncoding object from the internal temporary memory stream to the
  main device file stream.  Call once all pages have been generated. }

procedure TppPDFEncoding.SaveEncoding(aPosition: Integer);
begin
  ByteOffset := aPosition;

  FTempEncodingStream.Position := 0;
  OutputStream.CopyFrom(FTempEncodingStream, FTempEncodingStream.Size);
end;

procedure TppPDFEncoding.Write(aOutputStream: TStream; aReferenceNumber: Integer);
begin
  inherited;

  RetrieveCharSet;

  WriteMSLine(FTempEncodingStream, IntToStr(ReferenceNumber) + ' 0 obj');
  WriteMSLine(FTempEncodingStream, '<< /Type /Encoding');
  WriteMSLine(FTempEncodingStream, '/BaseEncoding /WinAnsiEncoding');

  CreatePDFEncoding;

  WriteMSLine(FTempEncodingStream, '>>');
  WriteMSLine(FTempEncodingStream, 'endobj');

end;

procedure TppPDFEncoding.SetFont(Value: TFont);
begin
  FFont := Value;

end;

procedure TppPDFEncoding.ArabicDifferences;
begin
  WriteMSLine(FTempEncodingStream,'/Differences [');
  WriteMSLine(FTempEncodingStream,'129 /afii57506');
  WriteMSLine(FTempEncodingStream,'138 /afii57511');
  WriteMSLine(FTempEncodingStream,'141 /afii57507 /afii57508 /afii57512 /afii57509');
  WriteMSLine(FTempEncodingStream,'154 /afii57513');
  WriteMSLine(FTempEncodingStream,'157 /afii61664');
  WriteMSLine(FTempEncodingStream,'158 /afii301 /afii57514');
  WriteMSLine(FTempEncodingStream,'161 /afii57388');
  WriteMSLine(FTempEncodingStream,'186 /afii57403');
  WriteMSLine(FTempEncodingStream,'191 /afii57407');
  WriteMSLine(FTempEncodingStream,'193 /afii57409 /afii57410 /afii57411 /afii57412 /afii57413 /afii57414 /afii57415 /afii57416 /afii57417 /afii57418 /afii57419 /afii57420 /afii57421 /afii57422 /afii57423 /afii57424 /afii57425 /afii57426 /afii57427 /afii57428 /afii57429 /afii57430');
  WriteMSLine(FTempEncodingStream,'216 /afii57431 /afii57432 /afii57433 /afii57434 /afii57440 /afii57441 /afii57442 /afii57443');
  WriteMSLine(FTempEncodingStream,'225 /afii57444');
  WriteMSLine(FTempEncodingStream,'227 /afii57445 /afii57446 /afii57470 /afii57448');
  WriteMSLine(FTempEncodingStream,'236 /afii57449 /afii57450');
  WriteMSLine(FTempEncodingStream,'240 /afii57451 /afii57452 /afii57453 /afii57454 /afii57455 /afii57456');
  WriteMSLine(FTempEncodingStream,'248 /afii57457');
  WriteMSLine(FTempEncodingStream,'250 /afii57458');
  WriteMSLine(FTempEncodingStream,'253 /afii299 /afii300 /afii57519');
  WriteMSLine(FTempEncodingStream,']');

end;

procedure TppPDFEncoding.EastEuropeDifferences;
begin
  WriteMSLine(FTempEncodingStream,'/Differences [');
  WriteMSLine(FTempEncodingStream,'140 /Sacute /Tcaron');
  WriteMSLine(FTempEncodingStream,'143 /Zacute');
  WriteMSLine(FTempEncodingStream,'156 /sacute /tcaron');
  WriteMSLine(FTempEncodingStream,'159 /zacute');
  WriteMSLine(FTempEncodingStream,'161 /caron /breve /Lslash');
  WriteMSLine(FTempEncodingStream,'165 /Aogonek');
  WriteMSLine(FTempEncodingStream,'170 /Scedilla');
  WriteMSLine(FTempEncodingStream,'175 /Zdotaccent');
  WriteMSLine(FTempEncodingStream,'178 /ogonek /lslash');
  WriteMSLine(FTempEncodingStream,'185 /aogonek /scedilla');
  WriteMSLine(FTempEncodingStream,'188 /Lcaron /hungarumlaut /lcaron /zdotaccent /Racute');
  WriteMSLine(FTempEncodingStream,'195 /Abreve');
  WriteMSLine(FTempEncodingStream,'197 /Lacute /Cacute');
  WriteMSLine(FTempEncodingStream,'200 /Ccaron');
  WriteMSLine(FTempEncodingStream,'202 /Eogonek');
  WriteMSLine(FTempEncodingStream,'204 /Ecaron');
  WriteMSLine(FTempEncodingStream,'207 /Dcaron /Dcroat /Nacute /Ncaron');
  WriteMSLine(FTempEncodingStream,'213 /Ohungarumlaut');
  WriteMSLine(FTempEncodingStream,'216 /Rcaron /Uring');
  WriteMSLine(FTempEncodingStream,'219 /Uhungarumlaut');
  WriteMSLine(FTempEncodingStream,'222 /Tcedilla');
  WriteMSLine(FTempEncodingStream,'224 /racute');
  WriteMSLine(FTempEncodingStream,'227 /abreve');
  WriteMSLine(FTempEncodingStream,'229 /lacute /cacute');
  WriteMSLine(FTempEncodingStream,'232 /ccaron');
  WriteMSLine(FTempEncodingStream,'234 /eogonek');
  WriteMSLine(FTempEncodingStream,'236 /ecaron');
  WriteMSLine(FTempEncodingStream,'239 /dcaron /dcroat /nacute /ncaron');
  WriteMSLine(FTempEncodingStream,'245 /ohungarumlaut');
  WriteMSLine(FTempEncodingStream,'248 /rcaron /uring');
  WriteMSLine(FTempEncodingStream,'251 /uhungarumlaut');
  WriteMSLine(FTempEncodingStream,'254 /tcedilla /dotaccent');
  WriteMSLine(FTempEncodingStream,']');
  
end;

procedure TppPDFEncoding.GreekDifferences;
begin
  WriteMSLine(FTempEncodingStream,'/Differences [');
  WriteMSLine(FTempEncodingStream,'161 /dieresistonos /Alphatonos');
  WriteMSLine(FTempEncodingStream,'175 /afii00208');
  WriteMSLine(FTempEncodingStream,'180 /tonos');
  WriteMSLine(FTempEncodingStream,'184 /Epsilontonos /Etatonos /Iotatonos');
  WriteMSLine(FTempEncodingStream,'188 /Omicrontonos');
  WriteMSLine(FTempEncodingStream,'190 /Upsilontonos /Omegatonos /iotadieresistonos /Alpha /Beta /Gamma /Delta /Epsilon /Zeta /Eta /Theta /Iota /Kappa /Lambda /Mu /Nu /Xi /Omicron /Pi /Rho');
  WriteMSLine(FTempEncodingStream,'211 /Sigma /Tau /Upsilon /Phi /Chi /Psi /Omega /Iotadieresis /Upsilondieresis /alphatonos /epsilontonos /etatonos /iotatonos /upsilondieresistonos /alpha');
  WriteMSLine(FTempEncodingStream,'226 /beta /gamma /delta /epsilon /zeta /eta /theta /iota /kappa /lambda /mu /nu /xi /omicron /pi /rho /sigma1 /sigma /tau /upsilon /phi /chi /psi /omega');
  WriteMSLine(FTempEncodingStream,'250 /iotadieresis /upsilondieresis /omicrontonos /upsilontonos /omegatonos');
  WriteMSLine(FTempEncodingStream,']');

end;

procedure TppPDFEncoding.HebrewDifferences;
begin
  WriteMSLine(FTempEncodingStream,'/Differences [');
  WriteMSLine(FTempEncodingStream,'164 /afii57636');
  WriteMSLine(FTempEncodingStream,'170 /multiply');
  WriteMSLine(FTempEncodingStream,'186 /divide');
  WriteMSLine(FTempEncodingStream,'192 /afii57799 /afii57801 /afii57800 /afii57802 /afii57793 /afii57794 /afii57795 /afii57798 /afii57797 /afii57806');
  WriteMSLine(FTempEncodingStream,'203 /afii57796 /afii57807 /afii57839 /afii57645 /afii57841 /afii57842 /afii57804 /afii57803 /afii57658 /afii57716 /afii57717 /afii57718');
  WriteMSLine(FTempEncodingStream,'224 /afii57664 /afii57665 /afii57666 /afii57667 /afii57668 /afii57669 /afii57670 /afii57671 /afii57672 /afii57673 /afii57674 /afii57675');
  WriteMSLine(FTempEncodingStream,'/afii57676 /afii57677 /afii57678 /afii57679 /afii57680 /afii57681 /afii57682 /afii57683 /afii57684 /afii57685 /afii57686 /afii57687 /afii57688 /afii57689 /afii57690');
  WriteMSLine(FTempEncodingStream,'253 /afii299 /afii300');
  WriteMSLine(FTempEncodingStream,']');

end;

procedure TppPDFEncoding.CyrillicDifferences;
begin
  WriteMSLine(FTempEncodingStream,'/Differences [');
  WriteMSLine(FTempEncodingStream,'128 /afii10051 /afii10052');
  WriteMSLine(FTempEncodingStream,'131 /afii10100');
  WriteMSLine(FTempEncodingStream,'136 /Euro');
  WriteMSLine(FTempEncodingStream,'138 /afii10058');
  WriteMSLine(FTempEncodingStream,'140 /afii10059 /afii10061 /afii10060 /afii10145 /afii10099');
  WriteMSLine(FTempEncodingStream,'154 /afii10106');
  WriteMSLine(FTempEncodingStream,'156 /afii10107 /afii10109 /afii10108 /afii10193');
  WriteMSLine(FTempEncodingStream,'161 /afii10062 /afii10110 /afii10057');
  WriteMSLine(FTempEncodingStream,'165 /afii10050');
  WriteMSLine(FTempEncodingStream,'168 /afii10023');
  WriteMSLine(FTempEncodingStream,'170 /afii10053');
  WriteMSLine(FTempEncodingStream,'175 /afii10056');
  WriteMSLine(FTempEncodingStream,'178 /afii10055 /afii10103 /afii10098');
  WriteMSLine(FTempEncodingStream,'184 /afii10071 /afii61352 /afii10101');
  WriteMSLine(FTempEncodingStream,'188 /afii10105 /afii10054 /afii10102 /afii10104 /afii10017 /afii10018 /afii10019 /afii10020 /afii10021 /afii10022 /afii10024');
  WriteMSLine(FTempEncodingStream,'/afii10025 /afii10026 /afii10027 /afii10028 /afii10029 /afii10030 /afii10031 /afii10032 /afii10033 /afii10034');
  WriteMSLine(FTempEncodingStream,'/afii10035 /afii10036 /afii10037 /afii10038 /afii10039 /afii10040 /afii10041 /afii10042 /afii10043 /afii10044');
  WriteMSLine(FTempEncodingStream,'/afii10045 /afii10046 /afii10047 /afii10048 /afii10049 /afii10065 /afii10066 /afii10067 /afii10068 /afii10069');
  WriteMSLine(FTempEncodingStream,'/afii10070 /afii10072 /afii10073 /afii10074 /afii10075 /afii10076 /afii10077 /afii10078 /afii10079 /afii10080');
  WriteMSLine(FTempEncodingStream,'/afii10081 /afii10082 /afii10083 /afii10084 /afii10085 /afii10086 /afii10087 /afii10088 /afii10089 /afii10090');
  WriteMSLine(FTempEncodingStream,'/afii10091 /afii10092 /afii10093 /afii10094 /afii10095 /afii10096 /afii10097');
  WriteMSLine(FTempEncodingStream,']');
end;

end.
