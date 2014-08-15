{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2006                    BBBBB   }

unit myDynamicLoadingSubReport;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Inifiles, Variants,

  ppClass,
  ppBands,
  ppSubRpt,
  ppTypes,
  ppVar,
  ppDB;

type

  { This component is an example of how you could provide a totally automated
    dynamic SubReport to your users. This component will load itself with a
    report template (from either an RTM file or from the database) based on
    what band it is in.  }

  { TmyDynamicLoadingSubReport }
  TmyDynamicLoadingSubReport = class(TppSubReport)
    private
      FAutomatedLoad: Boolean;
      FSettingsFile: String;

      procedure LoadSubreport;
      procedure LoadTitleSubreport;
      procedure LoadHeaderSubreport;
      procedure LoadFooterSubreport;

      procedure PageNumberVariableOnCalcEvent(Sender: TObject; var Value: Variant);

    protected
      function ehTemplate_OnLocateRecord(Sender: TObject; const aReportName: String): Boolean;
      function  GetCaption: String; override;

    public
      property SettingsFile: String read FSettingsFile write FSettingsFile;

      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      procedure Generate; override;
      procedure StartOfMainReport; override;

    published
      property AutomatedLoad: Boolean read FAutomatedLoad write FAutomatedLoad default True;
    end;

implementation

{$R mySubRptIcon.res}

{ TmyDynamicLoadingSubReport }

{------------------------------------------------------------------------------}
{ TmyDynamicLoadingSubReport.Create }
{ The settings for this component are stored in an INI file, mySettings.ini.
  The given settings allow you to specify whether the templates should be
  loaded from an RTM file or from the database. }
constructor TmyDynamicLoadingSubReport.Create(aOwner: TComponent);
var
  lsPath: String;
begin

  inherited Create(aOwner);

  FAutomatedLoad := True;

  lsPath := ExtractFilePath(Application.ExeName);

  FSettingsFile := lsPath + 'mySettings.ini';

end; { constructor, Create }

{------------------------------------------------------------------------------}
{ TmyDynamicLoadingSubReport.Destroy }

destructor TmyDynamicLoadingSubReport.Destroy;
begin

  inherited Destroy;

end; { destructor, Destroy }

{------------------------------------------------------------------------------}
{ TmyDynamicLoadingSubReport.ehTemplate_OnLocateRecord }

function TmyDynamicLoadingSubReport.ehTemplate_OnLocateRecord(Sender: TObject; const aReportName: String): Boolean;
var
  lDataPipeline: TppDataPipeline;
begin

  // use the plItem pipeline to perform the locate
  lDataPipeline  := TppDataPipeline(Report.Owner.FindComponent('plItem'));

  if (lDataPipeline = nil) then
    raise EReportBuilderError.Create('TmyDynamicLoadingSubReport.ehTemplate_OnLocateRecor: plItem DataPipeline not found.');

  Result := lDataPipeline.Locate('Name', aReportName, [pploCaseInsensitive]);

end;


{------------------------------------------------------------------------------}
{ TmyDynamicLoadingSubReport.Generate }
{ Autostop is set to True since these subreports will not be hooked to a
  datapipeline.  }
procedure TmyDynamicLoadingSubReport.Generate;
begin

  Report.AutoStop := True;

  inherited Generate;

end; { procedure, Generate }

{------------------------------------------------------------------------------}
{ TmyDynamicLoadingSubReport.GetCaption }

function TmyDynamicLoadingSubReport.GetCaption: String;
begin


  if (Band is TppTitleBand) then
    Result := 'Dynamic Title Template'

  else if (Band is TppHeaderBand) then
    Result := 'Dynamic Header Template'

  else if (Band is TppFooterBand) then
    Result := 'Dynamic Footer Template';


end; { procedure, GetCaption }

{------------------------------------------------------------------------------}
{ TmyDynamicLoadingSubReport.LoadFooterSubreport }
{ If the component is in the Footer band, we load the template specified for
  the footer.
  Since any TppSystemVariable placed in our footer template for page numbering
  purposes will only display page numbers for the subreport rather than the
  main report, we provide for the ability to use a TppVariable in the template
  for numbering. If this method finds a TppVariable in the template named
  "varPageNo" it will assign the OnCalc event to a private method which will
  return the page number of the main report. Slick, huh? }

{ Note: Subreport in footer can't stretch, so make sure it's tall enough... }

procedure TmyDynamicLoadingSubReport.LoadFooterSubreport;
var
  lIniFile: TIniFile;
  lbLoadFromFile: Boolean;
  liBandIndex: Integer;
  liComponentIndex: Integer;
begin

  lIniFile := TIniFile.Create(FSettingsFile);

  try
    lbLoadFromFile := lIniFile.ReadBool('FooterReport', 'LoadFromFile', True);

    if (lbLoadFromFile) then
      begin
        Report.Template.Filename := lIniFile.ReadString('FooterReport', 'TemplateName', 'myFooterTemplate.rtm');
        Report.Template.LoadFromFile;
      end

    else
      begin
        Report.Template.DatabaseSettings.DataPipeline := Band.Report.MainReport.Template.DataBaseSettings.DataPipeline;
        Report.Template.DatabaseSettings.NameField := Band.Report.MainReport.Template.DataBaseSettings.NameField;
        Report.Template.DatabaseSettings.TemplateField := Band.Report.MainReport.Template.DataBaseSettings.TemplateField;
        Report.Template.DatabaseSettings.Name := lIniFile.ReadString('FooterReport', 'TemplateName', 'myFooterTemplate');
        Report.Template.OnLocateRecord :=  ehTemplate_OnLocateRecord;
        Report.Template.BroadcastReportExplorerEvents := False;

        try
          Report.Template.LoadFromDatabase;
        finally
          Report.Template.BroadcastReportExplorerEvents := True;
          Report.Template.OnLocateRecord := nil;
        end;

      end;

    { If we have a page numbering TppVariable named "varPageNo", give it an 
      event handler...}
    if (Report.ObjectByName(liBandIndex, liComponentIndex, 'varPageNo')) then
      TppVariable(Report.Bands[liBandIndex].Objects[liComponentIndex]).OnCalc := PageNumberVariableOnCalcEvent;

  finally
    lIniFile.Free;
  end;

end; { procedure, LoadFooterSubreport }

{------------------------------------------------------------------------------}
{ TmyDynamicLoadingSubReport.LoadHeaderSubreport }
{ If the component is in the Footer band, we load the template specified for
  the footer.
  By setting our child report's PrinterSetup.DocumentName property to be the
  same as the Main report's, we can use a TppSystemVariable set to DocumentName
  to display the name of the Main report. This is handy for a header template.
  This is demonstrated in the sample reports. }

procedure TmyDynamicLoadingSubReport.LoadHeaderSubreport;
var
  lIniFile: TIniFile;
  lbLoadFromFile: Boolean;
begin

  lIniFile := TIniFile.Create(FSettingsFile);

  try
    lbLoadFromFile := lIniFile.ReadBool('HeaderReport', 'LoadFromFile', True);

    if (lbLoadFromFile) then
      begin
        Report.Template.Filename := lIniFile.ReadString('HeaderReport', 'TemplateName', 'myHeaderTemplate.rtm');
        Report.Template.LoadFromFile;
      end

    else
      begin
        Report.Template.DatabaseSettings.DataPipeline := Band.Report.MainReport.Template.DataBaseSettings.DataPipeline;
        Report.Template.DatabaseSettings.NameField := Band.Report.MainReport.Template.DataBaseSettings.NameField;
        Report.Template.DatabaseSettings.TemplateField := Band.Report.MainReport.Template.DataBaseSettings.TemplateField;
        Report.Template.DatabaseSettings.Name := lIniFile.ReadString('HeaderReport', 'TemplateName', 'myHeaderTemplate');
        Report.Template.OnLocateRecord :=  ehTemplate_OnLocateRecord;
        Report.Template.BroadcastReportExplorerEvents := False;

        try
          Report.Template.LoadFromDatabase;
        finally
          Report.Template.BroadcastReportExplorerEvents := True;
          Report.Template.OnLocateRecord := nil;
        end;

      end;

    Report.PrinterSetup.DocumentName := Band.Report.MainReport.PrinterSetup.DocumentName;

  finally
    lIniFile.Free;
  end;

end; { procedure, LoadHeaderSubreport }


{------------------------------------------------------------------------------}
{ TmyDynamicLoadingSubReport.LoadSubreport }
{ Determine what band we are in and load the appropriate template. }
procedure TmyDynamicLoadingSubReport.LoadSubreport;
begin

  if (Band is TppTitleBand) then
    LoadTitleSubreport

  else if (Band is TppHeaderBand) then
    LoadHeaderSubreport

  else if (Band is TppFooterBand) then
    LoadFooterSubreport;

end; { procedure, LoadSubreport }


{------------------------------------------------------------------------------}
{ TmyDynamicLoadingSubReport.LoadTitleSubreport }

procedure TmyDynamicLoadingSubReport.LoadTitleSubreport;
var
  lIniFile: TIniFile;
  lbLoadFromFile: Boolean;
begin

  lIniFile := TIniFile.Create(FSettingsFile);

  try
    lbLoadFromFile := lIniFile.ReadBool('TitleReport', 'LoadFromFile', True);

    if (lbLoadFromFile) then
      begin
        Report.Template.Filename := lIniFile.ReadString('TitleReport', 'TemplateName', 'myTitleTemplate.rtm');
        Report.Template.LoadFromFile;
      end

    else
      begin
        Report.Template.DatabaseSettings.DataPipeline := Band.Report.MainReport.Template.DataBaseSettings.DataPipeline;
        Report.Template.DatabaseSettings.NameField := Band.Report.MainReport.Template.DataBaseSettings.NameField;
        Report.Template.DatabaseSettings.TemplateField := Band.Report.MainReport.Template.DataBaseSettings.TemplateField;
        Report.Template.DatabaseSettings.Name := lIniFile.ReadString('TitleReport', 'TemplateName', 'myTitleTemplate');
        Report.Template.OnLocateRecord :=  ehTemplate_OnLocateRecord;
        Report.Template.BroadcastReportExplorerEvents := False;

        try
          Report.Template.LoadFromDatabase;
        finally
          Report.Template.BroadcastReportExplorerEvents := True;
          Report.Template.OnLocateRecord := nil;
        end;
        
      end;

  finally
    lIniFile.Free;
  end;

end; { procedure, LoadTitleSubreport }


{------------------------------------------------------------------------------}
{ TmyDynamicLoadingSubReport.PageNumberVariableOnCalcEvent }

procedure TmyDynamicLoadingSubReport.PageNumberVariableOnCalcEvent(Sender: TObject; var Value: Variant);
begin

  Value := 'Page ' + IntToStr(Band.Report.MainReport.AbsolutePageNo);

end; { procedure, LoadTitleSubreport }

{------------------------------------------------------------------------------}
{ TmyDynamicLoadingSubReport.StartOfMainReport }

procedure TmyDynamicLoadingSubReport.StartOfMainReport;
begin

  if (AutomatedLoad) and not(Overflow) then
    LoadSubreport;

  inherited StartOfMainReport;

end; { procedure, StartOfMainReport }




initialization
  { We register this component so that it will appear in its own toolbar in the
    ReportDesigner }
  ppRegisterComponent(TmyDynamicLoadingSubReport, 'Demo Components', 0, 0, 'Dynamic Loading SubReport', 0);


finalization
  ppUnRegisterComponent(TmyDynamicLoadingSubReport);


end.
