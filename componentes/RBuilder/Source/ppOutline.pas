{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit ppOutline;

interface

{$I ppIfDef.pas}

uses

  Classes,
  ppComm, ppClass, ppRTTI,
  ppOutlineNode, ppOutlineNodeCreator;

type

  TppOutlineNodeCreateEvent = procedure(Sender: TObject; aNode: TppOutlineNode; var aAccept: Boolean) of object;

  {TppOutline

    TppOutline is helper class used to generate the outline.}

  TppOutline = class(TppCommunicator)
    private

      FComplete: Boolean;
      FCurrentPageNodeCreator: TppOutlineNodeCreator;
      FHighPageNo: Integer;
      FOnOutlineNodeCreate: TppOutlineNodeCreateEvent;
      FReport: TppCustomReport;
      FReportNodeCreator: TppOutlineNodeCreator;
      FRootNode: TppOutlineNode;
      FReportNode: TppOutlineNode;

      class procedure RecursiveAttemptKeepTogetherRewind(aNodeCreator: TppOutlineNodeCreator);
      class procedure RecursiveProcessPageEnd(aNodeCreator: TppOutlineNodeCreator);

      procedure CreateRootNode;
      function CreateNodeCreator(aParticipant: TppCommunicator; aParent: TppOutlineNodeCreator): TppOutlineNodeCreator;
      function HasDrillDown(aReport: TppCustomReport): Boolean;
      function GetComplete: Boolean;
      procedure SetReport(aReport: TppCustomReport);
      function GetLocked: Boolean;
      procedure GetSubreports(aReport: TppCustomReport; aSubreports: TList);


    public

      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      procedure Initialize;
      procedure EventNotify(aCommunicator: TppCommunicator; aEventID: Integer; aParams: TraParamList); override;
      procedure GenerateDrawCommand; virtual;
      procedure DoOnOutlineNodeCreate(Sender: TObject; aNode: TppOutlineNode; var aAccept: Boolean); virtual;

      property Complete: Boolean read GetComplete;
      property CurrentPageNodeCreator: TppOutlineNodeCreator read FCurrentPageNodeCreator write FCurrentPageNodeCreator;
      property Locked: Boolean read GetLocked;
      property OnOutlineNodeCreate: TppOutlineNodeCreateEvent read FOnOutlineNodeCreate write FOnOutlineNodeCreate;
      property Report: TppCustomReport read FReport write SetReport;
      property RootNode: TppOutlineNode read FRootNode;

    end; { class, TppOutline }

implementation

uses
  SysUtils, Dialogs,
  ppTypes, ppSubRpt,
  ppOutlineDrawCommand, ppOutlineParticipant, ppOutlineGroupNodeCreator;

{------------------------------------------------------------------------------}
{ TppOutline.Create }

constructor TppOutline.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  FComplete := False;
  FCurrentPageNodeCreator := nil;
  FHighPageNo := 0;
  FOnOutlineNodeCreate := nil;
  FReport := nil;
  FReportNodeCreator := nil;
  FRootNode := nil;
  FReportNode := nil;

end; { constructor, Create }

{------------------------------------------------------------------------------}
{ TppOutline.Destroy }

destructor TppOutline.Destroy;
begin

  FReportNodeCreator.Free;
  FReportNode.Free;
  FRootNode.Free;

  inherited Destroy;

end; { destructor, Destroy }

{------------------------------------------------------------------------------}
{ TppOutline.EventNotify }

procedure TppOutline.EventNotify(aCommunicator: TppCommunicator; aEventID: Integer; aParams: TraParamList);
begin

  inherited EventNotify(aCommunicator, aEventID, aParams);

  if (not(Locked) and (FReportNodeCreator <> nil)) then
    begin

      if ((aCommunicator = FReport) and (aEventID = ciEngineEndPage)) then
        begin

          RecursiveAttemptKeepTogetherRewind(FReportNodeCreator);
          RecursiveProcessPageEnd(FReportNodeCreator);

          FHighPageNo := FReport.Engine.AbsolutePageNo;

        end;

    end;

end; { procedure, EventNotify }

{------------------------------------------------------------------------------}
{ TppOutline.RecursiveAttemptKeepTogetherRewind }

class procedure TppOutline.RecursiveAttemptKeepTogetherRewind(aNodeCreator: TppOutlineNodeCreator);
var
  liIndex: Integer;
begin

  if (aNodeCreator is TppOutlineGroupNodeCreator) then
    TppOutlineGroupNodeCreator(aNodeCreator).AttemptKeepTogetherRewind;

  for liIndex := 0 to aNodeCreator.ChildCount - 1 do
    RecursiveAttemptKeepTogetherRewind(TppOutlineNodeCreator(aNodeCreator.Children[liIndex]));

end; { procedure, RecursiveAttemptKeepTogetherRewind }

{------------------------------------------------------------------------------}
{ TppOutline.RecursiveProcessPageEnd }

class procedure TppOutline.RecursiveProcessPageEnd(aNodeCreator: TppOutlineNodeCreator);
var
  liIndex: Integer;
begin

  aNodeCreator.ProcessPageEnd;

  for liIndex := 0 to aNodeCreator.ChildCount - 1 do
    RecursiveProcessPageEnd(TppOutlineNodeCreator(aNodeCreator.Children[liIndex]));

end; { procedure, RecursiveProcessPageEnd }

{------------------------------------------------------------------------------}
{ TppOutline.CreateRootNode }

procedure TppOutline.CreateRootNode;
begin

  FRootNode := TppOutlineNode.Create(nil);
  FRootNode.Caption := '';
  FRootNode.NodeType := ntRoot;
  FRootNode.PageReference := -1;

end; { procedure, InitializeRootNode }

{------------------------------------------------------------------------------}
{ TppOutline.CreateNodeCreator }

function TppOutline.CreateNodeCreator(aParticipant: TppCommunicator; aParent: TppOutlineNodeCreator): TppOutlineNodeCreator;
var
  liIndex: Integer;
  lChildList: TList;
  IIParticipant: IppOutlineParticipant;
begin

  aParticipant.GetInterface(IppOutlineParticipant, IIParticipant);

  if (IIParticipant = nil) then
    raise EOutlineError.Create('TppOutline.CreateNodeCreator: The outline participant does not support the IppOutlineParticipant interface.');

  Result := TppOutlineNodeCreator(IIParticipant.iOutlineNodeCreatorClass.Create(nil));

  if (aParent = nil) then
    Result.MainReport := TppCustomReport(aParticipant)
  else
    Result.MainReport := aParent.MainReport;

  Result.NodeCreatorComponent := aParticipant;
  Result.Outline := Self;
  Result.Parent := aParent;
  Result.Initialize;

  lChildList := IIParticipant.iOutlineGetChildren;

  for liIndex := 0 to lChildList.Count - 1 do
    CreateNodeCreator(lChildList[liIndex], Result);

end; { procedure, CreateNodeCreator }

{------------------------------------------------------------------------------}
{ TppOutline.SetReport }

procedure TppOutline.SetReport(aReport: TppCustomReport);
begin

  if (FReport <> nil) then
    FReport.RemoveEventNotify(Self);

  FReport := aReport;

  if (FReport <> nil) then
    FReport.AddEventNotify(Self);

end; { procedure, SetReport }

{------------------------------------------------------------------------------}
{ TppOutline.GetLocked }

function TppOutline.GetLocked: Boolean;
begin

  Result := False;

  if ((FReport <> nil) and (Report.Engine <> nil) and (FHighPageNo > 0)) then
    Result := (FReport.Engine.AbsolutePageNo <= FHighPageNo);

end; { function, GetLocked }

{------------------------------------------------------------------------------}
{ TppOutline.GetComplete }

function TppOutline.GetComplete: Boolean;
begin

  if not(FComplete) then
    FComplete := (FReport.Engine.LastBandGenerated or FReport.SecondPass)
  else
    FComplete := True;

  Result := FComplete;

end; { function, GetLocked }

{------------------------------------------------------------------------------}
{ TppOutline.Initialize }

procedure TppOutline.Initialize;
begin

  if (FReport = nil) then
    raise EOutlineError.Create('TppOutline.Initialize: Report is nil.');

  FHighPageNo := 0;

  FRootNode.Free;

  FReportNodeCreator.Free;

  CreateRootNode;

  if HasDrillDown(FReport) then
    begin
      FComplete := True;

      FReportNode := TppOutlineNode.Create(nil);
      FReportNode.Open := True;
      FReportNode.Active := True;
      FReportNode.Caption := 'NoOutline: DrillDown not supported';
      FReportNode.NodeType := ntNoOutline;
      FReportNode.PageReference := -1;
      FReportNode.ParentNode := FRootNode;

      EventNotifies := EventNotifies - [ciEngineStartPage, ciEngineEndPage, ciEngineEndFirstPass];
    end

  else
    begin
      FComplete := False;

      FReportNodeCreator := CreateNodeCreator(FReport, nil);

      EventNotifies := EventNotifies + [ciEngineStartPage, ciEngineEndPage, ciEngineEndFirstPass];
    end;

end; { procedure, Initialize }

{------------------------------------------------------------------------------}
{ TppOutline.HasDrillDown }

function TppOutline.HasDrillDown(aReport: TppCustomReport): Boolean;
var
  lSubreports: TList;
  lSubreport: TppSubreport;
  liIndex: Integer;
begin

  Result := False;

  lSubreports := TList.Create;

  GetSubreports(aReport, lSubreports);

  for liIndex := 0 to lSubreports.Count - 1 do
    begin

      lSubreport := TppSubreport(lSubreports[liIndex]);

      if (lSubreport.IsDrillDown) and not(lSubreport.ExpandAll) then
        Result := True;

    end;

  lSubreports.Free;

end;

{------------------------------------------------------------------------------}
{ TppOutline.GetSubreports }

procedure TppOutline.GetSubreports(aReport: TppCustomReport; aSubreports: TList);
var
  liIndex: Integer;
  liIndex2: Integer;
  lBand: TppBand;
  lComponent: TppComponent;
begin

  for liIndex := 0 to aReport.BandCount - 1 do
    begin

      lBand := aReport.Bands[liIndex];

      for liIndex2 := 0 to lBand.ObjectCount - 1 do
        begin
          lComponent := TppComponent(lBand.Objects[liIndex2]);

          if lComponent is TppSubreport then
            begin
              GetSubreports(TppSubreport(lComponent).Report, aSubreports);

              aSubreports.Add(lComponent);
            end;
        end;

    end;

end;

{------------------------------------------------------------------------------}
{ TppOutline.GenerateDrawCommand }

procedure TppOutline.GenerateDrawCommand;
var
  lDrawOutline: TppOutlineDrawCommand;
begin

  lDrawOutline := TppOutlineDrawCommand.Create(nil);
  lDrawOutline.RootNode := TppOutlineNode.CloneActiveRootNode(FRootNode);
  lDrawOutline.Completed := GetComplete;
  lDrawOutline.Page := FReport.Engine.Page;

end;{ procedure, GenerateDrawCommand }

{------------------------------------------------------------------------------}
{ TppOutline.DoOutlineNodeCreate }

procedure TppOutline.DoOnOutlineNodeCreate(Sender: TObject; aNode: TppOutlineNode; var aAccept: Boolean);
begin

  if Assigned(FOnOutlineNodeCreate) then FOnOutlineNodeCreate(Sender, aNode, aAccept);

end; { procedure, DoOutlineNodeCreate }

{------------------------------------------------------------------------------}

end.

