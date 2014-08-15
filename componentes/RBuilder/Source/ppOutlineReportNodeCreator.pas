{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit ppOutlineReportNodeCreator;

interface

{$I ppIfDef.pas}

uses

  ppClass, ppComm, ppRTTI,
  ppOutlineNode, ppOutlineNodeCreator;

type

  {@TppOutlineReportNodeCreator }

  TppOutlineReportNodeCreator = class(TppOutlineNodeCreator)
    private

      procedure CreateReportNode;
      function GetReport: TppCustomReport;

    public

      procedure Initialize; override;
      procedure ProcessPageEnd; override;
      procedure EventNotify(aCommunicator: TppCommunicator; aEventID: Integer; aParams: TraParamList); override;

    end; { class, TppOutlineReportNodeCreator }

implementation

uses

  SysUtils,
  ppMath, ppReport, ppSubRpt, ppTypes, ppUtils,
  ppOutline, ppStrUtils;

{------------------------------------------------------------------------------}
{ TppOutlineReportNodeCreator.CreateReportNode }

procedure TppOutlineReportNodeCreator.CreateReportNode;
var
  lsCaption: String;
  lReportNode: TppOutlineNode;
begin

  if ((CurrentNode = nil) or ((CurrentNode <> nil) and not(CurrentNode.Open))) then
    begin

      lsCaption := GetReport.Caption;
      lsCaption := TppStrUtils.LeftString(lsCaption, Pos(':', lsCaption) - 1);
      if (lsCaption = '') then
        lsCaption := ppLoadStr(1040); // 'Main'

      lReportNode := TppOutlineNode.Create(nil);
      lReportNode.Open := True;
      lReportNode.Active := OutlineSettings.CreateNode;
      lReportNode.Caption := lsCaption;

      if (NodeCreatorComponent is TppReport) then
        lReportNode.NodeType := ntReport
      else
        lReportNode.NodeType := ntSubReport;

      lReportNode.PageReference := TppMath.Max(MainReport.Engine.AbsolutePageNo, 1);
      lReportNode.ParentNode := ParentNode;

      CurrentNode := lReportNode;

      if lReportNode.Active then
        lReportNode.Active := AcceptNodeCreate(lReportNode);

      AddNodeToPageList(lReportNode);

    end;

end; { procedure, CreateReportNode }

{------------------------------------------------------------------------------}
{ TppOutlineReportNodeCreator.GetReport }

function TppOutlineReportNodeCreator.GetReport: TppCustomReport;
begin

  if (NodeCreatorComponent is TppReport) then
    Result := TppCustomReport(NodeCreatorComponent)

  else if (NodeCreatorComponent is TppSubReport) then
    Result := TppCustomReport(TppSubReport(NodeCreatorComponent).Report)

  else
    Result := nil;

end; { function, GetReport }

{------------------------------------------------------------------------------}
{ TppOutlineReportNodeCreator.Initialize }

procedure TppOutlineReportNodeCreator.Initialize;
begin

  GetReport.AddEventNotify(Self);

  EventNotifies := EventNotifies + [ciEngineBeforeGenerate];

end; { procedure, PageComplete }

{------------------------------------------------------------------------------}
{ TppOutlineReportNodeCreator.ProcessPageEnd }

procedure TppOutlineReportNodeCreator.ProcessPageEnd;
begin

  if ((CurrentNode <> nil) and GetReport.Engine.LastBandGenerated) then
    CurrentNode.Open := False;

  CreatePageNodes;

  if ((CurrentNode <> nil) and CurrentNode.Open) then
    AddNodeToPageList(CurrentNode);

end; { procedure, ProcessPageEnd }

{------------------------------------------------------------------------------}
{ TppOutlineReportNodeCreator.EventNotify }

procedure TppOutlineReportNodeCreator.EventNotify(aCommunicator: TppCommunicator; aEventID: Integer; aParams: TraParamList);
var
  lbIsSubreport: Boolean;
  lbIsSectionSubreport: Boolean;
begin

  if ((aCommunicator = GetReport) and (aEventID = ciEngineBeforeGenerate)) then
    begin
      if (Outline = nil) then
        raise EOutlineError.Create('TppOutlineReportNodeCreator.EventNotify: Outline is nil');

      if (NodeCreatorComponent = nil) then
        raise EOutlineError.Create('TppOutlineReportNodeCreator.EventNotify: NodeCreatorComponent is nil');

      lbIsSubreport := NodeCreatorComponent is TppSubreport;

      if lbIsSubreport then
        lbIsSectionSubreport := (TppSubreport(NodeCreatorComponent).PrintBehavior = pbSection)
      else
        lbIsSectionSubreport := False;

      if not(TppOutline(Outline).Locked) and (not(lbIsSubreport) or lbIsSectionSubreport) then
        CreateReportNode;
    end;

end; { procedure, EventNotify }

{------------------------------------------------------------------------------}

end.

