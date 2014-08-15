{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2001                    BBBBB   }

unit dmUtil;

interface

uses
  Windows, ComCtrls, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DB, DBTables,
  ppProd, ppRichTx;

type

  { TdmCustomForm }
  TdmCustomForm = class(TForm)
    private
      FAssignViewer: Boolean;
      FDisplayForm: Boolean;
      FDisplayFormModal: Boolean;

    protected
      function GetReport: TppProducer; virtual; abstract;
      procedure Init; virtual;
      
    public
      constructor Create(aOwner: TComponent); override;
      
      property AssignViewer: Boolean read FAssignViewer write FAssignViewer default False;
      property DisplayForm: Boolean read FDisplayForm write FDisplayForm default False;
      property DisplayFormModal: Boolean read FDisplayFormModal write FDisplayFormModal default False;
      property Report: TppProducer read GetReport;

  end; {class, TdmCustomForm}

  { TdmReportProps }
  TdmReportPropsRec = record
    DataBased: Boolean;
    Columns: Boolean;
    Groups: Boolean;
    MasterDetail: Boolean;
    TitleSummary: Boolean;
    Stretchables: Boolean;
    Memos: Boolean;
    RTFs: Boolean;
    Regions: Boolean;
    SubReports: Boolean;
    ShiftWithParents: Boolean;
    StretchWithParents: Boolean;
    ShiftRelativeTos: Boolean;
  end; {record, TdmReportProps}

  procedure ReportToDB(aDataSet: TDataSet; aProducer: TppProducer);


implementation

uses
  ppClass, ppBands, ppTypes, ppStrtch, ppReport, ppRegion, ppCtrls,
  ppMemo, ppSubRpt, ppTxPipe;

{------------------------------------------------------------------------------}
{ TdmCustomForm.Create }

constructor TdmCustomForm.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  Init;

end;

{------------------------------------------------------------------------------}
{ TdmCustomForm.Init }

procedure TdmCustomForm.Init;
begin
  FAssignViewer := False;
  FDisplayForm := False;
  FDisplayFormModal := False;
end; {procedure, Init}

{------------------------------------------------------------------------------}
{ GetReportProps }

procedure GetReportProps(aReport: TppReport; var aRec: TdmReportPropsRec);
var
  lDetailBand: TppDetailBand;
  lTitleBand: TppBand;
  lSummaryBand: TppBand;
  liObject: Integer;
  liObjects: Integer;
  lObject: TppComponent;
  liBand: Integer;
  liBands: Integer;
  lBand: TppBand;
begin
  lDetailBand := TppDetailBand(aReport.GetBand(btDetail, 0));
  lTitleBand := aReport.GetBand(btTitle, 0);
  lSummaryBand := aReport.GetBand(btSummary, 0);

  aRec.DataBased := (aReport.DataPipeline <> nil) and not(aReport.DataPipeline is TppTextPipeline);
  aRec.Columns := (aReport.Columns > 1);
  aRec.Groups := (aReport.GroupCount > 0);
  aRec.MasterDetail := (lDetailBand <> nil) and (lDetailBand.DataPipeline <> nil);
  aRec.TitleSummary := (lTitleBand <> nil) or (lSummaryBand <> nil);

  aRec.Memos := False;
  aRec.RTFs := False;
  aRec.Regions := False;
  aRec.SubReports := False;
  aRec.ShiftWithParents := False;
  aRec.ShiftRelativeTos := False;
  aRec.StretchWithParents := False;

  liBands := aReport.BandCount;

  for liBand := 0 to liBands - 1 do
    begin
      lBand := aReport.Bands[liBand];

      liObjects := lBand.ObjectCount;

      for liObject := 0 to liObjects - 1 do
        begin

          lObject := lBand.Objects[liObject];

          if lObject is TppStretchable then
            begin
              aRec.Stretchables := True;

              if TppStretchable(lObject).ShiftRelativeTo <> nil then
                aRec.ShiftRelativeTos := True;

              if lObject is TppCustomMemo then
                aRec.Memos := True

              else if lObject is TppCustomRichText then
                aRec.RTFs := True

              else if lObject is TppCustomRegion then
                aRec.Regions := True

              else if lObject is TppSubReport then
                aRec.SubReports := True;

            end
          else
            begin
              if (lObject is TppShape) then
                begin
                  if TppShape(lObject).StretchWithParent then
                    aRec.StretchWithParents := True
                  else if TppShape(lObject).ShiftWithParent then
                    aRec.ShiftWithParents := True;
                end
              else if (lObject is TppLine) then
                begin
                  if TppLine(lObject).StretchWithParent then
                    aRec.StretchWithParents := True
                  else if TppLine(lObject).ShiftWithParent then
                    aRec.ShiftWithParents := True;
                end
              else
                begin
                  if TppCustomComponent(lObject).ShiftWithParent then
                    aRec.ShiftWithParents := True;
                end;

            end; {if, custom component or stretchable}

        end; {for, each object}

    end; {for, each band}

end; {procedure, GetReportProps}


{------------------------------------------------------------------------------}
{ GetDefaultProps }

procedure GetDefaultProps(var aRec: TdmReportPropsRec);
begin
  aRec.DataBased := False;
  aRec.Columns := False;
  aRec.Groups := False;
  aRec.MasterDetail := False;
  aRec.TitleSummary := False;
  aRec.Stretchables := False;
  aRec.Memos := False;
  aRec.RTFs := False;
  aRec.Regions := False;
  aRec.SubReports := False;
  aRec.ShiftWithParents := False;
  aRec.StretchWithParents := False;
  aRec.ShiftRelativeTos := False;

end;


{------------------------------------------------------------------------------}
{ ReportToDB }

procedure ReportToDB(aDataSet: TDataSet; aProducer: TppProducer);
var
  lRec: TdmReportPropsRec;
begin

  GetDefaultProps(lRec);

  if (aProducer <> nil) and (aProducer is TppReport) then
    GetReportProps(TppReport(aProducer), lRec);

  aDataSet.Edit;

  aDataSet.FieldByName('Databased').AsBoolean := lRec.DataBased;
  aDataSet.FieldByName('Columns').AsBoolean := lRec.Columns;
  aDataSet.FieldByName('Groups').AsBoolean := lRec.Groups;
  aDataSet.FieldByName('MasterDetail').AsBoolean := lRec.MasterDetail;
  aDataSet.FieldByName('TitleSummary').AsBoolean := lRec.TitleSummary;
  aDataSet.FieldByName('Stretchables').AsBoolean := lRec.Memos;
  aDataSet.FieldByName('Memos').AsBoolean := lRec.Memos;
  aDataSet.FieldByName('RTFs').AsBoolean := lRec.RTFs;
  aDataSet.FieldByName('Regions').AsBoolean := lRec.Regions;
  aDataSet.FieldByName('SubReports').AsBoolean := lRec.SubReports;
  aDataSet.FieldByName('ShiftWithParents').AsBoolean := lRec.ShiftWithParents;
  aDataSet.FieldByName('StretchWithParents').AsBoolean := lRec.StretchWithParents;
  aDataSet.FieldByName('ShiftRelativeTos').AsBoolean := lRec.ShiftRelativeTos;

  aDataSet.Post;

end; {procedure, ReportToDB}



end. 
