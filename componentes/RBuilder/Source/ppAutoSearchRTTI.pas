{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2003                    BBBBB   }

unit ppAutoSearchRTTI;

interface

uses
  Classes,
  ppProd, ppASField;

type

{@TppAutoSearchRTTI

  Provides the capability to transfer the autosearch fields from one object to
  another, without knowing hte class type. The primary use of this class is to
  pull the autosearch fields from the current report in order to use the same
  autosearch fields on a report created by the background print process.}

  TppAutoSearchRTTI = class
    private
      class procedure CopyAutosearchFields(aAutosearchFieldsInterface: IppAutoSearchFields; aAutoSearchFields: TList);
      class procedure CreateAutosearchFields(aCreateAutosearchFieldsInterface: IppAutoSearchFields; aAutosearchFieldsInterface: IppAutoSearchFields; aAutoSearchFields: TList);

    public
      class function GetAutoSearchFieldCount(aProducer: TppProducer): Integer;
      class function GetAutosearchFieldForIndex(aProducer: TppProducer; aIndex: Integer): TppAutosearchField;
      class function GetHasAutoSearchFields(aProducer: TppProducer): Boolean;
      class procedure GetAutosearchGroups(aProducer: TppProducer; aAutosearchGroups: TppAutosearchGroups);
      class procedure SetAutoSearchGroups(aProducer: TppProducer; aAutosearchGroups: TppAutoSearchGroups);

    end;


implementation

uses
  ppTypes;

{@TppAutoSearchRTTI.GetHasAutoSearchFields }

class function TppAutoSearchRTTI.GetHasAutoSearchFields(aProducer: TppProducer): Boolean;
begin
  Result := (GetAutoSearchFieldCount(aProducer) <> 0);
end;
 
{@TppAutoSearchRTTI.GetAutosearchGroups

  Assigns the autosearch group's autosearch fields to a report.}

class procedure TppAutoSearchRTTI.GetAutosearchGroups(aProducer: TppProducer; aAutosearchGroups: TppAutoSearchGroups);
var
  liIndex: Integer;
  liAutosearchGroupsFieldCount: Integer;
  liReportAutoSearchFieldCount: Integer;
  lAutoSearchFields: TList;
  llAutosearchFields: IppAutosearchFields;
begin

  lAutoSearchFields := TList.Create;

  try
    aAutosearchGroups.GetAllFields(lAutoSearchFields);

    liAutosearchGroupsFieldCount := lAutoSearchFields.Count;

    liReportAutoSearchFieldCount := GetAutoSearchFieldCount(aProducer);

    {do have autosearch to transfer}
    if (liAutoSearchGroupsFieldCount > 0) then
      begin

        if (aProducer.GetInterface(IppAutosearchFields, llAutosearchFields)) then
          begin
            {non DADE report with autosearch}
            if (liReportAutoSearchFieldCount = 0) then
              CreateAutosearchFields(llAutosearchFields, llAutosearchFields, lAutoSearchFields)

            {DADE report with autosearch}
            else
              CopyAutosearchFields(llAutosearchFields, lAutoSearchFields);
          end;

      end;

  finally
    for liIndex := 0 to lAutoSearchFields.Count - 1 do
      TObject(lAutoSearchFields[liIndex]).Free;

    lAutoSearchFields.Free;
  end;

end;
      
{@TppAutoSearchRTTI.CreateAutosearchFields }

class procedure TppAutoSearchRTTI.CreateAutosearchFields(aCreateAutosearchFieldsInterface: IppAutoSearchFields; aAutosearchFieldsInterface: IppAutoSearchFields; aAutoSearchFields: TList);
var
  liIndex: Integer;
  lField: TppAutosearchField;
  lNewField: TppAutosearchField;
begin

  for liIndex := 0 to aAutoSearchFields.Count - 1 do
    begin
      lField := TppAutosearchField(aAutoSearchFields[liIndex]);

      lNewField := aCreateAutosearchFieldsInterface.iCreateAutoSearchField(lField.TableName, lField.FieldName, lField.FieldAlias, lField.Datatype, lField.SearchOperator, lField.SearchExpression, lField.Mandatory);
      lNewField.Assign(lField);
      lNewField.AssignSearchValuesFromField(lField);
    end;

end;

{@TppAutoSearchRTTI.CopyAutoSearchFields }

class procedure TppAutoSearchRTTI.CopyAutoSearchFields(aAutosearchFieldsInterface: IppAutoSearchFields; aAutoSearchFields: TList);
var
  liAutosearchFieldCount: Integer;
  liIndex: Integer;
  lReportAutosearchField: TppAutosearchField;
  lRequestAutosearchField: TppAutosearchField;
begin

  liAutosearchFieldCount := aAutosearchFieldsInterface.iAutoSearchFieldCount;

  if (aAutoSearchFields.Count <> liAutosearchFieldCount) then
    raise EBackgroundPrintError.Create('TppAutoSearchRTTI.CopyAutoSearchFields: The report in the background thread has different autosearch fields than the request.');

  for liIndex := 0 to liAutosearchFieldCount - 1 do
    begin
      lReportAutosearchField := aAutosearchFieldsInterface.iAutosearchFieldForIndex(liIndex);
      lRequestAutosearchField := TppAutosearchField(aAutoSearchFields[liIndex]);

      lReportAutosearchField.Assign(lRequestAutosearchField);
      lReportAutosearchField.AssignSearchValuesFromField(lRequestAutosearchField);
    end;

end;
    
{@TppAutoSearchRTTI.GetAutoSearchFieldCount }

class function TppAutoSearchRTTI.GetAutoSearchFieldCount(aProducer: TppProducer): Integer;
var
  llAutosearchFields: IppAutosearchFields;
begin

  if aProducer.GetInterface(IppAutosearchFields, llAutosearchFields) and (llAutosearchFields <> nil) then
    Result := llAutosearchFields.iAutoSearchFieldCount
  else
    Result := 0;

end;

{@TppAutoSearchRTTI.GetAutosearchFieldForIndex }

class function TppAutoSearchRTTI.GetAutosearchFieldForIndex(aProducer: TppProducer; aIndex: Integer): TppAutosearchField;
var
  llAutosearchFields: IppAutosearchFields;
begin

  if aProducer.GetInterface(IppAutosearchFields, llAutosearchFields) and (llAutosearchFields <> nil) then
    Result := llAutosearchFields.iAutoSearchFieldForIndex(aIndex)
  else
    Result := nil;

end;
 
{@TppAutoSearchRTTI.SetAutoSearchGroups

  Pulls the autosearch fields from the current producer and populates a new
  autosearch groups object with the autosearch fields and its values.}

class procedure TppAutoSearchRTTI.SetAutoSearchGroups(aProducer: TppProducer; aAutosearchGroups: TppAutosearchGroups);
var
  lNewField: TppAutosearchField;
  liAutoSearchFieldCount: Integer;
  lField: TppAutosearchField;
  lAutoSearchFields: TList;
  liIndex: Integer;
begin

  if (aAutosearchGroups <> nil) then
    begin

      lAutoSearchFields := TList.Create;

      try
        liAutoSearchFieldCount := GetAutoSearchFieldCount(aProducer);

        for liIndex := 0 to liAutoSearchFieldCount - 1 do
          begin
            lNewField := TppAutosearchField.Create(nil);
            lField := GetAutosearchFieldForIndex(aProducer, liIndex);

            lNewField.Assign(lField);
            lNewField.AssignSearchValuesFromField(lField);

            lAutoSearchFields.Add(lNewField);
          end;

        aAutosearchGroups.AssignAutoSearchFields(lAutoSearchFields);

      finally
        lAutoSearchFields.Free;
      end;

    end;

end;

end.
 
