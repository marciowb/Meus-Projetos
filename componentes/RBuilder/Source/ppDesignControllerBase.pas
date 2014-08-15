{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2006                   BBBBB   }

unit ppDesignControllerBase;

interface

uses
  Types,
  Classes,
  Dialogs,

  ppTypes,
  ppUtils,
  ppComm,
  ppClass,
  ppReport,
  ppRegion,
  ppRuler,
  ppUndo,

  ppDesignObserver,
  ppDesignControls,
  ppDesignEventHub,
  ppDesignSelection,
  ppDesignerWorkspace,
  ppDesignWorkspaceView, ppDB;

type


  {TppDesignControllerBase}
  TppDesignControllerBase = class(TppDesignObserver)
  private
    FDesignControlManager: TppDesignControlManager;
    FSelection: TppDesignSelection;
    FUndoManager: TppUndoManager;
    FWorkspace: TppWorkspace;
    FWorkspaceView: TppDesignWorkspaceView;

  protected
    function CalcSnapToGridPos(aWorkspacePoint: TPoint): TPoint;
    procedure DoOnHelp(Sender: TObject; var aHelpFile, aKeyphrase: String; var aCallHelp: Boolean); virtual;
    procedure ehGetFieldForAlias(Sender: TObject; const aFieldAlias: String; var aDataPipeline: TObject; var aDataField: String); virtual;
    function GetFieldAliases: TStrings; virtual;
    procedure GetFieldForAlias(const aFieldAlias: String; var aDataPipeline: TppDataPipeline; var aDataField: String);
    procedure SetWorkspace(aWorkspace: TppWorkspace); virtual;
    procedure SetWorkspaceView(const Value: TppDesignWorkspaceView); virtual;

  public
    procedure Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;

    function CheckComponentAdd: Boolean; virtual;
    function CheckComponentDelete: Boolean;virtual;
    function CheckReportDelete: Boolean; virtual;
    function GetBandControlForPos(aPos: Integer): TppBandControl;
    function GetBandForPos(aPosition: Integer): TppBand;
    function GetBandForRect(aRect: TRect): TppBand;
    function GetRegionForPos(aPosition: TPoint): TppCustomRegion;
    function GetRegionForRect(aRect: TRect): TppCustomRegion;
    function GetVerticalRulerForPos(aPos: Integer): TppRuler;
    procedure ShowHelp; overload;
    procedure ShowHelp(aComponent: TComponent); overload;
    procedure ShowHelp(aContext: String); overload;
    procedure ShowHelp(aHelpFile, aContext: String); overload;

    property DesignControlManager: TppDesignControlManager read FDesignControlManager;
    property Selection: TppDesignSelection read FSelection;
    property UndoManager: TppUndoManager read FUndoManager;
    property Workspace: TppWorkspace read FWorkspace;
    property WorkspaceView: TppDesignWorkspaceView read FWorkspaceView write SetWorkspaceView;

  end;

    

implementation

function TppDesignControllerBase.CalcSnapToGridPos(aWorkspacePoint: TPoint): TPoint;
var
  lBand: TppBand;
begin

  lBand := GetBandForPos(aWorkspacePoint.Y);

  // normalize y pos to band
  if (lBand <> nil) then
    aWorkspacePoint.Y := aWorkspacePoint.Y - lBand.spTop;

  aWorkspacePoint := Workspace.CalcSnapToGridPosition(aWorkspacePoint);

  // normalize y pos to workspace
  if (lBand <> nil) then
    aWorkspacePoint.Y := aWorkspacePoint.Y + lBand.spTop;

  Result := aWorkspacePoint;

end;

{------------------------------------------------------------------------------}
{ TppDesignControllerBase.CheckComponentAdd}

function TppDesignControllerBase.CheckComponentAdd: Boolean;
var
  lsMessage: String;
begin

  Result := False;

  if (MainReport = nil) or (MainReport.Owner = nil) then Exit;

  {check whether this component resides in a nested frame}
  Result := not (csInline in MainReport.Owner.ComponentState);

  if not Result then
    begin
      lsMessage := ppLoadStr(686); {'New components cannot be added to frame instances.'}

      MessageDlg(lsMessage, mtWarning, [mbOK], 0);
    end;

end;

{------------------------------------------------------------------------------}
{ TppDesignControllerBase.CheckComponentDelete}

function TppDesignControllerBase.CheckComponentDelete: Boolean;
var
  liIndex: Integer;
  lsMessage: String;
begin

  Result := True;
  liIndex := 0;

  while Result and (liIndex < Selection.Count) do
    begin
      Result := not (csAncestor in Selection[liIndex].ComponentState);

      Inc(liIndex);

    end;

  if not Result then
    begin
      lsMessage := ppLoadStr(687); {'Selection contains a component introduced in an ancestor and cannot be deleted.'}

      MessageDlg(lsMessage, mtWarning, [mbOK], 0);
    end;

end;

{------------------------------------------------------------------------------}
{ TppDesignControllerBase.CheckReportDelete}

function TppDesignControllerBase.CheckReportDelete: Boolean;
var
  lsMessage: String;
begin

  Result := True;

  if (MainReport = nil) then Exit;

  Result := not (csAncestor in MainReport.ComponentState);

  if not Result then
    begin
      lsMessage := ppLoadStr(687); {'Selection contains a component introduced in an ancestor and cannot be deleted.'}

      MessageDlg(lsMessage, mtWarning, [mbOK], 0);
    end;


end;

{------------------------------------------------------------------------------}
{ TppDesignControllerBase.DoOnHelp}

procedure TppDesignControllerBase.DoOnHelp(Sender: TObject; var aHelpFile, aKeyphrase: String; var aCallHelp: Boolean);
var
  lEventParams: TppHelpEventParams;
begin

  lEventParams := TppHelpEventParams.Create(aHelpFile, aKeyphrase, aCallHelp);;

  try

    // notify end-user designer 
    EventHub.EndUserEvents.mcHelp.Notify(Self, lEventParams);

    aHelpFile := lEventParams.HelpFile;
    aKeyphrase := lEventParams.KeyPhrase;
    aCallHelp := lEventParams.CallHelp;

  finally

    lEventParams.Free;

  end;

end; 

{------------------------------------------------------------------------------}
{ TppDesignControllerBase.ehGetFieldForAlias }

procedure TppDesignControllerBase.ehGetFieldForAlias(Sender: TObject; const aFieldAlias: String; var aDataPipeline: TObject; var aDataField: String);
var
  lDataPipeline: TppDataPipeline;
begin
  if (aDataPipeline is TppDataPipeline) then
    lDataPipeline := TppDataPipeline(aDataPipeline);
  GetFieldForAlias(aFieldAlias, lDataPipeline, aDataField);
  aDataPipeline := lDataPipeline;
end;

{------------------------------------------------------------------------------}
{ TppDesignControllerBase.GetBandControlForPos }

function TppDesignControllerBase.GetBandControlForPos(aPos: Integer): TppBandControl;
var
  lBand: TppBand;
begin

  lBand := GetBandForPos(aPos);

  if (lBand <> nil) then
    Result := DesignControlManager.BandControls[lBand]
  else
    Result := nil;
    
end;

{------------------------------------------------------------------------------}
{ TppDesignControllerBase.GetBandForPos }

function TppDesignControllerBase.GetBandForPos(aPosition: Integer): TppBand;
var
  liIndex: Integer;
  liZeroHeightBand: Integer;
  lBand: TppBand;
  lbBandFound: Boolean;
  lBandControl: TppBandControl;
begin

  Result := nil;

  if (Report = nil) then Exit;

  liIndex  := 0;
  lbBandFound:= False;
  lBand := nil;

  while (not lbBandFound) and (liIndex < Report.BandCount) do
    begin
      lBand := Report.Bands[liIndex];
      lBandControl := DesignControlManager.BandControls[lBand];

      if (lBandControl <> nil) and
         (aPosition >= (lBand.spTop - lBandControl.Height)) and
         (aPosition < (lBandControl.Top)) then
        lbBandFound := True
      else
        Inc(liIndex);

    end;


  if lbBandFound then
    begin

      if (lBand.spHeight = 0) then
        begin
          {first, try to find a prior band with height > 0}
          liZeroHeightBand := Report.FindBand(lBand);
          liIndex := liZeroHeightBand;

          while (Result = nil) and (liIndex >= 0) do
            begin
              lBand := Report.Bands[liIndex];
              if lBand.spHeight > 0 then
                Result := lBand
              else
                Dec(liIndex);
            end;

          {next, try to find a next band with height > 0}
          if (Result = nil) then
            begin

              liIndex := liZeroHeightBand;

              while (Result = nil) and (liIndex < Report.BandCount) do
                begin
                  lBand := Report.Bands[liIndex];
                  if lBand.spHeight > 0 then
                    Result := lBand
                  else
                    Inc(liIndex);
                end;

             end;

          {if no bands > 0, return the header}
          if Result = nil then
            lBand := Report.Bands[0];

        end;


    end;

    Result := lBand;

end;

{------------------------------------------------------------------------------}
{ TppDesignControllerBase.GetBandForRect }

function TppDesignControllerBase.GetBandForRect(aRect: TRect): TppBand;
begin
  Result := GetBandForPos(aRect.Top);

  if Result = nil then
    Result := GetBandForPos(aRect.Bottom);
    
end;

{------------------------------------------------------------------------------}
{ TppDesignControllerBase.GetFieldAliases}

function TppDesignControllerBase.GetFieldAliases: TStrings;
var
  lEventParams: TppGetFieldAliasesEventParams;
begin

  Result := nil;

  if (EventHub <> nil) then
    begin
      lEventParams := TppGetFieldAliasesEventParams.Create;

      try
        EventHub.EndUserEvents.mcGetFieldAliases.Notify(Self, lEventParams);

        Result := lEventParams.FieldAliases;

      finally
        lEventParams.Free;

      end;

    end;

end;

{------------------------------------------------------------------------------}
{ TppDesignWorkspaceController.GetFieldforAlias }

procedure TppDesignControllerBase.GetFieldForAlias(const aFieldAlias: String; var aDataPipeline: TppDataPipeline; var aDataField: String);
var
  lEventParams: TppFieldAliasEventParams;
begin

  if (EventHub <> nil) then
    begin
      lEventParams := TppFieldAliasEventParams.Create;
      lEventParams.FieldAlias := aFieldAlias;

      try
        EventHub.EndUserEvents.mcGetFieldAliases.Notify(Self, lEventParams);

        if (lEventParams.DataPipeline is TppDataPipeline) then
          aDataPipeline := TppDataPipeline(lEventParams.DataPipeline);
        aDataField := lEventParams.FieldName;

      finally
        lEventParams.Free;

      end;

    end;


end;

{------------------------------------------------------------------------------}
{ TppDesignWorkspaceController.GetRegionForPos }

function TppDesignControllerBase.GetRegionForPos(aPosition: TPoint): TppCustomRegion;
var
  lBand: TppBand;
  lBoundsRect : TRect;
  liObject: Integer;
  lRegion: TppCustomRegion;
begin

  Result := nil;

  if (Report = nil) then Exit;

  lBand := GetBandForPos(aPosition.Y);

  if (lBand = nil) then Exit;
  

  liObject := lBand.ObjectCount-1;

  while (liObject >= 0) do
    begin

      if (lBand.Objects[liObject] is TppCustomRegion) then
        begin
          lRegion := TppCustomRegion(lBand.Objects[liObject]);
          lBoundsRect := DesignControlManager.DesignControls[lRegion].BoundsRect;

          if not ( (aPosition.X  > lBoundsRect.Right)  or (aPosition.X  < lBoundsRect.Left) )  and
             not ( (aPosition.Y  > lBoundsRect.Bottom) or (aPosition.Y  < lBoundsRect.Top) ) then

            Result := lRegion;

        end; {if, Region}

      if Result = nil then
        Dec(liObject)
      else
        Break;

    end; {while not end of Objects}

end;

{------------------------------------------------------------------------------}
{ TppDesignWorkspaceController.GetRegionForRect }

function TppDesignControllerBase.GetRegionForRect(aRect: TRect): TppCustomRegion;
begin
  Result := GetRegionForPos(aRect.TopLeft);
end;

{------------------------------------------------------------------------------}
{ TppDesignWorkspaceController.GetBandControlForPos }

function TppDesignControllerBase.GetVerticalRulerForPos(aPos: Integer):
    TppRuler;
var
  lBandControl: TppBandControl;
begin

  lBandControl := GetBandControlForPos(aPos);

  if (lBandControl <> nil) then
    Result := lBandControl.Ruler
  else
    Result := nil;
    
end;

{------------------------------------------------------------------------------}
{TppDesignControllerBase.Notify}

procedure TppDesignControllerBase.Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType);
begin

  if (aOperation = ppopRemove) and (aCommunicator = FWorkspaceView) then
      SetWorkspaceView(nil);

  inherited;

end; {procedure, Notify}

{------------------------------------------------------------------------------}
{TppDesignControllerBase.Notification}

procedure TppDesignControllerBase.Notification(AComponent: TComponent; Operation: TOperation);
begin

  if (aComponent = FWorkspace) and (Operation = opRemove) then
    SetWorkspaceView(nil);

  inherited;

end;

{------------------------------------------------------------------------------}
{ TppDesignControllerBase.SetWorkspace}

procedure TppDesignControllerBase.SetWorkspace(aWorkspace: TppWorkspace);
begin

  if (FWorkspace <> aWorkspace) then
    begin
      FWorkspace := aWorkspace;

      if (FWorkspace <> nil) then
        FWorkspace.FreeNotification(Self);

    end;

end;

{------------------------------------------------------------------------------}
{ TppDesignControllerBase.SetWorkspaceView}

procedure TppDesignControllerBase.SetWorkspaceView(const Value: TppDesignWorkspaceView);
begin

  if FWorkspaceView <> Value then
    begin
      if (FWorkspaceView <> nil) and not(csDestroying in FWorkspaceView.ComponentState) then
        FWorkspaceView.RemoveNotify(Self);

      FWorkspaceView := Value;

      if (FWorkspaceView <> nil) then
        begin
          FWorkspaceView.AddNotify(Self);
          FUndoManager := FWorkspaceView.UndoManager;
          FSelection := FWorkspaceView.Selection;
          FDesignControlManager := FWorkspaceView.DesignControlManager;
          SetWorkspace(FWorkspaceView.Workspace);
        end
      else
        begin
          FUndoManager := nil;
          FSelection := nil;
          FDesignControlManager := nil;
          SetWorkspace(nil);
        end;

    end;

end;

{------------------------------------------------------------------------------}
{ TppDesignControllerBase.ShowHelp}

procedure TppDesignControllerBase.ShowHelp;
begin

  ShowHelp('');

end;

{------------------------------------------------------------------------------}
{ TppDesignControllerBase.ShowHelp}

procedure TppDesignControllerBase.ShowHelp(aComponent: TComponent);
var
  lsHelpContext: String;
begin

  if aComponent <> nil then
    lsHelpContext := aComponent.ClassName
  else
    lsHelpContext := '';

  ShowHelp(lsHelpContext);

end;

{------------------------------------------------------------------------------}
{ TppDesignControllerBase.ShowHelp}

procedure TppDesignControllerBase.ShowHelp(aContext: String);
begin

  ShowHelp('', aContext);

end;

{------------------------------------------------------------------------------}
{ TppDesignControllerBase.ShowHelp}

procedure TppDesignControllerBase.ShowHelp(aHelpFile, aContext: String);
var
  lsHelpFile: String;
  lbCallHelp: Boolean;
  lsHelpContext: String;
begin

  if (aHelpfile = '') then
    lsHelpFile := ppGetHelpFilePath + 'RBuilder.hlp'
  else
    lsHelpFile := aHelpFile;

  lsHelpContext := aContext;

  lbCallHelp := True;

  DoOnHelp(Self, lsHelpFile, lsHelpContext, lbCallHelp);

  if not lbCallHelp or (lsHelpFile = '') then Exit;

  ppDisplayHelp('A', lsHelpFile, lsHelpContext);

end;

end.
