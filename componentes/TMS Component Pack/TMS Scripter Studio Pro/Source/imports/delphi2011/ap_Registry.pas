{***************************************************************************}
{ This source code was generated automatically by                           }
{ Pas file import tool for Scripter Studio (Pro)                            }
{                                                                           }
{ Scripter Studio and Pas file import tool for Scripter Studio              }
{ written by TMS Software                                                   }
{            copyright © 1997 - 2010                                        }
{            Email : info@tmssoftware.com                                   }
{            Web : http://www.tmssoftware.com                               }
{***************************************************************************}
unit ap_Registry;

interface

uses
  Windows,
  Classes,
  SysUtils,
  IniFiles,
  Registry,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatRegistryLibrary = class(TatScripterLibrary)
    procedure __TRegistryCreate(AMachine: TatVirtualMachine);
    procedure __TRegistryDestroy(AMachine: TatVirtualMachine);
    procedure __TRegistryCloseKey(AMachine: TatVirtualMachine);
    procedure __TRegistryCreateKey(AMachine: TatVirtualMachine);
    procedure __TRegistryDeleteKey(AMachine: TatVirtualMachine);
    procedure __TRegistryDeleteValue(AMachine: TatVirtualMachine);
    procedure __TRegistryGetDataAsString(AMachine: TatVirtualMachine);
    procedure __TRegistryGetDataInfo(AMachine: TatVirtualMachine);
    procedure __TRegistryGetDataSize(AMachine: TatVirtualMachine);
    procedure __TRegistryGetDataType(AMachine: TatVirtualMachine);
    procedure __TRegistryGetKeyInfo(AMachine: TatVirtualMachine);
    procedure __TRegistryGetKeyNames(AMachine: TatVirtualMachine);
    procedure __TRegistryGetValueNames(AMachine: TatVirtualMachine);
    procedure __TRegistryHasSubKeys(AMachine: TatVirtualMachine);
    procedure __TRegistryKeyExists(AMachine: TatVirtualMachine);
    procedure __TRegistryLoadKey(AMachine: TatVirtualMachine);
    procedure __TRegistryMoveKey(AMachine: TatVirtualMachine);
    procedure __TRegistryOpenKey(AMachine: TatVirtualMachine);
    procedure __TRegistryOpenKeyReadOnly(AMachine: TatVirtualMachine);
    procedure __TRegistryReadCurrency(AMachine: TatVirtualMachine);
    procedure __TRegistryReadBinaryData(AMachine: TatVirtualMachine);
    procedure __TRegistryReadBool(AMachine: TatVirtualMachine);
    procedure __TRegistryReadDate(AMachine: TatVirtualMachine);
    procedure __TRegistryReadDateTime(AMachine: TatVirtualMachine);
    procedure __TRegistryReadFloat(AMachine: TatVirtualMachine);
    procedure __TRegistryReadInteger(AMachine: TatVirtualMachine);
    procedure __TRegistryReadString(AMachine: TatVirtualMachine);
    procedure __TRegistryReadTime(AMachine: TatVirtualMachine);
    procedure __TRegistryRegistryConnect(AMachine: TatVirtualMachine);
    procedure __TRegistryRenameValue(AMachine: TatVirtualMachine);
    procedure __TRegistryReplaceKey(AMachine: TatVirtualMachine);
    procedure __TRegistryRestoreKey(AMachine: TatVirtualMachine);
    procedure __TRegistrySaveKey(AMachine: TatVirtualMachine);
    procedure __TRegistryUnLoadKey(AMachine: TatVirtualMachine);
    procedure __TRegistryValueExists(AMachine: TatVirtualMachine);
    procedure __TRegistryWriteCurrency(AMachine: TatVirtualMachine);
    procedure __TRegistryWriteBinaryData(AMachine: TatVirtualMachine);
    procedure __TRegistryWriteBool(AMachine: TatVirtualMachine);
    procedure __TRegistryWriteDate(AMachine: TatVirtualMachine);
    procedure __TRegistryWriteDateTime(AMachine: TatVirtualMachine);
    procedure __TRegistryWriteFloat(AMachine: TatVirtualMachine);
    procedure __TRegistryWriteInteger(AMachine: TatVirtualMachine);
    procedure __TRegistryWriteString(AMachine: TatVirtualMachine);
    procedure __TRegistryWriteExpandString(AMachine: TatVirtualMachine);
    procedure __TRegistryWriteTime(AMachine: TatVirtualMachine);
    procedure __GetTRegistryCurrentKey(AMachine: TatVirtualMachine);
    procedure __GetTRegistryCurrentPath(AMachine: TatVirtualMachine);
    procedure __GetTRegistryLazyWrite(AMachine: TatVirtualMachine);
    procedure __SetTRegistryLazyWrite(AMachine: TatVirtualMachine);
    procedure __GetTRegistryLastError(AMachine: TatVirtualMachine);
    procedure __GetTRegistryLastErrorMsg(AMachine: TatVirtualMachine);
    procedure __GetTRegistryRootKey(AMachine: TatVirtualMachine);
    procedure __SetTRegistryRootKey(AMachine: TatVirtualMachine);
    procedure __GetTRegistryRootKeyName(AMachine: TatVirtualMachine);
    procedure __GetTRegistryAccess(AMachine: TatVirtualMachine);
    procedure __SetTRegistryAccess(AMachine: TatVirtualMachine);
    procedure __TRegIniFileCreate(AMachine: TatVirtualMachine);
    procedure __TRegIniFileReadString(AMachine: TatVirtualMachine);
    procedure __TRegIniFileReadInteger(AMachine: TatVirtualMachine);
    procedure __TRegIniFileWriteInteger(AMachine: TatVirtualMachine);
    procedure __TRegIniFileWriteString(AMachine: TatVirtualMachine);
    procedure __TRegIniFileReadBool(AMachine: TatVirtualMachine);
    procedure __TRegIniFileWriteBool(AMachine: TatVirtualMachine);
    procedure __TRegIniFileReadSection(AMachine: TatVirtualMachine);
    procedure __TRegIniFileReadSections(AMachine: TatVirtualMachine);
    procedure __TRegIniFileReadSectionValues(AMachine: TatVirtualMachine);
    procedure __TRegIniFileEraseSection(AMachine: TatVirtualMachine);
    procedure __TRegIniFileDeleteKey(AMachine: TatVirtualMachine);
    procedure __GetTRegIniFileFileName(AMachine: TatVirtualMachine);
    procedure __TRegistryIniFileCreate(AMachine: TatVirtualMachine);
    procedure __TRegistryIniFileDestroy(AMachine: TatVirtualMachine);
    procedure __TRegistryIniFileReadDate(AMachine: TatVirtualMachine);
    procedure __TRegistryIniFileReadDateTime(AMachine: TatVirtualMachine);
    procedure __TRegistryIniFileReadInteger(AMachine: TatVirtualMachine);
    procedure __TRegistryIniFileReadFloat(AMachine: TatVirtualMachine);
    procedure __TRegistryIniFileReadString(AMachine: TatVirtualMachine);
    procedure __TRegistryIniFileReadTime(AMachine: TatVirtualMachine);
    procedure __TRegistryIniFileReadBinaryStream(AMachine: TatVirtualMachine);
    procedure __TRegistryIniFileWriteDate(AMachine: TatVirtualMachine);
    procedure __TRegistryIniFileWriteDateTime(AMachine: TatVirtualMachine);
    procedure __TRegistryIniFileWriteFloat(AMachine: TatVirtualMachine);
    procedure __TRegistryIniFileWriteInteger(AMachine: TatVirtualMachine);
    procedure __TRegistryIniFileWriteString(AMachine: TatVirtualMachine);
    procedure __TRegistryIniFileWriteTime(AMachine: TatVirtualMachine);
    procedure __TRegistryIniFileWriteBinaryStream(AMachine: TatVirtualMachine);
    procedure __TRegistryIniFileReadSection(AMachine: TatVirtualMachine);
    procedure __TRegistryIniFileReadSections(AMachine: TatVirtualMachine);
    procedure __TRegistryIniFileReadSubSections(AMachine: TatVirtualMachine);
    procedure __TRegistryIniFileReadSectionValues(AMachine: TatVirtualMachine);
    procedure __TRegistryIniFileEraseSection(AMachine: TatVirtualMachine);
    procedure __TRegistryIniFileDeleteKey(AMachine: TatVirtualMachine);
    procedure __TRegistryIniFileUpdateFile(AMachine: TatVirtualMachine);
    procedure __GetTRegistryIniFileRegIniFile(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  ERegistryExceptionClass = class of ERegistryException;
  TRegistryClass = class of TRegistry;
  TRegIniFileClass = class of TRegIniFile;
  TRegistryIniFileClass = class of TRegistryIniFile;


  TRegKeyInfoWrapper = class(TatRecordWrapper)
  private
    FNumSubKeys: Integer;
    FMaxSubKeyLen: Integer;
    FNumValues: Integer;
    FMaxValueLen: Integer;
    FMaxDataLen: Integer;
  public
    constructor Create(ARecord: TRegKeyInfo);
    function ObjToRec: TRegKeyInfo;
  published
    property NumSubKeys: Integer read FNumSubKeys write FNumSubKeys;
    property MaxSubKeyLen: Integer read FMaxSubKeyLen write FMaxSubKeyLen;
    property NumValues: Integer read FNumValues write FNumValues;
    property MaxValueLen: Integer read FMaxValueLen write FMaxValueLen;
    property MaxDataLen: Integer read FMaxDataLen write FMaxDataLen;
  end;
  
  TRegDataInfoWrapper = class(TatRecordWrapper)
  private
    FRegData: TRegDataType;
    FDataSize: Integer;
  public
    constructor Create(ARecord: TRegDataInfo);
    function ObjToRec: TRegDataInfo;
  published
    property RegData: TRegDataType read FRegData write FRegData;
    property DataSize: Integer read FDataSize write FDataSize;
  end;
  

implementation

constructor TRegKeyInfoWrapper.Create(ARecord: TRegKeyInfo);
begin
  inherited Create;
  FNumSubKeys := ARecord.NumSubKeys;
  FMaxSubKeyLen := ARecord.MaxSubKeyLen;
  FNumValues := ARecord.NumValues;
  FMaxValueLen := ARecord.MaxValueLen;
  FMaxDataLen := ARecord.MaxDataLen;
end;

function TRegKeyInfoWrapper.ObjToRec: TRegKeyInfo;
begin
  result.NumSubKeys := FNumSubKeys;
  result.MaxSubKeyLen := FMaxSubKeyLen;
  result.NumValues := FNumValues;
  result.MaxValueLen := FMaxValueLen;
  result.MaxDataLen := FMaxDataLen;
end;

constructor TRegDataInfoWrapper.Create(ARecord: TRegDataInfo);
begin
  inherited Create;
  FRegData := ARecord.RegData;
  FDataSize := ARecord.DataSize;
end;

function TRegDataInfoWrapper.ObjToRec: TRegDataInfo;
begin
  result.RegData := FRegData;
  result.DataSize := FDataSize;
end;



procedure TatRegistryLibrary.__TRegistryCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TRegistryClass(CurrentClass.ClassRef).Create);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatRegistryLibrary.__TRegistryDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TRegistry(CurrentObject).Destroy;
  end;
end;

procedure TatRegistryLibrary.__TRegistryCloseKey(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TRegistry(CurrentObject).CloseKey;
  end;
end;

procedure TatRegistryLibrary.__TRegistryCreateKey(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TRegistry(CurrentObject).CreateKey(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatRegistryLibrary.__TRegistryDeleteKey(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TRegistry(CurrentObject).DeleteKey(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatRegistryLibrary.__TRegistryDeleteValue(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TRegistry(CurrentObject).DeleteValue(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatRegistryLibrary.__TRegistryGetDataAsString(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
case InputArgCount of
1: AResult := TRegistry(CurrentObject).GetDataAsString(GetInputArg(0));
2: AResult := TRegistry(CurrentObject).GetDataAsString(GetInputArg(0),GetInputArg(1));
end;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatRegistryLibrary.__TRegistryGetDataInfo(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TRegDataInfo;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is TRegDataInfoWrapper) then 
  Param1Rec := TRegDataInfoWrapper.Create(Param1);
Param1 := TRegDataInfoWrapper(Param1Rec).ObjToRec;
AResult := TRegistry(CurrentObject).GetDataInfo(GetInputArg(0),Param1);
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(TRegDataInfoWrapper.Create(Param1)));
  end;
end;

procedure TatRegistryLibrary.__TRegistryGetDataSize(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TRegistry(CurrentObject).GetDataSize(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatRegistryLibrary.__TRegistryGetDataType(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TRegistry(CurrentObject).GetDataType(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatRegistryLibrary.__TRegistryGetKeyInfo(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TRegKeyInfo;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is TRegKeyInfoWrapper) then 
  Param0Rec := TRegKeyInfoWrapper.Create(Param0);
Param0 := TRegKeyInfoWrapper(Param0Rec).ObjToRec;
AResult := TRegistry(CurrentObject).GetKeyInfo(Param0);
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(TRegKeyInfoWrapper.Create(Param0)));
  end;
end;

procedure TatRegistryLibrary.__TRegistryGetKeyNames(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TRegistry(CurrentObject).GetKeyNames(TStrings(Integer(GetInputArg(0))));
  end;
end;

procedure TatRegistryLibrary.__TRegistryGetValueNames(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TRegistry(CurrentObject).GetValueNames(TStrings(Integer(GetInputArg(0))));
  end;
end;

procedure TatRegistryLibrary.__TRegistryHasSubKeys(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TRegistry(CurrentObject).HasSubKeys;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatRegistryLibrary.__TRegistryKeyExists(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TRegistry(CurrentObject).KeyExists(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatRegistryLibrary.__TRegistryLoadKey(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TRegistry(CurrentObject).LoadKey(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatRegistryLibrary.__TRegistryMoveKey(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TRegistry(CurrentObject).MoveKey(GetInputArg(0),GetInputArg(1),GetInputArg(2));
  end;
end;

procedure TatRegistryLibrary.__TRegistryOpenKey(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TRegistry(CurrentObject).OpenKey(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatRegistryLibrary.__TRegistryOpenKeyReadOnly(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TRegistry(CurrentObject).OpenKeyReadOnly(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatRegistryLibrary.__TRegistryReadCurrency(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TRegistry(CurrentObject).ReadCurrency(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatRegistryLibrary.__TRegistryReadBinaryData(AMachine: TatVirtualMachine);
  var
  Param1: Variant;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
AResult := Integer(TRegistry(CurrentObject).ReadBinaryData(GetInputArg(0),Param1,VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
    SetInputArg(1,Param1);
  end;
end;

procedure TatRegistryLibrary.__TRegistryReadBool(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TRegistry(CurrentObject).ReadBool(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatRegistryLibrary.__TRegistryReadDate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TRegistry(CurrentObject).ReadDate(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatRegistryLibrary.__TRegistryReadDateTime(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TRegistry(CurrentObject).ReadDateTime(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatRegistryLibrary.__TRegistryReadFloat(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TRegistry(CurrentObject).ReadFloat(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatRegistryLibrary.__TRegistryReadInteger(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TRegistry(CurrentObject).ReadInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatRegistryLibrary.__TRegistryReadString(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TRegistry(CurrentObject).ReadString(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatRegistryLibrary.__TRegistryReadTime(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TRegistry(CurrentObject).ReadTime(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatRegistryLibrary.__TRegistryRegistryConnect(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TRegistry(CurrentObject).RegistryConnect(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatRegistryLibrary.__TRegistryRenameValue(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TRegistry(CurrentObject).RenameValue(GetInputArg(0),GetInputArg(1));
  end;
end;

procedure TatRegistryLibrary.__TRegistryReplaceKey(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TRegistry(CurrentObject).ReplaceKey(GetInputArg(0),GetInputArg(1),GetInputArg(2));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatRegistryLibrary.__TRegistryRestoreKey(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TRegistry(CurrentObject).RestoreKey(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatRegistryLibrary.__TRegistrySaveKey(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TRegistry(CurrentObject).SaveKey(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatRegistryLibrary.__TRegistryUnLoadKey(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TRegistry(CurrentObject).UnLoadKey(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatRegistryLibrary.__TRegistryValueExists(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TRegistry(CurrentObject).ValueExists(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatRegistryLibrary.__TRegistryWriteCurrency(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TRegistry(CurrentObject).WriteCurrency(GetInputArg(0),GetInputArg(1));
  end;
end;

procedure TatRegistryLibrary.__TRegistryWriteBinaryData(AMachine: TatVirtualMachine);
  var
  Param1: Variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
    TRegistry(CurrentObject).WriteBinaryData(GetInputArg(0),Param1,VarToInteger(GetInputArg(2)));
    SetInputArg(1,Param1);
  end;
end;

procedure TatRegistryLibrary.__TRegistryWriteBool(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TRegistry(CurrentObject).WriteBool(GetInputArg(0),GetInputArg(1));
  end;
end;

procedure TatRegistryLibrary.__TRegistryWriteDate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TRegistry(CurrentObject).WriteDate(GetInputArg(0),GetInputArg(1));
  end;
end;

procedure TatRegistryLibrary.__TRegistryWriteDateTime(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TRegistry(CurrentObject).WriteDateTime(GetInputArg(0),GetInputArg(1));
  end;
end;

procedure TatRegistryLibrary.__TRegistryWriteFloat(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TRegistry(CurrentObject).WriteFloat(GetInputArg(0),GetInputArg(1));
  end;
end;

procedure TatRegistryLibrary.__TRegistryWriteInteger(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TRegistry(CurrentObject).WriteInteger(GetInputArg(0),VarToInteger(GetInputArg(1)));
  end;
end;

procedure TatRegistryLibrary.__TRegistryWriteString(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TRegistry(CurrentObject).WriteString(GetInputArg(0),GetInputArg(1));
  end;
end;

procedure TatRegistryLibrary.__TRegistryWriteExpandString(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TRegistry(CurrentObject).WriteExpandString(GetInputArg(0),GetInputArg(1));
  end;
end;

procedure TatRegistryLibrary.__TRegistryWriteTime(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TRegistry(CurrentObject).WriteTime(GetInputArg(0),GetInputArg(1));
  end;
end;

procedure TatRegistryLibrary.__GetTRegistryCurrentKey(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TRegistry(CurrentObject).CurrentKey));
  end;
end;

procedure TatRegistryLibrary.__GetTRegistryCurrentPath(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TRegistry(CurrentObject).CurrentPath);
  end;
end;

procedure TatRegistryLibrary.__GetTRegistryLazyWrite(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TRegistry(CurrentObject).LazyWrite);
  end;
end;

procedure TatRegistryLibrary.__SetTRegistryLazyWrite(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TRegistry(CurrentObject).LazyWrite:=GetInputArg(0);
  end;
end;

procedure TatRegistryLibrary.__GetTRegistryLastError(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TRegistry(CurrentObject).LastError));
  end;
end;

procedure TatRegistryLibrary.__GetTRegistryLastErrorMsg(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TRegistry(CurrentObject).LastErrorMsg);
  end;
end;

procedure TatRegistryLibrary.__GetTRegistryRootKey(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TRegistry(CurrentObject).RootKey));
  end;
end;

procedure TatRegistryLibrary.__SetTRegistryRootKey(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TRegistry(CurrentObject).RootKey:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatRegistryLibrary.__GetTRegistryRootKeyName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TRegistry(CurrentObject).RootKeyName);
  end;
end;

procedure TatRegistryLibrary.__GetTRegistryAccess(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TRegistry(CurrentObject).Access));
  end;
end;

procedure TatRegistryLibrary.__SetTRegistryAccess(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TRegistry(CurrentObject).Access:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatRegistryLibrary.__TRegIniFileCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TRegIniFileClass(CurrentClass.ClassRef).Create(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatRegistryLibrary.__TRegIniFileReadString(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TRegIniFile(CurrentObject).ReadString(GetInputArg(0),GetInputArg(1),GetInputArg(2));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatRegistryLibrary.__TRegIniFileReadInteger(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TRegIniFile(CurrentObject).ReadInteger(GetInputArg(0),GetInputArg(1),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatRegistryLibrary.__TRegIniFileWriteInteger(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TRegIniFile(CurrentObject).WriteInteger(GetInputArg(0),GetInputArg(1),VarToInteger(GetInputArg(2)));
  end;
end;

procedure TatRegistryLibrary.__TRegIniFileWriteString(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TRegIniFile(CurrentObject).WriteString(GetInputArg(0),GetInputArg(1),GetInputArg(2));
  end;
end;

procedure TatRegistryLibrary.__TRegIniFileReadBool(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TRegIniFile(CurrentObject).ReadBool(GetInputArg(0),GetInputArg(1),GetInputArg(2));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatRegistryLibrary.__TRegIniFileWriteBool(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TRegIniFile(CurrentObject).WriteBool(GetInputArg(0),GetInputArg(1),GetInputArg(2));
  end;
end;

procedure TatRegistryLibrary.__TRegIniFileReadSection(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TRegIniFile(CurrentObject).ReadSection(GetInputArg(0),TStrings(Integer(GetInputArg(1))));
  end;
end;

procedure TatRegistryLibrary.__TRegIniFileReadSections(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TRegIniFile(CurrentObject).ReadSections(TStrings(Integer(GetInputArg(0))));
  end;
end;

procedure TatRegistryLibrary.__TRegIniFileReadSectionValues(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TRegIniFile(CurrentObject).ReadSectionValues(GetInputArg(0),TStrings(Integer(GetInputArg(1))));
  end;
end;

procedure TatRegistryLibrary.__TRegIniFileEraseSection(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TRegIniFile(CurrentObject).EraseSection(GetInputArg(0));
  end;
end;

procedure TatRegistryLibrary.__TRegIniFileDeleteKey(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TRegIniFile(CurrentObject).DeleteKey(GetInputArg(0),GetInputArg(1));
  end;
end;

procedure TatRegistryLibrary.__GetTRegIniFileFileName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TRegIniFile(CurrentObject).FileName);
  end;
end;

procedure TatRegistryLibrary.__TRegistryIniFileCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TRegistryIniFileClass(CurrentClass.ClassRef).Create(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatRegistryLibrary.__TRegistryIniFileDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TRegistryIniFile(CurrentObject).Destroy;
  end;
end;

procedure TatRegistryLibrary.__TRegistryIniFileReadDate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TRegistryIniFile(CurrentObject).ReadDate(GetInputArg(0),GetInputArg(1),GetInputArg(2));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatRegistryLibrary.__TRegistryIniFileReadDateTime(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TRegistryIniFile(CurrentObject).ReadDateTime(GetInputArg(0),GetInputArg(1),GetInputArg(2));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatRegistryLibrary.__TRegistryIniFileReadInteger(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TRegistryIniFile(CurrentObject).ReadInteger(GetInputArg(0),GetInputArg(1),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatRegistryLibrary.__TRegistryIniFileReadFloat(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TRegistryIniFile(CurrentObject).ReadFloat(GetInputArg(0),GetInputArg(1),GetInputArg(2));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatRegistryLibrary.__TRegistryIniFileReadString(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TRegistryIniFile(CurrentObject).ReadString(GetInputArg(0),GetInputArg(1),GetInputArg(2));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatRegistryLibrary.__TRegistryIniFileReadTime(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TRegistryIniFile(CurrentObject).ReadTime(GetInputArg(0),GetInputArg(1),GetInputArg(2));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatRegistryLibrary.__TRegistryIniFileReadBinaryStream(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TRegistryIniFile(CurrentObject).ReadBinaryStream(GetInputArg(0),GetInputArg(1),TStream(Integer(GetInputArg(2)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatRegistryLibrary.__TRegistryIniFileWriteDate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TRegistryIniFile(CurrentObject).WriteDate(GetInputArg(0),GetInputArg(1),GetInputArg(2));
  end;
end;

procedure TatRegistryLibrary.__TRegistryIniFileWriteDateTime(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TRegistryIniFile(CurrentObject).WriteDateTime(GetInputArg(0),GetInputArg(1),GetInputArg(2));
  end;
end;

procedure TatRegistryLibrary.__TRegistryIniFileWriteFloat(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TRegistryIniFile(CurrentObject).WriteFloat(GetInputArg(0),GetInputArg(1),GetInputArg(2));
  end;
end;

procedure TatRegistryLibrary.__TRegistryIniFileWriteInteger(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TRegistryIniFile(CurrentObject).WriteInteger(GetInputArg(0),GetInputArg(1),VarToInteger(GetInputArg(2)));
  end;
end;

procedure TatRegistryLibrary.__TRegistryIniFileWriteString(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TRegistryIniFile(CurrentObject).WriteString(GetInputArg(0),GetInputArg(1),GetInputArg(2));
  end;
end;

procedure TatRegistryLibrary.__TRegistryIniFileWriteTime(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TRegistryIniFile(CurrentObject).WriteTime(GetInputArg(0),GetInputArg(1),GetInputArg(2));
  end;
end;

procedure TatRegistryLibrary.__TRegistryIniFileWriteBinaryStream(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TRegistryIniFile(CurrentObject).WriteBinaryStream(GetInputArg(0),GetInputArg(1),TStream(Integer(GetInputArg(2))));
  end;
end;

procedure TatRegistryLibrary.__TRegistryIniFileReadSection(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TRegistryIniFile(CurrentObject).ReadSection(GetInputArg(0),TStrings(Integer(GetInputArg(1))));
  end;
end;

procedure TatRegistryLibrary.__TRegistryIniFileReadSections(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TRegistryIniFile(CurrentObject).ReadSections(TStrings(Integer(GetInputArg(0))));
  end;
end;

procedure TatRegistryLibrary.__TRegistryIniFileReadSubSections(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Case InputArgCount of
      2: TRegistryIniFile(CurrentObject).ReadSubSections(GetInputArg(0),TStrings(Integer(GetInputArg(1))));
      3: TRegistryIniFile(CurrentObject).ReadSubSections(GetInputArg(0),TStrings(Integer(GetInputArg(1))),GetInputArg(2));
    end;
  end;
end;

procedure TatRegistryLibrary.__TRegistryIniFileReadSectionValues(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TRegistryIniFile(CurrentObject).ReadSectionValues(GetInputArg(0),TStrings(Integer(GetInputArg(1))));
  end;
end;

procedure TatRegistryLibrary.__TRegistryIniFileEraseSection(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TRegistryIniFile(CurrentObject).EraseSection(GetInputArg(0));
  end;
end;

procedure TatRegistryLibrary.__TRegistryIniFileDeleteKey(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TRegistryIniFile(CurrentObject).DeleteKey(GetInputArg(0),GetInputArg(1));
  end;
end;

procedure TatRegistryLibrary.__TRegistryIniFileUpdateFile(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TRegistryIniFile(CurrentObject).UpdateFile;
  end;
end;

procedure TatRegistryLibrary.__GetTRegistryIniFileRegIniFile(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TRegistryIniFile(CurrentObject).RegIniFile));
  end;
end;

procedure TatRegistryLibrary.Init;
begin
  With Scripter.DefineClass(ERegistryException) do
  begin
  end;
  With Scripter.DefineClass(TRegistry) do
  begin
    DefineMethod('Create',0,tkClass,TRegistry,__TRegistryCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TRegistryDestroy,false,0);
    DefineMethod('CloseKey',0,tkNone,nil,__TRegistryCloseKey,false,0);
    DefineMethod('CreateKey',1,tkVariant,nil,__TRegistryCreateKey,false,0);
    DefineMethod('DeleteKey',1,tkVariant,nil,__TRegistryDeleteKey,false,0);
    DefineMethod('DeleteValue',1,tkVariant,nil,__TRegistryDeleteValue,false,0);
    DefineMethod('GetDataAsString',2,tkVariant,nil,__TRegistryGetDataAsString,false,1);
    DefineMethod('GetDataInfo',2,tkVariant,nil,__TRegistryGetDataInfo,false,0).SetVarArgs([1]);
    DefineMethod('GetDataSize',1,tkInteger,nil,__TRegistryGetDataSize,false,0);
    DefineMethod('GetDataType',1,tkEnumeration,nil,__TRegistryGetDataType,false,0);
    DefineMethod('GetKeyInfo',1,tkVariant,nil,__TRegistryGetKeyInfo,false,0).SetVarArgs([0]);
    DefineMethod('GetKeyNames',1,tkNone,nil,__TRegistryGetKeyNames,false,0);
    DefineMethod('GetValueNames',1,tkNone,nil,__TRegistryGetValueNames,false,0);
    DefineMethod('HasSubKeys',0,tkVariant,nil,__TRegistryHasSubKeys,false,0);
    DefineMethod('KeyExists',1,tkVariant,nil,__TRegistryKeyExists,false,0);
    DefineMethod('LoadKey',2,tkVariant,nil,__TRegistryLoadKey,false,0);
    DefineMethod('MoveKey',3,tkNone,nil,__TRegistryMoveKey,false,0);
    DefineMethod('OpenKey',2,tkVariant,nil,__TRegistryOpenKey,false,0);
    DefineMethod('OpenKeyReadOnly',1,tkVariant,nil,__TRegistryOpenKeyReadOnly,false,0);
    DefineMethod('ReadCurrency',1,tkVariant,nil,__TRegistryReadCurrency,false,0);
    DefineMethod('ReadBinaryData',3,tkInteger,nil,__TRegistryReadBinaryData,false,0).SetVarArgs([1]);
    DefineMethod('ReadBool',1,tkVariant,nil,__TRegistryReadBool,false,0);
    DefineMethod('ReadDate',1,tkVariant,nil,__TRegistryReadDate,false,0);
    DefineMethod('ReadDateTime',1,tkVariant,nil,__TRegistryReadDateTime,false,0);
    DefineMethod('ReadFloat',1,tkVariant,nil,__TRegistryReadFloat,false,0);
    DefineMethod('ReadInteger',1,tkInteger,nil,__TRegistryReadInteger,false,0);
    DefineMethod('ReadString',1,tkVariant,nil,__TRegistryReadString,false,0);
    DefineMethod('ReadTime',1,tkVariant,nil,__TRegistryReadTime,false,0);
    DefineMethod('RegistryConnect',1,tkVariant,nil,__TRegistryRegistryConnect,false,0);
    DefineMethod('RenameValue',2,tkNone,nil,__TRegistryRenameValue,false,0);
    DefineMethod('ReplaceKey',3,tkVariant,nil,__TRegistryReplaceKey,false,0);
    DefineMethod('RestoreKey',2,tkVariant,nil,__TRegistryRestoreKey,false,0);
    DefineMethod('SaveKey',2,tkVariant,nil,__TRegistrySaveKey,false,0);
    DefineMethod('UnLoadKey',1,tkVariant,nil,__TRegistryUnLoadKey,false,0);
    DefineMethod('ValueExists',1,tkVariant,nil,__TRegistryValueExists,false,0);
    DefineMethod('WriteCurrency',2,tkNone,nil,__TRegistryWriteCurrency,false,0);
    DefineMethod('WriteBinaryData',3,tkNone,nil,__TRegistryWriteBinaryData,false,0).SetVarArgs([1]);
    DefineMethod('WriteBool',2,tkNone,nil,__TRegistryWriteBool,false,0);
    DefineMethod('WriteDate',2,tkNone,nil,__TRegistryWriteDate,false,0);
    DefineMethod('WriteDateTime',2,tkNone,nil,__TRegistryWriteDateTime,false,0);
    DefineMethod('WriteFloat',2,tkNone,nil,__TRegistryWriteFloat,false,0);
    DefineMethod('WriteInteger',2,tkNone,nil,__TRegistryWriteInteger,false,0);
    DefineMethod('WriteString',2,tkNone,nil,__TRegistryWriteString,false,0);
    DefineMethod('WriteExpandString',2,tkNone,nil,__TRegistryWriteExpandString,false,0);
    DefineMethod('WriteTime',2,tkNone,nil,__TRegistryWriteTime,false,0);
    DefineProp('CurrentKey',tkInteger,__GetTRegistryCurrentKey,nil,nil,false,0);
    DefineProp('CurrentPath',tkVariant,__GetTRegistryCurrentPath,nil,nil,false,0);
    DefineProp('LazyWrite',tkVariant,__GetTRegistryLazyWrite,__SetTRegistryLazyWrite,nil,false,0);
    DefineProp('LastError',tkInteger,__GetTRegistryLastError,nil,nil,false,0);
    DefineProp('LastErrorMsg',tkVariant,__GetTRegistryLastErrorMsg,nil,nil,false,0);
    DefineProp('RootKey',tkInteger,__GetTRegistryRootKey,__SetTRegistryRootKey,nil,false,0);
    DefineProp('RootKeyName',tkVariant,__GetTRegistryRootKeyName,nil,nil,false,0);
    DefineProp('Access',tkInteger,__GetTRegistryAccess,__SetTRegistryAccess,nil,false,0);
  end;
  With Scripter.DefineClass(TRegIniFile) do
  begin
    DefineMethod('Create',1,tkClass,TRegIniFile,__TRegIniFileCreate,true,0);
    DefineMethod('ReadString',3,tkVariant,nil,__TRegIniFileReadString,false,0);
    DefineMethod('ReadInteger',3,tkInteger,nil,__TRegIniFileReadInteger,false,0);
    DefineMethod('WriteInteger',3,tkNone,nil,__TRegIniFileWriteInteger,false,0);
    DefineMethod('WriteString',3,tkNone,nil,__TRegIniFileWriteString,false,0);
    DefineMethod('ReadBool',3,tkVariant,nil,__TRegIniFileReadBool,false,0);
    DefineMethod('WriteBool',3,tkNone,nil,__TRegIniFileWriteBool,false,0);
    DefineMethod('ReadSection',2,tkNone,nil,__TRegIniFileReadSection,false,0);
    DefineMethod('ReadSections',1,tkNone,nil,__TRegIniFileReadSections,false,0);
    DefineMethod('ReadSectionValues',2,tkNone,nil,__TRegIniFileReadSectionValues,false,0);
    DefineMethod('EraseSection',1,tkNone,nil,__TRegIniFileEraseSection,false,0);
    DefineMethod('DeleteKey',2,tkNone,nil,__TRegIniFileDeleteKey,false,0);
    DefineProp('FileName',tkVariant,__GetTRegIniFileFileName,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TRegistryIniFile) do
  begin
    DefineMethod('Create',1,tkClass,TRegistryIniFile,__TRegistryIniFileCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TRegistryIniFileDestroy,false,0);
    DefineMethod('ReadDate',3,tkVariant,nil,__TRegistryIniFileReadDate,false,0);
    DefineMethod('ReadDateTime',3,tkVariant,nil,__TRegistryIniFileReadDateTime,false,0);
    DefineMethod('ReadInteger',3,tkInteger,nil,__TRegistryIniFileReadInteger,false,0);
    DefineMethod('ReadFloat',3,tkVariant,nil,__TRegistryIniFileReadFloat,false,0);
    DefineMethod('ReadString',3,tkVariant,nil,__TRegistryIniFileReadString,false,0);
    DefineMethod('ReadTime',3,tkVariant,nil,__TRegistryIniFileReadTime,false,0);
    DefineMethod('ReadBinaryStream',3,tkInteger,nil,__TRegistryIniFileReadBinaryStream,false,0);
    DefineMethod('WriteDate',3,tkNone,nil,__TRegistryIniFileWriteDate,false,0);
    DefineMethod('WriteDateTime',3,tkNone,nil,__TRegistryIniFileWriteDateTime,false,0);
    DefineMethod('WriteFloat',3,tkNone,nil,__TRegistryIniFileWriteFloat,false,0);
    DefineMethod('WriteInteger',3,tkNone,nil,__TRegistryIniFileWriteInteger,false,0);
    DefineMethod('WriteString',3,tkNone,nil,__TRegistryIniFileWriteString,false,0);
    DefineMethod('WriteTime',3,tkNone,nil,__TRegistryIniFileWriteTime,false,0);
    DefineMethod('WriteBinaryStream',3,tkNone,nil,__TRegistryIniFileWriteBinaryStream,false,0);
    DefineMethod('ReadSection',2,tkNone,nil,__TRegistryIniFileReadSection,false,0);
    DefineMethod('ReadSections',1,tkNone,nil,__TRegistryIniFileReadSections,false,0);
    DefineMethod('ReadSubSections',3,tkNone,nil,__TRegistryIniFileReadSubSections,false,1);
    DefineMethod('ReadSectionValues',2,tkNone,nil,__TRegistryIniFileReadSectionValues,false,0);
    DefineMethod('EraseSection',1,tkNone,nil,__TRegistryIniFileEraseSection,false,0);
    DefineMethod('DeleteKey',2,tkNone,nil,__TRegistryIniFileDeleteKey,false,0);
    DefineMethod('UpdateFile',0,tkNone,nil,__TRegistryIniFileUpdateFile,false,0);
    DefineProp('RegIniFile',tkClass,__GetTRegistryIniFileRegIniFile,nil,TRegIniFile,false,0);
  end;
  With Scripter.DefineClass(ClassType) do
  begin
    AddConstant('rdUnknown',rdUnknown);
    AddConstant('rdString',rdString);
    AddConstant('rdExpandString',rdExpandString);
    AddConstant('rdInteger',rdInteger);
    AddConstant('rdBinary',rdBinary);
  end;
end;

class function TatRegistryLibrary.LibraryName: string;
begin
  result := 'Registry';
end;

initialization
  RegisterScripterLibrary(TatRegistryLibrary, True);

{$WARNINGS ON}

end.

