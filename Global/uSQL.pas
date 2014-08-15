unit uSQL;

interface
  uses MinhasClasses, StrUtils, SysUtils;

  Function GetSelect(TipoPesquisa : TTipoPesquisa; Wh : String = ''; Order : String = ''; Join: String = '' ): String;
  Function GetCampoChave(TipoPesquisa : TTipoPesquisa) : String;
  Function GetApelido(TipoPesquisa : TTipoPesquisa) : String;
  Function GetTabela(TipoPesquisa : TTipoPesquisa) : String;
  Function GetCampoCodigo(TipoPesquisa : TTipoPesquisa) : String;
  Function GetCampoDisplay(TipoPesquisa : TTipoPesquisa) : String;
  Function GetDescricaoCampoDisplay(TipoPesquisa : TTipoPesquisa) : String;

  Procedure GetSQL(MySQL : TSQL; TipoPesquisa : TTipoPesquisa ; Complemento : String);
  Function LimpaStr(Const Str : String) : String;

implementation


{ TSQL }

Procedure GetSQL(MySQL : TSQL; TipoPesquisa : TTipoPesquisa; Complemento : String );
Begin

  with MySQL do
      case TipoPesquisa of
        {$Region 'L-Kimera'}
//        tpLKimeraCliente :
//          Begin
//            NomeTabela := 'CLIENTE';
//            CampoChave := 'IDCLIENTE';
//            Select :=
//              'SELECT C.IDCLIENTE, C.CODIGO, C.NOMECLIENTE, C.TELEFONE, C.IDCEP,'+
//              '       C.OBS, C.REFERENCIA, C.NUMERO, C.COMPLEMENTO,C.CADASTRO ,'+
//              '       CEP.CEP, CEP.LOGRADOURO, CEP.BAIRRO, CEP.CIDADE,'+
//              '       SUM (COALESCE(CC.VALOR - COALESCE(CC.VALORPAGO,0),0)) DIVIDA'+
//              '  FROM CLIENTE C'+
//              '  LEFT JOIN  CONTAS CC'+
//              '    ON (C.IDCLIENTE = CC.IDCLIENTE)'+
//              '  LEFT JOIN CEP  '+
//              '    ON (CEP.IDCEP = C.IDCEP)'+
//              ' WHERE 1=1 '+Complemento+
//              ' GROUP BY C.IDCLIENTE, C.CODIGO, C.NOMECLIENTE, C.TELEFONE, C.IDCEP,'+
//              '          C.OBS, C.REFERENCIA, C.NUMERO, C.COMPLEMENTO,C.CADASTRO ,  '+
//              '          CEP.CEP, CEP.LOGRADOURO, CEP.BAIRRO, CEP.CIDADE';
//          End;
//        tpLKimeraProduto ,tpLKimeraProdutoAtivo:
//          Begin
//            NomeTabela := 'PRODUTO';
//            CampoChave := 'IDPRODUTO';
//            Select :=
//              'EXECUTE BLOCK RETURNS (IDPRODUTO INTEGER, NOMEPRODUTO VARCHAR(100),CODIGO VARCHAR(10),'+
//              '                       CODIGOINTERNO VARCHAR(20),PRECOVENDA NUMERIC(18,2),QUANTIDADE NUMERIC(18,2),'+
//              '                       UNIDADE VARCHAR(6),DATACADASTRO DATE,DATAREAJUSTE TIMESTAMP,'+
//              '                       FLAGINATIVO CHAR(1),PRECOCOMPRA NUMERIC(18,2),QUANTIDADECRITICA NUMERIC(18,2),'+
//              '                       OBS BLOB SUB_TYPE 1 SEGMENT SIZE 100) AS '+
//              'BEGIN'+
//              '  FOR'+
//              '    SELECT IDPRODUTO, NOMEPRODUTO, CODIGO, CODIGOINTERNO, PRECOVENDA,'+
//              '           QUANTIDADE, UNIDADE, DATACADASTRO, DATAREAJUSTE, FLAGINATIVO,'+
//              '           PRECOCOMPRA, QUANTIDADECRITICA, OBS'+
//              '      FROM PRODUTO'+
//              '      WHERE 1=1'+IfThen(TipoPesquisa = tpLKimeraProdutoAtivo, ' AND COALESCE(FLAGINATIVO, ''N'') = ''N'' ', '' )+ Complemento+
//              '      INTO :IDPRODUTO, :NOMEPRODUTO, :CODIGO, :CODIGOINTERNO, :PRECOVENDA,'+
//              '           :QUANTIDADE, :UNIDADE, :DATACADASTRO, :DATAREAJUSTE,'+
//              '           :FLAGINATIVO, :PRECOCOMPRA, :QUANTIDADECRITICA, :OBS'+
//              '   DO'+
//              '    BEGIN'+
//              '      SUSPEND;'+
//              '    END '+
//              'END';
//          End;
//        tpLKimeraCompra, tpLKimeraVenda :
//          Begin
//            NomeTabela := 'MOVIMENTO';
//            CampoChave := 'IDMOVIMENTO';
//            Select :=
//              ' SELECT M.IDMOVIMENTO, M.DATA, M.HORA, M.IDCLIENTE,'+
//              '        M.VALORTROCO, M.VALORTOTALBRUTO, M.VALORTOTALLIQUIDO,'+
//              '        M.VALORDESCONTOGERAL, M.VALORACRESCIMOGERAL, M.OBS,'+
//              '        M.NUMPEDIDO, M.FLAGTIPOMOVIMENTO, C.CODIGO,'+
//              '        C.NOMECLIENTE, C.REFERENCIA, C.NUMERO, C.COMPLEMENTO, '+
//              '        CEP.CEP, CEP.LOGRADOURO, CEP.BAIRRO'+
//              '  FROM MOVIMENTO M'+
//              '  LEFT JOIN CLIENTE C'+
//              '    ON (C.IDCLIENTE = M.IDCLIENTE)'+
//              '  LEFT JOIN CEP  '+
//              '    ON (CEP.IDCEP = C.IDCEP) '+
//              ' WHERE  '+IfThen(TipoPesquisa = tpLKimeraCompra , 'M.FLAGTIPOMOVIMENTO = ''C''', 'M.FLAGTIPOMOVIMENTO = ''V''') +Complemento;
//
//          end;
//        tpLKimeraContaReceber , tpLKimeraContaRecebida :
//          Begin
//            NomeTabela := 'CONTAS';
//            CampoChave := 'IDCONTAS';
//            Select :=
//                ' SELECT CC.IDCONTAS, CC.IDCLIENTE, CC.IDMOVIMENTO, CC.VALOR,'+
//                '        COALESCE(CC.VALORPAGO,0) VALORPAGO, CC.FLAGQUITADO, CC.DATAPAGO, CC.FLAGCANCELADO,'+
//                '        C.CODIGO, C.NOMECLIENTE, M.DATA, M.HORA, M.NUMPEDIDO, '+
//                '        CASE WHEN COALESCE(CC.FLAGCANCELADO,''N'') = ''Y'' THEN ''Sim'' ' +
//                '             ELSE  ''Não'' END CANCELADO ,  (CC.VALOR - COALESCE(CC.VALORPAGO,0)) DIVIDA'+
//                '   FROM CONTAS CC'+
//                '   LEFT JOIN CLIENTE C'+
//                '     ON (C.IDCLIENTE = CC.IDCLIENTE)'+
//                '   LEFT JOIN MOVIMENTO M'+
//                '     ON (M.IDMOVIMENTO = CC.IDMOVIMENTO)'+
//                ' WHERE '+ifThen(TipoPesquisa = tpLKimeraContaReceber, 'COALESCE(CC.FLAGQUITADO,''N'') = ''N'' ', 'COALESCE(CC.FLAGQUITADO,''N'') = ''Y'' ')+Complemento;
//          End;
//        tpLKimeraRecebimento :
//          Begin
//            NomeTabela := 'RECEBIMENTO';
//            CampoChave := 'IDRECEBIMENTO';
//            Select :=
//              ' SELECT IDRECEBIMENTO, CODIGO, NOMERECEBIMENTO, FLAGFINANCEIRO'+
//              '   FROM RECEBIMENTO'+
//              ' WHERE 1=1 '+Complemento;
//          End;
        tpLKimeraCEP, tpImoCEP:
          Begin
            NomeTabela := 'CEP';
            CampoChave := 'IDCEP';
            CampoCodigo := 'CEP';
            Select :=
              'EXECUTE BLOCK RETURNS (IDCEP INTEGER, CEP CHAR(8),LOGRADOURO VARCHAR(200),'+
              '                       BAIRRO VARCHAR(100),CIDADE VARCHAR(100),UF CHAR(2)) AS '+
              'BEGIN '+
              '  FOR'+
              '    SELECT IDCEP, CEP, LOGRADOURO, BAIRRO, CIDADE, ''RJ'' UF'+
              '      FROM CEP'+
              '     WHERE 1=1 '+Complemento+
              '      INTO IDCEP,:CEP, :LOGRADOURO, :BAIRRO, :CIDADE, :UF'+
              '   DO'+
              '    BEGIN'+
              '      SUSPEND;'+
              '    END '+
              'END';

          End;
//        tpLKimeraProdutosMovimento:
//          Begin
//            NomeTabela := 'MOVIMENTOPRODUTO';
//            CampoChave := 'IDMOVIMENTOPRODUTO';
//            Select :=
//              'SELECT MP.IDMOVIMENTOPRODUTO, MP.IDMOVIMENTO, MP.IDPRODUTO,'+
//              '       MP.QUANTIDADE, MP.PRECO, MP.VALORTOTAL, MP.VALORDESCONTO,'+
//              '       MP.VALORACRESCIMO, MP.VALORTOTALLIQUIDO, P.NOMEPRODUTO,'+
//              '       P.CODIGO, ''I'' FLAGEDICAO, P.PRECOVENDA '+
//              '  FROM MOVIMENTOPRODUTO MP'+
//              ' INNER JOIN MOVIMENTO M'+
//              '    ON (MP.IDMOVIMENTO = M.IDMOVIMENTO)'+
//              ' INNER JOIN PRODUTO P'+
//              '    ON (P.IDPRODUTO = MP.IDPRODUTO)'+
//              ' WHERE 1=1 '+Complemento;
//          End;
//        tpLKimeraRecebimentoMovimentoRecebimento :
//          Begin
//            NomeTabela := 'MOVIMENTORECEBIMENTO';
//            CampoChave := 'IDMOVIMENTORECEBIMENTO';
//            Select :=
//              'SELECT R.IDRECEBIMENTO, R.NOMERECEBIMENTO, R.FLAGFINANCEIRO,CAST(0 AS VALOR) VALORPAGO,'+
//              '       MR.IDMOVIMENTORECEBIMENTO, MR.IDMOVIMENTO,  MR.VALOR, ''N'' FLAGEDICAO'+
//              '  FROM RECEBIMENTO R'+
//              '  LEFT JOIN MOVIMENTORECEBIMENTO MR'+
//              '    ON (MR.IDRECEBIMENTO = R.IDRECEBIMENTO '+Complemento+' )'+
//              ' WHERE 1=1 ';
//          End;
        tpLayout :
          Begin
            NomeTabela := 'LAYOUT';
            CampoChave := 'IDLAYOUT';
            Select :=
              'SELECT L.IDLAYOUT, L.IDRELATORIO, L.NOMELAYOUT, L.FLAGTIPOLAYOUT,'+
              '       L.TEMPLATE, L.DATACRIACAO, L.DATAMODIFICACAO, L.FLAGPADRAO,'+
              '       R.IMPRESSORAPADRAO'+
              '  FROM LAYOUT L'+
              ' INNER JOIN RELATORIO R'+
              '    ON (R.IDRELATORIO = L.IDRELATORIO)'+
              ' WHERE 1=1 '+Complemento;
          End;
          {$EndRegion}

        {$Region 'Imovel'}
        {$EndRegion}

      end;
    MySQL.Select := LimpaStr(MySQL.Select);

End;

 Function GetSelect(TipoPesquisa : TTipoPesquisa; Wh : String = ''; Order : String = '' ; Join: String = ''): String;
  Var
   Complemento : String;
  Begin
    Complemento := IfThen(wh <> '' , ' AND '+WH, '')+ IfThen(Order <> '', ' order by '+ Order, '' ) ;
    Result := InfoSistema.SQLs.GetMySQL(TipoPesquisa, Complemento,Join).Select;

  End;

Function GetCampoChave(TipoPesquisa : TTipoPesquisa) : String;
 Begin
   Result := InfoSistema.SQLs.GetMySQL(TipoPesquisa,'').CampoChave;
End;

Function GetApelido(TipoPesquisa : TTipoPesquisa) : String;
 Begin
   Result := InfoSistema.SQLs.GetMySQL(TipoPesquisa,'').Apelido;
End;

Function GetTabela(TipoPesquisa : TTipoPesquisa) : String;
Begin
  Result := InfoSistema.SQLs.GetMySQL(TipoPesquisa,'').NomeTabela;
End;

Function LimpaStr(Const Str : String) : String;
var
  MyStr : String;
begin
  MyStr := StringReplace(Str, ''#$D#$A'',' ', [rfReplaceAll, rfIgnoreCase] );
  Result := MyStr;

end;

Function GetCampoCodigo(TipoPesquisa : TTipoPesquisa) : String;
Begin
   Result := InfoSistema.SQLs.GetMySQL(TipoPesquisa,'').CampoCodigo;
End;

Function GetCampoDisplay(TipoPesquisa : TTipoPesquisa) : String;
Begin
  Result := InfoSistema.SQLs.GetMySQL(TipoPesquisa,'').CampoDisplay;
End;

Function GetDescricaoCampoDisplay(TipoPesquisa : TTipoPesquisa) : String;
Begin
  Result := InfoSistema.SQLs.GetMySQL(TipoPesquisa,'').DescricaoCampoDisplay;
End;


end.

