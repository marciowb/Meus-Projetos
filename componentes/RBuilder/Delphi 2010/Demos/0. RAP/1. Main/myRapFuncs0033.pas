{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit myRapFuncs0033;

interface

  {See myRapFuncs0032.pas for more information.}

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, raFunc, ppRTTI, myRapFuncs0032;

type

  {TmyExtractFileNameFunction }
  TmyExtractFileNameFunction = class (TmyFilenameFunction)
  public
    procedure ExecuteFunction(aParams: TraParamList); override;
    class function GetSignature: String; override;

  end; {class, TmyExtractFileNameFunction}

  {TmyExtractFileExtFunction }
  TmyExtractFileExtFunction = class (TmyFilenameFunction)
  public
    procedure ExecuteFunction(aParams: TraParamList); override;
    class function GetSignature: String; override;

  end; {class, TmyExtractFileExtFunction}

  {TmyExtractFilePathFunction }
  TmyExtractFilePathFunction = class (TmyFilenameFunction)
  public
    procedure ExecuteFunction(aParams: TraParamList); override;
    class function GetSignature: String; override;

  end; {class, TmyExtractFilePathFunction}

implementation

{******************************************************************************
 *
 ** E X T R A C T  F I L E N A M E   F U N C T I O N
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TmyExtractFileNameFunction.GetSignature }

class function TmyExtractFileNameFunction.GetSignature: String;
begin
  Result := 'function ExtractFileName(const FileName: string): string;';
end; {class function GetSignature}

{------------------------------------------------------------------------------}
{ TmyExtractFileNameFunction.ExecuteFunction }
{As noted in myRapFuncs0032.pas, the TraParamList contains all the parameters
for the method and the Result value. The Result value is the last item in aParams.}

procedure TmyExtractFileNameFunction.ExecuteFunction(aParams: TraParamList);
var
  lsResult: String;
  lsString: String;
begin

  GetParamValue(0, lsString);

  lsResult := ExtractFileName(lsString);

  SetParamValue(1, lsResult);
end; {Procedure ExecuteFunction}

{******************************************************************************
 *
 ** E X T R A C T  F I L E  E X T   F U N C T I O N
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TmyExtractFileExtFunction.GetSignature }

class function TmyExtractFileExtFunction.GetSignature: String;
begin
  Result := 'function ExtractFileExt(const FileName: string): string;';
end; {class function GetSignature}

{------------------------------------------------------------------------------}
{ TmyExtractFileExtFunction.ExecuteFunction }

procedure TmyExtractFileExtFunction.ExecuteFunction(aParams: TraParamList);
var
  lsResult: String;
  lsString: String;
begin

  GetParamValue(0, lsString);

  lsResult := ExtractFileExt(lsString);

  SetParamValue(1, lsResult);

end; {Procedure ExecuteFunction}


{******************************************************************************
 *
 ** E X T R A C T  F I L E  P A T H  F U N C T I O N
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TmyExtractFilePathFunction.GetSignature }

class function TmyExtractFilePathFunction.GetSignature: String;
begin
  Result := 'function ExtractFilePath(const FileName: string): string;';
end; {class function GetSignature}

{------------------------------------------------------------------------------}
{ TmyExtractFilePathFunction.ExecuteFunction }

procedure TmyExtractFilePathFunction.ExecuteFunction(aParams: TraParamList);
var
  lsResult: String;
  lsString: String;
begin

  GetParamValue(0, lsString);

  lsResult := ExtractFilePath(lsString);

  SetParamValue(1, lsResult);
end; {Procedure ExecuteFunction}


initialization

  raRegisterFunction('ExtractFileName', TmyExtractFileNameFunction);
  raRegisterFunction('ExtractFilePath', TmyExtractFilePathFunction);
  raRegisterFunction('ExtractFileExt', TmyExtractFileExtFunction);

end.
