{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2001                    BBBBB   }

unit dm0140;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ppDB, ppCache, ppDBJIT, StdCtrls, ppComm, ppRelatv, ppProd, ppClass,
  ppReport, dmUtil, ppCtrls, ppPrnabl, ppBands, ppStrtch, ppMemo,
  ppVar;

type
  TmyStructureRecord = Record
    Name : String[32];
    StructType : String[8];
    CircuitName : String[16];
    CircuitNumber : Integer;
    Elevation : Double;
    NumberofInsulators : Integer;
    NumberofHotInsulators : Integer;
    Inspected : Boolean;
  end;

  Tfrm0140 = class(TdmCustomForm)
    ppReport1: TppReport;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    JITPipe: TppJITPipeline;
    ppJITPipeline1ppField1: TppField;
    ppJITPipeline1ppField2: TppField;
    ppJITPipeline1ppField3: TppField;
    ppJITPipeline1ppField4: TppField;
    ppJITPipeline1ppField5: TppField;
    ppJITPipeline1ppField6: TppField;
    ppJITPipeline1ppField7: TppField;
    ppJITPipeline1ppField8: TppField;
    ppHeaderBand1: TppHeaderBand;
    ppDetailBand1: TppDetailBand;
    ppFooterBand1: TppFooterBand;
    ppGroup1: TppGroup;
    ppGroupHeaderBand1: TppGroupHeaderBand;
    ppGroupFooterBand1: TppGroupFooterBand;
    ppShape1: TppShape;
    ppDBText1: TppDBText;
    ppLabel1: TppLabel;
    ppDBText2: TppDBText;
    ppShape2: TppShape;
    ppLabel2: TppLabel;
    ppShape3: TppShape;
    ppLabel3: TppLabel;
    ppDBText3: TppDBText;
    ppLabel4: TppLabel;
    ppDBText4: TppDBText;
    ppLabel5: TppLabel;
    ppDBText5: TppDBText;
    ppLabel6: TppLabel;
    ppDBText6: TppDBText;
    ppLabel7: TppLabel;
    ppLabel8: TppLabel;
    ppDBText8: TppDBText;
    ppLine1: TppLine;
    ppTitleBand1: TppTitleBand;
    ppMemo1: TppMemo;
    ppLabel9: TppLabel;
    ppLabel10: TppLabel;
    ppLabel11: TppLabel;
    ppSystemVariable1: TppSystemVariable;
    ppSystemVariable2: TppSystemVariable;
    ppLabel12: TppLabel;
    ppDBText7: TppDBText;
    function JITPipeGetDataSetName: String;
    function JITPipeGetFieldAsString(aFieldName: String): String;
    function JITPipeGetFieldValue(aFieldName: String): Variant;
    procedure FormCreate(Sender: TObject);
    procedure ppGroupHeaderBand1BeforePrint(Sender: TObject);
  private
    FRec : TmyStructureRecord;
    TheFile : File of TmyStructureRecord;
    function GetFieldValue(const aFieldName: String): Variant;
  protected
    function GetReport: TppProducer; override;
  public
    { Public declarations }
  end;

var
  frm0140: Tfrm0140;

implementation

{$R *.DFM}

function Tfrm0140.GetFieldValue(const aFieldName: String): Variant;
var
  lsFieldName: String;
begin
  Seek(TheFile, JITPipe.RecordIndex);
  Read(TheFile, FRec);

  lsFieldName := Uppercase(aFieldName);

  if (lsFieldName = 'NAME') then
    Result := FRec.Name
  else if (lsFieldName = 'STRUCTTYPE') then
    Result := FRec.StructType
  else if (lsFieldName = 'CIRCUITNAME') then
    Result := FRec.CircuitName
  else if (lsFieldName = 'CIRCUITNUMBER') then
    Result := FRec.CircuitNumber
  else if (lsFieldName = 'ELEVATION') then
    Result := FRec.Elevation
  else if (lsFieldName = 'NUMBEROFINSULATORS') then
    Result := FRec.NumberofInsulators
  else if (lsFieldName = 'NUMBEROFHOTINSULATORS') then
    Result := FRec.NumberofHotInsulators
  else if (lsFieldName = 'INSPECTED') then
    Result := FRec.Inspected
  else
    Result := '';
end;

function Tfrm0140.GetReport: TppProducer;
begin
  Result := ppReport1;
end;

function Tfrm0140.JITPipeGetDataSetName: String;
begin
  Result := 'Structures';
end;

function Tfrm0140.JITPipeGetFieldAsString(aFieldName: String): String;
begin
  Result := String(GetFieldValue(aFieldName));
end;

function Tfrm0140.JITPipeGetFieldValue(aFieldName: String): Variant;
begin
  Result := GetFieldValue(aFieldName);
end;

procedure Tfrm0140.FormCreate(Sender: TObject);
var
  lsCurrentDir: String;

begin

  lsCurrentDir := ExtractFilePath(ParamStr(0));
  AssignFile(TheFile, lsCurrentDir + 'TypedFile.typ');
  FileMode := 2;
  Try
    Reset(TheFile);
    JITPipe.RecordCount := FileSize(TheFile);
  except
    on EInOutError do
      begin
        raise Exception.Create('Unable to open typed file for report.');
        close;
      end;
  end;

end;

procedure Tfrm0140.ppGroupHeaderBand1BeforePrint(Sender: TObject);
begin
  if (not ppReport1.Groups[0].FirstPage) then
    ppLabel12.Visible := True
  else
    ppLabel12.Visible := False;
end;

end.
