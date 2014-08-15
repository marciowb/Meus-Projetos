unit EViewer;

interface

uses
  Windows, Forms, Dialogs, SysUtils, Classes, ImgList, ComCtrls, StdCtrls,
  ShellAPI, ExtCtrls, Messages, Controls, Graphics, cxStyles, cxCustomData,
  cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, cxMemo,
  cxCurrencyEdit, cxLookAndFeelPainters, cxContainer, cxTextEdit,
  cxButtons, cxHeader, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxClasses, cxControls, cxGridCustomView, cxGrid, cxPC, dxPSCore,
  dxPScxCommon, Menus, dxPSGlbl, dxPSUtl, dxPSEngn, dxPrnPg,
  dxBkgnd, dxWrap, dxPrnDev, dxPSCompsProvider, dxPSFillPatterns,
  dxPSEdgePatterns, cxRichEdit, cxDropDownEdit, cxCalendar, dxPScxGrid6Lnk;

const
  WM_ACCETPFILES = (WM_USER + 1);

type
  TELViewerMainForm = class(TForm)
    Images: TImageList;
    StyleRepository: TcxStyleRepository;
    stBlueDarkBold: TcxStyle;
    stBlueLight: TcxStyle;
    stBlueBright: TcxStyle;
    stYellowLight: TcxStyle;
    stGreyLight: TcxStyle;
    stBlueSky: TcxStyle;
    stBlueDark: TcxStyle;
    stGold: TcxStyle;
    TabContainer: TcxPageControl;
    cxTabSheet1: TcxTabSheet;
    GridCallStack: TcxGrid;
    CallStackView: TcxGridTableView;
    CallStack_Col_Group: TcxGridColumn;
    CallStack_Col_Addr: TcxGridColumn;
    CallStack_Col_Module: TcxGridColumn;
    CallStack_Col_Unit: TcxGridColumn;
    CallStack_Col_Class: TcxGridColumn;
    CallStack_Col_Proc: TcxGridColumn;
    CallStack_Col_Line: TcxGridColumn;
    CallStack_Col_Off: TcxGridColumn;
    LevelCallStack: TcxGridLevel;
    BarHeader: TcxHeader;
    OpenBtn: TcxButton;
    ExitBtn: TcxButton;
    GridList: TcxGrid;
    ListView: TcxGridTableView;
    Exception_Date: TcxGridColumn;
    Exception_Type: TcxGridColumn;
    Exception_Message: TcxGridColumn;
    LevelList: TcxGridLevel;
    Splitter1: TSplitter;
    cxTabSheet2: TcxTabSheet;
    cxTabSheet3: TcxTabSheet;
    cxTabSheet4: TcxTabSheet;
    GridGeneral: TcxGrid;
    GeneralView: TcxGridTableView;
    General_Col_Group: TcxGridColumn;
    General_Col_Name: TcxGridColumn;
    General_Col_Value: TcxGridColumn;
    LevelGeneral: TcxGridLevel;
    GridModules: TcxGrid;
    ModulesView: TcxGridTableView;
    Modules_Col_Handle: TcxGridColumn;
    Modules_Col_Name: TcxGridColumn;
    Modules_Col_Desc: TcxGridColumn;
    Modules_Col_Ver: TcxGridColumn;
    Modules_Col_Size: TcxGridColumn;
    Modules_Col_Mod: TcxGridColumn;
    Modules_Col_Path: TcxGridColumn;
    LevelModules: TcxGridLevel;
    OpenDialog: TOpenDialog;
    stBlue1: TcxStyle;
    stInactive: TcxStyle;
    XMLBtn: TcxButton;
    SaveDialog: TSaveDialog;
    PwdEdit: TcxTextEdit;
    cxContrast: TcxStyle;
    RefreshBtn: TcxButton;
    HelpBtn: TcxButton;
    PrnBtn: TcxButton;
    EL_Print: TdxComponentPrinter;
    EL_Print_General: TdxGridReportLink;
    EL_Print_CallStack: TdxGridReportLink;
    EL_Print_Modules: TdxGridReportLink;
    EL_Print_CPU: TdxGridReportLink;
    CallStackView_Preview: TcxGridColumn;
    cxTabSheet5: TcxTabSheet;
    cxTabSheet6: TcxTabSheet;
    GridProcesses: TcxGrid;
    ProcessesView: TcxGridTableView;
    Processes_Col_ID: TcxGridColumn;
    Processes_Col_Name: TcxGridColumn;
    Processes_Col_Description: TcxGridColumn;
    Processes_Col_Version: TcxGridColumn;
    Processes_Col_Memory: TcxGridColumn;
    Processes_Col_Priority: TcxGridColumn;
    Processes_Col_Threads: TcxGridColumn;
    Processes_Col_Path: TcxGridColumn;
    LevelProcesses: TcxGridLevel;
    EL_Print_Processes: TdxGridReportLink;
    GridAssembler: TcxGrid;
    AssemblerView: TcxGridTableView;
    Assembler_Col_Text: TcxGridColumn;
    LevelAssembler: TcxGridLevel;
    EL_Print_Assembler: TdxGridReportLink;
    stCourier: TcxStyle;
    GridCPU: TcxGrid;
    CPUView: TcxGridTableView;
    CPU_Col_Text: TcxGridColumn;
    LevelCPU: TcxGridLevel;
    Exception_Status: TcxGridColumn;
    Exception_Note: TcxGridColumn;
    Exception_ID: TcxGridColumn;
    Exception_Module: TcxGridColumn;
    DelBtn: TcxButton;
    stCourier2: TcxStyle;
    ClearBtn: TcxButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure CallStackViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure CallStackViewCustomDrawGroupCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableCellViewInfo;
      var ADone: Boolean);
    procedure OpenBtnClick(Sender: TObject);
    procedure ExitBtnClick(Sender: TObject);
    procedure GeneralViewCustomDrawGroupCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableCellViewInfo; var ADone: Boolean);
    procedure ModulesViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure FormMove(var Msg: TMessage); message WM_MOVE;
    procedure DropFiles(var Msg: TMessage); message WM_DROPFILES;
    procedure AcceptFiles(var Msg: TMessage); message WM_ACCETPFILES;
    procedure CallStackViewCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure XMLBtnClick(Sender: TObject);
    procedure RefreshBtnClick(Sender: TObject);
    procedure ListViewFocusedRecordChanged(Sender: TcxCustomGridTableView;
      APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure HelpBtnClick(Sender: TObject);
    procedure LoadState;
    procedure SaveState;
    procedure FormResize(Sender: TObject);
    procedure PwdEditKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure PrnBtnClick(Sender: TObject);
    procedure EL_Print_CallStackCustomDrawCell(Sender: TdxGridReportLink;
      ACanvas: TCanvas; AView: TcxCustomGridTableView;
      ARecord: TcxCustomGridRecord; AColumn: TcxGridColumn;
      AnItem: TAbstractdxReportCellData; var ADone: Boolean);
    procedure ListViewDataControllerAfterPost(
      ADataController: TcxCustomDataController);
    procedure ListViewDataControllerDataChanged(Sender: TObject);
    procedure DelBtnClick(Sender: TObject);
    procedure ClearBtnClick(Sender: TObject);
  public
    procedure LoadLog;
    procedure ImportLog(FileName: string);
    { Public declarations }
  end;

var
  ELViewerMainForm: TELViewerMainForm;

implementation

uses
 cxLookAndFeels, EGeneralData, Types, Registry, ShlObj, Variants,
 IniFiles, EConsts, ELogManager, ECore, EBase64, EEncrypt, EDesign, EHash;

{$R *.dfm}

{$R Icon.res}

const
  Title_Const = 'EurekaLog Viewer ' + EurekaLogViewerVersion;
  MyTextFlagsCenter = (cxAlignVCenter or cxShowEndEllipsis);
  MyTextFlagsBottom = (cxAlignBottom or cxShowEndEllipsis);
  IniFileName = 'EurekaLog_Viewer.ini';
  LogDBName = 'EurekaLog_Viewer_DataBase.dat';

const
  RTFHeader =
    '{\rtf1\ansi\ansicpg1252\deff0\deflang1040{\fonttbl{\f0\fmodern\fprq1\fcharset%d %s;}}'#13#10+
    '{\colortbl ;\red0\green100\blue100;\red0\green0\blue0;\red40\green40\blue40;' +
    '\red0\green0\blue160;\red160\green0\blue0;\red80\green80\blue80;' +
    '\red0\green100\blue0;}'#13#10;
  RTFFooter = '}';

var
  ListDataSet, GeneralDataSet, CallStackDataSet, ModulesDataSet,
    ProcessesDataSet, AssemblerDataSet, CPUDataSet: TGeneralDataSet;
  ListDataSource, GeneralDataSource, CallStackDataSource, ModulesDataSource,
    ProcessesDataSource, AssemblerDataSource, CPUDataSource: TUserDataSource;
  Log: TLogFile = nil;
  InternalChange: Boolean = False;
  LoadingState: Boolean = True;
  CurrentBugID: string = '';
  ImportLogCriticalSection: TRTLCriticalSection;

//------------------------------------------------------------------------------

procedure Error(const Msg: string);
begin
  MessageBeep(MB_ICONERROR);
  MessageBox(0, PChar(Msg), 'Error', MB_OK or MB_ICONERROR or MB_TASKMODAL);
end;

function GetDateTime(const Value: string): TDateTime;
const
  Months: array[1..12] of string =
  ('Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec');
var
  List: TStringList;
  Day, Month, Year, Hour, Min, Sec: DWord;
  GMT: Double;
begin
  Result := 0;
  if (Value = '') then Exit;

  List := TStringList.Create;
  try
    ExtractStringsEx([' ', ':'], Value, List);
    Day := StrToInt(List[1]);
    Month := 1;
    while (Month < 12) and (UpperCase(List[2]) <> UpperCase(Months[Month])) do
      inc(Month);
    Year := StrToInt(List[3]);
    Hour := StrToInt(List[4]);
    Min := StrToInt(List[5]);
    Sec := StrToInt(List[6]);
    GMT := (StrToInt(Copy(List[7], 1, Length(List[7]) - 2)) / 24);
    Result := (EncodeDate(Year, Month, Day) + EncodeTime(Hour, Min, Sec, 0) - GMT) + (GetGMT / 24);
  finally
    List.Free;
  end;
end;

function GetDate(const Value: string): string;
var
  Dat: TDateTime;
begin
  Dat := GetDateTime(Value);
  if (Dat = 0) then Result := '????-??-??'
  else Result := FormatDateTime('yyyy-mm-dd hh:nn:ss', Dat);
end;

function TestDecrypt(const Value: string): Boolean;
const
  chars: set of char = ['a'..'z', 'A'..'Z', '0'..'9', '_', '.', '@'];
var
  n: Integer;
begin
  Result := True;
  for n := 1 to Length(Value) do
    if not (Value[n] in chars) then
    begin
      Result := False;
      Break;
    end;
end;

// Example:
// ----------------------------------------------------------------------------------
// RegisterFiletype('.TED', 'TEDFile', 'TED File', 'open', Application.ExeName, '0');
// ----------------------------------------------------------------------------------
procedure RegisterFileType(const Ext, FileType, Description, App, Icon: string);
var
  KeyString, Verb, ParamNum: string;
  Reg: TRegistry;

  procedure CreateKeyEx(const Key, KeyName, KeyValue: string);
  begin
    if (Reg.OpenKey(Key, True)) then
    try
      try
        if (Reg.ReadString(KeyName) <> KeyValue) then
          if (Reg.Access and KEY_WRITE <> 0) then
            Reg.WriteString(KeyName, KeyValue);
      except
        // ...
      end;
    finally
      Reg.CloseKey;
    end;
  end;

begin
  Verb := 'open';
  ParamNum := ' "%1"';
  Reg := TRegistry.Create;
  with Reg do
  try
    RootKey := HKEY_CLASSES_ROOT;
    CreateKeyEx(Ext, '', FileType);
    CreateKeyEx(FileType, '', Description);
    KeyString := Format('%s\shell\%s\command', [FileType, Verb]);
    CreateKeyEx(KeyString, '', App + ParamNum);
    CreateKeyEx(FileType + '\DefaultIcon', '', App + ',' + Icon);
  finally
    Free;
  end;
  ShChangeNotify(SHCNE_ASSOCCHANGED, 0, nil, nil);
end;
//------------------------------------------------------------------------------

procedure TELViewerMainForm.FormCreate(Sender: TObject);
var
  DataHeight: Integer;

  function GetDisplayBitColors: Integer;
  var
    DeviceContext: hDC;
  begin
    DeviceContext := GetDC(0);
    try
      Result := GetDeviceCaps(DeviceContext, BITSPIXEL);
    finally
      ReleaseDC(0, DeviceContext);
    end;
  end;

begin
{$IFDEF BUILD_FOR_DOTNET}
  CallStack_Col_Off.Caption := 'Column';
  PwdEdit.Visible := False;
  RefreshBtn.Visible := False;
  BarHeader.Sections[6].Text := '';
{$ENDIF}
  Caption := Title_Const;
  if (GetDisplayBitColors <= 8) then
  begin
    cxContrast.Color := clWhite;
    stBlueBright.Color := clWhite;
    stCourier2.Color := clWhite;
  end;

{$IFNDEF BUILD_FOR_DOTNET}
  RegisterFileType('.elf', 'ELFFile', 'EurekaLog file', Application.ExeName, '1');
{$ELSE}
  RegisterFileType('.el', 'ELFile', 'EurekaLog file', Application.ExeName, '1');
{$ENDIF}

  DataHeight := (-GridCallStack.Font.Height + 6);
  if (DataHeight < 17) then DataHeight := 17;
  CallStackView.OptionsView.DataRowHeight := DataHeight;
  CallStackView.OptionsView.GroupRowHeight := (DataHeight + 19);
  ModulesView.OptionsView.DataRowHeight := (DataHeight + 0);

  GeneralDataSet := TGeneralDataSet.Create;
  GeneralDataSource := TUserDataSource.Create(GeneralDataSet);
  GeneralView.DataController.CustomDataSource := GeneralDataSource;

  CallStackDataSet := TGeneralDataSet.Create;
  CallStackDataSource := TUserDataSource.Create(CallStackDataSet);
  CallStackView.DataController.CustomDataSource := CallStackDataSource;

  ModulesDataSet := TGeneralDataSet.Create;
  ModulesDataSource := TUserDataSource.Create(ModulesDataSet);
  ModulesView.DataController.CustomDataSource := ModulesDataSource;

  ProcessesDataSet := TGeneralDataSet.Create;
  ProcessesDataSource := TUserDataSource.Create(ProcessesDataSet);
  ProcessesView.DataController.CustomDataSource := ProcessesDataSource;

  AssemblerDataSet := TGeneralDataSet.Create;
  AssemblerDataSource := TUserDataSource.Create(AssemblerDataSet);
  AssemblerView.DataController.CustomDataSource := AssemblerDataSource;

  CPUDataSet := TGeneralDataSet.Create;
  CPUDataSource := TUserDataSource.Create(CPUDataSet);
  CPUView.DataController.CustomDataSource := CPUDataSource;

  ListDataSet := TGeneralDataSet.Create;
  ListDataSource := TUserDataSource.Create(ListDataSet);
  ListView.DataController.CustomDataSource := ListDataSource;

  DragAcceptFiles(Handle, True);

  AdjustFontLanguage(Self);
  LoadState;
  LoadLog;

  if (ParamCount = 1) and (FileExists(ParamStr(1))) then ImportLog(ParamStr(1));
end;

procedure TELViewerMainForm.FormDestroy(Sender: TObject);
begin
  if (Log <> nil) then FreeAndNil(Log);
  GeneralDataSet.Free;
  GeneralDataSource.Free;
  CallStackDataSet.Free;
  CallStackDataSource.Free;
  ModulesDataSet.Free;
  ModulesDataSource.Free;
  ProcessesDataSet.Free;
  ProcessesDataSource.Free;
  AssemblerDataSet.Free;
  AssemblerDataSource.Free;
  CPUDataSet.Free;
  CPUDataSource.Free;
  ListDataSet.Free;
  ListDataSource.Free;

  SaveState;
  LoadingState := True;  
end;

procedure TELViewerMainForm.CallStackViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var
  Top, ImgIdx: Integer;
  LineStr, ModuleStr: string;
begin
  if (AViewInfo.Item.Index = 1) then // Address...
  begin
    ADone := True;
    LineStr := TcxGridViewData(Sender.ViewData).Rows[AViewInfo.GridRecord.Index].Values[6];
    ModuleStr := TcxGridViewData(Sender.ViewData).Rows[AViewInfo.GridRecord.Index].Values[2];
    if (LineStr <> '') then ImgIdx := {$IFNDEF BUILD_FOR_DOTNET} 3 {$ELSE} 4 {$ENDIF}
    else
      if (UpperCase(Trim(ExtractFileExt(ModuleStr))) = '.BPL') or
        (UpperCase(Trim(ExtractFileExt(ModuleStr))) = '.DPL') then ImgIdx := 1
      else
        if (UpperCase(Trim(ExtractFileExt(ModuleStr))) = '.EXE') then ImgIdx := 2
        else ImgIdx := 0;
    ACanvas.FillRect(AViewInfo.Bounds);
    Top := (AViewInfo.Bounds.Top + (AViewInfo.Bounds.Bottom - AViewInfo.Bounds.Top - 16) div 2);
    Images.Draw(ACanvas.Canvas, AViewInfo.Bounds.Left - 1, Top, ImgIdx);
    Inc(AViewInfo.Bounds.Left, 18);
    ACanvas.DrawText(AViewInfo.DisplayValue, AViewInfo.Bounds, MyTextFlagsCenter);
    Dec(AViewInfo.Bounds.Left, 18);
  end
  else
  if (AViewInfo.Item.Index = 8) then // Calling Thread...
  begin
    ADone := True;
    ACanvas.FillRect(AViewInfo.Bounds);
    if (not AViewInfo.Selected) then ACanvas.Font.Color := $606060;
    ACanvas.Font.Style := (ACanvas.Font.Style + [fsBold]);
    Inc(AViewInfo.Bounds.Left, 18);
    ACanvas.DrawText(AViewInfo.DisplayValue, AViewInfo.Bounds, MyTextFlagsCenter);
    Dec(AViewInfo.Bounds.Left, 18);
    ACanvas.Font.Style := (ACanvas.Font.Style - [fsBold]);
  end;
end;

procedure TELViewerMainForm.CallStackViewCustomDrawGroupCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableCellViewInfo; var ADone: Boolean);
var
  Idx: Integer;
  Text: string;
begin
  ADone := True;
  if (not AViewInfo.Selected) then
  begin
    if (AViewInfo.GridRecord.Index = 0) then
      ACanvas.Font.Color := $000080
    else
{$IFDEF BUILD_FOR_DOTNET}
      ACanvas.Font.Color := $000080;
{$ELSE}
      ACanvas.Font.Color := $800000;
{$ENDIF}
  end;
  ACanvas.FillRect(AViewInfo.Bounds);
  Inc(AViewInfo.Bounds.Left, 18);
  Dec(AViewInfo.Bounds.Bottom, 4);
  ACanvas.Font.Style := (ACanvas.Font.Style + [fsBold]);
  Idx := Pos(' ', AViewInfo.Text);
  Text := Copy(AViewInfo.Text, Idx + 1, MaxInt);
{$IFDEF BUILD_FOR_DOTNET}
  Idx := Pos(': ', Text);
  if (Idx > 0) then
  begin
    Inc(Idx, 2);
    repeat
      Delete(Text, Idx, 1);
    until ((Idx = Length(Text)) or (Text[Idx] = '('));
  end;
{$ELSE}
{$ENDIF}
  ACanvas.DrawText(Text, AViewInfo.Bounds, MyTextFlagsBottom);
  ACanvas.Font.Style := (ACanvas.Font.Style - [fsBold]);
  Dec(AViewInfo.Bounds.Left, 18);
  Inc(AViewInfo.Bounds.Bottom, 4);
end;

procedure TELViewerMainForm.OpenBtnClick(Sender: TObject);
var
  n: Integer;
begin
  if (OpenDialog.Execute) then
  begin
    Screen.Cursor := crHourGlass;
    try
      for n := 0 to (OpenDialog.Files.Count - 1) do
      begin
        Application.ProcessMessages;
        ImportLog(OpenDialog.Files[n]);
      end;
    finally
      Screen.Cursor := crDefault;
    end;
  end;
end;

procedure Generate_General(Index: Integer);
var
  Source: TStrings;
  TmpLine, GroupLabel, GroupName, LineName, LineLabel, LineValue: string;
  n, Idx, Idx2, Idx3: Integer;
  Group, AddValue: Boolean;
  Line: array [0..2] of Variant;

  procedure AddValueField;
  begin
    if (Copy(LineValue, 1, 3) = '.'#13#10) then Delete(LineValue, 1, 1);
    if (Copy(LineValue, Length(LineValue) - 2, 3) = #13#10'.') then
      Delete(LineValue, Length(LineValue), 1);
    LineValue := QuickStringReplace(LineValue, ':_', ': ');
    LineValue := QuickStringReplace(LineValue, #10'.'#13, #10#13);
    LineValue := Trim(LineValue);
    Line[2] := LineValue;
    GeneralDataSet.AddRow(Line);
  end;

begin
  GeneralDataSet.Clear;
  if (Log = nil) or (Log.Count = 0) then Exit;

  Group := True;
  AddValue := False;
  Source := TStringList.Create;
  try
    Source.Text := Log.Items_Generals[Index];
    n := 2;
    while (n <= Source.Count - 1) do
    begin
      if (Group) then
      begin
        GroupLabel := Source[n];
        Delete(GroupLabel, Length(GroupLabel), 1);
        GroupName := '';
        LineName := '';
        LineLabel := '';
        LineValue := '';
        Group := False;
        Inc(n);
      end
      else
      begin
        TmpLine := Trim(Source[n]);
        Idx := Pos(': ', TmpLine);
        if (Idx = 0) and (Copy(TmpLine, Length(TmpLine), 1) = ':') then Idx := Length(TmpLine);
        if (Idx > 0) then
        begin
          if (AddValue) then AddValueField;
          Idx2 := Pos(' ', TmpLine);
          LineName := Copy(TmpLine, 1, Idx2 - 1);
          Idx3 := Pos('.', LineName);
          if (GroupName = '') then
          begin
            GroupName := Copy(LineName, 1, Idx3 - 1);
            Line[0] := IntToHex(n, 4) + ' ' + GroupLabel;
          end;
          LineLabel := Trim(Copy(TmpLine, Idx2 + 1, Idx - Idx2 - 1));
          LineValue := Copy(TmpLine, Idx + 2, Length(TmpLine));
          Line[1] := LineLabel;
          AddValue := True;
        end
        else
          if (TmpLine = '') then
          begin
            Group := True;
            AddValueField;
            AddValue := False;
          end
          else LineValue := (LineValue + #13#10 + TmpLine);
      end;
      Inc(n);
      if (n >= Source.Count) then
      begin
        AddValueField;
        AddValue := False;
      end;
    end;
  finally
    Source.Free;
  end;
  with ELViewerMainForm do
  begin
    GeneralView.DataController.UpdateItems(True);
    GeneralView.ViewData.Expand(True);
  end;
end;

procedure Generate_CallStack(Index: Integer);
var
  Lines, Values: TStringList;
  n, Idx, count: Integer;
  Tmp, FirstCol, Value, TmpLine, Field1, Field2, Field3: string;
  Line, Offset: Variant;
  Master, First: Boolean;
  Row: array [0..8] of Variant;
  LangType, UnitName, ClassName, ProcName, Base64: string;

  function ExtractValue(const S: string): string;
  begin
    Result := Copy(S, Pos('=', S) + 1, Length(S));
  end;

begin
  CallStackDataSet.Clear;
  if (Log = nil) or (Log.Count = 0) then Exit;

  count := 0;
  Row[8] := '';
  Tmp := 'Exception Thread';
  Lines := TStringList.Create;
  Values := TStringList.Create;
  Value := Log.Items_CallStack[Index];
  try
    Master := True;
    First := True;
    Lines.Text := Value;
    for n := 3 to Lines.Count - 2 do
    begin
      Values.Clear;
      ExtractStringsEx(['|'], Lines[n], Values);
      if (Copy(Lines[n], 1, 2) = '|-') then Continue;
      if (Values.Count > 5) then
      begin
        UnitName := Values[2];
        ClassName := Values[3];
        ProcName := Values[4];
        if (Copy(UnitName, 1, 1) = '?') then // Encrypted...
        begin
          LangType := Copy(UnitName, 2, 1);
          Base64 := (Copy(UnitName, 3, Length(UnitName)));
          UnitName := Base64DecodeString(Base64);
          EEncrypt.Decrypt(UnitName[1], UnitName[1], Length(UnitName));
          if (LowerCase(ExtractFileExt(UnitName)) = '') then
            if (LangType = 'p') then UnitName := (UnitName + '.pas')
            else UnitName := (UnitName + '.cpp');
          Base64 := (Copy(ProcName, 2, Length(ProcName)));
          ProcName := Base64DecodeString(Base64);
          EEncrypt.Decrypt(ProcName[1], ProcName[1], Length(ProcName));
          Idx := Pos('.', ProcName);
          if (Idx > 0) then
          begin
            ClassName := Copy(ProcName, 1, Idx - 1);
            Procname := Copy(ProcName, Idx + 1, Length(ProcName));
          end
          else
            if (ClassName <> '') then
            begin
              Base64 := (Copy(ClassName, 2, Length(ClassName)));
              ClassName := Base64DecodeString(Base64);
              EEncrypt.Decrypt(ClassName[1], ClassName[1], Length(ClassName));
            end;
          if (not TestDecrypt(UnitName)) or (not TestDecrypt(ClassName)) or
            (not TestDecrypt(ProcName)) then
          begin
            Error('Invalid password.');
            Exit;
          end;
        end;
        if (ProcName <> '') and (ProcName[1] = '@') then ProcName[1] := '_';
        Row[1] := Values[0];
        Row[2] := Values[1];
        Row[3] := UnitName;
        Row[4] := ClassName;
        Row[5] := ProcName;
        Idx := Pos('[', Values[5]);
        if (Idx > 0) then
        begin
          Line := StrToIntDef(Copy(Values[5], 1, Idx - 1), 0);
          Offset := StrToIntDef(Copy(Values[5], Idx + 1, Length(Values[5]) - Idx - 1), 0);
        end
        else
        begin
          if (Values[5] <> '') then Line := StrToIntDef(Values[5], 0) else Line := '';
          Offset := '';
        end;
        Row[6] := Line;
        Row[7] := Offset;
        Row[0] := (IntToHex(count, 4) + ' ' + Tmp);
        CallStackDataSet.AddRow(Row);
        Row[8] := '';
      end
      else
      begin
        if (Values[0] <> '') then
        begin
          Idx := Pos(':', Values[0]);
          TmpLine := Copy(Values[0], Idx + 2, Length(Values[0]));
          ExtractStringsEx([';'], TmpLine, Values);
          if (Master) then
          begin
            if (First) then
            begin
              FirstCol := 'Exception Thread: ';
              First := False;
            end
            else
{$IFNDEF BUILD_FOR_DOTNET}
              FirstCol := 'Running Thread: ';
{$ELSE}
              FirstCol := 'Exception Thread: ';
{$ENDIF}
            Inc(count);
          end
          else FirstCol := 'Calling Thread: ';
          if ((Values.Count > 0) and (Copy(Values[0], 1, 1) = '+')) then
          begin
            FirstCol := 'Memory Leak: ';
            Field1 := 'Type';
            Field2 := 'Total size';
            Field3 := 'Count';
          end
          else
          begin
            Field1 := 'ID';
            Field2 := 'Priority';
            Field3 := 'Class';
          end;
          if (Values.Count > 1) then FirstCol := (FirstCol + Field1 + '=' + ExtractValue(Values[1])) + '; ';
          if (Values.Count > 2) then FirstCol := (FirstCol + Field2 + '=' + ExtractValue(Values[2])) + '; ';
          if (Values.Count > 3) and (ExtractValue(Values[3]) <> '') then
            FirstCol := (FirstCol + Field3 + '=' + ExtractValue(Values[3])) + '; ';
          if (Values.Count > 4) then FirstCol := (FirstCol + '[Main]');
          if (Master) then Tmp := FirstCol else Row[8] := FirstCol;
          Master := False;
        end
        else Master := True;
      end;
    end;
  finally
    Values.Free;
    Lines.Free;
    with ELViewerMainForm do
    begin
      CallStackView.DataController.UpdateItems(True);
      CallStackView.ViewData.Expand(True);
    end;
  end;
end;

procedure Generate_Modules(Index: Integer);
var
  Lines, Values: TStringList;
  n: Integer;
  Value: string;
  Row: array [0..6] of Variant;
begin
  ModulesDataSet.Clear;
  if (Log = nil) or (Log.Count = 0) then Exit;

  Lines := TStringList.Create;
  Values := TStringList.Create;
  Value := Log.Items_Modules[Index];
  try
    Lines.Text := Value;
    for n := 3 to Lines.Count - 2 do
    begin
      Values.Clear;
      ExtractStringsEx(['|'], Lines[n], Values);
      if (Copy(Lines[n], 1, 2) = '|-') then Continue;
      Row[0] := Values[0];
      Row[1] := Values[1];
      Row[2] := Values[2];
      Row[3] := Values[3];
      Row[4] := StrToIntDef(Values[4], 0);
      if (Values.Count > 6) then
      begin
        Row[5] := Values[5];
        Row[6] := Values[6];
      end
      else
      begin
        Row[5] := '';
        Row[6] := Values[5];
      end;
      ModulesDataSet.AddRow(Row);
    end;
  finally
    Values.Free;
    Lines.Free;
  end;
  ELViewerMainForm.ModulesView.DataController.UpdateItems(True);
end;

procedure Generate_Processes(Index: Integer);
var
  Lines, Values: TStringList;
  n: Integer;
  Value: string;
  Row: array [0..7] of Variant;
begin
  ProcessesDataSet.Clear;
  if (Log = nil) or (Log.Count = 0) then Exit;

  Lines := TStringList.Create;
  Values := TStringList.Create;
  Value := Log.Items_Processes[Index];
  try
    Lines.Text := Value;
    for n := 3 to Lines.Count - 2 do
    begin
      Values.Clear;
      ExtractStringsEx(['|'], Lines[n], Values);
      if (Copy(Lines[n], 1, 2) = '|-') then Continue;
      Row[0] := StrToFloat(Values[0]);
      Row[1] := Values[1];
      Row[2] := Values[2];
      Row[3] := Values[3];
      Row[4] := StrToIntDef(Values[4], 0);
      Row[5] := Values[5];
      Row[6] := StrToIntDef(Values[6], 0);
      Row[7] := Values[7];
      ProcessesDataSet.AddRow(Row);
    end;
  finally
    Values.Free;
    Lines.Free;
  end;
  ELViewerMainForm.ProcessesView.DataController.UpdateItems(True);
end;

function TextToRTF(const Txt: string): string;
begin
  Result := QuickStringReplace(Txt, '\', '\\');
  Result := QuickStringReplace(Result, '{', '\{');
  Result := QuickStringReplace(Result, '}', '\}');
  Result := QuickStringReplace(Result, #13#10, '\par'#13#10);
end;

function AssemblerToRTF(const Txt: string): string;
var
  n, Idx: Integer;
  Lines: TStrings;
  RTFText, Line: string;
begin
  Result := '';
  if (Txt = '') then Exit;

  Lines := TStringList.Create;
  try
    Lines.Text := TextToRTF(Txt);
    for n := 0 to (Lines.Count - 1) do
    begin
      Line := Lines[n];
      if (Copy(Line, 1, 1) <> ';') then
      begin
        Line := ('\cf5 ' + Line);
        Insert('\cf4\b ', Line, 15);
        Insert('\b0\cf7 ', Line, 31);
      end;
      Idx := Pos(';', Line);
      if (Idx > 0) then Insert('\cf6 ', Line, Idx);
      Lines[n] := Line;
    end;
    RTFText := Lines.Text;
    RTFText := ('\f0\fs' + IntToStr(8 * 2) + #13#10 {Font} + RTFText);
  finally
    Lines.Free;
  end;
  Result := (Format(RTFHeader, [0, 'Courier New']) + RTFText + RTFFooter);
end;

function DecodeAsmText(const AsmText: string): string;
var
  Lines: TStrings;
  n: Integer;

  function DecodeAsmLine(const AsmLine: string): string;
  var
    idx, n: Integer;
    Line, NewLine, LineNumbers, DecodedLine: string;
    Elements: TStrings;
  begin
    Result := AsmLine;

    if (Copy(AsmLine, 1, 3) = '; ?') then
    begin
      idx := Pos(' (', AsmLine);
      if (idx > 0) then
      begin
        LineNumbers := Copy(AsmLine, idx, MaxInt);
        Line := Copy(AsmLine, 5, idx - 5);
        Line := QuickStringReplace(Line, '?', '');
        Elements := TStringList.Create;
        try
          NewLine := '';
          ExtractList(Line, Elements, ['.'], False, False);
          for n := 0 to (Elements.Count - 1) do
          begin
            DecodedLine := Base64DecodeString(Elements[n]);
            Decrypt(DecodedLine[1], DecodedLine[1], Length(DecodedLine));
            if (not TestDecrypt(DecodedLine)) then Exit;
            if (NewLine <> '') then NewLine := (NewLine + '.');
            NewLine := (NewLine + DecodedLine);
          end;
          Result := ('; ' + NewLine + LineNumbers);
        finally
          Elements.Free;
        end;
      end;
    end;
  end;

begin
  Lines := TStringList.Create;
  try
    Lines.Text := AsmText;
    for n := 0 to (Lines.Count - 1) do
      Lines[n] := DecodeAsmLine(Lines[n]);
    Result := Lines.Text;
  finally
    Lines.Free;
  end;
end;

procedure Generate_Assembler(Index: Integer);
var
  Value: Variant;
begin
  AssemblerDataSet.Clear;
  if (Log = nil) or (Log.Count = 0) then Exit;

  Value := Log.Items_Assembler[Index];
  Value := AssemblerToRTF(DecodeAsmText(Value));
  AssemblerDataSet.AddRow(Value);
  ELViewerMainForm.AssemblerView.DataController.UpdateItems(True);
end;

function CPUToRTF(const Txt: string): string;
const
  Line = '---------------------';
var
  n: Integer;
  Lines: TStrings;
  RTFText: string;
  S: string;
begin
  Result := '';
  if (Txt = '') then Exit;

  Lines := TStringList.Create;
  try
    Lines.Text := TextToRTF(Txt);
    Lines[0] := ('\cf3\b ' + Lines[0] + '\cf2\b0');
    Lines[1] := ('\cf3 ' + Lines[1] + '\cf2');
    for n := 2 to 5 do
    begin
      S := Lines[n];
      Insert('\cf4 ', S, 6);
      Insert('\cf2 ', S, 19);
      Insert('\cf4 ', S, 32);
      Insert('\cf2 ', S, 45);
      Lines[n] := S;
    end;
    S := Lines[8];
    Lines[8] := ('\cf3 ' + S + '\cf2');
    for n := 9 to (Lines.Count - 1) do
    begin
      S := Lines[n];
      Insert('\cf4 ', S, 11);
      Insert('\cf2 ', S, 24);
      Insert('\cf4 ', S, 44);
      Insert('\cf5 ', S, 96);
      s := (s + '\cf2 ');
      Lines[n] := S;
    end;
    RTFText := Lines.Text;
    RTFText := ('\f0\fs' + IntToStr(8 * 2) + #13#10 {Font} + RTFText);
  finally
    Lines.Free;
  end;
  Result := (Format(RTFHeader, [0, 'Courier New']) + RTFText + RTFFooter);
end;

procedure Generate_CPU(Index: Integer);
var
  Value: Variant;
begin
  CPUDataSet.Clear;
  if (Log = nil) or (Log.Count = 0) then Exit;

  Value := Log.Items_CPU[Index];
  Value := CPUToRTF(Value);
  CPUDataSet.AddRow(Value);
  ELViewerMainForm.CPUView.DataController.UpdateItems(True);
end;

function Generate_List: Boolean;
var
  n, Idx: Integer;
  Bug_ID, Bug_Status, Bug_Note, Bug_Date, Bug_Type, Bug_Message,
  Bug_ModuleName, Bug_ModuleDescription, Bug_ModuleVersion: string;
begin
  Result := False;
  ListDataSet.Clear;
  for n := 0 to Log.Count - 1 do
  begin
    if (Log.LogVersion[n] >= '6.0') then
    begin
      Bug_ID := Log.GetItemValue('2.7', n);
      Bug_Status := Log.GetItemValue('2.9', n);
      Bug_Note := Log.GetItemValue('2.10', n);
      Bug_Date := Log.GetItemValue('2.1', n);
      Bug_Type := Log.GetItemValue('2.5', n);
      Bug_Message := Log.GetItemValue('2.6', n);
      Bug_ModuleName := Log.GetItemValue('2.3', n);
      Idx := Pos(' - ', Bug_ModuleName);
      if (Idx > 0) then
      begin
        Bug_ModuleDescription := Copy(Bug_ModuleName, Idx, MaxInt);
        Bug_ModuleName := Trim(Copy(Bug_ModuleName, 1, Idx - 1));
      end
      else Bug_ModuleDescription := '';

      Bug_ModuleName :=
        (UpperCase(Copy(Bug_ModuleName, 1, 1)) +
        LowerCase(Copy(Bug_ModuleName, 2, MaxInt)) + Bug_ModuleDescription);

      Bug_ModuleVersion := Log.GetItemValue('2.4', n);
      if (Bug_ModuleVersion <> '') then
        Bug_ModuleName := (Bug_ModuleName + ' v. ' + Bug_ModuleVersion);
    end
    else
    begin
      Bug_ID := Log.GetItemValue('2.7', n);
      Bug_Status := Log.GetItemValue('2.9', n);
      Bug_Note := Log.GetItemValue('2.10', n);
      Bug_Date := Log.GetItemValue('2.1', n);
      Bug_Type := Log.GetItemValue('2.4', n);
      Bug_Message := Log.GetItemValue('2.5', n);
      Bug_ModuleName := Log.GetItemValue('2.3', n);
    end;
    ListDataSet.AddRow([Bug_ID, Bug_Status, Bug_Note, GetDate(Bug_Date),
      Bug_Type, Bug_Message, Bug_ModuleName]);
    Result := True;
  end;
  ELViewerMainForm.ListView.DataController.UpdateItems(True);
end;

procedure Generate_Lists;
var
  Index: Integer;
  CharSet: string;
  n: Integer;
  Style: TcxStyle;
begin
  Index := ELViewerMainForm.ListView.DataController.FocusedRecordIndex;
  if (Index = -1) then Exit;

  CurrentBugID := ListDataSet.Items[Index].FieldsValue[0];

  Generate_General(Index);
  Generate_CallStack(Index);
  Generate_Modules(Index);
  Generate_Processes(Index);
  Generate_Assembler(Index);
  Generate_CPU(Index);

  if (Log = nil) or (Log.Count = 0) then Exit;

  if (Log.LogVersion[Index] >= '6.0') then
    CharSet := Log.GetItemValue('6.5', Index)
  else
    CharSet := IntToStr(DEFAULT_CHARSET);

  // Update all Fonts CharSet...
  if (CharSet = '') then CharSet := IntToStr(DEFAULT_CHARSET);
  for n := 0 to (ELViewerMainForm.StyleRepository.Count - 1) do
  begin
    Style := TcxStyle(ELViewerMainForm.StyleRepository.Items[n]);
    Style.Font.Charset := StrToInt(CharSet);
  end;
end;

procedure TELViewerMainForm.LoadLog;
var
  Created: Boolean;
  FileName: string;
begin
  Screen.Cursor := crHourGlass;
  Application.ProcessMessages;
  InternalChange := True;
  try
    if (PwdEdit.Text <> '') then EEncrypt.InitKey(PwdEdit.Text);
    Created := False;
    if (Log <> nil) then Log.Free;
    try
      FileName := (ExtractFilePath(ParamStr(0)) + LogDBName);
      if (not GetWorkingFile(FileName, True, False)) then Exit;

      Log := TLogFile.Create(FileName, False);
      Created := True;
      if (Log.Count > 0) then
      begin
        Modules_Col_Mod.Visible := (Log.LogVersion[0] >= '5.0');
        if (Generate_List) then
        begin
          if (ListView.DataController.ItemCount > 0) then
            ListView.DataController.FocusedRowIndex := 0;
          Generate_Lists;
        end;
        XMLBtn.Enabled := True;
        PrnBtn.Enabled := True;
        RefreshBtn.Enabled := True;
        if (GetParentForm(GridList).Showing) then GridList.SetFocus;
      end
      else
      begin
        ListDataSet.Clear;
        ListView.DataController.UpdateItems(True);
        GeneralDataSet.Clear;
        GeneralView.DataController.UpdateItems(True);
        GeneralView.ViewData.Expand(True);
        CallStackDataSet.Clear;
        CallStackView.DataController.UpdateItems(True);
        CallStackView.ViewData.Expand(True);
        ModulesDataSet.Clear;
        ModulesView.DataController.UpdateItems(True);
        ProcessesDataSet.Clear;
        ProcessesView.DataController.UpdateItems(True);
        AssemblerDataSet.Clear;
        AssemblerView.DataController.UpdateItems(True);
        CPUDataSet.Clear;
        CPUView.DataController.UpdateItems(True);
      end;
    except
      if (Created) then FreeAndNil(Log);
      if not (ExceptObject is EAbort) then Error('Wrong file format.');
    end;
  finally
    InternalChange := False;
  end;
  Screen.Cursor := crDefault;
end;

procedure TELViewerMainForm.ImportLog(FileName: string);
var
  TmpLog: TLogFile;
  n, NewItems, DupItems, Idx: Integer;
  Duplicated: Boolean;
  BugID, Item, FirstBugID, FirstDupBugID: string;
begin
  EnterCriticalSection(ImportLogCriticalSection);
  try
    if (ELViewerMainForm <> nil) then
    begin
      Application.Restore;
      Application.BringToFront;
    end;

    FileName := GetLongNameFromShort(FileName);
    if (not FileExists(FileName)) then
    begin
      Error(Format('File not found: "%s"', [FileName]));
      Exit;
    end;

    DupItems := 0;
    NewItems := 0;
    FirstBugID := '';
    FirstDupBugID := '';
    try
      TmpLog := TLogFile.Create(FileName, True);
      try
        for n := 0 to (TmpLog.Count - 1) do
        begin
          if (TmpLog.IsCoppuptedLog[n]) then
          begin
            Error('The Log number ' + IntToStr(n + 1) + ' is corrupted and will not be imported!');
            Continue;
          end;

          if (TmpLog.LogVersion[n] < '6.0') then
          begin
            BugID := (TmpLog.GetItemValue('2.2', n) + TmpLog.GetItemValue('2.3', n) +
              TmpLog.GetItemValue('2.4', n) + TmpLog.GetItemValue('2.5', n));
            BugID := IntToHex(GetCrc16(BugID), 4);
            TmpLog.SetItemValue('2.7', BugID, 'ID', n);
            TmpLog.SetItemValue('2.9', 'New', 'Status', n);
          end
          else BugID := TmpLog.GetItemValue('2.7', n);
          Duplicated := ((BugID <> '') and (Log.FindItem(['2.7'], [BugID]) <> -1));
          if (not Duplicated) then
          begin
            Item := TmpLog.Items[n];
            Item := Copy(Item, 1, Length(Item) - 7);
            Log.Append(Item, -1);
            Inc(NewItems);
            if (FirstBugID = '') then FirstBugID := BugID;
          end
          else
          begin
            Inc(DupItems);
            if (FirstDupBugID = '') then FirstDupBugID := BugID;
          end;
        end;
      finally
        TmpLog.Free;
      end;
      if (NewItems > 0) then
      begin
        Log.Save;
        LoadLog;
      end;
      if (FirstBugID = '') and (FirstDupBugID <> '') then FirstBugID := FirstDupBugID;
      if (FirstBugID <> '') then
      begin
        Idx := ListView.DataController.
          FindRecordIndexByText(0, Exception_ID.Index, FirstBugID, False, False, True);
        if (Idx <> -1) then ListView.DataController.FocusedRecordIndex := Idx;
      end;
      MessageBox(0, PChar(Format(
        'Log imported with success!'#13#10#13#10'File: %s'#13#10#13#10 +
        'New items: %d'#13#10'Duplicated items: %d',
        [ExtractFilename(FileName), NewItems, DupItems])),
        'Information', MB_OK or MB_ICONINFORMATION or MB_TASKMODAL);
    except
      if not (ExceptObject is EAbort) then Error('Wrong file format.');
    end;
  finally
    LeaveCriticalSection(ImportLogCriticalSection);
  end;
end;

procedure TELViewerMainForm.ExitBtnClick(Sender: TObject);
begin
  Close;
end;

procedure TELViewerMainForm.GeneralViewCustomDrawGroupCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableCellViewInfo; var ADone: Boolean);
var
  Idx: Integer;
begin
  ADone := True;
  if (not AViewInfo.Selected) then ACanvas.Font.Color := $800000;
  ACanvas.FillRect(AViewInfo.Bounds);
  Inc(AViewInfo.Bounds.Left, 18);
  Dec(AViewInfo.Bounds.Bottom, 4);
  ACanvas.Font.Style := (ACanvas.Font.Style + [fsBold]);
  Idx := Pos(' ', AViewInfo.Text);
  ACanvas.DrawText(Copy(AViewInfo.Text, Idx + 1, MaxInt),
    AViewInfo.Bounds, MyTextFlagsBottom);
  ACanvas.Font.Style := (ACanvas.Font.Style - [fsBold]);
  Dec(AViewInfo.Bounds.Left, 18);
  Inc(AViewInfo.Bounds.Bottom, 4);
end;

procedure TELViewerMainForm.ModulesViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var
  Ext: string;
  Top, ImgIdx: Integer;
begin
  if (AViewInfo.Item.Index = 0) then // Handle...
  begin
    ADone := True;
    Ext := UpperCase(Trim(ExtractFileExt(
      TcxGridViewData(Sender.ViewData).Rows[AViewInfo.GridRecord.Index].Values[1])));
    if (Ext = '.BPL') or (Ext = '.DPL') then ImgIdx := 1
    else
      if (Ext = '.EXE') then ImgIdx := 2
        else ImgIdx := 0;
    ACanvas.FillRect(AViewInfo.Bounds);
    Top := (AViewInfo.Bounds.Top + (AViewInfo.Bounds.Bottom - AViewInfo.Bounds.Top - 16) div 2);
    Images.Draw(ACanvas.Canvas, AViewInfo.Bounds.Left - 1, Top, ImgIdx);
    Inc(AViewInfo.Bounds.Left, 18);
    ACanvas.DrawText(AViewInfo.DisplayValue, AViewInfo.Bounds, MyTextFlagsCenter);
    Dec(AViewInfo.Bounds.Left, 18);
  end;
end;

procedure TELViewerMainForm.DropFiles(var msg: TMessage);
const
  cnMaxFileNameLen = 255;
var
  acFileName: array [0..cnMaxFileNameLen] of char;
  n, Count: Integer;
begin
  Count := DragQueryFile(msg.WParam, $FFFFFFFF, acFileName, cnMaxFileNameLen);
  for n := 0 to (Count - 1) do
  begin
    DragQueryFile(msg.WParam, n, acFileName, cnMaxFileNameLen);
    ImportLog(acFileName);
  end;
  DragFinish(msg.WParam);
end;

procedure TELViewerMainForm.AcceptFiles(var Msg: TMessage);
begin
  // ...
end;

function IsDelphiProcess(ProcID: DWord): Boolean;
type
  PRec = ^TRec;
  TRec = packed record
    ProcID: DWord;
    Found: Boolean;
  end;
var
  Rec: TRec;

  function GetWindowName(Wnd: THandle): string;
  var
    Buff: array[0..255] of Char;
    I: DWord;
  begin
    I := SizeOf(Buff);
    if GetClassName(Wnd, Buff, I) > 0 then
      Result := Buff
    else
      Result := '';
  end;

  function EnumWindowsProc(Wnd: THandle; Rec: PRec): Boolean; stdcall;
  var
    PID: DWord;
  begin
    GetWindowThreadProcessId(Wnd, @PID);
    if ((PID = Rec^.ProcID) and (GetWindowName(Wnd) = 'TAppBuilder')) then
    begin
      Rec^.Found := True;
      Result := False;
    end
    else
      Result := True;
  end;

begin
  Result := False;
  if (ProcID = 0) then Exit;
  
  Rec.ProcID := ProcID;
  Rec.Found := False;
  EnumWindows(@EnumWindowsProc, Integer(@Rec));
  Result := Rec.Found;
end;

procedure OpenIDEEditor(LineStr, UnitStr, ClassStr, ProcStr, OffsetStr: string;
  Compiled: TDateTime);
const
  TH32CS_SNAPPROCESS  = $00000002;
type
  TMailSlotMsg = packed record
    CompiledFile, UnitName, ClassName, ProcName: array[0..89] of Char;
    Line, Offset: DWord;
    Compiled: TDateTime;
  end;

  TProcessEntry32 = packed record
    dwSize: DWORD;
    cntUsage: DWORD;
    th32ProcessID: DWORD;       // this process
    th32DefaultHeapID: DWORD;
    th32ModuleID: DWORD;        // associated exe
    cntThreads: DWORD;
    th32ParentProcessID: DWORD; // this process's parent process
    pcPriClassBase: Longint;    // Base priority of process's threads
    dwFlags: DWORD;
    szExeFile: array[0..MAX_PATH - 1] of Char;// Path
  end;

  TCreateToolhelp32Snapshot =
    function (dwFlags, th32ProcessID: DWORD): THandle; stdcall;

  TProcess32First =
    function (hSnapshot: THandle; var lppe: TProcessEntry32): BOOL; stdcall;

  TProcess32Next =
    function (hSnapshot: THandle; var lppe: TProcessEntry32): BOOL; stdcall;

var
  MailSlotMsg: TMailSlotMsg;

  function GetParentProcessID: DWord;
  var
    SnapProcHandle: THandle;
    ProcEntry: TProcessEntry32;
    NextProc: Boolean;
    CreateToolhelp32Snapshot: TCreateToolhelp32Snapshot;
    Process32First: TProcess32First;
    Process32Next: TProcess32Next;
    KernelLib: THandle;
    CurrentPID: DWord;
  begin
    Result := 0;

    KernelLib := GetModuleHandle('Kernel32.dll');
    if (KernelLib <> 0) then
    begin
      @CreateToolhelp32Snapshot := GetProcAddress(KernelLib, 'CreateToolhelp32Snapshot');
      @Process32First := GetProcAddress(KernelLib, 'Process32First');
      @Process32Next := GetProcAddress(KernelLib, 'Process32Next');

      if (not Assigned(CreateToolhelp32Snapshot)) or
        (not Assigned(Process32First)) or (not Assigned(Process32Next)) then Exit;

      SnapProcHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
      if (SnapProcHandle <> INVALID_HANDLE_VALUE) then
      try
        CurrentPID := GetCurrentProcessId;
        ProcEntry.dwSize := SizeOf(ProcEntry);
        NextProc := Process32First(SnapProcHandle, ProcEntry);
        while NextProc do
        begin
          if (ProcEntry.th32ProcessID = CurrentPID) then
          begin
            Result := ProcEntry.th32ParentProcessID;
            Exit;
          end;
          NextProc := Process32Next(SnapProcHandle, ProcEntry);
        end;
      finally
        CloseHandle(SnapProcHandle);
      end;
    end;
  end;

  procedure MailSlotSend(const Name: string; Msg: TMailSlotMsg);
  var
    MailSlot: THandle;
    BytesWritten: DWord;
    ParentPID: DWord;
    AllowSetForegroundWindow: function(ProdID: DWord): BOOL stdcall;
  begin
    ParentPID := GetParentProcessID;
    if (not IsDelphiProcess(ParentPID)) then ParentPID := 0
    else
    begin // Allow Delphi to set the foreground window...
      @AllowSetForegroundWindow :=
        GetProcAddress(GetModuleHandle(user32), 'AllowSetForegroundWindow');
      if (Assigned(AllowSetForegroundWindow)) then
        AllowSetForegroundWindow(ParentPID);
    end;

    MailSlot := CreateFile(PChar('\\.\mailslot\' +
      Name + IntToStr(ParentPID)),
      GENERIC_WRITE, FILE_SHARE_READ, nil,
      OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
    if (MailSlot <> INVALID_HANDLE_VALUE) then
    begin
      WriteFile(MailSlot, Msg, SizeOf(Msg), BytesWritten, nil);
      CloseHandle(MailSlot);
    end;
  end;

begin
  if (LineStr <> '') then
  begin
    if (OffsetStr = '') then OffsetStr := '-1';
    StrPCopy(MailSlotMsg.CompiledFile, '');
    StrPCopy(MailSlotMsg.UnitName, UnitStr);
    StrPCopy(MailSlotMsg.ClassName, ClassStr);
    StrPCopy(MailSlotMsg.ProcName, ProcStr);
    MailSlotMsg.Offset := StrToInt(Trim(OffsetStr));
    MailSlotMsg.Line := StrToInt(Trim(LineStr));
    MailSlotMsg.Compiled := Compiled;
//    SetForegroundWindow(FindWindow('TAppBuilder', nil));
{$IFNDEF BUILD_FOR_DOTNET}
    MailSlotSend('EurekaLog', MailSlotMsg);
{$ELSE}
    MailSlotSend('EurekaLog4VS', MailSlotMsg);
{$ENDIF}
  end;
end;

procedure TELViewerMainForm.CallStackViewCellDblClick(
  Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
  AShift: TShiftState; var AHandled: Boolean);
var
  LineStr, UnitStr, ClassStr, ProcStr, OffsetStr: string;
  Index: Integer;
  Compiled: TDateTime;

  function GetColValue(Idx: Integer): Variant;
  begin
    Result := TcxGridViewData(Sender.ViewData).Rows[ACellViewInfo.GridRecord.Index].Values[Idx];
  end;

begin
  UnitStr := GetColValue(3);
  ClassStr := GetColValue(4);
  ProcStr := GetColValue(5);
  LineStr := GetColValue(6);
  OffsetStr := GetColValue(7);
  Index := ELViewerMainForm.ListView.DataController.FocusedRecordIndex;
  if (Index <> -1) then
    Compiled := (GetDateTime(Log.GetItemValue('1.5', Index)) - (GetGMT / 24))
  else
    Compiled := 0;
  OpenIDEEditor(LineStr, UnitStr, ClassStr, ProcStr, OffsetStr, Compiled);
end;

procedure TELViewerMainForm.XMLBtnClick(Sender: TObject);
begin
  if (SaveDialog.Execute) then
  begin
    Log.Password := PwdEdit.Text;
    Log.SaveXMLCopy(SaveDialog.FileName);
  end;
end;

procedure TELViewerMainForm.RefreshBtnClick(Sender: TObject);
begin
  LoadLog;
end;

procedure TELViewerMainForm.ListViewFocusedRecordChanged(
  Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord;
  ANewItemRecordFocusingChanged: Boolean);
begin
  if (not InternalChange) then Generate_Lists;
end;

procedure TELViewerMainForm.HelpBtnClick(Sender: TObject);
begin
  ShowHelp('EurekaLogViewer');
end;

procedure TELViewerMainForm.LoadState;
var
  Ini: TIniFile;
  ws, Idx: Integer;
  FileName: string;
begin
  FileName := (ExtractFilePath(ParamStr(0)) + IniFileName);
  if (not GetWorkingFile(FileName, True, False)) then Exit;

  Ini := TIniFile.Create(FileName);
  LoadingState := True;
  ELViewerMainForm.ListView.RestoreFromIniFile(FileName);
  try
    if Ini.ReadBool('Main', 'FirstUse', True) then Position := poScreenCenter
    else
    begin
      PwdEdit.Text := ini.ReadString('Main', 'Password', '');
      Left := Ini.ReadInteger('Main', 'Left', Left);
      Top := Ini.ReadInteger('Main', 'Top', Top);
      Width := Ini.ReadInteger('Main', 'Width', Width);
      Height := Ini.ReadInteger('Main', 'Height', Height);
      GridList.Height := Ini.ReadInteger('Main',
        'Exceptions_List_Height', GridList.Height);
      CurrentBugID := Ini.ReadString('Main', 'CurrentBugID', CurrentBugID);
      ws := Ini.ReadInteger('Main', 'WindowState', 0);
      case ws of
        0: WindowState := wsNormal;
        1: WindowState := wsMaximized;
      else
        WindowState := wsNormal;
      end;
      TabContainer.ActivePageIndex :=
        Ini.ReadInteger('Main', 'PageIndex', TabContainer.ActivePageIndex);

      Idx := ListView.DataController.
        FindRecordIndexByText(0, Exception_ID.Index, CurrentBugID, False, False, True);
      if (Idx <> -1) then ListView.DataController.FocusedRecordIndex := Idx;
    end;
  finally
    LoadingState := False;
    Ini.Free;
  end;
end;

procedure TELViewerMainForm.SaveState;
var
  Ini: TIniFile;
  ws: Integer;
  FileName: string;

  function GetDialogState: Cardinal;
  var
    Placement: TWindowPlacement;
  begin
    Placement.length := SizeOf(TWindowPlacement);
    GetWindowPlacement(Handle, @Placement);
    Result := Placement.showCmd;
  end;

begin
  if ((LoadingState) or (ELViewerMainForm = nil)) then Exit;

  FileName := (ExtractFilePath(ParamStr(0)) + IniFileName);
  if (not GetWorkingFile(FileName, True, False)) then Exit;

  ELViewerMainForm.ListView.StoreToIniFile(FileName,
    False, [gsoUseFilter, gsoUseSummary], '');
  Ini := TIniFile.Create(FileName);
  try
    if (GetDialogState <> SW_MAXIMIZE) then
    begin
      Ini.WriteInteger('Main', 'Left', Left);
      Ini.WriteInteger('Main', 'Top', Top);
      Ini.WriteInteger('Main', 'Width', Width);
      Ini.WriteInteger('Main', 'Height', Height);
    end;
    case WindowState of
      wsNormal: ws := 0;
      wsMaximized: ws := 1;
    else
      ws := 0;
    end;
    Ini.WriteString('Main', 'Password', PwdEdit.Text);
    Ini.WriteBool('Main', 'FirstUse', False);
    Ini.WriteInteger('Main', 'WindowState', ws);
    Ini.WriteInteger('Main', 'PageIndex', TabContainer.ActivePageIndex);
    Ini.WriteInteger('Main', 'Exceptions_List_Height', GridList.Height);
    Ini.WriteString('Main', 'CurrentBugID', CurrentBugID);
  finally
    Ini.Free;
  end;
end;

procedure TELViewerMainForm.FormResize(Sender: TObject);
begin
  SaveState;
end;

procedure TELViewerMainForm.FormMove(var Msg: TMessage);
begin
  SaveState;
end;

procedure TELViewerMainForm.PwdEditKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_RETURN) and (RefreshBtn.Enabled) then RefreshBtnClick(nil);
end;

procedure TELViewerMainForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #27) then Close;
end;

procedure TELViewerMainForm.PrnBtnClick(Sender: TObject);
var
  curRepLink : TdxGridReportLink;
  curSectionName : string;
begin
  curRepLink := nil;
  
  if (TabContainer.ActivePage = cxTabSheet1) then
  begin
    curRepLink := EL_Print_CallStack;
    curSectionName := 'Call Stack';
  end
  else
    if (TabContainer.ActivePage = cxTabSheet2) then
    begin
      curRepLink := EL_Print_General;
      curSectionName := 'General';
    end
    else
      if (TabContainer.ActivePage = cxTabSheet3) then
      begin
        curRepLink := EL_Print_Modules;
        curSectionName := 'Modules';
      end
      else
        if (TabContainer.ActivePage = cxTabSheet5) then
        begin
          curRepLink := EL_Print_Processes;
          curSectionName := 'Processes';
        end
          else
            if (TabContainer.ActivePage = cxTabSheet6) then
            begin
              curRepLink := EL_Print_Assembler;
              curSectionName := 'Assembler';
            end
            else
              if (TabContainer.ActivePage = cxTabSheet4) Then
              begin
                curRepLink := EL_Print_CPU;
                curSectionName := 'CPU';
              end;

  if (curRepLink = nil) then Exit;

  curRepLink.PrinterPage.PageHeader.CenterTitle.Text   :=
    Format('ID = %s; Status = %s; Note = %s; Date = %s; Type = %s; Message = %s',
    [VarToStr(Exception_ID.EditValue), VarToStr(Exception_Status.EditValue),
    VarToStr(Exception_Note.EditValue), VarToStr(Exception_Date.EditValue),
    VarToStr(Exception_Type.EditValue), VarToStr(Exception_Message.EditValue)]);

  curRepLink.ReportTitle.Text       := curSectionName;
  curRepLink.ReportTitle.Font.Name  := 'Arial';
  curRepLink.ReportTitle.Font.Size  := 9;
  curRepLink.ReportTitle.Font.Style := [fsBold];

  EL_Print.Preview(True, curRepLink);
end;

procedure TELViewerMainForm.EL_Print_CallStackCustomDrawCell(
  Sender: TdxGridReportLink; ACanvas: TCanvas;
  AView: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AColumn: TcxGridColumn; AnItem: TAbstractdxReportCellData;
  var ADone: Boolean);
var
  Txt: string;
  Rc: TRect;
begin
  if (AColumn.Index = 0) then
  begin
    if (ARecord.ValueCount > 0) then Txt := Copy(ARecord.Values[0], 6, MaxInt)
    else Txt := '';
    Rc := AnItem.GetInnerBounds(ACanvas.Handle);
    ACanvas.TextOut(1000, 900, Txt);
    ADone := True;
  end;
end;

procedure TELViewerMainForm.ListViewDataControllerAfterPost(
  ADataController: TcxCustomDataController);
var
  LogIdx: Integer;
begin
  LogIdx := ADataController.FocusedRecordIndex;
  Log.SetItemValue('2.9', VarToStr(Exception_Status.EditValue), 'Status', LogIdx);
  Log.SetItemValue('2.10', VarToStr(Exception_Note.EditValue), 'Note', LogIdx);
  Log.Save;
end;

procedure TELViewerMainForm.ListViewDataControllerDataChanged(Sender: TObject);
var
  State: Boolean;
begin
  State := ((Log <> nil) and (Log.Count > 0));
  DelBtn.Enabled := State;
  ClearBtn.Enabled := State;
  XMLBtn.Enabled := State;
  PrnBtn.Enabled := State;
  RefreshBtn.Enabled := State;
end;

procedure TELViewerMainForm.DelBtnClick(Sender: TObject);
var
  Index, Row: Integer;
begin
  DelBtn.Enabled := False;
  try
    Index := ELViewerMainForm.ListView.DataController.FocusedRecordIndex;
    if (Index = -1) then Exit;

    Row := ELViewerMainForm.ListView.DataController.FocusedRowIndex;
    if (Row = -1) then Exit;

    Log.DeleteItem(Index);
    Log.Save;
    LoadLog;

    ELViewerMainForm.ListView.DataController.FocusedRowIndex := Row;
  finally
    DelBtn.Enabled := ((Log <> nil) and (Log.Count > 0));
  end;
end;

procedure TELViewerMainForm.ClearBtnClick(Sender: TObject);
begin
  if (MessageBox(0, 'Are you sure you want to delete all records in the Exceptions Database?',
    'Question', MB_YESNO or MB_DEFBUTTON2 or MB_ICONQUESTION or MB_TASKMODAL) = ID_YES) then
  begin
    Log.Clear;
    Log.Save;
    LoadLog;
  end;
end;

initialization
  InitializeCriticalSection(ImportLogCriticalSection);

finalization
  DeleteCriticalSection(ImportLogCriticalSection);

end.
