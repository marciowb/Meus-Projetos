{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit ppBackgroundPrintSettings;

interface

uses
  Classes;

type

  {@TppBackgroundPrintSettings

    Set Enabled to true in order to show a background print option on the print
    dialog. Set Active to true in order to default the report to print in the
    background. Background printing is supported on the Report, ArchiveReader
    and DBArchiveReader.}

  {@TppBackgroundPrintSettings.Active

    Set this property to true in order to print the report to any device in a
    background thread. This can only be set to true if Enabled is set to True.

    Defaults to False.}

  {@TppBackgroundPrintSettings.Enabled

    Set this property to true in order to have the option available to use
    background printing. When Enabled is true, the print
    dialog shows an option to print the report in a background thread. Checking
    the option in the print dialog sets Active to true. The report
    prints in the background only when Enabled and Active are set to True.

    Defaults to False.}

  TppBackgroundPrintSettings = class(TPersistent)
    private
      FActive: Boolean;
      FEnabled: Boolean;

      procedure SetActive(aActive: Boolean);

    public
      constructor Create; virtual;

      procedure Assign(aSource: TPersistent); override;

    published
      property Enabled: Boolean read FEnabled write FEnabled default False;
      property Active: Boolean read FActive write SetActive default False;

    end;

implementation

{@TppBackgroundPrintSettings.Create }

constructor TppBackgroundPrintSettings.Create;
begin
  inherited Create;

  FActive := False;
  FEnabled := False;
end;
  
{@TppBackgroundPrintSettings.Assign }

procedure TppBackgroundPrintSettings.Assign(aSource: TPersistent);
var
  lBackgroundPrintSettings: TppBackgroundPrintSettings;
begin

  if (aSource is TppBackgroundPrintSettings) then
    begin
      lBackgroundPrintSettings := TppBackgroundPrintSettings(aSource);

      FEnabled := lBackgroundPrintSettings.FEnabled;
      FActive := lBackgroundPrintSettings.FActive;
    end
  else
    inherited Assign(aSource);
  
end;

{@TppBackgroundPrintSettings.SetActive }

procedure TppBackgroundPrintSettings.SetActive(aActive: Boolean);
begin
  if FEnabled then
    FActive := aActive
  else
    FActive := False;
end;


initialization
  RegisterClass(TppBackgroundPrintSettings);

finalization
  UnregisterClass(TppBackgroundPrintSettings);

end.
