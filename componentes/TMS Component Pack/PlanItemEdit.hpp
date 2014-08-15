// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Planitemedit.pas' rev: 21.00

#ifndef PlanitemeditHPP
#define PlanitemeditHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Planner.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Comctrls.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <Commctrl.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Planitemedit
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TEditState { esEdit, esNew };
#pragma option pop

class DELPHICLASS TBasePlannerItemEditForm;
class PASCALIMPLEMENTATION TBasePlannerItemEditForm : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
private:
	TEditState FEditState;
	
protected:
	virtual void __fastcall AssignFromPlannerItem(Planner::TPlannerItem* PlannerItem);
	virtual void __fastcall AssignToPlannerItem(Planner::TPlannerItem* PlannerItem);
	virtual void __fastcall CheckInputValues(Planner::TPlannerItem* PlannerItem);
	virtual void __fastcall EditStateChanged(void);
	virtual void __fastcall FixEnabledComponents(void);
	virtual void __fastcall InternalEditModal(Planner::TPlannerItem* PlannerItem);
	virtual void __fastcall ProcessWarnings(void);
	virtual void __fastcall SetEditState(const TEditState Value);
	
public:
	virtual void __fastcall EditModal(Planner::TPlannerItem* PlannerItem);
	__property TEditState EditState = {read=FEditState, write=SetEditState, nodefault};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TBasePlannerItemEditForm(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TBasePlannerItemEditForm(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TBasePlannerItemEditForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TBasePlannerItemEditForm(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


class DELPHICLASS TDefaultPlannerItemEditForm;
class PASCALIMPLEMENTATION TDefaultPlannerItemEditForm : public TBasePlannerItemEditForm
{
	typedef TBasePlannerItemEditForm inherited;
	
__published:
	Stdctrls::TLabel* Label1;
	Stdctrls::TLabel* Label2;
	Stdctrls::TLabel* Label3;
	Stdctrls::TLabel* Label4;
	Stdctrls::TLabel* Label5;
	Stdctrls::TLabel* Label6;
	Stdctrls::TButton* BaseColorButton;
	Comctrls::TDateTimePicker* StartTimeDateTimePicker;
	Comctrls::TDateTimePicker* EndTimeDateTimePicker;
	Extctrls::TPanel* BaseColorPanel;
	Stdctrls::TEdit* SubjectEdit;
	Stdctrls::TMemo* NotesMemo;
	Comctrls::TDateTimePicker* PlanDateDateTimePicker;
	Dialogs::TColorDialog* ColorDialog;
	Extctrls::TPanel* WarningPanel;
	Extctrls::TPanel* ButtonBottomPanel;
	Extctrls::TPanel* ButtonBottomRightPanel;
	Stdctrls::TButton* OKBtn;
	Stdctrls::TButton* CancBtn;
	Stdctrls::TLabel* Label9;
	Stdctrls::TEdit* UrlEdit;
	Extctrls::TBevel* Bevel1;
	Stdctrls::TCheckBox* ReminderCheckBox;
	Comctrls::TDateTimePicker* ReminderDateTimePicker;
	Stdctrls::TLabel* ReminderMessageLabel;
	Stdctrls::TEdit* ReminderMesssageEdit;
	Extctrls::TBevel* Bevel2;
	Stdctrls::TLabel* Label10;
	Stdctrls::TButton* TrackColorButton;
	Extctrls::TPanel* TrackColorPanel;
	Stdctrls::TButton* SelectedFontColorButton;
	Stdctrls::TButton* SelectedColorButton;
	Extctrls::TPanel* SelectedColorPanel;
	Extctrls::TPanel* SelectedFontColorPanel;
	Stdctrls::TLabel* Label7;
	Stdctrls::TComboBox* ShapeComboBox;
	Stdctrls::TCheckBox* FlashingCheckBox;
	Stdctrls::TButton* FontButton;
	Dialogs::TFontDialog* FontDialog;
	Stdctrls::TLabel* ReminderAddressLabel;
	Stdctrls::TEdit* ReminderAddressEdit;
	Extctrls::TPanel* FontPanel;
	Extctrls::TImage* AlarmImage;
	Extctrls::TImage* CautionImage;
	Buttons::TSpeedButton* ImageSpeedButton;
	Comctrls::TUpDown* ImageUpDown;
	Buttons::TBitBtn* AlignLeftBitBtn;
	Buttons::TBitBtn* AlignCentreLeftBitBtn;
	Buttons::TBitBtn* AlignRightBitBtn;
	void __fastcall BaseColorPanelClick(System::TObject* Sender);
	void __fastcall ReminderCheckBoxClick(System::TObject* Sender);
	void __fastcall FontButtonClick(System::TObject* Sender);
	void __fastcall PlanDateDateTimePickerChange(System::TObject* Sender);
	void __fastcall StartTimeDateTimePickerChange(System::TObject* Sender);
	void __fastcall EndTimeDateTimePickerChange(System::TObject* Sender);
	void __fastcall ImageUpDownClick(System::TObject* Sender, Comctrls::TUDBtnType Button);
	void __fastcall AlignLeftBitBtnClick(System::TObject* Sender);
	void __fastcall AlignCentreLeftBitBtnClick(System::TObject* Sender);
	void __fastcall AlignRightBitBtnClick(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	
private:
	Controls::TImageList* FImageList;
	
protected:
	virtual System::TTime __fastcall GetEndTime(void);
	virtual System::TDateTime __fastcall GetPlanDate(void);
	virtual System::TTime __fastcall GetStartTime(void);
	virtual System::TTime __fastcall GetReminderTime(void);
	virtual void __fastcall SetEndTime(const System::TTime Value);
	virtual void __fastcall SetImageList(const Controls::TImageList* Value);
	virtual void __fastcall SetPlanDate(const System::TDateTime Value);
	virtual void __fastcall SetStartTime(const System::TTime Value);
	virtual void __fastcall SetReminderTime(const System::TTime Value);
	__property System::TDateTime PlanDate = {read=GetPlanDate, write=SetPlanDate};
	__property System::TTime StartTime = {read=GetStartTime, write=SetStartTime};
	__property System::TTime EndTime = {read=GetEndTime, write=SetEndTime};
	__property Controls::TImageList* ImageList = {read=FImageList, write=SetImageList};
	__property System::TTime ReminderTime = {read=GetReminderTime, write=SetReminderTime};
	virtual void __fastcall AssignFromPlannerItem(Planner::TPlannerItem* PlannerItem);
	virtual void __fastcall AssignToPlannerItem(Planner::TPlannerItem* PlannerItem);
	virtual void __fastcall CheckInputValues(Planner::TPlannerItem* PlannerItem);
	virtual void __fastcall CopyImageToSpeedButton(int Index);
	virtual void __fastcall EditStateChanged(void);
	virtual void __fastcall FixEnabledComponents(void);
	virtual void __fastcall ImageChanged(void);
	virtual void __fastcall ProcessWarnings(void);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TDefaultPlannerItemEditForm(Classes::TComponent* AOwner) : TBasePlannerItemEditForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TDefaultPlannerItemEditForm(Classes::TComponent* AOwner, int Dummy) : TBasePlannerItemEditForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TDefaultPlannerItemEditForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TDefaultPlannerItemEditForm(HWND ParentWindow) : TBasePlannerItemEditForm(ParentWindow) { }
	
};


class DELPHICLASS TDefaultItemEditor;
class PASCALIMPLEMENTATION TDefaultItemEditor : public Planner::TCustomItemEditor
{
	typedef Planner::TCustomItemEditor inherited;
	
private:
	TDefaultPlannerItemEditForm* FEditForm;
	bool FCenter;
	int FFormLeft;
	int FFormTop;
	
public:
	__fastcall virtual TDefaultItemEditor(Classes::TComponent* AOwner);
	virtual void __fastcall CreateEditor(Classes::TComponent* AOwner);
	virtual void __fastcall DestroyEditor(void);
	virtual int __fastcall Execute(void);
	virtual void __fastcall PlannerItemToEdit(Planner::TPlannerItem* APlannerItem);
	virtual void __fastcall EditToPlannerItem(Planner::TPlannerItem* APlannerItem);
	
__published:
	__property bool CenterOnScreen = {read=FCenter, write=FCenter, default=1};
	__property int FormLeft = {read=FFormLeft, write=FFormLeft, nodefault};
	__property int FormTop = {read=FFormTop, write=FFormTop, nodefault};
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TDefaultItemEditor(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt OneDay = 0x1;
static const Extended OneHour = 4.166667E-02;
static const Extended OneMinute = 6.944444E-04;
static const Extended OneSecond = 1.157407E-05;
static const Extended MinDuration = 1.041667E-02;

}	/* namespace Planitemedit */
using namespace Planitemedit;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlanitemeditHPP
