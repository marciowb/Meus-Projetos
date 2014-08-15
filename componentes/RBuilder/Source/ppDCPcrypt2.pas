{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2009                    BBBBB   }

{******************************************************************************}
{* DCPcrypt v2.0 written by David Barton (crypto@cityinthesky.co.uk) **********}
{******************************************************************************}
{* Main component definitions *************************************************}
{******************************************************************************}
{* Copyright (c) 1999-2003 David Barton                                       *}
{* Permission is hereby granted, free of charge, to any person obtaining a    *}
{* copy of this software and associated documentation files (the "Software"), *}
{* to deal in the Software without restriction, including without limitation  *}
{* the rights to use, copy, modify, merge, publish, distribute, sublicense,   *}
{* and/or sell copies of the Software, and to permit persons to whom the      *}
{* Software is furnished to do so, subject to the following conditions:       *}
{*                                                                            *}
{* The above copyright notice and this permission notice shall be included in *}
{* all copies or substantial portions of the Software.                        *}
{*                                                                            *}
{* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR *}
{* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,   *}
{* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL    *}
{* THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER *}
{* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING    *}
{* FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER        *}
{* DEALINGS IN THE SOFTWARE.                                                  *}
{******************************************************************************}
unit ppDCPcrypt2;

interface

{$I ppIfDef.pas}

uses
  Classes, Sysutils, ppDCPconst{, DCPbase64};

//{$DEFINE DCP1COMPAT}  { DCPcrypt v1.31 compatiblity mode - see documentation }

{******************************************************************************}
    { A few predefined types to help out }

type
  Pbyte= ^byte;
  Pword= ^word;
  Pdword= ^dword;
  Pint64= ^int64;
  dword= longword;
  Pwordarray= ^Twordarray;
  Twordarray= array[0..19383] of word;
  Pdwordarray= ^Tdwordarray;
  Tdwordarray= array[0..8191] of dword;


{******************************************************************************}
    { The base class from which all hash algorithms are to be derived  }

type
  TppEDCP_hash = class(Exception)
  end;

  TppDCP_hash = class(TComponent)
  protected
    fInitialized: boolean;  { Whether or not the algorithm has been initialized }

    procedure DeadInt(Value: integer);   { Knudge to display vars in the object inspector   }
    procedure DeadStr(Value: string);    { Knudge to display vars in the object inspector   }
  
  private
    function _GetId: integer;
    function _GetAlgorithm: string;
    function _GetHashSize: integer; 

  public
    property Initialized: boolean
      read fInitialized;

    class function GetId: integer; virtual;
      { Get the algorithm id }
    class function GetAlgorithm: string; virtual;
      { Get the algorithm name }
    class function GetHashSize: integer; virtual;
      { Get the size of the digest produced - in bits }
    class function SelfTest: boolean; virtual;
      { Tests the implementation with several test vectors }

    procedure Init; virtual;
      { Initialize the hash algorithm }
    procedure Final(var Digest); virtual;
      { Create the final digest and clear the stored information.
        The size of the Digest var must be at least equal to the hash size }
    procedure Burn; virtual;
      { Clear any stored information with out creating the final digest }

    procedure Update(const Buffer; Size: longword); virtual;
      { Update the hash buffer with Size bytes of data from Buffer }
    procedure UpdateStream(Stream: TStream; Size: longword);
      { Update the hash buffer with Size bytes of data from the stream }
    procedure UpdateStr(const Str: AnsiString); overload;
{$IFDEF Unicode}
    procedure UpdateStr(const Str: String); overload;
{$ENDIF}
      { Update the hash buffer with the string }

    destructor Destroy; override;

  published
    property Id: integer
      read _GetId write DeadInt;
    property Algorithm: string
      read _GetAlgorithm write DeadStr;
    property HashSize: integer
      read _GetHashSize write DeadInt;
  end;
  TppDCP_hashclass= class of TppDCP_hash;


{******************************************************************************}
    { The base class from which all encryption components will be derived. }
    { Stream ciphers will be derived directly from this class where as     }
    { Block ciphers will have a further foundation class TDCP_blockcipher. }

type
  TppEDCP_cipher = class(Exception)
  end;

  TppDCP_cipher = class(TComponent)
  protected
    fInitialized: boolean;  { Whether or not the key setup has been done yet }

    procedure DeadInt(Value: integer);   { Knudge to display vars in the object inspector   }
    procedure DeadStr(Value: string);    { Knudge to display vars in the object inspector   }

  private
    function _GetId: integer;
    function _GetAlgorithm: string;
    function _GetMaxKeySize: integer; 

  public
    property Initialized: boolean
      read fInitialized;

    class function GetId: integer; virtual;
      { Get the algorithm id }
    class function GetAlgorithm: string; virtual;
      { Get the algorithm name }
    class function GetMaxKeySize: integer; virtual;
      { Get the maximum key size (in bits) }
    class function SelfTest: boolean; virtual;
      { Tests the implementation with several test vectors }

    procedure Init(const Key; Size: longword; InitVector: pointer); virtual;
      { Do key setup based on the data in Key, size is in bits }
    procedure InitStr(const Key: AnsiString; HashType: TppDCP_hashclass);
      { Do key setup based on a hash of the key string }
    procedure Burn; virtual;
      { Clear all stored key information }
    procedure Reset; virtual;
      { Reset any stored chaining information }
    procedure Encrypt(const Indata; var Outdata; Size: longword); virtual;
      { Encrypt size bytes of data and place in Outdata }
    procedure Decrypt(const Indata; var Outdata; Size: longword); virtual;
      { Decrypt size bytes of data and place in Outdata }
    function EncryptStream(InStream, OutStream: TStream; Size: longword): longword;
      { Encrypt size bytes of data from InStream and place in OutStream }
    function DecryptStream(InStream, OutStream: TStream; Size: longword): longword;
      { Decrypt size bytes of data from InStream and place in OutStream }
    function EncryptString(const Str: AnsiString): AnsiString; virtual;
      { Encrypt a string and return Base64 encoded }
    function DecryptString(const Str: AnsiString): AnsiString; virtual;
      { Decrypt a Base64 encoded string }

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

  published
    property Id: integer
      read _GetId write DeadInt;
    property Algorithm: string
      read _GetAlgorithm write DeadStr;
    property MaxKeySize: integer
      read _GetMaxKeySize write DeadInt;
  end;
  TppDCP_cipherclass= class of TppDCP_cipher;


{******************************************************************************}
    { The base class from which all block ciphers are to be derived, this  }
    { extra class takes care of the different block encryption modes.      }

type
  TDCP_ciphermode= (cmCBC, cmCFB8bit, cmCFBblock, cmOFB, cmCTR); // cmCFB8bit is equal to DCPcrypt v1.xx's CFB mode

{******************************************************************************}
    { Helper functions }

procedure XorBlock(var InData1, InData2; Size: longword);


implementation
{$Q-}{$R-}


{** TppDCP_hash *****************************************************************}

procedure TppDCP_hash.DeadInt(Value: integer);
begin
end;

procedure TppDCP_hash.DeadStr(Value: string);
begin
end;

function TppDCP_hash._GetId: integer;
begin
  Result:= GetId;
end;

function TppDCP_hash._GetAlgorithm: string;
begin
  Result:= GetAlgorithm;
end;

function TppDCP_hash._GetHashSize: integer;
begin
  Result:= GetHashSize;
end; 

class function TppDCP_hash.GetId: integer;
begin
  Result:= -1;
end;

class function TppDCP_hash.GetAlgorithm: string;
begin
  Result:= '';
end;

class function TppDCP_hash.GetHashSize: integer;
begin
  Result:= -1;
end;

class function TppDCP_hash.SelfTest: boolean;
begin
  Result:= false;
end;

procedure TppDCP_hash.Init;
begin
end;

procedure TppDCP_hash.Final(var Digest);
begin
end;

procedure TppDCP_hash.Burn;
begin
end;

procedure TppDCP_hash.Update(const Buffer; Size: longword);
begin
end;

procedure TppDCP_hash.UpdateStream(Stream: TStream; Size: longword);
var
  Buffer: array[0..8191] of byte;
  i, read: integer;
begin
  for i:= 1 to (Size div Sizeof(Buffer)) do
  begin
    read:= Stream.Read(Buffer,Sizeof(Buffer));
    Update(Buffer,read);
  end;
  if (Size mod Sizeof(Buffer))<> 0 then
  begin
    read:= Stream.Read(Buffer,Size mod Sizeof(Buffer));
    Update(Buffer,read);
  end;
end;

procedure TppDCP_hash.UpdateStr(const Str: AnsiString);
begin
  Update(Str[1],Length(Str));
end;

destructor TppDCP_hash.Destroy;
begin
  if fInitialized then
    Burn;
  inherited Destroy;
end;

{$IFDEF Unicode}

procedure TppDCP_hash.UpdateStr(const Str: String);
var
  lBytes: TBytes;
begin

  lBytes := TEncoding.Unicode.GetBytes(Str);

  if Length(lBytes) > 0 then
    Update(lBytes[0], Length(lBytes));

end;

{$ENDIF}

{** TppDCP_cipher ***************************************************************}

procedure TppDCP_cipher.DeadInt(Value: integer);
begin
end;

procedure TppDCP_cipher.DeadStr(Value: string);
begin
end;

function TppDCP_cipher._GetId: integer;
begin
  Result:= GetId;
end;

function TppDCP_cipher._GetAlgorithm: string;
begin
  Result:= GetAlgorithm;
end;

function TppDCP_cipher._GetMaxKeySize: integer;
begin
  Result:= GetMaxKeySize;
end; 

class function TppDCP_cipher.GetId: integer;
begin
  Result:= -1;
end;

class function TppDCP_cipher.GetAlgorithm: string;
begin
  Result:= '';
end;

class function TppDCP_cipher.GetMaxKeySize: integer;
begin
  Result:= -1;
end;

class function TppDCP_cipher.SelfTest: boolean;
begin
  Result:= false;
end;

procedure TppDCP_cipher.Init(const Key; Size: longword; InitVector: pointer);
begin
  if fInitialized then
    Burn;
  if (Size <= 0) or ((Size and 3)<> 0) or (Size> longword(GetMaxKeySize)) then
    raise TppEDCP_cipher.Create('Invalid key size')
  else
    fInitialized:= true;
end;

procedure TppDCP_cipher.InitStr(const Key: AnsiString; HashType: TppDCP_hashclass);
var
  Hash: TppDCP_hash;
  Digest: pointer;
begin
  if fInitialized then
    Burn;
  try
    GetMem(Digest,HashType.GetHashSize div 8);
    Hash:= HashType.Create(Self);
    Hash.Init;
    Hash.UpdateStr(Key);
    Hash.Final(Digest^);
    Hash.Free;
    if MaxKeySize< HashType.GetHashSize then
      Init(Digest^,MaxKeySize,nil)
    else
      Init(Digest^,HashType.GetHashSize,nil);
    FillChar(Digest^,HashType.GetHashSize div 8,$FF);
    FreeMem(Digest);
  except
    raise TppEDCP_cipher.Create('Unable to allocate sufficient memory for hash digest');
  end;
end;

procedure TppDCP_cipher.Burn;
begin
  fInitialized:= false;
end;

procedure TppDCP_cipher.Reset;
begin
end;

procedure TppDCP_cipher.Encrypt(const Indata; var Outdata; Size: longword);
begin
end;

procedure TppDCP_cipher.Decrypt(const Indata; var Outdata; Size: longword);
begin
end;

function TppDCP_cipher.EncryptStream(InStream, OutStream: TStream; Size: longword): longword;
var
  Buffer: array[0..8191] of byte;
  i, Read: longword;
begin
  Result:= 0;
  for i:= 1 to (Size div Sizeof(Buffer)) do
  begin
    Read:= InStream.Read(Buffer,Sizeof(Buffer));
    Inc(Result,Read);
    Encrypt(Buffer,Buffer,Read);
    OutStream.Write(Buffer,Read);
  end;
  if (Size mod Sizeof(Buffer))<> 0 then
  begin
    Read:= InStream.Read(Buffer,Size mod Sizeof(Buffer));
    Inc(Result,Read);
    Encrypt(Buffer,Buffer,Read);
    OutStream.Write(Buffer,Read);
  end;
end;

function TppDCP_cipher.DecryptStream(InStream, OutStream: TStream; Size: longword): longword;
var
  Buffer: array[0..8191] of byte;
  i, Read: longword;
begin
  Result:= 0;
  for i:= 1 to (Size div Sizeof(Buffer)) do
  begin
    Read:= InStream.Read(Buffer,Sizeof(Buffer));
    Inc(Result,Read);
    Decrypt(Buffer,Buffer,Read);
    OutStream.Write(Buffer,Read);
  end;
  if (Size mod Sizeof(Buffer))<> 0 then
  begin
    Read:= InStream.Read(Buffer,Size mod Sizeof(Buffer));
    Inc(Result,Read);
    Decrypt(Buffer,Buffer,Read);
    OutStream.Write(Buffer,Read);
  end;
end;

function TppDCP_cipher.EncryptString(const Str: AnsiString): AnsiString;
begin
  SetLength(Result,Length(Str));
  Encrypt(Str[1],Result[1],Length(Str));
  //Result:= Base64EncodeStr(Result);  //DM 05/20/09
end;

function TppDCP_cipher.DecryptString(const Str: AnsiString): AnsiString;
begin
  //Result:= Base64DecodeStr(Str);  //DM 05/20/09
  Decrypt(Result[1],Result[1],Length(Result));
end;

constructor TppDCP_cipher.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Burn;
end;

destructor TppDCP_cipher.Destroy;
begin
  if fInitialized then
    Burn;
  inherited Destroy;
end;



{** Helpher functions *********************************************************}
procedure XorBlock(var InData1, InData2; Size: longword);
var
  i: longword;
begin
  for i:= 1 to Size do
    Pbyte(longword(@InData1)+i-1)^:= Pbyte(longword(@InData1)+i-1)^ xor Pbyte(longword(@InData2)+i-1)^;
end;

end.

