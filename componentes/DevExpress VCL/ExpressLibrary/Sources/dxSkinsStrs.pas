
{********************************************************************}
{                                                                    }
{           Developer Express Visual Component Library               }
{           Express Cross Platform Library classes                   }
{                                                                    }
{           Copyright (c) 2000-2010 Developer Express Inc.           }
{           ALL RIGHTS RESERVED                                      }
{                                                                    }
{   The entire contents of this file is protected by U.S. and        }
{   International Copyright Laws. Unauthorized reproduction,         }
{   reverse-engineering, and distribution of all or any portion of   }
{   the code contained in this file is strictly prohibited and may   }
{   result in severe civil and criminal penalties and will be        }
{   prosecuted to the maximum extent possible under the law.         }
{                                                                    }
{   RESTRICTIONS                                                     }
{                                                                    }
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES            }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE     }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS    }
{   LICENSED TO DISTRIBUTE THE EXPRESSCROSSPLATFORMLIBRARY AND ALL   }
{   ACCOMPANYING VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM       }
{   ONLY.                                                            }
{                                                                    }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED       }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE         }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE        }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT   }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                       }
{                                                                    }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON        }
{   ADDITIONAL RESTRICTIONS.                                         }
{                                                                    }
{********************************************************************}

unit dxSkinsStrs;

interface

uses
  cxGraphics, cxLookAndFeelPainters;

resourcestring
  sdxSkinInvalidStreamFormat = 'Invalid stream format';
  sdxOldFormat = 'The skin data version is older than the current ExpressSkins Library version.'  + #13#10 +
                 'Skins cannot be loaded due to a version mismatch.';
  sdxSkinElementNotFound = 'Element "%s" not found';
  sdxSkinGroupNotFound = 'Group "%s" not found';
  sdxSkinParentNotFound = 'Parent skin "%s" not found';
  sdxSkinsRootFolder = 'My DX_VCL Skins';

const
  sdxSkinBinaryProjectExt = '.skinres';

  // skins core
  sdxResourceType = 'DXSKINS';
  sdxNavBarResourceType = 'DXNAVBARSKINS';

  sdxAdditionProperties ='AdditionalProperties';
  sdxColors = 'Colors';
  sdxInteger = 'Int';
  sdxMinSize = 'MinSize';
  sdxProperties = 'Properties';
  sdxValue = 'Value';
  sdxOffset = 'Offset';

  //colors
  sdxSchedulerSeparatorColor = 'SeparatorColor';
  sdxSkinsBarDisabledTextColor = 'DisabledTextColor';
  sdxSkinsButtonDisabledTextColor = 'DisabledText';
  sdxSkinsContainerBorderColor = 'ContainerBorderColor';
  sdxSkinsContainerHighlightBorderColor = 'ContainerHighlightBorderColor';
  sdxSkinsContentColor = 'ContentColor';
  sdxSkinsContentEvenColor = 'ContentEvenColor';
  sdxSkinsContentOddColor = 'ContentOddColor';
  sdxSkinsContentTextColor = 'ContentTextColor';
  sdxSkinsHeaderBackgroundColor = 'HeaderBackgroundColor';
  sdxSkinsHeaderBackgroundTextColor = 'HeaderBackgroundTextColor';
  sdxSkinsLayoutControlColor = 'LayoutControlColor';
  sdxSkinsSchedulerNavigatorColor = 'NavigatorColor';
  sdxSkinsSelectionColor = 'SelectionColor';
  sdxSkinsSelectionTextColor = 'SelectionTextColor';
  sdxSkinsTabTextColor = 'TabHeaderTextColor';
  sdxSkinsTabTextColorActive = 'TabHeaderTextColorActive';
  sdxSkinsTabTextColorDisabled = 'TabHeaderTextColorDisabled';
  sdxSkinsTabTextColorHot = 'TabHeaderTextColorHot';

  // Edit Colors
  sdxSkinsEditorBackgroundColor = 'BackgroundColor';
  sdxSkinsEditorBackgroundDisabledColor = 'BackgroundDisabledColor';
  sdxSkinsEditorBackgroundInactiveColor = 'BackgroundInactiveColor';
  sdxSkinsEditorBackgroundReadOnlyColor = 'BackgroundReadOnlyColor';
  sdxSkinsEditorTextColor = 'TextColor';
  sdxSkinsEditorTextDisabledColor = 'TextDisabledColor';
  sdxSkinsEditorTextInactiveColor = 'TextInactiveColor';
  sdxSkinsEditorTextReadOnlyColor = 'TextReadOnlyColor';
  sdxSkinsEditorHyperLinkTextColor = 'HyperLinkTextColor';

  // LayoutView
  sdxLayoutViewRecord = 'LayoutViewRecord';
  sdxLayoutViewRecordBottom = 'LayoutViewRecordBottom';
  sdxLayoutViewRecordLeft = 'LayoutViewRecordLeft';
  sdxLayoutViewRecordRight = 'LayoutViewRecordRight';
  sdxLayoutViewRecordTop = 'LayoutViewRecordTop';

  sdxLayoutViewRecordCaptionBottom = 'LayoutViewRecordCaptionBottom';
  sdxLayoutViewRecordCaptionLeft = 'LayoutViewRecordCaptionLeft';
  sdxLayoutViewRecordCaptionRight = 'LayoutViewRecordCaptionRight';
  sdxLayoutViewRecordCaptionTop = 'LayoutViewRecordCaptionTop';

  sdxLayoutViewRecordExpandButton = 'LayoutViewRecordExpandButton';

  sdxLayoutViewGroupPadding = 'LayoutViewGroupPadding';
  sdxLayoutViewGroupSpacing = 'LayoutViewGroupSpacing';
  sdxLayoutViewGroupWithoutBordersPadding = 'LayoutViewGroupWithoutBordersPadding';
  sdxLayoutViewGroupWithoutBordersSpacing = 'LayoutViewGroupWithoutBordersSpacing';
  sdxLayoutViewItem = 'LayoutViewItem';
  sdxLayoutViewItemPadding = 'LayoutViewItemPadding';
  sdxLayoutViewItemSpacing = 'LayoutViewItemSpacing';
  sdxLayoutViewRootGroupPadding = 'LayoutViewRootGroupPadding';
  sdxLayoutViewRootGroupSpacing = 'LayoutViewRootGroupSpacing';
  sdxLayoutViewRootGroupWithoutBordersPadding = 'LayoutViewRootGroupWithoutBordersPadding';
  sdxLayoutViewRootGroupWithoutBordersSpacing = 'LayoutViewRootGroupWithoutBordersSpacing';
  sdxLayoutViewTabbedGroupPadding = 'LayoutViewTabbedGroupPadding';
  sdxLayoutViewTabbedGroupSpacing = 'LayoutViewTabbedGroupSpacing';

  // ProgressBar
  sdxSkinsProgressBarFilledTextColor = 'ProgressBarFilledTextColor';
  sdxSkinsProgressBarEmptyTextColor = 'ProgressBarEmptyTextColor';

  // calendar
  sdxSkinsCalendarDayTextColor = 'CalendarDayTextColor';
  sdxSkinsCalendarHolidayTextColor = 'CalendarHolidayTextColor';
  sdxSkinsCalendarInactiveDayTextColor = 'CalendarInactiveDayTextColor';
  sdxSkinsCalendarSelectedDayColor = 'CalendarSelectedDayColor';
  sdxSkinsCalendarSelectedDayTextColor = 'CalendarSelectedDayTextColor';
  sdxSkinsCalendarSeparatorColor = 'CalendarSeparatorColor';
  sdxSkinsCalendarTodayFrameColor = 'CalendarTodayFrameColor';
  sdxSkinsCalendarTodayTextColor = 'CalendarTodayTextColor';

  // CalcEdit
  sdxSkinsCalcEditDigitTextColor = 'CalcEditDigitTextColor';
  sdxSkinsCalcEditArithmeticOperationTextColor = 'CalcEditArithmeticOperationTextColor';
  sdxSkinsCalcEditEditingOperationTextColor = 'CalcEditEditingOperationTextColor';
  sdxSkinsCalcEditMemoryOperationTextColor = 'CalcEditMemoryOperationTextColor';
  sdxSkinsCalcEditScientificOperationTextColor = 'CalcEditScientificOperationTextColor';

  // common
  sdxCaptionFontDelta = 'FontDelta';

  // dock control colors
  sdxSkinsDCCaptionActiveTextColor = 'DockControlCaptionActiveTextColor';
  sdxSkinsDCCaptionTextColor = 'DockControlCaptionTextColor';
  sdxSkinsDCHiddenBarTextColor = 'DockControlHiddenBarTextColor';
  sdxSkinsDCHiddenBarTextHotColor = 'DockControlHiddenBarTextHotColor';

  // groups
  sdxSkinGroupBars = 'Bars';
  sdxSkinGroupCommon = 'Common';
  sdxSkinGroupDocking = 'Docking';
  sdxSkinGroupEditors = 'Editors';
  sdxSkinGroupForm = 'Form';
  sdxSkinGroupGrid = 'Grid';
  sdxSkinGroupLayoutControl = 'LayoutControl';
  sdxSkinGroupNavBar = 'NavBar';
  sdxSkinGroupNavPane = 'NavPane';
  sdxSkinGroupPrintingSystem = 'PrintingSystem';
  sdxSkinGroupRibbon = 'Ribbon';
  sdxSkinGroupScheduler = 'Scheduler';
  sdxSkinGroupTabs = 'PageControl';
  sdxSkinGroupVGrid = 'VerticalGrid';

  // skin group elements

  sdxComboButtonGlyph = 'ComboButtonGlyph';
  sdxSpinUpGlyph = 'SpinUpGlyph';
  sdxSpinDownGlyph = 'SpinDownGlyph';
  sdxSpinLeftGlyph = 'SpinLeftGlyph';
  sdxSpinRightGlyph = 'SpinRightGlyph';
  sdxEditorButton = 'EditorButton';
  sdxEditorButtonMergeBorders = 'MergeBorders';
  sdxCloseButton = 'CloseButton';

  // bars elements
  sdxBarsBar = 'Bar';
  sdxBarsBarCustomize = 'BarCustomize';
  sdxBarsBarCustomizeVertical = 'BarCustomizeVertical';
  sdxBarsBarFinger = 'BarDragGrip';
  sdxBarsBarFingerVertical = 'BarDragGripVertical';
  sdxBarsBarSeparator = 'BarSeparator';
  sdxBarsBarVertical = 'BarVertical';
  sdxBarsBarVerticalSeparator = 'BarSeparatorVertical';
  sdxBarsDock = 'Dock';
  sdxBarsFloatBar = 'FloatBar';
  sdxBarsItemSeparator = 'ItemSeparator';
  sdxBarsLinkSelected = 'LinkSelected';
  sdxBarsLinkStatic = 'LinkStatic';
  sdxBarsMainMenu = 'MainMenu';
  sdxBarsMainMenuCustomize = 'MainMenuCustomize';
  sdxBarsMainMenuDrag = 'MainMenuDrag';
  sdxBarsMainMenuLinkSelected = 'MainMenuLinkSelected';
  sdxBarsMainMenuVertical = 'MainMenuVertical';
  sdxBarsMDIButtonClose = 'MDIButtonClose';
  sdxBarsMDIButtonMinimize = 'MDIButtonMinimize';
  sdxBarsMDIButtonRestore = 'MDIButtonRestore';
  sdxBarsPopupMenu = 'PopupMenu';
  sdxBarsPopupMenuCheck = 'PopupMenuCheck';
  sdxBarsPopupMenuDropDownButtonArrow = 'PopupMenuDropDownButtonArrow';
  sdxBarsPopupMenuDropDownButtonLabel = 'PopupMenuDropDownButtonLabel';
  sdxBarsPopupMenuExpandButton = 'PopupMenuExpandButton';
  sdxBarsPopupMenuLinkSelected = 'PopupMenuLinkSelected';
  sdxBarsPopupMenuSeparator = 'PopupMenuSeparator';
  sdxBarsPopupMenuSideStrip = 'PopupMenuSideStrip';
  sdxBarsPopupMenuSideStripNonRecent = 'PopupMenuSideStripNonRecent';

  // Label
  sdxLabelLine = 'LabelLine';
  sdxLabelLineVert = 'LabelLineVert';

  // Colors
  sdxTextColorNormal = 'TextColor';
  sdxTextColorDisabled = 'TextColorDisabled';
  sdxTextColorHot = 'TextColorHot';
  sdxTextColorPressed = 'TextColorPressed';
  sdxTextColorSelected = 'TextColorSelected';
  sdxTextInactiveColor = 'TextColorInactive';

  // ribbon elements
  sdxRibbonAppButtonLeftIndent = 'LeftIndent';
  sdxRibbonAppButtonRightIndent = 'RightIndent';
  sdxRibbonApplicationButton = 'FormAppButton';
  sdxRibbonApplicationButton2010 = 'FormAppButton2010';
  sdxRibbonAppMenuBackground = 'AppMenuBackground';
  sdxRibbonAppMenuFooterBackground = 'AppMenuBackgroundBottom';
  sdxRibbonAppMenuHeaderBackground = 'AppMenuBackgroundTop';
  sdxRibbonExtraPaneColor = 'AppMenuExtraPaneColor';
  sdxRibbonExtraPaneHeaderSeparator = 'AppMenuExtraPaneHeaderSeparator';
  sdxRibbonExtraPanePinButtonGlyph = 'AppMenuExtraPanePinButtonGlyph';
  sdxRibbonExtraPaneButton = 'AppMenuExtraPaneButton';
  sdxRibbonBackstageViewBackground = 'BackstageViewBackground';
  sdxRibbonBackstageViewMenuBackground = 'BackstageViewMenuBackground';
  sdxRibbonBackstageViewMenuButton = 'BackstageViewMenuButton';
  sdxRibbonBackstageViewTabHeader = 'BackstageViewTabHeader';
  sdxRibbonBackstageViewTopLine = 'BackstageViewTopLine';
  sdxRibbonButtonArrow = 'ButtonArrow';
  sdxRibbonButtonDisabledText = 'ButtonDisabled';
  sdxRibbonButtonGroup = 'ButtonGroup';
  sdxRibbonButtonGroupButton = 'ButtonGroupButton';
  sdxRibbonButtonGroupSeparator = 'ButtonGroupSeparator';
  sdxRibbonCaptionFontDelta = 'FontDelta';
  sdxRibbonCollapsedToolBarBackground = 'TabGroupCollapsed';
  sdxRibbonCollapsedToolBarGlyphBackground = 'TabGroupCollapsedBox';
  sdxRibbonContextualTabHeader = 'ContextualTabHeader';
  sdxRibbonContextualTabLabel = 'ContextualTabLabel';
  sdxRibbonContextualTabLabelOnGlass = 'ContextualTabLabelOnGlass';
  sdxRibbonContextualTabPanel = 'ContextualTabPanel';
  sdxRibbonContextualTabSeparator = 'ContextualTabSeparator';
  sdxRibbonDialogFrameBottom = 'DialogFrameBottom';
  sdxRibbonDialogFrameLeft = 'DialogFrameLeft';
  sdxRibbonDialogFrameRight = 'DialogFrameRight';
  sdxRibbonDocumentNameTextColor = 'DocumentNameTextColor';
  sdxRibbonEditorBackground = 'EditorBackground';
  sdxRibbonFormBottom = 'FormFrameBottom';
  sdxRibbonFormCaption = 'FormCaption';
  sdxRibbonFormFrameLeft = 'FormFrameLeft';
  sdxRibbonFormFrameRight = 'FormFrameRight';
  sdxRibbonGalleryBackground = 'DropDownGalleryBackground';
  sdxRibbonGalleryButtonDown = 'InRibbonGalleryButtonDown';
  sdxRibbonGalleryButtonDropDown = 'InRibbonGalleryButtonDropDown';
  sdxRibbonGalleryButtonUp = 'InRibbonGalleryButtonUp';
  sdxRibbonGalleryGroupCaption = 'DropDownGalleryGroupHeader';
  sdxRibbonGalleryPane = 'InRibbonGalleryPane';
  sdxRibbonGallerySizeGrips = 'DropDownGallerySizeGrip';
  sdxRibbonGallerySizingPanel = 'DropDownGallerySizePanel';
  sdxRibbonHeaderBackground = 'TabBackground';
  sdxRibbonHeaderBackgroundOnGlass = 'TabBackgroundOnGlass';
  sdxRibbonKeyTip = 'KeyTip';
  sdxRibbonLargeButton = 'LargeButton';
  sdxRibbonLargeSplitButtonBottom = 'LargeSplitButtonBottom';
  sdxRibbonLargeSplitButtonTop = 'LargeSplitButtonTop';
  sdxRibbonMinimizeButtonGlyph = 'MinimizeButtonGlyph';
  sdxRibbonQATCustomizeButtonOutsideQAT = 'DisplayCustomizeButtonOutsideQAT';
  sdxRibbonQATIndentBeforeCustomizeItem = 'IndentBeforeCustomizeButton';
  sdxRibbonQuickAccessToolbarOffset = 'Offset';
  sdxRibbonQuickToolbarAbove = 'QATAboveBackground';
  sdxRibbonQuickToolbarBelow = 'QATBelowBackground';
  sdxRibbonQuickToolbarButtonGlyph = 'QATButtonGlyph';
  sdxRibbonQuickToolbarDropDown = 'QATOverflow';
  sdxRibbonQuickToolbarGlyph = 'QATCustomizeButton';
  sdxRibbonQuickToolbarInCaption = 'QATInRibbonBackground';
  sdxRibbonSmallButton = 'Button';
  sdxRibbonSpaceBetweenTabGroups = 'SpaceBetweenTabGroups';
  sdxRibbonSplitButtonLeft = 'SplitButtonLeft';
  sdxRibbonSplitButtonRight = 'SplitButtonRight';
  sdxRibbonStatusBarBackground = 'StatusBarBackground';
  sdxRibbonStatusBarButton = 'StatusBarButton';
  sdxRibbonStatusBarSeparator = 'StatusBarSeparator';
  sdxRibbonTabAeroSupport = 'TabAeroSupport';
  sdxRibbonTabGroup = 'TabGroup';
  sdxRibbonTabGroupHeader = 'TabGroupCaption';
  sdxRibbonTabGroupItemsSeparator = 'TabGroupItemsSeparator';
  sdxRibbonTabGroupLeftScroll = 'TabGroupLeftScrollButton';
  sdxRibbonTabGroupRightScroll = 'TabGroupRightScrollButton';
  sdxRibbonTabHeaderDownGrowIndent = 'TabHeaderDownGrow';
  sdxRibbonTabHeaderPage = 'Tab';
  sdxRibbonTabPanel = 'TabPanel';
  sdxRibbonTabPanelGroupButton = 'TabGroupButton';
  sdxRibbonTabSeparatorLine = 'TabSeparatorLine';

  // navbar elemets
  sdxNavBarBackground = 'Background';
  sdxNavBarGroupClient = 'GroupClient';
  sdxNavBarGroupCloseButton = 'GroupCloseButton';
  sdxNavBarGroupFooter = 'GroupFooter';
  sdxNavBarGroupHeader = 'GroupHeader';
  sdxNavBarGroupOpenButton = 'GroupOpenButton';
  sdxNavBarItem = 'Item';

  sdxNavPaneCaptionFontSize = 'FontSize'; 
  sdxNavPaneCaptionHeight = 'Height';
  sdxNavPaneCollapseButton = 'CollapseButton';
  sdxNavPaneCollapsedGroupClient = 'CollapsedGroupClient';
  sdxNavPaneExpandButton = 'ExpandButton';
  sdxNavPaneFormBorder = 'PopupBorder';
  sdxNavPaneFormSizeGrip = 'PopupSizeGrip';
  sdxNavPaneGroupButton = 'GroupButton';
  sdxNavPaneGroupButtonSelected = 'GroupButtonSelected';
  sdxNavPaneGroupCaption = 'Caption';
  sdxNavPaneGroupClient = 'GroupClient';
  sdxNavPaneItem = 'Item';
  sdxNavPaneItemSelected = 'ItemSelected';
  sdxNavPaneOffsetGroupBorders = 'OverlapGroupBorders';
  sdxNavPaneOverflowPanel = 'OverflowPanel';
  sdxNavPaneOverflowPanelExpandItem = 'OverflowPanelExpandItem';
  sdxNavPaneOverflowPanelItem = 'OverflowPanelItem';
  sdxNavPaneScrollDownBtn = 'ScrollDownButton';
  sdxNavPaneScrollUpBtn = 'ScrollUpButton';
  sdxNavPaneSplitter = 'Splitter';

  // scheduler
  sdxSchedulerAllDayArea = 'AllDayArea';
  sdxSchedulerAllDayAreaSelected = 'AllDayAreaSelected';
  sdxSchedulerAppointment = 'Appointment';
  sdxSchedulerAppointmentBorder = 'AppointmentBorder';
  sdxSchedulerAppointmentBorderSize = 'BorderSize';
  sdxSchedulerAppointmentBottomShadow = 'AppointmentBottomShadow';
  sdxSchedulerAppointmentMask = 'AppointmentMask';
  sdxSchedulerAppointmentRight = 'AppointmentRightBorder';
  sdxSchedulerAppointmentRightShadow = 'AppointmentRightShadow';
  sdxSchedulerCurrentTimeIndicator = 'CurrentTimeIndicator';
  sdxSchedulerMoreButton = 'MoreButton';
  sdxSchedulerNavButtonNext = 'NavButtonNext';
  sdxSchedulerNavButtonNextArrow = 'NavButtonNextArrow';
  sdxSchedulerNavButtonPrev = 'NavButtonPrev';
  sdxSchedulerNavButtonPrevArrow = 'NavButtonPrevArrow';
  sdxSchedulerTimeGridCurrentTimeIndicator = 'TimeGridCurrentTimeIndicator';
  sdxSchedulerTimeGridHeader = 'TimeGridHeader';
  sdxSchedulerTimeGridHeaderSelected = 'TimeGridHeaderSelected';
  sdxSchedulerTimeLine = 'DefaultTimeLine';
  sdxSchedulerTimeRuler = 'Ruler';

  // dock control elements
  sdxDCActiveTabHeaderDownGrow = 'ActiveTabHeaderDownGrow';
  sdxDCActiveTabHeaderHGrow = 'ActiveTabHeaderHGrow';
  sdxDCActiveTabHeaderUpGrow = 'ActiveTabHeaderUpGrow';
  sdxDockCtrlAutoHideBar = 'AutoHideBar';
  sdxDockCtrlAutoHideBarBottom = 'AutoHideBarBottom';
  sdxDockCtrlAutoHideBarLeft = 'AutoHideBarLeft';
  sdxDockCtrlAutoHideBarRight = 'AutoHideBarRight';
  sdxDockCtrlBorder = 'DockWindowBorder';
  sdxDockCtrlCaption = 'DockWindowCaption';
  sdxDockCtrlInactiveCaptionTextColor = 'InactiveCaptionTextColor';
  sdxDockCtrlTabHeader = 'TabHeader';
  sdxDockCtrlTabHeaderAutoHideBar = 'TabHeaderAutoHideBar';
  sdxDockCtrlTabHeaderBackground = 'TabHeaderBackground';
  sdxDockCtrlTabHeaderLine = 'TabHeaderLine';
  sdxDockCtrlWindowButton = 'DockWindowButton';
  sdxDockCtrlWindowGlyphs = 'DockWindowButtonGlyphs';

  // skin group panel
  sdxGroupExpandButton = 'GroupExpandButton';
  sdxGroupPanel = 'GroupPanel';
  sdxGroupPanelBottom = 'GroupPanelBottom';
  sdxGroupPanelCaptionBottom = 'GroupPanelCaptionBottom';
  sdxGroupPanelCaptionLeft = 'GroupPanelCaptionLeft';
  sdxGroupPanelCaptionRight = 'GroupPanelCaptionRight';
  sdxGroupPanelCaptionTop = 'GroupPanelCaptionTop';
  sdxGroupPanelLeft = 'GroupPanelLeft';
  sdxGroupPanelNoBorder = 'GroupPanelNoBorder';
  sdxGroupPanelRight = 'GroupPanelRight';
  sdxGroupPanelTop = 'GroupPanelTop';

  sdxButton = 'Button';
  sdxCheckbox = 'Checkbox';
  sdxClock = 'ClockFace';
  sdxClockGlass = 'ClockGlass';
  sdxNavigatorGlyphs = 'Navigator';
  sdxNavigatorGlyphsVert = 'NavigatorVert';
  sdxProgressBorder = 'ProgressBorder';
  sdxProgressBorderVert = 'ProgressBorderVert';
  sdxProgressChunk = 'ProgressChunk';
  sdxProgressChunkVert = 'ProgressChunkVert';
  sdxRadioGroup = 'RadioButton';
  sdxScrollButton = 'ScrollButton';
  sdxScrollContentHorz = 'ScrollContentHorz';
  sdxScrollContentVert = 'ScrollContentVert';
  sdxScrollThumbButtonHorz = 'ScrollThumbHorz';
  sdxScrollThumbButtonVert = 'ScrollThumbVert';
  sdxSizeGrip = 'SizeGrip';
  sdxSplitterHorz = 'SplitterHorz';
  sdxSplitterVert = 'Splitter';
  sdxScreenTipItem = 'ScreenTipItem';
  sdxScreenTipSeparator = 'ScreenTipSeparator';
  sdxScreenTipTitleItem = 'ScreenTipTitleItem';
  sdxScreenTipWindow = 'ScreenTipWindow';


  // trackbar
  sdxTrackBarThumb = 'TrackBarThumb';
  sdxTrackBarThumbBoth = 'TrackBarThumbBoth';
  sdxTrackBarThumbUp = 'TrackBarThumbUp';
  sdxTrackBarThumbVert = 'TrackBarThumbVert';
  sdxTrackBarThumbVertBoth = 'TrackBarThumbVertBoth';
  sdxTrackBarThumbVertUp = 'TrackBarThumbVertUp';
  sdxTrackBarTrack = 'TrackBarTrack';
  sdxTrackBarTrackVert = 'TrackBarTrackVert';

  // PageControl
  sdxPageControlHeaderBottom = 'TabHeaderBottom';
  sdxPageControlHeaderCloseButton = 'TabHeaderCloseButton';
  sdxPageControlHeaderLeft = 'TabHeaderLeft';
  sdxPageControlHeaderRight = 'TabHeaderRight';
  sdxPageControlHeaderTop = 'TabHeader';
  sdxPageControlHorz = 'TabButtonHorz';
  sdxPageControlPane = 'TabPane';
  sdxPageControlVert = 'TabButtonVert';

  sdxHeaderDownGrow = 'HeaderDownGrow';
  sdxHeaderDownGrowBottomRight = 'HeaderDownGrowBottomRight';
  sdxRowIndentFar = 'RowIndentFar';
  sdxRowIndentNear = 'RowIndentNear';
  sdxSelectedHeaderDownGrow = 'SelectedHeaderDownGrow';
  sdxSelectedHeaderDownGrowBottomRight = 'SelectedHeaderDownGrowBottomRight';
  sdxSelectedHeaderHGrow = 'SelectedHeaderHGrow';
  sdxSelectedHeaderUpGrow = 'SelectedHeaderUpGrow';

  // grid
  sdxCardSeparator = 'CardSeparator';
  sdxFilterButton = 'FilterButton';
  sdxFilterButtonActive = 'FilterButtonActive';
  sdxFilterPanel = 'GridFilterPanel';
  sdxFooterCell = 'FooterCell';
  sdxFooterPanel = 'FooterPanel';
  sdxGridLine = 'GridLine';
  sdxGroupByBox = 'GridGroupPanel';
  sdxGroupRow = 'GroupRow';
  sdxHeader = 'Header';
  sdxHeaderLeft = 'HeaderLeft';
  sdxHeaderRight = 'HeaderRight';
  sdxHeaderSpecial = 'HeaderSpecial';
  sdxIndicatorImages = 'IndicatorImages';
  sdxGridFixedLine = 'GridFixedLine';
  sdxGridGroupRowStyleOffice11ContentColor = 'Office11ContentColor';
  sdxGridGroupRowStyleOffice11SeparatorColor = 'Office11SeparatorColor';
  sdxGridGroupRowStyleOffice11TextColor = 'Office11TextColor';

  sdxPlusMinus = 'PlusMinus';
  sdxPlusMinusEx = 'PlusMinusEx';

  sdxVGridBandLine = 'BandBorder';
  sdxVGridLine = 'GridLine';
  sdxVGridRowHeader = 'RowHeader';
  sdxVGridCategory = 'Category';

  // form
  sdxTextShadowColor = 'TextShadowColor';

  sdxFormFrameLeft = 'FormFrameLeft';
  sdxFormCaption = 'FormCaption';
  sdxFormContent = 'FormContent';
  sdxFormFrameRight = 'FormFrameRight';
  sdxFormFrameBottom = 'FormFrameBottom';

  sdxSmallFormFrameLeft = 'SmallFormFrameLeft';
  sdxSmallFormCaption = 'SmallFormCaption';
  sdxSmallFormFrameRight = 'SmallFormFrameRight';
  sdxSmallFormFrameBottom = 'SmallFormFrameBottom';

  sdxFormButtonClose = 'FormButtonClose';
  sdxFormButtonHelp = 'FormButtonHelp';
  sdxFormButtonMaximize = 'FormButtonMaximize';
  sdxFormButtonMinimize = 'FormButtonMinimize';
  sdxFormButtonRestore = 'FormButtonRestore';
  sdxSmallFormButtonClose = 'SmallFormButtonClose';
  sdxStatusBar = 'StatusBar';

  // Printing System
  sdxPrintingSystemPageBorder = 'PageBorder';
  sdxPrintingSystemPreviewBackground = 'PreviewBackground';

  // xml storage
  sdxItem = 'Item';
  sdxItems = 'Items';
  
  sdxControlParts = 'ControlParts';
  sdxDisplayName = 'DisplayName';
  sdxGlyph = 'Glyph';
  sdxImage = 'Image';
  sdxName = 'Name';
  sdxParentName = 'Parent';
  sdxPart = 'Part';
  sdxVersion = 'Version';

  sdxSkinGroupName = 'SkinGroupName';
  sdxSkinIcon = 'SkinIcon';
  sdxSkinIconLarge = 'SkinIconLarge';
  sdxSkinDefaultGroupName = 'Custom Skins';
  sdxSkinDefaultSkinIcon = 'DEFAULTSKINICONSMALL';
  sdxSkinDefaultSkinIconLarge = 'DEFAULTSKINICONLARGE';

  // layout orientation
  sdxLayoutHorz = 'Horizontal';
  sdxLayoutVert = 'Vertical';

  // properties
  sdxBoolean = 'Boolean';
  sdxColor = 'Color';
  sdxContent = 'Content';
  sdxImageCount = 'ImageCount';
  sdxRect = 'Rect';
  sdxSize = 'Size';
  sdxString = 'String';
  sdxTextColor = 'TextColor';

  // stretch mode
  sdxStretch = 'Stretch';
  sdxTile = 'Tile';
  sdxNoResize = 'NoResize';

  // bitmap
  sdxFile = 'File';
  sdxLayout = 'Layout';
  sdxStates = 'States';
  sdxMargins = 'Margins';

  // rect
  sdxBorders = 'Borders';
  sdxThin = 'Thin';

  sdxLeft = 'Left';
  sdxTop  = 'Top';
  sdxRight = 'Right';
  sdxBottom = 'Bottom';
  
  // size
  sdxWidth = 'Width';
  sdxHeight  = 'Height';

  // Gradient
  sdxGradientBeginColor = 'GradientBeginColor';
  sdxGradientEndColor = 'GradientEndColor';
  sdxGradientMode = 'GradientMode';
  sdxGradientModeBackwardDiagonal = 'BackwardDiagonal';
  sdxGradientModeForwardDiagonal = 'ForwardDiagonal';
  sdxGradientModeHorizontal = 'Horizontal';
  sdxGradientModeVertical = 'Vertical';

const

  CalcEditTextColorsMap: array[TcxCalcButtonKind] of string = (
    sdxSkinsCalcEditEditingOperationTextColor,
    sdxSkinsCalcEditEditingOperationTextColor,
    sdxSkinsCalcEditEditingOperationTextColor,

    sdxSkinsCalcEditMemoryOperationTextColor,
    sdxSkinsCalcEditMemoryOperationTextColor,
    sdxSkinsCalcEditMemoryOperationTextColor,
    sdxSkinsCalcEditMemoryOperationTextColor,    

    sdxSkinsCalcEditDigitTextColor, sdxSkinsCalcEditDigitTextColor,
    sdxSkinsCalcEditDigitTextColor, sdxSkinsCalcEditDigitTextColor,
    sdxSkinsCalcEditDigitTextColor, sdxSkinsCalcEditDigitTextColor,
    sdxSkinsCalcEditDigitTextColor, sdxSkinsCalcEditDigitTextColor,
    sdxSkinsCalcEditDigitTextColor, sdxSkinsCalcEditDigitTextColor,
    sdxSkinsCalcEditDigitTextColor, sdxSkinsCalcEditDigitTextColor,

    sdxSkinsCalcEditArithmeticOperationTextColor,
    sdxSkinsCalcEditArithmeticOperationTextColor,
    sdxSkinsCalcEditArithmeticOperationTextColor,
    sdxSkinsCalcEditArithmeticOperationTextColor,

    sdxSkinsCalcEditScientificOperationTextColor,
    sdxSkinsCalcEditScientificOperationTextColor,
    sdxSkinsCalcEditScientificOperationTextColor,
    sdxSkinsCalcEditScientificOperationTextColor,
    sdxSkinsCalcEditScientificOperationTextColor
  );

  CommonGroup: array[0..18] of string =
   (sdxSkinGroupCommon,
    sdxButton, sdxGroupPanel, sdxGroupPanelBottom, sdxGroupPanelCaptionBottom,
    sdxGroupPanelCaptionLeft, sdxGroupPanelCaptionRight, sdxGroupPanelCaptionTop,
    sdxGroupPanelLeft, sdxGroupPanelRight, sdxGroupPanelTop, sdxScrollButton,
    sdxScrollContentHorz, sdxScrollContentVert, sdxScrollThumbButtonHorz,
    sdxScrollThumbButtonVert, sdxSizeGrip, sdxSplitterHorz, sdxSplitterVert);

  EditorsGroup: array[0..22] of string =
   (sdxSkinGroupEditors,
    sdxCheckbox, sdxCloseButton, sdxComboButtonGlyph, sdxEditorButton, sdxNavigatorGlyphs,
    sdxProgressBorder, sdxProgressBorderVert, sdxProgressChunk, sdxProgressChunkVert,
    sdxRadioGroup, sdxSpinDownGlyph, sdxSpinLeftGlyph, sdxSpinRightGlyph, sdxSpinUpGlyph,
    sdxTrackBarThumb, sdxTrackBarThumbBoth, sdxTrackBarThumbUp, sdxTrackBarThumbVert,
    sdxTrackBarThumbVertBoth, sdxTrackBarThumbVertUp, sdxTrackBarTrack, sdxTrackBarTrackVert);

  GridGroup: array[0..14] of string =
   (sdxSkinGroupGrid,
    sdxFilterButton, sdxFilterButtonActive, sdxFilterPanel, sdxFooterCell, sdxFooterPanel,
    sdxGroupByBox, sdxGroupRow, sdxHeader, sdxHeaderLeft, sdxHeaderRight, sdxHeaderSpecial,
    sdxIndicatorImages, sdxPlusMinus, sdxPlusMinusEx);

  TabGroup: array[0..5] of string =
   (sdxSkinGroupTabs,
    sdxPageControlHeaderBottom, sdxPageControlHeaderLeft,
    sdxPageControlHeaderRight, sdxPageControlHeaderTop, sdxPageControlPane);

  VGridGroup: array[0..4] of string =
    (sdxSkinGroupVGrid,
     sdxVGridBandLine, sdxVGridLine, sdxVGridRowHeader, sdxVGridCategory);

  FormGroup: array[0..13] of string =
    (sdxFormFrameLeft, sdxFormCaption, sdxFormFrameRight, sdxFormFrameBottom,
     sdxSmallFormFrameLeft, sdxSmallFormCaption, sdxSmallFormFrameRight,
     sdxSmallFormFrameBottom, sdxSmallFormButtonClose, sdxFormButtonClose,
     sdxFormButtonMinimize, sdxFormButtonMaximize, sdxFormButtonRestore, sdxFormButtonHelp);

  EditButtonsMap: array[TcxEditBtnKind] of string = (sdxCloseButton, sdxComboButtonGlyph,
    sdxEditorButton, sdxEditorButton, sdxSpinUpGlyph, sdxSpinDownGlyph,
    sdxSpinLeftGlyph, sdxSpinRightGlyph);

  FormFrameMap: array[Boolean, TcxBorder] of string =
    ((sdxFormFrameLeft, sdxSmallFormCaption, sdxFormFrameRight, sdxFormFrameBottom),
     (sdxFormFrameLeft, sdxFormCaption, sdxFormFrameRight, sdxFormFrameBottom));

  EditBackgroundColorsMap: array[TcxEditStateColorKind] of string = (
    sdxSkinsEditorBackgroundColor, sdxSkinsEditorBackgroundDisabledColor,
    sdxSkinsEditorBackgroundInactiveColor, sdxSkinsEditorBackgroundReadOnlyColor
  );

  EditTextColorsMap: array[TcxEditStateColorKind] of string = (
    sdxSkinsEditorTextColor, sdxSkinsEditorTextDisabledColor,
    sdxSkinsEditorTextInactiveColor, sdxSkinsEditorTextReadOnlyColor
  );

  LayoutViewElementPaddingMap: array[TcxLayoutElement] of string = (
    sdxLayoutViewGroupPadding, sdxLayoutViewGroupWithoutBordersPadding,
    sdxLayoutViewTabbedGroupPadding, sdxLayoutViewRootGroupPadding,
    sdxLayoutViewRootGroupWithoutBordersPadding, sdxLayoutViewItemPadding
  );

  LayoutViewElementSpacingMap: array[TcxLayoutElement] of string = (
    sdxLayoutViewGroupSpacing, sdxLayoutViewGroupWithoutBordersSpacing,
    sdxLayoutViewTabbedGroupSpacing, sdxLayoutViewRootGroupSpacing,
    sdxLayoutViewRootGroupWithoutBordersSpacing, sdxLayoutViewItemSpacing
  );

implementation

end.

