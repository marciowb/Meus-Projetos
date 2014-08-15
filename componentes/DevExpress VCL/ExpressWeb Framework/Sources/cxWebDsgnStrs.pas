unit cxWebDsgnStrs;

interface

resourcestring
  scxCantAddComponent = 'Controls cannot be added to a web module';
  scxCantCreateUniqueName = 'Can''t create unique name';
  scxError = 'Error';
  scxFileReadOnly = 'The edit buffer of "%s" is marked read-only.';
  scxInvalidPageName = 'Invalid Page name';
  scxInvalidValue = '"%s" is not a valid integer value.';
  scxScalingFactorError = 'Scaling factor must be between %d and %d.';
  scxValueMustBeInteger = 'Value must be valid integer number';
  scxValueNotInTheRange = 'Value not in the range %d - %d';

  scxWebModuleDesignerComponentsPage = 'Components';
  scxWebModuleDesignerHTMLPage = 'HTML';
  scxWebModuleDesignerPreviewPage = 'Preview';
  scxNoImage = '(No Image)';

  { menus }
  scxNone = '(None)';
  scxEdit = '&Edit';
  scxUndo = '&Undo';
  scxCut = 'Cu&t';
  scxCopy = '&Copy';
  scxPaste = '&Paste';
  scxDelete = '&Delete';
  scxSelectAll = 'Se&lect All';
  scxPosition = '&Position';
  scxAlignToGrid = 'Align to Grid';
  scxAlign = 'Align...';
  scxSize = 'Size...';
  scxScale = 'Scale...';
  scxTabOrder = 'TabOrder...';
  scxEnvironmentOptions = 'Environment Options...';

  { hint prefixes }
  scxHintOrigin = 'Origin';
  scxHintSize = 'Size';
  scxHintTabStop = 'TabStop';
  scxHintTabOrder = 'Order';

  { Web Design Form }

  scxWebDsgnFormButton = 'Form';
  scxWebDsgnResultButton = 'HTML Result';
  scxWebDsgnPreviewButton = 'Preview';

  { Designer Dialog Forms}
  scxWebDsgnButtonOKCaption = 'OK';
  scxWebDsgnButtonApplyCaption = '&Apply';
  scxWebDsgnButtonCancelCaption = 'Cancel';
  scxWebDsgnButtonHelpCaption = '&Help';

  { Alignment form}
  scxWebDsgnAlignFormCaption = 'Alignment';
  scxWebDsgnAlignHAlignCaption = ' Horizontal ';
  scxWebDsgnAlignHAlignItem1 = '&No Changes';
  scxWebDsgnAlignHAlignItem2 = '&Left sides';
  scxWebDsgnAlignHAlignItem3 = '&Centers';
  scxWebDsgnAlignHAlignItem4 = '&Right sides';
  scxWebDsgnAlignHAlignItem5 = '&Space equally';
  scxWebDsgnAlignHAlignItem6 = 'Center in &Window';
  scxWebDsgnAlignVAlignCaption = ' Vertical ';
  scxWebDsgnAlignVAlignItem1 = 'No Chan&ges';
  scxWebDsgnAlignVAlignItem2 = '&Tops';
  scxWebDsgnAlignVAlignItem3 = 'C&enters';
  scxWebDsgnAlignVAlignItem4 = '&Bottoms';
  scxWebDsgnAlignVAlignItem5 = 'Space e&qually';
  scxWebDsgnAlignVAlignItem6 = 'Center &in Window';

  { Scale form }
  scxWebDsgnScaleFormCaption = 'Scale';
  scxWebDsgnScaleLabelFactor = '&Scaling factor:';

  { Size form }
  scxWebDsgnSizeFormCaption = 'Size';
  scxWebDsgnSizeWidthCaption = ' Width ';
  scxWebDsgnSizeHeightCaption = ' Height ';
  scxWebDsgnAlignSizeItem1 = 'No &change';
  scxWebDsgnAlignSizeItem2 = 'Shrin&k to smallest';
  scxWebDsgnAlignSizeItem3 = 'Grow to &largest';
  scxWebDsgnAlignSizeItem4 = 'E&xactly (px):';

  { Tab order form}
  scxWebDsgnTabOrderFormCaption = 'Edit Tab Order';
  scxWebDsgnTabOrderLabelControlsListed = '&Controls listed in tab order:';

  { Wizards }
  scxWebDsgnWizardPropertiesCaption = 'Properties';
  scxWebDsgnWizardPageModulePropertiesCaption = 'Page Module Properties';
  scxWebDsgnWizardDataModulePropertiesCaption = 'Data Module Properties';
  scxWebDsgnWizardFramesetPropertiesCaption = 'Frameset Properties';
  scxWebDsgnWizardScriptCaption = '&Server Script:';
  scxWebDsgnWizardCachingCaption = '&Caching:';
  scxWebDsgnWizardonDemandCaption = 'On &Demand';
  scxWebDsgnWizardPageNameCaption = 'Page &Name:';
  scxWebDsgnWizardDesignerCaption = '&Designer';
  scxWebDsgnWizardPublishedCaption = '&Published';
  scxWebDsgnWizardTemplateCaption = 'Frameset Template';
  scxWebDsgnWizardFramesetCaption = 'Frameset:';
  scxWebDsgnWizardPreviewCaption = 'Preview:';
  scxWebDsgnWizardDescriptionCaption = 'Description:';

  { Data Module Wizard }
  scxWebDsgnDataModuleWizardCaption = 'New EWF Data Module';

  { Page Module Wizard }
  scxWebDsgnPageModuleWizardCaption = 'New EWF Page Module';

  { Frameset Wizard }
  scxWebDsgnFramesetWizardCaption = 'New EWF Frameset';

  { Project Module Wizard }
  scxWebDsgnProjectModuleWizardCaption = 'New EWF Application';
  scxWebDsgnProjectWizardServerTypeCaption = '&Server Type';
  scxWebDsgnProjectWizardClassNameCaption = {$IFDEF VCL}'Co' + {$ENDIF}'Class&Name';

  { Web Components designers }
  cxWebCompEditorAdd = '&Add';
  cxWebCompEditorDelete = '&Delete';
  cxWebCompEditorSelectAll = 'Select All';
  cxWebCompEditorMoveUp = 'Move &Up';
  cxWebCompEditorMoveDown = 'Move &Down';
  cxWebCompEditorButtonBar = '&Button Bar';
  cxWebCompEditorAddDefaultColumns = 'Add default columns';
  cxWebCompEditorRestoreDefaults = 'Restore Defaults';
  cxWebCompEditorNewItem = '&New Item';
  cxWebCompEditorNewSubItem = 'N&ew SubItem';
  cxWebCompEditorLevelUp = 'Level Up';
  cxWebCompEditorLevelDown = 'Level Down';
  cxWebCompEditorItemProperties = 'Item Properties';
  cxWebCompEditorItemName = 'N&ame:';
  cxWebCompEditorItemHint = '&Hint:';
  cxWebCompEditorItemHref = 'H&ref:';
  cxWebCompEditorItemTarget = '&Target:';
  cxWebCompEditorItemImageIndex = 'I&mage Index:';

  { Designer ToolBar strings }
  scxBarButtonHintFormat = 'Blok Format';
  scxBarButtonHintFontName = 'Font Name';
  scxBarButtonHintFontSize = 'Font Size';
  scxBarButtonHintBold = 'Bold';
  scxBarButtonHintItalic = 'Italic';
  scxBarButtonHintUnderline = 'Underline';
  scxBarButtonHintAlignLeft = 'Align Left';
  scxBarButtonHintAlignCenter = 'Center';
  scxBarButtonHintAlignRight = 'Align Right';
  scxBarButtonHintJustify = 'Justify';
  scxBarButtonHintAlignNone = 'No Align';
  scxBarButtonHintNumbering = 'Numbering';
  scxBarButtonHintBullets = 'Bullets';
  scxBarButtonHintOutdent = 'Decrease Indent';
  scxBarButtonHintIndent = 'Increase Indent';
  scxBarButtonHintSubscript = 'Subscript';
  scxBarButtonHintSuperscript = 'Superscript';
  scxBarButtonHintBGColor = 'Highlight Color';
  scxBarButtonHintForeColor = 'Font Color';
  scxBarButtonHintLink = 'Link';
  scxBarButtonHintUnlink = 'UnLink';
  scxBarButtonHintRemoveFmt = 'Remove Formatting';

  scxBarButtonHintInsTable = 'Insert Table';
  scxBarButtonHintInsRowA = 'Insert Row Above';
  scxBarButtonHintInsRowB = 'Insert Row Below';
  scxBarButtonHintInsColL = 'Insert Column to the Left';
  scxBarButtonHintInsColR = 'Insert Column to the Right';
  scxBarButtonHintInsCell = 'Insert Cell';
  scxBarButtonHintDelTable = 'Delete Table';
  scxBarButtonHintDelRow = 'Delete Rows';
  scxBarButtonHintDelCol = 'Delete Columns';
  scxBarButtonHintDelCells = 'Delete Cells';
  scxBarButtonHintMergeCells = 'Merge Cells';
  scxBarButtonHintSplitCell = 'Split Cell';
  scxBarButtonHintSelTable = 'Select Table';
  scxBarButtonHintSelRow = 'Select Row';
  scxBarButtonHintSelCol = 'Select Column';
  scxBarButtonHintSelCell = 'Select Cell';

  scxBarButtonHintNewWholeFrame = 'New Whole Frame';
  scxBarButtonHintNewLFrame = 'New Left Frame';
  scxBarButtonHintNewRFrame = 'New Right Frame';
  scxBarButtonHintNewTFrame = 'New Top Frame';
  scxBarButtonHintNewBFrame = 'New Bottom Frame';
  scxBarButtonHintDelFrame = 'Delete Frame';

  scxBarFormatComboNone = '(none)';
  scxBarFormatComboNormal = 'Normal';
  scxBarFormatComboFormat = 'Formatted';
  scxBarFormatComboAdress = 'Address';
  scxBarFormatComboH1 = 'Heading 1';
  scxBarFormatComboH2 = 'Heading 2';
  scxBarFormatComboH3 = 'Heading 3';
  scxBarFormatComboH4 = 'Heading 4';
  scxBarFormatComboH5 = 'Heading 5';
  scxBarFormatComboH6 = 'Heading 6';
  scxBarFormatComboNumList = 'Numbered List';
  scxBarFormatComboBulList = 'Bulleted List';
  scxBarFormatComboDirList = 'Directory List';
  scxBarFormatComboMenuList = 'Menu List';
  scxBarFormatComboDefTerm = 'Definition Term';
  scxBarFormatComboDef = 'Definition';
  scxBarFormatComboPara = 'Paragraph';

  scxBarFontSizeComboNormal = 'Normal';

  scxBarColorHintDef = 'default';

  scxBarFontComboDef = 'default font';

  scxBarStdColors = 'Standard Colors';
  scxBarWebColors = 'Web Palette';
  scxBarSystemColors = 'System Colors';
  scxBarCustomColor = 'Custom Color';

  { HTML Editor command IDs}
  scxCmdUndo = 'Undo';
  scxCmdRedo = 'Redo';
  scxCmdCantUndo = 'Can''t Undo';
  scxCmdCantRedo = 'Can''t Redo';
  scxCmdResize = 'Resize';
  scxCmdMove = 'Move';
  scxCmdInsert = 'Insert';
  scxCmdDelete = 'Delete';
  scxCmdTableInsert = 'Table Insert';
  scxCmdTableDelete = 'Table Delete';
  scxCmdRowInsert = 'Row Insert';
  scxCmdRowDelete = 'Rows Delete';
  scxCmdColInsert = 'Column Insert';
  scxCmdColDelete = 'Columns Delete';
  scxCmdCellInsert = 'Cell Insert';
  scxCmdCellSplit = 'Cell Split';
  scxCmdCellMerge = 'Cells Merge';
  scxCmdCellDelete = 'Cells Delete';
  scxCmdFrameInsert = 'Frame Insert';
  scxCmdFrameDelete = 'Frame Delete';

  scxCmdAlign = 'Align';

  { Frameset templates strings}
  scxTemplate1Name = 'Banner and content';
  scxTemplate1Description = 'Creates a banner frame at the top, with a contents and main frame. Hyperlinks in the banner change the contents frame.';
  scxTemplate1Template = '<html>' + #13#10 +
      '  <head>' + #13#10 +
      '    <title></title>' + #13#10 +
      '  </head>' + #13#10 +
      '  <frameset rows="64,*">' + #13#10 +
      '  <frame name="banner" src="" scrolling="no" noresize>' + #13#10 +
      '    <frameset cols="150,*">' + #13#10 +
      '      <frame name="contents" src="">' + #13#10 +
      '      <frame name="main" src="">' + #13#10 +
      '    </frameset>' + #13#10 +
      '    <noframes>' + #13#10 +
      '      <p>' + #13#10 +
      '        This HTML frameset displays multiple Web pages. To view this frameset, use a' + #13#10 +
      '        Web browser that supports HTML 4.0 and later.' + #13#10 +
      '      </p>' + #13#10 +
      '    </noframes>' + #13#10 +
      '  </frameset>' + #13#10 +
      '</html>';
  scxTemplate2Name = 'Contents';
  scxTemplate2Description = 'Creates a contents frame on the left containing hyperlinks that change the page shown on the right.';
  scxTemplate2Template = '<html>' + #13#10 +
  '  <head>' + #13#10 +
  '    <title></title>' + #13#10 +
  '  </head>' + #13#10 +
  '  <frameset cols="150,*">' + #13#10 +
  '    <frame name="contents" src="">' + #13#10 +
  '    <frame name="main" src="">' + #13#10 +
  '    <noframes>' + #13#10 +
  '      <p>' + #13#10 +
  '        This HTML frameset displays multiple Web pages. To view this frameset, use a' + #13#10 +
  '        Web browser that supports HTML 4.0 and later.' + #13#10 +
  '      </p>' + #13#10 +
  '    </noframes>' + #13#10 +
  '  </frameset>' + #13#10 +
  '</html>';
  scxTemplate3Name = 'Footer';
  scxTemplate3Description = 'Creates a main frame with a footer underneath it. Hyperlinks in the footer change the main frame.';
  scxTemplate3Template = '<html>' + #13#10 +
  '  <head>' + #13#10 +
  '    <title></title>' + #13#10 +
  '  </head>' + #13#10 +
  '    <frameset rows="*,64">' + #13#10 +
  '      <frame name="main" src="">' + #13#10 +
  '      <frame name="footer" src="" scrolling="no" noresize>' + #13#10 +
  '      <noframes>' + #13#10 +
  '        <p>' + #13#10 +
  '          This HTML frameset displays multiple Web pages. To view this frameset, use a' + #13#10 +
  '          Web browser that supports HTML 4.0 and later.' + #13#10 +
  '        </p>' + #13#10 +
  '      </noframes>' + #13#10 +
  '    </frameset>' + #13#10 +
  '</html>';
  scxTemplate4Name = 'Footnotes';
  scxTemplate4Description = 'Creates a main frame with a footnotes underneath it. Hyperlinks in the main frame change the footnotes.';
  scxTemplate4Template = '<html>' + #13#10 +
  '  <head>' + #13#10 +
  '    <title></title>' + #13#10 +
  '  </head>' + #13#10 +
  '  <frameset rows="*,20%">' + #13#10 +
  '    <frame name="main" src="">' + #13#10 +
  '    <frame name="footnotes" src="">' + #13#10 +
  '    <noframes>' + #13#10 +
  '      <p>' + #13#10 +
  '        This HTML frameset displays multiple Web pages. To view this frameset, use a' + #13#10 +
  '        Web browser that supports HTML 4.0 and later.' + #13#10 +
  '      </p>' + #13#10 +
  '    </noframes>' + #13#10 +
  '  </frameset>' + #13#10 +
  '</html>';
  scxTemplate5Name = 'Header';
  scxTemplate5Description = 'Creates a navigation header and a main frame underneath it. Hyperlinks in the header change the main frame.';
  scxTemplate5Template = '<html>' + #13#10 +
  '  <head>' + #13#10 +
  '    <title></title>' + #13#10 +
  '  </head>' + #13#10 +
  '  <frameset rows="64,*">' + #13#10 +
  '    <frame name="header" src="" scrolling="no" noresize>' + #13#10 +
  '    <frame name="main" src="">' + #13#10 +
  '    <noframes>' + #13#10 +
  '      <p>' + #13#10 +
  '        This HTML frameset displays multiple Web pages. To view this frameset, use a' + #13#10 +
  '        Web browser that supports HTML 4.0 and later.' + #13#10 +
  '      </p>' + #13#10 +
  '    </noframes>' + #13#10 +
  '  </frameset>' + #13#10 +
  '</html>';
  scxTemplate6Name = 'Header, Footer and Contents';
  scxTemplate6Description = 'Creates header and footer frames for navigation. Hyperlinks in the header and footer change the contents frame.';
  scxTemplate6Template = '<html>' + #13#10 +
  '  <head>' + #13#10 +
  '    <title></title>' + #13#10 +
  '  </head>' + #13#10 +
  '  <frameset rows="64,*,64">' + #13#10 +
  '    <frame name="header" src="" scrolling="no" noresize>' + #13#10 +
  '    <frameset cols="150,*">' + #13#10 +
  '      <frame name="contents" src="">' + #13#10 +
  '      <frame name="main" src="">' + #13#10 +
  '    </frameset>' + #13#10 +
  '    <frame name="footer" src="" scrolling="no" noresize>' + #13#10 +
  '    <noframes>' + #13#10 +
  '      <p>' + #13#10 +
  '        This HTML frameset displays multiple Web pages. To view this frameset, use a' + #13#10 +
  '        Web browser that supports HTML 4.0 and later.' + #13#10 +
  '      </p>' + #13#10 +
  '    </noframes>' + #13#10 +
  '  </frameset>' + #13#10 +
  '</html>';
  scxTemplate7Name = 'Horizontal Split';
  scxTemplate7Description = 'Creates independent top and bottom frames.';
  scxTemplate7Template = '<html>' + #13#10 +
  '  <head>' + #13#10 +
  '    <title></title>' + #13#10 +
  '  </head>' + #13#10 +
  '  <frameset rows="*,*">' + #13#10 +
  '    <frame name="top" src="">' + #13#10 +
  '    <frame name="bottom" src="">' + #13#10 +
  '    <noframes>' + #13#10 +
  '      <p>' + #13#10 +
  '        This HTML frameset displays multiple Web pages. To view this frameset, use a' + #13#10 +
  '        Web browser that supports HTML 4.0 and later.' + #13#10 +
  '      </p>' + #13#10 +
  '    </noframes>' + #13#10 +
  '  </frameset>' + #13#10 +
  '</html>';
  scxTemplate8Name = 'Nested Hierarchy';
  scxTemplate8Description = 'Creates a nested information hierarchy. General hyperlinks on the left change the more specific on the right top.';
  scxTemplate8Template = '<html>' + #13#10 +
  '  <head>' + #13#10 +
  '    <title></title>' + #13#10 +
  '  </head>' + #13#10 +
  '  <frameset cols="150,*">' + #13#10 +
  '    <frame name="left" src="" scrolling="no" noresize>' + #13#10 +
  '    <frameset rows="20%,*">' + #13#10 +
  '      <frame name="rtop" src="">' + #13#10 +
  '      <frame name="rbottom" src="">' + #13#10 +
  '    </frameset>' + #13#10 +
  '    <noframes>' + #13#10 +
  '      <p>' + #13#10 +
  '        This HTML frameset displays multiple Web pages. To view this frameset, use a' + #13#10 +
  '        Web browser that supports HTML 4.0 and later.' + #13#10 +
  '      </p>' + #13#10 +
  '    </noframes>' + #13#10 +
  '  </frameset>' + #13#10 +
  '</html>';
  scxTemplate9Name = 'Top-Down Hierarchy';
  scxTemplate9Description = 'Creates a top-down information hierarchy. General hyperlinks at the top change the more specific middle frame.';
  scxTemplate9Template = '<html>' + #13#10 +
  '  <head>' + #13#10 +
  '    <title></title>' + #13#10 +
  '  </head>' + #13#10 +
  '  <frameset rows="64,25%,*">' + #13#10 +
  '    <frame name="top" src="" scrolling="no" noresize>' + #13#10 +
  '    <frame name="middle" src="">' + #13#10 +
  '    <frame name="bottom" src="">' + #13#10 +
  '    <noframes>' + #13#10 +
  '      <p>' + #13#10 +
  '        This HTML frameset displays multiple Web pages. To view this frameset, use a' + #13#10 +
  '        Web browser that supports HTML 4.0 and later.' + #13#10 +
  '      </p>' + #13#10 +
  '    </noframes>' + #13#10 +
  '  </frameset>' + #13#10 +
  '</html>';
  scxTemplate10Name = 'Vertical Split';
  scxTemplate10Description = 'Creates independent right and left frames.';
  scxTemplate10Template = '<html>' + #13#10 +
  '  <head>' + #13#10 +
  '    <title></title>' + #13#10 +
  '  </head>' + #13#10 +
  '  <frameset cols="*,*">' + #13#10 +
  '    <frame name="left" src="">' + #13#10 +
  '    <frame name="right" src="">' + #13#10 +
  '    <noframes>' + #13#10 +
  '      <p>' + #13#10 +
  '        This HTML frameset displays multiple Web pages. To view this frameset, use a' + #13#10 +
  '        Web browser that supports HTML 4.0 and later.' + #13#10 +
  '      </p>' + #13#10 +
  '    </noframes>' + #13#10 +
  '  </frameset>' + #13#10 +
  '</html>';
  scxTemplate11Name = 'Whole Frame';
  scxTemplate11Description = 'Creates a single main frame.';
  scxTemplate11Template = '<html>' + #13#10 +
  '  <head>' + #13#10 +
  '    <title></title>' + #13#10 +
  '  </head>' + #13#10 +
  '  <frameset cols="*">' + #13#10 +
  '    <frame name="main" src="">' + #13#10 +
  '    <noframes>' + #13#10 +
  '      <p>' + #13#10 +
  '        This HTML frameset displays multiple Web pages. To view this frameset, use a' + #13#10 +
  '        Web browser that supports HTML 4.0 and later.' + #13#10 +
  '      </p>' + #13#10 +
  '    </noframes>' + #13#10 +
  '  </frameset>' + #13#10 +
  '</html>';


implementation

end.
