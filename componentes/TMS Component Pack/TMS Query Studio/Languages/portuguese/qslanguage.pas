unit wsLanguage;

interface

implementation

uses
  wsRes;

const LanguageStr = 
'[strings]' + #13#10 +
'SAfter=depois' + #13#10 +
'SAggregationFunctionNotAllowed=Função de agregação "%s" não permitida para o tipo de dados "%s"' + #13#10 +
'SAlias=apelido' + #13#10 +
'SAmbiguousError=Erro ambíguo' + #13#10 +
'SAnd=E' + #13#10 +
'SAndNot=E não' + #13#10 +
'SAnyFile=Todos os arquivos' + #13#10 +
'SAs=como' + #13#10 +
'SAscending=crescente' + #13#10 +
'SAutomaticListEditor=Editor de lista automática' + #13#10 +
'SAvg=Média de' + #13#10 +
'SBefore=antes' + #13#10 +
'SBring=Obter' + #13#10 +
'SCancel=Cancelar' + #13#10 +
'SCannotClearParser=Não é possível limpar o parser durante o processamento' + #13#10 +
'SCapabilityNotSupportedJoins=Recurso não suportado em condições de junção ligando a tabela "%s" à "%s"' + #13#10 +
'SCheckListEditor=Editor de lista de marcação' + #13#10 +
'SChooseListEditor=Editor de lista de escolha' + #13#10 +
'SCompareFieldToAnother=Comparar um campo a outro campo' + #13#10 +
'SCompareFieldToParametricValue=Comparar um campo a um valor paramétrico' + #13#10 +
'SCompareFieldToSpecificValue=Comparar um campo a um valor específico' + #13#10 +
'SConditionExpressionNotSpecified=Expressão da condição não especificada' + #13#10 +
'SConditionRightSideNotSpecified=Lado direito da condição não especificado' + #13#10 +
'SConfirmChangeLogicalConnector=Confirma modificação do conector lógico das condições agrupadas?' + #13#10 +
'SConfirmClearAllItems=Limpar todos os itens?' + #13#10 +
'SConfirmDeleteSelectedItems=Deseja realmente excluir os itens selecionados?' + #13#10 +
'SConfirmExcludeAllDefinitions=Confirma exclusão de todas as definições da consulta "%s"?' + #13#10 +
'SConfirmUpdatingMetaSQL=Confirma atualização do componente MetaSQL com a sentença SQL atual?' + #13#10 +
'SContaining=contendo' + #13#10 +
'SCount=Quantidade' + #13#10 +
'SCustomExpression=Expressão personalizada' + #13#10 +
'SCustomExpressionSQLSyntax=Expressão personalizada (sintaxe SQL)' + #13#10 +
'SDatabaseNameNotInformed=Nome do banco de dados não informado' + #13#10 +
'SDataFields=Campos de dados' + #13#10 +
'SDataTypeNotIndicated=Tipo de dados não indicado' + #13#10 +
'SDate=data' + #13#10 +
'SDay=dia' + #13#10 +
'SDeleteThisQuery=&Excluir esta consulta' + #13#10 +
'SDescending=decrescente' + #13#10 +
'SDifferent=diferente' + #13#10 +
'SDropdownAutomatic=Lista automática' + #13#10 +
'SDropdownCheck=Lista de marcação' + #13#10 +
'SDropdownChoose=Lista de escolha' + #13#10 +
'SDropdownQuery=Lista de consulta' + #13#10 +
'SDuplicateThisQuery=Du&plicar esta consulta como...' + #13#10 +
'SEditMetaSQL=Editar Meta SQL' + #13#10 +
'SEditParameterEditorTitled=Editar parâmetro:%s com editor %s, título "%s"' + #13#10 +
'SEmpty=vazio' + #13#10 +
'SEndingWith=terminando com' + #13#10 +
'SEnterTableAlias=Informe o apelido da tabela:' + #13#10 +
'SEqual=igual' + #13#10 +
'SErrorOpeningQueryCombo=Erro abrindo query interna do TatQueryCombo:' + #13#10 +
'SErroSintaxeLinhaColuna=Erro de sintaxe na linha %d, coluna %d do Meta SQL:' + #13#10 +
'SExportQueriesToFile=Exportar consultas para arquivo' + #13#10 +
'SExpression=Expressão' + #13#10 +
'SExpressionAliasTitled=Expressão %s apelido %s, título "%s"' + #13#10 +
'SExpressionFieldNotSpecified=Campo da expressão não especificado' + #13#10 +
'SExpressionOperatorNotSpecified=Operador da expressão não especificado' + #13#10 +
'SFalse=Não' + #13#10 +
'SField=campo' + #13#10 +
'SFieldAliasNotIndicated=Apelido do campo não indicado' + #13#10 +
'SFieldAliasNotUnique=Apelido do campo não é único no Meta SQL' + #13#10 +
'SFieldCalculatedByAnExpression=Campo calculado por uma expressão' + #13#10 +
'SFieldComparing=Comparação de campos' + #13#10 +
'SFieldExpressionNotIndicated=Expressão do campo não indicada' + #13#10 +
'SFieldKindAvg=Média de (calcula a média do valor do campo em um conjunto de registros)' + #13#10 +
'SFieldKindBring=Obter (retorna os valores individuais do campo de uma tabela do banco de dados)' + #13#10 +
'SFieldKindCount=Quantidade (conta o número de ocorrências do valor do campo em um conjunto de registros)' + #13#10 +
'SFieldKindMax=Máximo de (retorna o valor máximo do campo em um conjunto de registros)' + #13#10 +
'SFieldKindMin=Mínimo de (retorna o valor mínimo do campo em um conjunto de registros)' + #13#10 +
'SFieldKindSum=Soma de (calcula a soma dos valores do campo em um conjunto de registros)' + #13#10 +
'SFieldNameNotIndicated=Nome do campo não indicado' + #13#10 +
'SFieldNotIndicated=Campo não indicado' + #13#10 +
'SFilterConditions=Condições de filtro' + #13#10 +
'SFreeTyping=edição livre' + #13#10 +
'SFreeTypingEditor=Editor de edição livre' + #13#10 +
'SGreaterOrEqual=maior ou igual a' + #13#10 +
'SGreaterThan=maior que' + #13#10 +
'SGroupingFields=Campos para agrupamento' + #13#10 +
'SImportQueriesFromFile=Importar consultas de arquivo' + #13#10 +
'SImportQueryFromTargetDataset=Importar consulta do Dataset' + #13#10 +
'SImportQueryFromTargetMetaSQL=Importar consulta do Meta SQL' + #13#10 +
'SInclude=Incluir' + #13#10 +
'SIncludeANewItem=incluir um novo item' + #13#10 +
'SIncorrectGrammarLiteralString=Gramática incorreta. String literal não terminada em "%s"' + #13#10 +
'SIncorrectGrammarSubexpressionEmpty=Gramática incorreta. Subexpressão está vazia em "%s"' + #13#10 +
'SIncorrectGrammarSubexpressionNotTerminated=Gramática incorreta. Subexpressão não terminada em "%s"' + #13#10 +
'SIndexOutOfBounds=Índice fora da faixa' + #13#10 +
'SInvalidFieldType=Tipo de campo inválido' + #13#10 +
'SInvalidIncludedInputBuffer=Buffer de leitura incluído inválido. Cada nó deve iniciar e terminar no mesmo buffer' + #13#10 +
'SInvalidMetaSQL=Meta SQL inválido:' + #13#10 +
'SInvalidSQLForQueryCombo=SQL inválida para query interna do TatQueryCombo' + #13#10 +
'SInvalidQueryFirstSecondFields=Consulta inválida. O primeiro campo deve ser a chave e o segundo a legenda' + #13#10 +
'SItemSets=item "%s" define' + #13#10 +
'SJoinConditionEmpty=Condição de junção está vazia' + #13#10 +
'SJoinConditionError=Erro na condição de junção:' + #13#10 +
'SLessOrEqual=menor ou igual a' + #13#10 +
'SLessThan=menor que' + #13#10 +
'SLike=similar a' + #13#10 +
'SMainConditions=Condições principais' + #13#10 +
'SMax=Máximo de' + #13#10 +
'SMin=Mínimo de' + #13#10 +
'SMonth=mês' + #13#10 +
'SNaoPossivelInserirSubstring=Não é possível inserir uma substring no nó "%s", porque ela pertence a seu sub-nó %d ("%s")' + #13#10 +
'SNaoPossivelModificarSubstring=Não é possível modificar a substring "%s" do nó "%s", porque ela pertence a seu sub-nó %d ("%s")' + #13#10 +
'SNestedConditions=Condições aninhadas...' + #13#10 +
'SNestedSubconditions=Subcondições aninhadas' + #13#10 +
'SNewCheckItem=novo item de marcação' + #13#10 +
'SNewChooseItem=novo item de escolha' + #13#10 +
'SNewCondition=nova condição' + #13#10 +
'SNewEditor=novo editor' + #13#10 +
'SNewField=novo campo' + #13#10 +
'SNewGroupField=novo campo de agrupamento' + #13#10 +
'SNewOrderField=novo campo de ordenação' + #13#10 +
'SNewParameterAssignment=nova atribuição de parâmetro' + #13#10 +
'SNewQuery=&Nova consulta...' + #13#10 +
'SNewTable=nova tabela' + #13#10 +
'SNewVisualQueryTitle=(Nova consulta visual)' + #13#10 +
'SNone=(nenhum)' + #13#10 +
'SNotEnoughTableLinks=Uma ou mais tabelas não ligadas' + #13#10 +
'SNotImplemented=Não implementado' + #13#10 +
'SNow=agora' + #13#10 +
'SNull=nulo' + #13#10 +
'SNullNode=Nó nulo' + #13#10 +
'SOff=inativo' + #13#10 +
'SOK=OK' + #13#10 +
'SOr=Ou' + #13#10 +
'SOrderingFields=Campos de ordenação' + #13#10 +
'SOrNot=Ou não' + #13#10 +
'SParamCaptionNotSpecified=Legenda do parâmetro não especificada' + #13#10 +
'SParameter=parâmetro' + #13#10 +
'SParameterEditors=Editores de parâmetro' + #13#10 +
'SParameterTo=parameter: %s para "%s"' + #13#10 +
'SParamNameNotIndicated=Nome do parâmetro não indicado' + #13#10 +
'SParamNameNotReferFieldComparingCondition=Nome do parâmetro não se refere a uma condição de comparação de campos' + #13#10 +
'SParamNameNotValid=Nome do parâmetro é inválido.' + #13#10 +
'SQueryAlreadyExists=Consulta "%s" já existe. Deseja sobrescrever?' + #13#10 +
'SQueryDefinitionFile=Arquivo de definições de consulta' + #13#10 +
'SQueryEditorForParameter=Editor para o parâmetro: %s' + #13#10 +
'SQueryListEditor=Editor de lista de consulta' + #13#10 +
'SQueryTitle=Título da consulta' + #13#10 +
'SSaveCurrentQuery=Salvar consulta atual na lista de consultas' + #13#10 +
'SSelectDirectory=Selecionar diretório' + #13#10 +
'SSetContinueOnRemarksShouldOnlyBeCalled=Erro interno' + #13#10 +
'SSetCurrentInputPosShouldOnlyBeCalled=Erro interno' + #13#10 +
'SSetCurrentMaxInputPosShouldOnlyBeCalled=Erro interno' + #13#10 +
'SSetTableAlias=Definir apelido da tabela' + #13#10 +
'SShowSQL=Exibir SQL' + #13#10 +
'SSingleField=Campo individual' + #13#10 +
'SSingleTable=Tabela individual' + #13#10 +
'SSourceTables=Tabelas de origem' + #13#10 +
'SSQLIs=SQL é:' + #13#10 +
'SStartingWith=começando com' + #13#10 +
'SSum=Soma de' + #13#10 +
'SSyntaxErrorAtRow=Erro de sintaxe na linha %d caracter %d' + #13#10 +
'SSyntaxOK=Sintaxe OK!' + #13#10 +
'STable=Tabela' + #13#10 +
'STableAliasAlreadyIncluded=Apelido "%s" já foi incluído em outra tabela no Meta SQL' + #13#10 +
'STableAliasEmpty=Apelido da tabela está vazio' + #13#10 +
'STableAliasJoinedConditioned=%s apelido %s com junção %s das tabelas acima, condicionada por' + #13#10 +
'STableJoinHandlingFailure=Falha na manipulação de junção de tabelas' + #13#10 +
'STableLinkedToAnother=Tabela ligada a outra' + #13#10 +
'STableNameEmpty=Nome da tabela está vazio' + #13#10 +
'STableNotIndicated=Tabela não indicada' + #13#10 +
'STargetDatasetNotSupported=Dataset destino não compatível com o componente TatDatabase corrente.' + #13#10 +
'STentativaAcessarPosicaoInexistente=Tentativa de acessar uma posição inexistente no fonte' + #13#10 +
'STentativaInserirSubstring=Tentativa de inserir uma substring fora do nó "%s"' + #13#10 +
'STentativaModificarSubstring=Tentativa de modificar uma substring não pertinente ao nó "%s"' + #13#10 +
'STitled=título' + #13#10 +
'SToday=hoje' + #13#10 +
'STokenDoesNotContainSubnode="%s" não contém o sub-nó %d' + #13#10 +
'STokenIsNotNode="%s" não é um nó %s' + #13#10 +
'STrue=Sim' + #13#10 +
'SUndefinedValue=indefinido' + #13#10 +
'SValue=valor' + #13#10 +
'SValuesAppliedNoItemSelected=Valores a aplicar quando nenhum item estiver selecionado:' + #13#10 +
'SValuesAppliedItemSelected=Valores a aplicar quando o item "%s" estiver selecionado:' + #13#10 +
'SVisualQueryEditor=Editor de consulta visual' + #13#10 +
'SWhen=Quando' + #13#10 +
'SWhenNot=Quando não' + #13#10 +
'SWith=comum' + #13#10 +
'SYear=ano' + #13#10 +
'SYouMustCompleteUndefinedItem=Você deve completar a definição do item indefinido para incluir um novo' + #13#10 +
'SYouMustSpecifyTargetDataset=Você deve especificar a propriedade TargetDataset para importar a consulta' + #13#10 +
'SYouMustSpecifyTargetMetaSQL=Você deve especificar a propriedade TargetMetaSQL para importar a consulta' + #13#10 +
'' + #13#10 +
'[atMetaSQLConditionEditor]' + #13#10 +
'fmMetaSQLConditionEditor.Label2.Caption=Valor' + #13#10 +
'fmMetaSQLConditionEditor.lbLinkType.Caption=Operador' + #13#10 +
'fmMetaSQLConditionEditor.Label1.Caption=Apelido do campo' + #13#10 +
'fmMetaSQLConditionEditor.Label3.Caption=Nome da condição' + #13#10 +
'fmMetaSQLConditionEditor.Label8.Caption=Tipo da condição' + #13#10 +
'fmMetaSQLConditionEditor.Label7.Caption=Expressão' + #13#10 +
'fmMetaSQLConditionEditor.Label4.Caption=Operador das subcondições' + #13#10 +
'fmMetaSQLConditionEditor.lvItems.Items0.Caption=Nome da condição' + #13#10 +
'fmMetaSQLConditionEditor.lvItems.Items1.Caption=Apelido do campo' + #13#10 +
'fmMetaSQLConditionEditor.lvItems.Items2.Caption=Operador' + #13#10 +
'fmMetaSQLConditionEditor.lvItems.Items3.Caption=Valor' + #13#10 +
'fmMetaSQLConditionEditor.lvItems.Items4.Caption=Conector' + #13#10 +
'fmMetaSQLConditionEditor.lvItems.Items5.Caption=Tipo da condição' + #13#10 +
'fmMetaSQLConditionEditor.lvItems.Items6.Caption=Expressão' + #13#10 +
'' + #13#10 +
'[atMetaSQLConditionForm]' + #13#10 +
'fmMetaSQLConditionForm.Self.Caption=Editor de condições' + #13#10 +
'' + #13#10 +
'[atmetasqlcustomeditor]' + #13#10 +
'fmMetaSQLCustomEditor.btInsert.Caption=&Salvar' + #13#10 +
'fmMetaSQLCustomEditor.acNew.Caption=&Novo' + #13#10 +
'fmMetaSQLCustomEditor.acInsert.Caption=&Inserir' + #13#10 +
'fmMetaSQLCustomEditor.acCancel.Caption=&Cancelar' + #13#10 +
'fmMetaSQLCustomEditor.acEdit.Caption=&Editar' + #13#10 +
'fmMetaSQLCustomEditor.acClearItems.Caption=Limpar todos os itens' + #13#10 +
'fmMetaSQLCustomEditor.acDelete.Caption=E&xcluir' + #13#10 +
'' + #13#10 +
'[atMetaSQLFieldEditor]' + #13#10 +
'fmMetaSQLFieldEditor.Label1.Caption=Legenda' + #13#10 +
'fmMetaSQLFieldEditor.Label2.Caption=Apelido da tabela' + #13#10 +
'fmMetaSQLFieldEditor.Label3.Caption=Nome do campo' + #13#10 +
'fmMetaSQLFieldEditor.Label4.Caption=Função de agrupamento' + #13#10 +
'fmMetaSQLFieldEditor.Label5.Caption=Tipo de dado' + #13#10 +
'fmMetaSQLFieldEditor.Label6.Caption=Apelido do campo' + #13#10 +
'fmMetaSQLFieldEditor.Label7.Caption=Expressão do campo' + #13#10 +
'fmMetaSQLFieldEditor.Label8.Caption=Tipo da expressão' + #13#10 +
'fmMetaSQLFieldEditor.Label10.Caption=Visível' + #13#10 +
'fmMetaSQLFieldEditor.lbOptions.Caption=Opções' + #13#10 +
'fmMetaSQLFieldEditor.lvItems.Items0.Caption=Apelido do campo' + #13#10 +
'fmMetaSQLFieldEditor.lvItems.Items1.Caption=Apelido da tabela' + #13#10 +
'fmMetaSQLFieldEditor.lvItems.Items2.Caption=Nome do campo' + #13#10 +
'fmMetaSQLFieldEditor.lvItems.Items3.Caption=Tipo de dado' + #13#10 +
'fmMetaSQLFieldEditor.lvItems.Items4.Caption=Legenda' + #13#10 +
'fmMetaSQLFieldEditor.lvItems.Items5.Caption=Função de agrupamento' + #13#10 +
'fmMetaSQLFieldEditor.lvItems.Items6.Caption=Expressão' + #13#10 +
'fmMetaSQLFieldEditor.lvItems.Items7.Caption=Expressão do campo' + #13#10 +
'fmMetaSQLFieldEditor.lvItems.Items8.Caption=Visível' + #13#10 +
'fmMetaSQLFieldEditor.lvItems.Items9.Caption=Oculto para o usuário' + #13#10 +
'fmMetaSQLFieldEditor.lvItems.Items10.Caption=Sempre na consulta' + #13#10 +
'fmMetaSQLFieldEditor.lvItems.Items11.Caption=Pode ordenar por' + #13#10 +
'fmMetaSQLFieldEditor.lvItems.Items12.Caption=Pode usar em condições' + #13#10 +
'fmMetaSQLFieldEditor.acAppendDataset.Caption=&Acrescenter do dataset' + #13#10 +
'fmMetaSQLFieldEditor.acAppendTable.Caption=Acrescentar da &tabela' + #13#10 +
'fmMetaSQLFieldEditor.acTableAlias.Caption=Definir apelido da tabela' + #13#10 +
'fmMetaSQLFieldEditor.ldPickDataset.CancelCaption=Cancelar' + #13#10 +
'fmMetaSQLFieldEditor.ldPickDataset.OkCaption=OK' + #13#10 +
'fmMetaSQLFieldEditor.ldPickDataset.Title=Escolher dataset' + #13#10 +
'' + #13#10 +
'[atMetaSQLForm]' + #13#10 +
'fmMetaSQLEditor.Self.Caption=Editor de Meta SQL' + #13#10 +
'fmMetaSQLEditor.TabControl1.Tabs0=Tabelas' + #13#10 +
'fmMetaSQLEditor.TabControl1.Tabs1=Campos' + #13#10 +
'fmMetaSQLEditor.TabControl1.Tabs2=Junções' + #13#10 +
'fmMetaSQLEditor.TabControl1.Tabs3=Condições' + #13#10 +
'fmMetaSQLEditor.TabControl1.Tabs4=Ordenação' + #13#10 +
'fmMetaSQLEditor.TabControl1.Tabs5=Agrupamento' + #13#10 +
'fmMetaSQLEditor.TabControl1.Tabs6=SQL' + #13#10 +
'fmMetaSQLEditor.TabControl1.Tabs7=Dados' + #13#10 +
'fmMetaSQLEditor.Label1.Caption=&Banco de dados:' + #13#10 +
'fmMetaSQLEditor.cbSaveDB.Caption=&Salvar o último banco de dados usado' + #13#10 +
'fmMetaSQLEditor.acNextTab.Caption=Próxima aba' + #13#10 +
'fmMetaSQLEditor.acPreviousTab.Caption=Aba anterior' + #13#10 +
'fmMetaSQLEditor.acImportFromSQL.Caption=Importar da SQL' + #13#10 +
'' + #13#10 +
'[atMetaSQLGroupEditor]' + #13#10 +
'fmMetaSQLGroupEditor.Label2.Caption=Agrupar pelo campo' + #13#10 +
'fmMetaSQLGroupEditor.lvItems.Items0.Caption=Agrupar pelo campo' + #13#10 +
'fmMetaSQLGroupEditor.lvItems.Items1.Caption=' + #13#10 +
'' + #13#10 +
'[atmetasqljoineditor]' + #13#10 +
'fmMetaSQLJoinEditor.Label2.Caption=Apelido da tabela relacionada' + #13#10 +
'fmMetaSQLJoinEditor.Label4.Caption=Tipo de ligação' + #13#10 +
'fmMetaSQLJoinEditor.Label1.Caption=Apelido da tabela primária' + #13#10 +
'fmMetaSQLJoinEditor.cbLinkType.Items0=Interna (inner join)' + #13#10 +
'fmMetaSQLJoinEditor.cbLinkType.Items1=Esquerda (left join)' + #13#10 +
'fmMetaSQLJoinEditor.cbLinkType.Items2=Direita (right join)' + #13#10 +
'fmMetaSQLJoinEditor.lvItems.Items0.Caption=Tabela primária' + #13#10 +
'fmMetaSQLJoinEditor.lvItems.Items1.Caption=Tabela relacionada' + #13#10 +
'fmMetaSQLJoinEditor.lvItems.Items2.Caption=Descrição da ligação' + #13#10 +
'fmMetaSQLJoinEditor.lvItems.Items3.Caption=Subcondições' + #13#10 +
'fmMetaSQLJoinEditor.acSubConditions.Caption=Editar &subcondições' + #13#10 +
'' + #13#10 +
'[atMetaSQLOrderEditor]' + #13#10 +
'fmMetaSQLOrderEditor.Label2.Caption=Ordenar pelo campo' + #13#10 +
'fmMetaSQLOrderEditor.Label4.Caption=Tipo de ordenação' + #13#10 +
'fmMetaSQLOrderEditor.cbSortType.Items0=crescente' + #13#10 +
'fmMetaSQLOrderEditor.cbSortType.Items1=decrescente' + #13#10 +
'fmMetaSQLOrderEditor.lvItems.Items0.Caption=Ordenar pelo campo' + #13#10 +
'fmMetaSQLOrderEditor.lvItems.Items1.Caption=Tipo de ordenação' + #13#10 +
'' + #13#10 +
'[atMetaSQLTableEditor]' + #13#10 +
'fmMetaSQLTableEditor.Label1.Caption=Nome da tabela' + #13#10 +
'fmMetaSQLTableEditor.Label2.Caption=Apelido da tabela' + #13#10 +
'fmMetaSQLTableEditor.lvItems.Columns0.Caption=Nome da tabela' + #13#10 +
'fmMetaSQLTableEditor.lvItems.Columns1.Caption=Apelido da tabela' + #13#10 +
'' + #13#10 +
'[atVisualQueryEditor]' + #13#10 +
'fmVisualQueryEditor.Self.Caption=Editando a consulta visual' + #13#10 +
'fmVisualQueryEditor.TabSheet1.Caption=&Visualizar consulta visual' + #13#10 +
'fmVisualQueryEditor.atVisualQuery1.MetaSqlDefs0.Title=(Nova consulta visual)' + #13#10 +
'fmVisualQueryEditor.Button1.Caption=&OK' + #13#10 +
'fmVisualQueryEditor.Button2.Caption=&Cancelar' + #13#10 +
'' + #13#10 +
'[fCheckListParamEditor]' + #13#10 +
'fmCheckListParamEditor.Self.Caption=Editor de parâmetro lista de marcação' + #13#10 +
'fmCheckListParamEditor.lbInfo.Caption=Este parâmetro permite ao usuário selecionar um ou mais itens em uma lista suspensa.\#13#10Cada item selecionado aplica todos os valores de parâmetro correspondentes à consulta. \#13#10Itens desmarcados desativam os parâmetros associados da consulta.' + #13#10 +
'' + #13#10 +
'[fChooseListParamEditor]' + #13#10 +
'fmChooseListParamEditor.Self.Caption=Editor de parâmetro lista de escolha' + #13#10 +
'fmChooseListParamEditor.lbInfo.Caption=Este parâmetro permite ao usuário selecionar um entre vários itens em uma lista suspensa.\#13#10O único item selecionado aplica todos os valores de parâmetro correspondentes à consulta.\#13#10Itens desmarcados desativam os parâmetros associados da consulta.' + #13#10 +
'' + #13#10 +
'[fCompareConditionEditor]' + #13#10 +
'fmCompareConditionEditor.Self.Caption=Condição de comparação' + #13#10 +
'fmCompareConditionEditor.Label1.Caption=Expressão:' + #13#10 +
'fmCompareConditionEditor.lbInfo.Caption=Esta condição representa uma comparação simples entre duas informações.\#13#10Um campo do banco de dados pode ser comparado a outro campo, a um valor individual ou a um parâmetro.' + #13#10 +
'' + #13#10 +
'[fCustomConditionEditor]' + #13#10 +
'fmCustomConditionEditor.Self.Caption=Editor de condição' + #13#10 +
'fmCustomConditionEditor.Label3.Caption=Conector:' + #13#10 +
'fmCustomConditionEditor.edLogicOper.Items0=Campo 1' + #13#10 +
'fmCustomConditionEditor.edLogicOper.Items1=Campo 2' + #13#10 +
'fmCustomConditionEditor.edLogicOper.Items2=Campo exemplo' + #13#10 +
'' + #13#10 +
'[fcustomeditor]' + #13#10 +
'fmCustomEditor.Self.Caption=fmCustomEditor' + #13#10 +
'fmCustomEditor.btOk.Caption=&OK' + #13#10 +
'fmCustomEditor.btCancel.Caption=&Cancelar' + #13#10 +
'fmCustomEditor.lbInfo.Caption=' + #13#10 +
'' + #13#10 +
'[fCustomFieldEditor]' + #13#10 +
'fmCustomFieldEditor.Self.Caption=Editor de campo' + #13#10 +
'' + #13#10 +
'[fCustomGroupEditor]' + #13#10 +
'fmCustomGroupEditor.Self.Caption=Campo de agrupamento' + #13#10 +
'fmCustomGroupEditor.Label2.Caption=Expressão do campo:' + #13#10 +
'fmCustomGroupEditor.lbInfo.Caption=Este campo será usado para separar funções de agregação. Geralmente, todos os campos visívels que não possuem função de agregação devem ser agrupados assim.' + #13#10 +
'' + #13#10 +
'[fCustomListParamEditor]' + #13#10 +
'fmCustomListParamEditor.Self.Caption=Editor de parâmetro lista' + #13#10 +
'fmCustomListParamEditor.lbParamValues.Caption=Parâmetros de condição correspondentes:' + #13#10 +
'fmCustomListParamEditor.Label2.Caption=Lista de escolha:' + #13#10 +
'fmCustomListParamEditor.edParamValues.Items0.Caption=Valor' + #13#10 +
'fmCustomListParamEditor.edParamValues.Items1.Caption=Nome do parâmetro' + #13#10 +
'fmCustomListParamEditor.edListItems.Items0.Caption=Texto do item' + #13#10 +
'fmCustomListParamEditor.lbInfo.Caption=' + #13#10 +
'' + #13#10 +
'[fCustomOrderEditor]' + #13#10 +
'fmCustomOrderEditor.Self.Caption=Campo de ordenação' + #13#10 +
'fmCustomOrderEditor.Label2.Caption=Expressão do campo:' + #13#10 +
'fmCustomOrderEditor.Label4.Caption=Direção da ordenação:' + #13#10 +
'fmCustomOrderEditor.edAggregation.Items0=Crescente' + #13#10 +
'fmCustomOrderEditor.edAggregation.Items1=Decrescente' + #13#10 +
'fmCustomOrderEditor.lbInfo.Caption=Este campo pode estar sozinho ou combinado com outros para especificar um critério de ordenação sobre o resultado da consulta.' + #13#10 +
'' + #13#10 +
'[fCustomParamEditor]' + #13#10 +
'fmCustomParamEditor.Self.Caption=Editor de parâmetro' + #13#10 +
'fmCustomParamEditor.Label5.Caption=Caption:' + #13#10 +
'' + #13#10 +
'[fCustomTableEditor]' + #13#10 +
'fmCustomTableEditor.Self.Caption=Tabela da consulta' + #13#10 +
'fmCustomTableEditor.Label1.Caption=Nome da tabela:' + #13#10 +
'fmCustomTableEditor.Label2.Caption=Apelido da tabela:' + #13#10 +
'fmCustomTableEditor.Label4.Caption=Tipo de junção:' + #13#10 +
'fmCustomTableEditor.edJoinType.Items0=(sem junção)' + #13#10 +
'fmCustomTableEditor.edJoinType.Items1=Interna (inner join)' + #13#10 +
'fmCustomTableEditor.edJoinType.Items2=Esquerda (left join)' + #13#10 +
'fmCustomTableEditor.edJoinType.Items3=Direita (right join)' + #13#10 +
'fmCustomTableEditor.Label3.Caption=Condição de junção:' + #13#10 +
'fmCustomTableEditor.lbInfo.Caption=A tabela indicada aqui é uma fonte de dados para a consulta. Uma ou mais tabelas podem ser ligadas entre si para construir uma consulta.\#13#10Condição de junção é usada para ligar esta tabela a outras relacionadas.' + #13#10 +
'' + #13#10 +
'[fDistinctListParamEditor]' + #13#10 +
'fmDistinctListParamEditor.Self.Caption=Editor de parâmetro lista distinta' + #13#10 +
'fmDistinctListParamEditor.Label2.Caption=Nome do parâmetro:' + #13#10 +
'fmDistinctListParamEditor.lbInfo.Caption=Este parâmetro retorna ao usuário uma lista de todos os valores distintos contidos na tabela relacionada. A tabela usada é a que contém o campo comparado a este parâmetro.' + #13#10 +
'' + #13#10 +
'[fExpressionConditionEditor]' + #13#10 +
'fmExpressionConditionEditor.Self.Caption=Condição de expressão' + #13#10 +
'fmExpressionConditionEditor.Label5.Caption=Expressão:' + #13#10 +
'fmExpressionConditionEditor.lbInfo.Caption=Esta condição pode ser representada por qualquer expressão lógica válida no Meta SQL. Nomes de parâmetros podem ser usados, prefixados por dois-pontos.' + #13#10 +
'' + #13#10 +
'[fExpressionFieldEditor]' + #13#10 +
'fmExpressionFieldEditor.Self.Caption=Campo de expressão' + #13#10 +
'fmExpressionFieldEditor.Label4.Caption=Agregação:' + #13#10 +
'fmExpressionFieldEditor.edAggregation.Items0=(nenhum)' + #13#10 +
'fmExpressionFieldEditor.edAggregation.Items1=Quantidade' + #13#10 +
'fmExpressionFieldEditor.edAggregation.Items2=Soma' + #13#10 +
'fmExpressionFieldEditor.edAggregation.Items3=Máximo' + #13#10 +
'fmExpressionFieldEditor.edAggregation.Items4=Mínimo' + #13#10 +
'fmExpressionFieldEditor.edAggregation.Items5=Média' + #13#10 +
'fmExpressionFieldEditor.Label6.Caption=Expressão:' + #13#10 +
'fmExpressionFieldEditor.Label3.Caption=Apelido do campo:' + #13#10 +
'fmExpressionFieldEditor.Label5.Caption=Legenda:' + #13#10 +
'fmExpressionFieldEditor.Label7.Caption=Tipo de dado:' + #13#10 +
'fmExpressionFieldEditor.edDataType.Items0=(nenhum)' + #13#10 +
'fmExpressionFieldEditor.edDataType.Items1=Quantidade' + #13#10 +
'fmExpressionFieldEditor.edDataType.Items2=Soma' + #13#10 +
'fmExpressionFieldEditor.edDataType.Items3=Máximo' + #13#10 +
'fmExpressionFieldEditor.edDataType.Items4=Mínimo' + #13#10 +
'fmExpressionFieldEditor.edDataType.Items5=Média' + #13#10 +
'fmExpressionFieldEditor.lbInfo.Caption=Este campo atua como uma informação calculada, e sua expres~sao pode ser qualquer expressão de campo válida no Meta SQL.' + #13#10 +
'' + #13#10 +
'[fFreeEditParamEditor]' + #13#10 +
'fmFreeEditParamEditor.Self.Caption=Editor de parâmetro livre' + #13#10 +
'fmFreeEditParamEditor.Label2.Caption=Nome do parâmetro:' + #13#10 +
'fmFreeEditParamEditor.lbInfo.Caption=Este editor permite ao usuário digitar valores correspondentes aos parâmetros usados pelas condições da consulta.' + #13#10 +
'' + #13#10 +
'[fQueryEditor]' + #13#10 +
'fmQueryEditor.Self.Caption=Consulta para editor de parâmetro' + #13#10 +
'fmQueryEditor.VisualQuery.MetaSqlDefs0.Title=(Nova consulta visual)' + #13#10 +
'fmQueryEditor.Button1.Caption=&OK' + #13#10 +
'fmQueryEditor.Button2.Caption=&Cancel' + #13#10 +
'' + #13#10 +
'[fQueryListParamEditor]' + #13#10 +
'fmQueryListParamEditor.Self.Caption=Editor de parâmetro lista de consulta' + #13#10 +
'fmQueryListParamEditor.Label2.Caption=Nome do parâmetro:' + #13#10 +
'fmQueryListParamEditor.Label1.Caption=Meta SQL:' + #13#10 +
'fmQueryListParamEditor.btMetaSql.Caption=Assistente >>' + #13#10 +
'fmQueryListParamEditor.lbInfo.Caption=Este parâmetro permite ao usuário selecionar um valor de uma lista suspensa. Os itens listados são obtidos desta consulta Meta SQL. O primeiro campo da consulta deve corresponder ao campo associado com este parâmetro.' + #13#10 +
'' + #13#10 +
'[fSingleFieldEditor]' + #13#10 +
'fmSingleFieldEditor.Self.Caption=Campo individual' + #13#10 +
'fmSingleFieldEditor.Label1.Caption=Tabela:' + #13#10 +
'fmSingleFieldEditor.Label2.Caption=Nome do campo:' + #13#10 +
'fmSingleFieldEditor.Label4.Caption=Agregação:' + #13#10 +
'fmSingleFieldEditor.edAggregation.Items0=(nenhum)' + #13#10 +
'fmSingleFieldEditor.edAggregation.Items1=Quantidade' + #13#10 +
'fmSingleFieldEditor.edAggregation.Items2=Soma' + #13#10 +
'fmSingleFieldEditor.edAggregation.Items3=Máximo' + #13#10 +
'fmSingleFieldEditor.edAggregation.Items4=Mínimo' + #13#10 +
'fmSingleFieldEditor.edAggregation.Items5=Média' + #13#10 +
'fmSingleFieldEditor.Label3.Caption=Apelido do campo:' + #13#10 +
'fmSingleFieldEditor.Label5.Caption=Legenda:' + #13#10 +
'fmSingleFieldEditor.Label7.Caption=Tipo de dado:' + #13#10 +
'fmSingleFieldEditor.edDataType.Items0=(nenhum)' + #13#10 +
'fmSingleFieldEditor.edDataType.Items1=Quantidade' + #13#10 +
'fmSingleFieldEditor.edDataType.Items2=Soma' + #13#10 +
'fmSingleFieldEditor.edDataType.Items3=Máximo' + #13#10 +
'fmSingleFieldEditor.edDataType.Items4=Mínimo' + #13#10 +
'fmSingleFieldEditor.edDataType.Items5=Média' + #13#10 +
'fmSingleFieldEditor.lbInfo.Caption=Este campo é uma expressão simples para uma informação.\#13#10Apenas um campo do banco de dados pode ser indicado aqui.' + #13#10 +
'' + #13#10 +
'[fSubconditionsEditor]' + #13#10 +
'fmSubconditionsEditor.Self.Caption=Coleção de condições' + #13#10 +
'fmSubconditionsEditor.lbInfo.Caption=Esta condição é um grupo de outras subcondições.\#13#10A avaliação de suas subcondições depende desta condição.' + #13#10 +
'' + #13#10 +
'[ShowSQLForm]' + #13#10 +
'fmShowSQL.Self.Caption=Exibir SQL' + #13#10 +
'fmShowSQL.Button1.Caption=Fechar' + #13#10 +
'' + #13#10 +
'';

initialization
  _ResAddStrings(LanguageStr);

end.
