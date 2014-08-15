{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit ppOutlineReportSettings;

interface

{$I ppIfDef.pas}

uses

  Classes,
  ppComm,
  ppOutlineSettings;

type

  {@TppOutlineReportSettings

    Use TppOutlineReportSettings to control the behavior of report outline
    generation. When enabled, an outline tree structure is dynamically generated
    by the report engine and rendered by the report previewer.

    From the report designer, select the Report|Outline Settings... menu
    option to access a dialog that enables simple visual configuration of
    outline settings for all relevant objects in the report.

    TppOutlineReportSettings is an embedded object property of TppReport. It
    descends from TppOutlineSettings and introduces two new properties: Enabled
    and CreatePageNodes. Use the Enabled property to control whether an
    outline is generated for the report. Use the CreatePageNodes boolean
    property to control whether outline nodes are generated to represent each
    page of the report.}

  {@TppOutlineReportSettings.CreatePageNodes

    Determines whether outline nodes are generate to represent each page of
    the report.}

  {@TppOutlineReportSettings.Enabled

    Determines whether an outline is generated for the report. Set Enabled to
    false to turn off outline generation.}

  {@TppOutlineReportSettings.Visible

    Determines whether an outline is shown for the report when Enabled is set to
    true. If false, the outline is enabled, but not initially shown.
    Access the popup menu in the previewer to show the enabled outline.}


  TppOutlineReportSettings = class(TppOutlineSettings)
    private
      FCreatePageNodes: Boolean;
      FEnabled: Boolean;
      FVisible: Boolean;

      procedure SetCreatePageNodes(aValue: Boolean);
      procedure SetEnabled(aValue: Boolean);
      procedure SetVisible(aVisible: Boolean);

    public
      constructor Create(aReportComponent: TppCommunicator); override;
      procedure Assign(Source: TPersistent); override;

    published
      property CreatePageNodes: Boolean read FCreatePageNodes write SetCreatePageNodes;
      property Enabled: Boolean read FEnabled write SetEnabled;
      property Visible: Boolean read FVisible write SetVisible;

    end; { class, TppOutlineReportSettings }


implementation

{------------------------------------------------------------------------------}
{ TppOutlineReportSettings.Create }

constructor TppOutlineReportSettings.Create(aReportComponent: TppCommunicator);
begin

  inherited Create(aReportComponent);

  FCreatePageNodes := True;
  FEnabled := True;
  FVisible := True;
  
end; { constructor, Create }

{------------------------------------------------------------------------------}
{ TppOutlineReportSettings.SetCreatePageNodes }

procedure TppOutlineReportSettings.SetCreatePageNodes(aValue: Boolean);
begin

  FCreatePageNodes := aValue;

  SettingsChanged;

end; { procedure, SetCreatePageNodes }

{------------------------------------------------------------------------------}
{ TppOutlineReportSettings.SetEnabled }

procedure TppOutlineReportSettings.SetEnabled(aValue: Boolean);
begin

  FEnabled := aValue;

  if not(FEnabled) then
    FVisible := False;

  SettingsChanged;

end; { procedure, SetEnabled }

{------------------------------------------------------------------------------}
{ TppOutlineReportSettings.Assign }

procedure TppOutlineReportSettings.Assign(Source: TPersistent);
begin

  if (Source is TppOutlineReportSettings) then
    begin

      FCreatePageNodes := TppOutlineReportSettings(Source).FCreatePageNodes;
      FEnabled := TppOutlineReportSettings(Source).FEnabled;
      FVisible := TppOutlineReportSettings(Source).FVisible;

    end;

  inherited Assign(Source);

end; { procedure, Assign }


{------------------------------------------------------------------------------}
{ TppOutlineReportSettings.SetVisible }

procedure TppOutlineReportSettings.SetVisible(aVisible: Boolean);
begin

  if FEnabled then
    FVisible := aVisible
  else
    FVisible := False;

  SettingsChanged;

end; { procedure, SetVisible }

initialization

  RegisterClass(TppOutlineReportSettings);

finalization

  UnRegisterClass(TppOutlineReportSettings);

end.

