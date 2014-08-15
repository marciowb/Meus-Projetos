unit uSQLPet;

interface
  uses SysUtils,MinhasClasses,StrUtils;
   Type
     TSQLPet = class(TSQLs)
       Function GetMySQL(TipoPesquisa : TTipoPesquisa ; Complemento : String) :TSQL;override;
     end;

implementation

{ TSQLPet }

function TSQLPet.GetMySQL(TipoPesquisa: TTipoPesquisa;
  Complemento: String): TSQL;
begin
  Result.CampoCodigo := 'CODIGO' ;
  Result := inherited;
  Result.Versao20 := True;
  with Result do
  Begin
    case TipoPesquisa of
      tpPetTipoAnimal:
      Begin
        CampoChave := 'IDTIPOANIMAL';
        CampoDisplay := 'NOMETIPOANIMAL';
        NomeTabela := 'TIPOANIMAL';
        DescricaoCampoDisplay := 'Espécie';
        DescricaoTabela := 'Espécie';
        Select :=
          'SELECT IDTIPOANIMAL, CODIGO, NOMETIPOANIMAL '+
          '  FROM TIPOANIMAL '+
          ' WHERE 1=1 '+Complemento;
      End;
      tpPetTipoServico:
       Begin
         CampoChave := 'IDTIPOSERVICO';
         CampoDisplay := 'NOMETIPOSERVICO';
         NomeTabela := 'TIPOSERVICO';
         DescricaoCampoDisplay := 'Nome do serviço';
         DescricaoTabela := 'Tipo de serviço';
         Select :=
            'SELECT IDTIPOSERVICO, CODIGO, NOMETIPOSERVICO '+
            '  FROM TIPOSERVICO '+
            ' WHERE 1=1 '+Complemento;
       End;
      tpPetCategoriaAnimal:
       Begin
         CampoChave := 'IDCATEGORIAANIMAL';
         CampoDisplay := 'NOMECATEGORIAANIMAL';
         NomeTabela := 'CATEGORIAANIMAL';
         DescricaoCampoDisplay := 'Categoria de animal';
         DescricaoTabela := 'Categoria de animal';
         Versao20 := False;
         Select :=
          'SELECT IDCATEGORIAANIMAL,CODIGO,NOMECATEGORIAANIMAL,IDTIPOANIMAL,NOMETIPOANIMAL'+
          '  FROM ('+
          '        SELECT C.IDCATEGORIAANIMAL, C.CODIGO, C.NOMECATEGORIAANIMAL, C.IDTIPOANIMAL,'+
          '               (SELECT T.NOMETIPOANIMAL'+
          '                  FROM TIPOANIMAL T'+
          '                 WHERE C.IDTIPOANIMAL = T.IDTIPOANIMAL ) NOMETIPOANIMAL'+
          '          FROM CATEGORIAANIMAL C )X'+
          ' WHERE 1=1 '+Complemento;
       End;
      tpPetFormaPagamento:
       Begin
         CampoChave := 'IDFORMAPAGAMENTO';
         CampoDisplay := 'NOMEFORMAPAGAMENTO';
         NomeTabela := 'FORMAPAGAMENTO';
         DescricaoCampoDisplay := 'Forma de pagamento';
         DescricaoTabela := 'Forma de pagamento';
         //Versao20 := False;
         Select :=
           'SELECT IDFORMAPAGAMENTO, CODIGO, NOMEFORMAPAGAMENTO, TIPOFORMAPAGAMENTO' +
           '  FROM FORMAPAGAMENTO '+
           ' WHERE 1=1 '+Complemento;
       End;
      tpPetProfissional:
       Begin
         CampoChave := 'IDPROFISSIONAL';
         CampoDisplay := 'NOMEPROFISSIONAL';
         NomeTabela := 'PROFISSIONAL';
         DescricaoCampoDisplay := 'Profissional';
         DescricaoTabela := 'Profissional';
         Versao20 := False;
         Select :=
            'SELECT IDPROFISSIONAL, CODIGO, NOMEPROFISSIONAL, OBS, '+
            '       ALIQCOMISSAO, FLAGPEDIRNOME '+
            '  FROM PROFISSIONAL '+
            ' WHERE 1=1 '+Complemento;
       End;
      tpPetRacaAnimal:
       Begin
         CampoChave := 'IDRACAANIMAL';
         CampoDisplay := 'NOMERACA';
         NomeTabela := 'RACAANIMAL';
         DescricaoCampoDisplay := 'Raça';
         DescricaoTabela := 'Raças';
         Versao20 := False;
         Select :=
           'SELECT R.IDRACAANIMAL, R.CODIGO, R.NOMERACA, R.IDTIPOANIMAL, '+
           '       T.NOMETIPOANIMAL   '+
           '  FROM RACAANIMAL R '+
           ' INNER JOIN TIPOANIMAL T  '+
           '    ON (T.IDTIPOANIMAL = R.IDTIPOANIMAL) '+
           ' WHERE 1=1 '+Complemento;
       End;
      tpPetEmpresa:
       Begin
         CampoChave := 'IDEMPRESA';
         CampoDisplay := 'RAZAOSOCIAL';
         NomeTabela := 'EMPRESA';
         DescricaoCampoDisplay := 'Razão social';
         DescricaoTabela := 'Empresa';
         Versao20 := False;
         Select :=
           'SELECT E.IDEMPRESA, E.CODIGO, E.RAZAOSOCIAL, E.FANTASIA, E.CNPJ, '+
           '       E.IDCEP, E.COMPLEMENTO, E.NUMERO, E.LOGOMARCA, E.IE,E.NUMSERVICO,  '+
           '       E.TELEFONE, E.FAX, E.OBS, E.IDLAYOUT,CEP.CEP, CEP.LOGRADOURO, CEP.BAIRRO, '+
           '       CEP.CIDADE, CEP.UF  '+
           '  FROM EMPRESA E '+
           ' INNER JOIN CEP  '+
           '    ON (CEP.IDCEP = E.IDCEP) '+
           ' WHERE 1=1 '+Complemento;
       End;
      tpPetUsuario:
       Begin
         CampoChave := 'IDUSUARIO';
         CampoDisplay := 'NOME';
         CampoCodigo  := 'LOGIN';
         NomeTabela := 'USUARIO';
         DescricaoCampoDisplay := 'Nome completo';
         DescricaoTabela := 'Usuários';
         Versao20 := False;
         Select :=
            'SELECT IDUSUARIO, LOGIN, SENHA, NOME '+
            '  FROM USUARIO '+
            ' WHERE 1=1 '+Complemento;
       End;
      tpPetPrecoServico:
       Begin
         CampoChave := 'IDPRECOSERVICO';
         CampoDisplay := '';
         CampoCodigo  := '';
         NomeTabela := 'PRECOSERVICO';
         DescricaoCampoDisplay := '';
         DescricaoTabela := 'Preço dos serviços';
         Versao20 := False;
         Select :=
            'SELECT T.IDTIPOSERVICO, T.CODIGO, T.NOMETIPOSERVICO,'+
            '       C.IDCATEGORIAANIMAL, C.NOMECATEGORIAANIMAL,'+
            '       C.IDTIPOANIMAL,TA.NOMETIPOANIMAL,''N'' FLAGEDICAO, '+
            '       (SELECT PS.PRECO'+
            '          FROM PRECOSERVICO PS'+
            '         WHERE PS.IDTIPOSERVICO = T.IDTIPOSERVICO'+
            '           AND PS.IDCATEGORIAANIMAL = C.IDCATEGORIAANIMAL ) PRECO,'+
            '       (SELECT PS.IDPRECOSERVICO  '+
            '          FROM PRECOSERVICO PS  '+
            '         WHERE PS.IDTIPOSERVICO = T.IDTIPOSERVICO '+
            '           AND PS.IDCATEGORIAANIMAL = C.IDCATEGORIAANIMAL )IDPRECOSERVICO  '+
            '  FROM TIPOSERVICO T, CATEGORIAANIMAL C'+
            ' INNER JOIN TIPOANIMAL TA '+
            '    ON (TA.IDTIPOANIMAL = C.IDTIPOANIMAL) '+
            ' WHERE 1=1 '+Complemento;
       End;
      tpPetCliente:
       Begin
         CampoChave := 'IDCLIENTE';
         CampoDisplay := 'NOMECLIENTE';
         NomeTabela := 'CLIENTE';
         DescricaoCampoDisplay := 'Nome';
         DescricaoTabela := 'Clientes';
         Versao20 := False;
         Select :=
            'SELECT C.IDCLIENTE, C.CODIGO, C.NOMECLIENTE, C.IDCEP, C.NUMERO, '+
            '       C.COMPLEMENTO, C.CPF, C.IDENTIDADE, C.ORGAOEMISSOR,C.FLAGSEXO, '+
            '       C.DATAEMISSAO, C.DATANASCIMENTO, C.DATACADASTRO, C.TELEFONE, C.CELULAR,'+
            '       C.OBS, C.RG, C.DIAPAGAMENTO, CEP.CEP, CEP.LOGRADOURO, CEP.BAIRRO, CEP.CIDADE, CEP.UF '+
            '  FROM CLIENTE C  '+
            '  LEFT JOIN CEP '+
            '    ON (CEP.IDCEP = C.IDCEP) '+
            ' WHERE 1=1 '+Complemento;
       End;
      tpPetAnimal:
       Begin
         CampoChave := 'IDANIMAL';
         CampoDisplay := 'NOMEANIMAL';
         NomeTabela := 'ANIMAL';
         DescricaoCampoDisplay := 'Nome';
         DescricaoTabela := 'Animais';
         Versao20 := False;
         Select :=
           'SELECT A.IDANIMAL, A.CODIGO, A.NOMEANIMAL, A.IDCLIENTE, A.DATACADASTRO, '+
           '       A.IDTIPOANIMAL, A.IDCATEGORIAANIMAL, A.PESO, '+
           '       A.ALTURA, A.COMPRIMENTO, A.OBS, A.IDRACAANIMAL, A.SEXO, '+
           '       A.DATANASCIMENTO,A.FLAGMONITORAR,TA.NOMETIPOANIMAL,CA.NOMECATEGORIAANIMAL, '+
           '       R.NOMERACA, C.NOMECLIENTE  '+
           '  FROM ANIMAL A '+
           ' INNER JOIN CLIENTE C '+
           '    ON (C.IDCLIENTE = A.IDCLIENTE)'+
           ' INNER JOIN TIPOANIMAL TA '+
           '    ON (TA.IDTIPOANIMAL = A.IDTIPOANIMAL) '+
           ' INNER JOIN CATEGORIAANIMAL CA  '+
           '    ON (CA.IDCATEGORIAANIMAL = A.IDCATEGORIAANIMAL) '+
           '  LEFT JOIN RACAANIMAL R '+
           '    ON (R.IDRACAANIMAL = A.IDRACAANIMAL) '+
           ' WHERE 1=1 '+Complemento;

       end;
      tpPetServico:
       Begin
         CampoChave := 'IDSERVICO';
         CampoDisplay := '';
         NomeTabela := 'SERVICO';
         DescricaoCampoDisplay := '';
         DescricaoTabela := 'Servico';
         CampoCodigo :='';
         Versao20 := False;
         Select :=
          'SELECT S.IDSERVICO, S.DATA, S.HORA, S.IDEMPRESA, S.VALORTOTAL, S.OBS,'+
          '       S.IDUSUARIO, S.IDAGENDA, S.IDCLIENTE,LPAD(S.NUMSERVICO,6,''0'')NUMSERVICO,S.VALORACRESCIMO,'+
          '       S.VALORDESCONTO,COALESCE(C.NOMECLIENTE, S.NOMECLIENTE)NOMECLIENTE,'+
          '       U.LOGIN,S.VALORTOTALLIQUIDO'+
          ' FROM SERVICO S '+
          'INNER JOIN USUARIO U'+
          '   ON (U.IDUSUARIO = S.IDUSUARIO)'+
          ' LEFT JOIN CLIENTE C'+
          '   ON (C.IDCLIENTE = S.IDCLIENTE)'+
          'WHERE 1=1'+ Complemento;

       End;
      tpPetServicoDetalhe:
       Begin
         CampoChave := 'IDSERVICODETALHE';
         CampoDisplay := '';
         NomeTabela := 'SERVICODETALHE';
         DescricaoCampoDisplay := '';
         DescricaoTabela := 'Itens do servico';
         CampoCodigo :='';
         Versao20 := False;
         Select :=
          'SELECT S.IDSERVICODETALHE, S.IDSERVICO, S.IDTIPOSERVICO, S.VALOR, S.VALORORIGINAL,'+
          '       S.IDTIPOANIMAL, S.IDANIMAL,S.IDPROFISSIONAL, S.ALIQCOMISSAO,'+
          '       S.VALORCOMISSAO,COALESCE(A.NOMEANIMAL, S.NOMEANIMAL)NOMEANIMAL,'+
          '       S.IDCATEGORIAANIMAL,TS.NOMETIPOSERVICO, TA.NOMETIPOANIMAL,'+
          '       COALESCE(S.NOMEPROFISSIONAL, P.NOMEPROFISSIONAL)NOMEPROFISSIONAL'+
          '  FROM SERVICODETALHE S'+
          ' INNER JOIN TIPOSERVICO TS'+
          '    ON (TS.IDTIPOSERVICO = S.IDTIPOSERVICO)'+
          ' INNER JOIN PROFISSIONAL P'+
          '    ON (P.IDPROFISSIONAL = S.IDPROFISSIONAL)'+
          '  LEFT JOIN ANIMAL A'+
          '    ON (A.IDANIMAL = S.IDANIMAL)'+
          '  LEFT JOIN TIPOANIMAL TA'+
          '    ON (TA.IDTIPOANIMAL = S.IDTIPOANIMAL)'+
          ' WHERE 1=1'+ Complemento;

       End;
      tpPetServicoPagamentos:
       Begin
         CampoChave := 'IDSERVICOFORMAPAGAMENTO';
         CampoDisplay := '';
         NomeTabela := 'SERVICOFORMAPAGAMENTO';
         DescricaoCampoDisplay := '';
         DescricaoTabela := 'Itens do servico';
         CampoCodigo :='';
         Versao20 := False;
         Select :=
            'SELECT SF.IDSERVICOFORMAPAGAMENTO, SF.IDSERVICO, '+
            '       FP.IDFORMAPAGAMENTO, SF.VALOR, FP.NOMEFORMAPAGAMENTO,FP.TIPOFORMAPAGAMENTO '+
            '  FROM FORMAPAGAMENTO FP '+
            '  LEFT JOIN SERVICOFORMAPAGAMENTO SF '+
            '    ON (FP.IDFORMAPAGAMENTO = SF.IDFORMAPAGAMENTO '+Complemento+') '+
            '  LEFT JOIN SERVICO S  '+
            '    ON (S.IDSERVICO = SF.IDSERVICO)'+
            ' WHERE 1=1 ';
       End;
      tpPetCaixa:
       Begin
         CampoChave := 'IDCAIXA';
         CampoDisplay := '';
         NomeTabela := 'CAIXA';
         DescricaoCampoDisplay := '';
         DescricaoTabela := 'Caixa';
         CampoCodigo :='';
         Versao20 := False;
         Select :=
           'SELECT C.IDCAIXA, C.DATA, C.FLAGOPERACAO, C.VALOR, '+
           '       C.IDUSUARIO, C.IDSERVICO, C.HISTORICO, '+
           '       CASE WHEN C.FLAGOPERACAO = ''D'' THEN C.VALOR * -1 '+
           '            ELSE C.VALOR END VALOR_CALC '+
           '  FROM CAIXA C '+
           ' WHERE 1=1 '+Complemento;

       End;
      tpPetGrupo:
       Begin
         CampoChave := 'IDGRUPO';
         CampoDisplay := 'NOMEGRUPO';
         NomeTabela := 'GRUPO';
         DescricaoCampoDisplay := 'Grupo';
         DescricaoTabela := 'Grupos';
         CampoCodigo :='CODIGO';
         Versao20 := True;
         Select :=
           'SELECT IDGRUPO, CODIGO, NOMEGRUPO'+
           '  FROM GRUPO '+
           ' WHERE 1=1 '+Complemento;
       End;
      tpPetGrupoAnimal:
       Begin
         CampoChave := 'IDGRUPO';
         CampoDisplay := 'NOMEGRUPO';
         NomeTabela := 'GRUPOANIMAL';
         DescricaoCampoDisplay := 'Grupo';
         DescricaoTabela := 'Grupos do animal';
         CampoCodigo :='CODIGO';
         Versao20 := True;
         Select :=
           'SELECT GA.IDGRUPOANIMAL, GA.IDANIMAL, GA.IDGRUPO, G.NOMEGRUPO,G.CODIGO,''N'' FLAGEDICAO '+
           '  FROM GRUPOANIMAL GA '+
           ' INNER JOIN GRUPO G '+
           '    ON (G.IDGRUPO = GA.IDGRUPO) '+
           ' WHERE 1=1 '+Complemento;
       End;
      tpPetAcompanhamentoAnimal:
       Begin
         CampoChave := 'IDANIMALACOMPANHAMENTO';
         CampoDisplay := 'OBS';
         NomeTabela := 'ANIMALACOMPANHAMENTO';
         DescricaoCampoDisplay := 'Texto';
         DescricaoTabela := 'Acompanhamentos do animal';
         CampoCodigo :='DATA';
         Versao20 := True;
         Select :=
            ' SELECT AC.IDANIMALACOMPANHAMENTO, AC.IDANIMAL, AC.DATA, AC.OBS,AC.FLAGCHECADO,'+
            '        A.NOMEANIMAL, A.CODIGO,AC.IDPRODUTO,'+
            '        ''CLIENTE: ''||C.CODIGO||'' - ''||C.NOMECLIENTE||'' TEL: ''||COALESCE(C.TELEFONE,'''') CLIENTE,''N'' FLAGEDICAO'+
            '   FROM ANIMALACOMPANHAMENTO AC'+
            '  INNER JOIN ANIMAL A'+
            '     ON (A.IDANIMAL = AC.IDANIMAL)'+
            '  INNER JOIN CLIENTE C'+
            '     ON (C.IDCLIENTE = A.IDCLIENTE)'+
            '  WHERE 1=1 '+Complemento;
       End;
      tpPetContasReceber,tpPetContasRecebidas:
       Begin
         CampoChave := 'IDCONTARECEBER';
         CampoDisplay := '';
         NomeTabela := 'CONTARECEBER';
         DescricaoCampoDisplay := '';
         DescricaoTabela := 'Contas a receber';
         CampoCodigo :='';
         Versao20 := False;
         Select :=
          'SELECT CR.IDCONTARECEBER, CR.DATACRIACAO, CR.DATA, CR.DATAVENCIMENTO,'+
          '       CR.VALOR, CR.IDUSUARIO, CR.FLAGCANCELADA,'+
          '       CR.DATACANCELADA, CR.IDUSUARIOCANCELADA, CR.FLAGPAGO, CR.VALORPAGO,'+
          '       CAST(CR.VALOR - COALESCE(CR.VALORPAGO,0) AS VALOR) DIVIDA, '+
          '       CR.DATAPAGO, CR.IDSERVICO, CR.IDCLIENTE,CR.OBS,CR.HISTORICO,'+
          '       C.CODIGO, C.NOMECLIENTE,'+
          '       (SELECT LIST(A.CODIGO||'' - ''||A.NOMEANIMAL||'' - RAÇA: ''||COALESCE(RA.NOMERACA,''''),''; '')'+
          '          FROM ANIMAL A'+
          '          LEFT JOIN RACAANIMAL RA'+
          '            ON (RA.IDRACAANIMAL = A.IDRACAANIMAL)'+
          '          WHERE C.IDCLIENTE = A.IDCLIENTE) ANIMAIS'+
          '  FROM CONTARECEBER CR'+
          ' INNER JOIN CLIENTE C'+
          '    ON (C.IDCLIENTE = CR.IDCLIENTE)'+
          ' WHERE  '+IfThen(TipoPesquisa = tpPetContasReceber,' COALESCE(CR.FLAGPAGO,''N'') = ''N'' ',' COALESCE(CR.FLAGPAGO,''N'') = ''Y'' ')+ Complemento;
       End;
      tpPetContaReceberRec:
       Begin
         CampoChave := 'IDCONTARECEBERREC';
         CampoDisplay := '';
         NomeTabela := 'CONTARECEBERREC';
         DescricaoCampoDisplay := '';
         DescricaoTabela := 'Recebimentos do Contas a receber';
         CampoCodigo :='';
         Versao20 := False;
         Select :=
            'SELECT CRR.IDCONTARECEBERREC, CRR.IDCONTARECEBER, '+
           '       CRR.DATA, CRR.IDUSUARIO, CRR.VALOR,CRR.IDFORMAPAGAMENTO, '+
           '       FP.NOMEFORMAPAGAMENTO '+
           '  FROM CONTARECEBERREC CRR '+
           ' INNER JOIN FORMAPAGAMENTO FP' +
           '    ON (FP.IDFORMAPAGAMENTO = CRR.IDFORMAPAGAMENTO) '+
           ' WHERE 1=1 '+Complemento;
       End;
    end; // Case


  End; // With


end;

end.
