{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2010                    BBBBB   }

unit ppStructuredStorage;

interface

uses
  Windows,
  SysUtils,
  Classes,
  ComObj,
  ActiveX,

  ppTypes;

type

  TAccessMode = (amRead, amWrite, amReadWrite);
  TShareMode = (smExclusive, smDenyWrite, smDenyRead, smDenyNone);
  TTransactMode = (tmDirect, tmTransacted);

  EStructuredStorageError = class(EReportBuilderError);

  {TppStructuredStorage
    - Structure storage document }
  TppStructuredStorage = class
  private
    FHResult: HResult;
    FIStorage: IStorage;
    FName: string;

  protected
    procedure CheckError(aMsg: string);

  public
    constructor Create(aName: string; aAccessMode: TAccessMode; aShareMode: TShareMode; aTransactMode: TTransactMode; aCreateNew: Boolean);
    destructor Destroy; override;
  end;

  {TppStructuredStorageStream }
  TppStructuredStorageStream = class(TStream)
  private
    FHResult: HResult;
    FIStream: IStream;
    FName: string;
    FParent: TppStructuredStorage;

  protected
    procedure CheckError(aMsg: string);
    procedure SetSize(aNewSize: Longint); override;

  public

    constructor Create(aName: string; aParentStorage: TppStructuredStorage; aAccessMode: TAccessMode; aCreateNew: Boolean); virtual;

    destructor Destroy; override;
    function Read(var Buffer; Count: Longint): Longint; override;
    function Seek(Offset: Longint; Origin: Word): Longint; override;
    function Write(const Buffer; Count: Longint): Longint; override;

  end;


  TppDocSummaryInfo = class;

  {TppPropertyStorage}
  TppPropertyStorage = class
  private
    FIPropertySetStorage: IPropertySetStorage;

  protected
    property PropertySetStorage: IPropertySetStorage read FIPropertySetStorage;

  public
    constructor Create(aParentStorage: TppStructuredStorage); virtual;

  end;

  {TppDocumentSummaryStorage}
  TppDocumentSummaryStorage = class(TppPropertyStorage)
  private
    FDocSummaryInfo: TppDocSummaryInfo;
  public

    constructor Create(aParentStorage: TppStructuredStorage); override;

    destructor Destroy; override;

    procedure Write;

    property DocSummaryInfo: TppDocSummaryInfo read FDocSummaryInfo;

  end;


  {TppDocSummaryInfo}
  TppDocSummaryInfo = class
  private
    FAppName: WideString;
    FAuthor: WideString;
    FCreated: TDateTime;
    FLastSaveBy: WideString;
    FLastSaved: TDateTime;
    FSecurity: Integer;
    FSubject: WideString;
//    FThumbnail: TGraphic;
    FTitle: WideString;

  public

    constructor Create; virtual;

    property AppName: WideString read FAppName write FAppName;
    property Author: WideString read FAuthor write FAuthor;
    property Created: TDateTime read FCreated write FCreated;
    property LastSaveBy: WideString read FLastSaveBy write FLastSaveBy;
    property LastSaved: TDateTime read FLastSaved write FLastSaved;
    property Security: Integer read FSecurity write FSecurity;
    property Subject: WideString read FSubject write FSubject;
//    property Thumbnail: TGraphic read FThumbnail write FThumbnail;
    property Title: WideString read FTitle write FTitle;

  end;

  function ppDateTimeToFileTime(aDateTime: TDateTime): TFileTime;


implementation

const
  S_OK = HResult(0);
  E_Fail = HResult($80004005);


function ppDateTimeToFileTime(aDateTime: TDateTime): TFileTime;
var
  lSystemTime: TSystemTime;
  lFileTime: TFileTime;
begin

  DateTimeToSystemTime(aDateTime, lSystemTime);
  SystemTimeToFileTime(lSystemTime, lFileTime);

  Result := lFileTime;

end;


function GetMode(Accessmode: TAccessMode; ShareMode: TShareMode; TransactMode: TTransactMode; CreateNew: Boolean): Longint;
begin

  Result := ord(AccessMode) or (succ(Ord(ShareMode)) shl 4) or (Ord(TransactMode) shl 16);

  if CreateNew then
    Result := Result or STGM_CREATE;

end;


constructor TppStructuredStorage.Create(aName: string; aAccessMode: TAccessMode; aShareMode: TShareMode; aTransactMode: TTransactMode; aCreateNew: Boolean);
var
  Mode: Longint;
  PName: PWideChar;
  lsName: WideString;
begin
  Mode := GetMode(aAccessMode, aShareMode, aTransactMode, aCreateNew);

  lsName := aName;

  if aCreateNew then
    begin
      if (aName = '') then
        begin
          PName := nil;
          Mode := Mode or STGM_DELETEONRELEASE;
        end
        else
        begin
          PName := PWideChar(lsName);
        end;

      FHResult := StgCreateDocFile(PName, Mode, 0, FIStorage);

      CheckError('root storage create failed');

      FName := aName;

    end
  else
    begin

      if aName = '' then
        begin
          PName := nil;
          FHResult := E_FAIL;
        end
        else
        begin
          PName := PWideChar(lsName);
          FHResult := S_OK;
        end;

      CheckError('no storage aName given');

      FHResult := StgIsStorageFile(PName);

      CheckError('not a storage file');
      FHResult := StgOpenStorage(PName, nil, Mode, nil, 0, FIStorage);
      CheckError('root storage open failed');
      FName := aName;
    end;
end;

destructor TppStructuredStorage.Destroy;
begin

  FIStorage := nil;

  inherited Destroy;

end;

procedure TppStructuredStorage.CheckError(aMsg: string);
begin

  if (FHResult <> S_OK) then
    begin
      aMsg := aMsg + ': ' + SysErrorMessage(FHResult);
      raise EStructuredStorageError.Create(aMsg);
    end;

end;


constructor TppStructuredStorageStream.Create(aName: string; aParentStorage: TppStructuredStorage; aAccessMode: TAccessMode; aCreateNew: Boolean);
var
  Mode: Longint;
  PName: PWideChar;
  lsName: WideString;
begin

  Mode := GetMode(aAccessMode, smExclusive, tmDirect, aCreateNew);

  lsName := aName;

  if aCreateNew then
    begin
      if aName = '' then
      begin
        PName := nil;
        Mode := Mode or STGM_DELETEONRELEASE;
      end
      else
        PName := PWideChar(lsName);

      FHResult := aParentStorage.FIStorage.CreateStream(PName, Mode, 0, 0, FIStream);
      CheckError('stream create failed');

      FName := aName;
      FParent := aParentStorage;
    end
  else
  begin
    if aName = '' then
      begin
        PName := nil;
        FHResult := E_FAIL;
      end
    else
      begin
        PName := PWideChar(lsName);
        FHResult := S_OK;
      end;
    CheckError('no stream aName given');
    FHResult := aParentStorage.FIStorage.OpenStream(PName, nil, Mode, 0, FIStream);
    FName := aName;
    FParent := aParentStorage;
  end;

end;

destructor TppStructuredStorageStream.Destroy;
begin

  FParent := nil;
  FIStream := nil;

  inherited Destroy;

end;

procedure TppStructuredStorageStream.CheckError(aMsg: string);
begin

  if (FHResult <> S_OK) then
    begin
      aMsg := aMsg + ': ' + SysErrorMessage(FHResult);
      raise EStructuredStorageError.Create(aMsg);
    end;
  
end;

function TppStructuredStorageStream.Read(var Buffer; Count: Longint): Longint;
var
  lCount: Longint;
begin
  lCount := 0;

  FHResult := FIStream.Read(@Buffer, Count, @lCount);

  if not Failed(FHResult) then
    Result := lCount
  else
    Result := 0;

end;

function TppStructuredStorageStream.Seek(Offset: Longint; Origin: Word): Longint;
var
  liNewPos: Int64;
begin

  FHResult := FIStream.Seek(Offset, Origin,liNewPos);

  if not Failed(FHResult) then
    Result := liNewPos
  else
    Result := -1;

end;

procedure TppStructuredStorageStream.SetSize(aNewSize: Longint);
begin
  FHResult := FIStream.SetSize(aNewSize);
end;

function TppStructuredStorageStream.Write(const Buffer; Count: Longint):
    Longint;
var
  lCount: Longint;
begin
  lCount := 0;

  FHResult := FIStream.Write(@Buffer, Count, @lCount);

  if not Failed(FHResult) then
    Result := lCount
  else
    Result := 0;
end;

constructor TppPropertyStorage.Create(aParentStorage: TppStructuredStorage);
begin

  FIPropertySetStorage := (aParentStorage.FIStorage as IPropertySetStorage);

end;


constructor TppDocSummaryInfo.Create;
begin

  inherited;

  FAppName := 'ReportBuilder';
  FAuthor := 'ReportBuilder';
  FCreated := Now;
  FLastSaveBy := 'ReportBuilder';
  FLastSaved := FCreated;
  FSubject := 'Report';
  FTitle := 'Report';

end;

constructor TppDocumentSummaryStorage.Create(aParentStorage: TppStructuredStorage);
begin

  inherited Create(aParentStorage);

  FDocSummaryInfo := TppDocSummaryInfo.Create;

end;

destructor TppDocumentSummaryStorage.Destroy;
begin

  FDocSummaryInfo.Free;
  FDocSummaryInfo := nil;

  inherited;

end;

procedure TppDocumentSummaryStorage.Write;
const
  FmtID_SummaryInformation: TGUID = '{F29F85E0-4FF9-1068-AB91-08002B27B3D9}';
  FmtID_DocumentSummaryInformation: TGUID = '{D5CDD502-2E9C-101B-9397-08002B2CF9AE}';
var
  lPropSpec: array[0..7] of TPropSpec;
  lIPropertyStorage: IPropertyStorage;
  lPropVariant: array[0..7] of TPropVariant;
  liIndex: Integer;
begin

  for liIndex := 0 to 7 do
    lPropSpec[liIndex].ulKind := PRSPEC_PROPID;

  lPropSpec[0].propid := PIDSI_APPNAME;
  lPropVariant[0].vt := VT_LPWSTR;
  lPropVariant[0].pwszVal := PWideChar(FDocSummaryInfo.AppName);

  lPropSpec[1].propid := PIDSI_AUTHOR;
  lPropVariant[1].vt := VT_LPWSTR;
  lPropVariant[1].pwszVal := PWideChar(FDocSummaryInfo.Author);

  lPropSpec[2].propid := PIDSI_CREATE_DTM;
  lPropVariant[2].vt := VT_FILETIME;
  lPropVariant[2].filetime := ppDateTimeToFileTime(FDocSummaryInfo.Created);

  lPropSpec[3].propid := PIDSI_LASTSAVE_DTM;
  lPropVariant[3].vt := VT_FILETIME;
  lPropVariant[3].filetime := ppDateTimeToFileTime(FDocSummaryInfo.LastSaved);

  lPropSpec[4].propid := PIDSI_LASTAUTHOR;
  lPropVariant[4].vt := VT_LPWSTR;
  lPropVariant[4].pwszVal := PWideChar(FDocSummaryInfo.LastSaveBy);

  lPropSpec[5].propid := PIDSI_DOC_SECURITY;
  lPropVariant[5].vt := VT_I4;
  lPropVariant[5].lVal := FDocSummaryInfo.Security;

  lPropSpec[6].propid := PIDSI_SUBJECT;
  lPropVariant[6].vt := VT_LPWSTR;
  lPropVariant[6].pwszVal := PWideChar(FDocSummaryInfo.Subject);

  lPropSpec[7].propid := PIDSI_TITLE;
  lPropVariant[7].vt := VT_LPWSTR;
  lPropVariant[7].pwszVal := PWideChar(FDocSummaryInfo.TITLE);

  // save summary info
  OleCheck(FIPropertySetStorage.Create(FmtID_SummaryInformation, FmtID_SummaryInformation, PROPSETFLAG_DEFAULT, STGM_CREATE or STGM_READWRITE or STGM_SHARE_EXCLUSIVE, lIPropertyStorage));
  lIPropertyStorage.WriteMultiple(8, @lPropSpec, @lPropVariant, 0);
  lIPropertyStorage.Commit(STGC_DEFAULT);

  // save doc summary info
  OleCheck(FIPropertySetStorage.Create(FmtID_DocumentSummaryInformation, FmtID_DocumentSummaryInformation, PROPSETFLAG_DEFAULT, STGM_CREATE or STGM_READWRITE or STGM_SHARE_EXCLUSIVE, lIPropertyStorage));
  lIPropertyStorage.WriteMultiple(8, @lPropSpec, @lPropVariant, 0);
  lIPropertyStorage.Commit(STGC_DEFAULT);

end;

end.
