{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit ppDBBDE;

interface

{@$I ppIfDef.pas}

uses
  Classes, ppDBPipe;


type

  {@TppBDEPipeline

   Identical to TppDBPipeline. Retained for backward compatibility.}

  TppBDEPipeline = class(TppDBPipeline);


 {@TppChildBDEPipeline }
  TppChildBDEPipeline = class(TppBDEPipeline)
    protected
      function GetChildOwner: TComponent; override;
      
    public
      function HasParent: Boolean; override;

    published
      property DataSource stored False;

    end; {class, TppChildBDEPipeline}

implementation

{******************************************************************************
 *
 ** C H I L D   B D E  P I P E L I N E
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppChildBDEPipeline.GetChildOwner }

function TppChildBDEPipeline.GetChildOwner: TComponent;
begin
  Result := Self;
end; {function, GetChildOwner}

{------------------------------------------------------------------------------}
{ TppChildBDEPipeline.HasParent }

function TppChildBDEPipeline.HasParent: Boolean;
begin
  Result := True;
end; {function, HasParent}



{******************************************************************************
 *
 ** I N I T I A L I Z A T I O N   /   F I N A L I Z A T I O N
 *
{******************************************************************************}

initialization

  RegisterClasses([TppBDEPipeline, TppChildBDEPipeline]);

finalization

  UnRegisterClasses([TppBDEPipeline, TppChildBDEPipeline]);

end.
