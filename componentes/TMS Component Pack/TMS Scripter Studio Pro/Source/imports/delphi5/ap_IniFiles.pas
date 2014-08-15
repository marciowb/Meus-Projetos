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
unit ap_IniFiles;

interface

uses
  Windows,
  SysUtils,
  Classes,
  IniFiles,
  atScript;

{$WARNINGS OFF}

type
  TatIniFilesLibrary = class(TatScripterLibrary)
    procedure __TCustomIniFileCreate(AMachine: TatVirtualMachine);
    procedure __TCustomIniFileSectionExists(AMachine: TatVirtualMachine);
    procedure __TCustomIniFileReadString(AMachine: TatVirtualMachine);
    procedure __TCustomIniFileWriteString(AMachine: TatVirtualMachine);
    procedure __TCustomIniFileReadInteger(AMachine: TatVirtualMachine);
    procedure __TCustomIniFileWriteInteger(AMachine: TatVirtualMachine);
    procedure __TCustomIniFileReadBool(AMachine: TatVirtualMachine);
    procedure __TCustomIniFileWriteBool(AMachine: TatVirtualMachine);
    procedure __TCustomIniFileReadDate(AMachine: TatVirtualMachine);
    procedure __TCustomIniFileReadDateTime(AMachine: TatVirtualMachine);
    procedure __TCustomIniFileReadFloat(AMachine: TatVirtualMachine);
    procedure __TCustomIniFileReadTime(AMachine: TatVirtualMachine);
    procedure __TCustomIniFileWriteDate(AMachine: TatVirtualMachine);
    procedure __TCustomIniFileWriteDateTime(AMachine: TatVirtualMachine);
    procedure __TCustomIniFileWriteFloat(AMachine: TatVirtualMachine);
    procedure __TCustomIniFileWriteTime(AMachine: TatVirtualMachine);
    procedure __TCustomIniFileReadSection(AMachine: TatVirtualMachine);
    procedure __TCustomIniFileReadSections(AMachine: TatVirtualMachine);
    procedure __TCustomIniFileReadSectionValues(AMachine: TatVirtualMachine);
    procedure __TCustomIniFileEraseSection(AMachine: TatVirtualMachine);
    procedure __TCustomIniFileDeleteKey(AMachine: TatVirtualMachine);
    procedure __TCustomIniFileUpdateFile(AMachine: TatVirtualMachine);
    procedure __TCustomIniFileValueExists(AMachine: TatVirtualMachine);
    procedure __GetTCustomIniFileFileName(AMachine: TatVirtualMachine);
    procedure __TIniFileReadString(AMachine: TatVirtualMachine);
    procedure __TIniFileWriteString(AMachine: TatVirtualMachine);
    procedure __TIniFileReadSection(AMachine: TatVirtualMachine);
    procedure __TIniFileReadSections(AMachine: TatVirtualMachine);
    procedure __TIniFileReadSectionValues(AMachine: TatVirtualMachine);
    procedure __TIniFileEraseSection(AMachine: TatVirtualMachine);
    procedure __TIniFileDeleteKey(AMachine: TatVirtualMachine);
    procedure __TIniFileUpdateFile(AMachine: TatVirtualMachine);
    procedure __TMemIniFileCreate(AMachine: TatVirtualMachine);
    procedure __TMemIniFileDestroy(AMachine: TatVirtualMachine);
    procedure __TMemIniFileClear(AMachine: TatVirtualMachine);
    procedure __TMemIniFileDeleteKey(AMachine: TatVirtualMachine);
    procedure __TMemIniFileEraseSection(AMachine: TatVirtualMachine);
    procedure __TMemIniFileGetStrings(AMachine: TatVirtualMachine);
    procedure __TMemIniFileReadSection(AMachine: TatVirtualMachine);
    procedure __TMemIniFileReadSections(AMachine: TatVirtualMachine);
    procedure __TMemIniFileReadSectionValues(AMachine: TatVirtualMachine);
    procedure __TMemIniFileReadString(AMachine: TatVirtualMachine);
    procedure __TMemIniFileRename(AMachine: TatVirtualMachine);
    procedure __TMemIniFileSetStrings(AMachine: TatVirtualMachine);
    procedure __TMemIniFileUpdateFile(AMachine: TatVirtualMachine);
    procedure __TMemIniFileWriteString(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TCustomIniFileClass = class of TCustomIniFile;
  TIniFileClass = class of TIniFile;
  TMemIniFileClass = class of TMemIniFile;



implementation



procedure TatIniFilesLibrary.__TCustomIniFileCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomIniFileClass(CurrentClass.ClassRef).Create(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIniFilesLibrary.__TCustomIniFileSectionExists(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TCustomIniFile(CurrentObject).SectionExists(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIniFilesLibrary.__TCustomIniFileReadString(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TCustomIniFile(CurrentObject).ReadString(GetInputArg(0),GetInputArg(1),GetInputArg(2));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIniFilesLibrary.__TCustomIniFileWriteString(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomIniFile(CurrentObject).WriteString(GetInputArg(0),GetInputArg(1),GetInputArg(2));
  end;
end;

procedure TatIniFilesLibrary.__TCustomIniFileReadInteger(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomIniFile(CurrentObject).ReadInteger(GetInputArg(0),GetInputArg(1),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIniFilesLibrary.__TCustomIniFileWriteInteger(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomIniFile(CurrentObject).WriteInteger(GetInputArg(0),GetInputArg(1),VarToInteger(GetInputArg(2)));
  end;
end;

procedure TatIniFilesLibrary.__TCustomIniFileReadBool(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TCustomIniFile(CurrentObject).ReadBool(GetInputArg(0),GetInputArg(1),GetInputArg(2));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIniFilesLibrary.__TCustomIniFileWriteBool(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomIniFile(CurrentObject).WriteBool(GetInputArg(0),GetInputArg(1),GetInputArg(2));
  end;
end;

procedure TatIniFilesLibrary.__TCustomIniFileReadDate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TCustomIniFile(CurrentObject).ReadDate(GetInputArg(0),GetInputArg(1),GetInputArg(2));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIniFilesLibrary.__TCustomIniFileReadDateTime(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TCustomIniFile(CurrentObject).ReadDateTime(GetInputArg(0),GetInputArg(1),GetInputArg(2));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIniFilesLibrary.__TCustomIniFileReadFloat(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TCustomIniFile(CurrentObject).ReadFloat(GetInputArg(0),GetInputArg(1),GetInputArg(2));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIniFilesLibrary.__TCustomIniFileReadTime(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TCustomIniFile(CurrentObject).ReadTime(GetInputArg(0),GetInputArg(1),GetInputArg(2));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIniFilesLibrary.__TCustomIniFileWriteDate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomIniFile(CurrentObject).WriteDate(GetInputArg(0),GetInputArg(1),GetInputArg(2));
  end;
end;

procedure TatIniFilesLibrary.__TCustomIniFileWriteDateTime(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomIniFile(CurrentObject).WriteDateTime(GetInputArg(0),GetInputArg(1),GetInputArg(2));
  end;
end;

procedure TatIniFilesLibrary.__TCustomIniFileWriteFloat(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomIniFile(CurrentObject).WriteFloat(GetInputArg(0),GetInputArg(1),GetInputArg(2));
  end;
end;

procedure TatIniFilesLibrary.__TCustomIniFileWriteTime(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomIniFile(CurrentObject).WriteTime(GetInputArg(0),GetInputArg(1),GetInputArg(2));
  end;
end;

procedure TatIniFilesLibrary.__TCustomIniFileReadSection(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomIniFile(CurrentObject).ReadSection(GetInputArg(0),TStrings(Integer(GetInputArg(1))));
  end;
end;

procedure TatIniFilesLibrary.__TCustomIniFileReadSections(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomIniFile(CurrentObject).ReadSections(TStrings(Integer(GetInputArg(0))));
  end;
end;

procedure TatIniFilesLibrary.__TCustomIniFileReadSectionValues(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomIniFile(CurrentObject).ReadSectionValues(GetInputArg(0),TStrings(Integer(GetInputArg(1))));
  end;
end;

procedure TatIniFilesLibrary.__TCustomIniFileEraseSection(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomIniFile(CurrentObject).EraseSection(GetInputArg(0));
  end;
end;

procedure TatIniFilesLibrary.__TCustomIniFileDeleteKey(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomIniFile(CurrentObject).DeleteKey(GetInputArg(0),GetInputArg(1));
  end;
end;

procedure TatIniFilesLibrary.__TCustomIniFileUpdateFile(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomIniFile(CurrentObject).UpdateFile;
  end;
end;

procedure TatIniFilesLibrary.__TCustomIniFileValueExists(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TCustomIniFile(CurrentObject).ValueExists(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIniFilesLibrary.__GetTCustomIniFileFileName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomIniFile(CurrentObject).FileName);
  end;
end;

procedure TatIniFilesLibrary.__TIniFileReadString(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TIniFile(CurrentObject).ReadString(GetInputArg(0),GetInputArg(1),GetInputArg(2));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIniFilesLibrary.__TIniFileWriteString(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIniFile(CurrentObject).WriteString(GetInputArg(0),GetInputArg(1),GetInputArg(2));
  end;
end;

procedure TatIniFilesLibrary.__TIniFileReadSection(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIniFile(CurrentObject).ReadSection(GetInputArg(0),TStrings(Integer(GetInputArg(1))));
  end;
end;

procedure TatIniFilesLibrary.__TIniFileReadSections(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIniFile(CurrentObject).ReadSections(TStrings(Integer(GetInputArg(0))));
  end;
end;

procedure TatIniFilesLibrary.__TIniFileReadSectionValues(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIniFile(CurrentObject).ReadSectionValues(GetInputArg(0),TStrings(Integer(GetInputArg(1))));
  end;
end;

procedure TatIniFilesLibrary.__TIniFileEraseSection(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIniFile(CurrentObject).EraseSection(GetInputArg(0));
  end;
end;

procedure TatIniFilesLibrary.__TIniFileDeleteKey(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIniFile(CurrentObject).DeleteKey(GetInputArg(0),GetInputArg(1));
  end;
end;

procedure TatIniFilesLibrary.__TIniFileUpdateFile(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIniFile(CurrentObject).UpdateFile;
  end;
end;

procedure TatIniFilesLibrary.__TMemIniFileCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TMemIniFileClass(CurrentClass.ClassRef).Create(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIniFilesLibrary.__TMemIniFileDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TMemIniFile(CurrentObject).Destroy;
  end;
end;

procedure TatIniFilesLibrary.__TMemIniFileClear(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TMemIniFile(CurrentObject).Clear;
  end;
end;

procedure TatIniFilesLibrary.__TMemIniFileDeleteKey(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TMemIniFile(CurrentObject).DeleteKey(GetInputArg(0),GetInputArg(1));
  end;
end;

procedure TatIniFilesLibrary.__TMemIniFileEraseSection(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TMemIniFile(CurrentObject).EraseSection(GetInputArg(0));
  end;
end;

procedure TatIniFilesLibrary.__TMemIniFileGetStrings(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TMemIniFile(CurrentObject).GetStrings(TStrings(Integer(GetInputArg(0))));
  end;
end;

procedure TatIniFilesLibrary.__TMemIniFileReadSection(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TMemIniFile(CurrentObject).ReadSection(GetInputArg(0),TStrings(Integer(GetInputArg(1))));
  end;
end;

procedure TatIniFilesLibrary.__TMemIniFileReadSections(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TMemIniFile(CurrentObject).ReadSections(TStrings(Integer(GetInputArg(0))));
  end;
end;

procedure TatIniFilesLibrary.__TMemIniFileReadSectionValues(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TMemIniFile(CurrentObject).ReadSectionValues(GetInputArg(0),TStrings(Integer(GetInputArg(1))));
  end;
end;

procedure TatIniFilesLibrary.__TMemIniFileReadString(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TMemIniFile(CurrentObject).ReadString(GetInputArg(0),GetInputArg(1),GetInputArg(2));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIniFilesLibrary.__TMemIniFileRename(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TMemIniFile(CurrentObject).Rename(GetInputArg(0),GetInputArg(1));
  end;
end;

procedure TatIniFilesLibrary.__TMemIniFileSetStrings(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TMemIniFile(CurrentObject).SetStrings(TStrings(Integer(GetInputArg(0))));
  end;
end;

procedure TatIniFilesLibrary.__TMemIniFileUpdateFile(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TMemIniFile(CurrentObject).UpdateFile;
  end;
end;

procedure TatIniFilesLibrary.__TMemIniFileWriteString(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TMemIniFile(CurrentObject).WriteString(GetInputArg(0),GetInputArg(1),GetInputArg(2));
  end;
end;

procedure TatIniFilesLibrary.Init;
begin
  With Scripter.DefineClass(TCustomIniFile) do
  begin
    DefineMethod('Create',1,tkClass,TCustomIniFile,__TCustomIniFileCreate,true,0);
    DefineMethod('SectionExists',1,tkVariant,nil,__TCustomIniFileSectionExists,false,0);
    DefineMethod('ReadString',3,tkVariant,nil,__TCustomIniFileReadString,false,0);
    DefineMethod('WriteString',3,tkNone,nil,__TCustomIniFileWriteString,false,0);
    DefineMethod('ReadInteger',3,tkInteger,nil,__TCustomIniFileReadInteger,false,0);
    DefineMethod('WriteInteger',3,tkNone,nil,__TCustomIniFileWriteInteger,false,0);
    DefineMethod('ReadBool',3,tkVariant,nil,__TCustomIniFileReadBool,false,0);
    DefineMethod('WriteBool',3,tkNone,nil,__TCustomIniFileWriteBool,false,0);
    DefineMethod('ReadDate',3,tkVariant,nil,__TCustomIniFileReadDate,false,0);
    DefineMethod('ReadDateTime',3,tkVariant,nil,__TCustomIniFileReadDateTime,false,0);
    DefineMethod('ReadFloat',3,tkVariant,nil,__TCustomIniFileReadFloat,false,0);
    DefineMethod('ReadTime',3,tkVariant,nil,__TCustomIniFileReadTime,false,0);
    DefineMethod('WriteDate',3,tkNone,nil,__TCustomIniFileWriteDate,false,0);
    DefineMethod('WriteDateTime',3,tkNone,nil,__TCustomIniFileWriteDateTime,false,0);
    DefineMethod('WriteFloat',3,tkNone,nil,__TCustomIniFileWriteFloat,false,0);
    DefineMethod('WriteTime',3,tkNone,nil,__TCustomIniFileWriteTime,false,0);
    DefineMethod('ReadSection',2,tkNone,nil,__TCustomIniFileReadSection,false,0);
    DefineMethod('ReadSections',1,tkNone,nil,__TCustomIniFileReadSections,false,0);
    DefineMethod('ReadSectionValues',2,tkNone,nil,__TCustomIniFileReadSectionValues,false,0);
    DefineMethod('EraseSection',1,tkNone,nil,__TCustomIniFileEraseSection,false,0);
    DefineMethod('DeleteKey',2,tkNone,nil,__TCustomIniFileDeleteKey,false,0);
    DefineMethod('UpdateFile',0,tkNone,nil,__TCustomIniFileUpdateFile,false,0);
    DefineMethod('ValueExists',2,tkVariant,nil,__TCustomIniFileValueExists,false,0);
    DefineProp('FileName',tkVariant,__GetTCustomIniFileFileName,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TIniFile) do
  begin
    DefineMethod('ReadString',3,tkVariant,nil,__TIniFileReadString,false,0);
    DefineMethod('WriteString',3,tkNone,nil,__TIniFileWriteString,false,0);
    DefineMethod('ReadSection',2,tkNone,nil,__TIniFileReadSection,false,0);
    DefineMethod('ReadSections',1,tkNone,nil,__TIniFileReadSections,false,0);
    DefineMethod('ReadSectionValues',2,tkNone,nil,__TIniFileReadSectionValues,false,0);
    DefineMethod('EraseSection',1,tkNone,nil,__TIniFileEraseSection,false,0);
    DefineMethod('DeleteKey',2,tkNone,nil,__TIniFileDeleteKey,false,0);
    DefineMethod('UpdateFile',0,tkNone,nil,__TIniFileUpdateFile,false,0);
  end;
  With Scripter.DefineClass(TMemIniFile) do
  begin
    DefineMethod('Create',1,tkClass,TMemIniFile,__TMemIniFileCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TMemIniFileDestroy,false,0);
    DefineMethod('Clear',0,tkNone,nil,__TMemIniFileClear,false,0);
    DefineMethod('DeleteKey',2,tkNone,nil,__TMemIniFileDeleteKey,false,0);
    DefineMethod('EraseSection',1,tkNone,nil,__TMemIniFileEraseSection,false,0);
    DefineMethod('GetStrings',1,tkNone,nil,__TMemIniFileGetStrings,false,0);
    DefineMethod('ReadSection',2,tkNone,nil,__TMemIniFileReadSection,false,0);
    DefineMethod('ReadSections',1,tkNone,nil,__TMemIniFileReadSections,false,0);
    DefineMethod('ReadSectionValues',2,tkNone,nil,__TMemIniFileReadSectionValues,false,0);
    DefineMethod('ReadString',3,tkVariant,nil,__TMemIniFileReadString,false,0);
    DefineMethod('Rename',2,tkNone,nil,__TMemIniFileRename,false,0);
    DefineMethod('SetStrings',1,tkNone,nil,__TMemIniFileSetStrings,false,0);
    DefineMethod('UpdateFile',0,tkNone,nil,__TMemIniFileUpdateFile,false,0);
    DefineMethod('WriteString',3,tkNone,nil,__TMemIniFileWriteString,false,0);
  end;
  With Scripter.DefineClass(ClassType) do
  begin
  end;
end;

class function TatIniFilesLibrary.LibraryName: string;
begin
  result := 'IniFiles';
end;

initialization
  RegisterScripterLibrary(TatIniFilesLibrary, True);

{$WARNINGS ON}

end.

