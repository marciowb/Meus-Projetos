// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Macrorecorder.pas' rev: 21.00

#ifndef MacrorecorderHPP
#define MacrorecorderHPP

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
#include <Appevnts.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Macrorecorder
{
//-- type declarations -------------------------------------------------------
typedef tagEVENTMSG *PEventMsg;

typedef StaticArray<tagEVENTMSG, 20001> TMsgBuff;

typedef void __fastcall (__closure *TcbPlaybackFinishedProc)(int AppData);

typedef void __fastcall (__closure *TcbRecordFinishedProc)(System::TObject* Sender);

#pragma option push -b-
enum TRecordOption { roMouseMove, roMouseRelative };
#pragma option pop

typedef Set<TRecordOption, roMouseMove, roMouseRelative>  TRecordOptions;

#pragma option push -b-
enum TPlaybackSpeed { pbNormal, pbFast };
#pragma option pop

#pragma option push -b-
enum TRecordingRange { rrSystem, rrApplication };
#pragma option pop

class DELPHICLASS TMacroRecorder;
class PASCALIMPLEMENTATION TMacroRecorder : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	int FElapsedTime;
	Classes::TComponent* FOwner;
	bool FPlayback;
	System::UnicodeString FFileName;
	TcbPlaybackFinishedProc FOnPlaybackFinished;
	TPlaybackSpeed FPlaybackSpeed;
	Appevnts::TApplicationEvents* FApplicationEvents;
	Classes::TNotifyEvent FApplicationOnActivate;
	Classes::TNotifyEvent FApplicationOnDeActivate;
	TRecordingRange FRecordingRange;
	TRecordOptions FOptions;
	TcbRecordFinishedProc FOnRecordFinished;
	Classes::TNotifyEvent FOnRecordCancelled;
	Classes::TNotifyEvent FOnPlaybackCancelled;
	void __fastcall SetFileName(System::UnicodeString value);
	void __fastcall SetPlaybackSpeed(TPlaybackSpeed value);
	void __fastcall PlaybackFinished(int AppData);
	void __fastcall ApplicationOnActivate(System::TObject* Sender);
	void __fastcall ApplicationOnDeActivate(System::TObject* Sender);
	void __fastcall SetRecordingRange(TRecordingRange value);
	void __fastcall ApplicationEventsMessage(tagMSG &Msg, bool &Handled);
	System::UnicodeString __fastcall KeyToString(unsigned aCode);
	unsigned __fastcall StringToKey(System::UnicodeString S);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	
protected:
	virtual int __fastcall GetVersionNr(void);
	
public:
	__fastcall virtual TMacroRecorder(Classes::TComponent* AOwner);
	__fastcall virtual ~TMacroRecorder(void);
	bool __fastcall IsPlaying(void);
	bool __fastcall IsRecording(void);
	void __fastcall RecordMacro(void);
	void __fastcall StopRecording(void);
	void __fastcall StopPlayback(void);
	void __fastcall PlayMacro(void);
	void __fastcall SaveMacro(void);
	void __fastcall LoadMacro(void);
	__property int ElapsedTime = {read=FElapsedTime, write=FElapsedTime, nodefault};
	
__published:
	__property System::UnicodeString FileName = {read=FFileName, write=SetFileName};
	__property TPlaybackSpeed PlaybackSpeed = {read=FPlaybackSpeed, write=SetPlaybackSpeed, nodefault};
	__property TRecordingRange RecordingRange = {read=FRecordingRange, write=SetRecordingRange, nodefault};
	__property TcbPlaybackFinishedProc OnPlaybackFinished = {read=FOnPlaybackFinished, write=FOnPlaybackFinished};
	__property Classes::TNotifyEvent OnPlaybackCancelled = {read=FOnPlaybackCancelled, write=FOnPlaybackCancelled};
	__property TcbRecordFinishedProc OnRecordFinished = {read=FOnRecordFinished, write=FOnRecordFinished};
	__property Classes::TNotifyEvent OnRecordCancelled = {read=FOnRecordCancelled, write=FOnRecordCancelled};
	__property TRecordOptions Options = {read=FOptions, write=FOptions, nodefault};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
};


//-- var, const, procedure ---------------------------------------------------
static const Word MAXMSG = 0x4e20;
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x2;
static const ShortInt REL_VER = 0x1;
static const ShortInt BLD_VER = 0x0;
extern PACKAGE unsigned JHook;
extern PACKAGE TMsgBuff *PMsgBuff;
extern PACKAGE int StartTime;
extern PACKAGE int MsgCount;
extern PACKAGE int CurrentMsg;
extern PACKAGE BOOL ReportDelayTime;
extern PACKAGE BOOL SysModalOn;
extern PACKAGE TcbPlaybackFinishedProc cbPlaybackFinishedProc;
extern PACKAGE int cbAppData;
extern PACKAGE bool DoMouseMove;
extern PACKAGE bool DoRelative;
extern PACKAGE bool FHookStarted;
extern PACKAGE TPlaybackSpeed gPlaybackSpeed;
extern PACKAGE TRecordingRange gRecordingRange;
extern PACKAGE bool gOutOfRange;
extern PACKAGE bool gFirstEvent;
extern PACKAGE TMacroRecorder* RecorderInstance;
extern PACKAGE Types::TPoint pt;
extern PACKAGE int __stdcall JournalProc(int Code, int wParam, tagEVENTMSG &EventStrut);
extern PACKAGE int __stdcall JournalPlaybackProc(int Code, int wParam, tagEVENTMSG &EventStrut);

}	/* namespace Macrorecorder */
using namespace Macrorecorder;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// MacrorecorderHPP
