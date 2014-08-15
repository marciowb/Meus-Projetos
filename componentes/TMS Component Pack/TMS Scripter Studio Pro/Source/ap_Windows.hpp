// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ap_Windows.pas' rev: 22.00

#ifndef Ap_windowsHPP
#define Ap_windowsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit
#include <ap_Types.hpp>	// Pascal unit
#include <atScript.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Ap_windows
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TatWindowsLibrary;
class PASCALIMPLEMENTATION TatWindowsLibrary : public Atscript::TatScripterLibrary
{
	typedef Atscript::TatScripterLibrary inherited;
	
public:
	void __fastcall __MAKELANGID(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __PRIMARYLANGID(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SUBLANGID(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __MAKELCID(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __MAKESORTLCID(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __LANGIDFROMLCID(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SORTIDFROMLCID(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SORTVERSIONFROMLCID(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetCurrentTime(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __FreeModule(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __InterlockedCompareExchange(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __InterlockedExchangeAdd(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __FreeLibrary(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetVersion(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GlobalMemoryStatusEx(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetLongPathName(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetLongPathNameA(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetLongPathNameW(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetLongPathNameTransacted(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetLongPathNameTransactedA(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetLongPathNameTransactedW(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetProcessHandleCount(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __ExitProcess(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetThreadIOPendingFlag(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __ExitThread(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __CheckRemoteDebuggerPresent(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __LockFile(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __UnlockFile(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetFileType(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __FindClose(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __CloseHandle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetSystemRegistryQuota(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetSystemTimes(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetNativeSystemInfo(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetDynamicTimeZoneInformation(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetDynamicTimeZoneInformation(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __FileTimeToLocalFileTime(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __FileTimeToSystemTime(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __FileTimeToDosDateTime(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTickCount(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __OpenFile(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __UnregisterWait(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __UnregisterWaitEx(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __WT_SET_MAX_THREADPOOL_THREADS(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __CreateTimerQueue(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __ChangeTimerQueueTimer(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __DeleteTimerQueueTimer(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __DeleteTimerQueueEx(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __CancelTimerQueueTimer(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __DeleteTimerQueue(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __LoadLibrary(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetCommandLine(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __IsDebuggerPresent(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __FindResource(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetCurrentDirectory(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetCurrentDirectory(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetDllDirectory(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetDllDirectoryA(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetDllDirectoryW(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetDllDirectory(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetDllDirectoryA(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetDllDirectoryW(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __RemoveDirectory(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __RemoveDirectoryTransacted(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __RemoveDirectoryTransactedA(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __RemoveDirectoryTransactedW(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetFullPathNameTransacted(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetFullPathNameTransactedA(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetFullPathNameTransactedW(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetFileAttributesTransacted(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetFileAttributesTransactedA(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetFileAttributesTransactedW(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetFileAttributes(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __DeleteFile(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __DeleteFileTransacted(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __DeleteFileTransactedA(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __DeleteFileTransactedW(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __FindFirstFile(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __FindNextFile(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __CopyFile(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __MoveFile(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __MoveFileTransacted(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __MoveFileTransactedA(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __MoveFileTransactedW(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __CreateHardLinkTransacted(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __CreateHardLinkTransactedA(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __CreateHardLinkTransactedW(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __CreateSymbolicLink(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __CreateSymbolicLinkA(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __CreateSymbolicLinkW(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __CreateSymbolicLinkTransacted(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __CreateSymbolicLinkTransactedA(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __CreateSymbolicLinkTransactedW(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetFinalPathNameByHandle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetFinalPathNameByHandleA(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetFinalPathNameByHandleW(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __AdjustTokenPrivileges(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetComputerNameEx(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetComputerNameExA(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetComputerNameExW(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __VerifyVersionInfo(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __VerifyVersionInfoA(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __VerifyVersionInfoW(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __CopyMetaFile(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetRandomRgn(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __CopyEnhMetaFile(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __EndPath(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __OffsetViewportOrgEx(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __OffsetWindowOrgEx(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GET_APPCOMMAND_LPARAM(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GET_DEVICE_LPARAM(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GET_MOUSEORKEY_LPARAM(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GET_FLAGS_LPARAM(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GET_KEYSTATE_LPARAM(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetMouseMovePointsEx(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __PointToLParam(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __ExitWindows(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __FlashWindow(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __CloseWindow(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetWindowPlacement(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetWindowPlacement(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetWindowDisplayAffinity(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetWindowDisplayAffinity(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __EndDialog(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __OpenClipboard(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __CloseClipboard(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetClipboardFormatName(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __AddClipboardFormatListener(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __RemoveClipboardFormatListener(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __CharToOem(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __CharToOemA(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __CharToOemW(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __OemToChar(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __CharToOemBuff(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __CharToOemBuffA(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __CharToOemBuffW(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __CharUpper(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __CharUpperA(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __CharUpperW(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __CharUpperBuff(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __CharUpperBuffA(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __CharUpperBuffW(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __CharLower(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __CharLowerA(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __CharLowerW(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __CharLowerBuff(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __CharLowerBuffA(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __CharLowerBuffW(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __CharNext(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __CharNextA(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __CharNextW(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __CharPrev(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __CharPrevA(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __CharPrevW(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __CharNextExA(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __CharNextEx(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __CharPrevEx(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __CharPrevExA(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __AnsiToOem(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __OemToAnsi(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __AnsiToOemBuff(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __AnsiUpper(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __AnsiUpperBuff(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __AnsiLower(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __AnsiLowerBuff(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __AnsiNext(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __AnsiPrev(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __CloseTouchInputHandle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __RegisterTouchWindow(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __UnregisterTouchWindow(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __CalculatePopupWindowPosition(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetWindowDC(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __InvalidateRect(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __ValidateRect(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __RedrawWindow(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __MessageBox(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __MessageBoxEx(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __MessageBeep(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetPhysicalCursorPos(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetPhysicalCursorPos(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetCaretPos(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __ClientToScreen(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __ScreenToClient(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __LogicalToPhysicalPoint(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __PhysicalToLogicalPoint(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __WindowFromPhysicalPoint(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __FrameRect(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __CopyRect(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __FindWindow(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetWindowThreadProcessId(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __CopyImage(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __CopyIcon(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __LoadString(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __HtmlHelp(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __HtmlHelpA(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __HtmlHelpW(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SystemParametersInfo(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __BlockInput(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetProcessDPIAware(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __IsProcessDPIAware(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetCPInfoEx(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetCPInfoExA(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetCPInfoExW(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __LCIDToLocaleName(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __LocaleNameToLCID(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetLocaleInfoEx(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __FoldString(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __RegOverridePredefKey(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __RegOpenUserClassesRoot(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __RegOpenCurrentUser(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __RegDisablePredefinedCache(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetWindowLongPtr(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetWindowLongPtr(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetWindowLongPtrA(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetWindowLongPtrA(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetWindowLongPtrW(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetWindowLongPtrW(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GID_ROTATE_ANGLE_TO_ARGUMENT(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GID_ROTATE_ANGLE_FROM_ARGUMENT(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetGestureInfo(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __CloseGestureInfoHandle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __RotateAngleFromArgument(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __InertiaVectorFromArgument(Atscript::TatVirtualMachine* AMachine);
	virtual void __fastcall Init(void);
	__classmethod virtual System::UnicodeString __fastcall LibraryName();
public:
	/* TatScripterLibrary.Create */ inline __fastcall virtual TatWindowsLibrary(Atscript::TatCustomScripter* AScripter) : Atscript::TatScripterLibrary(AScripter) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TatWindowsLibrary(void) { }
	
};


class DELPHICLASS _LARGE_INTEGERWrapper;
class PASCALIMPLEMENTATION _LARGE_INTEGERWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FLowPart;
	int FHighPart;
	__int64 FQuadPart;
	
public:
	__fastcall _LARGE_INTEGERWrapper(const _LARGE_INTEGER &ARecord);
	_LARGE_INTEGER __fastcall ObjToRec(void);
	
__published:
	__property unsigned LowPart = {read=FLowPart, write=FLowPart, nodefault};
	__property int HighPart = {read=FHighPart, write=FHighPart, nodefault};
	__property __int64 QuadPart = {read=FQuadPart, write=FQuadPart};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_LARGE_INTEGERWrapper(void) { }
	
};


class DELPHICLASS ULARGE_INTEGERWrapper;
class PASCALIMPLEMENTATION ULARGE_INTEGERWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FLowPart;
	unsigned FHighPart;
	unsigned __int64 FQuadPart;
	
public:
	__fastcall ULARGE_INTEGERWrapper(const ULARGE_INTEGER &ARecord);
	ULARGE_INTEGER __fastcall ObjToRec(void);
	
__published:
	__property unsigned LowPart = {read=FLowPart, write=FLowPart, nodefault};
	__property unsigned HighPart = {read=FHighPart, write=FHighPart, nodefault};
	__property unsigned __int64 QuadPart = {read=FQuadPart, write=FQuadPart};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~ULARGE_INTEGERWrapper(void) { }
	
};


class DELPHICLASS _LIST_ENTRYWrapper;
class PASCALIMPLEMENTATION _LIST_ENTRYWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
public:
	__fastcall _LIST_ENTRYWrapper(const _LIST_ENTRY &ARecord);
	_LIST_ENTRY __fastcall ObjToRec(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_LIST_ENTRYWrapper(void) { }
	
};


class DELPHICLASS _FLOATING_SAVE_AREAWrapper;
class PASCALIMPLEMENTATION _FLOATING_SAVE_AREAWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FControlWord;
	unsigned FStatusWord;
	unsigned FTagWord;
	unsigned FErrorOffset;
	unsigned FErrorSelector;
	unsigned FDataOffset;
	unsigned FDataSelector;
	unsigned FCr0NpxState;
	
public:
	__fastcall _FLOATING_SAVE_AREAWrapper(const _FLOATING_SAVE_AREA &ARecord);
	_FLOATING_SAVE_AREA __fastcall ObjToRec(void);
	
__published:
	__property unsigned ControlWord = {read=FControlWord, write=FControlWord, nodefault};
	__property unsigned StatusWord = {read=FStatusWord, write=FStatusWord, nodefault};
	__property unsigned TagWord = {read=FTagWord, write=FTagWord, nodefault};
	__property unsigned ErrorOffset = {read=FErrorOffset, write=FErrorOffset, nodefault};
	__property unsigned ErrorSelector = {read=FErrorSelector, write=FErrorSelector, nodefault};
	__property unsigned DataOffset = {read=FDataOffset, write=FDataOffset, nodefault};
	__property unsigned DataSelector = {read=FDataSelector, write=FDataSelector, nodefault};
	__property unsigned Cr0NpxState = {read=FCr0NpxState, write=FCr0NpxState, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_FLOATING_SAVE_AREAWrapper(void) { }
	
};


class DELPHICLASS _CONTEXTWrapper;
class PASCALIMPLEMENTATION _CONTEXTWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FContextFlags;
	unsigned FDr0;
	unsigned FDr1;
	unsigned FDr2;
	unsigned FDr3;
	unsigned FDr6;
	unsigned FDr7;
	unsigned FSegGs;
	unsigned FSegFs;
	unsigned FSegEs;
	unsigned FSegDs;
	unsigned FEdi;
	unsigned FEsi;
	unsigned FEbx;
	unsigned FEdx;
	unsigned FEcx;
	unsigned FEax;
	unsigned FEbp;
	unsigned FEip;
	unsigned FSegCs;
	unsigned FEFlags;
	unsigned FEsp;
	unsigned FSegSs;
	
public:
	__fastcall _CONTEXTWrapper(const _CONTEXT &ARecord);
	_CONTEXT __fastcall ObjToRec(void);
	
__published:
	__property unsigned ContextFlags = {read=FContextFlags, write=FContextFlags, nodefault};
	__property unsigned Dr0 = {read=FDr0, write=FDr0, nodefault};
	__property unsigned Dr1 = {read=FDr1, write=FDr1, nodefault};
	__property unsigned Dr2 = {read=FDr2, write=FDr2, nodefault};
	__property unsigned Dr3 = {read=FDr3, write=FDr3, nodefault};
	__property unsigned Dr6 = {read=FDr6, write=FDr6, nodefault};
	__property unsigned Dr7 = {read=FDr7, write=FDr7, nodefault};
	__property unsigned SegGs = {read=FSegGs, write=FSegGs, nodefault};
	__property unsigned SegFs = {read=FSegFs, write=FSegFs, nodefault};
	__property unsigned SegEs = {read=FSegEs, write=FSegEs, nodefault};
	__property unsigned SegDs = {read=FSegDs, write=FSegDs, nodefault};
	__property unsigned Edi = {read=FEdi, write=FEdi, nodefault};
	__property unsigned Esi = {read=FEsi, write=FEsi, nodefault};
	__property unsigned Ebx = {read=FEbx, write=FEbx, nodefault};
	__property unsigned Edx = {read=FEdx, write=FEdx, nodefault};
	__property unsigned Ecx = {read=FEcx, write=FEcx, nodefault};
	__property unsigned Eax = {read=FEax, write=FEax, nodefault};
	__property unsigned Ebp = {read=FEbp, write=FEbp, nodefault};
	__property unsigned Eip = {read=FEip, write=FEip, nodefault};
	__property unsigned SegCs = {read=FSegCs, write=FSegCs, nodefault};
	__property unsigned EFlags = {read=FEFlags, write=FEFlags, nodefault};
	__property unsigned Esp = {read=FEsp, write=FEsp, nodefault};
	__property unsigned SegSs = {read=FSegSs, write=FSegSs, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_CONTEXTWrapper(void) { }
	
};


class DELPHICLASS _LDT_ENTRYWrapper;
class PASCALIMPLEMENTATION _LDT_ENTRYWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	System::Word FLimitLow;
	System::Word FBaseLow;
	System::Byte FBaseMid;
	System::Byte FFlags1;
	System::Byte FFlags2;
	System::Byte FBaseHi;
	int FFlags;
	
public:
	__fastcall _LDT_ENTRYWrapper(const _LDT_ENTRY &ARecord);
	_LDT_ENTRY __fastcall ObjToRec(void);
	
__published:
	__property System::Word LimitLow = {read=FLimitLow, write=FLimitLow, nodefault};
	__property System::Word BaseLow = {read=FBaseLow, write=FBaseLow, nodefault};
	__property System::Byte BaseMid = {read=FBaseMid, write=FBaseMid, nodefault};
	__property System::Byte Flags1 = {read=FFlags1, write=FFlags1, nodefault};
	__property System::Byte Flags2 = {read=FFlags2, write=FFlags2, nodefault};
	__property System::Byte BaseHi = {read=FBaseHi, write=FBaseHi, nodefault};
	__property int Flags = {read=FFlags, write=FFlags, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_LDT_ENTRYWrapper(void) { }
	
};


class DELPHICLASS _EXCEPTION_RECORDWrapper;
class PASCALIMPLEMENTATION _EXCEPTION_RECORDWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FExceptionCode;
	unsigned FExceptionFlags;
	unsigned FNumberParameters;
	
public:
	__fastcall _EXCEPTION_RECORDWrapper(const _EXCEPTION_RECORD &ARecord);
	_EXCEPTION_RECORD __fastcall ObjToRec(void);
	
__published:
	__property unsigned ExceptionCode = {read=FExceptionCode, write=FExceptionCode, nodefault};
	__property unsigned ExceptionFlags = {read=FExceptionFlags, write=FExceptionFlags, nodefault};
	__property unsigned NumberParameters = {read=FNumberParameters, write=FNumberParameters, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_EXCEPTION_RECORDWrapper(void) { }
	
};


class DELPHICLASS _EXCEPTION_POINTERSWrapper;
class PASCALIMPLEMENTATION _EXCEPTION_POINTERSWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
public:
	__fastcall _EXCEPTION_POINTERSWrapper(const _EXCEPTION_POINTERS &ARecord);
	_EXCEPTION_POINTERS __fastcall ObjToRec(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_EXCEPTION_POINTERSWrapper(void) { }
	
};


class DELPHICLASS _MEMORY_BASIC_INFORMATIONWrapper;
class PASCALIMPLEMENTATION _MEMORY_BASIC_INFORMATIONWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FAllocationProtect;
	unsigned FRegionSize;
	unsigned FState;
	unsigned FProtect;
	unsigned FType_9;
	
public:
	__fastcall _MEMORY_BASIC_INFORMATIONWrapper(const _MEMORY_BASIC_INFORMATION &ARecord);
	_MEMORY_BASIC_INFORMATION __fastcall ObjToRec(void);
	
__published:
	__property unsigned AllocationProtect = {read=FAllocationProtect, write=FAllocationProtect, nodefault};
	__property unsigned RegionSize = {read=FRegionSize, write=FRegionSize, nodefault};
	__property unsigned State = {read=FState, write=FState, nodefault};
	__property unsigned Protect = {read=FProtect, write=FProtect, nodefault};
	__property unsigned Type_9 = {read=FType_9, write=FType_9, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_MEMORY_BASIC_INFORMATIONWrapper(void) { }
	
};


class DELPHICLASS _GENERIC_MAPPINGWrapper;
class PASCALIMPLEMENTATION _GENERIC_MAPPINGWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FGenericRead;
	unsigned FGenericWrite;
	unsigned FGenericExecute;
	unsigned FGenericAll;
	
public:
	__fastcall _GENERIC_MAPPINGWrapper(const _GENERIC_MAPPING &ARecord);
	_GENERIC_MAPPING __fastcall ObjToRec(void);
	
__published:
	__property unsigned GenericRead = {read=FGenericRead, write=FGenericRead, nodefault};
	__property unsigned GenericWrite = {read=FGenericWrite, write=FGenericWrite, nodefault};
	__property unsigned GenericExecute = {read=FGenericExecute, write=FGenericExecute, nodefault};
	__property unsigned GenericAll = {read=FGenericAll, write=FGenericAll, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_GENERIC_MAPPINGWrapper(void) { }
	
};


class DELPHICLASS _LUIDWrapper;
class PASCALIMPLEMENTATION _LUIDWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FLowPart;
	int FHighPart;
	
public:
	__fastcall _LUIDWrapper(const _LUID &ARecord);
	_LUID __fastcall ObjToRec(void);
	
__published:
	__property unsigned LowPart = {read=FLowPart, write=FLowPart, nodefault};
	__property int HighPart = {read=FHighPart, write=FHighPart, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_LUIDWrapper(void) { }
	
};


class DELPHICLASS _LUID_AND_ATTRIBUTESWrapper;
class PASCALIMPLEMENTATION _LUID_AND_ATTRIBUTESWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	__int64 FLuid;
	unsigned FAttributes;
	
public:
	__fastcall _LUID_AND_ATTRIBUTESWrapper(const _LUID_AND_ATTRIBUTES &ARecord);
	_LUID_AND_ATTRIBUTES __fastcall ObjToRec(void);
	
__published:
	__property __int64 Luid = {read=FLuid, write=FLuid};
	__property unsigned Attributes = {read=FAttributes, write=FAttributes, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_LUID_AND_ATTRIBUTESWrapper(void) { }
	
};


class DELPHICLASS _SID_IDENTIFIER_AUTHORITYWrapper;
class PASCALIMPLEMENTATION _SID_IDENTIFIER_AUTHORITYWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
public:
	__fastcall _SID_IDENTIFIER_AUTHORITYWrapper(const _SID_IDENTIFIER_AUTHORITY &ARecord);
	_SID_IDENTIFIER_AUTHORITY __fastcall ObjToRec(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_SID_IDENTIFIER_AUTHORITYWrapper(void) { }
	
};


class DELPHICLASS _SID_AND_ATTRIBUTESWrapper;
class PASCALIMPLEMENTATION _SID_AND_ATTRIBUTESWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FAttributes;
	
public:
	__fastcall _SID_AND_ATTRIBUTESWrapper(const _SID_AND_ATTRIBUTES &ARecord);
	_SID_AND_ATTRIBUTES __fastcall ObjToRec(void);
	
__published:
	__property unsigned Attributes = {read=FAttributes, write=FAttributes, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_SID_AND_ATTRIBUTESWrapper(void) { }
	
};


class DELPHICLASS _ACLWrapper;
class PASCALIMPLEMENTATION _ACLWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	System::Byte FAclRevision;
	System::Byte FSbz1;
	System::Word FAclSize;
	System::Word FAceCount;
	System::Word FSbz2;
	
public:
	__fastcall _ACLWrapper(const _ACL &ARecord);
	_ACL __fastcall ObjToRec(void);
	
__published:
	__property System::Byte AclRevision = {read=FAclRevision, write=FAclRevision, nodefault};
	__property System::Byte Sbz1 = {read=FSbz1, write=FSbz1, nodefault};
	__property System::Word AclSize = {read=FAclSize, write=FAclSize, nodefault};
	__property System::Word AceCount = {read=FAceCount, write=FAceCount, nodefault};
	__property System::Word Sbz2 = {read=FSbz2, write=FSbz2, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_ACLWrapper(void) { }
	
};


class DELPHICLASS _SECURITY_DESCRIPTORWrapper;
class PASCALIMPLEMENTATION _SECURITY_DESCRIPTORWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	System::Byte FRevision;
	System::Byte FSbz1;
	System::Word FControl;
	
public:
	__fastcall _SECURITY_DESCRIPTORWrapper(const _SECURITY_DESCRIPTOR &ARecord);
	_SECURITY_DESCRIPTOR __fastcall ObjToRec(void);
	
__published:
	__property System::Byte Revision = {read=FRevision, write=FRevision, nodefault};
	__property System::Byte Sbz1 = {read=FSbz1, write=FSbz1, nodefault};
	__property System::Word Control = {read=FControl, write=FControl, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_SECURITY_DESCRIPTORWrapper(void) { }
	
};


class DELPHICLASS _OBJECT_TYPE_LISTWrapper;
class PASCALIMPLEMENTATION _OBJECT_TYPE_LISTWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	System::Word FLevel;
	System::Word FSbz;
	
public:
	__fastcall _OBJECT_TYPE_LISTWrapper(const _OBJECT_TYPE_LIST &ARecord);
	_OBJECT_TYPE_LIST __fastcall ObjToRec(void);
	
__published:
	__property System::Word Level = {read=FLevel, write=FLevel, nodefault};
	__property System::Word Sbz = {read=FSbz, write=FSbz, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_OBJECT_TYPE_LISTWrapper(void) { }
	
};


class DELPHICLASS _PRIVILEGE_SETWrapper;
class PASCALIMPLEMENTATION _PRIVILEGE_SETWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FPrivilegeCount;
	unsigned FControl;
	
public:
	__fastcall _PRIVILEGE_SETWrapper(const _PRIVILEGE_SET &ARecord);
	_PRIVILEGE_SET __fastcall ObjToRec(void);
	
__published:
	__property unsigned PrivilegeCount = {read=FPrivilegeCount, write=FPrivilegeCount, nodefault};
	__property unsigned Control = {read=FControl, write=FControl, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_PRIVILEGE_SETWrapper(void) { }
	
};


class DELPHICLASS _TOKEN_USERWrapper;
class PASCALIMPLEMENTATION _TOKEN_USERWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
public:
	__fastcall _TOKEN_USERWrapper(const _TOKEN_USER &ARecord);
	_TOKEN_USER __fastcall ObjToRec(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_TOKEN_USERWrapper(void) { }
	
};


class DELPHICLASS _TOKEN_ELEVATIONWrapper;
class PASCALIMPLEMENTATION _TOKEN_ELEVATIONWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FTokenIsElevated;
	
public:
	__fastcall _TOKEN_ELEVATIONWrapper(_TOKEN_ELEVATION ARecord);
	_TOKEN_ELEVATION __fastcall ObjToRec(void);
	
__published:
	__property unsigned TokenIsElevated = {read=FTokenIsElevated, write=FTokenIsElevated, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_TOKEN_ELEVATIONWrapper(void) { }
	
};


class DELPHICLASS _TOKEN_PRIVILEGESWrapper;
class PASCALIMPLEMENTATION _TOKEN_PRIVILEGESWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FPrivilegeCount;
	
public:
	__fastcall _TOKEN_PRIVILEGESWrapper(const _TOKEN_PRIVILEGES &ARecord);
	_TOKEN_PRIVILEGES __fastcall ObjToRec(void);
	
__published:
	__property unsigned PrivilegeCount = {read=FPrivilegeCount, write=FPrivilegeCount, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_TOKEN_PRIVILEGESWrapper(void) { }
	
};


class DELPHICLASS _TOKEN_OWNERWrapper;
class PASCALIMPLEMENTATION _TOKEN_OWNERWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
public:
	__fastcall _TOKEN_OWNERWrapper(_TOKEN_OWNER ARecord);
	_TOKEN_OWNER __fastcall ObjToRec(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_TOKEN_OWNERWrapper(void) { }
	
};


class DELPHICLASS _TOKEN_PRIMARY_GROUPWrapper;
class PASCALIMPLEMENTATION _TOKEN_PRIMARY_GROUPWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
public:
	__fastcall _TOKEN_PRIMARY_GROUPWrapper(_TOKEN_PRIMARY_GROUP ARecord);
	_TOKEN_PRIMARY_GROUP __fastcall ObjToRec(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_TOKEN_PRIMARY_GROUPWrapper(void) { }
	
};


class DELPHICLASS _TOKEN_DEFAULT_DACLWrapper;
class PASCALIMPLEMENTATION _TOKEN_DEFAULT_DACLWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
public:
	__fastcall _TOKEN_DEFAULT_DACLWrapper(_TOKEN_DEFAULT_DACL ARecord);
	_TOKEN_DEFAULT_DACL __fastcall ObjToRec(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_TOKEN_DEFAULT_DACLWrapper(void) { }
	
};


class DELPHICLASS _TOKEN_SOURCEWrapper;
class PASCALIMPLEMENTATION _TOKEN_SOURCEWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
public:
	__fastcall _TOKEN_SOURCEWrapper(const _TOKEN_SOURCE &ARecord);
	_TOKEN_SOURCE __fastcall ObjToRec(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_TOKEN_SOURCEWrapper(void) { }
	
};


class DELPHICLASS _TOKEN_STATISTICSWrapper;
class PASCALIMPLEMENTATION _TOKEN_STATISTICSWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	TTokenType FTokenType;
	TSecurityImpersonationLevel FImpersonationLevel;
	unsigned FDynamicCharged;
	unsigned FDynamicAvailable;
	unsigned FGroupCount;
	unsigned FPrivilegeCount;
	
public:
	__fastcall _TOKEN_STATISTICSWrapper(const _TOKEN_STATISTICS &ARecord);
	_TOKEN_STATISTICS __fastcall ObjToRec(void);
	
__published:
	__property TTokenType TokenType = {read=FTokenType, write=FTokenType, nodefault};
	__property TSecurityImpersonationLevel ImpersonationLevel = {read=FImpersonationLevel, write=FImpersonationLevel, nodefault};
	__property unsigned DynamicCharged = {read=FDynamicCharged, write=FDynamicCharged, nodefault};
	__property unsigned DynamicAvailable = {read=FDynamicAvailable, write=FDynamicAvailable, nodefault};
	__property unsigned GroupCount = {read=FGroupCount, write=FGroupCount, nodefault};
	__property unsigned PrivilegeCount = {read=FPrivilegeCount, write=FPrivilegeCount, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_TOKEN_STATISTICSWrapper(void) { }
	
};


class DELPHICLASS _TOKEN_GROUPS_AND_PRIVILEGESWrapper;
class PASCALIMPLEMENTATION _TOKEN_GROUPS_AND_PRIVILEGESWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FSidcount;
	unsigned FSidLength;
	unsigned FRestrictedSidCount;
	unsigned FRestrictedSidLength;
	unsigned FPrivilegeCount;
	unsigned FPrivilegeLength;
	
public:
	__fastcall _TOKEN_GROUPS_AND_PRIVILEGESWrapper(const _TOKEN_GROUPS_AND_PRIVILEGES &ARecord);
	_TOKEN_GROUPS_AND_PRIVILEGES __fastcall ObjToRec(void);
	
__published:
	__property unsigned Sidcount = {read=FSidcount, write=FSidcount, nodefault};
	__property unsigned SidLength = {read=FSidLength, write=FSidLength, nodefault};
	__property unsigned RestrictedSidCount = {read=FRestrictedSidCount, write=FRestrictedSidCount, nodefault};
	__property unsigned RestrictedSidLength = {read=FRestrictedSidLength, write=FRestrictedSidLength, nodefault};
	__property unsigned PrivilegeCount = {read=FPrivilegeCount, write=FPrivilegeCount, nodefault};
	__property unsigned PrivilegeLength = {read=FPrivilegeLength, write=FPrivilegeLength, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_TOKEN_GROUPS_AND_PRIVILEGESWrapper(void) { }
	
};


class DELPHICLASS _TOKEN_GROUPSWrapper;
class PASCALIMPLEMENTATION _TOKEN_GROUPSWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FGroupCount;
	
public:
	__fastcall _TOKEN_GROUPSWrapper(const _TOKEN_GROUPS &ARecord);
	_TOKEN_GROUPS __fastcall ObjToRec(void);
	
__published:
	__property unsigned GroupCount = {read=FGroupCount, write=FGroupCount, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_TOKEN_GROUPSWrapper(void) { }
	
};


class DELPHICLASS _TOKEN_AUDIT_POLICYWrapper;
class PASCALIMPLEMENTATION _TOKEN_AUDIT_POLICYWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
public:
	__fastcall _TOKEN_AUDIT_POLICYWrapper(const _TOKEN_AUDIT_POLICY &ARecord);
	_TOKEN_AUDIT_POLICY __fastcall ObjToRec(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_TOKEN_AUDIT_POLICYWrapper(void) { }
	
};


class DELPHICLASS _TOKEN_ORIGINWrapper;
class PASCALIMPLEMENTATION _TOKEN_ORIGINWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
public:
	__fastcall _TOKEN_ORIGINWrapper(const _TOKEN_ORIGIN &ARecord);
	_TOKEN_ORIGIN __fastcall ObjToRec(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_TOKEN_ORIGINWrapper(void) { }
	
};


class DELPHICLASS _TOKEN_LINKED_TOKENWrapper;
class PASCALIMPLEMENTATION _TOKEN_LINKED_TOKENWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
public:
	__fastcall _TOKEN_LINKED_TOKENWrapper(_TOKEN_LINKED_TOKEN ARecord);
	_TOKEN_LINKED_TOKEN __fastcall ObjToRec(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_TOKEN_LINKED_TOKENWrapper(void) { }
	
};


class DELPHICLASS _TOKEN_MANDATORY_POLICYWrapper;
class PASCALIMPLEMENTATION _TOKEN_MANDATORY_POLICYWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FPolicy;
	
public:
	__fastcall _TOKEN_MANDATORY_POLICYWrapper(_TOKEN_MANDATORY_POLICY ARecord);
	_TOKEN_MANDATORY_POLICY __fastcall ObjToRec(void);
	
__published:
	__property unsigned Policy = {read=FPolicy, write=FPolicy, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_TOKEN_MANDATORY_POLICYWrapper(void) { }
	
};


class DELPHICLASS _TOKEN_ACCESS_INFORMATIONWrapper;
class PASCALIMPLEMENTATION _TOKEN_ACCESS_INFORMATIONWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	TTokenType FTokenType;
	TSecurityImpersonationLevel FImpersonationLevel;
	unsigned FFlags;
	
public:
	__fastcall _TOKEN_ACCESS_INFORMATIONWrapper(const _TOKEN_ACCESS_INFORMATION &ARecord);
	_TOKEN_ACCESS_INFORMATION __fastcall ObjToRec(void);
	
__published:
	__property TTokenType TokenType = {read=FTokenType, write=FTokenType, nodefault};
	__property TSecurityImpersonationLevel ImpersonationLevel = {read=FImpersonationLevel, write=FImpersonationLevel, nodefault};
	__property unsigned Flags = {read=FFlags, write=FFlags, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_TOKEN_ACCESS_INFORMATIONWrapper(void) { }
	
};


class DELPHICLASS _SECURITY_QUALITY_OF_SERVICEWrapper;
class PASCALIMPLEMENTATION _SECURITY_QUALITY_OF_SERVICEWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FLength;
	TSecurityImpersonationLevel FImpersonationLevel;
	bool FContextTrackingMode;
	bool FEffectiveOnly;
	
public:
	__fastcall _SECURITY_QUALITY_OF_SERVICEWrapper(const _SECURITY_QUALITY_OF_SERVICE &ARecord);
	_SECURITY_QUALITY_OF_SERVICE __fastcall ObjToRec(void);
	
__published:
	__property unsigned Length = {read=FLength, write=FLength, nodefault};
	__property TSecurityImpersonationLevel ImpersonationLevel = {read=FImpersonationLevel, write=FImpersonationLevel, nodefault};
	__property bool ContextTrackingMode = {read=FContextTrackingMode, write=FContextTrackingMode, nodefault};
	__property bool EffectiveOnly = {read=FEffectiveOnly, write=FEffectiveOnly, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_SECURITY_QUALITY_OF_SERVICEWrapper(void) { }
	
};


class DELPHICLASS _IMAGE_DOS_HEADERWrapper;
class PASCALIMPLEMENTATION _IMAGE_DOS_HEADERWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	System::Word Fe_magic;
	System::Word Fe_cblp;
	System::Word Fe_cp;
	System::Word Fe_crlc;
	System::Word Fe_cparhdr;
	System::Word Fe_minalloc;
	System::Word Fe_maxalloc;
	System::Word Fe_ss;
	System::Word Fe_sp;
	System::Word Fe_csum;
	System::Word Fe_ip;
	System::Word Fe_cs;
	System::Word Fe_lfarlc;
	System::Word Fe_ovno;
	System::Word Fe_oemid;
	System::Word Fe_oeminfo;
	int F_lfanew;
	
public:
	__fastcall _IMAGE_DOS_HEADERWrapper(const Windows::_IMAGE_DOS_HEADER &ARecord);
	Windows::_IMAGE_DOS_HEADER __fastcall ObjToRec(void);
	
__published:
	__property System::Word e_magic = {read=Fe_magic, write=Fe_magic, nodefault};
	__property System::Word e_cblp = {read=Fe_cblp, write=Fe_cblp, nodefault};
	__property System::Word e_cp = {read=Fe_cp, write=Fe_cp, nodefault};
	__property System::Word e_crlc = {read=Fe_crlc, write=Fe_crlc, nodefault};
	__property System::Word e_cparhdr = {read=Fe_cparhdr, write=Fe_cparhdr, nodefault};
	__property System::Word e_minalloc = {read=Fe_minalloc, write=Fe_minalloc, nodefault};
	__property System::Word e_maxalloc = {read=Fe_maxalloc, write=Fe_maxalloc, nodefault};
	__property System::Word e_ss = {read=Fe_ss, write=Fe_ss, nodefault};
	__property System::Word e_sp = {read=Fe_sp, write=Fe_sp, nodefault};
	__property System::Word e_csum = {read=Fe_csum, write=Fe_csum, nodefault};
	__property System::Word e_ip = {read=Fe_ip, write=Fe_ip, nodefault};
	__property System::Word e_cs = {read=Fe_cs, write=Fe_cs, nodefault};
	__property System::Word e_lfarlc = {read=Fe_lfarlc, write=Fe_lfarlc, nodefault};
	__property System::Word e_ovno = {read=Fe_ovno, write=Fe_ovno, nodefault};
	__property System::Word e_oemid = {read=Fe_oemid, write=Fe_oemid, nodefault};
	__property System::Word e_oeminfo = {read=Fe_oeminfo, write=Fe_oeminfo, nodefault};
	__property int _lfanew = {read=F_lfanew, write=F_lfanew, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_IMAGE_DOS_HEADERWrapper(void) { }
	
};


class DELPHICLASS _IMAGE_FILE_HEADERWrapper;
class PASCALIMPLEMENTATION _IMAGE_FILE_HEADERWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	System::Word FMachine;
	System::Word FNumberOfSections;
	unsigned FTimeDateStamp;
	unsigned FPointerToSymbolTable;
	unsigned FNumberOfSymbols;
	System::Word FSizeOfOptionalHeader;
	System::Word FCharacteristics;
	
public:
	__fastcall _IMAGE_FILE_HEADERWrapper(const _IMAGE_FILE_HEADER &ARecord);
	_IMAGE_FILE_HEADER __fastcall ObjToRec(void);
	
__published:
	__property System::Word Machine = {read=FMachine, write=FMachine, nodefault};
	__property System::Word NumberOfSections = {read=FNumberOfSections, write=FNumberOfSections, nodefault};
	__property unsigned TimeDateStamp = {read=FTimeDateStamp, write=FTimeDateStamp, nodefault};
	__property unsigned PointerToSymbolTable = {read=FPointerToSymbolTable, write=FPointerToSymbolTable, nodefault};
	__property unsigned NumberOfSymbols = {read=FNumberOfSymbols, write=FNumberOfSymbols, nodefault};
	__property System::Word SizeOfOptionalHeader = {read=FSizeOfOptionalHeader, write=FSizeOfOptionalHeader, nodefault};
	__property System::Word Characteristics = {read=FCharacteristics, write=FCharacteristics, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_IMAGE_FILE_HEADERWrapper(void) { }
	
};


class DELPHICLASS _IMAGE_EXPORT_DIRECTORYWrapper;
class PASCALIMPLEMENTATION _IMAGE_EXPORT_DIRECTORYWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FCharacteristics;
	unsigned FTimeDateStamp;
	System::Word FMajorVersion;
	System::Word FMinorVersion;
	unsigned FName;
	unsigned FBase;
	unsigned FNumberOfFunctions;
	unsigned FNumberOfNames;
	
public:
	__fastcall _IMAGE_EXPORT_DIRECTORYWrapper(const _IMAGE_EXPORT_DIRECTORY &ARecord);
	_IMAGE_EXPORT_DIRECTORY __fastcall ObjToRec(void);
	
__published:
	__property unsigned Characteristics = {read=FCharacteristics, write=FCharacteristics, nodefault};
	__property unsigned TimeDateStamp = {read=FTimeDateStamp, write=FTimeDateStamp, nodefault};
	__property System::Word MajorVersion = {read=FMajorVersion, write=FMajorVersion, nodefault};
	__property System::Word MinorVersion = {read=FMinorVersion, write=FMinorVersion, nodefault};
	__property unsigned Name = {read=FName, write=FName, nodefault};
	__property unsigned Base = {read=FBase, write=FBase, nodefault};
	__property unsigned NumberOfFunctions = {read=FNumberOfFunctions, write=FNumberOfFunctions, nodefault};
	__property unsigned NumberOfNames = {read=FNumberOfNames, write=FNumberOfNames, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_IMAGE_EXPORT_DIRECTORYWrapper(void) { }
	
};


class DELPHICLASS _IMAGE_IMPORT_BY_NAMEWrapper;
class PASCALIMPLEMENTATION _IMAGE_IMPORT_BY_NAMEWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	System::Word FHint;
	
public:
	__fastcall _IMAGE_IMPORT_BY_NAMEWrapper(_IMAGE_IMPORT_BY_NAME ARecord);
	_IMAGE_IMPORT_BY_NAME __fastcall ObjToRec(void);
	
__published:
	__property System::Word Hint = {read=FHint, write=FHint, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_IMAGE_IMPORT_BY_NAMEWrapper(void) { }
	
};


class DELPHICLASS _IMAGE_THUNK_DATA64Wrapper;
class PASCALIMPLEMENTATION _IMAGE_THUNK_DATA64Wrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned __int64 FForwarderString;
	unsigned __int64 F_Function;
	unsigned __int64 FOrdinal;
	unsigned __int64 FAddressOfData;
	
public:
	__fastcall _IMAGE_THUNK_DATA64Wrapper(const _IMAGE_THUNK_DATA64 &ARecord);
	_IMAGE_THUNK_DATA64 __fastcall ObjToRec(void);
	
__published:
	__property unsigned __int64 ForwarderString = {read=FForwarderString, write=FForwarderString};
	__property unsigned __int64 _Function = {read=F_Function, write=F_Function};
	__property unsigned __int64 Ordinal = {read=FOrdinal, write=FOrdinal};
	__property unsigned __int64 AddressOfData = {read=FAddressOfData, write=FAddressOfData};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_IMAGE_THUNK_DATA64Wrapper(void) { }
	
};


class DELPHICLASS _IMAGE_THUNK_DATA32Wrapper;
class PASCALIMPLEMENTATION _IMAGE_THUNK_DATA32Wrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FForwarderString;
	unsigned F_Function;
	unsigned FOrdinal;
	unsigned FAddressOfData;
	
public:
	__fastcall _IMAGE_THUNK_DATA32Wrapper(_IMAGE_THUNK_DATA32 ARecord);
	_IMAGE_THUNK_DATA32 __fastcall ObjToRec(void);
	
__published:
	__property unsigned ForwarderString = {read=FForwarderString, write=FForwarderString, nodefault};
	__property unsigned _Function = {read=F_Function, write=F_Function, nodefault};
	__property unsigned Ordinal = {read=FOrdinal, write=FOrdinal, nodefault};
	__property unsigned AddressOfData = {read=FAddressOfData, write=FAddressOfData, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_IMAGE_THUNK_DATA32Wrapper(void) { }
	
};


class DELPHICLASS _IMAGE_TLS_DIRECTORY64Wrapper;
class PASCALIMPLEMENTATION _IMAGE_TLS_DIRECTORY64Wrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned __int64 FStartAddressOfRawData;
	unsigned __int64 FEndAddressOfRawData;
	unsigned __int64 FAddressOfIndex;
	unsigned __int64 FAddressOfCallBacks;
	unsigned FSizeOfZeroFill;
	unsigned FCharacteristics;
	
public:
	__fastcall _IMAGE_TLS_DIRECTORY64Wrapper(const _IMAGE_TLS_DIRECTORY64 &ARecord);
	_IMAGE_TLS_DIRECTORY64 __fastcall ObjToRec(void);
	
__published:
	__property unsigned __int64 StartAddressOfRawData = {read=FStartAddressOfRawData, write=FStartAddressOfRawData};
	__property unsigned __int64 EndAddressOfRawData = {read=FEndAddressOfRawData, write=FEndAddressOfRawData};
	__property unsigned __int64 AddressOfIndex = {read=FAddressOfIndex, write=FAddressOfIndex};
	__property unsigned __int64 AddressOfCallBacks = {read=FAddressOfCallBacks, write=FAddressOfCallBacks};
	__property unsigned SizeOfZeroFill = {read=FSizeOfZeroFill, write=FSizeOfZeroFill, nodefault};
	__property unsigned Characteristics = {read=FCharacteristics, write=FCharacteristics, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_IMAGE_TLS_DIRECTORY64Wrapper(void) { }
	
};


class DELPHICLASS _IMAGE_TLS_DIRECTORY32Wrapper;
class PASCALIMPLEMENTATION _IMAGE_TLS_DIRECTORY32Wrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FStartAddressOfRawData;
	unsigned FEndAddressOfRawData;
	unsigned FAddressOfIndex;
	unsigned FAddressOfCallBacks;
	unsigned FSizeOfZeroFill;
	unsigned FCharacteristics;
	
public:
	__fastcall _IMAGE_TLS_DIRECTORY32Wrapper(const _IMAGE_TLS_DIRECTORY32 &ARecord);
	_IMAGE_TLS_DIRECTORY32 __fastcall ObjToRec(void);
	
__published:
	__property unsigned StartAddressOfRawData = {read=FStartAddressOfRawData, write=FStartAddressOfRawData, nodefault};
	__property unsigned EndAddressOfRawData = {read=FEndAddressOfRawData, write=FEndAddressOfRawData, nodefault};
	__property unsigned AddressOfIndex = {read=FAddressOfIndex, write=FAddressOfIndex, nodefault};
	__property unsigned AddressOfCallBacks = {read=FAddressOfCallBacks, write=FAddressOfCallBacks, nodefault};
	__property unsigned SizeOfZeroFill = {read=FSizeOfZeroFill, write=FSizeOfZeroFill, nodefault};
	__property unsigned Characteristics = {read=FCharacteristics, write=FCharacteristics, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_IMAGE_TLS_DIRECTORY32Wrapper(void) { }
	
};


class DELPHICLASS _IMAGE_IMPORT_DESCRIPTORWrapper;
class PASCALIMPLEMENTATION _IMAGE_IMPORT_DESCRIPTORWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FCharacteristics;
	unsigned FOriginalFirstThunk;
	unsigned FTimeDateStamp;
	unsigned FForwarderChain;
	unsigned FName;
	unsigned FFirstThunk;
	
public:
	__fastcall _IMAGE_IMPORT_DESCRIPTORWrapper(const _IMAGE_IMPORT_DESCRIPTOR &ARecord);
	_IMAGE_IMPORT_DESCRIPTOR __fastcall ObjToRec(void);
	
__published:
	__property unsigned Characteristics = {read=FCharacteristics, write=FCharacteristics, nodefault};
	__property unsigned OriginalFirstThunk = {read=FOriginalFirstThunk, write=FOriginalFirstThunk, nodefault};
	__property unsigned TimeDateStamp = {read=FTimeDateStamp, write=FTimeDateStamp, nodefault};
	__property unsigned ForwarderChain = {read=FForwarderChain, write=FForwarderChain, nodefault};
	__property unsigned Name = {read=FName, write=FName, nodefault};
	__property unsigned FirstThunk = {read=FFirstThunk, write=FFirstThunk, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_IMAGE_IMPORT_DESCRIPTORWrapper(void) { }
	
};


class DELPHICLASS _IMAGE_BOUND_IMPORT_DESCRIPTORWrapper;
class PASCALIMPLEMENTATION _IMAGE_BOUND_IMPORT_DESCRIPTORWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FTimeDateStamp;
	System::Word FOffsetModuleName;
	System::Word FNumberOfModuleForwarderRefs;
	
public:
	__fastcall _IMAGE_BOUND_IMPORT_DESCRIPTORWrapper(const _IMAGE_BOUND_IMPORT_DESCRIPTOR &ARecord);
	_IMAGE_BOUND_IMPORT_DESCRIPTOR __fastcall ObjToRec(void);
	
__published:
	__property unsigned TimeDateStamp = {read=FTimeDateStamp, write=FTimeDateStamp, nodefault};
	__property System::Word OffsetModuleName = {read=FOffsetModuleName, write=FOffsetModuleName, nodefault};
	__property System::Word NumberOfModuleForwarderRefs = {read=FNumberOfModuleForwarderRefs, write=FNumberOfModuleForwarderRefs, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_IMAGE_BOUND_IMPORT_DESCRIPTORWrapper(void) { }
	
};


class DELPHICLASS _IMAGE_BOUND_FORWARDER_REFWrapper;
class PASCALIMPLEMENTATION _IMAGE_BOUND_FORWARDER_REFWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FTimeDateStamp;
	System::Word FOffsetModuleName;
	System::Word FReserved;
	
public:
	__fastcall _IMAGE_BOUND_FORWARDER_REFWrapper(const _IMAGE_BOUND_FORWARDER_REF &ARecord);
	_IMAGE_BOUND_FORWARDER_REF __fastcall ObjToRec(void);
	
__published:
	__property unsigned TimeDateStamp = {read=FTimeDateStamp, write=FTimeDateStamp, nodefault};
	__property System::Word OffsetModuleName = {read=FOffsetModuleName, write=FOffsetModuleName, nodefault};
	__property System::Word Reserved = {read=FReserved, write=FReserved, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_IMAGE_BOUND_FORWARDER_REFWrapper(void) { }
	
};


class DELPHICLASS _IMAGE_DATA_DIRECTORYWrapper;
class PASCALIMPLEMENTATION _IMAGE_DATA_DIRECTORYWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FVirtualAddress;
	unsigned FSize;
	
public:
	__fastcall _IMAGE_DATA_DIRECTORYWrapper(const _IMAGE_DATA_DIRECTORY &ARecord);
	_IMAGE_DATA_DIRECTORY __fastcall ObjToRec(void);
	
__published:
	__property unsigned VirtualAddress = {read=FVirtualAddress, write=FVirtualAddress, nodefault};
	__property unsigned Size = {read=FSize, write=FSize, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_IMAGE_DATA_DIRECTORYWrapper(void) { }
	
};


class DELPHICLASS _IMAGE_OPTIONAL_HEADERWrapper;
class PASCALIMPLEMENTATION _IMAGE_OPTIONAL_HEADERWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	System::Word FMagic;
	System::Byte FMajorLinkerVersion;
	System::Byte FMinorLinkerVersion;
	unsigned FSizeOfCode;
	unsigned FSizeOfInitializedData;
	unsigned FSizeOfUninitializedData;
	unsigned FAddressOfEntryPoint;
	unsigned FBaseOfCode;
	unsigned FBaseOfData;
	unsigned FImageBase;
	unsigned FSectionAlignment;
	unsigned FFileAlignment;
	System::Word FMajorOperatingSystemVersion;
	System::Word FMinorOperatingSystemVersion;
	System::Word FMajorImageVersion;
	System::Word FMinorImageVersion;
	System::Word FMajorSubsystemVersion;
	System::Word FMinorSubsystemVersion;
	unsigned FWin32VersionValue;
	unsigned FSizeOfImage;
	unsigned FSizeOfHeaders;
	unsigned FCheckSum;
	System::Word FSubsystem;
	System::Word FDllCharacteristics;
	unsigned FSizeOfStackReserve;
	unsigned FSizeOfStackCommit;
	unsigned FSizeOfHeapReserve;
	unsigned FSizeOfHeapCommit;
	unsigned FLoaderFlags;
	unsigned FNumberOfRvaAndSizes;
	
public:
	__fastcall _IMAGE_OPTIONAL_HEADERWrapper(const _IMAGE_OPTIONAL_HEADER &ARecord);
	_IMAGE_OPTIONAL_HEADER __fastcall ObjToRec(void);
	
__published:
	__property System::Word Magic = {read=FMagic, write=FMagic, nodefault};
	__property System::Byte MajorLinkerVersion = {read=FMajorLinkerVersion, write=FMajorLinkerVersion, nodefault};
	__property System::Byte MinorLinkerVersion = {read=FMinorLinkerVersion, write=FMinorLinkerVersion, nodefault};
	__property unsigned SizeOfCode = {read=FSizeOfCode, write=FSizeOfCode, nodefault};
	__property unsigned SizeOfInitializedData = {read=FSizeOfInitializedData, write=FSizeOfInitializedData, nodefault};
	__property unsigned SizeOfUninitializedData = {read=FSizeOfUninitializedData, write=FSizeOfUninitializedData, nodefault};
	__property unsigned AddressOfEntryPoint = {read=FAddressOfEntryPoint, write=FAddressOfEntryPoint, nodefault};
	__property unsigned BaseOfCode = {read=FBaseOfCode, write=FBaseOfCode, nodefault};
	__property unsigned BaseOfData = {read=FBaseOfData, write=FBaseOfData, nodefault};
	__property unsigned ImageBase = {read=FImageBase, write=FImageBase, nodefault};
	__property unsigned SectionAlignment = {read=FSectionAlignment, write=FSectionAlignment, nodefault};
	__property unsigned FileAlignment = {read=FFileAlignment, write=FFileAlignment, nodefault};
	__property System::Word MajorOperatingSystemVersion = {read=FMajorOperatingSystemVersion, write=FMajorOperatingSystemVersion, nodefault};
	__property System::Word MinorOperatingSystemVersion = {read=FMinorOperatingSystemVersion, write=FMinorOperatingSystemVersion, nodefault};
	__property System::Word MajorImageVersion = {read=FMajorImageVersion, write=FMajorImageVersion, nodefault};
	__property System::Word MinorImageVersion = {read=FMinorImageVersion, write=FMinorImageVersion, nodefault};
	__property System::Word MajorSubsystemVersion = {read=FMajorSubsystemVersion, write=FMajorSubsystemVersion, nodefault};
	__property System::Word MinorSubsystemVersion = {read=FMinorSubsystemVersion, write=FMinorSubsystemVersion, nodefault};
	__property unsigned Win32VersionValue = {read=FWin32VersionValue, write=FWin32VersionValue, nodefault};
	__property unsigned SizeOfImage = {read=FSizeOfImage, write=FSizeOfImage, nodefault};
	__property unsigned SizeOfHeaders = {read=FSizeOfHeaders, write=FSizeOfHeaders, nodefault};
	__property unsigned CheckSum = {read=FCheckSum, write=FCheckSum, nodefault};
	__property System::Word Subsystem = {read=FSubsystem, write=FSubsystem, nodefault};
	__property System::Word DllCharacteristics = {read=FDllCharacteristics, write=FDllCharacteristics, nodefault};
	__property unsigned SizeOfStackReserve = {read=FSizeOfStackReserve, write=FSizeOfStackReserve, nodefault};
	__property unsigned SizeOfStackCommit = {read=FSizeOfStackCommit, write=FSizeOfStackCommit, nodefault};
	__property unsigned SizeOfHeapReserve = {read=FSizeOfHeapReserve, write=FSizeOfHeapReserve, nodefault};
	__property unsigned SizeOfHeapCommit = {read=FSizeOfHeapCommit, write=FSizeOfHeapCommit, nodefault};
	__property unsigned LoaderFlags = {read=FLoaderFlags, write=FLoaderFlags, nodefault};
	__property unsigned NumberOfRvaAndSizes = {read=FNumberOfRvaAndSizes, write=FNumberOfRvaAndSizes, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_IMAGE_OPTIONAL_HEADERWrapper(void) { }
	
};


class DELPHICLASS _IMAGE_ROM_OPTIONAL_HEADERWrapper;
class PASCALIMPLEMENTATION _IMAGE_ROM_OPTIONAL_HEADERWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	System::Word FMagic;
	System::Byte FMajorLinkerVersion;
	System::Byte FMinorLinkerVersion;
	unsigned FSizeOfCode;
	unsigned FSizeOfInitializedData;
	unsigned FSizeOfUninitializedData;
	unsigned FAddressOfEntryPoint;
	unsigned FBaseOfCode;
	unsigned FBaseOfData;
	unsigned FBaseOfBss;
	unsigned FGprMask;
	unsigned FGpValue;
	
public:
	__fastcall _IMAGE_ROM_OPTIONAL_HEADERWrapper(const _IMAGE_ROM_OPTIONAL_HEADER &ARecord);
	_IMAGE_ROM_OPTIONAL_HEADER __fastcall ObjToRec(void);
	
__published:
	__property System::Word Magic = {read=FMagic, write=FMagic, nodefault};
	__property System::Byte MajorLinkerVersion = {read=FMajorLinkerVersion, write=FMajorLinkerVersion, nodefault};
	__property System::Byte MinorLinkerVersion = {read=FMinorLinkerVersion, write=FMinorLinkerVersion, nodefault};
	__property unsigned SizeOfCode = {read=FSizeOfCode, write=FSizeOfCode, nodefault};
	__property unsigned SizeOfInitializedData = {read=FSizeOfInitializedData, write=FSizeOfInitializedData, nodefault};
	__property unsigned SizeOfUninitializedData = {read=FSizeOfUninitializedData, write=FSizeOfUninitializedData, nodefault};
	__property unsigned AddressOfEntryPoint = {read=FAddressOfEntryPoint, write=FAddressOfEntryPoint, nodefault};
	__property unsigned BaseOfCode = {read=FBaseOfCode, write=FBaseOfCode, nodefault};
	__property unsigned BaseOfData = {read=FBaseOfData, write=FBaseOfData, nodefault};
	__property unsigned BaseOfBss = {read=FBaseOfBss, write=FBaseOfBss, nodefault};
	__property unsigned GprMask = {read=FGprMask, write=FGprMask, nodefault};
	__property unsigned GpValue = {read=FGpValue, write=FGpValue, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_IMAGE_ROM_OPTIONAL_HEADERWrapper(void) { }
	
};


class DELPHICLASS _IMAGE_NT_HEADERSWrapper;
class PASCALIMPLEMENTATION _IMAGE_NT_HEADERSWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FSignature;
	
public:
	__fastcall _IMAGE_NT_HEADERSWrapper(const _IMAGE_NT_HEADERS &ARecord);
	_IMAGE_NT_HEADERS __fastcall ObjToRec(void);
	
__published:
	__property unsigned Signature = {read=FSignature, write=FSignature, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_IMAGE_NT_HEADERSWrapper(void) { }
	
};


class DELPHICLASS _IMAGE_ROM_HEADERSWrapper;
class PASCALIMPLEMENTATION _IMAGE_ROM_HEADERSWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
public:
	__fastcall _IMAGE_ROM_HEADERSWrapper(const _IMAGE_ROM_HEADERS &ARecord);
	_IMAGE_ROM_HEADERS __fastcall ObjToRec(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_IMAGE_ROM_HEADERSWrapper(void) { }
	
};


class DELPHICLASS TISHMiscWrapper;
class PASCALIMPLEMENTATION TISHMiscWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FPhysicalAddress;
	unsigned FVirtualSize;
	
public:
	__fastcall TISHMiscWrapper(Windows::TISHMisc ARecord);
	Windows::TISHMisc __fastcall ObjToRec(void);
	
__published:
	__property unsigned PhysicalAddress = {read=FPhysicalAddress, write=FPhysicalAddress, nodefault};
	__property unsigned VirtualSize = {read=FVirtualSize, write=FVirtualSize, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TISHMiscWrapper(void) { }
	
};


class DELPHICLASS _IMAGE_SECTION_HEADERWrapper;
class PASCALIMPLEMENTATION _IMAGE_SECTION_HEADERWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FVirtualAddress;
	unsigned FSizeOfRawData;
	unsigned FPointerToRawData;
	unsigned FPointerToRelocations;
	unsigned FPointerToLinenumbers;
	System::Word FNumberOfRelocations;
	System::Word FNumberOfLinenumbers;
	unsigned FCharacteristics;
	
public:
	__fastcall _IMAGE_SECTION_HEADERWrapper(const _IMAGE_SECTION_HEADER &ARecord);
	_IMAGE_SECTION_HEADER __fastcall ObjToRec(void);
	
__published:
	__property unsigned VirtualAddress = {read=FVirtualAddress, write=FVirtualAddress, nodefault};
	__property unsigned SizeOfRawData = {read=FSizeOfRawData, write=FSizeOfRawData, nodefault};
	__property unsigned PointerToRawData = {read=FPointerToRawData, write=FPointerToRawData, nodefault};
	__property unsigned PointerToRelocations = {read=FPointerToRelocations, write=FPointerToRelocations, nodefault};
	__property unsigned PointerToLinenumbers = {read=FPointerToLinenumbers, write=FPointerToLinenumbers, nodefault};
	__property System::Word NumberOfRelocations = {read=FNumberOfRelocations, write=FNumberOfRelocations, nodefault};
	__property System::Word NumberOfLinenumbers = {read=FNumberOfLinenumbers, write=FNumberOfLinenumbers, nodefault};
	__property unsigned Characteristics = {read=FCharacteristics, write=FCharacteristics, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_IMAGE_SECTION_HEADERWrapper(void) { }
	
};


class DELPHICLASS IMAGE_LOAD_CONFIG_DIRECTORYWrapper;
class PASCALIMPLEMENTATION IMAGE_LOAD_CONFIG_DIRECTORYWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FCharacteristics;
	unsigned FTimeDateStamp;
	System::Word FMajorVersion;
	System::Word FMinorVersion;
	unsigned FGlobalFlagsClear;
	unsigned FGlobalFlagsSet;
	unsigned FCriticalSectionDefaultTimeout;
	unsigned FDeCommitFreeBlockThreshold;
	unsigned FDeCommitTotalFreeThreshold;
	unsigned FMaximumAllocationSize;
	unsigned FVirtualMemoryThreshold;
	unsigned FProcessHeapFlags;
	unsigned FProcessAffinityMask;
	
public:
	__fastcall IMAGE_LOAD_CONFIG_DIRECTORYWrapper(const IMAGE_LOAD_CONFIG_DIRECTORY &ARecord);
	IMAGE_LOAD_CONFIG_DIRECTORY __fastcall ObjToRec(void);
	
__published:
	__property unsigned Characteristics = {read=FCharacteristics, write=FCharacteristics, nodefault};
	__property unsigned TimeDateStamp = {read=FTimeDateStamp, write=FTimeDateStamp, nodefault};
	__property System::Word MajorVersion = {read=FMajorVersion, write=FMajorVersion, nodefault};
	__property System::Word MinorVersion = {read=FMinorVersion, write=FMinorVersion, nodefault};
	__property unsigned GlobalFlagsClear = {read=FGlobalFlagsClear, write=FGlobalFlagsClear, nodefault};
	__property unsigned GlobalFlagsSet = {read=FGlobalFlagsSet, write=FGlobalFlagsSet, nodefault};
	__property unsigned CriticalSectionDefaultTimeout = {read=FCriticalSectionDefaultTimeout, write=FCriticalSectionDefaultTimeout, nodefault};
	__property unsigned DeCommitFreeBlockThreshold = {read=FDeCommitFreeBlockThreshold, write=FDeCommitFreeBlockThreshold, nodefault};
	__property unsigned DeCommitTotalFreeThreshold = {read=FDeCommitTotalFreeThreshold, write=FDeCommitTotalFreeThreshold, nodefault};
	__property unsigned MaximumAllocationSize = {read=FMaximumAllocationSize, write=FMaximumAllocationSize, nodefault};
	__property unsigned VirtualMemoryThreshold = {read=FVirtualMemoryThreshold, write=FVirtualMemoryThreshold, nodefault};
	__property unsigned ProcessHeapFlags = {read=FProcessHeapFlags, write=FProcessHeapFlags, nodefault};
	__property unsigned ProcessAffinityMask = {read=FProcessAffinityMask, write=FProcessAffinityMask, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~IMAGE_LOAD_CONFIG_DIRECTORYWrapper(void) { }
	
};


class DELPHICLASS IMAGE_RUNTIME_FUNCTION_ENTRYWrapper;
class PASCALIMPLEMENTATION IMAGE_RUNTIME_FUNCTION_ENTRYWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FBeginAddress;
	unsigned FEndAddress;
	unsigned FPrologEndAddress;
	
public:
	__fastcall IMAGE_RUNTIME_FUNCTION_ENTRYWrapper(const IMAGE_RUNTIME_FUNCTION_ENTRY &ARecord);
	IMAGE_RUNTIME_FUNCTION_ENTRY __fastcall ObjToRec(void);
	
__published:
	__property unsigned BeginAddress = {read=FBeginAddress, write=FBeginAddress, nodefault};
	__property unsigned EndAddress = {read=FEndAddress, write=FEndAddress, nodefault};
	__property unsigned PrologEndAddress = {read=FPrologEndAddress, write=FPrologEndAddress, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~IMAGE_RUNTIME_FUNCTION_ENTRYWrapper(void) { }
	
};


class DELPHICLASS _IMAGE_DEBUG_DIRECTORYWrapper;
class PASCALIMPLEMENTATION _IMAGE_DEBUG_DIRECTORYWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FCharacteristics;
	unsigned FTimeDateStamp;
	System::Word FMajorVersion;
	System::Word FMinorVersion;
	unsigned F_Type;
	unsigned FSizeOfData;
	unsigned FAddressOfRawData;
	unsigned FPointerToRawData;
	
public:
	__fastcall _IMAGE_DEBUG_DIRECTORYWrapper(const _IMAGE_DEBUG_DIRECTORY &ARecord);
	_IMAGE_DEBUG_DIRECTORY __fastcall ObjToRec(void);
	
__published:
	__property unsigned Characteristics = {read=FCharacteristics, write=FCharacteristics, nodefault};
	__property unsigned TimeDateStamp = {read=FTimeDateStamp, write=FTimeDateStamp, nodefault};
	__property System::Word MajorVersion = {read=FMajorVersion, write=FMajorVersion, nodefault};
	__property System::Word MinorVersion = {read=FMinorVersion, write=FMinorVersion, nodefault};
	__property unsigned _Type = {read=F_Type, write=F_Type, nodefault};
	__property unsigned SizeOfData = {read=FSizeOfData, write=FSizeOfData, nodefault};
	__property unsigned AddressOfRawData = {read=FAddressOfRawData, write=FAddressOfRawData, nodefault};
	__property unsigned PointerToRawData = {read=FPointerToRawData, write=FPointerToRawData, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_IMAGE_DEBUG_DIRECTORYWrapper(void) { }
	
};


class DELPHICLASS _IMAGE_COFF_SYMBOLS_HEADERWrapper;
class PASCALIMPLEMENTATION _IMAGE_COFF_SYMBOLS_HEADERWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FNumberOfSymbols;
	unsigned FLvaToFirstSymbol;
	unsigned FNumberOfLinenumbers;
	unsigned FLvaToFirstLinenumber;
	unsigned FRvaToFirstByteOfCode;
	unsigned FRvaToLastByteOfCode;
	unsigned FRvaToFirstByteOfData;
	unsigned FRvaToLastByteOfData;
	
public:
	__fastcall _IMAGE_COFF_SYMBOLS_HEADERWrapper(const _IMAGE_COFF_SYMBOLS_HEADER &ARecord);
	_IMAGE_COFF_SYMBOLS_HEADER __fastcall ObjToRec(void);
	
__published:
	__property unsigned NumberOfSymbols = {read=FNumberOfSymbols, write=FNumberOfSymbols, nodefault};
	__property unsigned LvaToFirstSymbol = {read=FLvaToFirstSymbol, write=FLvaToFirstSymbol, nodefault};
	__property unsigned NumberOfLinenumbers = {read=FNumberOfLinenumbers, write=FNumberOfLinenumbers, nodefault};
	__property unsigned LvaToFirstLinenumber = {read=FLvaToFirstLinenumber, write=FLvaToFirstLinenumber, nodefault};
	__property unsigned RvaToFirstByteOfCode = {read=FRvaToFirstByteOfCode, write=FRvaToFirstByteOfCode, nodefault};
	__property unsigned RvaToLastByteOfCode = {read=FRvaToLastByteOfCode, write=FRvaToLastByteOfCode, nodefault};
	__property unsigned RvaToFirstByteOfData = {read=FRvaToFirstByteOfData, write=FRvaToFirstByteOfData, nodefault};
	__property unsigned RvaToLastByteOfData = {read=FRvaToLastByteOfData, write=FRvaToLastByteOfData, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_IMAGE_COFF_SYMBOLS_HEADERWrapper(void) { }
	
};


class DELPHICLASS _FPO_DATAWrapper;
class PASCALIMPLEMENTATION _FPO_DATAWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FulOffStart;
	unsigned FcbProcSize;
	unsigned FcdwLocals;
	System::Word FcdwParams;
	System::Byte FcbProlog;
	System::Byte FOtherStuff;
	
public:
	__fastcall _FPO_DATAWrapper(const _FPO_DATA &ARecord);
	_FPO_DATA __fastcall ObjToRec(void);
	
__published:
	__property unsigned ulOffStart = {read=FulOffStart, write=FulOffStart, nodefault};
	__property unsigned cbProcSize = {read=FcbProcSize, write=FcbProcSize, nodefault};
	__property unsigned cdwLocals = {read=FcdwLocals, write=FcdwLocals, nodefault};
	__property System::Word cdwParams = {read=FcdwParams, write=FcdwParams, nodefault};
	__property System::Byte cbProlog = {read=FcbProlog, write=FcbProlog, nodefault};
	__property System::Byte OtherStuff = {read=FOtherStuff, write=FOtherStuff, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_FPO_DATAWrapper(void) { }
	
};


class DELPHICLASS _IMAGE_DEBUG_MISCWrapper;
class PASCALIMPLEMENTATION _IMAGE_DEBUG_MISCWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FDataType;
	unsigned FLength;
	System::ByteBool FUnicode;
	
public:
	__fastcall _IMAGE_DEBUG_MISCWrapper(const _IMAGE_DEBUG_MISC &ARecord);
	_IMAGE_DEBUG_MISC __fastcall ObjToRec(void);
	
__published:
	__property unsigned DataType = {read=FDataType, write=FDataType, nodefault};
	__property unsigned Length = {read=FLength, write=FLength, nodefault};
	__property System::ByteBool Unicode = {read=FUnicode, write=FUnicode, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_IMAGE_DEBUG_MISCWrapper(void) { }
	
};


class DELPHICLASS _IMAGE_FUNCTION_ENTRYWrapper;
class PASCALIMPLEMENTATION _IMAGE_FUNCTION_ENTRYWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FStartingAddress;
	unsigned FEndingAddress;
	unsigned FEndOfPrologue;
	
public:
	__fastcall _IMAGE_FUNCTION_ENTRYWrapper(const _IMAGE_FUNCTION_ENTRY &ARecord);
	_IMAGE_FUNCTION_ENTRY __fastcall ObjToRec(void);
	
__published:
	__property unsigned StartingAddress = {read=FStartingAddress, write=FStartingAddress, nodefault};
	__property unsigned EndingAddress = {read=FEndingAddress, write=FEndingAddress, nodefault};
	__property unsigned EndOfPrologue = {read=FEndOfPrologue, write=FEndOfPrologue, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_IMAGE_FUNCTION_ENTRYWrapper(void) { }
	
};


class DELPHICLASS _RTL_CRITICAL_SECTION_DEBUGWrapper;
class PASCALIMPLEMENTATION _RTL_CRITICAL_SECTION_DEBUGWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	System::Word FType_18;
	System::Word FCreatorBackTraceIndex;
	unsigned FEntryCount;
	unsigned FContentionCount;
	
public:
	__fastcall _RTL_CRITICAL_SECTION_DEBUGWrapper(const _RTL_CRITICAL_SECTION_DEBUG &ARecord);
	_RTL_CRITICAL_SECTION_DEBUG __fastcall ObjToRec(void);
	
__published:
	__property System::Word Type_18 = {read=FType_18, write=FType_18, nodefault};
	__property System::Word CreatorBackTraceIndex = {read=FCreatorBackTraceIndex, write=FCreatorBackTraceIndex, nodefault};
	__property unsigned EntryCount = {read=FEntryCount, write=FEntryCount, nodefault};
	__property unsigned ContentionCount = {read=FContentionCount, write=FContentionCount, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_RTL_CRITICAL_SECTION_DEBUGWrapper(void) { }
	
};


class DELPHICLASS _RTL_CRITICAL_SECTIONWrapper;
class PASCALIMPLEMENTATION _RTL_CRITICAL_SECTIONWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	int FLockCount;
	int FRecursionCount;
	unsigned FOwningThread;
	unsigned FLockSemaphore;
	unsigned FReserved;
	
public:
	__fastcall _RTL_CRITICAL_SECTIONWrapper(const _RTL_CRITICAL_SECTION &ARecord);
	_RTL_CRITICAL_SECTION __fastcall ObjToRec(void);
	
__published:
	__property int LockCount = {read=FLockCount, write=FLockCount, nodefault};
	__property int RecursionCount = {read=FRecursionCount, write=FRecursionCount, nodefault};
	__property unsigned OwningThread = {read=FOwningThread, write=FOwningThread, nodefault};
	__property unsigned LockSemaphore = {read=FLockSemaphore, write=FLockSemaphore, nodefault};
	__property unsigned Reserved = {read=FReserved, write=FReserved, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_RTL_CRITICAL_SECTIONWrapper(void) { }
	
};


class DELPHICLASS _RTL_CONDITION_VARIABLEWrapper;
class PASCALIMPLEMENTATION _RTL_CONDITION_VARIABLEWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
public:
	__fastcall _RTL_CONDITION_VARIABLEWrapper(_RTL_CONDITION_VARIABLE ARecord);
	_RTL_CONDITION_VARIABLE __fastcall ObjToRec(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_RTL_CONDITION_VARIABLEWrapper(void) { }
	
};


class DELPHICLASS _POINTLWrapper;
class PASCALIMPLEMENTATION _POINTLWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	int Fx;
	int Fy;
	
public:
	__fastcall _POINTLWrapper(const _POINTL &ARecord);
	_POINTL __fastcall ObjToRec(void);
	
__published:
	__property int x = {read=Fx, write=Fx, nodefault};
	__property int y = {read=Fy, write=Fy, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_POINTLWrapper(void) { }
	
};


class DELPHICLASS _OVERLAPPEDWrapper;
class PASCALIMPLEMENTATION _OVERLAPPEDWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FInternal;
	unsigned FInternalHigh;
	unsigned FOffset;
	unsigned FOffsetHigh;
	unsigned FhEvent;
	
public:
	__fastcall _OVERLAPPEDWrapper(const _OVERLAPPED &ARecord);
	_OVERLAPPED __fastcall ObjToRec(void);
	
__published:
	__property unsigned Internal = {read=FInternal, write=FInternal, nodefault};
	__property unsigned InternalHigh = {read=FInternalHigh, write=FInternalHigh, nodefault};
	__property unsigned Offset = {read=FOffset, write=FOffset, nodefault};
	__property unsigned OffsetHigh = {read=FOffsetHigh, write=FOffsetHigh, nodefault};
	__property unsigned hEvent = {read=FhEvent, write=FhEvent, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_OVERLAPPEDWrapper(void) { }
	
};


class DELPHICLASS _SECURITY_ATTRIBUTESWrapper;
class PASCALIMPLEMENTATION _SECURITY_ATTRIBUTESWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FnLength;
	BOOL FbInheritHandle;
	
public:
	__fastcall _SECURITY_ATTRIBUTESWrapper(const _SECURITY_ATTRIBUTES &ARecord);
	_SECURITY_ATTRIBUTES __fastcall ObjToRec(void);
	
__published:
	__property unsigned nLength = {read=FnLength, write=FnLength, nodefault};
	__property BOOL bInheritHandle = {read=FbInheritHandle, write=FbInheritHandle, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_SECURITY_ATTRIBUTESWrapper(void) { }
	
};


class DELPHICLASS _PROCESS_INFORMATIONWrapper;
class PASCALIMPLEMENTATION _PROCESS_INFORMATIONWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FhProcess;
	unsigned FhThread;
	unsigned FdwProcessId;
	unsigned FdwThreadId;
	
public:
	__fastcall _PROCESS_INFORMATIONWrapper(const _PROCESS_INFORMATION &ARecord);
	_PROCESS_INFORMATION __fastcall ObjToRec(void);
	
__published:
	__property unsigned hProcess = {read=FhProcess, write=FhProcess, nodefault};
	__property unsigned hThread = {read=FhThread, write=FhThread, nodefault};
	__property unsigned dwProcessId = {read=FdwProcessId, write=FdwProcessId, nodefault};
	__property unsigned dwThreadId = {read=FdwThreadId, write=FdwThreadId, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_PROCESS_INFORMATIONWrapper(void) { }
	
};


class DELPHICLASS _FILETIMEWrapper;
class PASCALIMPLEMENTATION _FILETIMEWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FdwLowDateTime;
	unsigned FdwHighDateTime;
	
public:
	__fastcall _FILETIMEWrapper(const _FILETIME &ARecord);
	_FILETIME __fastcall ObjToRec(void);
	
__published:
	__property unsigned dwLowDateTime = {read=FdwLowDateTime, write=FdwLowDateTime, nodefault};
	__property unsigned dwHighDateTime = {read=FdwHighDateTime, write=FdwHighDateTime, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_FILETIMEWrapper(void) { }
	
};


class DELPHICLASS _SYSTEMTIMEWrapper;
class PASCALIMPLEMENTATION _SYSTEMTIMEWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	System::Word FwYear;
	System::Word FwMonth;
	System::Word FwDayOfWeek;
	System::Word FwDay;
	System::Word FwHour;
	System::Word FwMinute;
	System::Word FwSecond;
	System::Word FwMilliseconds;
	
public:
	__fastcall _SYSTEMTIMEWrapper(const _SYSTEMTIME &ARecord);
	_SYSTEMTIME __fastcall ObjToRec(void);
	
__published:
	__property System::Word wYear = {read=FwYear, write=FwYear, nodefault};
	__property System::Word wMonth = {read=FwMonth, write=FwMonth, nodefault};
	__property System::Word wDayOfWeek = {read=FwDayOfWeek, write=FwDayOfWeek, nodefault};
	__property System::Word wDay = {read=FwDay, write=FwDay, nodefault};
	__property System::Word wHour = {read=FwHour, write=FwHour, nodefault};
	__property System::Word wMinute = {read=FwMinute, write=FwMinute, nodefault};
	__property System::Word wSecond = {read=FwSecond, write=FwSecond, nodefault};
	__property System::Word wMilliseconds = {read=FwMilliseconds, write=FwMilliseconds, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_SYSTEMTIMEWrapper(void) { }
	
};


class DELPHICLASS _COMMPROPWrapper;
class PASCALIMPLEMENTATION _COMMPROPWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	System::Word FwPacketLength;
	System::Word FwPacketVersion;
	unsigned FdwServiceMask;
	unsigned FdwReserved1;
	unsigned FdwMaxTxQueue;
	unsigned FdwMaxRxQueue;
	unsigned FdwMaxBaud;
	unsigned FdwProvSubType;
	unsigned FdwProvCapabilities;
	unsigned FdwSettableParams;
	unsigned FdwSettableBaud;
	System::Word FwSettableData;
	System::Word FwSettableStopParity;
	unsigned FdwCurrentTxQueue;
	unsigned FdwCurrentRxQueue;
	unsigned FdwProvSpec1;
	unsigned FdwProvSpec2;
	
public:
	__fastcall _COMMPROPWrapper(const _COMMPROP &ARecord);
	_COMMPROP __fastcall ObjToRec(void);
	
__published:
	__property System::Word wPacketLength = {read=FwPacketLength, write=FwPacketLength, nodefault};
	__property System::Word wPacketVersion = {read=FwPacketVersion, write=FwPacketVersion, nodefault};
	__property unsigned dwServiceMask = {read=FdwServiceMask, write=FdwServiceMask, nodefault};
	__property unsigned dwReserved1 = {read=FdwReserved1, write=FdwReserved1, nodefault};
	__property unsigned dwMaxTxQueue = {read=FdwMaxTxQueue, write=FdwMaxTxQueue, nodefault};
	__property unsigned dwMaxRxQueue = {read=FdwMaxRxQueue, write=FdwMaxRxQueue, nodefault};
	__property unsigned dwMaxBaud = {read=FdwMaxBaud, write=FdwMaxBaud, nodefault};
	__property unsigned dwProvSubType = {read=FdwProvSubType, write=FdwProvSubType, nodefault};
	__property unsigned dwProvCapabilities = {read=FdwProvCapabilities, write=FdwProvCapabilities, nodefault};
	__property unsigned dwSettableParams = {read=FdwSettableParams, write=FdwSettableParams, nodefault};
	__property unsigned dwSettableBaud = {read=FdwSettableBaud, write=FdwSettableBaud, nodefault};
	__property System::Word wSettableData = {read=FwSettableData, write=FwSettableData, nodefault};
	__property System::Word wSettableStopParity = {read=FwSettableStopParity, write=FwSettableStopParity, nodefault};
	__property unsigned dwCurrentTxQueue = {read=FdwCurrentTxQueue, write=FdwCurrentTxQueue, nodefault};
	__property unsigned dwCurrentRxQueue = {read=FdwCurrentRxQueue, write=FdwCurrentRxQueue, nodefault};
	__property unsigned dwProvSpec1 = {read=FdwProvSpec1, write=FdwProvSpec1, nodefault};
	__property unsigned dwProvSpec2 = {read=FdwProvSpec2, write=FdwProvSpec2, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_COMMPROPWrapper(void) { }
	
};


class DELPHICLASS _COMSTATWrapper;
class PASCALIMPLEMENTATION _COMSTATWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	Windows::TComStateFlags FFlags;
	unsigned FcbInQue;
	unsigned FcbOutQue;
	
public:
	__fastcall _COMSTATWrapper(const _COMSTAT &ARecord);
	_COMSTAT __fastcall ObjToRec(void);
	
__published:
	__property Windows::TComStateFlags Flags = {read=FFlags, write=FFlags, nodefault};
	__property unsigned cbInQue = {read=FcbInQue, write=FcbInQue, nodefault};
	__property unsigned cbOutQue = {read=FcbOutQue, write=FcbOutQue, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_COMSTATWrapper(void) { }
	
};


class DELPHICLASS _DCBWrapper;
class PASCALIMPLEMENTATION _DCBWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FDCBlength;
	unsigned FBaudRate;
	int FFlags;
	System::Word FwReserved;
	System::Word FXonLim;
	System::Word FXoffLim;
	System::Byte FByteSize;
	System::Byte FParity;
	System::Byte FStopBits;
	char FXonChar;
	char FXoffChar;
	char FErrorChar;
	char FEofChar;
	char FEvtChar;
	System::Word FwReserved1;
	
public:
	__fastcall _DCBWrapper(const _DCB &ARecord);
	_DCB __fastcall ObjToRec(void);
	
__published:
	__property unsigned DCBlength = {read=FDCBlength, write=FDCBlength, nodefault};
	__property unsigned BaudRate = {read=FBaudRate, write=FBaudRate, nodefault};
	__property int Flags = {read=FFlags, write=FFlags, nodefault};
	__property System::Word wReserved = {read=FwReserved, write=FwReserved, nodefault};
	__property System::Word XonLim = {read=FXonLim, write=FXonLim, nodefault};
	__property System::Word XoffLim = {read=FXoffLim, write=FXoffLim, nodefault};
	__property System::Byte ByteSize = {read=FByteSize, write=FByteSize, nodefault};
	__property System::Byte Parity = {read=FParity, write=FParity, nodefault};
	__property System::Byte StopBits = {read=FStopBits, write=FStopBits, nodefault};
	__property char XonChar = {read=FXonChar, write=FXonChar, nodefault};
	__property char XoffChar = {read=FXoffChar, write=FXoffChar, nodefault};
	__property char ErrorChar = {read=FErrorChar, write=FErrorChar, nodefault};
	__property char EofChar = {read=FEofChar, write=FEofChar, nodefault};
	__property char EvtChar = {read=FEvtChar, write=FEvtChar, nodefault};
	__property System::Word wReserved1 = {read=FwReserved1, write=FwReserved1, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_DCBWrapper(void) { }
	
};


class DELPHICLASS _COMMTIMEOUTSWrapper;
class PASCALIMPLEMENTATION _COMMTIMEOUTSWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FReadIntervalTimeout;
	unsigned FReadTotalTimeoutMultiplier;
	unsigned FReadTotalTimeoutConstant;
	unsigned FWriteTotalTimeoutMultiplier;
	unsigned FWriteTotalTimeoutConstant;
	
public:
	__fastcall _COMMTIMEOUTSWrapper(const _COMMTIMEOUTS &ARecord);
	_COMMTIMEOUTS __fastcall ObjToRec(void);
	
__published:
	__property unsigned ReadIntervalTimeout = {read=FReadIntervalTimeout, write=FReadIntervalTimeout, nodefault};
	__property unsigned ReadTotalTimeoutMultiplier = {read=FReadTotalTimeoutMultiplier, write=FReadTotalTimeoutMultiplier, nodefault};
	__property unsigned ReadTotalTimeoutConstant = {read=FReadTotalTimeoutConstant, write=FReadTotalTimeoutConstant, nodefault};
	__property unsigned WriteTotalTimeoutMultiplier = {read=FWriteTotalTimeoutMultiplier, write=FWriteTotalTimeoutMultiplier, nodefault};
	__property unsigned WriteTotalTimeoutConstant = {read=FWriteTotalTimeoutConstant, write=FWriteTotalTimeoutConstant, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_COMMTIMEOUTSWrapper(void) { }
	
};


class DELPHICLASS _COMMCONFIGWrapper;
class PASCALIMPLEMENTATION _COMMCONFIGWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FdwSize;
	System::Word FwVersion;
	System::Word FwReserved;
	unsigned FdwProviderSubType;
	unsigned FdwProviderOffset;
	unsigned FdwProviderSize;
	
public:
	__fastcall _COMMCONFIGWrapper(const _COMMCONFIG &ARecord);
	_COMMCONFIG __fastcall ObjToRec(void);
	
__published:
	__property unsigned dwSize = {read=FdwSize, write=FdwSize, nodefault};
	__property System::Word wVersion = {read=FwVersion, write=FwVersion, nodefault};
	__property System::Word wReserved = {read=FwReserved, write=FwReserved, nodefault};
	__property unsigned dwProviderSubType = {read=FdwProviderSubType, write=FdwProviderSubType, nodefault};
	__property unsigned dwProviderOffset = {read=FdwProviderOffset, write=FdwProviderOffset, nodefault};
	__property unsigned dwProviderSize = {read=FdwProviderSize, write=FdwProviderSize, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_COMMCONFIGWrapper(void) { }
	
};


class DELPHICLASS _SYSTEM_INFOWrapper;
class PASCALIMPLEMENTATION _SYSTEM_INFOWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FdwOemId;
	System::Word FwProcessorArchitecture;
	System::Word FwReserved;
	unsigned FdwPageSize;
	unsigned FdwActiveProcessorMask;
	unsigned FdwNumberOfProcessors;
	unsigned FdwProcessorType;
	unsigned FdwAllocationGranularity;
	System::Word FwProcessorLevel;
	System::Word FwProcessorRevision;
	
public:
	__fastcall _SYSTEM_INFOWrapper(const _SYSTEM_INFO &ARecord);
	_SYSTEM_INFO __fastcall ObjToRec(void);
	
__published:
	__property unsigned dwOemId = {read=FdwOemId, write=FdwOemId, nodefault};
	__property System::Word wProcessorArchitecture = {read=FwProcessorArchitecture, write=FwProcessorArchitecture, nodefault};
	__property System::Word wReserved = {read=FwReserved, write=FwReserved, nodefault};
	__property unsigned dwPageSize = {read=FdwPageSize, write=FdwPageSize, nodefault};
	__property unsigned dwActiveProcessorMask = {read=FdwActiveProcessorMask, write=FdwActiveProcessorMask, nodefault};
	__property unsigned dwNumberOfProcessors = {read=FdwNumberOfProcessors, write=FdwNumberOfProcessors, nodefault};
	__property unsigned dwProcessorType = {read=FdwProcessorType, write=FdwProcessorType, nodefault};
	__property unsigned dwAllocationGranularity = {read=FdwAllocationGranularity, write=FdwAllocationGranularity, nodefault};
	__property System::Word wProcessorLevel = {read=FwProcessorLevel, write=FwProcessorLevel, nodefault};
	__property System::Word wProcessorRevision = {read=FwProcessorRevision, write=FwProcessorRevision, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_SYSTEM_INFOWrapper(void) { }
	
};


class DELPHICLASS _MEMORYSTATUSWrapper;
class PASCALIMPLEMENTATION _MEMORYSTATUSWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FdwLength;
	unsigned FdwMemoryLoad;
	unsigned FdwTotalPhys;
	unsigned FdwAvailPhys;
	unsigned FdwTotalPageFile;
	unsigned FdwAvailPageFile;
	unsigned FdwTotalVirtual;
	unsigned FdwAvailVirtual;
	
public:
	__fastcall _MEMORYSTATUSWrapper(const _MEMORYSTATUS &ARecord);
	_MEMORYSTATUS __fastcall ObjToRec(void);
	
__published:
	__property unsigned dwLength = {read=FdwLength, write=FdwLength, nodefault};
	__property unsigned dwMemoryLoad = {read=FdwMemoryLoad, write=FdwMemoryLoad, nodefault};
	__property unsigned dwTotalPhys = {read=FdwTotalPhys, write=FdwTotalPhys, nodefault};
	__property unsigned dwAvailPhys = {read=FdwAvailPhys, write=FdwAvailPhys, nodefault};
	__property unsigned dwTotalPageFile = {read=FdwTotalPageFile, write=FdwTotalPageFile, nodefault};
	__property unsigned dwAvailPageFile = {read=FdwAvailPageFile, write=FdwAvailPageFile, nodefault};
	__property unsigned dwTotalVirtual = {read=FdwTotalVirtual, write=FdwTotalVirtual, nodefault};
	__property unsigned dwAvailVirtual = {read=FdwAvailVirtual, write=FdwAvailVirtual, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_MEMORYSTATUSWrapper(void) { }
	
};


class DELPHICLASS _MEMORYSTATUSEXWrapper;
class PASCALIMPLEMENTATION _MEMORYSTATUSEXWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FdwLength;
	unsigned FdwMemoryLoad;
	unsigned __int64 FullTotalPhys;
	unsigned __int64 FullAvailPhys;
	unsigned __int64 FullTotalPageFile;
	unsigned __int64 FullAvailPageFile;
	unsigned __int64 FullTotalVirtual;
	unsigned __int64 FullAvailVirtual;
	unsigned __int64 FullAvailExtendedVirtual;
	
public:
	__fastcall _MEMORYSTATUSEXWrapper(const _MEMORYSTATUSEX &ARecord);
	_MEMORYSTATUSEX __fastcall ObjToRec(void);
	
__published:
	__property unsigned dwLength = {read=FdwLength, write=FdwLength, nodefault};
	__property unsigned dwMemoryLoad = {read=FdwMemoryLoad, write=FdwMemoryLoad, nodefault};
	__property unsigned __int64 ullTotalPhys = {read=FullTotalPhys, write=FullTotalPhys};
	__property unsigned __int64 ullAvailPhys = {read=FullAvailPhys, write=FullAvailPhys};
	__property unsigned __int64 ullTotalPageFile = {read=FullTotalPageFile, write=FullTotalPageFile};
	__property unsigned __int64 ullAvailPageFile = {read=FullAvailPageFile, write=FullAvailPageFile};
	__property unsigned __int64 ullTotalVirtual = {read=FullTotalVirtual, write=FullTotalVirtual};
	__property unsigned __int64 ullAvailVirtual = {read=FullAvailVirtual, write=FullAvailVirtual};
	__property unsigned __int64 ullAvailExtendedVirtual = {read=FullAvailExtendedVirtual, write=FullAvailExtendedVirtual};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_MEMORYSTATUSEXWrapper(void) { }
	
};


class DELPHICLASS _EXCEPTION_DEBUG_INFOWrapper;
class PASCALIMPLEMENTATION _EXCEPTION_DEBUG_INFOWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FdwFirstChance;
	
public:
	__fastcall _EXCEPTION_DEBUG_INFOWrapper(const _EXCEPTION_DEBUG_INFO &ARecord);
	_EXCEPTION_DEBUG_INFO __fastcall ObjToRec(void);
	
__published:
	__property unsigned dwFirstChance = {read=FdwFirstChance, write=FdwFirstChance, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_EXCEPTION_DEBUG_INFOWrapper(void) { }
	
};


class DELPHICLASS _CREATE_THREAD_DEBUG_INFOWrapper;
class PASCALIMPLEMENTATION _CREATE_THREAD_DEBUG_INFOWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FhThread;
	
public:
	__fastcall _CREATE_THREAD_DEBUG_INFOWrapper(const _CREATE_THREAD_DEBUG_INFO &ARecord);
	_CREATE_THREAD_DEBUG_INFO __fastcall ObjToRec(void);
	
__published:
	__property unsigned hThread = {read=FhThread, write=FhThread, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_CREATE_THREAD_DEBUG_INFOWrapper(void) { }
	
};


class DELPHICLASS _CREATE_PROCESS_DEBUG_INFOWrapper;
class PASCALIMPLEMENTATION _CREATE_PROCESS_DEBUG_INFOWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FhFile;
	unsigned FhProcess;
	unsigned FhThread;
	unsigned FdwDebugInfoFileOffset;
	unsigned FnDebugInfoSize;
	System::Word FfUnicode;
	
public:
	__fastcall _CREATE_PROCESS_DEBUG_INFOWrapper(const _CREATE_PROCESS_DEBUG_INFO &ARecord);
	_CREATE_PROCESS_DEBUG_INFO __fastcall ObjToRec(void);
	
__published:
	__property unsigned hFile = {read=FhFile, write=FhFile, nodefault};
	__property unsigned hProcess = {read=FhProcess, write=FhProcess, nodefault};
	__property unsigned hThread = {read=FhThread, write=FhThread, nodefault};
	__property unsigned dwDebugInfoFileOffset = {read=FdwDebugInfoFileOffset, write=FdwDebugInfoFileOffset, nodefault};
	__property unsigned nDebugInfoSize = {read=FnDebugInfoSize, write=FnDebugInfoSize, nodefault};
	__property System::Word fUnicode = {read=FfUnicode, write=FfUnicode, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_CREATE_PROCESS_DEBUG_INFOWrapper(void) { }
	
};


class DELPHICLASS _EXIT_THREAD_DEBUG_INFOWrapper;
class PASCALIMPLEMENTATION _EXIT_THREAD_DEBUG_INFOWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FdwExitCode;
	
public:
	__fastcall _EXIT_THREAD_DEBUG_INFOWrapper(_EXIT_THREAD_DEBUG_INFO ARecord);
	_EXIT_THREAD_DEBUG_INFO __fastcall ObjToRec(void);
	
__published:
	__property unsigned dwExitCode = {read=FdwExitCode, write=FdwExitCode, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_EXIT_THREAD_DEBUG_INFOWrapper(void) { }
	
};


class DELPHICLASS _EXIT_PROCESS_DEBUG_INFOWrapper;
class PASCALIMPLEMENTATION _EXIT_PROCESS_DEBUG_INFOWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FdwExitCode;
	
public:
	__fastcall _EXIT_PROCESS_DEBUG_INFOWrapper(_EXIT_PROCESS_DEBUG_INFO ARecord);
	_EXIT_PROCESS_DEBUG_INFO __fastcall ObjToRec(void);
	
__published:
	__property unsigned dwExitCode = {read=FdwExitCode, write=FdwExitCode, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_EXIT_PROCESS_DEBUG_INFOWrapper(void) { }
	
};


class DELPHICLASS _LOAD_DLL_DEBUG_INFOWrapper;
class PASCALIMPLEMENTATION _LOAD_DLL_DEBUG_INFOWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FhFile;
	unsigned FdwDebugInfoFileOffset;
	unsigned FnDebugInfoSize;
	System::Word FfUnicode;
	
public:
	__fastcall _LOAD_DLL_DEBUG_INFOWrapper(const _LOAD_DLL_DEBUG_INFO &ARecord);
	_LOAD_DLL_DEBUG_INFO __fastcall ObjToRec(void);
	
__published:
	__property unsigned hFile = {read=FhFile, write=FhFile, nodefault};
	__property unsigned dwDebugInfoFileOffset = {read=FdwDebugInfoFileOffset, write=FdwDebugInfoFileOffset, nodefault};
	__property unsigned nDebugInfoSize = {read=FnDebugInfoSize, write=FnDebugInfoSize, nodefault};
	__property System::Word fUnicode = {read=FfUnicode, write=FfUnicode, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_LOAD_DLL_DEBUG_INFOWrapper(void) { }
	
};


class DELPHICLASS _UNLOAD_DLL_DEBUG_INFOWrapper;
class PASCALIMPLEMENTATION _UNLOAD_DLL_DEBUG_INFOWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
public:
	__fastcall _UNLOAD_DLL_DEBUG_INFOWrapper(_UNLOAD_DLL_DEBUG_INFO ARecord);
	_UNLOAD_DLL_DEBUG_INFO __fastcall ObjToRec(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_UNLOAD_DLL_DEBUG_INFOWrapper(void) { }
	
};


class DELPHICLASS _OUTPUT_DEBUG_STRING_INFOWrapper;
class PASCALIMPLEMENTATION _OUTPUT_DEBUG_STRING_INFOWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	System::Word FfUnicode;
	System::Word FnDebugStringLength;
	
public:
	__fastcall _OUTPUT_DEBUG_STRING_INFOWrapper(const _OUTPUT_DEBUG_STRING_INFO &ARecord);
	_OUTPUT_DEBUG_STRING_INFO __fastcall ObjToRec(void);
	
__published:
	__property System::Word fUnicode = {read=FfUnicode, write=FfUnicode, nodefault};
	__property System::Word nDebugStringLength = {read=FnDebugStringLength, write=FnDebugStringLength, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_OUTPUT_DEBUG_STRING_INFOWrapper(void) { }
	
};


class DELPHICLASS _RIP_INFOWrapper;
class PASCALIMPLEMENTATION _RIP_INFOWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FdwError;
	unsigned FdwType;
	
public:
	__fastcall _RIP_INFOWrapper(const _RIP_INFO &ARecord);
	_RIP_INFO __fastcall ObjToRec(void);
	
__published:
	__property unsigned dwError = {read=FdwError, write=FdwError, nodefault};
	__property unsigned dwType = {read=FdwType, write=FdwType, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_RIP_INFOWrapper(void) { }
	
};


class DELPHICLASS _DEBUG_EVENTWrapper;
class PASCALIMPLEMENTATION _DEBUG_EVENTWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FdwDebugEventCode;
	unsigned FdwProcessId;
	unsigned FdwThreadId;
	
public:
	__fastcall _DEBUG_EVENTWrapper(const _DEBUG_EVENT &ARecord);
	_DEBUG_EVENT __fastcall ObjToRec(void);
	
__published:
	__property unsigned dwDebugEventCode = {read=FdwDebugEventCode, write=FdwDebugEventCode, nodefault};
	__property unsigned dwProcessId = {read=FdwProcessId, write=FdwProcessId, nodefault};
	__property unsigned dwThreadId = {read=FdwThreadId, write=FdwThreadId, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_DEBUG_EVENTWrapper(void) { }
	
};


class DELPHICLASS _OFSTRUCTWrapper;
class PASCALIMPLEMENTATION _OFSTRUCTWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	System::Byte FcBytes;
	System::Byte FfFixedDisk;
	System::Word FnErrCode;
	System::Word FReserved1;
	System::Word FReserved2;
	
public:
	__fastcall _OFSTRUCTWrapper(const _OFSTRUCT &ARecord);
	_OFSTRUCT __fastcall ObjToRec(void);
	
__published:
	__property System::Byte cBytes = {read=FcBytes, write=FcBytes, nodefault};
	__property System::Byte fFixedDisk = {read=FfFixedDisk, write=FfFixedDisk, nodefault};
	__property System::Word nErrCode = {read=FnErrCode, write=FnErrCode, nodefault};
	__property System::Word Reserved1 = {read=FReserved1, write=FReserved1, nodefault};
	__property System::Word Reserved2 = {read=FReserved2, write=FReserved2, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_OFSTRUCTWrapper(void) { }
	
};


class DELPHICLASS _PROCESS_HEAP_ENTRYWrapper;
class PASCALIMPLEMENTATION _PROCESS_HEAP_ENTRYWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FcbData;
	System::Byte FcbOverhead;
	System::Byte FiRegionIndex;
	System::Word FwFlags;
	unsigned FhMem;
	unsigned FdwCommittedSize;
	unsigned FdwUnCommittedSize;
	
public:
	__fastcall _PROCESS_HEAP_ENTRYWrapper(const _PROCESS_HEAP_ENTRY &ARecord);
	_PROCESS_HEAP_ENTRY __fastcall ObjToRec(void);
	
__published:
	__property unsigned cbData = {read=FcbData, write=FcbData, nodefault};
	__property System::Byte cbOverhead = {read=FcbOverhead, write=FcbOverhead, nodefault};
	__property System::Byte iRegionIndex = {read=FiRegionIndex, write=FiRegionIndex, nodefault};
	__property System::Word wFlags = {read=FwFlags, write=FwFlags, nodefault};
	__property unsigned hMem = {read=FhMem, write=FhMem, nodefault};
	__property unsigned dwCommittedSize = {read=FdwCommittedSize, write=FdwCommittedSize, nodefault};
	__property unsigned dwUnCommittedSize = {read=FdwUnCommittedSize, write=FdwUnCommittedSize, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_PROCESS_HEAP_ENTRYWrapper(void) { }
	
};


class DELPHICLASS _BY_HANDLE_FILE_INFORMATIONWrapper;
class PASCALIMPLEMENTATION _BY_HANDLE_FILE_INFORMATIONWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FdwFileAttributes;
	unsigned FdwVolumeSerialNumber;
	unsigned FnFileSizeHigh;
	unsigned FnFileSizeLow;
	unsigned FnNumberOfLinks;
	unsigned FnFileIndexHigh;
	unsigned FnFileIndexLow;
	
public:
	__fastcall _BY_HANDLE_FILE_INFORMATIONWrapper(const _BY_HANDLE_FILE_INFORMATION &ARecord);
	_BY_HANDLE_FILE_INFORMATION __fastcall ObjToRec(void);
	
__published:
	__property unsigned dwFileAttributes = {read=FdwFileAttributes, write=FdwFileAttributes, nodefault};
	__property unsigned dwVolumeSerialNumber = {read=FdwVolumeSerialNumber, write=FdwVolumeSerialNumber, nodefault};
	__property unsigned nFileSizeHigh = {read=FnFileSizeHigh, write=FnFileSizeHigh, nodefault};
	__property unsigned nFileSizeLow = {read=FnFileSizeLow, write=FnFileSizeLow, nodefault};
	__property unsigned nNumberOfLinks = {read=FnNumberOfLinks, write=FnNumberOfLinks, nodefault};
	__property unsigned nFileIndexHigh = {read=FnFileIndexHigh, write=FnFileIndexHigh, nodefault};
	__property unsigned nFileIndexLow = {read=FnFileIndexLow, write=FnFileIndexLow, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_BY_HANDLE_FILE_INFORMATIONWrapper(void) { }
	
};


class DELPHICLASS _TIME_ZONE_INFORMATIONWrapper;
class PASCALIMPLEMENTATION _TIME_ZONE_INFORMATIONWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	int FBias;
	int FStandardBias;
	int FDaylightBias;
	
public:
	__fastcall _TIME_ZONE_INFORMATIONWrapper(const _TIME_ZONE_INFORMATION &ARecord);
	_TIME_ZONE_INFORMATION __fastcall ObjToRec(void);
	
__published:
	__property int Bias = {read=FBias, write=FBias, nodefault};
	__property int StandardBias = {read=FStandardBias, write=FStandardBias, nodefault};
	__property int DaylightBias = {read=FDaylightBias, write=FDaylightBias, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_TIME_ZONE_INFORMATIONWrapper(void) { }
	
};


class DELPHICLASS _TIME_DYNAMIC_ZONE_INFORMATIONWrapper;
class PASCALIMPLEMENTATION _TIME_DYNAMIC_ZONE_INFORMATIONWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	int FBias;
	int FStandardBias;
	int FDaylightBias;
	bool FDynamicDaylightTimeDisabled;
	
public:
	__fastcall _TIME_DYNAMIC_ZONE_INFORMATIONWrapper(const _TIME_DYNAMIC_ZONE_INFORMATION &ARecord);
	_TIME_DYNAMIC_ZONE_INFORMATION __fastcall ObjToRec(void);
	
__published:
	__property int Bias = {read=FBias, write=FBias, nodefault};
	__property int StandardBias = {read=FStandardBias, write=FStandardBias, nodefault};
	__property int DaylightBias = {read=FDaylightBias, write=FDaylightBias, nodefault};
	__property bool DynamicDaylightTimeDisabled = {read=FDynamicDaylightTimeDisabled, write=FDynamicDaylightTimeDisabled, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_TIME_DYNAMIC_ZONE_INFORMATIONWrapper(void) { }
	
};


class DELPHICLASS _RECOVERY_AGENT_INFORMATIONAWrapper;
class PASCALIMPLEMENTATION _RECOVERY_AGENT_INFORMATIONAWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FNextEntryOffset;
	unsigned FAgentNameLength;
	
public:
	__fastcall _RECOVERY_AGENT_INFORMATIONAWrapper(const Windows::_RECOVERY_AGENT_INFORMATIONA &ARecord);
	Windows::_RECOVERY_AGENT_INFORMATIONA __fastcall ObjToRec(void);
	
__published:
	__property unsigned NextEntryOffset = {read=FNextEntryOffset, write=FNextEntryOffset, nodefault};
	__property unsigned AgentNameLength = {read=FAgentNameLength, write=FAgentNameLength, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_RECOVERY_AGENT_INFORMATIONAWrapper(void) { }
	
};


class DELPHICLASS _RECOVERY_AGENT_INFORMATIONWWrapper;
class PASCALIMPLEMENTATION _RECOVERY_AGENT_INFORMATIONWWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FNextEntryOffset;
	unsigned FAgentNameLength;
	
public:
	__fastcall _RECOVERY_AGENT_INFORMATIONWWrapper(const Windows::_RECOVERY_AGENT_INFORMATIONW &ARecord);
	Windows::_RECOVERY_AGENT_INFORMATIONW __fastcall ObjToRec(void);
	
__published:
	__property unsigned NextEntryOffset = {read=FNextEntryOffset, write=FNextEntryOffset, nodefault};
	__property unsigned AgentNameLength = {read=FAgentNameLength, write=FAgentNameLength, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_RECOVERY_AGENT_INFORMATIONWWrapper(void) { }
	
};


class DELPHICLASS _WIN32_STREAM_IDWrapper;
class PASCALIMPLEMENTATION _WIN32_STREAM_IDWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FdwStreamId;
	unsigned FdwStreamAttributes;
	__int64 FSize;
	unsigned FdwStreamNameSize;
	
public:
	__fastcall _WIN32_STREAM_IDWrapper(const _WIN32_STREAM_ID &ARecord);
	_WIN32_STREAM_ID __fastcall ObjToRec(void);
	
__published:
	__property unsigned dwStreamId = {read=FdwStreamId, write=FdwStreamId, nodefault};
	__property unsigned dwStreamAttributes = {read=FdwStreamAttributes, write=FdwStreamAttributes, nodefault};
	__property __int64 Size = {read=FSize, write=FSize};
	__property unsigned dwStreamNameSize = {read=FdwStreamNameSize, write=FdwStreamNameSize, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_WIN32_STREAM_IDWrapper(void) { }
	
};


class DELPHICLASS _STARTUPINFOAWrapper;
class PASCALIMPLEMENTATION _STARTUPINFOAWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned Fcb;
	unsigned FdwX;
	unsigned FdwY;
	unsigned FdwXSize;
	unsigned FdwYSize;
	unsigned FdwXCountChars;
	unsigned FdwYCountChars;
	unsigned FdwFillAttribute;
	unsigned FdwFlags;
	System::Word FwShowWindow;
	System::Word FcbReserved2;
	unsigned FhStdInput;
	unsigned FhStdOutput;
	unsigned FhStdError;
	
public:
	__fastcall _STARTUPINFOAWrapper(const Windows::_STARTUPINFOA &ARecord);
	Windows::_STARTUPINFOA __fastcall ObjToRec(void);
	
__published:
	__property unsigned cb = {read=Fcb, write=Fcb, nodefault};
	__property unsigned dwX = {read=FdwX, write=FdwX, nodefault};
	__property unsigned dwY = {read=FdwY, write=FdwY, nodefault};
	__property unsigned dwXSize = {read=FdwXSize, write=FdwXSize, nodefault};
	__property unsigned dwYSize = {read=FdwYSize, write=FdwYSize, nodefault};
	__property unsigned dwXCountChars = {read=FdwXCountChars, write=FdwXCountChars, nodefault};
	__property unsigned dwYCountChars = {read=FdwYCountChars, write=FdwYCountChars, nodefault};
	__property unsigned dwFillAttribute = {read=FdwFillAttribute, write=FdwFillAttribute, nodefault};
	__property unsigned dwFlags = {read=FdwFlags, write=FdwFlags, nodefault};
	__property System::Word wShowWindow = {read=FwShowWindow, write=FwShowWindow, nodefault};
	__property System::Word cbReserved2 = {read=FcbReserved2, write=FcbReserved2, nodefault};
	__property unsigned hStdInput = {read=FhStdInput, write=FhStdInput, nodefault};
	__property unsigned hStdOutput = {read=FhStdOutput, write=FhStdOutput, nodefault};
	__property unsigned hStdError = {read=FhStdError, write=FhStdError, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_STARTUPINFOAWrapper(void) { }
	
};


class DELPHICLASS _STARTUPINFOWWrapper;
class PASCALIMPLEMENTATION _STARTUPINFOWWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned Fcb;
	unsigned FdwX;
	unsigned FdwY;
	unsigned FdwXSize;
	unsigned FdwYSize;
	unsigned FdwXCountChars;
	unsigned FdwYCountChars;
	unsigned FdwFillAttribute;
	unsigned FdwFlags;
	System::Word FwShowWindow;
	System::Word FcbReserved2;
	unsigned FhStdInput;
	unsigned FhStdOutput;
	unsigned FhStdError;
	
public:
	__fastcall _STARTUPINFOWWrapper(const Windows::_STARTUPINFOW &ARecord);
	Windows::_STARTUPINFOW __fastcall ObjToRec(void);
	
__published:
	__property unsigned cb = {read=Fcb, write=Fcb, nodefault};
	__property unsigned dwX = {read=FdwX, write=FdwX, nodefault};
	__property unsigned dwY = {read=FdwY, write=FdwY, nodefault};
	__property unsigned dwXSize = {read=FdwXSize, write=FdwXSize, nodefault};
	__property unsigned dwYSize = {read=FdwYSize, write=FdwYSize, nodefault};
	__property unsigned dwXCountChars = {read=FdwXCountChars, write=FdwXCountChars, nodefault};
	__property unsigned dwYCountChars = {read=FdwYCountChars, write=FdwYCountChars, nodefault};
	__property unsigned dwFillAttribute = {read=FdwFillAttribute, write=FdwFillAttribute, nodefault};
	__property unsigned dwFlags = {read=FdwFlags, write=FdwFlags, nodefault};
	__property System::Word wShowWindow = {read=FwShowWindow, write=FwShowWindow, nodefault};
	__property System::Word cbReserved2 = {read=FcbReserved2, write=FcbReserved2, nodefault};
	__property unsigned hStdInput = {read=FhStdInput, write=FhStdInput, nodefault};
	__property unsigned hStdOutput = {read=FhStdOutput, write=FhStdOutput, nodefault};
	__property unsigned hStdError = {read=FhStdError, write=FhStdError, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_STARTUPINFOWWrapper(void) { }
	
};


class DELPHICLASS _WIN32_FIND_DATAAWrapper;
class PASCALIMPLEMENTATION _WIN32_FIND_DATAAWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FdwFileAttributes;
	unsigned FnFileSizeHigh;
	unsigned FnFileSizeLow;
	unsigned FdwReserved0;
	unsigned FdwReserved1;
	
public:
	__fastcall _WIN32_FIND_DATAAWrapper(const _WIN32_FIND_DATAA &ARecord);
	_WIN32_FIND_DATAA __fastcall ObjToRec(void);
	
__published:
	__property unsigned dwFileAttributes = {read=FdwFileAttributes, write=FdwFileAttributes, nodefault};
	__property unsigned nFileSizeHigh = {read=FnFileSizeHigh, write=FnFileSizeHigh, nodefault};
	__property unsigned nFileSizeLow = {read=FnFileSizeLow, write=FnFileSizeLow, nodefault};
	__property unsigned dwReserved0 = {read=FdwReserved0, write=FdwReserved0, nodefault};
	__property unsigned dwReserved1 = {read=FdwReserved1, write=FdwReserved1, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_WIN32_FIND_DATAAWrapper(void) { }
	
};


class DELPHICLASS _WIN32_FIND_DATAWWrapper;
class PASCALIMPLEMENTATION _WIN32_FIND_DATAWWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FdwFileAttributes;
	unsigned FnFileSizeHigh;
	unsigned FnFileSizeLow;
	unsigned FdwReserved0;
	unsigned FdwReserved1;
	
public:
	__fastcall _WIN32_FIND_DATAWWrapper(const _WIN32_FIND_DATAW &ARecord);
	_WIN32_FIND_DATAW __fastcall ObjToRec(void);
	
__published:
	__property unsigned dwFileAttributes = {read=FdwFileAttributes, write=FdwFileAttributes, nodefault};
	__property unsigned nFileSizeHigh = {read=FnFileSizeHigh, write=FnFileSizeHigh, nodefault};
	__property unsigned nFileSizeLow = {read=FnFileSizeLow, write=FnFileSizeLow, nodefault};
	__property unsigned dwReserved0 = {read=FdwReserved0, write=FdwReserved0, nodefault};
	__property unsigned dwReserved1 = {read=FdwReserved1, write=FdwReserved1, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_WIN32_FIND_DATAWWrapper(void) { }
	
};


class DELPHICLASS _WIN32_FILE_ATTRIBUTE_DATAWrapper;
class PASCALIMPLEMENTATION _WIN32_FILE_ATTRIBUTE_DATAWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FdwFileAttributes;
	unsigned FnFileSizeHigh;
	unsigned FnFileSizeLow;
	
public:
	__fastcall _WIN32_FILE_ATTRIBUTE_DATAWrapper(const _WIN32_FILE_ATTRIBUTE_DATA &ARecord);
	_WIN32_FILE_ATTRIBUTE_DATA __fastcall ObjToRec(void);
	
__published:
	__property unsigned dwFileAttributes = {read=FdwFileAttributes, write=FdwFileAttributes, nodefault};
	__property unsigned nFileSizeHigh = {read=FnFileSizeHigh, write=FnFileSizeHigh, nodefault};
	__property unsigned nFileSizeLow = {read=FnFileSizeLow, write=FnFileSizeLow, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_WIN32_FILE_ATTRIBUTE_DATAWrapper(void) { }
	
};


class DELPHICLASS tagHW_PROFILE_INFOAWrapper;
class PASCALIMPLEMENTATION tagHW_PROFILE_INFOAWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FdwDockInfo;
	
public:
	__fastcall tagHW_PROFILE_INFOAWrapper(const tagHW_PROFILE_INFOA &ARecord);
	tagHW_PROFILE_INFOA __fastcall ObjToRec(void);
	
__published:
	__property unsigned dwDockInfo = {read=FdwDockInfo, write=FdwDockInfo, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagHW_PROFILE_INFOAWrapper(void) { }
	
};


class DELPHICLASS tagHW_PROFILE_INFOWWrapper;
class PASCALIMPLEMENTATION tagHW_PROFILE_INFOWWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FdwDockInfo;
	
public:
	__fastcall tagHW_PROFILE_INFOWWrapper(const tagHW_PROFILE_INFOW &ARecord);
	tagHW_PROFILE_INFOW __fastcall ObjToRec(void);
	
__published:
	__property unsigned dwDockInfo = {read=FdwDockInfo, write=FdwDockInfo, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagHW_PROFILE_INFOWWrapper(void) { }
	
};


class DELPHICLASS _OSVERSIONINFOAWrapper;
class PASCALIMPLEMENTATION _OSVERSIONINFOAWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FdwOSVersionInfoSize;
	unsigned FdwMajorVersion;
	unsigned FdwMinorVersion;
	unsigned FdwBuildNumber;
	unsigned FdwPlatformId;
	
public:
	__fastcall _OSVERSIONINFOAWrapper(const _OSVERSIONINFOA &ARecord);
	_OSVERSIONINFOA __fastcall ObjToRec(void);
	
__published:
	__property unsigned dwOSVersionInfoSize = {read=FdwOSVersionInfoSize, write=FdwOSVersionInfoSize, nodefault};
	__property unsigned dwMajorVersion = {read=FdwMajorVersion, write=FdwMajorVersion, nodefault};
	__property unsigned dwMinorVersion = {read=FdwMinorVersion, write=FdwMinorVersion, nodefault};
	__property unsigned dwBuildNumber = {read=FdwBuildNumber, write=FdwBuildNumber, nodefault};
	__property unsigned dwPlatformId = {read=FdwPlatformId, write=FdwPlatformId, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_OSVERSIONINFOAWrapper(void) { }
	
};


class DELPHICLASS _OSVERSIONINFOWWrapper;
class PASCALIMPLEMENTATION _OSVERSIONINFOWWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FdwOSVersionInfoSize;
	unsigned FdwMajorVersion;
	unsigned FdwMinorVersion;
	unsigned FdwBuildNumber;
	unsigned FdwPlatformId;
	
public:
	__fastcall _OSVERSIONINFOWWrapper(const _OSVERSIONINFOW &ARecord);
	_OSVERSIONINFOW __fastcall ObjToRec(void);
	
__published:
	__property unsigned dwOSVersionInfoSize = {read=FdwOSVersionInfoSize, write=FdwOSVersionInfoSize, nodefault};
	__property unsigned dwMajorVersion = {read=FdwMajorVersion, write=FdwMajorVersion, nodefault};
	__property unsigned dwMinorVersion = {read=FdwMinorVersion, write=FdwMinorVersion, nodefault};
	__property unsigned dwBuildNumber = {read=FdwBuildNumber, write=FdwBuildNumber, nodefault};
	__property unsigned dwPlatformId = {read=FdwPlatformId, write=FdwPlatformId, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_OSVERSIONINFOWWrapper(void) { }
	
};


class DELPHICLASS _OSVERSIONINFOEXAWrapper;
class PASCALIMPLEMENTATION _OSVERSIONINFOEXAWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FdwOSVersionInfoSize;
	unsigned FdwMajorVersion;
	unsigned FdwMinorVersion;
	unsigned FdwBuildNumber;
	unsigned FdwPlatformId;
	System::Word FwServicePackMajor;
	System::Word FwServicePackMinor;
	System::Word FwSuiteMask;
	System::Byte FwProductType;
	System::Byte FwReserved;
	
public:
	__fastcall _OSVERSIONINFOEXAWrapper(const _OSVERSIONINFOEXA &ARecord);
	_OSVERSIONINFOEXA __fastcall ObjToRec(void);
	
__published:
	__property unsigned dwOSVersionInfoSize = {read=FdwOSVersionInfoSize, write=FdwOSVersionInfoSize, nodefault};
	__property unsigned dwMajorVersion = {read=FdwMajorVersion, write=FdwMajorVersion, nodefault};
	__property unsigned dwMinorVersion = {read=FdwMinorVersion, write=FdwMinorVersion, nodefault};
	__property unsigned dwBuildNumber = {read=FdwBuildNumber, write=FdwBuildNumber, nodefault};
	__property unsigned dwPlatformId = {read=FdwPlatformId, write=FdwPlatformId, nodefault};
	__property System::Word wServicePackMajor = {read=FwServicePackMajor, write=FwServicePackMajor, nodefault};
	__property System::Word wServicePackMinor = {read=FwServicePackMinor, write=FwServicePackMinor, nodefault};
	__property System::Word wSuiteMask = {read=FwSuiteMask, write=FwSuiteMask, nodefault};
	__property System::Byte wProductType = {read=FwProductType, write=FwProductType, nodefault};
	__property System::Byte wReserved = {read=FwReserved, write=FwReserved, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_OSVERSIONINFOEXAWrapper(void) { }
	
};


class DELPHICLASS _OSVERSIONINFOEXWWrapper;
class PASCALIMPLEMENTATION _OSVERSIONINFOEXWWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FdwOSVersionInfoSize;
	unsigned FdwMajorVersion;
	unsigned FdwMinorVersion;
	unsigned FdwBuildNumber;
	unsigned FdwPlatformId;
	System::Word FwServicePackMajor;
	System::Word FwServicePackMinor;
	System::Word FwSuiteMask;
	System::Byte FwProductType;
	System::Byte FwReserved;
	
public:
	__fastcall _OSVERSIONINFOEXWWrapper(const _OSVERSIONINFOEXW &ARecord);
	_OSVERSIONINFOEXW __fastcall ObjToRec(void);
	
__published:
	__property unsigned dwOSVersionInfoSize = {read=FdwOSVersionInfoSize, write=FdwOSVersionInfoSize, nodefault};
	__property unsigned dwMajorVersion = {read=FdwMajorVersion, write=FdwMajorVersion, nodefault};
	__property unsigned dwMinorVersion = {read=FdwMinorVersion, write=FdwMinorVersion, nodefault};
	__property unsigned dwBuildNumber = {read=FdwBuildNumber, write=FdwBuildNumber, nodefault};
	__property unsigned dwPlatformId = {read=FdwPlatformId, write=FdwPlatformId, nodefault};
	__property System::Word wServicePackMajor = {read=FwServicePackMajor, write=FwServicePackMajor, nodefault};
	__property System::Word wServicePackMinor = {read=FwServicePackMinor, write=FwServicePackMinor, nodefault};
	__property System::Word wSuiteMask = {read=FwSuiteMask, write=FwSuiteMask, nodefault};
	__property System::Byte wProductType = {read=FwProductType, write=FwProductType, nodefault};
	__property System::Byte wReserved = {read=FwReserved, write=FwReserved, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_OSVERSIONINFOEXWWrapper(void) { }
	
};


class DELPHICLASS _SYSTEM_POWER_STATUSWrapper;
class PASCALIMPLEMENTATION _SYSTEM_POWER_STATUSWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	System::Byte FACLineStatus;
	System::Byte FBatteryFlag;
	System::Byte FBatteryLifePercent;
	System::Byte FReserved1;
	unsigned FBatteryLifeTime;
	unsigned FBatteryFullLifeTime;
	
public:
	__fastcall _SYSTEM_POWER_STATUSWrapper(const _SYSTEM_POWER_STATUS &ARecord);
	_SYSTEM_POWER_STATUS __fastcall ObjToRec(void);
	
__published:
	__property System::Byte ACLineStatus = {read=FACLineStatus, write=FACLineStatus, nodefault};
	__property System::Byte BatteryFlag = {read=FBatteryFlag, write=FBatteryFlag, nodefault};
	__property System::Byte BatteryLifePercent = {read=FBatteryLifePercent, write=FBatteryLifePercent, nodefault};
	__property System::Byte Reserved1 = {read=FReserved1, write=FReserved1, nodefault};
	__property unsigned BatteryLifeTime = {read=FBatteryLifeTime, write=FBatteryLifeTime, nodefault};
	__property unsigned BatteryFullLifeTime = {read=FBatteryFullLifeTime, write=FBatteryFullLifeTime, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_SYSTEM_POWER_STATUSWrapper(void) { }
	
};


class DELPHICLASS _WIN_CERTIFICATEWrapper;
class PASCALIMPLEMENTATION _WIN_CERTIFICATEWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FdwLength;
	System::Word FwRevision;
	System::Word FwCertificateType;
	
public:
	__fastcall _WIN_CERTIFICATEWrapper(const _WIN_CERTIFICATE &ARecord);
	_WIN_CERTIFICATE __fastcall ObjToRec(void);
	
__published:
	__property unsigned dwLength = {read=FdwLength, write=FdwLength, nodefault};
	__property System::Word wRevision = {read=FwRevision, write=FwRevision, nodefault};
	__property System::Word wCertificateType = {read=FwCertificateType, write=FwCertificateType, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_WIN_CERTIFICATEWrapper(void) { }
	
};


class DELPHICLASS _WIN_TRUST_ACTDATA_CONTEXT_WITH_SUBJECTWrapper;
class PASCALIMPLEMENTATION _WIN_TRUST_ACTDATA_CONTEXT_WITH_SUBJECTWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FhClientToken;
	
public:
	__fastcall _WIN_TRUST_ACTDATA_CONTEXT_WITH_SUBJECTWrapper(const _WIN_TRUST_ACTDATA_CONTEXT_WITH_SUBJECT &ARecord);
	_WIN_TRUST_ACTDATA_CONTEXT_WITH_SUBJECT __fastcall ObjToRec(void);
	
__published:
	__property unsigned hClientToken = {read=FhClientToken, write=FhClientToken, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_WIN_TRUST_ACTDATA_CONTEXT_WITH_SUBJECTWrapper(void) { }
	
};


class DELPHICLASS _WIN_TRUST_ACTDATA_SUBJECT_ONLYWrapper;
class PASCALIMPLEMENTATION _WIN_TRUST_ACTDATA_SUBJECT_ONLYWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
public:
	__fastcall _WIN_TRUST_ACTDATA_SUBJECT_ONLYWrapper(const _WIN_TRUST_ACTDATA_SUBJECT_ONLY &ARecord);
	_WIN_TRUST_ACTDATA_SUBJECT_ONLY __fastcall ObjToRec(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_WIN_TRUST_ACTDATA_SUBJECT_ONLYWrapper(void) { }
	
};


class DELPHICLASS _WIN_TRUST_SUBJECT_FILEWrapper;
class PASCALIMPLEMENTATION _WIN_TRUST_SUBJECT_FILEWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FhFile;
	
public:
	__fastcall _WIN_TRUST_SUBJECT_FILEWrapper(const _WIN_TRUST_SUBJECT_FILE &ARecord);
	_WIN_TRUST_SUBJECT_FILE __fastcall ObjToRec(void);
	
__published:
	__property unsigned hFile = {read=FhFile, write=FhFile, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_WIN_TRUST_SUBJECT_FILEWrapper(void) { }
	
};


class DELPHICLASS _WIN_TRUST_SUBJECT_FILE_AND_DISPLAYWrapper;
class PASCALIMPLEMENTATION _WIN_TRUST_SUBJECT_FILE_AND_DISPLAYWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FhFile;
	
public:
	__fastcall _WIN_TRUST_SUBJECT_FILE_AND_DISPLAYWrapper(const _WIN_TRUST_SUBJECT_FILE_AND_DISPLAY &ARecord);
	_WIN_TRUST_SUBJECT_FILE_AND_DISPLAY __fastcall ObjToRec(void);
	
__published:
	__property unsigned hFile = {read=FhFile, write=FhFile, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_WIN_TRUST_SUBJECT_FILE_AND_DISPLAYWrapper(void) { }
	
};


class DELPHICLASS _WIN_SPUB_TRUSTED_PUBLISHER_DATAWrapper;
class PASCALIMPLEMENTATION _WIN_SPUB_TRUSTED_PUBLISHER_DATAWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FhClientToken;
	
public:
	__fastcall _WIN_SPUB_TRUSTED_PUBLISHER_DATAWrapper(const _WIN_SPUB_TRUSTED_PUBLISHER_DATA &ARecord);
	_WIN_SPUB_TRUSTED_PUBLISHER_DATA __fastcall ObjToRec(void);
	
__published:
	__property unsigned hClientToken = {read=FhClientToken, write=FhClientToken, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_WIN_SPUB_TRUSTED_PUBLISHER_DATAWrapper(void) { }
	
};


class DELPHICLASS tagXFORMWrapper;
class PASCALIMPLEMENTATION tagXFORMWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	float FeM11;
	float FeM12;
	float FeM21;
	float FeM22;
	float FeDx;
	float FeDy;
	
public:
	__fastcall tagXFORMWrapper(const tagXFORM &ARecord);
	tagXFORM __fastcall ObjToRec(void);
	
__published:
	__property float eM11 = {read=FeM11, write=FeM11};
	__property float eM12 = {read=FeM12, write=FeM12};
	__property float eM21 = {read=FeM21, write=FeM21};
	__property float eM22 = {read=FeM22, write=FeM22};
	__property float eDx = {read=FeDx, write=FeDx};
	__property float eDy = {read=FeDy, write=FeDy};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagXFORMWrapper(void) { }
	
};


class DELPHICLASS tagBITMAPWrapper;
class PASCALIMPLEMENTATION tagBITMAPWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	int FbmType;
	int FbmWidth;
	int FbmHeight;
	int FbmWidthBytes;
	System::Word FbmPlanes;
	System::Word FbmBitsPixel;
	
public:
	__fastcall tagBITMAPWrapper(const tagBITMAP &ARecord);
	tagBITMAP __fastcall ObjToRec(void);
	
__published:
	__property int bmType = {read=FbmType, write=FbmType, nodefault};
	__property int bmWidth = {read=FbmWidth, write=FbmWidth, nodefault};
	__property int bmHeight = {read=FbmHeight, write=FbmHeight, nodefault};
	__property int bmWidthBytes = {read=FbmWidthBytes, write=FbmWidthBytes, nodefault};
	__property System::Word bmPlanes = {read=FbmPlanes, write=FbmPlanes, nodefault};
	__property System::Word bmBitsPixel = {read=FbmBitsPixel, write=FbmBitsPixel, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagBITMAPWrapper(void) { }
	
};


class DELPHICLASS tagRGBTRIPLEWrapper;
class PASCALIMPLEMENTATION tagRGBTRIPLEWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	System::Byte FrgbtBlue;
	System::Byte FrgbtGreen;
	System::Byte FrgbtRed;
	
public:
	__fastcall tagRGBTRIPLEWrapper(tagRGBTRIPLE ARecord);
	tagRGBTRIPLE __fastcall ObjToRec(void);
	
__published:
	__property System::Byte rgbtBlue = {read=FrgbtBlue, write=FrgbtBlue, nodefault};
	__property System::Byte rgbtGreen = {read=FrgbtGreen, write=FrgbtGreen, nodefault};
	__property System::Byte rgbtRed = {read=FrgbtRed, write=FrgbtRed, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagRGBTRIPLEWrapper(void) { }
	
};


class DELPHICLASS tagRGBQUADWrapper;
class PASCALIMPLEMENTATION tagRGBQUADWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	System::Byte FrgbBlue;
	System::Byte FrgbGreen;
	System::Byte FrgbRed;
	System::Byte FrgbReserved;
	
public:
	__fastcall tagRGBQUADWrapper(tagRGBQUAD ARecord);
	tagRGBQUAD __fastcall ObjToRec(void);
	
__published:
	__property System::Byte rgbBlue = {read=FrgbBlue, write=FrgbBlue, nodefault};
	__property System::Byte rgbGreen = {read=FrgbGreen, write=FrgbGreen, nodefault};
	__property System::Byte rgbRed = {read=FrgbRed, write=FrgbRed, nodefault};
	__property System::Byte rgbReserved = {read=FrgbReserved, write=FrgbReserved, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagRGBQUADWrapper(void) { }
	
};


class DELPHICLASS tagCIEXYZWrapper;
class PASCALIMPLEMENTATION tagCIEXYZWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	int FciexyzX;
	int FciexyzY;
	int FciexyzZ;
	
public:
	__fastcall tagCIEXYZWrapper(const tagCIEXYZ &ARecord);
	tagCIEXYZ __fastcall ObjToRec(void);
	
__published:
	__property int ciexyzX = {read=FciexyzX, write=FciexyzX, nodefault};
	__property int ciexyzY = {read=FciexyzY, write=FciexyzY, nodefault};
	__property int ciexyzZ = {read=FciexyzZ, write=FciexyzZ, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagCIEXYZWrapper(void) { }
	
};


class DELPHICLASS tagICEXYZTRIPLEWrapper;
class PASCALIMPLEMENTATION tagICEXYZTRIPLEWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
public:
	__fastcall tagICEXYZTRIPLEWrapper(const tagICEXYZTRIPLE &ARecord);
	tagICEXYZTRIPLE __fastcall ObjToRec(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagICEXYZTRIPLEWrapper(void) { }
	
};


class DELPHICLASS tagLOGCOLORSPACEAWrapper;
class PASCALIMPLEMENTATION tagLOGCOLORSPACEAWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FlcsSignature;
	unsigned FlcsVersion;
	unsigned FlcsSize;
	int FlcsCSType;
	int FlcsIntent;
	unsigned FlcsGammaRed;
	unsigned FlcsGammaGreen;
	unsigned FlcsGammaBlue;
	
public:
	__fastcall tagLOGCOLORSPACEAWrapper(const tagLOGCOLORSPACEA &ARecord);
	tagLOGCOLORSPACEA __fastcall ObjToRec(void);
	
__published:
	__property unsigned lcsSignature = {read=FlcsSignature, write=FlcsSignature, nodefault};
	__property unsigned lcsVersion = {read=FlcsVersion, write=FlcsVersion, nodefault};
	__property unsigned lcsSize = {read=FlcsSize, write=FlcsSize, nodefault};
	__property int lcsCSType = {read=FlcsCSType, write=FlcsCSType, nodefault};
	__property int lcsIntent = {read=FlcsIntent, write=FlcsIntent, nodefault};
	__property unsigned lcsGammaRed = {read=FlcsGammaRed, write=FlcsGammaRed, nodefault};
	__property unsigned lcsGammaGreen = {read=FlcsGammaGreen, write=FlcsGammaGreen, nodefault};
	__property unsigned lcsGammaBlue = {read=FlcsGammaBlue, write=FlcsGammaBlue, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagLOGCOLORSPACEAWrapper(void) { }
	
};


class DELPHICLASS tagLOGCOLORSPACEWWrapper;
class PASCALIMPLEMENTATION tagLOGCOLORSPACEWWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FlcsSignature;
	unsigned FlcsVersion;
	unsigned FlcsSize;
	int FlcsCSType;
	int FlcsIntent;
	unsigned FlcsGammaRed;
	unsigned FlcsGammaGreen;
	unsigned FlcsGammaBlue;
	
public:
	__fastcall tagLOGCOLORSPACEWWrapper(const tagLOGCOLORSPACEW &ARecord);
	tagLOGCOLORSPACEW __fastcall ObjToRec(void);
	
__published:
	__property unsigned lcsSignature = {read=FlcsSignature, write=FlcsSignature, nodefault};
	__property unsigned lcsVersion = {read=FlcsVersion, write=FlcsVersion, nodefault};
	__property unsigned lcsSize = {read=FlcsSize, write=FlcsSize, nodefault};
	__property int lcsCSType = {read=FlcsCSType, write=FlcsCSType, nodefault};
	__property int lcsIntent = {read=FlcsIntent, write=FlcsIntent, nodefault};
	__property unsigned lcsGammaRed = {read=FlcsGammaRed, write=FlcsGammaRed, nodefault};
	__property unsigned lcsGammaGreen = {read=FlcsGammaGreen, write=FlcsGammaGreen, nodefault};
	__property unsigned lcsGammaBlue = {read=FlcsGammaBlue, write=FlcsGammaBlue, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagLOGCOLORSPACEWWrapper(void) { }
	
};


class DELPHICLASS tagBITMAPCOREHEADERWrapper;
class PASCALIMPLEMENTATION tagBITMAPCOREHEADERWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FbcSize;
	System::Word FbcWidth;
	System::Word FbcHeight;
	System::Word FbcPlanes;
	System::Word FbcBitCount;
	
public:
	__fastcall tagBITMAPCOREHEADERWrapper(const tagBITMAPCOREHEADER &ARecord);
	tagBITMAPCOREHEADER __fastcall ObjToRec(void);
	
__published:
	__property unsigned bcSize = {read=FbcSize, write=FbcSize, nodefault};
	__property System::Word bcWidth = {read=FbcWidth, write=FbcWidth, nodefault};
	__property System::Word bcHeight = {read=FbcHeight, write=FbcHeight, nodefault};
	__property System::Word bcPlanes = {read=FbcPlanes, write=FbcPlanes, nodefault};
	__property System::Word bcBitCount = {read=FbcBitCount, write=FbcBitCount, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagBITMAPCOREHEADERWrapper(void) { }
	
};


class DELPHICLASS tagBITMAPINFOHEADERWrapper;
class PASCALIMPLEMENTATION tagBITMAPINFOHEADERWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FbiSize;
	int FbiWidth;
	int FbiHeight;
	System::Word FbiPlanes;
	System::Word FbiBitCount;
	unsigned FbiCompression;
	unsigned FbiSizeImage;
	int FbiXPelsPerMeter;
	int FbiYPelsPerMeter;
	unsigned FbiClrUsed;
	unsigned FbiClrImportant;
	
public:
	__fastcall tagBITMAPINFOHEADERWrapper(const tagBITMAPINFOHEADER &ARecord);
	tagBITMAPINFOHEADER __fastcall ObjToRec(void);
	
__published:
	__property unsigned biSize = {read=FbiSize, write=FbiSize, nodefault};
	__property int biWidth = {read=FbiWidth, write=FbiWidth, nodefault};
	__property int biHeight = {read=FbiHeight, write=FbiHeight, nodefault};
	__property System::Word biPlanes = {read=FbiPlanes, write=FbiPlanes, nodefault};
	__property System::Word biBitCount = {read=FbiBitCount, write=FbiBitCount, nodefault};
	__property unsigned biCompression = {read=FbiCompression, write=FbiCompression, nodefault};
	__property unsigned biSizeImage = {read=FbiSizeImage, write=FbiSizeImage, nodefault};
	__property int biXPelsPerMeter = {read=FbiXPelsPerMeter, write=FbiXPelsPerMeter, nodefault};
	__property int biYPelsPerMeter = {read=FbiYPelsPerMeter, write=FbiYPelsPerMeter, nodefault};
	__property unsigned biClrUsed = {read=FbiClrUsed, write=FbiClrUsed, nodefault};
	__property unsigned biClrImportant = {read=FbiClrImportant, write=FbiClrImportant, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagBITMAPINFOHEADERWrapper(void) { }
	
};


class DELPHICLASS BITMAPV4HEADERWrapper;
class PASCALIMPLEMENTATION BITMAPV4HEADERWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FbV4Size;
	int FbV4Width;
	int FbV4Height;
	System::Word FbV4Planes;
	System::Word FbV4BitCount;
	unsigned FbV4V4Compression;
	unsigned FbV4SizeImage;
	int FbV4XPelsPerMeter;
	int FbV4YPelsPerMeter;
	unsigned FbV4ClrUsed;
	unsigned FbV4ClrImportant;
	unsigned FbV4RedMask;
	unsigned FbV4GreenMask;
	unsigned FbV4BlueMask;
	unsigned FbV4AlphaMask;
	unsigned FbV4CSType;
	unsigned FbV4GammaRed;
	unsigned FbV4GammaGreen;
	unsigned FbV4GammaBlue;
	
public:
	__fastcall BITMAPV4HEADERWrapper(const BITMAPV4HEADER &ARecord);
	BITMAPV4HEADER __fastcall ObjToRec(void);
	
__published:
	__property unsigned bV4Size = {read=FbV4Size, write=FbV4Size, nodefault};
	__property int bV4Width = {read=FbV4Width, write=FbV4Width, nodefault};
	__property int bV4Height = {read=FbV4Height, write=FbV4Height, nodefault};
	__property System::Word bV4Planes = {read=FbV4Planes, write=FbV4Planes, nodefault};
	__property System::Word bV4BitCount = {read=FbV4BitCount, write=FbV4BitCount, nodefault};
	__property unsigned bV4V4Compression = {read=FbV4V4Compression, write=FbV4V4Compression, nodefault};
	__property unsigned bV4SizeImage = {read=FbV4SizeImage, write=FbV4SizeImage, nodefault};
	__property int bV4XPelsPerMeter = {read=FbV4XPelsPerMeter, write=FbV4XPelsPerMeter, nodefault};
	__property int bV4YPelsPerMeter = {read=FbV4YPelsPerMeter, write=FbV4YPelsPerMeter, nodefault};
	__property unsigned bV4ClrUsed = {read=FbV4ClrUsed, write=FbV4ClrUsed, nodefault};
	__property unsigned bV4ClrImportant = {read=FbV4ClrImportant, write=FbV4ClrImportant, nodefault};
	__property unsigned bV4RedMask = {read=FbV4RedMask, write=FbV4RedMask, nodefault};
	__property unsigned bV4GreenMask = {read=FbV4GreenMask, write=FbV4GreenMask, nodefault};
	__property unsigned bV4BlueMask = {read=FbV4BlueMask, write=FbV4BlueMask, nodefault};
	__property unsigned bV4AlphaMask = {read=FbV4AlphaMask, write=FbV4AlphaMask, nodefault};
	__property unsigned bV4CSType = {read=FbV4CSType, write=FbV4CSType, nodefault};
	__property unsigned bV4GammaRed = {read=FbV4GammaRed, write=FbV4GammaRed, nodefault};
	__property unsigned bV4GammaGreen = {read=FbV4GammaGreen, write=FbV4GammaGreen, nodefault};
	__property unsigned bV4GammaBlue = {read=FbV4GammaBlue, write=FbV4GammaBlue, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~BITMAPV4HEADERWrapper(void) { }
	
};


class DELPHICLASS BITMAPV5HEADERWrapper;
class PASCALIMPLEMENTATION BITMAPV5HEADERWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FbV5Size;
	int FbV5Width;
	int FbV5Height;
	System::Word FbV5Planes;
	System::Word FbV5BitCount;
	unsigned FbV5Compression;
	unsigned FbV5SizeImage;
	int FbV5XPelsPerMeter;
	int FbV5YPelsPerMeter;
	unsigned FbV5ClrUsed;
	unsigned FbV5ClrImportant;
	unsigned FbV5RedMask;
	unsigned FbV5GreenMask;
	unsigned FbV5BlueMask;
	unsigned FbV5AlphaMask;
	unsigned FbV5CSType;
	unsigned FbV5GammaRed;
	unsigned FbV5GammaGreen;
	unsigned FbV5GammaBlue;
	unsigned FbV5Intent;
	unsigned FbV5ProfileData;
	unsigned FbV5ProfileSize;
	unsigned FbV5Reserved;
	
public:
	__fastcall BITMAPV5HEADERWrapper(const BITMAPV5HEADER &ARecord);
	BITMAPV5HEADER __fastcall ObjToRec(void);
	
__published:
	__property unsigned bV5Size = {read=FbV5Size, write=FbV5Size, nodefault};
	__property int bV5Width = {read=FbV5Width, write=FbV5Width, nodefault};
	__property int bV5Height = {read=FbV5Height, write=FbV5Height, nodefault};
	__property System::Word bV5Planes = {read=FbV5Planes, write=FbV5Planes, nodefault};
	__property System::Word bV5BitCount = {read=FbV5BitCount, write=FbV5BitCount, nodefault};
	__property unsigned bV5Compression = {read=FbV5Compression, write=FbV5Compression, nodefault};
	__property unsigned bV5SizeImage = {read=FbV5SizeImage, write=FbV5SizeImage, nodefault};
	__property int bV5XPelsPerMeter = {read=FbV5XPelsPerMeter, write=FbV5XPelsPerMeter, nodefault};
	__property int bV5YPelsPerMeter = {read=FbV5YPelsPerMeter, write=FbV5YPelsPerMeter, nodefault};
	__property unsigned bV5ClrUsed = {read=FbV5ClrUsed, write=FbV5ClrUsed, nodefault};
	__property unsigned bV5ClrImportant = {read=FbV5ClrImportant, write=FbV5ClrImportant, nodefault};
	__property unsigned bV5RedMask = {read=FbV5RedMask, write=FbV5RedMask, nodefault};
	__property unsigned bV5GreenMask = {read=FbV5GreenMask, write=FbV5GreenMask, nodefault};
	__property unsigned bV5BlueMask = {read=FbV5BlueMask, write=FbV5BlueMask, nodefault};
	__property unsigned bV5AlphaMask = {read=FbV5AlphaMask, write=FbV5AlphaMask, nodefault};
	__property unsigned bV5CSType = {read=FbV5CSType, write=FbV5CSType, nodefault};
	__property unsigned bV5GammaRed = {read=FbV5GammaRed, write=FbV5GammaRed, nodefault};
	__property unsigned bV5GammaGreen = {read=FbV5GammaGreen, write=FbV5GammaGreen, nodefault};
	__property unsigned bV5GammaBlue = {read=FbV5GammaBlue, write=FbV5GammaBlue, nodefault};
	__property unsigned bV5Intent = {read=FbV5Intent, write=FbV5Intent, nodefault};
	__property unsigned bV5ProfileData = {read=FbV5ProfileData, write=FbV5ProfileData, nodefault};
	__property unsigned bV5ProfileSize = {read=FbV5ProfileSize, write=FbV5ProfileSize, nodefault};
	__property unsigned bV5Reserved = {read=FbV5Reserved, write=FbV5Reserved, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~BITMAPV5HEADERWrapper(void) { }
	
};


class DELPHICLASS tagBITMAPINFOWrapper;
class PASCALIMPLEMENTATION tagBITMAPINFOWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
public:
	__fastcall tagBITMAPINFOWrapper(const tagBITMAPINFO &ARecord);
	tagBITMAPINFO __fastcall ObjToRec(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagBITMAPINFOWrapper(void) { }
	
};


class DELPHICLASS tagBITMAPCOREINFOWrapper;
class PASCALIMPLEMENTATION tagBITMAPCOREINFOWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
public:
	__fastcall tagBITMAPCOREINFOWrapper(const tagBITMAPCOREINFO &ARecord);
	tagBITMAPCOREINFO __fastcall ObjToRec(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagBITMAPCOREINFOWrapper(void) { }
	
};


class DELPHICLASS tagBITMAPFILEHEADERWrapper;
class PASCALIMPLEMENTATION tagBITMAPFILEHEADERWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	System::Word FbfType;
	unsigned FbfSize;
	System::Word FbfReserved1;
	System::Word FbfReserved2;
	unsigned FbfOffBits;
	
public:
	__fastcall tagBITMAPFILEHEADERWrapper(const tagBITMAPFILEHEADER &ARecord);
	tagBITMAPFILEHEADER __fastcall ObjToRec(void);
	
__published:
	__property System::Word bfType = {read=FbfType, write=FbfType, nodefault};
	__property unsigned bfSize = {read=FbfSize, write=FbfSize, nodefault};
	__property System::Word bfReserved1 = {read=FbfReserved1, write=FbfReserved1, nodefault};
	__property System::Word bfReserved2 = {read=FbfReserved2, write=FbfReserved2, nodefault};
	__property unsigned bfOffBits = {read=FbfOffBits, write=FbfOffBits, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagBITMAPFILEHEADERWrapper(void) { }
	
};


class DELPHICLASS tagFONTSIGNATUREWrapper;
class PASCALIMPLEMENTATION tagFONTSIGNATUREWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
public:
	__fastcall tagFONTSIGNATUREWrapper(const tagFONTSIGNATURE &ARecord);
	tagFONTSIGNATURE __fastcall ObjToRec(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagFONTSIGNATUREWrapper(void) { }
	
};


class DELPHICLASS tagCHARSETINFOWrapper;
class PASCALIMPLEMENTATION tagCHARSETINFOWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FciCharset;
	unsigned FciACP;
	
public:
	__fastcall tagCHARSETINFOWrapper(const tagCHARSETINFO &ARecord);
	tagCHARSETINFO __fastcall ObjToRec(void);
	
__published:
	__property unsigned ciCharset = {read=FciCharset, write=FciCharset, nodefault};
	__property unsigned ciACP = {read=FciACP, write=FciACP, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagCHARSETINFOWrapper(void) { }
	
};


class DELPHICLASS tagLOCALESIGNATUREWrapper;
class PASCALIMPLEMENTATION tagLOCALESIGNATUREWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
public:
	__fastcall tagLOCALESIGNATUREWrapper(const tagLOCALESIGNATURE &ARecord);
	tagLOCALESIGNATURE __fastcall ObjToRec(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagLOCALESIGNATUREWrapper(void) { }
	
};


class DELPHICLASS tagHANDLETABLEWrapper;
class PASCALIMPLEMENTATION tagHANDLETABLEWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
public:
	__fastcall tagHANDLETABLEWrapper(tagHANDLETABLE ARecord);
	tagHANDLETABLE __fastcall ObjToRec(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagHANDLETABLEWrapper(void) { }
	
};


class DELPHICLASS tagMETARECORDWrapper;
class PASCALIMPLEMENTATION tagMETARECORDWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FrdSize;
	System::Word FrdFunction;
	
public:
	__fastcall tagMETARECORDWrapper(const tagMETARECORD &ARecord);
	tagMETARECORD __fastcall ObjToRec(void);
	
__published:
	__property unsigned rdSize = {read=FrdSize, write=FrdSize, nodefault};
	__property System::Word rdFunction = {read=FrdFunction, write=FrdFunction, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagMETARECORDWrapper(void) { }
	
};


class DELPHICLASS tagMETAFILEPICTWrapper;
class PASCALIMPLEMENTATION tagMETAFILEPICTWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	int Fmm;
	int FxExt;
	int FyExt;
	HMETAFILE FhMF;
	
public:
	__fastcall tagMETAFILEPICTWrapper(const tagMETAFILEPICT &ARecord);
	tagMETAFILEPICT __fastcall ObjToRec(void);
	
__published:
	__property int mm = {read=Fmm, write=Fmm, nodefault};
	__property int xExt = {read=FxExt, write=FxExt, nodefault};
	__property int yExt = {read=FyExt, write=FyExt, nodefault};
	__property HMETAFILE hMF = {read=FhMF, write=FhMF, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagMETAFILEPICTWrapper(void) { }
	
};


class DELPHICLASS tagMETAHEADERWrapper;
class PASCALIMPLEMENTATION tagMETAHEADERWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	System::Word FmtType;
	System::Word FmtHeaderSize;
	System::Word FmtVersion;
	unsigned FmtSize;
	System::Word FmtNoObjects;
	unsigned FmtMaxRecord;
	System::Word FmtNoParameters;
	
public:
	__fastcall tagMETAHEADERWrapper(const tagMETAHEADER &ARecord);
	tagMETAHEADER __fastcall ObjToRec(void);
	
__published:
	__property System::Word mtType = {read=FmtType, write=FmtType, nodefault};
	__property System::Word mtHeaderSize = {read=FmtHeaderSize, write=FmtHeaderSize, nodefault};
	__property System::Word mtVersion = {read=FmtVersion, write=FmtVersion, nodefault};
	__property unsigned mtSize = {read=FmtSize, write=FmtSize, nodefault};
	__property System::Word mtNoObjects = {read=FmtNoObjects, write=FmtNoObjects, nodefault};
	__property unsigned mtMaxRecord = {read=FmtMaxRecord, write=FmtMaxRecord, nodefault};
	__property System::Word mtNoParameters = {read=FmtNoParameters, write=FmtNoParameters, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagMETAHEADERWrapper(void) { }
	
};


class DELPHICLASS tagENHMETARECORDWrapper;
class PASCALIMPLEMENTATION tagENHMETARECORDWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FiType;
	unsigned FnSize;
	
public:
	__fastcall tagENHMETARECORDWrapper(const tagENHMETARECORD &ARecord);
	tagENHMETARECORD __fastcall ObjToRec(void);
	
__published:
	__property unsigned iType = {read=FiType, write=FiType, nodefault};
	__property unsigned nSize = {read=FnSize, write=FnSize, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagENHMETARECORDWrapper(void) { }
	
};


class DELPHICLASS tagENHMETAHEADERWrapper;
class PASCALIMPLEMENTATION tagENHMETAHEADERWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FiType;
	unsigned FnSize;
	unsigned FdSignature;
	unsigned FnVersion;
	unsigned FnBytes;
	unsigned FnRecords;
	System::Word FnHandles;
	System::Word FsReserved;
	unsigned FnDescription;
	unsigned FoffDescription;
	unsigned FnPalEntries;
	unsigned FcbPixelFormat;
	unsigned FoffPixelFormat;
	unsigned FbOpenGL;
	
public:
	__fastcall tagENHMETAHEADERWrapper(const tagENHMETAHEADER &ARecord);
	tagENHMETAHEADER __fastcall ObjToRec(void);
	
__published:
	__property unsigned iType = {read=FiType, write=FiType, nodefault};
	__property unsigned nSize = {read=FnSize, write=FnSize, nodefault};
	__property unsigned dSignature = {read=FdSignature, write=FdSignature, nodefault};
	__property unsigned nVersion = {read=FnVersion, write=FnVersion, nodefault};
	__property unsigned nBytes = {read=FnBytes, write=FnBytes, nodefault};
	__property unsigned nRecords = {read=FnRecords, write=FnRecords, nodefault};
	__property System::Word nHandles = {read=FnHandles, write=FnHandles, nodefault};
	__property System::Word sReserved = {read=FsReserved, write=FsReserved, nodefault};
	__property unsigned nDescription = {read=FnDescription, write=FnDescription, nodefault};
	__property unsigned offDescription = {read=FoffDescription, write=FoffDescription, nodefault};
	__property unsigned nPalEntries = {read=FnPalEntries, write=FnPalEntries, nodefault};
	__property unsigned cbPixelFormat = {read=FcbPixelFormat, write=FcbPixelFormat, nodefault};
	__property unsigned offPixelFormat = {read=FoffPixelFormat, write=FoffPixelFormat, nodefault};
	__property unsigned bOpenGL = {read=FbOpenGL, write=FbOpenGL, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagENHMETAHEADERWrapper(void) { }
	
};


class DELPHICLASS tagTEXTMETRICAWrapper;
class PASCALIMPLEMENTATION tagTEXTMETRICAWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	int FtmHeight;
	int FtmAscent;
	int FtmDescent;
	int FtmInternalLeading;
	int FtmExternalLeading;
	int FtmAveCharWidth;
	int FtmMaxCharWidth;
	int FtmWeight;
	int FtmOverhang;
	int FtmDigitizedAspectX;
	int FtmDigitizedAspectY;
	char FtmFirstChar;
	char FtmLastChar;
	char FtmDefaultChar;
	char FtmBreakChar;
	System::Byte FtmItalic;
	System::Byte FtmUnderlined;
	System::Byte FtmStruckOut;
	System::Byte FtmPitchAndFamily;
	System::Byte FtmCharSet;
	
public:
	__fastcall tagTEXTMETRICAWrapper(const tagTEXTMETRICA &ARecord);
	tagTEXTMETRICA __fastcall ObjToRec(void);
	
__published:
	__property int tmHeight = {read=FtmHeight, write=FtmHeight, nodefault};
	__property int tmAscent = {read=FtmAscent, write=FtmAscent, nodefault};
	__property int tmDescent = {read=FtmDescent, write=FtmDescent, nodefault};
	__property int tmInternalLeading = {read=FtmInternalLeading, write=FtmInternalLeading, nodefault};
	__property int tmExternalLeading = {read=FtmExternalLeading, write=FtmExternalLeading, nodefault};
	__property int tmAveCharWidth = {read=FtmAveCharWidth, write=FtmAveCharWidth, nodefault};
	__property int tmMaxCharWidth = {read=FtmMaxCharWidth, write=FtmMaxCharWidth, nodefault};
	__property int tmWeight = {read=FtmWeight, write=FtmWeight, nodefault};
	__property int tmOverhang = {read=FtmOverhang, write=FtmOverhang, nodefault};
	__property int tmDigitizedAspectX = {read=FtmDigitizedAspectX, write=FtmDigitizedAspectX, nodefault};
	__property int tmDigitizedAspectY = {read=FtmDigitizedAspectY, write=FtmDigitizedAspectY, nodefault};
	__property char tmFirstChar = {read=FtmFirstChar, write=FtmFirstChar, nodefault};
	__property char tmLastChar = {read=FtmLastChar, write=FtmLastChar, nodefault};
	__property char tmDefaultChar = {read=FtmDefaultChar, write=FtmDefaultChar, nodefault};
	__property char tmBreakChar = {read=FtmBreakChar, write=FtmBreakChar, nodefault};
	__property System::Byte tmItalic = {read=FtmItalic, write=FtmItalic, nodefault};
	__property System::Byte tmUnderlined = {read=FtmUnderlined, write=FtmUnderlined, nodefault};
	__property System::Byte tmStruckOut = {read=FtmStruckOut, write=FtmStruckOut, nodefault};
	__property System::Byte tmPitchAndFamily = {read=FtmPitchAndFamily, write=FtmPitchAndFamily, nodefault};
	__property System::Byte tmCharSet = {read=FtmCharSet, write=FtmCharSet, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagTEXTMETRICAWrapper(void) { }
	
};


class DELPHICLASS tagTEXTMETRICWWrapper;
class PASCALIMPLEMENTATION tagTEXTMETRICWWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	int FtmHeight;
	int FtmAscent;
	int FtmDescent;
	int FtmInternalLeading;
	int FtmExternalLeading;
	int FtmAveCharWidth;
	int FtmMaxCharWidth;
	int FtmWeight;
	int FtmOverhang;
	int FtmDigitizedAspectX;
	int FtmDigitizedAspectY;
	System::Byte FtmItalic;
	System::Byte FtmUnderlined;
	System::Byte FtmStruckOut;
	System::Byte FtmPitchAndFamily;
	System::Byte FtmCharSet;
	
public:
	__fastcall tagTEXTMETRICWWrapper(const tagTEXTMETRICW &ARecord);
	tagTEXTMETRICW __fastcall ObjToRec(void);
	
__published:
	__property int tmHeight = {read=FtmHeight, write=FtmHeight, nodefault};
	__property int tmAscent = {read=FtmAscent, write=FtmAscent, nodefault};
	__property int tmDescent = {read=FtmDescent, write=FtmDescent, nodefault};
	__property int tmInternalLeading = {read=FtmInternalLeading, write=FtmInternalLeading, nodefault};
	__property int tmExternalLeading = {read=FtmExternalLeading, write=FtmExternalLeading, nodefault};
	__property int tmAveCharWidth = {read=FtmAveCharWidth, write=FtmAveCharWidth, nodefault};
	__property int tmMaxCharWidth = {read=FtmMaxCharWidth, write=FtmMaxCharWidth, nodefault};
	__property int tmWeight = {read=FtmWeight, write=FtmWeight, nodefault};
	__property int tmOverhang = {read=FtmOverhang, write=FtmOverhang, nodefault};
	__property int tmDigitizedAspectX = {read=FtmDigitizedAspectX, write=FtmDigitizedAspectX, nodefault};
	__property int tmDigitizedAspectY = {read=FtmDigitizedAspectY, write=FtmDigitizedAspectY, nodefault};
	__property System::Byte tmItalic = {read=FtmItalic, write=FtmItalic, nodefault};
	__property System::Byte tmUnderlined = {read=FtmUnderlined, write=FtmUnderlined, nodefault};
	__property System::Byte tmStruckOut = {read=FtmStruckOut, write=FtmStruckOut, nodefault};
	__property System::Byte tmPitchAndFamily = {read=FtmPitchAndFamily, write=FtmPitchAndFamily, nodefault};
	__property System::Byte tmCharSet = {read=FtmCharSet, write=FtmCharSet, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagTEXTMETRICWWrapper(void) { }
	
};


class DELPHICLASS tagNEWTEXTMETRICAWrapper;
class PASCALIMPLEMENTATION tagNEWTEXTMETRICAWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	int FtmHeight;
	int FtmAscent;
	int FtmDescent;
	int FtmInternalLeading;
	int FtmExternalLeading;
	int FtmAveCharWidth;
	int FtmMaxCharWidth;
	int FtmWeight;
	int FtmOverhang;
	int FtmDigitizedAspectX;
	int FtmDigitizedAspectY;
	char FtmFirstChar;
	char FtmLastChar;
	char FtmDefaultChar;
	char FtmBreakChar;
	System::Byte FtmItalic;
	System::Byte FtmUnderlined;
	System::Byte FtmStruckOut;
	System::Byte FtmPitchAndFamily;
	System::Byte FtmCharSet;
	unsigned FntmFlags;
	unsigned FntmSizeEM;
	unsigned FntmCellHeight;
	unsigned FntmAvgWidth;
	
public:
	__fastcall tagNEWTEXTMETRICAWrapper(const tagNEWTEXTMETRICA &ARecord);
	tagNEWTEXTMETRICA __fastcall ObjToRec(void);
	
__published:
	__property int tmHeight = {read=FtmHeight, write=FtmHeight, nodefault};
	__property int tmAscent = {read=FtmAscent, write=FtmAscent, nodefault};
	__property int tmDescent = {read=FtmDescent, write=FtmDescent, nodefault};
	__property int tmInternalLeading = {read=FtmInternalLeading, write=FtmInternalLeading, nodefault};
	__property int tmExternalLeading = {read=FtmExternalLeading, write=FtmExternalLeading, nodefault};
	__property int tmAveCharWidth = {read=FtmAveCharWidth, write=FtmAveCharWidth, nodefault};
	__property int tmMaxCharWidth = {read=FtmMaxCharWidth, write=FtmMaxCharWidth, nodefault};
	__property int tmWeight = {read=FtmWeight, write=FtmWeight, nodefault};
	__property int tmOverhang = {read=FtmOverhang, write=FtmOverhang, nodefault};
	__property int tmDigitizedAspectX = {read=FtmDigitizedAspectX, write=FtmDigitizedAspectX, nodefault};
	__property int tmDigitizedAspectY = {read=FtmDigitizedAspectY, write=FtmDigitizedAspectY, nodefault};
	__property char tmFirstChar = {read=FtmFirstChar, write=FtmFirstChar, nodefault};
	__property char tmLastChar = {read=FtmLastChar, write=FtmLastChar, nodefault};
	__property char tmDefaultChar = {read=FtmDefaultChar, write=FtmDefaultChar, nodefault};
	__property char tmBreakChar = {read=FtmBreakChar, write=FtmBreakChar, nodefault};
	__property System::Byte tmItalic = {read=FtmItalic, write=FtmItalic, nodefault};
	__property System::Byte tmUnderlined = {read=FtmUnderlined, write=FtmUnderlined, nodefault};
	__property System::Byte tmStruckOut = {read=FtmStruckOut, write=FtmStruckOut, nodefault};
	__property System::Byte tmPitchAndFamily = {read=FtmPitchAndFamily, write=FtmPitchAndFamily, nodefault};
	__property System::Byte tmCharSet = {read=FtmCharSet, write=FtmCharSet, nodefault};
	__property unsigned ntmFlags = {read=FntmFlags, write=FntmFlags, nodefault};
	__property unsigned ntmSizeEM = {read=FntmSizeEM, write=FntmSizeEM, nodefault};
	__property unsigned ntmCellHeight = {read=FntmCellHeight, write=FntmCellHeight, nodefault};
	__property unsigned ntmAvgWidth = {read=FntmAvgWidth, write=FntmAvgWidth, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagNEWTEXTMETRICAWrapper(void) { }
	
};


class DELPHICLASS tagNEWTEXTMETRICWWrapper;
class PASCALIMPLEMENTATION tagNEWTEXTMETRICWWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	int FtmHeight;
	int FtmAscent;
	int FtmDescent;
	int FtmInternalLeading;
	int FtmExternalLeading;
	int FtmAveCharWidth;
	int FtmMaxCharWidth;
	int FtmWeight;
	int FtmOverhang;
	int FtmDigitizedAspectX;
	int FtmDigitizedAspectY;
	System::Byte FtmItalic;
	System::Byte FtmUnderlined;
	System::Byte FtmStruckOut;
	System::Byte FtmPitchAndFamily;
	System::Byte FtmCharSet;
	unsigned FntmFlags;
	unsigned FntmSizeEM;
	unsigned FntmCellHeight;
	unsigned FntmAvgWidth;
	
public:
	__fastcall tagNEWTEXTMETRICWWrapper(const tagNEWTEXTMETRICW &ARecord);
	tagNEWTEXTMETRICW __fastcall ObjToRec(void);
	
__published:
	__property int tmHeight = {read=FtmHeight, write=FtmHeight, nodefault};
	__property int tmAscent = {read=FtmAscent, write=FtmAscent, nodefault};
	__property int tmDescent = {read=FtmDescent, write=FtmDescent, nodefault};
	__property int tmInternalLeading = {read=FtmInternalLeading, write=FtmInternalLeading, nodefault};
	__property int tmExternalLeading = {read=FtmExternalLeading, write=FtmExternalLeading, nodefault};
	__property int tmAveCharWidth = {read=FtmAveCharWidth, write=FtmAveCharWidth, nodefault};
	__property int tmMaxCharWidth = {read=FtmMaxCharWidth, write=FtmMaxCharWidth, nodefault};
	__property int tmWeight = {read=FtmWeight, write=FtmWeight, nodefault};
	__property int tmOverhang = {read=FtmOverhang, write=FtmOverhang, nodefault};
	__property int tmDigitizedAspectX = {read=FtmDigitizedAspectX, write=FtmDigitizedAspectX, nodefault};
	__property int tmDigitizedAspectY = {read=FtmDigitizedAspectY, write=FtmDigitizedAspectY, nodefault};
	__property System::Byte tmItalic = {read=FtmItalic, write=FtmItalic, nodefault};
	__property System::Byte tmUnderlined = {read=FtmUnderlined, write=FtmUnderlined, nodefault};
	__property System::Byte tmStruckOut = {read=FtmStruckOut, write=FtmStruckOut, nodefault};
	__property System::Byte tmPitchAndFamily = {read=FtmPitchAndFamily, write=FtmPitchAndFamily, nodefault};
	__property System::Byte tmCharSet = {read=FtmCharSet, write=FtmCharSet, nodefault};
	__property unsigned ntmFlags = {read=FntmFlags, write=FntmFlags, nodefault};
	__property unsigned ntmSizeEM = {read=FntmSizeEM, write=FntmSizeEM, nodefault};
	__property unsigned ntmCellHeight = {read=FntmCellHeight, write=FntmCellHeight, nodefault};
	__property unsigned ntmAvgWidth = {read=FntmAvgWidth, write=FntmAvgWidth, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagNEWTEXTMETRICWWrapper(void) { }
	
};


class DELPHICLASS tagNEWTEXTMETRICEXAWrapper;
class PASCALIMPLEMENTATION tagNEWTEXTMETRICEXAWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
public:
	__fastcall tagNEWTEXTMETRICEXAWrapper(const tagNEWTEXTMETRICEXA &ARecord);
	tagNEWTEXTMETRICEXA __fastcall ObjToRec(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagNEWTEXTMETRICEXAWrapper(void) { }
	
};


class DELPHICLASS tagNEWTEXTMETRICEXWWrapper;
class PASCALIMPLEMENTATION tagNEWTEXTMETRICEXWWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
public:
	__fastcall tagNEWTEXTMETRICEXWWrapper(const tagNEWTEXTMETRICEXW &ARecord);
	tagNEWTEXTMETRICEXW __fastcall ObjToRec(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagNEWTEXTMETRICEXWWrapper(void) { }
	
};


class DELPHICLASS tagPELARRAYWrapper;
class PASCALIMPLEMENTATION tagPELARRAYWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	int FpaXCount;
	int FpaYCount;
	int FpaXExt;
	int FpaYExt;
	System::Byte FpaRGBs;
	
public:
	__fastcall tagPELARRAYWrapper(const tagPELARRAY &ARecord);
	tagPELARRAY __fastcall ObjToRec(void);
	
__published:
	__property int paXCount = {read=FpaXCount, write=FpaXCount, nodefault};
	__property int paYCount = {read=FpaYCount, write=FpaYCount, nodefault};
	__property int paXExt = {read=FpaXExt, write=FpaXExt, nodefault};
	__property int paYExt = {read=FpaYExt, write=FpaYExt, nodefault};
	__property System::Byte paRGBs = {read=FpaRGBs, write=FpaRGBs, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagPELARRAYWrapper(void) { }
	
};


class DELPHICLASS tagLOGBRUSHWrapper;
class PASCALIMPLEMENTATION tagLOGBRUSHWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FlbStyle;
	unsigned FlbColor;
	int FlbHatch;
	
public:
	__fastcall tagLOGBRUSHWrapper(const tagLOGBRUSH &ARecord);
	tagLOGBRUSH __fastcall ObjToRec(void);
	
__published:
	__property unsigned lbStyle = {read=FlbStyle, write=FlbStyle, nodefault};
	__property unsigned lbColor = {read=FlbColor, write=FlbColor, nodefault};
	__property int lbHatch = {read=FlbHatch, write=FlbHatch, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagLOGBRUSHWrapper(void) { }
	
};


class DELPHICLASS tagLOGPENWrapper;
class PASCALIMPLEMENTATION tagLOGPENWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FlopnStyle;
	unsigned FlopnColor;
	
public:
	__fastcall tagLOGPENWrapper(const tagLOGPEN &ARecord);
	tagLOGPEN __fastcall ObjToRec(void);
	
__published:
	__property unsigned lopnStyle = {read=FlopnStyle, write=FlopnStyle, nodefault};
	__property unsigned lopnColor = {read=FlopnColor, write=FlopnColor, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagLOGPENWrapper(void) { }
	
};


class DELPHICLASS tagEXTLOGPENWrapper;
class PASCALIMPLEMENTATION tagEXTLOGPENWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FelpPenStyle;
	unsigned FelpWidth;
	unsigned FelpBrushStyle;
	unsigned FelpColor;
	int FelpHatch;
	unsigned FelpNumEntries;
	
public:
	__fastcall tagEXTLOGPENWrapper(const tagEXTLOGPEN &ARecord);
	tagEXTLOGPEN __fastcall ObjToRec(void);
	
__published:
	__property unsigned elpPenStyle = {read=FelpPenStyle, write=FelpPenStyle, nodefault};
	__property unsigned elpWidth = {read=FelpWidth, write=FelpWidth, nodefault};
	__property unsigned elpBrushStyle = {read=FelpBrushStyle, write=FelpBrushStyle, nodefault};
	__property unsigned elpColor = {read=FelpColor, write=FelpColor, nodefault};
	__property int elpHatch = {read=FelpHatch, write=FelpHatch, nodefault};
	__property unsigned elpNumEntries = {read=FelpNumEntries, write=FelpNumEntries, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagEXTLOGPENWrapper(void) { }
	
};


class DELPHICLASS tagPALETTEENTRYWrapper;
class PASCALIMPLEMENTATION tagPALETTEENTRYWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	System::Byte FpeRed;
	System::Byte FpeGreen;
	System::Byte FpeBlue;
	System::Byte FpeFlags;
	
public:
	__fastcall tagPALETTEENTRYWrapper(tagPALETTEENTRY ARecord);
	tagPALETTEENTRY __fastcall ObjToRec(void);
	
__published:
	__property System::Byte peRed = {read=FpeRed, write=FpeRed, nodefault};
	__property System::Byte peGreen = {read=FpeGreen, write=FpeGreen, nodefault};
	__property System::Byte peBlue = {read=FpeBlue, write=FpeBlue, nodefault};
	__property System::Byte peFlags = {read=FpeFlags, write=FpeFlags, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagPALETTEENTRYWrapper(void) { }
	
};


class DELPHICLASS tagLOGPALETTEWrapper;
class PASCALIMPLEMENTATION tagLOGPALETTEWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	System::Word FpalVersion;
	System::Word FpalNumEntries;
	
public:
	__fastcall tagLOGPALETTEWrapper(const tagLOGPALETTE &ARecord);
	tagLOGPALETTE __fastcall ObjToRec(void);
	
__published:
	__property System::Word palVersion = {read=FpalVersion, write=FpalVersion, nodefault};
	__property System::Word palNumEntries = {read=FpalNumEntries, write=FpalNumEntries, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagLOGPALETTEWrapper(void) { }
	
};


class DELPHICLASS TMaxLogPaletteWrapper;
class PASCALIMPLEMENTATION TMaxLogPaletteWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	System::Word FpalVersion;
	System::Word FpalNumEntries;
	
public:
	__fastcall TMaxLogPaletteWrapper(const Windows::TMaxLogPalette &ARecord);
	Windows::TMaxLogPalette __fastcall ObjToRec(void);
	
__published:
	__property System::Word palVersion = {read=FpalVersion, write=FpalVersion, nodefault};
	__property System::Word palNumEntries = {read=FpalNumEntries, write=FpalNumEntries, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TMaxLogPaletteWrapper(void) { }
	
};


class DELPHICLASS tagLOGFONTAWrapper;
class PASCALIMPLEMENTATION tagLOGFONTAWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	int FlfHeight;
	int FlfWidth;
	int FlfEscapement;
	int FlfOrientation;
	int FlfWeight;
	System::Byte FlfItalic;
	System::Byte FlfUnderline;
	System::Byte FlfStrikeOut;
	System::Byte FlfCharSet;
	System::Byte FlfOutPrecision;
	System::Byte FlfClipPrecision;
	System::Byte FlfQuality;
	System::Byte FlfPitchAndFamily;
	
public:
	__fastcall tagLOGFONTAWrapper(const tagLOGFONTA &ARecord);
	tagLOGFONTA __fastcall ObjToRec(void);
	
__published:
	__property int lfHeight = {read=FlfHeight, write=FlfHeight, nodefault};
	__property int lfWidth = {read=FlfWidth, write=FlfWidth, nodefault};
	__property int lfEscapement = {read=FlfEscapement, write=FlfEscapement, nodefault};
	__property int lfOrientation = {read=FlfOrientation, write=FlfOrientation, nodefault};
	__property int lfWeight = {read=FlfWeight, write=FlfWeight, nodefault};
	__property System::Byte lfItalic = {read=FlfItalic, write=FlfItalic, nodefault};
	__property System::Byte lfUnderline = {read=FlfUnderline, write=FlfUnderline, nodefault};
	__property System::Byte lfStrikeOut = {read=FlfStrikeOut, write=FlfStrikeOut, nodefault};
	__property System::Byte lfCharSet = {read=FlfCharSet, write=FlfCharSet, nodefault};
	__property System::Byte lfOutPrecision = {read=FlfOutPrecision, write=FlfOutPrecision, nodefault};
	__property System::Byte lfClipPrecision = {read=FlfClipPrecision, write=FlfClipPrecision, nodefault};
	__property System::Byte lfQuality = {read=FlfQuality, write=FlfQuality, nodefault};
	__property System::Byte lfPitchAndFamily = {read=FlfPitchAndFamily, write=FlfPitchAndFamily, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagLOGFONTAWrapper(void) { }
	
};


class DELPHICLASS tagLOGFONTWWrapper;
class PASCALIMPLEMENTATION tagLOGFONTWWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	int FlfHeight;
	int FlfWidth;
	int FlfEscapement;
	int FlfOrientation;
	int FlfWeight;
	System::Byte FlfItalic;
	System::Byte FlfUnderline;
	System::Byte FlfStrikeOut;
	System::Byte FlfCharSet;
	System::Byte FlfOutPrecision;
	System::Byte FlfClipPrecision;
	System::Byte FlfQuality;
	System::Byte FlfPitchAndFamily;
	
public:
	__fastcall tagLOGFONTWWrapper(const tagLOGFONTW &ARecord);
	tagLOGFONTW __fastcall ObjToRec(void);
	
__published:
	__property int lfHeight = {read=FlfHeight, write=FlfHeight, nodefault};
	__property int lfWidth = {read=FlfWidth, write=FlfWidth, nodefault};
	__property int lfEscapement = {read=FlfEscapement, write=FlfEscapement, nodefault};
	__property int lfOrientation = {read=FlfOrientation, write=FlfOrientation, nodefault};
	__property int lfWeight = {read=FlfWeight, write=FlfWeight, nodefault};
	__property System::Byte lfItalic = {read=FlfItalic, write=FlfItalic, nodefault};
	__property System::Byte lfUnderline = {read=FlfUnderline, write=FlfUnderline, nodefault};
	__property System::Byte lfStrikeOut = {read=FlfStrikeOut, write=FlfStrikeOut, nodefault};
	__property System::Byte lfCharSet = {read=FlfCharSet, write=FlfCharSet, nodefault};
	__property System::Byte lfOutPrecision = {read=FlfOutPrecision, write=FlfOutPrecision, nodefault};
	__property System::Byte lfClipPrecision = {read=FlfClipPrecision, write=FlfClipPrecision, nodefault};
	__property System::Byte lfQuality = {read=FlfQuality, write=FlfQuality, nodefault};
	__property System::Byte lfPitchAndFamily = {read=FlfPitchAndFamily, write=FlfPitchAndFamily, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagLOGFONTWWrapper(void) { }
	
};


class DELPHICLASS tagENUMLOGFONTAWrapper;
class PASCALIMPLEMENTATION tagENUMLOGFONTAWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
public:
	__fastcall tagENUMLOGFONTAWrapper(const tagENUMLOGFONTA &ARecord);
	tagENUMLOGFONTA __fastcall ObjToRec(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagENUMLOGFONTAWrapper(void) { }
	
};


class DELPHICLASS tagENUMLOGFONTWWrapper;
class PASCALIMPLEMENTATION tagENUMLOGFONTWWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
public:
	__fastcall tagENUMLOGFONTWWrapper(const tagENUMLOGFONTW &ARecord);
	tagENUMLOGFONTW __fastcall ObjToRec(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagENUMLOGFONTWWrapper(void) { }
	
};


class DELPHICLASS tagENUMLOGFONTEXAWrapper;
class PASCALIMPLEMENTATION tagENUMLOGFONTEXAWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
public:
	__fastcall tagENUMLOGFONTEXAWrapper(const tagENUMLOGFONTEXA &ARecord);
	tagENUMLOGFONTEXA __fastcall ObjToRec(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagENUMLOGFONTEXAWrapper(void) { }
	
};


class DELPHICLASS tagENUMLOGFONTEXWWrapper;
class PASCALIMPLEMENTATION tagENUMLOGFONTEXWWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
public:
	__fastcall tagENUMLOGFONTEXWWrapper(const tagENUMLOGFONTEXW &ARecord);
	tagENUMLOGFONTEXW __fastcall ObjToRec(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagENUMLOGFONTEXWWrapper(void) { }
	
};


class DELPHICLASS tagPANOSEWrapper;
class PASCALIMPLEMENTATION tagPANOSEWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	System::Byte FbFamilyType;
	System::Byte FbSerifStyle;
	System::Byte FbWeight;
	System::Byte FbProportion;
	System::Byte FbContrast;
	System::Byte FbStrokeVariation;
	System::Byte FbArmStyle;
	System::Byte FbLetterform;
	System::Byte FbMidline;
	System::Byte FbXHeight;
	
public:
	__fastcall tagPANOSEWrapper(const tagPANOSE &ARecord);
	tagPANOSE __fastcall ObjToRec(void);
	
__published:
	__property System::Byte bFamilyType = {read=FbFamilyType, write=FbFamilyType, nodefault};
	__property System::Byte bSerifStyle = {read=FbSerifStyle, write=FbSerifStyle, nodefault};
	__property System::Byte bWeight = {read=FbWeight, write=FbWeight, nodefault};
	__property System::Byte bProportion = {read=FbProportion, write=FbProportion, nodefault};
	__property System::Byte bContrast = {read=FbContrast, write=FbContrast, nodefault};
	__property System::Byte bStrokeVariation = {read=FbStrokeVariation, write=FbStrokeVariation, nodefault};
	__property System::Byte bArmStyle = {read=FbArmStyle, write=FbArmStyle, nodefault};
	__property System::Byte bLetterform = {read=FbLetterform, write=FbLetterform, nodefault};
	__property System::Byte bMidline = {read=FbMidline, write=FbMidline, nodefault};
	__property System::Byte bXHeight = {read=FbXHeight, write=FbXHeight, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagPANOSEWrapper(void) { }
	
};


class DELPHICLASS tagEXTLOGFONTAWrapper;
class PASCALIMPLEMENTATION tagEXTLOGFONTAWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FelfVersion;
	unsigned FelfStyleSize;
	unsigned FelfMatch;
	unsigned FelfReserved;
	unsigned FelfCulture;
	
public:
	__fastcall tagEXTLOGFONTAWrapper(const tagEXTLOGFONTA &ARecord);
	tagEXTLOGFONTA __fastcall ObjToRec(void);
	
__published:
	__property unsigned elfVersion = {read=FelfVersion, write=FelfVersion, nodefault};
	__property unsigned elfStyleSize = {read=FelfStyleSize, write=FelfStyleSize, nodefault};
	__property unsigned elfMatch = {read=FelfMatch, write=FelfMatch, nodefault};
	__property unsigned elfReserved = {read=FelfReserved, write=FelfReserved, nodefault};
	__property unsigned elfCulture = {read=FelfCulture, write=FelfCulture, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagEXTLOGFONTAWrapper(void) { }
	
};


class DELPHICLASS tagEXTLOGFONTWWrapper;
class PASCALIMPLEMENTATION tagEXTLOGFONTWWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FelfVersion;
	unsigned FelfStyleSize;
	unsigned FelfMatch;
	unsigned FelfReserved;
	unsigned FelfCulture;
	
public:
	__fastcall tagEXTLOGFONTWWrapper(const tagEXTLOGFONTW &ARecord);
	tagEXTLOGFONTW __fastcall ObjToRec(void);
	
__published:
	__property unsigned elfVersion = {read=FelfVersion, write=FelfVersion, nodefault};
	__property unsigned elfStyleSize = {read=FelfStyleSize, write=FelfStyleSize, nodefault};
	__property unsigned elfMatch = {read=FelfMatch, write=FelfMatch, nodefault};
	__property unsigned elfReserved = {read=FelfReserved, write=FelfReserved, nodefault};
	__property unsigned elfCulture = {read=FelfCulture, write=FelfCulture, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagEXTLOGFONTWWrapper(void) { }
	
};


class DELPHICLASS _devicemodeAWrapper;
class PASCALIMPLEMENTATION _devicemodeAWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	System::Word FdmSpecVersion;
	System::Word FdmDriverVersion;
	System::Word FdmSize;
	System::Word FdmDriverExtra;
	unsigned FdmFields;
	short FdmOrientation;
	short FdmPaperSize;
	short FdmPaperLength;
	short FdmPaperWidth;
	short FdmScale;
	short FdmCopies;
	short FdmDefaultSource;
	short FdmPrintQuality;
	short FdmColor;
	short FdmDuplex;
	short FdmYResolution;
	short FdmTTOption;
	short FdmCollate;
	System::Word FdmLogPixels;
	unsigned FdmBitsPerPel;
	unsigned FdmPelsWidth;
	unsigned FdmPelsHeight;
	unsigned FdmDisplayFlags;
	unsigned FdmDisplayFrequency;
	unsigned FdmICMMethod;
	unsigned FdmICMIntent;
	unsigned FdmMediaType;
	unsigned FdmDitherType;
	unsigned FdmICCManufacturer;
	unsigned FdmICCModel;
	unsigned FdmPanningWidth;
	unsigned FdmPanningHeight;
	
public:
	__fastcall _devicemodeAWrapper(const _devicemodeA &ARecord);
	_devicemodeA __fastcall ObjToRec(void);
	
__published:
	__property System::Word dmSpecVersion = {read=FdmSpecVersion, write=FdmSpecVersion, nodefault};
	__property System::Word dmDriverVersion = {read=FdmDriverVersion, write=FdmDriverVersion, nodefault};
	__property System::Word dmSize = {read=FdmSize, write=FdmSize, nodefault};
	__property System::Word dmDriverExtra = {read=FdmDriverExtra, write=FdmDriverExtra, nodefault};
	__property unsigned dmFields = {read=FdmFields, write=FdmFields, nodefault};
	__property short dmOrientation = {read=FdmOrientation, write=FdmOrientation, nodefault};
	__property short dmPaperSize = {read=FdmPaperSize, write=FdmPaperSize, nodefault};
	__property short dmPaperLength = {read=FdmPaperLength, write=FdmPaperLength, nodefault};
	__property short dmPaperWidth = {read=FdmPaperWidth, write=FdmPaperWidth, nodefault};
	__property short dmScale = {read=FdmScale, write=FdmScale, nodefault};
	__property short dmCopies = {read=FdmCopies, write=FdmCopies, nodefault};
	__property short dmDefaultSource = {read=FdmDefaultSource, write=FdmDefaultSource, nodefault};
	__property short dmPrintQuality = {read=FdmPrintQuality, write=FdmPrintQuality, nodefault};
	__property short dmColor = {read=FdmColor, write=FdmColor, nodefault};
	__property short dmDuplex = {read=FdmDuplex, write=FdmDuplex, nodefault};
	__property short dmYResolution = {read=FdmYResolution, write=FdmYResolution, nodefault};
	__property short dmTTOption = {read=FdmTTOption, write=FdmTTOption, nodefault};
	__property short dmCollate = {read=FdmCollate, write=FdmCollate, nodefault};
	__property System::Word dmLogPixels = {read=FdmLogPixels, write=FdmLogPixels, nodefault};
	__property unsigned dmBitsPerPel = {read=FdmBitsPerPel, write=FdmBitsPerPel, nodefault};
	__property unsigned dmPelsWidth = {read=FdmPelsWidth, write=FdmPelsWidth, nodefault};
	__property unsigned dmPelsHeight = {read=FdmPelsHeight, write=FdmPelsHeight, nodefault};
	__property unsigned dmDisplayFlags = {read=FdmDisplayFlags, write=FdmDisplayFlags, nodefault};
	__property unsigned dmDisplayFrequency = {read=FdmDisplayFrequency, write=FdmDisplayFrequency, nodefault};
	__property unsigned dmICMMethod = {read=FdmICMMethod, write=FdmICMMethod, nodefault};
	__property unsigned dmICMIntent = {read=FdmICMIntent, write=FdmICMIntent, nodefault};
	__property unsigned dmMediaType = {read=FdmMediaType, write=FdmMediaType, nodefault};
	__property unsigned dmDitherType = {read=FdmDitherType, write=FdmDitherType, nodefault};
	__property unsigned dmICCManufacturer = {read=FdmICCManufacturer, write=FdmICCManufacturer, nodefault};
	__property unsigned dmICCModel = {read=FdmICCModel, write=FdmICCModel, nodefault};
	__property unsigned dmPanningWidth = {read=FdmPanningWidth, write=FdmPanningWidth, nodefault};
	__property unsigned dmPanningHeight = {read=FdmPanningHeight, write=FdmPanningHeight, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_devicemodeAWrapper(void) { }
	
};


class DELPHICLASS _devicemodeWWrapper;
class PASCALIMPLEMENTATION _devicemodeWWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	System::Word FdmSpecVersion;
	System::Word FdmDriverVersion;
	System::Word FdmSize;
	System::Word FdmDriverExtra;
	unsigned FdmFields;
	short FdmOrientation;
	short FdmPaperSize;
	short FdmPaperLength;
	short FdmPaperWidth;
	short FdmScale;
	short FdmCopies;
	short FdmDefaultSource;
	short FdmPrintQuality;
	short FdmColor;
	short FdmDuplex;
	short FdmYResolution;
	short FdmTTOption;
	short FdmCollate;
	System::Word FdmLogPixels;
	unsigned FdmBitsPerPel;
	unsigned FdmPelsWidth;
	unsigned FdmPelsHeight;
	unsigned FdmDisplayFlags;
	unsigned FdmDisplayFrequency;
	unsigned FdmICMMethod;
	unsigned FdmICMIntent;
	unsigned FdmMediaType;
	unsigned FdmDitherType;
	unsigned FdmICCManufacturer;
	unsigned FdmICCModel;
	unsigned FdmPanningWidth;
	unsigned FdmPanningHeight;
	
public:
	__fastcall _devicemodeWWrapper(const _devicemodeW &ARecord);
	_devicemodeW __fastcall ObjToRec(void);
	
__published:
	__property System::Word dmSpecVersion = {read=FdmSpecVersion, write=FdmSpecVersion, nodefault};
	__property System::Word dmDriverVersion = {read=FdmDriverVersion, write=FdmDriverVersion, nodefault};
	__property System::Word dmSize = {read=FdmSize, write=FdmSize, nodefault};
	__property System::Word dmDriverExtra = {read=FdmDriverExtra, write=FdmDriverExtra, nodefault};
	__property unsigned dmFields = {read=FdmFields, write=FdmFields, nodefault};
	__property short dmOrientation = {read=FdmOrientation, write=FdmOrientation, nodefault};
	__property short dmPaperSize = {read=FdmPaperSize, write=FdmPaperSize, nodefault};
	__property short dmPaperLength = {read=FdmPaperLength, write=FdmPaperLength, nodefault};
	__property short dmPaperWidth = {read=FdmPaperWidth, write=FdmPaperWidth, nodefault};
	__property short dmScale = {read=FdmScale, write=FdmScale, nodefault};
	__property short dmCopies = {read=FdmCopies, write=FdmCopies, nodefault};
	__property short dmDefaultSource = {read=FdmDefaultSource, write=FdmDefaultSource, nodefault};
	__property short dmPrintQuality = {read=FdmPrintQuality, write=FdmPrintQuality, nodefault};
	__property short dmColor = {read=FdmColor, write=FdmColor, nodefault};
	__property short dmDuplex = {read=FdmDuplex, write=FdmDuplex, nodefault};
	__property short dmYResolution = {read=FdmYResolution, write=FdmYResolution, nodefault};
	__property short dmTTOption = {read=FdmTTOption, write=FdmTTOption, nodefault};
	__property short dmCollate = {read=FdmCollate, write=FdmCollate, nodefault};
	__property System::Word dmLogPixels = {read=FdmLogPixels, write=FdmLogPixels, nodefault};
	__property unsigned dmBitsPerPel = {read=FdmBitsPerPel, write=FdmBitsPerPel, nodefault};
	__property unsigned dmPelsWidth = {read=FdmPelsWidth, write=FdmPelsWidth, nodefault};
	__property unsigned dmPelsHeight = {read=FdmPelsHeight, write=FdmPelsHeight, nodefault};
	__property unsigned dmDisplayFlags = {read=FdmDisplayFlags, write=FdmDisplayFlags, nodefault};
	__property unsigned dmDisplayFrequency = {read=FdmDisplayFrequency, write=FdmDisplayFrequency, nodefault};
	__property unsigned dmICMMethod = {read=FdmICMMethod, write=FdmICMMethod, nodefault};
	__property unsigned dmICMIntent = {read=FdmICMIntent, write=FdmICMIntent, nodefault};
	__property unsigned dmMediaType = {read=FdmMediaType, write=FdmMediaType, nodefault};
	__property unsigned dmDitherType = {read=FdmDitherType, write=FdmDitherType, nodefault};
	__property unsigned dmICCManufacturer = {read=FdmICCManufacturer, write=FdmICCManufacturer, nodefault};
	__property unsigned dmICCModel = {read=FdmICCModel, write=FdmICCModel, nodefault};
	__property unsigned dmPanningWidth = {read=FdmPanningWidth, write=FdmPanningWidth, nodefault};
	__property unsigned dmPanningHeight = {read=FdmPanningHeight, write=FdmPanningHeight, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_devicemodeWWrapper(void) { }
	
};


class DELPHICLASS _DISPLAY_DEVICEAWrapper;
class PASCALIMPLEMENTATION _DISPLAY_DEVICEAWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned Fcb;
	unsigned FStateFlags;
	
public:
	__fastcall _DISPLAY_DEVICEAWrapper(const _DISPLAY_DEVICEA &ARecord);
	_DISPLAY_DEVICEA __fastcall ObjToRec(void);
	
__published:
	__property unsigned cb = {read=Fcb, write=Fcb, nodefault};
	__property unsigned StateFlags = {read=FStateFlags, write=FStateFlags, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_DISPLAY_DEVICEAWrapper(void) { }
	
};


class DELPHICLASS _DISPLAY_DEVICEWWrapper;
class PASCALIMPLEMENTATION _DISPLAY_DEVICEWWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned Fcb;
	unsigned FStateFlags;
	
public:
	__fastcall _DISPLAY_DEVICEWWrapper(const _DISPLAY_DEVICEW &ARecord);
	_DISPLAY_DEVICEW __fastcall ObjToRec(void);
	
__published:
	__property unsigned cb = {read=Fcb, write=Fcb, nodefault};
	__property unsigned StateFlags = {read=FStateFlags, write=FStateFlags, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_DISPLAY_DEVICEWWrapper(void) { }
	
};


class DELPHICLASS _RGNDATAHEADERWrapper;
class PASCALIMPLEMENTATION _RGNDATAHEADERWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FdwSize;
	unsigned FiType;
	unsigned FnCount;
	unsigned FnRgnSize;
	
public:
	__fastcall _RGNDATAHEADERWrapper(const _RGNDATAHEADER &ARecord);
	_RGNDATAHEADER __fastcall ObjToRec(void);
	
__published:
	__property unsigned dwSize = {read=FdwSize, write=FdwSize, nodefault};
	__property unsigned iType = {read=FiType, write=FiType, nodefault};
	__property unsigned nCount = {read=FnCount, write=FnCount, nodefault};
	__property unsigned nRgnSize = {read=FnRgnSize, write=FnRgnSize, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_RGNDATAHEADERWrapper(void) { }
	
};


class DELPHICLASS _RGNDATAWrapper;
class PASCALIMPLEMENTATION _RGNDATAWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
public:
	__fastcall _RGNDATAWrapper(const _RGNDATA &ARecord);
	_RGNDATA __fastcall ObjToRec(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_RGNDATAWrapper(void) { }
	
};


class DELPHICLASS _ABCWrapper;
class PASCALIMPLEMENTATION _ABCWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	int FabcA;
	unsigned FabcB;
	int FabcC;
	
public:
	__fastcall _ABCWrapper(const _ABC &ARecord);
	_ABC __fastcall ObjToRec(void);
	
__published:
	__property int abcA = {read=FabcA, write=FabcA, nodefault};
	__property unsigned abcB = {read=FabcB, write=FabcB, nodefault};
	__property int abcC = {read=FabcC, write=FabcC, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_ABCWrapper(void) { }
	
};


class DELPHICLASS _ABCFLOATWrapper;
class PASCALIMPLEMENTATION _ABCFLOATWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	float FabcfA;
	float FabcfB;
	float FabcfC;
	
public:
	__fastcall _ABCFLOATWrapper(const _ABCFLOAT &ARecord);
	_ABCFLOAT __fastcall ObjToRec(void);
	
__published:
	__property float abcfA = {read=FabcfA, write=FabcfA};
	__property float abcfB = {read=FabcfB, write=FabcfB};
	__property float abcfC = {read=FabcfC, write=FabcfC};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_ABCFLOATWrapper(void) { }
	
};


class DELPHICLASS _OUTLINETEXTMETRICAWrapper;
class PASCALIMPLEMENTATION _OUTLINETEXTMETRICAWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FotmSize;
	System::Byte FotmFiller;
	unsigned FotmfsSelection;
	unsigned FotmfsType;
	int FotmsCharSlopeRise;
	int FotmsCharSlopeRun;
	int FotmItalicAngle;
	unsigned FotmEMSquare;
	int FotmAscent;
	int FotmDescent;
	unsigned FotmLineGap;
	unsigned FotmsCapEmHeight;
	unsigned FotmsXHeight;
	int FotmMacAscent;
	int FotmMacDescent;
	unsigned FotmMacLineGap;
	unsigned FotmusMinimumPPEM;
	unsigned FotmsStrikeoutSize;
	int FotmsStrikeoutPosition;
	int FotmsUnderscoreSize;
	int FotmsUnderscorePosition;
	
public:
	__fastcall _OUTLINETEXTMETRICAWrapper(const _OUTLINETEXTMETRICA &ARecord);
	_OUTLINETEXTMETRICA __fastcall ObjToRec(void);
	
__published:
	__property unsigned otmSize = {read=FotmSize, write=FotmSize, nodefault};
	__property System::Byte otmFiller = {read=FotmFiller, write=FotmFiller, nodefault};
	__property unsigned otmfsSelection = {read=FotmfsSelection, write=FotmfsSelection, nodefault};
	__property unsigned otmfsType = {read=FotmfsType, write=FotmfsType, nodefault};
	__property int otmsCharSlopeRise = {read=FotmsCharSlopeRise, write=FotmsCharSlopeRise, nodefault};
	__property int otmsCharSlopeRun = {read=FotmsCharSlopeRun, write=FotmsCharSlopeRun, nodefault};
	__property int otmItalicAngle = {read=FotmItalicAngle, write=FotmItalicAngle, nodefault};
	__property unsigned otmEMSquare = {read=FotmEMSquare, write=FotmEMSquare, nodefault};
	__property int otmAscent = {read=FotmAscent, write=FotmAscent, nodefault};
	__property int otmDescent = {read=FotmDescent, write=FotmDescent, nodefault};
	__property unsigned otmLineGap = {read=FotmLineGap, write=FotmLineGap, nodefault};
	__property unsigned otmsCapEmHeight = {read=FotmsCapEmHeight, write=FotmsCapEmHeight, nodefault};
	__property unsigned otmsXHeight = {read=FotmsXHeight, write=FotmsXHeight, nodefault};
	__property int otmMacAscent = {read=FotmMacAscent, write=FotmMacAscent, nodefault};
	__property int otmMacDescent = {read=FotmMacDescent, write=FotmMacDescent, nodefault};
	__property unsigned otmMacLineGap = {read=FotmMacLineGap, write=FotmMacLineGap, nodefault};
	__property unsigned otmusMinimumPPEM = {read=FotmusMinimumPPEM, write=FotmusMinimumPPEM, nodefault};
	__property unsigned otmsStrikeoutSize = {read=FotmsStrikeoutSize, write=FotmsStrikeoutSize, nodefault};
	__property int otmsStrikeoutPosition = {read=FotmsStrikeoutPosition, write=FotmsStrikeoutPosition, nodefault};
	__property int otmsUnderscoreSize = {read=FotmsUnderscoreSize, write=FotmsUnderscoreSize, nodefault};
	__property int otmsUnderscorePosition = {read=FotmsUnderscorePosition, write=FotmsUnderscorePosition, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_OUTLINETEXTMETRICAWrapper(void) { }
	
};


class DELPHICLASS _OUTLINETEXTMETRICWWrapper;
class PASCALIMPLEMENTATION _OUTLINETEXTMETRICWWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FotmSize;
	System::Byte FotmFiller;
	unsigned FotmfsSelection;
	unsigned FotmfsType;
	int FotmsCharSlopeRise;
	int FotmsCharSlopeRun;
	int FotmItalicAngle;
	unsigned FotmEMSquare;
	int FotmAscent;
	int FotmDescent;
	unsigned FotmLineGap;
	unsigned FotmsCapEmHeight;
	unsigned FotmsXHeight;
	int FotmMacAscent;
	int FotmMacDescent;
	unsigned FotmMacLineGap;
	unsigned FotmusMinimumPPEM;
	unsigned FotmsStrikeoutSize;
	int FotmsStrikeoutPosition;
	int FotmsUnderscoreSize;
	int FotmsUnderscorePosition;
	
public:
	__fastcall _OUTLINETEXTMETRICWWrapper(const _OUTLINETEXTMETRICW &ARecord);
	_OUTLINETEXTMETRICW __fastcall ObjToRec(void);
	
__published:
	__property unsigned otmSize = {read=FotmSize, write=FotmSize, nodefault};
	__property System::Byte otmFiller = {read=FotmFiller, write=FotmFiller, nodefault};
	__property unsigned otmfsSelection = {read=FotmfsSelection, write=FotmfsSelection, nodefault};
	__property unsigned otmfsType = {read=FotmfsType, write=FotmfsType, nodefault};
	__property int otmsCharSlopeRise = {read=FotmsCharSlopeRise, write=FotmsCharSlopeRise, nodefault};
	__property int otmsCharSlopeRun = {read=FotmsCharSlopeRun, write=FotmsCharSlopeRun, nodefault};
	__property int otmItalicAngle = {read=FotmItalicAngle, write=FotmItalicAngle, nodefault};
	__property unsigned otmEMSquare = {read=FotmEMSquare, write=FotmEMSquare, nodefault};
	__property int otmAscent = {read=FotmAscent, write=FotmAscent, nodefault};
	__property int otmDescent = {read=FotmDescent, write=FotmDescent, nodefault};
	__property unsigned otmLineGap = {read=FotmLineGap, write=FotmLineGap, nodefault};
	__property unsigned otmsCapEmHeight = {read=FotmsCapEmHeight, write=FotmsCapEmHeight, nodefault};
	__property unsigned otmsXHeight = {read=FotmsXHeight, write=FotmsXHeight, nodefault};
	__property int otmMacAscent = {read=FotmMacAscent, write=FotmMacAscent, nodefault};
	__property int otmMacDescent = {read=FotmMacDescent, write=FotmMacDescent, nodefault};
	__property unsigned otmMacLineGap = {read=FotmMacLineGap, write=FotmMacLineGap, nodefault};
	__property unsigned otmusMinimumPPEM = {read=FotmusMinimumPPEM, write=FotmusMinimumPPEM, nodefault};
	__property unsigned otmsStrikeoutSize = {read=FotmsStrikeoutSize, write=FotmsStrikeoutSize, nodefault};
	__property int otmsStrikeoutPosition = {read=FotmsStrikeoutPosition, write=FotmsStrikeoutPosition, nodefault};
	__property int otmsUnderscoreSize = {read=FotmsUnderscoreSize, write=FotmsUnderscoreSize, nodefault};
	__property int otmsUnderscorePosition = {read=FotmsUnderscorePosition, write=FotmsUnderscorePosition, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_OUTLINETEXTMETRICWWrapper(void) { }
	
};


class DELPHICLASS tagPOLYTEXTAWrapper;
class PASCALIMPLEMENTATION tagPOLYTEXTAWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	int Fx;
	int Fy;
	unsigned Fn;
	unsigned FuiFlags;
	
public:
	__fastcall tagPOLYTEXTAWrapper(const tagPOLYTEXTA &ARecord);
	tagPOLYTEXTA __fastcall ObjToRec(void);
	
__published:
	__property int x = {read=Fx, write=Fx, nodefault};
	__property int y = {read=Fy, write=Fy, nodefault};
	__property unsigned n = {read=Fn, write=Fn, nodefault};
	__property unsigned uiFlags = {read=FuiFlags, write=FuiFlags, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagPOLYTEXTAWrapper(void) { }
	
};


class DELPHICLASS tagPOLYTEXTWWrapper;
class PASCALIMPLEMENTATION tagPOLYTEXTWWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	int Fx;
	int Fy;
	unsigned Fn;
	unsigned FuiFlags;
	
public:
	__fastcall tagPOLYTEXTWWrapper(const tagPOLYTEXTW &ARecord);
	tagPOLYTEXTW __fastcall ObjToRec(void);
	
__published:
	__property int x = {read=Fx, write=Fx, nodefault};
	__property int y = {read=Fy, write=Fy, nodefault};
	__property unsigned n = {read=Fn, write=Fn, nodefault};
	__property unsigned uiFlags = {read=FuiFlags, write=FuiFlags, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagPOLYTEXTWWrapper(void) { }
	
};


class DELPHICLASS _FIXEDWrapper;
class PASCALIMPLEMENTATION _FIXEDWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	System::Word Ffract;
	short Fvalue;
	
public:
	__fastcall _FIXEDWrapper(_FIXED ARecord);
	_FIXED __fastcall ObjToRec(void);
	
__published:
	__property System::Word fract = {read=Ffract, write=Ffract, nodefault};
	__property short value = {read=Fvalue, write=Fvalue, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_FIXEDWrapper(void) { }
	
};


class DELPHICLASS _MAT2Wrapper;
class PASCALIMPLEMENTATION _MAT2Wrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
public:
	__fastcall _MAT2Wrapper(const _MAT2 &ARecord);
	_MAT2 __fastcall ObjToRec(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_MAT2Wrapper(void) { }
	
};


class DELPHICLASS _GLYPHMETRICSWrapper;
class PASCALIMPLEMENTATION _GLYPHMETRICSWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FgmBlackBoxX;
	unsigned FgmBlackBoxY;
	short FgmCellIncX;
	short FgmCellIncY;
	
public:
	__fastcall _GLYPHMETRICSWrapper(const _GLYPHMETRICS &ARecord);
	_GLYPHMETRICS __fastcall ObjToRec(void);
	
__published:
	__property unsigned gmBlackBoxX = {read=FgmBlackBoxX, write=FgmBlackBoxX, nodefault};
	__property unsigned gmBlackBoxY = {read=FgmBlackBoxY, write=FgmBlackBoxY, nodefault};
	__property short gmCellIncX = {read=FgmCellIncX, write=FgmCellIncX, nodefault};
	__property short gmCellIncY = {read=FgmCellIncY, write=FgmCellIncY, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_GLYPHMETRICSWrapper(void) { }
	
};


class DELPHICLASS tagPOINTFXWrapper;
class PASCALIMPLEMENTATION tagPOINTFXWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
public:
	__fastcall tagPOINTFXWrapper(const tagPOINTFX &ARecord);
	tagPOINTFX __fastcall ObjToRec(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagPOINTFXWrapper(void) { }
	
};


class DELPHICLASS tagTTPOLYCURVEWrapper;
class PASCALIMPLEMENTATION tagTTPOLYCURVEWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	System::Word FwType;
	System::Word Fcpfx;
	
public:
	__fastcall tagTTPOLYCURVEWrapper(const tagTTPOLYCURVE &ARecord);
	tagTTPOLYCURVE __fastcall ObjToRec(void);
	
__published:
	__property System::Word wType = {read=FwType, write=FwType, nodefault};
	__property System::Word cpfx = {read=Fcpfx, write=Fcpfx, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagTTPOLYCURVEWrapper(void) { }
	
};


class DELPHICLASS tagTTPOLYGONHEADERWrapper;
class PASCALIMPLEMENTATION tagTTPOLYGONHEADERWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned Fcb;
	unsigned FdwType;
	
public:
	__fastcall tagTTPOLYGONHEADERWrapper(const tagTTPOLYGONHEADER &ARecord);
	tagTTPOLYGONHEADER __fastcall ObjToRec(void);
	
__published:
	__property unsigned cb = {read=Fcb, write=Fcb, nodefault};
	__property unsigned dwType = {read=FdwType, write=FdwType, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagTTPOLYGONHEADERWrapper(void) { }
	
};


class DELPHICLASS tagGCP_RESULTSAWrapper;
class PASCALIMPLEMENTATION tagGCP_RESULTSAWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FlStructSize;
	unsigned FnGlyphs;
	int FnMaxFit;
	
public:
	__fastcall tagGCP_RESULTSAWrapper(const tagGCP_RESULTSA &ARecord);
	tagGCP_RESULTSA __fastcall ObjToRec(void);
	
__published:
	__property unsigned lStructSize = {read=FlStructSize, write=FlStructSize, nodefault};
	__property unsigned nGlyphs = {read=FnGlyphs, write=FnGlyphs, nodefault};
	__property int nMaxFit = {read=FnMaxFit, write=FnMaxFit, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagGCP_RESULTSAWrapper(void) { }
	
};


class DELPHICLASS tagGCP_RESULTSWWrapper;
class PASCALIMPLEMENTATION tagGCP_RESULTSWWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FlStructSize;
	unsigned FnGlyphs;
	int FnMaxFit;
	
public:
	__fastcall tagGCP_RESULTSWWrapper(const tagGCP_RESULTSW &ARecord);
	tagGCP_RESULTSW __fastcall ObjToRec(void);
	
__published:
	__property unsigned lStructSize = {read=FlStructSize, write=FlStructSize, nodefault};
	__property unsigned nGlyphs = {read=FnGlyphs, write=FnGlyphs, nodefault};
	__property int nMaxFit = {read=FnMaxFit, write=FnMaxFit, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagGCP_RESULTSWWrapper(void) { }
	
};


class DELPHICLASS _RASTERIZER_STATUSWrapper;
class PASCALIMPLEMENTATION _RASTERIZER_STATUSWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	short FnSize;
	short FwFlags;
	short FnLanguageID;
	
public:
	__fastcall _RASTERIZER_STATUSWrapper(const _RASTERIZER_STATUS &ARecord);
	_RASTERIZER_STATUS __fastcall ObjToRec(void);
	
__published:
	__property short nSize = {read=FnSize, write=FnSize, nodefault};
	__property short wFlags = {read=FwFlags, write=FwFlags, nodefault};
	__property short nLanguageID = {read=FnLanguageID, write=FnLanguageID, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_RASTERIZER_STATUSWrapper(void) { }
	
};


class DELPHICLASS tagPIXELFORMATDESCRIPTORWrapper;
class PASCALIMPLEMENTATION tagPIXELFORMATDESCRIPTORWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	System::Word FnSize;
	System::Word FnVersion;
	unsigned FdwFlags;
	System::Byte FiPixelType;
	System::Byte FcColorBits;
	System::Byte FcRedBits;
	System::Byte FcRedShift;
	System::Byte FcGreenBits;
	System::Byte FcGreenShift;
	System::Byte FcBlueBits;
	System::Byte FcBlueShift;
	System::Byte FcAlphaBits;
	System::Byte FcAlphaShift;
	System::Byte FcAccumBits;
	System::Byte FcAccumRedBits;
	System::Byte FcAccumGreenBits;
	System::Byte FcAccumBlueBits;
	System::Byte FcAccumAlphaBits;
	System::Byte FcDepthBits;
	System::Byte FcStencilBits;
	System::Byte FcAuxBuffers;
	System::Byte FiLayerType;
	System::Byte FbReserved;
	unsigned FdwLayerMask;
	unsigned FdwVisibleMask;
	unsigned FdwDamageMask;
	
public:
	__fastcall tagPIXELFORMATDESCRIPTORWrapper(const tagPIXELFORMATDESCRIPTOR &ARecord);
	tagPIXELFORMATDESCRIPTOR __fastcall ObjToRec(void);
	
__published:
	__property System::Word nSize = {read=FnSize, write=FnSize, nodefault};
	__property System::Word nVersion = {read=FnVersion, write=FnVersion, nodefault};
	__property unsigned dwFlags = {read=FdwFlags, write=FdwFlags, nodefault};
	__property System::Byte iPixelType = {read=FiPixelType, write=FiPixelType, nodefault};
	__property System::Byte cColorBits = {read=FcColorBits, write=FcColorBits, nodefault};
	__property System::Byte cRedBits = {read=FcRedBits, write=FcRedBits, nodefault};
	__property System::Byte cRedShift = {read=FcRedShift, write=FcRedShift, nodefault};
	__property System::Byte cGreenBits = {read=FcGreenBits, write=FcGreenBits, nodefault};
	__property System::Byte cGreenShift = {read=FcGreenShift, write=FcGreenShift, nodefault};
	__property System::Byte cBlueBits = {read=FcBlueBits, write=FcBlueBits, nodefault};
	__property System::Byte cBlueShift = {read=FcBlueShift, write=FcBlueShift, nodefault};
	__property System::Byte cAlphaBits = {read=FcAlphaBits, write=FcAlphaBits, nodefault};
	__property System::Byte cAlphaShift = {read=FcAlphaShift, write=FcAlphaShift, nodefault};
	__property System::Byte cAccumBits = {read=FcAccumBits, write=FcAccumBits, nodefault};
	__property System::Byte cAccumRedBits = {read=FcAccumRedBits, write=FcAccumRedBits, nodefault};
	__property System::Byte cAccumGreenBits = {read=FcAccumGreenBits, write=FcAccumGreenBits, nodefault};
	__property System::Byte cAccumBlueBits = {read=FcAccumBlueBits, write=FcAccumBlueBits, nodefault};
	__property System::Byte cAccumAlphaBits = {read=FcAccumAlphaBits, write=FcAccumAlphaBits, nodefault};
	__property System::Byte cDepthBits = {read=FcDepthBits, write=FcDepthBits, nodefault};
	__property System::Byte cStencilBits = {read=FcStencilBits, write=FcStencilBits, nodefault};
	__property System::Byte cAuxBuffers = {read=FcAuxBuffers, write=FcAuxBuffers, nodefault};
	__property System::Byte iLayerType = {read=FiLayerType, write=FiLayerType, nodefault};
	__property System::Byte bReserved = {read=FbReserved, write=FbReserved, nodefault};
	__property unsigned dwLayerMask = {read=FdwLayerMask, write=FdwLayerMask, nodefault};
	__property unsigned dwVisibleMask = {read=FdwVisibleMask, write=FdwVisibleMask, nodefault};
	__property unsigned dwDamageMask = {read=FdwDamageMask, write=FdwDamageMask, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagPIXELFORMATDESCRIPTORWrapper(void) { }
	
};


class DELPHICLASS tagWCRANGEWrapper;
class PASCALIMPLEMENTATION tagWCRANGEWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	short FcGlyphs;
	
public:
	__fastcall tagWCRANGEWrapper(tagWCRANGE ARecord);
	tagWCRANGE __fastcall ObjToRec(void);
	
__published:
	__property short cGlyphs = {read=FcGlyphs, write=FcGlyphs, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagWCRANGEWrapper(void) { }
	
};


class DELPHICLASS tagGLYPHSETWrapper;
class PASCALIMPLEMENTATION tagGLYPHSETWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FcbThis;
	unsigned FflAccel;
	unsigned FcGlyphsSupported;
	unsigned FcRanges;
	
public:
	__fastcall tagGLYPHSETWrapper(const tagGLYPHSET &ARecord);
	tagGLYPHSET __fastcall ObjToRec(void);
	
__published:
	__property unsigned cbThis = {read=FcbThis, write=FcbThis, nodefault};
	__property unsigned flAccel = {read=FflAccel, write=FflAccel, nodefault};
	__property unsigned cGlyphsSupported = {read=FcGlyphsSupported, write=FcGlyphsSupported, nodefault};
	__property unsigned cRanges = {read=FcRanges, write=FcRanges, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagGLYPHSETWrapper(void) { }
	
};


class DELPHICLASS tagDESIGNVECTORWrapper;
class PASCALIMPLEMENTATION tagDESIGNVECTORWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FdvReserved;
	unsigned FdvNumAxes;
	
public:
	__fastcall tagDESIGNVECTORWrapper(const tagDESIGNVECTOR &ARecord);
	tagDESIGNVECTOR __fastcall ObjToRec(void);
	
__published:
	__property unsigned dvReserved = {read=FdvReserved, write=FdvReserved, nodefault};
	__property unsigned dvNumAxes = {read=FdvNumAxes, write=FdvNumAxes, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagDESIGNVECTORWrapper(void) { }
	
};


class DELPHICLASS tagAXISINFOAWrapper;
class PASCALIMPLEMENTATION tagAXISINFOAWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	int FaxMinValue;
	int FaxMaxValue;
	
public:
	__fastcall tagAXISINFOAWrapper(const tagAXISINFOA &ARecord);
	tagAXISINFOA __fastcall ObjToRec(void);
	
__published:
	__property int axMinValue = {read=FaxMinValue, write=FaxMinValue, nodefault};
	__property int axMaxValue = {read=FaxMaxValue, write=FaxMaxValue, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagAXISINFOAWrapper(void) { }
	
};


class DELPHICLASS tagAXISINFOWWrapper;
class PASCALIMPLEMENTATION tagAXISINFOWWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	int FaxMinValue;
	int FaxMaxValue;
	
public:
	__fastcall tagAXISINFOWWrapper(const tagAXISINFOW &ARecord);
	tagAXISINFOW __fastcall ObjToRec(void);
	
__published:
	__property int axMinValue = {read=FaxMinValue, write=FaxMinValue, nodefault};
	__property int axMaxValue = {read=FaxMaxValue, write=FaxMaxValue, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagAXISINFOWWrapper(void) { }
	
};


class DELPHICLASS tagAXESLISTAWrapper;
class PASCALIMPLEMENTATION tagAXESLISTAWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FaxlReserved;
	unsigned FaxlNumAxes;
	
public:
	__fastcall tagAXESLISTAWrapper(const tagAXESLISTA &ARecord);
	tagAXESLISTA __fastcall ObjToRec(void);
	
__published:
	__property unsigned axlReserved = {read=FaxlReserved, write=FaxlReserved, nodefault};
	__property unsigned axlNumAxes = {read=FaxlNumAxes, write=FaxlNumAxes, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagAXESLISTAWrapper(void) { }
	
};


class DELPHICLASS tagAXESLISTWWrapper;
class PASCALIMPLEMENTATION tagAXESLISTWWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FaxlReserved;
	unsigned FaxlNumAxes;
	
public:
	__fastcall tagAXESLISTWWrapper(const tagAXESLISTW &ARecord);
	tagAXESLISTW __fastcall ObjToRec(void);
	
__published:
	__property unsigned axlReserved = {read=FaxlReserved, write=FaxlReserved, nodefault};
	__property unsigned axlNumAxes = {read=FaxlNumAxes, write=FaxlNumAxes, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagAXESLISTWWrapper(void) { }
	
};


class DELPHICLASS tagENUMLOGFONTEXDVAWrapper;
class PASCALIMPLEMENTATION tagENUMLOGFONTEXDVAWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
public:
	__fastcall tagENUMLOGFONTEXDVAWrapper(const tagENUMLOGFONTEXDVA &ARecord);
	tagENUMLOGFONTEXDVA __fastcall ObjToRec(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagENUMLOGFONTEXDVAWrapper(void) { }
	
};


class DELPHICLASS tagENUMLOGFONTEXDVWWrapper;
class PASCALIMPLEMENTATION tagENUMLOGFONTEXDVWWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
public:
	__fastcall tagENUMLOGFONTEXDVWWrapper(const tagENUMLOGFONTEXDVW &ARecord);
	tagENUMLOGFONTEXDVW __fastcall ObjToRec(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagENUMLOGFONTEXDVWWrapper(void) { }
	
};


class DELPHICLASS tagENUMTEXTMETRICAWrapper;
class PASCALIMPLEMENTATION tagENUMTEXTMETRICAWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
public:
	__fastcall tagENUMTEXTMETRICAWrapper(const tagENUMTEXTMETRICA &ARecord);
	tagENUMTEXTMETRICA __fastcall ObjToRec(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagENUMTEXTMETRICAWrapper(void) { }
	
};


class DELPHICLASS tagENUMTEXTMETRICWWrapper;
class PASCALIMPLEMENTATION tagENUMTEXTMETRICWWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
public:
	__fastcall tagENUMTEXTMETRICWWrapper(const tagENUMTEXTMETRICW &ARecord);
	tagENUMTEXTMETRICW __fastcall ObjToRec(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagENUMTEXTMETRICWWrapper(void) { }
	
};


class DELPHICLASS _TRIVERTEXWrapper;
class PASCALIMPLEMENTATION _TRIVERTEXWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	int Fx;
	int Fy;
	System::Word FRed;
	System::Word FGreen;
	System::Word FBlue;
	System::Word FAlpha;
	
public:
	__fastcall _TRIVERTEXWrapper(const _TRIVERTEX &ARecord);
	_TRIVERTEX __fastcall ObjToRec(void);
	
__published:
	__property int x = {read=Fx, write=Fx, nodefault};
	__property int y = {read=Fy, write=Fy, nodefault};
	__property System::Word Red = {read=FRed, write=FRed, nodefault};
	__property System::Word Green = {read=FGreen, write=FGreen, nodefault};
	__property System::Word Blue = {read=FBlue, write=FBlue, nodefault};
	__property System::Word Alpha = {read=FAlpha, write=FAlpha, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_TRIVERTEXWrapper(void) { }
	
};


class DELPHICLASS _GRADIENT_TRIANGLEWrapper;
class PASCALIMPLEMENTATION _GRADIENT_TRIANGLEWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FVertex1;
	unsigned FVertex2;
	unsigned FVertex3;
	
public:
	__fastcall _GRADIENT_TRIANGLEWrapper(const _GRADIENT_TRIANGLE &ARecord);
	_GRADIENT_TRIANGLE __fastcall ObjToRec(void);
	
__published:
	__property unsigned Vertex1 = {read=FVertex1, write=FVertex1, nodefault};
	__property unsigned Vertex2 = {read=FVertex2, write=FVertex2, nodefault};
	__property unsigned Vertex3 = {read=FVertex3, write=FVertex3, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_GRADIENT_TRIANGLEWrapper(void) { }
	
};


class DELPHICLASS _GRADIENT_RECTWrapper;
class PASCALIMPLEMENTATION _GRADIENT_RECTWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FUpperLeft;
	unsigned FLowerRight;
	
public:
	__fastcall _GRADIENT_RECTWrapper(const _GRADIENT_RECT &ARecord);
	_GRADIENT_RECT __fastcall ObjToRec(void);
	
__published:
	__property unsigned UpperLeft = {read=FUpperLeft, write=FUpperLeft, nodefault};
	__property unsigned LowerRight = {read=FLowerRight, write=FLowerRight, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_GRADIENT_RECTWrapper(void) { }
	
};


class DELPHICLASS tagDIBSECTIONWrapper;
class PASCALIMPLEMENTATION tagDIBSECTIONWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FdshSection;
	unsigned FdsOffset;
	
public:
	__fastcall tagDIBSECTIONWrapper(const tagDIBSECTION &ARecord);
	tagDIBSECTION __fastcall ObjToRec(void);
	
__published:
	__property unsigned dshSection = {read=FdshSection, write=FdshSection, nodefault};
	__property unsigned dsOffset = {read=FdsOffset, write=FdsOffset, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagDIBSECTIONWrapper(void) { }
	
};


class DELPHICLASS tagCOLORADJUSTMENTWrapper;
class PASCALIMPLEMENTATION tagCOLORADJUSTMENTWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	System::Word FcaSize;
	System::Word FcaFlags;
	System::Word FcaIlluminantIndex;
	System::Word FcaRedGamma;
	System::Word FcaGreenGamma;
	System::Word FcaBlueGamma;
	System::Word FcaReferenceBlack;
	System::Word FcaReferenceWhite;
	short FcaContrast;
	short FcaBrightness;
	short FcaColorfulness;
	short FcaRedGreenTint;
	
public:
	__fastcall tagCOLORADJUSTMENTWrapper(const tagCOLORADJUSTMENT &ARecord);
	tagCOLORADJUSTMENT __fastcall ObjToRec(void);
	
__published:
	__property System::Word caSize = {read=FcaSize, write=FcaSize, nodefault};
	__property System::Word caFlags = {read=FcaFlags, write=FcaFlags, nodefault};
	__property System::Word caIlluminantIndex = {read=FcaIlluminantIndex, write=FcaIlluminantIndex, nodefault};
	__property System::Word caRedGamma = {read=FcaRedGamma, write=FcaRedGamma, nodefault};
	__property System::Word caGreenGamma = {read=FcaGreenGamma, write=FcaGreenGamma, nodefault};
	__property System::Word caBlueGamma = {read=FcaBlueGamma, write=FcaBlueGamma, nodefault};
	__property System::Word caReferenceBlack = {read=FcaReferenceBlack, write=FcaReferenceBlack, nodefault};
	__property System::Word caReferenceWhite = {read=FcaReferenceWhite, write=FcaReferenceWhite, nodefault};
	__property short caContrast = {read=FcaContrast, write=FcaContrast, nodefault};
	__property short caBrightness = {read=FcaBrightness, write=FcaBrightness, nodefault};
	__property short caColorfulness = {read=FcaColorfulness, write=FcaColorfulness, nodefault};
	__property short caRedGreenTint = {read=FcaRedGreenTint, write=FcaRedGreenTint, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagCOLORADJUSTMENTWrapper(void) { }
	
};


class DELPHICLASS _DOCINFOAWrapper;
class PASCALIMPLEMENTATION _DOCINFOAWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	int FcbSize;
	unsigned FfwType;
	
public:
	__fastcall _DOCINFOAWrapper(const _DOCINFOA &ARecord);
	_DOCINFOA __fastcall ObjToRec(void);
	
__published:
	__property int cbSize = {read=FcbSize, write=FcbSize, nodefault};
	__property unsigned fwType = {read=FfwType, write=FfwType, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_DOCINFOAWrapper(void) { }
	
};


class DELPHICLASS _DOCINFOWWrapper;
class PASCALIMPLEMENTATION _DOCINFOWWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	int FcbSize;
	unsigned FfwType;
	
public:
	__fastcall _DOCINFOWWrapper(const _DOCINFOW &ARecord);
	_DOCINFOW __fastcall ObjToRec(void);
	
__published:
	__property int cbSize = {read=FcbSize, write=FcbSize, nodefault};
	__property unsigned fwType = {read=FfwType, write=FfwType, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_DOCINFOWWrapper(void) { }
	
};


class DELPHICLASS tagKERNINGPAIRWrapper;
class PASCALIMPLEMENTATION tagKERNINGPAIRWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	System::Word FwFirst;
	System::Word FwSecond;
	int FiKernAmount;
	
public:
	__fastcall tagKERNINGPAIRWrapper(const tagKERNINGPAIR &ARecord);
	tagKERNINGPAIR __fastcall ObjToRec(void);
	
__published:
	__property System::Word wFirst = {read=FwFirst, write=FwFirst, nodefault};
	__property System::Word wSecond = {read=FwSecond, write=FwSecond, nodefault};
	__property int iKernAmount = {read=FiKernAmount, write=FiKernAmount, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagKERNINGPAIRWrapper(void) { }
	
};


class DELPHICLASS tagEMRWrapper;
class PASCALIMPLEMENTATION tagEMRWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FiType;
	unsigned FnSize;
	
public:
	__fastcall tagEMRWrapper(const tagEMR &ARecord);
	tagEMR __fastcall ObjToRec(void);
	
__published:
	__property unsigned iType = {read=FiType, write=FiType, nodefault};
	__property unsigned nSize = {read=FnSize, write=FnSize, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagEMRWrapper(void) { }
	
};


class DELPHICLASS tagEMRTEXTWrapper;
class PASCALIMPLEMENTATION tagEMRTEXTWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FnChars;
	unsigned FoffString;
	unsigned FfOptions;
	unsigned FoffDx;
	
public:
	__fastcall tagEMRTEXTWrapper(const tagEMRTEXT &ARecord);
	tagEMRTEXT __fastcall ObjToRec(void);
	
__published:
	__property unsigned nChars = {read=FnChars, write=FnChars, nodefault};
	__property unsigned offString = {read=FoffString, write=FoffString, nodefault};
	__property unsigned fOptions = {read=FfOptions, write=FfOptions, nodefault};
	__property unsigned offDx = {read=FoffDx, write=FoffDx, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagEMRTEXTWrapper(void) { }
	
};


class DELPHICLASS tagABORTPATHWrapper;
class PASCALIMPLEMENTATION tagABORTPATHWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
public:
	__fastcall tagABORTPATHWrapper(const tagABORTPATH &ARecord);
	tagABORTPATH __fastcall ObjToRec(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagABORTPATHWrapper(void) { }
	
};


class DELPHICLASS tagEMRSELECTCLIPPATHWrapper;
class PASCALIMPLEMENTATION tagEMRSELECTCLIPPATHWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FiMode;
	
public:
	__fastcall tagEMRSELECTCLIPPATHWrapper(const tagEMRSELECTCLIPPATH &ARecord);
	tagEMRSELECTCLIPPATH __fastcall ObjToRec(void);
	
__published:
	__property unsigned iMode = {read=FiMode, write=FiMode, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagEMRSELECTCLIPPATHWrapper(void) { }
	
};


class DELPHICLASS tagEMRSETMITERLIMITWrapper;
class PASCALIMPLEMENTATION tagEMRSETMITERLIMITWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	float FeMiterLimit;
	
public:
	__fastcall tagEMRSETMITERLIMITWrapper(const tagEMRSETMITERLIMIT &ARecord);
	tagEMRSETMITERLIMIT __fastcall ObjToRec(void);
	
__published:
	__property float eMiterLimit = {read=FeMiterLimit, write=FeMiterLimit};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagEMRSETMITERLIMITWrapper(void) { }
	
};


class DELPHICLASS tagEMRRESTOREDCWrapper;
class PASCALIMPLEMENTATION tagEMRRESTOREDCWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	int FiRelative;
	
public:
	__fastcall tagEMRRESTOREDCWrapper(const tagEMRRESTOREDC &ARecord);
	tagEMRRESTOREDC __fastcall ObjToRec(void);
	
__published:
	__property int iRelative = {read=FiRelative, write=FiRelative, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagEMRRESTOREDCWrapper(void) { }
	
};


class DELPHICLASS tagEMRSETARCDIRECTIONWrapper;
class PASCALIMPLEMENTATION tagEMRSETARCDIRECTIONWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FiArcDirection;
	
public:
	__fastcall tagEMRSETARCDIRECTIONWrapper(const tagEMRSETARCDIRECTION &ARecord);
	tagEMRSETARCDIRECTION __fastcall ObjToRec(void);
	
__published:
	__property unsigned iArcDirection = {read=FiArcDirection, write=FiArcDirection, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagEMRSETARCDIRECTIONWrapper(void) { }
	
};


class DELPHICLASS tagEMRSETMAPPERFLAGSWrapper;
class PASCALIMPLEMENTATION tagEMRSETMAPPERFLAGSWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FdwFlags;
	
public:
	__fastcall tagEMRSETMAPPERFLAGSWrapper(const tagEMRSETMAPPERFLAGS &ARecord);
	tagEMRSETMAPPERFLAGS __fastcall ObjToRec(void);
	
__published:
	__property unsigned dwFlags = {read=FdwFlags, write=FdwFlags, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagEMRSETMAPPERFLAGSWrapper(void) { }
	
};


class DELPHICLASS tagEMRSETTEXTCOLORWrapper;
class PASCALIMPLEMENTATION tagEMRSETTEXTCOLORWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FcrColor;
	
public:
	__fastcall tagEMRSETTEXTCOLORWrapper(const tagEMRSETTEXTCOLOR &ARecord);
	tagEMRSETTEXTCOLOR __fastcall ObjToRec(void);
	
__published:
	__property unsigned crColor = {read=FcrColor, write=FcrColor, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagEMRSETTEXTCOLORWrapper(void) { }
	
};


class DELPHICLASS tagEMRSELECTOBJECTWrapper;
class PASCALIMPLEMENTATION tagEMRSELECTOBJECTWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FihObject;
	
public:
	__fastcall tagEMRSELECTOBJECTWrapper(const tagEMRSELECTOBJECT &ARecord);
	tagEMRSELECTOBJECT __fastcall ObjToRec(void);
	
__published:
	__property unsigned ihObject = {read=FihObject, write=FihObject, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagEMRSELECTOBJECTWrapper(void) { }
	
};


class DELPHICLASS tagEMRSETCOLORSPACEWrapper;
class PASCALIMPLEMENTATION tagEMRSETCOLORSPACEWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FihCS;
	
public:
	__fastcall tagEMRSETCOLORSPACEWrapper(const tagEMRSETCOLORSPACE &ARecord);
	tagEMRSETCOLORSPACE __fastcall ObjToRec(void);
	
__published:
	__property unsigned ihCS = {read=FihCS, write=FihCS, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagEMRSETCOLORSPACEWrapper(void) { }
	
};


class DELPHICLASS tagEMRSELECTPALETTEWrapper;
class PASCALIMPLEMENTATION tagEMRSELECTPALETTEWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FihPal;
	
public:
	__fastcall tagEMRSELECTPALETTEWrapper(const tagEMRSELECTPALETTE &ARecord);
	tagEMRSELECTPALETTE __fastcall ObjToRec(void);
	
__published:
	__property unsigned ihPal = {read=FihPal, write=FihPal, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagEMRSELECTPALETTEWrapper(void) { }
	
};


class DELPHICLASS tagEMRRESIZEPALETTEWrapper;
class PASCALIMPLEMENTATION tagEMRRESIZEPALETTEWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FihPal;
	unsigned FcEntries;
	
public:
	__fastcall tagEMRRESIZEPALETTEWrapper(const tagEMRRESIZEPALETTE &ARecord);
	tagEMRRESIZEPALETTE __fastcall ObjToRec(void);
	
__published:
	__property unsigned ihPal = {read=FihPal, write=FihPal, nodefault};
	__property unsigned cEntries = {read=FcEntries, write=FcEntries, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagEMRRESIZEPALETTEWrapper(void) { }
	
};


class DELPHICLASS tagEMRSETPALETTEENTRIESWrapper;
class PASCALIMPLEMENTATION tagEMRSETPALETTEENTRIESWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FihPal;
	unsigned FiStart;
	unsigned FcEntries;
	
public:
	__fastcall tagEMRSETPALETTEENTRIESWrapper(const tagEMRSETPALETTEENTRIES &ARecord);
	tagEMRSETPALETTEENTRIES __fastcall ObjToRec(void);
	
__published:
	__property unsigned ihPal = {read=FihPal, write=FihPal, nodefault};
	__property unsigned iStart = {read=FiStart, write=FiStart, nodefault};
	__property unsigned cEntries = {read=FcEntries, write=FcEntries, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagEMRSETPALETTEENTRIESWrapper(void) { }
	
};


class DELPHICLASS tagEMRSETCOLORADJUSTMENTWrapper;
class PASCALIMPLEMENTATION tagEMRSETCOLORADJUSTMENTWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
public:
	__fastcall tagEMRSETCOLORADJUSTMENTWrapper(const tagEMRSETCOLORADJUSTMENT &ARecord);
	tagEMRSETCOLORADJUSTMENT __fastcall ObjToRec(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagEMRSETCOLORADJUSTMENTWrapper(void) { }
	
};


class DELPHICLASS tagEMRGDICOMMENTWrapper;
class PASCALIMPLEMENTATION tagEMRGDICOMMENTWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FcbData;
	
public:
	__fastcall tagEMRGDICOMMENTWrapper(const tagEMRGDICOMMENT &ARecord);
	tagEMRGDICOMMENT __fastcall ObjToRec(void);
	
__published:
	__property unsigned cbData = {read=FcbData, write=FcbData, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagEMRGDICOMMENTWrapper(void) { }
	
};


class DELPHICLASS tagEMREOFWrapper;
class PASCALIMPLEMENTATION tagEMREOFWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FnPalEntries;
	unsigned FoffPalEntries;
	unsigned FnSizeLast;
	
public:
	__fastcall tagEMREOFWrapper(const tagEMREOF &ARecord);
	tagEMREOF __fastcall ObjToRec(void);
	
__published:
	__property unsigned nPalEntries = {read=FnPalEntries, write=FnPalEntries, nodefault};
	__property unsigned offPalEntries = {read=FoffPalEntries, write=FoffPalEntries, nodefault};
	__property unsigned nSizeLast = {read=FnSizeLast, write=FnSizeLast, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagEMREOFWrapper(void) { }
	
};


class DELPHICLASS tagEMRLINETOWrapper;
class PASCALIMPLEMENTATION tagEMRLINETOWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
public:
	__fastcall tagEMRLINETOWrapper(const tagEMRLINETO &ARecord);
	tagEMRLINETO __fastcall ObjToRec(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagEMRLINETOWrapper(void) { }
	
};


class DELPHICLASS tagEMROFFSETCLIPRGNWrapper;
class PASCALIMPLEMENTATION tagEMROFFSETCLIPRGNWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
public:
	__fastcall tagEMROFFSETCLIPRGNWrapper(const tagEMROFFSETCLIPRGN &ARecord);
	tagEMROFFSETCLIPRGN __fastcall ObjToRec(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagEMROFFSETCLIPRGNWrapper(void) { }
	
};


class DELPHICLASS tagEMRFILLPATHWrapper;
class PASCALIMPLEMENTATION tagEMRFILLPATHWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
public:
	__fastcall tagEMRFILLPATHWrapper(const tagEMRFILLPATH &ARecord);
	tagEMRFILLPATH __fastcall ObjToRec(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagEMRFILLPATHWrapper(void) { }
	
};


class DELPHICLASS tagEMREXCLUDECLIPRECTWrapper;
class PASCALIMPLEMENTATION tagEMREXCLUDECLIPRECTWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
public:
	__fastcall tagEMREXCLUDECLIPRECTWrapper(const tagEMREXCLUDECLIPRECT &ARecord);
	tagEMREXCLUDECLIPRECT __fastcall ObjToRec(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagEMREXCLUDECLIPRECTWrapper(void) { }
	
};


class DELPHICLASS tagEMRSETVIEWPORTORGEXWrapper;
class PASCALIMPLEMENTATION tagEMRSETVIEWPORTORGEXWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
public:
	__fastcall tagEMRSETVIEWPORTORGEXWrapper(const tagEMRSETVIEWPORTORGEX &ARecord);
	tagEMRSETVIEWPORTORGEX __fastcall ObjToRec(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagEMRSETVIEWPORTORGEXWrapper(void) { }
	
};


class DELPHICLASS tagEMRSETVIEWPORTEXTEXWrapper;
class PASCALIMPLEMENTATION tagEMRSETVIEWPORTEXTEXWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
public:
	__fastcall tagEMRSETVIEWPORTEXTEXWrapper(const tagEMRSETVIEWPORTEXTEX &ARecord);
	tagEMRSETVIEWPORTEXTEX __fastcall ObjToRec(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagEMRSETVIEWPORTEXTEXWrapper(void) { }
	
};


class DELPHICLASS tagEMRSCALEVIEWPORTEXTEXWrapper;
class PASCALIMPLEMENTATION tagEMRSCALEVIEWPORTEXTEXWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	int FxNum;
	int FxDenom;
	int FyNum;
	int FyDenom;
	
public:
	__fastcall tagEMRSCALEVIEWPORTEXTEXWrapper(const tagEMRSCALEVIEWPORTEXTEX &ARecord);
	tagEMRSCALEVIEWPORTEXTEX __fastcall ObjToRec(void);
	
__published:
	__property int xNum = {read=FxNum, write=FxNum, nodefault};
	__property int xDenom = {read=FxDenom, write=FxDenom, nodefault};
	__property int yNum = {read=FyNum, write=FyNum, nodefault};
	__property int yDenom = {read=FyDenom, write=FyDenom, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagEMRSCALEVIEWPORTEXTEXWrapper(void) { }
	
};


class DELPHICLASS tagEMRSETWORLDTRANSFORMWrapper;
class PASCALIMPLEMENTATION tagEMRSETWORLDTRANSFORMWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
public:
	__fastcall tagEMRSETWORLDTRANSFORMWrapper(const tagEMRSETWORLDTRANSFORM &ARecord);
	tagEMRSETWORLDTRANSFORM __fastcall ObjToRec(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagEMRSETWORLDTRANSFORMWrapper(void) { }
	
};


class DELPHICLASS tagEMRMODIFYWORLDTRANSFORMWrapper;
class PASCALIMPLEMENTATION tagEMRMODIFYWORLDTRANSFORMWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FiMode;
	
public:
	__fastcall tagEMRMODIFYWORLDTRANSFORMWrapper(const tagEMRMODIFYWORLDTRANSFORM &ARecord);
	tagEMRMODIFYWORLDTRANSFORM __fastcall ObjToRec(void);
	
__published:
	__property unsigned iMode = {read=FiMode, write=FiMode, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagEMRMODIFYWORLDTRANSFORMWrapper(void) { }
	
};


class DELPHICLASS tagEMRSETPIXELVWrapper;
class PASCALIMPLEMENTATION tagEMRSETPIXELVWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FcrColor;
	
public:
	__fastcall tagEMRSETPIXELVWrapper(const tagEMRSETPIXELV &ARecord);
	tagEMRSETPIXELV __fastcall ObjToRec(void);
	
__published:
	__property unsigned crColor = {read=FcrColor, write=FcrColor, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagEMRSETPIXELVWrapper(void) { }
	
};


class DELPHICLASS tagEMREXTFLOODFILLWrapper;
class PASCALIMPLEMENTATION tagEMREXTFLOODFILLWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FcrColor;
	unsigned FiMode;
	
public:
	__fastcall tagEMREXTFLOODFILLWrapper(const tagEMREXTFLOODFILL &ARecord);
	tagEMREXTFLOODFILL __fastcall ObjToRec(void);
	
__published:
	__property unsigned crColor = {read=FcrColor, write=FcrColor, nodefault};
	__property unsigned iMode = {read=FiMode, write=FiMode, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagEMREXTFLOODFILLWrapper(void) { }
	
};


class DELPHICLASS tagEMRELLIPSEWrapper;
class PASCALIMPLEMENTATION tagEMRELLIPSEWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
public:
	__fastcall tagEMRELLIPSEWrapper(const tagEMRELLIPSE &ARecord);
	tagEMRELLIPSE __fastcall ObjToRec(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagEMRELLIPSEWrapper(void) { }
	
};


class DELPHICLASS tagEMRROUNDRECTWrapper;
class PASCALIMPLEMENTATION tagEMRROUNDRECTWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
public:
	__fastcall tagEMRROUNDRECTWrapper(const tagEMRROUNDRECT &ARecord);
	tagEMRROUNDRECT __fastcall ObjToRec(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagEMRROUNDRECTWrapper(void) { }
	
};


class DELPHICLASS tagEMRARCWrapper;
class PASCALIMPLEMENTATION tagEMRARCWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
public:
	__fastcall tagEMRARCWrapper(const tagEMRARC &ARecord);
	tagEMRARC __fastcall ObjToRec(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagEMRARCWrapper(void) { }
	
};


class DELPHICLASS tagEMRANGLEARCWrapper;
class PASCALIMPLEMENTATION tagEMRANGLEARCWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FnRadius;
	float FeStartAngle;
	float FeSweepAngle;
	
public:
	__fastcall tagEMRANGLEARCWrapper(const tagEMRANGLEARC &ARecord);
	tagEMRANGLEARC __fastcall ObjToRec(void);
	
__published:
	__property unsigned nRadius = {read=FnRadius, write=FnRadius, nodefault};
	__property float eStartAngle = {read=FeStartAngle, write=FeStartAngle};
	__property float eSweepAngle = {read=FeSweepAngle, write=FeSweepAngle};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagEMRANGLEARCWrapper(void) { }
	
};


class DELPHICLASS tagEMRPOLYLINEWrapper;
class PASCALIMPLEMENTATION tagEMRPOLYLINEWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned Fcptl;
	
public:
	__fastcall tagEMRPOLYLINEWrapper(const tagEMRPOLYLINE &ARecord);
	tagEMRPOLYLINE __fastcall ObjToRec(void);
	
__published:
	__property unsigned cptl = {read=Fcptl, write=Fcptl, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagEMRPOLYLINEWrapper(void) { }
	
};


class DELPHICLASS tagEMRPOLYLINE16Wrapper;
class PASCALIMPLEMENTATION tagEMRPOLYLINE16Wrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned Fcpts;
	
public:
	__fastcall tagEMRPOLYLINE16Wrapper(const tagEMRPOLYLINE16 &ARecord);
	tagEMRPOLYLINE16 __fastcall ObjToRec(void);
	
__published:
	__property unsigned cpts = {read=Fcpts, write=Fcpts, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagEMRPOLYLINE16Wrapper(void) { }
	
};


class DELPHICLASS tagEMRPOLYDRAWWrapper;
class PASCALIMPLEMENTATION tagEMRPOLYDRAWWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned Fcptl;
	
public:
	__fastcall tagEMRPOLYDRAWWrapper(const tagEMRPOLYDRAW &ARecord);
	tagEMRPOLYDRAW __fastcall ObjToRec(void);
	
__published:
	__property unsigned cptl = {read=Fcptl, write=Fcptl, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagEMRPOLYDRAWWrapper(void) { }
	
};


class DELPHICLASS tagEMRPOLYDRAW16Wrapper;
class PASCALIMPLEMENTATION tagEMRPOLYDRAW16Wrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned Fcpts;
	
public:
	__fastcall tagEMRPOLYDRAW16Wrapper(const tagEMRPOLYDRAW16 &ARecord);
	tagEMRPOLYDRAW16 __fastcall ObjToRec(void);
	
__published:
	__property unsigned cpts = {read=Fcpts, write=Fcpts, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagEMRPOLYDRAW16Wrapper(void) { }
	
};


class DELPHICLASS tagEMRPOLYPOLYLINEWrapper;
class PASCALIMPLEMENTATION tagEMRPOLYPOLYLINEWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FnPolys;
	unsigned Fcptl;
	
public:
	__fastcall tagEMRPOLYPOLYLINEWrapper(const tagEMRPOLYPOLYLINE &ARecord);
	tagEMRPOLYPOLYLINE __fastcall ObjToRec(void);
	
__published:
	__property unsigned nPolys = {read=FnPolys, write=FnPolys, nodefault};
	__property unsigned cptl = {read=Fcptl, write=Fcptl, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagEMRPOLYPOLYLINEWrapper(void) { }
	
};


class DELPHICLASS tagEMRPOLYPOLYLINE16Wrapper;
class PASCALIMPLEMENTATION tagEMRPOLYPOLYLINE16Wrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FnPolys;
	unsigned Fcpts;
	
public:
	__fastcall tagEMRPOLYPOLYLINE16Wrapper(const tagEMRPOLYPOLYLINE16 &ARecord);
	tagEMRPOLYPOLYLINE16 __fastcall ObjToRec(void);
	
__published:
	__property unsigned nPolys = {read=FnPolys, write=FnPolys, nodefault};
	__property unsigned cpts = {read=Fcpts, write=Fcpts, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagEMRPOLYPOLYLINE16Wrapper(void) { }
	
};


class DELPHICLASS tagEMRINVERTRGNWrapper;
class PASCALIMPLEMENTATION tagEMRINVERTRGNWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FcbRgnData;
	
public:
	__fastcall tagEMRINVERTRGNWrapper(const tagEMRINVERTRGN &ARecord);
	tagEMRINVERTRGN __fastcall ObjToRec(void);
	
__published:
	__property unsigned cbRgnData = {read=FcbRgnData, write=FcbRgnData, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagEMRINVERTRGNWrapper(void) { }
	
};


class DELPHICLASS tagEMRFILLRGNWrapper;
class PASCALIMPLEMENTATION tagEMRFILLRGNWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FcbRgnData;
	unsigned FihBrush;
	
public:
	__fastcall tagEMRFILLRGNWrapper(const tagEMRFILLRGN &ARecord);
	tagEMRFILLRGN __fastcall ObjToRec(void);
	
__published:
	__property unsigned cbRgnData = {read=FcbRgnData, write=FcbRgnData, nodefault};
	__property unsigned ihBrush = {read=FihBrush, write=FihBrush, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagEMRFILLRGNWrapper(void) { }
	
};


class DELPHICLASS tagEMRFRAMERGNWrapper;
class PASCALIMPLEMENTATION tagEMRFRAMERGNWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FcbRgnData;
	unsigned FihBrush;
	
public:
	__fastcall tagEMRFRAMERGNWrapper(const tagEMRFRAMERGN &ARecord);
	tagEMRFRAMERGN __fastcall ObjToRec(void);
	
__published:
	__property unsigned cbRgnData = {read=FcbRgnData, write=FcbRgnData, nodefault};
	__property unsigned ihBrush = {read=FihBrush, write=FihBrush, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagEMRFRAMERGNWrapper(void) { }
	
};


class DELPHICLASS tagEMRGRADIENTFILLWrapper;
class PASCALIMPLEMENTATION tagEMRGRADIENTFILLWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FnVer;
	unsigned FnTri;
	unsigned FulMode;
	
public:
	__fastcall tagEMRGRADIENTFILLWrapper(const tagEMRGRADIENTFILL &ARecord);
	tagEMRGRADIENTFILL __fastcall ObjToRec(void);
	
__published:
	__property unsigned nVer = {read=FnVer, write=FnVer, nodefault};
	__property unsigned nTri = {read=FnTri, write=FnTri, nodefault};
	__property unsigned ulMode = {read=FulMode, write=FulMode, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagEMRGRADIENTFILLWrapper(void) { }
	
};


class DELPHICLASS tagEMREXTSELECTCLIPRGNWrapper;
class PASCALIMPLEMENTATION tagEMREXTSELECTCLIPRGNWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FcbRgnData;
	unsigned FiMode;
	
public:
	__fastcall tagEMREXTSELECTCLIPRGNWrapper(const tagEMREXTSELECTCLIPRGN &ARecord);
	tagEMREXTSELECTCLIPRGN __fastcall ObjToRec(void);
	
__published:
	__property unsigned cbRgnData = {read=FcbRgnData, write=FcbRgnData, nodefault};
	__property unsigned iMode = {read=FiMode, write=FiMode, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagEMREXTSELECTCLIPRGNWrapper(void) { }
	
};


class DELPHICLASS tagEMREXTTEXTOUTAWrapper;
class PASCALIMPLEMENTATION tagEMREXTTEXTOUTAWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FiGraphicsMode;
	float FexScale;
	float FeyScale;
	
public:
	__fastcall tagEMREXTTEXTOUTAWrapper(const tagEMREXTTEXTOUTA &ARecord);
	tagEMREXTTEXTOUTA __fastcall ObjToRec(void);
	
__published:
	__property unsigned iGraphicsMode = {read=FiGraphicsMode, write=FiGraphicsMode, nodefault};
	__property float exScale = {read=FexScale, write=FexScale};
	__property float eyScale = {read=FeyScale, write=FeyScale};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagEMREXTTEXTOUTAWrapper(void) { }
	
};


class DELPHICLASS tagEMRPOLYTEXTOUTAWrapper;
class PASCALIMPLEMENTATION tagEMRPOLYTEXTOUTAWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FiGraphicsMode;
	float FexScale;
	float FeyScale;
	int FcStrings;
	
public:
	__fastcall tagEMRPOLYTEXTOUTAWrapper(const tagEMRPOLYTEXTOUTA &ARecord);
	tagEMRPOLYTEXTOUTA __fastcall ObjToRec(void);
	
__published:
	__property unsigned iGraphicsMode = {read=FiGraphicsMode, write=FiGraphicsMode, nodefault};
	__property float exScale = {read=FexScale, write=FexScale};
	__property float eyScale = {read=FeyScale, write=FeyScale};
	__property int cStrings = {read=FcStrings, write=FcStrings, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagEMRPOLYTEXTOUTAWrapper(void) { }
	
};


class DELPHICLASS tagEMRBITBLTWrapper;
class PASCALIMPLEMENTATION tagEMRBITBLTWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	int FxDest;
	int FyDest;
	int FcxDest;
	int FcyDest;
	unsigned FdwRop;
	int FxSrc;
	int FySrc;
	unsigned FcrBkColorSrc;
	unsigned FiUsageSrc;
	unsigned FoffBmiSrc;
	unsigned FcbBmiSrc;
	unsigned FoffBitsSrc;
	unsigned FcbBitsSrc;
	
public:
	__fastcall tagEMRBITBLTWrapper(const tagEMRBITBLT &ARecord);
	tagEMRBITBLT __fastcall ObjToRec(void);
	
__published:
	__property int xDest = {read=FxDest, write=FxDest, nodefault};
	__property int yDest = {read=FyDest, write=FyDest, nodefault};
	__property int cxDest = {read=FcxDest, write=FcxDest, nodefault};
	__property int cyDest = {read=FcyDest, write=FcyDest, nodefault};
	__property unsigned dwRop = {read=FdwRop, write=FdwRop, nodefault};
	__property int xSrc = {read=FxSrc, write=FxSrc, nodefault};
	__property int ySrc = {read=FySrc, write=FySrc, nodefault};
	__property unsigned crBkColorSrc = {read=FcrBkColorSrc, write=FcrBkColorSrc, nodefault};
	__property unsigned iUsageSrc = {read=FiUsageSrc, write=FiUsageSrc, nodefault};
	__property unsigned offBmiSrc = {read=FoffBmiSrc, write=FoffBmiSrc, nodefault};
	__property unsigned cbBmiSrc = {read=FcbBmiSrc, write=FcbBmiSrc, nodefault};
	__property unsigned offBitsSrc = {read=FoffBitsSrc, write=FoffBitsSrc, nodefault};
	__property unsigned cbBitsSrc = {read=FcbBitsSrc, write=FcbBitsSrc, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagEMRBITBLTWrapper(void) { }
	
};


class DELPHICLASS tagEMRSTRETCHBLTWrapper;
class PASCALIMPLEMENTATION tagEMRSTRETCHBLTWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	int FxDest;
	int FyDest;
	int FcxDest;
	int FcyDest;
	unsigned FdwRop;
	int FxSrc;
	int FySrc;
	unsigned FcrBkColorSrc;
	unsigned FiUsageSrc;
	unsigned FoffBmiSrc;
	unsigned FcbBmiSrc;
	unsigned FoffBitsSrc;
	unsigned FcbBitsSrc;
	int FcxSrc;
	int FcySrc;
	
public:
	__fastcall tagEMRSTRETCHBLTWrapper(const tagEMRSTRETCHBLT &ARecord);
	tagEMRSTRETCHBLT __fastcall ObjToRec(void);
	
__published:
	__property int xDest = {read=FxDest, write=FxDest, nodefault};
	__property int yDest = {read=FyDest, write=FyDest, nodefault};
	__property int cxDest = {read=FcxDest, write=FcxDest, nodefault};
	__property int cyDest = {read=FcyDest, write=FcyDest, nodefault};
	__property unsigned dwRop = {read=FdwRop, write=FdwRop, nodefault};
	__property int xSrc = {read=FxSrc, write=FxSrc, nodefault};
	__property int ySrc = {read=FySrc, write=FySrc, nodefault};
	__property unsigned crBkColorSrc = {read=FcrBkColorSrc, write=FcrBkColorSrc, nodefault};
	__property unsigned iUsageSrc = {read=FiUsageSrc, write=FiUsageSrc, nodefault};
	__property unsigned offBmiSrc = {read=FoffBmiSrc, write=FoffBmiSrc, nodefault};
	__property unsigned cbBmiSrc = {read=FcbBmiSrc, write=FcbBmiSrc, nodefault};
	__property unsigned offBitsSrc = {read=FoffBitsSrc, write=FoffBitsSrc, nodefault};
	__property unsigned cbBitsSrc = {read=FcbBitsSrc, write=FcbBitsSrc, nodefault};
	__property int cxSrc = {read=FcxSrc, write=FcxSrc, nodefault};
	__property int cySrc = {read=FcySrc, write=FcySrc, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagEMRSTRETCHBLTWrapper(void) { }
	
};


class DELPHICLASS tagEMRMASKBLTWrapper;
class PASCALIMPLEMENTATION tagEMRMASKBLTWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	int FxDest;
	int FyDest;
	int FcxDest;
	int FcyDest;
	unsigned FdwRop;
	int FxSrc;
	int FySrc;
	unsigned FcrBkColorSrc;
	unsigned FiUsageSrc;
	unsigned FoffBmiSrc;
	unsigned FcbBmiSrc;
	unsigned FoffBitsSrc;
	unsigned FcbBitsSrc;
	int FxMask;
	int FyMask;
	unsigned FiUsageMask;
	unsigned FoffBmiMask;
	unsigned FcbBmiMask;
	unsigned FoffBitsMask;
	unsigned FcbBitsMask;
	
public:
	__fastcall tagEMRMASKBLTWrapper(const tagEMRMASKBLT &ARecord);
	tagEMRMASKBLT __fastcall ObjToRec(void);
	
__published:
	__property int xDest = {read=FxDest, write=FxDest, nodefault};
	__property int yDest = {read=FyDest, write=FyDest, nodefault};
	__property int cxDest = {read=FcxDest, write=FcxDest, nodefault};
	__property int cyDest = {read=FcyDest, write=FcyDest, nodefault};
	__property unsigned dwRop = {read=FdwRop, write=FdwRop, nodefault};
	__property int xSrc = {read=FxSrc, write=FxSrc, nodefault};
	__property int ySrc = {read=FySrc, write=FySrc, nodefault};
	__property unsigned crBkColorSrc = {read=FcrBkColorSrc, write=FcrBkColorSrc, nodefault};
	__property unsigned iUsageSrc = {read=FiUsageSrc, write=FiUsageSrc, nodefault};
	__property unsigned offBmiSrc = {read=FoffBmiSrc, write=FoffBmiSrc, nodefault};
	__property unsigned cbBmiSrc = {read=FcbBmiSrc, write=FcbBmiSrc, nodefault};
	__property unsigned offBitsSrc = {read=FoffBitsSrc, write=FoffBitsSrc, nodefault};
	__property unsigned cbBitsSrc = {read=FcbBitsSrc, write=FcbBitsSrc, nodefault};
	__property int xMask = {read=FxMask, write=FxMask, nodefault};
	__property int yMask = {read=FyMask, write=FyMask, nodefault};
	__property unsigned iUsageMask = {read=FiUsageMask, write=FiUsageMask, nodefault};
	__property unsigned offBmiMask = {read=FoffBmiMask, write=FoffBmiMask, nodefault};
	__property unsigned cbBmiMask = {read=FcbBmiMask, write=FcbBmiMask, nodefault};
	__property unsigned offBitsMask = {read=FoffBitsMask, write=FoffBitsMask, nodefault};
	__property unsigned cbBitsMask = {read=FcbBitsMask, write=FcbBitsMask, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagEMRMASKBLTWrapper(void) { }
	
};


class DELPHICLASS tagEMRPLGBLTWrapper;
class PASCALIMPLEMENTATION tagEMRPLGBLTWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	int FxSrc;
	int FySrc;
	int FcxSrc;
	int FcySrc;
	unsigned FcrBkColorSrc;
	unsigned FiUsageSrc;
	unsigned FoffBmiSrc;
	unsigned FcbBmiSrc;
	unsigned FoffBitsSrc;
	unsigned FcbBitsSrc;
	int FxMask;
	int FyMask;
	unsigned FiUsageMask;
	unsigned FoffBmiMask;
	unsigned FcbBmiMask;
	unsigned FoffBitsMask;
	unsigned FcbBitsMask;
	
public:
	__fastcall tagEMRPLGBLTWrapper(const tagEMRPLGBLT &ARecord);
	tagEMRPLGBLT __fastcall ObjToRec(void);
	
__published:
	__property int xSrc = {read=FxSrc, write=FxSrc, nodefault};
	__property int ySrc = {read=FySrc, write=FySrc, nodefault};
	__property int cxSrc = {read=FcxSrc, write=FcxSrc, nodefault};
	__property int cySrc = {read=FcySrc, write=FcySrc, nodefault};
	__property unsigned crBkColorSrc = {read=FcrBkColorSrc, write=FcrBkColorSrc, nodefault};
	__property unsigned iUsageSrc = {read=FiUsageSrc, write=FiUsageSrc, nodefault};
	__property unsigned offBmiSrc = {read=FoffBmiSrc, write=FoffBmiSrc, nodefault};
	__property unsigned cbBmiSrc = {read=FcbBmiSrc, write=FcbBmiSrc, nodefault};
	__property unsigned offBitsSrc = {read=FoffBitsSrc, write=FoffBitsSrc, nodefault};
	__property unsigned cbBitsSrc = {read=FcbBitsSrc, write=FcbBitsSrc, nodefault};
	__property int xMask = {read=FxMask, write=FxMask, nodefault};
	__property int yMask = {read=FyMask, write=FyMask, nodefault};
	__property unsigned iUsageMask = {read=FiUsageMask, write=FiUsageMask, nodefault};
	__property unsigned offBmiMask = {read=FoffBmiMask, write=FoffBmiMask, nodefault};
	__property unsigned cbBmiMask = {read=FcbBmiMask, write=FcbBmiMask, nodefault};
	__property unsigned offBitsMask = {read=FoffBitsMask, write=FoffBitsMask, nodefault};
	__property unsigned cbBitsMask = {read=FcbBitsMask, write=FcbBitsMask, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagEMRPLGBLTWrapper(void) { }
	
};


class DELPHICLASS tagEMRSETDIBITSTODEVICEWrapper;
class PASCALIMPLEMENTATION tagEMRSETDIBITSTODEVICEWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	int FxDest;
	int FyDest;
	int FxSrc;
	int FySrc;
	int FcxSrc;
	int FcySrc;
	unsigned FoffBmiSrc;
	unsigned FcbBmiSrc;
	unsigned FoffBitsSrc;
	unsigned FcbBitsSrc;
	unsigned FiUsageSrc;
	unsigned FiStartScan;
	unsigned FcScans;
	
public:
	__fastcall tagEMRSETDIBITSTODEVICEWrapper(const tagEMRSETDIBITSTODEVICE &ARecord);
	tagEMRSETDIBITSTODEVICE __fastcall ObjToRec(void);
	
__published:
	__property int xDest = {read=FxDest, write=FxDest, nodefault};
	__property int yDest = {read=FyDest, write=FyDest, nodefault};
	__property int xSrc = {read=FxSrc, write=FxSrc, nodefault};
	__property int ySrc = {read=FySrc, write=FySrc, nodefault};
	__property int cxSrc = {read=FcxSrc, write=FcxSrc, nodefault};
	__property int cySrc = {read=FcySrc, write=FcySrc, nodefault};
	__property unsigned offBmiSrc = {read=FoffBmiSrc, write=FoffBmiSrc, nodefault};
	__property unsigned cbBmiSrc = {read=FcbBmiSrc, write=FcbBmiSrc, nodefault};
	__property unsigned offBitsSrc = {read=FoffBitsSrc, write=FoffBitsSrc, nodefault};
	__property unsigned cbBitsSrc = {read=FcbBitsSrc, write=FcbBitsSrc, nodefault};
	__property unsigned iUsageSrc = {read=FiUsageSrc, write=FiUsageSrc, nodefault};
	__property unsigned iStartScan = {read=FiStartScan, write=FiStartScan, nodefault};
	__property unsigned cScans = {read=FcScans, write=FcScans, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagEMRSETDIBITSTODEVICEWrapper(void) { }
	
};


class DELPHICLASS tagEMRSTRETCHDIBITSWrapper;
class PASCALIMPLEMENTATION tagEMRSTRETCHDIBITSWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	int FxDest;
	int FyDest;
	int FxSrc;
	int FySrc;
	int FcxSrc;
	int FcySrc;
	unsigned FoffBmiSrc;
	unsigned FcbBmiSrc;
	unsigned FoffBitsSrc;
	unsigned FcbBitsSrc;
	unsigned FiUsageSrc;
	unsigned FdwRop;
	int FcxDest;
	int FcyDest;
	
public:
	__fastcall tagEMRSTRETCHDIBITSWrapper(const tagEMRSTRETCHDIBITS &ARecord);
	tagEMRSTRETCHDIBITS __fastcall ObjToRec(void);
	
__published:
	__property int xDest = {read=FxDest, write=FxDest, nodefault};
	__property int yDest = {read=FyDest, write=FyDest, nodefault};
	__property int xSrc = {read=FxSrc, write=FxSrc, nodefault};
	__property int ySrc = {read=FySrc, write=FySrc, nodefault};
	__property int cxSrc = {read=FcxSrc, write=FcxSrc, nodefault};
	__property int cySrc = {read=FcySrc, write=FcySrc, nodefault};
	__property unsigned offBmiSrc = {read=FoffBmiSrc, write=FoffBmiSrc, nodefault};
	__property unsigned cbBmiSrc = {read=FcbBmiSrc, write=FcbBmiSrc, nodefault};
	__property unsigned offBitsSrc = {read=FoffBitsSrc, write=FoffBitsSrc, nodefault};
	__property unsigned cbBitsSrc = {read=FcbBitsSrc, write=FcbBitsSrc, nodefault};
	__property unsigned iUsageSrc = {read=FiUsageSrc, write=FiUsageSrc, nodefault};
	__property unsigned dwRop = {read=FdwRop, write=FdwRop, nodefault};
	__property int cxDest = {read=FcxDest, write=FcxDest, nodefault};
	__property int cyDest = {read=FcyDest, write=FcyDest, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagEMRSTRETCHDIBITSWrapper(void) { }
	
};


class DELPHICLASS tagEMRALPHABLENDWrapper;
class PASCALIMPLEMENTATION tagEMRALPHABLENDWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	int FxDest;
	int FyDest;
	int FcxDest;
	int FcyDest;
	unsigned FdwRop;
	int FxSrc;
	int FySrc;
	unsigned FcrBkColorSrc;
	unsigned FiUsageSrc;
	unsigned FoffBmiSrc;
	unsigned FcbBmiSrc;
	unsigned FoffBitsSrc;
	unsigned FcbBitsSrc;
	int FcxSrc;
	int FcySrc;
	
public:
	__fastcall tagEMRALPHABLENDWrapper(const tagEMRALPHABLEND &ARecord);
	tagEMRALPHABLEND __fastcall ObjToRec(void);
	
__published:
	__property int xDest = {read=FxDest, write=FxDest, nodefault};
	__property int yDest = {read=FyDest, write=FyDest, nodefault};
	__property int cxDest = {read=FcxDest, write=FcxDest, nodefault};
	__property int cyDest = {read=FcyDest, write=FcyDest, nodefault};
	__property unsigned dwRop = {read=FdwRop, write=FdwRop, nodefault};
	__property int xSrc = {read=FxSrc, write=FxSrc, nodefault};
	__property int ySrc = {read=FySrc, write=FySrc, nodefault};
	__property unsigned crBkColorSrc = {read=FcrBkColorSrc, write=FcrBkColorSrc, nodefault};
	__property unsigned iUsageSrc = {read=FiUsageSrc, write=FiUsageSrc, nodefault};
	__property unsigned offBmiSrc = {read=FoffBmiSrc, write=FoffBmiSrc, nodefault};
	__property unsigned cbBmiSrc = {read=FcbBmiSrc, write=FcbBmiSrc, nodefault};
	__property unsigned offBitsSrc = {read=FoffBitsSrc, write=FoffBitsSrc, nodefault};
	__property unsigned cbBitsSrc = {read=FcbBitsSrc, write=FcbBitsSrc, nodefault};
	__property int cxSrc = {read=FcxSrc, write=FcxSrc, nodefault};
	__property int cySrc = {read=FcySrc, write=FcySrc, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagEMRALPHABLENDWrapper(void) { }
	
};


class DELPHICLASS tagEMRTRANSPARENTBLTWrapper;
class PASCALIMPLEMENTATION tagEMRTRANSPARENTBLTWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	int FxDest;
	int FyDest;
	int FcxDest;
	int FcyDest;
	unsigned FdwRop;
	int FxSrc;
	int FySrc;
	unsigned FcrBkColorSrc;
	unsigned FiUsageSrc;
	unsigned FoffBmiSrc;
	unsigned FcbBmiSrc;
	unsigned FoffBitsSrc;
	unsigned FcbBitsSrc;
	int FcxSrc;
	int FcySrc;
	
public:
	__fastcall tagEMRTRANSPARENTBLTWrapper(const tagEMRTRANSPARENTBLT &ARecord);
	tagEMRTRANSPARENTBLT __fastcall ObjToRec(void);
	
__published:
	__property int xDest = {read=FxDest, write=FxDest, nodefault};
	__property int yDest = {read=FyDest, write=FyDest, nodefault};
	__property int cxDest = {read=FcxDest, write=FcxDest, nodefault};
	__property int cyDest = {read=FcyDest, write=FcyDest, nodefault};
	__property unsigned dwRop = {read=FdwRop, write=FdwRop, nodefault};
	__property int xSrc = {read=FxSrc, write=FxSrc, nodefault};
	__property int ySrc = {read=FySrc, write=FySrc, nodefault};
	__property unsigned crBkColorSrc = {read=FcrBkColorSrc, write=FcrBkColorSrc, nodefault};
	__property unsigned iUsageSrc = {read=FiUsageSrc, write=FiUsageSrc, nodefault};
	__property unsigned offBmiSrc = {read=FoffBmiSrc, write=FoffBmiSrc, nodefault};
	__property unsigned cbBmiSrc = {read=FcbBmiSrc, write=FcbBmiSrc, nodefault};
	__property unsigned offBitsSrc = {read=FoffBitsSrc, write=FoffBitsSrc, nodefault};
	__property unsigned cbBitsSrc = {read=FcbBitsSrc, write=FcbBitsSrc, nodefault};
	__property int cxSrc = {read=FcxSrc, write=FcxSrc, nodefault};
	__property int cySrc = {read=FcySrc, write=FcySrc, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagEMRTRANSPARENTBLTWrapper(void) { }
	
};


class DELPHICLASS tagEMREXTCREATEFONTINDIRECTWWrapper;
class PASCALIMPLEMENTATION tagEMREXTCREATEFONTINDIRECTWWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FihFont;
	
public:
	__fastcall tagEMREXTCREATEFONTINDIRECTWWrapper(const tagEMREXTCREATEFONTINDIRECTW &ARecord);
	tagEMREXTCREATEFONTINDIRECTW __fastcall ObjToRec(void);
	
__published:
	__property unsigned ihFont = {read=FihFont, write=FihFont, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagEMREXTCREATEFONTINDIRECTWWrapper(void) { }
	
};


class DELPHICLASS tagEMRCREATEPALETTEWrapper;
class PASCALIMPLEMENTATION tagEMRCREATEPALETTEWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FihPal;
	
public:
	__fastcall tagEMRCREATEPALETTEWrapper(const tagEMRCREATEPALETTE &ARecord);
	tagEMRCREATEPALETTE __fastcall ObjToRec(void);
	
__published:
	__property unsigned ihPal = {read=FihPal, write=FihPal, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagEMRCREATEPALETTEWrapper(void) { }
	
};


class DELPHICLASS tagEMRCREATECOLORSPACEWrapper;
class PASCALIMPLEMENTATION tagEMRCREATECOLORSPACEWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FihCS;
	
public:
	__fastcall tagEMRCREATECOLORSPACEWrapper(const tagEMRCREATECOLORSPACE &ARecord);
	tagEMRCREATECOLORSPACE __fastcall ObjToRec(void);
	
__published:
	__property unsigned ihCS = {read=FihCS, write=FihCS, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagEMRCREATECOLORSPACEWrapper(void) { }
	
};


class DELPHICLASS tagEMRCREATEPENWrapper;
class PASCALIMPLEMENTATION tagEMRCREATEPENWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FihPen;
	
public:
	__fastcall tagEMRCREATEPENWrapper(const tagEMRCREATEPEN &ARecord);
	tagEMRCREATEPEN __fastcall ObjToRec(void);
	
__published:
	__property unsigned ihPen = {read=FihPen, write=FihPen, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagEMRCREATEPENWrapper(void) { }
	
};


class DELPHICLASS tagEMREXTCREATEPENWrapper;
class PASCALIMPLEMENTATION tagEMREXTCREATEPENWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FihPen;
	unsigned FoffBmi;
	unsigned FcbBmi;
	unsigned FoffBits;
	unsigned FcbBits;
	
public:
	__fastcall tagEMREXTCREATEPENWrapper(const tagEMREXTCREATEPEN &ARecord);
	tagEMREXTCREATEPEN __fastcall ObjToRec(void);
	
__published:
	__property unsigned ihPen = {read=FihPen, write=FihPen, nodefault};
	__property unsigned offBmi = {read=FoffBmi, write=FoffBmi, nodefault};
	__property unsigned cbBmi = {read=FcbBmi, write=FcbBmi, nodefault};
	__property unsigned offBits = {read=FoffBits, write=FoffBits, nodefault};
	__property unsigned cbBits = {read=FcbBits, write=FcbBits, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagEMREXTCREATEPENWrapper(void) { }
	
};


class DELPHICLASS tagEMRCREATEBRUSHINDIRECTWrapper;
class PASCALIMPLEMENTATION tagEMRCREATEBRUSHINDIRECTWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FihBrush;
	
public:
	__fastcall tagEMRCREATEBRUSHINDIRECTWrapper(const tagEMRCREATEBRUSHINDIRECT &ARecord);
	tagEMRCREATEBRUSHINDIRECT __fastcall ObjToRec(void);
	
__published:
	__property unsigned ihBrush = {read=FihBrush, write=FihBrush, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagEMRCREATEBRUSHINDIRECTWrapper(void) { }
	
};


class DELPHICLASS tagEMRCREATEMONOBRUSHWrapper;
class PASCALIMPLEMENTATION tagEMRCREATEMONOBRUSHWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FihBrush;
	unsigned FiUsage;
	unsigned FoffBmi;
	unsigned FcbBmi;
	unsigned FoffBits;
	unsigned FcbBits;
	
public:
	__fastcall tagEMRCREATEMONOBRUSHWrapper(const tagEMRCREATEMONOBRUSH &ARecord);
	tagEMRCREATEMONOBRUSH __fastcall ObjToRec(void);
	
__published:
	__property unsigned ihBrush = {read=FihBrush, write=FihBrush, nodefault};
	__property unsigned iUsage = {read=FiUsage, write=FiUsage, nodefault};
	__property unsigned offBmi = {read=FoffBmi, write=FoffBmi, nodefault};
	__property unsigned cbBmi = {read=FcbBmi, write=FcbBmi, nodefault};
	__property unsigned offBits = {read=FoffBits, write=FoffBits, nodefault};
	__property unsigned cbBits = {read=FcbBits, write=FcbBits, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagEMRCREATEMONOBRUSHWrapper(void) { }
	
};


class DELPHICLASS tagEMRCREATEDIBPATTERNBRUSHPTWrapper;
class PASCALIMPLEMENTATION tagEMRCREATEDIBPATTERNBRUSHPTWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FihBrush;
	unsigned FiUsage;
	unsigned FoffBmi;
	unsigned FcbBmi;
	unsigned FoffBits;
	unsigned FcbBits;
	
public:
	__fastcall tagEMRCREATEDIBPATTERNBRUSHPTWrapper(const tagEMRCREATEDIBPATTERNBRUSHPT &ARecord);
	tagEMRCREATEDIBPATTERNBRUSHPT __fastcall ObjToRec(void);
	
__published:
	__property unsigned ihBrush = {read=FihBrush, write=FihBrush, nodefault};
	__property unsigned iUsage = {read=FiUsage, write=FiUsage, nodefault};
	__property unsigned offBmi = {read=FoffBmi, write=FoffBmi, nodefault};
	__property unsigned cbBmi = {read=FcbBmi, write=FcbBmi, nodefault};
	__property unsigned offBits = {read=FoffBits, write=FoffBits, nodefault};
	__property unsigned cbBits = {read=FcbBits, write=FcbBits, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagEMRCREATEDIBPATTERNBRUSHPTWrapper(void) { }
	
};


class DELPHICLASS tagEMRFORMATWrapper;
class PASCALIMPLEMENTATION tagEMRFORMATWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FdSignature;
	unsigned FnVersion;
	unsigned FcbData;
	unsigned FoffData;
	
public:
	__fastcall tagEMRFORMATWrapper(const tagEMRFORMAT &ARecord);
	tagEMRFORMAT __fastcall ObjToRec(void);
	
__published:
	__property unsigned dSignature = {read=FdSignature, write=FdSignature, nodefault};
	__property unsigned nVersion = {read=FnVersion, write=FnVersion, nodefault};
	__property unsigned cbData = {read=FcbData, write=FcbData, nodefault};
	__property unsigned offData = {read=FoffData, write=FoffData, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagEMRFORMATWrapper(void) { }
	
};


class DELPHICLASS tagEMRGLSRECORDWrapper;
class PASCALIMPLEMENTATION tagEMRGLSRECORDWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FcbData;
	
public:
	__fastcall tagEMRGLSRECORDWrapper(const tagEMRGLSRECORD &ARecord);
	tagEMRGLSRECORD __fastcall ObjToRec(void);
	
__published:
	__property unsigned cbData = {read=FcbData, write=FcbData, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagEMRGLSRECORDWrapper(void) { }
	
};


class DELPHICLASS tagEMRGLSBOUNDEDRECORDWrapper;
class PASCALIMPLEMENTATION tagEMRGLSBOUNDEDRECORDWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FcbData;
	
public:
	__fastcall tagEMRGLSBOUNDEDRECORDWrapper(const tagEMRGLSBOUNDEDRECORD &ARecord);
	tagEMRGLSBOUNDEDRECORD __fastcall ObjToRec(void);
	
__published:
	__property unsigned cbData = {read=FcbData, write=FcbData, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagEMRGLSBOUNDEDRECORDWrapper(void) { }
	
};


class DELPHICLASS tagEMRPIXELFORMATWrapper;
class PASCALIMPLEMENTATION tagEMRPIXELFORMATWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
public:
	__fastcall tagEMRPIXELFORMATWrapper(const tagEMRPIXELFORMAT &ARecord);
	tagEMRPIXELFORMAT __fastcall ObjToRec(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagEMRPIXELFORMATWrapper(void) { }
	
};


class DELPHICLASS _POINTFLOATWrapper;
class PASCALIMPLEMENTATION _POINTFLOATWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	float Fx;
	float Fy;
	
public:
	__fastcall _POINTFLOATWrapper(const _POINTFLOAT &ARecord);
	_POINTFLOAT __fastcall ObjToRec(void);
	
__published:
	__property float x = {read=Fx, write=Fx};
	__property float y = {read=Fy, write=Fy};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_POINTFLOATWrapper(void) { }
	
};


class DELPHICLASS _GLYPHMETRICSFLOATWrapper;
class PASCALIMPLEMENTATION _GLYPHMETRICSFLOATWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	float FgmfBlackBoxX;
	float FgmfBlackBoxY;
	float FgmfCellIncX;
	float FgmfCellIncY;
	
public:
	__fastcall _GLYPHMETRICSFLOATWrapper(const _GLYPHMETRICSFLOAT &ARecord);
	_GLYPHMETRICSFLOAT __fastcall ObjToRec(void);
	
__published:
	__property float gmfBlackBoxX = {read=FgmfBlackBoxX, write=FgmfBlackBoxX};
	__property float gmfBlackBoxY = {read=FgmfBlackBoxY, write=FgmfBlackBoxY};
	__property float gmfCellIncX = {read=FgmfCellIncX, write=FgmfCellIncX};
	__property float gmfCellIncY = {read=FgmfCellIncY, write=FgmfCellIncY};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_GLYPHMETRICSFLOATWrapper(void) { }
	
};


class DELPHICLASS tagLAYERPLANEDESCRIPTORWrapper;
class PASCALIMPLEMENTATION tagLAYERPLANEDESCRIPTORWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	System::Word FnSize;
	System::Word FnVersion;
	unsigned FdwFlags;
	System::Byte FiPixelType;
	System::Byte FcColorBits;
	System::Byte FcRedBits;
	System::Byte FcRedShift;
	System::Byte FcGreenBits;
	System::Byte FcGreenShift;
	System::Byte FcBlueBits;
	System::Byte FcBlueShift;
	System::Byte FcAlphaBits;
	System::Byte FcAlphaShift;
	System::Byte FcAccumBits;
	System::Byte FcAccumRedBits;
	System::Byte FcAccumGreenBits;
	System::Byte FcAccumBlueBits;
	System::Byte FcAccumAlphaBits;
	System::Byte FcDepthBits;
	System::Byte FcStencilBits;
	System::Byte FcAuxBuffers;
	System::Byte FiLayerPlane;
	System::Byte FbReserved;
	unsigned FcrTransparent;
	
public:
	__fastcall tagLAYERPLANEDESCRIPTORWrapper(const tagLAYERPLANEDESCRIPTOR &ARecord);
	tagLAYERPLANEDESCRIPTOR __fastcall ObjToRec(void);
	
__published:
	__property System::Word nSize = {read=FnSize, write=FnSize, nodefault};
	__property System::Word nVersion = {read=FnVersion, write=FnVersion, nodefault};
	__property unsigned dwFlags = {read=FdwFlags, write=FdwFlags, nodefault};
	__property System::Byte iPixelType = {read=FiPixelType, write=FiPixelType, nodefault};
	__property System::Byte cColorBits = {read=FcColorBits, write=FcColorBits, nodefault};
	__property System::Byte cRedBits = {read=FcRedBits, write=FcRedBits, nodefault};
	__property System::Byte cRedShift = {read=FcRedShift, write=FcRedShift, nodefault};
	__property System::Byte cGreenBits = {read=FcGreenBits, write=FcGreenBits, nodefault};
	__property System::Byte cGreenShift = {read=FcGreenShift, write=FcGreenShift, nodefault};
	__property System::Byte cBlueBits = {read=FcBlueBits, write=FcBlueBits, nodefault};
	__property System::Byte cBlueShift = {read=FcBlueShift, write=FcBlueShift, nodefault};
	__property System::Byte cAlphaBits = {read=FcAlphaBits, write=FcAlphaBits, nodefault};
	__property System::Byte cAlphaShift = {read=FcAlphaShift, write=FcAlphaShift, nodefault};
	__property System::Byte cAccumBits = {read=FcAccumBits, write=FcAccumBits, nodefault};
	__property System::Byte cAccumRedBits = {read=FcAccumRedBits, write=FcAccumRedBits, nodefault};
	__property System::Byte cAccumGreenBits = {read=FcAccumGreenBits, write=FcAccumGreenBits, nodefault};
	__property System::Byte cAccumBlueBits = {read=FcAccumBlueBits, write=FcAccumBlueBits, nodefault};
	__property System::Byte cAccumAlphaBits = {read=FcAccumAlphaBits, write=FcAccumAlphaBits, nodefault};
	__property System::Byte cDepthBits = {read=FcDepthBits, write=FcDepthBits, nodefault};
	__property System::Byte cStencilBits = {read=FcStencilBits, write=FcStencilBits, nodefault};
	__property System::Byte cAuxBuffers = {read=FcAuxBuffers, write=FcAuxBuffers, nodefault};
	__property System::Byte iLayerPlane = {read=FiLayerPlane, write=FiLayerPlane, nodefault};
	__property System::Byte bReserved = {read=FbReserved, write=FbReserved, nodefault};
	__property unsigned crTransparent = {read=FcrTransparent, write=FcrTransparent, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagLAYERPLANEDESCRIPTORWrapper(void) { }
	
};


class DELPHICLASS _WGLSWAPWrapper;
class PASCALIMPLEMENTATION _WGLSWAPWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	HDC Fhdc;
	unsigned FuiFlags;
	
public:
	__fastcall _WGLSWAPWrapper(const _WGLSWAP &ARecord);
	_WGLSWAP __fastcall ObjToRec(void);
	
__published:
	__property HDC hdc = {read=Fhdc, write=Fhdc, nodefault};
	__property unsigned uiFlags = {read=FuiFlags, write=FuiFlags, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_WGLSWAPWrapper(void) { }
	
};


class DELPHICLASS tagCREATESTRUCTAWrapper;
class PASCALIMPLEMENTATION tagCREATESTRUCTAWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FhInstance;
	HMENU FhMenu;
	HWND FhwndParent;
	int Fcy;
	int Fcx;
	int Fy;
	int Fx;
	int Fstyle;
	unsigned FdwExStyle;
	
public:
	__fastcall tagCREATESTRUCTAWrapper(const tagCREATESTRUCTA &ARecord);
	tagCREATESTRUCTA __fastcall ObjToRec(void);
	
__published:
	__property unsigned hInstance = {read=FhInstance, write=FhInstance, nodefault};
	__property HMENU hMenu = {read=FhMenu, write=FhMenu, nodefault};
	__property HWND hwndParent = {read=FhwndParent, write=FhwndParent, nodefault};
	__property int cy = {read=Fcy, write=Fcy, nodefault};
	__property int cx = {read=Fcx, write=Fcx, nodefault};
	__property int y = {read=Fy, write=Fy, nodefault};
	__property int x = {read=Fx, write=Fx, nodefault};
	__property int style = {read=Fstyle, write=Fstyle, nodefault};
	__property unsigned dwExStyle = {read=FdwExStyle, write=FdwExStyle, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagCREATESTRUCTAWrapper(void) { }
	
};


class DELPHICLASS tagCREATESTRUCTWWrapper;
class PASCALIMPLEMENTATION tagCREATESTRUCTWWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FhInstance;
	HMENU FhMenu;
	HWND FhwndParent;
	int Fcy;
	int Fcx;
	int Fy;
	int Fx;
	int Fstyle;
	unsigned FdwExStyle;
	
public:
	__fastcall tagCREATESTRUCTWWrapper(const tagCREATESTRUCTW &ARecord);
	tagCREATESTRUCTW __fastcall ObjToRec(void);
	
__published:
	__property unsigned hInstance = {read=FhInstance, write=FhInstance, nodefault};
	__property HMENU hMenu = {read=FhMenu, write=FhMenu, nodefault};
	__property HWND hwndParent = {read=FhwndParent, write=FhwndParent, nodefault};
	__property int cy = {read=Fcy, write=Fcy, nodefault};
	__property int cx = {read=Fcx, write=Fcx, nodefault};
	__property int y = {read=Fy, write=Fy, nodefault};
	__property int x = {read=Fx, write=Fx, nodefault};
	__property int style = {read=Fstyle, write=Fstyle, nodefault};
	__property unsigned dwExStyle = {read=FdwExStyle, write=FdwExStyle, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagCREATESTRUCTWWrapper(void) { }
	
};


class DELPHICLASS tagCBT_CREATEWNDAWrapper;
class PASCALIMPLEMENTATION tagCBT_CREATEWNDAWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	HWND FhwndInsertAfter;
	
public:
	__fastcall tagCBT_CREATEWNDAWrapper(const tagCBT_CREATEWNDA &ARecord);
	tagCBT_CREATEWNDA __fastcall ObjToRec(void);
	
__published:
	__property HWND hwndInsertAfter = {read=FhwndInsertAfter, write=FhwndInsertAfter, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagCBT_CREATEWNDAWrapper(void) { }
	
};


class DELPHICLASS tagCBTACTIVATESTRUCTWrapper;
class PASCALIMPLEMENTATION tagCBTACTIVATESTRUCTWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	BOOL FfMouse;
	HWND FhWndActive;
	
public:
	__fastcall tagCBTACTIVATESTRUCTWrapper(const tagCBTACTIVATESTRUCT &ARecord);
	tagCBTACTIVATESTRUCT __fastcall ObjToRec(void);
	
__published:
	__property BOOL fMouse = {read=FfMouse, write=FfMouse, nodefault};
	__property HWND hWndActive = {read=FhWndActive, write=FhWndActive, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagCBTACTIVATESTRUCTWrapper(void) { }
	
};


class DELPHICLASS tagEVENTMSGWrapper;
class PASCALIMPLEMENTATION tagEVENTMSGWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned Fmessage;
	unsigned FparamL;
	unsigned FparamH;
	unsigned Ftime;
	HWND Fhwnd;
	
public:
	__fastcall tagEVENTMSGWrapper(const tagEVENTMSG &ARecord);
	tagEVENTMSG __fastcall ObjToRec(void);
	
__published:
	__property unsigned message = {read=Fmessage, write=Fmessage, nodefault};
	__property unsigned paramL = {read=FparamL, write=FparamL, nodefault};
	__property unsigned paramH = {read=FparamH, write=FparamH, nodefault};
	__property unsigned time = {read=Ftime, write=Ftime, nodefault};
	__property HWND hwnd = {read=Fhwnd, write=Fhwnd, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagEVENTMSGWrapper(void) { }
	
};


class DELPHICLASS tagCWPSTRUCTWrapper;
class PASCALIMPLEMENTATION tagCWPSTRUCTWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	int FlParam;
	int FwParam;
	unsigned Fmessage;
	HWND Fhwnd;
	
public:
	__fastcall tagCWPSTRUCTWrapper(const tagCWPSTRUCT &ARecord);
	tagCWPSTRUCT __fastcall ObjToRec(void);
	
__published:
	__property int lParam = {read=FlParam, write=FlParam, nodefault};
	__property int wParam = {read=FwParam, write=FwParam, nodefault};
	__property unsigned message = {read=Fmessage, write=Fmessage, nodefault};
	__property HWND hwnd = {read=Fhwnd, write=Fhwnd, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagCWPSTRUCTWrapper(void) { }
	
};


class DELPHICLASS tagCWPRETSTRUCTWrapper;
class PASCALIMPLEMENTATION tagCWPRETSTRUCTWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	int FlResult;
	int FlParam;
	int FwParam;
	unsigned Fmessage;
	HWND Fhwnd;
	
public:
	__fastcall tagCWPRETSTRUCTWrapper(const tagCWPRETSTRUCT &ARecord);
	tagCWPRETSTRUCT __fastcall ObjToRec(void);
	
__published:
	__property int lResult = {read=FlResult, write=FlResult, nodefault};
	__property int lParam = {read=FlParam, write=FlParam, nodefault};
	__property int wParam = {read=FwParam, write=FwParam, nodefault};
	__property unsigned message = {read=Fmessage, write=Fmessage, nodefault};
	__property HWND hwnd = {read=Fhwnd, write=Fhwnd, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagCWPRETSTRUCTWrapper(void) { }
	
};


class DELPHICLASS tagDEBUGHOOKINFOWrapper;
class PASCALIMPLEMENTATION tagDEBUGHOOKINFOWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FidThread;
	unsigned FidThreadInstaller;
	int FlParam;
	int FwParam;
	int Fcode;
	
public:
	__fastcall tagDEBUGHOOKINFOWrapper(const tagDEBUGHOOKINFO &ARecord);
	tagDEBUGHOOKINFO __fastcall ObjToRec(void);
	
__published:
	__property unsigned idThread = {read=FidThread, write=FidThread, nodefault};
	__property unsigned idThreadInstaller = {read=FidThreadInstaller, write=FidThreadInstaller, nodefault};
	__property int lParam = {read=FlParam, write=FlParam, nodefault};
	__property int wParam = {read=FwParam, write=FwParam, nodefault};
	__property int code = {read=Fcode, write=Fcode, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagDEBUGHOOKINFOWrapper(void) { }
	
};


class DELPHICLASS tagMOUSEHOOKSTRUCTWrapper;
class PASCALIMPLEMENTATION tagMOUSEHOOKSTRUCTWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	HWND Fhwnd;
	unsigned FwHitTestCode;
	unsigned FdwExtraInfo;
	
public:
	__fastcall tagMOUSEHOOKSTRUCTWrapper(const tagMOUSEHOOKSTRUCT &ARecord);
	tagMOUSEHOOKSTRUCT __fastcall ObjToRec(void);
	
__published:
	__property HWND hwnd = {read=Fhwnd, write=Fhwnd, nodefault};
	__property unsigned wHitTestCode = {read=FwHitTestCode, write=FwHitTestCode, nodefault};
	__property unsigned dwExtraInfo = {read=FdwExtraInfo, write=FdwExtraInfo, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagMOUSEHOOKSTRUCTWrapper(void) { }
	
};


class DELPHICLASS tagMOUSEHOOKSTRUCTEXWrapper;
class PASCALIMPLEMENTATION tagMOUSEHOOKSTRUCTEXWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FmouseData;
	
public:
	__fastcall tagMOUSEHOOKSTRUCTEXWrapper(const tagMOUSEHOOKSTRUCTEX &ARecord);
	tagMOUSEHOOKSTRUCTEX __fastcall ObjToRec(void);
	
__published:
	__property unsigned mouseData = {read=FmouseData, write=FmouseData, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagMOUSEHOOKSTRUCTEXWrapper(void) { }
	
};


class DELPHICLASS tagHARDWAREHOOKSTRUCTWrapper;
class PASCALIMPLEMENTATION tagHARDWAREHOOKSTRUCTWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	HWND Fhwnd;
	unsigned Fmessage;
	int FwParam;
	int FlParam;
	
public:
	__fastcall tagHARDWAREHOOKSTRUCTWrapper(const tagHARDWAREHOOKSTRUCT &ARecord);
	tagHARDWAREHOOKSTRUCT __fastcall ObjToRec(void);
	
__published:
	__property HWND hwnd = {read=Fhwnd, write=Fhwnd, nodefault};
	__property unsigned message = {read=Fmessage, write=Fmessage, nodefault};
	__property int wParam = {read=FwParam, write=FwParam, nodefault};
	__property int lParam = {read=FlParam, write=FlParam, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagHARDWAREHOOKSTRUCTWrapper(void) { }
	
};


class DELPHICLASS tagMOUSEMOVEPOINTWrapper;
class PASCALIMPLEMENTATION tagMOUSEMOVEPOINTWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	int Fx;
	int Fy;
	unsigned Ftime;
	unsigned FdwExtraInfo;
	
public:
	__fastcall tagMOUSEMOVEPOINTWrapper(const tagMOUSEMOVEPOINT &ARecord);
	tagMOUSEMOVEPOINT __fastcall ObjToRec(void);
	
__published:
	__property int x = {read=Fx, write=Fx, nodefault};
	__property int y = {read=Fy, write=Fy, nodefault};
	__property unsigned time = {read=Ftime, write=Ftime, nodefault};
	__property unsigned dwExtraInfo = {read=FdwExtraInfo, write=FdwExtraInfo, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagMOUSEMOVEPOINTWrapper(void) { }
	
};


class DELPHICLASS tagUSEROBJECTFLAGSWrapper;
class PASCALIMPLEMENTATION tagUSEROBJECTFLAGSWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	BOOL FfInherit;
	BOOL FfReserved;
	unsigned FdwFlags;
	
public:
	__fastcall tagUSEROBJECTFLAGSWrapper(const tagUSEROBJECTFLAGS &ARecord);
	tagUSEROBJECTFLAGS __fastcall ObjToRec(void);
	
__published:
	__property BOOL fInherit = {read=FfInherit, write=FfInherit, nodefault};
	__property BOOL fReserved = {read=FfReserved, write=FfReserved, nodefault};
	__property unsigned dwFlags = {read=FdwFlags, write=FdwFlags, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagUSEROBJECTFLAGSWrapper(void) { }
	
};


class DELPHICLASS tagWNDCLASSEXAWrapper;
class PASCALIMPLEMENTATION tagWNDCLASSEXAWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FcbSize;
	unsigned Fstyle;
	int FcbClsExtra;
	int FcbWndExtra;
	unsigned FhInstance;
	HICON FhIcon;
	HICON FhCursor;
	HBRUSH FhbrBackground;
	HICON FhIconSm;
	
public:
	__fastcall tagWNDCLASSEXAWrapper(const tagWNDCLASSEXA &ARecord);
	tagWNDCLASSEXA __fastcall ObjToRec(void);
	
__published:
	__property unsigned cbSize = {read=FcbSize, write=FcbSize, nodefault};
	__property unsigned style = {read=Fstyle, write=Fstyle, nodefault};
	__property int cbClsExtra = {read=FcbClsExtra, write=FcbClsExtra, nodefault};
	__property int cbWndExtra = {read=FcbWndExtra, write=FcbWndExtra, nodefault};
	__property unsigned hInstance = {read=FhInstance, write=FhInstance, nodefault};
	__property HICON hIcon = {read=FhIcon, write=FhIcon, nodefault};
	__property HICON hCursor = {read=FhCursor, write=FhCursor, nodefault};
	__property HBRUSH hbrBackground = {read=FhbrBackground, write=FhbrBackground, nodefault};
	__property HICON hIconSm = {read=FhIconSm, write=FhIconSm, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagWNDCLASSEXAWrapper(void) { }
	
};


class DELPHICLASS tagWNDCLASSEXWWrapper;
class PASCALIMPLEMENTATION tagWNDCLASSEXWWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FcbSize;
	unsigned Fstyle;
	int FcbClsExtra;
	int FcbWndExtra;
	unsigned FhInstance;
	HICON FhIcon;
	HICON FhCursor;
	HBRUSH FhbrBackground;
	HICON FhIconSm;
	
public:
	__fastcall tagWNDCLASSEXWWrapper(const tagWNDCLASSEXW &ARecord);
	tagWNDCLASSEXW __fastcall ObjToRec(void);
	
__published:
	__property unsigned cbSize = {read=FcbSize, write=FcbSize, nodefault};
	__property unsigned style = {read=Fstyle, write=Fstyle, nodefault};
	__property int cbClsExtra = {read=FcbClsExtra, write=FcbClsExtra, nodefault};
	__property int cbWndExtra = {read=FcbWndExtra, write=FcbWndExtra, nodefault};
	__property unsigned hInstance = {read=FhInstance, write=FhInstance, nodefault};
	__property HICON hIcon = {read=FhIcon, write=FhIcon, nodefault};
	__property HICON hCursor = {read=FhCursor, write=FhCursor, nodefault};
	__property HBRUSH hbrBackground = {read=FhbrBackground, write=FhbrBackground, nodefault};
	__property HICON hIconSm = {read=FhIconSm, write=FhIconSm, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagWNDCLASSEXWWrapper(void) { }
	
};


class DELPHICLASS tagWNDCLASSAWrapper;
class PASCALIMPLEMENTATION tagWNDCLASSAWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned Fstyle;
	int FcbClsExtra;
	int FcbWndExtra;
	unsigned FhInstance;
	HICON FhIcon;
	HICON FhCursor;
	HBRUSH FhbrBackground;
	
public:
	__fastcall tagWNDCLASSAWrapper(const tagWNDCLASSA &ARecord);
	tagWNDCLASSA __fastcall ObjToRec(void);
	
__published:
	__property unsigned style = {read=Fstyle, write=Fstyle, nodefault};
	__property int cbClsExtra = {read=FcbClsExtra, write=FcbClsExtra, nodefault};
	__property int cbWndExtra = {read=FcbWndExtra, write=FcbWndExtra, nodefault};
	__property unsigned hInstance = {read=FhInstance, write=FhInstance, nodefault};
	__property HICON hIcon = {read=FhIcon, write=FhIcon, nodefault};
	__property HICON hCursor = {read=FhCursor, write=FhCursor, nodefault};
	__property HBRUSH hbrBackground = {read=FhbrBackground, write=FhbrBackground, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagWNDCLASSAWrapper(void) { }
	
};


class DELPHICLASS tagWNDCLASSWWrapper;
class PASCALIMPLEMENTATION tagWNDCLASSWWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned Fstyle;
	int FcbClsExtra;
	int FcbWndExtra;
	unsigned FhInstance;
	HICON FhIcon;
	HICON FhCursor;
	HBRUSH FhbrBackground;
	
public:
	__fastcall tagWNDCLASSWWrapper(const tagWNDCLASSW &ARecord);
	tagWNDCLASSW __fastcall ObjToRec(void);
	
__published:
	__property unsigned style = {read=Fstyle, write=Fstyle, nodefault};
	__property int cbClsExtra = {read=FcbClsExtra, write=FcbClsExtra, nodefault};
	__property int cbWndExtra = {read=FcbWndExtra, write=FcbWndExtra, nodefault};
	__property unsigned hInstance = {read=FhInstance, write=FhInstance, nodefault};
	__property HICON hIcon = {read=FhIcon, write=FhIcon, nodefault};
	__property HICON hCursor = {read=FhCursor, write=FhCursor, nodefault};
	__property HBRUSH hbrBackground = {read=FhbrBackground, write=FhbrBackground, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagWNDCLASSWWrapper(void) { }
	
};


class DELPHICLASS tagMSGWrapper;
class PASCALIMPLEMENTATION tagMSGWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	HWND Fhwnd;
	unsigned Fmessage;
	int FwParam;
	int FlParam;
	unsigned Ftime;
	
public:
	__fastcall tagMSGWrapper(const tagMSG &ARecord);
	tagMSG __fastcall ObjToRec(void);
	
__published:
	__property HWND hwnd = {read=Fhwnd, write=Fhwnd, nodefault};
	__property unsigned message = {read=Fmessage, write=Fmessage, nodefault};
	__property int wParam = {read=FwParam, write=FwParam, nodefault};
	__property int lParam = {read=FlParam, write=FlParam, nodefault};
	__property unsigned time = {read=Ftime, write=Ftime, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagMSGWrapper(void) { }
	
};


class DELPHICLASS tagMINMAXINFOWrapper;
class PASCALIMPLEMENTATION tagMINMAXINFOWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
public:
	__fastcall tagMINMAXINFOWrapper(const tagMINMAXINFO &ARecord);
	tagMINMAXINFO __fastcall ObjToRec(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagMINMAXINFOWrapper(void) { }
	
};


class DELPHICLASS tagCOPYDATASTRUCTWrapper;
class PASCALIMPLEMENTATION tagCOPYDATASTRUCTWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FdwData;
	unsigned FcbData;
	
public:
	__fastcall tagCOPYDATASTRUCTWrapper(const tagCOPYDATASTRUCT &ARecord);
	tagCOPYDATASTRUCT __fastcall ObjToRec(void);
	
__published:
	__property unsigned dwData = {read=FdwData, write=FdwData, nodefault};
	__property unsigned cbData = {read=FcbData, write=FcbData, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagCOPYDATASTRUCTWrapper(void) { }
	
};


class DELPHICLASS tagMDINEXTMENUWrapper;
class PASCALIMPLEMENTATION tagMDINEXTMENUWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	HMENU FhmenuIn;
	HMENU FhmenuNext;
	HWND FhwndNext;
	
public:
	__fastcall tagMDINEXTMENUWrapper(const tagMDINEXTMENU &ARecord);
	tagMDINEXTMENU __fastcall ObjToRec(void);
	
__published:
	__property HMENU hmenuIn = {read=FhmenuIn, write=FhmenuIn, nodefault};
	__property HMENU hmenuNext = {read=FhmenuNext, write=FhmenuNext, nodefault};
	__property HWND hwndNext = {read=FhwndNext, write=FhwndNext, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagMDINEXTMENUWrapper(void) { }
	
};


class DELPHICLASS POWERBROADCAST_SETTINGWrapper;
class PASCALIMPLEMENTATION POWERBROADCAST_SETTINGWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	#pragma pack(push,1)
	GUID FPowerSetting;
	#pragma pack(pop)
	unsigned FDataLength;
	
public:
	__fastcall POWERBROADCAST_SETTINGWrapper(const POWERBROADCAST_SETTING &ARecord);
	POWERBROADCAST_SETTING __fastcall ObjToRec(void);
	
__published:
	__property GUID PowerSetting = {read=FPowerSetting, write=FPowerSetting};
	__property unsigned DataLength = {read=FDataLength, write=FDataLength, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~POWERBROADCAST_SETTINGWrapper(void) { }
	
};


class DELPHICLASS tagWINDOWPOSWrapper;
class PASCALIMPLEMENTATION tagWINDOWPOSWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	HWND Fhwnd;
	HWND FhwndInsertAfter;
	int Fx;
	int Fy;
	int Fcx;
	int Fcy;
	unsigned Fflags;
	
public:
	__fastcall tagWINDOWPOSWrapper(const tagWINDOWPOS &ARecord);
	tagWINDOWPOS __fastcall ObjToRec(void);
	
__published:
	__property HWND hwnd = {read=Fhwnd, write=Fhwnd, nodefault};
	__property HWND hwndInsertAfter = {read=FhwndInsertAfter, write=FhwndInsertAfter, nodefault};
	__property int x = {read=Fx, write=Fx, nodefault};
	__property int y = {read=Fy, write=Fy, nodefault};
	__property int cx = {read=Fcx, write=Fcx, nodefault};
	__property int cy = {read=Fcy, write=Fcy, nodefault};
	__property unsigned flags = {read=Fflags, write=Fflags, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagWINDOWPOSWrapper(void) { }
	
};


class DELPHICLASS tagNCCALCSIZE_PARAMSWrapper;
class PASCALIMPLEMENTATION tagNCCALCSIZE_PARAMSWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
public:
	__fastcall tagNCCALCSIZE_PARAMSWrapper(const tagNCCALCSIZE_PARAMS &ARecord);
	tagNCCALCSIZE_PARAMS __fastcall ObjToRec(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagNCCALCSIZE_PARAMSWrapper(void) { }
	
};


class DELPHICLASS tagTRACKMOUSEEVENTWrapper;
class PASCALIMPLEMENTATION tagTRACKMOUSEEVENTWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FcbSize;
	unsigned FdwFlags;
	HWND FhwndTrack;
	unsigned FdwHoverTime;
	
public:
	__fastcall tagTRACKMOUSEEVENTWrapper(const tagTRACKMOUSEEVENT &ARecord);
	tagTRACKMOUSEEVENT __fastcall ObjToRec(void);
	
__published:
	__property unsigned cbSize = {read=FcbSize, write=FcbSize, nodefault};
	__property unsigned dwFlags = {read=FdwFlags, write=FdwFlags, nodefault};
	__property HWND hwndTrack = {read=FhwndTrack, write=FhwndTrack, nodefault};
	__property unsigned dwHoverTime = {read=FdwHoverTime, write=FdwHoverTime, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagTRACKMOUSEEVENTWrapper(void) { }
	
};


class DELPHICLASS tagACCELWrapper;
class PASCALIMPLEMENTATION tagACCELWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	System::Word FfVirt;
	System::Word Fkey;
	System::Word Fcmd;
	
public:
	__fastcall tagACCELWrapper(const tagACCEL &ARecord);
	tagACCEL __fastcall ObjToRec(void);
	
__published:
	__property System::Word fVirt = {read=FfVirt, write=FfVirt, nodefault};
	__property System::Word key = {read=Fkey, write=Fkey, nodefault};
	__property System::Word cmd = {read=Fcmd, write=Fcmd, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagACCELWrapper(void) { }
	
};


class DELPHICLASS tagPAINTSTRUCTWrapper;
class PASCALIMPLEMENTATION tagPAINTSTRUCTWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	HDC Fhdc;
	BOOL FfErase;
	BOOL FfRestore;
	BOOL FfIncUpdate;
	
public:
	__fastcall tagPAINTSTRUCTWrapper(const tagPAINTSTRUCT &ARecord);
	tagPAINTSTRUCT __fastcall ObjToRec(void);
	
__published:
	__property HDC hdc = {read=Fhdc, write=Fhdc, nodefault};
	__property BOOL fErase = {read=FfErase, write=FfErase, nodefault};
	__property BOOL fRestore = {read=FfRestore, write=FfRestore, nodefault};
	__property BOOL fIncUpdate = {read=FfIncUpdate, write=FfIncUpdate, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagPAINTSTRUCTWrapper(void) { }
	
};


class DELPHICLASS tagWINDOWPLACEMENTWrapper;
class PASCALIMPLEMENTATION tagWINDOWPLACEMENTWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned Flength;
	unsigned Fflags;
	unsigned FshowCmd;
	
public:
	__fastcall tagWINDOWPLACEMENTWrapper(const tagWINDOWPLACEMENT &ARecord);
	tagWINDOWPLACEMENT __fastcall ObjToRec(void);
	
__published:
	__property unsigned length = {read=Flength, write=Flength, nodefault};
	__property unsigned flags = {read=Fflags, write=Fflags, nodefault};
	__property unsigned showCmd = {read=FshowCmd, write=FshowCmd, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagWINDOWPLACEMENTWrapper(void) { }
	
};


class DELPHICLASS tagNMHDRWrapper;
class PASCALIMPLEMENTATION tagNMHDRWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	HWND FhwndFrom;
	unsigned FidFrom;
	int Fcode;
	
public:
	__fastcall tagNMHDRWrapper(const tagNMHDR &ARecord);
	tagNMHDR __fastcall ObjToRec(void);
	
__published:
	__property HWND hwndFrom = {read=FhwndFrom, write=FhwndFrom, nodefault};
	__property unsigned idFrom = {read=FidFrom, write=FidFrom, nodefault};
	__property int code = {read=Fcode, write=Fcode, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagNMHDRWrapper(void) { }
	
};


class DELPHICLASS tagSTYLESTRUCTWrapper;
class PASCALIMPLEMENTATION tagSTYLESTRUCTWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FstyleOld;
	unsigned FstyleNew;
	
public:
	__fastcall tagSTYLESTRUCTWrapper(const tagSTYLESTRUCT &ARecord);
	tagSTYLESTRUCT __fastcall ObjToRec(void);
	
__published:
	__property unsigned styleOld = {read=FstyleOld, write=FstyleOld, nodefault};
	__property unsigned styleNew = {read=FstyleNew, write=FstyleNew, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagSTYLESTRUCTWrapper(void) { }
	
};


class DELPHICLASS tagMEASUREITEMSTRUCTWrapper;
class PASCALIMPLEMENTATION tagMEASUREITEMSTRUCTWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FCtlType;
	unsigned FCtlID;
	unsigned FitemID;
	unsigned FitemWidth;
	unsigned FitemHeight;
	unsigned FitemData;
	
public:
	__fastcall tagMEASUREITEMSTRUCTWrapper(const tagMEASUREITEMSTRUCT &ARecord);
	tagMEASUREITEMSTRUCT __fastcall ObjToRec(void);
	
__published:
	__property unsigned CtlType = {read=FCtlType, write=FCtlType, nodefault};
	__property unsigned CtlID = {read=FCtlID, write=FCtlID, nodefault};
	__property unsigned itemID = {read=FitemID, write=FitemID, nodefault};
	__property unsigned itemWidth = {read=FitemWidth, write=FitemWidth, nodefault};
	__property unsigned itemHeight = {read=FitemHeight, write=FitemHeight, nodefault};
	__property unsigned itemData = {read=FitemData, write=FitemData, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagMEASUREITEMSTRUCTWrapper(void) { }
	
};


class DELPHICLASS tagDRAWITEMSTRUCTWrapper;
class PASCALIMPLEMENTATION tagDRAWITEMSTRUCTWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FCtlType;
	unsigned FCtlID;
	unsigned FitemID;
	unsigned FitemAction;
	unsigned FitemState;
	HWND FhwndItem;
	HDC FhDC;
	unsigned FitemData;
	
public:
	__fastcall tagDRAWITEMSTRUCTWrapper(const tagDRAWITEMSTRUCT &ARecord);
	tagDRAWITEMSTRUCT __fastcall ObjToRec(void);
	
__published:
	__property unsigned CtlType = {read=FCtlType, write=FCtlType, nodefault};
	__property unsigned CtlID = {read=FCtlID, write=FCtlID, nodefault};
	__property unsigned itemID = {read=FitemID, write=FitemID, nodefault};
	__property unsigned itemAction = {read=FitemAction, write=FitemAction, nodefault};
	__property unsigned itemState = {read=FitemState, write=FitemState, nodefault};
	__property HWND hwndItem = {read=FhwndItem, write=FhwndItem, nodefault};
	__property HDC hDC = {read=FhDC, write=FhDC, nodefault};
	__property unsigned itemData = {read=FitemData, write=FitemData, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagDRAWITEMSTRUCTWrapper(void) { }
	
};


class DELPHICLASS tagDELETEITEMSTRUCTWrapper;
class PASCALIMPLEMENTATION tagDELETEITEMSTRUCTWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FCtlType;
	unsigned FCtlID;
	unsigned FitemID;
	HWND FhwndItem;
	unsigned FitemData;
	
public:
	__fastcall tagDELETEITEMSTRUCTWrapper(const tagDELETEITEMSTRUCT &ARecord);
	tagDELETEITEMSTRUCT __fastcall ObjToRec(void);
	
__published:
	__property unsigned CtlType = {read=FCtlType, write=FCtlType, nodefault};
	__property unsigned CtlID = {read=FCtlID, write=FCtlID, nodefault};
	__property unsigned itemID = {read=FitemID, write=FitemID, nodefault};
	__property HWND hwndItem = {read=FhwndItem, write=FhwndItem, nodefault};
	__property unsigned itemData = {read=FitemData, write=FitemData, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagDELETEITEMSTRUCTWrapper(void) { }
	
};


class DELPHICLASS tagCOMPAREITEMSTRUCTWrapper;
class PASCALIMPLEMENTATION tagCOMPAREITEMSTRUCTWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FCtlType;
	unsigned FCtlID;
	HWND FhwndItem;
	unsigned FitemID1;
	unsigned FitemData1;
	unsigned FitemID2;
	unsigned FitemData2;
	unsigned FdwLocaleId;
	
public:
	__fastcall tagCOMPAREITEMSTRUCTWrapper(const tagCOMPAREITEMSTRUCT &ARecord);
	tagCOMPAREITEMSTRUCT __fastcall ObjToRec(void);
	
__published:
	__property unsigned CtlType = {read=FCtlType, write=FCtlType, nodefault};
	__property unsigned CtlID = {read=FCtlID, write=FCtlID, nodefault};
	__property HWND hwndItem = {read=FhwndItem, write=FhwndItem, nodefault};
	__property unsigned itemID1 = {read=FitemID1, write=FitemID1, nodefault};
	__property unsigned itemData1 = {read=FitemData1, write=FitemData1, nodefault};
	__property unsigned itemID2 = {read=FitemID2, write=FitemID2, nodefault};
	__property unsigned itemData2 = {read=FitemData2, write=FitemData2, nodefault};
	__property unsigned dwLocaleId = {read=FdwLocaleId, write=FdwLocaleId, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagCOMPAREITEMSTRUCTWrapper(void) { }
	
};


class DELPHICLASS tagBROADCASTSYSMSGWrapper;
class PASCALIMPLEMENTATION tagBROADCASTSYSMSGWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FuiMessage;
	int FwParam;
	int FlParam;
	
public:
	__fastcall tagBROADCASTSYSMSGWrapper(const Windows::tagBROADCASTSYSMSG &ARecord);
	Windows::tagBROADCASTSYSMSG __fastcall ObjToRec(void);
	
__published:
	__property unsigned uiMessage = {read=FuiMessage, write=FuiMessage, nodefault};
	__property int wParam = {read=FwParam, write=FwParam, nodefault};
	__property int lParam = {read=FlParam, write=FlParam, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagBROADCASTSYSMSGWrapper(void) { }
	
};


class DELPHICLASS FLASHWINFOWrapper;
class PASCALIMPLEMENTATION FLASHWINFOWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FcbSize;
	HWND Fhwnd;
	unsigned FdwFlags;
	unsigned FuCount;
	unsigned FdwTimeout;
	
public:
	__fastcall FLASHWINFOWrapper(const FLASHWINFO &ARecord);
	FLASHWINFO __fastcall ObjToRec(void);
	
__published:
	__property unsigned cbSize = {read=FcbSize, write=FcbSize, nodefault};
	__property HWND hwnd = {read=Fhwnd, write=Fhwnd, nodefault};
	__property unsigned dwFlags = {read=FdwFlags, write=FdwFlags, nodefault};
	__property unsigned uCount = {read=FuCount, write=FuCount, nodefault};
	__property unsigned dwTimeout = {read=FdwTimeout, write=FdwTimeout, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~FLASHWINFOWrapper(void) { }
	
};


class DELPHICLASS DLGTEMPLATEWrapper;
class PASCALIMPLEMENTATION DLGTEMPLATEWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned Fstyle;
	unsigned FdwExtendedStyle;
	System::Word Fcdit;
	short Fx;
	short Fy;
	short Fcx;
	short Fcy;
	
public:
	__fastcall DLGTEMPLATEWrapper(const DLGTEMPLATE &ARecord);
	DLGTEMPLATE __fastcall ObjToRec(void);
	
__published:
	__property unsigned style = {read=Fstyle, write=Fstyle, nodefault};
	__property unsigned dwExtendedStyle = {read=FdwExtendedStyle, write=FdwExtendedStyle, nodefault};
	__property System::Word cdit = {read=Fcdit, write=Fcdit, nodefault};
	__property short x = {read=Fx, write=Fx, nodefault};
	__property short y = {read=Fy, write=Fy, nodefault};
	__property short cx = {read=Fcx, write=Fcx, nodefault};
	__property short cy = {read=Fcy, write=Fcy, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~DLGTEMPLATEWrapper(void) { }
	
};


class DELPHICLASS DLGITEMTEMPLATEWrapper;
class PASCALIMPLEMENTATION DLGITEMTEMPLATEWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned Fstyle;
	unsigned FdwExtendedStyle;
	short Fx;
	short Fy;
	short Fcx;
	short Fcy;
	System::Word Fid;
	
public:
	__fastcall DLGITEMTEMPLATEWrapper(const DLGITEMTEMPLATE &ARecord);
	DLGITEMTEMPLATE __fastcall ObjToRec(void);
	
__published:
	__property unsigned style = {read=Fstyle, write=Fstyle, nodefault};
	__property unsigned dwExtendedStyle = {read=FdwExtendedStyle, write=FdwExtendedStyle, nodefault};
	__property short x = {read=Fx, write=Fx, nodefault};
	__property short y = {read=Fy, write=Fy, nodefault};
	__property short cx = {read=Fcx, write=Fcx, nodefault};
	__property short cy = {read=Fcy, write=Fcy, nodefault};
	__property System::Word id = {read=Fid, write=Fid, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~DLGITEMTEMPLATEWrapper(void) { }
	
};


class DELPHICLASS tagMOUSEINPUTWrapper;
class PASCALIMPLEMENTATION tagMOUSEINPUTWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	int Fdx;
	int Fdy;
	unsigned FmouseData;
	unsigned FdwFlags;
	unsigned Ftime;
	unsigned FdwExtraInfo;
	
public:
	__fastcall tagMOUSEINPUTWrapper(const tagMOUSEINPUT &ARecord);
	tagMOUSEINPUT __fastcall ObjToRec(void);
	
__published:
	__property int dx = {read=Fdx, write=Fdx, nodefault};
	__property int dy = {read=Fdy, write=Fdy, nodefault};
	__property unsigned mouseData = {read=FmouseData, write=FmouseData, nodefault};
	__property unsigned dwFlags = {read=FdwFlags, write=FdwFlags, nodefault};
	__property unsigned time = {read=Ftime, write=Ftime, nodefault};
	__property unsigned dwExtraInfo = {read=FdwExtraInfo, write=FdwExtraInfo, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagMOUSEINPUTWrapper(void) { }
	
};


class DELPHICLASS tagKEYBDINPUTWrapper;
class PASCALIMPLEMENTATION tagKEYBDINPUTWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	System::Word FwVk;
	System::Word FwScan;
	unsigned FdwFlags;
	unsigned Ftime;
	unsigned FdwExtraInfo;
	
public:
	__fastcall tagKEYBDINPUTWrapper(const tagKEYBDINPUT &ARecord);
	tagKEYBDINPUT __fastcall ObjToRec(void);
	
__published:
	__property System::Word wVk = {read=FwVk, write=FwVk, nodefault};
	__property System::Word wScan = {read=FwScan, write=FwScan, nodefault};
	__property unsigned dwFlags = {read=FdwFlags, write=FdwFlags, nodefault};
	__property unsigned time = {read=Ftime, write=Ftime, nodefault};
	__property unsigned dwExtraInfo = {read=FdwExtraInfo, write=FdwExtraInfo, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagKEYBDINPUTWrapper(void) { }
	
};


class DELPHICLASS tagHARDWAREINPUTWrapper;
class PASCALIMPLEMENTATION tagHARDWAREINPUTWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FuMsg;
	System::Word FwParamL;
	System::Word FwParamH;
	
public:
	__fastcall tagHARDWAREINPUTWrapper(const tagHARDWAREINPUT &ARecord);
	tagHARDWAREINPUT __fastcall ObjToRec(void);
	
__published:
	__property unsigned uMsg = {read=FuMsg, write=FuMsg, nodefault};
	__property System::Word wParamL = {read=FwParamL, write=FwParamL, nodefault};
	__property System::Word wParamH = {read=FwParamH, write=FwParamH, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagHARDWAREINPUTWrapper(void) { }
	
};


class DELPHICLASS tagINPUTWrapper;
class PASCALIMPLEMENTATION tagINPUTWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FItype;
	
public:
	__fastcall tagINPUTWrapper(const tagINPUT &ARecord);
	tagINPUT __fastcall ObjToRec(void);
	
__published:
	__property unsigned Itype = {read=FItype, write=FItype, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagINPUTWrapper(void) { }
	
};


class DELPHICLASS TOUCHINPUTWrapper;
class PASCALIMPLEMENTATION TOUCHINPUTWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	int Fx;
	int Fy;
	unsigned FhSource;
	unsigned FdwID;
	unsigned FdwFlags;
	unsigned FdwMask;
	unsigned FdwTime;
	unsigned FdwExtraInfo;
	unsigned FcxContact;
	unsigned FcyContact;
	
public:
	__fastcall TOUCHINPUTWrapper(const TOUCHINPUT &ARecord);
	TOUCHINPUT __fastcall ObjToRec(void);
	
__published:
	__property int x = {read=Fx, write=Fx, nodefault};
	__property int y = {read=Fy, write=Fy, nodefault};
	__property unsigned hSource = {read=FhSource, write=FhSource, nodefault};
	__property unsigned dwID = {read=FdwID, write=FdwID, nodefault};
	__property unsigned dwFlags = {read=FdwFlags, write=FdwFlags, nodefault};
	__property unsigned dwMask = {read=FdwMask, write=FdwMask, nodefault};
	__property unsigned dwTime = {read=FdwTime, write=FdwTime, nodefault};
	__property unsigned dwExtraInfo = {read=FdwExtraInfo, write=FdwExtraInfo, nodefault};
	__property unsigned cxContact = {read=FcxContact, write=FcxContact, nodefault};
	__property unsigned cyContact = {read=FcyContact, write=FcyContact, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TOUCHINPUTWrapper(void) { }
	
};


class DELPHICLASS tagLASTINPUTINFOWrapper;
class PASCALIMPLEMENTATION tagLASTINPUTINFOWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FcbSize;
	unsigned FdwTime;
	
public:
	__fastcall tagLASTINPUTINFOWrapper(const tagLASTINPUTINFO &ARecord);
	tagLASTINPUTINFO __fastcall ObjToRec(void);
	
__published:
	__property unsigned cbSize = {read=FcbSize, write=FcbSize, nodefault};
	__property unsigned dwTime = {read=FdwTime, write=FdwTime, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagLASTINPUTINFOWrapper(void) { }
	
};


class DELPHICLASS tagTPMPARAMSWrapper;
class PASCALIMPLEMENTATION tagTPMPARAMSWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FcbSize;
	
public:
	__fastcall tagTPMPARAMSWrapper(const tagTPMPARAMS &ARecord);
	tagTPMPARAMS __fastcall ObjToRec(void);
	
__published:
	__property unsigned cbSize = {read=FcbSize, write=FcbSize, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagTPMPARAMSWrapper(void) { }
	
};


class DELPHICLASS tagMENUINFOWrapper;
class PASCALIMPLEMENTATION tagMENUINFOWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FcbSize;
	unsigned FfMask;
	unsigned FdwStyle;
	unsigned FcyMax;
	HBRUSH FhbrBack;
	unsigned FdwContextHelpID;
	unsigned FdwMenuData;
	
public:
	__fastcall tagMENUINFOWrapper(const tagMENUINFO &ARecord);
	tagMENUINFO __fastcall ObjToRec(void);
	
__published:
	__property unsigned cbSize = {read=FcbSize, write=FcbSize, nodefault};
	__property unsigned fMask = {read=FfMask, write=FfMask, nodefault};
	__property unsigned dwStyle = {read=FdwStyle, write=FdwStyle, nodefault};
	__property unsigned cyMax = {read=FcyMax, write=FcyMax, nodefault};
	__property HBRUSH hbrBack = {read=FhbrBack, write=FhbrBack, nodefault};
	__property unsigned dwContextHelpID = {read=FdwContextHelpID, write=FdwContextHelpID, nodefault};
	__property unsigned dwMenuData = {read=FdwMenuData, write=FdwMenuData, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagMENUINFOWrapper(void) { }
	
};


class DELPHICLASS tagMENUGETOBJECTINFOWrapper;
class PASCALIMPLEMENTATION tagMENUGETOBJECTINFOWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FdwFlags;
	unsigned FuPos;
	HMENU Fhmenu;
	
public:
	__fastcall tagMENUGETOBJECTINFOWrapper(const tagMENUGETOBJECTINFO &ARecord);
	tagMENUGETOBJECTINFO __fastcall ObjToRec(void);
	
__published:
	__property unsigned dwFlags = {read=FdwFlags, write=FdwFlags, nodefault};
	__property unsigned uPos = {read=FuPos, write=FuPos, nodefault};
	__property HMENU hmenu = {read=Fhmenu, write=Fhmenu, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagMENUGETOBJECTINFOWrapper(void) { }
	
};


class DELPHICLASS tagMENUITEMINFOAWrapper;
class PASCALIMPLEMENTATION tagMENUITEMINFOAWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FcbSize;
	unsigned FfMask;
	unsigned FfType;
	unsigned FfState;
	unsigned FwID;
	HMENU FhSubMenu;
	HBITMAP FhbmpChecked;
	HBITMAP FhbmpUnchecked;
	unsigned FdwItemData;
	unsigned Fcch;
	HBITMAP FhbmpItem;
	
public:
	__fastcall tagMENUITEMINFOAWrapper(const tagMENUITEMINFOA &ARecord);
	tagMENUITEMINFOA __fastcall ObjToRec(void);
	
__published:
	__property unsigned cbSize = {read=FcbSize, write=FcbSize, nodefault};
	__property unsigned fMask = {read=FfMask, write=FfMask, nodefault};
	__property unsigned fType = {read=FfType, write=FfType, nodefault};
	__property unsigned fState = {read=FfState, write=FfState, nodefault};
	__property unsigned wID = {read=FwID, write=FwID, nodefault};
	__property HMENU hSubMenu = {read=FhSubMenu, write=FhSubMenu, nodefault};
	__property HBITMAP hbmpChecked = {read=FhbmpChecked, write=FhbmpChecked, nodefault};
	__property HBITMAP hbmpUnchecked = {read=FhbmpUnchecked, write=FhbmpUnchecked, nodefault};
	__property unsigned dwItemData = {read=FdwItemData, write=FdwItemData, nodefault};
	__property unsigned cch = {read=Fcch, write=Fcch, nodefault};
	__property HBITMAP hbmpItem = {read=FhbmpItem, write=FhbmpItem, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagMENUITEMINFOAWrapper(void) { }
	
};


class DELPHICLASS tagMENUITEMINFOWWrapper;
class PASCALIMPLEMENTATION tagMENUITEMINFOWWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FcbSize;
	unsigned FfMask;
	unsigned FfType;
	unsigned FfState;
	unsigned FwID;
	HMENU FhSubMenu;
	HBITMAP FhbmpChecked;
	HBITMAP FhbmpUnchecked;
	unsigned FdwItemData;
	unsigned Fcch;
	HBITMAP FhbmpItem;
	
public:
	__fastcall tagMENUITEMINFOWWrapper(const tagMENUITEMINFOW &ARecord);
	tagMENUITEMINFOW __fastcall ObjToRec(void);
	
__published:
	__property unsigned cbSize = {read=FcbSize, write=FcbSize, nodefault};
	__property unsigned fMask = {read=FfMask, write=FfMask, nodefault};
	__property unsigned fType = {read=FfType, write=FfType, nodefault};
	__property unsigned fState = {read=FfState, write=FfState, nodefault};
	__property unsigned wID = {read=FwID, write=FwID, nodefault};
	__property HMENU hSubMenu = {read=FhSubMenu, write=FhSubMenu, nodefault};
	__property HBITMAP hbmpChecked = {read=FhbmpChecked, write=FhbmpChecked, nodefault};
	__property HBITMAP hbmpUnchecked = {read=FhbmpUnchecked, write=FhbmpUnchecked, nodefault};
	__property unsigned dwItemData = {read=FdwItemData, write=FdwItemData, nodefault};
	__property unsigned cch = {read=Fcch, write=Fcch, nodefault};
	__property HBITMAP hbmpItem = {read=FhbmpItem, write=FhbmpItem, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagMENUITEMINFOWWrapper(void) { }
	
};


class DELPHICLASS tagDROPSTRUCTWrapper;
class PASCALIMPLEMENTATION tagDROPSTRUCTWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	HWND FhwndSource;
	HWND FhwndSink;
	unsigned FwFmt;
	unsigned FdwData;
	unsigned FdwControlData;
	
public:
	__fastcall tagDROPSTRUCTWrapper(const tagDROPSTRUCT &ARecord);
	tagDROPSTRUCT __fastcall ObjToRec(void);
	
__published:
	__property HWND hwndSource = {read=FhwndSource, write=FhwndSource, nodefault};
	__property HWND hwndSink = {read=FhwndSink, write=FhwndSink, nodefault};
	__property unsigned wFmt = {read=FwFmt, write=FwFmt, nodefault};
	__property unsigned dwData = {read=FdwData, write=FdwData, nodefault};
	__property unsigned dwControlData = {read=FdwControlData, write=FdwControlData, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagDROPSTRUCTWrapper(void) { }
	
};


class DELPHICLASS tagDRAWTEXTPARAMSWrapper;
class PASCALIMPLEMENTATION tagDRAWTEXTPARAMSWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FcbSize;
	int FiTabLength;
	int FiLeftMargin;
	int FiRightMargin;
	unsigned FuiLengthDrawn;
	
public:
	__fastcall tagDRAWTEXTPARAMSWrapper(const tagDRAWTEXTPARAMS &ARecord);
	tagDRAWTEXTPARAMS __fastcall ObjToRec(void);
	
__published:
	__property unsigned cbSize = {read=FcbSize, write=FcbSize, nodefault};
	__property int iTabLength = {read=FiTabLength, write=FiTabLength, nodefault};
	__property int iLeftMargin = {read=FiLeftMargin, write=FiLeftMargin, nodefault};
	__property int iRightMargin = {read=FiRightMargin, write=FiRightMargin, nodefault};
	__property unsigned uiLengthDrawn = {read=FuiLengthDrawn, write=FuiLengthDrawn, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagDRAWTEXTPARAMSWrapper(void) { }
	
};


class DELPHICLASS tagHELPINFOWrapper;
class PASCALIMPLEMENTATION tagHELPINFOWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FcbSize;
	int FiContextType;
	int FiCtrlId;
	unsigned FhItemHandle;
	unsigned FdwContextId;
	
public:
	__fastcall tagHELPINFOWrapper(const tagHELPINFO &ARecord);
	tagHELPINFO __fastcall ObjToRec(void);
	
__published:
	__property unsigned cbSize = {read=FcbSize, write=FcbSize, nodefault};
	__property int iContextType = {read=FiContextType, write=FiContextType, nodefault};
	__property int iCtrlId = {read=FiCtrlId, write=FiCtrlId, nodefault};
	__property unsigned hItemHandle = {read=FhItemHandle, write=FhItemHandle, nodefault};
	__property unsigned dwContextId = {read=FdwContextId, write=FdwContextId, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagHELPINFOWrapper(void) { }
	
};


class DELPHICLASS tagMSGBOXPARAMSAWrapper;
class PASCALIMPLEMENTATION tagMSGBOXPARAMSAWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FcbSize;
	HWND FhwndOwner;
	unsigned FhInstance;
	unsigned FdwStyle;
	unsigned FdwContextHelpId;
	unsigned FdwLanguageId;
	
public:
	__fastcall tagMSGBOXPARAMSAWrapper(const tagMSGBOXPARAMSA &ARecord);
	tagMSGBOXPARAMSA __fastcall ObjToRec(void);
	
__published:
	__property unsigned cbSize = {read=FcbSize, write=FcbSize, nodefault};
	__property HWND hwndOwner = {read=FhwndOwner, write=FhwndOwner, nodefault};
	__property unsigned hInstance = {read=FhInstance, write=FhInstance, nodefault};
	__property unsigned dwStyle = {read=FdwStyle, write=FdwStyle, nodefault};
	__property unsigned dwContextHelpId = {read=FdwContextHelpId, write=FdwContextHelpId, nodefault};
	__property unsigned dwLanguageId = {read=FdwLanguageId, write=FdwLanguageId, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagMSGBOXPARAMSAWrapper(void) { }
	
};


class DELPHICLASS tagMSGBOXPARAMSWWrapper;
class PASCALIMPLEMENTATION tagMSGBOXPARAMSWWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FcbSize;
	HWND FhwndOwner;
	unsigned FhInstance;
	unsigned FdwStyle;
	unsigned FdwContextHelpId;
	unsigned FdwLanguageId;
	
public:
	__fastcall tagMSGBOXPARAMSWWrapper(const tagMSGBOXPARAMSW &ARecord);
	tagMSGBOXPARAMSW __fastcall ObjToRec(void);
	
__published:
	__property unsigned cbSize = {read=FcbSize, write=FcbSize, nodefault};
	__property HWND hwndOwner = {read=FhwndOwner, write=FhwndOwner, nodefault};
	__property unsigned hInstance = {read=FhInstance, write=FhInstance, nodefault};
	__property unsigned dwStyle = {read=FdwStyle, write=FdwStyle, nodefault};
	__property unsigned dwContextHelpId = {read=FdwContextHelpId, write=FdwContextHelpId, nodefault};
	__property unsigned dwLanguageId = {read=FdwLanguageId, write=FdwLanguageId, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagMSGBOXPARAMSWWrapper(void) { }
	
};


class DELPHICLASS MENUITEMTEMPLATEHEADERWrapper;
class PASCALIMPLEMENTATION MENUITEMTEMPLATEHEADERWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	System::Word FversionNumber;
	System::Word Foffset;
	
public:
	__fastcall MENUITEMTEMPLATEHEADERWrapper(MENUITEMTEMPLATEHEADER ARecord);
	MENUITEMTEMPLATEHEADER __fastcall ObjToRec(void);
	
__published:
	__property System::Word versionNumber = {read=FversionNumber, write=FversionNumber, nodefault};
	__property System::Word offset = {read=Foffset, write=Foffset, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~MENUITEMTEMPLATEHEADERWrapper(void) { }
	
};


class DELPHICLASS MENUITEMTEMPLATEWrapper;
class PASCALIMPLEMENTATION MENUITEMTEMPLATEWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	System::Word FmtOption;
	System::Word FmtID;
	
public:
	__fastcall MENUITEMTEMPLATEWrapper(const MENUITEMTEMPLATE &ARecord);
	MENUITEMTEMPLATE __fastcall ObjToRec(void);
	
__published:
	__property System::Word mtOption = {read=FmtOption, write=FmtOption, nodefault};
	__property System::Word mtID = {read=FmtID, write=FmtID, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~MENUITEMTEMPLATEWrapper(void) { }
	
};


class DELPHICLASS _ICONINFOWrapper;
class PASCALIMPLEMENTATION _ICONINFOWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	BOOL FfIcon;
	unsigned FxHotspot;
	unsigned FyHotspot;
	HBITMAP FhbmMask;
	HBITMAP FhbmColor;
	
public:
	__fastcall _ICONINFOWrapper(const _ICONINFO &ARecord);
	_ICONINFO __fastcall ObjToRec(void);
	
__published:
	__property BOOL fIcon = {read=FfIcon, write=FfIcon, nodefault};
	__property unsigned xHotspot = {read=FxHotspot, write=FxHotspot, nodefault};
	__property unsigned yHotspot = {read=FyHotspot, write=FyHotspot, nodefault};
	__property HBITMAP hbmMask = {read=FhbmMask, write=FhbmMask, nodefault};
	__property HBITMAP hbmColor = {read=FhbmColor, write=FhbmColor, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_ICONINFOWrapper(void) { }
	
};


class DELPHICLASS tagCURSORSHAPEWrapper;
class PASCALIMPLEMENTATION tagCURSORSHAPEWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	int FxHotSpot;
	int FyHotSpot;
	int Fcx;
	int Fcy;
	int FcbWidth;
	System::Byte FPlanes;
	System::Byte FBitsPixel;
	
public:
	__fastcall tagCURSORSHAPEWrapper(const tagCURSORSHAPE &ARecord);
	tagCURSORSHAPE __fastcall ObjToRec(void);
	
__published:
	__property int xHotSpot = {read=FxHotSpot, write=FxHotSpot, nodefault};
	__property int yHotSpot = {read=FyHotSpot, write=FyHotSpot, nodefault};
	__property int cx = {read=Fcx, write=Fcx, nodefault};
	__property int cy = {read=Fcy, write=Fcy, nodefault};
	__property int cbWidth = {read=FcbWidth, write=FcbWidth, nodefault};
	__property System::Byte Planes = {read=FPlanes, write=FPlanes, nodefault};
	__property System::Byte BitsPixel = {read=FBitsPixel, write=FBitsPixel, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagCURSORSHAPEWrapper(void) { }
	
};


class DELPHICLASS ICONINFOEXAWrapper;
class PASCALIMPLEMENTATION ICONINFOEXAWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FcbSize;
	BOOL FfIcon;
	unsigned FxHotspot;
	unsigned FyHotspot;
	HBITMAP FhbmMask;
	HBITMAP FhbmColor;
	System::Word FwResID;
	
public:
	__fastcall ICONINFOEXAWrapper(const ICONINFOEXA &ARecord);
	ICONINFOEXA __fastcall ObjToRec(void);
	
__published:
	__property unsigned cbSize = {read=FcbSize, write=FcbSize, nodefault};
	__property BOOL fIcon = {read=FfIcon, write=FfIcon, nodefault};
	__property unsigned xHotspot = {read=FxHotspot, write=FxHotspot, nodefault};
	__property unsigned yHotspot = {read=FyHotspot, write=FyHotspot, nodefault};
	__property HBITMAP hbmMask = {read=FhbmMask, write=FhbmMask, nodefault};
	__property HBITMAP hbmColor = {read=FhbmColor, write=FhbmColor, nodefault};
	__property System::Word wResID = {read=FwResID, write=FwResID, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~ICONINFOEXAWrapper(void) { }
	
};


class DELPHICLASS ICONINFOEXWWrapper;
class PASCALIMPLEMENTATION ICONINFOEXWWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FcbSize;
	BOOL FfIcon;
	unsigned FxHotspot;
	unsigned FyHotspot;
	HBITMAP FhbmMask;
	HBITMAP FhbmColor;
	System::Word FwResID;
	
public:
	__fastcall ICONINFOEXWWrapper(const ICONINFOEXW &ARecord);
	ICONINFOEXW __fastcall ObjToRec(void);
	
__published:
	__property unsigned cbSize = {read=FcbSize, write=FcbSize, nodefault};
	__property BOOL fIcon = {read=FfIcon, write=FfIcon, nodefault};
	__property unsigned xHotspot = {read=FxHotspot, write=FxHotspot, nodefault};
	__property unsigned yHotspot = {read=FyHotspot, write=FyHotspot, nodefault};
	__property HBITMAP hbmMask = {read=FhbmMask, write=FhbmMask, nodefault};
	__property HBITMAP hbmColor = {read=FhbmColor, write=FhbmColor, nodefault};
	__property System::Word wResID = {read=FwResID, write=FwResID, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~ICONINFOEXWWrapper(void) { }
	
};


class DELPHICLASS tagSCROLLINFOWrapper;
class PASCALIMPLEMENTATION tagSCROLLINFOWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FcbSize;
	unsigned FfMask;
	int FnMin;
	int FnMax;
	unsigned FnPage;
	int FnPos;
	int FnTrackPos;
	
public:
	__fastcall tagSCROLLINFOWrapper(const tagSCROLLINFO &ARecord);
	tagSCROLLINFO __fastcall ObjToRec(void);
	
__published:
	__property unsigned cbSize = {read=FcbSize, write=FcbSize, nodefault};
	__property unsigned fMask = {read=FfMask, write=FfMask, nodefault};
	__property int nMin = {read=FnMin, write=FnMin, nodefault};
	__property int nMax = {read=FnMax, write=FnMax, nodefault};
	__property unsigned nPage = {read=FnPage, write=FnPage, nodefault};
	__property int nPos = {read=FnPos, write=FnPos, nodefault};
	__property int nTrackPos = {read=FnTrackPos, write=FnTrackPos, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagSCROLLINFOWrapper(void) { }
	
};


class DELPHICLASS tagMDICREATESTRUCTAWrapper;
class PASCALIMPLEMENTATION tagMDICREATESTRUCTAWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FhOwner;
	int Fx;
	int Fy;
	int Fcx;
	int Fcy;
	unsigned Fstyle;
	int FlParam;
	
public:
	__fastcall tagMDICREATESTRUCTAWrapper(const tagMDICREATESTRUCTA &ARecord);
	tagMDICREATESTRUCTA __fastcall ObjToRec(void);
	
__published:
	__property unsigned hOwner = {read=FhOwner, write=FhOwner, nodefault};
	__property int x = {read=Fx, write=Fx, nodefault};
	__property int y = {read=Fy, write=Fy, nodefault};
	__property int cx = {read=Fcx, write=Fcx, nodefault};
	__property int cy = {read=Fcy, write=Fcy, nodefault};
	__property unsigned style = {read=Fstyle, write=Fstyle, nodefault};
	__property int lParam = {read=FlParam, write=FlParam, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagMDICREATESTRUCTAWrapper(void) { }
	
};


class DELPHICLASS tagMDICREATESTRUCTWWrapper;
class PASCALIMPLEMENTATION tagMDICREATESTRUCTWWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FhOwner;
	int Fx;
	int Fy;
	int Fcx;
	int Fcy;
	unsigned Fstyle;
	int FlParam;
	
public:
	__fastcall tagMDICREATESTRUCTWWrapper(const tagMDICREATESTRUCTW &ARecord);
	tagMDICREATESTRUCTW __fastcall ObjToRec(void);
	
__published:
	__property unsigned hOwner = {read=FhOwner, write=FhOwner, nodefault};
	__property int x = {read=Fx, write=Fx, nodefault};
	__property int y = {read=Fy, write=Fy, nodefault};
	__property int cx = {read=Fcx, write=Fcx, nodefault};
	__property int cy = {read=Fcy, write=Fcy, nodefault};
	__property unsigned style = {read=Fstyle, write=Fstyle, nodefault};
	__property int lParam = {read=FlParam, write=FlParam, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagMDICREATESTRUCTWWrapper(void) { }
	
};


class DELPHICLASS tagCLIENTCREATESTRUCTWrapper;
class PASCALIMPLEMENTATION tagCLIENTCREATESTRUCTWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FhWindowMenu;
	unsigned FidFirstChild;
	
public:
	__fastcall tagCLIENTCREATESTRUCTWrapper(const tagCLIENTCREATESTRUCT &ARecord);
	tagCLIENTCREATESTRUCT __fastcall ObjToRec(void);
	
__published:
	__property unsigned hWindowMenu = {read=FhWindowMenu, write=FhWindowMenu, nodefault};
	__property unsigned idFirstChild = {read=FidFirstChild, write=FidFirstChild, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagCLIENTCREATESTRUCTWrapper(void) { }
	
};


class DELPHICLASS tagMULTIKEYHELPAWrapper;
class PASCALIMPLEMENTATION tagMULTIKEYHELPAWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FmkSize;
	char FmkKeylist;
	
public:
	__fastcall tagMULTIKEYHELPAWrapper(const tagMULTIKEYHELPA &ARecord);
	tagMULTIKEYHELPA __fastcall ObjToRec(void);
	
__published:
	__property unsigned mkSize = {read=FmkSize, write=FmkSize, nodefault};
	__property char mkKeylist = {read=FmkKeylist, write=FmkKeylist, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagMULTIKEYHELPAWrapper(void) { }
	
};


class DELPHICLASS tagMULTIKEYHELPWWrapper;
class PASCALIMPLEMENTATION tagMULTIKEYHELPWWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FmkSize;
	
public:
	__fastcall tagMULTIKEYHELPWWrapper(const tagMULTIKEYHELPW &ARecord);
	tagMULTIKEYHELPW __fastcall ObjToRec(void);
	
__published:
	__property unsigned mkSize = {read=FmkSize, write=FmkSize, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagMULTIKEYHELPWWrapper(void) { }
	
};


class DELPHICLASS tagHELPWININFOAWrapper;
class PASCALIMPLEMENTATION tagHELPWININFOAWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	int FwStructSize;
	int Fx;
	int Fy;
	int Fdx;
	int Fdy;
	int FwMax;
	
public:
	__fastcall tagHELPWININFOAWrapper(const tagHELPWININFOA &ARecord);
	tagHELPWININFOA __fastcall ObjToRec(void);
	
__published:
	__property int wStructSize = {read=FwStructSize, write=FwStructSize, nodefault};
	__property int x = {read=Fx, write=Fx, nodefault};
	__property int y = {read=Fy, write=Fy, nodefault};
	__property int dx = {read=Fdx, write=Fdx, nodefault};
	__property int dy = {read=Fdy, write=Fdy, nodefault};
	__property int wMax = {read=FwMax, write=FwMax, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagHELPWININFOAWrapper(void) { }
	
};


class DELPHICLASS tagHELPWININFOWWrapper;
class PASCALIMPLEMENTATION tagHELPWININFOWWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	int FwStructSize;
	int Fx;
	int Fy;
	int Fdx;
	int Fdy;
	int FwMax;
	
public:
	__fastcall tagHELPWININFOWWrapper(const tagHELPWININFOW &ARecord);
	tagHELPWININFOW __fastcall ObjToRec(void);
	
__published:
	__property int wStructSize = {read=FwStructSize, write=FwStructSize, nodefault};
	__property int x = {read=Fx, write=Fx, nodefault};
	__property int y = {read=Fy, write=Fy, nodefault};
	__property int dx = {read=Fdx, write=Fdx, nodefault};
	__property int dy = {read=Fdy, write=Fdy, nodefault};
	__property int wMax = {read=FwMax, write=FwMax, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagHELPWININFOWWrapper(void) { }
	
};


class DELPHICLASS _HHN_NOTIFYWrapper;
class PASCALIMPLEMENTATION _HHN_NOTIFYWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
public:
	__fastcall _HHN_NOTIFYWrapper(const Windows::_HHN_NOTIFY &ARecord);
	Windows::_HHN_NOTIFY __fastcall ObjToRec(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_HHN_NOTIFYWrapper(void) { }
	
};


class DELPHICLASS _HH_POPUPWrapper;
class PASCALIMPLEMENTATION _HH_POPUPWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	int FcbStruct;
	unsigned FhInst;
	unsigned FidString;
	unsigned FclrForeground;
	unsigned FclrBackground;
	
public:
	__fastcall _HH_POPUPWrapper(const Windows::_HH_POPUP &ARecord);
	Windows::_HH_POPUP __fastcall ObjToRec(void);
	
__published:
	__property int cbStruct = {read=FcbStruct, write=FcbStruct, nodefault};
	__property unsigned hInst = {read=FhInst, write=FhInst, nodefault};
	__property unsigned idString = {read=FidString, write=FidString, nodefault};
	__property unsigned clrForeground = {read=FclrForeground, write=FclrForeground, nodefault};
	__property unsigned clrBackground = {read=FclrBackground, write=FclrBackground, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_HH_POPUPWrapper(void) { }
	
};


class DELPHICLASS _HH_AKLINKWrapper;
class PASCALIMPLEMENTATION _HH_AKLINKWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	int FcbStruct;
	BOOL FfReserved;
	BOOL FfIndexOnFail;
	
public:
	__fastcall _HH_AKLINKWrapper(const Windows::_HH_AKLINK &ARecord);
	Windows::_HH_AKLINK __fastcall ObjToRec(void);
	
__published:
	__property int cbStruct = {read=FcbStruct, write=FcbStruct, nodefault};
	__property BOOL fReserved = {read=FfReserved, write=FfReserved, nodefault};
	__property BOOL fIndexOnFail = {read=FfIndexOnFail, write=FfIndexOnFail, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_HH_AKLINKWrapper(void) { }
	
};


class DELPHICLASS _HH_ENUM_ITWrapper;
class PASCALIMPLEMENTATION _HH_ENUM_ITWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	int FcbStruct;
	int FiType;
	
public:
	__fastcall _HH_ENUM_ITWrapper(const Windows::_HH_ENUM_IT &ARecord);
	Windows::_HH_ENUM_IT __fastcall ObjToRec(void);
	
__published:
	__property int cbStruct = {read=FcbStruct, write=FcbStruct, nodefault};
	__property int iType = {read=FiType, write=FiType, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_HH_ENUM_ITWrapper(void) { }
	
};


class DELPHICLASS _HH_ENUM_CATWrapper;
class PASCALIMPLEMENTATION _HH_ENUM_CATWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	int FcbStruct;
	
public:
	__fastcall _HH_ENUM_CATWrapper(const Windows::_HH_ENUM_CAT &ARecord);
	Windows::_HH_ENUM_CAT __fastcall ObjToRec(void);
	
__published:
	__property int cbStruct = {read=FcbStruct, write=FcbStruct, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_HH_ENUM_CATWrapper(void) { }
	
};


class DELPHICLASS _HH_SET_INFOTYPEWrapper;
class PASCALIMPLEMENTATION _HH_SET_INFOTYPEWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	int FcbStruct;
	
public:
	__fastcall _HH_SET_INFOTYPEWrapper(const Windows::_HH_SET_INFOTYPE &ARecord);
	Windows::_HH_SET_INFOTYPE __fastcall ObjToRec(void);
	
__published:
	__property int cbStruct = {read=FcbStruct, write=FcbStruct, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_HH_SET_INFOTYPEWrapper(void) { }
	
};


class DELPHICLASS _HH_FTS_QUERYAWrapper;
class PASCALIMPLEMENTATION _HH_FTS_QUERYAWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	int FcbStruct;
	BOOL FfUniCodeStrings;
	int FiProximity;
	BOOL FfStemmedSearch;
	BOOL FfTitleOnly;
	BOOL FfExecute;
	
public:
	__fastcall _HH_FTS_QUERYAWrapper(const Windows::_HH_FTS_QUERYA &ARecord);
	Windows::_HH_FTS_QUERYA __fastcall ObjToRec(void);
	
__published:
	__property int cbStruct = {read=FcbStruct, write=FcbStruct, nodefault};
	__property BOOL fUniCodeStrings = {read=FfUniCodeStrings, write=FfUniCodeStrings, nodefault};
	__property int iProximity = {read=FiProximity, write=FiProximity, nodefault};
	__property BOOL fStemmedSearch = {read=FfStemmedSearch, write=FfStemmedSearch, nodefault};
	__property BOOL fTitleOnly = {read=FfTitleOnly, write=FfTitleOnly, nodefault};
	__property BOOL fExecute = {read=FfExecute, write=FfExecute, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_HH_FTS_QUERYAWrapper(void) { }
	
};


class DELPHICLASS _HH_FTS_QUERYWWrapper;
class PASCALIMPLEMENTATION _HH_FTS_QUERYWWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	int FcbStruct;
	BOOL FfUniCodeStrings;
	int FiProximity;
	BOOL FfStemmedSearch;
	BOOL FfTitleOnly;
	BOOL FfExecute;
	
public:
	__fastcall _HH_FTS_QUERYWWrapper(const Windows::_HH_FTS_QUERYW &ARecord);
	Windows::_HH_FTS_QUERYW __fastcall ObjToRec(void);
	
__published:
	__property int cbStruct = {read=FcbStruct, write=FcbStruct, nodefault};
	__property BOOL fUniCodeStrings = {read=FfUniCodeStrings, write=FfUniCodeStrings, nodefault};
	__property int iProximity = {read=FiProximity, write=FiProximity, nodefault};
	__property BOOL fStemmedSearch = {read=FfStemmedSearch, write=FfStemmedSearch, nodefault};
	__property BOOL fTitleOnly = {read=FfTitleOnly, write=FfTitleOnly, nodefault};
	__property BOOL fExecute = {read=FfExecute, write=FfExecute, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_HH_FTS_QUERYWWrapper(void) { }
	
};


class DELPHICLASS _HH_WINTYPEWrapper;
class PASCALIMPLEMENTATION _HH_WINTYPEWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	int FcbStruct;
	BOOL FfUniCodeStrings;
	unsigned FfsValidMembers;
	unsigned FfsWinProperties;
	unsigned FdwStyles;
	unsigned FdwExStyles;
	int FnShowState;
	HWND FhwndHelp;
	HWND FhwndCaller;
	HWND FhwndToolBar;
	HWND FhwndNavigation;
	HWND FhwndHTML;
	int FiNavWidth;
	unsigned FfsToolBarFlags;
	BOOL FfNotExpanded;
	int FcurNavType;
	int FtabPos;
	int FidNotify;
	int FcHistory;
	int FcbInfoTYpes;
	int FpszCustomTabs;
	
public:
	__fastcall _HH_WINTYPEWrapper(const Windows::_HH_WINTYPE &ARecord);
	Windows::_HH_WINTYPE __fastcall ObjToRec(void);
	
__published:
	__property int cbStruct = {read=FcbStruct, write=FcbStruct, nodefault};
	__property BOOL fUniCodeStrings = {read=FfUniCodeStrings, write=FfUniCodeStrings, nodefault};
	__property unsigned fsValidMembers = {read=FfsValidMembers, write=FfsValidMembers, nodefault};
	__property unsigned fsWinProperties = {read=FfsWinProperties, write=FfsWinProperties, nodefault};
	__property unsigned dwStyles = {read=FdwStyles, write=FdwStyles, nodefault};
	__property unsigned dwExStyles = {read=FdwExStyles, write=FdwExStyles, nodefault};
	__property int nShowState = {read=FnShowState, write=FnShowState, nodefault};
	__property HWND hwndHelp = {read=FhwndHelp, write=FhwndHelp, nodefault};
	__property HWND hwndCaller = {read=FhwndCaller, write=FhwndCaller, nodefault};
	__property HWND hwndToolBar = {read=FhwndToolBar, write=FhwndToolBar, nodefault};
	__property HWND hwndNavigation = {read=FhwndNavigation, write=FhwndNavigation, nodefault};
	__property HWND hwndHTML = {read=FhwndHTML, write=FhwndHTML, nodefault};
	__property int iNavWidth = {read=FiNavWidth, write=FiNavWidth, nodefault};
	__property unsigned fsToolBarFlags = {read=FfsToolBarFlags, write=FfsToolBarFlags, nodefault};
	__property BOOL fNotExpanded = {read=FfNotExpanded, write=FfNotExpanded, nodefault};
	__property int curNavType = {read=FcurNavType, write=FcurNavType, nodefault};
	__property int tabPos = {read=FtabPos, write=FtabPos, nodefault};
	__property int idNotify = {read=FidNotify, write=FidNotify, nodefault};
	__property int cHistory = {read=FcHistory, write=FcHistory, nodefault};
	__property int cbInfoTYpes = {read=FcbInfoTYpes, write=FcbInfoTYpes, nodefault};
	__property int pszCustomTabs = {read=FpszCustomTabs, write=FpszCustomTabs, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_HH_WINTYPEWrapper(void) { }
	
};


class DELPHICLASS _HH_NTRACKWrapper;
class PASCALIMPLEMENTATION _HH_NTRACKWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	int FidAction;
	
public:
	__fastcall _HH_NTRACKWrapper(const Windows::_HH_NTRACK &ARecord);
	Windows::_HH_NTRACK __fastcall ObjToRec(void);
	
__published:
	__property int idAction = {read=FidAction, write=FidAction, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_HH_NTRACKWrapper(void) { }
	
};


class DELPHICLASS tagNONCLIENTMETRICSAWrapper;
class PASCALIMPLEMENTATION tagNONCLIENTMETRICSAWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FcbSize;
	int FiBorderWidth;
	int FiScrollWidth;
	int FiScrollHeight;
	int FiCaptionWidth;
	int FiCaptionHeight;
	int FiSmCaptionWidth;
	int FiSmCaptionHeight;
	int FiMenuWidth;
	int FiMenuHeight;
	int FiPaddedBorderWidth;
	
public:
	__fastcall tagNONCLIENTMETRICSAWrapper(const tagNONCLIENTMETRICSA &ARecord);
	tagNONCLIENTMETRICSA __fastcall ObjToRec(void);
	
__published:
	__property unsigned cbSize = {read=FcbSize, write=FcbSize, nodefault};
	__property int iBorderWidth = {read=FiBorderWidth, write=FiBorderWidth, nodefault};
	__property int iScrollWidth = {read=FiScrollWidth, write=FiScrollWidth, nodefault};
	__property int iScrollHeight = {read=FiScrollHeight, write=FiScrollHeight, nodefault};
	__property int iCaptionWidth = {read=FiCaptionWidth, write=FiCaptionWidth, nodefault};
	__property int iCaptionHeight = {read=FiCaptionHeight, write=FiCaptionHeight, nodefault};
	__property int iSmCaptionWidth = {read=FiSmCaptionWidth, write=FiSmCaptionWidth, nodefault};
	__property int iSmCaptionHeight = {read=FiSmCaptionHeight, write=FiSmCaptionHeight, nodefault};
	__property int iMenuWidth = {read=FiMenuWidth, write=FiMenuWidth, nodefault};
	__property int iMenuHeight = {read=FiMenuHeight, write=FiMenuHeight, nodefault};
	__property int iPaddedBorderWidth = {read=FiPaddedBorderWidth, write=FiPaddedBorderWidth, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagNONCLIENTMETRICSAWrapper(void) { }
	
};


class DELPHICLASS tagNONCLIENTMETRICSWWrapper;
class PASCALIMPLEMENTATION tagNONCLIENTMETRICSWWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FcbSize;
	int FiBorderWidth;
	int FiScrollWidth;
	int FiScrollHeight;
	int FiCaptionWidth;
	int FiCaptionHeight;
	int FiSmCaptionWidth;
	int FiSmCaptionHeight;
	int FiMenuWidth;
	int FiMenuHeight;
	int FiPaddedBorderWidth;
	
public:
	__fastcall tagNONCLIENTMETRICSWWrapper(const tagNONCLIENTMETRICSW &ARecord);
	tagNONCLIENTMETRICSW __fastcall ObjToRec(void);
	
__published:
	__property unsigned cbSize = {read=FcbSize, write=FcbSize, nodefault};
	__property int iBorderWidth = {read=FiBorderWidth, write=FiBorderWidth, nodefault};
	__property int iScrollWidth = {read=FiScrollWidth, write=FiScrollWidth, nodefault};
	__property int iScrollHeight = {read=FiScrollHeight, write=FiScrollHeight, nodefault};
	__property int iCaptionWidth = {read=FiCaptionWidth, write=FiCaptionWidth, nodefault};
	__property int iCaptionHeight = {read=FiCaptionHeight, write=FiCaptionHeight, nodefault};
	__property int iSmCaptionWidth = {read=FiSmCaptionWidth, write=FiSmCaptionWidth, nodefault};
	__property int iSmCaptionHeight = {read=FiSmCaptionHeight, write=FiSmCaptionHeight, nodefault};
	__property int iMenuWidth = {read=FiMenuWidth, write=FiMenuWidth, nodefault};
	__property int iMenuHeight = {read=FiMenuHeight, write=FiMenuHeight, nodefault};
	__property int iPaddedBorderWidth = {read=FiPaddedBorderWidth, write=FiPaddedBorderWidth, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagNONCLIENTMETRICSWWrapper(void) { }
	
};


class DELPHICLASS tagMINIMIZEDMETRICSWrapper;
class PASCALIMPLEMENTATION tagMINIMIZEDMETRICSWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FcbSize;
	int FiWidth;
	int FiHorzGap;
	int FiVertGap;
	int FiArrange;
	
public:
	__fastcall tagMINIMIZEDMETRICSWrapper(const tagMINIMIZEDMETRICS &ARecord);
	tagMINIMIZEDMETRICS __fastcall ObjToRec(void);
	
__published:
	__property unsigned cbSize = {read=FcbSize, write=FcbSize, nodefault};
	__property int iWidth = {read=FiWidth, write=FiWidth, nodefault};
	__property int iHorzGap = {read=FiHorzGap, write=FiHorzGap, nodefault};
	__property int iVertGap = {read=FiVertGap, write=FiVertGap, nodefault};
	__property int iArrange = {read=FiArrange, write=FiArrange, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagMINIMIZEDMETRICSWrapper(void) { }
	
};


class DELPHICLASS tagICONMETRICSAWrapper;
class PASCALIMPLEMENTATION tagICONMETRICSAWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FcbSize;
	int FiHorzSpacing;
	int FiVertSpacing;
	int FiTitleWrap;
	
public:
	__fastcall tagICONMETRICSAWrapper(const tagICONMETRICSA &ARecord);
	tagICONMETRICSA __fastcall ObjToRec(void);
	
__published:
	__property unsigned cbSize = {read=FcbSize, write=FcbSize, nodefault};
	__property int iHorzSpacing = {read=FiHorzSpacing, write=FiHorzSpacing, nodefault};
	__property int iVertSpacing = {read=FiVertSpacing, write=FiVertSpacing, nodefault};
	__property int iTitleWrap = {read=FiTitleWrap, write=FiTitleWrap, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagICONMETRICSAWrapper(void) { }
	
};


class DELPHICLASS tagICONMETRICSWWrapper;
class PASCALIMPLEMENTATION tagICONMETRICSWWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FcbSize;
	int FiHorzSpacing;
	int FiVertSpacing;
	int FiTitleWrap;
	
public:
	__fastcall tagICONMETRICSWWrapper(const tagICONMETRICSW &ARecord);
	tagICONMETRICSW __fastcall ObjToRec(void);
	
__published:
	__property unsigned cbSize = {read=FcbSize, write=FcbSize, nodefault};
	__property int iHorzSpacing = {read=FiHorzSpacing, write=FiHorzSpacing, nodefault};
	__property int iVertSpacing = {read=FiVertSpacing, write=FiVertSpacing, nodefault};
	__property int iTitleWrap = {read=FiTitleWrap, write=FiTitleWrap, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagICONMETRICSWWrapper(void) { }
	
};


class DELPHICLASS tagANIMATIONINFOWrapper;
class PASCALIMPLEMENTATION tagANIMATIONINFOWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FcbSize;
	int FiMinAnimate;
	
public:
	__fastcall tagANIMATIONINFOWrapper(const tagANIMATIONINFO &ARecord);
	tagANIMATIONINFO __fastcall ObjToRec(void);
	
__published:
	__property unsigned cbSize = {read=FcbSize, write=FcbSize, nodefault};
	__property int iMinAnimate = {read=FiMinAnimate, write=FiMinAnimate, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagANIMATIONINFOWrapper(void) { }
	
};


class DELPHICLASS tagSERIALKEYSAWrapper;
class PASCALIMPLEMENTATION tagSERIALKEYSAWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FcbSize;
	unsigned FdwFlags;
	unsigned FiBaudRate;
	unsigned FiPortState;
	unsigned FiActive;
	
public:
	__fastcall tagSERIALKEYSAWrapper(const tagSERIALKEYSA &ARecord);
	tagSERIALKEYSA __fastcall ObjToRec(void);
	
__published:
	__property unsigned cbSize = {read=FcbSize, write=FcbSize, nodefault};
	__property unsigned dwFlags = {read=FdwFlags, write=FdwFlags, nodefault};
	__property unsigned iBaudRate = {read=FiBaudRate, write=FiBaudRate, nodefault};
	__property unsigned iPortState = {read=FiPortState, write=FiPortState, nodefault};
	__property unsigned iActive = {read=FiActive, write=FiActive, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagSERIALKEYSAWrapper(void) { }
	
};


class DELPHICLASS tagSERIALKEYSWWrapper;
class PASCALIMPLEMENTATION tagSERIALKEYSWWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FcbSize;
	unsigned FdwFlags;
	unsigned FiBaudRate;
	unsigned FiPortState;
	unsigned FiActive;
	
public:
	__fastcall tagSERIALKEYSWWrapper(const tagSERIALKEYSW &ARecord);
	tagSERIALKEYSW __fastcall ObjToRec(void);
	
__published:
	__property unsigned cbSize = {read=FcbSize, write=FcbSize, nodefault};
	__property unsigned dwFlags = {read=FdwFlags, write=FdwFlags, nodefault};
	__property unsigned iBaudRate = {read=FiBaudRate, write=FiBaudRate, nodefault};
	__property unsigned iPortState = {read=FiPortState, write=FiPortState, nodefault};
	__property unsigned iActive = {read=FiActive, write=FiActive, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagSERIALKEYSWWrapper(void) { }
	
};


class DELPHICLASS tagHIGHCONTRASTAWrapper;
class PASCALIMPLEMENTATION tagHIGHCONTRASTAWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FcbSize;
	unsigned FdwFlags;
	
public:
	__fastcall tagHIGHCONTRASTAWrapper(const tagHIGHCONTRASTA &ARecord);
	tagHIGHCONTRASTA __fastcall ObjToRec(void);
	
__published:
	__property unsigned cbSize = {read=FcbSize, write=FcbSize, nodefault};
	__property unsigned dwFlags = {read=FdwFlags, write=FdwFlags, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagHIGHCONTRASTAWrapper(void) { }
	
};


class DELPHICLASS tagHIGHCONTRASTWWrapper;
class PASCALIMPLEMENTATION tagHIGHCONTRASTWWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FcbSize;
	unsigned FdwFlags;
	
public:
	__fastcall tagHIGHCONTRASTWWrapper(const tagHIGHCONTRASTW &ARecord);
	tagHIGHCONTRASTW __fastcall ObjToRec(void);
	
__published:
	__property unsigned cbSize = {read=FcbSize, write=FcbSize, nodefault};
	__property unsigned dwFlags = {read=FdwFlags, write=FdwFlags, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagHIGHCONTRASTWWrapper(void) { }
	
};


class DELPHICLASS tagFILTERKEYSWrapper;
class PASCALIMPLEMENTATION tagFILTERKEYSWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FcbSize;
	unsigned FdwFlags;
	unsigned FiWaitMSec;
	unsigned FiDelayMSec;
	unsigned FiRepeatMSec;
	unsigned FiBounceMSec;
	
public:
	__fastcall tagFILTERKEYSWrapper(const tagFILTERKEYS &ARecord);
	tagFILTERKEYS __fastcall ObjToRec(void);
	
__published:
	__property unsigned cbSize = {read=FcbSize, write=FcbSize, nodefault};
	__property unsigned dwFlags = {read=FdwFlags, write=FdwFlags, nodefault};
	__property unsigned iWaitMSec = {read=FiWaitMSec, write=FiWaitMSec, nodefault};
	__property unsigned iDelayMSec = {read=FiDelayMSec, write=FiDelayMSec, nodefault};
	__property unsigned iRepeatMSec = {read=FiRepeatMSec, write=FiRepeatMSec, nodefault};
	__property unsigned iBounceMSec = {read=FiBounceMSec, write=FiBounceMSec, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagFILTERKEYSWrapper(void) { }
	
};


class DELPHICLASS tagSTICKYKEYSWrapper;
class PASCALIMPLEMENTATION tagSTICKYKEYSWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FcbSize;
	unsigned FdwFlags;
	
public:
	__fastcall tagSTICKYKEYSWrapper(const tagSTICKYKEYS &ARecord);
	tagSTICKYKEYS __fastcall ObjToRec(void);
	
__published:
	__property unsigned cbSize = {read=FcbSize, write=FcbSize, nodefault};
	__property unsigned dwFlags = {read=FdwFlags, write=FdwFlags, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagSTICKYKEYSWrapper(void) { }
	
};


class DELPHICLASS tagMOUSEKEYSWrapper;
class PASCALIMPLEMENTATION tagMOUSEKEYSWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FcbSize;
	unsigned FdwFlags;
	unsigned FiMaxSpeed;
	unsigned FiTimeToMaxSpeed;
	unsigned FiCtrlSpeed;
	unsigned FdwReserved1;
	unsigned FdwReserved2;
	
public:
	__fastcall tagMOUSEKEYSWrapper(const tagMOUSEKEYS &ARecord);
	tagMOUSEKEYS __fastcall ObjToRec(void);
	
__published:
	__property unsigned cbSize = {read=FcbSize, write=FcbSize, nodefault};
	__property unsigned dwFlags = {read=FdwFlags, write=FdwFlags, nodefault};
	__property unsigned iMaxSpeed = {read=FiMaxSpeed, write=FiMaxSpeed, nodefault};
	__property unsigned iTimeToMaxSpeed = {read=FiTimeToMaxSpeed, write=FiTimeToMaxSpeed, nodefault};
	__property unsigned iCtrlSpeed = {read=FiCtrlSpeed, write=FiCtrlSpeed, nodefault};
	__property unsigned dwReserved1 = {read=FdwReserved1, write=FdwReserved1, nodefault};
	__property unsigned dwReserved2 = {read=FdwReserved2, write=FdwReserved2, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagMOUSEKEYSWrapper(void) { }
	
};


class DELPHICLASS tagACCESSTIMEOUTWrapper;
class PASCALIMPLEMENTATION tagACCESSTIMEOUTWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FcbSize;
	unsigned FdwFlags;
	unsigned FiTimeOutMSec;
	
public:
	__fastcall tagACCESSTIMEOUTWrapper(const tagACCESSTIMEOUT &ARecord);
	tagACCESSTIMEOUT __fastcall ObjToRec(void);
	
__published:
	__property unsigned cbSize = {read=FcbSize, write=FcbSize, nodefault};
	__property unsigned dwFlags = {read=FdwFlags, write=FdwFlags, nodefault};
	__property unsigned iTimeOutMSec = {read=FiTimeOutMSec, write=FiTimeOutMSec, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagACCESSTIMEOUTWrapper(void) { }
	
};


class DELPHICLASS tagSOUNDSENTRYAWrapper;
class PASCALIMPLEMENTATION tagSOUNDSENTRYAWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FcbSize;
	unsigned FdwFlags;
	unsigned FiFSTextEffect;
	unsigned FiFSTextEffectMSec;
	unsigned FiFSTextEffectColorBits;
	unsigned FiFSGrafEffect;
	unsigned FiFSGrafEffectMSec;
	unsigned FiFSGrafEffectColor;
	unsigned FiWindowsEffect;
	unsigned FiWindowsEffectMSec;
	unsigned FiWindowsEffectOrdinal;
	
public:
	__fastcall tagSOUNDSENTRYAWrapper(const tagSOUNDSENTRYA &ARecord);
	tagSOUNDSENTRYA __fastcall ObjToRec(void);
	
__published:
	__property unsigned cbSize = {read=FcbSize, write=FcbSize, nodefault};
	__property unsigned dwFlags = {read=FdwFlags, write=FdwFlags, nodefault};
	__property unsigned iFSTextEffect = {read=FiFSTextEffect, write=FiFSTextEffect, nodefault};
	__property unsigned iFSTextEffectMSec = {read=FiFSTextEffectMSec, write=FiFSTextEffectMSec, nodefault};
	__property unsigned iFSTextEffectColorBits = {read=FiFSTextEffectColorBits, write=FiFSTextEffectColorBits, nodefault};
	__property unsigned iFSGrafEffect = {read=FiFSGrafEffect, write=FiFSGrafEffect, nodefault};
	__property unsigned iFSGrafEffectMSec = {read=FiFSGrafEffectMSec, write=FiFSGrafEffectMSec, nodefault};
	__property unsigned iFSGrafEffectColor = {read=FiFSGrafEffectColor, write=FiFSGrafEffectColor, nodefault};
	__property unsigned iWindowsEffect = {read=FiWindowsEffect, write=FiWindowsEffect, nodefault};
	__property unsigned iWindowsEffectMSec = {read=FiWindowsEffectMSec, write=FiWindowsEffectMSec, nodefault};
	__property unsigned iWindowsEffectOrdinal = {read=FiWindowsEffectOrdinal, write=FiWindowsEffectOrdinal, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagSOUNDSENTRYAWrapper(void) { }
	
};


class DELPHICLASS tagSOUNDSENTRYWWrapper;
class PASCALIMPLEMENTATION tagSOUNDSENTRYWWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FcbSize;
	unsigned FdwFlags;
	unsigned FiFSTextEffect;
	unsigned FiFSTextEffectMSec;
	unsigned FiFSTextEffectColorBits;
	unsigned FiFSGrafEffect;
	unsigned FiFSGrafEffectMSec;
	unsigned FiFSGrafEffectColor;
	unsigned FiWindowsEffect;
	unsigned FiWindowsEffectMSec;
	unsigned FiWindowsEffectOrdinal;
	
public:
	__fastcall tagSOUNDSENTRYWWrapper(const tagSOUNDSENTRYW &ARecord);
	tagSOUNDSENTRYW __fastcall ObjToRec(void);
	
__published:
	__property unsigned cbSize = {read=FcbSize, write=FcbSize, nodefault};
	__property unsigned dwFlags = {read=FdwFlags, write=FdwFlags, nodefault};
	__property unsigned iFSTextEffect = {read=FiFSTextEffect, write=FiFSTextEffect, nodefault};
	__property unsigned iFSTextEffectMSec = {read=FiFSTextEffectMSec, write=FiFSTextEffectMSec, nodefault};
	__property unsigned iFSTextEffectColorBits = {read=FiFSTextEffectColorBits, write=FiFSTextEffectColorBits, nodefault};
	__property unsigned iFSGrafEffect = {read=FiFSGrafEffect, write=FiFSGrafEffect, nodefault};
	__property unsigned iFSGrafEffectMSec = {read=FiFSGrafEffectMSec, write=FiFSGrafEffectMSec, nodefault};
	__property unsigned iFSGrafEffectColor = {read=FiFSGrafEffectColor, write=FiFSGrafEffectColor, nodefault};
	__property unsigned iWindowsEffect = {read=FiWindowsEffect, write=FiWindowsEffect, nodefault};
	__property unsigned iWindowsEffectMSec = {read=FiWindowsEffectMSec, write=FiWindowsEffectMSec, nodefault};
	__property unsigned iWindowsEffectOrdinal = {read=FiWindowsEffectOrdinal, write=FiWindowsEffectOrdinal, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagSOUNDSENTRYWWrapper(void) { }
	
};


class DELPHICLASS tagTOGGLEKEYSWrapper;
class PASCALIMPLEMENTATION tagTOGGLEKEYSWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FcbSize;
	unsigned FdwFlags;
	
public:
	__fastcall tagTOGGLEKEYSWrapper(const tagTOGGLEKEYS &ARecord);
	tagTOGGLEKEYS __fastcall ObjToRec(void);
	
__published:
	__property unsigned cbSize = {read=FcbSize, write=FcbSize, nodefault};
	__property unsigned dwFlags = {read=FdwFlags, write=FdwFlags, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagTOGGLEKEYSWrapper(void) { }
	
};


class DELPHICLASS AUDIODESCRIPTIONWrapper;
class PASCALIMPLEMENTATION AUDIODESCRIPTIONWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FcbSize;
	BOOL FEnabled;
	unsigned FLocale;
	
public:
	__fastcall AUDIODESCRIPTIONWrapper(const AUDIODESCRIPTION &ARecord);
	AUDIODESCRIPTION __fastcall ObjToRec(void);
	
__published:
	__property unsigned cbSize = {read=FcbSize, write=FcbSize, nodefault};
	__property BOOL Enabled = {read=FEnabled, write=FEnabled, nodefault};
	__property unsigned Locale = {read=FLocale, write=FLocale, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~AUDIODESCRIPTIONWrapper(void) { }
	
};


class DELPHICLASS tagGUITHREADINFOWrapper;
class PASCALIMPLEMENTATION tagGUITHREADINFOWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FcbSize;
	unsigned Fflags;
	HWND FhwndActive;
	HWND FhwndFocus;
	HWND FhwndCapture;
	HWND FhwndMenuOwner;
	HWND FhwndMoveSize;
	HWND FhwndCaret;
	
public:
	__fastcall tagGUITHREADINFOWrapper(const tagGUITHREADINFO &ARecord);
	tagGUITHREADINFO __fastcall ObjToRec(void);
	
__published:
	__property unsigned cbSize = {read=FcbSize, write=FcbSize, nodefault};
	__property unsigned flags = {read=Fflags, write=Fflags, nodefault};
	__property HWND hwndActive = {read=FhwndActive, write=FhwndActive, nodefault};
	__property HWND hwndFocus = {read=FhwndFocus, write=FhwndFocus, nodefault};
	__property HWND hwndCapture = {read=FhwndCapture, write=FhwndCapture, nodefault};
	__property HWND hwndMenuOwner = {read=FhwndMenuOwner, write=FhwndMenuOwner, nodefault};
	__property HWND hwndMoveSize = {read=FhwndMoveSize, write=FhwndMoveSize, nodefault};
	__property HWND hwndCaret = {read=FhwndCaret, write=FhwndCaret, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagGUITHREADINFOWrapper(void) { }
	
};


class DELPHICLASS tagCURSORINFOWrapper;
class PASCALIMPLEMENTATION tagCURSORINFOWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FcbSize;
	unsigned Fflags;
	HICON FhCursor;
	
public:
	__fastcall tagCURSORINFOWrapper(const tagCURSORINFO &ARecord);
	tagCURSORINFO __fastcall ObjToRec(void);
	
__published:
	__property unsigned cbSize = {read=FcbSize, write=FcbSize, nodefault};
	__property unsigned flags = {read=Fflags, write=Fflags, nodefault};
	__property HICON hCursor = {read=FhCursor, write=FhCursor, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagCURSORINFOWrapper(void) { }
	
};


class DELPHICLASS tagWINDOWINFOWrapper;
class PASCALIMPLEMENTATION tagWINDOWINFOWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FcbSize;
	unsigned FdwStyle;
	unsigned FdwExStyle;
	unsigned FdwOtherStuff;
	unsigned FcxWindowBorders;
	unsigned FcyWindowBorders;
	System::Word FatomWindowType;
	System::Word FwCreatorVersion;
	
public:
	__fastcall tagWINDOWINFOWrapper(const tagWINDOWINFO &ARecord);
	tagWINDOWINFO __fastcall ObjToRec(void);
	
__published:
	__property unsigned cbSize = {read=FcbSize, write=FcbSize, nodefault};
	__property unsigned dwStyle = {read=FdwStyle, write=FdwStyle, nodefault};
	__property unsigned dwExStyle = {read=FdwExStyle, write=FdwExStyle, nodefault};
	__property unsigned dwOtherStuff = {read=FdwOtherStuff, write=FdwOtherStuff, nodefault};
	__property unsigned cxWindowBorders = {read=FcxWindowBorders, write=FcxWindowBorders, nodefault};
	__property unsigned cyWindowBorders = {read=FcyWindowBorders, write=FcyWindowBorders, nodefault};
	__property System::Word atomWindowType = {read=FatomWindowType, write=FatomWindowType, nodefault};
	__property System::Word wCreatorVersion = {read=FwCreatorVersion, write=FwCreatorVersion, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagWINDOWINFOWrapper(void) { }
	
};


class DELPHICLASS tagTITLEBARINFOWrapper;
class PASCALIMPLEMENTATION tagTITLEBARINFOWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FcbSize;
	
public:
	__fastcall tagTITLEBARINFOWrapper(const tagTITLEBARINFO &ARecord);
	tagTITLEBARINFO __fastcall ObjToRec(void);
	
__published:
	__property unsigned cbSize = {read=FcbSize, write=FcbSize, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagTITLEBARINFOWrapper(void) { }
	
};


class DELPHICLASS tagTITLEBARINFOEXWrapper;
class PASCALIMPLEMENTATION tagTITLEBARINFOEXWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FcbSize;
	
public:
	__fastcall tagTITLEBARINFOEXWrapper(const tagTITLEBARINFOEX &ARecord);
	tagTITLEBARINFOEX __fastcall ObjToRec(void);
	
__published:
	__property unsigned cbSize = {read=FcbSize, write=FcbSize, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagTITLEBARINFOEXWrapper(void) { }
	
};


class DELPHICLASS tagMENUBARINFOWrapper;
class PASCALIMPLEMENTATION tagMENUBARINFOWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FcbSize;
	HMENU FhMenu;
	HWND FhwndMenu;
	System::Byte FFocusedBits;
	
public:
	__fastcall tagMENUBARINFOWrapper(const tagMENUBARINFO &ARecord);
	tagMENUBARINFO __fastcall ObjToRec(void);
	
__published:
	__property unsigned cbSize = {read=FcbSize, write=FcbSize, nodefault};
	__property HMENU hMenu = {read=FhMenu, write=FhMenu, nodefault};
	__property HWND hwndMenu = {read=FhwndMenu, write=FhwndMenu, nodefault};
	__property System::Byte FocusedBits = {read=FFocusedBits, write=FFocusedBits, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagMENUBARINFOWrapper(void) { }
	
};


class DELPHICLASS tagSCROLLBARINFOWrapper;
class PASCALIMPLEMENTATION tagSCROLLBARINFOWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FcbSize;
	int FdxyLineButton;
	int FxyThumbTop;
	int FxyThumbBottom;
	int Fbogus;
	
public:
	__fastcall tagSCROLLBARINFOWrapper(const tagSCROLLBARINFO &ARecord);
	tagSCROLLBARINFO __fastcall ObjToRec(void);
	
__published:
	__property unsigned cbSize = {read=FcbSize, write=FcbSize, nodefault};
	__property int dxyLineButton = {read=FdxyLineButton, write=FdxyLineButton, nodefault};
	__property int xyThumbTop = {read=FxyThumbTop, write=FxyThumbTop, nodefault};
	__property int xyThumbBottom = {read=FxyThumbBottom, write=FxyThumbBottom, nodefault};
	__property int bogus = {read=Fbogus, write=Fbogus, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagSCROLLBARINFOWrapper(void) { }
	
};


class DELPHICLASS tagCOMBOBOXINFOWrapper;
class PASCALIMPLEMENTATION tagCOMBOBOXINFOWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FcbSize;
	unsigned FstateButton;
	HWND FhwndCombo;
	HWND FhwndItem;
	HWND FhwndList;
	
public:
	__fastcall tagCOMBOBOXINFOWrapper(const tagCOMBOBOXINFO &ARecord);
	tagCOMBOBOXINFO __fastcall ObjToRec(void);
	
__published:
	__property unsigned cbSize = {read=FcbSize, write=FcbSize, nodefault};
	__property unsigned stateButton = {read=FstateButton, write=FstateButton, nodefault};
	__property HWND hwndCombo = {read=FhwndCombo, write=FhwndCombo, nodefault};
	__property HWND hwndItem = {read=FhwndItem, write=FhwndItem, nodefault};
	__property HWND hwndList = {read=FhwndList, write=FhwndList, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagCOMBOBOXINFOWrapper(void) { }
	
};


class DELPHICLASS tagALTTABINFOWrapper;
class PASCALIMPLEMENTATION tagALTTABINFOWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FcbSize;
	int FcItems;
	int FcColumns;
	int FcRows;
	int FiColFocus;
	int FiRowFocus;
	int FcxItem;
	int FcyItem;
	
public:
	__fastcall tagALTTABINFOWrapper(const tagALTTABINFO &ARecord);
	tagALTTABINFO __fastcall ObjToRec(void);
	
__published:
	__property unsigned cbSize = {read=FcbSize, write=FcbSize, nodefault};
	__property int cItems = {read=FcItems, write=FcItems, nodefault};
	__property int cColumns = {read=FcColumns, write=FcColumns, nodefault};
	__property int cRows = {read=FcRows, write=FcRows, nodefault};
	__property int iColFocus = {read=FiColFocus, write=FiColFocus, nodefault};
	__property int iRowFocus = {read=FiRowFocus, write=FiRowFocus, nodefault};
	__property int cxItem = {read=FcxItem, write=FcxItem, nodefault};
	__property int cyItem = {read=FcyItem, write=FcyItem, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagALTTABINFOWrapper(void) { }
	
};


class DELPHICLASS _cpinfoWrapper;
class PASCALIMPLEMENTATION _cpinfoWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMaxCharSize;
	
public:
	__fastcall _cpinfoWrapper(const _cpinfo &ARecord);
	_cpinfo __fastcall ObjToRec(void);
	
__published:
	__property unsigned MaxCharSize = {read=FMaxCharSize, write=FMaxCharSize, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_cpinfoWrapper(void) { }
	
};


class DELPHICLASS _cpinfoExAWrapper;
class PASCALIMPLEMENTATION _cpinfoExAWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMaxCharSize;
	unsigned FCodepage;
	
public:
	__fastcall _cpinfoExAWrapper(const _cpinfoExA &ARecord);
	_cpinfoExA __fastcall ObjToRec(void);
	
__published:
	__property unsigned MaxCharSize = {read=FMaxCharSize, write=FMaxCharSize, nodefault};
	__property unsigned Codepage = {read=FCodepage, write=FCodepage, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_cpinfoExAWrapper(void) { }
	
};


class DELPHICLASS _cpinfoExWWrapper;
class PASCALIMPLEMENTATION _cpinfoExWWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMaxCharSize;
	unsigned FCodepage;
	
public:
	__fastcall _cpinfoExWWrapper(const _cpinfoExW &ARecord);
	_cpinfoExW __fastcall ObjToRec(void);
	
__published:
	__property unsigned MaxCharSize = {read=FMaxCharSize, write=FMaxCharSize, nodefault};
	__property unsigned Codepage = {read=FCodepage, write=FCodepage, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_cpinfoExWWrapper(void) { }
	
};


class DELPHICLASS _numberfmtAWrapper;
class PASCALIMPLEMENTATION _numberfmtAWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FNumDigits;
	unsigned FLeadingZero;
	unsigned FGrouping;
	unsigned FNegativeOrder;
	
public:
	__fastcall _numberfmtAWrapper(const _numberfmtA &ARecord);
	_numberfmtA __fastcall ObjToRec(void);
	
__published:
	__property unsigned NumDigits = {read=FNumDigits, write=FNumDigits, nodefault};
	__property unsigned LeadingZero = {read=FLeadingZero, write=FLeadingZero, nodefault};
	__property unsigned Grouping = {read=FGrouping, write=FGrouping, nodefault};
	__property unsigned NegativeOrder = {read=FNegativeOrder, write=FNegativeOrder, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_numberfmtAWrapper(void) { }
	
};


class DELPHICLASS _numberfmtWWrapper;
class PASCALIMPLEMENTATION _numberfmtWWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FNumDigits;
	unsigned FLeadingZero;
	unsigned FGrouping;
	unsigned FNegativeOrder;
	
public:
	__fastcall _numberfmtWWrapper(const _numberfmtW &ARecord);
	_numberfmtW __fastcall ObjToRec(void);
	
__published:
	__property unsigned NumDigits = {read=FNumDigits, write=FNumDigits, nodefault};
	__property unsigned LeadingZero = {read=FLeadingZero, write=FLeadingZero, nodefault};
	__property unsigned Grouping = {read=FGrouping, write=FGrouping, nodefault};
	__property unsigned NegativeOrder = {read=FNegativeOrder, write=FNegativeOrder, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_numberfmtWWrapper(void) { }
	
};


class DELPHICLASS _currencyfmtAWrapper;
class PASCALIMPLEMENTATION _currencyfmtAWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FNumDigits;
	unsigned FLeadingZero;
	unsigned FGrouping;
	unsigned FNegativeOrder;
	unsigned FPositiveOrder;
	
public:
	__fastcall _currencyfmtAWrapper(const _currencyfmtA &ARecord);
	_currencyfmtA __fastcall ObjToRec(void);
	
__published:
	__property unsigned NumDigits = {read=FNumDigits, write=FNumDigits, nodefault};
	__property unsigned LeadingZero = {read=FLeadingZero, write=FLeadingZero, nodefault};
	__property unsigned Grouping = {read=FGrouping, write=FGrouping, nodefault};
	__property unsigned NegativeOrder = {read=FNegativeOrder, write=FNegativeOrder, nodefault};
	__property unsigned PositiveOrder = {read=FPositiveOrder, write=FPositiveOrder, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_currencyfmtAWrapper(void) { }
	
};


class DELPHICLASS _currencyfmtWWrapper;
class PASCALIMPLEMENTATION _currencyfmtWWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FNumDigits;
	unsigned FLeadingZero;
	unsigned FGrouping;
	unsigned FNegativeOrder;
	unsigned FPositiveOrder;
	
public:
	__fastcall _currencyfmtWWrapper(const _currencyfmtW &ARecord);
	_currencyfmtW __fastcall ObjToRec(void);
	
__published:
	__property unsigned NumDigits = {read=FNumDigits, write=FNumDigits, nodefault};
	__property unsigned LeadingZero = {read=FLeadingZero, write=FLeadingZero, nodefault};
	__property unsigned Grouping = {read=FGrouping, write=FGrouping, nodefault};
	__property unsigned NegativeOrder = {read=FNegativeOrder, write=FNegativeOrder, nodefault};
	__property unsigned PositiveOrder = {read=FPositiveOrder, write=FPositiveOrder, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_currencyfmtWWrapper(void) { }
	
};


class DELPHICLASS _COORDWrapper;
class PASCALIMPLEMENTATION _COORDWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	short FX;
	short FY;
	
public:
	__fastcall _COORDWrapper(_COORD ARecord);
	_COORD __fastcall ObjToRec(void);
	
__published:
	__property short X = {read=FX, write=FX, nodefault};
	__property short Y = {read=FY, write=FY, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_COORDWrapper(void) { }
	
};


class DELPHICLASS _SMALL_RECTWrapper;
class PASCALIMPLEMENTATION _SMALL_RECTWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	short FLeft;
	short FTop;
	short FRight;
	short FBottom;
	
public:
	__fastcall _SMALL_RECTWrapper(const _SMALL_RECT &ARecord);
	_SMALL_RECT __fastcall ObjToRec(void);
	
__published:
	__property short Left = {read=FLeft, write=FLeft, nodefault};
	__property short Top = {read=FTop, write=FTop, nodefault};
	__property short Right = {read=FRight, write=FRight, nodefault};
	__property short Bottom = {read=FBottom, write=FBottom, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_SMALL_RECTWrapper(void) { }
	
};


class DELPHICLASS _KEY_EVENT_RECORDWrapper;
class PASCALIMPLEMENTATION _KEY_EVENT_RECORDWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	BOOL FbKeyDown;
	System::Word FwRepeatCount;
	System::Word FwVirtualKeyCode;
	System::Word FwVirtualScanCode;
	unsigned FdwControlKeyState;
	char FAsciiChar;
	
public:
	__fastcall _KEY_EVENT_RECORDWrapper(const _KEY_EVENT_RECORD &ARecord);
	_KEY_EVENT_RECORD __fastcall ObjToRec(void);
	
__published:
	__property BOOL bKeyDown = {read=FbKeyDown, write=FbKeyDown, nodefault};
	__property System::Word wRepeatCount = {read=FwRepeatCount, write=FwRepeatCount, nodefault};
	__property System::Word wVirtualKeyCode = {read=FwVirtualKeyCode, write=FwVirtualKeyCode, nodefault};
	__property System::Word wVirtualScanCode = {read=FwVirtualScanCode, write=FwVirtualScanCode, nodefault};
	__property unsigned dwControlKeyState = {read=FdwControlKeyState, write=FdwControlKeyState, nodefault};
	__property char AsciiChar = {read=FAsciiChar, write=FAsciiChar, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_KEY_EVENT_RECORDWrapper(void) { }
	
};


class DELPHICLASS _MOUSE_EVENT_RECORDWrapper;
class PASCALIMPLEMENTATION _MOUSE_EVENT_RECORDWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FdwButtonState;
	unsigned FdwControlKeyState;
	unsigned FdwEventFlags;
	
public:
	__fastcall _MOUSE_EVENT_RECORDWrapper(const _MOUSE_EVENT_RECORD &ARecord);
	_MOUSE_EVENT_RECORD __fastcall ObjToRec(void);
	
__published:
	__property unsigned dwButtonState = {read=FdwButtonState, write=FdwButtonState, nodefault};
	__property unsigned dwControlKeyState = {read=FdwControlKeyState, write=FdwControlKeyState, nodefault};
	__property unsigned dwEventFlags = {read=FdwEventFlags, write=FdwEventFlags, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_MOUSE_EVENT_RECORDWrapper(void) { }
	
};


class DELPHICLASS _WINDOW_BUFFER_SIZE_RECORDWrapper;
class PASCALIMPLEMENTATION _WINDOW_BUFFER_SIZE_RECORDWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
public:
	__fastcall _WINDOW_BUFFER_SIZE_RECORDWrapper(_WINDOW_BUFFER_SIZE_RECORD ARecord);
	_WINDOW_BUFFER_SIZE_RECORD __fastcall ObjToRec(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_WINDOW_BUFFER_SIZE_RECORDWrapper(void) { }
	
};


class DELPHICLASS _MENU_EVENT_RECORDWrapper;
class PASCALIMPLEMENTATION _MENU_EVENT_RECORDWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FdwCommandId;
	
public:
	__fastcall _MENU_EVENT_RECORDWrapper(_MENU_EVENT_RECORD ARecord);
	_MENU_EVENT_RECORD __fastcall ObjToRec(void);
	
__published:
	__property unsigned dwCommandId = {read=FdwCommandId, write=FdwCommandId, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_MENU_EVENT_RECORDWrapper(void) { }
	
};


class DELPHICLASS _FOCUS_EVENT_RECORDWrapper;
class PASCALIMPLEMENTATION _FOCUS_EVENT_RECORDWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	BOOL FbSetFocus;
	
public:
	__fastcall _FOCUS_EVENT_RECORDWrapper(_FOCUS_EVENT_RECORD ARecord);
	_FOCUS_EVENT_RECORD __fastcall ObjToRec(void);
	
__published:
	__property BOOL bSetFocus = {read=FbSetFocus, write=FbSetFocus, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_FOCUS_EVENT_RECORDWrapper(void) { }
	
};


class DELPHICLASS _INPUT_RECORDWrapper;
class PASCALIMPLEMENTATION _INPUT_RECORDWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	System::Word FEventType;
	System::Word FReserved;
	
public:
	__fastcall _INPUT_RECORDWrapper(const _INPUT_RECORD &ARecord);
	_INPUT_RECORD __fastcall ObjToRec(void);
	
__published:
	__property System::Word EventType = {read=FEventType, write=FEventType, nodefault};
	__property System::Word Reserved = {read=FReserved, write=FReserved, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_INPUT_RECORDWrapper(void) { }
	
};


class DELPHICLASS _CHAR_INFOWrapper;
class PASCALIMPLEMENTATION _CHAR_INFOWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	System::Word FAttributes;
	char FAsciiChar;
	
public:
	__fastcall _CHAR_INFOWrapper(_CHAR_INFO ARecord);
	_CHAR_INFO __fastcall ObjToRec(void);
	
__published:
	__property System::Word Attributes = {read=FAttributes, write=FAttributes, nodefault};
	__property char AsciiChar = {read=FAsciiChar, write=FAsciiChar, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_CHAR_INFOWrapper(void) { }
	
};


class DELPHICLASS _CONSOLE_SCREEN_BUFFER_INFOWrapper;
class PASCALIMPLEMENTATION _CONSOLE_SCREEN_BUFFER_INFOWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	System::Word FwAttributes;
	
public:
	__fastcall _CONSOLE_SCREEN_BUFFER_INFOWrapper(const _CONSOLE_SCREEN_BUFFER_INFO &ARecord);
	_CONSOLE_SCREEN_BUFFER_INFO __fastcall ObjToRec(void);
	
__published:
	__property System::Word wAttributes = {read=FwAttributes, write=FwAttributes, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_CONSOLE_SCREEN_BUFFER_INFOWrapper(void) { }
	
};


class DELPHICLASS _CONSOLE_CURSOR_INFOWrapper;
class PASCALIMPLEMENTATION _CONSOLE_CURSOR_INFOWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FdwSize;
	BOOL FbVisible;
	
public:
	__fastcall _CONSOLE_CURSOR_INFOWrapper(const _CONSOLE_CURSOR_INFO &ARecord);
	_CONSOLE_CURSOR_INFO __fastcall ObjToRec(void);
	
__published:
	__property unsigned dwSize = {read=FdwSize, write=FdwSize, nodefault};
	__property BOOL bVisible = {read=FbVisible, write=FbVisible, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_CONSOLE_CURSOR_INFOWrapper(void) { }
	
};


class DELPHICLASS tagVS_FIXEDFILEINFOWrapper;
class PASCALIMPLEMENTATION tagVS_FIXEDFILEINFOWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FdwSignature;
	unsigned FdwStrucVersion;
	unsigned FdwFileVersionMS;
	unsigned FdwFileVersionLS;
	unsigned FdwProductVersionMS;
	unsigned FdwProductVersionLS;
	unsigned FdwFileFlagsMask;
	unsigned FdwFileFlags;
	unsigned FdwFileOS;
	unsigned FdwFileType;
	unsigned FdwFileSubtype;
	unsigned FdwFileDateMS;
	unsigned FdwFileDateLS;
	
public:
	__fastcall tagVS_FIXEDFILEINFOWrapper(const tagVS_FIXEDFILEINFO &ARecord);
	tagVS_FIXEDFILEINFO __fastcall ObjToRec(void);
	
__published:
	__property unsigned dwSignature = {read=FdwSignature, write=FdwSignature, nodefault};
	__property unsigned dwStrucVersion = {read=FdwStrucVersion, write=FdwStrucVersion, nodefault};
	__property unsigned dwFileVersionMS = {read=FdwFileVersionMS, write=FdwFileVersionMS, nodefault};
	__property unsigned dwFileVersionLS = {read=FdwFileVersionLS, write=FdwFileVersionLS, nodefault};
	__property unsigned dwProductVersionMS = {read=FdwProductVersionMS, write=FdwProductVersionMS, nodefault};
	__property unsigned dwProductVersionLS = {read=FdwProductVersionLS, write=FdwProductVersionLS, nodefault};
	__property unsigned dwFileFlagsMask = {read=FdwFileFlagsMask, write=FdwFileFlagsMask, nodefault};
	__property unsigned dwFileFlags = {read=FdwFileFlags, write=FdwFileFlags, nodefault};
	__property unsigned dwFileOS = {read=FdwFileOS, write=FdwFileOS, nodefault};
	__property unsigned dwFileType = {read=FdwFileType, write=FdwFileType, nodefault};
	__property unsigned dwFileSubtype = {read=FdwFileSubtype, write=FdwFileSubtype, nodefault};
	__property unsigned dwFileDateMS = {read=FdwFileDateMS, write=FdwFileDateMS, nodefault};
	__property unsigned dwFileDateLS = {read=FdwFileDateLS, write=FdwFileDateLS, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagVS_FIXEDFILEINFOWrapper(void) { }
	
};


class DELPHICLASS val_contextWrapper;
class PASCALIMPLEMENTATION val_contextWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	int Fvaluelen;
	
public:
	__fastcall val_contextWrapper(const val_context &ARecord);
	val_context __fastcall ObjToRec(void);
	
__published:
	__property int valuelen = {read=Fvaluelen, write=Fvaluelen, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~val_contextWrapper(void) { }
	
};


class DELPHICLASS pvalueAWrapper;
class PASCALIMPLEMENTATION pvalueAWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	BOOL Fpv_valuelen;
	unsigned Fpv_type;
	
public:
	__fastcall pvalueAWrapper(const pvalueA &ARecord);
	pvalueA __fastcall ObjToRec(void);
	
__published:
	__property BOOL pv_valuelen = {read=Fpv_valuelen, write=Fpv_valuelen, nodefault};
	__property unsigned pv_type = {read=Fpv_type, write=Fpv_type, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~pvalueAWrapper(void) { }
	
};


class DELPHICLASS pvalueWWrapper;
class PASCALIMPLEMENTATION pvalueWWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	BOOL Fpv_valuelen;
	unsigned Fpv_type;
	
public:
	__fastcall pvalueWWrapper(const pvalueW &ARecord);
	pvalueW __fastcall ObjToRec(void);
	
__published:
	__property BOOL pv_valuelen = {read=Fpv_valuelen, write=Fpv_valuelen, nodefault};
	__property unsigned pv_type = {read=Fpv_type, write=Fpv_type, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~pvalueWWrapper(void) { }
	
};


class DELPHICLASS provider_infoWrapper;
class PASCALIMPLEMENTATION provider_infoWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned Fpi_flags;
	
public:
	__fastcall provider_infoWrapper(const provider_info &ARecord);
	provider_info __fastcall ObjToRec(void);
	
__published:
	__property unsigned pi_flags = {read=Fpi_flags, write=Fpi_flags, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~provider_infoWrapper(void) { }
	
};


class DELPHICLASS value_entAWrapper;
class PASCALIMPLEMENTATION value_entAWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned Fve_valuelen;
	unsigned Fve_valueptr;
	unsigned Fve_type;
	
public:
	__fastcall value_entAWrapper(const value_entA &ARecord);
	value_entA __fastcall ObjToRec(void);
	
__published:
	__property unsigned ve_valuelen = {read=Fve_valuelen, write=Fve_valuelen, nodefault};
	__property unsigned ve_valueptr = {read=Fve_valueptr, write=Fve_valueptr, nodefault};
	__property unsigned ve_type = {read=Fve_type, write=Fve_type, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~value_entAWrapper(void) { }
	
};


class DELPHICLASS value_entWWrapper;
class PASCALIMPLEMENTATION value_entWWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned Fve_valuelen;
	unsigned Fve_valueptr;
	unsigned Fve_type;
	
public:
	__fastcall value_entWWrapper(const value_entW &ARecord);
	value_entW __fastcall ObjToRec(void);
	
__published:
	__property unsigned ve_valuelen = {read=Fve_valuelen, write=Fve_valuelen, nodefault};
	__property unsigned ve_valueptr = {read=Fve_valueptr, write=Fve_valueptr, nodefault};
	__property unsigned ve_type = {read=Fve_type, write=Fve_type, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~value_entWWrapper(void) { }
	
};


class DELPHICLASS _NETRESOURCEAWrapper;
class PASCALIMPLEMENTATION _NETRESOURCEAWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FdwScope;
	unsigned FdwType;
	unsigned FdwDisplayType;
	unsigned FdwUsage;
	
public:
	__fastcall _NETRESOURCEAWrapper(const _NETRESOURCEA &ARecord);
	_NETRESOURCEA __fastcall ObjToRec(void);
	
__published:
	__property unsigned dwScope = {read=FdwScope, write=FdwScope, nodefault};
	__property unsigned dwType = {read=FdwType, write=FdwType, nodefault};
	__property unsigned dwDisplayType = {read=FdwDisplayType, write=FdwDisplayType, nodefault};
	__property unsigned dwUsage = {read=FdwUsage, write=FdwUsage, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_NETRESOURCEAWrapper(void) { }
	
};


class DELPHICLASS _NETRESOURCEWWrapper;
class PASCALIMPLEMENTATION _NETRESOURCEWWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FdwScope;
	unsigned FdwType;
	unsigned FdwDisplayType;
	unsigned FdwUsage;
	
public:
	__fastcall _NETRESOURCEWWrapper(const _NETRESOURCEW &ARecord);
	_NETRESOURCEW __fastcall ObjToRec(void);
	
__published:
	__property unsigned dwScope = {read=FdwScope, write=FdwScope, nodefault};
	__property unsigned dwType = {read=FdwType, write=FdwType, nodefault};
	__property unsigned dwDisplayType = {read=FdwDisplayType, write=FdwDisplayType, nodefault};
	__property unsigned dwUsage = {read=FdwUsage, write=FdwUsage, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_NETRESOURCEWWrapper(void) { }
	
};


class DELPHICLASS _CONNECTDLGSTRUCTAWrapper;
class PASCALIMPLEMENTATION _CONNECTDLGSTRUCTAWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FcbStructure;
	HWND FhwndOwner;
	unsigned FdwFlags;
	unsigned FdwDevNum;
	
public:
	__fastcall _CONNECTDLGSTRUCTAWrapper(const _CONNECTDLGSTRUCTA &ARecord);
	_CONNECTDLGSTRUCTA __fastcall ObjToRec(void);
	
__published:
	__property unsigned cbStructure = {read=FcbStructure, write=FcbStructure, nodefault};
	__property HWND hwndOwner = {read=FhwndOwner, write=FhwndOwner, nodefault};
	__property unsigned dwFlags = {read=FdwFlags, write=FdwFlags, nodefault};
	__property unsigned dwDevNum = {read=FdwDevNum, write=FdwDevNum, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_CONNECTDLGSTRUCTAWrapper(void) { }
	
};


class DELPHICLASS _DISCDLGSTRUCTAWrapper;
class PASCALIMPLEMENTATION _DISCDLGSTRUCTAWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FcbStructure;
	HWND FhwndOwner;
	unsigned FdwFlags;
	
public:
	__fastcall _DISCDLGSTRUCTAWrapper(const _DISCDLGSTRUCTA &ARecord);
	_DISCDLGSTRUCTA __fastcall ObjToRec(void);
	
__published:
	__property unsigned cbStructure = {read=FcbStructure, write=FcbStructure, nodefault};
	__property HWND hwndOwner = {read=FhwndOwner, write=FhwndOwner, nodefault};
	__property unsigned dwFlags = {read=FdwFlags, write=FdwFlags, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_DISCDLGSTRUCTAWrapper(void) { }
	
};


class DELPHICLASS _DISCDLGSTRUCTWWrapper;
class PASCALIMPLEMENTATION _DISCDLGSTRUCTWWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FcbStructure;
	HWND FhwndOwner;
	unsigned FdwFlags;
	
public:
	__fastcall _DISCDLGSTRUCTWWrapper(const _DISCDLGSTRUCTW &ARecord);
	_DISCDLGSTRUCTW __fastcall ObjToRec(void);
	
__published:
	__property unsigned cbStructure = {read=FcbStructure, write=FcbStructure, nodefault};
	__property HWND hwndOwner = {read=FhwndOwner, write=FhwndOwner, nodefault};
	__property unsigned dwFlags = {read=FdwFlags, write=FdwFlags, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_DISCDLGSTRUCTWWrapper(void) { }
	
};


class DELPHICLASS _UNIVERSAL_NAME_INFOAWrapper;
class PASCALIMPLEMENTATION _UNIVERSAL_NAME_INFOAWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
public:
	__fastcall _UNIVERSAL_NAME_INFOAWrapper(_UNIVERSAL_NAME_INFOA ARecord);
	_UNIVERSAL_NAME_INFOA __fastcall ObjToRec(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_UNIVERSAL_NAME_INFOAWrapper(void) { }
	
};


class DELPHICLASS _UNIVERSAL_NAME_INFOWWrapper;
class PASCALIMPLEMENTATION _UNIVERSAL_NAME_INFOWWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
public:
	__fastcall _UNIVERSAL_NAME_INFOWWrapper(_UNIVERSAL_NAME_INFOW ARecord);
	_UNIVERSAL_NAME_INFOW __fastcall ObjToRec(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_UNIVERSAL_NAME_INFOWWrapper(void) { }
	
};


class DELPHICLASS _REMOTE_NAME_INFOAWrapper;
class PASCALIMPLEMENTATION _REMOTE_NAME_INFOAWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
public:
	__fastcall _REMOTE_NAME_INFOAWrapper(const _REMOTE_NAME_INFOA &ARecord);
	_REMOTE_NAME_INFOA __fastcall ObjToRec(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_REMOTE_NAME_INFOAWrapper(void) { }
	
};


class DELPHICLASS _REMOTE_NAME_INFOWWrapper;
class PASCALIMPLEMENTATION _REMOTE_NAME_INFOWWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
public:
	__fastcall _REMOTE_NAME_INFOWWrapper(const _REMOTE_NAME_INFOW &ARecord);
	_REMOTE_NAME_INFOW __fastcall ObjToRec(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_REMOTE_NAME_INFOWWrapper(void) { }
	
};


class DELPHICLASS _NETINFOSTRUCTWrapper;
class PASCALIMPLEMENTATION _NETINFOSTRUCTWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FcbStructure;
	unsigned FdwProviderVersion;
	unsigned FdwStatus;
	unsigned FdwCharacteristics;
	unsigned FdwHandle;
	System::Word FwNetType;
	unsigned FdwPrinters;
	unsigned FdwDrives;
	
public:
	__fastcall _NETINFOSTRUCTWrapper(const _NETINFOSTRUCT &ARecord);
	_NETINFOSTRUCT __fastcall ObjToRec(void);
	
__published:
	__property unsigned cbStructure = {read=FcbStructure, write=FcbStructure, nodefault};
	__property unsigned dwProviderVersion = {read=FdwProviderVersion, write=FdwProviderVersion, nodefault};
	__property unsigned dwStatus = {read=FdwStatus, write=FdwStatus, nodefault};
	__property unsigned dwCharacteristics = {read=FdwCharacteristics, write=FdwCharacteristics, nodefault};
	__property unsigned dwHandle = {read=FdwHandle, write=FdwHandle, nodefault};
	__property System::Word wNetType = {read=FwNetType, write=FwNetType, nodefault};
	__property unsigned dwPrinters = {read=FdwPrinters, write=FdwPrinters, nodefault};
	__property unsigned dwDrives = {read=FdwDrives, write=FdwDrives, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_NETINFOSTRUCTWrapper(void) { }
	
};


class DELPHICLASS _NETCONNECTINFOSTRUCTWrapper;
class PASCALIMPLEMENTATION _NETCONNECTINFOSTRUCTWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FcbStructure;
	unsigned FdwFlags;
	unsigned FdwSpeed;
	unsigned FdwDelay;
	unsigned FdwOptDataSize;
	
public:
	__fastcall _NETCONNECTINFOSTRUCTWrapper(const _NETCONNECTINFOSTRUCT &ARecord);
	_NETCONNECTINFOSTRUCT __fastcall ObjToRec(void);
	
__published:
	__property unsigned cbStructure = {read=FcbStructure, write=FcbStructure, nodefault};
	__property unsigned dwFlags = {read=FdwFlags, write=FdwFlags, nodefault};
	__property unsigned dwSpeed = {read=FdwSpeed, write=FdwSpeed, nodefault};
	__property unsigned dwDelay = {read=FdwDelay, write=FdwDelay, nodefault};
	__property unsigned dwOptDataSize = {read=FdwOptDataSize, write=FdwOptDataSize, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_NETCONNECTINFOSTRUCTWrapper(void) { }
	
};


class DELPHICLASS DDEACKWrapper;
class PASCALIMPLEMENTATION DDEACKWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	System::Word FFlags;
	
public:
	__fastcall DDEACKWrapper(DDEACK ARecord);
	DDEACK __fastcall ObjToRec(void);
	
__published:
	__property System::Word Flags = {read=FFlags, write=FFlags, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~DDEACKWrapper(void) { }
	
};


class DELPHICLASS DDEADVISEWrapper;
class PASCALIMPLEMENTATION DDEADVISEWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	System::Word FFlags;
	short FcfFormat;
	
public:
	__fastcall DDEADVISEWrapper(DDEADVISE ARecord);
	DDEADVISE __fastcall ObjToRec(void);
	
__published:
	__property System::Word Flags = {read=FFlags, write=FFlags, nodefault};
	__property short cfFormat = {read=FcfFormat, write=FcfFormat, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~DDEADVISEWrapper(void) { }
	
};


class DELPHICLASS DDEDATAWrapper;
class PASCALIMPLEMENTATION DDEDATAWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	System::Word FFlags;
	short FcfFormat;
	
public:
	__fastcall DDEDATAWrapper(const DDEDATA &ARecord);
	DDEDATA __fastcall ObjToRec(void);
	
__published:
	__property System::Word Flags = {read=FFlags, write=FFlags, nodefault};
	__property short cfFormat = {read=FcfFormat, write=FcfFormat, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~DDEDATAWrapper(void) { }
	
};


class DELPHICLASS DDEPOKEWrapper;
class PASCALIMPLEMENTATION DDEPOKEWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	System::Word FFlags;
	short FcfFormat;
	
public:
	__fastcall DDEPOKEWrapper(const DDEPOKE &ARecord);
	DDEPOKE __fastcall ObjToRec(void);
	
__published:
	__property System::Word Flags = {read=FFlags, write=FFlags, nodefault};
	__property short cfFormat = {read=FcfFormat, write=FcfFormat, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~DDEPOKEWrapper(void) { }
	
};


class DELPHICLASS GESTUREINFOWrapper;
class PASCALIMPLEMENTATION GESTUREINFOWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FcbSize;
	unsigned FdwFlags;
	unsigned FdwID;
	HWND FhwndTarget;
	unsigned FdwInstanceID;
	unsigned FdwSequenceID;
	unsigned __int64 FullArguments;
	unsigned FcbExtraArgs;
	
public:
	__fastcall GESTUREINFOWrapper(const GESTUREINFO &ARecord);
	GESTUREINFO __fastcall ObjToRec(void);
	
__published:
	__property unsigned cbSize = {read=FcbSize, write=FcbSize, nodefault};
	__property unsigned dwFlags = {read=FdwFlags, write=FdwFlags, nodefault};
	__property unsigned dwID = {read=FdwID, write=FdwID, nodefault};
	__property HWND hwndTarget = {read=FhwndTarget, write=FhwndTarget, nodefault};
	__property unsigned dwInstanceID = {read=FdwInstanceID, write=FdwInstanceID, nodefault};
	__property unsigned dwSequenceID = {read=FdwSequenceID, write=FdwSequenceID, nodefault};
	__property unsigned __int64 ullArguments = {read=FullArguments, write=FullArguments};
	__property unsigned cbExtraArgs = {read=FcbExtraArgs, write=FcbExtraArgs, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~GESTUREINFOWrapper(void) { }
	
};


class DELPHICLASS GESTURENOTIFYSTRUCTWrapper;
class PASCALIMPLEMENTATION GESTURENOTIFYSTRUCTWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FcbSize;
	unsigned FdwFlags;
	HWND FhwndTarget;
	unsigned FdwInstanceID;
	
public:
	__fastcall GESTURENOTIFYSTRUCTWrapper(const GESTURENOTIFYSTRUCT &ARecord);
	GESTURENOTIFYSTRUCT __fastcall ObjToRec(void);
	
__published:
	__property unsigned cbSize = {read=FcbSize, write=FcbSize, nodefault};
	__property unsigned dwFlags = {read=FdwFlags, write=FdwFlags, nodefault};
	__property HWND hwndTarget = {read=FhwndTarget, write=FhwndTarget, nodefault};
	__property unsigned dwInstanceID = {read=FdwInstanceID, write=FdwInstanceID, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~GESTURENOTIFYSTRUCTWrapper(void) { }
	
};


class DELPHICLASS GESTURECONFIGWrapper;
class PASCALIMPLEMENTATION GESTURECONFIGWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FdwID;
	unsigned FdwWant;
	unsigned FdwBlock;
	
public:
	__fastcall GESTURECONFIGWrapper(const GESTURECONFIG &ARecord);
	GESTURECONFIG __fastcall ObjToRec(void);
	
__published:
	__property unsigned dwID = {read=FdwID, write=FdwID, nodefault};
	__property unsigned dwWant = {read=FdwWant, write=FdwWant, nodefault};
	__property unsigned dwBlock = {read=FdwBlock, write=FdwBlock, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~GESTURECONFIGWrapper(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Ap_windows */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Ap_windows;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Ap_windowsHPP
