{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit myRapFuncs0032;

interface

{An example of how to create your own Pass-through functions for RAP.

Properly coded descendants of TraSystemFunction (declared in raFunc) that are
registered by calling raRegisterFunction (also declared in raFunc) will appear
in the RAP Code Toolbox. Following this method you can surface new methods for
you and your users to use in RAP.}

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs,
  {declares TraSystemFunction and raRegisterFunction} raFunc,
  ppRTTI;

type
  {raFunc declares the following:

     TraSystemFunction
       |
        -- TraStringFunction
       |
        -- TraConversionFunction
       |
        -- TraFormatFunction
       |
        -- TraDateTimeFunction
       |
        -- TraMathFunction

   These descendants of TraSystemFunction override the Catagory class function
   to return a value that will become a category under the Function node in
   the Language tab of the Code Toolbox.

   You can either declare new subclasses under one of the existing categories:

     TMyNewStringFunction = class(TraStringFunction)

     this function would appear in the String category -

   or you can declare a new category subclass, then descend a new function class
   from that one:

     TMyNewCategoryFunction = class(TraSystemFunction)

     TMyNewFunction = class(TMyNewCategoryFunction)


   This second method is what we are doing in this unit. We have declared a new
   descendant of TraSystemFunction to create a new category of "Filename" then
   we descend a new function class from it. This new function will appear in the
   Code Toolbox in the Langauge tab under Functions|Filename.}


  TmyFilenameFunction = class (TraSystemFunction)
  public
    {Override Category to return a new category string}
    class function Category: String; override;
  end;

  {Descendants of TmyFilenameFunction will appear in the Filename category}
  TmyApplicationFilenameFunction = class (TmyFilenameFunction)
  public
    procedure ExecuteFunction(aParams: TraParamList); override;
    class function GetSignature: String; override;
    class function HasParams: Boolean; override;
  end;


implementation


{******************************************************************************
 *
 ** F I L E N A M E   F U N C T I O N
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TmyFilenameFunction.Category }

class function TmyFilenameFunction.Category: String;
begin
  Result := 'Filename';
end; {class function Category}


{******************************************************************************
 *
 ** A P P L I C A T I O N  F I L E N A M E   F U N C T I O N
 *
{******************************************************************************}


{------------------------------------------------------------------------------}
{ TmyApplicationFilenameFunction.GetSignature }
{GetSignature should return the string representation of the declaration of the
  RAP method. Note that this is not the Delphi version of the declaration.}

class function TmyApplicationFilenameFunction.GetSignature: String;
begin
  Result := 'function ApplicationFilename: string;';
end; {class function GetSignature}

{------------------------------------------------------------------------------}
{ TmyApplicationFilenameFunction.HasParams }
{HasParams defaults to return True. For a method with no parameters, we should
  override and return False.}

class function TmyApplicationFilenameFunction.HasParams: Boolean;
begin
  Result := False;
end; {class function HasParams}

{------------------------------------------------------------------------------}
{ TmyApplicationFilenameFunction.ExecuteFunction }
{This method is executed when RAP attempts to execute the pass-through method.
  Place in here the code to assign parameters and Results.
  TraParamList contains all the parameters of the method and the Result value,
  if there is one. The Result value is always the last item in aParams.}

procedure TmyApplicationFilenameFunction.ExecuteFunction(aParams: TraParamList);
var
  {include a local var for each parameter and the Result value}
  lsResult: String;
begin

  {Call the actual Delphi method and pass the Result to a local var.}
  lsResult := Application.Exename;

  {Set the last item in the TraParamList as the Result.}
  SetParamValue(0, lsResult);

end; {Procedure ExecuteFunction}




initialization

  raRegisterFunction('ApplicationFilename', TmyApplicationFilenameFunction);

finalization

  raUnRegisterFunction('ApplicationFilename');

end.
