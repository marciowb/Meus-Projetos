unit UCheckTemplate;
{$IFDEF LINUX}{$INCLUDE ../FLXCOMPILER.INC}{$ELSE}{$INCLUDE ..\FLXCOMPILER.INC}{$ENDIF}
{$IFDEF LINUX}{$INCLUDE ../FLXCONFIG.INC}{$ELSE}{$INCLUDE ..\FLXCONFIG.INC}{$ENDIF}

interface

  {$IFDEF FLX_CANDISABLEWARNINGS}  //Delphi 6 or above
    {$WARN UNIT_PLATFORM OFF}
  {$ENDIF}

uses
  SysUtils, Classes,
  {$IFDEF FLX_VCL}
  Forms, Dialogs, StdCtrls, ActnList, ImgList, ComCtrls, FileCtrl, ExtCtrls, Controls,
  {$ENDIF}
  {$IFDEF FLX_CLX}
  QForms, QDialogs, QStdCtrls, QActnList, QImgList, QComCtrls, QExtCtrls, QControls,
  {$ENDIF}
  TemplateStore, UFlxMessages, ToolWin, XLSAdapter, XlsMessages,
  {$IFDEF FLX_NEEDSTYPES}
    Types,
  {$ENDIF}
  {$IFDEF FLX_EXTRAWINDOWS}
    Windows,
  {$ENDIF}
  {$IFDEF FLX_FPC}
    LResources,
  {$ENDIF}

  UExcelAdapter, UXlsDB, UCustomFlexCelReport;

type
  TCheckTemplate = class(TForm)
    ImageList1: TImageList;
    ImageList2: TImageList;
    ImageList3: TImageList;
    ActionList1: TActionList;
    ActionClose: TAction;
    Panel1: TPanel;
    FormCaption: TPanel;
    ToolBar1: TToolBar;
    btnCancel: TToolButton;
    MemoLog: TMemo;
    procedure ActionCloseExecute(Sender: TObject);
  private
    procedure Check(const FlxReport: TCustomFlexCelReport;const CheckTStore: boolean; const aFileName: string);
    procedure AddHeader(const aReportName, aFileName: string);
    procedure DoError(const s1: string; const Args: array of const);
    { Private declarations }
  public
    { Public declarations }
  end;

  procedure InvokeCheckTemplate(const FlxReport: TCustomFlexCelReport; const aCheckTemplate: TCheckTemplate; const CheckTStore: boolean; const FileName, ProjName: string);

implementation

{$IFNDEF FLX_FPC}
  {$IFDEF FLX_VCL}
    {$R *.dfm}
  {$ENDIF}
  {$IFDEF FLX_CLX}
    {$R *.xfm}
  {$ENDIF}
{$ENDIF}

procedure InvokeCheckTemplate(const FlxReport: TCustomFlexCelReport; const aCheckTemplate: TCheckTemplate; const CheckTStore: boolean; const FileName, ProjName: string);
var
  FName: TFileName;
  OldCursor: TCursor;
  CheckTemplate: TCheckTemplate;
begin
  if FlxReport.Adapter=nil then raise Exception.Create(ErrNoAdapter);
  try
    OldCursor:=Screen.Cursor;
    Screen.Cursor:=crHourGlass;
    try
      if aCheckTemplate=nil then CheckTemplate:= TCheckTemplate.Create(nil) else CheckTemplate:=aCheckTemplate;
      try
        CheckTemplate.AddHeader(FlxReport.Name, FlxReport.Template);
        try
          if (FlxReport.Adapter is TXLSAdapter) and
           (FlxReport.Adapter<>nil) and ((FlxReport.Adapter as TXLSAdapter).TemplateStore<>nil)
           then FName := FileName
         else
           begin
             FName := IncludeTrailingPathDelimiter(ExtractFilePath(ProjName)) + FileName;
             if not FileExists(FName) then
               FName:=SearchPathStr(FlxReport.Adapter.BasePathToOpen, FileName);
           end;
        except
          on e:Exception do
            raise Exception.CreateFmt (ErrNoTemplate, [e.Message, ProjName]);
        end; //except

        CheckTemplate.Check(FlxReport, CheckTStore, FName);
        if aCheckTemplate=nil then CheckTemplate.ShowModal;
      finally
        if aCheckTemplate=nil then FreeAndNil(CheckTemplate);
      end;
    finally
      Screen.Cursor:=OldCursor;
    end; //finally
  except
    on e: Exception do if aCheckTemplate=nil then raise else aCheckTemplate.MemoLog.Lines.Add(e.Message);
  end; //except
end;

procedure TCheckTemplate.ActionCloseExecute(Sender: TObject);
begin
  ModalResult:=mrOk;
end;

procedure TCheckTemplate.AddHeader(const aReportName, aFileName: string);
begin
  MemoLog.Lines.Add('');
  MemoLog.Lines.Add(TxtSepLog);
  MemoLog.Lines.Add(Format(TxtCheckHeader, [aReportName, aFileName]));
  MemoLog.Lines.Add(TxtSepLog);
end;

procedure TCheckTemplate.DoError(const s1: string; const Args: array of const);
begin
  MemoLog.Lines.Add('   '+Format(s1, Args));
end;


function ExtractStr(const s, Delim: WideString; const Position: integer):WideString;
var
  i: integer;
begin
  Result:=s;
  for i:=1 to Position do Result:=copy(Result,pos(Delim, Result+Delim)+2,Length(Result));
  Result:=copy(Result,1,pos(Delim, Result+Delim)-1);
end;

function Is__Range__(const s: string):boolean;
begin
  Result:=(copy(s,1,Length(DataSetStr))=DataSetStr) and(copy(s,Length(s)-Length(DataSetStr)+1,Length(DataSetStr))=DataSetStr);
end;

procedure TCheckTemplate.Check(const FlxReport: TCustomFlexCelReport;
  const CheckTStore: boolean; const aFileName: string);
var
  Wb: TXlsAdapter;
  Workbook: TExcelFile;
  i, k, Row, Col: integer;
  s, s2: WideString;
  DS: TComponent;
  DSx: IXlsDataSet;
  InRange: boolean;
begin
  //Check File on disk is same time than TemplateStore
  if CheckTStore then
    if (FlxReport.Adapter is TXLSAdapter) and
       (FlxReport.Adapter<>nil) and ((FlxReport.Adapter as TXLSAdapter).TemplateStore<>nil) and
      not ((FlxReport.Adapter as TXLSAdapter).TemplateStore).IsUpToDate then
        DoError(ErrTemplateNotRefreshed,[(FlxReport.Adapter as TXLSAdapter).TemplateStore.Name]);

  if FlxReport.Adapter is TXLSAdapter then Wb := FlxReport.Adapter as TXlsAdapter else Wb := TXlsAdapter.Create(nil);
  try
    Workbook:=Wb.GetWorkbook;
    try
      Workbook.Connect;
      try
        Workbook.OpenFileAndSearch(aFileName);
        try
          //Check there is a __Main__ range
          for k:=1 to Workbook.RangeCount do
          begin
            s:=Workbook.RangeName[k];
            if copy(s,1, Length(DataSetStr))=DataSetStr then
            begin
              //Check range ends with DataSetStr
              if copy(s,Length(s)-Length(DataSetStr)+1,Length(DataSetStr))<>DataSetStr then
              begin
                DoError(ErrInvalidRangeName, [s]);
                continue;
              end;
              //Made: see __xx__yy__
              //Check it is a "__Mainxx__" range or a "__DataSet__" range for existing datasets
              i:=1;
              s2:=ExtractStr(s, DataSetStr, i);
              while s2<>'' do
              begin
                if (Uppercase(copy(s2,1,Length(MainTxt)))<>UpperCase(MainTxt)) and
                  (FlxReport.DesignDataModule.FindComponent(s2)=nil) then
                  begin
                    DoError(ErrRangeNameNotFound, [s2,s]);
                  end;
                //Check the component is a tdataset or corresponding
                if (FlxReport.DesignDataModule.FindComponent(s2)<>nil) and (FlxReport.GetDataSet(s2)=nil) then
                begin
                  DoError(ErrRangeNameInvalidType, [s2,s]);
                end;

                inc(i);
                s2:=ExtractStr(s, DataSetStr, i);
                if i>100 then break; //Just a safety check...
              end; //while
            end;
          end;   //Finish Checking Ranges

          for i:=1 to Workbook.SheetCount do
            if Workbook.IsWorksheet(i) then
            begin
              Workbook.ActiveSheet:=i;

              //Check Images
              for k:=0 to Workbook.PicturesCount[-1]-1 do
              begin
                s:= Workbook.PictureName[-1, k];
                s2:=ExtractStr(s, FieldStr, 1);
                if s2<>'' then
                begin
                  DSx:= FlxReport.GetDataSet(s2);
                  if DSx=nil then
                  begin
                    DoError(ErrInvalidImageDB, [Workbook.ActiveSheet, s]);
                    continue;
                  end;
                  //Check for Field
                  if (DSx.FieldCount>0) then  //If there are no persistent fields, we can't check
                  try
                    DSx.FieldByName(ExtractStr(s, FieldStr, 2));
                  except
                    on e:exception do
                    begin
                      DoError(ErrInvalidImageField, [Workbook.ActiveSheet, s]);
                      continue;
                    end;
                  end; //except
                  try
                    FlxReport.GetPictureType(s);
                  except
                    on e:exception do
                    begin
                      DoError(ErrInvalidImageType, [Workbook.ActiveSheet, s, ExtractStr(s, FieldStr, 3)]);
                      continue;
                    end;
                  end; //except

                end;
              end;

              for Row:=1 to Workbook.MaxRow do
              begin
                for Col:=1 to Workbook.MaxCol do
                begin
                  //Check there are not ##dataset##field mispells
                  s:= Workbook.CellValue[Row, Col];
                  if copy(s, 1, Length(FieldStr))=FieldStr then
                  begin
                    s2:=ExtractStr(s, FieldStr, 1);
                    DS:= FlxReport.DesignDataModule.FindComponent(s2);
                    if DS=nil then
                    begin
                      DoError(ErrInvalidCellDB, [Row, Col, Workbook.ActiveSheet, s]);
                      continue;
                    end;
                    DSx:= FlxReport.GetDataSet(s2);
                    if DSx=nil then
                    begin
                      DoError(ErrInvalidCellDB2, [Row, Col, Workbook.ActiveSheet, s]);
                      continue;
                    end;
                    //Check for Field
                    if (DSx.FieldCount>0)and (ExtractStr(s, FieldStr, 2)<>FullDataSetStr) then  //If there are no persistent fields, we can't check
                    try
                      DSx.FieldByName(ExtractStr(s, FieldStr, 2));
                    except
                      on e:exception do
                      begin
                        DoError(ErrInvalidField, [Row, Col, Workbook.ActiveSheet, s]);
                        continue;
                      end;
                    end; //except
                  end;

                  //Check that no ##dataset##field is out of a range
                  InRange:=(ExtractStr(s, FieldStr, 1)='') and (ExtractStr(s, VarStr, 1)='')
                           and (ExtractStr(s, ExtrasDelim, 1)='');
                  if not InRange then
                    for k:=1 to Workbook.RangeCount do
                      if (Workbook.RangeSheet[k]=Workbook.ActiveSheet)and
                      Is__Range__(Workbook.RangeName[k]) and
                      PtInRect(Rect(Workbook.RangeR1[k],Workbook.RangeC1[k],Workbook.RangeR2[k]+1,Workbook.RangeC2[k]+1),Point(Row, Col)) then
                      begin
                        InRange:=true;
                        break;
                      end;

                  if not InRange then
                  begin
                    DoError(ErrFieldOutsideRange, [Row, Col, Workbook.ActiveSheet, s]);
                    continue;
                  end;

                  //Check for false "..."
                  if (Length(s)>0) and ((s[1]=UTF16Char($2026))or(s[Length(s)]=UTF16Char($2026))) then
                  begin
                    DoError(ErrCheckCellDots,[Row, Col, Workbook.ActiveSheet, s]);
                    continue;
                  end;
                  //Check that ...commands... are on first column
                  if (ExtractStr(s, ExtrasDelim, 1)<>'')and (Col<>1) then
                  begin
                    DoError(ErrCheckDotCommandsCol,[Row, Col, Workbook.ActiveSheet, s]);
                    continue;
                  end;

                end;
              end;
            end; //For each page

           //Check for PagesDataSet and PagesDataSetField
           DSx:= FlxReport.GetPagesDataSet;
           if (DSx<>nil) and (DSx.FieldCount>0) then
           try
             DSx.FieldByName(FlxReport.PagesDataField);
           except
             on e:exception do
             begin
               DoError(ErrInvalidPagesField, [FlxReport.PagesDataField, DSx.DsName]);
             end;
           end; //except

        except
          Workbook.CloseFile;
          raise;
        end; //Except

        //If there was an exception the workbook has already been closed, so we dont have to protect this
        try
          Workbook.CloseFile;  //This wont quit excel, but when the app finishes it will quit too.
        except
          //nothing
        end; //Except

      finally
        Workbook.Disconnect;
      end; //finally
    finally
      FreeAndNil(Workbook);
    end; //finally

    MemoLog.Lines.Add(TxtOK);
  finally
    if not(FlxReport.Adapter is TXLSAdapter) then FreeAndNil(Wb);
  end; //finally
end;

{$IFDEF FLX_FPC}
initialization
{$I UCheckTemplate.lrs}
{$ENDIF}

end.
