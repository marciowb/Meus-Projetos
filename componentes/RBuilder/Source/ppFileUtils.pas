{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2008                    BBBBB   }

unit ppFileUtils;

interface

{$WARN SYMBOL_PLATFORM OFF}

uses
  Windows,
  Classes,
  SysUtils,
  ShellAPI,
  SHFolder,
  ppTypes,
  ppCharacter;

type

  {@TppFileUtils }

  TppFileUtils = class
  private
    protected
    public
      class function GetApplicationFileName: String;
      class function GetApplicationFilePath: String;
      class function GetApplicationShortFilePath: String;
      class function GetCommonAppDataPath: String;
      class function GetLocalAppDataPath: String;
      class function GetLibraryFileName: String;
      class function GetLibraryFilePath: String;
      class function GetLibraryShortFilePath: String;
      class function GetSystemFilePath: String;

      class procedure GetFileNamesForDirectory(aDirectory: String; aFileExtension: String; aList: TStrings); overload; virtual; 
      class procedure GetFileNamesForDirectory(aPathWithFileSpec: String; aList: TStrings); overload; virtual; 
      class function GetFileSearchRec(aFileName: String; var aSearchRec: TSearchRec): Boolean; virtual;
      class procedure GetFolderNamesForDirectory(const aDirectory: string; aNameList: TStrings); virtual;
      class function GetLongFileName(aFileName: String): String;
      class procedure GetReportNamesForDirectory(aDirectory: String; aFileExtension: String; aList: TStrings); virtual;

      class procedure ParseDirectoryPath(aDirectoryPath: String; aStrings: TStrings); overload; virtual;
      class procedure RemoveDirAndContents(aDirName: String);
      class procedure RemoveDirContents(aDirName: String);

      class procedure ComponentToFile(aComponent: TComponent; aFileName: String);
      class function FileToComponent(aFileName: String): TComponent;

      class procedure StringToFile(aString, aFileName: String);
      class function FileToString(aFileName: String): String;
      class function GetWindowsFilePath: String;
      class function GetTempFilePath: string;
      class procedure ParseDirectoryPath(aDirectoryPath: String; aStrings: TStrings; aDelimiter: Char); overload; virtual;
      class function RemoveFileExtension(const aFileName: String): String;
      class procedure SeparateRootFolderFromPath(aPath: String; var aRootFolder, aRemainingPath: String);

    end;


  {TppFilePathVariables}
  TppFilePathVariables = class
  private
    class function CreateList: TStrings;
    class function ContainsVariable(const aVariable, aFilePath: String): Boolean;

  public
    class function WinSys: String;
    class function LocalAppData: String;
    class function CommonAppData: String;
    class function Application: String;
    class function Temp: String;
    class function MainApplication: String;
    class function System: string;

    class function GetList: TStrings;
    class function ResolveFilePath(const aFilePath: String): String;
  end;



implementation

var
  uPathVariableList: TStringList;

const
   SHGFP_TYPE_CURRENT = 0;

{------------------------------------------------------------------------------}
{TppFileUtils.GetApplicationFileName }

class function TppFileUtils.GetApplicationFileName: String;
begin

   Result := ParamStr(0);

  {The above call sometimes returns the short path name - for example
   when running an application as a service. Therefore, need to
   check whether the result is the short path name and convert if needed.
   The GetLongFileNames call will fail if you perform it on a long path name
   that includes spaces.}
  if (Pos('~', Result) > 0) then
    Result := GetLongFileName(Result);

end;

{------------------------------------------------------------------------------}
{TppFileUtils.GetApplicationFilePath }

class function TppFileUtils.GetApplicationFilePath: String;
begin

  Result := ExtractFilePath(GetApplicationFileName);

end;

{------------------------------------------------------------------------------}
{TppFileUtils.GetApplicationShortFilePath }

class function TppFileUtils.GetApplicationShortFilePath: String;
var
  lsShortPathFileName: String;
begin

  lsShortPathFileName := ExtractShortPathName(GetApplicationFileName);

  Result := ExtractFilePath(lsShortPathFileName);

end;

{------------------------------------------------------------------------------}
{TppFileUtils.GetCommonAppDataPath }

class function TppFileUtils.GetCommonAppDataPath: String;
var
  lsPath: array [0..MAX_PATH] of char;
begin
  SHGetFolderPath(0, CSIDL_COMMON_APPDATA, 0, SHGFP_TYPE_CURRENT, @lsPath[0]);
  result := lsPath;
end;

{------------------------------------------------------------------------------}
{TppFileUtils.GetLibraryFileName }

class function TppFileUtils.GetLibraryFileName: String;
var
  lsFileName: String;
  liNameLength: Integer;
begin

  if IsLibrary then
    begin
      SetLength(lsFileName, Max_Path);

      liNameLength := GetModuleFileName(HInstance, PChar(lsFileName), Length(lsFileName));

      if (liNameLength > 0) then
        SetLength(lsFileName, liNameLength)
      else
        lsFileName := '';

    end
  else
    lsFileName := GetApplicationFileName;

  if (Pos('~', lsFileName) > 0) then
    Result := GetLongFileName(lsFileName);


  Result := lsFileName;

end;

{------------------------------------------------------------------------------}
{TppFileUtils.GetLibraryFilePath }

class function TppFileUtils.GetLibraryFilePath: String;
begin
  Result := ExtractFilePath(GetLibraryFileName);

end;

{------------------------------------------------------------------------------}
{TppFileUtils.GetLibraryShortFilePath }

class function TppFileUtils.GetLibraryShortFilePath: String;
var
  lsShortPathFileName: String;
begin

  lsShortPathFileName := ExtractShortPathName(GetLibraryFileName);

  Result := ExtractFilePath(lsShortPathFileName);

end;

{------------------------------------------------------------------------------}
{TppFileUtils.GetLongFileName }

class function TppFileUtils.GetLongFileName(aFileName: String): String;
var
  lSearchRec: TSearchRec;
  lPathStrings: TStringList;
  liIndex: Integer;
begin

  if not FileExists(aFileName) then
    raise EReportBuilderError.Create('TppFileUtils.GetLongFileName: File does not exist, ' + aFileName);

  lPathStrings := TStringList.Create;

  try
    {use TString list to parse the path}
    lPathStrings.Delimiter := '\';
    lPathStrings.DelimitedText := aFileName;

    liIndex := lPathStrings.Count-1;
    Result := '';

    {use GetFileSearchRec to find the long name of of each element in the path,
      starting with the filename and working backwards to each parent folder}
    while liIndex > 0 do
      begin
        GetFileSearchRec(lPathStrings.DelimitedText, lSearchRec);

        if Result <> '' then
          Result := '\' + Result;

        Result := lSearchRec.FindData.cFileName + Result;

        lPathStrings.Delete(liIndex);
        Dec(liIndex);

      end;

    {first string contains the drive info}
    Result := lPathStrings[0] + '\' + Result;

  finally
    lPathStrings.Free;

  end;

end;

{------------------------------------------------------------------------------}
{TppFileUtils.GetFileSearchRec }

class function TppFileUtils.GetFileSearchRec(aFileName: String; var aSearchRec: TSearchRec): Boolean;
var
  liFindStatus: Integer;
begin

  liFindStatus := FindFirst(aFileName, faAnyFile, aSearchRec);
  FindClose(aSearchRec);

  Result := (liFindStatus = 0);

end; {class procedure, GetFileSearchRec}

{-------------------------------------------------------------------------------}
{TppFileUtils.GetFileNamesForDirectory }

class procedure TppFileUtils.GetFileNamesForDirectory(aDirectory: String; aFileExtension: String; aList: TStrings);
var
  lsPathWithFileSpec: String;
  lExtension: String;
begin

  if (aFileExtension = '') then
    lExtension := '*'
  else
    lExtension := aFileExtension;

  lsPathWithFileSpec := IncludeTrailingPathDelimiter(aDirectory) + '*.' + lExtension;

  GetFileNamesForDirectory(lsPathWithFileSpec, aList);


end; {class procedure, GetFileNamesForDirectory}

class procedure TppFileUtils.GetFileNamesForDirectory(aPathWithFileSpec: String; aList: TStrings);
var
  liStatus: Integer;
  lSearchRec: TSearchRec;
begin
  
  liStatus := FindFirst(aPathWithFileSpec, faAnyFile, lSearchRec);
  
  try

    while (liStatus = 0) do
      begin

        if ((lSearchRec.Attr and faDirectory) = 0) then
          if (lSearchRec.Name <> '.') and (lSearchRec.Name <> '..') then
            aList.Add(lSearchRec.Name);

        liStatus := FindNext(lSearchRec);

      end;

  finally
    FindClose(lSearchRec);
  end;

end;


{-------------------------------------------------------------------------------}
{TppFileUtils.GetReportNamesForDirectory }

class procedure TppFileUtils.GetReportNamesForDirectory(aDirectory: String; aFileExtension: String; aList: TStrings);
var
  liIndex: Integer;
  lsFileName: String;
  lsExtension: String;
begin

  GetFileNamesForDirectory(aDirectory, aFileExtension, aList);

  for liIndex := 0 to aList.Count-1 do
    begin
      lsFileName := aList[liIndex];
      lsExtension := '.' + aFileExtension;
      aList[liIndex] := StringReplace(lsFileName, lsExtension, '', [rfIgnoreCase]);
    end;

end; class function TppFileUtils.GetSystemFilePath: String;
begin
  SetLength(Result, MAX_PATH);
  SetLength(Result, Windows.GetSystemDirectory(PChar(Result), MAX_PATH));
end;

{class procedure, GetReportNamesForDirectory}

{------------------------------------------------------------------------------}
{ TppFileUtils.GetFolderNamesForDirectory }

class procedure TppFileUtils.GetFolderNamesForDirectory(const aDirectory: string; aNameList: TStrings);
var
  liStatus: Integer;
  lSearchRec: TSearchRec;
  lsParentDirectory: String;
begin

  if (aDirectory <> '') then
    begin
      lsParentDirectory := IncludeTrailingPathDelimiter(aDirectory) + '*.*';;

      liStatus := FindFirst(lsParentDirectory, faDirectory, lSearchRec);

      try

        while (liStatus = 0) do
          begin

            if ((lSearchRec.Attr and faDirectory) <> 0) then
              if (lSearchRec.Name <> '.') and (lSearchRec.Name <> '..') then
                aNameList.Add(lSearchRec.Name);

            liStatus := FindNext(lSearchRec);

          end;

      finally
        FindClose(lSearchRec);
      end;

    end;
    

end; {class procedure, GetFolderNamesForDirectory}

{------------------------------------------------------------------------------}
{ TppFileUtils.ParseDirectoryPath }

class procedure TppFileUtils.ParseDirectoryPath(aDirectoryPath: String; aStrings: TStrings);
begin

  ParseDirectoryPath(aDirectoryPath, aStrings, '\');

end; {class procedure, ParseDirectoryPath}

{$IFDEF UNICODE}

class procedure TppFileUtils.StringToFile(aString, aFileName: String);
var
  lFileStream: TFileStream;
  lBytes: TBytes;
begin

  if (aString <> '') then
    try
      lFileStream := TFileStream.Create(aFileName, fmCreate);

      try
        // use UTF 8 encoding
        lBytes := TEncoding.UTF8.GetBytes(aString);
        lFileStream.Write(lBytes[0], Length(lBytes));
      finally
        lFileStream.Free;
      end;

    except
    end;

end;
{$ELSE}

{@TppFileUtils.StringToFile }

class procedure TppFileUtils.StringToFile(aString, aFileName: String);
var
  lFileStream: TFileStream;
begin

  if (aString <> '') then
    try

      lFileStream := TFileStream.Create(aFileName, fmCreate);

      try
        lFileStream.Write(aString[1], Length(aString));
      finally
        lFileStream.Free;
      end;

    except
    end;

end;

{$ENDIF}


{$IFDEF UNICODE}

{@TppFileUtils.FileToString }

class function TppFileUtils.FileToString(aFileName: String): String;
var
  lFileStream: TFileStream;
  lBytes: TBytes;
begin

  Result := '';

  if (FileExists(aFileName)) then
    try

      lFileStream := TFileStream.Create(aFileName, fmOpenRead);

      try
        // read bytes
        SetLength(lBytes, lFileStream.Size);
        lFileStream.ReadBuffer(lBytes[0], lFileStream.Size);
        
        // decode UTF8 bytes
        Result := TEncoding.UTF8.GetString(lBytes);

      finally
        lFileStream.Free;
      end;

    except
    end;

end;

{$ELSE}

{@TppFileUtils.FileToString }

class function TppFileUtils.FileToString(aFileName: String): String;
var
  lFileStream: TFileStream;
begin

  Result := '';

  if (FileExists(aFileName)) then
    try

      lFileStream := TFileStream.Create(aFileName, fmOpenRead);

      try
        SetLength(Result, lFileStream.Size);
        lFileStream.ReadBuffer(Pointer(Result)^, lFileStream.Size);

      finally
        lFileStream.Free;
      end;

    except
    end;

end;

{$ENDIF}

{@TppFileUtils.RemoveDirContents }

class procedure TppFileUtils.RemoveDirContents(aDirName: String);
var
  lSearchRec: TSearchRec;
  liStatus: Integer;
begin

  liStatus := FindFirst(aDirName + '\*.*', faAnyFile, lSearchRec); {first always '.' }

  try
    {remove files in this directory and recursively call this method for each directory}
    while (liStatus = 0) do
      begin

        if (lSearchRec.Name = '..') or (lSearchRec.Name = '.') then
          {do nothing }
        else if (lSearchRec.Attr and faDirectory) > 0 then
          RemoveDirAndContents(aDirName + '\' + lSearchRec.name)
        else
          Deletefile(aDirName + '\' + lSearchRec.name);

        liStatus := FindNext(lSearchRec);

      end;

  finally
    FindClose(lSearchRec);
  end

end;


{@TppFileUtils.RemoveDirAndContents }

class procedure TppFileUtils.RemoveDirAndContents(aDirName: String);
begin

  RemoveDirContents(aDirName);

  RemoveDir(aDirName);

end;


{@TppFileUtils.ComponentToFile }

class procedure TppFileUtils.ComponentToFile(aComponent: TComponent; aFileName: String);
var
  lFileStream: TFileStream;
  lMemoryStream: TMemoryStream;
begin

  try

    DeleteFile(aFileName);

    lMemoryStream := TMemoryStream.Create;

    try

      lMemoryStream.WriteComponent(aComponent);
      lMemoryStream.Position := 0;

      lFileStream := TFileStream.Create(aFileName, fmCreate);

      try
        ObjectBinaryToText(lMemoryStream, lFileStream);
      finally
        lFileStream.Free;
      end;

    finally
      lMemoryStream.Free;
    end;

  except
  end;

end;


{@TppFileUtils.FileToComponent }

class function TppFileUtils.FileToComponent(aFileName: String): TComponent;
var
  lFileStream: TFileStream;
  lMemoryStream: TMemoryStream;
begin

  try

    Result := nil;

    if FileExists(aFileName) then
      begin

        lMemoryStream := TMemoryStream.Create;

        try

          lFileStream := TFileStream.Create(aFileName, fmOpenRead);

          try
            ObjectTextToBinary(lFileStream, lMemoryStream);
          finally
            lFileStream.Free;
          end;

          lMemoryStream.Position := 0;
          Result := lMemoryStream.ReadComponent(nil);

        finally
          lMemoryStream.Free;
        end;

      end;

  except
    Result := nil;
  end;

end;

{------------------------------------------------------------------------------}
{ TppFileUtils.GetLocalAppDataPath }

class function TppFileUtils.GetLocalAppDataPath: String;
var
  lsPath: array [0..MAX_PATH] of char;
begin
  SHGetFolderPath(0, CSIDL_LOCAL_APPDATA, 0, SHGFP_TYPE_CURRENT, @lsPath[0]);
  result := lsPath;
end;

{------------------------------------------------------------------------------}
{ TppFileUtils.GetWindowsFilePath }

class function TppFileUtils.GetWindowsFilePath: String;
begin
  SetLength(Result, MAX_PATH);
  SetLength(Result, Windows.GetWindowsDirectory(PChar(Result), MAX_PATH));
end;

{------------------------------------------------------------------------------}
{ TppFileUtils.GetTempFilePath }

class function TppFileUtils.GetTempFilePath: string;
begin
  SetLength(Result, MAX_PATH);
  SetLength(Result, Windows.GetTempPath(MAX_PATH, PChar(Result)));
end;

{------------------------------------------------------------------------------}
{ TppFileUtils.ParseDirectoryPath }

class procedure TppFileUtils.ParseDirectoryPath(aDirectoryPath: String; aStrings: TStrings; aDelimiter: Char);
var
  lsString: String;
  liPosition: Integer;
begin

  aStrings.Clear;

  lsString := aDirectoryPath;

  liPosition := Pos(aDelimiter, lsString);

  {if path starts with a aDelimiter, strip it off}
  if (liPosition = 1) then
    begin
      lsString := Copy(lsString, liPosition + 1, Length(lsString));
      liPosition := Pos(aDelimiter, lsString);
    end;

  while (liPosition <> 0) do
    begin
      aStrings.Add(Copy(lsString, 1, liPosition - 1));

      lsString := Copy(lsString, liPosition + 1, Length(lsString));

      liPosition := Pos(aDelimiter, lsString);
    end;

  if (Length(lsString) > 0) then
    aStrings.Add(lsString);

end; {class procedure, ParseDirectoryPath}

class function TppFileUtils.RemoveFileExtension(const aFileName: String): String;
begin

  Result := ChangeFileExt(ExtractFileName(aFileName), '');

end;

class procedure TppFileUtils.SeparateRootFolderFromPath(aPath: String; var aRootFolder, aRemainingPath: String);
var
  liPosition: Integer;
begin

  liPosition := Pos('\', aPath);

  aRootFolder := Copy(aPath, 1, liPosition - 1);

  aRemainingPath := Copy(aPath, liPosition+1, Length(aPath));

end;


{ TppFilePathVariables }

class function TppFilePathVariables.Application: String;
begin
  Result := '($Application)';
end;

class function TppFilePathVariables.CommonAppData: String;
begin
  Result := '($CommonAppData)';

end;

class function TppFilePathVariables.ContainsVariable(const aVariable, aFilePath: String): Boolean;
begin
  Result := Pos(UpperCase(aVariable), UpperCase(aFilePath)) > 0;

end;

class function TppFilePathVariables.CreateList: TStrings;
begin

  if (uPathVariableList = nil) then
    begin
      uPathVariableList := TStringList.Create;
      uPathVariableList.Add(TppFilePathVariables.Application);
      uPathVariableList.Add(TppFilePathVariables.CommonAppData);
      uPathVariableList.Add(TppFilePathVariables.LocalAppData);
      uPathVariableList.Add(TppFilePathVariables.System);
      uPathVariableList.Add(TppFilePathVariables.Temp);
      uPathVariableList.Add(TppFilePathVariables.WinSys);
    end;

  Result := uPathVariableList;

end;

class function TppFilePathVariables.GetList: TStrings;
begin
  if (uPathVariableList = nil) then
    TppFilePathVariables.CreateList;

  Result := uPathVariableList;

end;

class function TppFilePathVariables.LocalAppData: String;
begin
  Result := '($LocalAppData)';

end;

class function TppFilePathVariables.MainApplication: String;
begin
  Result := '($MainApplication)';

end;

class function TppFilePathVariables.ResolveFilePath(const aFilePath: String): String;
begin

  if ContainsVariable(TppFilePathVariables.LocalAppData, aFilePath) then
    Result := StringReplace(aFilePath, TppFilePathVariables.LocalAppData, TppFileUtils.GetLocalAppDataPath, [rfIgnoreCase])

  else if ContainsVariable(TppFilePathVariables.CommonAppData, aFilePath) then
    Result := StringReplace(aFilePath, TppFilePathVariables.CommonAppData, TppFileUtils.GetCommonAppDataPath, [rfIgnoreCase])

  else if ContainsVariable(TppFilePathVariables.Temp, aFilePath) then
    Result := StringReplace(aFilePath, TppFilePathVariables.Temp, TppFileUtils.GetTempFilePath, [rfIgnoreCase])

  else if ContainsVariable(TppFilePathVariables.Application, aFilePath) then
    begin
      if IsLibrary then
        Result := StringReplace(aFilePath, TppFilePathVariables.Application, TppFileUtils.GetLibraryFilePath, [rfIgnoreCase])
      else
        Result := StringReplace(aFilePath, TppFilePathVariables.Application, TppFileUtils.GetApplicationFilePath, [rfIgnoreCase]);
    end

  else if ContainsVariable(TppFilePathVariables.MainApplication, aFilePath) then
    Result := StringReplace(aFilePath, TppFilePathVariables.MainApplication, TppFileUtils.GetApplicationFilePath, [rfIgnoreCase])

  else if ContainsVariable(TppFilePathVariables.System, aFilePath) then
    Result := StringReplace(aFilePath, TppFilePathVariables.System, TppFileUtils.GetSystemFilePath, [rfIgnoreCase])

  else if ContainsVariable(TppFilePathVariables.WinSys, aFilePath) then
    Result := StringReplace(aFilePath, TppFilePathVariables.WinSys, TppFileUtils.GetSystemFilePath, [rfIgnoreCase])

  else
    Result := aFilePath;

end;

class function TppFilePathVariables.System: string;
begin
  Result := '($System)';

end;

class function TppFilePathVariables.Temp: String;
begin
  Result := '($Temp)';

end;

class function TppFilePathVariables.WinSys: String;
begin
  Result := '($WinSys)';

end;

initialization

finalization

  uPathVariableList.Free;
  uPathVariableList := nil;

end.

