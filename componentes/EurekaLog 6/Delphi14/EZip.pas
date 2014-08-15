{************************************************}
{                                                }
{               EurekaLog v 6.x                  }
{               Zip Unit - EZip                  }
{                                                }
{  Copyright (c) 2001 - 2008 by Fabio Dell'Aria  }
{                                                }
{************************************************}

unit EZip;

{$I Exceptions.inc}

interface

uses
  Windows,
	SysUtils,
	Classes;

type
  TZipExtractor = class
  protected
    FStream: TMemoryStream;
    FBytesToGo: Integer;
  public
    constructor Create(const InputName, OutDir, Password: AnsiString);
  end;

  TZipWriter = class
  protected
    FZipHandle: THandle;
    FPassword: AnsiString;
  public
    constructor Create(const FileName, Password: AnsiString);
    destructor Destroy; override;
    procedure AddFile(const FileName, ArchiveFileName: AnsiString);
  end;

//------------------------------------------------------------------------------

implementation

uses EZLib2;

{ TZipExtractor }

constructor TZipExtractor.Create(const InputName, OutDir, Password: AnsiString);
begin
  ExtractZipFiles(PAnsiChar(InputName), PAnsiChar(OutDir), PAnsiChar(Password));
end;

{ TZipWriter }

constructor TZipWriter.Create(const FileName, Password: AnsiString);
begin
  FZipHandle := CreateZipFile(PAnsiChar(FileName));
  FPassword := Password;
end;

procedure TZipWriter.AddFile(const FileName, ArchiveFileName: AnsiString);
begin
  AddZipFile(FZipHandle, PAnsiChar(FileName), PAnsiChar(ArchiveFileName), PAnsiChar(FPassword));
end;

destructor TZipWriter.Destroy;
begin
  CloseZipFile(FZipHandle);
  inherited;
end;

end.

