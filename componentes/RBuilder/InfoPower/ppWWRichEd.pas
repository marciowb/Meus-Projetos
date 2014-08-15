{******************************************************************************}
{                                                                              }
{                   ReportBuilder Report Component Library                     }
{                                                                              }
{             Copyright (c) 1996, 1999 Digital Metaphors Corporation           }
{                                                                              }
{******************************************************************************}

unit ppWWRichEd;

interface

  { InfoPower RichEdit support.

    This unit defines a TwwDBRichEdit descendant and then registers the class
    with ReportBuilder. This enables the TppRichText and TppDBRichText controls
    in ReportBuilder to use the formatting capabilities of TwwDBRichEidt when
    rendering data.

    Add this unit to the 'uses' clauses of the main form of your application to
    use it a runtime.

    Build and Install the rbIPxx.bpl package into the Delphi IDE to use this unit at
    Delphi designt-time.

    }


uses
  Windows,
  Controls,
  Messages,
  Classes,
  RichEdit,
  ComCtrls,
  ppRichTxDrwCmd,
  wwRichEd;

type

  {TppWWRichEdit }
  TppWWRichEdit = class(TwwDBRichEdit)
    private
      procedure EMFormatRange(var msg:TMessage); message EM_FORMATRANGE;
      function GetLines: TStrings;
      procedure SetLines(const Value: TStrings);

      {$IFDEF UNICODE}
      procedure EMFindText(var msg:TMessage); message EM_FINDTEXT;
      {$ENDIF}

    protected
      procedure CreateParams(var Params: TCreateParams); override;

    published
      // work around for bug in ancestor class (IP Studio )
      property Lines: TStrings read GetLines write SetLines;


  end; {class, TppWWRichEdit}


implementation

{------------------------------------------------------------------------------}
{ TppWWRichEdit.CreateParams }

procedure TppWWRichEdit.CreateParams(var Params: TCreateParams);
begin

  inherited CreateParams(Params);

  {remove ws-child so that no parent window is required}
  if (Parent = nil) then
    Params.Style := Params.Style and not(WS_CHILD);

end; {procedure, CreateParams}

{------------------------------------------------------------------------------}
{ TppWWRichEdit.EMFormatRange }

procedure TppWWRichEdit.EMFormatRange(var msg:TMessage);
begin
  {must bypass the EMFormatRange of the ancestor, TwwCustomRichEdit,
   because it modifies the target rectangle}
  DefaultHandler(Msg);

end; {procedure, EMFormatRange }

{------------------------------------------------------------------------------}
{ TppWWRichEdit.EMFindText }

{$IFDEF UNICODE}
procedure TppWWRichEdit.EMFindText(var msg: TMessage);
begin
  //Need to take control over the EM_FINDTEXT message for versions of Delphi
  //Unicode support to ensure the EM_FINDTEXTW message is sent.
  msg.Result := SendMessage(Handle, EM_FINDTEXTW, msg.WParam, msg.LParam);

end; {procedure, EMFindText }
{$ENDIF}

{------------------------------------------------------------------------------}
{ TppWWRichEdit.GetLines }

function TppWWRichEdit.GetLines: TStrings;
begin
  Result := Self.ILines; // return the ILines reference
end;

{------------------------------------------------------------------------------}
{ TppWWRichEdit.SetLines }

procedure TppWWRichEdit.SetLines(const Value: TStrings);
begin
  Self.ILines.Assign(Value); // assign to ILines
end;

{******************************************************************************
 *
 ** I N I T I A L I Z A T I O N   /   F I N A L I Z A T I O N
 *
{******************************************************************************}

initialization
  ppRegisterRichEditClass(TppWWRichEdit);

finalization
  ppRegisterRichEditClass(nil);
  
end.
