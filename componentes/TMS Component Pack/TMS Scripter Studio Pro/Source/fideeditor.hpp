// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'fIDEEditor.pas' rev: 22.00

#ifndef FideeditorHPP
#define FideeditorHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <ExtCtrls.hpp>	// Pascal unit
#include <ComCtrls.hpp>	// Pascal unit
#include <IDEMain.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <atScripter.hpp>	// Pascal unit
#include <atScript.hpp>	// Pascal unit
#include <atPascal.hpp>	// Pascal unit
#include <AdvMemo.hpp>	// Pascal unit
#include <fObjectInspector.hpp>	// Pascal unit
#include <fWatches.hpp>	// Pascal unit
#include <fToolPalette.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <dIDEActions.hpp>	// Pascal unit
#include <StdCtrls.hpp>	// Pascal unit
#include <ToolWin.hpp>	// Pascal unit
#include <Tabs.hpp>	// Pascal unit
#include <ImgList.hpp>	// Pascal unit
#include <ActnList.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Fideeditor
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TIDEEditorForm;
class PASCALIMPLEMENTATION TIDEEditorForm : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
__published:
	Extctrls::TPanel* FLeftPanel;
	Menus::TMainMenu* MainMenu1;
	Extctrls::TSplitter* FLeftSplitter;
	Idemain::TIDEPaletteToolbar* IDEPaletteToolbar2;
	Menus::TMenuItem* File1;
	Menus::TMenuItem* N1;
	Menus::TMenuItem* Save1;
	Menus::TMenuItem* Saveas1;
	Menus::TMenuItem* Saveall1;
	Menus::TMenuItem* N2;
	Menus::TMenuItem* Closefile1;
	Menus::TMenuItem* Closeall1;
	Menus::TMenuItem* N3;
	Menus::TMenuItem* Exit1;
	Menus::TMenuItem* N4;
	Menus::TMenuItem* Open1;
	Menus::TMenuItem* View1;
	Menus::TMenuItem* ToggleFormUnit1;
	Menus::TMenuItem* Run1;
	Menus::TMenuItem* Run2;
	Menus::TMenuItem* N5;
	Menus::TMenuItem* Stepover1;
	Menus::TMenuItem* Traceinto1;
	Menus::TMenuItem* Runtocursor1;
	Menus::TMenuItem* Rununtilreturn1;
	Menus::TMenuItem* Pause1;
	Menus::TMenuItem* Scriptreset1;
	Menus::TMenuItem* N6;
	Menus::TMenuItem* Addwatch1;
	Menus::TMenuItem* Togglebreakpoint1;
	Menus::TMenuItem* Removefromproject1;
	Menus::TMenuItem* Saveprojectas1;
	Menus::TMenuItem* Newproject1;
	Menus::TMenuItem* N7;
	Menus::TMenuItem* Openproject1;
	Menus::TMenuItem* Edit1;
	Menus::TMenuItem* Cut1;
	Menus::TMenuItem* Copy1;
	Menus::TMenuItem* Paste1;
	Menus::TMenuItem* Delete1;
	Menus::TMenuItem* SelectAll1;
	Menus::TMenuItem* N8;
	Menus::TMenuItem* AligntoGrid1;
	Menus::TMenuItem* BringtoFront1;
	Menus::TMenuItem* SendtoBack1;
	Menus::TMenuItem* Align1;
	Menus::TMenuItem* Size1;
	Menus::TMenuItem* TabOrder1;
	Menus::TMenuItem* acLock1;
	Menus::TMenuItem* Tools1;
	Menus::TMenuItem* DesignerOptions1;
	Extctrls::TControlBar* ControlBar1;
	Comctrls::TToolBar* ToolBar1;
	Comctrls::TToolButton* ToolButton1;
	Comctrls::TToolButton* ToolButton2;
	Comctrls::TToolBar* ToolBar2;
	Comctrls::TToolButton* ToolButton3;
	Comctrls::TToolButton* ToolButton4;
	Comctrls::TToolButton* ToolButton5;
	Comctrls::TToolBar* ToolBar3;
	Comctrls::TToolButton* ToolButton6;
	Comctrls::TToolButton* ToolButton7;
	Comctrls::TToolButton* ToolButton8;
	Comctrls::TToolButton* ToolButton9;
	Comctrls::TToolButton* ToolButton10;
	Comctrls::TToolButton* ToolButton11;
	Comctrls::TToolButton* ToolButton12;
	Comctrls::TToolButton* ToolButton13;
	Comctrls::TToolButton* ToolButton14;
	Extctrls::TPanel* FRightPanel;
	Extctrls::TSplitter* FRightSplitter;
	Menus::TMenuItem* NewUnit1;
	Menus::TMenuItem* NewForm1;
	Comctrls::TToolButton* ToolButton15;
	Menus::TMenuItem* Project1;
	Menus::TMenuItem* SelectMainUnit1;
	Actnlist::TActionList* ActionList1;
	Actnlist::TAction* acViewWatches;
	Actnlist::TAction* acViewPalette;
	Actnlist::TAction* acViewInspector;
	Menus::TMenuItem* N9;
	Menus::TMenuItem* ObjectInspector1;
	Menus::TMenuItem* ToolPalette1;
	Menus::TMenuItem* Watches1;
	Extctrls::TPanel* Panel1;
	Extctrls::TPanel* Panel2;
	Comctrls::TTabControl* TabControl1;
	Idemain::TIDEFormDesignControl* IDEFormDesignControl1;
	Idemain::TIDEMemo* IDEMemo1;
	Tabs::TTabSet* TabSet1;
	Extctrls::TPanel* FBottomPanel;
	Extctrls::TSplitter* FBottomSplitter;
	Menus::TPopupMenu* PopupMenu1;
	Comctrls::TToolBar* ToolBar4;
	Comctrls::TToolButton* ToolButton16;
	Comctrls::TToolButton* ToolButton17;
	Comctrls::TToolButton* ToolButton18;
	Comctrls::TToolButton* ToolButton19;
	Menus::TMenuItem* N10;
	Menus::TMenuItem* Undo1;
	Menus::TMenuItem* N11;
	Menus::TMenuItem* Find1;
	Menus::TMenuItem* Replace1;
	Menus::TMenuItem* Searchagain1;
	Menus::TMenuItem* Redo1;
	Menus::TMenuItem* Compile1;
	void __fastcall PanelDockDrop(System::TObject* Sender, Controls::TDragDockObject* Source, int X, int Y);
	void __fastcall PanelUnDock(System::TObject* Sender, Controls::TControl* Client, Controls::TWinControl* NewTarget, bool &Allow);
	void __fastcall ControlBar1DockOver(System::TObject* Sender, Controls::TDragDockObject* Source, int X, int Y, Controls::TDragState State, bool &Accept);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall FormCloseQuery(System::TObject* Sender, bool &CanClose);
	void __fastcall acViewInspectorExecute(System::TObject* Sender);
	void __fastcall acViewPaletteExecute(System::TObject* Sender);
	void __fastcall acViewWatchesExecute(System::TObject* Sender);
	void __fastcall TabSet1Change(System::TObject* Sender, int NewTab, bool &AllowChange);
	
private:
	Dideactions::TdmIDEActions* FIDEActions;
	Fobjectinspector::TfmObjectInspector* FInspectorForm;
	Ftoolpalette::TfmToolPalette* FPaletteForm;
	Fwatches::TfmWatches* FWatchesForm;
	bool FUpdatingTabset;
	System::UnicodeString FTitle;
	Idemain::TIDEEngine* FEngine;
	bool FCloseAllOnExit;
	Idemain::TIDEFormDesignControl* FOldDesignControl;
	Idemain::TIDEMemo* FOldMemo;
	Idemain::TIDEPaletteToolbar* FOldPaletteToolbar;
	Controls::TControl* FOldTabControl;
	Classes::TNotifyEvent FOldBeforeAddWatchDlg;
	Classes::TNotifyEvent FOldOnActiveFileChanged;
	Idemain::TRunningChangeEvent FOldOnRunningChanged;
	Classes::TNotifyEvent FOldOnViewModeChanged;
	Classes::TNotifyEvent FOldOnProjNameChanged;
	Classes::TNotifyEvent FOnNotifyShow;
	void __fastcall IDEEngineProjNameChanged(System::TObject* Sender);
	void __fastcall UpdateCodeTabset(Tabs::TTabSet* ATabset);
	Extctrls::TSplitter* __fastcall PanelSplitter(Extctrls::TPanel* APanel);
	int __fastcall PanelSize(Extctrls::TPanel* APanel);
	void __fastcall SetPanelSize(Extctrls::TPanel* APanel, int ASize);
	void __fastcall SetSplitterPos(Extctrls::TPanel* APanel, int APos);
	void __fastcall UpdatePanel(Extctrls::TPanel* APanel, Controls::TControl* AIgnore = (Controls::TControl*)(0x0));
	void __fastcall ShowDockedForm(Forms::TForm* AForm, bool AVisible, bool AFocus = true);
	void __fastcall DockFormClose(System::TObject* Sender, Forms::TCloseAction &Action);
	void __fastcall SetTitle(const System::UnicodeString Value);
	void __fastcall IDEEngineViewModeChanged(System::TObject* Sender);
	void __fastcall IDEEngineActiveFileChanged(System::TObject* Sender);
	void __fastcall IDEEngineBeforeAddWatchDlg(System::TObject* Sender);
	void __fastcall IDEEngineRunningChanged(System::TObject* Sender, bool ARunning);
	
public:
	void __fastcall AttachEngine(Idemain::TIDEEngine* AEngine);
	void __fastcall DetachEngine(void);
	void __fastcall ShowInspector(bool AVisible);
	void __fastcall ShowPalette(bool AVisible);
	void __fastcall ShowWatches(bool AVisible, bool AFocus = true);
	__property Dideactions::TdmIDEActions* IDEActions = {read=FIDEActions};
	__property System::UnicodeString Title = {read=FTitle, write=SetTitle};
	__property bool CloseAllOnExit = {read=FCloseAllOnExit, write=FCloseAllOnExit, nodefault};
	__property Classes::TNotifyEvent OnNotifyShow = {read=FOnNotifyShow, write=FOnNotifyShow};
	__property Fobjectinspector::TfmObjectInspector* InspectorForm = {read=FInspectorForm};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TIDEEditorForm(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TIDEEditorForm(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TIDEEditorForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TIDEEditorForm(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE TIDEEditorForm* IDEEditorForm;

}	/* namespace Fideeditor */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Fideeditor;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FideeditorHPP
