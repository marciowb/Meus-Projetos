{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2009                    BBBBB   }

unit ppPDFEncrypt;

interface

uses
  Classes,
  ppPDFObject,
  ppPDFSettings,
  ppDCPmd5,
  ppDCPrc4;

type

{@TppPDFEncrypt

  Encryption Dictionary for the PDF file.}

  TppPDFEncrypt = class(TppPDFObject)
    private
      FEncryptSettings: TppPDFEncryptSettings;
      FOwnerKey: String;
      FUserKey: String;
      FFileID: String;
      FKeyPadding: String;
      FMD5Hash: TppDCP_md5;
      FRC4Cipher: TppDCP_rc4;

      procedure CreateEncryptionKey;
      procedure CreateOwnerKey;
      procedure CreateUserKey;

      function  GetKeyLength: Integer;
      function  GetKeyPadding: String;
      function  GetPermissions: Integer;
      procedure SetEncryptSettings(const Value: TppPDFEncryptSettings);

    protected
      procedure Init;

    public
      constructor Create; override;
      destructor Destroy; override;

      procedure Write(aOutputStream: TStream; aReferenceNumber: Integer); override;

      property EncryptSettings: TppPDFEncryptSettings read FEncryptSettings write SetEncryptSettings;
      property FileID: string read FFileID write FFileID;

  end;

implementation

uses
  SysUtils,
  StrUtils,
  ppUtils,
  ppPDFUtils;

const
  cKeyPadding: array[0..31] of Byte = ($28, $BF, $4E, $5E, $4E, $75, $8A, $41, $64, $00, $4E,
                                       $56, $FF, $FA, $01, $08, $2E, $2E, $00, $B6, $D0, $68,
                                       $3E, $80, $2F, $0C, $A9, $FE, $64, $53, $69, $7A);

constructor TppPDFEncrypt.Create;
begin
  inherited;

  FEncryptSettings := TppPDFEncryptSettings.Create;
  FMD5Hash := TppDCP_md5.Create(nil);
  FRC4Cipher := TppDCP_rc4.Create(nil);

end;

destructor TppPDFEncrypt.Destroy;
begin
  FRC4Cipher.Free;
  FRC4Cipher := nil;

  FMD5Hash.Free;
  FMD5Hash := nil;

  FEncryptSettings.Free;
  FEncryptSettings := nil;

  inherited;
end;

procedure TppPDFEncrypt.CreateEncryptionKey;
var
  lsPermissions: String;
  lsUserPassword: String;
  lsKey: AnsiString;
  lDigest: array[0..15] of byte;
  liIndex: Integer;
begin

  //Pad the password with the default padding array up to 32 bytes
  lsUserPassword := Copy(EncryptSettings.UserPassword + FKeyPadding, 1, 32);

  //Convert permissions to a byte char string low order byte first
  lsPermissions := ReverseString(TppPDFUtils.IntToByteChars(GetPermissions));

  FMD5Hash.Init;

  FMD5Hash.UpdateStr(AnsiString(lsUserPassword));
  FMD5Hash.UpdateStr(AnsiString(FOwnerKey));
  FMD5Hash.UpdateStr(AnsiString(lsPermissions));
  FMD5Hash.UpdateStr(AnsiString(FFileID));

  FMD5Hash.Final(lDigest);

  lsKey := '';
  //Finish the hash (take the first n bytes).
  for liIndex := 0 to 4 do
    lsKey := lsKey + AnsiChar(Chr(lDigest[liIndex]));

  EncryptionKey := lsKey;

end;

procedure TppPDFEncrypt.CreateOwnerKey;
var
  lsOwnerPassword: String;
  lsUserPassword: String;
  lKey: array[0..4] of byte;
  lDigest: array[0..15] of byte;
  liIndex: Integer;
begin

  //Pad the passwords with the default padding array up to 32 bytes
  lsOwnerPassword := Copy(EncryptSettings.OwnerPassword + FKeyPadding, 1, 32);
  lsUserPassword := Copy(EncryptSettings.UserPassword + FKeyPadding, 1, 32);

  //Hash the owner password to get the key
  FMd5Hash.Init;
  FMD5Hash.UpdateStr(AnsiString(lsOwnerPassword));
  FMD5Hash.Final(lDigest);

  //Take the first n bytes from the hash result
  for liIndex := 0 to Length(lKey) - 1 do
    lKey[liIndex] := lDigest[liIndex];

  //Encrypt the user password using the key.
  FRC4Cipher.Init(lKey, Sizeof(lKey)*8, nil);
  FOwnerKey := String(FRC4Cipher.EncryptString(AnsiString(lsUserPassword)));

end;

procedure TppPDFEncrypt.CreateUserKey;
var
  lKey: array[0..4] of byte;
  liIndex: Integer;
begin

  //Retrieve the encryption key as a byte array
  for liIndex := 0 to Length(EncryptionKey) - 1 do
    lKey[liIndex] := Ord(EncryptionKey[liIndex + 1]);

  //Encrypt the key padding array using the encryption key.
  FRC4Cipher.Init(lKey, SizeOf(lKey)*8, nil);
  FUserKey := String(FRC4Cipher.EncryptString(AnsiString(FKeyPadding)));

end;

function TppPDFEncrypt.GetKeyLength: Integer;
begin
  Result := 40;

end;

function TppPDFEncrypt.GetKeyPadding: String;
var
  liIndex: Integer;
begin
  {$WARNINGS OFF}
  //Get the padding string based on the Key Padding array
  for liIndex := 0 to Length(cKeyPadding) - 1 do
    Result := Result + AnsiChar(Chr(cKeyPadding[liIndex]));
  {$WARNINGS ON}

end;

function TppPDFEncrypt.GetPermissions: Integer;
var
  liFlags: Int64;
begin

  liFlags := $FFFFFFC0;

  if EncryptSettings.AllowPrint then
    liFlags := liFlags + 4;

  if EncryptSettings.AllowModify then
    liFlags := liFlags + 8;

  if EncryptSettings.AllowCopy then
    liFlags := liFlags + 16;

  if EncryptSettings.AllowInteract then
    liFlags := liFlags + 32;

  Result := liFlags;

end;

procedure TppPDFEncrypt.Init;
begin
  //Init key padding constant
  FKeyPadding := GetKeyPadding;

  if EncryptSettings.OwnerPassword = '' then
    EncryptSettings.OwnerPassword := EncryptSettings.UserPassword;

  //Create File Identifier
  FFileID := ppCreateGuidString;

  //Reset the encryption algorithms
  FMD5Hash.Burn;
  FRC4Cipher.Burn;

  CreateOwnerKey;
  CreateEncryptionKey;
  CreateUserKey;
  
end;

procedure TppPDFEncrypt.SetEncryptSettings(const Value: TppPDFEncryptSettings);
begin
  FEncryptSettings.Assign(Value);

end;

procedure TppPDFEncrypt.Write(aOutputStream: TStream; aReferenceNumber: Integer);
begin
  inherited;

  Init;

  WriteLine(IntToStr(ReferenceNumber) + ' 0 obj');
  WriteLine('<< /Filter /Standard');
  WriteLine('/V 1');
  WriteLine('/Length ' + IntToStr(GetKeyLength));
  WriteLine('/R 2');
  WriteLine('/O <' + TppPDFUtils.StrToHex(FOwnerKey) + '>');
  WriteLine('/U <' + TppPDFUtils.StrToHex(FUserKey) + '>');
  WriteLine('/P ' + IntToStr(GetPermissions) + ' >>');
  WriteLine('endobj');

end;

end.
