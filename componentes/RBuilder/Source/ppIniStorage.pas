{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2008                    BBBBB   }

unit ppIniStorage;

interface

uses
  Windows,
  Classes,
  SysUtils,
  IniFiles,
  Registry,

  ppUtils,
  ppFileUtils;

type

  TppIniStorage = class;
  TppIniStorageClass = class of TppIniStorage;

  {@TppIniStoragePlugIns
     - IniStorage class registry
     - enables plug-in classes to be registered and unregistered
     - provides access to list of registered plug-ins classes}
  TppIniStoragePlugIns = class
    private

    public
      class procedure Register(aIniStorageClass: TppIniStorageClass);
      class procedure UnRegister(aIniStorageClass: TppIniStorageClass);

      class procedure GetClasses(var aList: TStrings);
      class function GetClassForIndex(aIndex: Integer): TppIniStorageClass;
      class function GetClassForName(aPlugInName: String): TppIniStorageClass;

    end; {class, TppIniStoragePlugIns}


  {@TppIniStoragePlugIn
    - allows a system global StorageClass and StorageName to be specified
    - class factory for the system global IniStorage class}
  TppIniStoragePlugIn = class
    private

    public
      class function CreateInstance: TppIniStorage;

      class function GetStorageName: String;
      class function GetStorageClass: TppIniStorageClass;

      class procedure SetClass(aIniStorageClass: TppIniStorageClass);
      class procedure SetStorageName(aStorageName: String);


    end; {class, TppIniStoragePlugIn}


  {@TppIniStorage
    - abstract ancestor for IniStorage plug-in classes
    - provides method to read and write state data}
  TppIniStorage = class
    private

    protected

    public
      constructor Create(aStorageName: String); virtual;

      class function ClassDescription: String; virtual; abstract;
      class function DefaultStorageName: String; virtual; abstract;

      procedure EraseSection(const Section: String); virtual; abstract;

      function ReadBool (const Section, Ident: String; Default: Boolean): Boolean; virtual; abstract;
      function ReadDate (const Section, Ident: string; Default: TDateTime): TDateTime; virtual; abstract;
      function ReadDateTime (const Section, Ident: String; Default: TDateTime): TDateTime; virtual; abstract;
      function ReadFloat (const Section, Ident: String; Default: Double): Double;  virtual; abstract;
      function ReadInteger(const Section, Ident: String; Default: Longint): Longint; virtual; abstract;
      function ReadString(const Section, Ident, Default: string): string; virtual; abstract;
      function ReadTime (const Section, Ident: String; Default: TDateTime): TDateTime; virtual; abstract;

      procedure WriteBool(const Section, Ident: String; Value: Boolean); virtual; abstract;
      procedure WriteDate(const Section, Ident: String; Value: TDateTime); virtual; abstract;
      procedure WriteDateTime(const Section, Ident: String; Value: TDateTime); virtual; abstract;
      procedure WriteFloat(const Section, Ident: String; Value: Double); virtual; abstract;
      procedure WriteInteger(const Section, Ident: String; Value: Longint); virtual; abstract;
      procedure WriteString(const Section, Ident, Value: String); virtual; abstract;
      procedure WriteTime(const Section, Ident: String; Value: TDateTime); virtual; abstract;

    end; {class, TppIniStorage}


  {@TppCustomIniFileStorage
    - descends from TppIniStorage and implements all read and write methods
    - serves as the abstract ancestor for descendants that utilize Delphi's TCustomIniFile
    - TppCustomIniFileStorage descendants must implement the CreateIniFile method}
  TppCustomIniFileStorage = class(TppIniStorage)
    private
      FCustomIniFile: TCustomIniFile;
      FModified: Boolean;

    protected
      function CreateCustomIniFile(aStorageName: String): TCustomIniFile; virtual; abstract;

      property CustomIniFile: TCustomIniFile read FCustomIniFile;
      property Modified: Boolean read FModified write FModified;

    public
      constructor Create(aStorageName: String); override;
      destructor Destroy; override;

      procedure EraseSection(const Section: String); override;

      function ReadBool (const Section, Ident: String; Default: Boolean): Boolean; override;
      function ReadDate (const Section, Ident: string; Default: TDateTime): TDateTime; override;
      function ReadDateTime (const Section, Ident: String; Default: TDateTime): TDateTime; override;
      function ReadFloat (const Section, Ident: String; Default: Double): Double;  override;
      function ReadInteger(const Section, Ident: String; Default: Longint): Longint; override;
      function ReadString(const Section, Ident, Default: string): string; override;
      function ReadTime (const Section, Ident: String; Default: TDateTime): TDateTime; override;

      procedure WriteBool(const Section, Ident: String; Value: Boolean); override;
      procedure WriteDate(const Section, Ident: String; Value: TDateTime); override;
      procedure WriteDateTime(const Section, Ident: String; Value: TDateTime); override;
      procedure WriteFloat(const Section, Ident: String; Value: Double); override;
      procedure WriteInteger(const Section, Ident: String; Value: Longint); override;
      procedure WriteString(const Section, Ident, Value: String); override;
      procedure WriteTime(const Section, Ident: String; Value: TDateTime); override;

    end; {class, TppCustomIniFileStorage}

    
  {@TppIniFile
    - IniFile storage plug-in
    - enables state information to be stored in an .Ini file}
  TppIniFile = class(TppCustomIniFileStorage)
    private
    protected
      function CreateCustomIniFile(aStorageName: String): TCustomIniFile; override;

    public
      destructor Destroy; override;
      class function ClassDescription: String; override;
      class function DefaultStorageName: String; override;
  end; {class, TppIniFile}


  {@TppRegistry
    - Registry storage plug-in
    - enables state information to be stored in the Windows Registry }
  TppRegistry = class(TppCustomIniFileStorage)
    protected
      function CreateCustomIniFile(aStorageName: String): TCustomIniFile; override;

    public
      class function ClassDescription: String; override;
      class function DefaultStorageName: String; override;

  end; {class, TppRegistry}


  {@TppIniNone
    - IniFile storage plug-in
    - enables state information to exists in memory only, not stored}
  TppIniNone = class(TppCustomIniFileStorage)
    private
    protected
      function CreateCustomIniFile(aStorageName: String): TCustomIniFile; override;

    public
      class function ClassDescription: String; override;
      class function DefaultStorageName: String; override;
  end;



implementation

const
  cRBuilderIniPathAndFile = '\RBuilder\RBuilder.ini';

var
  FStorageClass: TppIniStorageClass;
  FStorageName: String;
  FPlugIns: TList;


{******************************************************************************
 *
 ** S T A T E  S T O R A G E   P L U G - I N S
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppIniStoragePlugIns.Register }

class procedure TppIniStoragePlugIns.Register(aIniStorageClass: TppIniStorageClass);
begin
  FPlugIns.Add(aIniStorageClass);

end; {class procedure, Register}

{------------------------------------------------------------------------------}
{ TppIniStoragePlugIns.UnRegister }

class procedure TppIniStoragePlugIns.UnRegister(aIniStorageClass: TppIniStorageClass);
begin
  FPlugIns.Remove(aIniStorageClass);

end; {class procedure, UnRegister}

{------------------------------------------------------------------------------}
{ TppIniStoragePlugIns.GetClasses }

class procedure TppIniStoragePlugIns.GetClasses(var aList: TStrings);
var
  liIndex: Integer;
  lStorageClass: TppIniStorageClass;
begin

  for liIndex := 0 to FPlugIns.Count-1 do
    begin
      lStorageClass := TppIniStorageClass(FPlugins[liIndex]);
      aList.AddObject(lStorageClass.ClassDescription, Pointer(lStorageClass));
    end;

end; {class procedure, GetClasses}

{------------------------------------------------------------------------------}
{ TppIniStoragePlugIns.GetClassForIndex }

class function TppIniStoragePlugIns.GetClassForIndex(aIndex: Integer): TppIniStorageClass;
begin
  Result := TppIniStorageClass(FPlugins[aIndex]);

end; {class function, GetClassForIndex}

{------------------------------------------------------------------------------}
{ TppIniStoragePlugIns.GetClassForName }

class function TppIniStoragePlugIns.GetClassForName(aPlugInName: String): TppIniStorageClass;
var
  liIndex: Integer;
  lStorageClass: TppIniStorageClass;
begin

  Result := nil;
  liIndex := 0;

  while (Result = nil) and (liIndex < FPlugins.Count) do
    begin
      lStorageClass := TppIniStorageClass(FPlugins[liIndex]);

      if (AnsiCompareText(aPlugInName, lStorageClass.ClassDescription) = 0) then
        Result :=  lStorageClass;

      Inc(liIndex);

    end;

end; {class function, GetClassForName}


{******************************************************************************
 *
 ** S T A T E  S T O R A G E   P L U G - I N
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppIniStoragePlugIn.CreateInstance }

class function TppIniStoragePlugIn.CreateInstance: TppIniStorage;
begin
  Result := FStorageClass.Create(FStorageName);

end; {class procedure, CreateInstance}

{------------------------------------------------------------------------------}
{ TppIniStoragePlugIn.SetClass }

class procedure TppIniStoragePlugIn.SetClass(aIniStorageClass: TppIniStorageClass);
begin
  FStorageClass := aIniStorageClass;

end; {class procedure, SetClass}

{------------------------------------------------------------------------------}
{ TppIniStoragePlugIn.SetStorageName }

class procedure TppIniStoragePlugIn.SetStorageName(aStorageName: String);
begin
  FStorageName := aStorageName;

end; {class procedure, SetStorageName}

{------------------------------------------------------------------------------}
{ TppIniStoragePlugIn.GetStorageName }

class function TppIniStoragePlugIn.GetStorageName: String;
begin
  Result := FStorageName;
  
end; {class function, GetStorageName}

{------------------------------------------------------------------------------}
{ TppIniStoragePlugIn.GetStorageClass }

class function TppIniStoragePlugIn.GetStorageClass: TppIniStorageClass;
begin
  Result := FStorageClass;
  
end; {class function, GetStorageClass}


{******************************************************************************
 *
 ** S T A T E   S T O R A G E
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppIniStorage.Create }

constructor TppIniStorage.Create(aStorageName: String);
begin
  inherited Create;

end; {function, Create}

{******************************************************************************
 *
 ** C U S T O M   I N I   S T O R A G E
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppCustomIniFileStorage.Create }

constructor TppCustomIniFileStorage.Create(aStorageName: String);
begin

  inherited Create(aStorageName);

  FCustomIniFile := CreateCustomIniFile(aStorageName);

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppCustomIniFileStorage.Destroy }

destructor TppCustomIniFileStorage.Destroy;
begin
  FCustomIniFile.Free;
  FCustomIniFile := nil;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppCustomIniFileStorage.EraseSection }

procedure TppCustomIniFileStorage.EraseSection(const Section: String);
begin
  FCustomIniFile.EraseSection(Section);

end; {procedure, EraseSection}

{------------------------------------------------------------------------------}
{ TppCustomIniFileStorage.ReadBool }

function TppCustomIniFileStorage.ReadBool (const Section, Ident: String; Default: Boolean): Boolean;
begin
  Result := FCustomIniFile.ReadBool(Section, Ident, Default);

end; {function, ReadBool}

{------------------------------------------------------------------------------}
{ TppCustomIniFileStorage.ReadDate }

function TppCustomIniFileStorage.ReadDate (const Section, Ident: string; Default: TDateTime): TDateTime;
begin
  Result := FCustomIniFile.ReadDate(Section, Ident, Default);

end; {function, ReadDate}

{------------------------------------------------------------------------------}
{ TppCustomIniFileStorage.ReadDateTime }

function TppCustomIniFileStorage.ReadDateTime (const Section, Ident: String; Default: TDateTime): TDateTime;
begin
  Result := FCustomIniFile.ReadDateTime(Section, Ident, Default);

end; {function, ReadDateTime}

{------------------------------------------------------------------------------}
{ TppCustomIniFileStorage.ReadFloat }

function TppCustomIniFileStorage.ReadFloat (const Section, Ident: String; Default: Double): Double;
begin
  Result := FCustomIniFile.ReadFloat(Section, Ident, Default);

end; {function, ReadFloat}

{------------------------------------------------------------------------------}
{ TppCustomIniFileStorage.ReadInteger }

function TppCustomIniFileStorage.ReadInteger(const Section, Ident: String; Default: Longint): Longint;
begin
  Result := FCustomIniFile.ReadInteger(Section, Ident, Default);

end; {function, ReadInteger}

{------------------------------------------------------------------------------}
{ TppCustomIniFileStorage.ReadString }

function TppCustomIniFileStorage.ReadString(const Section, Ident, Default: String): String;
begin
  Result := FCustomIniFile.ReadString(Section, Ident, Default);

end; {function, ReadString}

{------------------------------------------------------------------------------}
{ TppCustomIniFileStorage.ReadTime }

function TppCustomIniFileStorage.ReadTime(const Section, Ident: String; Default: TDateTime): TDateTime;
begin
  Result := FCustomIniFile.ReadTime(Section, Ident, Default);

end; {function, ReadTime}

{------------------------------------------------------------------------------}
{ TppCustomIniFileStorage.WriteBool }

procedure TppCustomIniFileStorage.WriteBool(const Section, Ident: String; Value: Boolean);
begin
  FCustomIniFile.WriteBool(Section, Ident, Value);

  FModified := True;

end; {procedure, WriteBool}

{------------------------------------------------------------------------------}
{ TppCustomIniFileStorage.WriteDate }

procedure TppCustomIniFileStorage.WriteDate(const Section, Ident: String; Value: TDateTime);
begin
  FCustomIniFile.WriteDate(Section, Ident, Value);
  FModified := True;

end; {procedure, WriteDate}

{------------------------------------------------------------------------------}
{ TppCustomIniFileStorage.WriteDateTime }

procedure TppCustomIniFileStorage.WriteDateTime(const Section, Ident: String; Value: TDateTime);
begin
   FCustomIniFile.WriteDateTime(Section, Ident, Value);
  FModified := True;

end; {procedure, WriteDateTime}

{------------------------------------------------------------------------------}
{ TppCustomIniFileStorage.WriteFloat }

procedure TppCustomIniFileStorage.WriteFloat(const Section, Ident: String; Value: Double);
begin
  FCustomIniFile.WriteFloat(Section, Ident, Value);
  FModified := True;

end; {procedure, WriteFloat}

{------------------------------------------------------------------------------}
{ TppCustomIniFileStorage.WriteInteger }

procedure TppCustomIniFileStorage.WriteInteger(const Section, Ident: String; Value: Longint);
begin
  FCustomIniFile.WriteInteger(Section, Ident, Value);
  FModified := True;

end; {procedure, WriteInteger}

{------------------------------------------------------------------------------}
{ TppCustomIniFileStorage.WriteString }

procedure TppCustomIniFileStorage.WriteString(const Section, Ident, Value: String);
begin
  FCustomIniFile.WriteString(Section, Ident, Value);
  FModified := True;

end; {procedure, WriteString}

{------------------------------------------------------------------------------}
{ TppCustomIniFileStorage.WriteTime }

procedure TppCustomIniFileStorage.WriteTime(const Section, Ident: String; Value: TDateTime);
begin
  FCustomIniFile.WriteTime(Section, Ident, Value);
  FModified := True;

end; {procedure, WriteTime}


{******************************************************************************
 *
 ** I N I   F I L E
 *
{******************************************************************************}

destructor TppIniFile.Destroy;
var
  lsPath: String;
begin

  // check for design-time or designer or client report explorer
  if Modified and (gbDesignTime or (GetClass('TppDesigner') <> nil) or (GetClass('TrsClientReportExplorer') <> nil)) then
    begin
      lsPath := ExtractFilePath(CustomIniFile.FileName);
      ForceDirectories(lsPath);
      TMemIniFile(CustomIniFile).UpdateFile;
    end;

  inherited;

end;

{------------------------------------------------------------------------------}
{ TppIniFile.CreateCustomIniFile }

function TppIniFile.CreateCustomIniFile(aStorageName: String): TCustomIniFile;
begin
  // replace constants
  if Pos(TppFilePathVariables.WinSys, aStorageName) > 0 then
    // backwards compatibility, resolve ($WinSys) to Windows directory
    aStorageName := StringReplace(aStorageName, TppFilePathVariables.WinSys, TppFileUtils.GetWindowsFilePath, [rfIgnoreCase])

  else
    aStorageName := TppFilePathVariables.ResolveFilePath(aStorageName);
  
  Result := TMemIniFile.Create(aStorageName);

end; {function, CreateCustomIniFile}

{------------------------------------------------------------------------------}
{ TppIniFile.Description }

class function TppIniFile.ClassDescription: String;
begin
  Result := 'IniFile';

end; {class function, Description}

{------------------------------------------------------------------------------}
{ TppIniFile.DefaultStorageName }

class function TppIniFile.DefaultStorageName: String;
begin
  Result := TppFilePathVariables.LocalAppData + cRBuilderIniPathAndFile;

end; {class function, DefaultStorageName}


{******************************************************************************
 *
 ** R E G I S T R Y
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppRegistry.CreateCustomIniFile }

function TppRegistry.CreateCustomIniFile(aStorageName: String): TCustomIniFile;
begin
  Result := TRegistryIniFile.Create(aStorageName)

end; {function, CreateCustomIniFile}

{------------------------------------------------------------------------------}
{ TppRegistry.Description }

class function TppRegistry.ClassDescription: String;
begin
  Result := 'Registry';

end; {class function, Description}

{------------------------------------------------------------------------------}
{ TppRegistry.DefaultStorageName }

class function TppRegistry.DefaultStorageName: String;
begin
  Result := 'RBuilder';

end; {class function, DefaultStorageName}

{******************************************************************************
 *
 ** IniNone
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppIniNone.CreateCustomIniFile }

function TppIniNone.CreateCustomIniFile(aStorageName: String): TCustomIniFile;
begin

  Result := TMemIniFile.Create('');

end; {function, CreateCustomIniFile}

{------------------------------------------------------------------------------}
{ TppIniNone.Description }

class function TppIniNone.ClassDescription: String;
begin
  Result := 'IniNone';

end; {class function, Description}

{------------------------------------------------------------------------------}
{ TppIniNone.DefaultStorageName }

class function TppIniNone.DefaultStorageName: String;
begin
  Result := 'RBuilder';

end; {class function, DefaultStorageName}



initialization

  FPlugIns := TList.Create;
  FStorageClass := TppIniFile;
  FStorageName := TppFilePathVariables.LocalAppdata + cRBuilderIniPathAndFile;

  TppIniStoragePlugIns.Register(TppIniFile);
  TppIniStoragePlugIns.Register(TppRegistry);
  TppIniStoragePlugIns.Register(TppIniNone);

finalization

  TppIniStoragePlugIns.UnRegister(TppIniFile);
  TppIniStoragePlugIns.UnRegister(TppRegistry);
  TppIniStoragePlugIns.UnRegister(TppIniNone);

  FPlugIns.Free;
  FPlugIns := nil;

end.
