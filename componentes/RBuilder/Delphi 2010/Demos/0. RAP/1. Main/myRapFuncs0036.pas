{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit myRapFuncs0036;

interface

uses
  Sysutils, classes, raFunc, ppRTTI;

type
  TDoubleKeeper = class(TObject)
    dblSum: Double;
    dblCount: Double;
    dblAve: Double;
    function SumAsString: String;
    function CountAsString: String;
    function AveAsString: String;
  end;

  TmyStorageFunction = class (TraSystemFunction)
  public
    class function Category: String; override;
  end;

  TmySetStorageListFunction = class(TmyStorageFunction)
  public
    procedure ExecuteFunction(aParams: TraParamList); override;
    class function GetSignature: String; override;
    class function IsFunction: Boolean; override;
  end;

  TmyStoreDoublesFunction = class (TmyStorageFunction)
  public
    procedure ExecuteFunction(aParams: TraParamList); override;
    class function GetSignature: String; override;
    class function IsFunction: Boolean; override;
  end;

  TmyGetDoublesFunction = class (TmyStorageFunction)
  public
    procedure ExecuteFunction(aParams: TraParamList); override;
    class function GetSignature: String; override;
    class function IsFunction: Boolean; override;
  end;

  TmyClearListFunction = class (TmyStorageFunction)
  public
    procedure ExecuteFunction(aParams: TraParamList); override;
    class function GetSignature: String; override;
    class function IsFunction: Boolean; override;
    class function HasParams: Boolean; override;
  end;

var
  gStringList: TStringList;

implementation

{******************************************************************************
 *
 ** D O U B L E   K E E P E R
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TDoubleKeeper.AveAsString }

function TDoubleKeeper.AveAsString: String;
begin
  Result := FloatToStrF(dblAve, ffFixed, 15, 2);
end;

{------------------------------------------------------------------------------}
{ TDoubleKeeper.CountAsString }

function TDoubleKeeper.CountAsString: String;
begin
  Result := FloatToStrF(dblCount, ffGeneral, 15, 2);
end;

{------------------------------------------------------------------------------}
{ TDoubleKeeper.SumAsString }

function TDoubleKeeper.SumAsString: String;
begin
  Result := FloatToStrF(dblSum, ffFixed, 15, 2);
end;

{******************************************************************************
 *
 ** S T O R A G E  F U N C T I O N
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TmyStorageFunction.Category }

class function TmyStorageFunction.Category: String;
begin
  Result := 'Storage';
end;

{------------------------------------------------------------------------------}
{ TmyStorageFunction.GetSignature }

class function TmySetStorageListFunction.GetSignature: String;
begin
  Result := 'procedure SetStorageList(aStringList: TStringList);';
end;

{------------------------------------------------------------------------------}
{ TmyStorageFunction.IsFunction }

class function TmySetStorageListFunction.IsFunction: Boolean;
begin
  Result := False;
end;

{------------------------------------------------------------------------------}
{ TmyStorageFunction.ExecuteFunction }

procedure TmySetStorageListFunction.ExecuteFunction(aParams: TraParamList);
var
  lStringList: TStringList;
begin

  GetParamValue(0, lStringList);

  if Assigned(lStringList) then
    gStringList := lStringList;

end;


{******************************************************************************
 *
 ** S T O R E  D O U B L E S  F U N C T I O N
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TmyStoreDoublesFunction.GetSignature }

class function TmyStoreDoublesFunction.GetSignature: String;
begin
  Result := 'procedure StoreDouble(aString: String; aSum, aCount, aAve: Double);';
end;

{------------------------------------------------------------------------------}
{ TmyStoreDoublesFunction.IsFunction }

class function TmyStoreDoublesFunction.IsFunction: Boolean;
begin
  Result := False;
end;

{------------------------------------------------------------------------------}
{ TmyStoreDoublesFunction.ExecuteFunction }

procedure TmyStoreDoublesFunction.ExecuteFunction(aParams: TraParamList);
var
  lDoubleSum: Double;
  lDoubleCount: Double;
  lDoubleAve: Double;
  lString: String;
  lDoubleKeeper: TDoubleKeeper;
begin

  if gStringList <> nil then
    begin
      lDoubleKeeper := TDoubleKeeper.Create;

      GetParamValue(0, lString);
      GetParamValue(1, lDoubleSum);
      GetParamValue(2, lDoubleCount);
      GetParamValue(3, lDoubleAve);

      lDoubleKeeper.dblSum := lDoubleSum;
      lDoubleKeeper.dblCount := lDoubleCount;
      lDoubleKeeper.dblAve := lDoubleAve;

      gStringList.AddObject(lString, lDoubleKeeper);
    end;

end;

{******************************************************************************
 *
 ** G E T  D O U B L E S  F U N C T I O N
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TmyGetDoublesFunction.GetSignature }

class function TmyGetDoublesFunction.GetSignature: String;
begin
  Result := 'procedure GetDoubles(aIndex: Integer; var aString, aSum, aCount, aAve: String);';
end;

{------------------------------------------------------------------------------}
{ TmyGetDoublesFunction.IsFunction }

class function TmyGetDoublesFunction.IsFunction: Boolean;
begin
  Result := False;
end;

{------------------------------------------------------------------------------}
{ TmyGetDoublesFunction.ExecuteFunction }

procedure TmyGetDoublesFunction.ExecuteFunction(aParams: TraParamList);
var
  liIndex: Integer;
  lsSum: String;
  lsCount: String;
  lsAve: String;
  lString: String;
  lDoubleKeeper: TDoubleKeeper;
begin

  if gStringList <> nil then
    begin
      GetParamValue(0, liIndex);

      lDoubleKeeper := TDoubleKeeper(gStringList.Objects[liIndex]);

      lString := gStringList[liIndex];
      lsSum := lDoubleKeeper.SumAsString;
      lsCount := lDoubleKeeper.CountAsString;
      lsAve := lDoubleKeeper.AveAsString;

      SetParamValue(1, lString);
      SetParamValue(2, lsSum);
      SetParamValue(3, lsCount);
      SetParamValue(4, lsAve);
    end;

end;


{******************************************************************************
 *
 ** C L E A R L I S T  F U N C T I O N
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TmyClearListFunction.GetSignature }

class function TmyClearListFunction.GetSignature: String;
begin
  Result := 'procedure ClearList;';
end;

{------------------------------------------------------------------------------}
{ TmyClearListFunction.HasParams }

class function TmyClearListFunction.HasParams: Boolean;
begin
  Result := False;
end;

{------------------------------------------------------------------------------}
{ TmyClearListFunction.IsFunction }

class function TmyClearListFunction.IsFunction: Boolean;
begin
  Result := False;
end;

{------------------------------------------------------------------------------}
{ TmyClearListFunction.ExecuteFunction }

procedure TmyClearListFunction.ExecuteFunction(aParams: TraParamList);
var
  lDoubleKeeper: TDoubleKeeper;
  liCounter: Integer;
begin

  if gStringList <> nil then
    for liCounter := 0 to gStringList.Count - 1 do
      begin
        lDoubleKeeper := TDoubleKeeper(gStringList.Objects[0]);
        lDoubleKeeper.Free;
        gStringList.Delete(0);
      end;

end;


initialization
  raRegisterFunction('StoreDouble', TmyStoreDoublesFunction);
  raRegisterFunction('SetStorageList', TmySetStorageListFunction);
  raRegisterFunction('GetDoubles', TmyGetDoublesFunction);
  raRegisterFunction('ClearList', TmyClearListFunction);

finalization
  raUnRegisterFunction('StoreDouble');
  raUnRegisterFunction('SetStorageList');
  raUnRegisterFunction('GetDoubles');
  raUnRegisterFunction('ClearList');



end.
