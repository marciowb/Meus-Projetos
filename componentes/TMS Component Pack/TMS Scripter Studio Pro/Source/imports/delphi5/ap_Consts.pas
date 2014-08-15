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
    AddConstant('SAssignError',SAssignError);
    AddConstant('SFCreateError',SFCreateError);
    AddConstant('SFOpenError',SFOpenError);
    AddConstant('SReadError',SReadError);
    AddConstant('SWriteError',SWriteError);
    AddConstant('SMemoryStreamError',SMemoryStreamError);
    AddConstant('SCantWriteResourceStreamError',SCantWriteResourceStreamError);
    AddConstant('SDuplicateReference',SDuplicateReference);
    AddConstant('SClassNotFound',SClassNotFound);
    AddConstant('SInvalidImage',SInvalidImage);
    AddConstant('SResNotFound',SResNotFound);
    AddConstant('SClassMismatch',SClassMismatch);
    AddConstant('SListIndexError',SListIndexError);
    AddConstant('SListCapacityError',SListCapacityError);
    AddConstant('SListCountError',SListCountError);
    AddConstant('SSortedListError',SSortedListError);
    AddConstant('SDuplicateString',SDuplicateString);
    AddConstant('SInvalidTabIndex',SInvalidTabIndex);
    AddConstant('SInvalidTabPosition',SInvalidTabPosition);
    AddConstant('SInvalidTabStyle',SInvalidTabStyle);
    AddConstant('SDuplicateName',SDuplicateName);
    AddConstant('SInvalidName',SInvalidName);
    AddConstant('SDuplicateClass',SDuplicateClass);
    AddConstant('SNoComSupport',SNoComSupport);
    AddConstant('SInvalidInteger',SInvalidInteger);
    AddConstant('SLineTooLong',SLineTooLong);
    AddConstant('SInvalidPropertyValue',SInvalidPropertyValue);
    AddConstant('SInvalidPropertyPath',SInvalidPropertyPath);
    AddConstant('SInvalidPropertyType',SInvalidPropertyType);
    AddConstant('SInvalidPropertyElement',SInvalidPropertyElement);
    AddConstant('SUnknownProperty',SUnknownProperty);
    AddConstant('SReadOnlyProperty',SReadOnlyProperty);
    AddConstant('SPropertyException',SPropertyException);
    AddConstant('SAncestorNotFound',SAncestorNotFound);
    AddConstant('SInvalidBitmap',SInvalidBitmap);
    AddConstant('SInvalidIcon',SInvalidIcon);
    AddConstant('SInvalidMetafile',SInvalidMetafile);
    AddConstant('SInvalidPixelFormat',SInvalidPixelFormat);
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
    AddConstant('SRegisterError',SRegisterError);
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
    AddConstant('SParseError',SParseError);
    AddConstant('SIdentifierExpected',SIdentifierExpected);
    AddConstant('SStringExpected',SStringExpected);
    AddConstant('SNumberExpected',SNumberExpected);
    AddConstant('SCharExpected',SCharExpected);
    AddConstant('SSymbolExpected',SSymbolExpected);
    AddConstant('SInvalidNumber',SInvalidNumber);
    AddConstant('SInvalidString',SInvalidString);
    AddConstant('SInvalidProperty',SInvalidProperty);
    AddConstant('SInvalidBinary',SInvalidBinary);
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
    AddConstant('SCannotCreateName',SCannotCreateName);
    AddConstant('SDateEncodeError',SDateEncodeError);
    AddConstant('STimeEncodeError',STimeEncodeError);
    AddConstant('SInvalidDate',SInvalidDate);
    AddConstant('SInvalidTime',SInvalidTime);
    AddConstant('SInvalidDateTime',SInvalidDateTime);
    AddConstant('SInvalidFileName',SInvalidFileName);
    AddConstant('SDefaultFilter',SDefaultFilter);
    AddConstant('sAllFilter',sAllFilter);
    AddConstant('SNoVolumeLabel',SNoVolumeLabel);
    AddConstant('SInsertLineError',SInsertLineError);
    AddConstant('SConfirmCreateDir',SConfirmCreateDir);
    AddConstant('SSelectDirCap',SSelectDirCap);
    AddConstant('SCannotCreateDir',SCannotCreateDir);
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
    AddConstant('SRegCreateFailed',SRegCreateFailed);
    AddConstant('SRegSetDataFailed',SRegSetDataFailed);
    AddConstant('SRegGetDataFailed',SRegGetDataFailed);
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
    AddConstant('sWindowsSocketError',sWindowsSocketError);
    AddConstant('sAsyncSocketError',sAsyncSocketError);
    AddConstant('sNoAddress',sNoAddress);
    AddConstant('sCannotListenOnOpen',sCannotListenOnOpen);
    AddConstant('sCannotCreateSocket',sCannotCreateSocket);
    AddConstant('sSocketAlreadyOpen',sSocketAlreadyOpen);
    AddConstant('sCantChangeWhileActive',sCantChangeWhileActive);
    AddConstant('sSocketMustBeBlocking',sSocketMustBeBlocking);
    AddConstant('sSocketIOError',sSocketIOError);
    AddConstant('sSocketRead',sSocketRead);
    AddConstant('sSocketWrite',sSocketWrite);
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
    AddConstant('SAllCommands',SAllCommands);
    AddConstant('SDuplicateItem',SDuplicateItem);
    AddConstant('SDuplicatePropertyCategory',SDuplicatePropertyCategory);
    AddConstant('SUnknownPropertyCategory',SUnknownPropertyCategory);
    AddConstant('SActionCategoryName',SActionCategoryName);
    AddConstant('SActionCategoryDesc',SActionCategoryDesc);
    AddConstant('SDataCategoryName',SDataCategoryName);
    AddConstant('SDataCategoryDesc',SDataCategoryDesc);
    AddConstant('SDatabaseCategoryName',SDatabaseCategoryName);
    AddConstant('SDatabaseCategoryDesc',SDatabaseCategoryDesc);
    AddConstant('SDragNDropCategoryName',SDragNDropCategoryName);
    AddConstant('SDragNDropCategoryDesc',SDragNDropCategoryDesc);
    AddConstant('SHelpCategoryName',SHelpCategoryName);
    AddConstant('SHelpCategoryDesc',SHelpCategoryDesc);
    AddConstant('SLayoutCategoryName',SLayoutCategoryName);
    AddConstant('SLayoutCategoryDesc',SLayoutCategoryDesc);
    AddConstant('SLegacyCategoryName',SLegacyCategoryName);
    AddConstant('SLegacyCategoryDesc',SLegacyCategoryDesc);
    AddConstant('SLinkageCategoryName',SLinkageCategoryName);
    AddConstant('SLinkageCategoryDesc',SLinkageCategoryDesc);
    AddConstant('SLocaleCategoryName',SLocaleCategoryName);
    AddConstant('SLocaleCategoryDesc',SLocaleCategoryDesc);
    AddConstant('SLocalizableCategoryName',SLocalizableCategoryName);
    AddConstant('SLocalizableCategoryDesc',SLocalizableCategoryDesc);
    AddConstant('SMiscellaneousCategoryName',SMiscellaneousCategoryName);
    AddConstant('SMiscellaneousCategoryDesc',SMiscellaneousCategoryDesc);
    AddConstant('SVisualCategoryName',SVisualCategoryName);
    AddConstant('SVisualCategoryDesc',SVisualCategoryDesc);
    AddConstant('SInputCategoryName',SInputCategoryName);
    AddConstant('SInputCategoryDesc',SInputCategoryDesc);
    AddConstant('SInvalidMask',SInvalidMask);
    AddConstant('SInvalidFilter',SInvalidFilter);
    AddConstant('SInvalidCategory',SInvalidCategory);
    AddConstant('sOperationNotAllowed',sOperationNotAllowed);
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

