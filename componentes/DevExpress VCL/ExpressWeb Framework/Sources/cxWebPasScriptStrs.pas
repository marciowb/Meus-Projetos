unit cxWebPasScriptStrs;

interface

resourcestring
  scxPascalCompileError = 'Innerfuse Pascal Script compilation error';
  scxPascalRunError = 'Innerfuse Pascal Script runtime error';

  scxPascalHTMLtemplate =  '<%unit Main;'#13#10 +
                           'begin%>'#13#10 +
                           '<html>'#13#10 +
                           '  <head>'#13#10 +
                           '    <title><%=Context.Page.Title%></title>'#13#10 +
                           '  </head>'#13#10 +
                           '  <body>'#13#10 +
                           '    <ewf:Form id="<%=Form.Name%>">'#13#10 +
                           '    </ewf:Form>'#13#10 +
                           '  </body>'#13#10 +
                           '</html>'#13#10 +
                           '<%end.%>'#13#10;

implementation

end.
