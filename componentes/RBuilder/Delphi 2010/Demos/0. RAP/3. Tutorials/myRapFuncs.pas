{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit myRapFuncs;

interface

uses
  Forms, raFunc, ppRTTI;

type
  { TmyFilenameFunction }
  TmyFilenameFunction = class (TraSystemFunction)
  public
    class function Category: string; override;
  end;

  { TmyApplicationFilenameFunction }
  TmyApplicationFilenameFunction = class (TmyFilenameFunction)
  public
    procedure ExecuteFunction(aParams: TraParamList); override;
    class function GetSignature: string; override;
    class function HasParams: Boolean; override;
  end;

implementation


{------------------------------------------------------------------------------}
{ TmyFilenameFunction.Category}

class function TmyFilenameFunction.Category: string;
begin

  result := 'Filename';

end;{ class function, Category }


{------------------------------------------------------------------------------}
{ TmyApplicationFilenameFunction.ExecuteFunction}

procedure TmyApplicationFilenameFunction.ExecuteFunction(aParams: TraParamList);
var
  lsResult: string;
begin

  lsResult := Application.Exename;
  
  SetParamValue(0, lsResult);

end;{ procedure, ExecuteFunction }


{------------------------------------------------------------------------------}
{ TmyApplicationFilenameFunction.GetSignature}

class function TmyApplicationFilenameFunction.GetSignature: string;
begin

  result := 'function ApplicationFilename: string;';

end;{ class function, GetSignature }


{------------------------------------------------------------------------------}
{ TmyApplicationFilenameFunction.HasParams}

class function TmyApplicationFilenameFunction.HasParams: Boolean;
begin

  result := False;

end;{ class function, HasParams }



initialization
  raRegisterFunction('ApplicationFilename', TmyApplicationFilenameFunction);

finalization
  raUnRegisterFunction('ApplicationFilename');

end.
