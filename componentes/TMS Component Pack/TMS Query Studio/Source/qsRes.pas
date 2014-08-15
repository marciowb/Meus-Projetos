unit qsRes;

interface

uses
  SysUtils, Classes;

const
  {begin strings}
  SAfter = 'SAfter'; //after
  SAggregationFunctionNotAllowed = 'SAggregationFunctionNotAllowed'; //Aggregation function "%s" not allowed with data type "%s"
  SAlias = 'SAlias'; //alias
  SAmbiguousError = 'SAmbiguousError'; //Ambiguos error
  SAnd = 'SAnd'; //And
  SAndNot = 'SAndNot'; //And not
  SAnyFile = 'SAnyFile'; //Any file
  SAs = 'SAs'; //as
  SAscending = 'SAscending'; //ascending
  SAutomaticListEditor = 'SAutomaticListEditor'; //Automatic-list editor
  SAvg = 'SAvg'; //Average of
  SBefore = 'SBefore'; //before
  SBring = 'SBring'; //Bring
  SCancel = 'SCancel'; //Cancel
  SCannotClearParser = 'SCannotClearParser'; //Cannot clear parser when parsing
  SCapabilityNotSupportedJoins = 'SCapabilityNotSupportedJoins'; //Capability not supported on join conditions linking table "%s" to "%s"
  SCheckListEditor = 'SCheckListEditor'; //Check-list editor
  SChooseListEditor = 'SChooseListEditor'; //Choose-list editor
  SCompareFieldToAnother = 'SCompareFieldToAnother'; //Compare a field to another field
  SCompareFieldToParametricValue = 'SCompareFieldToParametricValue'; //Compare a field to a parametric value
  SCompareFieldToSpecificValue = 'SCompareFieldToSpecificValue'; //Compare a field to a specific value
  SConditionExpressionNotSpecified = 'SConditionExpressionNotSpecified'; //Condition expression is not specified
  SConditionRightSideNotSpecified = 'SConditionRightSideNotSpecified'; //Condition right side is not specified
  SConfirmChangeLogicalConnector = 'SConfirmChangeLogicalConnector'; //Confirm to change logical conector of the grouped conditions?
  SConfirmClearAllItems = 'SConfirmClearAllItems'; //Clear all items?
  SConfirmDeleteSelectedItems = 'SConfirmDeleteSelectedItems'; //Are you sure you want to delete selected item(s)?
  SConfirmExcludeAllDefinitions = 'SConfirmExcludeAllDefinitions'; //Confirm to exclude all definitions of query "%s"?
  SConfirmUpdatingMetaSQL = 'SConfirmUpdatingMetaSQL'; //Confirm updating MetaSQL component with current SQL statement?
  SContaining = 'SContaining'; //containing
  SCount = 'SCount'; //Count
  SCustomExpression = 'SCustomExpression'; //Custom expression
  SCustomExpressionSQLSyntax = 'SCustomExpressionSQLSyntax'; //Custom expression (SQL syntax)
  SDatabaseNameNotInformed = 'SDatabaseNameNotInformed'; //Database name not informed
  SDataFields = 'SDataFields'; //Data fields
  SDataTypeNotIndicated = 'SDataTypeNotIndicated'; //Data type not indicated
  SDate = 'SDate'; //date
  SDay = 'SDay'; //day
  SDeleteThisQuery = 'SDeleteThisQuery'; //&Delete this query
  SDescending = 'SDescending'; //descending
  SDifferent = 'SDifferent'; //different
  SDropdownAutomatic = 'SDropdownAutomatic'; //dropdown automatic-list
  SDropdownCheck = 'SDropdownCheck'; //dropdown check-list
  SDropdownChoose = 'SDropdownChoose'; //dropdown choose-list
  SDropdownQuery = 'SDropdownQuery'; //dropdown query-list
  SDuplicateThisQuery = 'SDuplicateThisQuery'; //Du&plicate this query as...
  SEditMetaSQL = 'SEditMetaSQL'; //Edit Meta SQL
  SEditParameterEditorTitled = 'SEditParameterEditorTitled'; //Edit parameter:%s with %s editor, titled "%s"
  SEmpty = 'SEmpty'; //empty
  SEndingWith = 'SEndingWith'; //ending with
  SEnterTableAlias = 'SEnterTableAlias'; //Enter table alias:
  SEqual = 'SEqual'; //equal
  SErrorOpeningQueryCombo = 'SErrorOpeningQueryCombo'; //Error opening TatQueryCombo internal query:
  SErroSintaxeLinhaColuna = 'SErroSintaxeLinhaColuna'; //Syntax error at row %d, col %d of Meta SQL:
  SExportQueriesToFile = 'SExportQueriesToFile'; //Export queries to file
  SExpression = 'SExpression'; //Expression
  SExpressionAliasTitled = 'SExpressionAliasTitled'; //Expression %s alias %s, titled "%s"
  SExpressionFieldNotSpecified = 'SExpressionFieldNotSpecified'; //Expression field is not specified
  SExpressionOperatorNotSpecified = 'SExpressionOperatorNotSpecified'; //Expression operator is not specified
  SFalse = 'SFalse'; //False
  SField = 'SField'; //field
  SFieldAliasNotIndicated = 'SFieldAliasNotIndicated'; //Field alias not indicated
  SFieldAliasNotUnique = 'SFieldAliasNotUnique'; //Field alias is not unique on meta-sql
  SFieldCalculatedByAnExpression = 'SFieldCalculatedByAnExpression'; //Field calculated by an expression
  SFieldComparing = 'SFieldComparing'; //Field comparing
  SFieldExpressionNotIndicated = 'SFieldExpressionNotIndicated'; //Field expression not indicated
  SFieldKindAvg = 'SFieldKindAvg'; //Average of (evaluate the field value average on a group of records)
  SFieldKindBring = 'SFieldKindBring'; //Bring (bring individual field value from database table)
  SFieldKindCount = 'SFieldKindCount'; //Count (count field value occurencies on a group of records)
  SFieldKindMax = 'SFieldKindMax'; //Maximum of (evaluate the maximum field value on a group of records)
  SFieldKindMin = 'SFieldKindMin'; //Minimum of (evaluate the minum field value on a group of record)
  SFieldKindSum = 'SFieldKindSum'; //Sum of (compute the sum of field value on a group of records)
  SFieldNameNotIndicated = 'SFieldNameNotIndicated'; //Field name not indicated
  SFieldNotIndicated = 'SFieldNotIndicated'; //Field not indicated
  SFilterConditions = 'SFilterConditions'; //Filter conditions
  SFreeTyping = 'SFreeTyping'; //free typing
  SFreeTypingEditor = 'SFreeTypingEditor'; //Free typing editor
  SGreaterOrEqual = 'SGreaterOrEqual'; //greater or equal
  SGreaterThan = 'SGreaterThan'; //greater than
  SGroupingFields = 'SGroupingFields'; //Grouping fields
  SImportQueriesFromFile = 'SImportQueriesFromFile'; //Import queries from file
  SImportQueryFromTargetDataset = 'SImportQueryFromTargetDataset'; //Import query from target dataset
  SImportQueryFromTargetMetaSQL = 'SImportQueryFromTargetMetaSQL'; //Import query from target meta-sql
  SInclude = 'SInclude'; //Include
  SIncludeANewItem = 'SIncludeANewItem'; //include a new item
  SIncorrectGrammarLiteralString = 'SIncorrectGrammarLiteralString'; //Incorrect grammar. Literal string not terminated on "%s"
  SIncorrectGrammarSubexpressionEmpty = 'SIncorrectGrammarSubexpressionEmpty'; //Incorrect grammar. Subexpression is empty on "%s"
  SIncorrectGrammarSubexpressionNotTerminated = 'SIncorrectGrammarSubexpressionNotTerminated'; //Incorrect grammar. Subexpression not terminated on "%s"
  SIndexOutOfBounds = 'SIndexOutOfBounds'; //Index out of bounds
  SInvalidFieldType = 'SInvalidFieldType'; //Invalid field type
  SInvalidIncludedInputBuffer = 'SInvalidIncludedInputBuffer'; //Invalid included input buffer. Each nodes must begin and end on the same input buffer
  SInvalidMetaSQL = 'SInvalidMetaSQL'; //Invalid Meta SQL:
  SInvalidSQLForQueryCombo = 'SInvalidSQLForQueryCombo'; //Invalid SQL for TatQueryCombo internal query
  SInvalidQueryFirstSecondFields = 'SInvalidQueryFirstSecondFields'; //Invalid query. First field should be the key and the second field should be a caption
  SItemSets = 'SItemSets'; //item "%s" sets
  SJoinConditionEmpty = 'SJoinConditionEmpty'; //Join condition is empty
  SJoinConditionError = 'SJoinConditionError'; //Join condition error:
  SLessOrEqual = 'SLessOrEqual'; //less or equal
  SLessThan = 'SLessThan'; //less than
  SLike = 'SLike'; //like
  SMainConditions = 'SMainConditions'; //Main conditions
  SMax = 'SMax'; //Maximum of
  SMin = 'SMin'; //Minimum of
  SMonth = 'SMonth'; //month
  SNaoPossivelInserirSubstring = 'SNaoPossivelInserirSubstring'; //Cannot insert a substring into node "%s", because it belongs to its subnode %d ("%s")
  SNaoPossivelModificarSubstring = 'SNaoPossivelModificarSubstring'; //Cannot modify the substring "%s" in node "%s", because it belongs to its subnode %d ("%s")
  SNestedConditions = 'SNestedConditions'; //Nested conditions...
  SNestedSubconditions = 'SNestedSubconditions'; //Nested subconditions
  SNewCheckItem = 'SNewCheckItem'; //new check item
  SNewChooseItem = 'SNewChooseItem'; //new choose item
  SNewCondition = 'SNewCondition'; //new condition
  SNewEditor = 'SNewEditor'; //new editor
  SNewField = 'SNewField'; //new field
  SNewGroupField = 'SNewGroupField'; //new group field
  SNewOrderField = 'SNewOrderField'; //new order field
  SNewParameterAssignment = 'SNewParameterAssignment'; //new parameter assignment
  SNewQuery = 'SNewQuery'; //&New query...
  SNewTable = 'SNewTable'; //new table
  SNewVisualQueryTitle = 'SNewVisualQueryTitle'; //(New visual query)
  SNone = 'SNone'; //(none)
  SNotEnoughTableLinks = 'SNotEnoughTableLinks'; //One or more tables not linked
  SNotImplemented = 'SNotImplemented'; //Not implemented
  SNow = 'SNow'; //now
  SNull = 'SNull'; //null
  SNullNode = 'SNullNode'; //Null node
  SOff = 'SOff'; //off
  SOK = 'SOK'; //OK
  SOr = 'SOr'; //Or
  SOrderingFields = 'SOrderingFields'; //Ordering fields
  SOrNot = 'SOrNot'; //Or not
  SParamCaptionNotSpecified = 'SParamCaptionNotSpecified'; //Param caption not specified
  SParameter = 'SParameter'; //parameter
  SParameterEditors = 'SParameterEditors'; //Parameter editors
  SParameterTo = 'SParameterTo'; //parameter: %s to "%s"
  SParamNameNotIndicated = 'SParamNameNotIndicated'; //Param name not indicated
  SParamNameNotReferFieldComparingCondition = 'SParamNameNotReferFieldComparingCondition'; //Param name not refer to a field comparing condition
  SParamNameNotValid = 'SParamNameNotValid'; //Param name is not valid.
  SQueryAlreadyExists = 'SQueryAlreadyExists'; //Query "%s" already exists. Confirm overwriting?
  SQueryDefinitionFile = 'SQueryDefinitionFile'; //Query definition file
  SQueryEditorForParameter = 'SQueryEditorForParameter'; //Query editor for parameter: %s
  SQueryListEditor = 'SQueryListEditor'; //Query-list editor
  SQueryTitle = 'SQueryTitle'; //Query title
  SSaveCurrentQuery = 'SSaveCurrentQuery'; //Save current query into query list
  SSelectDirectory = 'SSelectDirectory'; //Select directory
  SSetContinueOnRemarksShouldOnlyBeCalled = 'SSetContinueOnRemarksShouldOnlyBeCalled'; //SetContinueOnRemarks should only be called when processing input remarks
  SSetCurrentInputPosShouldOnlyBeCalled = 'SSetCurrentInputPosShouldOnlyBeCalled'; //SetCurrentInputPos should only be called when processing input remarks
  SSetCurrentMaxInputPosShouldOnlyBeCalled = 'SSetCurrentMaxInputPosShouldOnlyBeCalled'; //SetCurrentMaxInputPos should only be called when processing input remarks
  SSetTableAlias = 'SSetTableAlias'; //Set table alias
  SShowSQL = 'SShowSQL'; //Show SQL
  SSingleField = 'SSingleField'; //Single field
  SSingleTable = 'SSingleTable'; //Single table
  SSourceTables = 'SSourceTables'; //Source tables
  SSQLIs = 'SSQLIs'; //SQL is:
  SStartingWith = 'SStartingWith'; //starting with
  SSum = 'SSum'; //Sum of
  SSyntaxErrorAtRow = 'SSyntaxErrorAtRow'; //Syntax error at row %d character %d
  SSyntaxOK = 'SSyntaxOK'; //Syntax Ok!
  STable = 'STable'; //Table
  STableAliasAlreadyIncluded = 'STableAliasAlreadyIncluded'; //Table alias "%s" already included in meta-sql
  STableAliasEmpty = 'STableAliasEmpty'; //Table alias is empty
  STableAliasJoinedConditioned = 'STableAliasJoinedConditioned'; //%s alias %s joined %s above tables, conditioned by 
  STableJoinHandlingFailure = 'STableJoinHandlingFailure'; //Table join handling failure
  STableLinkedToAnother = 'STableLinkedToAnother'; //Table linked to another
  STableNameEmpty = 'STableNameEmpty'; //Table name is empty
  STableNotIndicated = 'STableNotIndicated'; //Table not indicated
  STargetDatasetNotSupported = 'STargetDatasetNotSupported'; //Target dataset not compatible with current TatDatabase component.
  STentativaAcessarPosicaoInexistente = 'STentativaAcessarPosicaoInexistente'; //Attempt to access a nonexistent position in the source
  STentativaInserirSubstring = 'STentativaInserirSubstring'; //Attempt to insert a substring out of the node "%s"
  STentativaModificarSubstring = 'STentativaModificarSubstring'; //Attempt to modify a substring not belonging to node "%s"
  STitled = 'STitled'; //titled
  SToday = 'SToday'; //today
  STokenDoesNotContainSubnode = 'STokenDoesNotContainSubnode'; //"%s" does not contain subnode %d'
  STokenIsNotNode = 'STokenIsNotNode'; //"'%s" is not a %s node'
  STrue = 'STrue'; //True
  SUndefinedValue = 'SUndefinedValue'; //undefined
  SValue = 'SValue'; //value
  SValuesAppliedNoItemSelected = 'SValuesAppliedNoItemSelected'; //Values to be applied when no item is selected:
  SValuesAppliedItemSelected = 'SValuesAppliedItemSelected'; //Values to be applied when item "%s" is selected:
  SVisualQueryEditor = 'SVisualQueryEditor'; //Visual query editor
  SWhen = 'SWhen'; //When
  SWhenNot = 'SWhenNot'; //When not
  SWith = 'SWith'; //with
  SYear = 'SYear'; //year
  SYouMustCompleteUndefinedItem = 'SYouMustCompleteUndefinedItem'; //You must complete the undefined item definition to add new one
  SYouMustSpecifyTargetDataset = 'SYouMustSpecifyTargetDataset'; //You must specify TargetDataset property to import query
  SYouMustSpecifyTargetMetaSQL = 'SYouMustSpecifyTargetMetaSQL'; //You must specify TargetMetaSQL property to import query
  {end strings}

function _str(id: string): string;
procedure _ResAddStrings(str: string);

implementation

uses
  qsLanguage;

var
  qsResources: TStrings;

procedure CheckResources;
begin
  if qsResources = nil then
    qsResources := TStringList.Create;
end;

procedure _ResAddStrings(str: string);
var
  c: integer;
  SL: TStringList;
begin
  CheckResources;
  SL := TStringList.Create;
  SL.Text := str;
  try
    for c := 0 to SL.Count - 1 do
      qsResources.Add(SL[c]);
  finally
    SL.Free;
  end;
end;

function _str(id: string): string;
begin
  if qsResources.IndexOfName(id) > -1 then
    result := qsResources.Values[id]
  else
    result := id;
  result := StringReplace(result, '\#13#10', #13#10, [rfReplaceAll]);
end;

initialization
  CheckResources;
finalization
  if qsResources <> nil then
  begin
    qsResources.Free;
    qsResources := nil;
  end;

end.

