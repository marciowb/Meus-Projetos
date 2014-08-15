{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit ppOutlineSettingsPreviewThread;

interface

{$I ppIfDef.pas}

uses

  Classes,
  ppDevice, ppReport,
  ppOutlineViewer;

type

  {@TppOutlineSettingsPreviewThread }

  TppOutlineSettingsPreviewThread = class(TThread)
    private

      FDevice: TppDevice;
      FDialog: TObject;
      FFinish: Boolean;
      FCurrentPage: TppPage;
      FGenerate: Boolean;
      FPageLimit: Integer;
      FReport: TppReport;
      FViewer: TppOutlineViewer;

      procedure UpdateViewer;
      procedure CantPreview;
      procedure OnPreviewPageReceive(Sender: TObject; aPage: TObject);

    protected

      procedure Execute; override;

    public

      constructor Create; virtual;
      destructor Destroy; override;

      procedure Generate;
      procedure Cancel;
      procedure Finish;

      property Dialog: TObject read FDialog write FDialog;
      property PageLimit: Integer read FPageLimit write FPageLimit;
      property Report: TppReport read FReport write FReport;
      property Viewer: TppOutlineViewer read FViewer write FViewer;

    end; { class, TppOutlineSettingsPreviewThread }

implementation

uses

  Windows, Dialogs,
  ppTypes, ppUtils,
  ppOutlineSettingsDialog;

{------------------------------------------------------------------------------}
{ TppOutlineSettingsPreviewThread.Create }

constructor TppOutlineSettingsPreviewThread.Create;
begin

  inherited Create(True);

  FDevice := TppDevice.Create(nil);
  FDialog := nil;
  FFinish := False;
  FCurrentPage := nil;
  FGenerate := True;
  FPageLimit := 0;
  FReport := nil;
  FViewer := nil;

end; { constructor, Create }

{------------------------------------------------------------------------------}
{ TppOutlineSettingsPreviewThread.Destroy }

destructor TppOutlineSettingsPreviewThread.Destroy;
begin

  FDevice.Free;

  inherited Destroy;

end; { destructor, Destroy }

{------------------------------------------------------------------------------}
{ TppOutlineSettingsPreviewThread.UpdateViewer }

procedure TppOutlineSettingsPreviewThread.UpdateViewer;
begin

  FViewer.UpdateOutline(FCurrentPage);
  FViewer.ScrollToPage(1);

end; { procedure, UpdateViewer }

{------------------------------------------------------------------------------}
{ TppOutlineSettingsPreviewThread.CantPreview }

procedure TppOutlineSettingsPreviewThread.CantPreview;
var
  lsMessage: String;
begin

  lsMessage := ppLoadStr(1149); // 'Can''t generate report. Preview is not available.'
  MessageDlg(lsMessage, mtError, [mbOK], 0);

  TppOutlineSettingsDialog(FDialog).DisablePreview;

end; { procedure, CantPreview }

{------------------------------------------------------------------------------}
{ TppOutlineSettingsPreviewThread.OnPreviewPageReceive }

procedure TppOutlineSettingsPreviewThread.OnPreviewPageReceive(Sender: TObject; aPage: TObject);
begin

  FCurrentPage := TppPage(aPage);

  if (FDevice.IsRequestedPage and not(FDevice.IsMessagePage)) then
    Synchronize(UpdateViewer);

end; { procedure, OnPreviewPageReceive }

{------------------------------------------------------------------------------}
{ TppOutlineSettingsPreviewThread.Execute }

procedure TppOutlineSettingsPreviewThread.Execute;
var
  lDialog: TppOutlineSettingsDialog;
begin

  lDialog := TppOutlineSettingsDialog(FDialog);

  FDevice.Publisher := TppReport(Report).Publisher;
  FDevice.OnPageReceive := OnPreviewPageReceive;

  while not(FFinish) do
    if FGenerate then
      begin

        FGenerate := False;

        FViewer.Reset;

        if FPageLimit = 0 then
          FDevice.PageSetting := psLastPage
        else
          begin
            FDevice.PageSetting := psSinglePage;
            FDevice.PageRequest.PageRequested := FPageLimit;
          end;

        lDialog.ApplyChanges;
        FReport.PassSetting := psOnePass;

        try
          try
            FReport.PrintToDevices;
          except
            Synchronize(CantPreview);
          end;
        finally
          lDialog.ResetPassSetting;
          lDialog.UndoChanges;
        end;

      end
    else
      Sleep(0);

end; { procedure, Execute }

{------------------------------------------------------------------------------}
{ TppOutlineSettingsPreviewThread.Generate }

procedure TppOutlineSettingsPreviewThread.Generate;
begin

  FGenerate := True;

  if FReport.Printing then
    FReport.Cancel;

end; { procedure, Generate }

{------------------------------------------------------------------------------}
{ TppOutlineSettingsPreviewThread.Cancel }

procedure TppOutlineSettingsPreviewThread.Cancel;
begin

  if FReport.Printing then
    FReport.Cancel;

end; { procedure, Cancel }

{------------------------------------------------------------------------------}
{ TppOutlineSettingsPreviewThread.Finish }

procedure TppOutlineSettingsPreviewThread.Finish;
begin

  FFinish := True;

end; { procedure, Finish }

{------------------------------------------------------------------------------}

end.

