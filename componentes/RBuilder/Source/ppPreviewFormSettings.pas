{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit ppPreviewFormSettings;

interface

uses
  Classes, Windows, Forms,
  ppTypes;

type

  {@TppPreviewFormSettings

    Allows the initial state of the Print Preview form to be set at Delphi
    design-time. Can also be used to set the WindowState, ZoomSetting and
    ZoomPercentage in code (usually via the OnPreviewFormCreate event.) If the
    Print Preview form has already been instantiated, any changes made to
    PreviewFormSettings are immediately applied to the form.}


  {@TppPreviewFormSettings.WindowState

    The window state can either be maximized, minimized or normal. See the
    Delphi help for <EXTLINK borland://TWindowState_type>TWindowState</EXTLINK>}


  {@TppPreviewFormSettings.ZoomSetting

    Indicates how pages will be displayed in the viewer.

    <Table>
    Value		            Meaning
    ------------        ---------
    zsWholePage	        Entire page is scaled to fit into the viewing area
    zsPageWidth	        PageWidth is fitted to width of viewing area, vertical
                        scrollbar is provided to view page height.
    zs100Percent	      Page is shown at full size.  Both the vertical and
                        horizontal scrollbars are provided as necessary.
    zsPercentage	      Page is shown based on the value of the ZoomPercentage
                        property.
    </Table>}


  {@TppPreviewFormSettings.ZoomPercentage

    Value between 25 and 250 which indicates the scaling percentage to be used
    when drawing the report page on the viewer panel. This value is only
    applicable when the ZoomSetting is set to zsPercentage.}


  {@TppPreviewFormSettings.OnPreviewSettingsChange

    This event is triggered when any of the settings change. The producer
    listens for this event in order to transfer the settings to the viewer
    component.}


  TppPreviewFormSettings = class(TPersistent)
    private
      FOnPreviewSettingsChange: TNotifyEvent;
      FWindowState: TWindowState;
      FZoomPercentage: Integer;
      FZoomSetting: TppZoomSettingType;

      procedure DoOnPreviewSettingsChange;

      procedure SetWindowState(aWindowState: TWindowState);
      procedure SetZoomSetting(aZoomSetting: TppZoomSettingType);
      procedure SetZoomPercentage(aZoomPercentage: Integer);

    public
      constructor Create;

      procedure Clone(aSettings: TppPreviewFormSettings);

      property OnPreviewSettingsChange: TNotifyEvent read FOnPreviewSettingsChange write FOnPreviewSettingsChange;

    published
      property WindowState: TWindowState read FWindowState write SetWindowState default wsNormal;
      property ZoomSetting: TppZoomSettingType read FZoomSetting write SetZoomSetting default zsWholePage;
      property ZoomPercentage: Integer read FZoomPercentage write SetZoomPercentage default 100;

    end;  {class, TppPreviewFormSettings}

implementation

uses
  ppEnum;

{******************************************************************************
 *
 ** P R E V I E W   F O R M   S E T T I N G S
 *
{******************************************************************************}

{@TppPreviewFormSettings.Create }

constructor TppPreviewFormSettings.Create;
begin

  inherited Create;

  FWindowState := wsNormal;
  FZoomSetting := zsWholePage;
  FZoomPercentage := 100;

  FOnPreviewSettingsChange := nil;

end;

{@TppPreviewFormSettings.Clone }

procedure TppPreviewFormSettings.Clone(aSettings: TppPreviewFormSettings);
begin

  FWindowState := aSettings.FWindowState;
  FZoomPercentage := aSettings.FZoomPercentage;
  FZoomSetting := aSettings.FZoomSetting;

end;

{@TppPreviewFormSettings.DoOnPreviewSettingsChange }

procedure TppPreviewFormSettings.DoOnPreviewSettingsChange;
begin
  if Assigned(FOnPreviewSettingsChange) then FOnPreviewSettingsChange(Self);
end;

{@TppPreviewFormSettings.SetWindowState }

procedure TppPreviewFormSettings.SetWindowState(aWindowState: TWindowState);
begin
  FWindowState := aWindowState;

  DoOnPreviewSettingsChange;
end;

{@TppPreviewFormSettings.SetZoomSetting }

procedure TppPreviewFormSettings.SetZoomSetting(aZoomSetting: TppZoomSettingType);
begin
  FZoomSetting := aZoomSetting;

  DoOnPreviewSettingsChange;
end;

{@TppPreviewFormSettings.SetZoomPercentage }

procedure TppPreviewFormSettings.SetZoomPercentage(aZoomPercentage: Integer);
begin

  if (aZoomPercentage < 25) then
    FZoomPercentage := 25
  else if (aZoomPercentage > 250) then
    FZoomPercentage := 250
  else
    FZoomPercentage := aZoomPercentage;

  SetZoomSetting(zsPercentage);

  DoOnPreviewSettingsChange;
end;

initialization
  Classes.RegisterClass(TppPreviewFormSettings);

  raRegisterEnum('TppZoomSettingType', TypeInfo(TppZoomSettingType));
  raRegisterEnum('TWindowState', TypeInfo(TWindowState));

finalization
  Classes.UnRegisterClass(TppPreviewFormSettings);

  raUnRegisterEnum('TppZoomSettingType');
  raUnRegisterEnum('TWindowState');

end.
