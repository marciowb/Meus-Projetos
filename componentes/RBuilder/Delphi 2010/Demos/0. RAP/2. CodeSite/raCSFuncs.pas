{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit raCSFuncs;

interface

{$DEFINE CODESITE}            {remove the 'x' to enable CodeSite support}

{$ifdef CodeSite}
{.$define CodeSite2}
{.$define CodeSite3}
{$define CodeSite4}
{$endif}  // CodeSite

{$ifdef CodeSite3}
  {$define NewCS}
{$endif}  // NewCS
{$ifdef CodeSite4}
  {$define NewCS}
{$endif}  // CodeSite4

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs,
  {$IFDEF CODESITE}
    {$ifdef CodeSite2} CSIntf {$endif}
    {$ifdef NewCS} CodeSiteLogging, {$endif} 
  {$endif}
  raFunc, ppRTTI, ppEnum;

type
  TraCodeSiteMessageType = (cmtInfo, cmtWarning, cmtError, cmtCheckPoint, cmtObject,
     cmtStream, cmtStringList, cmtProperty, cmtNote, cmtEnterMethod, cmtExitMethod,
     cmtSeparator);
     
  { TraCodesiteFunction }
  TraCodesiteFunction = class (TraSystemFunction)
  public
    class function Category: String; override;
    class function IsFunction: Boolean; override;
  end;

  { TraCSAddCheckPointFunction }
  TraCSAddCheckPointFunction = class (TraCodesiteFunction)
  public
    procedure ExecuteFunction(aParams: TraParamList); override;
    class function GetSignature: String; override;
    class function HasParams: Boolean; override;
  end;

  { TraCSAddSeparatorFunction }
  TraCSAddSeparatorFunction = class (TraCodesiteFunction)
  public
    procedure ExecuteFunction(aParams: TraParamList); override;
    class function GetSignature: String; override;
    class function HasParams: Boolean; override;
  end;

  { TraCSClearFunction }
  TraCSClearFunction = class (TraCodesiteFunction)
  public
    procedure ExecuteFunction(aParams: TraParamList); override;
    class function GetSignature: String; override;
    class function HasParams: Boolean; override;
  end;

  { TraCSEnableFunction }
  TraCSEnableFunction = class (TraCodesiteFunction)
  public
    procedure ExecuteFunction(aParams: TraParamList); override;
    class function GetSignature: String; override;
  end;

  { TraCSEnterMethodFunction }
  TraCSEnterMethodFunction = class (TraCodesiteFunction)
  public
    procedure ExecuteFunction(aParams: TraParamList); override;
    class function GetSignature: String; override;
  end;

  { TraCSExitMethodFunction }
  TraCSExitMethodFunction = class (TraCodesiteFunction)
  public
    procedure ExecuteFunction(aParams: TraParamList); override;
    class function GetSignature: String; override;
  end;

  { TraCSScratchPadFunction }
  TraCSScratchPadFunction = class (TraCodesiteFunction)
  public
    procedure ExecuteFunction(aParams: TraParamList); override;
    class function GetSignature: String; override;
  end;

  { TraCSSendAssignedExFunction }
  TraCSSendAssignedExFunction = class (TraCodesiteFunction)
  public
    procedure ExecuteFunction(aParams: TraParamList); override;
    class function GetSignature: String; override;
  end;

  { TraCSSendAssignedFunction }
  TraCSSendAssignedFunction = class (TraCodesiteFunction)
  public
    procedure ExecuteFunction(aParams: TraParamList); override;
    class function GetSignature: String; override;
  end;

  { TraCSSendBooleanExFunction }
  TraCSSendBooleanExFunction = class (TraCodesiteFunction)
  public
    procedure ExecuteFunction(aParams: TraParamList); override;
    class function GetSignature: String; override;
  end;

  { TraCSSendBooleanFunction }
  TraCSSendBooleanFunction = class (TraCodesiteFunction)
  public
    procedure ExecuteFunction(aParams: TraParamList); override;
    class function GetSignature: String; override;
  end;

  { TraCSSendColorExFunction }
  TraCSSendColorExFunction = class (TraCodesiteFunction)
  public
    procedure ExecuteFunction(aParams: TraParamList); override;
    class function GetSignature: String; override;
  end;

  { TraCSSendColorFunction }
  TraCSSendColorFunction = class (TraCodesiteFunction)
  public
    procedure ExecuteFunction(aParams: TraParamList); override;
    class function GetSignature: String; override;
  end;

  { TraCSSendErrorFunction }
  TraCSSendErrorFunction = class (TraCodesiteFunction)
  public
    procedure ExecuteFunction(aParams: TraParamList); override;
    class function GetSignature: String; override;
  end;

  { TraCSSendIntegerExFunction }
  TraCSSendIntegerExFunction = class (TraCodesiteFunction)
  public
    procedure ExecuteFunction(aParams: TraParamList); override;
    class function GetSignature: String; override;
  end;

  { TraCSSendIntegerFunction }
  TraCSSendIntegerFunction = class (TraCodesiteFunction)
  public
    procedure ExecuteFunction(aParams: TraParamList); override;
    class function GetSignature: String; override;
  end;

  { TraCSSendMsgExFunction }
  TraCSSendMsgExFunction = class (TraCodesiteFunction)
  public
    procedure ExecuteFunction(aParams: TraParamList); override;
    class function GetSignature: String; override;
  end;

  { TraCSSendMsgFunction }
  TraCSSendMsgFunction = class (TraCodesiteFunction)
  public
    procedure ExecuteFunction(aParams: TraParamList); override;
    class function GetSignature: String; override;
  end;

  { TraCSSendNoteFunction }
  TraCSSendNoteFunction = class (TraCodesiteFunction)
  public
    procedure ExecuteFunction(aParams: TraParamList); override;
    class function GetSignature: String; override;
  end;

  { TraCSSendObjectFunction }
  TraCSSendObjectFunction = class (TraCodesiteFunction)
  public
    procedure ExecuteFunction(aParams: TraParamList); override;
    class function GetSignature: String; override;
  end;

  { TraCSSendPointExFunction }
  TraCSSendPointExFunction = class (TraCodesiteFunction)
  public
    procedure ExecuteFunction(aParams: TraParamList); override;
    class function GetSignature: String; override;
  end;

  { TraCSSendPointFunction }
  TraCSSendPointFunction = class (TraCodesiteFunction)
  public
    procedure ExecuteFunction(aParams: TraParamList); override;
    class function GetSignature: String; override;
  end;

  { TraCSSendPropertyFunction }
  TraCSSendPropertyFunction = class (TraCodesiteFunction)
  public
    procedure ExecuteFunction(aParams: TraParamList); override;
    class function GetSignature: String; override;
  end;

  { TraCSSendRectExFunction }
  TraCSSendRectExFunction = class (TraCodesiteFunction)
  public
    procedure ExecuteFunction(aParams: TraParamList); override;
    class function GetSignature: String; override;
  end;

  { TraCSSendRectFunction }
  TraCSSendRectFunction = class (TraCodesiteFunction)
  public
    procedure ExecuteFunction(aParams: TraParamList); override;
    class function GetSignature: String; override;
  end;

  { TraCSSendStreamFunction }
  TraCSSendStreamFunction = class (TraCodesiteFunction)
  public
    procedure ExecuteFunction(aParams: TraParamList); override;
    class function GetSignature: String; override;
  end;

  { TraCSSendStringExFunction }
  TraCSSendStringExFunction = class (TraCodesiteFunction)
  public
    procedure ExecuteFunction(aParams: TraParamList); override;
    class function GetSignature: String; override;
  end;

  { TraCSSendStringFunction }
  TraCSSendStringFunction = class (TraCodesiteFunction)
  public
    procedure ExecuteFunction(aParams: TraParamList); override;
    class function GetSignature: String; override;
  end;

  { TraCSSendStringListFunction }
  TraCSSendStringListFunction = class (TraCodesiteFunction)
  public
    procedure ExecuteFunction(aParams: TraParamList); override;
    class function GetSignature: String; override;
  end;

  { TraCSSendWarningFunction }
  TraCSSendWarningFunction = class (TraCodesiteFunction)
  public
    procedure ExecuteFunction(aParams: TraParamList); override;
    class function GetSignature: String; override;
  end;

  { TraCSSendCurrencyFunction }
  TraCSSendCurrencyFunction = class (TraCodeSiteFunction)
  Public
    procedure ExecuteFunction(aParams: TraParamList); override;
    class function GetSignature: String; override;
  end;

  { TraCSSendCurrencyExFunction }
  TraCSSendCurrencyExFunction = class (TraCodeSiteFunction)
  Public
    procedure ExecuteFunction(aParams: TraParamList); override;
    class function GetSignature: String; override;
  end;

  { TraCSSendFloatFunction }
  TraCSSendFloatFunction = class (TraCodeSiteFunction)
  Public
    procedure ExecuteFunction(aParams: TraParamList); override;
    class function GetSignature: String; override;
  end;

  { TraCSSendFloatExFunction }
  TraCSSendFloatExFunction = class (TraCodeSiteFunction)
  Public
    procedure ExecuteFunction(aParams: TraParamList); override;
    class function GetSignature: String; override;
  end;


{$IFDEF CODESITE}function GetCSMessageType(aMessageType: TraCodeSiteMessageType): Integer;{$ENDIF}

Const
  csAddCheckPointSignature = 'procedure csAddCheckPoint;';
  csAddSeparatorSignature = 'procedure csAddSeparator;';
  csClearSignature = 'procedure csClear;';
  csEnableSignature = 'procedure csEnable(aEnabled: Boolean);';
  csEnterMethodSignature = 'procedure csEnterMethod(const aMethodName: string);';
  csExitMethodSignature = 'procedure csExitMethod(const aMethodName: string);';
  csScratchPadSignature = 'procedure csScratchPad(LineIndex: Integer; const Msg: string);';
  csSendAssignedExSignature = 'procedure csSendAssignedEx(MsgType: TraCodeSiteMessageType; const Msg: string; Value: TObject);';
  csSendAssignedSignature = 'procedure csSendAssigned(const Msg: string; Value: TObject);';
  csSendBooleanExSignature = 'procedure csSendBooleanEx(MsgType: TraCodeSiteMessageType; const Msg: string; Expression: Boolean);';
  csSendBooleanSignature = 'procedure csSendBoolean(const Msg: string; Expression: Boolean);';
  csSendColorExSignature = 'procedure csSendColorEx(MsgType: TraCodeSiteMessageType; const Msg: string; Value: TColor);';
  csSendColorSignature = 'procedure csSendColor(const Msg: string; Value: TColor);';
  csSendCurrencyEx = 'procedure csSendCurrencyEx(MsgType: TraCodeSiteMessageType; const Msg: string; Value: Currency);';
  csSendCurrency = 'procedure csSendCurrency(const Msg: string; Value: Currency);';
  csSendErrorSignature = 'procedure csSendError(const Msg: string);';
  csSendFloatEx = 'procedure csSendFloatEx(MsgType: TraCodeSiteMessageType; const Msg: string; Value: Extended);';
  csSendFloat = 'procedure csSendFloat(const Msg: string; Value: Extended);';
  csSendIntegerExSignature = 'procedure csSendIntegerEx(MsgType: TraCodeSiteMessageType; const Msg: string; Value: Integer);';
  csSendIntegerSignature = 'procedure csSendInteger(const Msg: string; Value: Integer);';
  csSendMsgExSignature = 'procedure csSendMsgEx(MsgType: TraCodeSiteMessageType; const Msg: string);';
  csSendMsgSignature = 'procedure csSendMsg(const Msg: string);';
  csSendNoteSignature = 'procedure csSendNote(const Msg: string);';
  csSendObjectSignature = 'procedure csSendObject(const Msg: string; Obj: TObject);';
  csSendPointExSignature = 'procedure csSendPointEx(MsgType: TraCodeSiteMessageType; const Msg: string; X, Y: Integer);';
  csSendPointSignature = 'procedure csSendPoint(const Msg: string; X, Y: Integer);';
  csSendPropertySignature = 'procedure csSendProperty(const Msg: string; Obj: TObject; const PropName: string);';
  csSendRectExSignature = 'procedure csSendRectEx(MsgType: TraCodeSiteMessageType; const Msg: string; aLeft, aTop, aRight, aBottom: Integer);';
  csSendRectSignature = 'procedure csSendRect(const Msg: string; aLeft, aTop, aRight, aBottom: Integer);';
  csSendStreamSignature = 'procedure csSendStream(const Msg: string; Obj: TComponent);';
  csSendStringExSignature = 'procedure csSendStringEx(MsgType: TraCodeSiteMessageType; const Msg: string; const Value: string);';
  csSendStringSignature = 'procedure csSendString(const Msg: string; const Value: string);';
  csSendStringListSignature = 'procedure csSendStringList(const Msg: string; List: TStrings);';
  csSendWarningSignature = 'procedure csSendWarning(const Msg: string);';


implementation


{$IFDEF CODESITE}
function GetCSMessageType(aMessageType: TraCodeSiteMessageType): Integer;
begin

  Case aMessageType of
    cmtInfo: Result := csmInfo;
    cmtWarning: Result := csmWarning;
    cmtError: Result := csmError;
    cmtCheckPoint: Result := csmCheckPoint;
    cmtObject: Result := csmObject;
{$ifdef CodeSite2}
    cmtStream: Result := csmStream;
    cmtProperty: Result := csmProperty;
{$endif}  // CodeSite2
    cmtStringList: Result := csmStringList;
    cmtNote: Result := csmNote;
    cmtEnterMethod: Result := csmEnterMethod;
    cmtExitMethod: Result := csmExitMethod;
    cmtSeparator: Result := csmSeparator;
    else Result := -1;
  end;

end;
{$ENDIF}

{------------------------------------------------------------------------------}
{ TraCodesiteFunction.Category }
class function TraCodesiteFunction.Category: String;
begin
  result := 'Codesite';
end;{ TraCodesiteFunction .Category() }

{------------------------------------------------------------------------------}
{ TraCodesiteFunction.IsFunction }
class function TraCodesiteFunction.IsFunction: Boolean;
begin
  result := False;
end;{ TraCodesiteFunction .IsFunction() }

{------------------------------------------------------------------------------}
{ TraCSAddCheckPointFunction.ExecuteFunction }
procedure TraCSAddCheckPointFunction.ExecuteFunction(aParams: TraParamList);
begin
  {$IFDEF CODESITE}
  CodeSite.AddCheckPoint;
  {$ENDIF}
end;{ TraCSAddCheckPointFunction .ExecuteFunction() }

{------------------------------------------------------------------------------}
{ TraCSAddCheckPointFunction.GetSignature }
class function TraCSAddCheckPointFunction.GetSignature: String;
begin
  result := csAddCheckPointSignature;
end;{ TraCSAddCheckPointFunction .GetSignature() }

{------------------------------------------------------------------------------}
{ TraCSAddCheckPointFunction.HasParams }
class function TraCSAddCheckPointFunction.HasParams: Boolean;
begin
  result := False;
end;{ TraCSAddCheckPointFunction .HasParams() }

{------------------------------------------------------------------------------}
{ TraCSAddSeparatorFunction.ExecuteFunction }
procedure TraCSAddSeparatorFunction.ExecuteFunction(aParams: TraParamList);
begin
  {$IFDEF CODESITE}
  CodeSite.AddSeparator;
  {$ENDIF}
end;{ TraCSAddSeparatorFunction .ExecuteFunction() }

{------------------------------------------------------------------------------}
{ TraCSAddSeparatorFunction.GetSignature }
class function TraCSAddSeparatorFunction.GetSignature: String;
begin
  result := csAddSeparatorSignature;
end;{ TraCSAddSeparatorFunction .GetSignature() }

{------------------------------------------------------------------------------}
{ TraCSAddSeparatorFunction.HasParams }
class function TraCSAddSeparatorFunction.HasParams: Boolean;
begin
  result := False;
end;{ TraCSAddSeparatorFunction .HasParams() }

{------------------------------------------------------------------------------}
{ TraCSClearFunction.ExecuteFunction }
procedure TraCSClearFunction.ExecuteFunction(aParams: TraParamList);
begin
  {$IFDEF CODESITE}
  CodeSite.Clear;
  {$ENDIF}
end;{ TraCSClearFunction .ExecuteFunction() }

{------------------------------------------------------------------------------}
{ TraCSClearFunction.GetSignature }
class function TraCSClearFunction.GetSignature: String;
begin
  result := csClearSignature;
end;{ TraCSClearFunction .GetSignature() }

{------------------------------------------------------------------------------}
{ TraCSClearFunction.HasParams }
class function TraCSClearFunction.HasParams: Boolean;
begin
  result := False;
end;{ TraCSClearFunction .HasParams() }

{------------------------------------------------------------------------------}
{ TraCSEnableFunction.ExecuteFunction }
procedure TraCSEnableFunction.ExecuteFunction(aParams: TraParamList);
{$IFDEF CODESITE}
var
  lbEnabled: Boolean;
{$ENDIF}
begin
  {$IFDEF CODESITE}
  GetParamValue(0, lbEnabled);

  CodeSite.Enabled := lbEnabled;
  {$ENDIF}
end;{ TraCSEnableFunction .ExecuteFunction() }

{------------------------------------------------------------------------------}
{ TraCSEnableFunction.GetSignature }
class function TraCSEnableFunction.GetSignature: String;
begin
  result := csEnableSignature;
end;{ TraCSEnableFunction .GetSignature() }

{------------------------------------------------------------------------------}
{ TraCSEnterMethodFunction.ExecuteFunction }
procedure TraCSEnterMethodFunction.ExecuteFunction(aParams: TraParamList);
{$IFDEF CODESITE}
var
  lsString: String;
{$ENDIF}
begin
  {$IFDEF CODESITE}
  GetParamValue(0, lsString);

  CodeSite.EnterMethod(lsString);
  {$ENDIF}
end;{ TraCSEnterMethodFunction .ExecuteFunction() }

{------------------------------------------------------------------------------}
{ TraCSEnterMethodFunction.GetSignature }
class function TraCSEnterMethodFunction.GetSignature: String;
begin
  result := csEnterMethodSignature;
end;{ TraCSEnterMethodFunction .GetSignature() }

{------------------------------------------------------------------------------}
{ TraCSExitMethodFunction.ExecuteFunction }
procedure TraCSExitMethodFunction.ExecuteFunction(aParams: TraParamList);
{$IFDEF CODESITE}
var
  lsString: String;
{$ENDIF}
begin
  {$IFDEF CODESITE}
  GetParamValue(0, lsString);

  CodeSite.ExitMethod(lsString);
  {$ENDIF}
end;{ TraCSExitMethodFunction .ExecuteFunction() }

{------------------------------------------------------------------------------}
{ TraCSExitMethodFunction.GetSignature }
class function TraCSExitMethodFunction.GetSignature: String;
begin
  result := csExitMethodSignature;
end;{ TraCSExitMethodFunction .GetSignature() }

{------------------------------------------------------------------------------}
{ TraCSScratchPadFunction.ExecuteFunction }
procedure TraCSScratchPadFunction.ExecuteFunction(aParams: TraParamList);
{$IFDEF CODESITE}
var
  liIndex: Integer;
  lsMsg: String;
{$ENDIF}
begin
  {$IFDEF CODESITE}
  GetParamValue(0, liIndex);
  GetParamValue(1, lsMsg);

{$ifdef CodeSite2}
  CodeSite.ScratchPad(liIndex, lsMsg);
{$endif}  // CodeSite2
{$ifdef NewCS}
{$endif}  
  {$ENDIF}
end;{ TraCSScratchPadFunction .ExecuteFunction() }

{------------------------------------------------------------------------------}
{ TraCSScratchPadFunction.GetSignature }
class function TraCSScratchPadFunction.GetSignature: String;
begin
  result := csScratchPadSignature;
end;{ TraCSScratchPadFunction .GetSignature() }

{------------------------------------------------------------------------------}
{ TraCSSendAssignedExFunction.ExecuteFunction }
procedure TraCSSendAssignedExFunction.ExecuteFunction(aParams: TraParamList);
{$IFDEF CODESITE}
var
  lMessageType: TraCodeSiteMessageType;
  lsMsg: String;
  lValue: TObject;
  liMsgType: Integer;
{$ENDIF}
begin
  {$IFDEF CODESITE}
  GetParamValue(0, lMessageType);
  GetParamValue(1, lsMsg);
  GetParamValue(2, lValue);

{$ifdef CodeSite2}
  liMsgType := GetCSMessageType(lMessageType);
  CodeSite.SendAssignedEx(liMsgType, lsMsg, Pointer(lValue));
{$endif}  // CodeSite2
{$ifdef NewCS}
  liMsgType := 0;
  CodeSite.Send(liMsgType, lsMsg, Pointer(lValue));
{$endif}  // NewCS
  {$ENDIF}
end;{ TraCSSendAssignedExFunction .ExecuteFunction() }

{------------------------------------------------------------------------------}
{ TraCSSendAssignedExFunction.GetSignature }
class function TraCSSendAssignedExFunction.GetSignature: String;
begin
  Result := csSendAssignedExSignature;
end;{ TraCSSendAssignedExFunction .GetSignature() }

{------------------------------------------------------------------------------}
{ TraCSSendAssignedFunction.ExecuteFunction }
procedure TraCSSendAssignedFunction.ExecuteFunction(aParams: TraParamList);
{$IFDEF CODESITE}
var
  lsMsg: String;
  lValue: TObject;
{$ENDIF}
begin
  {$IFDEF CODESITE}
  GetParamValue(0, lsMsg);
  GetParamValue(1, lValue);

  CodeSite.SendAssigned(lsMsg, Pointer(lValue));
  {$ENDIF}
end;{ TraCSSendAssignedFunction .ExecuteFunction() }

{------------------------------------------------------------------------------}
{ TraCSSendAssignedFunction.GetSignature }
class function TraCSSendAssignedFunction.GetSignature: String;
begin
  Result := csSendAssignedSignature;
end;{ TraCSSendAssignedFunction .GetSignature() }

{------------------------------------------------------------------------------}
{ TraCSSendBooleanExFunction.ExecuteFunction }
procedure TraCSSendBooleanExFunction.ExecuteFunction(aParams: TraParamList);
{$IFDEF CODESITE}
var
  liMsgType: Integer;
  lsMsg: String;
  lbExpression: Boolean;
  lMessageType: TraCodeSiteMessageType;
{$ENDIF}
begin
  {$IFDEF CODESITE}
  GetParamValue(0, lMessageType);
  GetParamValue(1, lsMsg);
  GetParamValue(2, lbExpression);

  liMsgType := GetCSMessageType(lMessageType);
{$ifdef CodeSite2}
  CodeSite.SendBooleanEx(liMsgType, lsMsg, lbExpression);
{$endif}  // CodeSite2
{$ifdef NewCS}
  CodeSite.Send(liMsgType, lsMsg, lbExpression);
{$endif}  // NewCS
  {$ENDIF}
end;{ TraCSSendBooleanExFunction .ExecuteFunction() }

{------------------------------------------------------------------------------}
{ TraCSSendBooleanExFunction.GetSignature }
class function TraCSSendBooleanExFunction.GetSignature: String;
begin
  result := csSendBooleanExSignature;
end;{ TraCSSendBooleanExFunction .GetSignature() }

{------------------------------------------------------------------------------}
{ TraCSSendBooleanFunction.ExecuteFunction }
procedure TraCSSendBooleanFunction.ExecuteFunction(aParams: TraParamList);
{$IFDEF CODESITE}
var
  lsMsg: String;
  lbExpression: Boolean;
{$ENDIF}
begin
  {$IFDEF CODESITE}
  GetParamValue(0, lsMsg);
  GetParamValue(1, lbExpression);

{$ifdef CodeSite2}
  CodeSite.SendBoolean(lsMsg, lbExpression);
{$endif}  // CodeSite2
{$ifdef NewCS}
  CodeSite.Send(lsMsg, lbExpression);
{$endif}  // NewCS
  {$ENDIF}
end;{ TraCSSendBooleanFunction .ExecuteFunction() }

{------------------------------------------------------------------------------}
{ TraCSSendBooleanFunction.GetSignature }
class function TraCSSendBooleanFunction.GetSignature: String;
begin
  result := csSendBooleanSignature;
end;{ TraCSSendBooleanFunction .GetSignature() }

{------------------------------------------------------------------------------}
{ TraCSSendColorExFunction.ExecuteFunction }
procedure TraCSSendColorExFunction.ExecuteFunction(aParams: TraParamList);
{$IFDEF CODESITE}
var
{$ifdef CodeSite2}
  liMsgType: Integer;
{$endif}  // Debug
  lsMsg: String;
  lValue: TColor;
  lMessageType: TraCodeSiteMessageType;
{$ENDIF}
begin
  {$IFDEF CODESITE}
  GetParamValue(0, lMessageType);
  GetParamValue(1, lsMsg);
  GetParamValue(2, lValue);


{$ifdef CodeSite2}
  liMsgType := GetCSMessageType(lMessageType);
  CodeSite.SendColorEx(liMsgType, lsMsg, lValue);
{$endif}  // CodeSite2
{$ifdef NewCS}
  {Not supported}
{$endif}  // NewCS
  {$ENDIF}
end;{ TraCSSendColorExFunction .ExecuteFunction() }

{------------------------------------------------------------------------------}
{ TraCSSendColorExFunction.GetSignature }
class function TraCSSendColorExFunction.GetSignature: String;
begin
  result := csSendColorExSignature;
end;{ TraCSSendColorExFunction .GetSignature() }

{------------------------------------------------------------------------------}
{ TraCSSendColorFunction.ExecuteFunction }
procedure TraCSSendColorFunction.ExecuteFunction(aParams: TraParamList);
{$IFDEF CODESITE}
var
  lsMsg: String;
  lValue: TColor;
{$ENDIF}
begin
  {$IFDEF CODESITE}
  GetParamValue(0, lsMsg);
  GetParamValue(1, lValue);

  CodeSite.SendColor(lsMsg, lValue);
  {$ENDIF}
end;{ TraCSSendColorFunction .ExecuteFunction() }

{------------------------------------------------------------------------------}
{ TraCSSendColorFunction.GetSignature }
class function TraCSSendColorFunction.GetSignature: String;
begin
  result := csSendColorSignature;
end;{ TraCSSendColorFunction .GetSignature() }

{------------------------------------------------------------------------------}
{ TraCSSendErrorFunction.ExecuteFunction }
procedure TraCSSendErrorFunction.ExecuteFunction(aParams: TraParamList);
{$IFDEF CODESITE}
var
  lsMsg: String;
{$ENDIF}
begin
  {$IFDEF CODESITE}
  GetParamValue(0, lsMsg);

  CodeSite.SendError(lsMsg);
  {$ENDIF}
end;{ TraCSSendErrorFunction .ExecuteFunction() }

{------------------------------------------------------------------------------}
{ TraCSSendErrorFunction.GetSignature }
class function TraCSSendErrorFunction.GetSignature: String;
begin
  Result := csSendErrorSignature;
end;{ TraCSSendErrorFunction .GetSignature() }

{------------------------------------------------------------------------------}
{ TraCSSendIntegerExFunction.ExecuteFunction }
procedure TraCSSendIntegerExFunction.ExecuteFunction(aParams: TraParamList);
{$IFDEF CODESITE}
var
  liMsgType: Integer;
  lsMsg: String;
  liValue: Integer;
  lMessageType: TraCodeSiteMessageType;
{$ENDIF}
begin
  {$IFDEF CODESITE}
  GetParamValue(0, lMessageType);
  GetParamValue(1, lsMsg);
  GetParamValue(2, liValue);

  liMsgType := GetCSMessageType(lMessageType);

{$ifdef CodeSite2}
  CodeSite.SendIntegerEx(liMsgType, lsMsg, liValue);
{$endif}  // CodeSite2
{$ifdef NewCS}
  CodeSite.Send(liMsgType, lsMsg, liValue);
{$endif}  // NewCS
  {$ENDIF}
end;{ TraCSSendIntegerExFunction .ExecuteFunction() }

{------------------------------------------------------------------------------}
{ TraCSSendIntegerExFunction.GetSignature }
class function TraCSSendIntegerExFunction.GetSignature: String;
begin
  result := csSendIntegerExSignature;
end;{ TraCSSendIntegerExFunction .GetSignature() }

{------------------------------------------------------------------------------}
{ TraCSSendIntegerFunction.ExecuteFunction }
procedure TraCSSendIntegerFunction.ExecuteFunction(aParams: TraParamList);
{$IFDEF CODESITE}
var
  lsMsg: String;
  liValue: Integer;
{$ENDIF}
begin
  {$IFDEF CODESITE}
  GetParamValue(0, lsMsg);
  GetParamValue(1, liValue);

{$ifdef CodeSite2}
  CodeSite.SendInteger(lsMsg, liValue);
{$endif}  // CodeSite2
{$ifdef NewCS}
  CodeSite.Send(lsMsg, liValue);
{$endif}  // NewCS
  {$ENDIF}
end;{ TraCSSendIntegerFunction .ExecuteFunction() }

{------------------------------------------------------------------------------}
{ TraCSSendIntegerFunction.GetSignature }
class function TraCSSendIntegerFunction.GetSignature: String;
begin
  result := csSendIntegerSignature;
end;{ TraCSSendIntegerFunction .GetSignature() }

{------------------------------------------------------------------------------}
{ TraCSSendMsgExFunction.ExecuteFunction }
procedure TraCSSendMsgExFunction.ExecuteFunction(aParams: TraParamList);
{$IFDEF CODESITE}
var
  lsMsg: String;
  lMessageType: TraCodeSiteMessageType;
  liMsgType: Integer;
{$ENDIF}
begin
  {$IFDEF CODESITE}
  GetParamValue(0, lMessageType);
  GetParamValue(1, lsMsg);

  liMsgType := GetCSMessageType(lMessageType);

{$ifdef CodeSite2}
  CodeSite.SendMsgEx(liMsgType, lsMsg);
{$endif}  // NewCS
{$ifdef NewCS}
  CodeSite.Send(liMsgType, lsMsg);
{$endif}  // NewCS
  {$ENDIF}
end;{ TraCSSendMsgExFunction .ExecuteFunction() }

{------------------------------------------------------------------------------}
{ TraCSSendMsgExFunction.GetSignature }
class function TraCSSendMsgExFunction.GetSignature: String;
begin
  result := csSendMsgExSignature;
end;{ TraCSSendMsgExFunction .GetSignature() }

{------------------------------------------------------------------------------}
{ TraCSSendMsgFunction.ExecuteFunction }
procedure TraCSSendMsgFunction.ExecuteFunction(aParams: TraParamList);
{$IFDEF CODESITE}
var
  lsMessage: String;
{$ENDIF}
begin
  {$IFDEF CODESITE}
  GetParamValue(0, lsMessage);

  CodeSite.SendMsg(lsMessage);
  {$ENDIF}
end;{ TraCSSendMsgFunction .ExecuteFunction() }

{------------------------------------------------------------------------------}
{ TraCSSendMsgFunction.GetSignature }
class function TraCSSendMsgFunction.GetSignature: String;
begin
  result := csSendMsgSignature;
end;{ TraCSSendMsgFunction .GetSignature() }

{------------------------------------------------------------------------------}
{ TraCSSendNoteFunction.ExecuteFunction }
procedure TraCSSendNoteFunction.ExecuteFunction(aParams: TraParamList);
{$IFDEF CODESITE}
var
  lsMsg: String;
{$ENDIF}
begin
  {$IFDEF CODESITE}
  GetParamValue(0, lsMsg);

  CodeSite.SendNote(lsMsg);
  {$ENDIF}
end;{ TraCSSendNoteFunction .ExecuteFunction() }

{------------------------------------------------------------------------------}
{ TraCSSendNoteFunction.GetSignature }
class function TraCSSendNoteFunction.GetSignature: String;
begin
  result := csSendNoteSignature;
end;{ TraCSSendNoteFunction .GetSignature() }

{------------------------------------------------------------------------------}
{ TraCSSendObjectFunction.ExecuteFunction }
procedure TraCSSendObjectFunction.ExecuteFunction(aParams: TraParamList);
{$IFDEF CODESITE}
var
  lsMsg: String;
  lObject: TObject;
{$ENDIF}
begin
  {$IFDEF CODESITE}
  GetParamValue(0, lsMsg);
  GetParamValue(1, lObject);

{$ifdef CodeSite2}
  CodeSite.SendObject(lsMsg, lObject);
{$endif}  // CodeSite2
{$ifdef NewCS}
  CodeSite.Send(lsMsg, lObject);
{$endif}  // NewCS
  {$ENDIF}
end;{ TraCSSendObjectFunction .ExecuteFunction() }

{------------------------------------------------------------------------------}
{ TraCSSendObjectFunction.GetSignature }
class function TraCSSendObjectFunction.GetSignature: String;
begin
  result := csSendObjectSignature;
end;{ TraCSSendObjectFunction .GetSignature() }

{------------------------------------------------------------------------------}
{ TraCSSendPointExFunction.ExecuteFunction }
procedure TraCSSendPointExFunction.ExecuteFunction(aParams: TraParamList);
{$IFDEF CODESITE}
var
  lMessageType: TraCodeSiteMessageType;
  lsMsg: String;
  liX: Integer;
  liY: Integer;
  liMsgType: Integer;
{$ENDIF}
begin
  {$IFDEF CODESITE}
  GetParamValue(0, lMessageType);
  GetParamValue(1, lsMsg);
  GetParamValue(2, liX);
  GetParamValue(3, liY);

  liMsgType := GetCSMessageType(lMessageType);

{$ifdef CodeSite2}
  CodeSite.SendPointEx(liMsgType, lsMsg, Point(liX, liY));
{$endif}  // CodeSite2
{$ifdef NewCS}
  CodeSite.Send(liMsgType, lsMsg, Point(liX, liY));
{$endif}  // NewCS
  {$ENDIF}
end;{ TraCSSendPointExFunction .ExecuteFunction() }

{------------------------------------------------------------------------------}
{ TraCSSendPointExFunction.GetSignature }
class function TraCSSendPointExFunction.GetSignature: String;
begin
  Result := csSendPointExSignature;
end;{ TraCSSendPointExFunction .GetSignature() }

{------------------------------------------------------------------------------}
{ TraCSSendPointFunction.ExecuteFunction }
procedure TraCSSendPointFunction.ExecuteFunction(aParams: TraParamList);
{$IFDEF CODESITE}
var
  lsMsg: String;
  liX: Integer;
  liY: Integer;
{$ENDIF}
begin
  {$IFDEF CODESITE}
  GetParamValue(0, lsMsg);
  GetParamValue(1, liX);
  GetParamValue(2, liY);

{$ifdef CodeSite2}
  CodeSite.SendPoint(lsMsg, Point(liX, liY));
{$endif}  // NewCS
{$ifdef NewCS}
  CodeSite.Send(lsMsg, Point(liX, liY));
{$endif}  // NewCS
  {$ENDIF}
end;{ TraCSSendPointFunction .ExecuteFunction() }

{------------------------------------------------------------------------------}
{ TraCSSendPointFunction.GetSignature }
class function TraCSSendPointFunction.GetSignature: String;
begin
  Result := csSendPointSignature;
end;{ TraCSSendPointFunction .GetSignature() }

{------------------------------------------------------------------------------}
{ TraCSSendPropertyFunction.ExecuteFunction }
procedure TraCSSendPropertyFunction.ExecuteFunction(aParams: TraParamList);
{$IFDEF CODESITE}
var
  lsMsg: String;
  lObject: TObject;
  lsPropName: String;
{$ENDIF}
begin
  {$IFDEF CODESITE}
  GetParamValue(0, lsMsg);
  GetParamValue(1, lObject);
  GetParamValue(2, lsPropName);

  CodeSite.SendProperty(lsMsg, lObject, lsPropName);
  {$ENDIF}
end;{ TraCSSendPropertyFunction .ExecuteFunction() }

{------------------------------------------------------------------------------}
{ TraCSSendPropertyFunction.GetSignature }
class function TraCSSendPropertyFunction.GetSignature: String;
begin
  result := csSendPropertySignature;
end;{ TraCSSendPropertyFunction .GetSignature() }

{------------------------------------------------------------------------------}
{ TraCSSendRectExFunction.ExecuteFunction }
procedure TraCSSendRectExFunction.ExecuteFunction(aParams: TraParamList);
{$IFDEF CODESITE}
var
  liMsgType: Integer;
  lsMsg: String;
  liLeft: Integer;
  liTop: Integer;
  liRight: Integer;
  liBottom: Integer;
  lMessageType: TraCodeSiteMessageType;
{$ENDIF}
begin
  {$IFDEF CODESITE}
  GetParamValue(0, lMessageType);
  GetParamValue(1, lsMsg);
  GetParamValue(2, liLeft);
  GetParamValue(3, liTop);
  GetParamValue(4, liRight);
  GetParamValue(5, liBottom);

  liMsgType := GetCSMessageType(lMessageType);

{$ifdef CodeSite2}
  CodeSite.SendRectEx(liMsgType, lsMsg, Rect(liLeft, liTop, liRight, liBottom));
{$endif}  // CodeSite2
{$ifdef NewCS}
  CodeSite.Send(liMsgType, lsMsg, Rect(liLeft, liTop, liRight, liBottom));
{$endif}  // NewCS
  {$ENDIF}
end;{ TraCSSendRectExFunction .ExecuteFunction() }

{------------------------------------------------------------------------------}
{ TraCSSendRectExFunction.GetSignature }
class function TraCSSendRectExFunction.GetSignature: String;
begin
  result := csSendRectExSignature;
end;{ TraCSSendRectExFunction .GetSignature() }

{------------------------------------------------------------------------------}
{ TraCSSendRectFunction.ExecuteFunction }
procedure TraCSSendRectFunction.ExecuteFunction(aParams: TraParamList);
{$IFDEF CODESITE}
var
  lsMsg: String;
  liLeft: Integer;
  liTop: Integer;
  liRight: Integer;
  liBottom: Integer;
{$ENDIF}
begin
  {$IFDEF CODESITE}
  GetParamValue(0, lsMsg);
  GetParamValue(1, liLeft);
  GetParamValue(2, liTop);
  GetParamValue(3, liRight);
  GetParamValue(4, liBottom);

{$ifdef CodeSite2}
  CodeSite.SendRect(lsMsg, Rect(liLeft, liTop, liRight, liBottom));
{$endif}  // CodeSite2
{$ifdef NewCS}
  CodeSite.Send(lsMsg, Rect(liLeft, liTop, liRight, liBottom));
{$endif}  // NewCS
  {$ENDIF}
end;{ TraCSSendRectFunction .ExecuteFunction() }

{------------------------------------------------------------------------------}
{ TraCSSendRectFunction.GetSignature }
class function TraCSSendRectFunction.GetSignature: String;
begin
  result := csSendRectSignature;
end;{ TraCSSendRectFunction .GetSignature() }

{------------------------------------------------------------------------------}
{ TraCSSendStreamFunction.ExecuteFunction }
procedure TraCSSendStreamFunction.ExecuteFunction(aParams: TraParamList);
{$IFDEF CODESITE}
var
  lsMsg: String;
  lObj: TComponent;
{$ENDIF}
begin
  {$IFDEF CODESITE}
  GetParamValue(0, lsMsg);
  GetParamValue(1, lObj);

{$ifdef CodeSite2}
  CodeSite.SendStream(lsMsg, lObj);
{$endif}  // CodeSite2
{$ifdef NewCS}
  CodeSite.Send(lsMsg, lObj);
{$endif}  // NewCS
  {$ENDIF}
end;{ TraCSSendStreamFunction .ExecuteFunction() }

{------------------------------------------------------------------------------}
{ TraCSSendStreamFunction.GetSignature }
class function TraCSSendStreamFunction.GetSignature: String;
begin
  result := csSendStreamSignature;
end;{ TraCSSendStreamFunction .GetSignature() }

{------------------------------------------------------------------------------}
{ TraCSSendStringExFunction.ExecuteFunction }
procedure TraCSSendStringExFunction.ExecuteFunction(aParams: TraParamList);
{$IFDEF CODESITE}
var
  liMsgType: Integer;
  lsMsg: String;
  lsValue: String;
  lMessageType: TraCodeSiteMessageType;
{$ENDIF}
begin
  {$IFDEF CODESITE}
  GetParamValue(0, lMessageType);
  GetParamValue(1, lsMsg);
  GetParamValue(2, lsValue);

  liMsgType := GetCSMessageType(lMessageType);

{$ifdef CodeSite2}
  CodeSite.SendStringEx(liMsgType, lsMsg, lsValue);
{$endif}  // CodeSite2
{$ifdef NewCS}
  CodeSite.Send(liMsgType, lsMsg, lsValue);
{$endif}  // NewCS
  {$ENDIF}
end;{ TraCSSendStringExFunction .ExecuteFunction() }

{------------------------------------------------------------------------------}
{ TraCSSendStringExFunction.GetSignature }
class function TraCSSendStringExFunction.GetSignature: String;
begin
  result := csSendStringExSignature;
end;{ TraCSSendStringExFunction .GetSignature() }

{------------------------------------------------------------------------------}
{ TraCSSendStringFunction.ExecuteFunction }
procedure TraCSSendStringFunction.ExecuteFunction(aParams: TraParamList);
{$IFDEF CODESITE}
var
  lsMsg: String;
  lsValue: String;
{$ENDIF}
begin
  {$IFDEF CODESITE}
  GetParamValue(0, lsMsg);
  GetParamValue(1, lsValue);

{$ifdef CodeSite2}
  CodeSite.SendString(lsMsg, lsValue);
{$endif}  // CodeSite2
{$ifdef NewCS}
  CodeSite.Send(lsMsg, lsValue);
{$endif}  // NewCS
  {$ENDIF}
end;{ TraCSSendStringFunction .ExecuteFunction() }

{------------------------------------------------------------------------------}
{ TraCSSendStringFunction.GetSignature }
class function TraCSSendStringFunction.GetSignature: String;
begin
  result := csSendStringSignature;
end;{ TraCSSendStringFunction .GetSignature() }

{------------------------------------------------------------------------------}
{ TraCSSendStringListFunction.ExecuteFunction }
procedure TraCSSendStringListFunction.ExecuteFunction(aParams: TraParamList);
{$IFDEF CODESITE}
var
  lsMsg: String;
  lsList: TStringList;
{$ENDIF}
begin
  {$IFDEF CODESITE}
  GetParamValue(0, lsMsg);
  GetParamValue(1, lsList);

{$ifdef CodeSite2}
  CodeSite.SendStringList(lsMsg, lsList);
{$endif}  // NewCS
{$ifdef NewCS}
  CodeSite.Send(lsMsg, lsList);
{$endif}  // NewCS
  {$ENDIF}
end;{ TraCSSendStringListFunction .ExecuteFunction() }

{------------------------------------------------------------------------------}
{ TraCSSendStringListFunction.GetSignature }
class function TraCSSendStringListFunction.GetSignature: String;
begin
  result := csSendStringListSignature;
end;{ TraCSSendStringListFunction .GetSignature() }

{------------------------------------------------------------------------------}
{ TraCSSendWarningFunction.ExecuteFunction }
procedure TraCSSendWarningFunction.ExecuteFunction(aParams: TraParamList);
{$IFDEF CODESITE}
var
  lsMsg: String;
{$ENDIF}
begin
  {$IFDEF CODESITE}
  GetParamValue(0, lsMsg);

  CodeSite.SendWarning(lsMsg);
  {$ENDIF}
end;{ TraCSSendWarningFunction .ExecuteFunction() }

{------------------------------------------------------------------------------}
{ TraCSSendWarningFunction.GetSignature }
class function TraCSSendWarningFunction.GetSignature: String;
begin
  result := csSendWarningSignature;
end;{ TraCSSendWarningFunction .GetSignature() }


{ TraCSSendCurrencyFunction }

{------------------------------------------------------------------------------}
{ TraCSSendWarningFunction.ExecuteFunction }
procedure TraCSSendCurrencyFunction.ExecuteFunction(aParams: TraParamList);
{$IFDEF CODESITE}
var
  lsMsg: String;
  lCurrency: Currency;
{$ENDIF}
begin
  {$IFDEF CODESITE}
  GetParamValue(0, lsMsg);
  GetParamValue(1, lCurrency);

  CodeSite.SendCurrency(lsMsg, lCurrency);
  {$ENDIF}
end; {TraCSSendCurrencyFunction.ExecuteFunction}

{------------------------------------------------------------------------------}
{ TraCSSendWarningFunction.GetSignature }
class function TraCSSendCurrencyFunction.GetSignature: String;
begin
  result := csSendCurrency;
end; {TraCSSendCurrencyFunction.GetSignature}

{ TraCSSendCurrencyExFunction }

{------------------------------------------------------------------------------}
{ TraCSSendCurrencyExFunction.ExecuteFunction }
procedure TraCSSendCurrencyExFunction.ExecuteFunction(aParams: TraParamList);
{$IFDEF CODESITE}
var
  liMsgType: Integer;
  lsMsg: String;
  lCurrency: Currency;
  lMessageType: TraCodeSiteMessageType;
{$ENDIF}
begin
  {$IFDEF CODESITE}
  GetParamValue(0, lMessageType);
  GetParamValue(1, lsMsg);
  GetParamValue(2, lCurrency);

  liMsgType := GetCSMessageType(lMessageType);

{$ifdef CodeSite2}
  CodeSite.SendCurrencyEx(liMsgType, lsMsg, lCurrency);
{$endif}  // CodeSite2
{$ifdef NewCS}
  CodeSite.SendCurrency(liMsgType, lsMsg, lCurrency);
{$endif}  // NewCS
  {$ENDIF}
end; {TraCSSendCurrencyExFunction.ExecuteFunction}

{------------------------------------------------------------------------------}
{ TraCSSendCurrencyExFunction.GetSignature }
class function TraCSSendCurrencyExFunction.GetSignature: String;
begin
  result := csSendCurrencyEx;
end; {TraCSSendCurrencyExFunction.GetSignature}

{ TraCSSendFloatFunction }

{------------------------------------------------------------------------------}
{ TraCSSendFloatFunction.ExecuteFunction }
procedure TraCSSendFloatFunction.ExecuteFunction(aParams: TraParamList);
{$IFDEF CODESITE}
var
  lsMsg: String;
  lFloat: Extended;
{$ENDIF}
begin
  {$IFDEF CODESITE}
  GetParamValue(0, lsMsg);
  GetParamValue(1, lFloat);

{$ifdef CodeSite2}
  CodeSite.SendFloat(lsMsg, lFloat);
{$endif}  // CodeSite2
{$ifdef NewCS}
  CodeSite.Send(lsMsg, lFloat);
{$endif}  // NewCS
{$ENDIF}
end;

{------------------------------------------------------------------------------}
{ TraCSSendFloatFunction.GetSignature }
class function TraCSSendFloatFunction.GetSignature: String;
begin
  result := csSendFloat;
end;

{ TraCSSendFloatExFunction }

{------------------------------------------------------------------------------}
{ TraCSSendFloatExFunction.ExecuteFunction }
procedure TraCSSendFloatExFunction.ExecuteFunction(aParams: TraParamList);
{$IFDEF CODESITE}
var
  liMsgType: Integer;
  lsMsg: String;
  lFloat: Extended;
  lMessageType: TraCodeSiteMessageType;
{$ENDIF}
begin
  {$IFDEF CODESITE}
  GetParamValue(0, lMessageType);
  GetParamValue(1, lsMsg);
  GetParamValue(2, lFloat);

  liMsgType := GetCSMessageType(lMessageType);

{$ifdef CodeSite2}
  CodeSite.SendFloatEx(liMsgType, lsMsg, lFloat);
{$endif}  // CodeSite2
{$ifdef NewCS}
  CodeSite.Send(liMsgType, lsMsg, lFloat);
{$endif}  // NewCS
  {$ENDIF}
end;

{------------------------------------------------------------------------------}
{ TraCSSendFloatExFunction.GetSignature }
class function TraCSSendFloatExFunction.GetSignature: String;
begin
  result := csSendFloatEx;
end;


initialization

  raRegisterFunction('csAddCheckPoint', TraCSAddCheckPointFunction);
  raRegisterFunction('csAddSeparator', TraCSAddSeparatorFunction);
  raRegisterFunction('csClear', TraCSClearFunction);
  raRegisterFunction('csEnable', TraCSEnableFunction);
  raRegisterFunction('csEnterMethod', TraCSEnterMethodFunction);
  raRegisterFunction('csExitMethod', TraCSExitMethodFunction);
  raRegisterFunction('csScratchPad', TraCSScratchPadFunction);
  raRegisterFunction('csSendAssignedEx', TraCSSendASsignedExFunction);
  raRegisterFunction('csSendAssigned', TraCSSendAssignedFunction);
  raRegisterFunction('csSendBooleanEx', TraCSSendBooleanExFunction);
  raRegisterFunction('csSendBoolean', TraCSSendBooleanFunction);
  raRegisterFunction('csSendColorEx', TraCSSendColorExFunction);
  raRegisterFunction('csSendColor', TraCSSendColorFunction);
  raRegisterFunction('csSendCurrencyEx', TraCSSendCurrencyExFunction);
  raRegisterFunction('csSendCurrency', TraCSSendCurrencyFunction);
  raRegisterFunction('csSendError', TraCSSendErrorFunction);
  raRegisterFunction('csSendFloatEx', TraCSSendFloatExFunction);
  raRegisterFunction('csSendFloat', TraCSSendFloatFunction);
  raRegisterFunction('csSendIntegerEx', TraCSSendIntegerExFunction);
  raRegisterFunction('csSendInteger', TraCSSendIntegerFunction);
  raRegisterFunction('csSendMsgEx', TraCSSendMsgExFunction);
  raRegisterFunction('csSendMsg', TraCSSendMsgFunction);
  raRegisterFunction('csSendNote', TraCSSendNoteFunction);
  raRegisterFunction('csSendObject', TraCSSendObjectFunction);
  raRegisterFunction('csSendPointEx', TraCSSendPointExFunction);
  raRegisterFunction('csSendPoint', TraCSSendPointFunction);
  raRegisterFunction('csSendProperty', TraCSSendPropertyFunction);
  raRegisterFunction('csSendRectEx', TraCSSendRectExFunction);
  raRegisterFunction('csSendRect', TraCSSendRectFunction);
  raRegisterFunction('csSendStream', TraCSSendStreamFunction);
  raRegisterFunction('csSendStringEx', TraCSSendStringExFunction);
  raRegisterFunction('csSendString', TraCSSendStringFunction);
  raRegisterFunction('csSendStringList', TraCSSendStringListFunction);
  raRegisterFunction('csSendWarning', TraCSSendWarningFunction);

  raRegisterEnum('TraCodeSiteMessageType', TypeInfo(TraCodeSiteMessageType));

finalization

  raUnRegisterFunction('csAddCheckPoint');
  raUnRegisterFunction('csAddSeparator');
  raUnRegisterFunction('csClear');
  raUnRegisterFunction('csEnable');
  raUnRegisterFunction('csEnterMethod');
  raUnRegisterFunction('csExitMethod');
  raUnRegisterFunction('csScratchPad');
  raUnRegisterFunction('csSendAssignedEx');
  raUnRegisterFunction('csSendAssigned');
  raUnRegisterFunction('csSendBooleanEx');
  raUnRegisterFunction('csSendBoolean');
  raUnRegisterFunction('csSendColorEx');
  raUnRegisterFunction('csSendColor');
  raUnRegisterFunction('csSendCurrencyEx');
  raUnRegisterFunction('csSendCurrency');
  raUnRegisterFunction('csSendError');
  raUnRegisterFunction('csSendFloatEx');
  raUnRegisterFunction('csSendFloat');
  raUnRegisterFunction('csSendIntegerEx');
  raUnRegisterFunction('csSendInteger');
  raUnRegisterFunction('csSendMsgEx');
  raUnRegisterFunction('csSendMsg');
  raUnRegisterFunction('csSendNote');
  raUnRegisterFunction('csSendObject');
  raUnRegisterFunction('csSendPointEx');
  raUnRegisterFunction('csSendPoint');
  raUnRegisterFunction('csSendProperty');
  raUnRegisterFunction('csSendRectEx');
  raUnRegisterFunction('csSendRect');
  raUnRegisterFunction('csSendStream');
  raUnRegisterFunction('csSendStringEx');
  raUnRegisterFunction('csSendString');
  raUnRegisterFunction('csSendStringList');
  raUnRegisterFunction('csSendWarning');

end.
