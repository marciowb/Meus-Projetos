{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2006                   BBBBB   }

unit ppDesignToolWindow;

interface

uses
  windows,
  Messages,
  Controls,
  Classes,

  ppIniStorage,
  ppClass,
  ppReport,
  ppDesignControllers,
  ppDesignEventHub,

  ppTBXDkPanels,
  ppToolbarTBX;

type

  {TppDesignToolWindow}
  TppDesignToolWindow = class(TppToolWindow)
  private
    FDesignControllers: TppDesignControllers;
    FEventHub: TppDesignEventHub;
    FOnVisibleChanged: TNotifyEvent;
    FReport: TppCustomReport;

    procedure CMVisibleChanged(var Message: TMessage); message CM_VISIBLECHANGED;
    procedure CMShowingChanged(var Message: TMessage); message CM_SHOWINGCHANGED;
    procedure ehSelection_SelectReport(Sender, aParameters: TObject);
    function GetMainReport: TppReport;

  protected
    // overriden from ancetor
    procedure SetParent(AParent: TWinControl); override;

    procedure AfterParentChange; virtual;
    procedure BeforeParentChange; virtual;
    procedure DoOnHelp(Sender: TObject; var aHelpFile, aKeyphrase: String; var aCallHelp: Boolean); virtual;
    procedure DoVisibleChanged; virtual;
    procedure SetEventHub(aEventHub: TppDesignEventHub); virtual;
    procedure SetReport(aReport: TppCustomReport); virtual;

  public
    procedure Initialize(aParent: TWinControl; aDesignControllers: TppDesignControllers); overload; virtual;
    procedure Notification(aComponent: TComponent; aOperation: TOperation); override;
    property DesignControllers: TppDesignControllers read FDesignControllers write FDesignControllers;
    property EventHub: TppDesignEventHub read FEventHub write SetEventHub;
    property MainReport: TppReport read GetMainReport;
    property Report: TppCustomReport read FReport;
    property OnVisibleChanged: TNotifyEvent read FOnVisibleChanged write FOnVisibleChanged;
  end;

implementation

{------------------------------------------------------------------------------}
{ TppDesignToolWindow.AfterParentChange}

procedure TppDesignToolWindow.AfterParentChange;
begin

end;

{------------------------------------------------------------------------------}
{ TppDesignToolWindow.BeforeParentChange}

procedure TppDesignToolWindow.BeforeParentChange;
begin

end;

{------------------------------------------------------------------------------}
{ TppDesignToolWindow.CMShowingChanged}

procedure TppDesignToolWindow.CMShowingChanged(var Message: TMessage);
begin

  inherited;

  ShowingChanged(Boolean(Message.WParam));

end;

{------------------------------------------------------------------------------}
{ TppDesignToolWindow.CMVisibleChanged}

procedure TppDesignToolWindow.CMVisibleChanged(var Message: TMessage);
begin
{$IFDEF CodeSite}
  gCodeSite.EnterMethod('TppCustomToolWindow.CMVisibleChanged');
{$ENDIF}

  if (Floating) and not(csDestroying in ComponentState) then
    DoVisibleChanged;

  inherited;

{$IFDEF CodeSite}
  gCodeSite.ExitMethod('TppCustomToolWindow.CMVisibleChanged');
{$ENDIF}

end;

{------------------------------------------------------------------------------}
{ TppDesignToolWindow.DoOnHelp}

procedure TppDesignToolWindow.DoOnHelp(Sender: TObject; var aHelpFile, aKeyphrase: String; var aCallHelp: Boolean);
begin

  {fire the help event}
  DesignControllers.DialogController.ShowHelp(aHelpFile, aKeyphrase);

  aCallHelp := False;


end; {procedure, DoOnHelp}

{------------------------------------------------------------------------------}
{ TppDesignToolWindow.DoVisibleChanged}

procedure TppDesignToolWindow.DoVisibleChanged;
begin
  if Assigned(FOnVisibleChanged) then FOnVisibleChanged(Self);

end;

{------------------------------------------------------------------------------}
{ TppDesignToolWindow.ehSelection_SelectReport }

procedure TppDesignToolWindow.ehSelection_SelectReport(Sender, aParameters: TObject);
begin

  SetReport(TppCustomReport(aParameters));

end;

{------------------------------------------------------------------------------}
{ TppDesignToolWindow.GetMainReport }

function TppDesignToolWindow.GetMainReport: TppReport;
begin

  if (FReport <> nil) then
    Result := TppReport(FReport.MainReport)
  else
    Result := nil;

end;

{------------------------------------------------------------------------------}
{ TppDesignToolWindow.Initialize}

procedure TppDesignToolWindow.Initialize(aParent: TWinControl; aDesignControllers: TppDesignControllers);
begin
  Parent := aParent;
  FDesignControllers := aDesignControllers;
  SupportedDocks := [dkMultiDock];

  CreateControls();

end;

{------------------------------------------------------------------------------}
{ TppDesignToolWindow.Notification}

procedure TppDesignToolWindow.Notification(aComponent: TComponent; aOperation: TOperation);
begin

  if (aOperation = opRemove) then
    if (FEventHub = aComponent) then
      SetEventHub(nil)
    else if (FReport = aComponent) then
      SetReport(nil);

  inherited;
  
end;

{------------------------------------------------------------------------------}
{TppDesignToolWindow.SetEventHub}

procedure TppDesignToolWindow.SetEventHub(aEventHub: TppDesignEventHub);
begin

  if (FEventHub <> aEventHub) then
    begin
      if (FEventHub <> nil) and not(csDestroying in FEventHub.ComponentState) then
        begin
          FEventHub.RemoveFreeNotification(Self);
          FEventHub.SelectionEvents.mcSelectReport.RemoveNotify(ehSelection_SelectReport);
        end;

      FEventHub := aEventHub;

      if (FEventHub <> nil) then
        begin
          FEventHub.FreeNotification(Self);
          FEventHub.SelectionEvents.mcSelectReport.AddNotify(ehSelection_SelectReport);
        end;

    end;
  
end;

{------------------------------------------------------------------------------}
{ TppDesignToolWindow.SetParent}

procedure TppDesignToolWindow.SetParent(AParent: TWinControl);
var
  lbParentChanging: Boolean;
begin

  lbParentChanging := (Parent <> aParent) and not(csDestroying in ComponentState);

  if lbParentChanging then
    try
      BeforeParentChange;

      inherited;

    finally
      AfterParentChange;
    end
  else
    inherited;

end;

{------------------------------------------------------------------------------}
{ TppDesignToolWindow.SetReport}

procedure TppDesignToolWindow.SetReport(aReport: TppCustomReport);
begin

  if FReport <> aReport then
    begin
      if (FReport <> nil) then
        FReport.RemoveFreeNotification(Self);

      FReport := aReport;

      if (FReport <> nil) then
        FReport.FreeNotification(Self);

    end;

end;



end.
