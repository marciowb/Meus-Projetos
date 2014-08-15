{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2006                   BBBBB   }

unit ppDesignObserver;

interface

uses
  Classes,
  ppClass,
  ppComm,
  ppReport,
  ppTypes,
  ppDesignEventHub;

type

  {TppDesignObserver}
  TppDesignObserver = class(TppCommunicator)
  private
    FEventHub: TppDesignEventHub;
    FReport: TppCustomReport;

    procedure ehSelection_SelectReport(Sender, aParameters: TObject);
    function GetMainReport: TppReport;

  protected
    procedure SetEventHub(aEventHub: TppDesignEventHub); virtual;
    procedure SetReport(const Value: TppCustomReport); virtual;

  public
    procedure Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType); override;

    property EventHub: TppDesignEventHub read FEventHub write SetEventHub;
    property MainReport: TppReport read GetMainReport;
    property Report: TppCustomReport read FReport;

  end;

implementation


{------------------------------------------------------------------------------}
{ TppDesignObserver.ehSelection_SelectReport }

procedure TppDesignObserver.ehSelection_SelectReport(Sender, aParameters: TObject);
begin

  SetReport(TppCustomReport(aParameters));

end;

{------------------------------------------------------------------------------}
{ TppDesignObserver.GetMainReport }

function TppDesignObserver.GetMainReport: TppReport;
begin

  if (FReport <> nil) then
    Result := TppReport(FReport.MainReport)
  else
    Result := nil;

end;

{------------------------------------------------------------------------------}
{TppDesignObserver.Notify}

procedure TppDesignObserver.Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType);
begin

  if (aOperation = ppopRemove) then
    begin
      if (aCommunicator = FReport) then
        SetReport(nil)
      else if (aCommunicator = EventHub) then
        SetEventHub(nil);
    end;

  inherited;

end; {procedure, Notify}

{------------------------------------------------------------------------------}
{TppDesignObserver.SetEventHub}

procedure TppDesignObserver.SetEventHub(aEventHub: TppDesignEventHub);
begin

  if (FEventHub <> aEventHub) then
    begin
      if (FEventHub <> nil) and not(csDestroying in FEventHub.ComponentState) then
        begin
          FEventHub.RemoveNotify(Self);
          FEventHub.SelectionEvents.mcSelectReport.RemoveNotify(ehSelection_SelectReport);
        end;

      FEventHub := aEventHub;

      if (FEventHub <> nil) then
        begin
          FEventHub.AddNotify(Self);
          FEventHub.SelectionEvents.mcSelectReport.AddNotify(ehSelection_SelectReport);
        end;

    end;
  
end;

{------------------------------------------------------------------------------}
{ TppDesignObserver.SetReport}

procedure TppDesignObserver.SetReport(const Value: TppCustomReport);
begin

  if FReport <> Value then
    begin
      if (FReport <> nil) then
        FReport.RemoveNotify(Self);

      FReport := Value;

      if (FReport <> nil) then
        FReport.AddNotify(Self);

    end;

end;


end.
