unit EditNumber;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, StdCtrls;

type
  TEditNumber = class(TEdit)
  private
    { Private declarations }
    FonEnter   : TNotifyEvent;
    FonExit    : TNotifyEvent;
    ValInteger : Integer;
    ValFloat   : Double;
    ValDecimal : Boolean;
    Mascara    : String;
    Alinham    : TAlignment;
  protected
    { Protected declarations }
    procedure CreateParams(var Params: TCreateParams); Override;
    procedure KeyPress(var Key : Char); Override;
    procedure DoEnter; Override;
    procedure DoExit; Override;
  public
    { Public declarations }
    constructor Create(AOwner : TComponent); Override;
    procedure StoreValue(Value : Double);
    procedure SetAlinhamento(Value: TAlignment);
  published
    { Published declarations }
    property OnEnter    : TNotifyEvent read FonEnter Write FonEnter;
    property OnExit     : TNotifyEvent read FonExit Write FonExit;
    property ValueInt   : Integer read ValInteger Write ValInteger default 0;
    property ValueFloat : Double read ValFloat Write ValFloat;
    property ValueDec   : Boolean read ValDecimal Write ValDecimal default False;
    property Mask       : String read Mascara Write Mascara;
    property Alinhamento: TAlignment read Alinham write Alinham default taRightJustify;
  end;

procedure Register;

implementation

{ TEditNumber }

constructor TEditNumber.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ValInteger:=0;
  ValFloat:=0.0;
  ValDecimal:=False;
  Mascara:='';
  Text:='';
  Alinham:=taRightJustify;
end;

procedure TEditNumber.CreateParams(var Params: TCreateParams);
const
 Alinha: Array[TAlignment] of Byte = (ES_LEFT, ES_RIGHT, ES_CENTER);
begin
  inherited CreateParams(Params);
  CreateSubClass(Params, 'EDIT');
  params.Style:=params.Style and not (ES_AUTOVSCROLL or ES_AUTOHSCROLL) or
                ES_MULTILINE or Alinha[Alinham];
end;

procedure TEditNumber.DoEnter;
begin
 if Assigned(FonEnter) then FonEnter(Self);
 if ValueDec
  then Text:=FloatToStr(ValFloat)
  else Text:=IntToStr(ValInteger);
 SelectAll;
end;

procedure TEditNumber.DoExit;
begin
 if Text<>''
  then begin
   if ValueDec
    then begin
     ValueFloat:=StrToFloat(Text);
     Text:=FormatFloat(Mask, ValueFloat);
    end
    else begin
     ValueInt:=StrToInt(Text);
     Text:=FormatFloat(Mask, ValueInt);
    end;
  end
  else begin
   if ValueDec
    then begin
     ValueFloat:=0.0;
     Text:=FormatFloat(Mask, ValueFloat);
    end
    else begin
     ValueInt:=0;
     Text:=FormatFloat(Mask, ValueInt);
    end;
  end;
 if Assigned(FonExit) then FonExit(Self);
end;

procedure TEditNumber.KeyPress(var Key: Char);
begin
 if Key=#27 then Text:='';
 if ValueDec
  then begin
        if not (Key in ['0'..'9',',',#8]) or ((Key=',') and (pos(',',Text)>0))
         then begin
          Key:=#0;
          Beep;
         end;
       end
  else begin
       if not (Key in ['0'..'9',#8])
        then begin
         Key:=#0;
         Beep;
        end;
       end;
 if Key<>#0 then inherited KeyPress(Key);
end;

procedure TEditNumber.SetAlinhamento(Value: TAlignment);
begin
 if Alinham<>Value
  then begin
   Alinham:=Value;
   RecreateWnd;
  end;
end;

procedure TEditNumber.StoreValue(Value: Double);
begin
 if ValueDec
  then begin
   ValueFloat:=Value;
   Text:=FormatFloat(Mask, ValueFloat);
  end
  else begin
   ValueInt:=Trunc(Value);
   Text:=FormatFloat(Mask, ValueInt);
  end;
end;

procedure Register;
begin
  RegisterComponents('Samples', [TEditNumber]);
end;

end.
