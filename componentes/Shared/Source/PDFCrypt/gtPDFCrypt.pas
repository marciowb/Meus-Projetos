{ *************************************************************************** }
{                                                                             }
{  Gnostice Shared Visual Component Library                                   }
{                                                                             }
{  Copyright © 2002-2008 Gnostice Information Technologies Private Limited    }
{  http://www.gnostice.com                                                    }
{                                                                             }
{ *************************************************************************** }

{------------------------------------}
{          Editor Options            }
{------------------------------------}
{                                    }
{ Tab Stops = 2                      }
{ Use Tab Character = True           }
{                                    }
{------------------------------------}

{$Q-}
{$R-}

unit gtPDFCrypt;

interface
uses
   Windows, Classes, SysUtils, gtUtils;
type
{------------------------------------------------------------------------------}
                                  {MD5}
{------------------------------------------------------------------------------}

	MD5Count = array[0..1] of DWORD;
	MD5State = array[0..3] of DWORD;
	MD5Block = array[0..15] of DWORD;
	MD5CBits = array[0..7] of byte;
	MD5Digest = array[0..15] of byte;
	MD5Buffer = array[0..63] of byte;
	MD5Context = record
		State: MD5State;
		Count: MD5Count;
		Buffer: MD5Buffer;
	end;
  
{------------------------------------------------------------------------------}
                                  {RC4}
{------------------------------------------------------------------------------}
  
	TRC4Data = record
		Key: array[0..255] of byte;         { current key }
		OrgKey: array[0..255] of byte;      { original key }
	end;

{------------------------------------------------------------------------------}
                                  {TgtPDFEncryption}
{------------------------------------------------------------------------------}

  TgtPDFEncryptionLevel = (el40bit, el128bit);

  TgtUserPermissionsType = (AllowCopy, AllowModify, AllowPrint, AllowAnnotation,
    AllowFormFill, AllowAccessibility, AllowDocAssembly, AllowHighResPrint);

  TgtUserPermissions = set of TgtUserPermissionsType;

	TPermission = array [0..3] of Byte;

{------------------------------------------------------------------------------}
                           {TgtPDFEncryptionSettings}
{------------------------------------------------------------------------------}

  TgtPDFEncryptionSettings = class(TPersistent)
  private
    FIsOwner: Boolean;
    FEnabled: Boolean;
    FLevel: TgtPDFEncryptionLevel;
    FOwnerPassword: AnsiString;
    FUserPassword: AnsiString;
    FUserPermissions: TgtUserPermissions;
    procedure SetLevel(const Value: TgtPDFEncryptionLevel);
    procedure SetOwnerPassword(const Value: AnsiString);
    procedure SetUserPassword(const Value: AnsiString);
    procedure SetUserPermissions(const Value: TgtUserPermissions);
    procedure SetEnabled(const Value: Boolean);
    function GetOwnerPassword: AnsiString;
    
  public
    constructor Create;
    destructor Destroy; override;
    
  published
    property Enabled: Boolean read FEnabled
      write SetEnabled default False;
    property Level: TgtPDFEncryptionLevel read FLevel
      write SetLevel default el128bit;
    property OwnerPassword: AnsiString read GetOwnerPassword
      write SetOwnerPassword;
    property UserPassword: AnsiString read FUserPassword
      write SetUserPassword;
    property UserPermissions: TgtUserPermissions read FUserPermissions
      write SetUserPermissions
      default [AllowCopy, AllowModify, AllowPrint, AllowAnnotation,
      AllowFormFill, AllowAccessibility, AllowDocAssembly, AllowHighResPrint];
  end;  

{------------------------------------------------------------------------------}
                              {TgtBasePDFCrypt}
{------------------------------------------------------------------------------}

  TgtBasePDFCrypt = class(TObject)
  private
    FLevel: TgtPDFEncryptionLevel;
    FFileID: TgtByteArray;
		FOwnerKey: array [0..31] of Byte;
		FUserKey: array [0..31] of Byte;
    FFileKey: array[0..15] of Byte;
    FUserPermissions: TgtUserPermissions;

    procedure SetLevel(const Value: TgtPDFEncryptionLevel);
    function GetFileID: AnsiString;
    procedure SetFileID(const Value: AnsiString);
    function GetOwnerKey: AnsiString;
    function GetUserKey: AnsiString;
    procedure SetUserKey(const Value: AnsiString);
    procedure SetOwnerKey(const Value: AnsiString);

  protected
    procedure PasswordPadding(const AStr: AnsiString; var ADest: array of Byte);

  public
    property Level: TgtPDFEncryptionLevel read FLevel write SetLevel
      default el128bit;
    property FileID: AnsiString read GetFileID write SetFileID;
    property OwnerKey: AnsiString read GetOwnerKey write SetOwnerKey;
    property UserKey: AnsiString read GetUserKey write SetUserKey;
    property UserPermissions: TgtUserPermissions read FUserPermissions
      default [AllowCopy, AllowModify, AllowPrint, AllowAnnotation,
        AllowFormFill, AllowAccessibility, AllowDocAssembly, AllowHighResPrint];

    constructor Create;
    destructor Destroy; override;
  end;

{------------------------------------------------------------------------------}
                                  {TgtPDFEncryption}
{------------------------------------------------------------------------------}

	TgtPDFEncryption = class(TgtBasePDFCrypt)
	private
		FOwnerPassword: AnsiString;
		FUserPassword: AnsiString;
		FOwnerPad: array [0..31] of Byte;
		FUserPad: array [0..31] of Byte;

    function EncryptInit(AObjNo, AGenNo: Integer) : TRC4Data;
    procedure MakeOwnerKey;
    function GetPermissionValue : Integer;
    procedure MakeUserKey;
    procedure MakeFileID(AFileName, ACreationTime: AnsiString);
    procedure MakeFileKey;

	public
		constructor Create(AFileName, ACreationTime: AnsiString;
      Settings: TgtPDFEncryptionSettings);

		procedure EncryptBuffer(const ASrc; var ADest; ADataSize, AObjNo,
      AGenNo: Integer);
		procedure EncryptStream(var AStream: TMemoryStream; ADataSize, AObjNo,
      AGenNo: Integer);

    (*  To Obtain
          Unsigned Long - Cardinal -> Use the value as is.
          Signed Long - Long -> Typecast to Long.
          Unsigned Short - Word -> Use Word instead of Cardinal here.
            See GetPermissionValue function for further details.
        Ex.: If all permissions are set and encryption level is 40bit, then
          Unsigned Long value  = 4294967292.
          Signed Long value    = -4.
          Unsigned Short value = 65532.
    *)
    property PermissionValue: Integer read GetPermissionValue;
	end;

{------------------------------------------------------------------------------}
                               {TgtPDFDecrypt}
{------------------------------------------------------------------------------}

  TgtPDFDecrypt = class(TgtBasePDFCrypt)
  private
    FPermissions: array[0..3] of Byte;
    FIsOwner: Boolean;

    function CheckUserPassword(AUserPassword: AnsiString): Integer;
    function CheckOwnerPassword(AOwnerPassword: AnsiString; var AUserPassword: AnsiString): Integer;
    procedure SetPermissions(const Value: Int64);
    procedure SetUserPermissions;
    procedure SetUserKey(const Value: AnsiString);
    procedure SetOwnerKey(const Value: AnsiString);
    procedure SetFileID(const Value: AnsiString);
    function IsHex(const Value: AnsiString): Boolean;

  public
    FFileKey: array[0..15] of Byte;

    constructor Create;
    function CheckPassword(var Settings: TgtPDFEncryptionSettings;
      Password: AnsiString): Boolean;
    procedure DecryptStream(var AStream: TMemoryStream; ADataSize, AObjNo,
      AGenNo: Integer);
    procedure DecryptString(const ASrc; var ADest; ADataSize, AObjNo,
      AGenNo: Integer);

    property IsOwner: Boolean read FIsOwner;
    property Permissions: Int64 write SetPermissions;
    property UserKey write SetUserKey;
    property OwnerKey write SetOwnerKey;
    property FileID write SetFileID;
  end;

{------------------------------------------------------------------------------}
                                  {MD5}
{------------------------------------------------------------------------------}

  procedure MD5Final(var AContext: MD5Context; var ADigest: MD5Digest);
  procedure MD5Init(var AContext: MD5Context);
  procedure MD5Update(var AContext: MD5Context; AInput: array of Byte;
    ALength: Longword);

{------------------------------------------------------------------------------}
                                  {RC4}
{------------------------------------------------------------------------------}

  procedure RC4Crypt(var AData: TRC4Data; AInData, AOutData: Pointer;
    ALen: Integer);
  procedure RC4Init(var AData: TRC4Data; AKey: Pointer; ALen: Integer);

{------------------------------------------------------------------------------}
                                  {Encryption}
{------------------------------------------------------------------------------}

const
	CMaxPasswordStrLength = 32;

  Level40N = 5;
  Level128N = 16;  

  EncryptLength : array[TgtPDFEncryptionLevel] of Integer = (5, 16);

	Padding: array[0..31] of byte = ($28, $BF, $4E, $5E, $4E, $75, $8A, $41, $64,
		$00, $4E, $56, $FF, $FA, $01, $08, $2E, $2E, $00, $B6, $D0, $68, $3E, $80,
		$2F, $0C, $A9, $FE, $64, $53, $69, $7A);

implementation
uses Math;

var
	BufferPad: MD5Buffer = (
		$80, $00, $00, $00, $00, $00, $00, $00,
		$00, $00, $00, $00, $00, $00, $00, $00,
		$00, $00, $00, $00, $00, $00, $00, $00,
		$00, $00, $00, $00, $00, $00, $00, $00,
		$00, $00, $00, $00, $00, $00, $00, $00,
		$00, $00, $00, $00, $00, $00, $00, $00,
		$00, $00, $00, $00, $00, $00, $00, $00,
		$00, $00, $00, $00, $00, $00, $00, $00
	);

{------------------------------------------------------------------------------}
                                  {MD5}
{------------------------------------------------------------------------------}

function F(AX, AY, AZ: DWORD): DWORD;
begin
	Result := (AX and AY) or ((not AX) and AZ);
end;

function G(AX, AY, AZ: DWORD): DWORD;
begin
	Result := (AX and AZ) or (AY and (not AZ));
end;

function H(AX, AY, AZ: DWORD): DWORD;
begin
	Result := AX xor AY xor AZ;
end;

function I(AX, AY, AZ: DWORD): DWORD;
begin
	Result := AY xor (AX or (not AZ));
end;

procedure Rot(var AX: DWORD; AN: BYTE);
begin
	AX := (AX shl AN) or (AX shr (32 - AN));
end;

procedure FF(var AA: DWORD; AB, AC, AD, AX: DWORD; AByte: BYTE; ADWord: DWORD);
begin
	Inc(AA, F(AB, AC, AD) + AX + ADWord);
	Rot(AA, AByte);
	Inc(AA, AB);
end;

procedure GG(var AA: DWORD; AB, AC, AD, AX: DWORD; AByte: BYTE; ADWord: DWORD);
begin
	Inc(AA, G(AB, AC, AD) + AX + ADWord);
	Rot(AA, AByte);
	Inc(AA, AB);
end;

procedure HH(var AA: DWORD; AB, AC, AD, AX: DWORD; AByte: BYTE; ADWord: DWORD);
begin
	Inc(AA, H(AB, AC, AD) + AX + ADWord);
	Rot(AA, AByte);
	Inc(AA, AB);
end;

procedure II(var AA: DWORD; AB, AC, AD, AX: DWORD; AByte: BYTE; ADWord: DWORD);
begin
	Inc(AA, I(AB, AC, AD) + AX + ADWord);
	Rot(AA, AByte);
	Inc(AA, AB);
end;

{------------------------------------------------------------------------------}

// Encode Count bytes at Source into (Count / 4) DWORDs at Target
procedure Encode(ASource, ATarget: Pointer; ACount: Longword);
var
	S: PByte;
	T: PDWORD;
	I: Longword;
begin
	S := ASource;
	T := ATarget;
	for I := 1 to ACount div 4 do begin
		T^ := S^;
		Inc(S);
		T^ := T^ or (S^ shl 8);
		Inc(S);
		T^ := T^ or (S^ shl 16);
		Inc(S);
		T^ := T^ or (S^ shl 24);
		Inc(S);
		Inc(T);
	end;
end;

{------------------------------------------------------------------------------}

// Decode Count DWORDs at Source into (Count * 4) Bytes at Target
procedure Decode(ASource, ATarget: Pointer; ACount: Longword);
var
	S: PDWORD;
	T: PByte;
	I: Longword;
begin
	S := ASource;
	T := ATarget;
	for I := 1 to ACount do begin
		T^ := S^ and $ff;
		Inc(T);
		T^ := (S^ shr 8) and $ff;
		Inc(T);
		T^ := (S^ shr 16) and $ff;
		Inc(T);
		T^ := (S^ shr 24) and $ff;
		Inc(T);
		Inc(S);
	end;
end;

{------------------------------------------------------------------------------}

// Transform State according to first 64 bytes at Buffer
procedure Transform(ABuffer: Pointer; var AState: MD5State);
var
	A, B, C, D: DWORD;
	Block: MD5Block;
begin
	Encode(ABuffer, @Block, 64);
	A := AState[0];
	B := AState[1];
	C := AState[2];
	D := AState[3];
	FF (A, B, C, D, Block[ 0],  7, $d76aa478);
	FF (D, A, B, C, Block[ 1], 12, $e8c7b756);
	FF (C, D, A, B, Block[ 2], 17, $242070db);
	FF (B, C, D, A, Block[ 3], 22, $c1bdceee);
	FF (A, B, C, D, Block[ 4],  7, $f57c0faf);
	FF (D, A, B, C, Block[ 5], 12, $4787c62a);
	FF (C, D, A, B, Block[ 6], 17, $a8304613);
	FF (B, C, D, A, Block[ 7], 22, $fd469501);
	FF (A, B, C, D, Block[ 8],  7, $698098d8);
	FF (D, A, B, C, Block[ 9], 12, $8b44f7af);
	FF (C, D, A, B, Block[10], 17, $ffff5bb1);
	FF (B, C, D, A, Block[11], 22, $895cd7be);
	FF (A, B, C, D, Block[12],  7, $6b901122);
	FF (D, A, B, C, Block[13], 12, $fd987193);
	FF (C, D, A, B, Block[14], 17, $a679438e);
	FF (B, C, D, A, Block[15], 22, $49b40821);
	GG (A, B, C, D, Block[ 1],  5, $f61e2562);
	GG (D, A, B, C, Block[ 6],  9, $c040b340);
	GG (C, D, A, B, Block[11], 14, $265e5a51);
	GG (B, C, D, A, Block[ 0], 20, $e9b6c7aa);
	GG (A, B, C, D, Block[ 5],  5, $d62f105d);
	GG (D, A, B, C, Block[10],  9,  $2441453);
	GG (C, D, A, B, Block[15], 14, $d8a1e681);
	GG (B, C, D, A, Block[ 4], 20, $e7d3fbc8);
	GG (A, B, C, D, Block[ 9],  5, $21e1cde6);
	GG (D, A, B, C, Block[14],  9, $c33707d6);
	GG (C, D, A, B, Block[ 3], 14, $f4d50d87);
	GG (B, C, D, A, Block[ 8], 20, $455a14ed);
	GG (A, B, C, D, Block[13],  5, $a9e3e905);
	GG (D, A, B, C, Block[ 2],  9, $fcefa3f8);
	GG (C, D, A, B, Block[ 7], 14, $676f02d9);
	GG (B, C, D, A, Block[12], 20, $8d2a4c8a);
	HH (A, B, C, D, Block[ 5],  4, $fffa3942);
	HH (D, A, B, C, Block[ 8], 11, $8771f681);
	HH (C, D, A, B, Block[11], 16, $6d9d6122);
	HH (B, C, D, A, Block[14], 23, $fde5380c);
	HH (A, B, C, D, Block[ 1],  4, $a4beea44);
	HH (D, A, B, C, Block[ 4], 11, $4bdecfa9);
	HH (C, D, A, B, Block[ 7], 16, $f6bb4b60);
	HH (B, C, D, A, Block[10], 23, $bebfbc70);
	HH (A, B, C, D, Block[13],  4, $289b7ec6);
	HH (D, A, B, C, Block[ 0], 11, $eaa127fa);
	HH (C, D, A, B, Block[ 3], 16, $d4ef3085);
	HH (B, C, D, A, Block[ 6], 23,  $4881d05);
	HH (A, B, C, D, Block[ 9],  4, $d9d4d039);
	HH (D, A, B, C, Block[12], 11, $e6db99e5);
	HH (C, D, A, B, Block[15], 16, $1fa27cf8);
	HH (B, C, D, A, Block[ 2], 23, $c4ac5665);
	II (A, B, C, D, Block[ 0],  6, $f4292244);
	II (D, A, B, C, Block[ 7], 10, $432aff97);
	II (C, D, A, B, Block[14], 15, $ab9423a7);
	II (B, C, D, A, Block[ 5], 21, $fc93a039);
	II (A, B, C, D, Block[12],  6, $655b59c3);
	II (D, A, B, C, Block[ 3], 10, $8f0ccc92);
	II (C, D, A, B, Block[10], 15, $ffeff47d);
	II (B, C, D, A, Block[ 1], 21, $85845dd1);
	II (A, B, C, D, Block[ 8],  6, $6fa87e4f);
	II (D, A, B, C, Block[15], 10, $fe2ce6e0);
	II (C, D, A, B, Block[ 6], 15, $a3014314);
	II (B, C, D, A, Block[13], 21, $4e0811a1);
	II (A, B, C, D, Block[ 4],  6, $f7537e82);
	II (D, A, B, C, Block[11], 10, $bd3af235);
	II (C, D, A, B, Block[ 2], 15, $2ad7d2bb);
	II (B, C, D, A, Block[ 9], 21, $eb86d391);
	Inc(AState[0], A);
	Inc(AState[1], B);
	Inc(AState[2], C);
	Inc(AState[3], D);
end;

{------------------------------------------------------------------------------}

// Initialize given Context
procedure MD5Init(var AContext: MD5Context);
begin
	with AContext do begin
		State[0] := $67452301;
		State[1] := $efcdab89;
		State[2] := $98badcfe;
		State[3] := $10325476;
		Count[0] := 0;
		Count[1] := 0;
		ZeroMemory(@Buffer, SizeOf(MD5Buffer));
	end;
end;

{------------------------------------------------------------------------------}

// Update given Context to include Length bytes of Input
procedure MD5Update(var AContext: MD5Context; AInput: array of Byte;
  ALength: Longword);
var
	Index: Longword;
	PartLen: Longword;
	I: Longword;
begin
	with AContext do begin
		Index := (Count[0] shr 3) and $3f;
		Inc(Count[0], ALength shl 3);
		if Count[0] < (ALength shl 3) then
      Inc(Count[1]);
		Inc(Count[1], ALength shr 29);
	end;
	PartLen := 64 - Index;
	if ALength >= PartLen then
  begin
		CopyMemory(@AContext.Buffer[Index], @AInput, PartLen);
		Transform(@AContext.Buffer, AContext.State);
		I := PartLen;
		while I + 63 < ALength do
    begin
			Transform(@AInput[I], AContext.State);
			Inc(I, 64);
		end;
		Index := 0;
	end
  else
    I := 0;
	CopyMemory(@AContext.Buffer[Index], @AInput[I], ALength - I);
end;

{------------------------------------------------------------------------------}

// Finalize given Context, create Digest and zeroize Context
procedure MD5Final(var AContext: MD5Context; var ADigest: MD5Digest);
var
	Bits: MD5CBits;
	Index: Longword;
	PadLen: Longword;
begin
	Decode(@AContext.Count, @Bits, 2);
	Index := (AContext.Count[0] shr 3) and $3f;
	if Index < 56 then
    PadLen := 56 - Index
  else
    PadLen := 120 - Index;
	MD5Update(AContext, BufferPad, PadLen);
	MD5Update(AContext, Bits, 8);
	Decode(@AContext.State, @ADigest, 4);
	ZeroMemory(@AContext, SizeOf(MD5Context));
end;

{------------------------------------------------------------------------------}
                                  {RC4}
{------------------------------------------------------------------------------}

procedure RC4Crypt(var AData: TRC4Data; AInData,
  AOutData: Pointer; ALen: Integer);
var
  T, I, J: byte;
  K: integer;
begin
	I := 0;
	J := 0;
	for K := 0 to ALen-1 do
	begin
		I := (I+1) and $FF;
		J := (J + AData.Key[I]) and $FF;
		T := AData.Key[I];
    AData.Key[I]:= AData.Key[J];
    AData.Key[J]:= T;
    T := (AData.Key[I] + AData.Key[J]) and $FF;
    PByteArray(AOutData)[K]:= PByteArray(AInData)[K] xor AData.Key[T];
  end;
end;

{------------------------------------------------------------------------------}

procedure RC4Init(var AData: TRC4Data; AKey: Pointer;
  ALen: Integer);
var
	XKey: array[0..255] of byte;
	I, J: integer;
	T: byte;
begin
	ZeroMemory(@XKey, SizeOf(XKey));
	if (ALen <= 0) or (ALen > 256) then
		raise Exception.Create('RC4: Invalid key length');
	for I := 0 to 255 do
	begin
		AData.Key[I] := I;
		XKey[I] := PByte(Integer(AKey) + (I mod ALen))^;
	end;
	J := 0;
	for I := 0 to 255 do
	begin
		J := (J + AData.Key[I] + XKey[I]) and $FF;
		T := AData.Key[I];
		AData.Key[I] := AData.Key[J];
		AData.Key[J] := T;
	end;
	Move(AData.Key, AData.OrgKey, 256);
end;
{ TgtBasePDFCrypt }

constructor TgtBasePDFCrypt.Create;
begin
  SetLength(FFileId, 0);
  FLevel := el128bit;
  FUserPermissions := [AllowCopy, AllowModify, AllowPrint, AllowAnnotation,
    AllowFormFill, AllowAccessibility, AllowDocAssembly, AllowHighResPrint];
end;

destructor TgtBasePDFCrypt.Destroy;
begin

  inherited;
end;

function TgtBasePDFCrypt.GetFileID: AnsiString;
begin
  SetLength(Result, Length(FFileID));
  Move(FFileID[0], Result[1], Length(Result));
end;

function TgtBasePDFCrypt.GetOwnerKey: AnsiString;
begin
  SetLength(Result, Length(FOwnerKey));
  Move(FOwnerKey[0], Result[1], Length(Result));
end;

function TgtBasePDFCrypt.GetUserKey: AnsiString;
begin
  SetLength(Result, Length(FUserKey));
  Move(FUserKey[0], Result[1], Length(Result));
end;

procedure TgtBasePDFCrypt.PasswordPadding(const AStr: AnsiString;
  var ADest: array of Byte);
var
	Len: Integer;
begin
	Len := Length(AStr);
	if Len > CMaxPasswordStrLength then
		Len := CMaxPasswordStrLength;
	Move(AStr[1], ADest[Low(ADest)], Len);
	Move(Padding, ADest[Low(ADest) + Len], CMaxPasswordStrLength - Len);
end;

procedure TgtBasePDFCrypt.SetFileID(const Value: AnsiString);
begin

end;

procedure TgtBasePDFCrypt.SetLevel(const Value: TgtPDFEncryptionLevel);
begin
  FLevel := Value;
end;

procedure TgtBasePDFCrypt.SetUserKey(const Value: AnsiString);
begin

end;

procedure TgtBasePDFCrypt.SetOwnerKey(const Value: AnsiString);
begin

end;

{ TgtPDFEncryption }

constructor TgtPDFEncryption.Create(AFileName, ACreationTime: AnsiString;
  Settings: TgtPDFEncryptionSettings);
begin
  inherited Create;
  FOwnerPassword := Settings.FOwnerPassword;
  FUserPassword := Settings.FUserPassword;
  FLevel := Settings.FLevel;
  FUserPermissions := Settings.FUserPermissions;
  SetLength(FFileID, 16);
  MakeFileID(AFileName, ACreationTime);
  MakeFileKey;    
end;

procedure TgtPDFEncryption.EncryptBuffer(const ASrc; var ADest; ADataSize,
  AObjNo, AGenNo: Integer);
var
  RC4Data: TRC4Data;
begin
  RC4Data := EncryptInit(AObjNo, AGenNo);
	RC4Crypt(RC4Data, @ASrc, @ADest, ADataSize);
end;

function TgtPDFEncryption.EncryptInit(AObjNo, AGenNo: Integer): TRC4Data;
var
	LKey: array[0..20] of Byte;
	LMD5Output: array [0..15] of Byte;
	MD5Data: MD5Context;
	LMD5Digest: MD5Digest;
  LRC4Length : Integer;
begin
  Move(FFileKey[0], LKey[0], EncryptLength[FLevel]);
  LKey[EncryptLength[FLevel]] := (AObjNo and $FF);
  LKey[EncryptLength[FLevel] + 1] := (AObjNo shr 8) and $FF;
  LKey[EncryptLength[FLevel] + 2] := (AObjNo shr 16) and $FF;
  LKey[EncryptLength[FLevel] + 3] := AGenNo and $FF;
  LKey[EncryptLength[FLevel] + 4] := (AGenNo shr 8) and $FF;

	MD5Init(MD5Data);
  MD5Update(MD5Data, LKey, (EncryptLength[FLevel]+5));
	MD5Final(MD5Data, LMD5Digest);
  LRC4Length := gtUtils.IfThen((EncryptLength[FLevel]+5) > 16, 16,
    (EncryptLength[FLevel]+5));
  Move(LMD5Digest, LMD5Output[0], LRC4Length);
  RC4Init(Result, @LMD5Output, LRC4Length);
end;

procedure TgtPDFEncryption.EncryptStream(var AStream: TMemoryStream;
  ADataSize, AObjNo, AGenNo: Integer);
var
  EncryptedStream: TMemoryStream;
  RC4Data: TRC4Data;
begin
  EncryptedStream := TMemoryStream.Create;
  EncryptedStream.Size := AStream.Size;
  RC4Data := EncryptInit(AObjNo, AGenNo);
	RC4Crypt(RC4Data, AStream.Memory, EncryptedStream.Memory, ADataSize);
  AStream.Clear;
  AStream.Size := EncryptedStream.Size;
  AStream.CopyFrom(EncryptedStream, 0);
  EncryptedStream.Free;
end;

function TgtPDFEncryption.GetPermissionValue: Integer;
begin
  (*
    You can obtain Unsigned Short value by setting -
      Return type = Word.
      Result := $FFC0; instead of Result := $FFFFFFC0; &
      Result := $F0C0; instead of Result := $FFFFF0C0;
  *)
  Result := Integer($FFFFFFC0);
  if (EncryptLength[FLevel] > 5) then
    Result := Integer($FFFFF0C0);
  if AllowPrint in FUserPermissions then
    Result := Result or 4;
  if AllowModify in FUserPermissions then
    Result := Result or 8;
  if AllowCopy in FUserPermissions then
    Result := Result or 16;
  if (AllowAnnotation in FUserPermissions) then
    Result := Result or 32;
  if (EncryptLength[FLevel] > 5) then begin
    if (AllowFormFill in FUserPermissions) then
      Result := Result or 256;
    if (AllowAccessibility in FUserPermissions) then
      Result := Result or 512;
    if (AllowDocAssembly in FUserPermissions) then
      Result := Result or 1024;
    if ((AllowHighResPrint in FUserPermissions) and
        (AllowPrint in FUserPermissions)) then
      Result := Result or 2048;
  end;
end;

procedure TgtPDFEncryption.MakeFileID(AFileName, ACreationTime: AnsiString);
var
  LMD5Context: MD5Context;
  LArray: array of Byte;
  LI: Integer;
  LMD5Digest: MD5Digest;
begin
  MD5Init(LMD5Context);

  SetLength(LArray, Length(AFileName));
  for LI := 1 to Length(AFileName) do
    LArray[LI - 1] := Ord(AFileName[LI]);
  MD5Update(LMD5Context, LArray, Length(AFileName));

  SetLength(LArray, Length(ACreationTime));
  for LI := 1 to Length(ACreationTime) do
    LArray[LI - 1] := Ord(ACreationTime[LI]);
  MD5Update(LMD5Context, LArray, Length(ACreationTime));

  MD5Final(LMD5Context, LMD5Digest);
	Move(LMD5Digest, FFileID[0], 16);
end;

procedure TgtPDFEncryption.MakeFileKey;
var
	S: array [0..3] of Byte;
	MD5Data: MD5Context;
	LMD5Digest: MD5Digest;
  LI : Integer;
  LEncyptPerm : Cardinal;
begin
  if (FOwnerPassword = '') then PasswordPadding(FUserPassword,FOwnerPad)
  else PasswordPadding(FOwnerPassword, FOwnerPad);
  PasswordPadding(FUserPassword, FUserPad);
  //Owner Key
  MakeOwnerKey;
  //permissions
  LEncyptPerm := GetPermissionValue;
  S[0] := Byte(LEncyptPerm and $FF);
  S[1] := Byte((LEncyptPerm shr 8) and $FF);
  S[2] := Byte((LEncyptPerm shr 16) and $FF);
  S[3] := Byte((LEncyptPerm shr 24) and $FF);
  //encryption key
  MD5Init(MD5Data);
	MD5Update(MD5Data, FUserPad, SizeOf(FUserPad));
	MD5Update(MD5Data, FOwnerKey, SizeOf(FOwnerKey));
  MD5Update(MD5Data, S, 4);
  MD5Update(MD5Data, FFileID, 16);
  MD5Final(MD5Data, LMD5Digest);
  if (EncryptLength[FLevel] > 5) then begin
    for LI := 0 to 49 do begin
      MD5Init(MD5Data);
      MD5Update(MD5Data, LMD5Digest, 16);
      MD5Final(MD5Data, LMD5Digest);
    end;
  end;
  CopyMemory(@FFileKey[0], @LMD5Digest, EncryptLength[FLevel]);
  //user key
  MakeUserKey;
end;

procedure TgtPDFEncryption.MakeOwnerKey;
var
  MD5Data : MD5Context;
  LMD5Digest : MD5Digest;
  LI, LJ : Integer;
  LMD5Output: array[0..15] of Byte;
  RC4Data : TRC4Data;
begin
  MD5Init(MD5Data);
  MD5Update(MD5Data, FOwnerPad, 32);
  MD5Final(MD5Data, LMD5Digest);
  if (EncryptLength[FLevel] > 5) then begin
    for LI := 0 to 49 do begin
      MD5Init(MD5Data);
      MD5Update(MD5Data, LMD5Digest, 16);
      MD5Final(MD5Data, LMD5Digest);
    end;
    CopyMemory(@FOwnerKey, @FUserPad, 32);
    for LI := 0 to 19 do begin
       for LJ := 0 to EncryptLength[FLevel]-1 do
         FFileKey[LJ] := LMD5Digest[LJ] xor LI;
       RC4Init(RC4Data, @FFileKey, EncryptLength[FLevel]);
       RC4Crypt(RC4Data, @FOwnerKey, @FOwnerKey, 32);
    end;
  end
  else begin
    Move(LMD5Digest[0], LMD5Output[0], 16);
    RC4Init(RC4Data, @LMD5Output, EncryptLength[FLevel]);
    RC4Crypt(RC4Data, @FUserPad, @FOwnerKey, 32);
  end;
end;

procedure TgtPDFEncryption.MakeUserKey;
var
  MD5Data : MD5Context;
  LMD5Digest : MD5Digest;
  LMD5Output : array[0..15] of Byte;
  LI, LJ : Integer;
  RC4Data : TRC4Data;
begin
  if (EncryptLength[FLevel] > 5) then begin
    MD5Init(MD5Data);
    MD5Update(MD5Data, Padding, 32);
    MD5Update(MD5Data, FFileID, 16);
    MD5Final(MD5Data, LMD5Digest);
    Move(LMD5Digest, FUserKey[0], 16);
    for LI := 16 to 31 do FUserKey[LI] := 0;
    for LI := 0 to 19 do begin
      for LJ := 0 to EncryptLength[FLevel]-1 do
        LMD5Output[LJ] := FFileKey[LJ] xor LI;
      RC4Init(RC4Data, @LMD5Output, EncryptLength[FLevel]);
      RC4Crypt(RC4Data, @FUserKey, @FUserKey, 16);
    end;
  end
  else begin
    RC4Init(RC4Data, @FFileKey, EncryptLength[FLevel]);
    RC4Crypt(RC4Data, @Padding, @FUserKey, 32);
  end;
end;

{ TgtPDFEncryptionSettings }

constructor TgtPDFEncryptionSettings.Create;
begin
  inherited;
  
  FIsOwner := True;
  FEnabled := False;
  FLevel := el128bit;
  FOwnerPassword := '';
  FUserPassword := '';
  FUserPermissions := [AllowCopy, AllowModify, AllowPrint, AllowAnnotation,
    AllowFormFill, AllowAccessibility, AllowDocAssembly, AllowHighResPrint];
end;

destructor TgtPDFEncryptionSettings.Destroy;
begin
  inherited;
end;

function TgtPDFEncryptionSettings.GetOwnerPassword: AnsiString;
begin
  if FIsOwner then
    Result := FOwnerPassword
  else Result := '';
end;

procedure TgtPDFEncryptionSettings.SetEnabled(const Value: Boolean);
begin
  if FIsOwner then
    FEnabled := Value
  else
    raise Exception.Create('User cannot change encryption settings');
end;

procedure TgtPDFEncryptionSettings.SetLevel(
  const Value: TgtPDFEncryptionLevel);
begin
  if FIsOwner then
    FLevel := Value
  else
    raise Exception.Create('User cannot change encryption settings');    
end;

procedure TgtPDFEncryptionSettings.SetOwnerPassword(const Value: AnsiString);
begin
  if FIsOwner then
    FOwnerPassword := Value
  else
    raise Exception.Create('User cannot change encryption settings');    
end;

procedure TgtPDFEncryptionSettings.SetUserPassword(const Value: AnsiString);
begin
  if FIsOwner then
    FUserPassword := Value
  else
    raise Exception.Create('User cannot change encryption settings');    
end;

procedure TgtPDFEncryptionSettings.SetUserPermissions(
  const Value: TgtUserPermissions);
begin
  if FIsOwner then
    FUserPermissions := Value
  else
    raise Exception.Create('User cannot change encryption settings');    
end;

{ TgtPDFDecrypt }

function TgtPDFDecrypt.CheckOwnerPassword(AOwnerPassword: AnsiString; var AUserPassword: AnsiString): Integer;
var
  LOwnerPad: array [0..31] of Byte;
  LContext: MD5Context;
  LDigest: MD5Digest;

  LRC4Data: TRC4Data;

  LRC4Output: array[0..31] of Byte;

  LI, LJ, LEncryptionLength: Integer;

  LEncryptionKey, LEncryptionKeyXor: array[0..15] of Byte;
  LUserPassword: AnsiString;
begin
  Result := -1;
  LEncryptionLength := EncryptLength[Level];

  if Level = el40bit then
  begin
    if (AOwnerPassword <> '') then
      PasswordPadding(AOwnerPassword, LOwnerPad)
    else
      CopyMemory(@LOwnerPad, @Padding, Length(Padding));

    MD5Init(LContext);
    MD5Update(LContext, LOwnerPad, Length(LOwnerPad));
    MD5Final(LContext, LDigest);

    RC4Init(LRC4Data, @LDigest, LEncryptionLength);

    RC4Crypt(LRC4Data, @FOwnerKey, @LRC4Output, 32);

    SetLength(LUserPassword, 32);

    for LI := 1 to 33 do
      LUserPassword[LI] := AnsiChar(LRC4Output[LI - 1]);

    // Obtain the User Password
    AUserPassword := '';
    for LJ := 1 to Length(LUserPassword) do
    begin
      if ((LUserPassword[LJ] = AnsiChar(Padding[0])) and
         (LUserPassword[LJ+1] = AnsiChar(Padding[1]))) then break;
      AUserPassword := AUserPassword + LUserPassword[LJ]
    end;

    if (CheckUserPassword(LUserPassword) <> 0) then
      Exit;
  end
  else
  begin
    if (AOwnerPassword <> '') then
      PasswordPadding(AOwnerPassword, LOwnerPad)
    else
      CopyMemory(@LOwnerPad, @Padding, Length(Padding));

    MD5Init(LContext);
    MD5Update(LContext, LOwnerPad, Length(LOwnerPad));
    MD5Final(LContext, LDigest);

    for LI := 0 to 49 do
    begin
      MD5Init(LContext);
      MD5Update(LContext, LDigest, 16);
      MD5Final(LContext, LDigest);
    end;
    Move(LDigest, LEncryptionKey, LEncryptionLength);

    CopyMemory(@LRC4Output, @FOwnerKey, 32);

    for LI := 19 downto 0 do
    begin
      for LJ := 0 to LEncryptionLength - 1 do
        LEncryptionKeyXor[LJ] := LDigest[LJ] xor LI;

      RC4Init(LRC4Data, @LEncryptionKeyXor, LEncryptionLength);
      RC4Crypt(LRC4Data, @LRC4Output, @LRC4Output, 32);
    end;

    SetLength(LUserPassword, 32);

    for LI := 1 to 33 do
      LUserPassword[LI] := AnsiChar(LRC4Output[LI - 1]);

    // Obtain the User Password
    AUserPassword := '';
    for LJ := 1 to Length(LUserPassword) do
    begin
      if ((LUserPassword[LJ] = AnsiChar(Padding[0])) and
         (LUserPassword[LJ+1] = AnsiChar(Padding[1]))) then break;
      AUserPassword := AUserPassword + LUserPassword[LJ]
    end;

    if (CheckUserPassword(LUserPassword) <> 0) then
      Exit;
  end;

  Result := 0;
end;

function TgtPDFDecrypt.CheckPassword(var Settings: TgtPDFEncryptionSettings;
  Password: AnsiString): Boolean;
var
  LUserPassword: AnsiString;
begin
  Result := False;
  if (CheckOwnerPassword(Password, LUserPassword) = 0) then
  begin
    FIsOwner := True;
    Result := True;

    Settings.Enabled := True;
    Settings.OwnerPassword := Password;
    Settings.UserPassword := LUserPassword;
    Settings.UserPermissions := UserPermissions;
    Settings.Level := Level;
  end
  else if (CheckUserPassword(Password) = 0) then
  begin
    SetUserPermissions;
    Result := True;
    Settings.Enabled := True;
    Settings.UserPassword := Password;
    Randomize;
    Settings.OwnerPassword := AnsiString('Gnostice' +
      FormatDateTime('yyyymmddhhnnss', Now) + IntToStr(Random(MaxInt)));
    Settings.UserPermissions := UserPermissions;
    Settings.Level := Level;
    Settings.FIsOwner := False;
  end;
end;

function TgtPDFDecrypt.CheckUserPassword(AUserPassword: AnsiString): Integer;
var
  LUserPad: array [0..31] of Byte;
  LContext: MD5Context;
  LDigest: MD5Digest;
  LEncryptionKey, LEncryptionKeyXor: array[0..15] of Byte;

  LRC4Data: TRC4Data;
  LRC4Output: array[0..31] of Byte;
  LMD5Output: MD5Digest;

  LI, LJ, LEncryptionLength: Integer;
begin
  Result := -1;
  LEncryptionLength := EncryptLength[Level];

  if Level = el40bit then
  begin
    PasswordPadding(AUserPassword, LUserPad);
    MD5Init(LContext);
    MD5Update(LContext, LUserPad, Length(LUserPad));
    MD5Update(LContext, FOwnerKey, Length(FOwnerKey));
    MD5Update(LContext, FPermissions, Length(FPermissions));
    if Length(FFileId) <> 0 then
      MD5Update(LContext, FFileId, Length(FFileId));
    MD5Final(LContext, LDigest);
    Move(LDigest, LEncryptionKey, LEncryptionLength);

    RC4Init(LRC4Data, @LEncryptionKey, LEncryptionLength);
    RC4Crypt(LRC4Data, @FUserKey, @LRC4Output, 32);

    for LI := 0 to 31 do
      if (LRC4Output[LI] <> Padding[LI]) then
        Exit;

    for LI := 0 to (LEncryptionLength - 1) do
      FFileKey[LI] := LEncryptionKey[LI];

    for LI := 5 to 15 do
      FFileKey[LI] := 0;
  end
  else
  begin
    PasswordPadding(AUserPassword, LUserPad);
    MD5Init(LContext);
    MD5Update(LContext, LUserPad, Length(LUserPad));
    MD5Update(LContext, FOwnerKey, Length(FOwnerKey));
    MD5Update(LContext, FPermissions, Length(FPermissions));
    if Length(FFileId) <> 0 then
      MD5Update(LContext, FFileId, Length(FFileId));
    MD5Final(LContext, LDigest);
    for LI := 0 to 49 do
    begin
      MD5Init(LContext);
      MD5Update(LContext, LDigest, 16);
      MD5Final(LContext, LDigest);
    end;
    Move(LDigest, LEncryptionKey, LEncryptionLength);
    CopyMemory(@LRC4Output, @FUserKey, 32);

    for LI := 19 downto 0 do
    begin
      for LJ := 0 to LEncryptionLength - 1 do
        LEncryptionKeyXor[LJ] := LEncryptionKey[LJ] xor LI;

      RC4Init(LRC4Data, @LEncryptionKeyXor, LEncryptionLength);
      RC4Crypt(LRC4Data, @LRC4Output, @LRC4Output, 32);
    end;

    MD5Init(LContext);
    MD5Update(LContext, Padding, Length(Padding));
    if Length(FFileId) <> 0 then
      MD5Update(LContext, FFileId, Length(FFileId));
    MD5Final(LContext, LMD5Output);

    for LI := 0 to 15 do
      if (LRC4Output[LI] <> LMD5Output[LI]) then
        Exit;

    for LI := 0 to (LEncryptionLength - 1) do
      FFileKey[LI] := LEncryptionKey[LI];
  end;

  Result := 0;
end;

constructor TgtPDFDecrypt.Create;
begin
  inherited Create;
end;

procedure TgtPDFDecrypt.DecryptStream(var AStream: TMemoryStream;
  ADataSize, AObjNo, AGenNo: Integer);
var
  LKey: array[0..20] of Byte;
  LMD5Output: array [0..15] of Byte;
  LMD5Data: MD5Context;
  LMD5Digest: MD5Digest;

  LRC4Data: TRC4Data;
  EncryptedStream: TMemoryStream;
begin
  if Level = el128bit then
  begin
	  Move(FFileKey[0], LKey[0], Level128N);
    LKey[Level128N] := (AObjNo and $FF);
    LKey[Level128N + 1] := (AObjNo shr 8) and $FF;
    LKey[Level128N + 2] := (AObjNo shr 16) and $FF;
    LKey[Level128N + 3] := AGenNo and $FF;
    LKey[Level128N + 4] := (AGenNo shr 8) and $FF;
  end
  else
  begin
    Move(FFileKey[0], LKey[0], Level40N);
    LKey[Level40N] := (AObjNo and $FF);
    LKey[Level40N + 1] := (AObjNo shr 8) and $FF;
    LKey[Level40N + 2] := (AObjNo shr 16) and $FF;
    LKey[Level40N + 3] := AGenNo and $FF;
    LKey[Level40N + 4] := (AGenNo shr 8) and $FF;
  end;

	MD5Init(LMD5Data);
  if Level = el128bit then
	  MD5Update(LMD5Data, LKey, Level128N + 5)
  else
    MD5Update(LMD5Data, LKey, Level40N + 5);
  MD5Final(LMD5Data, LMD5Digest);

  if Level = el128bit then
  begin
	  Move(LMD5Digest, LMD5Output[0], SizeOf(LMD5Output));
  	RC4Init(LRC4Data, @LMD5Output, SizeOf(LMD5Output));
  end
  else
  begin
    Move(LMD5Digest, LMD5Output[0], Level40N + 5);
    RC4Init(LRC4Data, @LMD5Output, Level40N + 5);
  end;

  EncryptedStream := TMemoryStream.Create;
  EncryptedStream.Size := AStream.Size;
	RC4Crypt(LRC4Data, AStream.Memory, EncryptedStream.Memory, ADataSize);
  AStream.Clear;
  AStream.Size := EncryptedStream.Size;
  AStream.CopyFrom(EncryptedStream, 0);
  EncryptedStream.Free;
end;

procedure TgtPDFDecrypt.DecryptString(const ASrc; var ADest; ADataSize,
  AObjNo, AGenNo: Integer);
var
  LKey: array[0..20] of Byte;
  LMD5Output: array [0..15] of Byte;
  LMD5Data: MD5Context;
  LMD5Digest: MD5Digest;

  LRC4Data: TRC4Data;
  LString: AnsiString;
begin
  if Level = el128bit then
  begin
	  Move(FFileKey[0], LKey[0], Level128N);
    LKey[Level128N] := (AObjNo and $FF);
    LKey[Level128N + 1] := (AObjNo shr 8) and $FF;
    LKey[Level128N + 2] := (AObjNo shr 16) and $FF;
    LKey[Level128N + 3] := AGenNo and $FF;
    LKey[Level128N + 4] := (AGenNo shr 8) and $FF;
  end
  else
  begin
    Move(FFileKey[0], LKey[0], Level40N);
    LKey[Level40N] := (AObjNo and $FF);
    LKey[Level40N + 1] := (AObjNo shr 8) and $FF;
    LKey[Level40N + 2] := (AObjNo shr 16) and $FF;
    LKey[Level40N + 3] := AGenNo and $FF;
    LKey[Level40N + 4] := (AGenNo shr 8) and $FF;
  end;

  MD5Init(LMD5Data);
  if Level = el128bit then
	  MD5Update(LMD5Data, LKey, Level128N + 5)
  else
    MD5Update(LMD5Data, LKey, Level40N + 5);
  MD5Final(LMD5Data, LMD5Digest);

  if Level = el128bit then
  begin
	  Move(LMD5Digest, LMD5Output[0], SizeOf(LMD5Output));
  	RC4Init(LRC4Data, @LMD5Output, SizeOf(LMD5Output));
  end
  else
  begin
    Move(LMD5Digest, LMD5Output[0], Level40N + 5);
    RC4Init(LRC4Data, @LMD5Output, Level40N + 5);
  end;

  RC4Crypt(LRC4Data, @ASrc, @ADest, ADataSize);
  LString := PAnsiChar(@ADest);
end;

function TgtPDFDecrypt.IsHex(const Value: AnsiString): Boolean;
begin
  Result := False;
  if (Value[1] = '<') and (Value[Length(Value)] = '>') then
    Result := True;
end;

procedure TgtPDFDecrypt.SetFileID(const Value: AnsiString);
var
  lstr: AnsiString;
begin
  if (not IsHex(Value)) and (Length(Value) < 32) then
    lstr :=GetHexOfStr(Value)
  else
    lstr := Value;

  if Length(lstr) = 32 then
    FFileID := HexToByteArray(String(lstr))
  else
    raise Exception.Create('Invalid FileId.');
end;

procedure TgtPDFDecrypt.SetOwnerKey(const Value: AnsiString);
var
  LOwnerKey, LChar: AnsiString;
  LByteArray: TgtByteArray;
  LI, LLength: Integer;
begin
  SetLength(LByteArray, 0);
  if Value = '' then
  begin
    raise Exception.Create('Invalid Owner Key.');
    Exit;
  end;
  LOwnerKey := Copy(Value, 2, Length(Value) - 2);
  if IsHex(Value) then
  begin
    LByteArray := HexToByteArray(String(LOwnerKey));
    for LI := 0 to Length(LByteArray) - 1 do
      FOwnerKey[LI] := LByteArray[LI];
  end
  else
  begin
    LLength := Length(LOwnerKey);
    if LLength > 32 then
      EscapeStringToByteArray(LOwnerKey, FOwnerKey)
    else
    begin
      LI := 1;
      repeat
        LChar := LOwnerKey[LI];
        FOwnerKey[LI - 1] := Ord(LChar[1]);
        Inc(LI);
      until(LI > LLength);
    end;
  end;
end;

procedure TgtPDFDecrypt.SetPermissions(const Value: Int64);
var
  I: Int64;
begin
  if (Value < 0) or (Value <= High(Word)) then
    I := Value
  else
    I := LongInt(Value);

  FPermissions[0] := I and $FF;
  FPermissions[1] := (I shr 8) and $FF;
  if (Value < 0) or (Value > High(Word)) then
  begin
    FPermissions[2] := $FF;
    FPermissions[3] := $FF;
  end
  else
  begin
    FPermissions[2] := $00;
    FPermissions[3] := $00;
  end;
end;

procedure TgtPDFDecrypt.SetUserKey(const Value: AnsiString);
var
  LUserKey, LChar: AnsiString;
  LByteArray: TgtByteArray;
  LI, LLength: Integer;
begin
  SetLength(LByteArray, 0);
  if Value = '' then
  begin
    raise Exception.Create('Invalid User Key.');
    Exit;
  end;
  LUserKey := Copy(Value, 2, Length(Value) - 2);
  if IsHex(Value) then
  begin
    LByteArray := HexToByteArray(String(LUserKey));
    for LI := 0 to Length(LByteArray) - 1 do
      FUserKey[LI] := LByteArray[LI];
  end
  else
  begin
    LLength := Length(LUserKey);
    if LLength > 32 then
      EscapeStringToByteArray(LUserKey, FUserKey)
    else
    begin
      LI := 1;
      repeat
        LChar := LUserKey[LI];
        FUserKey[LI - 1] := Ord(LChar[1]);
        Inc(LI);
      until(LI > LLength);
    end;
  end;
end;

procedure TgtPDFDecrypt.SetUserPermissions;
begin
  if FPermissions[0] and 4 = 0 then
    FUserPermissions := FUserPermissions - [AllowPrint];
  if FPermissions[0] and 8 = 0 then
    FUserPermissions := FUserPermissions - [AllowModify];
  if FPermissions[0] and 16 = 0 then
    FUserPermissions := FUserPermissions - [AllowCopy];
  if FPermissions[0] and 32 = 0 then
    FUserPermissions := FUserPermissions - [AllowAnnotation];
  if FLevel = el128bit then
  begin
    if FPermissions[1] and 1 = 0 then
      FUserPermissions := FUserPermissions - [AllowFormFill];
    if FPermissions[1] and 2 = 0 then
      FUserPermissions := FUserPermissions - [AllowAccessibility];
    if FPermissions[1] and 4 = 0 then
      FUserPermissions := FUserPermissions - [AllowDocAssembly];
    if FPermissions[1] and 8 = 0 then
      FUserPermissions := FUserPermissions - [AllowHighResPrint];
  end;
end;

end.
