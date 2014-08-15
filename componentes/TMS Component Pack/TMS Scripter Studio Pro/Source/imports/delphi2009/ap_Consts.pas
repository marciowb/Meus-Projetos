{***************************************************************************}
{ This source code was generated automatically by                           }
{ Pas file import tool for Scripter Studio (Pro)                            }
{                                                                           }
{ Scripter Studio and Pas file import tool for Scripter Studio              }
{ written by TMS Software                                                   }
{            copyright © 1997 - 2010                                        }
{            Email : info@tmssoftware.com                                   }
{            Web : http://www.tmssoftware.com                               }
{***************************************************************************}
unit ap_Consts;

interface

uses
  Consts,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatConstsLibrary = class(TatScripterLibrary)
    procedure Init; override;
    class function LibraryName: string; override;
  end;




implementation



procedure TatConstsLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    AddConstant('SOpenFileTitle',SOpenFileTitle);
    AddConstant('SCantWriteResourceStreamError',SCantWriteResourceStreamError);
    AddConstant('SDuplicateReference',SDuplicateReference);
    AddConstant('SClassMismatch',SClassMismatch);
    AddConstant('SInvalidTabIndex',SInvalidTabIndex);
    AddConstant('SInvalidTabPosition',SInvalidTabPosition);
    AddConstant('SInvalidTabStyle',SInvalidTabStyle);
    AddConstant('SInvalidBitmap',SInvalidBitmap);
    AddConstant('SInvalidIcon',SInvalidIcon);
    AddConstant('SInvalidMetafile',SInvalidMetafile);
    AddConstant('SInvalidPixelFormat',SInvalidPixelFormat);
    AddConstant('SInvalidImage',SInvalidImage);
    AddConstant('SBitmapEmpty',SBitmapEmpty);
    AddConstant('SScanLine',SScanLine);
    AddConstant('SChangeIconSize',SChangeIconSize);
    AddConstant('SOleGraphic',SOleGraphic);
    AddConstant('SUnknownExtension',SUnknownExtension);
    AddConstant('SUnknownClipboardFormat',SUnknownClipboardFormat);
    AddConstant('SOutOfResources',SOutOfResources);
    AddConstant('SNoCanvasHandle',SNoCanvasHandle);
    AddConstant('SInvalidImageSize',SInvalidImageSize);
    AddConstant('STooManyImages',STooManyImages);
    AddConstant('SDimsDoNotMatch',SDimsDoNotMatch);
    AddConstant('SInvalidImageList',SInvalidImageList);
    AddConstant('SReplaceImage',SReplaceImage);
    AddConstant('SImageIndexError',SImageIndexError);
    AddConstant('SImageReadFail',SImageReadFail);
    AddConstant('SImageWriteFail',SImageWriteFail);
    AddConstant('SWindowDCError',SWindowDCError);
    AddConstant('SClientNotSet',SClientNotSet);
    AddConstant('SWindowClass',SWindowClass);
    AddConstant('SWindowCreate',SWindowCreate);
    AddConstant('SCannotFocus',SCannotFocus);
    AddConstant('SParentRequired',SParentRequired);
    AddConstant('SParentGivenNotAParent',SParentGivenNotAParent);
    AddConstant('SMDIChildNotVisible',SMDIChildNotVisible);
    AddConstant('SVisibleChanged',SVisibleChanged);
    AddConstant('SCannotShowModal',SCannotShowModal);
    AddConstant('SScrollBarRange',SScrollBarRange);
    AddConstant('SPropertyOutOfRange',SPropertyOutOfRange);
    AddConstant('SMenuIndexError',SMenuIndexError);
    AddConstant('SMenuReinserted',SMenuReinserted);
    AddConstant('SMenuNotFound',SMenuNotFound);
    AddConstant('SNoTimers',SNoTimers);
    AddConstant('SNotPrinting',SNotPrinting);
    AddConstant('SPrinting',SPrinting);
    AddConstant('SPrinterIndexError',SPrinterIndexError);
    AddConstant('SInvalidPrinter',SInvalidPrinter);
    AddConstant('SDeviceOnPort',SDeviceOnPort);
    AddConstant('SGroupIndexTooLow',SGroupIndexTooLow);
    AddConstant('STwoMDIForms',STwoMDIForms);
    AddConstant('SNoMDIForm',SNoMDIForm);
    AddConstant('SImageCanvasNeedsBitmap',SImageCanvasNeedsBitmap);
    AddConstant('SControlParentSetToSelf',SControlParentSetToSelf);
    AddConstant('SOKButton',SOKButton);
    AddConstant('SCancelButton',SCancelButton);
    AddConstant('SYesButton',SYesButton);
    AddConstant('SNoButton',SNoButton);
    AddConstant('SHelpButton',SHelpButton);
    AddConstant('SCloseButton',SCloseButton);
    AddConstant('SIgnoreButton',SIgnoreButton);
    AddConstant('SRetryButton',SRetryButton);
    AddConstant('SAbortButton',SAbortButton);
    AddConstant('SAllButton',SAllButton);
    AddConstant('SCannotDragForm',SCannotDragForm);
    AddConstant('SPutObjectError',SPutObjectError);
    AddConstant('SCardDLLNotLoaded',SCardDLLNotLoaded);
    AddConstant('SDuplicateCardId',SDuplicateCardId);
    AddConstant('SDdeErr',SDdeErr);
    AddConstant('SDdeConvErr',SDdeConvErr);
    AddConstant('SDdeMemErr',SDdeMemErr);
    AddConstant('SDdeNoConnect',SDdeNoConnect);
    AddConstant('SFB',SFB);
    AddConstant('SFG',SFG);
    AddConstant('SBG',SBG);
    AddConstant('SOldTShape',SOldTShape);
    AddConstant('SVMetafiles',SVMetafiles);
    AddConstant('SVEnhMetafiles',SVEnhMetafiles);
    AddConstant('SVIcons',SVIcons);
    AddConstant('SVBitmaps',SVBitmaps);
    AddConstant('SGridTooLarge',SGridTooLarge);
    AddConstant('STooManyDeleted',STooManyDeleted);
    AddConstant('SIndexOutOfRange',SIndexOutOfRange);
    AddConstant('SFixedColTooBig',SFixedColTooBig);
    AddConstant('SFixedRowTooBig',SFixedRowTooBig);
    AddConstant('SInvalidStringGridOp',SInvalidStringGridOp);
    AddConstant('SInvalidEnumValue',SInvalidEnumValue);
    AddConstant('SInvalidNumber',SInvalidNumber);
    AddConstant('SOutlineIndexError',SOutlineIndexError);
    AddConstant('SOutlineExpandError',SOutlineExpandError);
    AddConstant('SInvalidCurrentItem',SInvalidCurrentItem);
    AddConstant('SMaskErr',SMaskErr);
    AddConstant('SMaskEditErr',SMaskEditErr);
    AddConstant('SOutlineError',SOutlineError);
    AddConstant('SOutlineBadLevel',SOutlineBadLevel);
    AddConstant('SOutlineSelection',SOutlineSelection);
    AddConstant('SOutlineFileLoad',SOutlineFileLoad);
    AddConstant('SOutlineLongLine',SOutlineLongLine);
    AddConstant('SOutlineMaxLevels',SOutlineMaxLevels);
    AddConstant('SMsgDlgWarning',SMsgDlgWarning);
    AddConstant('SMsgDlgError',SMsgDlgError);
    AddConstant('SMsgDlgInformation',SMsgDlgInformation);
    AddConstant('SMsgDlgConfirm',SMsgDlgConfirm);
    AddConstant('SMsgDlgYes',SMsgDlgYes);
    AddConstant('SMsgDlgNo',SMsgDlgNo);
    AddConstant('SMsgDlgOK',SMsgDlgOK);
    AddConstant('SMsgDlgCancel',SMsgDlgCancel);
    AddConstant('SMsgDlgHelp',SMsgDlgHelp);
    AddConstant('SMsgDlgHelpNone',SMsgDlgHelpNone);
    AddConstant('SMsgDlgHelpHelp',SMsgDlgHelpHelp);
    AddConstant('SMsgDlgAbort',SMsgDlgAbort);
    AddConstant('SMsgDlgRetry',SMsgDlgRetry);
    AddConstant('SMsgDlgIgnore',SMsgDlgIgnore);
    AddConstant('SMsgDlgAll',SMsgDlgAll);
    AddConstant('SMsgDlgNoToAll',SMsgDlgNoToAll);
    AddConstant('SMsgDlgYesToAll',SMsgDlgYesToAll);
    AddConstant('SMsgDlgClose',SMsgDlgClose);
    AddConstant('SmkcBkSp',SmkcBkSp);
    AddConstant('SmkcTab',SmkcTab);
    AddConstant('SmkcEsc',SmkcEsc);
    AddConstant('SmkcEnter',SmkcEnter);
    AddConstant('SmkcSpace',SmkcSpace);
    AddConstant('SmkcPgUp',SmkcPgUp);
    AddConstant('SmkcPgDn',SmkcPgDn);
    AddConstant('SmkcEnd',SmkcEnd);
    AddConstant('SmkcHome',SmkcHome);
    AddConstant('SmkcLeft',SmkcLeft);
    AddConstant('SmkcUp',SmkcUp);
    AddConstant('SmkcRight',SmkcRight);
    AddConstant('SmkcDown',SmkcDown);
    AddConstant('SmkcIns',SmkcIns);
    AddConstant('SmkcDel',SmkcDel);
    AddConstant('SmkcShift',SmkcShift);
    AddConstant('SmkcCtrl',SmkcCtrl);
    AddConstant('SmkcAlt',SmkcAlt);
    AddConstant('srUnknown',srUnknown);
    AddConstant('srNone',srNone);
    AddConstant('SOutOfRange',SOutOfRange);
    AddConstant('SDateEncodeError',SDateEncodeError);
    AddConstant('SDefaultFilter',SDefaultFilter);
    AddConstant('sAllFilter',sAllFilter);
    AddConstant('SNoVolumeLabel',SNoVolumeLabel);
    AddConstant('SInsertLineError',SInsertLineError);
    AddConstant('SConfirmCreateDir',SConfirmCreateDir);
    AddConstant('SSelectDirCap',SSelectDirCap);
    AddConstant('SDirNameCap',SDirNameCap);
    AddConstant('SDrivesCap',SDrivesCap);
    AddConstant('SDirsCap',SDirsCap);
    AddConstant('SFilesCap',SFilesCap);
    AddConstant('SNetworkCap',SNetworkCap);
    AddConstant('SColorPrefix',SColorPrefix);
    AddConstant('SColorTags',SColorTags);
    AddConstant('SInvalidClipFmt',SInvalidClipFmt);
    AddConstant('SIconToClipboard',SIconToClipboard);
    AddConstant('SCannotOpenClipboard',SCannotOpenClipboard);
    AddConstant('SDefault',SDefault);
    AddConstant('SInvalidMemoSize',SInvalidMemoSize);
    AddConstant('SCustomColors',SCustomColors);
    AddConstant('SInvalidPrinterOp',SInvalidPrinterOp);
    AddConstant('SNoDefaultPrinter',SNoDefaultPrinter);
    AddConstant('SIniFileWriteError',SIniFileWriteError);
    AddConstant('SBitsIndexError',SBitsIndexError);
    AddConstant('SUntitled',SUntitled);
    AddConstant('SInvalidRegType',SInvalidRegType);
    AddConstant('SUnknownConversion',SUnknownConversion);
    AddConstant('SDuplicateMenus',SDuplicateMenus);
    AddConstant('SPictureLabel',SPictureLabel);
    AddConstant('SPictureDesc',SPictureDesc);
    AddConstant('SPreviewLabel',SPreviewLabel);
    AddConstant('SCannotOpenAVI',SCannotOpenAVI);
    AddConstant('SNotOpenErr',SNotOpenErr);
    AddConstant('SMPOpenFilter',SMPOpenFilter);
    AddConstant('SMCINil',SMCINil);
    AddConstant('SMCIAVIVideo',SMCIAVIVideo);
    AddConstant('SMCICDAudio',SMCICDAudio);
    AddConstant('SMCIDAT',SMCIDAT);
    AddConstant('SMCIDigitalVideo',SMCIDigitalVideo);
    AddConstant('SMCIMMMovie',SMCIMMMovie);
    AddConstant('SMCIOther',SMCIOther);
    AddConstant('SMCIOverlay',SMCIOverlay);
    AddConstant('SMCIScanner',SMCIScanner);
    AddConstant('SMCISequencer',SMCISequencer);
    AddConstant('SMCIVCR',SMCIVCR);
    AddConstant('SMCIVideodisc',SMCIVideodisc);
    AddConstant('SMCIWaveAudio',SMCIWaveAudio);
    AddConstant('SMCIUnknownError',SMCIUnknownError);
    AddConstant('SBoldItalicFont',SBoldItalicFont);
    AddConstant('SBoldFont',SBoldFont);
    AddConstant('SItalicFont',SItalicFont);
    AddConstant('SRegularFont',SRegularFont);
    AddConstant('SPropertiesVerb',SPropertiesVerb);
    AddConstant('SServiceFailed',SServiceFailed);
    AddConstant('SExecute',SExecute);
    AddConstant('SStart',SStart);
    AddConstant('SStop',SStop);
    AddConstant('SPause',SPause);
    AddConstant('SContinue',SContinue);
    AddConstant('SInterrogate',SInterrogate);
    AddConstant('SShutdown',SShutdown);
    AddConstant('SCustomError',SCustomError);
    AddConstant('SServiceInstallOK',SServiceInstallOK);
    AddConstant('SServiceInstallFailed',SServiceInstallFailed);
    AddConstant('SServiceUninstallOK',SServiceUninstallOK);
    AddConstant('SServiceUninstallFailed',SServiceUninstallFailed);
    AddConstant('SInvalidActionRegistration',SInvalidActionRegistration);
    AddConstant('SInvalidActionUnregistration',SInvalidActionUnregistration);
    AddConstant('SInvalidActionEnumeration',SInvalidActionEnumeration);
    AddConstant('SInvalidActionCreation',SInvalidActionCreation);
    AddConstant('SDockedCtlNeedsName',SDockedCtlNeedsName);
    AddConstant('SDockTreeRemoveError',SDockTreeRemoveError);
    AddConstant('SDockZoneNotFound',SDockZoneNotFound);
    AddConstant('SDockZoneHasNoCtl',SDockZoneHasNoCtl);
    AddConstant('SDockZoneVersionConflict',SDockZoneVersionConflict);
    AddConstant('SAllCommands',SAllCommands);
    AddConstant('SDuplicateItem',SDuplicateItem);
    AddConstant('STextNotFound',STextNotFound);
    AddConstant('SBrowserExecError',SBrowserExecError);
    AddConstant('SColorBoxCustomCaption',SColorBoxCustomCaption);
    AddConstant('SMultiSelectRequired',SMultiSelectRequired);
    AddConstant('SKeyCaption',SKeyCaption);
    AddConstant('SValueCaption',SValueCaption);
    AddConstant('SKeyConflict',SKeyConflict);
    AddConstant('SKeyNotFound',SKeyNotFound);
    AddConstant('SNoColumnMoving',SNoColumnMoving);
    AddConstant('SNoEqualsInKey',SNoEqualsInKey);
    AddConstant('SSendError',SSendError);
    AddConstant('SAssignSubItemError',SAssignSubItemError);
    AddConstant('SDeleteItemWithSubItems',SDeleteItemWithSubItems);
    AddConstant('SDeleteNotAllowed',SDeleteNotAllowed);
    AddConstant('SMoveNotAllowed',SMoveNotAllowed);
    AddConstant('SMoreButtons',SMoreButtons);
    AddConstant('SErrorDownloadingURL',SErrorDownloadingURL);
    AddConstant('SUrlMonDllMissing',SUrlMonDllMissing);
    AddConstant('SAllActions',SAllActions);
    AddConstant('SNoCategory',SNoCategory);
    AddConstant('SExpand',SExpand);
    AddConstant('SErrorSettingPath',SErrorSettingPath);
    AddConstant('SLBPutError',SLBPutError);
    AddConstant('SErrorLoadingFile',SErrorLoadingFile);
    AddConstant('SResetUsageData',SResetUsageData);
    AddConstant('SFileRunDialogTitle',SFileRunDialogTitle);
    AddConstant('SNoName',SNoName);
    AddConstant('SErrorActionManagerNotAssigned',SErrorActionManagerNotAssigned);
    AddConstant('SAddRemoveButtons',SAddRemoveButtons);
    AddConstant('SResetActionToolBar',SResetActionToolBar);
    AddConstant('SCustomize',SCustomize);
    AddConstant('SSeparator',SSeparator);
    AddConstant('SCircularReferencesNotAllowed',SCircularReferencesNotAllowed);
    AddConstant('SCannotHideActionBand',SCannotHideActionBand);
    AddConstant('SErrorSettingCount',SErrorSettingCount);
    AddConstant('SListBoxMustBeVirtual',SListBoxMustBeVirtual);
    AddConstant('SUnableToSaveSettings',SUnableToSaveSettings);
    AddConstant('SRestoreDefaultSchedule',SRestoreDefaultSchedule);
    AddConstant('SNoGetItemEventHandler',SNoGetItemEventHandler);
    AddConstant('SInvalidColorMap',SInvalidColorMap);
    AddConstant('SDuplicateActionBarStyleName',SDuplicateActionBarStyleName);
    AddConstant('SStandardStyleActionBars',SStandardStyleActionBars);
    AddConstant('SXPStyleActionBars',SXPStyleActionBars);
    AddConstant('SActionBarStyleMissing',SActionBarStyleMissing);
    AddConstant('sParameterCannotBeNil',sParameterCannotBeNil);
    AddConstant('SInvalidColorString',SInvalidColorString);
    AddConstant('SInvalidPath',SInvalidPath);
    AddConstant('SInvalidPathCaption',SInvalidPathCaption);
    AddConstant('SANSIEncoding',SANSIEncoding);
    AddConstant('SASCIIEncoding',SASCIIEncoding);
    AddConstant('SUnicodeEncoding',SUnicodeEncoding);
    AddConstant('SBigEndianEncoding',SBigEndianEncoding);
    AddConstant('SUTF8Encoding',SUTF8Encoding);
    AddConstant('SUTF7Encoding',SUTF7Encoding);
    AddConstant('SEncodingLabel',SEncodingLabel);
    AddConstant('sCannotAddFixedSize',sCannotAddFixedSize);
    AddConstant('sInvalidSpan',sInvalidSpan);
    AddConstant('sInvalidRowIndex',sInvalidRowIndex);
    AddConstant('sInvalidColumnIndex',sInvalidColumnIndex);
    AddConstant('sInvalidControlItem',sInvalidControlItem);
    AddConstant('sCannotDeleteColumn',sCannotDeleteColumn);
    AddConstant('sCannotDeleteRow',sCannotDeleteRow);
    AddConstant('sCellMember',sCellMember);
    AddConstant('sCellSizeType',sCellSizeType);
    AddConstant('sCellValue',sCellValue);
    AddConstant('sCellAutoSize',sCellAutoSize);
    AddConstant('sCellPercentSize',sCellPercentSize);
    AddConstant('sCellAbsoluteSize',sCellAbsoluteSize);
    AddConstant('sCellColumn',sCellColumn);
    AddConstant('sCellRow',sCellRow);
    AddConstant('STrayIconRemoveError',STrayIconRemoveError);
    AddConstant('STrayIconCreateError',STrayIconCreateError);
    AddConstant('SPageControlNotSet',SPageControlNotSet);
    AddConstant('SWindowsVistaRequired',SWindowsVistaRequired);
    AddConstant('SXPThemesRequired',SXPThemesRequired);
    AddConstant('STaskDlgButtonCaption',STaskDlgButtonCaption);
    AddConstant('STaskDlgRadioButtonCaption',STaskDlgRadioButtonCaption);
    AddConstant('SInvalidTaskDlgButtonCaption',SInvalidTaskDlgButtonCaption);
    AddConstant('SInvalidCategoryPanelParent',SInvalidCategoryPanelParent);
    AddConstant('SInvalidCategoryPanelGroupChild',SInvalidCategoryPanelGroupChild);
  end;
end;

class function TatConstsLibrary.LibraryName: string;
begin
  result := 'Consts';
end;

initialization
  RegisterScripterLibrary(TatConstsLibrary, True);

{$WARNINGS ON}

end.

