unit uSQLERP;

interface
  uses SysUtils,MinhasClasses,StrUtils;
   Type
     TSQLERP = class(TSQLs)
       Function GetMySQL(TipoPesquisa : TTipoPesquisa ; Complemento : String; Join: String = '') :TSQL;override;
       Function GetTSQL(TipoPesquisa : TTipoPesquisa ; Complemento : String; Join: String = '') :TSQL;
     end;
implementation

uses uConstantes;

{ TSQLERP }

function TSQLERP.GetMySQL(TipoPesquisa: TTipoPesquisa; Complemento,
  Join: String): TSQL;
begin
  Result.CampoCodigo := 'CODIGO' ;
  Result := inherited;
  Result.Versao20 := True;
  Result.UsaMaxParaCodigo := True;
  Result.TipoForm := TfGrid;
  with Result do
  Begin
    case TipoPesquisa of
     tpERPEmpresa:
     Begin
         CampoChave := 'IDEMPRESA';
         CampoDisplay := 'RAZAOSOCIAL';
         NomeTabela := 'EMPRESA';
         DescricaoCampoDisplay := 'Razão social';
         DescricaoTabela := 'Empresa';
         Versao20 := False;
         DesconsiderarCampos := 'CODIGOIBGEESTADO;CEP;LOGRADOURO;BAIRRO;CIDADE;IBGE';
         Select :=
           'SELECT E.IDEMPRESA, E.CODIGO, E.RAZAOSOCIAL, E.FANTASIA, E.CNPJ,E.REGIMEEMPRESA, '+
           '       E.IDCEP, E.COMPLEMENTO, E.NUMERO, E.LOGOMARCA, E.IE,E.IM,E.NUMEROPROPOSTA, '+
           '       E.NUMEROCONTRATO,E.IDMUNICIPIO,E.CNAE, E.AMBIENTENFSE,E.AMBIENTENFE,E.ALIQPIS,'+
           '       E.ALIQCOFINS,E.ALIQIR,E.ALIQCSLL, '+
           '       E.TELEFONE, E.FAX, E.OBS,E.NUMEROOS,E.NUMEROSAIDA, CEP.CEP, CEP.LOGRADOURO, CEP.BAIRRO, '+
           '       CEP.CIDADE,COALESCE(E.UF, CEP.UF) UF,  '+
           '       (SELECT UF.CODIBGE '+
           '          FROM VW_UF UF    '+
           '         WHERE UF.UF = CEP.UF)  CODIGOIBGEESTADO, M.IBGE  '+
           '  FROM EMPRESA E '+
           ' INNER JOIN CEP  '+
           '    ON (CEP.IDCEP = E.IDCEP) '+
           '  LEFT JOIN MUNICIPIO M '+
           '    ON (M.IDMUNICIPIO = CEP.IDMUNICIPIO)'+
           ' WHERE 1=1 '+Complemento;
       End;
     tpERPCFOPVisivel,tpERPCFOP:
       Begin
         CampoChave := 'IDCFOP';
         CampoDisplay := 'NATUREZA';
         NomeTabela := 'CFOP';
         DescricaoCampoDisplay := 'Natureza';
         DescricaoTabela := 'CFOP';
         CampoCodigo := 'CFOP';
         Versao20 := True;
         Select :=
            'SELECT IDCFOP, CFOP, NATUREZA, FLAGTIPOOPERACAO, '+
            '       FLAGTRIBUTAIPI,FLAGTRIBUTAICMS,'+
            '       FLAGTRIBUTAST,FLAGTRIBUTAPIS_COFINS,CST_PIS_COFINS,FLAGVISIVEL '+
            '  FROM CFOP '+
            '  WHERE 1=1 '+IfThen(TipoPesquisa = tpERPCFOPVisivel,' AND COALESCE(FLAGVISIVEL,''N'') = ''Y'' ')+Complemento;
       End;

     tpERPUnidade:
       Begin
         CampoChave := 'IDUNIDADE';
         CampoDisplay := 'NOMEUNIDADE';
         NomeTabela := 'UNIDADE';
         DescricaoCampoDisplay := 'Unidade';
         DescricaoTabela := 'Unidade';
         Versao20 := True;
         Select :=
            'SELECT IDUNIDADE, CODIGO, NOMEUNIDADE,FLAGFRACIONADO '+
            '  FROM UNIDADE '+
            '  WHERE 1=1 '+Complemento;
       End;

       tpERPAgenda:
       Begin
         CampoChave := 'IDAGENDA';
         CampoDisplay := '';
         NomeTabela := 'AGENDA';
         DescricaoCampoDisplay := '';
         DescricaoTabela := 'Agenda';
         CampoCodigo := '';
         Versao20 := False;
         Select :=
              'SELECT A.IDAGENDA, A.DATACOMPROMISSO, A.HORA, A.ASSUNTO,A.DATACRIACAO,A.FLAGPARTICULAR,A.IDFUNCIONARIO,'+
              '       A.TEXTO, A.FLAGBAIXADO,C.NOMECLIENTE,C.IDCLIENTE , A.NUMREPETICAO,A.IDAGENDAREF,A.IDCONTRATOCOMPETENCIA,'+
              '       ''0'' TYPE,''3'' OPTIONS,'+
              '       CAST(A.DATACOMPROMISSO+ A.HORA AS TIMESTAMP)DATA_HORAINI,'+
              '       CAST(A.DATACOMPROMISSO+ A.HORA AS TIMESTAMP)DATA_HORAFIM, '+
              '       ''Assunto: ''||A.ASSUNTO||'' Cliente: ''||COALESCE(C.NOMECLIENTE,'''')||'' Funcionário: ''||COALESCE(F.NOMEFUNCIONARIO,'''') CAPTION'+
              '  FROM AGENDA A'+
              '  LEFT JOIN CLIENTE C'+
              '    ON (C.IDCLIENTE = A.IDCLIENTE)'+
              '  LEFT JOIN FUNCIONARIO F '+
              '    ON (F.IDFUNCIONARIO = A.IDFUNCIONARIO)'+
              ' WHERE ((COALESCE(FLAGPARTICULAR,''N'') = ''N'') OR '+
              '        ((COALESCE(FLAGPARTICULAR,''N'') = ''Y'') AND '+
              '         (A.IDUSUARIO= '+IntToStr(USuarioLogado.Id)+' ) ) ) '+Complemento;
       End;
      tpERPNCM:
      Begin
        CampoChave := 'IDNCM';
        CampoDisplay := 'DESCRICAO';
        NomeTabela := 'NCM';
        DescricaoCampoDisplay := 'Descrição';
        DescricaoTabela := 'NCM';
        Versao20 := True;
        Select :=
          'SELECT IDNCM, DESCRICAO, CODIGO'+
          '  FROM NCM '+
          ' WHERE 1=1 '+Complemento;
      End;
     tpERPNCMTributacao:
      Begin
        CampoChave := 'IDNCMESTADO';
        CampoDisplay := '';
        NomeTabela := 'NCMESTADO';
        DescricaoCampoDisplay := '';
        DescricaoTabela := 'NCM Impostos';
        Versao20 := True;
        DesconsiderarCampos := 'TIPO_ALIQIPI;FLAGEDICAO';
        Select :=
          'SELECT IDNCMESTADO, IDNCM,UF,  '+
          '       ALIQPIS, ALIQCOFINS, ALIQII, ALIQIPI ,VALOR_LI,''N'' FLAGEDICAO, '+
          '       CASE WHEN (ALIQIPI IS NULL ) AND (IPIVALOR IS NOT NULL ) THEN ''V'' '+
          '            ELSE ''A'' END TIPO_ALIQIPI, ALIQREDUCAOBASEICMS '+
          '  FROM NCMESTADO '+
          ' WHERE 1=1 '+Complemento;
      End;
    tpERPCliente:
      Begin
       CampoChave := 'IDCLIENTE';
       CampoDisplay := 'NOMECLIENTE';
       NomeTabela := 'CLIENTE';
       DescricaoCampoDisplay := 'Nome';
       DescricaoTabela := 'Clientes';
       Versao20 := False;
       UsaMaxParaCodigo := True;
       DesconsiderarCampos := 'GRUPOCLIENTE;MUNICIPIO;IBGE';
       Select :=
          ' SELECT C.IDCLIENTE, C.CODIGO, C.NOMECLIENTE, C.NUMERO, C.COMPLEMENTO, C.CPF,C.CNPJ, C.ORGAOEMISSOR,'+
          '        C.DATAEMISSAO, C.DATANASCIMENTO, C.DATACADASTRO, C.TELEFONE, C.OBS, C.RG, C.IDCEP, C.CELULAR,C.FANTASIA, '+
          '        C.CONTATO, C.IE, C.IM, C.FLAGTIPOPESSOA,C.CEP, C.LOGRADOURO, C.BAIRRO, C.CIDADE, C.UF,C.EMAIL,C.IDGRUPOCLIENTE,'+
          '        C.IDMUNICIPIO, G.NOME GRUPOCLIENTE,M.NOME MUNICIPIO, M.IBGE'+
          '   FROM CLIENTE C'+
          '   LEFT JOIN GRUPOCLIENTE G '+
          '     ON (G.IDGRUPOCLIENTE = C.IDGRUPOCLIENTE)'+
          '   LEFT JOIN MUNICIPIO M '+
          '     ON (M.IDMUNICIPIO = C.IDMUNICIPIO) '+
          '  WHERE 1=1 '+Complemento;
      End;
     tpERPGrupoCliente:
      Begin
        CampoChave := 'IDGRUPOCLIENTE';
        CampoDisplay := 'NOME';
        NomeTabela := 'GRUPOCLIENTE';
        DescricaoCampoDisplay := 'Descrição';
        DescricaoTabela := 'Grupo de clientes';
        Versao20 := True;
        Select :=
          'SELECT IDGRUPOCLIENTE, NOME, CODIGO'+
          '  FROM GRUPOCLIENTE '+
          ' WHERE 1=1 '+Complemento;
      End;
      tpERPCargo:
      Begin
        CampoChave := 'IDCARGO';
        CampoDisplay := 'NOME';
        NomeTabela := 'CARGO';
        DescricaoCampoDisplay := 'Descrição';
        DescricaoTabela := 'Cargos';
        Versao20 := True;
        Select :=
          'SELECT IDCARGO, NOME, CODIGO'+
          '  FROM CARGO '+
          ' WHERE 1=1 '+Complemento;
      End;
      tpERPUsuario:
       Begin
         CampoChave := 'IDUSUARIO';
         CampoDisplay := 'NOMECOMPLETO';
         NomeTabela := 'USUARIO';
         DescricaoCampoDisplay := 'Nome';
         DescricaoTabela := 'Usuário';
         CampoCodigo := 'LOGIN';
         Versao20 := True;
         Select :=
           'SELECT IDUSUARIO, LOGIN, SENHA, NOMECOMPLETO, COALESCE(FLAGADMINISTRADOR,''Y'')FLAGADMINISTRADOR '+
           '  FROM USUARIO '+
           ' WHERE 1=1 '+Complemento;
       End;
      tpERPFuncionario:
       Begin
         CampoChave := 'IDFUNCIONARIO';
         CampoDisplay := 'NOMEFUNCIONARIO';
         NomeTabela := 'FUNCIONARIO';
         DescricaoCampoDisplay := 'Nome completo';
         DescricaoTabela := 'Funcionários';
         Versao20 := False;
         UsaMaxParaCodigo := True;
         DesconsiderarCampos := 'CARGO;USUARIO;NOMEDEPARTAMENTO';
         Select :=
            'SELECT F.IDFUNCIONARIO, F.CODIGO, F.NOMEFUNCIONARIO, F.IDCARGO,'+
            '       F.TELEFONE, F.CELULAR, F.OBS, F.FOTO, F.IDUSUARIO, F.SALARIO,'+
            '       C.NOME CARGO , U.LOGIN USUARIO, F.IDDEPARTAMENTO, D.NOMEDEPARTAMENTO, F.EMAIL'+
            '  FROM FUNCIONARIO F'+
            '  LEFT JOIN CARGO C'+
            '    ON (C.IDCARGO = F.IDCARGO)'+
            '  LEFT JOIN USUARIO U'+
            '    ON (U.IDUSUARIO = F.IDUSUARIO)'+
            '  LEFT JOIN DEPARTAMENTO D  '+
            '    ON (D.IDDEPARTAMENTO = F.IDDEPARTAMENTO)'+
            ' WHERE 1=1 '+Complemento;
       End;
       tpERPDepartamento:
        Begin
        CampoChave := 'IDDEPARTAMENTO';
        CampoDisplay := 'NOMEDEPARTAMENTO';
        NomeTabela := 'DEPARTAMENTO';
        DescricaoCampoDisplay := 'Descrição';
        DescricaoTabela := 'Departamento';
        Versao20 := True;
        Select :=
          'SELECT IDDEPARTAMENTO, NOMEDEPARTAMENTO, CODIGO'+
          '  FROM DEPARTAMENTO '+
          ' WHERE 1=1 '+Complemento;
        End;
       tpERPFornecedor:
       Begin
         CampoChave := 'IDFORNECEDOR';
         CampoDisplay := 'RAZAOSOCIAL';
         NomeTabela := 'FORNECEDOR';
         DescricaoCampoDisplay := 'Razão social';
         DescricaoTabela := 'Fornecedor';
         Select :=
            'SELECT IDFORNECEDOR, CODIGO, RAZAOSOCIAL,NOMEFANTASIA, CNPJ, CONTATO, '+
            '       TELEFONE, EMAIL, ENDERECO, NUMERO, CEP, BAIRRO, CIDADE, UF,'+
            '       DATACADASTRO,COMPLEMENTO,OBS '+
            '  FROM FORNECEDOR '+
            ' WHERE 1=1 '+Complemento;
       End;
       tpERPLocalizacao:
       Begin
        CampoChave := 'IDLOCALIZACAO';
        CampoDisplay := 'NOMELOCALIZACAO';
        NomeTabela := 'LOCALIZACAO';
        DescricaoCampoDisplay := 'Descrição';
        DescricaoTabela := 'Localização';
        Versao20 := True;
        Select :=
          'SELECT IDLOCALIZACAO, NOMELOCALIZACAO, CODIGO'+
          '  FROM LOCALIZACAO '+
          ' WHERE 1=1 '+Complemento;
        End;
       tpERPGrupo:
       Begin
        CampoChave := 'IDGRUPO';
        CampoDisplay := 'NOMEGRUPO';
        NomeTabela := 'GRUPO';
        DescricaoCampoDisplay := 'Descrição';
        DescricaoTabela := 'Grupo';
        Versao20 := True;
        Select :=
          'SELECT IDGRUPO, NOMEGRUPO, CODIGO'+
          '  FROM GRUPO '+
          ' WHERE 1=1 '+Complemento;
        End;
       tpERPLinha:
       Begin
        CampoChave := 'IDLINHA';
        CampoDisplay := 'NOMELINHA';
        NomeTabela := 'LINHA';
        DescricaoCampoDisplay := 'Descrição';
        DescricaoTabela := 'Linha';
        Versao20 := True;
        Select :=
          'SELECT IDLINHA, NOMELINHA, CODIGO'+
          '  FROM LINHA '+
          ' WHERE 1=1 '+Complemento;
        End;
      tpERPProduto:
       Begin
        CampoChave := 'IDPRODUTO';
        CampoDisplay := 'NOMEPRODUTO';
        NomeTabela := 'PRODUTO';
        DescricaoCampoDisplay := 'Descrição';
        DescricaoTabela := 'Produto';
        DesconsiderarCampos := 'NOMELINHA;NOMEGRUPO;RAZAOSOCIAL;NOMELOCALIZACAO;NOMEFABRICANTE;CODIGOMUNICIPALSERVICO;NCM;CODIGOSERVFEDERAL;DESCRICAOCODIGOSERVICO';
        Versao20 := False;
        UsaMaxParaCodigo := True;
        Select :=
          'SELECT P.IDPRODUTO, P.CODIGO, P.NOMEPRODUTO, P.DESCRICAODETALHADA, P.TIPOPRODUTO, P.IDGRUPO, P.IDLINHA, P.IDLOCALIZACAO,'+
          '       P.IMAGEMPRINCIPAL, P.OBS, P.IDNCM, P.IDCODIGOMUNICIPALSERVICO, CF.CODIGO CODIGOSERVFEDERAL, P.CUSTOATUAL, P.CUSTOMEDIO,'+
          '       P.CUSTOCONTABIL, P.ESTOQUEMINIMO, P.DATACADASTRO, P.FLAGSERIAL, P.FLAGLOTE, P.FLAGINATIVO, P.CODIGOBARRAS,'+
          '       P.IDFABRICANTE, P.IDFORNECEDOR, P.CST, P.CSOSN, P.IDUNIDADE, P.ORIGEM, P.PRECO, P.MARKUP,P.ESTOQUEATUAL,'+
          '       P.FATORMULTIPLICADOR,L.NOMELINHA,'+
          '       G.NOMEGRUPO, F.RAZAOSOCIAL, LO.NOMELOCALIZACAO, FA.NOMEFABRICANTE, C.CODIGO CODIGOMUNICIPALSERVICO,C.DESCRICAOCODIGOSERVICO, NCM.CODIGO NCM'+
          '  FROM PRODUTO P'+
          '  LEFT JOIN LINHA L'+
          '    ON (L.IDLINHA = P.IDLINHA)'+
          '  LEFT JOIN GRUPO G'+
          '    ON (G.IDGRUPO = P.IDGRUPO)'+
          '  LEFT JOIN FORNECEDOR F'+
          '    ON (F.IDFORNECEDOR = P.IDFORNECEDOR)'+
          '  LEFT JOIN LOCALIZACAO LO'+
          '    ON (LO.IDLOCALIZACAO = P.IDLOCALIZACAO )'+
          '  LEFT JOIN FABRICANTE FA'+
          '    ON (FA.IDFABRICANTE = P.IDFABRICANTE)'+
          '  LEFT JOIN UNIDADE U'+
          '    ON (U.IDUNIDADE = P.IDUNIDADE)'+
          '  LEFT JOIN CODIGOMUNICIPALSERVICO C '+
          '    ON (c.IDCODIGOMUNICIPALSERVICO  = P.IDCODIGOMUNICIPALSERVICO)  '+
          '  LEFT JOIN CODIGOMUNICIPALSERVICO CF '+
          '    ON (c.CODPAI  = CF.IDCODIGOMUNICIPALSERVICO)  '+
          '  LEFT JOIN NCM '+
          '    ON (NCM.IDNCM  = P.IDNCM)  '+
          ' WHERE 1=1 '+Complemento;
        End;
      tpERPFabricante:
       Begin
        CampoChave := 'IDFABRICANTE';
        CampoDisplay := 'NOMEFABRICANTE';
        NomeTabela := 'FABRICANTE';
        DescricaoCampoDisplay := 'Descrição';
        DescricaoTabela := 'Fabricante';
        Versao20 := True;
        Select :=
          'SELECT F.IDFABRICANTE, F.CODIGO, F.NOMEFABRICANTE '+
          '  FROM FABRICANTE F '+
          ' WHERE 1=1 '+Complemento;
        End;
       tpERPCodigoMunicipalServico:
       Begin
        CampoChave := 'IDCODIGOMUNICIPALSERVICO';
        CampoDisplay := 'DESCRICAOCODIGOSERVICO';
        NomeTabela := 'CODIGOMUNICIPALSERVICO';
        DescricaoCampoDisplay := 'Descrição';
        DescricaoTabela := 'Código municipal de serviço';
        Result.TipoForm := tfTree;
        Versao20 := True;
        Select :=
          'SELECT IDCODIGOMUNICIPALSERVICO, CODIGO, '+
          '       CAST(DESCRICAOCODIGOSERVICO AS VARCHAR(3000))DESCRICAOCODIGOSERVICO , CODPAI,'+
          '       CLASSIFICACAO, FLAGTIPO '+
          '  FROM CODIGOMUNICIPALSERVICO '+
          ' WHERE 1=1 '+Complemento;
        End;
       tpERPProcessosservico:
        Begin
          CampoChave := 'IDPROCESSODESERVICO';
          CampoDisplay := 'DESCRICAOPROCESSO';
          NomeTabela := 'PROCESSODESERVICO';
          DescricaoCampoDisplay := 'Descrição';
          DescricaoTabela := 'Processos de serviço';
          Versao20 := True;
          Select :=
            'SELECT IDPROCESSODESERVICO, CODIGO,DESCRICAOPROCESSO '+
            '  FROM PROCESSODESERVICO '+
            ' WHERE 1=1 '+Complemento;

        End;
        tpERPProdutoProcessosservico :
        Begin
          CampoChave := 'IDPRODUTOPROCESSODESERVICO';
          CampoDisplay := 'DESCRICAOPROCESSO';
          NomeTabela := 'PRODUTOPROCESSODESERVICO';
          DescricaoCampoDisplay := 'Processos do serviço';
          DescricaoTabela := 'Processos do serviço';
          DesconsiderarCampos :='DESCRICAOPROCESSO;CODIGO;FLAGEDICAO';
          Select :=
            'SELECT PS.IDPRODUTOPROCESSODESERVICO, PS.IDPRODUTO, '+
            '       PS.IDPROCESSODESERVICO,  P.DESCRICAOPROCESSO, P.CODIGO ,''N'' FLAGEDICAO'+
            '  FROM PRODUTOPROCESSODESERVICO PS '+
            ' INNER JOIN PROCESSODESERVICO P '+
            '    ON (P.IDPROCESSODESERVICO = PS.IDPROCESSODESERVICO) '+
            ' WHERE 1=1 '+Complemento;

        End;
        tpERPPeridicidade:
        begin
          CampoChave := 'IDPERIODICIDADE';
          CampoDisplay := 'DESCRICAOPERIODICIDADE';
          NomeTabela := 'PERIODICIDADE';
          DescricaoCampoDisplay := 'Nº de dias';
          DescricaoTabela := 'Periodicidade';
          CampoCodigo := 'NUMDIAS';
          Versao20 := False;
          Select :=
            'SELECT IDPERIODICIDADE, DESCRICAOPERIODICIDADE,NUMDIAS '+
            '  FROM PERIODICIDADE '+
            ' WHERE 1=1 '+Complemento;
        end;
        tpERPBanco:
        Begin
          CampoChave := 'IDBANCO';
          CampoDisplay := 'NOMEBANCO';
          NomeTabela := 'BANCO';
          DescricaoCampoDisplay := 'Nome';
          DescricaoTabela := 'Banco';
          Versao20 := True;
          Select :=
            'SELECT IDBANCO, CODIGO,NOMEBANCO '+
            '  FROM BANCO '+
            ' WHERE 1=1 '+Complemento;

        End;
        tpERPContaBancaria:
         Begin
          CampoChave := 'IDCONTABANCARIA';
          CampoDisplay := 'CONTA';
          NomeTabela := 'CONTABANCARIA';
          DescricaoCampoDisplay := 'Conta';
          DescricaoTabela := 'Conta bancária';
          Versao20 := False;
          CampoCodigo := 'AGENCIA' ;
          DesconsiderarCampos :='Banco';
          Select :=
            'SELECT IDCONTABANCARIA, C.IDBANCO,AGENCIA,CONTA,'+
            '       DVCONTA,DVAGENCIA,CARTEIRA,TIPOCONTA, B.CODIGO '+
            '  FROM CONTABANCARIA C'+
            ' INNER JOIN BANCO B '+
            '    ON (B.IDBANCO = C.IDBANCO) '+
            ' WHERE 1=1 '+Complemento;

        End;
      tpERPCondicaoPagamento:
         Begin
          CampoChave := 'IDCONDICAOPAGAMENTO';
          CampoDisplay := 'NOMECONDICAOPAGAMENTO';
          NomeTabela := 'CONDICAOPAGAMENTO';
          DescricaoCampoDisplay := 'Descerição';
          DescricaoTabela := 'Condição de pagamento';
          Versao20 := True;
          Select :=
            'SELECT CP.IDCONDICAOPAGAMENTO, CP.CODIGO, CP.NOMECONDICAOPAGAMENTO,   '+
            '       CP.FLAGTIPOPAGAMENTO, CP.MAXPARCELAS, CP.IDCONTABANCARIA,CP.VALORMINIMO '+
            '  FROM CONDICAOPAGAMENTO CP '+
            ' WHERE 1=1 '+Complemento;

        End;
      tpERPProposta:
        Begin
          CampoChave := 'IDPROPOSTA';
          CampoDisplay := '';
          NomeTabela := 'PROPOSTA';
          DescricaoCampoDisplay := '';
          DescricaoTabela := 'Propósta';
          Versao20 := False;
          CampoCodigo := '';
          DesconsiderarCampos := 'CODIGOCLIENTE;NOMECLIENTE;DESCPERIDOVIGENCIACONTRATO;'+
                                 'DESCPERIDOVISITACONTRATO;LOGIN;CODIGOEMPRESA;STATUSPROPOSTA_LEGENDA';
          Select :=
            'SELECT P.IDPROPOSTA, P.IDEMPRESA, P.NUMEROPROPOSTA, P.DATACRIACAO, P.DATA,'+
            '       P.IDCLIENTE, P.FINALIDADEPROPOSTA,P.VALORTOTALPROPOSTA,'+
            '       P.VALORDESCONTOTOTAL, P.VALORACRESCIMOTOTAL,P.ALIQDESCONTO,P.ALIQACRESCIMO,P.SUBTOTALPROPOSTA, '+
            '       P.IDPERIDOVIGENCIACONTRATO, P.IDPERIODICIDADEVISITACONTRATO,'+
            '       P.STATUSPROPOSTA, P.IDUSUARIO, P.OBS, P.DATAEXPIRA,P.HORACRIACAO,'+
            '       C.CODIGO CODIGOCLIENTE, C.NOMECLIENTE,'+
            '       PVC.DESCRICAOPERIODICIDADE DESCPERIDOVIGENCIACONTRATO,'+
            '       PC.DESCRICAOPERIODICIDADE  DESCPERIDOVISITACONTRATO,'+
            '       U.LOGIN,E.CODIGO CODIGOEMPRESA,'+
            '       CASE WHEN P.STATUSPROPOSTA  = ''A'' THEN ''Aberta'' '+
            '            WHEN P.STATUSPROPOSTA  = ''F'' THEN ''Fechada'' '+
            '            WHEN P.STATUSPROPOSTA  = ''C'' THEN ''Com contrato'' end STATUSPROPOSTA_LEGENDA '+
            '  FROM PROPOSTA P'+
            ' INNER JOIN EMPRESA E'+
            '    ON (E.IDEMPRESA = P.IDEMPRESA)'+
            ' INNER JOIN CLIENTE C'+
            '    ON (C.IDCLIENTE = P.IDCLIENTE)'+
            '  LEFT JOIN PERIODICIDADE PVC'+
            '    ON (PVC.IDPERIODICIDADE = P.IDPERIDOVIGENCIACONTRATO)'+
            '  LEFT JOIN PERIODICIDADE PC'+
            '    ON (PVC.IDPERIODICIDADE = P.IDPERIODICIDADEVISITACONTRATO)'+
            ' LEFT JOIN USUARIO U'+
            '   ON (U.IDUSUARIO = P.IDUSUARIO)'+
            ' WHERE 1=1 '+Complemento;
        End;
      tpERPItemProposta:
        Begin
          CampoChave := 'IDITEMPROPOSTA';
          CampoDisplay := '';
          NomeTabela := 'ITEMPROPOSTA';
          DescricaoCampoDisplay := '';
          DescricaoTabela := 'Propósta(Itens)';
          Versao20 := False;
          CampoCodigo := '';
          DesconsiderarCampos := 'UNIDADE;FLAGEDICAO;NOMEPRODUTO;CODIGO';
          Select :=
            'SELECT IP.IDITEMPROPOSTA, IP.IDPROPOSTA, IP.IDPRODUTO,'+
            '       IP.QUANTIDADE, IP.VALORUNITARIO, IP.SUBTOTAL, IP.VALORDESCONTO,'+
            '       IP.VALORACRESCIMO,IP.ALIQDESCONTO,IP.OBS,IP.IDCLIENTEEQUIPAMENTOS,'+
            '       IP.ALIQACRESCIMO, IP.VALORTOTAL, U.CODIGO UNIDADE,''N'' FLAGEDICAO, '+
            '       P.NOMEPRODUTO, P.CODIGO'+
            '  FROM ITEMPROPOSTA IP'+
            '  INNER JOIN PRODUTO P'+
            '     ON (P.IDPRODUTO = IP.IDPRODUTO)'+
            '   LEFT JOIN UNIDADE U'+
            '     ON (U.IDUNIDADE = P.IDUNIDADE)'+
            ' WHERE 1=1 '+Complemento;
        End;
       tpERPCondicaoPagamentoProposta:
        Begin
          CampoChave := 'IDCONDICAOPAGAMENTOPROPOSTA';
          CampoDisplay := '';
          NomeTabela := 'CONDICAOPAGAMENTOPROPOSTA';
          DescricaoCampoDisplay := '';
          DescricaoTabela := 'Propósta(Pagamentos)';
          Versao20 := False;
          CampoCodigo := '';
          DesconsiderarCampos := 'CODIGO;FLAGEDICAO;NOMECONDICAOPAGAMENTO';
          Select :=
            '  SELECT CPP.IDCONDICAOPAGAMENTOPROPOSTA, CPP.IDCONDICAOPAGAMENTO,'+
            '         CPP.IDPROPOSTA, CPP.VALOR, CPP.NUMTOTALPARCELAS,'+
            '         C.CODIGO, C.NOMECONDICAOPAGAMENTO,''N'' FLAGEDICAO '+
            '    FROM CONDICAOPAGAMENTOPROPOSTA CPP'+
            '   INNER JOIN CONDICAOPAGAMENTO C'+
            '      ON (C.IDCONDICAOPAGAMENTO = CPP.IDCONDICAOPAGAMENTO)'+
            ' WHERE 1=1 '+Complemento;
        End;
       tpERPParcelaCondicaoPagamentoProposta:
       begin
          CampoChave := 'IDPARCONDPAGAMENTOPROPOSTA';
          CampoDisplay := '';
          NomeTabela := 'PARCCONDPAGAMENTOPROPOSTA';
          DescricaoCampoDisplay := '';
          DescricaoTabela := 'Parcela das condições de pagamento da proposta';
          Versao20 := False;
          CampoCodigo := '';
           DesconsiderarCampos := 'FLAGEDICAO';
          Select :=
            'SELECT IDPARCONDPAGAMENTOPROPOSTA, IDCONDICAOPAGAMENTOPROPOSTA, NUMPARCELA,'+
            '       VALORPARCELA,''N'' FLAGEDICAO '+
            '  FROM PARCCONDPAGAMENTOPROPOSTA '+
            ' WHERE 1=1 '+Complemento;
        End;
       tpERPTipoContrato:
       begin
          CampoChave := 'IDTIPOCONTRATO';
          CampoDisplay := 'NOMETIPOCONTRATO';
          NomeTabela := 'TIPOCONTRATO';
          DescricaoCampoDisplay := 'Descrição';
          DescricaoTabela := 'Tipo de contrato';
          Versao20 := False;
          UsaMaxParaCodigo := True;
          Select :=
            'SELECT IDTIPOCONTRATO, CODIGO, NOMETIPOCONTRATO, '+
            '       IDLAYOUT, ALIQMULTAQUEBRA, FLAGREGRAQUEBRA,FLAGRENOVARAUTOMATICO '+
            '  FROM TIPOCONTRATO'+
            ' WHERE 1=1 '+Complemento;
       end;
       tpERPContrato:
       begin
          CampoChave := 'IDCONTRATO';
          CampoDisplay := '';
          NomeTabela := 'CONTRATO';
          DescricaoCampoDisplay := '';
          DescricaoTabela := 'Contrato';
          CampoCodigo := '';
          Versao20 := False;
          UsaMaxParaCodigo := True;
          DesconsiderarCampos := 'NOMECLIENTE;CODIGO_EMPRESA;LOGIN;NOMECONDICAOPAGAMENTO;FLAGSTATUS_LEGENDA';
          Select :=
            ' SELECT C.IDCONTRATO, C.NUMEROCONTRATO, C.IDEMPRESA, C.DATAGERACAO,'+
            '        C.DATA, C.DATATERMINO,C.IDPROPOSTA,C.DIAPAGAMENTO,'+
            '        C.FLAGINDETERMINADO, C.IDCLIENTE, C.IDPERIODICIDADEVISITA, C.IDCONDICAOPAGAMENTO,'+
            '        C.IDTIPOCONTRATO, C.DATACANCELADO, C.FLAGSTATUS,C.OBS,'+
            '        C.VALORTOTAL, C.IDUSUARIO,C.IDPERIODICIDADEVIGENCIA,CL.NOMECLIENTE,'+
            '        E.CODIGO CODIGO_EMPRESA,  U.LOGIN,CP.NOMECONDICAOPAGAMENTO,'+
            '        CASE WHEN C.FLAGSTATUS = ''A'' THEN ''Ativo''  '+
            '             WHEN C.FLAGSTATUS = ''I'' THEN ''Inativo''  '+
            '             WHEN C.FLAGSTATUS = ''C'' THEN ''Cancelado''  END FLAGSTATUS_LEGENDA'+
            '   FROM CONTRATO C'+
            '  INNER JOIN CLIENTE CL'+
            '     ON (CL.IDCLIENTE = C.IDCLIENTE)'+
            '  INNER JOIN EMPRESA E'+
            '     ON (E.IDEMPRESA = C.IDEMPRESA)'+
            '  INNER JOIN CONDICAOPAGAMENTO CP'+
            '     ON (CP.IDCONDICAOPAGAMENTO=C.IDCONDICAOPAGAMENTO)'+
            '   LEFT JOIN USUARIO U'+
            '     ON (U.IDUSUARIO = C.IDUSUARIO)'+
            ' WHERE 1=1 '+Complemento;
       end;
       tpERPServicoContrato:
       begin
          CampoChave := 'IDCONTRATOPRODUTOS';
          CampoDisplay := '';
          NomeTabela := 'CONTRATOPRODUTOS';
          DescricaoCampoDisplay := '';
          DescricaoTabela := 'Serviços do Contrato';
          CampoCodigo := '';
          Versao20 := False;
          UsaMaxParaCodigo := True;
          DesconsiderarCampos := 'CODIGO;NOMEPRODUTO;FLAGEDICAO;QUANTIDADE;IDENTIFICADOR;DESCRICAOEQUIPAMENTO';
          Select :=
            'SELECT CP.IDCONTRATOPRODUTOS, CP.IDCONTRATO, CP.IDPRODUTO, '+
            '       CP.VALORUNITARIO, CP.VALORDESCONTO, CP.VALORACRESCIMO, '+
            '       CP.VALORTOTAL, CP.OBS, CP.ALIQDESCONTO, CP.ALIQACRESCIMO, CP.IDEQUIPAMENTOCLIENTE,'+
            '       CP.SUBTOTAL,P.CODIGO, P.NOMEPRODUTO,''N'' FLAGEDICAO, CAST(1 AS VALOR) QUANTIDADE,CE.IDENTIFICADOR,CE.DESCRICAOEQUIPAMENTO '+
            '  FROM CONTRATOPRODUTOS CP '+
            ' INNER JOIN PRODUTO P '+
            '    ON (P.IDPRODUTO = CP.IDPRODUTO) '+
            '  LEFT JOIN CLIENTEEQUIPAMENTOS CE'+
            '    ON (CE.IDCLIENTEEQUIPAMENTOS = CP.IDEQUIPAMENTOCLIENTE)'+
            ' WHERE 1=1 '+Complemento;
       end;
      tpERPClienteEquipamento:
       Begin
          CampoChave := 'IDCLIENTEEQUIPAMENTOS';
          CampoDisplay := 'DESCRICAOEQUIPAMENTO';
          NomeTabela := 'CLIENTEEQUIPAMENTOS';
          DescricaoCampoDisplay := 'Descrição';
          DescricaoTabela := 'Equipamentos do cliente';
          CampoCodigo := 'IDENTIFICADOR';
          Versao20 := True;
          UsaMaxParaCodigo := True;
          DesconsiderarCampos := 'FLAGEDICAO';
          Select :=
           ' SELECT CE.IDCLIENTEEQUIPAMENTOS, CE.IDCLIENTE, '+
           '        CE.DESCRICAOEQUIPAMENTO, CE.DESCRICAOCOMPLETA, '+
           '        CE.IDENTIFICADOR, CE.IDPRODUTO,''N'' FLAGEDICAO'+
           '   FROM CLIENTEEQUIPAMENTOS CE    '+
            ' WHERE 1=1 '+Complemento;
       End;
       {tpERPClienteEquipamentoContrato:
       Begin
          CampoChave := 'IDCONTRATOEQUIPAMENTOCLIENTE';
          CampoDisplay := '';
          NomeTabela := 'CONTRATOEQUIPAMENTOCLIENTE';
          DescricaoCampoDisplay := '';
          DescricaoTabela := 'Equipamentos do cliente no contrato';
          CampoCodigo := '';
          Versao20 := False;
          UsaMaxParaCodigo := True;
          DesconsiderarCampos := 'DESCRICAOEQUIPAMENTO;IDENTIFICADOR;DESCRICAOPERIODICIDADE;FLAGEDICAO;IDPRODUTO';
          Select :=
            '  SELECT CEC.IDCONTRATOEQUIPAMENTOCLIENTE,'+
            '         CEC.IDCLIENTEEQUIPAMENTOS, CEC.IDPERIODICIADEVISITA,'+
            '         CEC.IDCONTRATO, CE.DESCRICAOEQUIPAMENTO, CE.IDENTIFICADOR,'+
            '         P.DESCRICAOPERIODICIDADE,''N'' FLAGEDICAO,CE.IDPRODUTO'+
            '    FROM CONTRATOEQUIPAMENTOCLIENTE CEC'+
            '   INNER JOIN CLIENTEEQUIPAMENTOS CE'+
            '      ON (CE.IDCLIENTEEQUIPAMENTOS = CEC.IDCLIENTEEQUIPAMENTOS)'+
            '    LEFT JOIN PERIODICIDADE P'+
            '      ON (P.IDPERIODICIDADE = CEC.IDPERIODICIADEVISITA)'+
            '   WHERE 1=1 '+Complemento;
       End;}
       tpERPTipoOS:
       begin
          CampoChave := 'IDTIPOOS';
          CampoDisplay := 'NOMETIPOOS';
          NomeTabela := 'TIPOOS';
          DescricaoCampoDisplay := 'Descrição';
          DescricaoTabela := 'Tipo de O.S.';
          Versao20 := True;
          UsaMaxParaCodigo := True;
          Select :=
            'SELECT IDTIPOOS, CODIGO, NOMETIPOOS,IDLAYOUT, FLAGTIPOMOVIMENTO '+
            '  FROM TIPOOS'+
            ' WHERE 1=1 '+Complemento;
       end;
       tpERPStatusOS:
       begin
          CampoChave := 'IDSTATUSOS';
          CampoDisplay := 'NOMESTATUSOS';
          NomeTabela := 'STATUSOS';
          DescricaoCampoDisplay := 'Descrição';
          DescricaoTabela := 'Status de O.S.';
          Versao20 := True;
          UsaMaxParaCodigo := True;
          Select :=
            'SELECT IDSTATUSOS, CODIGO, NOMESTATUSOS,COR '+
            '  FROM STATUSOS'+
            ' WHERE 1=1 '+Complemento;
       end;
       tpERPOS:
       begin
          CampoChave := 'IDOS';
          CampoDisplay := '';
          NomeTabela := 'OS';
          DescricaoCampoDisplay := '';
          DescricaoTabela := 'O.S.';
          Versao20 := False;
          CampoCodigo := '';
          DesconsiderarCampos := 'CODIGOCLIENTE;NOMECLIENTE;NOMETIPOOS;NOMESTATUSOS;NUMEROCONTRATO;COR';
          Select :=
            ' SELECT O.IDOS, O.NUMEROOS, O.DATAGERACAO,'+
            '        O.IDUSUARIO, O.IDEMPRESA, O.DATA, O.HORA, O.IDCLIENTE,'+
            '        O.IDTIPOOS,O.IDSTATUSOS, O.VALORTOTAL, O.OBS,O.FLAGBAIXADA,'+
            '        O.DATAINICIO,O.HORAINICIO, O.DATATERMINO, O.HORATERMINO ,O.IDAGENDA, '+
            '        O.IDCONTRATOCOMPETENCIA ,O.IDPROPOSTA, O.FLAGFATURADA, C.CODIGO CODIGOCLIENTE,'+
            '        C.NOMECLIENTE, T.NOMETIPOOS,S.NOMESTATUSOS,S.COR,'+
            '        CO.NUMEROCONTRATO'+
            '   FROM OS O'+
            '  INNER JOIN CLIENTE C'+
            '     ON (C.IDCLIENTE = O.IDCLIENTE)'+
            '  INNER JOIN TIPOOS T'+
            '     ON (T.IDTIPOOS = O.IDTIPOOS)'+
            '   LEFT JOIN STATUSOS S'+
            '     ON (S.IDSTATUSOS = O.IDSTATUSOS)'+
            '   LEFT JOIN CONTRATOCOMPETENCIA CC'+
            '     ON (CC.IDCONTRATOCOMPETENCIA = O.IDCONTRATOCOMPETENCIA)'+
            '   LEFT JOIN CONTRATO CO'+
            '     ON (CO.IDCONTRATO = CC.IDCONTRATO)'+
            '  WHERE 1=1 '+Complemento;
       end;
       tpERPEquipamentoOS:
       begin
          CampoChave := 'IDEQUIPAMENTOSOS';
          CampoDisplay := '';
          NomeTabela := 'EQUIPAMENTOSOS';
          DescricaoCampoDisplay := '';
          DescricaoTabela := 'Equipamentos da O.S.';
          Versao20 := False;
          CampoCodigo := '';
          DesconsiderarCampos := 'DESCRICAOEQUIPAMENTO;IDENTIFICADOR;FLAGEDICAO';
          Select :=
            '  SELECT E.IDEQUIPAMENTOSOS, E.IDEQUIPAMENTOCLIENTE,'+
            '         E.IDOS, E.DETALHEDEFEITO,'+
            '         E.VALORTOTALEQUIPAMENTO,E.SOLUCAO,E.IDFUNCIONARIOSOLUCAO,E.CONTADORPATRIMONIO,'+
            '         E.IDPATRIMONIO, '+
            '         COALESCE(C.DESCRICAOEQUIPAMENTO,P.NOMEPATRIMONIO)DESCRICAOEQUIPAMENTO, '+
            '         COALESCE(C.IDENTIFICADOR,P.SERIAL) IDENTIFICADOR, ''N'' FLAGEDICAO '+
            '    FROM EQUIPAMENTOSOS E'+
            '    LEFT JOIN CLIENTEEQUIPAMENTOS C'+
            '      ON (C.IDCLIENTEEQUIPAMENTOS = E.IDEQUIPAMENTOCLIENTE)'+
            '    LEFT JOIN PATRIMONIO P '+
            '      ON (P.IDPATRIMONIO  = E.IDPATRIMONIO) '+
            '   WHERE 1=1 '+Complemento;

       end;
       tpERPServicoEquipamentoOS :
       begin
          CampoChave := 'IDSERVICOOS';
          CampoDisplay := '';
          NomeTabela := 'SERVICOOS';
          DescricaoCampoDisplay := '';
          DescricaoTabela := 'Serviços do Equipamentos da O.S.';
          Versao20 := False;
          CampoCodigo := '';
          DesconsiderarCampos := 'CODIGOSERVICO;DESCRICAOSERVICO;NOMEFUNCIONARIO;FLAGEDICAO';
          Select :=
            'SELECT S.IDSERVICOOS, S.IDEQUIPAMENTOSOS, S.IDPRODUTO, S.VALORSERVICO,S.IDTIPOEVENTOPATRIMONIO,'+
            '       S.VALORTOTALPRODUTOS, S.VALORTOTAL,S.OBS,S.DATAINICIO,S.HORAINICIO, S.DATATERMINO, S.HORATERMINO , '+
            '       S.IDFUNCIONARIO,S.IDALMOXARIFADO, P.CODIGO CODIGOSERVICO, P.NOMEPRODUTO DESCRICAOSERVICO,'+
            '       F.NOMEFUNCIONARIO,''N'' FLAGEDICAO '+
            '  FROM SERVICOOS S'+
            ' INNER JOIN PRODUTO P'+
            '    ON (P.IDPRODUTO = S.IDPRODUTO)'+
            '  LEFT JOIN FUNCIONARIO F'+
            '    ON (F.IDFUNCIONARIO = S.IDFUNCIONARIO)'+
            '   WHERE 1=1 '+Complemento;

       end;
      tpERPProdutoServicoOS:
        begin
          CampoChave := 'IDPRODUTOSSERVICOOS';
          CampoDisplay := '';
          NomeTabela := 'PRODUTOSSERVICOOS';
          DescricaoCampoDisplay := '';
          DescricaoTabela := 'Produto dos Serviços da O.S.';
          Versao20 := False;
          CampoCodigo := '';
          DesconsiderarCampos := 'CODIGO;DESCRICAO;FLAGEDICAO;IDUNIDADE;'+
                                 'IDNCM;CST;CSOSN;CUSTOMEDIO;CUSTOATUAL;CUSTOCONTABIL;CODIGOBARRAS';
          Select :=
            'SELECT PS.IDPRODUTOSSERVICOOS, PS.IDSERVICOOS,'+
            '       PS.IDPRODUTO,PS.IDCOR, PS.IDTAMANHO, PS.QUANTIDADE, PS.VALORUNITARIO, PS.TOTAL,'+
            '       P.CODIGO, P.NOMEPRODUTO DESCRICAO,''N'' FLAGEDICAO, PS.IDALMOXARIFADO,'+
            '       P.IDUNIDADE,P.IDNCM,P.CST,P.CSOSN,P.CUSTOMEDIO, P.CUSTOATUAL, P.CUSTOCONTABIL, P.CODIGOBARRAS'+
            '  FROM PRODUTOSSERVICOOS PS'+
            ' INNER JOIN PRODUTO P'+
            '    ON (P.IDPRODUTO = PS.IDPRODUTO)'+
            '   WHERE 1=1 '+Complemento;

       end;
      tpERPEntrada:
        begin
          CampoChave := 'IDENTRADA';
          CampoDisplay := 'NUMERONOTA';
          NomeTabela := 'ENTRADA';
          DescricaoCampoDisplay := '';
          DescricaoTabela := 'Entrada de Produtos ';
          Versao20 := False;
          CampoCodigo := 'NUMERONOTA';
          DesconsiderarCampos := 'NOMEOPERACAOESTOQUE;PESSOA;TIPOPESSOA;LOGIN;IDCFOP;CODIGOEMPRESA;ESTACANCELADA;DESCTIPOPESSOA';
          Select :=
            'SELECT IDENTRADA,DATA,IDOPERACAOESTOQUE,IDFORNECEDOR,NUMERONOTA,SERIE,MODELO,'+
            '       VALORTOTALPRODUTOS,BASEICMS,VALORICMS,BASEIPI,VALORIPI,BASEST,'+
            '       VALORST,VALORSEGURO,VALORFRETE,VALOROUTRAS,VALORTOTALNOTA,'+
            '       FLAGCANCELADA,OBS,VALORDESCONTO,IDEMPRESA,'+
            '       FRETEPORCONTA,IDUSUARIO,DATACRIACAO,IDCLIENTE,'+
            '       NOMEOPERACAOESTOQUE,PESSOA,TIPOPESSOA,LOGIN,'+
            '       IDCFOP,CODIGOEMPRESA,ESTACANCELADA,DESCTIPOPESSOA,TIPOTRANSPORTE'+
            ' FROM ('+
            '        SELECT E.IDENTRADA, E.DATA, E.IDOPERACAOESTOQUE, E.IDFORNECEDOR,'+
            '               E.NUMERONOTA, E.SERIE, E.MODELO, E.VALORTOTALPRODUTOS,'+
            '               E.BASEICMS, E.VALORICMS, E.BASEIPI, E.VALORIPI, E.BASEST,'+
            '               E.VALORST, E.VALORSEGURO, E.VALORFRETE, E.VALOROUTRAS,'+
            '               E.VALORTOTALNOTA, E.FLAGCANCELADA, E.OBS, E.VALORDESCONTO,'+
            '               E.IDEMPRESA, E.FRETEPORCONTA, E.IDUSUARIO,'+
            '               E.DATACRIACAO, E.IDCLIENTE,E.TIPOTRANSPORTE,'+
            '               O.NOMEOPERACAOESTOQUE,'+
            '               COALESCE(F.RAZAOSOCIAL,C.NOMECLIENTE) PESSOA,'+
            '               CASE WHEN E.IDFORNECEDOR IS NULL THEN ''C'' ELSE ''F'' END TIPOPESSOA,'+
            '               CASE WHEN E.IDFORNECEDOR IS NULL THEN ''Cliente'' ELSE ''Fornecedor'' END DESCTIPOPESSOA,'+
            '               U.LOGIN,CAST(NULL AS CHAVE) IDCFOP,EP.CODIGO CODIGOEMPRESA,'+
            '               CASE WHEN COALESCE(E.FLAGCANCELADA,''N'') = ''Y'' THEN ''SIM'' ELSE ''NÃO'' END ESTACANCELADA '+
            '          FROM ENTRADA E'+
            '         INNER JOIN EMPRESA EP'+
            '            ON (E.IDEMPRESA = EP.IDEMPRESA)'+
            '         INNER JOIN OPERACAOESTOQUE O'+
            '            ON (O.IDOPERACAOESTOQUE = E.IDOPERACAOESTOQUE)'+
            '          LEFT JOIN FORNECEDOR F'+
            '            ON (F.IDFORNECEDOR = E.IDFORNECEDOR)'+
            '          LEFT JOIN CLIENTE C'+
            '            ON (C.IDCLIENTE = E.IDCLIENTE)'+
            '          LEFT JOIN USUARIO U'+
            '            ON (U.IDUSUARIO = E.IDUSUARIO))X'+
            ' WHERE 1=1 '+Complemento;

       end;
      tpERPEntradaProduto:
        begin
          CampoChave := 'IDENTRADAPRODUTO';
          CampoDisplay := '';
          NomeTabela := 'ENTRADAPRODUTO';
          DescricaoCampoDisplay := '';
          DescricaoTabela := 'Entrada de Produtos(Itens) ';
          Versao20 := False;
          CampoCodigo := '';
          DesconsiderarCampos := 'CODIGO_PRODUTO;NOME_PRODUTO;CFOP;UNIDADE;UNIDADE_COMPRA;CODIGOPRODUTOFORNECEDOR;FLAGEDICAO;CFOPENTRADA;NOMEALMOXARIFADO';
          Select :=
            'SELECT EP.IDENTRADAPRODUTO, EP.IDENTRADA, EP.IDCFOP, EP.IDPRODUTO,'+
            '       EP.QUANTIDADE, EP.VALORUNITARIO, EP.VALORACRESCIMO,'+
            '       EP.VALORDESCONTO, EP.BASEICMS, EP.ALIQICMS, EP.VALORICMS,'+
            '       EP.ALIQIPI, EP.VALORIPI, EP.VALORTOTAL,'+
            '       EP.VALORTOTALBRUTO, EP.STITUACAOTRIBUTARIA, EP.VALORFRETERATEADO,'+
            '       EP.VALORSEGURORATEADO, EP.VALOROUTROSRATEADO,'+
            '       EP.IDUNIDADE, EP.NUMITEM, EP.VALORST, EP.BASEST, EP.MVA,'+
            '       EP.REDUCAOBASE, EP.IDUNIDADECOMPRA,EP.CST,EP.IDCFOPENTRADA,EP.IDALMOXARIFADO,'+
            '       EP.FATORMULTIPLICADOR, EP.QUANTIDADERECEBIDA,EP.IDPATRIMONIO,EP.CONTADORPATRIMONIO,COALESCE(P.CODIGO,PT.CODIGO) CODIGO_PRODUTO,'+
            '       COALESCE(P.NOMEPRODUTO,PT.NOMEPATRIMONIO) NOME_PRODUTO,C.CFOP,CE.CFOP CFOPENTRADA,U.CODIGO UNIDADE,UC.CODIGO UNIDADE_COMPRA,'+
            '       PF.CODIGOPRODUTO CODIGOPRODUTOFORNECEDOR,''N'' FLAGEDICAO, A.NOMEALMOXARIFADO, '+
            '        CASE WHEN P.CODIGO IS NULL THEN ''P'' '+
            '             WHEN P.TIPOPRODUTO = '+QuotedStr(TipoProdutoServico)+' THEN ''S'' ELSE ''I'' END TIPO_ITEM '+
            '  FROM ENTRADA E '+
            ' INNER JOIN ENTRADAPRODUTO EP '+
            '    ON (EP.IDENTRADA = E.IDENTRADA)'+
            '  LEFT JOIN PRODUTO P'+
            '    ON (P.IDPRODUTO = EP.IDPRODUTO)'+
            '  LEFT JOIN CFOP C'+
            '    ON (C.IDCFOP = EP.IDCFOP)'+
            '  LEFT JOIN CFOP CE'+
            '    ON (CE.IDCFOP = EP.IDCFOPENTRADA)'+
            '  LEFT JOIN UNIDADE U'+
            '    ON (U.IDUNIDADE = EP.IDUNIDADE)'+
            '  LEFT JOIN UNIDADE UC'+
            '    ON (UC.IDUNIDADE = EP.IDUNIDADECOMPRA)'+
            '  LEFT JOIN ALMOXARIFADO A '+
            '    ON (A.IDALMOXARIFADO = EP.IDALMOXARIFADO)'+
            '  LEFT JOIN PRODUTOFORNECEDOR PF '+
            '    ON (PF.IDPRODUTO = P.IDPRODUTO AND PF.IDFORNECEDOR = E.IDFORNECEDOR) '+
            '  LEFT JOIN PATRIMONIO PT '+
            '    ON (PT.IDPATRIMONIO = EP.IDPATRIMONIO) '+
            ' WHERE 1=1 '+Complemento;

       end;
     tpERPModeloNota:
        begin
          CampoChave := 'MODELO';
          CampoDisplay := 'DESCRICAO';
          NomeTabela := 'VW_MODELONOTA';
          DescricaoCampoDisplay := 'Descrição';
          DescricaoTabela := 'Modelo de notas ';
          Versao20 := True;
          CampoCodigo := 'MODELO';
          DesconsiderarCampos := '';
          Select :=
            ' SELECT MODELO, DESCRICAO '+
            '   FROM VW_MODELONOTA'+
            '  WHERE 1=1 '+Complemento;

       end;
      tpERPOperacao,tpERPOperacaoEntrada,tpERPOperacaoSaida:
        begin
          CampoChave := 'IDOPERACAOESTOQUE';
          CampoDisplay := 'NOMEOPERACAOESTOQUE';
          NomeTabela := 'OPERACAOESTOQUE';
          DescricaoCampoDisplay := 'Operação';
          DescricaoTabela := 'Operação de estoque ';
          Versao20 := False;
//          CampoCodigo := '';
          DesconsiderarCampos := '';
          UsaMaxParaCodigo:= True;
          Select :=
            ' SELECT IDOPERACAOESTOQUE, CODIGO, NOMEOPERACAOESTOQUE, '+
            '        FLAGTIPOOPERACAO, FLAGVENDA, FLAGTIPOPESSOA, FLAGGERAFINANCEIRO, '+
            '        FLAGMOVIMENTAESTOQUE,FLAGDOCUMENTO,FLAGMOVPATRIMONIO,FLAGCONTABILIZARECEITABRUTA '+
            '   FROM OPERACAOESTOQUE'+
            '  WHERE  '+IfThen(TipoPesquisa = tpERPOperacaoEntrada,' FLAGTIPOOPERACAO =''E'' ',
                                 IfThen(TipoPesquisa = tpERPOperacaoSaida,' FLAGTIPOOPERACAO =''S'' ', ' 1=1 '))+   Complemento;

       end;
       tpERPSerialProduto,tpERPSerialProdutoAtivo:
       begin
          CampoChave := 'IDSERIALPRODUTO';
          CampoDisplay := '';
          NomeTabela := 'SERIALPRODUTO';
          DescricaoCampoDisplay := '';
          DescricaoTabela := 'Seriais do produto ';
          Versao20 := False;
          CampoCodigo := '';
          DesconsiderarCampos := 'FLAGEDICAO';
          Select :=
            'SELECT IDSERIALPRODUTO, IDPRODUTO, '+
            '       IDEMPRESA, SERIAL, DATAENTRADA, DATASAIDA, FLAGATIVO,''N'' FLAGEDICAO '+
            '  FROM SERIALPRODUTO '+
            '  WHERE '+IfThen(TipoPesquisa = tpERPSerialProdutoAtivo,' COALESCE(FLAGATIVO,''N'') = ''Y'' ',' 1=1 ')+Complemento;
       end;
       tpERPSerialProdutoEntrada:
       begin
          CampoChave := 'IDENTRADAPRODUTOSERIAL';
          CampoDisplay := '';
          NomeTabela := 'ENTRADAPRODUTOSERIAL';
          DescricaoCampoDisplay := '';
          DescricaoTabela := 'Seriais do produto(Entrada) ';
          Versao20 := False;
          CampoCodigo := '';
          DesconsiderarCampos := 'FLAGEDICAO';
          Select :=
            'SELECT ES.IDENTRADAPRODUTOSERIAL, ES.IDENTRADAPRODUTO, ES.IDSERIALPRODUTO, '+
            '       P.CODIGO, P.NOMEPRODUTO,SP.SERIAL, SP.IDEMPRESA, SP.DATAENTRADA,''N'' FLAGEDICAO'+
            '  FROM ENTRADAPRODUTOSERIAL ES '+
            ' INNER JOIN SERIALPRODUTO SP '+
            '    ON (SP.IDSERIALPRODUTO = ES.IDSERIALPRODUTO) '+
            ' INNER JOIN PRODUTO P '+
            '    ON (P.IDPRODUTO = SP.IDPRODUTO) '+
            '  WHERE 1=1 '+Complemento;
       end;
       tpERPSerialProdutoOS:
       begin
          CampoChave := 'IDSERIALPRODUTOOS';
          CampoDisplay := '';
          NomeTabela := 'SERIALPRODUTOOS';
          DescricaoCampoDisplay := '';
          DescricaoTabela := 'Seriais do produto(OS) ';
          Versao20 := False;
          CampoCodigo := '';
          DesconsiderarCampos := 'SERIAL;IDSERVICOOS;FLAGEDICAO';
          Select :=
            'SELECT SO.IDSERIALPRODUTOOS, SO.IDPRODUTOSSERVICOOS, SO.IDSERIALPRODUTO,'+
            '       SE.SERIAL,S.IDSERVICOOS,''N'' FLAGEDICAO'+
            '  FROM SERIALPRODUTOOS SO'+
            ' INNER JOIN PRODUTOSSERVICOOS PS'+
            '    ON (PS.IDPRODUTOSSERVICOOS = SO.IDPRODUTOSSERVICOOS)'+
            ' INNER JOIN SERVICOOS S'+
            '    ON (S.IDSERVICOOS = PS.IDSERVICOOS)'+
            ' INNER JOIN EQUIPAMENTOSOS E'+
            '    ON (E.IDEQUIPAMENTOSOS = S.IDEQUIPAMENTOSOS)'+
            ' INNER JOIN OS'+
            '    ON (OS.IDOS = E.IDOS)'+
            ' INNER JOIN SERIALPRODUTO SE'+
            '    ON (SE.IDSERIALPRODUTO = SO.IDSERIALPRODUTO AND'+
            '        SE.IDEMPRESA = OS.IDEMPRESA   )'+
            '  WHERE 1=1 '+Complemento;

       end;
       tpERPSaida:
       begin
        CampoChave := 'IDSAIDA';
        CampoDisplay := 'PESSOA';
        NomeTabela := 'SAIDA';
        DescricaoCampoDisplay := '';
        DescricaoTabela := 'Saída de produto';
        Versao20 := False;
        CampoCodigo := 'NUMEROSAIDA';
        DesconsiderarCampos := 'NOMEOPERACAOESTOQUE;CODIGO_PESSOA;PESSOA;'+
                               'UF_PESSOA;TRANSPORTADORA;USUARIO;NOMEFUNCIONARIO;'+
                               'STATUS_NOTA;CODIGO_EMPRRESA;RAZAOSOCIAL;SERIENFSE;SERIENFE';
        Select :=
          ' SELECT S.IDSAIDA, S.DATACRIACAO, S.HORA, S.DATA, S.IDOPERACAOESTOQUE, S.IDEMPRESA, S.IDCLIENTE, S.IDOS, '+
          '        S.DATASAIDA, S.HORASAIDA, S.IDTRANSPORTADORA, S.PLACAVEICULO, S.UFPLACAVEICULO, S.FLAGFINALIDADE,'+
          '        S.OBS, S.PESOLIQ, S.PESOBRUTO, S.VOLUME, S.ESPECIE, S.FLAGMODALIDADEFRETE, S.VALORFRETE, S.VALORDESCONTOTOTAL,'+
          '        S.VALORACRESCIMOTOTAL, S.VALORTOTALPRODUTOS, S.VALORTOTALSERVICOS, S.VALORSEGURO, S.VALOROUTRASDESPESAS,'+
          '        S.BASECALCULOICMS, S.BASECALCULOIPI,  S.BASECALCULOPISCOFINS, S.BASECALCULOICMSST,S.IDSERIENFE, S.IDSERIENFSE,'+
          '        S.BASECALCULOISS, S.BASECSLL, S.VALORICMS, S.VALORIPI, S.VALORST, S.VALORPIS, S.VALORCOFINS, S.VALORTOTALNOTA,'+
          '        S.VALORICMSST, S.VALORISS, S.VAORPISSERVICO, S.VAORCOFINSSERVICO, S.VALORCSLL, S.CHAVEACESSO, S.FLAGCANCELADA,'+
          '        S.JUSTIFICATIVACANCELAMENTO, S.IDUSUARIO, S.IDUSUARIOCANCELAMENTO, S.DATACANCELAMENTO, S.HORACANCELAMENTO, '+
          '        S.IDPROPOSTA,S.FLAGVENDA, S.ALIQACRESCIMO,S.ALIQDESCONTO,S.IDFUNCIONARIO,S.NUMEROSAIDA,COALESCE(S.TIPOTRANSPORTE,7)TIPOTRANSPORTE, '+
          '        O.NOMEOPERACAOESTOQUE,COALESCE(C.CODIGO, F.CODIGO) CODIGO_PESSOA,'+
          '        COALESCE( C.NOMECLIENTE, F.RAZAOSOCIAL) PESSOA,COALESCE( C.UF, F.UF) UF_PESSOA, T.RAZAOSOCIAL TRANSPORTADORA ,'+
          '        U.LOGIN USUARIO,FU.NOMEFUNCIONARIO,NFE.SERIE SERIENFE,NFSE.SERIE SERIENFSE,'+
          '        CASE WHEN COALESCE(S.FLAGCANCELADA,''N'' )= ''N'' THEN ''NORMAL'' ELSE ''CANCELADA'' END STATUS_NOTA,E.CODIGO CODIGO_EMPRRESA, E.RAZAOSOCIAL'+
          '   FROM SAIDA S'+
          '  INNER JOIN OPERACAOESTOQUE O'+
          '     ON (S.IDOPERACAOESTOQUE = O.IDOPERACAOESTOQUE)'+
          '  INNER JOIN EMPRESA E'+
          '     ON (S.IDEMPRESA = E.IDEMPRESA)'+
          '   LEFT JOIN CLIENTE C'+
          '     ON (S.IDCLIENTE = C.IDCLIENTE)'+
          '   LEFT JOIN FORNECEDOR F'+
          '     ON (S.IDFORNECEDOR = F.IDFORNECEDOR)'+
          '   LEFT JOIN TRANSPORTADORA T'+
          '     ON (S.IDTRANSPORTADORA = T.IDTRANSPORTADORA)'+
          '   LEFT JOIN USUARIO U'+
          '     ON (S.IDUSUARIO = U.IDUSUARIO)'+
          '   LEFT JOIN FUNCIONARIO FU '+
          '     ON (FU.IDFUNCIONARIO = S.IDFUNCIONARIO) '+
          '   LEFT JOIN NUMERACAONOTASAIDA NFE '+
          '     ON (S.IDSERIENFE = NFE.IDNUMERACAONOTASAIDA) '+
          '   LEFT JOIN NUMERACAONOTASAIDA NFSE '+
          '     ON (S.IDSERIENFSE = NFSE.IDNUMERACAONOTASAIDA) '+
          '  WHERE 1=1 '+Complemento;

       end;
       tpERPSaidaProduto:
       begin
        CampoChave := 'IDSAIDAPRODUTO';
        CampoDisplay := '';
        NomeTabela := 'SAIDAPRODUTO';
        DescricaoCampoDisplay := '';
        DescricaoTabela := 'Saída de produto(Itens)';
        Versao20 := False;
        CampoCodigo := '';
        DesconsiderarCampos := 'CODIGO;NOMEPRODUTO;UNIDADE;CFOP;FLAGEDICAO;TIPO_ITEM';
        Select :=
          ' SELECT SP.IDSAIDAPRODUTO, SP.IDSAIDA, SP.IDPRODUTO,SP.IDCOR, SP.IDTAMANHO, SP.NUMITEM, SP.IDUNIDADE, SP.QUANTIDADE, SP.VALORUNITARIO,'+
          '        SP.ALIQDESCONTO, SP.ALIQACRESCIMO, SP.VALORDESCONTO, SP.VALORACRESCIMO, SP.BASEICMS, SP.ALIQICMS, SP.VALORICMS,'+
          '        SP.BASEIPI, SP.ALIQIPI, SP.VALORIPI, SP.BASEICMSST, SP.ALIQST, SP.MVA, SP.VALORST, SP.BASEPISCOFINS, SP.ALIQPIS,'+
          '        SP.ALIQCOFINS, SP.VALORPIS, SP.VALORCOFINS, SP.BASEISS, SP.ALIQISS, SP.VALORISS, SP.BASECSLL, SP.ALIQCSLL,'+
          '        SP.VALORCSLL,SP.BASEIRRF, SP.ALIQIRRF, SP.VALORIRRF,  SP.IDCFOP, SP.IDNCM, SP.IDCODIGOMUNICIPAL, SP.CST, SP.CSOSN,'+
          '        SP.CUSTOMEDIO, SP.CUSTOESTOQUE,SP.CRT,SP.VALORUNITARIOORIGINAL, '+
          '        SP.CUSTOCONTABIL, SP.EAN, SP.MARCKUP, SP.VALORLUCRO, SP.VALORFRETERATEADO, SP.VALORSEGURORATEADO,SP.IDPATRIMONIO, SP.CONTADORPATRIMONIO,'+
          '        SP.VALOROUTRASDESPESASRATEADO, SP.SUBTOTAL, SP.VALORTOTAL,SP.OBS,SP.IDALMOXARIFADO, COALESCE(P.CODIGO , PT.CODIGO) CODIGO,'+
          '        COALESCE(P.NOMEPRODUTO,PT.NOMEPATRIMONIO) NOMEPRODUTO, U.CODIGO UNIDADE,C.CFOP,''N'' FLAGEDICAO, '+
          '        CASE WHEN P.CODIGO IS NULL THEN ''P'' '+
          '             WHEN P.TIPOPRODUTO = '+QuotedStr(TipoProdutoServico)+' THEN ''S'' ELSE ''I'' END TIPO_ITEM '+
          '   FROM SAIDAPRODUTO SP'+
          '   LEFT JOIN PRODUTO P'+
          '     ON (SP.IDPRODUTO = P.IDPRODUTO)'+
          '   LEFT JOIN PATRIMONIO PT' +
          '     ON (PT.IDPATRIMONIO = SP.IDPATRIMONIO) '+
          '   LEFT JOIN UNIDADE U'+
          '     ON (SP.IDUNIDADE =  U.IDUNIDADE)'+
          '   LEFT JOIN CFOP C '+
          '     ON (SP.IDCFOP = C.IDCFOP ) '+
          '  WHERE 1=1 '+Complemento;
       end;
      tpERPSaidaCondicaoPagamento:
       begin
        CampoChave := 'IDSAIDACONDICAOPAGAMENTO';
        CampoDisplay := '';
        NomeTabela := 'SAIDACONDICAOPAGAMENTO';
        DescricaoCampoDisplay := '';
        DescricaoTabela := 'Saída de produto(Pagamentos)';
        Versao20 := False;
        CampoCodigo := '';
        DesconsiderarCampos := 'NOMECONDICAOPAGAMENTO;FLAGEDICAO';
        Select :=
          ' SELECT SC.IDSAIDACONDICAOPAGAMENTO, SC.IDSAIDA,'+
          '        SC.IDCONDICAOPAGAMENTO, SC.VALOR,'+
          '        SC.NUMTOTALPARCELAS,C.NOMECONDICAOPAGAMENTO,''N'' FLAGEDICAO'+
          '   FROM SAIDACONDICAOPAGAMENTO SC'+
          '  INNER JOIN CONDICAOPAGAMENTO C'+
          '     ON (SC.IDCONDICAOPAGAMENTO = C.IDCONDICAOPAGAMENTO)'+
          '  WHERE 1=1 '+Complemento;
       end;
     tpERPSaidaCondicaoPagamentoParcelas:
       begin
        CampoChave := 'IDPARSAIDACONDICAOPAGAMENTO';
        CampoDisplay := '';
        NomeTabela := 'PARSAIDACONDICAOPAGAMENTO';
        DescricaoCampoDisplay := '';
        DescricaoTabela := 'Saída de produto(Parcelamentos de Pagamentos)';
        Versao20 := False;
        CampoCodigo := '';
        DesconsiderarCampos := 'NOMECONDICAOPAGAMENTO;FLAGEDICAO';
        Select :=
         'SELECT PS.IDPARSAIDACONDICAOPAGAMENTO, PS.IDSAIDACONDICAOPAGAMENTO, '+
         '       PS.NUMPARCELA, PS.VALORPARCELA ,''N'' FLAGEDICAO'+
         '  FROM PARSAIDACONDICAOPAGAMENTO PS '+
         '  WHERE 1=1 '+Complemento;
       end;
      tpERPTransportadora:
        begin
          CampoChave := 'IDTRANSPORTADORA';
          CampoDisplay := 'NOMEFANTASIA';
          NomeTabela := 'TRANSPORTADORA';
          DescricaoCampoDisplay := 'Nome fantasia';
          DescricaoTabela := 'Transportadora';
          Versao20 := False;
          DesconsiderarCampos := 'CEP;LOGRADOURO;BAIRRO;CIDADE;UF;IBGE';
          Select :=
             'SELECT T.IDTRANSPORTADORA, T.CODIGO, T.RAZAOSOCIAL, T.NOMEFANTASIA, T.CNPJ, T.IE, T.IDCEP, T.COMPLEMENTO, T.NUMERO, '+
             '       T.RNTRC, T.IDCFOP, CEP.CEP, CEP.LOGRADOURO, CEP.BAIRRO, CEP.CIDADE, CEP.UF,M.IBGE '+
             '  FROM TRANSPORTADORA T '+
             ' INNER JOIN CEP '+
             '    ON (CEP.IDCEP = T.IDCEP) '+
             '  LEFT JOIN MUNICIPIO M '+
             '    ON (M.IDMUNICIPIO = CEP.IDMUNICIPIO )'+
             '  WHERE 1=1 '+Complemento;
        end;
      tpERPAlmoxarifado:
        begin
          CampoChave := 'IDALMOXARIFADO';
          CampoDisplay := 'NOMEALMOXARIFADO';
          NomeTabela := 'ALMOXARIFADO';
          DescricaoCampoDisplay := 'Almoxarifado';
          DescricaoTabela := 'Almoxarifados';
          Versao20 := True;
          DesconsiderarCampos := '';
          Select :=
            'SELECT IDALMOXARIFADO,CODIGO, NOMEALMOXARIFADO'+
            '  FROM ALMOXARIFADO'+
            ' WHERE 1=1 '+Complemento;
        end;
      tpERPSaidaSerialProduto:
       Begin
          CampoChave := 'IDSAIDASERIALPRODUTO';
          CampoDisplay := '';
          NomeTabela := 'SAIDASERIALPRODUTO';
          DescricaoCampoDisplay := '';
          DescricaoTabela := 'Seriais do produto na saída';
          Versao20 := False;
          DesconsiderarCampos := 'SERIAL;FLAGEDICAO';
          CampoCodigo := '';
          Select :=
            'SELECT SSP.IDSAIDASERIALPRODUTO,  SSP.IDSAIDAPRODUTO, SSP.IDSERIALPRODUTO, S.SERIAL,''N'' FLAGEDICAO '+
            '  FROM SAIDASERIALPRODUTO SSP '+
            ' INNER JOIN SERIALPRODUTO S '+
            '    ON (S.IDSERIALPRODUTO =SSP.IDSERIALPRODUTO) '+
            ' WHERE 1=1 '+Complemento;
       End;
      tpERPCEP:
      begin
        NomeTabela := 'CEP';
        CampoChave := 'IDCEP';
        CampoCodigo := 'CEP';
        Select :=
          'EXECUTE BLOCK RETURNS (IDCEP CHAVE, CEP CHAR(8),LOGRADOURO VARCHAR(200),'+
          '                       BAIRRO VARCHAR(100),CIDADE VARCHAR(100),UF CHAR(2), IDMUNICIPIO CHAVE) AS '+
          'BEGIN '+
          '  FOR'+
          '    SELECT IDCEP, CEP, LOGRADOURO, BAIRRO, CIDADE,UF,IDMUNICIPIO'+
          '      FROM CEP'+
          '     WHERE 1=1 '+Complemento+
          '      INTO IDCEP,:CEP, :LOGRADOURO, :BAIRRO, :CIDADE, :UF, :IDMUNICIPIO'+
          '   DO'+
          '    BEGIN'+
          '      SUSPEND;'+
          '    END '+
          'END';
      end;
      tpERPCompetenciaContrato:
      begin
        NomeTabela := 'CONTRATOCOMPETENCIA';
        CampoChave := 'IDCONTRATOCOMPETENCIA';
        CampoCodigo := 'NUMEROCONTRATO';
        CampoDisplay := 'ANO ';
        DescricaoCampoDisplay := 'Competência';
        DescricaoTabela :='Competências do contrato';
        Versao20 := false;
        Select :=
          'SELECT CONTRATOCOMPETENCIA.IDCONTRATOCOMPETENCIA, CONTRATOCOMPETENCIA.IDCONTRATO, CONTRATOCOMPETENCIA.MES, CONTRATOCOMPETENCIA.ANO,'+
          '       CONTRATOCOMPETENCIA.VALOR, CONTRATOCOMPETENCIA.FLAGMOVIMENTADO, '+
          '       LPAD(CAST(CONTRATOCOMPETENCIA.MES AS VARCHAR(2)),2,''0'') ||''/''||CONTRATOCOMPETENCIA.ANO COMPETENCIA, C.NUMEROCONTRATO'+
          '  FROM CONTRATOCOMPETENCIA '+
          ' INNER JOIN CONTRATO C     '+
          '    ON (C.IDCONTRATO = CONTRATOCOMPETENCIA.IDCONTRATO) '+
          ' where 1=1 '+Complemento;
      end;
      tpERPContasReceber:
       Begin
          CampoChave := 'IDCONTARECEBER';
          CampoDisplay := '';
          NomeTabela := 'CONTARECEBER';
          DescricaoCampoDisplay := '';
          DescricaoTabela := 'Contas a receber';
          Versao20 := False;
          DesconsiderarCampos := 'CODIGOCLIENTE;NOMECLIENTE;NOMEBANCO;AGENCIA;CONTA;NOMEPLANOCONTA;LOGIN;CODIGOEMPRESA;STATUS';
          CampoCodigo := '';
          Select :=
            ' SELECT CR.IDCONTARECEBER, CR.DATAGERACAO, CR.HORAGERACAO, CR.NUMERODOCUMENTO,'+
            '        CR.DATA, CR.DATAVENCIMENTO, CR.IDCLIENTE,'+
            '        CR.IDSAIDA, CR.VALOR, CR.VALORPAGO, CR.FLAGSTATUS,'+
            '        CR.IDPLANOCONTA, CR.VALORJUROSTOTAL,CR.PARCELA,'+
            '        CR.VALORMORA, CR.VALORORIGINAL, CR.ALIQJUROS, CR.IDUSUARIO,'+
            '        CR.IDUSUARIOCANCELAMENTO, CR.DATACANCELAMENTO,'+
            '        CR.IDEMPRESA, CR.OBS, CR.DESCONTOFINANCEIRO,CR.VALORRESTANTE,'+
            '        C.CODIGO CODIGOCLIENTE, C.NOMECLIENTE,CR.IDCONTABANCARIA,CR.IDCONDICAOPAGAMENTO,'+
            '        U.LOGIN,E.CODIGO CODIGOEMPRESA,B.NOMEBANCO, CB.AGENCIA, CB.CONTA,'+
            '        CASE WHEN CR.FLAGSTATUS= ''A'' THEN ''Aberto'' '+
            '             WHEN CR.FLAGSTATUS= ''C'' THEN ''Cancelado'' '+
            '             WHEN CR.FLAGSTATUS= ''F'' THEN ''Finalizada'' END STATUS,PC.NOMEPLANOCONTA '+
            '   FROM CONTARECEBER CR'+
            '  INNER JOIN CLIENTE C'+
            '     ON (CR.IDCLIENTE = C.IDCLIENTE)'+
            '  INNER JOIN EMPRESA E '+
            '     ON (E.IDEMPRESA = CR.IDEMPRESA)'+
            '   LEFT JOIN PLANOCONTA PC'+
            '     ON (PC.IDPLANOCONTA =CR.IDPLANOCONTA)'+
            '   LEFT JOIN CONTABANCARIA CB'+
            '     ON (CB.IDCONTABANCARIA = CR.IDCONTABANCARIA)'+
            '   LEFT JOIN BANCO B'+
            '     ON (B.IDBANCO =CB.IDBANCO)'+
            '   LEFT JOIN USUARIO U'+
            '     ON (U.IDUSUARIO = CR.IDUSUARIO)'+
            '  WHERE 1=1 '+Complemento;
       End;
       tpERPPlanoContas:
       begin
          CampoChave := 'IDPLANOCONTA';
          CampoDisplay := 'NOMEPLANOCONTA';
          NomeTabela := 'PLANOCONTA';
          DescricaoCampoDisplay := 'Descrição';
          DescricaoTabela := 'Planos de conta';
          Versao20 := True;
          DesconsiderarCampos := '';
          TipoForm := tfTree;
          UsaMaxParaCodigo := True;
          Select :=
            'SELECT IDPLANOCONTA, CODIGO, NOMEPLANOCONTA, CODPAI, CLASSIFICACAO,FLAGTIPO '+
            '  FROM PLANOCONTA '+
            ' WHERE 1=1 '+Complemento;
       end;
       tpERPContasReceberRecebimentos:
        begin
          CampoChave := 'IDCONTARECEBERRECIMENTOS';
          CampoDisplay := '';
          NomeTabela := 'CONTARECEBERRECIMENTOS';
          DescricaoCampoDisplay := '';
          DescricaoTabela := 'Recebimentos do contas a receber';
          Versao20 := False;
          DesconsiderarCampos := 'LOGIN;FLAGEDICAO';
          Select :=
            'SELECT CR.IDCONTARECEBERRECIMENTOS, CR.IDCONTARECEBER, CR.ALIQJUROS, CR.VALORJUROS, '+
            '       CR.VALORMORA, CR.VALORRECEBIDO, CR.DATARECEBIDO, CR.DESCONTOFINANCEIRO,CR.IDUSUARIO, '+
            '       U.LOGIN, ''N'' FLAGEDICAO'+
            '  FROM CONTARECEBERRECIMENTOS CR '+
            '  LEFT JOIN USUARIO U'+
            '    ON (U.IDUSUARIO = CR.IDUSUARIO)'+
            ' WHERE 1=1 '+Complemento;
        end;
       tpERPEstoque:
       Begin
          CampoChave := 'IDESTOQUE';
          CampoDisplay := 'NOMEPRODUTO';
          NomeTabela := 'VW_ESTOQUE';
          DescricaoCampoDisplay := 'Produto';
          DescricaoTabela := 'Estoque';
          Versao20 := False;
          DesconsiderarCampos := '';
          CampoCodigo := 'Codigo';
          Select :=
            'SELECT IDESTOQUE,IDPRODUTO,IDEMPRESA,IDCOR,IDTAMANHO,IDALMOXARIFADO,' +
            '       QUANTIDADE,CODIGO,NOMEPRODUTO,EMPRESA,NOMEALMOXARIFADO,DESCRICAOCOR, '+
            '       DESCRICAOTAMANHO,COR,TAMANHO '+
            '  FROM VW_ESTOQUE '+
            ' WHERE 1=1 '+Complemento;
       End;
      tpERPMovimentacaoEstoque:
       Begin
          CampoChave := 'IDESTOQUE';
          CampoDisplay := 'NOMEPRODUTO';
          NomeTabela := 'VW_ESTOQUE';
          DescricaoCampoDisplay := 'Produto';
          DescricaoTabela := 'Estoque';
          Versao20 := False;
          DesconsiderarCampos := '';
          CampoCodigo := 'Codigo';
          Select :=
            'SELECT IDEMPRESA,IDPRODUTO,CODIGOPRODUTO,NOMEPRODUTO, '+
            '       TIPOPRODUTO,CODIGOEMPRESA,EMPRESA,IDCOR,DESCRICAOCOR, '+
            '       CODIGO_COR,IDTAMANHO,CODIGOTAMANHO,DESCRICAOTAMANHO, '+
            '       IDALMOXARIFADO,NOMEALMOXARIFADO,OPERACAO, '+
            '       QUANTIDADE,NOMEOPERACAOESTOQUE,LOCALMOVIMENTO, '+
            '       NUMERO_MOVIMENTO,DATA '+
            '  FROM VW_MOVIMENTACAO_PRODUTO '+
            ' WHERE 1=1 '+Complemento;
       End;
      tpERPTipoPatrimonio:
       begin
          CampoChave := 'IDTIPOPATRIMONIO';
          CampoDisplay := 'NOMETIPOPATRIMONIO';
          NomeTabela := 'TIPOPATRIMONIO';
          DescricaoCampoDisplay := 'Descrição';
          DescricaoTabela := 'Tipo de patrimônio';
          DesconsiderarCampos := '';
          UsaMaxParaCodigo := True;
          Versao20:= False;
          Select :=
            'SELECT IDTIPOPATRIMONIO, CODIGO, NOMETIPOPATRIMONIO, '+
            '       FLAGCONTROLACONTADOR, IDUNIDADECONTADOR '+
            '  FROM TIPOPATRIMONIO '+
            ' WHERE 1=1 '+Complemento;
       end;
        else
        Result := GetTSQL(TipoPesquisa,Complemento,Join);

    end;

  End;


end;

function TSQLERP.GetTSQL(TipoPesquisa: TTipoPesquisa; Complemento,
  Join: String): TSQL;
begin
  Result.CampoCodigo := 'CODIGO' ;
  Result.Versao20 := True;
  Result.UsaMaxParaCodigo := True;
  Result.TipoForm := TfGrid;
  with Result do
  Begin
    case TipoPesquisa of
       tpERPPatrimonio,tpERPPatrimonioDisponivel:
       begin
          CampoChave := 'IDPATRIMONIO';
          CampoDisplay := 'NOMEPATRIMONIO';
          NomeTabela := 'PATRIMONIO';
          DescricaoCampoDisplay := 'Descrição';
          DescricaoTabela := 'Patrimônio';
          DesconsiderarCampos := 'EMPRESA;NOMETIPOPATRIMONIO;FLAGCONTROLACONTADOR;NOMEUNIDADE;NCM;NOMEFABRICANTE';
          UsaMaxParaCodigo := True;
          Versao20:= False;
          Select :=
            'SELECT P.IDPATRIMONIO, P.CODIGO, P.NOMEPATRIMONIO, P.OBS, P.DATAAQUISICAO,'+
            '       P.VALORAQUISICAO, P.DATACADASTRO, P.CONTADOR,'+
            '       P.SERIAL, P.IDEMPRESA, P.IDTIPOPATRIMONIO, P.FLAGINATIVO, P.IDENTRADA, P.IDVENDA, P.IDNCM, P.IDFABRICANTE,'+
            '       P.LASTCHANGE, P.FLAGDISPONIVEL,P.PRECOSAIDA, E.CODIGO EMPRESA,TP.NOMETIPOPATRIMONIO, TP.FLAGCONTROLACONTADOR,'+
            '       U.NOMEUNIDADE,NCM.CODIGO NCM,F.NOMEFABRICANTE'+
            '  FROM PATRIMONIO P'+
            ' INNER JOIN EMPRESA E'+
            '    ON (P.IDEMPRESA = E.IDEMPRESA)'+
            ' INNER JOIN TIPOPATRIMONIO TP'+
            '    ON (P.IDTIPOPATRIMONIO = TP.IDTIPOPATRIMONIO)'+
            '  LEFT JOIN UNIDADE U'+
            '    ON (TP.IDUNIDADECONTADOR =  U.IDUNIDADE )'+
            '  LEFT JOIN NCM'+
            '    ON (P.IDNCM = NCM.IDNCM)'+
            '  LEFT JOIN FABRICANTE F'+
            '    ON (P.IDFABRICANTE = F.IDFABRICANTE)'+
            ' WHERE '+IfThen(TipoPesquisa = tpERPPatrimonioDisponivel, ' COALESCE(P.FLAGDISPONIVEL,''Y'') =''Y'' ',' 1=1 ')+Complemento;

       end;
      tpERPTipoEventos:
        begin
          CampoChave := 'IDTIPOEVENTOPATRIMONIO';
          CampoDisplay := 'NOMETIPOEVENTOPATRIMONIO';
          NomeTabela := 'TIPOEVENTOPATRIMONIO';
          DescricaoCampoDisplay := 'Evento';
          DescricaoTabela := 'Tipo de evento patrimônio';
          DesconsiderarCampos := 'DESCRICAOPERIODICIDADE;NUMDIAS;SERVICO;NOMESERVICO';
          UsaMaxParaCodigo := True;
          Versao20:= False;
          Select :=
           ' SELECT TE.IDTIPOEVENTOPATRIMONIO,TE.CODIGO, TE.NOMETIPOEVENTOPATRIMONIO,TE.FLAGFORMACONTROLE, '+
           '        TE.IDPERIODICIDADE,TE.IDSERVICO, TE.IDPERIODICIDADEALERTA,TE.VALORCONTADORALERTA, ' +
           '        TE.OBS,TE.VALORCONTADOR, PE.DESCRICAOPERIODICIDADE,PE.NUMDIAS, PS.CODIGO SERVICO, PS.NOMEPRODUTO NOMESERVICO '+
           '   FROM TIPOEVENTOPATRIMONIO TE' +
           '   LEFT JOIN PERIODICIDADE PE' +
           '     ON (PE.IDPERIODICIDADE= TE.IDPERIODICIDADE)'+
           '   LEFT JOIN PRODUTO PS' +
           '     ON (PS.IDPRODUTO = TE.IDSERVICO) '+
           '  WHERE 1=1 '+Complemento;
        end;
      tpERPTipoPatrimonioTipoEventos:
        begin
          CampoChave := 'IDTIPOPATRIMONIOTIPOEVENTO';
          CampoDisplay := '';
          NomeTabela := 'TIPOPATRIMONIOTIPOEVENTO';
          DescricaoCampoDisplay := '';
          DescricaoTabela := 'Eventos do tipo de patrimônio';
          DesconsiderarCampos := 'CODIGO;NOMETIPOEVENTOPATRIMONIO;FLAGEDICAO';
          Versao20:= False;
          Select :=
            'SELECT TI.IDTIPOPATRIMONIOTIPOEVENTO, TI.IDTIPOPATRIMONIO,'+
            '       TI.IDTIPOEVENTOPATRIMONIO,TE.CODIGO, TE.NOMETIPOEVENTOPATRIMONIO,''N'' FLAGEDICAO '+
            '  FROM TIPOPATRIMONIOTIPOEVENTO TI '+
            ' INNER JOIN TIPOEVENTOPATRIMONIO TE '+
            '    ON (TE.IDTIPOEVENTOPATRIMONIO = TI.IDTIPOEVENTOPATRIMONIO)  '+
            ' WHERE 1=1 '+Complemento;
        end;

      tpERPPatrimoniosUsadosOS:
        Begin
          CampoChave := 'IDOSPATRIMONIOSUSADOS';
          CampoDisplay := '';
          NomeTabela := 'OSPATRIMONIOSUSADOS';
          DescricaoCampoDisplay := '';
          DescricaoTabela := 'patrimônios usados na O.S.';
          DesconsiderarCampos := 'CODIGO;NOMEPATRIMONIO;FLAGEDICAO';
          Versao20:= False;
          Select :=
            'SELECT OP.IDOSPATRIMONIOSUSADOS, OP.IDSERVICOOS, OP.IDPATRIMONIO, '+
            '       OP.CONTADORPATRIMONIO,P.CODIGO, P.NOMEPATRIMONIO,''N'' FLAGEDICAO '+
            '  FROM OSPATRIMONIOSUSADOS OP '+
            ' INNER JOIN PATRIMONIO P '+
            '    ON (P.IDPATRIMONIO = OP.IDPATRIMONIO) '+
            ' WHERE 1=1 '+Complemento;
        End;
      tpERPPatrimonioManutencaoTerceiros:
        Begin
          CampoChave := 'IDPATRIMONIOMANUTENCAO';
          CampoDisplay := '';
          NomeTabela := 'PATRIMONIOMANUTENCAO';
          DescricaoCampoDisplay := '';
          DescricaoTabela := 'Manutenção de patrimônios';
          DesconsiderarCampos := 'CODIGOPATRIMONIO;NOMEPATRIMONIO;CODIGOFORNECEDOR;RAZAOSOCIAL;NUMERONOTA';
          Versao20:= False;
          CampoCodigo := '';
          Select :=
            'SELECT PM.IDPATRIMONIOMANUTENCAO, PM.IDPATRIMONIO, PM.IDFORNECEDOR,'+
            '       PM.DATA, PM.CONTADORPATRIMONIO, PM.DETALHESMANUTENCAO,PM.IDENTRADA,'+
            '       P.CODIGO CODIGOPATRIMONIO, P.NOMEPATRIMONIO,'+
            '       F.CODIGO CODIGOFORNECEDOR, F.RAZAOSOCIAL,E.NUMERONOTA'+
            '  FROM PATRIMONIOMANUTENCAO PM'+
            ' INNER JOIN PATRIMONIO P'+
            '    ON (P.IDPATRIMONIO = PM.IDPATRIMONIO)'+
            ' INNER JOIN FORNECEDOR F'+
            '    ON (F.IDFORNECEDOR = PM.IDFORNECEDOR)'+
            '  LEFT JOIN ENTRADA E '+
            '    ON (E.IDENTRADA = PM.IDENTRADA)'+
            ' WHERE 1=1 '+Complemento;
        End;
      tpERPPatrimonioManutencaoTerceirosEventos:
        begin
          CampoChave := 'IDPATRIMONIOMANUTENCAOEVENTOS';
          CampoDisplay := '';
          NomeTabela := 'PATRIMONIOMANUTENCAOEVENTOS';
          DescricaoCampoDisplay := '';
          DescricaoTabela := 'Manutenção de patrimônios(Eventos)';
          DesconsiderarCampos := 'CODIGO;NOMETIPOEVENTOPATRIMONIO;FLAGEDICAO';
          Versao20:= False;
          CampoCodigo := '';
          Select :=
            'SELECT PEM.IDPATRIMONIOMANUTENCAOEVENTOS, PEM.IDTIPOEVENTOPATRIMONIO, PEM.IDPATRIMONIOMANUTENCAO, '+
            '       TE.CODIGO, TE.NOMETIPOEVENTOPATRIMONIO,''N'' FLAGEDICAO  '+
            '  FROM PATRIMONIOMANUTENCAOEVENTOS PEM   '+
            ' INNER JOIN TIPOEVENTOPATRIMONIO TE '+
            '   ON (TE.IDTIPOEVENTOPATRIMONIO = PEM.IDTIPOEVENTOPATRIMONIO) '+
            ' WHERE 1=1 '+Complemento;
        end;
       tpERPAlertaPatrimonio:
        begin
          CampoChave := '';
          CampoDisplay := '';
          NomeTabela := 'VW_ALERTATIPOEVENTOPATRIMONIO';
          DescricaoCampoDisplay := '';
          DescricaoTabela := 'Alerta de patrimônio';
          DesconsiderarCampos := 'CODIGO;NOMETIPOEVENTOPATRIMONIO;FLAGEDICAO';
          Versao20:= False;
          CampoCodigo := '';
          Select :=
            'SELECT IDPATRIMONIO, IDTIPOEVENTOPATRIMONIO,CODIGOPATRIMONIO,NOMEPATRIMONIO, '+
            '       CODIGOTIPOEVENTO,NOMETIPOEVENTOPATRIMONIO,FLAGFORMACONTROLE, '+
            '       CONTADORATUAL,ULTIMADATAMOV,DATALIMITE,CONTADORLIMITE, '+
            '       DATAALERTA,CONTADORALERTA '+
            '  FROM VW_ALERTATIPOEVENTOPATRIMONIO '+
            ' WHERE 1=1 '+Complemento;
        end;
       tpERPICMS:
        begin
          CampoChave := 'IDICMS';
          CampoDisplay := '';
          NomeTabela := 'ICMS';
          DescricaoCampoDisplay := '';
          DescricaoTabela := 'ICMS';
          DesconsiderarCampos := '';
          Versao20:= False;
          CampoCodigo := '';
          Select :=
            'SELECT IDICMS, ALIQICMS,UFORIGEM,UFDESTINO '+
            '  FROM ICMS '+
            ' WHERE 1=1 '+Complemento;
        end;
       tpERPISS:
        begin
          CampoChave := 'IDISS';
          CampoDisplay := '';
          NomeTabela := 'ISS';
          DescricaoCampoDisplay := '';
          DescricaoTabela := 'ISS';
          DesconsiderarCampos := 'CODIGO;DESCRICAO;MUNICIPIO';
          Versao20:= False;
          CampoCodigo := '';
          Select :=
            'SELECT ISS.IDISS, ISS.IDMUNICIPIO, ISS.IDCODIGOMUNICIPALSERVICO, ISS.ALIQISS, '+
            '       C.CODIGO,SUBSTRING( C.DESCRICAOCODIGOSERVICO FROM 1 FOR 100) DESCRICAO, '+
            '       M.NOME MUNICIPIO, ISS.ALIQPIS,ISS.ALIQCOFINS, ISS.ALIQCSLL, ISS.VALORMINIMOTRIBFEDERAL, ISS.VALORMINIMOIR,ISS.ALIQIR '+
            '  FROM ISS '+
            ' INNER JOIN CODIGOMUNICIPALSERVICO C '+
            '    ON (ISS.IDCODIGOMUNICIPALSERVICO = C.IDCODIGOMUNICIPALSERVICO) '+
            ' INNER JOIN MUNICIPIO M '+
            '    ON (M.IDMUNICIPIO = ISS.IDMUNICIPIO)'+
            ' WHERE 1=1 '+Complemento;
        end;
        tpERPPatrimoniosEventos:
        begin
          CampoChave := 'IDPATRIMONIOEVENTO';
          CampoDisplay := '';
          NomeTabela := 'PATRIMONIOEVENTO';
          DescricaoCampoDisplay := '';
          DescricaoTabela := 'Eventos do patrimônio';
          CampoCodigo := '';
          DesconsiderarCampos := 'IDTIPOPATRIMONIO;CODIGO;NOMETIPOEVENTOPATRIMONIO;FLAGEDICAO';
          Versao20:= False;
          Select :=
            'SELECT IDPATRIMONIO,IDTIPOPATRIMONIO,IDPATRIMONIOEVENTO,'+
            '       IDTIPOEVENTOPATRIMONIO,CODIGO,NOMETIPOEVENTOPATRIMONIO,'+
            '       FLAGEDICAO'+
            '  FROM ('+
            '        SELECT CAST(NULL AS CHAVE) IDPATRIMONIO, TI.IDTIPOPATRIMONIO,'+
            '               CAST(NULL AS CHAVE)  IDPATRIMONIOEVENTO, TE.IDTIPOEVENTOPATRIMONIO,'+
            '               TE.CODIGO, TE.NOMETIPOEVENTOPATRIMONIO,''N'' FLAGEDICAO'+
            '          FROM TIPOPATRIMONIOTIPOEVENTO TI'+
            '         INNER JOIN TIPOEVENTOPATRIMONIO TE'+
            '            ON (TE.IDTIPOEVENTOPATRIMONIO = TI.IDTIPOEVENTOPATRIMONIO)'+
            '         UNION'+
            '        SELECT PE.IDPATRIMONIO, P.IDTIPOPATRIMONIO,'+
            '               PE.IDPATRIMONIOEVENTO, TE.IDTIPOEVENTOPATRIMONIO,'+
            '               TE.CODIGO, TE.NOMETIPOEVENTOPATRIMONIO,''U'' FLAGEDICAO'+
            '         FROM PATRIMONIO P'+
            '        INNER JOIN PATRIMONIOEVENTO PE'+
            '           ON (P.IDPATRIMONIO = PE.IDPATRIMONIO)'+
            '        INNER JOIN  TIPOEVENTOPATRIMONIO TE'+
            '           ON (PE.IDTIPOEVENTOPATRIMONIO = TE.IDTIPOEVENTOPATRIMONIO))X'+
            ' WHERE 1=1 '+Complemento;

        end;
        tpERPMunicpio:
        begin
          CampoChave := 'IDMUNICIPIO';
          CampoDisplay := 'NOME';
          NomeTabela := 'MUNICIPIO';
          DescricaoCampoDisplay := 'Município';
          DescricaoTabela := 'Municípios';
          CampoCodigo := 'IBGE';
          DesconsiderarCampos := '';
          Versao20:= True;
          Select :=
             'SELECT  IDMUNICIPIO,UF,IBGE, NOME '+
             '  FROM MUNICIPIO '+
             ' WHERE 1=1 '+Complemento;
        end;
        tpERPCST:
        begin
          CampoChave := 'CST';
          CampoDisplay := 'descricao';
          NomeTabela := 'VW_SITUACAO_TRIBUTARIA';
          DescricaoCampoDisplay := 'Descrição';
          DescricaoTabela := 'CST';
          CampoCodigo := 'CST';
          DesconsiderarCampos := '';
          Versao20:= True;
          Select :=
             'SELECT  CST,descricao, CST, ST, Origem, DESCRICAO, descricao_Origem, descricao_ST '+
             '  FROM VW_SITUACAO_TRIBUTARIA '+
             ' WHERE 1=1 '+Complemento;
        end;

        tpERPST:
        begin
          CampoChave := 'ST';
          CampoDisplay := 'descricao_ST';
          NomeTabela := 'VW_SITUACAO_TRIBUTARIA';
          DescricaoCampoDisplay := 'Descrição';
          DescricaoTabela := 'CST';
          CampoCodigo := 'ST';
          DesconsiderarCampos := '';
          Versao20:= True;
          Select :=
             'SELECT distinct descricao_ST, ST '+
             '  FROM VW_SITUACAO_TRIBUTARIA '+
             ' WHERE 1=1 '+Complemento;
        end;

        tpERPCSOSN:
        begin
          CampoChave := 'CSOSN';
          CampoDisplay := 'descricao';
          NomeTabela := 'vw_CSOSN';
          DescricaoCampoDisplay := 'Descrição';
          DescricaoTabela := 'CSOSN';
          CampoCodigo := 'CSOSN';
          DesconsiderarCampos := '';
          Versao20:= True;
          Select :=
             'SELECT  CSOSN,descricao,DETALHES '+
             '  FROM vw_CSOSN '+
             ' WHERE 1=1 '+Complemento;
        end;
       tpERPLimiteReceitaBruta:
         begin
          CampoChave := 'IDLIMITERECEITABRUTA';
          CampoDisplay := 'VALOR';
          NomeTabela := 'LIMITERECEITABRUTA';
          CampoCodigo :='ANO';
          DescricaoCampoDisplay := 'Valor';
          DescricaoTabela := 'Limite de receita bruta decretada pelo governo(Somente para simples nacional e lucro presumido) ';
          DesconsiderarCampos := 'FLAGEDICAO';
          Versao20:= True;
          Select :=
             'SELECT  IDLIMITERECEITABRUTA,IDEMPRESA,ANO,VALOR,''N'' FLAGEDICAO '+
             '  FROM LIMITERECEITABRUTA '+
             ' WHERE 1=1 '+Complemento;
        end;
       tpERPCST_CFOP:
         begin
          CampoChave := 'IDCFOPCST';
          CampoDisplay := 'DESCRICAO_ST';
          NomeTabela := 'CFOPCST';
          CampoCodigo :='CST';
          DescricaoCampoDisplay := 'Descrição';
          DescricaoTabela := 'CST/CFOP';
          DesconsiderarCampos := 'FLAGEDICAO;DESCRICAO_ST;ST';
          Versao20:= True;
          Select :=
             'SELECT CST.IDCFOPCST, CST.IDCFOP, CST.CST, CST.CSOSN,S.DESCRICAO_ST,''N'' FLAGEDICAO, S.ST '+
             '  FROM CFOPCST CST '+
             '  LEFT JOIN (SELECT DISTINCT ST, DESCRICAO_ST '+
             '               FROM VW_SITUACAO_TRIBUTARIA) S '+
             '    ON (S.ST = CST.CST) '+
             ' WHERE 1=1 '+Complemento;
        end;
       tpERPCFOPSemelhante:
          begin
          CampoChave := 'IDCFOPSEMELHANTE';
          CampoDisplay := 'NATUREZA';
          NomeTabela := 'CFOPSEMELHANTE';
          CampoCodigo :='CFOP';
          DescricaoCampoDisplay := 'Descrição';
          DescricaoTabela := 'CFOPs semelhantes';
          DesconsiderarCampos := 'FLAGEDICAO;NATUREZA;CFOP';
          Versao20:= True;
          Select :=
             'SELECT CS.IDCFOPSEMELHANTE, CS.IDCFOPPAI,CS.IDCFOP,CFOP.CFOP, CFOP.NATUREZA,''N'' FLAGEDICAO '+
             '  FROM CFOPSEMELHANTE CS '+
             ' INNER JOIN CFOP '+
             '    ON (CS.IDCFOP = CFOP.IDCFOP) '+
             ' WHERE 1=1 '+Complemento;
        end;
        tpERPNumeracaoNotaSaida:
        begin
          CampoChave := 'IDNUMERACAONOTASAIDA';
          CampoDisplay := 'SERIE';
          NomeTabela := 'NUMERACAONOTASAIDA';
          CampoCodigo :='SERIE';
          DescricaoCampoDisplay := 'Série';
          DescricaoTabela := 'Numeração das notas de saída';
          DesconsiderarCampos := 'FLAGEDICAO';
          Versao20:= True;
          Select :=
             'SELECT  IDNUMERACAONOTASAIDA,IDEMPRESA,FLAGTIPODOCUMENTO,SERIE,NUMEROATUAL,''N'' FLAGEDICAO '+
             '  FROM NUMERACAONOTASAIDA  '+
             ' WHERE 1=1 '+Complemento;
        end;
        tpERPLotesNota:
        begin
          CampoChave := 'IDLOTEDOCUMENTO';
          CampoDisplay := 'NUMEROLOTES';
          NomeTabela := 'LOTEDOCUMENTO';
          CampoCodigo :='';
          DescricaoCampoDisplay := '';
          DescricaoTabela := 'Lotes de documentos ';
          DesconsiderarCampos := 'STATUSNFSE;STATUSNFE';
          Versao20:= True;
          Select :=
            ' SELECT IDLOTEDOCUMENTO, LPAD(NUMEROLOTE, 10,''0'') NUMEROLOTE, DATAGERACAO, '+
            '        HORAGERACAO, FLAGSTATUSNFE, DATAHORARESPOSTANFE, MSGERRONFE,'+
            '        FLAGSTATUSNFSE, DATAHORARESPOSTANFSE, MSGERRONFSE,'+
            '        CASE WHEN FLAGSTATUSNFE =''N'' THEN ''NÃO INICIADO'''+
            '             WHEN FLAGSTATUSNFE =''I'' THEN ''INICIO ENVIO'''+
            '             WHEN FLAGSTATUSNFE =''E'' THEN ''ENVIADO'''+
            '             WHEN FLAGSTATUSNFE =''R'' THEN ''ERRO'''+
            '             WHEN FLAGSTATUSNFE =''S'' THEN ''SUCESSO'' END STATUSNFE,'+
            '        CASE WHEN FLAGSTATUSNFSE =''N'' THEN ''NÃO INICIADO'''+
            '             WHEN FLAGSTATUSNFSE =''I'' THEN ''INICIO ENVIO'''+
            '             WHEN FLAGSTATUSNFSE =''E'' THEN ''ENVIADO'''+
            '             WHEN FLAGSTATUSNFSE =''R'' THEN ''ERRO'''+
            '             WHEN FLAGSTATUSNFSE =''S'' THEN ''SUCESSO'' END STATUSNFSE'+
            '   FROM LOTEDOCUMENTO'+
            '  WHERE 1=1 '+Complemento;
        end;
       tpERPItensLotesNota:
       begin
          CampoChave := 'IDITENSLOTEDOCUMENTO';
          CampoDisplay := 'PESSOA';
          NomeTabela := 'ITENSLOTEDOCUMENTO';
          CampoCodigo :='';
          DescricaoCampoDisplay := '';
          DescricaoTabela := 'Lotes de documentos(Itens) ';
          DesconsiderarCampos := 'STATUS;PESSOA;DATA;NUMEROSAIDA';
          Versao20:= True;
          Select :=
            '  SELECT I.IDITENSLOTEDOCUMENTO, I.IDLOTEDOCUMENTO,'+
            '         I.IDSAIDA, I.FLAGSTATUS,'+
            '         S.DATA,S.NUMEROSAIDA,COALESCE(C.NOMECLIENTE,F.RAZAOSOCIAL) PESSOA,'+
            '         CASE WHEN I.FLAGSTATUS = ''A'' THEN ''AGUARDANDO'''+
            '              WHEN I.FLAGSTATUS = ''E'' THEN ''ERRO'''+
            '              WHEN I.FLAGSTATUS = ''S'' THEN ''SUCESSO'' END STATUS'+
            '    FROM ITENSLOTEDOCUMENTO I'+
            '   INNER JOIN SAIDA S'+
            '      ON (S.IDSAIDA = I.IDSAIDA)'+
            '    LEFT JOIN CLIENTE C'+
            '      ON (C.IDCLIENTE = S.IDCLIENTE)'+
            '    LEFT JOIN FORNECEDOR F'+
            '      ON (F.IDFORNECEDOR = S.IDFORNECEDOR)'+
            ' WHERE 1=1 '+Complemento;
       end;
    end;
  End;


end;

end.
