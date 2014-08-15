{********************************************************************}
{                                                                    }
{       Developer Express Visual Component Library                   }
{                   ExpressScheduler                                 }
{                                                                    }
{       Copyright (c) 2003-2010 Developer Express Inc.               }
{       ALL RIGHTS RESERVED                                          }
{                                                                    }
{   The entire contents of this file is protected by U.S. and        }
{   International Copyright Laws. Unauthorized reproduction,         }
{   reverse-engineering, and distribution of all or any portion of   }
{   the code contained in this file is strictly prohibited and may   }
{   result in severe civil and criminal penalties and will be        }
{   prosecuted to the maximum extent possible under the law.         }
{                                                                    }
{   RESTRICTIONS                                                     }
{                                                                    }
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES            }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE     }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS    }
{   LICENSED TO DISTRIBUTE THE EXPRESSSCHEDULER AND ALL ACCOMPANYING }
{   VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY.              }
{                                                                    }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED       }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE         }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE        }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT   }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                       }
{                                                                    }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON        }
{   ADDITIONAL RESTRICTIONS.                                         }
{                                                                    }
{********************************************************************}

unit cxExportSchedulerLink;

{$I cxVer.inc}

interface

uses
  Windows, Classes, SysUtils, Graphics, {$IFDEF DELPHI6} Variants, {$ENDIF} cxDataUtils,
  cxDateUtils, cxClasses, cxGraphics, cxStyles, cxGeometry, cxSchedulerCustomControls,
  Math, cxSchedulerUtils, cxSchedulerStorage, cxSchedulerStrs, cxExport, cxXLSExport,
  cxHtmlXmlTxtExport;

procedure cxExportSchedulerToHTML(const AFileName: string; AScheduler: TcxCustomScheduler; AsTable: Boolean = False;
  AShowDialog: Boolean = False;  const AHeader: string = 'Event %d'; const AStart: TDateTime = NullDate;
  const AFinish: TDateTime = NullDate; const AFileExt: string = 'html');
procedure cxExportSchedulerToXML(const AFileName: string; AScheduler: TcxCustomScheduler; AsTable: Boolean = False;
  AShowDialog: Boolean = False; const AHeader: string = 'Event %d'; const AStart: TDateTime = NullDate;
  const AFinish: TDateTime = NullDate; const AFileExt: string = 'xml');
procedure cxExportSchedulerToExcel(const AFileName: string; AScheduler: TcxCustomScheduler; AsTable: Boolean = False;
  AShowDialog: Boolean = False; const AHeader: string = 'Event %d'; const AStart: TDateTime = NullDate;
  const AFinish: TDateTime = NullDate; const AFileExt: string = 'xls');
procedure cxExportSchedulerToText(const AFileName: string; AScheduler: TcxCustomScheduler; AsTable: Boolean = False;
  AShowDialog: Boolean = False; const AHeader: string = 'Event %d'; const AStart: TDateTime = NullDate;
  const AFinish: TDateTime = NullDate; const ASeparator: string = '';
  const ABeginString: string = ''; const AEndString: string = ''; const AFileExt: string = 'txt');

//  general export method interface
procedure cxExportSchedulerToFile(AFileName: string; AScheduler: TcxCustomScheduler; AsTable,
  AShowDialog: Boolean; const AHeader: string; AStart, AFinish: TDateTime;
  AExportType: Integer; const ASeparators: array of string; const AFileExt: string);

type
  // IcxNameExportProvider
  IcxNameExportProvider = interface
  ['{FC69194E-E3C7-41F4-98AE-5948813210AE}']
    procedure SetName(const AName: string);
    procedure SetRangeName(const AName: string; const ARange: TRect);
  end;

  {TcxSchedulerExportHelper }

  TcxSchedulerExportHelper = class
  private
    FEvents: TcxSchedulerFilteredEventList;
    FFinish: TDateTime;
    FNameProvider: IcxNameExportProvider;
    FHeader: string;
    FProvider: IcxExportProvider;
    FStart: TDateTime;
  protected
    HasHeader: Boolean;
    CaptionStyle: Integer;
    Font: TFont;
    MaxCaptionWidth: Integer;
    MaxDataWidth: Integer;
    RowHeight: Integer;
    procedure CalculateLayout; virtual;
    procedure DoExport; virtual;
    procedure ExportEvent(AEvent: TcxSchedulerEvent; AIndex: Integer; var ARow: Integer); virtual;
    procedure ExportEvents; virtual;
    function RegisterCellStyle(AColor, AFontColor: TColor; AFontStyle: TcxFontStyles;
      ABorders, ABoldBorders: TcxBorders; AAlignText: TcxAlignText = catLeft): Integer;
    procedure TextWidth(const AString: string; AWordBreak: Boolean; var AWidth, AHeight: Integer);
  public
    constructor Create(AScheduler: TcxCustomScheduler; const AStart, AFinish: TDateTime;
      AExportType: Integer; const AFileName: string); virtual;
    destructor Destroy; override;
    property Events: TcxSchedulerFilteredEventList read FEvents;
    property Finish: TDateTime read FFinish;
    property NameProvider: IcxNameExportProvider read FNameProvider;
    property Provider: IcxExportProvider read FProvider;
    property Start: TDateTime read FStart;
    property Header: string read FHeader;
  end;

  { TcxSchedulerTableExportHelper }

  TcxSchedulerTableExportHelper = class(TcxSchedulerExportHelper)
  protected
    Style: Integer;
    procedure CalculateLayout; override;
    procedure DoExport; override;
    procedure ExportEvent(AEvent: TcxSchedulerEvent; AIndex: Integer;  var ARow: Integer); override;
  end;

  TcxSchedulerExportHelperClass = class of TcxSchedulerExportHelper;

const
  SchedulerExportHelpers: array[Boolean] of TcxSchedulerExportHelperClass =
    (TcxSchedulerExportHelper, TcxSchedulerTableExportHelper);
  YesNoStrs: array[Boolean] of Pointer = (@secxNo, @secxYes);
  States: array[0..3] of Pointer = (@scxFree, @scxTentative, @scxBusy, @scxOutOfOffice);
  MaxColumnWidth: Integer = 20;

implementation

const
  NecessaryFields: array[0..21] of Pointer =
     (@secxSubject, @secxStartDate, @secxStartTime, @secxEndDate, @secxEndTime, @secxAlldayevent,
      @secxReminderonoff, @secxReminderDate, @secxReminderTime, @secxMeetingOrganizer,
      @secxRequiredAttendees, @secxOptionalAttendees, @secxMeetingResources, @secxBillingInformation,
      @secxCategories, @secxDescription, @secxLocation, @secxMileage, @secxPriority, @secxPrivate,
      @secxSensitivity, @secxShowtimeas);

type
  TcxDateNavigatorAccess = class(TcxSchedulerCustomDateNavigator);

{ TcxSchedulerExportHelper }

constructor TcxSchedulerExportHelper.Create(AScheduler: TcxCustomScheduler;
  const AStart, AFinish: TDateTime; AExportType: Integer; const AFileName: string);
begin
  FEvents := TcxSchedulerFilteredEventList.Create;
  TcxExport.Provider(AExportType, AFileName).GetInterface(
    IcxExportProvider, FProvider);
  Supports(Provider, IcxNameExportProvider, FNameProvider);
  FStart := AStart;
  FFinish := AFinish;
  AScheduler.Storage.GetEvents(FEvents, AStart, AFinish);
  Provider.SetDefaultStyle(DefaultCellStyle);
  Font := TFont.Create;
  Font.Name := PChar(@DefaultCellStyle.FontName);
  Font.Size := DefaultCellStyle.FontSize;
  MaxCaptionWidth := 100;
  MaxDataWidth := 100;
  TextWidth('00/00/00 00:00', False, MaxDataWidth, RowHeight);
end;

destructor TcxSchedulerExportHelper.Destroy;
begin
  FEvents.Free;
  try
    Font.Free;
    FProvider := nil;
  finally
    inherited Destroy;
  end;
end;

procedure TcxSchedulerExportHelper.CalculateLayout;
begin
  if Events.Count = 0 then Exit;
  HasHeader := FHeader <> '';
  Provider.SetRange(2, Events.Count * (8 + Byte(HasHeader)), False);
end;

procedure TcxSchedulerExportHelper.DoExport;
begin
  CalculateLayout;
  ExportEvents;
  Provider.SetColumnWidth(0, Min(MaxColumnWidth, MaxCaptionWidth));
  Provider.SetColumnWidth(1, Min(MaxColumnWidth, MaxDataWidth));
  Provider.Commit;
end;

procedure TcxSchedulerExportHelper.ExportEvent(
  AEvent: TcxSchedulerEvent; AIndex: Integer; var ARow: Integer);

  procedure WriteSingleRow(const ACaption: string; const AData: Variant; ABorders: TcxBorders);
  begin
    TextWidth(ACaption, False, MaxCaptionWidth, RowHeight);
    TextWidth(VarToStr(AData), True, MaxDataWidth, RowHeight);
    Provider.SetRowHeight(ARow, RowHeight);
    Provider.SetCellStyle(0, ARow, RegisterCellStyle(clDefault,
      clDefault, [cfsBold], cxBordersAll, ABorders));
    Provider.SetCellStyle(1, ARow, RegisterCellStyle(clDefault,
      clDefault, [], cxBordersAll, ABorders - [bLeft]));
    Provider.SetCellValue(0, ARow, ACaption);
    Provider.SetCellValue(1, ARow, AData);
    Inc(ARow);
  end;

const
  ATopRowBorders: array[Boolean] of TcxBorders =
    ([bLeft, bTop, bRight], [bLeft, bRight]);

begin
  if HasHeader then
  begin
    Provider.SetCellUnion(0, ARow, 1, 2);
    Provider.SetCellStyleEx(0, ARow, 1, 2, RegisterCellStyle(clDefault,
      clDefault, [cfsBold], cxBordersAll, [bRight, bLeft, bTop], catCenter));
    Provider.SetCellValue(0, ARow, Format(Header, [AIndex]));
    Inc(ARow);
  end;
  WriteSingleRow(cxGetResourceString(@secxSubject),
    AEvent.Caption, ATopRowBorders[HasHeader]);
  WriteSingleRow(cxGetResourceString(@secxLocation),
    AEvent.Location, [bLeft, bRight]);
  WriteSingleRow(cxGetResourceString(@secxDescription),
    AEvent.Message, [bLeft, bRight]);
  WriteSingleRow(cxGetResourceString(@secxAllDay),
    cxGetResourceString(YesNoStrs[AEvent.AllDayEvent]), [bLeft, bRight]);
  WriteSingleRow(cxGetResourceString(@secxStart), AEvent.Start, [bLeft, bRight]);
  WriteSingleRow(cxGetResourceString(@secxFinish), AEvent.Finish, [bLeft, bRight]);
  WriteSingleRow(cxGetResourceString(@secxState),
    cxGetResourceString(States[Min(3, AEvent.State)]), [bLeft, bBottom, bRight]);
{  WriteSingleRow(cxGetResourceString(@secxReminder),
    cxGetResourceString(YesNoStrs[AEvent.Reminder]), [bLeft, bBottom, bRight]);}
  Provider.SetCellStyle(0, ARow, RegisterCellStyle(clDefault, clDefault, [], [], []));
  Provider.SetCellStyle(1, ARow, RegisterCellStyle(clDefault, clDefault, [], [], []));
  Inc(ARow);
end;

procedure TcxSchedulerExportHelper.ExportEvents;
var
  I, ARow: Integer;
begin
  if Events.Count = 0 then Exit;
  ARow := 0;
  for I := 0 to Events.Count - 1 do
    ExportEvent(Events[I], I, ARow);
end;

function TcxSchedulerExportHelper.RegisterCellStyle(AColor, AFontColor: TColor;
  AFontStyle: TcxFontStyles; ABorders, ABoldBorders: TcxBorders; AAlignText: TcxAlignText = catLeft): Integer;
var
  AStyle: TcxCacheCellStyle;
  ASide: TcxBorder;
begin
  AStyle := DefaultCellStyle;
  AStyle.FontStyle := AFontStyle;
  AStyle.AlignText := AAlignText;
  if AColor <> clDefault then
  begin
    AStyle.BrushStyle := cbsSolid;
    AStyle.BrushBkColor := ColorToRgb(AColor);
  end;
  if AFontColor <> clDefault then
    AStyle.FontColor := AFontColor;
  for ASide := bLeft to bBottom do
    with AStyle.Borders[Integer(ASide)] do
    begin
      IsDefault := not (ASide in ABorders);
      if not IsDefault then
      begin
        if ASide in ABoldBorders then
          Width := 2
        else
          Width := 1;
      end;
    end;
  Result := Provider.RegisterStyle(AStyle);
end;

procedure TcxSchedulerExportHelper.TextWidth(const AString: string;
  AWordBreak: Boolean; var AWidth, AHeight: Integer);
var
  R: TRect;
const
  AFlags: array[Boolean] of Integer = (
     DT_CALCRECT or DT_LEFT or DT_WORDBREAK or DT_NOPREFIX,
     DT_CALCRECT or DT_LEFT or DT_NOPREFIX);
begin
  with TcxScreenCanvas.Create do
  try
    R := Rect(0, 0, AWidth, 0);
    Font := Self.Font;
    if not AWordBreak then
      Font.Style := [fsBold];
    Windows.DrawText(Handle, PChar(AString), Length(AString), R, AFlags[AWordBreak]);
    AWidth := Max(AWidth, R.Right - R.Left);
    AHeight := Max(TextHeight('Wg') + 4, R.Bottom - R.Top + 4);
  finally
    Free;
  end;
end;

{ TcxSchedulerTableExportHelper }

procedure TcxSchedulerTableExportHelper.CalculateLayout;
begin
  HasHeader := FHeader <> '';
  Provider.SetRange(Length(NecessaryFields), Events.Count + 1 , False);
end;

procedure TcxSchedulerTableExportHelper.DoExport;
var
  I: Integer;
begin
  CalculateLayout;
  Style := RegisterCellStyle(clDefault, clDefault,
    [cfsBold], cxBordersAll, [], catCenter);
  if FNameProvider <> nil then
  begin
    FNameProvider.SetName('Calendar');
    FNameProvider.SetRangeName('Calendar', Rect(0, 0, Length(NecessaryFields) - 1, Events.Count));
  end;
  for I := 0 to Length(NecessaryFields) - 1 do
  begin
    Provider.SetCellStyle(I, 0, Style);
    Provider.SetCellValue(I, 0, cxGetResourceString(NecessaryFields[I]));
    Provider.SetColumnWidth(I, Min(MaxColumnWidth, 120));
  end;
  Style := RegisterCellStyle(clDefault, clDefault, [], cxBordersAll, []);
  ExportEvents;
  Provider.Commit;
end;

procedure TcxSchedulerTableExportHelper.ExportEvent(
  AEvent: TcxSchedulerEvent; AIndex: Integer; var ARow: Integer);
var
  ACol: Integer;
  ARTime: TDateTime;

  procedure WriteItem(const AData: Variant);
  begin
    Provider.SetCellStyle(ACol, ARow, Style);
    Provider.SetCellValue(ACol, ARow, AData);
    Inc(ACol);
  end;

const
  AStates: array[0..3] of Integer = (3, 1, 2, 4);
begin
  if ARow = 0 then // for fields header
    Inc(ARow);
  ACol := 0;
  ARTime := 0;//AEvent.Start - AEvent.ReminderTime * MinuteToTime;
  WriteItem(AEvent.Caption);                      // Subject
  WriteItem(VarToDateTime(DateOf(AEvent.Start))); // StartDate
  WriteItem(VarToDateTime(TimeOf(AEvent.Start))); // StartTime
  WriteItem(VarToDateTime(DateOf(AEvent.Finish)));// EndDate
  WriteItem(VarToDateTime(TimeOf(AEvent.Finish)));// EndTime
  WriteItem(AEvent.AllDayEvent);                  // Alldayevent
  WriteItem(False{AEvent.Reminder});                     // Reminderonoff
  WriteItem(VarToDateTime(DateOf(ARTime)));       // ReminderDate
  WriteItem(VarToDateTime(TimeOf(ARTime)));       // ReminderTime
  WriteItem('');                                  // MeetingOrganizer
  WriteItem('');                                  // RequiredAttendees
  WriteItem('');                                  // OptionalAttendees
  WriteItem('');                                  // MeetingResources
  WriteItem('');                                  // BillingInformation
  WriteItem('');                                  // Categories,
  WriteItem(AEvent.Message);                      // Description
  WriteItem(AEvent.Location);                     // Location
  WriteItem('');                                  // Mileage
  WriteItem(secxNormal);                          // Priority
  WriteItem(False);                               // Private
  WriteItem(secxNormal);                          // Sensitivity
  WriteItem(AStates[Min(3, AEvent.State)]);       // Showtimeas
  Inc(ARow);
end;

// external procedures definition

procedure cxExportSchedulerToFile(AFileName: string; AScheduler: TcxCustomScheduler;
  AsTable, AShowDialog: Boolean; const AHeader: string; AStart, AFinish: TDateTime;
  AExportType: Integer; const ASeparators: array of string; const AFileExt: string);
var
  I: Integer;
  AIntf: IcxExportWithSeparators;
begin
  if AFileExt <> '' then
    AFileName := ChangeFileExt(AFileName, '.' + AFileExt);
  if (AScheduler.Storage = nil) then
    cxSchedulerError(secxExportStorageInvalid);
  if (AStart = NullDate) or (AFinish = NullDate) then
  begin
    AStart := TcxDateNavigatorAccess(AScheduler.DateNavigator).GetRealFirstDate;
    AFinish := TcxDateNavigatorAccess(AScheduler.DateNavigator).GetRealLastDate;
    if AShowDialog then
    begin
    // todo: use dialog for select period
    end;
  end;
  with SchedulerExportHelpers[AsTable].Create(AScheduler, AStart, AFinish, AExportType, AFileName) do
  try
    FHeader := AHeader;
    if Supports(Provider, IcxExportWithSeparators, AIntf) and (Length(ASeparators) > 0) then
    begin
      for I := Low(ASeparators) to High(ASeparators) do
        AIntf.AddSeparator(ASeparators[I]);
    end;
    DoExport;
  finally
    Free;
  end;
end;

procedure cxExportSchedulerToHTML(const AFileName: string; AScheduler: TcxCustomScheduler;
  AsTable: Boolean = False; AShowDialog: Boolean = False; const AHeader: string = 'Event %d';
  const AStart: TDateTime = NullDate; const AFinish: TDateTime = NullDate; const AFileExt: string = 'html');
begin
  cxExportSchedulerToFile(AFileName, AScheduler, AsTable, AShowDialog, AHeader,
    AStart, AFinish, cxExportToHtml, [], AFileExt);
end;

procedure cxExportSchedulerToXML(const AFileName: string; AScheduler: TcxCustomScheduler;
  AsTable: Boolean = False; AShowDialog: Boolean = False; const AHeader: string = 'Event %d';
  const AStart: TDateTime = NullDate; const AFinish: TDateTime = NullDate; const AFileExt: string = 'xml');
begin
  cxExportSchedulerToFile(AFileName, AScheduler, AsTable, AShowDialog, AHeader,
    AStart, AFinish, cxExportToXML, [], AFileExt);
end;

procedure cxExportSchedulerToExcel(const AFileName: string; AScheduler: TcxCustomScheduler;
  AsTable: Boolean = False; AShowDialog: Boolean = False; const AHeader: string = 'Event %d';
  const AStart: TDateTime = NullDate; const AFinish: TDateTime = NullDate; const AFileExt: string = 'xls');
begin
  cxExportSchedulerToFile(AFileName, AScheduler, AsTable, AShowDialog, AHeader,
    AStart, AFinish, cxExportToExcel, [], AFileExt);
end;

procedure cxExportSchedulerToText(const AFileName: string; AScheduler: TcxCustomScheduler;
  AsTable: Boolean = False; AShowDialog: Boolean = False; const AHeader: string = 'Event %d';
  const AStart: TDateTime = NullDate; const AFinish: TDateTime = NullDate; const ASeparator: string = '';
  const ABeginString: string = ''; const AEndString: string = ''; const AFileExt: string = 'txt');
begin
  cxExportSchedulerToFile(AFileName, AScheduler, AsTable, AShowDialog, AHeader,
    AStart, AFinish, cxExportToText, [ASeparator, ABeginString, AEndString], AFileExt);
end;

initialization
  cxExportInit(TcxGetResourceStringProc(@cxGetResourceString), @ColorToRGB,  True );

end.
