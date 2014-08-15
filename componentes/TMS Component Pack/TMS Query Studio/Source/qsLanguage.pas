unit qsLanguage;

interface

implementation

uses
  qsRes;

const LanguageStr = 
'[strings]' + #13#10 +
'SAfter=after' + #13#10 +
'SAggregationFunctionNotAllowed=Aggregation function "%s" not allowed with data type "%s"' + #13#10 +
'SAlias=alias' + #13#10 +
'SAmbiguousError=Ambiguos error' + #13#10 +
'SAnd=And' + #13#10 +
'SAndNot=And not' + #13#10 +
'SAnyFile=Any file' + #13#10 +
'SAs=as' + #13#10 +
'SAscending=ascending' + #13#10 +
'SAutomaticListEditor=Automatic-list editor' + #13#10 +
'SAvg=Average of' + #13#10 +
'SBefore=before' + #13#10 +
'SBring=Bring' + #13#10 +
'SCancel=Cancel' + #13#10 +
'SCannotClearParser=Cannot clear parser when parsing' + #13#10 +
'SCapabilityNotSupportedJoins=Capability not supported on join conditions linking table "%s" to "%s"' + #13#10 +
'SCheckListEditor=Check-list editor' + #13#10 +
'SChooseListEditor=Choose-list editor' + #13#10 +
'SCompareFieldToAnother=Compare a field to another field' + #13#10 +
'SCompareFieldToParametricValue=Compare a field to a parametric value' + #13#10 +
'SCompareFieldToSpecificValue=Compare a field to a specific value' + #13#10 +
'SConditionExpressionNotSpecified=Condition expression is not specified' + #13#10 +
'SConditionRightSideNotSpecified=Condition right side is not specified' + #13#10 +
'SConfirmChangeLogicalConnector=Confirm to change logical conector of the grouped conditions?' + #13#10 +
'SConfirmClearAllItems=Clear all items?' + #13#10 +
'SConfirmDeleteSelectedItems=Are you sure you want to delete selected item(s)?' + #13#10 +
'SConfirmExcludeAllDefinitions=Confirm to exclude all definitions of query "%s"?' + #13#10 +
'SConfirmUpdatingMetaSQL=Confirm updating MetaSQL component with current SQL statement?' + #13#10 +
'SContaining=containing' + #13#10 +
'SCount=Count' + #13#10 +
'SCustomExpression=Custom expression' + #13#10 +
'SCustomExpressionSQLSyntax=Custom expression (SQL syntax)' + #13#10 +
'SDatabaseNameNotInformed=Database name not informed' + #13#10 +
'SDataFields=Data fields' + #13#10 +
'SDataTypeNotIndicated=Data type not indicated' + #13#10 +
'SDate=date' + #13#10 +
'SDay=day' + #13#10 +
'SDeleteThisQuery=&Delete this query' + #13#10 +
'SDescending=descending' + #13#10 +
'SDifferent=different' + #13#10 +
'SDropdownAutomatic=dropdown automatic-list' + #13#10 +
'SDropdownCheck=dropdown check-list' + #13#10 +
'SDropdownChoose=dropdown choose-list' + #13#10 +
'SDropdownQuery=dropdown query-list' + #13#10 +
'SDuplicateThisQuery=Du&plicate this query as...' + #13#10 +
'SEditMetaSQL=Edit Meta SQL' + #13#10 +
'SEditParameterEditorTitled=Edit parameter:%s with %s editor, titled "%s"' + #13#10 +
'SEmpty=empty' + #13#10 +
'SEndingWith=ending with' + #13#10 +
'SEnterTableAlias=Enter table alias:' + #13#10 +
'SEqual=equal' + #13#10 +
'SErrorOpeningQueryCombo=Error opening TatQueryCombo internal query:' + #13#10 +
'SErroSintaxeLinhaColuna=Syntax error at row %d, col %d of Meta SQL:' + #13#10 +
'SExportQueriesToFile=Export queries to file' + #13#10 +
'SExpression=Expression' + #13#10 +
'SExpressionAliasTitled=Expression %s alias %s, titled "%s"' + #13#10 +
'SExpressionFieldNotSpecified=Expression field is not specified' + #13#10 +
'SExpressionOperatorNotSpecified=Expression operator is not specified' + #13#10 +
'SFalse=False' + #13#10 +
'SField=field' + #13#10 +
'SFieldAliasNotIndicated=Field alias not indicated' + #13#10 +
'SFieldAliasNotUnique=Field alias is not unique on meta-sql' + #13#10 +
'SFieldCalculatedByAnExpression=Field calculated by an expression' + #13#10 +
'SFieldComparing=Field comparing' + #13#10 +
'SFieldExpressionNotIndicated=Field expression not indicated' + #13#10 +
'SFieldKindAvg=Average of (evaluate the field value average on a group of records)' + #13#10 +
'SFieldKindBring=Bring (bring individual field value from database table)' + #13#10 +
'SFieldKindCount=Count (count field value occurencies on a group of records)' + #13#10 +
'SFieldKindMax=Maximum of (evaluate the maximum field value on a group of records)' + #13#10 +
'SFieldKindMin=Minimum of (evaluate the minum field value on a group of record)' + #13#10 +
'SFieldKindSum=Sum of (compute the sum of field value on a group of records)' + #13#10 +
'SFieldNameNotIndicated=Field name not indicated' + #13#10 +
'SFieldNotIndicated=Field not indicated' + #13#10 +
'SFilterConditions=Filter conditions' + #13#10 +
'SFreeTyping=free typing' + #13#10 +
'SFreeTypingEditor=Free typing editor' + #13#10 +
'SGreaterOrEqual=greater or equal' + #13#10 +
'SGreaterThan=greater than' + #13#10 +
'SGroupingFields=Grouping fields' + #13#10 +
'SImportQueriesFromFile=Import queries from file' + #13#10 +
'SImportQueryFromTargetDataset=Import query from target dataset' + #13#10 +
'SImportQueryFromTargetMetaSQL=Import query from target meta-sql' + #13#10 +
'SInclude=Include' + #13#10 +
'SIncludeANewItem=include a new item' + #13#10 +
'SIncorrectGrammarLiteralString=Incorrect grammar. Literal string not terminated on "%s"' + #13#10 +
'SIncorrectGrammarSubexpressionEmpty=Incorrect grammar. Subexpression is empty on "%s"' + #13#10 +
'SIncorrectGrammarSubexpressionNotTerminated=Incorrect grammar. Subexpression not terminated on "%s"' + #13#10 +
'SIndexOutOfBounds=Index out of bounds' + #13#10 +
'SInvalidFieldType=Invalid field type' + #13#10 +
'SInvalidIncludedInputBuffer=Invalid included input buffer. Each nodes must begin and end on the same input buffer' + #13#10 +
'SInvalidMetaSQL=Invalid Meta SQL:' + #13#10 +
'SInvalidSQLForQueryCombo=Invalid SQL for TatQueryCombo internal query' + #13#10 +
'SInvalidQueryFirstSecondFields=Invalid query. First field should be the key and the second field should be a caption' + #13#10 +
'SItemSets=item "%s" sets' + #13#10 +
'SJoinConditionEmpty=Join condition is empty' + #13#10 +
'SJoinConditionError=Join condition error:' + #13#10 +
'SLessOrEqual=less or equal' + #13#10 +
'SLessThan=less than' + #13#10 +
'SLike=like' + #13#10 +
'SMainConditions=Main conditions' + #13#10 +
'SMax=Maximum of' + #13#10 +
'SMin=Minimum of' + #13#10 +
'SMonth=month' + #13#10 +
'SNaoPossivelInserirSubstring=Cannot insert a substring into node "%s", because it belongs to its subnode %d ("%s")' + #13#10 +
'SNaoPossivelModificarSubstring=Cannot modify the substring "%s" in node "%s", because it belongs to its subnode %d ("%s")' + #13#10 +
'SNestedConditions=Nested conditions...' + #13#10 +
'SNestedSubconditions=Nested subconditions' + #13#10 +
'SNewCheckItem=new check item' + #13#10 +
'SNewChooseItem=new choose item' + #13#10 +
'SNewCondition=new condition' + #13#10 +
'SNewEditor=new editor' + #13#10 +
'SNewField=new field' + #13#10 +
'SNewGroupField=new group field' + #13#10 +
'SNewOrderField=new order field' + #13#10 +
'SNewParameterAssignment=new parameter assignment' + #13#10 +
'SNewQuery=&New query...' + #13#10 +
'SNewTable=new table' + #13#10 +
'SNewVisualQueryTitle=(New visual query)' + #13#10 +
'SNone=(none)' + #13#10 +
'SNotEnoughTableLinks=One or more tables not linked' + #13#10 +
'SNotImplemented=Not implemented' + #13#10 +
'SNow=now' + #13#10 +
'SNull=null' + #13#10 +
'SNullNode=Null node' + #13#10 +
'SOff=off' + #13#10 +
'SOK=OK' + #13#10 +
'SOr=Or' + #13#10 +
'SOrderingFields=Ordering fields' + #13#10 +
'SOrNot=Or not' + #13#10 +
'SParamCaptionNotSpecified=Param caption not specified' + #13#10 +
'SParameter=parameter' + #13#10 +
'SParameterEditors=Parameter editors' + #13#10 +
'SParameterTo=parameter: %s to "%s"' + #13#10 +
'SParamNameNotIndicated=Param name not indicated' + #13#10 +
'SParamNameNotReferFieldComparingCondition=Param name not refer to a field comparing condition' + #13#10 +
'SParamNameNotValid=Param name is not valid.' + #13#10 +
'SQueryAlreadyExists=Query "%s" already exists. Confirm overwriting?' + #13#10 +
'SQueryDefinitionFile=Query definition file' + #13#10 +
'SQueryEditorForParameter=Query editor for parameter: %s' + #13#10 +
'SQueryListEditor=Query-list editor' + #13#10 +
'SQueryTitle=Query title' + #13#10 +
'SSaveCurrentQuery=Save current query into query list' + #13#10 +
'SSelectDirectory=Select directory' + #13#10 +
'SSetContinueOnRemarksShouldOnlyBeCalled=SetContinueOnRemarks should only be called when processing input remarks' + #13#10 +
'SSetCurrentInputPosShouldOnlyBeCalled=SetCurrentInputPos should only be called when processing input remarks' + #13#10 +
'SSetCurrentMaxInputPosShouldOnlyBeCalled=SetCurrentMaxInputPos should only be called when processing input remarks' + #13#10 +
'SSetTableAlias=Set table alias' + #13#10 +
'SShowSQL=Show SQL' + #13#10 +
'SSingleField=Single field' + #13#10 +
'SSingleTable=Single table' + #13#10 +
'SSourceTables=Source tables' + #13#10 +
'SSQLIs=SQL is:' + #13#10 +
'SStartingWith=starting with' + #13#10 +
'SSum=Sum of' + #13#10 +
'SSyntaxErrorAtRow=Syntax error at row %d character %d' + #13#10 +
'SSyntaxOK=Syntax Ok!' + #13#10 +
'STable=Table' + #13#10 +
'STableAliasAlreadyIncluded=Table alias "%s" already included in meta-sql' + #13#10 +
'STableAliasEmpty=Table alias is empty' + #13#10 +
'STableAliasJoinedConditioned=%s alias %s joined %s above tables, conditioned by' + #13#10 +
'STableJoinHandlingFailure=Table join handling failure' + #13#10 +
'STableLinkedToAnother=Table linked to another' + #13#10 +
'STableNameEmpty=Table name is empty' + #13#10 +
'STableNotIndicated=Table not indicated' + #13#10 +
'STargetDatasetNotSupported=Target dataset not compatible with current TatDatabase component.' + #13#10 +
'STentativaAcessarPosicaoInexistente=Attempt to access a nonexistent position in the source' + #13#10 +
'STentativaInserirSubstring=Attempt to insert a substring out of the node "%s"' + #13#10 +
'STentativaModificarSubstring=Attempt to modify a substring not belonging to node "%s"' + #13#10 +
'STitled=titled' + #13#10 +
'SToday=today' + #13#10 +
'STokenDoesNotContainSubnode="%s" does not contain subnode %d''' + #13#10 +
'STokenIsNotNode="''%s" is not a %s node''' + #13#10 +
'STrue=True' + #13#10 +
'SUndefinedValue=undefined' + #13#10 +
'SValue=value' + #13#10 +
'SValuesAppliedNoItemSelected=Values to be applied when no item is selected:' + #13#10 +
'SValuesAppliedItemSelected=Values to be applied when item "%s" is selected:' + #13#10 +
'SVisualQueryEditor=Visual query editor' + #13#10 +
'SWhen=When' + #13#10 +
'SWhenNot=When not' + #13#10 +
'SWith=with' + #13#10 +
'SYear=year' + #13#10 +
'SYouMustCompleteUndefinedItem=You must complete the undefined item definition to add new one' + #13#10 +
'SYouMustSpecifyTargetDataset=You must specify TargetDataset property to import query' + #13#10 +
'SYouMustSpecifyTargetMetaSQL=You must specify TargetMetaSQL property to import query' + #13#10 +
'' + #13#10 +
'[atMetaSQLConditionEditor]' + #13#10 +
'fmMetaSQLConditionEditor.Label2.Caption=Value' + #13#10 +
'fmMetaSQLConditionEditor.lbLinkType.Caption=Operator' + #13#10 +
'fmMetaSQLConditionEditor.Label1.Caption=Field alias' + #13#10 +
'fmMetaSQLConditionEditor.Label3.Caption=Condition name' + #13#10 +
'fmMetaSQLConditionEditor.Label8.Caption=Condition type' + #13#10 +
'fmMetaSQLConditionEditor.Label7.Caption=Expression' + #13#10 +
'fmMetaSQLConditionEditor.Label4.Caption=Subconds operator' + #13#10 +
'fmMetaSQLConditionEditor.lvItems.Items0.Caption=Condition name' + #13#10 +
'fmMetaSQLConditionEditor.lvItems.Items1.Caption=Field alias' + #13#10 +
'fmMetaSQLConditionEditor.lvItems.Items2.Caption=Operator' + #13#10 +
'fmMetaSQLConditionEditor.lvItems.Items3.Caption=Value' + #13#10 +
'fmMetaSQLConditionEditor.lvItems.Items4.Caption=Connector' + #13#10 +
'fmMetaSQLConditionEditor.lvItems.Items5.Caption=Condition type' + #13#10 +
'fmMetaSQLConditionEditor.lvItems.Items6.Caption=Expression' + #13#10 +
'' + #13#10 +
'[atMetaSQLConditionForm]' + #13#10 +
'fmMetaSQLConditionForm.Self.Caption=Conditions editor' + #13#10 +
'' + #13#10 +
'[atmetasqlcustomeditor]' + #13#10 +
'fmMetaSQLCustomEditor.btInsert.Caption=&Save' + #13#10 +
'fmMetaSQLCustomEditor.acNew.Caption=&New' + #13#10 +
'fmMetaSQLCustomEditor.acInsert.Caption=&Insert' + #13#10 +
'fmMetaSQLCustomEditor.acCancel.Caption=&Cancel' + #13#10 +
'fmMetaSQLCustomEditor.acEdit.Caption=&Edit' + #13#10 +
'fmMetaSQLCustomEditor.acClearItems.Caption=Clear all items' + #13#10 +
'fmMetaSQLCustomEditor.acDelete.Caption=&Delete' + #13#10 +
'' + #13#10 +
'[atMetaSQLFieldEditor]' + #13#10 +
'fmMetaSQLFieldEditor.Label1.Caption=Display label' + #13#10 +
'fmMetaSQLFieldEditor.Label2.Caption=Table Alias' + #13#10 +
'fmMetaSQLFieldEditor.Label3.Caption=Field Name' + #13#10 +
'fmMetaSQLFieldEditor.Label4.Caption=Group function' + #13#10 +
'fmMetaSQLFieldEditor.Label5.Caption=Data type' + #13#10 +
'fmMetaSQLFieldEditor.Label6.Caption=Field Alias' + #13#10 +
'fmMetaSQLFieldEditor.Label7.Caption=Field expression' + #13#10 +
'fmMetaSQLFieldEditor.Label8.Caption=Expression type' + #13#10 +
'fmMetaSQLFieldEditor.Label10.Caption=Visible' + #13#10 +
'fmMetaSQLFieldEditor.lbOptions.Caption=Options' + #13#10 +
'fmMetaSQLFieldEditor.lvItems.Items0.Caption=Field alias' + #13#10 +
'fmMetaSQLFieldEditor.lvItems.Items1.Caption=Table alias' + #13#10 +
'fmMetaSQLFieldEditor.lvItems.Items2.Caption=Field Name' + #13#10 +
'fmMetaSQLFieldEditor.lvItems.Items3.Caption=Data type' + #13#10 +
'fmMetaSQLFieldEditor.lvItems.Items4.Caption=Display label' + #13#10 +
'fmMetaSQLFieldEditor.lvItems.Items5.Caption=Group function' + #13#10 +
'fmMetaSQLFieldEditor.lvItems.Items6.Caption=Expression' + #13#10 +
'fmMetaSQLFieldEditor.lvItems.Items7.Caption=Field expression' + #13#10 +
'fmMetaSQLFieldEditor.lvItems.Items8.Caption=Visible' + #13#10 +
'fmMetaSQLFieldEditor.lvItems.Items9.Caption=Hidden from user' + #13#10 +
'fmMetaSQLFieldEditor.lvItems.Items10.Caption=Always in select' + #13#10 +
'fmMetaSQLFieldEditor.lvItems.Items11.Caption=Can order by' + #13#10 +
'fmMetaSQLFieldEditor.lvItems.Items12.Caption=Can use in condition' + #13#10 +
'fmMetaSQLFieldEditor.acAppendDataset.Caption=&Append from dataset' + #13#10 +
'fmMetaSQLFieldEditor.acAppendTable.Caption=Append from &table' + #13#10 +
'fmMetaSQLFieldEditor.acTableAlias.Caption=Set table alias' + #13#10 +
'fmMetaSQLFieldEditor.ldPickDataset.CancelCaption=Cancel' + #13#10 +
'fmMetaSQLFieldEditor.ldPickDataset.OkCaption=Ok' + #13#10 +
'fmMetaSQLFieldEditor.ldPickDataset.Title=Choose dataset' + #13#10 +
'' + #13#10 +
'[atMetaSQLForm]' + #13#10 +
'fmMetaSQLEditor.Self.Caption=Meta SQL Editor' + #13#10 +
'fmMetaSQLEditor.TabControl1.Tabs0=Tables' + #13#10 +
'fmMetaSQLEditor.TabControl1.Tabs1=Fields' + #13#10 +
'fmMetaSQLEditor.TabControl1.Tabs2=Joins' + #13#10 +
'fmMetaSQLEditor.TabControl1.Tabs3=Conditions' + #13#10 +
'fmMetaSQLEditor.TabControl1.Tabs4=Order' + #13#10 +
'fmMetaSQLEditor.TabControl1.Tabs5=Group' + #13#10 +
'fmMetaSQLEditor.TabControl1.Tabs6=SQL' + #13#10 +
'fmMetaSQLEditor.TabControl1.Tabs7=Data result' + #13#10 +
'fmMetaSQLEditor.Label1.Caption=&Database:' + #13#10 +
'fmMetaSQLEditor.cbSaveDB.Caption=&Save last used database' + #13#10 +
'fmMetaSQLEditor.acNextTab.Caption=Next tab' + #13#10 +
'fmMetaSQLEditor.acPreviousTab.Caption=Previous tab' + #13#10 +
'fmMetaSQLEditor.acImportFromSQL.Caption=Import from SQL' + #13#10 +
'' + #13#10 +
'[atMetaSQLGroupEditor]' + #13#10 +
'fmMetaSQLGroupEditor.Label2.Caption=Group by field alias' + #13#10 +
'fmMetaSQLGroupEditor.lvItems.Items0.Caption=Group by field alias' + #13#10 +
'fmMetaSQLGroupEditor.lvItems.Items1.Caption=' + #13#10 +
'' + #13#10 +
'[atmetasqljoineditor]' + #13#10 +
'fmMetaSQLJoinEditor.Label2.Caption=Foreign table alias' + #13#10 +
'fmMetaSQLJoinEditor.Label4.Caption=Link type' + #13#10 +
'fmMetaSQLJoinEditor.Label1.Caption=Primary table alias' + #13#10 +
'fmMetaSQLJoinEditor.cbLinkType.Items0=Inner join' + #13#10 +
'fmMetaSQLJoinEditor.cbLinkType.Items1=Left join' + #13#10 +
'fmMetaSQLJoinEditor.cbLinkType.Items2=Right join' + #13#10 +
'fmMetaSQLJoinEditor.lvItems.Items0.Caption=Prim. table' + #13#10 +
'fmMetaSQLJoinEditor.lvItems.Items1.Caption=For. Table' + #13#10 +
'fmMetaSQLJoinEditor.lvItems.Items2.Caption=Link description' + #13#10 +
'fmMetaSQLJoinEditor.lvItems.Items3.Caption=SubConditions' + #13#10 +
'fmMetaSQLJoinEditor.acSubConditions.Caption=Edit &subconditions' + #13#10 +
'' + #13#10 +
'[atMetaSQLOrderEditor]' + #13#10 +
'fmMetaSQLOrderEditor.Label2.Caption=Order by field alias' + #13#10 +
'fmMetaSQLOrderEditor.Label4.Caption=Sort type' + #13#10 +
'fmMetaSQLOrderEditor.cbSortType.Items0=ascending' + #13#10 +
'fmMetaSQLOrderEditor.cbSortType.Items1=descending' + #13#10 +
'fmMetaSQLOrderEditor.lvItems.Items0.Caption=Order by field alias' + #13#10 +
'fmMetaSQLOrderEditor.lvItems.Items1.Caption=Sort type' + #13#10 +
'' + #13#10 +
'[atMetaSQLTableEditor]' + #13#10 +
'fmMetaSQLTableEditor.Label1.Caption=Table name' + #13#10 +
'fmMetaSQLTableEditor.Label2.Caption=Table Alias' + #13#10 +
'fmMetaSQLTableEditor.lvItems.Columns0.Caption=Table name' + #13#10 +
'fmMetaSQLTableEditor.lvItems.Columns1.Caption=Table alias' + #13#10 +
'' + #13#10 +
'[atVisualQueryEditor]' + #13#10 +
'fmVisualQueryEditor.Self.Caption=Editing the visual-query' + #13#10 +
'fmVisualQueryEditor.TabSheet1.Caption=&Visual-query preview' + #13#10 +
'fmVisualQueryEditor.atVisualQuery1.MetaSqlDefs0.Title=(New visual query)' + #13#10 +
'fmVisualQueryEditor.Button1.Caption=&Ok' + #13#10 +
'fmVisualQueryEditor.Button2.Caption=&Cancel' + #13#10 +
'' + #13#10 +
'[fCheckListParamEditor]' + #13#10 +
'fmCheckListParamEditor.Self.Caption=Check list parameter editor' + #13#10 +
'fmCheckListParamEditor.lbInfo.Caption=This parameter allow users to select one or more items on a drop down list editor.\#13#10Each selected item apply all corresponding param values to the query. \#13#10' + 'Unselected items deactivates associated parameter values from query.' + #13#10 +
'' + #13#10 +
'[fChooseListParamEditor]' + #13#10 +
'fmChooseListParamEditor.Self.Caption=Choose list parameter editor' + #13#10 +
'fmChooseListParamEditor.lbInfo.Caption=This parameter allow users to select one among several items on a drop down list editor.\#13#10The unique selected item apply all corresponding parameter values to the query.\#13#10' + 'Unselected items deactivates corresponding parameter values from query.' + #13#10 +
'' + #13#10 +
'[fCompareConditionEditor]' + #13#10 +
'fmCompareConditionEditor.Self.Caption=Query comparing condition' + #13#10 +
'fmCompareConditionEditor.Label1.Caption=Expression:' + #13#10 +
'fmCompareConditionEditor.lbInfo.Caption=This condition represents a single comparing of two informations.\#13#10A database field can be compared to another field, to a single value or to a parameter.' + #13#10 +
'' + #13#10 +
'[fCustomConditionEditor]' + #13#10 +
'fmCustomConditionEditor.Self.Caption=Custom condition editor' + #13#10 +
'fmCustomConditionEditor.Label3.Caption=Conector:' + #13#10 +
'fmCustomConditionEditor.edLogicOper.Items0=Field 1' + #13#10 +
'fmCustomConditionEditor.edLogicOper.Items1=Field 2' + #13#10 +
'fmCustomConditionEditor.edLogicOper.Items2=Sample field' + #13#10 +
'' + #13#10 +
'[fcustomeditor]' + #13#10 +
'fmCustomEditor.Self.Caption=fmCustomEditor' + #13#10 +
'fmCustomEditor.btOk.Caption=&Ok' + #13#10 +
'fmCustomEditor.btCancel.Caption=&Cancel' + #13#10 +
'fmCustomEditor.lbInfo.Caption=' + #13#10 +
'' + #13#10 +
'[fCustomFieldEditor]' + #13#10 +
'fmCustomFieldEditor.Self.Caption=Custom field editor' + #13#10 +
'' + #13#10 +
'[fCustomGroupEditor]' + #13#10 +
'fmCustomGroupEditor.Self.Caption=Query group field' + #13#10 +
'fmCustomGroupEditor.Label2.Caption=Field expression:' + #13#10 +
'fmCustomGroupEditor.lbInfo.Caption=This field will be used to break aggregation functions. Generally, all visible fields that have not aggregation function should be grouped like this.' + #13#10 +
'' + #13#10 +
'[fCustomListParamEditor]' + #13#10 +
'fmCustomListParamEditor.Self.Caption=Custom list parameter editor' + #13#10 +
'fmCustomListParamEditor.lbParamValues.Caption=Corresponding condition parameters:' + #13#10 +
'fmCustomListParamEditor.Label2.Caption=Drop down list:' + #13#10 +
'fmCustomListParamEditor.edParamValues.Items0.Caption=Value' + #13#10 +
'fmCustomListParamEditor.edParamValues.Items1.Caption=Param name' + #13#10 +
'fmCustomListParamEditor.edListItems.Items0.Caption=Item text' + #13#10 +
'fmCustomListParamEditor.lbInfo.Caption=' + #13#10 +
'' + #13#10 +
'[fCustomOrderEditor]' + #13#10 +
'fmCustomOrderEditor.Self.Caption=Query order field' + #13#10 +
'fmCustomOrderEditor.Label2.Caption=Field expression:' + #13#10 +
'fmCustomOrderEditor.Label4.Caption=Sort direction:' + #13#10 +
'fmCustomOrderEditor.edAggregation.Items0=Ascending' + #13#10 +
'fmCustomOrderEditor.edAggregation.Items1=Descending' + #13#10 +
'fmCustomOrderEditor.lbInfo.Caption=This field may be lonely or combined with others to specify a sorting criteria over the query result set.' + #13#10 +
'' + #13#10 +
'[fCustomParamEditor]' + #13#10 +
'fmCustomParamEditor.Self.Caption=Custom parameter editor' + #13#10 +
'fmCustomParamEditor.Label5.Caption=Caption:' + #13#10 +
'' + #13#10 +
'[fCustomTableEditor]' + #13#10 +
'fmCustomTableEditor.Self.Caption=Query table' + #13#10 +
'fmCustomTableEditor.Label1.Caption=Table name:' + #13#10 +
'fmCustomTableEditor.Label2.Caption=Table alias:' + #13#10 +
'fmCustomTableEditor.Label4.Caption=Join type:' + #13#10 +
'fmCustomTableEditor.edJoinType.Items0=(no join)' + #13#10 +
'fmCustomTableEditor.edJoinType.Items1=Inner join' + #13#10 +
'fmCustomTableEditor.edJoinType.Items2=Left outer join' + #13#10 +
'fmCustomTableEditor.edJoinType.Items3=Right outer join' + #13#10 +
'fmCustomTableEditor.Label3.Caption=Join condition:' + #13#10 +
'fmCustomTableEditor.lbInfo.Caption=Table indicated here is a data source for querying. One or more tables may be linked together to build a query.\#13#10Join condition is used to link this table to other related tables.' + #13#10 +
'' + #13#10 +
'[fDistinctListParamEditor]' + #13#10 +
'fmDistinctListParamEditor.Self.Caption=Distinct list parameter editor' + #13#10 +
'fmDistinctListParamEditor.Label2.Caption=Param name:' + #13#10 +
'fmDistinctListParamEditor.lbInfo.Caption=This parameter brings to the user a list of all distinctive values contained on related table. The used table is the owner of field compared to this parameter.' + #13#10 +
'' + #13#10 +
'[fExpressionConditionEditor]' + #13#10 +
'fmExpressionConditionEditor.Self.Caption=Query expression condition' + #13#10 +
'fmExpressionConditionEditor.Label5.Caption=Expression:' + #13#10 +
'fmExpressionConditionEditor.lbInfo.Caption=This condition may be represented by any valid meta-sql logic expression. Parameter names may be used prefixed by a colon.' + #13#10 +
'' + #13#10 +
'[fExpressionFieldEditor]' + #13#10 +
'fmExpressionFieldEditor.Self.Caption=Query expression field' + #13#10 +
'fmExpressionFieldEditor.Label4.Caption=Aggregation:' + #13#10 +
'fmExpressionFieldEditor.edAggregation.Items0=(none)' + #13#10 +
'fmExpressionFieldEditor.edAggregation.Items1=Row count' + #13#10 +
'fmExpressionFieldEditor.edAggregation.Items2=Sum' + #13#10 +
'fmExpressionFieldEditor.edAggregation.Items3=Maximum' + #13#10 +
'fmExpressionFieldEditor.edAggregation.Items4=Minimum' + #13#10 +
'fmExpressionFieldEditor.edAggregation.Items5=Average' + #13#10 +
'fmExpressionFieldEditor.Label6.Caption=Expression:' + #13#10 +
'fmExpressionFieldEditor.Label3.Caption=Field alias:' + #13#10 +
'fmExpressionFieldEditor.Label5.Caption=Display label:' + #13#10 +
'fmExpressionFieldEditor.Label7.Caption=Data type:' + #13#10 +
'fmExpressionFieldEditor.edDataType.Items0=(none)' + #13#10 +
'fmExpressionFieldEditor.edDataType.Items1=Row count' + #13#10 +
'fmExpressionFieldEditor.edDataType.Items2=Sum' + #13#10 +
'fmExpressionFieldEditor.edDataType.Items3=Maximum' + #13#10 +
'fmExpressionFieldEditor.edDataType.Items4=Minimum' + #13#10 +
'fmExpressionFieldEditor.edDataType.Items5=Average' + #13#10 +
'fmExpressionFieldEditor.lbInfo.Caption=This field acts like a calculated information, which data expression may be any valid meta-sql field expression.' + #13#10 +
'' + #13#10 +
'[fFreeEditParamEditor]' + #13#10 +
'fmFreeEditParamEditor.Self.Caption=Free parameter editor' + #13#10 +
'fmFreeEditParamEditor.Label2.Caption=Param name:' + #13#10 +
'fmFreeEditParamEditor.lbInfo.Caption=This parameter editor allow user to type values that corresponds to the parameters used by query conditions.' + #13#10 +
'' + #13#10 +
'[fQueryEditor]' + #13#10 +
'fmQueryEditor.Self.Caption=Query for parameter editor' + #13#10 +
'fmQueryEditor.VisualQuery.MetaSqlDefs0.Title=(New visual query)' + #13#10 +
'fmQueryEditor.Button1.Caption=&Ok' + #13#10 +
'fmQueryEditor.Button2.Caption=&Cancel' + #13#10 +
'' + #13#10 +
'[fQueryListParamEditor]' + #13#10 +
'fmQueryListParamEditor.Self.Caption=Query list parameter editor' + #13#10 +
'fmQueryListParamEditor.Label2.Caption=Param name:' + #13#10 +
'fmQueryListParamEditor.Label1.Caption=Meta-SQL:' + #13#10 +
'fmQueryListParamEditor.btMetaSql.Caption=Wizard >>' + #13#10 +
'fmQueryListParamEditor.lbInfo.Caption=This parameter allow user to select a value from a drop down list. List items are fetched from this meta-sql query. The first field on such query should correspond to the field associated to this parameter.' + #13#10 +
'' + #13#10 +
'[fSingleFieldEditor]' + #13#10 +
'fmSingleFieldEditor.Self.Caption=Query single field' + #13#10 +
'fmSingleFieldEditor.Label1.Caption=Table:' + #13#10 +
'fmSingleFieldEditor.Label2.Caption=Field name:' + #13#10 +
'fmSingleFieldEditor.Label4.Caption=Aggregation:' + #13#10 +
'fmSingleFieldEditor.edAggregation.Items0=(none)' + #13#10 +
'fmSingleFieldEditor.edAggregation.Items1=Row count' + #13#10 +
'fmSingleFieldEditor.edAggregation.Items2=Sum' + #13#10 +
'fmSingleFieldEditor.edAggregation.Items3=Maximum' + #13#10 +
'fmSingleFieldEditor.edAggregation.Items4=Minimum' + #13#10 +
'fmSingleFieldEditor.edAggregation.Items5=Average' + #13#10 +
'fmSingleFieldEditor.Label3.Caption=Field alias:' + #13#10 +
'fmSingleFieldEditor.Label5.Caption=Display label:' + #13#10 +
'fmSingleFieldEditor.Label7.Caption=Data type:' + #13#10 +
'fmSingleFieldEditor.edDataType.Items0=(none)' + #13#10 +
'fmSingleFieldEditor.edDataType.Items1=Row count' + #13#10 +
'fmSingleFieldEditor.edDataType.Items2=Sum' + #13#10 +
'fmSingleFieldEditor.edDataType.Items3=Maximum' + #13#10 +
'fmSingleFieldEditor.edDataType.Items4=Minimum' + #13#10 +
'fmSingleFieldEditor.edDataType.Items5=Average' + #13#10 +
'fmSingleFieldEditor.lbInfo.Caption=This field is a single expression to an information.\#13#10Just one database field may be indicated here.' + #13#10 +
'' + #13#10 +
'[fSubconditionsEditor]' + #13#10 +
'fmSubconditionsEditor.Self.Caption=Query collection condition' + #13#10 +
'fmSubconditionsEditor.lbInfo.Caption=This condition is a group of other subconditions.\#13#10Evaluation of its subconditions depends of this condition.' + #13#10 +
'' + #13#10 +
'[ShowSQLForm]' + #13#10 +
'fmShowSQL.Self.Caption=Show SQL' + #13#10 +
'fmShowSQL.Button1.Caption=Close' + #13#10 +
'' + #13#10 +
'';

initialization
  _ResAddStrings(LanguageStr);

end.
