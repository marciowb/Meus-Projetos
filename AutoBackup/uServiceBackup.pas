unit uServiceBackup;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, SvcMgr, Dialogs, Registry,
  IB_Services, ExtCtrls;

type
  TDadosBackup = packed Record
    Dia: Array [0..6] of Boolean;
    Horas: array of TTime;
    PastaTemp : String;
    BancoBackup : String;
  End;
  TsrvBackup = class(TService)
    Timer: TTimer;
    procedure ServiceAfterInstall(Sender: TService);
    procedure TimerTimer(Sender: TObject);
    procedure ServiceStart(Sender: TService; var Started: Boolean);
  private
    { Private declarations }

  public
    function GetServiceController: TServiceController; override;
    { Public declarations }
  end;

var
  srvBackup: TsrvBackup;
  DadosBackup: TDadosBackup;
implementation

uses uLibBackup;

{$R *.DFM}

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  srvBackup.Controller(CtrlCode);
end;

function TsrvBackup.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure TsrvBackup.ServiceAfterInstall(Sender: TService);
var
  Reg : TRegistry;
begin
  Try
    Reg := TRegistry.Create;
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    if Reg.OpenKey('\SYSTEM\CurrentControlSet\Services\'+Name, False) Then
    Begin
      Reg.WriteString('Description', Self.DisplayName);
      Reg.CloseKey;
    End;
  Finally
    FreeAndNil(Reg);
  End;
end;

procedure TsrvBackup.ServiceStart(Sender: TService; var Started: Boolean);
var
  Reg : TRegistry;
  Lista : TStringList;
  I: Integer;
begin
  Try
    Reg := TRegistry.Create;
    Lista := TStringList.Create;
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    Lista.Delimiter := '|';
    if Reg.OpenKey('/SOFTWARE/HRM/AutoBackup/', True) Then
    Begin
      Lista.DelimitedText := Reg.ReadString('Dias');
      if Lista.Count = 0 then
        Lista.Text := '||||||';
      for I := 0 to Lista.Count - 1 do
        DadosBackup.Dia[i] := Lista[i] = 'Y';
      Lista.DelimitedText := Reg.ReadString('Horas');
      SetLength(DadosBackup.Horas, Lista.Count);
      for I := 0 to Lista.Count - 1 do
         DadosBackup.Horas[i] := StrToTime(Lista[i]);
      DadosBackup.PastaTemp := Reg.ReadString('PastaTemp');
      DadosBackup.BancoBackup := Reg.ReadString('BancoBackup');
    End;
  Finally
    FreeAndNil(Reg);
    FreeAndNil(Lista);
  End;
end;

procedure TsrvBackup.TimerTimer(Sender: TObject);
var
  i, DiaAtual : Integer;
  HoraAtual : TTime;
begin
  if (DadosBackup.BancoBackup = '') or
     (Length(DadosBackup.Horas) <= 0 ) or
     (Length(DadosBackup.Dia) <= 0 ) then
    Exit;
  HoraAtual := StrToTime(FormatDateTime('HH:NN', now));
  DiaAtual := DayOfWeek(Now);
  for I := low(DadosBackup.Horas) to High(DadosBackup.Horas) do
  Begin
    if HoraAtual = DadosBackup.Horas[i] then
    Begin
       if DadosBackup.Dia[DiaAtual] then
          GeraBackup(DadosBackup.BancoBackup, DadosBackup.PastaTemp);
    End;
  End;
end;

end.
