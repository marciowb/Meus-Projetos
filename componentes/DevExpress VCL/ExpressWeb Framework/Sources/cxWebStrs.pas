unit cxWebStrs;

interface

resourcestring

  scxWebNoPage = 'Application does not have the default page';
  scxWebPageNotFound = 'Web Page not found: %s';
  scxWebPageContentIsEmpty = 'Web Page %s does not have content';
  scxResourceNotFound = 'Resource %s not found';
  scxWebSessionsLimitExceeded = 'Sessions limit is exceeded';
  scxWebCannotChangePositioningType = 'The designer doesn''t support this positioning type';
  scxWebDuplicateName = 'Component name "%s" is duplicated';
  scxControlParentSetToSelf = 'A control cannot have itself as its parent';
  // Script errors
  scxDuplicateScriptEngineID = 'The server-side script engine with ID ''%d'' is already registered.';
  scxDuplicateScriptEngineName = 'The ''%s'' name is already used.';
  scxCannotCreateScriptEngine = 'Cannot create script engine: %s.'#13#10'Error code: %x';
  scxDuplicateItem = 'An item named %s already exists';
  scxItemNameIsBlank = 'Item name cannot be blank';
  scxObjectFactoryNotFound = 'Object factory for class %s missing';
  scxScriptClassNotFound = 'Wrapper for class %s missing';
  scxScriptErrorHTML = '<table border="0">'#13#10 +
                       '  <tr>'#13#10 +
                       '    <td colspan="3"><b>Error[%0:u]: <font size=+2>%1:s</font></b></td>'#13#10 +
                       '  </tr>'#13#10 +
                       '  <tr>'#13#10 +
                       '    <td width="5%%"></td>'#13#10 +
                       '    <td width="20%%"><b>Code:</b></td>'#13#10 +
                       '    <td>#%2:x</td>'#13#10 +
                       '  </tr>'#13#10 +
                       '  <tr>'#13#10 +
                       '    <td></td>'#13#10 +
                       '    <td><b>Description:</b></td>'#13#10 +
                       '    <td>%3:s</td>'#13#10 +
                       '  </tr>'#13#10 +
                       '  <tr>'#13#10 +
                       '    <td></td>'#13#10 +
                       '    <td><b>Source name:</b></td>'#13#10 +
                       '    <td>%4:s</td>'#13#10 +
                       '  </tr>'#13#10 +
                       '  <tr>'#13#10 +
                       '    <td></td>'#13#10 +
                       '    <td><b>Source line:</b></td>'#13#10 +
                       '    <td>%5:u</td>'#13#10 +
                       '  </tr>'#13#10 +
                       '  <tr>'#13#10 +
                       '    <td></td>'#13#10 +
                       '    <td><b>Position:</b></td>'#13#10 +
                       '    <td>%6:u</td>'#13#10 +
                       '  </tr>'#13#10 +
                       '  <tr>'#13#10 +
                       '    <td></td>'#13#10 +
                       '    <td colspan="2"><pre>%7:s<br><font color="#FF0000">%8:s</font></pre></td>'#13#10 +
                       '  </tr>'#13#10 +
                       '</table>'#13#10;
  // Script parser errors
  scxWebScriptParserError = 'Server-side script parser error';
  scxWebPreParsingError = 'Server-side script pre-parsing error';  
  scxCantFindIncludePage = 'Cannot find included page: %s';
  scxCantFindIncludeFile = 'Cannot find included file: %s';
  scxInclusionNotSupported = 'Page %s does not support inclusion';
  scxRecursiveInclude = 'The %s %s recursively includes itself';
  scxUnsupportedIncludeType = 'Unsupported include type ''%s''';
  scxExpectedSymbol = 'Expected ''%s''';
  scxUnknownScriptEngine = 'Unknown server-side script engine name: ''%s''.'; 
  // HTML parser errors
  scxExpectedPropertyName = 'Expected property Name';
  scxInvalidPropertyName = 'Invalid property name';
  scxExpectedPropertyValue = 'Expected property value';
  scxExpectedClassname = 'Expected classname';
  scxExpectedClosingTag = 'Expected closing tag for %s';
  scxUnexpectedClosingTag = 'Unexpected closing tag for %s';
  scxTooManyForms = 'Too many forms';
  scxComponentOutOfForm = 'Component with name "%s" out of form';
  scxInvalidPropertyValue = 'The property value %s of the %s property is invalid';
  scxInvalidComponentClassName = 'The web classname in the tag: ewf:%s is invalid';
  scxIncorrectComponentClassName = 'The class name of the component: %s is not: %s';
  scxCannotAssignProperty = 'Cannot assign the property %s of the %s component.';
  scxInvalidComponentPropertyValue = 'The property %s of the %s component is invalid.';
  scxUnexpectedEWFTag = 'The EWF tag cannot be placed on this module.';
  // HTML builder errors
  scxUnableWriteAttribute = 'Unable write attribute';
  scxInvalidAttribute = 'Invalid attribute';
  scxInvalidStyleAttribute = 'Invalid style attribute';
  scxInvalidEventAttribute = 'Invalid event attribute';
  scxInvalidClosingTag = 'Invalid closing tag';
  scxUnsupportedTag = 'Tag %s doesn''t supported in this browser';
  // HTML Templates
  scxSmartRedirectHTML = '<html>'#13#10 +
                         '  <head>'#13#10 +
                         '    <title>Document Moved 301</title>'#13#10 +
                         '    <meta http-equiv="Refresh" content="0; url=%0:s">'#13#10 +
                         '    <script language="Javascript" type="text/javascript">'#13#10 +
                         '      location.href="%0:s"'#13#10 +
                         '    </script>'#13#10 +
                         '  </head>'#13#10 +
                         '  <body>'#13#10 +
                         '    <h1>Object Moved</h1><hr>'#13#10 +
                         '    This Object may be found <a href="%0:s">here.</a>'#13#10 +
                         '  </body>'#13#10 +
                         '</html>'#13#10;
  scxPageTitleScript = '<%=Context.Page.Title%>';
  scxFormNameScript = '<%=Form.Name%>';
  scxDefaultHTMLTemplate = '<html>'#13#10 +
                           '  <head>'#13#10 +
                           '    <title>%0:s</title>'#13#10 +
                           '  </head>'#13#10 +
                           '  <body>'#13#10 +
                           '    <ewf:Form id="%1:s">'#13#10 +
                           '    </ewf:Form>'#13#10 +
                           '  </body>'#13#10 +
                           '</html>'#13#10;
  scxDebugHTMLFileName = 'htmlsource.ewf';
  // WebGrid strings
  scxNodeBtnHint = 'Row #';
  scxCancelBtnHint = 'Cancel edit';
  scxDeleteBtnHint = 'Delete record';
  scxInsertBtnHint = 'Insert record';
  scxPostBtnHint = 'Post edit';
  scxEmptyGroupPanelText = '&nbsp;Drag a column header here to group by that column&nbsp;';
  scxStatusBarText = 'Rows %d - %d From %d Visible';
  scxStatusBarEmptyGridText = 'Data not loaded to grid';
  // WebDataSources strings
  scxDeleteConfirmText = 'Delete record?';

implementation

end.
