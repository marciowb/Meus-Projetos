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
unit ap_Themes;

interface

uses
  Windows,
  Classes,
  Messages,
  Graphics,
  UxTheme,
  CommCtrl,
  Controls,
  Themes,
  Variants,
  ap_Types,
  atScript;

{$WARNINGS OFF}

type
  TatThemesLibrary = class(TatScripterLibrary)
    procedure __TThemeServicesCreate(AMachine: TatVirtualMachine);
    procedure __TThemeServicesDestroy(AMachine: TatVirtualMachine);
    procedure __TThemeServicesApplyThemeChange(AMachine: TatVirtualMachine);
    procedure __TThemeServicesContentRect(AMachine: TatVirtualMachine);
    procedure __TThemeServicesDrawIcon(AMachine: TatVirtualMachine);
    procedure __TThemeServicesDrawText(AMachine: TatVirtualMachine);
    procedure __TThemeServicesHasTransparentParts(AMachine: TatVirtualMachine);
    procedure __TThemeServicesPaintBorder(AMachine: TatVirtualMachine);
    procedure __TThemeServicesUpdateThemes(AMachine: TatVirtualMachine);
    procedure __GetTThemeServicesTheme(AMachine: TatVirtualMachine);
    procedure __GetTThemeServicesThemesAvailable(AMachine: TatVirtualMachine);
    procedure __GetTThemeServicesThemesEnabled(AMachine: TatVirtualMachine);
    procedure __ThemeServices(AMachine: TatVirtualMachine);
    procedure __ThemeControl(AMachine: TatVirtualMachine);
    procedure __UnthemedDesigner(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TThemeServicesClass = class of TThemeServices;


  TThemedElementDetailsWrapper = class(TatRecordWrapper)
  private
    FElement: TThemedElement;
    FPart: Integer;
    FState: Integer;
  public
    constructor Create(ARecord: TThemedElementDetails);
    function ObjToRec: TThemedElementDetails;
  published
    property Element: TThemedElement read FElement write FElement;
    property Part: Integer read FPart write FPart;
    property State: Integer read FState write FState;
  end;
  

implementation

constructor TThemedElementDetailsWrapper.Create(ARecord: TThemedElementDetails);
begin
  inherited Create;
  FElement := ARecord.Element;
  FPart := ARecord.Part;
  FState := ARecord.State;
end;

function TThemedElementDetailsWrapper.ObjToRec: TThemedElementDetails;
begin
  result.Element := FElement;
  result.Part := FPart;
  result.State := FState;
end;



procedure TatThemesLibrary.__TThemeServicesCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TThemeServicesClass(CurrentClass.ClassRef).Create);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatThemesLibrary.__TThemeServicesDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TThemeServices(CurrentObject).Destroy;
  end;
end;

procedure TatThemesLibrary.__TThemeServicesApplyThemeChange(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TThemeServices(CurrentObject).ApplyThemeChange;
  end;
end;

procedure TatThemesLibrary.__TThemeServicesContentRect(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := integer(TRectWrapper.Create(TThemeServices(CurrentObject).ContentRect(VarToInteger(GetInputArg(0)),TThemedElementDetailsWrapper(integer(GetInputArg(1))).ObjToRec,TRectWrapper(integer(GetInputArg(2))).ObjToRec)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatThemesLibrary.__TThemeServicesDrawIcon(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TThemeServices(CurrentObject).DrawIcon(VarToInteger(GetInputArg(0)),TThemedElementDetailsWrapper(integer(GetInputArg(1))).ObjToRec,TRectWrapper(integer(GetInputArg(2))).ObjToRec,VarToInteger(GetInputArg(3)),VarToInteger(GetInputArg(4)));
  end;
end;

procedure TatThemesLibrary.__TThemeServicesDrawText(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TThemeServices(CurrentObject).DrawText(VarToInteger(GetInputArg(0)),TThemedElementDetailsWrapper(integer(GetInputArg(1))).ObjToRec,GetInputArg(2),TRectWrapper(integer(GetInputArg(3))).ObjToRec,VarToInteger(GetInputArg(4)),VarToInteger(GetInputArg(5)));
  end;
end;

procedure TatThemesLibrary.__TThemeServicesHasTransparentParts(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TThemeServices(CurrentObject).HasTransparentParts(TThemedElementDetailsWrapper(integer(GetInputArg(0))).ObjToRec);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatThemesLibrary.__TThemeServicesPaintBorder(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TThemeServices(CurrentObject).PaintBorder(TWinControl(Integer(GetInputArg(0))),GetInputArg(1));
  end;
end;

procedure TatThemesLibrary.__TThemeServicesUpdateThemes(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TThemeServices(CurrentObject).UpdateThemes;
  end;
end;

procedure TatThemesLibrary.__GetTThemeServicesTheme(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TThemeServices(CurrentObject).Theme[GetArrayIndex(0)]));
  end;
end;

procedure TatThemesLibrary.__GetTThemeServicesThemesAvailable(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TThemeServices(CurrentObject).ThemesAvailable);
  end;
end;

procedure TatThemesLibrary.__GetTThemeServicesThemesEnabled(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TThemeServices(CurrentObject).ThemesEnabled);
  end;
end;

procedure TatThemesLibrary.__ThemeServices(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Themes.ThemeServices);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatThemesLibrary.__ThemeControl(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Themes.ThemeControl(TControl(Integer(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatThemesLibrary.__UnthemedDesigner(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Themes.UnthemedDesigner(TControl(Integer(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatThemesLibrary.Init;
begin
  With Scripter.DefineClass(TThemeServices) do
  begin
    DefineMethod('Create',0,tkClass,TThemeServices,__TThemeServicesCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TThemeServicesDestroy,false,0);
    DefineMethod('ApplyThemeChange',0,tkNone,nil,__TThemeServicesApplyThemeChange,false,0);
    DefineMethod('ContentRect',3,tkVariant,nil,__TThemeServicesContentRect,false,0);
    DefineMethod('DrawIcon',5,tkNone,nil,__TThemeServicesDrawIcon,false,0);
    DefineMethod('DrawText',6,tkNone,nil,__TThemeServicesDrawText,false,0);
    DefineMethod('HasTransparentParts',1,tkVariant,nil,__TThemeServicesHasTransparentParts,false,0);
    DefineMethod('PaintBorder',2,tkNone,nil,__TThemeServicesPaintBorder,false,0);
    DefineMethod('UpdateThemes',0,tkNone,nil,__TThemeServicesUpdateThemes,false,0);
    DefineProp('Theme',tkInteger,__GetTThemeServicesTheme,nil,nil,false,1);
    DefineProp('ThemesAvailable',tkVariant,__GetTThemeServicesThemesAvailable,nil,nil,false,0);
    DefineProp('ThemesEnabled',tkVariant,__GetTThemeServicesThemesEnabled,nil,nil,false,0);
  end;
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('ThemeServices',0,tkClass,TThemeServices,__ThemeServices,false,0);
    DefineMethod('ThemeControl',1,tkVariant,nil,__ThemeControl,false,0);
    DefineMethod('UnthemedDesigner',1,tkVariant,nil,__UnthemedDesigner,false,0);
    AddConstant('teButton',teButton);
    AddConstant('teClock',teClock);
    AddConstant('teComboBox',teComboBox);
    AddConstant('teEdit',teEdit);
    AddConstant('teExplorerBar',teExplorerBar);
    AddConstant('teHeader',teHeader);
    AddConstant('teListView',teListView);
    AddConstant('teMenu',teMenu);
    AddConstant('tePage',tePage);
    AddConstant('teProgress',teProgress);
    AddConstant('teRebar',teRebar);
    AddConstant('teScrollBar',teScrollBar);
    AddConstant('teSpin',teSpin);
    AddConstant('teStartPanel',teStartPanel);
    AddConstant('teStatus',teStatus);
    AddConstant('teTab',teTab);
    AddConstant('teTaskBand',teTaskBand);
    AddConstant('teTaskBar',teTaskBar);
    AddConstant('teToolBar',teToolBar);
    AddConstant('teToolTip',teToolTip);
    AddConstant('teTrackBar',teTrackBar);
    AddConstant('teTrayNotify',teTrayNotify);
    AddConstant('teTreeview',teTreeview);
    AddConstant('teWindow',teWindow);
    AddConstant('tbButtonDontCare',tbButtonDontCare);
    AddConstant('tbButtonRoot',tbButtonRoot);
    AddConstant('tbPushButtonNormal',tbPushButtonNormal);
    AddConstant('tbPushButtonHot',tbPushButtonHot);
    AddConstant('tbPushButtonPressed',tbPushButtonPressed);
    AddConstant('tbPushButtonDisabled',tbPushButtonDisabled);
    AddConstant('tbPushButtonDefaulted',tbPushButtonDefaulted);
    AddConstant('tbRadioButtonUncheckedNormal',tbRadioButtonUncheckedNormal);
    AddConstant('tbRadioButtonUncheckedHot',tbRadioButtonUncheckedHot);
    AddConstant('tbRadioButtonUncheckedPressed',tbRadioButtonUncheckedPressed);
    AddConstant('tbRadioButtonUncheckedDisabled',tbRadioButtonUncheckedDisabled);
    AddConstant('tbRadioButtonCheckedNormal',tbRadioButtonCheckedNormal);
    AddConstant('tbRadioButtonCheckedHot',tbRadioButtonCheckedHot);
    AddConstant('tbRadioButtonCheckedPressed',tbRadioButtonCheckedPressed);
    AddConstant('tbRadioButtonCheckedDisabled',tbRadioButtonCheckedDisabled);
    AddConstant('tbCheckBoxUncheckedNormal',tbCheckBoxUncheckedNormal);
    AddConstant('tbCheckBoxUncheckedHot',tbCheckBoxUncheckedHot);
    AddConstant('tbCheckBoxUncheckedPressed',tbCheckBoxUncheckedPressed);
    AddConstant('tbCheckBoxUncheckedDisabled',tbCheckBoxUncheckedDisabled);
    AddConstant('tbCheckBoxCheckedNormal',tbCheckBoxCheckedNormal);
    AddConstant('tbCheckBoxCheckedHot',tbCheckBoxCheckedHot);
    AddConstant('tbCheckBoxCheckedPressed',tbCheckBoxCheckedPressed);
    AddConstant('tbCheckBoxCheckedDisabled',tbCheckBoxCheckedDisabled);
    AddConstant('tbCheckBoxMixedNormal',tbCheckBoxMixedNormal);
    AddConstant('tbCheckBoxMixedHot',tbCheckBoxMixedHot);
    AddConstant('tbCheckBoxMixedPressed',tbCheckBoxMixedPressed);
    AddConstant('tbCheckBoxMixedDisabled',tbCheckBoxMixedDisabled);
    AddConstant('tbGroupBoxNormal',tbGroupBoxNormal);
    AddConstant('tbGroupBoxDisabled',tbGroupBoxDisabled);
    AddConstant('tbUserButton',tbUserButton);
    AddConstant('tcClockDontCare',tcClockDontCare);
    AddConstant('tcClockRoot',tcClockRoot);
    AddConstant('tcTimeNormal',tcTimeNormal);
    AddConstant('tcComboBoxDontCare',tcComboBoxDontCare);
    AddConstant('tcComboBoxRoot',tcComboBoxRoot);
    AddConstant('tcDropDownButtonNormal',tcDropDownButtonNormal);
    AddConstant('tcDropDownButtonHot',tcDropDownButtonHot);
    AddConstant('tcDropDownButtonPressed',tcDropDownButtonPressed);
    AddConstant('tcDropDownButtonDisabled',tcDropDownButtonDisabled);
    AddConstant('teEditDontCare',teEditDontCare);
    AddConstant('teEditRoot',teEditRoot);
    AddConstant('teEditTextNormal',teEditTextNormal);
    AddConstant('teEditTextHot',teEditTextHot);
    AddConstant('teEditTextSelected',teEditTextSelected);
    AddConstant('teEditTextDisabled',teEditTextDisabled);
    AddConstant('teEditTextFocused',teEditTextFocused);
    AddConstant('teEditTextReadOnly',teEditTextReadOnly);
    AddConstant('teEditTextAssist',teEditTextAssist);
    AddConstant('teEditCaret',teEditCaret);
    AddConstant('tebExplorerBarDontCare',tebExplorerBarDontCare);
    AddConstant('tebExplorerBarRoot',tebExplorerBarRoot);
    AddConstant('tebHeaderBackgroundNormal',tebHeaderBackgroundNormal);
    AddConstant('tebHeaderBackgroundHot',tebHeaderBackgroundHot);
    AddConstant('tebHeaderBackgroundPressed',tebHeaderBackgroundPressed);
    AddConstant('tebHeaderCloseNormal',tebHeaderCloseNormal);
    AddConstant('tebHeaderCloseHot',tebHeaderCloseHot);
    AddConstant('tebHeaderClosePressed',tebHeaderClosePressed);
    AddConstant('tebHeaderPinNormal',tebHeaderPinNormal);
    AddConstant('tebHeaderPinHot',tebHeaderPinHot);
    AddConstant('tebHeaderPinPressed',tebHeaderPinPressed);
    AddConstant('tebHeaderPinSelectedNormal',tebHeaderPinSelectedNormal);
    AddConstant('tebHeaderPinSelectedHot',tebHeaderPinSelectedHot);
    AddConstant('tebHeaderPinSelectedPressed',tebHeaderPinSelectedPressed);
    AddConstant('tebIEBarMenuNormal',tebIEBarMenuNormal);
    AddConstant('tebIEBarMenuHot',tebIEBarMenuHot);
    AddConstant('tebIEBarMenuPressed',tebIEBarMenuPressed);
    AddConstant('tebNormalGroupBackground',tebNormalGroupBackground);
    AddConstant('tebNormalGroupCollapseNormal',tebNormalGroupCollapseNormal);
    AddConstant('tebNormalGroupCollapseHot',tebNormalGroupCollapseHot);
    AddConstant('tebNormalGroupCollapsePressed',tebNormalGroupCollapsePressed);
    AddConstant('tebNormalGroupExpandNormal',tebNormalGroupExpandNormal);
    AddConstant('tebNormalGroupExpandHot',tebNormalGroupExpandHot);
    AddConstant('tebNormalGroupExpandPressed',tebNormalGroupExpandPressed);
    AddConstant('tebNormalGroupHead',tebNormalGroupHead);
    AddConstant('tebSpecialGroupBackground',tebSpecialGroupBackground);
    AddConstant('tebSpecialGroupCollapseSpecial',tebSpecialGroupCollapseSpecial);
    AddConstant('tebSpecialGroupCollapseHot',tebSpecialGroupCollapseHot);
    AddConstant('tebSpecialGroupCollapsePressed',tebSpecialGroupCollapsePressed);
    AddConstant('tebSpecialGroupExpandSpecial',tebSpecialGroupExpandSpecial);
    AddConstant('tebSpecialGroupExpandHot',tebSpecialGroupExpandHot);
    AddConstant('tebSpecialGroupExpandPressed',tebSpecialGroupExpandPressed);
    AddConstant('tebSpecialGroupHead',tebSpecialGroupHead);
    AddConstant('thHeaderDontCare',thHeaderDontCare);
    AddConstant('thHeaderRoot',thHeaderRoot);
    AddConstant('thHeaderItemNormal',thHeaderItemNormal);
    AddConstant('thHeaderItemHot',thHeaderItemHot);
    AddConstant('thHeaderItemPressed',thHeaderItemPressed);
    AddConstant('thHeaderItemLeftNormal',thHeaderItemLeftNormal);
    AddConstant('thHeaderItemLeftHot',thHeaderItemLeftHot);
    AddConstant('thHeaderItemLeftPressed',thHeaderItemLeftPressed);
    AddConstant('thHeaderItemRightNormal',thHeaderItemRightNormal);
    AddConstant('thHeaderItemRightHot',thHeaderItemRightHot);
    AddConstant('thHeaderItemRightPressed',thHeaderItemRightPressed);
    AddConstant('thHeaderSortArrowSortedUp',thHeaderSortArrowSortedUp);
    AddConstant('thHeaderSortArrowSortedDown',thHeaderSortArrowSortedDown);
    AddConstant('tlListviewDontCare',tlListviewDontCare);
    AddConstant('tlListviewRoot',tlListviewRoot);
    AddConstant('tlListItemNormal',tlListItemNormal);
    AddConstant('tlListItemHot',tlListItemHot);
    AddConstant('tlListItemSelected',tlListItemSelected);
    AddConstant('tlListItemDisabled',tlListItemDisabled);
    AddConstant('tlListItemSelectedNotFocus',tlListItemSelectedNotFocus);
    AddConstant('tlListGroup',tlListGroup);
    AddConstant('tlListDetail',tlListDetail);
    AddConstant('tlListSortDetail',tlListSortDetail);
    AddConstant('tlEmptyText',tlEmptyText);
    AddConstant('tmMenuDontCare',tmMenuDontCare);
    AddConstant('tmMenuRoot',tmMenuRoot);
    AddConstant('tmMenuItemNormal',tmMenuItemNormal);
    AddConstant('tmMenuItemSelected',tmMenuItemSelected);
    AddConstant('tmMenuItemDemoted',tmMenuItemDemoted);
    AddConstant('tmMenuDropDown',tmMenuDropDown);
    AddConstant('tmMenuBarItem',tmMenuBarItem);
    AddConstant('tmMenuBarDropDown',tmMenuBarDropDown);
    AddConstant('tmChevron',tmChevron);
    AddConstant('tmSeparator',tmSeparator);
    AddConstant('tpPageDontCare',tpPageDontCare);
    AddConstant('tpPageRoot',tpPageRoot);
    AddConstant('tpUpNormal',tpUpNormal);
    AddConstant('tpUpHot',tpUpHot);
    AddConstant('tpUpPressed',tpUpPressed);
    AddConstant('tpUpDisabled',tpUpDisabled);
    AddConstant('tpDownNormal',tpDownNormal);
    AddConstant('tpDownHot',tpDownHot);
    AddConstant('tpDownPressed',tpDownPressed);
    AddConstant('tpDownDisabled',tpDownDisabled);
    AddConstant('tpUpHorzNormal',tpUpHorzNormal);
    AddConstant('tpUpHorzHot',tpUpHorzHot);
    AddConstant('tpUpHorzPressed',tpUpHorzPressed);
    AddConstant('tpUpHorzDisabled',tpUpHorzDisabled);
    AddConstant('tpDownHorzNormal',tpDownHorzNormal);
    AddConstant('tpDownHorzHot',tpDownHorzHot);
    AddConstant('tpDownHorzPressed',tpDownHorzPressed);
    AddConstant('tpDownHorzDisabled',tpDownHorzDisabled);
    AddConstant('tpProgressDontCare',tpProgressDontCare);
    AddConstant('tpProgressRoot',tpProgressRoot);
    AddConstant('tpBar',tpBar);
    AddConstant('tpBarVert',tpBarVert);
    AddConstant('tpChunk',tpChunk);
    AddConstant('tpChunkVert',tpChunkVert);
    AddConstant('trRebarDontCare',trRebarDontCare);
    AddConstant('trRebarRoot',trRebarRoot);
    AddConstant('trGripper',trGripper);
    AddConstant('trGripperVert',trGripperVert);
    AddConstant('trBandNormal',trBandNormal);
    AddConstant('trBandHot',trBandHot);
    AddConstant('trBandPressed',trBandPressed);
    AddConstant('trBandDisabled',trBandDisabled);
    AddConstant('trBandChecked',trBandChecked);
    AddConstant('trBandHotChecked',trBandHotChecked);
    AddConstant('trChevronNormal',trChevronNormal);
    AddConstant('trChevronHot',trChevronHot);
    AddConstant('trChevronPressed',trChevronPressed);
    AddConstant('trChevronDisabled',trChevronDisabled);
    AddConstant('trChevronVertNormal',trChevronVertNormal);
    AddConstant('trChevronVertHot',trChevronVertHot);
    AddConstant('trChevronVertPressed',trChevronVertPressed);
    AddConstant('trChevronVertDisabled',trChevronVertDisabled);
    AddConstant('tsScrollBarDontCare',tsScrollBarDontCare);
    AddConstant('tsScrollBarRoot',tsScrollBarRoot);
    AddConstant('tsArrowBtnUpNormal',tsArrowBtnUpNormal);
    AddConstant('tsArrowBtnUpHot',tsArrowBtnUpHot);
    AddConstant('tsArrowBtnUpPressed',tsArrowBtnUpPressed);
    AddConstant('tsArrowBtnUpDisabled',tsArrowBtnUpDisabled);
    AddConstant('tsArrowBtnDownNormal',tsArrowBtnDownNormal);
    AddConstant('tsArrowBtnDownHot',tsArrowBtnDownHot);
    AddConstant('tsArrowBtnDownPressed',tsArrowBtnDownPressed);
    AddConstant('tsArrowBtnDownDisabled',tsArrowBtnDownDisabled);
    AddConstant('tsArrowBtnLeftNormal',tsArrowBtnLeftNormal);
    AddConstant('tsArrowBtnLeftHot',tsArrowBtnLeftHot);
    AddConstant('tsArrowBtnLeftPressed',tsArrowBtnLeftPressed);
    AddConstant('tsArrowBtnLeftDisabled',tsArrowBtnLeftDisabled);
    AddConstant('tsArrowBtnRightNormal',tsArrowBtnRightNormal);
    AddConstant('tsArrowBtnRightHot',tsArrowBtnRightHot);
    AddConstant('tsArrowBtnRightPressed',tsArrowBtnRightPressed);
    AddConstant('tsArrowBtnRightDisabled',tsArrowBtnRightDisabled);
    AddConstant('tsThumbBtnHorzNormal',tsThumbBtnHorzNormal);
    AddConstant('tsThumbBtnHorzHot',tsThumbBtnHorzHot);
    AddConstant('tsThumbBtnHorzPressed',tsThumbBtnHorzPressed);
    AddConstant('tsThumbBtnHorzDisabled',tsThumbBtnHorzDisabled);
    AddConstant('tsThumbBtnVertNormal',tsThumbBtnVertNormal);
    AddConstant('tsThumbBtnVertHot',tsThumbBtnVertHot);
    AddConstant('tsThumbBtnVertPressed',tsThumbBtnVertPressed);
    AddConstant('tsThumbBtnVertDisabled',tsThumbBtnVertDisabled);
    AddConstant('tsLowerTrackHorzNormal',tsLowerTrackHorzNormal);
    AddConstant('tsLowerTrackHorzHot',tsLowerTrackHorzHot);
    AddConstant('tsLowerTrackHorzPressed',tsLowerTrackHorzPressed);
    AddConstant('tsLowerTrackHorzDisabled',tsLowerTrackHorzDisabled);
    AddConstant('tsUpperTrackHorzNormal',tsUpperTrackHorzNormal);
    AddConstant('tsUpperTrackHorzHot',tsUpperTrackHorzHot);
    AddConstant('tsUpperTrackHorzPressed',tsUpperTrackHorzPressed);
    AddConstant('tsUpperTrackHorzDisabled',tsUpperTrackHorzDisabled);
    AddConstant('tsLowerTrackVertNormal',tsLowerTrackVertNormal);
    AddConstant('tsLowerTrackVertHot',tsLowerTrackVertHot);
    AddConstant('tsLowerTrackVertPressed',tsLowerTrackVertPressed);
    AddConstant('tsLowerTrackVertDisabled',tsLowerTrackVertDisabled);
    AddConstant('tsUpperTrackVertNormal',tsUpperTrackVertNormal);
    AddConstant('tsUpperTrackVertHot',tsUpperTrackVertHot);
    AddConstant('tsUpperTrackVertPressed',tsUpperTrackVertPressed);
    AddConstant('tsUpperTrackVertDisabled',tsUpperTrackVertDisabled);
    AddConstant('tsGripperHorzNormal',tsGripperHorzNormal);
    AddConstant('tsGripperHorzHot',tsGripperHorzHot);
    AddConstant('tsGripperHorzPressed',tsGripperHorzPressed);
    AddConstant('tsGripperHorzDisabled',tsGripperHorzDisabled);
    AddConstant('tsGripperVertNormal',tsGripperVertNormal);
    AddConstant('tsGripperVertHot',tsGripperVertHot);
    AddConstant('tsGripperVertPressed',tsGripperVertPressed);
    AddConstant('tsGripperVertDisabled',tsGripperVertDisabled);
    AddConstant('tsSizeBoxRightAlign',tsSizeBoxRightAlign);
    AddConstant('tsSizeBoxLeftAlign',tsSizeBoxLeftAlign);
    AddConstant('tsSpinDontCare',tsSpinDontCare);
    AddConstant('tsSpinRoot',tsSpinRoot);
    AddConstant('tsUpNormal',tsUpNormal);
    AddConstant('tsUpHot',tsUpHot);
    AddConstant('tsUpPressed',tsUpPressed);
    AddConstant('tsUpDisabled',tsUpDisabled);
    AddConstant('tsDownNormal',tsDownNormal);
    AddConstant('tsDownHot',tsDownHot);
    AddConstant('tsDownPressed',tsDownPressed);
    AddConstant('tsDownDisabled',tsDownDisabled);
    AddConstant('tsUpHorzNormal',tsUpHorzNormal);
    AddConstant('tsUpHorzHot',tsUpHorzHot);
    AddConstant('tsUpHorzPressed',tsUpHorzPressed);
    AddConstant('tsUpHorzDisabled',tsUpHorzDisabled);
    AddConstant('tsDownHorzNormal',tsDownHorzNormal);
    AddConstant('tsDownHorzHot',tsDownHorzHot);
    AddConstant('tsDownHorzPressed',tsDownHorzPressed);
    AddConstant('tsDownHorzDisabled',tsDownHorzDisabled);
    AddConstant('tspStartPanelDontCare',tspStartPanelDontCare);
    AddConstant('tspStartPanelRoot',tspStartPanelRoot);
    AddConstant('tspUserPane',tspUserPane);
    AddConstant('tspMorePrograms',tspMorePrograms);
    AddConstant('tspMoreProgramsArrowNormal',tspMoreProgramsArrowNormal);
    AddConstant('tspMoreProgramsArrowHot',tspMoreProgramsArrowHot);
    AddConstant('tspMoreProgramsArrowPressed',tspMoreProgramsArrowPressed);
    AddConstant('tspProgList',tspProgList);
    AddConstant('tspProgListSeparator',tspProgListSeparator);
    AddConstant('tspPlacesList',tspPlacesList);
    AddConstant('tspPlacesListSeparator',tspPlacesListSeparator);
    AddConstant('tspLogOff',tspLogOff);
    AddConstant('tspLogOffButtonsNormal',tspLogOffButtonsNormal);
    AddConstant('tspLogOffButtonsHot',tspLogOffButtonsHot);
    AddConstant('tspLogOffButtonsPressed',tspLogOffButtonsPressed);
    AddConstant('tspUserPicture',tspUserPicture);
    AddConstant('tspPreview',tspPreview);
    AddConstant('tsStatusDontCare',tsStatusDontCare);
    AddConstant('tsStatusRoot',tsStatusRoot);
    AddConstant('tsPane',tsPane);
    AddConstant('tsGripperPane',tsGripperPane);
    AddConstant('tsGripper',tsGripper);
    AddConstant('ttTabDontCare',ttTabDontCare);
    AddConstant('ttTabRoot',ttTabRoot);
    AddConstant('ttTabItemNormal',ttTabItemNormal);
    AddConstant('ttTabItemHot',ttTabItemHot);
    AddConstant('ttTabItemSelected',ttTabItemSelected);
    AddConstant('ttTabItemDisabled',ttTabItemDisabled);
    AddConstant('ttTabItemFocused',ttTabItemFocused);
    AddConstant('ttTabItemLeftEdgeNormal',ttTabItemLeftEdgeNormal);
    AddConstant('ttTabItemLeftEdgeHot',ttTabItemLeftEdgeHot);
    AddConstant('ttTabItemLeftEdgeSelected',ttTabItemLeftEdgeSelected);
    AddConstant('ttTabItemLeftEdgeDisabled',ttTabItemLeftEdgeDisabled);
    AddConstant('ttTabItemLeftEdgeFocused',ttTabItemLeftEdgeFocused);
    AddConstant('ttTabItemRightEdgeNormal',ttTabItemRightEdgeNormal);
    AddConstant('ttTabItemRightEdgeHot',ttTabItemRightEdgeHot);
    AddConstant('ttTabItemRightEdgeSelected',ttTabItemRightEdgeSelected);
    AddConstant('ttTabItemRightEdgeDisabled',ttTabItemRightEdgeDisabled);
    AddConstant('ttTabItemRightEdgeFocused',ttTabItemRightEdgeFocused);
    AddConstant('ttTabItemBothEdgeNormal',ttTabItemBothEdgeNormal);
    AddConstant('ttTabItemBothEdgeHot',ttTabItemBothEdgeHot);
    AddConstant('ttTabItemBothEdgeSelected',ttTabItemBothEdgeSelected);
    AddConstant('ttTabItemBothEdgeDisabled',ttTabItemBothEdgeDisabled);
    AddConstant('ttTabItemBothEdgeFocused',ttTabItemBothEdgeFocused);
    AddConstant('ttTopTabItemNormal',ttTopTabItemNormal);
    AddConstant('ttTopTabItemHot',ttTopTabItemHot);
    AddConstant('ttTopTabItemSelected',ttTopTabItemSelected);
    AddConstant('ttTopTabItemDisabled',ttTopTabItemDisabled);
    AddConstant('ttTopTabItemFocused',ttTopTabItemFocused);
    AddConstant('ttTopTabItemLeftEdgeNormal',ttTopTabItemLeftEdgeNormal);
    AddConstant('ttTopTabItemLeftEdgeHot',ttTopTabItemLeftEdgeHot);
    AddConstant('ttTopTabItemLeftEdgeSelected',ttTopTabItemLeftEdgeSelected);
    AddConstant('ttTopTabItemLeftEdgeDisabled',ttTopTabItemLeftEdgeDisabled);
    AddConstant('ttTopTabItemLeftEdgeFocused',ttTopTabItemLeftEdgeFocused);
    AddConstant('ttTopTabItemRightEdgeNormal',ttTopTabItemRightEdgeNormal);
    AddConstant('ttTopTabItemRightEdgeHot',ttTopTabItemRightEdgeHot);
    AddConstant('ttTopTabItemRightEdgeSelected',ttTopTabItemRightEdgeSelected);
    AddConstant('ttTopTabItemRightEdgeDisabled',ttTopTabItemRightEdgeDisabled);
    AddConstant('ttTopTabItemRightEdgeFocused',ttTopTabItemRightEdgeFocused);
    AddConstant('ttTopTabItemBothEdgeNormal',ttTopTabItemBothEdgeNormal);
    AddConstant('ttTopTabItemBothEdgeHot',ttTopTabItemBothEdgeHot);
    AddConstant('ttTopTabItemBothEdgeSelected',ttTopTabItemBothEdgeSelected);
    AddConstant('ttTopTabItemBothEdgeDisabled',ttTopTabItemBothEdgeDisabled);
    AddConstant('ttTopTabItemBothEdgeFocused',ttTopTabItemBothEdgeFocused);
    AddConstant('ttPane',ttPane);
    AddConstant('ttBody',ttBody);
    AddConstant('ttbTaskBandDontCare',ttbTaskBandDontCare);
    AddConstant('ttbTaskBandRoot',ttbTaskBandRoot);
    AddConstant('ttbGroupCount',ttbGroupCount);
    AddConstant('ttbFlashButton',ttbFlashButton);
    AddConstant('ttpFlashButtonGroupMenu',ttpFlashButtonGroupMenu);
    AddConstant('ttTaskBarDontCare',ttTaskBarDontCare);
    AddConstant('ttTaskBarRoot',ttTaskBarRoot);
    AddConstant('ttbTimeNormal',ttbTimeNormal);
    AddConstant('ttbToolBarDontCare',ttbToolBarDontCare);
    AddConstant('ttbToolBarRoot',ttbToolBarRoot);
    AddConstant('ttbButtonNormal',ttbButtonNormal);
    AddConstant('ttbButtonHot',ttbButtonHot);
    AddConstant('ttbButtonPressed',ttbButtonPressed);
    AddConstant('ttbButtonDisabled',ttbButtonDisabled);
    AddConstant('ttbButtonChecked',ttbButtonChecked);
    AddConstant('ttbButtonCheckedHot',ttbButtonCheckedHot);
    AddConstant('ttbDropDownButtonNormal',ttbDropDownButtonNormal);
    AddConstant('ttbDropDownButtonHot',ttbDropDownButtonHot);
    AddConstant('ttbDropDownButtonPressed',ttbDropDownButtonPressed);
    AddConstant('ttbDropDownButtonDisabled',ttbDropDownButtonDisabled);
    AddConstant('ttbDropDownButtonChecked',ttbDropDownButtonChecked);
    AddConstant('ttbDropDownButtonCheckedHot',ttbDropDownButtonCheckedHot);
    AddConstant('ttbSplitButtonNormal',ttbSplitButtonNormal);
    AddConstant('ttbSplitButtonHot',ttbSplitButtonHot);
    AddConstant('ttbSplitButtonPressed',ttbSplitButtonPressed);
    AddConstant('ttbSplitButtonDisabled',ttbSplitButtonDisabled);
    AddConstant('ttbSplitButtonChecked',ttbSplitButtonChecked);
    AddConstant('ttbSplitButtonCheckedHot',ttbSplitButtonCheckedHot);
    AddConstant('ttbSplitButtonDropDownNormal',ttbSplitButtonDropDownNormal);
    AddConstant('ttbSplitButtonDropDownHot',ttbSplitButtonDropDownHot);
    AddConstant('ttbSplitButtonDropDownPressed',ttbSplitButtonDropDownPressed);
    AddConstant('ttbSplitButtonDropDownDisabled',ttbSplitButtonDropDownDisabled);
    AddConstant('ttbSplitButtonDropDownChecked',ttbSplitButtonDropDownChecked);
    AddConstant('ttbSplitButtonDropDownCheckedHot',ttbSplitButtonDropDownCheckedHot);
    AddConstant('ttbSeparatorNormal',ttbSeparatorNormal);
    AddConstant('ttbSeparatorHot',ttbSeparatorHot);
    AddConstant('ttbSeparatorPressed',ttbSeparatorPressed);
    AddConstant('ttbSeparatorDisabled',ttbSeparatorDisabled);
    AddConstant('ttbSeparatorChecked',ttbSeparatorChecked);
    AddConstant('ttbSeparatorCheckedHot',ttbSeparatorCheckedHot);
    AddConstant('ttbSeparatorVertNormal',ttbSeparatorVertNormal);
    AddConstant('ttbSeparatorVertHot',ttbSeparatorVertHot);
    AddConstant('ttbSeparatorVertPressed',ttbSeparatorVertPressed);
    AddConstant('ttbSeparatorVertDisabled',ttbSeparatorVertDisabled);
    AddConstant('ttbSeparatorVertChecked',ttbSeparatorVertChecked);
    AddConstant('ttbSeparatorVertCheckedHot',ttbSeparatorVertCheckedHot);
    AddConstant('tttToolTipDontCare',tttToolTipDontCare);
    AddConstant('tttToolTipRoot',tttToolTipRoot);
    AddConstant('tttStandardNormal',tttStandardNormal);
    AddConstant('tttStandardLink',tttStandardLink);
    AddConstant('tttStandardTitleNormal',tttStandardTitleNormal);
    AddConstant('tttStandardTitleLink',tttStandardTitleLink);
    AddConstant('tttBaloonNormal',tttBaloonNormal);
    AddConstant('tttBaloonLink',tttBaloonLink);
    AddConstant('tttBaloonTitleNormal',tttBaloonTitleNormal);
    AddConstant('tttBaloonTitleLink',tttBaloonTitleLink);
    AddConstant('tttCloseNormal',tttCloseNormal);
    AddConstant('tttCloseHot',tttCloseHot);
    AddConstant('tttClosePressed',tttClosePressed);
    AddConstant('ttbTrackBarDontCare',ttbTrackBarDontCare);
    AddConstant('ttbTrackBarRoot',ttbTrackBarRoot);
    AddConstant('ttbTrack',ttbTrack);
    AddConstant('ttbTrackVert',ttbTrackVert);
    AddConstant('ttbThumbNormal',ttbThumbNormal);
    AddConstant('ttbThumbHot',ttbThumbHot);
    AddConstant('ttbThumbPressed',ttbThumbPressed);
    AddConstant('ttbThumbFocused',ttbThumbFocused);
    AddConstant('ttbThumbDisabled',ttbThumbDisabled);
    AddConstant('ttbThumbBottomNormal',ttbThumbBottomNormal);
    AddConstant('ttbThumbBottomHot',ttbThumbBottomHot);
    AddConstant('ttbThumbBottomPressed',ttbThumbBottomPressed);
    AddConstant('ttbThumbBottomFocused',ttbThumbBottomFocused);
    AddConstant('ttbThumbBottomDisabled',ttbThumbBottomDisabled);
    AddConstant('ttbThumbTopNormal',ttbThumbTopNormal);
    AddConstant('ttbThumbTopHot',ttbThumbTopHot);
    AddConstant('ttbThumbTopPressed',ttbThumbTopPressed);
    AddConstant('ttbThumbTopFocused',ttbThumbTopFocused);
    AddConstant('ttbThumbTopDisabled',ttbThumbTopDisabled);
    AddConstant('ttbThumbVertNormal',ttbThumbVertNormal);
    AddConstant('ttbThumbVertHot',ttbThumbVertHot);
    AddConstant('ttbThumbVertPressed',ttbThumbVertPressed);
    AddConstant('ttbThumbVertFocused',ttbThumbVertFocused);
    AddConstant('ttbThumbVertDisabled',ttbThumbVertDisabled);
    AddConstant('ttbThumbLeftNormal',ttbThumbLeftNormal);
    AddConstant('ttbThumbLeftHot',ttbThumbLeftHot);
    AddConstant('ttbThumbLeftPressed',ttbThumbLeftPressed);
    AddConstant('ttbThumbLeftFocused',ttbThumbLeftFocused);
    AddConstant('ttbThumbLeftDisabled',ttbThumbLeftDisabled);
    AddConstant('ttbThumbRightNormal',ttbThumbRightNormal);
    AddConstant('ttbThumbRightHot',ttbThumbRightHot);
    AddConstant('ttbThumbRightPressed',ttbThumbRightPressed);
    AddConstant('ttbThumbRightFocused',ttbThumbRightFocused);
    AddConstant('ttbThumbRightDisabled',ttbThumbRightDisabled);
    AddConstant('ttbThumbTics',ttbThumbTics);
    AddConstant('ttbThumbTicsVert',ttbThumbTicsVert);
    AddConstant('ttnTrayNotifyDontCare',ttnTrayNotifyDontCare);
    AddConstant('ttnTrayNotifyRoot',ttnTrayNotifyRoot);
    AddConstant('ttnBackground',ttnBackground);
    AddConstant('ttnAnimBackground',ttnAnimBackground);
    AddConstant('ttTreeviewDontCare',ttTreeviewDontCare);
    AddConstant('ttTreeviewRoot',ttTreeviewRoot);
    AddConstant('ttItemNormal',ttItemNormal);
    AddConstant('ttItemHot',ttItemHot);
    AddConstant('ttItemSelected',ttItemSelected);
    AddConstant('ttItemDisabled',ttItemDisabled);
    AddConstant('ttItemSelectedNotFocus',ttItemSelectedNotFocus);
    AddConstant('ttGlyphClosed',ttGlyphClosed);
    AddConstant('ttGlyphOpened',ttGlyphOpened);
    AddConstant('ttBranch',ttBranch);
    AddConstant('twWindowDontCare',twWindowDontCare);
    AddConstant('twWindowRoot',twWindowRoot);
    AddConstant('twCaptionActive',twCaptionActive);
    AddConstant('twCaptionInactive',twCaptionInactive);
    AddConstant('twCaptionDisabled',twCaptionDisabled);
    AddConstant('twSmallCaptionActive',twSmallCaptionActive);
    AddConstant('twSmallCaptionInactive',twSmallCaptionInactive);
    AddConstant('twSmallCaptionDisabled',twSmallCaptionDisabled);
    AddConstant('twMinCaptionActive',twMinCaptionActive);
    AddConstant('twMinCaptionInactive',twMinCaptionInactive);
    AddConstant('twMinCaptionDisabled',twMinCaptionDisabled);
    AddConstant('twSmallMinCaptionActive',twSmallMinCaptionActive);
    AddConstant('twSmallMinCaptionInactive',twSmallMinCaptionInactive);
    AddConstant('twSmallMinCaptionDisabled',twSmallMinCaptionDisabled);
    AddConstant('twMaxCaptionActive',twMaxCaptionActive);
    AddConstant('twMaxCaptionInactive',twMaxCaptionInactive);
    AddConstant('twMaxCaptionDisabled',twMaxCaptionDisabled);
    AddConstant('twSmallMaxCaptionActive',twSmallMaxCaptionActive);
    AddConstant('twSmallMaxCaptionInactive',twSmallMaxCaptionInactive);
    AddConstant('twSmallMaxCaptionDisabled',twSmallMaxCaptionDisabled);
    AddConstant('twFrameLeftActive',twFrameLeftActive);
    AddConstant('twFrameLeftInactive',twFrameLeftInactive);
    AddConstant('twFrameRightActive',twFrameRightActive);
    AddConstant('twFrameRightInactive',twFrameRightInactive);
    AddConstant('twFrameBottomActive',twFrameBottomActive);
    AddConstant('twFrameBottomInactive',twFrameBottomInactive);
    AddConstant('twSmallFrameLeftActive',twSmallFrameLeftActive);
    AddConstant('twSmallFrameLeftInactive',twSmallFrameLeftInactive);
    AddConstant('twSmallFrameRightActive',twSmallFrameRightActive);
    AddConstant('twSmallFrameRightInactive',twSmallFrameRightInactive);
    AddConstant('twSmallFrameBottomActive',twSmallFrameBottomActive);
    AddConstant('twSmallFrameBottomInactive',twSmallFrameBottomInactive);
    AddConstant('twSysButtonNormal',twSysButtonNormal);
    AddConstant('twSysButtonHot',twSysButtonHot);
    AddConstant('twSysButtonPushed',twSysButtonPushed);
    AddConstant('twSysButtonDisabled',twSysButtonDisabled);
    AddConstant('twMDISysButtonNormal',twMDISysButtonNormal);
    AddConstant('twMDISysButtonHot',twMDISysButtonHot);
    AddConstant('twMDISysButtonPushed',twMDISysButtonPushed);
    AddConstant('twMDISysButtonDisabled',twMDISysButtonDisabled);
    AddConstant('twMinButtonNormal',twMinButtonNormal);
    AddConstant('twMinButtonHot',twMinButtonHot);
    AddConstant('twMinButtonPushed',twMinButtonPushed);
    AddConstant('twMinButtonDisabled',twMinButtonDisabled);
    AddConstant('twMDIMinButtonNormal',twMDIMinButtonNormal);
    AddConstant('twMDIMinButtonHot',twMDIMinButtonHot);
    AddConstant('twMDIMinButtonPushed',twMDIMinButtonPushed);
    AddConstant('twMDIMinButtonDisabled',twMDIMinButtonDisabled);
    AddConstant('twMaxButtonNormal',twMaxButtonNormal);
    AddConstant('twMaxButtonHot',twMaxButtonHot);
    AddConstant('twMaxButtonPushed',twMaxButtonPushed);
    AddConstant('twMaxButtonDisabled',twMaxButtonDisabled);
    AddConstant('twCloseButtonNormal',twCloseButtonNormal);
    AddConstant('twCloseButtonHot',twCloseButtonHot);
    AddConstant('twCloseButtonPushed',twCloseButtonPushed);
    AddConstant('twCloseButtonDisabled',twCloseButtonDisabled);
    AddConstant('twSmallCloseButtonNormal',twSmallCloseButtonNormal);
    AddConstant('twSmallCloseButtonHot',twSmallCloseButtonHot);
    AddConstant('twSmallCloseButtonPushed',twSmallCloseButtonPushed);
    AddConstant('twSmallCloseButtonDisabled',twSmallCloseButtonDisabled);
    AddConstant('twMDICloseButtonNormal',twMDICloseButtonNormal);
    AddConstant('twMDICloseButtonHot',twMDICloseButtonHot);
    AddConstant('twMDICloseButtonPushed',twMDICloseButtonPushed);
    AddConstant('twMDICloseButtonDisabled',twMDICloseButtonDisabled);
    AddConstant('twRestoreButtonNormal',twRestoreButtonNormal);
    AddConstant('twRestoreButtonHot',twRestoreButtonHot);
    AddConstant('twRestoreButtonPushed',twRestoreButtonPushed);
    AddConstant('twRestoreButtonDisabled',twRestoreButtonDisabled);
    AddConstant('twMDIRestoreButtonNormal',twMDIRestoreButtonNormal);
    AddConstant('twMDIRestoreButtonHot',twMDIRestoreButtonHot);
    AddConstant('twMDIRestoreButtonPushed',twMDIRestoreButtonPushed);
    AddConstant('twMDIRestoreButtonDisabled',twMDIRestoreButtonDisabled);
    AddConstant('twHelpButtonNormal',twHelpButtonNormal);
    AddConstant('twHelpButtonHot',twHelpButtonHot);
    AddConstant('twHelpButtonPushed',twHelpButtonPushed);
    AddConstant('twHelpButtonDisabled',twHelpButtonDisabled);
    AddConstant('twMDIHelpButtonNormal',twMDIHelpButtonNormal);
    AddConstant('twMDIHelpButtonHot',twMDIHelpButtonHot);
    AddConstant('twMDIHelpButtonPushed',twMDIHelpButtonPushed);
    AddConstant('twMDIHelpButtonDisabled',twMDIHelpButtonDisabled);
    AddConstant('twHorzScrollNormal',twHorzScrollNormal);
    AddConstant('twHorzScrollHot',twHorzScrollHot);
    AddConstant('twHorzScrollPushed',twHorzScrollPushed);
    AddConstant('twHorzScrollDisabled',twHorzScrollDisabled);
    AddConstant('twHorzThumbNormal',twHorzThumbNormal);
    AddConstant('twHorzThumbHot',twHorzThumbHot);
    AddConstant('twHorzThumbPushed',twHorzThumbPushed);
    AddConstant('twHorzThumbDisabled',twHorzThumbDisabled);
    AddConstant('twVertScrollNormal',twVertScrollNormal);
    AddConstant('twVertScrollHot',twVertScrollHot);
    AddConstant('twVertScrollPushed',twVertScrollPushed);
    AddConstant('twVertScrollDisabled',twVertScrollDisabled);
    AddConstant('twVertThumbNormal',twVertThumbNormal);
    AddConstant('twVertThumbHot',twVertThumbHot);
    AddConstant('twVertThumbPushed',twVertThumbPushed);
    AddConstant('twVertThumbDisabled',twVertThumbDisabled);
    AddConstant('twDialog',twDialog);
    AddConstant('twCaptionSizingTemplate',twCaptionSizingTemplate);
    AddConstant('twSmallCaptionSizingTemplate',twSmallCaptionSizingTemplate);
    AddConstant('twFrameLeftSizingTemplate',twFrameLeftSizingTemplate);
    AddConstant('twSmallFrameLeftSizingTemplate',twSmallFrameLeftSizingTemplate);
    AddConstant('twFrameRightSizingTemplate',twFrameRightSizingTemplate);
    AddConstant('twSmallFrameRightSizingTemplate',twSmallFrameRightSizingTemplate);
    AddConstant('twFrameBottomSizingTemplate',twFrameBottomSizingTemplate);
    AddConstant('twSmallFrameBottomSizingTemplate',twSmallFrameBottomSizingTemplate);
  end;
end;

class function TatThemesLibrary.LibraryName: string;
begin
  result := 'Themes';
end;

initialization
  RegisterScripterLibrary(TatThemesLibrary, True);

{$WARNINGS ON}

end.

