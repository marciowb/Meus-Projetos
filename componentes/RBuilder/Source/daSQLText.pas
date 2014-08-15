{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2008                    BBBBB   }

unit daSQLText;

interface

uses
  SysUtils,
  Classes,

  ppTypes,
  ppCharacter,
  ppUtils,
  ppParameter,

  daSQLParser;

type

   {TdaSQLText

      TdaSQL
         SQLText <---> TdaSQLText
                         QueryExpression: TdaSQLQueryExpression
                         QueryParameters: TppParameterList;


   }

   TdaSQLTextClass = class of TdaSQLText;


   {TdaSQLText}
   TdaSQLText = class(TStringList)
   private
     FSQL: TObject;
     FOutOfSync: Boolean;
     FQueryExpression: TdaSQLQueryExpression;
     FSQLCommantText: TStrings;

//     function GetAvailableLinkingTypes: TdaLinkTypes;
     function GetIsParseable: Boolean;
     function GetQueryParameters: TppParameterList;
     function GetQueryExpression: TdaSQLQueryExpression;

   protected
     procedure Changed; override;
     function FormatParamValue(aParam: TppParameter): String; overload; virtual;
     function FormatParamValue(aParam: TppParameter; aValue: Variant): String; overload; virtual;
     function ResolveParam(aParameter: TppParameter): String;  virtual;
     procedure SetTextStr(const Value: string); override;

   public
     constructor Create(aSQL: TObject); virtual;
     destructor Destroy; override;

     function GetCommandText(aParameters: TppParameterList): TStrings;  virtual;
     function ValidateCommandText(aParameters: TppParameterList; var aErrorMessage: String): Boolean;  virtual;

//     property AvailableLinkingTypes: TdaLinkTypes read GetAvailableLinkingTypes;
     property IsParseable: Boolean read GetIsParseable;
     property QueryExpression: TdaSQLQueryExpression read GetQueryExpression;
     property QueryParameters: TppParameterList read GetQueryParameters;

   end;

implementation

uses
  daSQL;


constructor TdaSQLText.Create(aSQL: TObject);
begin

  inherited Create;

  FSQL := aSQL;
  FQueryExpression := TdaSQLQueryExpression.Create;
  FSQLCommantText := TStringList.Create;

end;

destructor TdaSQLText.Destroy;
begin

  inherited;

  FQueryExpression.Free;
  FSQLCommantText.Free;

end;

procedure TdaSQLText.Changed;
begin
  inherited;

  FOutOfSync := True;

end;

function TdaSQLText.FormatParamValue(aParam: TppParameter; aValue: Variant): String;
const
  SearchConditions: array[0..13] of String[11] = ('=','<>','<','<=','>','>=','LIKE','NOT LIKE',
                                                  'BETWEEN','NOT BETWEEN','IN','NOT IN','IS NULL','IS NOT NULL');
var
  lDateTime: TDateTime;
  lcDateSeparator: Char;
  lbContainsTime: Boolean;
  lsDateFormat: string;
  lsTimeFormat: string;
  lsWildCard: Char;
  lSQL: TdaSQL;
begin

  lSQL := TdaSQL(FSQL);

  Result := TrimLeft(aValue);

//  if not(CaseSensitive) then
//    Result := Uppercase(Result);

  if (aParam.DataType in [dtDate, dtDateTime]) or ((aParam.DataType in [dtTime]) and (lSQL.IsNexusDB)) then
    begin

      try
        ppStrToDateTime(aValue);
      except on EConvertError do
        begin
          Result := '';
  
          Exit;
        end;
      end;

      lDateTime := ppStrToDateTime(aValue);

      lcDateSeparator := DateSeparator;

      lsDateFormat := lSQL.Session.GetSearchCriteriaDateFormat(lSQL.DatabaseType, lSQL.DatabaseName);
      lsTimeFormat := lSQL.Session.GetSearchCriteriaTimeFormat(lSQL.DatabaseType, lSQL.DatabaseName);

      if (lSQL.IsOracle or lSQL.IsSybaseASA or lSQL.IsSybaseASE or lSQL.IsMSSQLServer) then
        lbContainsTime := (Pos(#32, Result) <> 0)
      else
        lbContainsTime := (Pos(#32, Result) <> 0) or (aParam.DataType = dtDateTime);

      try
        DateSeparator := '/';
  
        if lbContainsTime then
          Result := FormatDateTime(lsDateFormat + ' ' + lsTimeFormat, lDateTime)
        else
          Result := FormatDateTime(lsDateFormat, lDateTime);
  
        {add special function call to convert the Oracle date based on the format of the criteria value}
        if (lSQL.IsOracle) then
          begin
            if (lbContainsTime) then
              Result := 'TO_DATE(' + '''' + Result + '''' + ',' + '''' + lsDateFormat + ' HH24:MI:SS' + '''' + ')'
            else
              Result := 'TO_DATE(' + '''' + Result + '''' + ',' + '''' + lsDateFormat + '''' + ')';
          end;

        if (lSQL.IsMSSQLServer) then
          begin
            if (lbContainsTime) then
              Result := 'CONVERT(DATETIME,' + '''' + Result + '''' + ',' + '120' + ')'
            else
              Result := 'CONVERT(DATETIME,' + '''' + Result + '''' + ',' + '120' + ')'
          end;

        if (lSQL.DatabaseType in [dtNexusDB, dtElevateDB]) then
          begin
            case aParam.DataType of
              dtDate:     Result := 'DATE ' + '''' + FormatDateTime(lsDateFormat, lDateTime) + '''';
              dtDateTime: Result := 'TIMESTAMP ' + '''' + FormatDateTime(lsDateFormat, lDateTime) + ' ' + FormatDateTime(lsTimeFormat, lDateTime) + '''';
              dtTime:     Result := 'TIME ' + '''' + FormatDateTime(lsDateFormat, lDateTime) + '''';
            end;
          end;
                

      finally
        DateSeparator := lcDateSeparator;
      end; {try, finally}
  

      if lSQL.IsMSAccess or lSQL.IsApollo then
        Result := '#' + Result + '#'
      else if not(lSQL.DatabaseType in [dtNexusDB, dtElevateDB, dtOracle, dtMSSQLServer]) then

//            else if not(IsOracle) and not(IsMSSQLServer) and not(IsNexusDB) then
        Result := '''' + Result + '''';
     end

  else if (aParam.DataType in [dtBoolean]) and
          (lSQL.IsAdvantage or lSQL.IsMSSQLServer or lSQL.IsOracle or lSQL.IsSybaseASE or lSQL.IsSybaseASA) then
    begin
      if (Length(Result) > 0) and ppCharInSet(UpperCase(Result[1])[1], ['T', 'Y', '1']) then
        Result := '1'
      else
        Result := '0';
    end
  
  else if (aParam.DataType in [dtBoolean]) then
    begin
      if (Length(Result) > 0) and ppCharInSet(UpperCase(Result[1])[1], ['T', 'Y', '1']) then
        Result := 'TRUE'
      else
        Result := 'FALSE';
    end
  
  else if (aParam.DataType in dacaNumerics) then
    Result := ppFixUpFloatString(Result, '')

  else if (lSQL.IsNexusDB) and (aParam.DataType = dtGuid) then
    Result := 'GUID ' + '''' + Result + ''''

  else if not(aParam.AutoSearchSettings.SearchOperator in [soBlank, soNotBlank]) then
    begin

      if lSQL.IsMSAccess and (CompareText(lSQL.Session.ClassName, 'TdaBDESession') = 0) then
        lsWildCard := '*'
      else
        lsWildCard := '%';

      if (aParam.AutoSearchSettings.SearchOperator in [soLike, soNotLike]) and (Pos('_', Result) = 0) and (Pos(lsWildCard, Result) = 0) then
        Result := Result + lsWildCard;

      if (lSQL.SQLType = sqBDELocal) then
        Result := '"' + Result + '"'
      else
        Result := '''' + Result + '''';

    end;


end;

function TdaSQLText.FormatParamValue(aParam: TppParameter): String;
var
  liIndex: Integer;
begin

  Result := '';
  
  for liIndex := 0 to aParam.ValueCount - 1 do
    begin
      if liIndex > 0 then
        Result := Result + ',';

         Result := Result + FormatParamValue(aParam, aParam.Values[liIndex]);

    end;

end;

{
function TdaSQLText.GetAvailableLinkingTypes: TdaLinkTypes;
begin

  if FQueryExpression.IsValid then
    Result := [ltParameterizedSQL, ltManualSQL]
  else
    Result := [ltManualSQL];

end;
}

function TdaSQLText.GetCommandText(aParameters: TppParameterList): TStrings;
var
  liIndex: Integer;
  lQueryParam: TppParameter;
  lReportParameter: TppParameter;
begin

  for liIndex := 0 to GetQueryExpression.Parameters.Count - 1 do
    begin
      lQueryParam := FQueryExpression.Parameters.ItemsByIndex[liIndex];

      if aParameters.InList(lQueryParam.Name) then
        begin
          lReportParameter := aParameters.Items[lQueryParam.Name];

          lQueryParam.Value := ResolveParam(lReportParameter);
        end;

    end;

  FSQLCommantText.Text := FQueryExpression.GetCommandText;

  Result := FSQLCommantText;

end;

function TdaSQLText.GetIsParseable: Boolean;
begin
  Result := GetQueryExpression.IsValid;
end;

function TdaSQLText.GetQueryExpression: TdaSQLQueryExpression;
begin

  if FOutOfSync then
    begin
      FQueryExpression.DatabaseType := TdaSQL(FSQL).DatabaseType;
      FQueryExpression.Read(Self);
    end;

  Result := FQueryExpression;

end;

function TdaSQLText.GetQueryParameters: TppParameterList;
begin
  Result := GetQueryExpression.Parameters;
end;

function TdaSQLText.ResolveParam(aParameter: TppParameter): String;
var
  lsValue: String;
begin

  case aParameter.AutoSearchSettings.SearchOperator of

    soEqual, soNotEqual, soLessThan, soLessThanOrEqualTo,
    soGreaterThan, soGreaterThanOrEqualTo, soLike, soNotLike:
      lsValue := FormatParamValue(aParameter);

    soBlank, soNotBlank:
      lsValue := '';
  
    soBetween, soNotBetween:
      begin

        if (aParameter.ValueCount = 2) then
          lsValue := FormatParamValue(aParameter, aParameter.Values[0]) + ' AND ' + FormatParamValue(aParameter, aParameter.Values[1])
        else
          lsValue := '';

      end;

    soInList, soNotInList:
      begin

        lsValue := '(' + FormatParamValue(aParameter) + ')';
  
      end; {inlist}
  
  end; {case, operator type}

  Result := lsValue;

end;

procedure TdaSQLText.SetTextStr(const Value: string);
var
  lStrings: TStringList;
begin

  inherited;

  // this enables TdaSQL.SQLText.Text to be updated directly,
  // this code will trigger the prop setter for SQLText (i.e. TdaSQL.SetSQLText)
  if (FSQL <> nil) then
    begin
      lStrings := TStringList.Create;
      lStrings.Assign(Self);
      TdaSQL(FSQL).SQLText := lStrings;
      lStrings.Free;
    end;

end;

function TdaSQLText.ValidateCommandText(aParameters: TppParameterList; var aErrorMessage: String): Boolean;
var
  liIndex: Integer;
  lQueryParam: TppParameter;
begin

  Result := True;

  for liIndex := 0 to GetQueryExpression.Parameters.Count - 1 do
    begin
      lQueryParam := FQueryExpression.Parameters.ItemsByIndex[liIndex];

      if not aParameters.InList(lQueryParam.Name) then
         begin
           aErrorMessage := 'No Report Parameter found for ' + ':'  + lQueryParam.UserName;  //TODO Lang
           Result := False;
           Exit;
         end;

    end;

end;


end.
