{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit myRapFuncsForm;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls, Forms, Dialogs,
  raFunc, ppRTTI, myUserInputForm;

type

  { TmyShowFormFunction }
  TmyShowFormFunction = class (TraSystemFunction)
    public
      class function Category: string; override;
      procedure ExecuteFunction(aParams: TraParamList); override;
      class function GetSignature: string; override;
  end;

implementation


{------------------------------------------------------------------------------}
{ TmyShowFormFunction.Category}

class function TmyShowFormFunction.Category: string;
begin

  Result := 'User Input Forms';

end;{ class function, Category }

{------------------------------------------------------------------------------}
{ TmyShowFormFunction.GetSignature}

class function TmyShowFormFunction.GetSignature: string;
begin

  result := 'function ExecuteShowForm(var aReportHeading: String; var aDestinationIndex: Integer): Boolean;';

end;{ class function, GetSignature }

{------------------------------------------------------------------------------}
{ TmyShowFormFunction.ExecuteFunction}

procedure TmyShowFormFunction.ExecuteFunction(aParams: TraParamList);
var
  lString: string;
  lInteger: Integer;
  lbResult: Boolean;
  lInputForm: TfrmMyUserInput;
begin

  GetParamValue(0, lString);
  GetParamValue(1, lInteger);

  lInputForm := TfrmMyUserInput.Create(Application);
  try
    lInputForm.InitDialog(True, lString, '');

    if lInputForm.ShowModal = mrOK then
      begin
        lString := lInputForm.ebHeading.Text;

        lInteger := lInputForm.rgDestination.ItemIndex;
        lbResult := True;
      end

    else
      lbResult := False;

  finally
    lInputForm.Free;
  end;

  SetParamValue(0, lString);
  SetParamValue(1, lInteger);
  SetParamValue(2, lbResult);

end;{ procedure, ExecuteFunction }


initialization
  raRegisterFunction('ExecuteShowForm', TmyShowFormFunction);

finalization
  raUnRegisterFunction('ExecuteShowForm');

end.
