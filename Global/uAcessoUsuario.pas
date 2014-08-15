unit uAcessoUsuario;

interface
   uses Classes, SysUtils, MinhasClasses, UDmConexao,
        Comandos, pFIBDatabase, pFIBProps,
        pFIBDataSet, pFIBQuery, ActnList, Forms;


   Function GravarInfoForm(UnitName, ClassName, Caption : AnsiString) : Integer;
   Procedure GravaObjetosForm(Action : TCustomAction; IdForm: Integer);
   procedure SetPermissao(Action : TCustomAction; IdForm: Integer);

implementation
   Function GravarInfoForm(UnitName, ClassName, Caption : AnsiString) : Integer;
   var
     StrSQL : String;
     Trans: TpFIBTransaction;
     DataSet : TpFIBDataSet;
     Qry : TpFIBQuery;
   Begin
      Result := -1;
      if DMCOnexao = nil then
        Exit;
      Try
        Trans := TpFIBTransaction.Create(nil);
        DataSet := TpFIBDataSet.Create(nil);
        Qry := TpFIBQuery.Create(nil);
        Trans.Name := 'TransUsuario';
        Trans.DefaultDatabase := DMCOnexao.Conexao;
        Trans.TPBMode := tpbReadCommitted;
        DataSet.Database := DMCOnexao.Conexao;
        DataSet.Transaction := Trans;
        Qry.Database := DMCOnexao.Conexao;
        Qry.Transaction := Trans;
        Trans.StartTransaction;
        DataSet.PrepareOptions := DataSet.PrepareOptions+[ psCanEditComputedFields,
                                                psSetEmptyStrToNull,psSupportUnicodeBlobs,
                                                psUseLargeIntField, psSQLINT64ToBCD, psSupportUnicodeBlobs,
                                                psApplyRepositary, psUseBooleanField]  ;
        DataSet.PrepareOptions := DataSet.PrepareOptions - [pfImportDefaultValues];
        try
          StrSQL :=
            'SELECT FIRST 1 IDFORM '+
            '  FROM FORM '+
            ' WHERE UNITNAME = '+GetStr(UnitName)+
            '   AND NOMECLASS = '+GetStr(ClassName);

          DataSet.Close;
          DataSet.SQLs.SelectSQL.Text := StrSQL;
          DataSet.Prepare;
          DataSet.Open;
          Result :=  StrToIntDef(DataSet.FieldByName('IDFORM').AsString,-1);
          Qry.Close;
          Qry.SQL.Text := 'UPDATE OR  INSERT INTO SISTEMA (IDSISTEMA, NOMESISTEMA) '+
                          ' VALUES ('+IntToStr(InfoSistema.Sistema)+', '+GetStr(Application.Title)+')MATCHING(IDSISTEMA)';
          Qry.ExecQuery;
          Qry.Close;
          if Result <= 0 then
          Begin
            Result := GetValSeq('SEQ_IDFORM');
            StrSQL:=
              ' INSERT INTO FORM (IDFORM, UNITNAME, NOMECLASS, CAPTION,IDSISTEMA) '+
              '           VALUES ('+IntToStr(Result)+', '+GetStr(UnitName)+', '+
              GetStr(ClassName)+', '+GetStr(Caption)+','+IntToStr(InfoSistema.Sistema)+' ) ';
            Qry.SQL.Text := StrSQL;
          End else
          Begin
            StrSQL:=
              'UPDATE FORM  '+
              '  SET UNITNAME = '+GetStr(UnitName)+','+
              '      NOMECLASS = '+GetStr(ClassName)+','+
              '      CAPTION = '+GetStr(Caption)+
              '     ,IDSISTEMA = '+IntToStr(InfoSistema.Sistema)+
              '  WHERE (IDFORM = '+IntToStr(Result)+') ';
            Qry.SQL.Text := StrSQL;
          End;
          Qry.ExecQuery;
          Trans.Commit;
        except
          on e: Exception do
          Begin
            Trans.Rollback;
            raise;
          End;
        end;
      Finally
        FreeAndNil(Trans);
        FreeAndNil(DataSet);
        FreeAndNil(Qry);
      End;
   End;

 Procedure GravaObjetosForm(Action : TCustomAction;  IdForm: Integer);
   var
     StrSQL : String;
     Trans: TpFIBTransaction;
     Qry : TpFIBQuery;
     IdFormControle : Int64;
     Temp: String;
     Guid: TGUID;
   Begin
      if DMCOnexao = nil then
        Exit;
      Try
        Try
          Trans := TpFIBTransaction.Create(nil);
          Qry := TpFIBQuery.Create(nil);
          Trans.DefaultDatabase := DMCOnexao.Conexao;
          Trans.TPBMode := tpbReadCommitted;
          Qry.Database := DMCOnexao.Conexao;
          Qry.Transaction := Trans;
          Trans.StartTransaction;
          StrSQL :=
            'UPDATE OR INSERT INTO FORMCONTROLE (IDFORM, NOMEOBJETO, CAPTION) '+
            '                            VALUES ('+IntToStr(IdForm)+', '+
                                                  GetStr(Action.Name)+','+ GetStr(Action.Caption)+' ) '+
                                                  'MATCHING(IDFORM, NOMEOBJETO) ';
          Qry.Close;
          Qry.SQL.Text := StrSQL;
          Qry.ExecQuery;
          Trans.Commit;
        except
          Trans.Rollback;
        end;
      Finally
        FreeAndNil(Trans);
        FreeAndNil(Qry);
      End;

 End;

 procedure SetPermissao(Action : TCustomAction; IdForm: Integer);
   var
     StrSQL : String;
     Trans: TpFIBTransaction;
     Qry : TpFIBDataSet;
     IdFormControle : Int64;
   Begin
      if DMCOnexao = nil then
        Exit;
      Try
        Trans := TpFIBTransaction.Create(nil);
        Qry := TpFIBDataSet.Create(nil);
        Trans.DefaultDatabase := DMCOnexao.Conexao;
        Trans.TPBMode := tpbReadCommitted;
        Qry.Database := DMCOnexao.Conexao;
        Qry.Transaction := Trans;
        IdFormControle := Action.GetHashCode;
        Trans.StartTransaction;
        StrSQL :=
          'SELECT PA.FLAGVISIVEL '+
          '  FROM PERFILACESSO PA '+
          ' WHERE PA.IDPERFILUSUARIO = '+IntToStr(USuarioLogado.IdPerfil)+
          '   AND PA.IDFORM = '+IntToStr(IdForm)+
          '   AND NOMEOBJETO = '+GetStr(Action.Name);
        Qry.Close;
        Qry.SQLs.SelectSQL.Text := StrSQL;
        Qry.Open;
        if not Qry.Fields[0].IsNull then
          Action.Visible := Qry.Fields[0].AsString = 'L';
      Finally
        FreeAndNil(Trans);
        FreeAndNil(Qry);
      End;


 end;

end.
