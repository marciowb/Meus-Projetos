// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ap_Messages.pas' rev: 22.00

#ifndef Ap_messagesHPP
#define Ap_messagesHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit
#include <atScript.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Ap_messages
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TatMessagesLibrary;
class PASCALIMPLEMENTATION TatMessagesLibrary : public Atscript::TatScripterLibrary
{
	typedef Atscript::TatScripterLibrary inherited;
	
public:
	void __fastcall __SendTextMessage(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SendStructMessage(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SendGetStructMessage(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SendGetIntMessage(Atscript::TatVirtualMachine* AMachine);
	virtual void __fastcall Init(void);
	__classmethod virtual System::UnicodeString __fastcall LibraryName();
public:
	/* TatScripterLibrary.Create */ inline __fastcall virtual TatMessagesLibrary(Atscript::TatCustomScripter* AScripter) : Atscript::TatScripterLibrary(AScripter) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TatMessagesLibrary(void) { }
	
};


class DELPHICLASS TMessageWrapper;
class PASCALIMPLEMENTATION TMessageWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	int FWParam;
	int FLParam;
	int FResult;
	System::Word FWParamLo;
	System::Word FWParamHi;
	System::Word FLParamLo;
	System::Word FLParamHi;
	System::Word FResultLo;
	System::Word FResultHi;
	
public:
	__fastcall TMessageWrapper(const Messages::TMessage &ARecord);
	Messages::TMessage __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property int WParam = {read=FWParam, write=FWParam, nodefault};
	__property int LParam = {read=FLParam, write=FLParam, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
	__property System::Word WParamLo = {read=FWParamLo, write=FWParamLo, nodefault};
	__property System::Word WParamHi = {read=FWParamHi, write=FWParamHi, nodefault};
	__property System::Word LParamLo = {read=FLParamLo, write=FLParamLo, nodefault};
	__property System::Word LParamHi = {read=FLParamHi, write=FLParamHi, nodefault};
	__property System::Word ResultLo = {read=FResultLo, write=FResultLo, nodefault};
	__property System::Word ResultHi = {read=FResultHi, write=FResultHi, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TMessageWrapper(void) { }
	
};


class DELPHICLASS TWMNoParamsWrapper;
class PASCALIMPLEMENTATION TWMNoParamsWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	int FResult;
	
public:
	__fastcall TWMNoParamsWrapper(const Messages::TWMNoParams &ARecord);
	Messages::TWMNoParams __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMNoParamsWrapper(void) { }
	
};


class DELPHICLASS TWMKeyWrapper;
class PASCALIMPLEMENTATION TWMKeyWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	System::Word FCharCode;
	System::Word FUnused;
	int FKeyData;
	int FResult;
	
public:
	__fastcall TWMKeyWrapper(const Messages::TWMKey &ARecord);
	Messages::TWMKey __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property System::Word CharCode = {read=FCharCode, write=FCharCode, nodefault};
	__property System::Word Unused = {read=FUnused, write=FUnused, nodefault};
	__property int KeyData = {read=FKeyData, write=FKeyData, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMKeyWrapper(void) { }
	
};


class DELPHICLASS TWMMouseWrapper;
class PASCALIMPLEMENTATION TWMMouseWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	int FKeys;
	short FXPos;
	short FYPos;
	int FResult;
	
public:
	__fastcall TWMMouseWrapper(const Messages::TWMMouse &ARecord);
	Messages::TWMMouse __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property int Keys = {read=FKeys, write=FKeys, nodefault};
	__property short XPos = {read=FXPos, write=FXPos, nodefault};
	__property short YPos = {read=FYPos, write=FYPos, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMMouseWrapper(void) { }
	
};


class DELPHICLASS TWMMouseWheelWrapper;
class PASCALIMPLEMENTATION TWMMouseWheelWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	short FKeys;
	short FWheelDelta;
	short FXPos;
	short FYPos;
	int FResult;
	
public:
	__fastcall TWMMouseWheelWrapper(const Messages::TWMMouseWheel &ARecord);
	Messages::TWMMouseWheel __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property short Keys = {read=FKeys, write=FKeys, nodefault};
	__property short WheelDelta = {read=FWheelDelta, write=FWheelDelta, nodefault};
	__property short XPos = {read=FXPos, write=FXPos, nodefault};
	__property short YPos = {read=FYPos, write=FYPos, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMMouseWheelWrapper(void) { }
	
};


class DELPHICLASS TMSHMouseWheelWrapper;
class PASCALIMPLEMENTATION TMSHMouseWheelWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	int FWheelDelta;
	short FXPos;
	short FYPos;
	int FResult;
	
public:
	__fastcall TMSHMouseWheelWrapper(const Messages::TMSHMouseWheel &ARecord);
	Messages::TMSHMouseWheel __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property int WheelDelta = {read=FWheelDelta, write=FWheelDelta, nodefault};
	__property short XPos = {read=FXPos, write=FXPos, nodefault};
	__property short YPos = {read=FYPos, write=FYPos, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TMSHMouseWheelWrapper(void) { }
	
};


class DELPHICLASS TWMWindowPosMsgWrapper;
class PASCALIMPLEMENTATION TWMWindowPosMsgWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	int FUnused;
	int FResult;
	
public:
	__fastcall TWMWindowPosMsgWrapper(const Messages::TWMWindowPosMsg &ARecord);
	Messages::TWMWindowPosMsg __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property int Unused = {read=FUnused, write=FUnused, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMWindowPosMsgWrapper(void) { }
	
};


class DELPHICLASS TWMScrollWrapper;
class PASCALIMPLEMENTATION TWMScrollWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	short FScrollCode;
	short FPos;
	HWND FScrollBar;
	int FResult;
	
public:
	__fastcall TWMScrollWrapper(const Messages::TWMScroll &ARecord);
	Messages::TWMScroll __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property short ScrollCode = {read=FScrollCode, write=FScrollCode, nodefault};
	__property short Pos = {read=FPos, write=FPos, nodefault};
	__property HWND ScrollBar = {read=FScrollBar, write=FScrollBar, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMScrollWrapper(void) { }
	
};


class DELPHICLASS TWMActivateWrapper;
class PASCALIMPLEMENTATION TWMActivateWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	System::Word FActive;
	System::WordBool FMinimized;
	HWND FActiveWindow;
	int FResult;
	
public:
	__fastcall TWMActivateWrapper(const Messages::TWMActivate &ARecord);
	Messages::TWMActivate __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property System::Word Active = {read=FActive, write=FActive, nodefault};
	__property System::WordBool Minimized = {read=FMinimized, write=FMinimized, nodefault};
	__property HWND ActiveWindow = {read=FActiveWindow, write=FActiveWindow, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMActivateWrapper(void) { }
	
};


class DELPHICLASS TWMActivateAppWrapper;
class PASCALIMPLEMENTATION TWMActivateAppWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	BOOL FActive;
	int FThreadId;
	int FResult;
	
public:
	__fastcall TWMActivateAppWrapper(const Messages::TWMActivateApp &ARecord);
	Messages::TWMActivateApp __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property BOOL Active = {read=FActive, write=FActive, nodefault};
	__property int ThreadId = {read=FThreadId, write=FThreadId, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMActivateAppWrapper(void) { }
	
};


class DELPHICLASS TWMAskCBFormatNameWrapper;
class PASCALIMPLEMENTATION TWMAskCBFormatNameWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	System::Word FNameLen;
	System::Word FUnused;
	int FResult;
	
public:
	__fastcall TWMAskCBFormatNameWrapper(const Messages::TWMAskCBFormatName &ARecord);
	Messages::TWMAskCBFormatName __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property System::Word NameLen = {read=FNameLen, write=FNameLen, nodefault};
	__property System::Word Unused = {read=FUnused, write=FUnused, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMAskCBFormatNameWrapper(void) { }
	
};


class DELPHICLASS TWMChangeCBChainWrapper;
class PASCALIMPLEMENTATION TWMChangeCBChainWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	HWND FRemove;
	HWND FNext;
	int FResult;
	
public:
	__fastcall TWMChangeCBChainWrapper(const Messages::TWMChangeCBChain &ARecord);
	Messages::TWMChangeCBChain __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property HWND Remove = {read=FRemove, write=FRemove, nodefault};
	__property HWND Next = {read=FNext, write=FNext, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMChangeCBChainWrapper(void) { }
	
};


class DELPHICLASS TWMCharToItemWrapper;
class PASCALIMPLEMENTATION TWMCharToItemWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	System::Word FKey;
	System::Word FCaretPos;
	HWND FListBox;
	int FResult;
	
public:
	__fastcall TWMCharToItemWrapper(const Messages::TWMCharToItem &ARecord);
	Messages::TWMCharToItem __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property System::Word Key = {read=FKey, write=FKey, nodefault};
	__property System::Word CaretPos = {read=FCaretPos, write=FCaretPos, nodefault};
	__property HWND ListBox = {read=FListBox, write=FListBox, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMCharToItemWrapper(void) { }
	
};


class DELPHICLASS TWMChooseFont_GetLogFontWrapper;
class PASCALIMPLEMENTATION TWMChooseFont_GetLogFontWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	int FUnused;
	int FResult;
	
public:
	__fastcall TWMChooseFont_GetLogFontWrapper(const Messages::TWMChooseFont_GetLogFont &ARecord);
	Messages::TWMChooseFont_GetLogFont __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property int Unused = {read=FUnused, write=FUnused, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMChooseFont_GetLogFontWrapper(void) { }
	
};


class DELPHICLASS TWMCommandWrapper;
class PASCALIMPLEMENTATION TWMCommandWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	System::Word FItemID;
	System::Word FNotifyCode;
	HWND FCtl;
	int FResult;
	
public:
	__fastcall TWMCommandWrapper(const Messages::TWMCommand &ARecord);
	Messages::TWMCommand __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property System::Word ItemID = {read=FItemID, write=FItemID, nodefault};
	__property System::Word NotifyCode = {read=FNotifyCode, write=FNotifyCode, nodefault};
	__property HWND Ctl = {read=FCtl, write=FCtl, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMCommandWrapper(void) { }
	
};


class DELPHICLASS TWMCompactingWrapper;
class PASCALIMPLEMENTATION TWMCompactingWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	int FCompactRatio;
	int FUnused;
	int FResult;
	
public:
	__fastcall TWMCompactingWrapper(const Messages::TWMCompacting &ARecord);
	Messages::TWMCompacting __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property int CompactRatio = {read=FCompactRatio, write=FCompactRatio, nodefault};
	__property int Unused = {read=FUnused, write=FUnused, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMCompactingWrapper(void) { }
	
};


class DELPHICLASS TWMCompareItemWrapper;
class PASCALIMPLEMENTATION TWMCompareItemWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	HWND FCtl;
	int FResult;
	
public:
	__fastcall TWMCompareItemWrapper(const Messages::TWMCompareItem &ARecord);
	Messages::TWMCompareItem __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property HWND Ctl = {read=FCtl, write=FCtl, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMCompareItemWrapper(void) { }
	
};


class DELPHICLASS TWMCopyDataWrapper;
class PASCALIMPLEMENTATION TWMCopyDataWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	HWND FFrom;
	int FResult;
	
public:
	__fastcall TWMCopyDataWrapper(const Messages::TWMCopyData &ARecord);
	Messages::TWMCopyData __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property HWND From = {read=FFrom, write=FFrom, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMCopyDataWrapper(void) { }
	
};


class DELPHICLASS TWMCreateWrapper;
class PASCALIMPLEMENTATION TWMCreateWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	int FUnused;
	int FResult;
	
public:
	__fastcall TWMCreateWrapper(const Messages::TWMCreate &ARecord);
	Messages::TWMCreate __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property int Unused = {read=FUnused, write=FUnused, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMCreateWrapper(void) { }
	
};


class DELPHICLASS TWMCtlColorWrapper;
class PASCALIMPLEMENTATION TWMCtlColorWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	HDC FChildDC;
	HWND FChildWnd;
	int FResult;
	
public:
	__fastcall TWMCtlColorWrapper(const Messages::TWMCtlColor &ARecord);
	Messages::TWMCtlColor __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property HDC ChildDC = {read=FChildDC, write=FChildDC, nodefault};
	__property HWND ChildWnd = {read=FChildWnd, write=FChildWnd, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMCtlColorWrapper(void) { }
	
};


class DELPHICLASS TWMDDE_AckWrapper;
class PASCALIMPLEMENTATION TWMDDE_AckWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	HWND FPostingApp;
	System::Word FApp;
	System::Word FTopic;
	int FResult;
	int FPackedVal;
	
public:
	__fastcall TWMDDE_AckWrapper(const Messages::TWMDDE_Ack &ARecord);
	Messages::TWMDDE_Ack __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property HWND PostingApp = {read=FPostingApp, write=FPostingApp, nodefault};
	__property System::Word App = {read=FApp, write=FApp, nodefault};
	__property System::Word Topic = {read=FTopic, write=FTopic, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
	__property int PackedVal = {read=FPackedVal, write=FPackedVal, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMDDE_AckWrapper(void) { }
	
};


class DELPHICLASS TWMDDE_AdviseWrapper;
class PASCALIMPLEMENTATION TWMDDE_AdviseWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	HWND FPostingApp;
	int FPackedVal;
	int FResult;
	
public:
	__fastcall TWMDDE_AdviseWrapper(const Messages::TWMDDE_Advise &ARecord);
	Messages::TWMDDE_Advise __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property HWND PostingApp = {read=FPostingApp, write=FPostingApp, nodefault};
	__property int PackedVal = {read=FPackedVal, write=FPackedVal, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMDDE_AdviseWrapper(void) { }
	
};


class DELPHICLASS TWMDDE_DataWrapper;
class PASCALIMPLEMENTATION TWMDDE_DataWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	HWND FPostingApp;
	int FPackedVal;
	int FResult;
	
public:
	__fastcall TWMDDE_DataWrapper(const Messages::TWMDDE_Data &ARecord);
	Messages::TWMDDE_Data __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property HWND PostingApp = {read=FPostingApp, write=FPostingApp, nodefault};
	__property int PackedVal = {read=FPackedVal, write=FPackedVal, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMDDE_DataWrapper(void) { }
	
};


class DELPHICLASS TWMDDE_ExecuteWrapper;
class PASCALIMPLEMENTATION TWMDDE_ExecuteWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	HWND FPostingApp;
	unsigned FCommands;
	int FResult;
	
public:
	__fastcall TWMDDE_ExecuteWrapper(const Messages::TWMDDE_Execute &ARecord);
	Messages::TWMDDE_Execute __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property HWND PostingApp = {read=FPostingApp, write=FPostingApp, nodefault};
	__property unsigned Commands = {read=FCommands, write=FCommands, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMDDE_ExecuteWrapper(void) { }
	
};


class DELPHICLASS TWMDDE_InitiateWrapper;
class PASCALIMPLEMENTATION TWMDDE_InitiateWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	HWND FPostingApp;
	System::Word FApp;
	System::Word FTopic;
	int FResult;
	
public:
	__fastcall TWMDDE_InitiateWrapper(const Messages::TWMDDE_Initiate &ARecord);
	Messages::TWMDDE_Initiate __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property HWND PostingApp = {read=FPostingApp, write=FPostingApp, nodefault};
	__property System::Word App = {read=FApp, write=FApp, nodefault};
	__property System::Word Topic = {read=FTopic, write=FTopic, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMDDE_InitiateWrapper(void) { }
	
};


class DELPHICLASS TWMDDE_PokeWrapper;
class PASCALIMPLEMENTATION TWMDDE_PokeWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	HWND FPostingApp;
	int FPackedVal;
	int FResult;
	
public:
	__fastcall TWMDDE_PokeWrapper(const Messages::TWMDDE_Poke &ARecord);
	Messages::TWMDDE_Poke __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property HWND PostingApp = {read=FPostingApp, write=FPostingApp, nodefault};
	__property int PackedVal = {read=FPackedVal, write=FPackedVal, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMDDE_PokeWrapper(void) { }
	
};


class DELPHICLASS TWMDDE_RequestWrapper;
class PASCALIMPLEMENTATION TWMDDE_RequestWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	HWND FPostingApp;
	System::Word FFormat;
	System::Word FItem;
	int FResult;
	
public:
	__fastcall TWMDDE_RequestWrapper(const Messages::TWMDDE_Request &ARecord);
	Messages::TWMDDE_Request __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property HWND PostingApp = {read=FPostingApp, write=FPostingApp, nodefault};
	__property System::Word Format = {read=FFormat, write=FFormat, nodefault};
	__property System::Word Item = {read=FItem, write=FItem, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMDDE_RequestWrapper(void) { }
	
};


class DELPHICLASS TWMDDE_TerminateWrapper;
class PASCALIMPLEMENTATION TWMDDE_TerminateWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	HWND FPostingApp;
	int FUnused;
	int FResult;
	
public:
	__fastcall TWMDDE_TerminateWrapper(const Messages::TWMDDE_Terminate &ARecord);
	Messages::TWMDDE_Terminate __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property HWND PostingApp = {read=FPostingApp, write=FPostingApp, nodefault};
	__property int Unused = {read=FUnused, write=FUnused, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMDDE_TerminateWrapper(void) { }
	
};


class DELPHICLASS TWMDDE_UnadviseWrapper;
class PASCALIMPLEMENTATION TWMDDE_UnadviseWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	HWND FPostingApp;
	System::Word FFormat;
	System::Word FItem;
	int FResult;
	
public:
	__fastcall TWMDDE_UnadviseWrapper(const Messages::TWMDDE_Unadvise &ARecord);
	Messages::TWMDDE_Unadvise __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property HWND PostingApp = {read=FPostingApp, write=FPostingApp, nodefault};
	__property System::Word Format = {read=FFormat, write=FFormat, nodefault};
	__property System::Word Item = {read=FItem, write=FItem, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMDDE_UnadviseWrapper(void) { }
	
};


class DELPHICLASS TWMDeleteItemWrapper;
class PASCALIMPLEMENTATION TWMDeleteItemWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	HWND FCtl;
	int FResult;
	
public:
	__fastcall TWMDeleteItemWrapper(const Messages::TWMDeleteItem &ARecord);
	Messages::TWMDeleteItem __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property HWND Ctl = {read=FCtl, write=FCtl, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMDeleteItemWrapper(void) { }
	
};


class DELPHICLASS TWMDevModeChangeWrapper;
class PASCALIMPLEMENTATION TWMDevModeChangeWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	int FUnused;
	int FResult;
	
public:
	__fastcall TWMDevModeChangeWrapper(const Messages::TWMDevModeChange &ARecord);
	Messages::TWMDevModeChange __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property int Unused = {read=FUnused, write=FUnused, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMDevModeChangeWrapper(void) { }
	
};


class DELPHICLASS TWMDrawItemWrapper;
class PASCALIMPLEMENTATION TWMDrawItemWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	HWND FCtl;
	int FResult;
	
public:
	__fastcall TWMDrawItemWrapper(const Messages::TWMDrawItem &ARecord);
	Messages::TWMDrawItem __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property HWND Ctl = {read=FCtl, write=FCtl, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMDrawItemWrapper(void) { }
	
};


class DELPHICLASS TWMDropFilesWrapper;
class PASCALIMPLEMENTATION TWMDropFilesWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	unsigned FDrop;
	int FUnused;
	int FResult;
	
public:
	__fastcall TWMDropFilesWrapper(const Messages::TWMDropFiles &ARecord);
	Messages::TWMDropFiles __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property unsigned Drop = {read=FDrop, write=FDrop, nodefault};
	__property int Unused = {read=FUnused, write=FUnused, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMDropFilesWrapper(void) { }
	
};


class DELPHICLASS TWMEnableWrapper;
class PASCALIMPLEMENTATION TWMEnableWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	BOOL FEnabled;
	int FUnused;
	int FResult;
	
public:
	__fastcall TWMEnableWrapper(const Messages::TWMEnable &ARecord);
	Messages::TWMEnable __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property BOOL Enabled = {read=FEnabled, write=FEnabled, nodefault};
	__property int Unused = {read=FUnused, write=FUnused, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMEnableWrapper(void) { }
	
};


class DELPHICLASS TWMEndSessionWrapper;
class PASCALIMPLEMENTATION TWMEndSessionWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	BOOL FEndSession;
	int FUnused;
	int FResult;
	
public:
	__fastcall TWMEndSessionWrapper(const Messages::TWMEndSession &ARecord);
	Messages::TWMEndSession __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property BOOL EndSession = {read=FEndSession, write=FEndSession, nodefault};
	__property int Unused = {read=FUnused, write=FUnused, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMEndSessionWrapper(void) { }
	
};


class DELPHICLASS TWMEnterIdleWrapper;
class PASCALIMPLEMENTATION TWMEnterIdleWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	int FSource;
	HWND FIdleWnd;
	int FResult;
	
public:
	__fastcall TWMEnterIdleWrapper(const Messages::TWMEnterIdle &ARecord);
	Messages::TWMEnterIdle __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property int Source = {read=FSource, write=FSource, nodefault};
	__property HWND IdleWnd = {read=FIdleWnd, write=FIdleWnd, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMEnterIdleWrapper(void) { }
	
};


class DELPHICLASS TWMEnterMenuLoopWrapper;
class PASCALIMPLEMENTATION TWMEnterMenuLoopWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	BOOL FIsTrackPopupMenu;
	int FUnused;
	int FResult;
	
public:
	__fastcall TWMEnterMenuLoopWrapper(const Messages::TWMEnterMenuLoop &ARecord);
	Messages::TWMEnterMenuLoop __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property BOOL IsTrackPopupMenu = {read=FIsTrackPopupMenu, write=FIsTrackPopupMenu, nodefault};
	__property int Unused = {read=FUnused, write=FUnused, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMEnterMenuLoopWrapper(void) { }
	
};


class DELPHICLASS TWMEraseBkgndWrapper;
class PASCALIMPLEMENTATION TWMEraseBkgndWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	HDC FDC;
	int FUnused;
	int FResult;
	
public:
	__fastcall TWMEraseBkgndWrapper(const Messages::TWMEraseBkgnd &ARecord);
	Messages::TWMEraseBkgnd __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property HDC DC = {read=FDC, write=FDC, nodefault};
	__property int Unused = {read=FUnused, write=FUnused, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMEraseBkgndWrapper(void) { }
	
};


class DELPHICLASS TWMGetIconWrapper;
class PASCALIMPLEMENTATION TWMGetIconWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	BOOL FBigIcon;
	int FUnused;
	int FResult;
	
public:
	__fastcall TWMGetIconWrapper(const Messages::TWMGetIcon &ARecord);
	Messages::TWMGetIcon __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property BOOL BigIcon = {read=FBigIcon, write=FBigIcon, nodefault};
	__property int Unused = {read=FUnused, write=FUnused, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMGetIconWrapper(void) { }
	
};


class DELPHICLASS TWMGetMinMaxInfoWrapper;
class PASCALIMPLEMENTATION TWMGetMinMaxInfoWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	int FUnused;
	int FResult;
	
public:
	__fastcall TWMGetMinMaxInfoWrapper(const Messages::TWMGetMinMaxInfo &ARecord);
	Messages::TWMGetMinMaxInfo __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property int Unused = {read=FUnused, write=FUnused, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMGetMinMaxInfoWrapper(void) { }
	
};


class DELPHICLASS TWMGetTextWrapper;
class PASCALIMPLEMENTATION TWMGetTextWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	int FTextMax;
	int FResult;
	
public:
	__fastcall TWMGetTextWrapper(const Messages::TWMGetText &ARecord);
	Messages::TWMGetText __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property int TextMax = {read=FTextMax, write=FTextMax, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMGetTextWrapper(void) { }
	
};


class DELPHICLASS TWMHotKeyWrapper;
class PASCALIMPLEMENTATION TWMHotKeyWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	int FHotKey;
	int FUnused;
	int FResult;
	
public:
	__fastcall TWMHotKeyWrapper(const Messages::TWMHotKey &ARecord);
	Messages::TWMHotKey __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property int HotKey = {read=FHotKey, write=FHotKey, nodefault};
	__property int Unused = {read=FUnused, write=FUnused, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMHotKeyWrapper(void) { }
	
};


class DELPHICLASS TWMHScrollClipboardWrapper;
class PASCALIMPLEMENTATION TWMHScrollClipboardWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	HWND FViewer;
	System::Word FScrollCode;
	System::Word FPos;
	int FResult;
	
public:
	__fastcall TWMHScrollClipboardWrapper(const Messages::TWMHScrollClipboard &ARecord);
	Messages::TWMHScrollClipboard __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property HWND Viewer = {read=FViewer, write=FViewer, nodefault};
	__property System::Word ScrollCode = {read=FScrollCode, write=FScrollCode, nodefault};
	__property System::Word Pos = {read=FPos, write=FPos, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMHScrollClipboardWrapper(void) { }
	
};


class DELPHICLASS TWMInitDialogWrapper;
class PASCALIMPLEMENTATION TWMInitDialogWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	HWND FFocus;
	int FInitParam;
	int FResult;
	
public:
	__fastcall TWMInitDialogWrapper(const Messages::TWMInitDialog &ARecord);
	Messages::TWMInitDialog __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property HWND Focus = {read=FFocus, write=FFocus, nodefault};
	__property int InitParam = {read=FInitParam, write=FInitParam, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMInitDialogWrapper(void) { }
	
};


class DELPHICLASS TWMInitMenuWrapper;
class PASCALIMPLEMENTATION TWMInitMenuWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	HMENU FMenu;
	int FUnused;
	int FResult;
	
public:
	__fastcall TWMInitMenuWrapper(const Messages::TWMInitMenu &ARecord);
	Messages::TWMInitMenu __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property HMENU Menu = {read=FMenu, write=FMenu, nodefault};
	__property int Unused = {read=FUnused, write=FUnused, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMInitMenuWrapper(void) { }
	
};


class DELPHICLASS TWMInitMenuPopupWrapper;
class PASCALIMPLEMENTATION TWMInitMenuPopupWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	HMENU FMenuPopup;
	short FPos;
	System::WordBool FSystemMenu;
	int FResult;
	
public:
	__fastcall TWMInitMenuPopupWrapper(const Messages::TWMInitMenuPopup &ARecord);
	Messages::TWMInitMenuPopup __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property HMENU MenuPopup = {read=FMenuPopup, write=FMenuPopup, nodefault};
	__property short Pos = {read=FPos, write=FPos, nodefault};
	__property System::WordBool SystemMenu = {read=FSystemMenu, write=FSystemMenu, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMInitMenuPopupWrapper(void) { }
	
};


class DELPHICLASS TWMKillFocusWrapper;
class PASCALIMPLEMENTATION TWMKillFocusWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	HWND FFocusedWnd;
	int FUnused;
	int FResult;
	
public:
	__fastcall TWMKillFocusWrapper(const Messages::TWMKillFocus &ARecord);
	Messages::TWMKillFocus __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property HWND FocusedWnd = {read=FFocusedWnd, write=FFocusedWnd, nodefault};
	__property int Unused = {read=FUnused, write=FUnused, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMKillFocusWrapper(void) { }
	
};


class DELPHICLASS TWMMDIActivateWrapper;
class PASCALIMPLEMENTATION TWMMDIActivateWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	HWND FChildWnd;
	HWND FDeactiveWnd;
	HWND FActiveWnd;
	int FResult;
	
public:
	__fastcall TWMMDIActivateWrapper(const Messages::TWMMDIActivate &ARecord);
	Messages::TWMMDIActivate __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property HWND ChildWnd = {read=FChildWnd, write=FChildWnd, nodefault};
	__property HWND DeactiveWnd = {read=FDeactiveWnd, write=FDeactiveWnd, nodefault};
	__property HWND ActiveWnd = {read=FActiveWnd, write=FActiveWnd, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMMDIActivateWrapper(void) { }
	
};


class DELPHICLASS TWMMDICascadeWrapper;
class PASCALIMPLEMENTATION TWMMDICascadeWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	int FCascade;
	int FUnused;
	int FResult;
	
public:
	__fastcall TWMMDICascadeWrapper(const Messages::TWMMDICascade &ARecord);
	Messages::TWMMDICascade __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property int Cascade = {read=FCascade, write=FCascade, nodefault};
	__property int Unused = {read=FUnused, write=FUnused, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMMDICascadeWrapper(void) { }
	
};


class DELPHICLASS TWMMDICreateWrapper;
class PASCALIMPLEMENTATION TWMMDICreateWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	int FUnused;
	int FResult;
	
public:
	__fastcall TWMMDICreateWrapper(const Messages::TWMMDICreate &ARecord);
	Messages::TWMMDICreate __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property int Unused = {read=FUnused, write=FUnused, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMMDICreateWrapper(void) { }
	
};


class DELPHICLASS TWMMDIDestroyWrapper;
class PASCALIMPLEMENTATION TWMMDIDestroyWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	HWND FChild;
	int FUnused;
	int FResult;
	
public:
	__fastcall TWMMDIDestroyWrapper(const Messages::TWMMDIDestroy &ARecord);
	Messages::TWMMDIDestroy __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property HWND Child = {read=FChild, write=FChild, nodefault};
	__property int Unused = {read=FUnused, write=FUnused, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMMDIDestroyWrapper(void) { }
	
};


class DELPHICLASS TWMMDIMaximizeWrapper;
class PASCALIMPLEMENTATION TWMMDIMaximizeWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	HWND FMaximize;
	int FUnused;
	int FResult;
	
public:
	__fastcall TWMMDIMaximizeWrapper(const Messages::TWMMDIMaximize &ARecord);
	Messages::TWMMDIMaximize __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property HWND Maximize = {read=FMaximize, write=FMaximize, nodefault};
	__property int Unused = {read=FUnused, write=FUnused, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMMDIMaximizeWrapper(void) { }
	
};


class DELPHICLASS TWMMDINextWrapper;
class PASCALIMPLEMENTATION TWMMDINextWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	HWND FChild;
	int FNext;
	int FResult;
	
public:
	__fastcall TWMMDINextWrapper(const Messages::TWMMDINext &ARecord);
	Messages::TWMMDINext __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property HWND Child = {read=FChild, write=FChild, nodefault};
	__property int Next = {read=FNext, write=FNext, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMMDINextWrapper(void) { }
	
};


class DELPHICLASS TWMMDIRestoreWrapper;
class PASCALIMPLEMENTATION TWMMDIRestoreWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	HWND FIDChild;
	int FUnused;
	int FResult;
	
public:
	__fastcall TWMMDIRestoreWrapper(const Messages::TWMMDIRestore &ARecord);
	Messages::TWMMDIRestore __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property HWND IDChild = {read=FIDChild, write=FIDChild, nodefault};
	__property int Unused = {read=FUnused, write=FUnused, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMMDIRestoreWrapper(void) { }
	
};


class DELPHICLASS TWMMDISetMenuWrapper;
class PASCALIMPLEMENTATION TWMMDISetMenuWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	HMENU FMenuFrame;
	HMENU FMenuWindow;
	int FResult;
	
public:
	__fastcall TWMMDISetMenuWrapper(const Messages::TWMMDISetMenu &ARecord);
	Messages::TWMMDISetMenu __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property HMENU MenuFrame = {read=FMenuFrame, write=FMenuFrame, nodefault};
	__property HMENU MenuWindow = {read=FMenuWindow, write=FMenuWindow, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMMDISetMenuWrapper(void) { }
	
};


class DELPHICLASS TWMMDITileWrapper;
class PASCALIMPLEMENTATION TWMMDITileWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	int FTile;
	int FUnused;
	int FResult;
	
public:
	__fastcall TWMMDITileWrapper(const Messages::TWMMDITile &ARecord);
	Messages::TWMMDITile __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property int Tile = {read=FTile, write=FTile, nodefault};
	__property int Unused = {read=FUnused, write=FUnused, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMMDITileWrapper(void) { }
	
};


class DELPHICLASS TWMMeasureItemWrapper;
class PASCALIMPLEMENTATION TWMMeasureItemWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	HWND FIDCtl;
	int FResult;
	
public:
	__fastcall TWMMeasureItemWrapper(const Messages::TWMMeasureItem &ARecord);
	Messages::TWMMeasureItem __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property HWND IDCtl = {read=FIDCtl, write=FIDCtl, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMMeasureItemWrapper(void) { }
	
};


class DELPHICLASS TWMMenuCharWrapper;
class PASCALIMPLEMENTATION TWMMenuCharWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	System::WideChar FUser;
	System::Word FMenuFlag;
	HMENU FMenu;
	int FResult;
	
public:
	__fastcall TWMMenuCharWrapper(const Messages::TWMMenuChar &ARecord);
	Messages::TWMMenuChar __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property System::WideChar User = {read=FUser, write=FUser, nodefault};
	__property System::Word MenuFlag = {read=FMenuFlag, write=FMenuFlag, nodefault};
	__property HMENU Menu = {read=FMenu, write=FMenu, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMMenuCharWrapper(void) { }
	
};


class DELPHICLASS TWMMenuSelectWrapper;
class PASCALIMPLEMENTATION TWMMenuSelectWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	System::Word FIDItem;
	System::Word FMenuFlag;
	HMENU FMenu;
	int FResult;
	
public:
	__fastcall TWMMenuSelectWrapper(const Messages::TWMMenuSelect &ARecord);
	Messages::TWMMenuSelect __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property System::Word IDItem = {read=FIDItem, write=FIDItem, nodefault};
	__property System::Word MenuFlag = {read=FMenuFlag, write=FMenuFlag, nodefault};
	__property HMENU Menu = {read=FMenu, write=FMenu, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMMenuSelectWrapper(void) { }
	
};


class DELPHICLASS TWMMouseActivateWrapper;
class PASCALIMPLEMENTATION TWMMouseActivateWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	HWND FTopLevel;
	System::Word FHitTestCode;
	System::Word FMouseMsg;
	int FResult;
	
public:
	__fastcall TWMMouseActivateWrapper(const Messages::TWMMouseActivate &ARecord);
	Messages::TWMMouseActivate __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property HWND TopLevel = {read=FTopLevel, write=FTopLevel, nodefault};
	__property System::Word HitTestCode = {read=FHitTestCode, write=FHitTestCode, nodefault};
	__property System::Word MouseMsg = {read=FMouseMsg, write=FMouseMsg, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMMouseActivateWrapper(void) { }
	
};


class DELPHICLASS TWMMoveWrapper;
class PASCALIMPLEMENTATION TWMMoveWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	int FUnused;
	short FXPos;
	short FYPos;
	int FResult;
	
public:
	__fastcall TWMMoveWrapper(const Messages::TWMMove &ARecord);
	Messages::TWMMove __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property int Unused = {read=FUnused, write=FUnused, nodefault};
	__property short XPos = {read=FXPos, write=FXPos, nodefault};
	__property short YPos = {read=FYPos, write=FYPos, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMMoveWrapper(void) { }
	
};


class DELPHICLASS TWMMovingWrapper;
class PASCALIMPLEMENTATION TWMMovingWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	int FEdge;
	
public:
	__fastcall TWMMovingWrapper(const Messages::TWMMoving &ARecord);
	Messages::TWMMoving __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property int Edge = {read=FEdge, write=FEdge, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMMovingWrapper(void) { }
	
};


class DELPHICLASS TWMNCActivateWrapper;
class PASCALIMPLEMENTATION TWMNCActivateWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	BOOL FActive;
	int FUnused;
	int FResult;
	
public:
	__fastcall TWMNCActivateWrapper(const Messages::TWMNCActivate &ARecord);
	Messages::TWMNCActivate __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property BOOL Active = {read=FActive, write=FActive, nodefault};
	__property int Unused = {read=FUnused, write=FUnused, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMNCActivateWrapper(void) { }
	
};


class DELPHICLASS TWMNCCalcSizeWrapper;
class PASCALIMPLEMENTATION TWMNCCalcSizeWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	BOOL FCalcValidRects;
	int FResult;
	
public:
	__fastcall TWMNCCalcSizeWrapper(const Messages::TWMNCCalcSize &ARecord);
	Messages::TWMNCCalcSize __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property BOOL CalcValidRects = {read=FCalcValidRects, write=FCalcValidRects, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMNCCalcSizeWrapper(void) { }
	
};


class DELPHICLASS TWMNCCreateWrapper;
class PASCALIMPLEMENTATION TWMNCCreateWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	int FUnused;
	int FResult;
	
public:
	__fastcall TWMNCCreateWrapper(const Messages::TWMNCCreate &ARecord);
	Messages::TWMNCCreate __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property int Unused = {read=FUnused, write=FUnused, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMNCCreateWrapper(void) { }
	
};


class DELPHICLASS TWMNCHitTestWrapper;
class PASCALIMPLEMENTATION TWMNCHitTestWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	int FUnused;
	short FXPos;
	short FYPos;
	int FResult;
	
public:
	__fastcall TWMNCHitTestWrapper(const Messages::TWMNCHitTest &ARecord);
	Messages::TWMNCHitTest __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property int Unused = {read=FUnused, write=FUnused, nodefault};
	__property short XPos = {read=FXPos, write=FXPos, nodefault};
	__property short YPos = {read=FYPos, write=FYPos, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMNCHitTestWrapper(void) { }
	
};


class DELPHICLASS TWMNCHitMessageWrapper;
class PASCALIMPLEMENTATION TWMNCHitMessageWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	int FHitTest;
	short FXCursor;
	short FYCursor;
	int FResult;
	
public:
	__fastcall TWMNCHitMessageWrapper(const Messages::TWMNCHitMessage &ARecord);
	Messages::TWMNCHitMessage __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property int HitTest = {read=FHitTest, write=FHitTest, nodefault};
	__property short XCursor = {read=FXCursor, write=FXCursor, nodefault};
	__property short YCursor = {read=FYCursor, write=FYCursor, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMNCHitMessageWrapper(void) { }
	
};


class DELPHICLASS TWMNCPaintWrapper;
class PASCALIMPLEMENTATION TWMNCPaintWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	HRGN FRGN;
	int FUnused;
	int FResult;
	
public:
	__fastcall TWMNCPaintWrapper(const Messages::TWMNCPaint &ARecord);
	Messages::TWMNCPaint __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property HRGN RGN = {read=FRGN, write=FRGN, nodefault};
	__property int Unused = {read=FUnused, write=FUnused, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMNCPaintWrapper(void) { }
	
};


class DELPHICLASS TWMNextDlgCtlWrapper;
class PASCALIMPLEMENTATION TWMNextDlgCtlWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	int FCtlFocus;
	System::WordBool FHandle;
	System::Word FUnused;
	int FResult;
	
public:
	__fastcall TWMNextDlgCtlWrapper(const Messages::TWMNextDlgCtl &ARecord);
	Messages::TWMNextDlgCtl __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property int CtlFocus = {read=FCtlFocus, write=FCtlFocus, nodefault};
	__property System::WordBool Handle = {read=FHandle, write=FHandle, nodefault};
	__property System::Word Unused = {read=FUnused, write=FUnused, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMNextDlgCtlWrapper(void) { }
	
};


class DELPHICLASS TWMNotifyWrapper;
class PASCALIMPLEMENTATION TWMNotifyWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	int FIDCtrl;
	int FResult;
	
public:
	__fastcall TWMNotifyWrapper(const Messages::TWMNotify &ARecord);
	Messages::TWMNotify __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property int IDCtrl = {read=FIDCtrl, write=FIDCtrl, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMNotifyWrapper(void) { }
	
};


class DELPHICLASS TWMNotifyFormatWrapper;
class PASCALIMPLEMENTATION TWMNotifyFormatWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	HWND FFrom;
	int FCommand;
	int FResult;
	
public:
	__fastcall TWMNotifyFormatWrapper(const Messages::TWMNotifyFormat &ARecord);
	Messages::TWMNotifyFormat __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property HWND From = {read=FFrom, write=FFrom, nodefault};
	__property int Command = {read=FCommand, write=FCommand, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMNotifyFormatWrapper(void) { }
	
};


class DELPHICLASS TWMPaintWrapper;
class PASCALIMPLEMENTATION TWMPaintWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	HDC FDC;
	int FUnused;
	int FResult;
	
public:
	__fastcall TWMPaintWrapper(const Messages::TWMPaint &ARecord);
	Messages::TWMPaint __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property HDC DC = {read=FDC, write=FDC, nodefault};
	__property int Unused = {read=FUnused, write=FUnused, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMPaintWrapper(void) { }
	
};


class DELPHICLASS TWMPaintClipboardWrapper;
class PASCALIMPLEMENTATION TWMPaintClipboardWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	HWND FViewer;
	unsigned FPaintStruct;
	int FResult;
	
public:
	__fastcall TWMPaintClipboardWrapper(const Messages::TWMPaintClipboard &ARecord);
	Messages::TWMPaintClipboard __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property HWND Viewer = {read=FViewer, write=FViewer, nodefault};
	__property unsigned PaintStruct = {read=FPaintStruct, write=FPaintStruct, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMPaintClipboardWrapper(void) { }
	
};


class DELPHICLASS TWMPaletteChangedWrapper;
class PASCALIMPLEMENTATION TWMPaletteChangedWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	HWND FPalChg;
	int FUnused;
	int FResult;
	
public:
	__fastcall TWMPaletteChangedWrapper(const Messages::TWMPaletteChanged &ARecord);
	Messages::TWMPaletteChanged __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property HWND PalChg = {read=FPalChg, write=FPalChg, nodefault};
	__property int Unused = {read=FUnused, write=FUnused, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMPaletteChangedWrapper(void) { }
	
};


class DELPHICLASS TWMPaletteIsChangingWrapper;
class PASCALIMPLEMENTATION TWMPaletteIsChangingWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	HWND FRealize;
	int FUnused;
	int FResult;
	
public:
	__fastcall TWMPaletteIsChangingWrapper(const Messages::TWMPaletteIsChanging &ARecord);
	Messages::TWMPaletteIsChanging __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property HWND Realize = {read=FRealize, write=FRealize, nodefault};
	__property int Unused = {read=FUnused, write=FUnused, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMPaletteIsChangingWrapper(void) { }
	
};


class DELPHICLASS TWMParentNotifyWrapper;
class PASCALIMPLEMENTATION TWMParentNotifyWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	System::Word FChildID;
	HWND FChildWnd;
	System::Word FValue;
	short FXPos;
	short FYPos;
	System::Word FValue1;
	int FValue2;
	int FResult;
	
public:
	__fastcall TWMParentNotifyWrapper(const Messages::TWMParentNotify &ARecord);
	Messages::TWMParentNotify __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property System::Word ChildID = {read=FChildID, write=FChildID, nodefault};
	__property HWND ChildWnd = {read=FChildWnd, write=FChildWnd, nodefault};
	__property System::Word Value = {read=FValue, write=FValue, nodefault};
	__property short XPos = {read=FXPos, write=FXPos, nodefault};
	__property short YPos = {read=FYPos, write=FYPos, nodefault};
	__property System::Word Value1 = {read=FValue1, write=FValue1, nodefault};
	__property int Value2 = {read=FValue2, write=FValue2, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMParentNotifyWrapper(void) { }
	
};


class DELPHICLASS TWMPowerWrapper;
class PASCALIMPLEMENTATION TWMPowerWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	int FPowerEvt;
	int FUnused;
	int FResult;
	
public:
	__fastcall TWMPowerWrapper(const Messages::TWMPower &ARecord);
	Messages::TWMPower __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property int PowerEvt = {read=FPowerEvt, write=FPowerEvt, nodefault};
	__property int Unused = {read=FUnused, write=FUnused, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMPowerWrapper(void) { }
	
};


class DELPHICLASS TWMQueryEndSessionWrapper;
class PASCALIMPLEMENTATION TWMQueryEndSessionWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	int FSource;
	int FUnused;
	int FResult;
	
public:
	__fastcall TWMQueryEndSessionWrapper(const Messages::TWMQueryEndSession &ARecord);
	Messages::TWMQueryEndSession __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property int Source = {read=FSource, write=FSource, nodefault};
	__property int Unused = {read=FUnused, write=FUnused, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMQueryEndSessionWrapper(void) { }
	
};


class DELPHICLASS TWMQuitWrapper;
class PASCALIMPLEMENTATION TWMQuitWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	int FExitCode;
	int FUnused;
	int FResult;
	
public:
	__fastcall TWMQuitWrapper(const Messages::TWMQuit &ARecord);
	Messages::TWMQuit __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property int ExitCode = {read=FExitCode, write=FExitCode, nodefault};
	__property int Unused = {read=FUnused, write=FUnused, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMQuitWrapper(void) { }
	
};


class DELPHICLASS TWMRenderFormatWrapper;
class PASCALIMPLEMENTATION TWMRenderFormatWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	int FFormat;
	int FUnused;
	int FResult;
	
public:
	__fastcall TWMRenderFormatWrapper(const Messages::TWMRenderFormat &ARecord);
	Messages::TWMRenderFormat __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property int Format = {read=FFormat, write=FFormat, nodefault};
	__property int Unused = {read=FUnused, write=FUnused, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMRenderFormatWrapper(void) { }
	
};


class DELPHICLASS TWMSetCursorWrapper;
class PASCALIMPLEMENTATION TWMSetCursorWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	HWND FCursorWnd;
	short FHitTest;
	System::Word FMouseMsg;
	int FResult;
	
public:
	__fastcall TWMSetCursorWrapper(const Messages::TWMSetCursor &ARecord);
	Messages::TWMSetCursor __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property HWND CursorWnd = {read=FCursorWnd, write=FCursorWnd, nodefault};
	__property short HitTest = {read=FHitTest, write=FHitTest, nodefault};
	__property System::Word MouseMsg = {read=FMouseMsg, write=FMouseMsg, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMSetCursorWrapper(void) { }
	
};


class DELPHICLASS TWMSetFocusWrapper;
class PASCALIMPLEMENTATION TWMSetFocusWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	HWND FFocusedWnd;
	int FUnused;
	int FResult;
	
public:
	__fastcall TWMSetFocusWrapper(const Messages::TWMSetFocus &ARecord);
	Messages::TWMSetFocus __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property HWND FocusedWnd = {read=FFocusedWnd, write=FFocusedWnd, nodefault};
	__property int Unused = {read=FUnused, write=FUnused, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMSetFocusWrapper(void) { }
	
};


class DELPHICLASS TWMSetFontWrapper;
class PASCALIMPLEMENTATION TWMSetFontWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	HFONT FFont;
	System::WordBool FRedraw;
	System::Word FUnused;
	int FResult;
	
public:
	__fastcall TWMSetFontWrapper(const Messages::TWMSetFont &ARecord);
	Messages::TWMSetFont __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property HFONT Font = {read=FFont, write=FFont, nodefault};
	__property System::WordBool Redraw = {read=FRedraw, write=FRedraw, nodefault};
	__property System::Word Unused = {read=FUnused, write=FUnused, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMSetFontWrapper(void) { }
	
};


class DELPHICLASS TWMSetHotKeyWrapper;
class PASCALIMPLEMENTATION TWMSetHotKeyWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	int FKey;
	int FUnused;
	int FResult;
	
public:
	__fastcall TWMSetHotKeyWrapper(const Messages::TWMSetHotKey &ARecord);
	Messages::TWMSetHotKey __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property int Key = {read=FKey, write=FKey, nodefault};
	__property int Unused = {read=FUnused, write=FUnused, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMSetHotKeyWrapper(void) { }
	
};


class DELPHICLASS TWMSetIconWrapper;
class PASCALIMPLEMENTATION TWMSetIconWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	BOOL FBigIcon;
	HICON FIcon;
	int FResult;
	
public:
	__fastcall TWMSetIconWrapper(const Messages::TWMSetIcon &ARecord);
	Messages::TWMSetIcon __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property BOOL BigIcon = {read=FBigIcon, write=FBigIcon, nodefault};
	__property HICON Icon = {read=FIcon, write=FIcon, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMSetIconWrapper(void) { }
	
};


class DELPHICLASS TWMSetRedrawWrapper;
class PASCALIMPLEMENTATION TWMSetRedrawWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	int FRedraw;
	int FUnused;
	int FResult;
	
public:
	__fastcall TWMSetRedrawWrapper(const Messages::TWMSetRedraw &ARecord);
	Messages::TWMSetRedraw __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property int Redraw = {read=FRedraw, write=FRedraw, nodefault};
	__property int Unused = {read=FUnused, write=FUnused, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMSetRedrawWrapper(void) { }
	
};


class DELPHICLASS TWMSetTextWrapper;
class PASCALIMPLEMENTATION TWMSetTextWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	int FUnused;
	int FResult;
	
public:
	__fastcall TWMSetTextWrapper(const Messages::TWMSetText &ARecord);
	Messages::TWMSetText __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property int Unused = {read=FUnused, write=FUnused, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMSetTextWrapper(void) { }
	
};


class DELPHICLASS TWMShowWindowWrapper;
class PASCALIMPLEMENTATION TWMShowWindowWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	BOOL FShow;
	int FStatus;
	int FResult;
	
public:
	__fastcall TWMShowWindowWrapper(const Messages::TWMShowWindow &ARecord);
	Messages::TWMShowWindow __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property BOOL Show = {read=FShow, write=FShow, nodefault};
	__property int Status = {read=FStatus, write=FStatus, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMShowWindowWrapper(void) { }
	
};


class DELPHICLASS TWMSizeWrapper;
class PASCALIMPLEMENTATION TWMSizeWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	int FSizeType;
	System::Word FWidth;
	System::Word FHeight;
	int FResult;
	
public:
	__fastcall TWMSizeWrapper(const Messages::TWMSize &ARecord);
	Messages::TWMSize __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property int SizeType = {read=FSizeType, write=FSizeType, nodefault};
	__property System::Word Width = {read=FWidth, write=FWidth, nodefault};
	__property System::Word Height = {read=FHeight, write=FHeight, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMSizeWrapper(void) { }
	
};


class DELPHICLASS TWMSizeClipboardWrapper;
class PASCALIMPLEMENTATION TWMSizeClipboardWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	HWND FViewer;
	unsigned FRC;
	int FResult;
	
public:
	__fastcall TWMSizeClipboardWrapper(const Messages::TWMSizeClipboard &ARecord);
	Messages::TWMSizeClipboard __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property HWND Viewer = {read=FViewer, write=FViewer, nodefault};
	__property unsigned RC = {read=FRC, write=FRC, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMSizeClipboardWrapper(void) { }
	
};


class DELPHICLASS TWMSpoolerStatusWrapper;
class PASCALIMPLEMENTATION TWMSpoolerStatusWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	int FJobStatus;
	System::Word FJobsLeft;
	System::Word FUnused;
	int FResult;
	
public:
	__fastcall TWMSpoolerStatusWrapper(const Messages::TWMSpoolerStatus &ARecord);
	Messages::TWMSpoolerStatus __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property int JobStatus = {read=FJobStatus, write=FJobStatus, nodefault};
	__property System::Word JobsLeft = {read=FJobsLeft, write=FJobsLeft, nodefault};
	__property System::Word Unused = {read=FUnused, write=FUnused, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMSpoolerStatusWrapper(void) { }
	
};


class DELPHICLASS TWMStyleChangeWrapper;
class PASCALIMPLEMENTATION TWMStyleChangeWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	int FStyleType;
	int FResult;
	
public:
	__fastcall TWMStyleChangeWrapper(const Messages::TWMStyleChange &ARecord);
	Messages::TWMStyleChange __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property int StyleType = {read=FStyleType, write=FStyleType, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMStyleChangeWrapper(void) { }
	
};


class DELPHICLASS TWMSysCommandWrapper;
class PASCALIMPLEMENTATION TWMSysCommandWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	HWND FActivateWnd;
	System::Word FKey;
	short FXPos;
	short FYPos;
	int FResult;
	
public:
	__fastcall TWMSysCommandWrapper(const Messages::TWMSysCommand &ARecord);
	Messages::TWMSysCommand __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property HWND ActivateWnd = {read=FActivateWnd, write=FActivateWnd, nodefault};
	__property System::Word Key = {read=FKey, write=FKey, nodefault};
	__property short XPos = {read=FXPos, write=FXPos, nodefault};
	__property short YPos = {read=FYPos, write=FYPos, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMSysCommandWrapper(void) { }
	
};


class DELPHICLASS TWMSysDeadCharWrapper;
class PASCALIMPLEMENTATION TWMSysDeadCharWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	System::Word FCharCode;
	System::Word FUnused;
	int FKeyData;
	int FResult;
	
public:
	__fastcall TWMSysDeadCharWrapper(const Messages::TWMSysDeadChar &ARecord);
	Messages::TWMSysDeadChar __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property System::Word CharCode = {read=FCharCode, write=FCharCode, nodefault};
	__property System::Word Unused = {read=FUnused, write=FUnused, nodefault};
	__property int KeyData = {read=FKeyData, write=FKeyData, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMSysDeadCharWrapper(void) { }
	
};


class DELPHICLASS TWMSystemErrorWrapper;
class PASCALIMPLEMENTATION TWMSystemErrorWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	System::Word FErrSpec;
	int FUnused;
	int FResult;
	
public:
	__fastcall TWMSystemErrorWrapper(const Messages::TWMSystemError &ARecord);
	Messages::TWMSystemError __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property System::Word ErrSpec = {read=FErrSpec, write=FErrSpec, nodefault};
	__property int Unused = {read=FUnused, write=FUnused, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMSystemErrorWrapper(void) { }
	
};


class DELPHICLASS TWMTimerWrapper;
class PASCALIMPLEMENTATION TWMTimerWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	int FTimerID;
	int FResult;
	
public:
	__fastcall TWMTimerWrapper(const Messages::TWMTimer &ARecord);
	Messages::TWMTimer __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property int TimerID = {read=FTimerID, write=FTimerID, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMTimerWrapper(void) { }
	
};


class DELPHICLASS TWMUIStateWrapper;
class PASCALIMPLEMENTATION TWMUIStateWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	System::Word FAction;
	System::Word FFlags;
	int FUnused;
	
public:
	__fastcall TWMUIStateWrapper(const Messages::TWMUIState &ARecord);
	Messages::TWMUIState __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property System::Word Action = {read=FAction, write=FAction, nodefault};
	__property System::Word Flags = {read=FFlags, write=FFlags, nodefault};
	__property int Unused = {read=FUnused, write=FUnused, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMUIStateWrapper(void) { }
	
};


class DELPHICLASS TWMVScrollClipboardWrapper;
class PASCALIMPLEMENTATION TWMVScrollClipboardWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	HWND FViewer;
	System::Word FScollCode;
	System::Word FThumbPos;
	int FResult;
	
public:
	__fastcall TWMVScrollClipboardWrapper(const Messages::TWMVScrollClipboard &ARecord);
	Messages::TWMVScrollClipboard __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property HWND Viewer = {read=FViewer, write=FViewer, nodefault};
	__property System::Word ScollCode = {read=FScollCode, write=FScollCode, nodefault};
	__property System::Word ThumbPos = {read=FThumbPos, write=FThumbPos, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMVScrollClipboardWrapper(void) { }
	
};


class DELPHICLASS TWMWinIniChangeWrapper;
class PASCALIMPLEMENTATION TWMWinIniChangeWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	int FUnused;
	int FResult;
	
public:
	__fastcall TWMWinIniChangeWrapper(const Messages::TWMWinIniChange &ARecord);
	Messages::TWMWinIniChange __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property int Unused = {read=FUnused, write=FUnused, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMWinIniChangeWrapper(void) { }
	
};


class DELPHICLASS TWMSettingChangeWrapper;
class PASCALIMPLEMENTATION TWMSettingChangeWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	int FFlag;
	int FResult;
	
public:
	__fastcall TWMSettingChangeWrapper(const Messages::TWMSettingChange &ARecord);
	Messages::TWMSettingChange __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property int Flag = {read=FFlag, write=FFlag, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMSettingChangeWrapper(void) { }
	
};


class DELPHICLASS TWMHelpWrapper;
class PASCALIMPLEMENTATION TWMHelpWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	int FUnused;
	int FResult;
	
public:
	__fastcall TWMHelpWrapper(const Messages::TWMHelp &ARecord);
	Messages::TWMHelp __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property int Unused = {read=FUnused, write=FUnused, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMHelpWrapper(void) { }
	
};


class DELPHICLASS TWMDisplayChangeWrapper;
class PASCALIMPLEMENTATION TWMDisplayChangeWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	int FBitsPerPixel;
	System::Word FWidth;
	System::Word FHeight;
	int FResult;
	
public:
	__fastcall TWMDisplayChangeWrapper(const Messages::TWMDisplayChange &ARecord);
	Messages::TWMDisplayChange __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property int BitsPerPixel = {read=FBitsPerPixel, write=FBitsPerPixel, nodefault};
	__property System::Word Width = {read=FWidth, write=FWidth, nodefault};
	__property System::Word Height = {read=FHeight, write=FHeight, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMDisplayChangeWrapper(void) { }
	
};


class DELPHICLASS TWMContextMenuWrapper;
class PASCALIMPLEMENTATION TWMContextMenuWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	HWND FhWnd;
	short FXPos;
	short FYPos;
	int FResult;
	
public:
	__fastcall TWMContextMenuWrapper(const Messages::TWMContextMenu &ARecord);
	Messages::TWMContextMenu __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property HWND hWnd = {read=FhWnd, write=FhWnd, nodefault};
	__property short XPos = {read=FXPos, write=FXPos, nodefault};
	__property short YPos = {read=FYPos, write=FYPos, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMContextMenuWrapper(void) { }
	
};


class DELPHICLASS TWMPrintWrapper;
class PASCALIMPLEMENTATION TWMPrintWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	HDC FDC;
	unsigned FFlags;
	int FResult;
	
public:
	__fastcall TWMPrintWrapper(const Messages::TWMPrint &ARecord);
	Messages::TWMPrint __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property HDC DC = {read=FDC, write=FDC, nodefault};
	__property unsigned Flags = {read=FFlags, write=FFlags, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMPrintWrapper(void) { }
	
};


class DELPHICLASS TWMGestureNotifyWrapper;
class PASCALIMPLEMENTATION TWMGestureNotifyWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	int FUnused;
	int FResult;
	
public:
	__fastcall TWMGestureNotifyWrapper(const Messages::TWMGestureNotify &ARecord);
	Messages::TWMGestureNotify __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property int Unused = {read=FUnused, write=FUnused, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TWMGestureNotifyWrapper(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Ap_messages */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Ap_messages;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Ap_messagesHPP
