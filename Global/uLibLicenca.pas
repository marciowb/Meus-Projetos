unit uLibLicenca;

interface
   uses
      classes, SysUtils, Windows,Forms, JvComponentBase,
       JvComputerInfoEx{, uCfg};

   Function GetSerialHD: AnsiString;
   Function GetDataBIOS: AnsiString;
   Function Kripta(Txt :AnsiString) : AnsiString;
   Function Deckripta(Txt :AnsiString) : AnsiString;
   Function GerarCodigoComputador: AnsiString;
   Function GerarChave(Key, Serial, Data, NumeroUsuarios :AnsiString;UltimaData: AnsiString = '00000000'): AnsiString;
   Function ChaveValida(Key ,Serial: AnsiString): Boolean;
   Function Licenciar(Key : AnsiString) : Boolean;
   Function GetComputadorLiberado(Serial: AnsiString): Boolean;
implementation

uses Comandos, MinhasClasses;
   Var
     Info : TJvComputerInfoEx;
   Const
     Krip_Nivel_1 = 'ABCDEFGHIJLMNOPQRST1234567890UVXYWZabcdefghijlmnopqrstuvxywzçÇáà';
     Krip_Nivel_2 = '0987654321ZWYXVUTSRQPONMLJIHGFEDCBA!@#$%¨&*(){}=+-_~ªº²³£¢¬"[]Ýÿ';
     MsgBloqueado: AnsiString = 'Não foi encontrada a chave de licenciamento do sistema.'+#13+
                                'Entre em contado com o suporte técnico pelo telefone: 8589-2803 ou pelo e-mail: desenvolvimentohrm@gmail.com para mais explicações!';

   Function GetSerialHD: AnsiString;
   var
     Volume : AnsiString;
     Serial, DirLen, DirFlags: Dword;
     DLabel: Array[0..11] of Char;
   Begin
     Volume := ExtractFileDrive(Application.ExeName);
     GetVolumeInformationW(PWideChar(Volume), DLabel, 12, @Serial, DirLen, DirFlags, nil, 0);
     Result := IntToHex(Serial,8);
   End;

   Function GetDataBIOS: AnsiString;
   Begin
      Result := PWideChar(Ptr($FFFF5));
   End;

   Function Kripta(Txt :AnsiString) : AnsiString;
   var
     I,r: Integer;
   Begin
     for I := 1 to Length(Txt) do
     Begin
       for r := 1 to Length(Krip_Nivel_1) do
       Begin
         if Krip_Nivel_1[r] = Char(Txt[i]) then
           Result := Result + Krip_Nivel_2[r];
       End;
     End;

   End;

   Function Deckripta(Txt :AnsiString) : AnsiString;
    var
     I,r: Integer;
   Begin
     for I := 1 to Length(Txt) do
     Begin
       for r := 1 to Length(Krip_Nivel_1) do
       Begin
         if Krip_Nivel_2[r] = Char(Txt[i]) then
           Result := Result + Krip_Nivel_1[r];
       End;
     End;

   End;

   Function GerarCodigoComputador: AnsiString;
   const
     Invalidos : AnsiString = '{},.-_+';
   var
     i : Integer;
     temp : AnsiString;
   Begin
     Result := Info.Misc.HardwareProfile.GUID;
     for I := 1 to Length(Result) do
       if Pos(Result[i], Invalidos) = 0  then
         Temp:= Temp + Result[i];
     Result := UpperCase(Copy(Temp,1,10));
   End;

   Function GerarChave(Key, Serial, Data, NumeroUsuarios :AnsiString;UltimaData: AnsiString = '00000000'): AnsiString;
   Var
     Txt : AnsiString;
   Begin
     if Data = '' then
       Data := '000000';
     //UltimaData := '00000000';
     if NumeroUsuarios = '' then
       NumeroUsuarios := '000';
     Txt := Key+Data+Serial+UltimaData+NumeroUsuarios;
     Result := Kripta(txt) ;
   End;

   Function ChaveValida(Key ,Serial: AnsiString): Boolean;
   var
     x,hd, Data,vSerial : AnsiString;
   Begin
     if Key = '' then
     Begin
       Result := False;
       Exit;
     End;
     X := Deckripta(Key);
     hd := Copy(x, 1,10);
     Data := Copy(x,11,6);
     if Data <> '000000' then
       Data := Copy(Data,1,2)+'/'+Copy(Data,3,2)+'/'+'20'+Copy(Data,5,2);

     vSerial  := Copy(x, 17,6);
     Result := vSerial = Serial;

     if Result  then
     Begin
       {Para não ter que fazer uma UDF só verifica se for o servidor}
       Result :=  Hd = GerarCodigoComputador;
       if not Result then{Se o código do HD for diferente, verifica se é uma máquina na rede}
       Begin
         Result := InfoSistema.Host <> '127.0.0.1' ;
         if Result then //Verifica se o host é o ip ou nome da máquina local
          Begin
            Result := (UpperCase(InfoSistema.Host) <> UpperCase(info.Identification.LocalComputerName)) ;
            if Result then
              Result := ( (IsInteger(StringReplace(InfoSistema.Host, '.','',[rfReplaceAll]) )) and
                          (StringReplace(info.Identification.IPAddress, '.','',[rfReplaceAll])  <>
                           StringReplace(InfoSistema.Host, '.','',[rfReplaceAll])) ) ;
          End;

       End;
     End;

     if (Result) and (Data <> '000000') then
       Result := StrToDate(GetDataServidor) <= StrToDate(Data) ;


   End;

   Function Licenciar(Key : AnsiString) : Boolean;
   var
     StrSQL,Serial : AnsiString;
   Begin
     {Grava a o serial no pc}
     Result := True;
    try
      Serial := Deckripta(Key);
      Serial  := Copy(Serial, 17,6);
      if InfoSistema.Sistema in [sL_Kimera,sPet,sControleServico] then
      Begin
        StartTrans;
        StrSQL :=
         'UPDATE OR  INSERT INTO CONFIGURACOES ( NOMECONFIGURACAO, NOMESECAO, VALOR) '+
         '  VALUES ('+GetStr(cfgLKimeraLicenca)+', ''LICENCA'', '+GetStr(Key)+') MATCHING(NOMECONFIGURACAO, NOMESECAO) ';
        Exec_SQL(StrSQL);
        StrSQL :=
         'UPDATE OR  INSERT INTO CONFIGURACOES ( NOMECONFIGURACAO, NOMESECAO, VALOR) '+
         '  VALUES ('+GetStr(cfgLKimeraSerial)+', ''LICENCA'', '+GetStr(Serial)+') MATCHING(NOMECONFIGURACAO, NOMESECAO) ';
        Exec_SQL(StrSQL);
        Commit;
      End;
      {if InfoSistema.Sistema = sImoveis then // Ninguém usa essa licença
      Begin
        MyCfgImovel.SetConfiguracao(tpImovChave, Key);
        MyCfgImovel.SetConfiguracao(tpImovSerial, Serial)
      End;}
    except
      on E: Exception do
      Begin
        if InfoSistema.Sistema = sL_Kimera Then
         RollBack;
        Result := False;
        raise;
      End;
    end;

   End;

 Function GetComputadorLiberado(Serial: AnsiString): Boolean;
 var
   vChave ,
   vUltimaData, Data,vKey, Usuarios: AnsiString;
 Begin
     { Verifica se o sistema pode ser executado }
   Result := True;
   if InfoSistema.Sistema in [sL_Kimera,sPet,sControleServico] then
     vChave := GetValorCds('SELECT VALOR FROM CONFIGURACOES WHERE NOMECONFIGURACAO = '+GetStr(cfgLKimeraLicenca));
   {if InfoSistema.Sistema = sImoveis then
     vChave := MyCfgImovel.GetConfiguracao(tpImovChave);}
   if (vChave = '') or
      (not ChaveValida(vChave, Serial)) then
   Begin
     Avisa(MsgBloqueado);
     Result := False;
     Exit;
   End;
   vKey := Deckripta(vChave) ;
   vUltimaData := Copy(vKey, 23, 8);
   if vUltimaData = '00000000' then
     vUltimaData := '';
   Data := Copy(vKey,11,6);
   if Data <> '000000' then
   Begin
     if (vUltimaData <> '') and (StrToDate(Copy(vUltimaData, 7,2)+'/'+ Copy(vUltimaData, 5,2)+'/'+Copy(vUltimaData, 1,4)) >
                                 StrToDate(GetDataServidor)) then
     Begin
       Avisa(MsgBloqueado);      {Se o usuário voltar a data do sistema a licença bloqeuia pegando a últimada do usuário}
       Result := False;
       Exit;
     End else
     Begin
       vKey := vKey +  FormatDateTime('yyyymmdd', StrToDate(GetDataServidor));
       Usuarios := Copy(vKey, 31,3);// Varifica Usuarios Logados
       vKey := Kripta(vKey);
       Licenciar(vKey);
     End;

   End else
   begin
     vKey := vKey +  FormatDateTime('yyyymmdd', StrToDate(GetDataServidor));
       Usuarios := Copy(vKey, 31,3);// Varifica Usuarios Logados
       vKey := Kripta(vKey);
       Licenciar(vKey);{ TODO : Rever }
   end;
   InfoSistema.Serial := Serial;
   InfoSistema.ChaveInstalacao :=vKey;
   InfoSistema.UsuariosMax := StrToIntDef(Usuarios,0);
   InfoSistema.DataLimite := Data;
   InfoSistema.UltimaData := StrToDateDef(vUltimaData,0);



 End;
  initialization
   Info := TJvComputerInfoEx.Create(Application);

end.
