{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit ppDisplayFormat;

interface

{$I ppIfDef.pas}

uses
  {$IFDEF Delphi6}Variants, MaskUtils, {$ENDIF}
  Classes,
  ppTypes;

type

  TppDisplayFormat = class
    private
      class function CalcDigits(aDisplayFormat: String): Integer;

    public
      class function  Format(const aDisplayFormat: String; aDataType: TppDataType; aValue: Variant): String; virtual;
      class procedure GetDisplayFormats(aDataType: TppDataType; aFormatList: TStrings); virtual;
  end;

  TppDisplayFormatClass = class of TppDisplayFormat;

implementation

uses
  SysUtils, Mask,
  ppUtils;

{------------------------------------------------------------------------------}
{ TppDisplayFormat.GetDisplayFormats }

class procedure TppDisplayFormat.GetDisplayFormats(aDataType: TppDataType; aFormatList: TStrings);
begin

  if aFormatList = nil then Exit;

  aFormatList.Clear;

  case aDataType of
  
    dtString:
      begin
        aFormatList.Add('Phone'           + #1 + '!\(999\)\ 000\-0000;0; ');
        aFormatList.Add('Extension'       + #1 + '!99999;0; ');
        aFormatList.Add('Social Security' + #1 + '000\-00\-0000;0; ');
        aFormatList.Add('Short Zip Code'  + #1 + '00000;0; ');
        aFormatList.Add('Long Zip Code'   + #1 + '00000\-9999;0; ');
        aFormatList.Add('Date'            + #1 + '!99/99/00;0; ');
        aFormatList.Add('Long Time'       + #1 + '!90:00:00\ >LL;0; ');
        aFormatList.Add('Short Time'      + #1 + '!90:00;0; ');
      end;

    dtInteger, dtSingle, dtDouble, dtExtended, dtCurrency, dtLongint, dtLargeInt:
      begin
        aFormatList.Add('-1,234'     + #1 + '#,0;-#,0');
        aFormatList.Add('-1,234.40'  + #1 + '#,0.00;-#,0.00');
        aFormatList.Add('(1,234.40)' + #1 + '#,0.00;(#,0.00)');
        aFormatList.Add('($1,234.40)'+ #1 + '$#,0.00;($#,0.00)');
        aFormatList.Add('-$1,234.40' + #1 + '$#,0.00;-$#,0.00');
        aFormatList.Add('-$1,234'    + #1 + '$#,0;-$#,0');
        aFormatList.Add('($1,234)'   + #1 + '$#,0;($#,0)');
        aFormatList.Add('-1234 %'    + #1 + '0 %');
        aFormatList.Add('-1234.40 %' + #1 + '0.00 %');
      end;

    dtDate:
      begin
        aFormatList.Add('3/4/95'            + #1 + 'm/d/yy');
        aFormatList.Add('03/04/95'          + #1 + 'mm/dd/yy');
        aFormatList.Add('03/04/1995'        + #1 + 'mm/dd/yyyy');
        aFormatList.Add('4-Mar-95 '         + #1 + 'd-mmm-yy');
        aFormatList.Add('04-Mar-95 '        + #1 + 'dd-mmm-yy');
        aFormatList.Add('March 4, 1995'     + #1 + 'mmmm d, yyyy');
        aFormatList.Add('3/4'               + #1 + 'm/d');
        aFormatList.Add('Mar-95'            + #1 + 'mmm-yy');
        aFormatList.Add('March-95'          + #1 + 'mmmm-yy');
      end;

    dtTime:
      begin
        aFormatList.Add('1:30 PM'    + #1 + 'h:nn AM/PM');
        aFormatList.Add('13:30'      + #1 + 'h:nn');
        aFormatList.Add('1:30:55 PM' + #1 + 'h:nn:ss AM/PM');
        aFormatList.Add('13:30:55'   + #1 + 'h:nn:ss');
      end;

    dtBoolean:
      begin
        aFormatList.Add('Yes'  + #1 + 'Yes;No');
        aFormatList.Add('Y'    + #1 + 'Y;N');
        aFormatList.Add('True' + #1 + 'True;False');
        aFormatList.Add('T'    + #1 + 'T;F');
        aFormatList.Add('OK'   + #1 + 'OK;');
        aFormatList.Add('Done' + #1 + 'Done;');
        aFormatList.Add(''     + #1 + ';Not OK');
        aFormatList.Add(''     + #1 + ';Not Done');
      end;

    dtDateTime:
      begin
        aFormatList.Add('3/4/95 1:30:55 PM' + #1 + 'm/d/yy h:nn:ss AM/PM');
        aFormatList.Add('3/4/95 13:30:55'   + #1 + 'm/d/yy h:nn:ss');
        aFormatList.Add('3/4/95'            + #1 + 'm/d/yy');
        aFormatList.Add('03/04/95'          + #1 + 'mm/dd/yy');
        aFormatList.Add('03/04/1995'        + #1 + 'mm/dd/yyyy');
        aFormatList.Add('4-Mar-95 '         + #1 + 'd-mmm-yy');
        aFormatList.Add('04-Mar-95 '        + #1 + 'dd-mmm-yy');
        aFormatList.Add('March 4, 1995'     + #1 + 'mmmm d, yyyy');
        aFormatList.Add('3/4'               + #1 + 'm/d');
        aFormatList.Add('Mar-95'            + #1 + 'mmm-yy');
        aFormatList.Add('March-95'          + #1 + 'mmmm-yy');
      end;

  end; {case, DataType}


end; {class procedure, GetDisplayFormats}

{------------------------------------------------------------------------------}
{ TppDisplayFormat.Format }

class function TppDisplayFormat.Format(const aDisplayFormat: String; aDataType: TppDataType; aValue: Variant): String;
var
  lsFormatStr: String;
  lfFormat: TFloatFormat;
  liDigits: Integer;
  liPrecision: Integer;
  lsString: String;
  liPos: Integer;
  lsTrueString: String;
  lsFalseString: String;
begin

  Result := '';

  if VarIsNull(aValue) then Exit;

  case aDataType of

    dtInteger, dtSingle, dtDouble, dtExtended, dtCurrency, dtLongint, dtLargeInt:
      begin

        lsFormatStr  := aDisplayFormat;

        if (Pos('$', aDisplayFormat) <> 0) then
          begin
            lfFormat := ffCurrency;
            liDigits := CalcDigits(aDisplayFormat);
            liPrecision := 15;
            lsString := FloatToStrF(aValue, lfFormat, liPrecision, liDigits);
          end

        else if (aDisplayFormat <> '') then
          begin
            if aDataType = dtCurrency then
              lsString := FormatCurr(aDisplayFormat, aValue)
            else
              lsString := FormatFloat(aDisplayFormat, aValue);
          end

        else
          begin

            if (aDataType = dtCurrency) then
              begin
                lfFormat := ffCurrency;
                liDigits := CurrencyDecimals;
                liPrecision := 15;
              end

            else
              begin
                lfFormat := ffGeneral;
                liDigits := 0;
                liPrecision := 15;
              end;

            lsString := FloatToStrF(aValue, lfFormat, liPrecision, liDigits);
          end;

        Result := lsString;
      end;

    dtDate:

      if Length(aDisplayFormat) > 0 then
        Result := FormatDateTime(aDisplayFormat, aValue)
      else
        Result := FormatDateTime(ShortDateFormat, aValue);


    dtTime:

      if Length(aDisplayFormat) > 0 then
        Result := FormatDateTime(aDisplayFormat, aValue)
      else
        Result := FormatDateTime(LongTimeFormat, aValue);


    dtDateTime:

      if Length(aDisplayFormat) > 0 then
        Result := FormatDateTime(aDisplayFormat, aValue)
      else
        Result := FormatDateTime('c', aValue);

    dtString, dtChar, dtMemo, dtGuid:
      if Length(aDisplayFormat) > 0 then
         Result := FormatMaskText(aDisplayFormat, aValue)
      else
         Result := aValue;

    dtBoolean:
      begin
        if (Length(aDisplayFormat) > 0) and (TVarData(aValue).VType = varBoolean) then
          begin

            liPos :=  Pos(';', aDisplayFormat);

            if (liPos > 0) then
              begin
                if (liPos > 1) then
                  begin
                    lsTrueString := Copy(aDisplayFormat, 1, liPos - 1);
                    lsFalseString := Copy(aDisplayFormat, liPos + 1, Length(aDisplayFormat));
                  end
                else
                  begin
                    lsTrueString := '';
                    lsFalseString := Copy(aDisplayFormat, liPos + 1, Length(aDisplayFormat));
                  end;
              end
            else
              begin
                lsTrueString := aDisplayFormat;
                lsFalseString := '';
              end;

            if (aValue) then
              Result := lsTrueString
            else
              Result := lsFalseString
          end
        else
          Result := aValue;

      end;

  end;


end; {class function, Format}

class function TppDisplayFormat.CalcDigits(aDisplayFormat: String): Integer;
var
  lsFormat: String;
  liPos: Integer;
begin

  {calc digits required after the decimal separator }
  if Pos('.', aDisplayFormat) = 0 then
    Result := 0
  else
    begin
      liPos :=  Pos(';', aDisplayFormat);
      if liPos > 0 then
        lsFormat := Copy(aDisplayFormat, 1, liPos-1)
      else
        lsFormat := aDisplayFormat;

      Result := Length(lsFormat) - Pos('.', lsFormat);
    end;
end;


initialization
  gcDisplayFormat := TppDisplayFormat;
finalization
  gcDisplayFormat := nil;
end.
