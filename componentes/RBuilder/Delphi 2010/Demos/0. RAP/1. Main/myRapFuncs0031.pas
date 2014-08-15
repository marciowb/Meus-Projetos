{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit myRapFuncs0031;

interface

{An example of how to create your own Pass-through functions for RAP.

Properly coded descendants of TraSystemFunction (declared in raFunc) that are
registered by calling raRegisterFunction (also declared in raFunc) will appear
in the RAP Code Toolbox. Following this method you can surface new methods for
you and your users to use in RAP.}

{see myRapFuncs0032 for more information}

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, raFunc, ppRTTI;

type
  TmyTrimFunction = class (TraStringFunction)
  public
    procedure ExecuteFunction(aParams: TraParamList); override;
    class function GetSignature: String; override;
  end;

implementation


{------------------------------------------------------------------------------}
{ TmyTrimFunction.GetSignature }

class function TmyTrimFunction.GetSignature: String;
begin
  Result := 'function Trim(const S: string): string;';
end; {class function, GetSignature}

{------------------------------------------------------------------------------}
{ TmyTrimFunction.ExecuteFunction }

procedure TmyTrimFunction.ExecuteFunction(aParams: TraParamList);
var
  lsResult: String;
  lsString: String;
begin

  GetParamValue(0, lsString);

  lsResult := Trim(lsString);

  SetParamValue(1, lsResult);

end; {procedure, ExecuteFunction}


initialization
  raRegisterFunction('Trim', TmyTrimFunction);

finalization
  raUnRegisterFunction('Trim');

end.
