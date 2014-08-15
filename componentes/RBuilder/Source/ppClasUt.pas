{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit ppClasUt;

interface

{$I ppIfDef.pas}

uses
  Classes, TypInfo, SysUtils, ppComm, ppTypes;

  function  ppComponentCreate(aParent: TComponent; appComponentClass: TComponentClass): TComponent;
  procedure ppConvertMemoTabStops(aReport: TComponent);
  function  ppExtractUserNamingNumber(aNamingPrefix: String; aComponent: TComponent; var aNamingNo: Integer): Boolean;
  procedure ppGetClickableComponents(aComponent: TComponent; aList: TStrings; FullDescription: Boolean);
  procedure ppGetCustomTextComponents(aReport: TComponent; aList: TStrings; FullDescription: Boolean);
  procedure ppGetFields(aReport: TComponent; aList: TStrings; FullDescription: Boolean);
  procedure ppGetStretchableComponents(aComponent: TComponent; aList: TStrings; FullDescription: Boolean);
  function  ppIsValidStretchable(aTarget, aStretchable: TComponent): Boolean;
  function  ppValidStretchablesExist(aReport: TComponent; aComponent: TComponent): Boolean;

implementation

uses
  ppClass, ppUtils, ppBands, ppDB, ppDsIntf, ppCtrls, ppMemo, ppPrintr,
  ppRegion, ppStrtch;

{------------------------------------------------------------------------------}
{ ppConvertMemoTabStops }

procedure ppConvertMemoTabStops(aReport: TComponent);
var
  liBand,
  liObject: Integer;
  lppReport: TppCustomReport;
  lppBand: TppBand;
  lppCustomMemo: TppCustomMemo;
begin

  if not (aReport is TppCustomReport) then Exit;

  lppReport := TppCustomReport(aReport);

  for liBand := 0 to (lppReport.BandCount - 1) do
    begin
      lppBand := lppReport.Bands[liBand];

      for liObject := 0 to lppBand.ObjectCount-1 do
        if lppBand.Objects[liObject] is TppCustomMemo then
          begin
            lppCustomMemo := TppCustomMemo(lppBand.Objects[liObject]);
            if lppCustomMemo.TabStopPositions.Count > 0  then
               ppPeriodToDecimalSeparator(lppCustomMemo.TabStopPositions);
          end;

    end;

end; {procedure, ppConvertMemoTabStops}

{------------------------------------------------------------------------------}
{ ppGetCustomTextComponents }

procedure ppGetCustomTextComponents(aReport: TComponent; aList: TStrings; FullDescription: Boolean);
var
  liBand: Integer;
  lBand: TppBand;
  lObject: TppComponent;
  liObject: Integer;
  lReport: TppCustomReport;
begin

  if not(aReport is TppCustomReport) then Exit;

  lReport := TppCustomReport(aReport);

  for liBand := 0 to lReport.BandCount - 1 do
    begin

      lBand := lReport.Bands[liBand];

      for liObject := 0 to TppBand(lBand).ObjectCount - 1 do
        begin
          lObject := TppComponent(lBand.Objects[liObject]);
          if lObject is TppCustomText then
            if FullDescription then
              aList.Add(TppCustomText(lObject).Description)
            else
              aList.Add(TppCustomText(lObject).Name);

        end; {for, each Object}

    end; {for, each Band}

end; {procedure, ppGetCustomTextComponents}

{------------------------------------------------------------------------------}
{ ppGetClickableComponents }

procedure ppGetClickableComponents(aComponent: TComponent; aList: TStrings; FullDescription: Boolean);
var
  lObject: TppComponent;
  liObject: Integer;
  lBand: TppBand;
begin

  if not(aComponent is TppComponent) then Exit;

  lBand := TppComponent(aComponent).Band;

  for liObject := 0 to TppBand(lBand).ObjectCount - 1 do
    begin
      lObject := lBand.Objects[liObject];

      if lObject.IsClickable and not(lObject = aComponent) then
        begin

          if FullDescription then
            aList.AddObject(lObject.Description, lObject)
          else
            aList.AddObject(lObject.Name, lObject);

        end;

    end; {for, each Object}

end; {procedure, ppGetClickableComponents}

{------------------------------------------------------------------------------}
{ ppValidStretchablesExist }

function ppValidStretchablesExist(aReport: TComponent; aComponent: TComponent): Boolean;
var
  lList: TStringList;
  lbFullDesc: Boolean;
begin
  lList := TStringList.Create;

  lbFullDesc := False;

  ppGetStretchableComponents(aComponent, TStrings(lList), lbFullDesc);

  if (lList.Count > 0) then
    Result := True
  else
    Result := False;

  lList.Free;
end; {function, ppValidStretchablesExist}

{------------------------------------------------------------------------------}
{ ppGetStretchableComponents }

procedure ppGetStretchableComponents(aComponent: TComponent; aList: TStrings; FullDescription: Boolean);
var
  lObject: TppComponent;
  liObject: Integer;
  lbAddIt: Boolean;
  lBand: TppBand;
begin

  if not(aComponent is TppComponent) then Exit;

  lBand := TppComponent(aComponent).Band;

  for liObject := 0 to TppBand(lBand).ObjectCount - 1 do
    begin
      lObject := TppComponent(lBand.Objects[liObject]);

      if (lObject is TppStretchable) then
        lbAddIt := True
      else
        lbAddIt := False;

      if (aComponent is TppStretchable) and lbAddIt then
        lbAddIt := ppIsValidStretchable(aComponent, lObject);

      if lbAddIt then
        begin
          if FullDescription then
            aList.AddObject(TppStretchable(lObject).Description, lObject)
          else
            aList.AddObject(lObject.Name, lObject);
        end;

    end; {for, each Object}

end; {procedure, ppGetStretchableComponents}

{------------------------------------------------------------------------------}
{ ppIsValidStretchable }

function ppIsValidStretchable(aTarget, aStretchable: TComponent): Boolean;
var
  lStretchable: TComponent;
begin
  Result := True;

  if (aStretchable = nil) then Exit;

  {if target is region, stretchable cannot be in region}
  if (aTarget is TppRegion) and (TppStretchable(aStretchable).Region = aTarget) then
    begin
      Result := False;

      Exit;
    end;

  lStretchable := aStretchable;

  while (lStretchable <> nil) and Result do
    begin
      if lStretchable = aTarget then
        Result := False;

      lStretchable := TppStretchable(lStretchable).ShiftRelativeTo;
    end;


end; {function, ppIsValidStretchable}

{------------------------------------------------------------------------------}
{ ppGetFields }

procedure ppGetFields(aReport: TComponent; aList: TStrings; FullDescription: Boolean);
var
  lReport: TppCustomReport;
  lDetailBand: TppDetailBand;
  lReportDataPipeline: TppDataPipeline;
  lDetailDataPipeline: TppDataPipeline;
  lList1: TStringList;
  lList2: TStringList;
  lList3: TStringList;
  liField: Integer;

begin
  if not(aReport is TppCustomReport) then Exit;

  lReport := TppCustomReport(aReport);

  lReportDataPipeline := lReport.DataPipeline;

  {get field names for Report's DataPipeline}
  if (lReportDataPipeline <> nil) then
    begin
      lList1 := TStringList.Create;
      lList3 := TStringList.Create;

      lReportDataPipeline.GetFieldNames(lList1, True {Visible fields});
      lReportDataPipeline.GetFieldAliases(lList3, True);

      for liField := 0 to lList1.Count - 1 do
        begin
          lList1.Objects[liField] := lReportDataPipeline;

          if FullDescription then
            lList1[liField] := lReportDataPipeline.UserName + '.' + lList3[liField];
        end;

      aList.AddStrings(lList1);

      lList1.Free;
      lList3.Free;
    end;


  lDetailBand := TppDetailBand(lReport.GetBand(btDetail, 0));

  {get field names for DetailBand's DataPipeline}
  if (lDetailBand <> nil) then
    lDetailDataPipeline := lDetailBand.DataPipeline
  else
    lDetailDataPipeline := nil;

  if (lDetailDataPipeline <> nil) then
    begin
      lList2 := TStringList.Create;
      lList3 := TStringList.Create;

      lDetailDataPipeline.GetFieldNames(lList2, True {Visible fields});
      lDetailDataPipeline.GetFieldAliases(lList3, True);

      for liField := 0 to lList2.Count - 1 do
        begin
          lList2.Objects[liField] := lDetailDataPipeline;

          if FullDescription then
            lList2[liField] := lDetailDataPipeline.UserName + '.' + lList3[liField];
        end;

      aList.AddStrings(lList2);

      lList2.Free;
      lList3.Free;
    end;

end; {procedure, ppGetFields}

{------------------------------------------------------------------------------}
{ ppComponentCreate}

function ppComponentCreate(aParent: TComponent; appComponentClass: TComponentClass): TComponent;
var
  lComponent: TComponent;
  lParent: TppCommunicator;
  lFormDesigner: TppFormDesigner;

begin

  Result := nil;

  if (aParent = nil) or not (aParent is TppCommunicator) then Exit;

  lParent := TppCommunicator(aParent);

  if (lParent is TppCustomReport) and (TppCustomReport(lParent).ReportDesigner = nil) then
    lFormDesigner := nil
  else
    lFormDesigner := lParent.FormDesigner;
 

  if (lFormDesigner <> nil) then
    begin
      {tell the FormDesigner to create a Component with no parent}
      lComponent := lParent.FormDesigner.CreateComponent(appComponentClass, nil, -1, -1, -1, -1);
      lComponent.Name := lParent.GetValidName(lComponent);
    end
  else
    begin
     lComponent := appComponentClass.Create(nil);

     lComponent.Name := lParent.GetValidName(lComponent);

     if lParent.Owner <> nil then
       lParent.Owner.InsertComponent(lComponent)
     else
       lParent.InsertComponent(lComponent);
    end;

  TppComponent(lComponent).UserName := lParent.GetUniqueUserName(lComponent);

  Result := lComponent;

end;


{------------------------------------------------------------------------------}
{ ppExtractUserNamingNumber }

function ppExtractUserNamingNumber(aNamingPrefix: String; aComponent: TComponent; var aNamingNo: Integer): Boolean;
var
  lsComponentNo: String;
  lCommunicator: TppCommunicator;

begin

  Result := False;

  if not (aComponent is TppCommunicator) then Exit;

  lCommunicator := TppCommunicator(aComponent);

  {determine whether component name has standard prefix}
  if not ( Pos(aNamingPrefix, lCommunicator.UserName) = 1) then Exit;

  {get name suffix}
  lsComponentNo := Copy(lCommunicator.UserName, (Length(aNamingPrefix) + 1),
                                          Length(lCommunicator.UserName));

  {determine whether name suffix is an integer}
  aNamingNo := StrToIntDef(lsComponentNo, 0);

  Result := (aNamingNo > 0);


end; {function, ppExtractUserNamingNumber}




end.



