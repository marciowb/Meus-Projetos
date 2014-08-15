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
unit ap_MMSystem;

interface

uses
  Windows,
  MMSystem,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatMMSystemLibrary = class(TatScripterLibrary)
    procedure __CloseDriver(AMachine: TatVirtualMachine);
    procedure __OpenDriver(AMachine: TatVirtualMachine);
    procedure __SendDriverMessage(AMachine: TatVirtualMachine);
    procedure __DrvGetModuleHandle(AMachine: TatVirtualMachine);
    procedure __GetDriverModuleHandle(AMachine: TatVirtualMachine);
    procedure __DefDriverProc(AMachine: TatVirtualMachine);
    procedure __mmsystemGetVersion(AMachine: TatVirtualMachine);
    procedure __sndPlaySound(AMachine: TatVirtualMachine);
    procedure __sndPlaySoundA(AMachine: TatVirtualMachine);
    procedure __sndPlaySoundW(AMachine: TatVirtualMachine);
    procedure __PlaySound(AMachine: TatVirtualMachine);
    procedure __PlaySoundA(AMachine: TatVirtualMachine);
    procedure __PlaySoundW(AMachine: TatVirtualMachine);
    procedure __waveOutGetNumDevs(AMachine: TatVirtualMachine);
    procedure __waveOutSetVolume(AMachine: TatVirtualMachine);
    procedure __waveOutGetErrorText(AMachine: TatVirtualMachine);
    procedure __waveOutGetErrorTextA(AMachine: TatVirtualMachine);
    procedure __waveOutGetErrorTextW(AMachine: TatVirtualMachine);
    procedure __waveOutClose(AMachine: TatVirtualMachine);
    procedure __waveOutPause(AMachine: TatVirtualMachine);
    procedure __waveOutRestart(AMachine: TatVirtualMachine);
    procedure __waveOutReset(AMachine: TatVirtualMachine);
    procedure __waveOutBreakLoop(AMachine: TatVirtualMachine);
    procedure __waveOutSetPitch(AMachine: TatVirtualMachine);
    procedure __waveOutSetPlaybackRate(AMachine: TatVirtualMachine);
    procedure __waveOutMessage(AMachine: TatVirtualMachine);
    procedure __waveInGetNumDevs(AMachine: TatVirtualMachine);
    procedure __waveInGetErrorText(AMachine: TatVirtualMachine);
    procedure __waveInGetErrorTextA(AMachine: TatVirtualMachine);
    procedure __waveInGetErrorTextW(AMachine: TatVirtualMachine);
    procedure __waveInClose(AMachine: TatVirtualMachine);
    procedure __waveInStart(AMachine: TatVirtualMachine);
    procedure __waveInStop(AMachine: TatVirtualMachine);
    procedure __waveInReset(AMachine: TatVirtualMachine);
    procedure __waveInMessage(AMachine: TatVirtualMachine);
    procedure __midiOutGetNumDevs(AMachine: TatVirtualMachine);
    procedure __midiStreamClose(AMachine: TatVirtualMachine);
    procedure __midiStreamPause(AMachine: TatVirtualMachine);
    procedure __midiStreamRestart(AMachine: TatVirtualMachine);
    procedure __midiStreamStop(AMachine: TatVirtualMachine);
    procedure __midiOutSetVolume(AMachine: TatVirtualMachine);
    procedure __midiOutGetErrorText(AMachine: TatVirtualMachine);
    procedure __midiOutGetErrorTextA(AMachine: TatVirtualMachine);
    procedure __midiOutGetErrorTextW(AMachine: TatVirtualMachine);
    procedure __midiOutClose(AMachine: TatVirtualMachine);
    procedure __midiOutShortMsg(AMachine: TatVirtualMachine);
    procedure __midiOutReset(AMachine: TatVirtualMachine);
    procedure __midiOutMessage(AMachine: TatVirtualMachine);
    procedure __midiInGetNumDevs(AMachine: TatVirtualMachine);
    procedure __midiInGetErrorText(AMachine: TatVirtualMachine);
    procedure __midiInGetErrorTextA(AMachine: TatVirtualMachine);
    procedure __midiInGetErrorTextW(AMachine: TatVirtualMachine);
    procedure __midiInClose(AMachine: TatVirtualMachine);
    procedure __midiInStart(AMachine: TatVirtualMachine);
    procedure __midiInStop(AMachine: TatVirtualMachine);
    procedure __midiInReset(AMachine: TatVirtualMachine);
    procedure __midiInMessage(AMachine: TatVirtualMachine);
    procedure __auxGetNumDevs(AMachine: TatVirtualMachine);
    procedure __auxSetVolume(AMachine: TatVirtualMachine);
    procedure __auxOutMessage(AMachine: TatVirtualMachine);
    procedure __mixerGetNumDevs(AMachine: TatVirtualMachine);
    procedure __mixerClose(AMachine: TatVirtualMachine);
    procedure __mixerMessage(AMachine: TatVirtualMachine);
    procedure __mixerGetID(AMachine: TatVirtualMachine);
    procedure __timeGetTime(AMachine: TatVirtualMachine);
    procedure __timeKillEvent(AMachine: TatVirtualMachine);
    procedure __timeBeginPeriod(AMachine: TatVirtualMachine);
    procedure __timeEndPeriod(AMachine: TatVirtualMachine);
    procedure __joyGetNumDevs(AMachine: TatVirtualMachine);
    procedure __joyReleaseCapture(AMachine: TatVirtualMachine);
    procedure __joySetCapture(AMachine: TatVirtualMachine);
    procedure __joySetThreshold(AMachine: TatVirtualMachine);
    procedure __mmioStringToFOURCC(AMachine: TatVirtualMachine);
    procedure __mmioStringToFOURCCA(AMachine: TatVirtualMachine);
    procedure __mmioStringToFOURCCW(AMachine: TatVirtualMachine);
    procedure __mmioClose(AMachine: TatVirtualMachine);
    procedure __mmioRead(AMachine: TatVirtualMachine);
    procedure __mmioWrite(AMachine: TatVirtualMachine);
    procedure __mmioSeek(AMachine: TatVirtualMachine);
    procedure __mmioSetBuffer(AMachine: TatVirtualMachine);
    procedure __mmioFlush(AMachine: TatVirtualMachine);
    procedure __mmioSendMessage(AMachine: TatVirtualMachine);
    procedure __mciSendCommand(AMachine: TatVirtualMachine);
    procedure __mciSendCommandA(AMachine: TatVirtualMachine);
    procedure __mciSendCommandW(AMachine: TatVirtualMachine);
    procedure __mciSendString(AMachine: TatVirtualMachine);
    procedure __mciSendStringA(AMachine: TatVirtualMachine);
    procedure __mciSendStringW(AMachine: TatVirtualMachine);
    procedure __mciGetDeviceID(AMachine: TatVirtualMachine);
    procedure __mciGetDeviceIDA(AMachine: TatVirtualMachine);
    procedure __mciGetDeviceIDW(AMachine: TatVirtualMachine);
    procedure __mciGetDeviceIDFromElementID(AMachine: TatVirtualMachine);
    procedure __mciGetDeviceIDFromElementIDA(AMachine: TatVirtualMachine);
    procedure __mciGetDeviceIDFromElementIDW(AMachine: TatVirtualMachine);
    procedure __mciGetErrorString(AMachine: TatVirtualMachine);
    procedure __mciGetErrorStringA(AMachine: TatVirtualMachine);
    procedure __mciGetErrorStringW(AMachine: TatVirtualMachine);
    procedure __mciGetCreatorTask(AMachine: TatVirtualMachine);
    procedure __mciExecute(AMachine: TatVirtualMachine);
    procedure __mci_MSF_Minute(AMachine: TatVirtualMachine);
    procedure __mci_MSF_Second(AMachine: TatVirtualMachine);
    procedure __mci_MSF_Frame(AMachine: TatVirtualMachine);
    procedure __mci_Make_MSF(AMachine: TatVirtualMachine);
    procedure __mci_TMSF_Track(AMachine: TatVirtualMachine);
    procedure __mci_TMSF_Minute(AMachine: TatVirtualMachine);
    procedure __mci_TMSF_Second(AMachine: TatVirtualMachine);
    procedure __mci_TMSF_Frame(AMachine: TatVirtualMachine);
    procedure __mci_Make_TMSF(AMachine: TatVirtualMachine);
    procedure __mci_HMS_Hour(AMachine: TatVirtualMachine);
    procedure __mci_HMS_Minute(AMachine: TatVirtualMachine);
    procedure __mci_HMS_Second(AMachine: TatVirtualMachine);
    procedure __mci_Make_HMS(AMachine: TatVirtualMachine);
    procedure __DIBIndex(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;



  mmtime_tagWrapper = class(TatRecordWrapper)
  private
    Fms: DWORD;
    Fsample: DWORD;
    Fcb: DWORD;
    Fticks: DWORD;
    Fhour: Byte;
    Fmin: Byte;
    Fsec: Byte;
    Fframe: Byte;
    Ffps: Byte;
    Fdummy: Byte;
    Fsongptrpos: DWORD;
  public
    constructor Create(ARecord: mmtime_tag);
    function ObjToRec: mmtime_tag;
  published
    property ms: DWORD read Fms write Fms;
    property sample: DWORD read Fsample write Fsample;
    property cb: DWORD read Fcb write Fcb;
    property ticks: DWORD read Fticks write Fticks;
    property hour: Byte read Fhour write Fhour;
    property min: Byte read Fmin write Fmin;
    property sec: Byte read Fsec write Fsec;
    property frame: Byte read Fframe write Fframe;
    property fps: Byte read Ffps write Ffps;
    property dummy: Byte read Fdummy write Fdummy;
    property songptrpos: DWORD read Fsongptrpos write Fsongptrpos;
  end;
  
  DRVCONFIGINFOEXWrapper = class(TatRecordWrapper)
  private
    FdwDCISize: DWORD;
    FdnDevNode: DWORD;
  public
    constructor Create(ARecord: DRVCONFIGINFOEX);
    function ObjToRec: DRVCONFIGINFOEX;
  published
    property dwDCISize: DWORD read FdwDCISize write FdwDCISize;
    property dnDevNode: DWORD read FdnDevNode write FdnDevNode;
  end;
  
  tagDRVCONFIGINFOWrapper = class(TatRecordWrapper)
  private
    FdwDCISize: DWORD;
  public
    constructor Create(ARecord: tagDRVCONFIGINFO);
    function ObjToRec: tagDRVCONFIGINFO;
  published
    property dwDCISize: DWORD read FdwDCISize write FdwDCISize;
  end;
  
  wavehdr_tagWrapper = class(TatRecordWrapper)
  private
    FdwBufferLength: DWORD;
    FdwBytesRecorded: DWORD;
    FdwUser: DWORD;
    FdwFlags: DWORD;
    FdwLoops: DWORD;
    Freserved: DWORD;
  public
    constructor Create(ARecord: wavehdr_tag);
    function ObjToRec: wavehdr_tag;
  published
    property dwBufferLength: DWORD read FdwBufferLength write FdwBufferLength;
    property dwBytesRecorded: DWORD read FdwBytesRecorded write FdwBytesRecorded;
    property dwUser: DWORD read FdwUser write FdwUser;
    property dwFlags: DWORD read FdwFlags write FdwFlags;
    property dwLoops: DWORD read FdwLoops write FdwLoops;
    property reserved: DWORD read Freserved write Freserved;
  end;
  
  tagWAVEOUTCAPSAWrapper = class(TatRecordWrapper)
  private
    FwMid: Word;
    FwPid: Word;
    FvDriverVersion: MMVERSION;
    FdwFormats: DWORD;
    FwChannels: Word;
    FdwSupport: DWORD;
  public
    constructor Create(ARecord: tagWAVEOUTCAPSA);
    function ObjToRec: tagWAVEOUTCAPSA;
  published
    property wMid: Word read FwMid write FwMid;
    property wPid: Word read FwPid write FwPid;
    property vDriverVersion: MMVERSION read FvDriverVersion write FvDriverVersion;
    property dwFormats: DWORD read FdwFormats write FdwFormats;
    property wChannels: Word read FwChannels write FwChannels;
    property dwSupport: DWORD read FdwSupport write FdwSupport;
  end;
  
  tagWAVEOUTCAPSWWrapper = class(TatRecordWrapper)
  private
    FwMid: Word;
    FwPid: Word;
    FvDriverVersion: MMVERSION;
    FdwFormats: DWORD;
    FwChannels: Word;
    FdwSupport: DWORD;
  public
    constructor Create(ARecord: tagWAVEOUTCAPSW);
    function ObjToRec: tagWAVEOUTCAPSW;
  published
    property wMid: Word read FwMid write FwMid;
    property wPid: Word read FwPid write FwPid;
    property vDriverVersion: MMVERSION read FvDriverVersion write FvDriverVersion;
    property dwFormats: DWORD read FdwFormats write FdwFormats;
    property wChannels: Word read FwChannels write FwChannels;
    property dwSupport: DWORD read FdwSupport write FdwSupport;
  end;
  
  tagWAVEINCAPSAWrapper = class(TatRecordWrapper)
  private
    FwMid: Word;
    FwPid: Word;
    FvDriverVersion: MMVERSION;
    FdwFormats: DWORD;
    FwChannels: Word;
    FwReserved1: Word;
  public
    constructor Create(ARecord: tagWAVEINCAPSA);
    function ObjToRec: tagWAVEINCAPSA;
  published
    property wMid: Word read FwMid write FwMid;
    property wPid: Word read FwPid write FwPid;
    property vDriverVersion: MMVERSION read FvDriverVersion write FvDriverVersion;
    property dwFormats: DWORD read FdwFormats write FdwFormats;
    property wChannels: Word read FwChannels write FwChannels;
    property wReserved1: Word read FwReserved1 write FwReserved1;
  end;
  
  tagWAVEINCAPSWWrapper = class(TatRecordWrapper)
  private
    FwMid: Word;
    FwPid: Word;
    FvDriverVersion: MMVERSION;
    FdwFormats: DWORD;
    FwChannels: Word;
    FwReserved1: Word;
  public
    constructor Create(ARecord: tagWAVEINCAPSW);
    function ObjToRec: tagWAVEINCAPSW;
  published
    property wMid: Word read FwMid write FwMid;
    property wPid: Word read FwPid write FwPid;
    property vDriverVersion: MMVERSION read FvDriverVersion write FvDriverVersion;
    property dwFormats: DWORD read FdwFormats write FdwFormats;
    property wChannels: Word read FwChannels write FwChannels;
    property wReserved1: Word read FwReserved1 write FwReserved1;
  end;
  
  waveformat_tagWrapper = class(TatRecordWrapper)
  private
    FwFormatTag: Word;
    FnChannels: Word;
    FnSamplesPerSec: DWORD;
    FnAvgBytesPerSec: DWORD;
    FnBlockAlign: Word;
  public
    constructor Create(ARecord: waveformat_tag);
    function ObjToRec: waveformat_tag;
  published
    property wFormatTag: Word read FwFormatTag write FwFormatTag;
    property nChannels: Word read FnChannels write FnChannels;
    property nSamplesPerSec: DWORD read FnSamplesPerSec write FnSamplesPerSec;
    property nAvgBytesPerSec: DWORD read FnAvgBytesPerSec write FnAvgBytesPerSec;
    property nBlockAlign: Word read FnBlockAlign write FnBlockAlign;
  end;
  
  pcmwaveformat_tagWrapper = class(TatRecordWrapper)
  private
    FwBitsPerSample: Word;
  public
    constructor Create(ARecord: pcmwaveformat_tag);
    function ObjToRec: pcmwaveformat_tag;
  published
    property wBitsPerSample: Word read FwBitsPerSample write FwBitsPerSample;
  end;
  
  tWAVEFORMATEXWrapper = class(TatRecordWrapper)
  private
    FwFormatTag: Word;
    FnChannels: Word;
    FnSamplesPerSec: DWORD;
    FnAvgBytesPerSec: DWORD;
    FnBlockAlign: Word;
    FwBitsPerSample: Word;
    FcbSize: Word;
  public
    constructor Create(ARecord: tWAVEFORMATEX);
    function ObjToRec: tWAVEFORMATEX;
  published
    property wFormatTag: Word read FwFormatTag write FwFormatTag;
    property nChannels: Word read FnChannels write FnChannels;
    property nSamplesPerSec: DWORD read FnSamplesPerSec write FnSamplesPerSec;
    property nAvgBytesPerSec: DWORD read FnAvgBytesPerSec write FnAvgBytesPerSec;
    property nBlockAlign: Word read FnBlockAlign write FnBlockAlign;
    property wBitsPerSample: Word read FwBitsPerSample write FwBitsPerSample;
    property cbSize: Word read FcbSize write FcbSize;
  end;
  
  tagMIDIOUTCAPSAWrapper = class(TatRecordWrapper)
  private
    FwMid: Word;
    FwPid: Word;
    FvDriverVersion: MMVERSION;
    FwTechnology: Word;
    FwVoices: Word;
    FwNotes: Word;
    FwChannelMask: Word;
    FdwSupport: DWORD;
  public
    constructor Create(ARecord: tagMIDIOUTCAPSA);
    function ObjToRec: tagMIDIOUTCAPSA;
  published
    property wMid: Word read FwMid write FwMid;
    property wPid: Word read FwPid write FwPid;
    property vDriverVersion: MMVERSION read FvDriverVersion write FvDriverVersion;
    property wTechnology: Word read FwTechnology write FwTechnology;
    property wVoices: Word read FwVoices write FwVoices;
    property wNotes: Word read FwNotes write FwNotes;
    property wChannelMask: Word read FwChannelMask write FwChannelMask;
    property dwSupport: DWORD read FdwSupport write FdwSupport;
  end;
  
  tagMIDIOUTCAPSWWrapper = class(TatRecordWrapper)
  private
    FwMid: Word;
    FwPid: Word;
    FvDriverVersion: MMVERSION;
    FwTechnology: Word;
    FwVoices: Word;
    FwNotes: Word;
    FwChannelMask: Word;
    FdwSupport: DWORD;
  public
    constructor Create(ARecord: tagMIDIOUTCAPSW);
    function ObjToRec: tagMIDIOUTCAPSW;
  published
    property wMid: Word read FwMid write FwMid;
    property wPid: Word read FwPid write FwPid;
    property vDriverVersion: MMVERSION read FvDriverVersion write FvDriverVersion;
    property wTechnology: Word read FwTechnology write FwTechnology;
    property wVoices: Word read FwVoices write FwVoices;
    property wNotes: Word read FwNotes write FwNotes;
    property wChannelMask: Word read FwChannelMask write FwChannelMask;
    property dwSupport: DWORD read FdwSupport write FdwSupport;
  end;
  
  tagMIDIINCAPSAWrapper = class(TatRecordWrapper)
  private
    FwMid: Word;
    FwPid: Word;
    FvDriverVersion: MMVERSION;
    FdwSupport: DWORD;
  public
    constructor Create(ARecord: tagMIDIINCAPSA);
    function ObjToRec: tagMIDIINCAPSA;
  published
    property wMid: Word read FwMid write FwMid;
    property wPid: Word read FwPid write FwPid;
    property vDriverVersion: MMVERSION read FvDriverVersion write FvDriverVersion;
    property dwSupport: DWORD read FdwSupport write FdwSupport;
  end;
  
  tagMIDIINCAPSWWrapper = class(TatRecordWrapper)
  private
    FwMid: Word;
    FwPid: Word;
    FvDriverVersion: MMVERSION;
    FdwSupport: DWORD;
  public
    constructor Create(ARecord: tagMIDIINCAPSW);
    function ObjToRec: tagMIDIINCAPSW;
  published
    property wMid: Word read FwMid write FwMid;
    property wPid: Word read FwPid write FwPid;
    property vDriverVersion: MMVERSION read FvDriverVersion write FvDriverVersion;
    property dwSupport: DWORD read FdwSupport write FdwSupport;
  end;
  
  midihdr_tagWrapper = class(TatRecordWrapper)
  private
    FdwBufferLength: DWORD;
    FdwBytesRecorded: DWORD;
    FdwUser: DWORD;
    FdwFlags: DWORD;
    Freserved: DWORD;
    FdwOffset: DWORD;
  public
    constructor Create(ARecord: midihdr_tag);
    function ObjToRec: midihdr_tag;
  published
    property dwBufferLength: DWORD read FdwBufferLength write FdwBufferLength;
    property dwBytesRecorded: DWORD read FdwBytesRecorded write FdwBytesRecorded;
    property dwUser: DWORD read FdwUser write FdwUser;
    property dwFlags: DWORD read FdwFlags write FdwFlags;
    property reserved: DWORD read Freserved write Freserved;
    property dwOffset: DWORD read FdwOffset write FdwOffset;
  end;
  
  midievent_tagWrapper = class(TatRecordWrapper)
  private
    FdwDeltaTime: DWORD;
    FdwStreamID: DWORD;
    FdwEvent: DWORD;
  public
    constructor Create(ARecord: midievent_tag);
    function ObjToRec: midievent_tag;
  published
    property dwDeltaTime: DWORD read FdwDeltaTime write FdwDeltaTime;
    property dwStreamID: DWORD read FdwStreamID write FdwStreamID;
    property dwEvent: DWORD read FdwEvent write FdwEvent;
  end;
  
  midistrmbuffver_tagWrapper = class(TatRecordWrapper)
  private
    FdwVersion: DWORD;
    FdwMid: DWORD;
    FdwOEMVersion: DWORD;
  public
    constructor Create(ARecord: midistrmbuffver_tag);
    function ObjToRec: midistrmbuffver_tag;
  published
    property dwVersion: DWORD read FdwVersion write FdwVersion;
    property dwMid: DWORD read FdwMid write FdwMid;
    property dwOEMVersion: DWORD read FdwOEMVersion write FdwOEMVersion;
  end;
  
  midiproptimediv_tagWrapper = class(TatRecordWrapper)
  private
    FcbStruct: DWORD;
    FdwTimeDiv: DWORD;
  public
    constructor Create(ARecord: midiproptimediv_tag);
    function ObjToRec: midiproptimediv_tag;
  published
    property cbStruct: DWORD read FcbStruct write FcbStruct;
    property dwTimeDiv: DWORD read FdwTimeDiv write FdwTimeDiv;
  end;
  
  midiproptempo_tagWrapper = class(TatRecordWrapper)
  private
    FcbStruct: DWORD;
    FdwTempo: DWORD;
  public
    constructor Create(ARecord: midiproptempo_tag);
    function ObjToRec: midiproptempo_tag;
  published
    property cbStruct: DWORD read FcbStruct write FcbStruct;
    property dwTempo: DWORD read FdwTempo write FdwTempo;
  end;
  
  tagAUXCAPSAWrapper = class(TatRecordWrapper)
  private
    FwMid: Word;
    FwPid: Word;
    FvDriverVersion: MMVERSION;
    FwTechnology: Word;
    FdwSupport: DWORD;
  public
    constructor Create(ARecord: tagAUXCAPSA);
    function ObjToRec: tagAUXCAPSA;
  published
    property wMid: Word read FwMid write FwMid;
    property wPid: Word read FwPid write FwPid;
    property vDriverVersion: MMVERSION read FvDriverVersion write FvDriverVersion;
    property wTechnology: Word read FwTechnology write FwTechnology;
    property dwSupport: DWORD read FdwSupport write FdwSupport;
  end;
  
  tagAUXCAPSWWrapper = class(TatRecordWrapper)
  private
    FwMid: Word;
    FwPid: Word;
    FvDriverVersion: MMVERSION;
    FwTechnology: Word;
    FdwSupport: DWORD;
  public
    constructor Create(ARecord: tagAUXCAPSW);
    function ObjToRec: tagAUXCAPSW;
  published
    property wMid: Word read FwMid write FwMid;
    property wPid: Word read FwPid write FwPid;
    property vDriverVersion: MMVERSION read FvDriverVersion write FvDriverVersion;
    property wTechnology: Word read FwTechnology write FwTechnology;
    property dwSupport: DWORD read FdwSupport write FdwSupport;
  end;
  
  tagMIXERCAPSAWrapper = class(TatRecordWrapper)
  private
    FwMid: WORD;
    FwPid: WORD;
    FvDriverVersion: MMVERSION;
    FfdwSupport: DWORD;
    FcDestinations: DWORD;
  public
    constructor Create(ARecord: tagMIXERCAPSA);
    function ObjToRec: tagMIXERCAPSA;
  published
    property wMid: WORD read FwMid write FwMid;
    property wPid: WORD read FwPid write FwPid;
    property vDriverVersion: MMVERSION read FvDriverVersion write FvDriverVersion;
    property fdwSupport: DWORD read FfdwSupport write FfdwSupport;
    property cDestinations: DWORD read FcDestinations write FcDestinations;
  end;
  
  tagMIXERCAPSWWrapper = class(TatRecordWrapper)
  private
    FwMid: WORD;
    FwPid: WORD;
    FvDriverVersion: MMVERSION;
    FfdwSupport: DWORD;
    FcDestinations: DWORD;
  public
    constructor Create(ARecord: tagMIXERCAPSW);
    function ObjToRec: tagMIXERCAPSW;
  published
    property wMid: WORD read FwMid write FwMid;
    property wPid: WORD read FwPid write FwPid;
    property vDriverVersion: MMVERSION read FvDriverVersion write FvDriverVersion;
    property fdwSupport: DWORD read FfdwSupport write FfdwSupport;
    property cDestinations: DWORD read FcDestinations write FcDestinations;
  end;
  
  tagMIXERLINEAWrapper = class(TatRecordWrapper)
  private
    FcbStruct: DWORD;
    FdwDestination: DWORD;
    FdwSource: DWORD;
    FdwLineID: DWORD;
    FfdwLine: DWORD;
    FdwUser: DWORD;
    FdwComponentType: DWORD;
    FcChannels: DWORD;
    FcConnections: DWORD;
    FcControls: DWORD;
  public
    constructor Create(ARecord: tagMIXERLINEA);
    function ObjToRec: tagMIXERLINEA;
  published
    property cbStruct: DWORD read FcbStruct write FcbStruct;
    property dwDestination: DWORD read FdwDestination write FdwDestination;
    property dwSource: DWORD read FdwSource write FdwSource;
    property dwLineID: DWORD read FdwLineID write FdwLineID;
    property fdwLine: DWORD read FfdwLine write FfdwLine;
    property dwUser: DWORD read FdwUser write FdwUser;
    property dwComponentType: DWORD read FdwComponentType write FdwComponentType;
    property cChannels: DWORD read FcChannels write FcChannels;
    property cConnections: DWORD read FcConnections write FcConnections;
    property cControls: DWORD read FcControls write FcControls;
  end;
  
  tagMIXERLINEWWrapper = class(TatRecordWrapper)
  private
    FcbStruct: DWORD;
    FdwDestination: DWORD;
    FdwSource: DWORD;
    FdwLineID: DWORD;
    FfdwLine: DWORD;
    FdwUser: DWORD;
    FdwComponentType: DWORD;
    FcChannels: DWORD;
    FcConnections: DWORD;
    FcControls: DWORD;
  public
    constructor Create(ARecord: tagMIXERLINEW);
    function ObjToRec: tagMIXERLINEW;
  published
    property cbStruct: DWORD read FcbStruct write FcbStruct;
    property dwDestination: DWORD read FdwDestination write FdwDestination;
    property dwSource: DWORD read FdwSource write FdwSource;
    property dwLineID: DWORD read FdwLineID write FdwLineID;
    property fdwLine: DWORD read FfdwLine write FfdwLine;
    property dwUser: DWORD read FdwUser write FdwUser;
    property dwComponentType: DWORD read FdwComponentType write FdwComponentType;
    property cChannels: DWORD read FcChannels write FcChannels;
    property cConnections: DWORD read FcConnections write FcConnections;
    property cControls: DWORD read FcControls write FcControls;
  end;
  
  tagMIXERCONTROLAWrapper = class(TatRecordWrapper)
  private
    FcbStruct: DWORD;
    FdwControlID: DWORD;
    FdwControlType: DWORD;
    FfdwControl: DWORD;
    FcMultipleItems: DWORD;
  public
    constructor Create(ARecord: tagMIXERCONTROLA);
    function ObjToRec: tagMIXERCONTROLA;
  published
    property cbStruct: DWORD read FcbStruct write FcbStruct;
    property dwControlID: DWORD read FdwControlID write FdwControlID;
    property dwControlType: DWORD read FdwControlType write FdwControlType;
    property fdwControl: DWORD read FfdwControl write FfdwControl;
    property cMultipleItems: DWORD read FcMultipleItems write FcMultipleItems;
  end;
  
  tagMIXERCONTROLWWrapper = class(TatRecordWrapper)
  private
    FcbStruct: DWORD;
    FdwControlID: DWORD;
    FdwControlType: DWORD;
    FfdwControl: DWORD;
    FcMultipleItems: DWORD;
  public
    constructor Create(ARecord: tagMIXERCONTROLW);
    function ObjToRec: tagMIXERCONTROLW;
  published
    property cbStruct: DWORD read FcbStruct write FcbStruct;
    property dwControlID: DWORD read FdwControlID write FdwControlID;
    property dwControlType: DWORD read FdwControlType write FdwControlType;
    property fdwControl: DWORD read FfdwControl write FfdwControl;
    property cMultipleItems: DWORD read FcMultipleItems write FcMultipleItems;
  end;
  
  tagMIXERLINECONTROLSAWrapper = class(TatRecordWrapper)
  private
    FcbStruct: DWORD;
    FdwLineID: DWORD;
    FdwControlID: DWORD;
    FdwControlType: DWORD;
    FcControls: DWORD;
    Fcbmxctrl: DWORD;
  public
    constructor Create(ARecord: tagMIXERLINECONTROLSA);
    function ObjToRec: tagMIXERLINECONTROLSA;
  published
    property cbStruct: DWORD read FcbStruct write FcbStruct;
    property dwLineID: DWORD read FdwLineID write FdwLineID;
    property dwControlID: DWORD read FdwControlID write FdwControlID;
    property dwControlType: DWORD read FdwControlType write FdwControlType;
    property cControls: DWORD read FcControls write FcControls;
    property cbmxctrl: DWORD read Fcbmxctrl write Fcbmxctrl;
  end;
  
  tagMIXERLINECONTROLSWWrapper = class(TatRecordWrapper)
  private
    FcbStruct: DWORD;
    FdwLineID: DWORD;
    FdwControlID: DWORD;
    FdwControlType: DWORD;
    FcControls: DWORD;
    Fcbmxctrl: DWORD;
  public
    constructor Create(ARecord: tagMIXERLINECONTROLSW);
    function ObjToRec: tagMIXERLINECONTROLSW;
  published
    property cbStruct: DWORD read FcbStruct write FcbStruct;
    property dwLineID: DWORD read FdwLineID write FdwLineID;
    property dwControlID: DWORD read FdwControlID write FdwControlID;
    property dwControlType: DWORD read FdwControlType write FdwControlType;
    property cControls: DWORD read FcControls write FcControls;
    property cbmxctrl: DWORD read Fcbmxctrl write Fcbmxctrl;
  end;
  
  tMIXERCONTROLDETAILSWrapper = class(TatRecordWrapper)
  private
    FcbStruct: DWORD;
    FdwControlID: DWORD;
    FcChannels: DWORD;
    FhwndOwner: HWND;
    FcMultipleItems: DWORD;
    FcbDetails: DWORD;
  public
    constructor Create(ARecord: tMIXERCONTROLDETAILS);
    function ObjToRec: tMIXERCONTROLDETAILS;
  published
    property cbStruct: DWORD read FcbStruct write FcbStruct;
    property dwControlID: DWORD read FdwControlID write FdwControlID;
    property cChannels: DWORD read FcChannels write FcChannels;
    property hwndOwner: HWND read FhwndOwner write FhwndOwner;
    property cMultipleItems: DWORD read FcMultipleItems write FcMultipleItems;
    property cbDetails: DWORD read FcbDetails write FcbDetails;
  end;
  
  tagMIXERCONTROLDETAILS_LISTTEXTAWrapper = class(TatRecordWrapper)
  private
    FdwParam1: DWORD;
    FdwParam2: DWORD;
  public
    constructor Create(ARecord: tagMIXERCONTROLDETAILS_LISTTEXTA);
    function ObjToRec: tagMIXERCONTROLDETAILS_LISTTEXTA;
  published
    property dwParam1: DWORD read FdwParam1 write FdwParam1;
    property dwParam2: DWORD read FdwParam2 write FdwParam2;
  end;
  
  tagMIXERCONTROLDETAILS_LISTTEXTWWrapper = class(TatRecordWrapper)
  private
    FdwParam1: DWORD;
    FdwParam2: DWORD;
  public
    constructor Create(ARecord: tagMIXERCONTROLDETAILS_LISTTEXTW);
    function ObjToRec: tagMIXERCONTROLDETAILS_LISTTEXTW;
  published
    property dwParam1: DWORD read FdwParam1 write FdwParam1;
    property dwParam2: DWORD read FdwParam2 write FdwParam2;
  end;
  
  tMIXERCONTROLDETAILS_BOOLEANWrapper = class(TatRecordWrapper)
  private
    FfValue: Longint;
  public
    constructor Create(ARecord: tMIXERCONTROLDETAILS_BOOLEAN);
    function ObjToRec: tMIXERCONTROLDETAILS_BOOLEAN;
  published
    property fValue: Longint read FfValue write FfValue;
  end;
  
  tMIXERCONTROLDETAILS_SIGNEDWrapper = class(TatRecordWrapper)
  private
    FlValue: Longint;
  public
    constructor Create(ARecord: tMIXERCONTROLDETAILS_SIGNED);
    function ObjToRec: tMIXERCONTROLDETAILS_SIGNED;
  published
    property lValue: Longint read FlValue write FlValue;
  end;
  
  tMIXERCONTROLDETAILS_UNSIGNEDWrapper = class(TatRecordWrapper)
  private
    FdwValue: DWORD;
  public
    constructor Create(ARecord: tMIXERCONTROLDETAILS_UNSIGNED);
    function ObjToRec: tMIXERCONTROLDETAILS_UNSIGNED;
  published
    property dwValue: DWORD read FdwValue write FdwValue;
  end;
  
  timecaps_tagWrapper = class(TatRecordWrapper)
  private
    FwPeriodMin: UINT;
    FwPeriodMax: UINT;
  public
    constructor Create(ARecord: timecaps_tag);
    function ObjToRec: timecaps_tag;
  published
    property wPeriodMin: UINT read FwPeriodMin write FwPeriodMin;
    property wPeriodMax: UINT read FwPeriodMax write FwPeriodMax;
  end;
  
  tagJOYCAPSAWrapper = class(TatRecordWrapper)
  private
    FwMid: Word;
    FwPid: Word;
    FwXmin: UINT;
    FwXmax: UINT;
    FwYmin: UINT;
    FwYmax: UINT;
    FwZmin: UINT;
    FwZmax: UINT;
    FwNumButtons: UINT;
    FwPeriodMin: UINT;
    FwPeriodMax: UINT;
    FwRmin: UINT;
    FwRmax: UINT;
    FwUmin: UINT;
    FwUmax: UINT;
    FwVmin: UINT;
    FwVmax: UINT;
    FwCaps: UINT;
    FwMaxAxes: UINT;
    FwNumAxes: UINT;
    FwMaxButtons: UINT;
  public
    constructor Create(ARecord: tagJOYCAPSA);
    function ObjToRec: tagJOYCAPSA;
  published
    property wMid: Word read FwMid write FwMid;
    property wPid: Word read FwPid write FwPid;
    property wXmin: UINT read FwXmin write FwXmin;
    property wXmax: UINT read FwXmax write FwXmax;
    property wYmin: UINT read FwYmin write FwYmin;
    property wYmax: UINT read FwYmax write FwYmax;
    property wZmin: UINT read FwZmin write FwZmin;
    property wZmax: UINT read FwZmax write FwZmax;
    property wNumButtons: UINT read FwNumButtons write FwNumButtons;
    property wPeriodMin: UINT read FwPeriodMin write FwPeriodMin;
    property wPeriodMax: UINT read FwPeriodMax write FwPeriodMax;
    property wRmin: UINT read FwRmin write FwRmin;
    property wRmax: UINT read FwRmax write FwRmax;
    property wUmin: UINT read FwUmin write FwUmin;
    property wUmax: UINT read FwUmax write FwUmax;
    property wVmin: UINT read FwVmin write FwVmin;
    property wVmax: UINT read FwVmax write FwVmax;
    property wCaps: UINT read FwCaps write FwCaps;
    property wMaxAxes: UINT read FwMaxAxes write FwMaxAxes;
    property wNumAxes: UINT read FwNumAxes write FwNumAxes;
    property wMaxButtons: UINT read FwMaxButtons write FwMaxButtons;
  end;
  
  tagJOYCAPSWWrapper = class(TatRecordWrapper)
  private
    FwMid: Word;
    FwPid: Word;
    FwXmin: UINT;
    FwXmax: UINT;
    FwYmin: UINT;
    FwYmax: UINT;
    FwZmin: UINT;
    FwZmax: UINT;
    FwNumButtons: UINT;
    FwPeriodMin: UINT;
    FwPeriodMax: UINT;
    FwRmin: UINT;
    FwRmax: UINT;
    FwUmin: UINT;
    FwUmax: UINT;
    FwVmin: UINT;
    FwVmax: UINT;
    FwCaps: UINT;
    FwMaxAxes: UINT;
    FwNumAxes: UINT;
    FwMaxButtons: UINT;
  public
    constructor Create(ARecord: tagJOYCAPSW);
    function ObjToRec: tagJOYCAPSW;
  published
    property wMid: Word read FwMid write FwMid;
    property wPid: Word read FwPid write FwPid;
    property wXmin: UINT read FwXmin write FwXmin;
    property wXmax: UINT read FwXmax write FwXmax;
    property wYmin: UINT read FwYmin write FwYmin;
    property wYmax: UINT read FwYmax write FwYmax;
    property wZmin: UINT read FwZmin write FwZmin;
    property wZmax: UINT read FwZmax write FwZmax;
    property wNumButtons: UINT read FwNumButtons write FwNumButtons;
    property wPeriodMin: UINT read FwPeriodMin write FwPeriodMin;
    property wPeriodMax: UINT read FwPeriodMax write FwPeriodMax;
    property wRmin: UINT read FwRmin write FwRmin;
    property wRmax: UINT read FwRmax write FwRmax;
    property wUmin: UINT read FwUmin write FwUmin;
    property wUmax: UINT read FwUmax write FwUmax;
    property wVmin: UINT read FwVmin write FwVmin;
    property wVmax: UINT read FwVmax write FwVmax;
    property wCaps: UINT read FwCaps write FwCaps;
    property wMaxAxes: UINT read FwMaxAxes write FwMaxAxes;
    property wNumAxes: UINT read FwNumAxes write FwNumAxes;
    property wMaxButtons: UINT read FwMaxButtons write FwMaxButtons;
  end;
  
  joyinfo_tagWrapper = class(TatRecordWrapper)
  private
    FwXpos: UINT;
    FwYpos: UINT;
    FwZpos: UINT;
    FwButtons: UINT;
  public
    constructor Create(ARecord: joyinfo_tag);
    function ObjToRec: joyinfo_tag;
  published
    property wXpos: UINT read FwXpos write FwXpos;
    property wYpos: UINT read FwYpos write FwYpos;
    property wZpos: UINT read FwZpos write FwZpos;
    property wButtons: UINT read FwButtons write FwButtons;
  end;
  
  joyinfoex_tagWrapper = class(TatRecordWrapper)
  private
    FdwSize: DWORD;
    FdwFlags: DWORD;
    FwXpos: UINT;
    FwYpos: UINT;
    FwZpos: UINT;
    FdwRpos: DWORD;
    FdwUpos: DWORD;
    FdwVpos: DWORD;
    FwButtons: UINT;
    FdwButtonNumber: DWORD;
    FdwPOV: DWORD;
    FdwReserved1: DWORD;
    FdwReserved2: DWORD;
  public
    constructor Create(ARecord: joyinfoex_tag);
    function ObjToRec: joyinfoex_tag;
  published
    property dwSize: DWORD read FdwSize write FdwSize;
    property dwFlags: DWORD read FdwFlags write FdwFlags;
    property wXpos: UINT read FwXpos write FwXpos;
    property wYpos: UINT read FwYpos write FwYpos;
    property wZpos: UINT read FwZpos write FwZpos;
    property dwRpos: DWORD read FdwRpos write FdwRpos;
    property dwUpos: DWORD read FdwUpos write FdwUpos;
    property dwVpos: DWORD read FdwVpos write FdwVpos;
    property wButtons: UINT read FwButtons write FwButtons;
    property dwButtonNumber: DWORD read FdwButtonNumber write FdwButtonNumber;
    property dwPOV: DWORD read FdwPOV write FdwPOV;
    property dwReserved1: DWORD read FdwReserved1 write FdwReserved1;
    property dwReserved2: DWORD read FdwReserved2 write FdwReserved2;
  end;
  
  _MMIOINFOWrapper = class(TatRecordWrapper)
  private
    FdwFlags: DWORD;
    FfccIOProc: FOURCC;
    FwErrorRet: UINT;
    FhTask: HTASK;
    FcchBuffer: Longint;
    FlBufOffset: Longint;
    FlDiskOffset: Longint;
    FdwReserved1: DWORD;
    FdwReserved2: DWORD;
    Fhmmio: HMMIO;
  public
    constructor Create(ARecord: _MMIOINFO);
    function ObjToRec: _MMIOINFO;
  published
    property dwFlags: DWORD read FdwFlags write FdwFlags;
    property fccIOProc: FOURCC read FfccIOProc write FfccIOProc;
    property wErrorRet: UINT read FwErrorRet write FwErrorRet;
    property hTask: HTASK read FhTask write FhTask;
    property cchBuffer: Longint read FcchBuffer write FcchBuffer;
    property lBufOffset: Longint read FlBufOffset write FlBufOffset;
    property lDiskOffset: Longint read FlDiskOffset write FlDiskOffset;
    property dwReserved1: DWORD read FdwReserved1 write FdwReserved1;
    property dwReserved2: DWORD read FdwReserved2 write FdwReserved2;
    property hmmio: HMMIO read Fhmmio write Fhmmio;
  end;
  
  _MMCKINFOWrapper = class(TatRecordWrapper)
  private
    Fckid: FOURCC;
    Fcksize: DWORD;
    FfccType: FOURCC;
    FdwDataOffset: DWORD;
    FdwFlags: DWORD;
  public
    constructor Create(ARecord: _MMCKINFO);
    function ObjToRec: _MMCKINFO;
  published
    property ckid: FOURCC read Fckid write Fckid;
    property cksize: DWORD read Fcksize write Fcksize;
    property fccType: FOURCC read FfccType write FfccType;
    property dwDataOffset: DWORD read FdwDataOffset write FdwDataOffset;
    property dwFlags: DWORD read FdwFlags write FdwFlags;
  end;
  
  tagMCI_GENERIC_PARMSWrapper = class(TatRecordWrapper)
  private
    FdwCallback: DWORD;
  public
    constructor Create(ARecord: tagMCI_GENERIC_PARMS);
    function ObjToRec: tagMCI_GENERIC_PARMS;
  published
    property dwCallback: DWORD read FdwCallback write FdwCallback;
  end;
  
  tagMCI_OPEN_PARMSAWrapper = class(TatRecordWrapper)
  private
    FdwCallback: DWORD;
    FwDeviceID: MCIDEVICEID;
  public
    constructor Create(ARecord: tagMCI_OPEN_PARMSA);
    function ObjToRec: tagMCI_OPEN_PARMSA;
  published
    property dwCallback: DWORD read FdwCallback write FdwCallback;
    property wDeviceID: MCIDEVICEID read FwDeviceID write FwDeviceID;
  end;
  
  tagMCI_OPEN_PARMSWWrapper = class(TatRecordWrapper)
  private
    FdwCallback: DWORD;
    FwDeviceID: MCIDEVICEID;
  public
    constructor Create(ARecord: tagMCI_OPEN_PARMSW);
    function ObjToRec: tagMCI_OPEN_PARMSW;
  published
    property dwCallback: DWORD read FdwCallback write FdwCallback;
    property wDeviceID: MCIDEVICEID read FwDeviceID write FwDeviceID;
  end;
  
  tagMCI_PLAY_PARMSWrapper = class(TatRecordWrapper)
  private
    FdwCallback: DWORD;
    FdwFrom: DWORD;
    FdwTo: DWORD;
  public
    constructor Create(ARecord: tagMCI_PLAY_PARMS);
    function ObjToRec: tagMCI_PLAY_PARMS;
  published
    property dwCallback: DWORD read FdwCallback write FdwCallback;
    property dwFrom: DWORD read FdwFrom write FdwFrom;
    property dwTo: DWORD read FdwTo write FdwTo;
  end;
  
  tagMCI_SEEK_PARMSWrapper = class(TatRecordWrapper)
  private
    FdwCallback: DWORD;
    FdwTo: DWORD;
  public
    constructor Create(ARecord: tagMCI_SEEK_PARMS);
    function ObjToRec: tagMCI_SEEK_PARMS;
  published
    property dwCallback: DWORD read FdwCallback write FdwCallback;
    property dwTo: DWORD read FdwTo write FdwTo;
  end;
  
  tagMCI_STATUS_PARMSWrapper = class(TatRecordWrapper)
  private
    FdwCallback: DWORD;
    FdwReturn: DWORD;
    FdwItem: DWORD;
    FdwTrack: DWORD;
  public
    constructor Create(ARecord: tagMCI_STATUS_PARMS);
    function ObjToRec: tagMCI_STATUS_PARMS;
  published
    property dwCallback: DWORD read FdwCallback write FdwCallback;
    property dwReturn: DWORD read FdwReturn write FdwReturn;
    property dwItem: DWORD read FdwItem write FdwItem;
    property dwTrack: DWORD read FdwTrack write FdwTrack;
  end;
  
  tagMCI_INFO_PARMSAWrapper = class(TatRecordWrapper)
  private
    FdwCallback: DWORD;
    FdwRetSize: DWORD;
  public
    constructor Create(ARecord: tagMCI_INFO_PARMSA);
    function ObjToRec: tagMCI_INFO_PARMSA;
  published
    property dwCallback: DWORD read FdwCallback write FdwCallback;
    property dwRetSize: DWORD read FdwRetSize write FdwRetSize;
  end;
  
  tagMCI_INFO_PARMSWWrapper = class(TatRecordWrapper)
  private
    FdwCallback: DWORD;
    FdwRetSize: DWORD;
  public
    constructor Create(ARecord: tagMCI_INFO_PARMSW);
    function ObjToRec: tagMCI_INFO_PARMSW;
  published
    property dwCallback: DWORD read FdwCallback write FdwCallback;
    property dwRetSize: DWORD read FdwRetSize write FdwRetSize;
  end;
  
  tagMCI_GETDEVCAPS_PARMSWrapper = class(TatRecordWrapper)
  private
    FdwCallback: DWORD;
    FdwReturn: DWORD;
    FdwItem: DWORD;
  public
    constructor Create(ARecord: tagMCI_GETDEVCAPS_PARMS);
    function ObjToRec: tagMCI_GETDEVCAPS_PARMS;
  published
    property dwCallback: DWORD read FdwCallback write FdwCallback;
    property dwReturn: DWORD read FdwReturn write FdwReturn;
    property dwItem: DWORD read FdwItem write FdwItem;
  end;
  
  tagMCI_SYSINFO_PARMSAWrapper = class(TatRecordWrapper)
  private
    FdwCallback: DWORD;
    FdwRetSize: DWORD;
    FdwNumber: DWORD;
    FwDeviceType: UINT;
  public
    constructor Create(ARecord: tagMCI_SYSINFO_PARMSA);
    function ObjToRec: tagMCI_SYSINFO_PARMSA;
  published
    property dwCallback: DWORD read FdwCallback write FdwCallback;
    property dwRetSize: DWORD read FdwRetSize write FdwRetSize;
    property dwNumber: DWORD read FdwNumber write FdwNumber;
    property wDeviceType: UINT read FwDeviceType write FwDeviceType;
  end;
  
  tagMCI_SYSINFO_PARMSWWrapper = class(TatRecordWrapper)
  private
    FdwCallback: DWORD;
    FdwRetSize: DWORD;
    FdwNumber: DWORD;
    FwDeviceType: UINT;
  public
    constructor Create(ARecord: tagMCI_SYSINFO_PARMSW);
    function ObjToRec: tagMCI_SYSINFO_PARMSW;
  published
    property dwCallback: DWORD read FdwCallback write FdwCallback;
    property dwRetSize: DWORD read FdwRetSize write FdwRetSize;
    property dwNumber: DWORD read FdwNumber write FdwNumber;
    property wDeviceType: UINT read FwDeviceType write FwDeviceType;
  end;
  
  tagMCI_SET_PARMSWrapper = class(TatRecordWrapper)
  private
    FdwCallback: DWORD;
    FdwTimeFormat: DWORD;
    FdwAudio: DWORD;
  public
    constructor Create(ARecord: tagMCI_SET_PARMS);
    function ObjToRec: tagMCI_SET_PARMS;
  published
    property dwCallback: DWORD read FdwCallback write FdwCallback;
    property dwTimeFormat: DWORD read FdwTimeFormat write FdwTimeFormat;
    property dwAudio: DWORD read FdwAudio write FdwAudio;
  end;
  
  tagMCI_BREAK_PARMSWrapper = class(TatRecordWrapper)
  private
    FdwCallback: DWORD;
    FnVirtKey: Integer;
    FhWndBreak: HWND;
  public
    constructor Create(ARecord: tagMCI_BREAK_PARMS);
    function ObjToRec: tagMCI_BREAK_PARMS;
  published
    property dwCallback: DWORD read FdwCallback write FdwCallback;
    property nVirtKey: Integer read FnVirtKey write FnVirtKey;
    property hWndBreak: HWND read FhWndBreak write FhWndBreak;
  end;
  
  TMCI_Sound_ParmsWrapper = class(TatRecordWrapper)
  private
    FdwCallback: Longint;
  public
    constructor Create(ARecord: TMCI_Sound_Parms);
    function ObjToRec: TMCI_Sound_Parms;
  published
    property dwCallback: Longint read FdwCallback write FdwCallback;
  end;
  
  MCI_SAVE_PARMSAWrapper = class(TatRecordWrapper)
  private
    FdwCallback: DWORD;
  public
    constructor Create(ARecord: MCI_SAVE_PARMSA);
    function ObjToRec: MCI_SAVE_PARMSA;
  published
    property dwCallback: DWORD read FdwCallback write FdwCallback;
  end;
  
  MCI_SAVE_PARMSWWrapper = class(TatRecordWrapper)
  private
    FdwCallback: DWORD;
  public
    constructor Create(ARecord: MCI_SAVE_PARMSW);
    function ObjToRec: MCI_SAVE_PARMSW;
  published
    property dwCallback: DWORD read FdwCallback write FdwCallback;
  end;
  
  tagMCI_LOAD_PARMSAWrapper = class(TatRecordWrapper)
  private
    FdwCallback: DWORD;
  public
    constructor Create(ARecord: tagMCI_LOAD_PARMSA);
    function ObjToRec: tagMCI_LOAD_PARMSA;
  published
    property dwCallback: DWORD read FdwCallback write FdwCallback;
  end;
  
  tagMCI_LOAD_PARMSWWrapper = class(TatRecordWrapper)
  private
    FdwCallback: DWORD;
  public
    constructor Create(ARecord: tagMCI_LOAD_PARMSW);
    function ObjToRec: tagMCI_LOAD_PARMSW;
  published
    property dwCallback: DWORD read FdwCallback write FdwCallback;
  end;
  
  tagMCI_RECORD_PARMSWrapper = class(TatRecordWrapper)
  private
    FdwCallback: DWORD;
    FdwFrom: DWORD;
    FdwTo: DWORD;
  public
    constructor Create(ARecord: tagMCI_RECORD_PARMS);
    function ObjToRec: tagMCI_RECORD_PARMS;
  published
    property dwCallback: DWORD read FdwCallback write FdwCallback;
    property dwFrom: DWORD read FdwFrom write FdwFrom;
    property dwTo: DWORD read FdwTo write FdwTo;
  end;
  
  tagMCI_VD_PLAY_PARMSWrapper = class(TatRecordWrapper)
  private
    FdwCallback: DWORD;
    FdwFrom: DWORD;
    FdwTo: DWORD;
    FdwSpeed: DWORD;
  public
    constructor Create(ARecord: tagMCI_VD_PLAY_PARMS);
    function ObjToRec: tagMCI_VD_PLAY_PARMS;
  published
    property dwCallback: DWORD read FdwCallback write FdwCallback;
    property dwFrom: DWORD read FdwFrom write FdwFrom;
    property dwTo: DWORD read FdwTo write FdwTo;
    property dwSpeed: DWORD read FdwSpeed write FdwSpeed;
  end;
  
  tagMCI_VD_STEP_PARMSWrapper = class(TatRecordWrapper)
  private
    FdwCallback: DWORD;
    FdwFrames: DWORD;
  public
    constructor Create(ARecord: tagMCI_VD_STEP_PARMS);
    function ObjToRec: tagMCI_VD_STEP_PARMS;
  published
    property dwCallback: DWORD read FdwCallback write FdwCallback;
    property dwFrames: DWORD read FdwFrames write FdwFrames;
  end;
  
  tagMCI_VD_ESCAPE_PARMSAWrapper = class(TatRecordWrapper)
  private
    FdwCallback: DWORD;
  public
    constructor Create(ARecord: tagMCI_VD_ESCAPE_PARMSA);
    function ObjToRec: tagMCI_VD_ESCAPE_PARMSA;
  published
    property dwCallback: DWORD read FdwCallback write FdwCallback;
  end;
  
  tagMCI_VD_ESCAPE_PARMSWWrapper = class(TatRecordWrapper)
  private
    FdwCallback: DWORD;
  public
    constructor Create(ARecord: tagMCI_VD_ESCAPE_PARMSW);
    function ObjToRec: tagMCI_VD_ESCAPE_PARMSW;
  published
    property dwCallback: DWORD read FdwCallback write FdwCallback;
  end;
  
  tagMCI_WAVE_OPEN_PARMSAWrapper = class(TatRecordWrapper)
  private
    FdwCallback: DWORD;
    FwDeviceID: MCIDEVICEID;
    FdwBufferSeconds: DWORD;
  public
    constructor Create(ARecord: tagMCI_WAVE_OPEN_PARMSA);
    function ObjToRec: tagMCI_WAVE_OPEN_PARMSA;
  published
    property dwCallback: DWORD read FdwCallback write FdwCallback;
    property wDeviceID: MCIDEVICEID read FwDeviceID write FwDeviceID;
    property dwBufferSeconds: DWORD read FdwBufferSeconds write FdwBufferSeconds;
  end;
  
  tagMCI_WAVE_OPEN_PARMSWWrapper = class(TatRecordWrapper)
  private
    FdwCallback: DWORD;
    FwDeviceID: MCIDEVICEID;
    FdwBufferSeconds: DWORD;
  public
    constructor Create(ARecord: tagMCI_WAVE_OPEN_PARMSW);
    function ObjToRec: tagMCI_WAVE_OPEN_PARMSW;
  published
    property dwCallback: DWORD read FdwCallback write FdwCallback;
    property wDeviceID: MCIDEVICEID read FwDeviceID write FwDeviceID;
    property dwBufferSeconds: DWORD read FdwBufferSeconds write FdwBufferSeconds;
  end;
  
  tagMCI_WAVE_DELETE_PARMSWrapper = class(TatRecordWrapper)
  private
    FdwCallback: DWORD;
    FdwFrom: DWORD;
    FdwTo: DWORD;
  public
    constructor Create(ARecord: tagMCI_WAVE_DELETE_PARMS);
    function ObjToRec: tagMCI_WAVE_DELETE_PARMS;
  published
    property dwCallback: DWORD read FdwCallback write FdwCallback;
    property dwFrom: DWORD read FdwFrom write FdwFrom;
    property dwTo: DWORD read FdwTo write FdwTo;
  end;
  
  tagMCI_WAVE_SET_PARMSWrapper = class(TatRecordWrapper)
  private
    FdwCallback: DWORD;
    FdwTimeFormat: DWORD;
    FdwAudio: DWORD;
    FwInput: UINT;
    FwOutput: UINT;
    FwFormatTag: Word;
    FwReserved2: Word;
    FnChannels: Word;
    FwReserved3: Word;
    FnSamplesPerSec: DWORD;
    FnAvgBytesPerSec: DWORD;
    FnBlockAlign: Word;
    FwReserved4: Word;
    FwBitsPerSample: Word;
    FwReserved5: Word;
  public
    constructor Create(ARecord: tagMCI_WAVE_SET_PARMS);
    function ObjToRec: tagMCI_WAVE_SET_PARMS;
  published
    property dwCallback: DWORD read FdwCallback write FdwCallback;
    property dwTimeFormat: DWORD read FdwTimeFormat write FdwTimeFormat;
    property dwAudio: DWORD read FdwAudio write FdwAudio;
    property wInput: UINT read FwInput write FwInput;
    property wOutput: UINT read FwOutput write FwOutput;
    property wFormatTag: Word read FwFormatTag write FwFormatTag;
    property wReserved2: Word read FwReserved2 write FwReserved2;
    property nChannels: Word read FnChannels write FnChannels;
    property wReserved3: Word read FwReserved3 write FwReserved3;
    property nSamplesPerSec: DWORD read FnSamplesPerSec write FnSamplesPerSec;
    property nAvgBytesPerSec: DWORD read FnAvgBytesPerSec write FnAvgBytesPerSec;
    property nBlockAlign: Word read FnBlockAlign write FnBlockAlign;
    property wReserved4: Word read FwReserved4 write FwReserved4;
    property wBitsPerSample: Word read FwBitsPerSample write FwBitsPerSample;
    property wReserved5: Word read FwReserved5 write FwReserved5;
  end;
  
  tagMCI_SEQ_SET_PARMSWrapper = class(TatRecordWrapper)
  private
    FdwCallback: DWORD;
    FdwTimeFormat: DWORD;
    FdwAudio: DWORD;
    FdwTempo: DWORD;
    FdwPort: DWORD;
    FdwSlave: DWORD;
    FdwMaster: DWORD;
    FdwOffset: DWORD;
  public
    constructor Create(ARecord: tagMCI_SEQ_SET_PARMS);
    function ObjToRec: tagMCI_SEQ_SET_PARMS;
  published
    property dwCallback: DWORD read FdwCallback write FdwCallback;
    property dwTimeFormat: DWORD read FdwTimeFormat write FdwTimeFormat;
    property dwAudio: DWORD read FdwAudio write FdwAudio;
    property dwTempo: DWORD read FdwTempo write FdwTempo;
    property dwPort: DWORD read FdwPort write FdwPort;
    property dwSlave: DWORD read FdwSlave write FdwSlave;
    property dwMaster: DWORD read FdwMaster write FdwMaster;
    property dwOffset: DWORD read FdwOffset write FdwOffset;
  end;
  
  tagMCI_ANIM_OPEN_PARMSAWrapper = class(TatRecordWrapper)
  private
    FdwCallback: DWORD;
    FwDeviceID: MCIDEVICEID;
    FdwStyle: DWORD;
    FhWndParent: HWND;
  public
    constructor Create(ARecord: tagMCI_ANIM_OPEN_PARMSA);
    function ObjToRec: tagMCI_ANIM_OPEN_PARMSA;
  published
    property dwCallback: DWORD read FdwCallback write FdwCallback;
    property wDeviceID: MCIDEVICEID read FwDeviceID write FwDeviceID;
    property dwStyle: DWORD read FdwStyle write FdwStyle;
    property hWndParent: HWND read FhWndParent write FhWndParent;
  end;
  
  tagMCI_ANIM_OPEN_PARMSWWrapper = class(TatRecordWrapper)
  private
    FdwCallback: DWORD;
    FwDeviceID: MCIDEVICEID;
    FdwStyle: DWORD;
    FhWndParent: HWND;
  public
    constructor Create(ARecord: tagMCI_ANIM_OPEN_PARMSW);
    function ObjToRec: tagMCI_ANIM_OPEN_PARMSW;
  published
    property dwCallback: DWORD read FdwCallback write FdwCallback;
    property wDeviceID: MCIDEVICEID read FwDeviceID write FwDeviceID;
    property dwStyle: DWORD read FdwStyle write FdwStyle;
    property hWndParent: HWND read FhWndParent write FhWndParent;
  end;
  
  tagMCI_ANIM_PLAY_PARMSWrapper = class(TatRecordWrapper)
  private
    FdwCallback: DWORD;
    FdwFrom: DWORD;
    FdwTo: DWORD;
    FdwSpeed: DWORD;
  public
    constructor Create(ARecord: tagMCI_ANIM_PLAY_PARMS);
    function ObjToRec: tagMCI_ANIM_PLAY_PARMS;
  published
    property dwCallback: DWORD read FdwCallback write FdwCallback;
    property dwFrom: DWORD read FdwFrom write FdwFrom;
    property dwTo: DWORD read FdwTo write FdwTo;
    property dwSpeed: DWORD read FdwSpeed write FdwSpeed;
  end;
  
  tagMCI_ANIM_STEP_PARMSWrapper = class(TatRecordWrapper)
  private
    FdwCallback: DWORD;
    FdwFrames: DWORD;
  public
    constructor Create(ARecord: tagMCI_ANIM_STEP_PARMS);
    function ObjToRec: tagMCI_ANIM_STEP_PARMS;
  published
    property dwCallback: DWORD read FdwCallback write FdwCallback;
    property dwFrames: DWORD read FdwFrames write FdwFrames;
  end;
  
  tagMCI_ANIM_WINDOW_PARMSAWrapper = class(TatRecordWrapper)
  private
    FdwCallback: DWORD;
    FWnd: HWND;
    FnCmdShow: UINT;
  public
    constructor Create(ARecord: tagMCI_ANIM_WINDOW_PARMSA);
    function ObjToRec: tagMCI_ANIM_WINDOW_PARMSA;
  published
    property dwCallback: DWORD read FdwCallback write FdwCallback;
    property Wnd: HWND read FWnd write FWnd;
    property nCmdShow: UINT read FnCmdShow write FnCmdShow;
  end;
  
  tagMCI_ANIM_WINDOW_PARMSWWrapper = class(TatRecordWrapper)
  private
    FdwCallback: DWORD;
    FWnd: HWND;
    FnCmdShow: UINT;
  public
    constructor Create(ARecord: tagMCI_ANIM_WINDOW_PARMSW);
    function ObjToRec: tagMCI_ANIM_WINDOW_PARMSW;
  published
    property dwCallback: DWORD read FdwCallback write FdwCallback;
    property Wnd: HWND read FWnd write FWnd;
    property nCmdShow: UINT read FnCmdShow write FnCmdShow;
  end;
  
  tagMCI_ANIM_RECT_PARMSWrapper = class(TatRecordWrapper)
  private
    FdwCallback: DWORD;
  public
    constructor Create(ARecord: tagMCI_ANIM_RECT_PARMS);
    function ObjToRec: tagMCI_ANIM_RECT_PARMS;
  published
    property dwCallback: DWORD read FdwCallback write FdwCallback;
  end;
  
  tagMCI_ANIM_UPDATE_PARMSWrapper = class(TatRecordWrapper)
  private
    FdwCallback: DWORD;
    FhDC: HDC;
  public
    constructor Create(ARecord: tagMCI_ANIM_UPDATE_PARMS);
    function ObjToRec: tagMCI_ANIM_UPDATE_PARMS;
  published
    property dwCallback: DWORD read FdwCallback write FdwCallback;
    property hDC: HDC read FhDC write FhDC;
  end;
  
  tagMCI_OVLY_OPEN_PARMSAWrapper = class(TatRecordWrapper)
  private
    FdwCallback: DWORD;
    FwDeviceID: MCIDEVICEID;
    FdwStyle: DWORD;
    FhWndParent: HWND;
  public
    constructor Create(ARecord: tagMCI_OVLY_OPEN_PARMSA);
    function ObjToRec: tagMCI_OVLY_OPEN_PARMSA;
  published
    property dwCallback: DWORD read FdwCallback write FdwCallback;
    property wDeviceID: MCIDEVICEID read FwDeviceID write FwDeviceID;
    property dwStyle: DWORD read FdwStyle write FdwStyle;
    property hWndParent: HWND read FhWndParent write FhWndParent;
  end;
  
  tagMCI_OVLY_OPEN_PARMSWWrapper = class(TatRecordWrapper)
  private
    FdwCallback: DWORD;
    FwDeviceID: MCIDEVICEID;
    FdwStyle: DWORD;
    FhWndParent: HWND;
  public
    constructor Create(ARecord: tagMCI_OVLY_OPEN_PARMSW);
    function ObjToRec: tagMCI_OVLY_OPEN_PARMSW;
  published
    property dwCallback: DWORD read FdwCallback write FdwCallback;
    property wDeviceID: MCIDEVICEID read FwDeviceID write FwDeviceID;
    property dwStyle: DWORD read FdwStyle write FdwStyle;
    property hWndParent: HWND read FhWndParent write FhWndParent;
  end;
  
  tagMCI_OVLY_WINDOW_PARMSAWrapper = class(TatRecordWrapper)
  private
    FdwCallback: DWORD;
    FWHandle: HWND;
    FnCmdShow: UINT;
  public
    constructor Create(ARecord: tagMCI_OVLY_WINDOW_PARMSA);
    function ObjToRec: tagMCI_OVLY_WINDOW_PARMSA;
  published
    property dwCallback: DWORD read FdwCallback write FdwCallback;
    property WHandle: HWND read FWHandle write FWHandle;
    property nCmdShow: UINT read FnCmdShow write FnCmdShow;
  end;
  
  tagMCI_OVLY_WINDOW_PARMSWWrapper = class(TatRecordWrapper)
  private
    FdwCallback: DWORD;
    FWHandle: HWND;
    FnCmdShow: UINT;
  public
    constructor Create(ARecord: tagMCI_OVLY_WINDOW_PARMSW);
    function ObjToRec: tagMCI_OVLY_WINDOW_PARMSW;
  published
    property dwCallback: DWORD read FdwCallback write FdwCallback;
    property WHandle: HWND read FWHandle write FWHandle;
    property nCmdShow: UINT read FnCmdShow write FnCmdShow;
  end;
  
  tagMCI_OVLY_RECT_PARMSWrapper = class(TatRecordWrapper)
  private
    FdwCallback: DWORD;
  public
    constructor Create(ARecord: tagMCI_OVLY_RECT_PARMS);
    function ObjToRec: tagMCI_OVLY_RECT_PARMS;
  published
    property dwCallback: DWORD read FdwCallback write FdwCallback;
  end;
  
  tagMCI_OVLY_SAVE_PARMSAWrapper = class(TatRecordWrapper)
  private
    FdwCallback: DWORD;
  public
    constructor Create(ARecord: tagMCI_OVLY_SAVE_PARMSA);
    function ObjToRec: tagMCI_OVLY_SAVE_PARMSA;
  published
    property dwCallback: DWORD read FdwCallback write FdwCallback;
  end;
  
  tagMCI_OVLY_SAVE_PARMSWWrapper = class(TatRecordWrapper)
  private
    FdwCallback: DWORD;
  public
    constructor Create(ARecord: tagMCI_OVLY_SAVE_PARMSW);
    function ObjToRec: tagMCI_OVLY_SAVE_PARMSW;
  published
    property dwCallback: DWORD read FdwCallback write FdwCallback;
  end;
  
  tagMCI_OVLY_LOAD_PARMSAWrapper = class(TatRecordWrapper)
  private
    FdwCallback: DWORD;
  public
    constructor Create(ARecord: tagMCI_OVLY_LOAD_PARMSA);
    function ObjToRec: tagMCI_OVLY_LOAD_PARMSA;
  published
    property dwCallback: DWORD read FdwCallback write FdwCallback;
  end;
  
  tagMCI_OVLY_LOAD_PARMSWWrapper = class(TatRecordWrapper)
  private
    FdwCallback: DWORD;
  public
    constructor Create(ARecord: tagMCI_OVLY_LOAD_PARMSW);
    function ObjToRec: tagMCI_OVLY_LOAD_PARMSW;
  published
    property dwCallback: DWORD read FdwCallback write FdwCallback;
  end;
  

implementation

constructor mmtime_tagWrapper.Create(ARecord: mmtime_tag);
begin
  inherited Create;
  Fms := ARecord.ms;
  Fsample := ARecord.sample;
  Fcb := ARecord.cb;
  Fticks := ARecord.ticks;
  Fhour := ARecord.hour;
  Fmin := ARecord.min;
  Fsec := ARecord.sec;
  Fframe := ARecord.frame;
  Ffps := ARecord.fps;
  Fdummy := ARecord.dummy;
  Fsongptrpos := ARecord.songptrpos;
end;

function mmtime_tagWrapper.ObjToRec: mmtime_tag;
begin
  result.ms := Fms;
  result.sample := Fsample;
  result.cb := Fcb;
  result.ticks := Fticks;
  result.hour := Fhour;
  result.min := Fmin;
  result.sec := Fsec;
  result.frame := Fframe;
  result.fps := Ffps;
  result.dummy := Fdummy;
  result.songptrpos := Fsongptrpos;
end;

constructor DRVCONFIGINFOEXWrapper.Create(ARecord: DRVCONFIGINFOEX);
begin
  inherited Create;
  FdwDCISize := ARecord.dwDCISize;
  FdnDevNode := ARecord.dnDevNode;
end;

function DRVCONFIGINFOEXWrapper.ObjToRec: DRVCONFIGINFOEX;
begin
  result.dwDCISize := FdwDCISize;
  result.dnDevNode := FdnDevNode;
end;

constructor tagDRVCONFIGINFOWrapper.Create(ARecord: tagDRVCONFIGINFO);
begin
  inherited Create;
  FdwDCISize := ARecord.dwDCISize;
end;

function tagDRVCONFIGINFOWrapper.ObjToRec: tagDRVCONFIGINFO;
begin
  result.dwDCISize := FdwDCISize;
end;

constructor wavehdr_tagWrapper.Create(ARecord: wavehdr_tag);
begin
  inherited Create;
  FdwBufferLength := ARecord.dwBufferLength;
  FdwBytesRecorded := ARecord.dwBytesRecorded;
  FdwUser := ARecord.dwUser;
  FdwFlags := ARecord.dwFlags;
  FdwLoops := ARecord.dwLoops;
  Freserved := ARecord.reserved;
end;

function wavehdr_tagWrapper.ObjToRec: wavehdr_tag;
begin
  result.dwBufferLength := FdwBufferLength;
  result.dwBytesRecorded := FdwBytesRecorded;
  result.dwUser := FdwUser;
  result.dwFlags := FdwFlags;
  result.dwLoops := FdwLoops;
  result.reserved := Freserved;
end;

constructor tagWAVEOUTCAPSAWrapper.Create(ARecord: tagWAVEOUTCAPSA);
begin
  inherited Create;
  FwMid := ARecord.wMid;
  FwPid := ARecord.wPid;
  FvDriverVersion := ARecord.vDriverVersion;
  FdwFormats := ARecord.dwFormats;
  FwChannels := ARecord.wChannels;
  FdwSupport := ARecord.dwSupport;
end;

function tagWAVEOUTCAPSAWrapper.ObjToRec: tagWAVEOUTCAPSA;
begin
  result.wMid := FwMid;
  result.wPid := FwPid;
  result.vDriverVersion := FvDriverVersion;
  result.dwFormats := FdwFormats;
  result.wChannels := FwChannels;
  result.dwSupport := FdwSupport;
end;

constructor tagWAVEOUTCAPSWWrapper.Create(ARecord: tagWAVEOUTCAPSW);
begin
  inherited Create;
  FwMid := ARecord.wMid;
  FwPid := ARecord.wPid;
  FvDriverVersion := ARecord.vDriverVersion;
  FdwFormats := ARecord.dwFormats;
  FwChannels := ARecord.wChannels;
  FdwSupport := ARecord.dwSupport;
end;

function tagWAVEOUTCAPSWWrapper.ObjToRec: tagWAVEOUTCAPSW;
begin
  result.wMid := FwMid;
  result.wPid := FwPid;
  result.vDriverVersion := FvDriverVersion;
  result.dwFormats := FdwFormats;
  result.wChannels := FwChannels;
  result.dwSupport := FdwSupport;
end;

constructor tagWAVEINCAPSAWrapper.Create(ARecord: tagWAVEINCAPSA);
begin
  inherited Create;
  FwMid := ARecord.wMid;
  FwPid := ARecord.wPid;
  FvDriverVersion := ARecord.vDriverVersion;
  FdwFormats := ARecord.dwFormats;
  FwChannels := ARecord.wChannels;
  FwReserved1 := ARecord.wReserved1;
end;

function tagWAVEINCAPSAWrapper.ObjToRec: tagWAVEINCAPSA;
begin
  result.wMid := FwMid;
  result.wPid := FwPid;
  result.vDriverVersion := FvDriverVersion;
  result.dwFormats := FdwFormats;
  result.wChannels := FwChannels;
  result.wReserved1 := FwReserved1;
end;

constructor tagWAVEINCAPSWWrapper.Create(ARecord: tagWAVEINCAPSW);
begin
  inherited Create;
  FwMid := ARecord.wMid;
  FwPid := ARecord.wPid;
  FvDriverVersion := ARecord.vDriverVersion;
  FdwFormats := ARecord.dwFormats;
  FwChannels := ARecord.wChannels;
  FwReserved1 := ARecord.wReserved1;
end;

function tagWAVEINCAPSWWrapper.ObjToRec: tagWAVEINCAPSW;
begin
  result.wMid := FwMid;
  result.wPid := FwPid;
  result.vDriverVersion := FvDriverVersion;
  result.dwFormats := FdwFormats;
  result.wChannels := FwChannels;
  result.wReserved1 := FwReserved1;
end;

constructor waveformat_tagWrapper.Create(ARecord: waveformat_tag);
begin
  inherited Create;
  FwFormatTag := ARecord.wFormatTag;
  FnChannels := ARecord.nChannels;
  FnSamplesPerSec := ARecord.nSamplesPerSec;
  FnAvgBytesPerSec := ARecord.nAvgBytesPerSec;
  FnBlockAlign := ARecord.nBlockAlign;
end;

function waveformat_tagWrapper.ObjToRec: waveformat_tag;
begin
  result.wFormatTag := FwFormatTag;
  result.nChannels := FnChannels;
  result.nSamplesPerSec := FnSamplesPerSec;
  result.nAvgBytesPerSec := FnAvgBytesPerSec;
  result.nBlockAlign := FnBlockAlign;
end;

constructor pcmwaveformat_tagWrapper.Create(ARecord: pcmwaveformat_tag);
begin
  inherited Create;
  FwBitsPerSample := ARecord.wBitsPerSample;
end;

function pcmwaveformat_tagWrapper.ObjToRec: pcmwaveformat_tag;
begin
  result.wBitsPerSample := FwBitsPerSample;
end;

constructor tWAVEFORMATEXWrapper.Create(ARecord: tWAVEFORMATEX);
begin
  inherited Create;
  FwFormatTag := ARecord.wFormatTag;
  FnChannels := ARecord.nChannels;
  FnSamplesPerSec := ARecord.nSamplesPerSec;
  FnAvgBytesPerSec := ARecord.nAvgBytesPerSec;
  FnBlockAlign := ARecord.nBlockAlign;
  FwBitsPerSample := ARecord.wBitsPerSample;
  FcbSize := ARecord.cbSize;
end;

function tWAVEFORMATEXWrapper.ObjToRec: tWAVEFORMATEX;
begin
  result.wFormatTag := FwFormatTag;
  result.nChannels := FnChannels;
  result.nSamplesPerSec := FnSamplesPerSec;
  result.nAvgBytesPerSec := FnAvgBytesPerSec;
  result.nBlockAlign := FnBlockAlign;
  result.wBitsPerSample := FwBitsPerSample;
  result.cbSize := FcbSize;
end;

constructor tagMIDIOUTCAPSAWrapper.Create(ARecord: tagMIDIOUTCAPSA);
begin
  inherited Create;
  FwMid := ARecord.wMid;
  FwPid := ARecord.wPid;
  FvDriverVersion := ARecord.vDriverVersion;
  FwTechnology := ARecord.wTechnology;
  FwVoices := ARecord.wVoices;
  FwNotes := ARecord.wNotes;
  FwChannelMask := ARecord.wChannelMask;
  FdwSupport := ARecord.dwSupport;
end;

function tagMIDIOUTCAPSAWrapper.ObjToRec: tagMIDIOUTCAPSA;
begin
  result.wMid := FwMid;
  result.wPid := FwPid;
  result.vDriverVersion := FvDriverVersion;
  result.wTechnology := FwTechnology;
  result.wVoices := FwVoices;
  result.wNotes := FwNotes;
  result.wChannelMask := FwChannelMask;
  result.dwSupport := FdwSupport;
end;

constructor tagMIDIOUTCAPSWWrapper.Create(ARecord: tagMIDIOUTCAPSW);
begin
  inherited Create;
  FwMid := ARecord.wMid;
  FwPid := ARecord.wPid;
  FvDriverVersion := ARecord.vDriverVersion;
  FwTechnology := ARecord.wTechnology;
  FwVoices := ARecord.wVoices;
  FwNotes := ARecord.wNotes;
  FwChannelMask := ARecord.wChannelMask;
  FdwSupport := ARecord.dwSupport;
end;

function tagMIDIOUTCAPSWWrapper.ObjToRec: tagMIDIOUTCAPSW;
begin
  result.wMid := FwMid;
  result.wPid := FwPid;
  result.vDriverVersion := FvDriverVersion;
  result.wTechnology := FwTechnology;
  result.wVoices := FwVoices;
  result.wNotes := FwNotes;
  result.wChannelMask := FwChannelMask;
  result.dwSupport := FdwSupport;
end;

constructor tagMIDIINCAPSAWrapper.Create(ARecord: tagMIDIINCAPSA);
begin
  inherited Create;
  FwMid := ARecord.wMid;
  FwPid := ARecord.wPid;
  FvDriverVersion := ARecord.vDriverVersion;
  FdwSupport := ARecord.dwSupport;
end;

function tagMIDIINCAPSAWrapper.ObjToRec: tagMIDIINCAPSA;
begin
  result.wMid := FwMid;
  result.wPid := FwPid;
  result.vDriverVersion := FvDriverVersion;
  result.dwSupport := FdwSupport;
end;

constructor tagMIDIINCAPSWWrapper.Create(ARecord: tagMIDIINCAPSW);
begin
  inherited Create;
  FwMid := ARecord.wMid;
  FwPid := ARecord.wPid;
  FvDriverVersion := ARecord.vDriverVersion;
  FdwSupport := ARecord.dwSupport;
end;

function tagMIDIINCAPSWWrapper.ObjToRec: tagMIDIINCAPSW;
begin
  result.wMid := FwMid;
  result.wPid := FwPid;
  result.vDriverVersion := FvDriverVersion;
  result.dwSupport := FdwSupport;
end;

constructor midihdr_tagWrapper.Create(ARecord: midihdr_tag);
begin
  inherited Create;
  FdwBufferLength := ARecord.dwBufferLength;
  FdwBytesRecorded := ARecord.dwBytesRecorded;
  FdwUser := ARecord.dwUser;
  FdwFlags := ARecord.dwFlags;
  Freserved := ARecord.reserved;
  FdwOffset := ARecord.dwOffset;
end;

function midihdr_tagWrapper.ObjToRec: midihdr_tag;
begin
  result.dwBufferLength := FdwBufferLength;
  result.dwBytesRecorded := FdwBytesRecorded;
  result.dwUser := FdwUser;
  result.dwFlags := FdwFlags;
  result.reserved := Freserved;
  result.dwOffset := FdwOffset;
end;

constructor midievent_tagWrapper.Create(ARecord: midievent_tag);
begin
  inherited Create;
  FdwDeltaTime := ARecord.dwDeltaTime;
  FdwStreamID := ARecord.dwStreamID;
  FdwEvent := ARecord.dwEvent;
end;

function midievent_tagWrapper.ObjToRec: midievent_tag;
begin
  result.dwDeltaTime := FdwDeltaTime;
  result.dwStreamID := FdwStreamID;
  result.dwEvent := FdwEvent;
end;

constructor midistrmbuffver_tagWrapper.Create(ARecord: midistrmbuffver_tag);
begin
  inherited Create;
  FdwVersion := ARecord.dwVersion;
  FdwMid := ARecord.dwMid;
  FdwOEMVersion := ARecord.dwOEMVersion;
end;

function midistrmbuffver_tagWrapper.ObjToRec: midistrmbuffver_tag;
begin
  result.dwVersion := FdwVersion;
  result.dwMid := FdwMid;
  result.dwOEMVersion := FdwOEMVersion;
end;

constructor midiproptimediv_tagWrapper.Create(ARecord: midiproptimediv_tag);
begin
  inherited Create;
  FcbStruct := ARecord.cbStruct;
  FdwTimeDiv := ARecord.dwTimeDiv;
end;

function midiproptimediv_tagWrapper.ObjToRec: midiproptimediv_tag;
begin
  result.cbStruct := FcbStruct;
  result.dwTimeDiv := FdwTimeDiv;
end;

constructor midiproptempo_tagWrapper.Create(ARecord: midiproptempo_tag);
begin
  inherited Create;
  FcbStruct := ARecord.cbStruct;
  FdwTempo := ARecord.dwTempo;
end;

function midiproptempo_tagWrapper.ObjToRec: midiproptempo_tag;
begin
  result.cbStruct := FcbStruct;
  result.dwTempo := FdwTempo;
end;

constructor tagAUXCAPSAWrapper.Create(ARecord: tagAUXCAPSA);
begin
  inherited Create;
  FwMid := ARecord.wMid;
  FwPid := ARecord.wPid;
  FvDriverVersion := ARecord.vDriverVersion;
  FwTechnology := ARecord.wTechnology;
  FdwSupport := ARecord.dwSupport;
end;

function tagAUXCAPSAWrapper.ObjToRec: tagAUXCAPSA;
begin
  result.wMid := FwMid;
  result.wPid := FwPid;
  result.vDriverVersion := FvDriverVersion;
  result.wTechnology := FwTechnology;
  result.dwSupport := FdwSupport;
end;

constructor tagAUXCAPSWWrapper.Create(ARecord: tagAUXCAPSW);
begin
  inherited Create;
  FwMid := ARecord.wMid;
  FwPid := ARecord.wPid;
  FvDriverVersion := ARecord.vDriverVersion;
  FwTechnology := ARecord.wTechnology;
  FdwSupport := ARecord.dwSupport;
end;

function tagAUXCAPSWWrapper.ObjToRec: tagAUXCAPSW;
begin
  result.wMid := FwMid;
  result.wPid := FwPid;
  result.vDriverVersion := FvDriverVersion;
  result.wTechnology := FwTechnology;
  result.dwSupport := FdwSupport;
end;

constructor tagMIXERCAPSAWrapper.Create(ARecord: tagMIXERCAPSA);
begin
  inherited Create;
  FwMid := ARecord.wMid;
  FwPid := ARecord.wPid;
  FvDriverVersion := ARecord.vDriverVersion;
  FfdwSupport := ARecord.fdwSupport;
  FcDestinations := ARecord.cDestinations;
end;

function tagMIXERCAPSAWrapper.ObjToRec: tagMIXERCAPSA;
begin
  result.wMid := FwMid;
  result.wPid := FwPid;
  result.vDriverVersion := FvDriverVersion;
  result.fdwSupport := FfdwSupport;
  result.cDestinations := FcDestinations;
end;

constructor tagMIXERCAPSWWrapper.Create(ARecord: tagMIXERCAPSW);
begin
  inherited Create;
  FwMid := ARecord.wMid;
  FwPid := ARecord.wPid;
  FvDriverVersion := ARecord.vDriverVersion;
  FfdwSupport := ARecord.fdwSupport;
  FcDestinations := ARecord.cDestinations;
end;

function tagMIXERCAPSWWrapper.ObjToRec: tagMIXERCAPSW;
begin
  result.wMid := FwMid;
  result.wPid := FwPid;
  result.vDriverVersion := FvDriverVersion;
  result.fdwSupport := FfdwSupport;
  result.cDestinations := FcDestinations;
end;

constructor tagMIXERLINEAWrapper.Create(ARecord: tagMIXERLINEA);
begin
  inherited Create;
  FcbStruct := ARecord.cbStruct;
  FdwDestination := ARecord.dwDestination;
  FdwSource := ARecord.dwSource;
  FdwLineID := ARecord.dwLineID;
  FfdwLine := ARecord.fdwLine;
  FdwUser := ARecord.dwUser;
  FdwComponentType := ARecord.dwComponentType;
  FcChannels := ARecord.cChannels;
  FcConnections := ARecord.cConnections;
  FcControls := ARecord.cControls;
end;

function tagMIXERLINEAWrapper.ObjToRec: tagMIXERLINEA;
begin
  result.cbStruct := FcbStruct;
  result.dwDestination := FdwDestination;
  result.dwSource := FdwSource;
  result.dwLineID := FdwLineID;
  result.fdwLine := FfdwLine;
  result.dwUser := FdwUser;
  result.dwComponentType := FdwComponentType;
  result.cChannels := FcChannels;
  result.cConnections := FcConnections;
  result.cControls := FcControls;
end;

constructor tagMIXERLINEWWrapper.Create(ARecord: tagMIXERLINEW);
begin
  inherited Create;
  FcbStruct := ARecord.cbStruct;
  FdwDestination := ARecord.dwDestination;
  FdwSource := ARecord.dwSource;
  FdwLineID := ARecord.dwLineID;
  FfdwLine := ARecord.fdwLine;
  FdwUser := ARecord.dwUser;
  FdwComponentType := ARecord.dwComponentType;
  FcChannels := ARecord.cChannels;
  FcConnections := ARecord.cConnections;
  FcControls := ARecord.cControls;
end;

function tagMIXERLINEWWrapper.ObjToRec: tagMIXERLINEW;
begin
  result.cbStruct := FcbStruct;
  result.dwDestination := FdwDestination;
  result.dwSource := FdwSource;
  result.dwLineID := FdwLineID;
  result.fdwLine := FfdwLine;
  result.dwUser := FdwUser;
  result.dwComponentType := FdwComponentType;
  result.cChannels := FcChannels;
  result.cConnections := FcConnections;
  result.cControls := FcControls;
end;

constructor tagMIXERCONTROLAWrapper.Create(ARecord: tagMIXERCONTROLA);
begin
  inherited Create;
  FcbStruct := ARecord.cbStruct;
  FdwControlID := ARecord.dwControlID;
  FdwControlType := ARecord.dwControlType;
  FfdwControl := ARecord.fdwControl;
  FcMultipleItems := ARecord.cMultipleItems;
end;

function tagMIXERCONTROLAWrapper.ObjToRec: tagMIXERCONTROLA;
begin
  result.cbStruct := FcbStruct;
  result.dwControlID := FdwControlID;
  result.dwControlType := FdwControlType;
  result.fdwControl := FfdwControl;
  result.cMultipleItems := FcMultipleItems;
end;

constructor tagMIXERCONTROLWWrapper.Create(ARecord: tagMIXERCONTROLW);
begin
  inherited Create;
  FcbStruct := ARecord.cbStruct;
  FdwControlID := ARecord.dwControlID;
  FdwControlType := ARecord.dwControlType;
  FfdwControl := ARecord.fdwControl;
  FcMultipleItems := ARecord.cMultipleItems;
end;

function tagMIXERCONTROLWWrapper.ObjToRec: tagMIXERCONTROLW;
begin
  result.cbStruct := FcbStruct;
  result.dwControlID := FdwControlID;
  result.dwControlType := FdwControlType;
  result.fdwControl := FfdwControl;
  result.cMultipleItems := FcMultipleItems;
end;

constructor tagMIXERLINECONTROLSAWrapper.Create(ARecord: tagMIXERLINECONTROLSA);
begin
  inherited Create;
  FcbStruct := ARecord.cbStruct;
  FdwLineID := ARecord.dwLineID;
  FdwControlID := ARecord.dwControlID;
  FdwControlType := ARecord.dwControlType;
  FcControls := ARecord.cControls;
  Fcbmxctrl := ARecord.cbmxctrl;
end;

function tagMIXERLINECONTROLSAWrapper.ObjToRec: tagMIXERLINECONTROLSA;
begin
  result.cbStruct := FcbStruct;
  result.dwLineID := FdwLineID;
  result.dwControlID := FdwControlID;
  result.dwControlType := FdwControlType;
  result.cControls := FcControls;
  result.cbmxctrl := Fcbmxctrl;
end;

constructor tagMIXERLINECONTROLSWWrapper.Create(ARecord: tagMIXERLINECONTROLSW);
begin
  inherited Create;
  FcbStruct := ARecord.cbStruct;
  FdwLineID := ARecord.dwLineID;
  FdwControlID := ARecord.dwControlID;
  FdwControlType := ARecord.dwControlType;
  FcControls := ARecord.cControls;
  Fcbmxctrl := ARecord.cbmxctrl;
end;

function tagMIXERLINECONTROLSWWrapper.ObjToRec: tagMIXERLINECONTROLSW;
begin
  result.cbStruct := FcbStruct;
  result.dwLineID := FdwLineID;
  result.dwControlID := FdwControlID;
  result.dwControlType := FdwControlType;
  result.cControls := FcControls;
  result.cbmxctrl := Fcbmxctrl;
end;

constructor tMIXERCONTROLDETAILSWrapper.Create(ARecord: tMIXERCONTROLDETAILS);
begin
  inherited Create;
  FcbStruct := ARecord.cbStruct;
  FdwControlID := ARecord.dwControlID;
  FcChannels := ARecord.cChannels;
  FhwndOwner := ARecord.hwndOwner;
  FcMultipleItems := ARecord.cMultipleItems;
  FcbDetails := ARecord.cbDetails;
end;

function tMIXERCONTROLDETAILSWrapper.ObjToRec: tMIXERCONTROLDETAILS;
begin
  result.cbStruct := FcbStruct;
  result.dwControlID := FdwControlID;
  result.cChannels := FcChannels;
  result.hwndOwner := FhwndOwner;
  result.cMultipleItems := FcMultipleItems;
  result.cbDetails := FcbDetails;
end;

constructor tagMIXERCONTROLDETAILS_LISTTEXTAWrapper.Create(ARecord: tagMIXERCONTROLDETAILS_LISTTEXTA);
begin
  inherited Create;
  FdwParam1 := ARecord.dwParam1;
  FdwParam2 := ARecord.dwParam2;
end;

function tagMIXERCONTROLDETAILS_LISTTEXTAWrapper.ObjToRec: tagMIXERCONTROLDETAILS_LISTTEXTA;
begin
  result.dwParam1 := FdwParam1;
  result.dwParam2 := FdwParam2;
end;

constructor tagMIXERCONTROLDETAILS_LISTTEXTWWrapper.Create(ARecord: tagMIXERCONTROLDETAILS_LISTTEXTW);
begin
  inherited Create;
  FdwParam1 := ARecord.dwParam1;
  FdwParam2 := ARecord.dwParam2;
end;

function tagMIXERCONTROLDETAILS_LISTTEXTWWrapper.ObjToRec: tagMIXERCONTROLDETAILS_LISTTEXTW;
begin
  result.dwParam1 := FdwParam1;
  result.dwParam2 := FdwParam2;
end;

constructor tMIXERCONTROLDETAILS_BOOLEANWrapper.Create(ARecord: tMIXERCONTROLDETAILS_BOOLEAN);
begin
  inherited Create;
  FfValue := ARecord.fValue;
end;

function tMIXERCONTROLDETAILS_BOOLEANWrapper.ObjToRec: tMIXERCONTROLDETAILS_BOOLEAN;
begin
  result.fValue := FfValue;
end;

constructor tMIXERCONTROLDETAILS_SIGNEDWrapper.Create(ARecord: tMIXERCONTROLDETAILS_SIGNED);
begin
  inherited Create;
  FlValue := ARecord.lValue;
end;

function tMIXERCONTROLDETAILS_SIGNEDWrapper.ObjToRec: tMIXERCONTROLDETAILS_SIGNED;
begin
  result.lValue := FlValue;
end;

constructor tMIXERCONTROLDETAILS_UNSIGNEDWrapper.Create(ARecord: tMIXERCONTROLDETAILS_UNSIGNED);
begin
  inherited Create;
  FdwValue := ARecord.dwValue;
end;

function tMIXERCONTROLDETAILS_UNSIGNEDWrapper.ObjToRec: tMIXERCONTROLDETAILS_UNSIGNED;
begin
  result.dwValue := FdwValue;
end;

constructor timecaps_tagWrapper.Create(ARecord: timecaps_tag);
begin
  inherited Create;
  FwPeriodMin := ARecord.wPeriodMin;
  FwPeriodMax := ARecord.wPeriodMax;
end;

function timecaps_tagWrapper.ObjToRec: timecaps_tag;
begin
  result.wPeriodMin := FwPeriodMin;
  result.wPeriodMax := FwPeriodMax;
end;

constructor tagJOYCAPSAWrapper.Create(ARecord: tagJOYCAPSA);
begin
  inherited Create;
  FwMid := ARecord.wMid;
  FwPid := ARecord.wPid;
  FwXmin := ARecord.wXmin;
  FwXmax := ARecord.wXmax;
  FwYmin := ARecord.wYmin;
  FwYmax := ARecord.wYmax;
  FwZmin := ARecord.wZmin;
  FwZmax := ARecord.wZmax;
  FwNumButtons := ARecord.wNumButtons;
  FwPeriodMin := ARecord.wPeriodMin;
  FwPeriodMax := ARecord.wPeriodMax;
  FwRmin := ARecord.wRmin;
  FwRmax := ARecord.wRmax;
  FwUmin := ARecord.wUmin;
  FwUmax := ARecord.wUmax;
  FwVmin := ARecord.wVmin;
  FwVmax := ARecord.wVmax;
  FwCaps := ARecord.wCaps;
  FwMaxAxes := ARecord.wMaxAxes;
  FwNumAxes := ARecord.wNumAxes;
  FwMaxButtons := ARecord.wMaxButtons;
end;

function tagJOYCAPSAWrapper.ObjToRec: tagJOYCAPSA;
begin
  result.wMid := FwMid;
  result.wPid := FwPid;
  result.wXmin := FwXmin;
  result.wXmax := FwXmax;
  result.wYmin := FwYmin;
  result.wYmax := FwYmax;
  result.wZmin := FwZmin;
  result.wZmax := FwZmax;
  result.wNumButtons := FwNumButtons;
  result.wPeriodMin := FwPeriodMin;
  result.wPeriodMax := FwPeriodMax;
  result.wRmin := FwRmin;
  result.wRmax := FwRmax;
  result.wUmin := FwUmin;
  result.wUmax := FwUmax;
  result.wVmin := FwVmin;
  result.wVmax := FwVmax;
  result.wCaps := FwCaps;
  result.wMaxAxes := FwMaxAxes;
  result.wNumAxes := FwNumAxes;
  result.wMaxButtons := FwMaxButtons;
end;

constructor tagJOYCAPSWWrapper.Create(ARecord: tagJOYCAPSW);
begin
  inherited Create;
  FwMid := ARecord.wMid;
  FwPid := ARecord.wPid;
  FwXmin := ARecord.wXmin;
  FwXmax := ARecord.wXmax;
  FwYmin := ARecord.wYmin;
  FwYmax := ARecord.wYmax;
  FwZmin := ARecord.wZmin;
  FwZmax := ARecord.wZmax;
  FwNumButtons := ARecord.wNumButtons;
  FwPeriodMin := ARecord.wPeriodMin;
  FwPeriodMax := ARecord.wPeriodMax;
  FwRmin := ARecord.wRmin;
  FwRmax := ARecord.wRmax;
  FwUmin := ARecord.wUmin;
  FwUmax := ARecord.wUmax;
  FwVmin := ARecord.wVmin;
  FwVmax := ARecord.wVmax;
  FwCaps := ARecord.wCaps;
  FwMaxAxes := ARecord.wMaxAxes;
  FwNumAxes := ARecord.wNumAxes;
  FwMaxButtons := ARecord.wMaxButtons;
end;

function tagJOYCAPSWWrapper.ObjToRec: tagJOYCAPSW;
begin
  result.wMid := FwMid;
  result.wPid := FwPid;
  result.wXmin := FwXmin;
  result.wXmax := FwXmax;
  result.wYmin := FwYmin;
  result.wYmax := FwYmax;
  result.wZmin := FwZmin;
  result.wZmax := FwZmax;
  result.wNumButtons := FwNumButtons;
  result.wPeriodMin := FwPeriodMin;
  result.wPeriodMax := FwPeriodMax;
  result.wRmin := FwRmin;
  result.wRmax := FwRmax;
  result.wUmin := FwUmin;
  result.wUmax := FwUmax;
  result.wVmin := FwVmin;
  result.wVmax := FwVmax;
  result.wCaps := FwCaps;
  result.wMaxAxes := FwMaxAxes;
  result.wNumAxes := FwNumAxes;
  result.wMaxButtons := FwMaxButtons;
end;

constructor joyinfo_tagWrapper.Create(ARecord: joyinfo_tag);
begin
  inherited Create;
  FwXpos := ARecord.wXpos;
  FwYpos := ARecord.wYpos;
  FwZpos := ARecord.wZpos;
  FwButtons := ARecord.wButtons;
end;

function joyinfo_tagWrapper.ObjToRec: joyinfo_tag;
begin
  result.wXpos := FwXpos;
  result.wYpos := FwYpos;
  result.wZpos := FwZpos;
  result.wButtons := FwButtons;
end;

constructor joyinfoex_tagWrapper.Create(ARecord: joyinfoex_tag);
begin
  inherited Create;
  FdwSize := ARecord.dwSize;
  FdwFlags := ARecord.dwFlags;
  FwXpos := ARecord.wXpos;
  FwYpos := ARecord.wYpos;
  FwZpos := ARecord.wZpos;
  FdwRpos := ARecord.dwRpos;
  FdwUpos := ARecord.dwUpos;
  FdwVpos := ARecord.dwVpos;
  FwButtons := ARecord.wButtons;
  FdwButtonNumber := ARecord.dwButtonNumber;
  FdwPOV := ARecord.dwPOV;
  FdwReserved1 := ARecord.dwReserved1;
  FdwReserved2 := ARecord.dwReserved2;
end;

function joyinfoex_tagWrapper.ObjToRec: joyinfoex_tag;
begin
  result.dwSize := FdwSize;
  result.dwFlags := FdwFlags;
  result.wXpos := FwXpos;
  result.wYpos := FwYpos;
  result.wZpos := FwZpos;
  result.dwRpos := FdwRpos;
  result.dwUpos := FdwUpos;
  result.dwVpos := FdwVpos;
  result.wButtons := FwButtons;
  result.dwButtonNumber := FdwButtonNumber;
  result.dwPOV := FdwPOV;
  result.dwReserved1 := FdwReserved1;
  result.dwReserved2 := FdwReserved2;
end;

constructor _MMIOINFOWrapper.Create(ARecord: _MMIOINFO);
begin
  inherited Create;
  FdwFlags := ARecord.dwFlags;
  FfccIOProc := ARecord.fccIOProc;
  FwErrorRet := ARecord.wErrorRet;
  FhTask := ARecord.hTask;
  FcchBuffer := ARecord.cchBuffer;
  FlBufOffset := ARecord.lBufOffset;
  FlDiskOffset := ARecord.lDiskOffset;
  FdwReserved1 := ARecord.dwReserved1;
  FdwReserved2 := ARecord.dwReserved2;
  Fhmmio := ARecord.hmmio;
end;

function _MMIOINFOWrapper.ObjToRec: _MMIOINFO;
begin
  result.dwFlags := FdwFlags;
  result.fccIOProc := FfccIOProc;
  result.wErrorRet := FwErrorRet;
  result.hTask := FhTask;
  result.cchBuffer := FcchBuffer;
  result.lBufOffset := FlBufOffset;
  result.lDiskOffset := FlDiskOffset;
  result.dwReserved1 := FdwReserved1;
  result.dwReserved2 := FdwReserved2;
  result.hmmio := Fhmmio;
end;

constructor _MMCKINFOWrapper.Create(ARecord: _MMCKINFO);
begin
  inherited Create;
  Fckid := ARecord.ckid;
  Fcksize := ARecord.cksize;
  FfccType := ARecord.fccType;
  FdwDataOffset := ARecord.dwDataOffset;
  FdwFlags := ARecord.dwFlags;
end;

function _MMCKINFOWrapper.ObjToRec: _MMCKINFO;
begin
  result.ckid := Fckid;
  result.cksize := Fcksize;
  result.fccType := FfccType;
  result.dwDataOffset := FdwDataOffset;
  result.dwFlags := FdwFlags;
end;

constructor tagMCI_GENERIC_PARMSWrapper.Create(ARecord: tagMCI_GENERIC_PARMS);
begin
  inherited Create;
  FdwCallback := ARecord.dwCallback;
end;

function tagMCI_GENERIC_PARMSWrapper.ObjToRec: tagMCI_GENERIC_PARMS;
begin
  result.dwCallback := FdwCallback;
end;

constructor tagMCI_OPEN_PARMSAWrapper.Create(ARecord: tagMCI_OPEN_PARMSA);
begin
  inherited Create;
  FdwCallback := ARecord.dwCallback;
  FwDeviceID := ARecord.wDeviceID;
end;

function tagMCI_OPEN_PARMSAWrapper.ObjToRec: tagMCI_OPEN_PARMSA;
begin
  result.dwCallback := FdwCallback;
  result.wDeviceID := FwDeviceID;
end;

constructor tagMCI_OPEN_PARMSWWrapper.Create(ARecord: tagMCI_OPEN_PARMSW);
begin
  inherited Create;
  FdwCallback := ARecord.dwCallback;
  FwDeviceID := ARecord.wDeviceID;
end;

function tagMCI_OPEN_PARMSWWrapper.ObjToRec: tagMCI_OPEN_PARMSW;
begin
  result.dwCallback := FdwCallback;
  result.wDeviceID := FwDeviceID;
end;

constructor tagMCI_PLAY_PARMSWrapper.Create(ARecord: tagMCI_PLAY_PARMS);
begin
  inherited Create;
  FdwCallback := ARecord.dwCallback;
  FdwFrom := ARecord.dwFrom;
  FdwTo := ARecord.dwTo;
end;

function tagMCI_PLAY_PARMSWrapper.ObjToRec: tagMCI_PLAY_PARMS;
begin
  result.dwCallback := FdwCallback;
  result.dwFrom := FdwFrom;
  result.dwTo := FdwTo;
end;

constructor tagMCI_SEEK_PARMSWrapper.Create(ARecord: tagMCI_SEEK_PARMS);
begin
  inherited Create;
  FdwCallback := ARecord.dwCallback;
  FdwTo := ARecord.dwTo;
end;

function tagMCI_SEEK_PARMSWrapper.ObjToRec: tagMCI_SEEK_PARMS;
begin
  result.dwCallback := FdwCallback;
  result.dwTo := FdwTo;
end;

constructor tagMCI_STATUS_PARMSWrapper.Create(ARecord: tagMCI_STATUS_PARMS);
begin
  inherited Create;
  FdwCallback := ARecord.dwCallback;
  FdwReturn := ARecord.dwReturn;
  FdwItem := ARecord.dwItem;
  FdwTrack := ARecord.dwTrack;
end;

function tagMCI_STATUS_PARMSWrapper.ObjToRec: tagMCI_STATUS_PARMS;
begin
  result.dwCallback := FdwCallback;
  result.dwReturn := FdwReturn;
  result.dwItem := FdwItem;
  result.dwTrack := FdwTrack;
end;

constructor tagMCI_INFO_PARMSAWrapper.Create(ARecord: tagMCI_INFO_PARMSA);
begin
  inherited Create;
  FdwCallback := ARecord.dwCallback;
  FdwRetSize := ARecord.dwRetSize;
end;

function tagMCI_INFO_PARMSAWrapper.ObjToRec: tagMCI_INFO_PARMSA;
begin
  result.dwCallback := FdwCallback;
  result.dwRetSize := FdwRetSize;
end;

constructor tagMCI_INFO_PARMSWWrapper.Create(ARecord: tagMCI_INFO_PARMSW);
begin
  inherited Create;
  FdwCallback := ARecord.dwCallback;
  FdwRetSize := ARecord.dwRetSize;
end;

function tagMCI_INFO_PARMSWWrapper.ObjToRec: tagMCI_INFO_PARMSW;
begin
  result.dwCallback := FdwCallback;
  result.dwRetSize := FdwRetSize;
end;

constructor tagMCI_GETDEVCAPS_PARMSWrapper.Create(ARecord: tagMCI_GETDEVCAPS_PARMS);
begin
  inherited Create;
  FdwCallback := ARecord.dwCallback;
  FdwReturn := ARecord.dwReturn;
  FdwItem := ARecord.dwItem;
end;

function tagMCI_GETDEVCAPS_PARMSWrapper.ObjToRec: tagMCI_GETDEVCAPS_PARMS;
begin
  result.dwCallback := FdwCallback;
  result.dwReturn := FdwReturn;
  result.dwItem := FdwItem;
end;

constructor tagMCI_SYSINFO_PARMSAWrapper.Create(ARecord: tagMCI_SYSINFO_PARMSA);
begin
  inherited Create;
  FdwCallback := ARecord.dwCallback;
  FdwRetSize := ARecord.dwRetSize;
  FdwNumber := ARecord.dwNumber;
  FwDeviceType := ARecord.wDeviceType;
end;

function tagMCI_SYSINFO_PARMSAWrapper.ObjToRec: tagMCI_SYSINFO_PARMSA;
begin
  result.dwCallback := FdwCallback;
  result.dwRetSize := FdwRetSize;
  result.dwNumber := FdwNumber;
  result.wDeviceType := FwDeviceType;
end;

constructor tagMCI_SYSINFO_PARMSWWrapper.Create(ARecord: tagMCI_SYSINFO_PARMSW);
begin
  inherited Create;
  FdwCallback := ARecord.dwCallback;
  FdwRetSize := ARecord.dwRetSize;
  FdwNumber := ARecord.dwNumber;
  FwDeviceType := ARecord.wDeviceType;
end;

function tagMCI_SYSINFO_PARMSWWrapper.ObjToRec: tagMCI_SYSINFO_PARMSW;
begin
  result.dwCallback := FdwCallback;
  result.dwRetSize := FdwRetSize;
  result.dwNumber := FdwNumber;
  result.wDeviceType := FwDeviceType;
end;

constructor tagMCI_SET_PARMSWrapper.Create(ARecord: tagMCI_SET_PARMS);
begin
  inherited Create;
  FdwCallback := ARecord.dwCallback;
  FdwTimeFormat := ARecord.dwTimeFormat;
  FdwAudio := ARecord.dwAudio;
end;

function tagMCI_SET_PARMSWrapper.ObjToRec: tagMCI_SET_PARMS;
begin
  result.dwCallback := FdwCallback;
  result.dwTimeFormat := FdwTimeFormat;
  result.dwAudio := FdwAudio;
end;

constructor tagMCI_BREAK_PARMSWrapper.Create(ARecord: tagMCI_BREAK_PARMS);
begin
  inherited Create;
  FdwCallback := ARecord.dwCallback;
  FnVirtKey := ARecord.nVirtKey;
  FhWndBreak := ARecord.hWndBreak;
end;

function tagMCI_BREAK_PARMSWrapper.ObjToRec: tagMCI_BREAK_PARMS;
begin
  result.dwCallback := FdwCallback;
  result.nVirtKey := FnVirtKey;
  result.hWndBreak := FhWndBreak;
end;

constructor TMCI_Sound_ParmsWrapper.Create(ARecord: TMCI_Sound_Parms);
begin
  inherited Create;
  FdwCallback := ARecord.dwCallback;
end;

function TMCI_Sound_ParmsWrapper.ObjToRec: TMCI_Sound_Parms;
begin
  result.dwCallback := FdwCallback;
end;

constructor MCI_SAVE_PARMSAWrapper.Create(ARecord: MCI_SAVE_PARMSA);
begin
  inherited Create;
  FdwCallback := ARecord.dwCallback;
end;

function MCI_SAVE_PARMSAWrapper.ObjToRec: MCI_SAVE_PARMSA;
begin
  result.dwCallback := FdwCallback;
end;

constructor MCI_SAVE_PARMSWWrapper.Create(ARecord: MCI_SAVE_PARMSW);
begin
  inherited Create;
  FdwCallback := ARecord.dwCallback;
end;

function MCI_SAVE_PARMSWWrapper.ObjToRec: MCI_SAVE_PARMSW;
begin
  result.dwCallback := FdwCallback;
end;

constructor tagMCI_LOAD_PARMSAWrapper.Create(ARecord: tagMCI_LOAD_PARMSA);
begin
  inherited Create;
  FdwCallback := ARecord.dwCallback;
end;

function tagMCI_LOAD_PARMSAWrapper.ObjToRec: tagMCI_LOAD_PARMSA;
begin
  result.dwCallback := FdwCallback;
end;

constructor tagMCI_LOAD_PARMSWWrapper.Create(ARecord: tagMCI_LOAD_PARMSW);
begin
  inherited Create;
  FdwCallback := ARecord.dwCallback;
end;

function tagMCI_LOAD_PARMSWWrapper.ObjToRec: tagMCI_LOAD_PARMSW;
begin
  result.dwCallback := FdwCallback;
end;

constructor tagMCI_RECORD_PARMSWrapper.Create(ARecord: tagMCI_RECORD_PARMS);
begin
  inherited Create;
  FdwCallback := ARecord.dwCallback;
  FdwFrom := ARecord.dwFrom;
  FdwTo := ARecord.dwTo;
end;

function tagMCI_RECORD_PARMSWrapper.ObjToRec: tagMCI_RECORD_PARMS;
begin
  result.dwCallback := FdwCallback;
  result.dwFrom := FdwFrom;
  result.dwTo := FdwTo;
end;

constructor tagMCI_VD_PLAY_PARMSWrapper.Create(ARecord: tagMCI_VD_PLAY_PARMS);
begin
  inherited Create;
  FdwCallback := ARecord.dwCallback;
  FdwFrom := ARecord.dwFrom;
  FdwTo := ARecord.dwTo;
  FdwSpeed := ARecord.dwSpeed;
end;

function tagMCI_VD_PLAY_PARMSWrapper.ObjToRec: tagMCI_VD_PLAY_PARMS;
begin
  result.dwCallback := FdwCallback;
  result.dwFrom := FdwFrom;
  result.dwTo := FdwTo;
  result.dwSpeed := FdwSpeed;
end;

constructor tagMCI_VD_STEP_PARMSWrapper.Create(ARecord: tagMCI_VD_STEP_PARMS);
begin
  inherited Create;
  FdwCallback := ARecord.dwCallback;
  FdwFrames := ARecord.dwFrames;
end;

function tagMCI_VD_STEP_PARMSWrapper.ObjToRec: tagMCI_VD_STEP_PARMS;
begin
  result.dwCallback := FdwCallback;
  result.dwFrames := FdwFrames;
end;

constructor tagMCI_VD_ESCAPE_PARMSAWrapper.Create(ARecord: tagMCI_VD_ESCAPE_PARMSA);
begin
  inherited Create;
  FdwCallback := ARecord.dwCallback;
end;

function tagMCI_VD_ESCAPE_PARMSAWrapper.ObjToRec: tagMCI_VD_ESCAPE_PARMSA;
begin
  result.dwCallback := FdwCallback;
end;

constructor tagMCI_VD_ESCAPE_PARMSWWrapper.Create(ARecord: tagMCI_VD_ESCAPE_PARMSW);
begin
  inherited Create;
  FdwCallback := ARecord.dwCallback;
end;

function tagMCI_VD_ESCAPE_PARMSWWrapper.ObjToRec: tagMCI_VD_ESCAPE_PARMSW;
begin
  result.dwCallback := FdwCallback;
end;

constructor tagMCI_WAVE_OPEN_PARMSAWrapper.Create(ARecord: tagMCI_WAVE_OPEN_PARMSA);
begin
  inherited Create;
  FdwCallback := ARecord.dwCallback;
  FwDeviceID := ARecord.wDeviceID;
  FdwBufferSeconds := ARecord.dwBufferSeconds;
end;

function tagMCI_WAVE_OPEN_PARMSAWrapper.ObjToRec: tagMCI_WAVE_OPEN_PARMSA;
begin
  result.dwCallback := FdwCallback;
  result.wDeviceID := FwDeviceID;
  result.dwBufferSeconds := FdwBufferSeconds;
end;

constructor tagMCI_WAVE_OPEN_PARMSWWrapper.Create(ARecord: tagMCI_WAVE_OPEN_PARMSW);
begin
  inherited Create;
  FdwCallback := ARecord.dwCallback;
  FwDeviceID := ARecord.wDeviceID;
  FdwBufferSeconds := ARecord.dwBufferSeconds;
end;

function tagMCI_WAVE_OPEN_PARMSWWrapper.ObjToRec: tagMCI_WAVE_OPEN_PARMSW;
begin
  result.dwCallback := FdwCallback;
  result.wDeviceID := FwDeviceID;
  result.dwBufferSeconds := FdwBufferSeconds;
end;

constructor tagMCI_WAVE_DELETE_PARMSWrapper.Create(ARecord: tagMCI_WAVE_DELETE_PARMS);
begin
  inherited Create;
  FdwCallback := ARecord.dwCallback;
  FdwFrom := ARecord.dwFrom;
  FdwTo := ARecord.dwTo;
end;

function tagMCI_WAVE_DELETE_PARMSWrapper.ObjToRec: tagMCI_WAVE_DELETE_PARMS;
begin
  result.dwCallback := FdwCallback;
  result.dwFrom := FdwFrom;
  result.dwTo := FdwTo;
end;

constructor tagMCI_WAVE_SET_PARMSWrapper.Create(ARecord: tagMCI_WAVE_SET_PARMS);
begin
  inherited Create;
  FdwCallback := ARecord.dwCallback;
  FdwTimeFormat := ARecord.dwTimeFormat;
  FdwAudio := ARecord.dwAudio;
  FwInput := ARecord.wInput;
  FwOutput := ARecord.wOutput;
  FwFormatTag := ARecord.wFormatTag;
  FwReserved2 := ARecord.wReserved2;
  FnChannels := ARecord.nChannels;
  FwReserved3 := ARecord.wReserved3;
  FnSamplesPerSec := ARecord.nSamplesPerSec;
  FnAvgBytesPerSec := ARecord.nAvgBytesPerSec;
  FnBlockAlign := ARecord.nBlockAlign;
  FwReserved4 := ARecord.wReserved4;
  FwBitsPerSample := ARecord.wBitsPerSample;
  FwReserved5 := ARecord.wReserved5;
end;

function tagMCI_WAVE_SET_PARMSWrapper.ObjToRec: tagMCI_WAVE_SET_PARMS;
begin
  result.dwCallback := FdwCallback;
  result.dwTimeFormat := FdwTimeFormat;
  result.dwAudio := FdwAudio;
  result.wInput := FwInput;
  result.wOutput := FwOutput;
  result.wFormatTag := FwFormatTag;
  result.wReserved2 := FwReserved2;
  result.nChannels := FnChannels;
  result.wReserved3 := FwReserved3;
  result.nSamplesPerSec := FnSamplesPerSec;
  result.nAvgBytesPerSec := FnAvgBytesPerSec;
  result.nBlockAlign := FnBlockAlign;
  result.wReserved4 := FwReserved4;
  result.wBitsPerSample := FwBitsPerSample;
  result.wReserved5 := FwReserved5;
end;

constructor tagMCI_SEQ_SET_PARMSWrapper.Create(ARecord: tagMCI_SEQ_SET_PARMS);
begin
  inherited Create;
  FdwCallback := ARecord.dwCallback;
  FdwTimeFormat := ARecord.dwTimeFormat;
  FdwAudio := ARecord.dwAudio;
  FdwTempo := ARecord.dwTempo;
  FdwPort := ARecord.dwPort;
  FdwSlave := ARecord.dwSlave;
  FdwMaster := ARecord.dwMaster;
  FdwOffset := ARecord.dwOffset;
end;

function tagMCI_SEQ_SET_PARMSWrapper.ObjToRec: tagMCI_SEQ_SET_PARMS;
begin
  result.dwCallback := FdwCallback;
  result.dwTimeFormat := FdwTimeFormat;
  result.dwAudio := FdwAudio;
  result.dwTempo := FdwTempo;
  result.dwPort := FdwPort;
  result.dwSlave := FdwSlave;
  result.dwMaster := FdwMaster;
  result.dwOffset := FdwOffset;
end;

constructor tagMCI_ANIM_OPEN_PARMSAWrapper.Create(ARecord: tagMCI_ANIM_OPEN_PARMSA);
begin
  inherited Create;
  FdwCallback := ARecord.dwCallback;
  FwDeviceID := ARecord.wDeviceID;
  FdwStyle := ARecord.dwStyle;
  FhWndParent := ARecord.hWndParent;
end;

function tagMCI_ANIM_OPEN_PARMSAWrapper.ObjToRec: tagMCI_ANIM_OPEN_PARMSA;
begin
  result.dwCallback := FdwCallback;
  result.wDeviceID := FwDeviceID;
  result.dwStyle := FdwStyle;
  result.hWndParent := FhWndParent;
end;

constructor tagMCI_ANIM_OPEN_PARMSWWrapper.Create(ARecord: tagMCI_ANIM_OPEN_PARMSW);
begin
  inherited Create;
  FdwCallback := ARecord.dwCallback;
  FwDeviceID := ARecord.wDeviceID;
  FdwStyle := ARecord.dwStyle;
  FhWndParent := ARecord.hWndParent;
end;

function tagMCI_ANIM_OPEN_PARMSWWrapper.ObjToRec: tagMCI_ANIM_OPEN_PARMSW;
begin
  result.dwCallback := FdwCallback;
  result.wDeviceID := FwDeviceID;
  result.dwStyle := FdwStyle;
  result.hWndParent := FhWndParent;
end;

constructor tagMCI_ANIM_PLAY_PARMSWrapper.Create(ARecord: tagMCI_ANIM_PLAY_PARMS);
begin
  inherited Create;
  FdwCallback := ARecord.dwCallback;
  FdwFrom := ARecord.dwFrom;
  FdwTo := ARecord.dwTo;
  FdwSpeed := ARecord.dwSpeed;
end;

function tagMCI_ANIM_PLAY_PARMSWrapper.ObjToRec: tagMCI_ANIM_PLAY_PARMS;
begin
  result.dwCallback := FdwCallback;
  result.dwFrom := FdwFrom;
  result.dwTo := FdwTo;
  result.dwSpeed := FdwSpeed;
end;

constructor tagMCI_ANIM_STEP_PARMSWrapper.Create(ARecord: tagMCI_ANIM_STEP_PARMS);
begin
  inherited Create;
  FdwCallback := ARecord.dwCallback;
  FdwFrames := ARecord.dwFrames;
end;

function tagMCI_ANIM_STEP_PARMSWrapper.ObjToRec: tagMCI_ANIM_STEP_PARMS;
begin
  result.dwCallback := FdwCallback;
  result.dwFrames := FdwFrames;
end;

constructor tagMCI_ANIM_WINDOW_PARMSAWrapper.Create(ARecord: tagMCI_ANIM_WINDOW_PARMSA);
begin
  inherited Create;
  FdwCallback := ARecord.dwCallback;
  FWnd := ARecord.Wnd;
  FnCmdShow := ARecord.nCmdShow;
end;

function tagMCI_ANIM_WINDOW_PARMSAWrapper.ObjToRec: tagMCI_ANIM_WINDOW_PARMSA;
begin
  result.dwCallback := FdwCallback;
  result.Wnd := FWnd;
  result.nCmdShow := FnCmdShow;
end;

constructor tagMCI_ANIM_WINDOW_PARMSWWrapper.Create(ARecord: tagMCI_ANIM_WINDOW_PARMSW);
begin
  inherited Create;
  FdwCallback := ARecord.dwCallback;
  FWnd := ARecord.Wnd;
  FnCmdShow := ARecord.nCmdShow;
end;

function tagMCI_ANIM_WINDOW_PARMSWWrapper.ObjToRec: tagMCI_ANIM_WINDOW_PARMSW;
begin
  result.dwCallback := FdwCallback;
  result.Wnd := FWnd;
  result.nCmdShow := FnCmdShow;
end;

constructor tagMCI_ANIM_RECT_PARMSWrapper.Create(ARecord: tagMCI_ANIM_RECT_PARMS);
begin
  inherited Create;
  FdwCallback := ARecord.dwCallback;
end;

function tagMCI_ANIM_RECT_PARMSWrapper.ObjToRec: tagMCI_ANIM_RECT_PARMS;
begin
  result.dwCallback := FdwCallback;
end;

constructor tagMCI_ANIM_UPDATE_PARMSWrapper.Create(ARecord: tagMCI_ANIM_UPDATE_PARMS);
begin
  inherited Create;
  FdwCallback := ARecord.dwCallback;
  FhDC := ARecord.hDC;
end;

function tagMCI_ANIM_UPDATE_PARMSWrapper.ObjToRec: tagMCI_ANIM_UPDATE_PARMS;
begin
  result.dwCallback := FdwCallback;
  result.hDC := FhDC;
end;

constructor tagMCI_OVLY_OPEN_PARMSAWrapper.Create(ARecord: tagMCI_OVLY_OPEN_PARMSA);
begin
  inherited Create;
  FdwCallback := ARecord.dwCallback;
  FwDeviceID := ARecord.wDeviceID;
  FdwStyle := ARecord.dwStyle;
  FhWndParent := ARecord.hWndParent;
end;

function tagMCI_OVLY_OPEN_PARMSAWrapper.ObjToRec: tagMCI_OVLY_OPEN_PARMSA;
begin
  result.dwCallback := FdwCallback;
  result.wDeviceID := FwDeviceID;
  result.dwStyle := FdwStyle;
  result.hWndParent := FhWndParent;
end;

constructor tagMCI_OVLY_OPEN_PARMSWWrapper.Create(ARecord: tagMCI_OVLY_OPEN_PARMSW);
begin
  inherited Create;
  FdwCallback := ARecord.dwCallback;
  FwDeviceID := ARecord.wDeviceID;
  FdwStyle := ARecord.dwStyle;
  FhWndParent := ARecord.hWndParent;
end;

function tagMCI_OVLY_OPEN_PARMSWWrapper.ObjToRec: tagMCI_OVLY_OPEN_PARMSW;
begin
  result.dwCallback := FdwCallback;
  result.wDeviceID := FwDeviceID;
  result.dwStyle := FdwStyle;
  result.hWndParent := FhWndParent;
end;

constructor tagMCI_OVLY_WINDOW_PARMSAWrapper.Create(ARecord: tagMCI_OVLY_WINDOW_PARMSA);
begin
  inherited Create;
  FdwCallback := ARecord.dwCallback;
  FWHandle := ARecord.WHandle;
  FnCmdShow := ARecord.nCmdShow;
end;

function tagMCI_OVLY_WINDOW_PARMSAWrapper.ObjToRec: tagMCI_OVLY_WINDOW_PARMSA;
begin
  result.dwCallback := FdwCallback;
  result.WHandle := FWHandle;
  result.nCmdShow := FnCmdShow;
end;

constructor tagMCI_OVLY_WINDOW_PARMSWWrapper.Create(ARecord: tagMCI_OVLY_WINDOW_PARMSW);
begin
  inherited Create;
  FdwCallback := ARecord.dwCallback;
  FWHandle := ARecord.WHandle;
  FnCmdShow := ARecord.nCmdShow;
end;

function tagMCI_OVLY_WINDOW_PARMSWWrapper.ObjToRec: tagMCI_OVLY_WINDOW_PARMSW;
begin
  result.dwCallback := FdwCallback;
  result.WHandle := FWHandle;
  result.nCmdShow := FnCmdShow;
end;

constructor tagMCI_OVLY_RECT_PARMSWrapper.Create(ARecord: tagMCI_OVLY_RECT_PARMS);
begin
  inherited Create;
  FdwCallback := ARecord.dwCallback;
end;

function tagMCI_OVLY_RECT_PARMSWrapper.ObjToRec: tagMCI_OVLY_RECT_PARMS;
begin
  result.dwCallback := FdwCallback;
end;

constructor tagMCI_OVLY_SAVE_PARMSAWrapper.Create(ARecord: tagMCI_OVLY_SAVE_PARMSA);
begin
  inherited Create;
  FdwCallback := ARecord.dwCallback;
end;

function tagMCI_OVLY_SAVE_PARMSAWrapper.ObjToRec: tagMCI_OVLY_SAVE_PARMSA;
begin
  result.dwCallback := FdwCallback;
end;

constructor tagMCI_OVLY_SAVE_PARMSWWrapper.Create(ARecord: tagMCI_OVLY_SAVE_PARMSW);
begin
  inherited Create;
  FdwCallback := ARecord.dwCallback;
end;

function tagMCI_OVLY_SAVE_PARMSWWrapper.ObjToRec: tagMCI_OVLY_SAVE_PARMSW;
begin
  result.dwCallback := FdwCallback;
end;

constructor tagMCI_OVLY_LOAD_PARMSAWrapper.Create(ARecord: tagMCI_OVLY_LOAD_PARMSA);
begin
  inherited Create;
  FdwCallback := ARecord.dwCallback;
end;

function tagMCI_OVLY_LOAD_PARMSAWrapper.ObjToRec: tagMCI_OVLY_LOAD_PARMSA;
begin
  result.dwCallback := FdwCallback;
end;

constructor tagMCI_OVLY_LOAD_PARMSWWrapper.Create(ARecord: tagMCI_OVLY_LOAD_PARMSW);
begin
  inherited Create;
  FdwCallback := ARecord.dwCallback;
end;

function tagMCI_OVLY_LOAD_PARMSWWrapper.ObjToRec: tagMCI_OVLY_LOAD_PARMSW;
begin
  result.dwCallback := FdwCallback;
end;



procedure TatMMSystemLibrary.__CloseDriver(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.CloseDriver(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__OpenDriver(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.OpenDriver(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__SendDriverMessage(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.SendDriverMessage(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__DrvGetModuleHandle(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.DrvGetModuleHandle(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__GetDriverModuleHandle(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.GetDriverModuleHandle(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__DefDriverProc(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.DefDriverProc(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)),VarToInteger(GetInputArg(4))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__mmsystemGetVersion(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.mmsystemGetVersion);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__sndPlaySound(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := MMSystem.sndPlaySound(PChar(VarToStr(GetInputArg(0))),VarToInteger(GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__sndPlaySoundA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := MMSystem.sndPlaySoundA(PChar(VarToStr(GetInputArg(0))),VarToInteger(GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__sndPlaySoundW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := MMSystem.sndPlaySoundW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),VarToInteger(GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__PlaySound(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := MMSystem.PlaySound(PChar(VarToStr(GetInputArg(0))),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__PlaySoundA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := MMSystem.PlaySoundA(PChar(VarToStr(GetInputArg(0))),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__PlaySoundW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := MMSystem.PlaySoundW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__waveOutGetNumDevs(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.waveOutGetNumDevs);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__waveOutSetVolume(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.waveOutSetVolume(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__waveOutGetErrorText(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.waveOutGetErrorText(VarToInteger(GetInputArg(0)),PChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__waveOutGetErrorTextA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.waveOutGetErrorTextA(VarToInteger(GetInputArg(0)),PChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__waveOutGetErrorTextW(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.waveOutGetErrorTextW(VarToInteger(GetInputArg(0)),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__waveOutClose(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.waveOutClose(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__waveOutPause(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.waveOutPause(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__waveOutRestart(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.waveOutRestart(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__waveOutReset(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.waveOutReset(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__waveOutBreakLoop(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.waveOutBreakLoop(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__waveOutSetPitch(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.waveOutSetPitch(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__waveOutSetPlaybackRate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.waveOutSetPlaybackRate(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__waveOutMessage(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.waveOutMessage(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__waveInGetNumDevs(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.waveInGetNumDevs);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__waveInGetErrorText(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.waveInGetErrorText(VarToInteger(GetInputArg(0)),PChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__waveInGetErrorTextA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.waveInGetErrorTextA(VarToInteger(GetInputArg(0)),PChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__waveInGetErrorTextW(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.waveInGetErrorTextW(VarToInteger(GetInputArg(0)),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__waveInClose(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.waveInClose(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__waveInStart(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.waveInStart(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__waveInStop(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.waveInStop(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__waveInReset(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.waveInReset(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__waveInMessage(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.waveInMessage(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__midiOutGetNumDevs(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.midiOutGetNumDevs);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__midiStreamClose(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.midiStreamClose(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__midiStreamPause(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.midiStreamPause(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__midiStreamRestart(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.midiStreamRestart(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__midiStreamStop(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.midiStreamStop(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__midiOutSetVolume(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.midiOutSetVolume(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__midiOutGetErrorText(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.midiOutGetErrorText(VarToInteger(GetInputArg(0)),PChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__midiOutGetErrorTextA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.midiOutGetErrorTextA(VarToInteger(GetInputArg(0)),PChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__midiOutGetErrorTextW(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.midiOutGetErrorTextW(VarToInteger(GetInputArg(0)),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__midiOutClose(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.midiOutClose(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__midiOutShortMsg(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.midiOutShortMsg(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__midiOutReset(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.midiOutReset(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__midiOutMessage(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.midiOutMessage(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__midiInGetNumDevs(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.midiInGetNumDevs);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__midiInGetErrorText(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.midiInGetErrorText(VarToInteger(GetInputArg(0)),PChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__midiInGetErrorTextA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.midiInGetErrorTextA(VarToInteger(GetInputArg(0)),PChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__midiInGetErrorTextW(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.midiInGetErrorTextW(VarToInteger(GetInputArg(0)),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__midiInClose(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.midiInClose(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__midiInStart(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.midiInStart(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__midiInStop(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.midiInStop(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__midiInReset(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.midiInReset(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__midiInMessage(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.midiInMessage(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__auxGetNumDevs(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.auxGetNumDevs);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__auxSetVolume(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.auxSetVolume(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__auxOutMessage(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.auxOutMessage(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__mixerGetNumDevs(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.mixerGetNumDevs);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__mixerClose(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.mixerClose(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__mixerMessage(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.mixerMessage(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__mixerGetID(AMachine: TatVirtualMachine);
  var
  Param1: UINT;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
AResult := Integer(MMSystem.mixerGetID(VarToInteger(GetInputArg(0)),Param1,VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatMMSystemLibrary.__timeGetTime(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.timeGetTime);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__timeKillEvent(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.timeKillEvent(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__timeBeginPeriod(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.timeBeginPeriod(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__timeEndPeriod(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.timeEndPeriod(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__joyGetNumDevs(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.joyGetNumDevs);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__joyReleaseCapture(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.joyReleaseCapture(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__joySetCapture(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.joySetCapture(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),GetInputArg(3)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__joySetThreshold(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.joySetThreshold(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__mmioStringToFOURCC(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.mmioStringToFOURCC(PChar(VarToStr(GetInputArg(0))),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__mmioStringToFOURCCA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.mmioStringToFOURCCA(PChar(VarToStr(GetInputArg(0))),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__mmioStringToFOURCCW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.mmioStringToFOURCCW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__mmioClose(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.mmioClose(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__mmioRead(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.mmioRead(VarToInteger(GetInputArg(0)),PChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__mmioWrite(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.mmioWrite(VarToInteger(GetInputArg(0)),PChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__mmioSeek(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.mmioSeek(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__mmioSetBuffer(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.mmioSetBuffer(VarToInteger(GetInputArg(0)),PChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__mmioFlush(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.mmioFlush(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__mmioSendMessage(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.mmioSendMessage(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__mciSendCommand(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.mciSendCommand(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__mciSendCommandA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.mciSendCommandA(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__mciSendCommandW(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.mciSendCommandW(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__mciSendString(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.mciSendString(PChar(VarToStr(GetInputArg(0))),PChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__mciSendStringA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.mciSendStringA(PChar(VarToStr(GetInputArg(0))),PChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__mciSendStringW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.mciSendStringW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__mciGetDeviceID(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.mciGetDeviceID(PChar(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__mciGetDeviceIDA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.mciGetDeviceIDA(PChar(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__mciGetDeviceIDW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.mciGetDeviceIDW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__mciGetDeviceIDFromElementID(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.mciGetDeviceIDFromElementID(VarToInteger(GetInputArg(0)),PChar(VarToStr(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__mciGetDeviceIDFromElementIDA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.mciGetDeviceIDFromElementIDA(VarToInteger(GetInputArg(0)),PChar(VarToStr(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__mciGetDeviceIDFromElementIDW(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.mciGetDeviceIDFromElementIDW(VarToInteger(GetInputArg(0)),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__mciGetErrorString(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := MMSystem.mciGetErrorString(VarToInteger(GetInputArg(0)),PChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__mciGetErrorStringA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := MMSystem.mciGetErrorStringA(VarToInteger(GetInputArg(0)),PChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__mciGetErrorStringW(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := MMSystem.mciGetErrorStringW(VarToInteger(GetInputArg(0)),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__mciGetCreatorTask(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.mciGetCreatorTask(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__mciExecute(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := MMSystem.mciExecute(PChar(VarToStr(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__mci_MSF_Minute(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.mci_MSF_Minute(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__mci_MSF_Second(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.mci_MSF_Second(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__mci_MSF_Frame(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.mci_MSF_Frame(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__mci_Make_MSF(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.mci_Make_MSF(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__mci_TMSF_Track(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.mci_TMSF_Track(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__mci_TMSF_Minute(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.mci_TMSF_Minute(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__mci_TMSF_Second(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.mci_TMSF_Second(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__mci_TMSF_Frame(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.mci_TMSF_Frame(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__mci_Make_TMSF(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.mci_Make_TMSF(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__mci_HMS_Hour(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.mci_HMS_Hour(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__mci_HMS_Minute(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.mci_HMS_Minute(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__mci_HMS_Second(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.mci_HMS_Second(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__mci_Make_HMS(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.mci_Make_HMS(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.__DIBIndex(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MMSystem.DIBIndex(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMMSystemLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('CloseDriver',3,tkInteger,nil,__CloseDriver,false,0);
    DefineMethod('OpenDriver',3,tkInteger,nil,__OpenDriver,false,0);
    DefineMethod('SendDriverMessage',4,tkInteger,nil,__SendDriverMessage,false,0);
    DefineMethod('DrvGetModuleHandle',1,tkInteger,nil,__DrvGetModuleHandle,false,0);
    DefineMethod('GetDriverModuleHandle',1,tkInteger,nil,__GetDriverModuleHandle,false,0);
    DefineMethod('DefDriverProc',5,tkInteger,nil,__DefDriverProc,false,0);
    DefineMethod('mmsystemGetVersion',0,tkInteger,nil,__mmsystemGetVersion,false,0);
    DefineMethod('sndPlaySound',2,tkVariant,nil,__sndPlaySound,false,0);
    DefineMethod('sndPlaySoundA',2,tkVariant,nil,__sndPlaySoundA,false,0);
    DefineMethod('sndPlaySoundW',2,tkVariant,nil,__sndPlaySoundW,false,0);
    DefineMethod('PlaySound',3,tkVariant,nil,__PlaySound,false,0);
    DefineMethod('PlaySoundA',3,tkVariant,nil,__PlaySoundA,false,0);
    DefineMethod('PlaySoundW',3,tkVariant,nil,__PlaySoundW,false,0);
    DefineMethod('waveOutGetNumDevs',0,tkInteger,nil,__waveOutGetNumDevs,false,0);
    DefineMethod('waveOutSetVolume',2,tkInteger,nil,__waveOutSetVolume,false,0);
    DefineMethod('waveOutGetErrorText',3,tkInteger,nil,__waveOutGetErrorText,false,0);
    DefineMethod('waveOutGetErrorTextA',3,tkInteger,nil,__waveOutGetErrorTextA,false,0);
    DefineMethod('waveOutGetErrorTextW',3,tkInteger,nil,__waveOutGetErrorTextW,false,0);
    DefineMethod('waveOutClose',1,tkInteger,nil,__waveOutClose,false,0);
    DefineMethod('waveOutPause',1,tkInteger,nil,__waveOutPause,false,0);
    DefineMethod('waveOutRestart',1,tkInteger,nil,__waveOutRestart,false,0);
    DefineMethod('waveOutReset',1,tkInteger,nil,__waveOutReset,false,0);
    DefineMethod('waveOutBreakLoop',1,tkInteger,nil,__waveOutBreakLoop,false,0);
    DefineMethod('waveOutSetPitch',2,tkInteger,nil,__waveOutSetPitch,false,0);
    DefineMethod('waveOutSetPlaybackRate',2,tkInteger,nil,__waveOutSetPlaybackRate,false,0);
    DefineMethod('waveOutMessage',4,tkInteger,nil,__waveOutMessage,false,0);
    DefineMethod('waveInGetNumDevs',0,tkInteger,nil,__waveInGetNumDevs,false,0);
    DefineMethod('waveInGetErrorText',3,tkInteger,nil,__waveInGetErrorText,false,0);
    DefineMethod('waveInGetErrorTextA',3,tkInteger,nil,__waveInGetErrorTextA,false,0);
    DefineMethod('waveInGetErrorTextW',3,tkInteger,nil,__waveInGetErrorTextW,false,0);
    DefineMethod('waveInClose',1,tkInteger,nil,__waveInClose,false,0);
    DefineMethod('waveInStart',1,tkInteger,nil,__waveInStart,false,0);
    DefineMethod('waveInStop',1,tkInteger,nil,__waveInStop,false,0);
    DefineMethod('waveInReset',1,tkInteger,nil,__waveInReset,false,0);
    DefineMethod('waveInMessage',4,tkInteger,nil,__waveInMessage,false,0);
    DefineMethod('midiOutGetNumDevs',0,tkInteger,nil,__midiOutGetNumDevs,false,0);
    DefineMethod('midiStreamClose',1,tkInteger,nil,__midiStreamClose,false,0);
    DefineMethod('midiStreamPause',1,tkInteger,nil,__midiStreamPause,false,0);
    DefineMethod('midiStreamRestart',1,tkInteger,nil,__midiStreamRestart,false,0);
    DefineMethod('midiStreamStop',1,tkInteger,nil,__midiStreamStop,false,0);
    DefineMethod('midiOutSetVolume',2,tkInteger,nil,__midiOutSetVolume,false,0);
    DefineMethod('midiOutGetErrorText',3,tkInteger,nil,__midiOutGetErrorText,false,0);
    DefineMethod('midiOutGetErrorTextA',3,tkInteger,nil,__midiOutGetErrorTextA,false,0);
    DefineMethod('midiOutGetErrorTextW',3,tkInteger,nil,__midiOutGetErrorTextW,false,0);
    DefineMethod('midiOutClose',1,tkInteger,nil,__midiOutClose,false,0);
    DefineMethod('midiOutShortMsg',2,tkInteger,nil,__midiOutShortMsg,false,0);
    DefineMethod('midiOutReset',1,tkInteger,nil,__midiOutReset,false,0);
    DefineMethod('midiOutMessage',4,tkInteger,nil,__midiOutMessage,false,0);
    DefineMethod('midiInGetNumDevs',0,tkInteger,nil,__midiInGetNumDevs,false,0);
    DefineMethod('midiInGetErrorText',3,tkInteger,nil,__midiInGetErrorText,false,0);
    DefineMethod('midiInGetErrorTextA',3,tkInteger,nil,__midiInGetErrorTextA,false,0);
    DefineMethod('midiInGetErrorTextW',3,tkInteger,nil,__midiInGetErrorTextW,false,0);
    DefineMethod('midiInClose',1,tkInteger,nil,__midiInClose,false,0);
    DefineMethod('midiInStart',1,tkInteger,nil,__midiInStart,false,0);
    DefineMethod('midiInStop',1,tkInteger,nil,__midiInStop,false,0);
    DefineMethod('midiInReset',1,tkInteger,nil,__midiInReset,false,0);
    DefineMethod('midiInMessage',4,tkInteger,nil,__midiInMessage,false,0);
    DefineMethod('auxGetNumDevs',0,tkInteger,nil,__auxGetNumDevs,false,0);
    DefineMethod('auxSetVolume',2,tkInteger,nil,__auxSetVolume,false,0);
    DefineMethod('auxOutMessage',4,tkInteger,nil,__auxOutMessage,false,0);
    DefineMethod('mixerGetNumDevs',0,tkInteger,nil,__mixerGetNumDevs,false,0);
    DefineMethod('mixerClose',1,tkInteger,nil,__mixerClose,false,0);
    DefineMethod('mixerMessage',4,tkInteger,nil,__mixerMessage,false,0);
    DefineMethod('mixerGetID',3,tkInteger,nil,__mixerGetID,false,0).SetVarArgs([1]);
    DefineMethod('timeGetTime',0,tkInteger,nil,__timeGetTime,false,0);
    DefineMethod('timeKillEvent',1,tkInteger,nil,__timeKillEvent,false,0);
    DefineMethod('timeBeginPeriod',1,tkInteger,nil,__timeBeginPeriod,false,0);
    DefineMethod('timeEndPeriod',1,tkInteger,nil,__timeEndPeriod,false,0);
    DefineMethod('joyGetNumDevs',0,tkInteger,nil,__joyGetNumDevs,false,0);
    DefineMethod('joyReleaseCapture',1,tkInteger,nil,__joyReleaseCapture,false,0);
    DefineMethod('joySetCapture',4,tkInteger,nil,__joySetCapture,false,0);
    DefineMethod('joySetThreshold',2,tkInteger,nil,__joySetThreshold,false,0);
    DefineMethod('mmioStringToFOURCC',2,tkInteger,nil,__mmioStringToFOURCC,false,0);
    DefineMethod('mmioStringToFOURCCA',2,tkInteger,nil,__mmioStringToFOURCCA,false,0);
    DefineMethod('mmioStringToFOURCCW',2,tkInteger,nil,__mmioStringToFOURCCW,false,0);
    DefineMethod('mmioClose',2,tkInteger,nil,__mmioClose,false,0);
    DefineMethod('mmioRead',3,tkInteger,nil,__mmioRead,false,0);
    DefineMethod('mmioWrite',3,tkInteger,nil,__mmioWrite,false,0);
    DefineMethod('mmioSeek',3,tkInteger,nil,__mmioSeek,false,0);
    DefineMethod('mmioSetBuffer',4,tkInteger,nil,__mmioSetBuffer,false,0);
    DefineMethod('mmioFlush',2,tkInteger,nil,__mmioFlush,false,0);
    DefineMethod('mmioSendMessage',4,tkInteger,nil,__mmioSendMessage,false,0);
    DefineMethod('mciSendCommand',4,tkInteger,nil,__mciSendCommand,false,0);
    DefineMethod('mciSendCommandA',4,tkInteger,nil,__mciSendCommandA,false,0);
    DefineMethod('mciSendCommandW',4,tkInteger,nil,__mciSendCommandW,false,0);
    DefineMethod('mciSendString',4,tkInteger,nil,__mciSendString,false,0);
    DefineMethod('mciSendStringA',4,tkInteger,nil,__mciSendStringA,false,0);
    DefineMethod('mciSendStringW',4,tkInteger,nil,__mciSendStringW,false,0);
    DefineMethod('mciGetDeviceID',1,tkInteger,nil,__mciGetDeviceID,false,0);
    DefineMethod('mciGetDeviceIDA',1,tkInteger,nil,__mciGetDeviceIDA,false,0);
    DefineMethod('mciGetDeviceIDW',1,tkInteger,nil,__mciGetDeviceIDW,false,0);
    DefineMethod('mciGetDeviceIDFromElementID',2,tkInteger,nil,__mciGetDeviceIDFromElementID,false,0);
    DefineMethod('mciGetDeviceIDFromElementIDA',2,tkInteger,nil,__mciGetDeviceIDFromElementIDA,false,0);
    DefineMethod('mciGetDeviceIDFromElementIDW',2,tkInteger,nil,__mciGetDeviceIDFromElementIDW,false,0);
    DefineMethod('mciGetErrorString',3,tkVariant,nil,__mciGetErrorString,false,0);
    DefineMethod('mciGetErrorStringA',3,tkVariant,nil,__mciGetErrorStringA,false,0);
    DefineMethod('mciGetErrorStringW',3,tkVariant,nil,__mciGetErrorStringW,false,0);
    DefineMethod('mciGetCreatorTask',1,tkInteger,nil,__mciGetCreatorTask,false,0);
    DefineMethod('mciExecute',1,tkVariant,nil,__mciExecute,false,0);
    DefineMethod('mci_MSF_Minute',1,tkInteger,nil,__mci_MSF_Minute,false,0);
    DefineMethod('mci_MSF_Second',1,tkInteger,nil,__mci_MSF_Second,false,0);
    DefineMethod('mci_MSF_Frame',1,tkInteger,nil,__mci_MSF_Frame,false,0);
    DefineMethod('mci_Make_MSF',3,tkInteger,nil,__mci_Make_MSF,false,0);
    DefineMethod('mci_TMSF_Track',1,tkInteger,nil,__mci_TMSF_Track,false,0);
    DefineMethod('mci_TMSF_Minute',1,tkInteger,nil,__mci_TMSF_Minute,false,0);
    DefineMethod('mci_TMSF_Second',1,tkInteger,nil,__mci_TMSF_Second,false,0);
    DefineMethod('mci_TMSF_Frame',1,tkInteger,nil,__mci_TMSF_Frame,false,0);
    DefineMethod('mci_Make_TMSF',4,tkInteger,nil,__mci_Make_TMSF,false,0);
    DefineMethod('mci_HMS_Hour',1,tkInteger,nil,__mci_HMS_Hour,false,0);
    DefineMethod('mci_HMS_Minute',1,tkInteger,nil,__mci_HMS_Minute,false,0);
    DefineMethod('mci_HMS_Second',1,tkInteger,nil,__mci_HMS_Second,false,0);
    DefineMethod('mci_Make_HMS',3,tkInteger,nil,__mci_Make_HMS,false,0);
    DefineMethod('DIBIndex',1,tkInteger,nil,__DIBIndex,false,0);
    AddConstant('MAXPNAMELEN',MAXPNAMELEN);
    AddConstant('MAXERRORLENGTH',MAXERRORLENGTH);
    AddConstant('MAX_JOYSTICKOEMVXDNAME',MAX_JOYSTICKOEMVXDNAME);
    AddConstant('MM_MICROSOFT',MM_MICROSOFT);
    AddConstant('MM_MIDI_MAPPER',MM_MIDI_MAPPER);
    AddConstant('MM_WAVE_MAPPER',MM_WAVE_MAPPER);
    AddConstant('MM_SNDBLST_MIDIOUT',MM_SNDBLST_MIDIOUT);
    AddConstant('MM_SNDBLST_MIDIIN',MM_SNDBLST_MIDIIN);
    AddConstant('MM_SNDBLST_SYNTH',MM_SNDBLST_SYNTH);
    AddConstant('MM_SNDBLST_WAVEOUT',MM_SNDBLST_WAVEOUT);
    AddConstant('MM_SNDBLST_WAVEIN',MM_SNDBLST_WAVEIN);
    AddConstant('MM_ADLIB',MM_ADLIB);
    AddConstant('MM_MPU401_MIDIOUT',MM_MPU401_MIDIOUT);
    AddConstant('MM_MPU401_MIDIIN',MM_MPU401_MIDIIN);
    AddConstant('MM_PC_JOYSTICK',MM_PC_JOYSTICK);
    AddConstant('TIME_MS',TIME_MS);
    AddConstant('TIME_SAMPLES',TIME_SAMPLES);
    AddConstant('TIME_BYTES',TIME_BYTES);
    AddConstant('TIME_SMPTE',TIME_SMPTE);
    AddConstant('TIME_MIDI',TIME_MIDI);
    AddConstant('TIME_TICKS',TIME_TICKS);
    AddConstant('MM_JOY1MOVE',MM_JOY1MOVE);
    AddConstant('MM_JOY2MOVE',MM_JOY2MOVE);
    AddConstant('MM_JOY1ZMOVE',MM_JOY1ZMOVE);
    AddConstant('MM_JOY2ZMOVE',MM_JOY2ZMOVE);
    AddConstant('MM_JOY1BUTTONDOWN',MM_JOY1BUTTONDOWN);
    AddConstant('MM_JOY2BUTTONDOWN',MM_JOY2BUTTONDOWN);
    AddConstant('MM_JOY1BUTTONUP',MM_JOY1BUTTONUP);
    AddConstant('MM_JOY2BUTTONUP',MM_JOY2BUTTONUP);
    AddConstant('MM_MCINOTIFY',MM_MCINOTIFY);
    AddConstant('MM_WOM_OPEN',MM_WOM_OPEN);
    AddConstant('MM_WOM_CLOSE',MM_WOM_CLOSE);
    AddConstant('MM_WOM_DONE',MM_WOM_DONE);
    AddConstant('MM_WIM_OPEN',MM_WIM_OPEN);
    AddConstant('MM_WIM_CLOSE',MM_WIM_CLOSE);
    AddConstant('MM_WIM_DATA',MM_WIM_DATA);
    AddConstant('MM_MIM_OPEN',MM_MIM_OPEN);
    AddConstant('MM_MIM_CLOSE',MM_MIM_CLOSE);
    AddConstant('MM_MIM_DATA',MM_MIM_DATA);
    AddConstant('MM_MIM_LONGDATA',MM_MIM_LONGDATA);
    AddConstant('MM_MIM_ERROR',MM_MIM_ERROR);
    AddConstant('MM_MIM_LONGERROR',MM_MIM_LONGERROR);
    AddConstant('MM_MOM_OPEN',MM_MOM_OPEN);
    AddConstant('MM_MOM_CLOSE',MM_MOM_CLOSE);
    AddConstant('MM_MOM_DONE',MM_MOM_DONE);
    AddConstant('MM_DRVM_OPEN',MM_DRVM_OPEN);
    AddConstant('MM_DRVM_CLOSE',MM_DRVM_CLOSE);
    AddConstant('MM_DRVM_DATA',MM_DRVM_DATA);
    AddConstant('MM_DRVM_ERROR',MM_DRVM_ERROR);
    AddConstant('MM_STREAM_OPEN',MM_STREAM_OPEN);
    AddConstant('MM_STREAM_CLOSE',MM_STREAM_CLOSE);
    AddConstant('MM_STREAM_DONE',MM_STREAM_DONE);
    AddConstant('MM_STREAM_ERROR',MM_STREAM_ERROR);
    AddConstant('MM_MOM_POSITIONCB',MM_MOM_POSITIONCB);
    AddConstant('MM_MCISIGNAL',MM_MCISIGNAL);
    AddConstant('MM_MIM_MOREDATA',MM_MIM_MOREDATA);
    AddConstant('MM_MIXM_LINE_CHANGE',MM_MIXM_LINE_CHANGE);
    AddConstant('MM_MIXM_CONTROL_CHANGE',MM_MIXM_CONTROL_CHANGE);
    AddConstant('MMSYSERR_BASE',MMSYSERR_BASE);
    AddConstant('WAVERR_BASE',WAVERR_BASE);
    AddConstant('MIDIERR_BASE',MIDIERR_BASE);
    AddConstant('TIMERR_BASE',TIMERR_BASE);
    AddConstant('JOYERR_BASE',JOYERR_BASE);
    AddConstant('MCIERR_BASE',MCIERR_BASE);
    AddConstant('MIXERR_BASE',MIXERR_BASE);
    AddConstant('MCI_STRING_OFFSET',MCI_STRING_OFFSET);
    AddConstant('MCI_VD_OFFSET',MCI_VD_OFFSET);
    AddConstant('MCI_CD_OFFSET',MCI_CD_OFFSET);
    AddConstant('MCI_WAVE_OFFSET',MCI_WAVE_OFFSET);
    AddConstant('MCI_SEQ_OFFSET',MCI_SEQ_OFFSET);
    AddConstant('MMSYSERR_NOERROR',MMSYSERR_NOERROR);
    AddConstant('MMSYSERR_ERROR',MMSYSERR_ERROR);
    AddConstant('MMSYSERR_BADDEVICEID',MMSYSERR_BADDEVICEID);
    AddConstant('MMSYSERR_NOTENABLED',MMSYSERR_NOTENABLED);
    AddConstant('MMSYSERR_ALLOCATED',MMSYSERR_ALLOCATED);
    AddConstant('MMSYSERR_INVALHANDLE',MMSYSERR_INVALHANDLE);
    AddConstant('MMSYSERR_NODRIVER',MMSYSERR_NODRIVER);
    AddConstant('MMSYSERR_NOMEM',MMSYSERR_NOMEM);
    AddConstant('MMSYSERR_NOTSUPPORTED',MMSYSERR_NOTSUPPORTED);
    AddConstant('MMSYSERR_BADERRNUM',MMSYSERR_BADERRNUM);
    AddConstant('MMSYSERR_INVALFLAG',MMSYSERR_INVALFLAG);
    AddConstant('MMSYSERR_INVALPARAM',MMSYSERR_INVALPARAM);
    AddConstant('MMSYSERR_HANDLEBUSY',MMSYSERR_HANDLEBUSY);
    AddConstant('MMSYSERR_INVALIDALIAS',MMSYSERR_INVALIDALIAS);
    AddConstant('MMSYSERR_BADDB',MMSYSERR_BADDB);
    AddConstant('MMSYSERR_KEYNOTFOUND',MMSYSERR_KEYNOTFOUND);
    AddConstant('MMSYSERR_READERROR',MMSYSERR_READERROR);
    AddConstant('MMSYSERR_WRITEERROR',MMSYSERR_WRITEERROR);
    AddConstant('MMSYSERR_DELETEERROR',MMSYSERR_DELETEERROR);
    AddConstant('MMSYSERR_VALNOTFOUND',MMSYSERR_VALNOTFOUND);
    AddConstant('MMSYSERR_NODRIVERCB',MMSYSERR_NODRIVERCB);
    AddConstant('MMSYSERR_LASTERROR',MMSYSERR_LASTERROR);
    AddConstant('DRV_LOAD',DRV_LOAD);
    AddConstant('DRV_ENABLE',DRV_ENABLE);
    AddConstant('DRV_OPEN',DRV_OPEN);
    AddConstant('DRV_CLOSE',DRV_CLOSE);
    AddConstant('DRV_DISABLE',DRV_DISABLE);
    AddConstant('DRV_FREE',DRV_FREE);
    AddConstant('DRV_CONFIGURE',DRV_CONFIGURE);
    AddConstant('DRV_QUERYCONFIGURE',DRV_QUERYCONFIGURE);
    AddConstant('DRV_INSTALL',DRV_INSTALL);
    AddConstant('DRV_REMOVE',DRV_REMOVE);
    AddConstant('DRV_EXITSESSION',DRV_EXITSESSION);
    AddConstant('DRV_POWER',DRV_POWER);
    AddConstant('DRV_RESERVED',DRV_RESERVED);
    AddConstant('DRV_USER',DRV_USER);
    AddConstant('DRVCNF_CANCEL',DRVCNF_CANCEL);
    AddConstant('DRVCNF_OK',DRVCNF_OK);
    AddConstant('DRVCNF_RESTART',DRVCNF_RESTART);
    AddConstant('DRV_CANCEL',DRV_CANCEL);
    AddConstant('DRV_OK',DRV_OK);
    AddConstant('DRV_RESTART',DRV_RESTART);
    AddConstant('DRV_MCI_FIRST',DRV_MCI_FIRST);
    AddConstant('DRV_MCI_LAST',DRV_MCI_LAST);
    AddConstant('CALLBACK_TYPEMASK',CALLBACK_TYPEMASK);
    AddConstant('CALLBACK_NULL',CALLBACK_NULL);
    AddConstant('CALLBACK_WINDOW',CALLBACK_WINDOW);
    AddConstant('CALLBACK_TASK',CALLBACK_TASK);
    AddConstant('CALLBACK_FUNCTION',CALLBACK_FUNCTION);
    AddConstant('CALLBACK_THREAD',CALLBACK_THREAD);
    AddConstant('CALLBACK_EVENT',CALLBACK_EVENT);
    AddConstant('SND_SYNC',SND_SYNC);
    AddConstant('SND_ASYNC',SND_ASYNC);
    AddConstant('SND_NODEFAULT',SND_NODEFAULT);
    AddConstant('SND_MEMORY',SND_MEMORY);
    AddConstant('SND_LOOP',SND_LOOP);
    AddConstant('SND_NOSTOP',SND_NOSTOP);
    AddConstant('SND_NOWAIT',SND_NOWAIT);
    AddConstant('SND_ALIAS',SND_ALIAS);
    AddConstant('SND_ALIAS_ID',SND_ALIAS_ID);
    AddConstant('SND_FILENAME',SND_FILENAME);
    AddConstant('SND_RESOURCE',SND_RESOURCE);
    AddConstant('SND_PURGE',SND_PURGE);
    AddConstant('SND_APPLICATION',SND_APPLICATION);
    AddConstant('SND_ALIAS_START',SND_ALIAS_START);
    AddConstant('SND_ALIAS_SYSTEMASTERISK',SND_ALIAS_SYSTEMASTERISK);
    AddConstant('SND_ALIAS_SYSTEMQUESTION',SND_ALIAS_SYSTEMQUESTION);
    AddConstant('SND_ALIAS_SYSTEMHAND',SND_ALIAS_SYSTEMHAND);
    AddConstant('SND_ALIAS_SYSTEMEXIT',SND_ALIAS_SYSTEMEXIT);
    AddConstant('SND_ALIAS_SYSTEMSTART',SND_ALIAS_SYSTEMSTART);
    AddConstant('SND_ALIAS_SYSTEMWELCOME',SND_ALIAS_SYSTEMWELCOME);
    AddConstant('SND_ALIAS_SYSTEMEXCLAMATION',SND_ALIAS_SYSTEMEXCLAMATION);
    AddConstant('SND_ALIAS_SYSTEMDEFAULT',SND_ALIAS_SYSTEMDEFAULT);
    AddConstant('WAVERR_BADFORMAT',WAVERR_BADFORMAT);
    AddConstant('WAVERR_STILLPLAYING',WAVERR_STILLPLAYING);
    AddConstant('WAVERR_UNPREPARED',WAVERR_UNPREPARED);
    AddConstant('WAVERR_SYNC',WAVERR_SYNC);
    AddConstant('WAVERR_LASTERROR',WAVERR_LASTERROR);
    AddConstant('WOM_OPEN',WOM_OPEN);
    AddConstant('WOM_CLOSE',WOM_CLOSE);
    AddConstant('WOM_DONE',WOM_DONE);
    AddConstant('WIM_OPEN',WIM_OPEN);
    AddConstant('WIM_CLOSE',WIM_CLOSE);
    AddConstant('WIM_DATA',WIM_DATA);
    AddConstant('WAVE_MAPPER',WAVE_MAPPER);
    AddConstant('WAVE_FORMAT_QUERY',WAVE_FORMAT_QUERY);
    AddConstant('WAVE_ALLOWSYNC',WAVE_ALLOWSYNC);
    AddConstant('WAVE_MAPPED',WAVE_MAPPED);
    AddConstant('WHDR_DONE',WHDR_DONE);
    AddConstant('WHDR_PREPARED',WHDR_PREPARED);
    AddConstant('WHDR_BEGINLOOP',WHDR_BEGINLOOP);
    AddConstant('WHDR_ENDLOOP',WHDR_ENDLOOP);
    AddConstant('WHDR_INQUEUE',WHDR_INQUEUE);
    AddConstant('WAVECAPS_PITCH',WAVECAPS_PITCH);
    AddConstant('WAVECAPS_PLAYBACKRATE',WAVECAPS_PLAYBACKRATE);
    AddConstant('WAVECAPS_VOLUME',WAVECAPS_VOLUME);
    AddConstant('WAVECAPS_LRVOLUME',WAVECAPS_LRVOLUME);
    AddConstant('WAVECAPS_SYNC',WAVECAPS_SYNC);
    AddConstant('WAVECAPS_SAMPLEACCURATE',WAVECAPS_SAMPLEACCURATE);
    AddConstant('WAVECAPS_DIRECTSOUND',WAVECAPS_DIRECTSOUND);
    AddConstant('WAVE_INVALIDFORMAT',WAVE_INVALIDFORMAT);
    AddConstant('WAVE_FORMAT_1M08',WAVE_FORMAT_1M08);
    AddConstant('WAVE_FORMAT_1S08',WAVE_FORMAT_1S08);
    AddConstant('WAVE_FORMAT_1M16',WAVE_FORMAT_1M16);
    AddConstant('WAVE_FORMAT_1S16',WAVE_FORMAT_1S16);
    AddConstant('WAVE_FORMAT_2M08',WAVE_FORMAT_2M08);
    AddConstant('WAVE_FORMAT_2S08',WAVE_FORMAT_2S08);
    AddConstant('WAVE_FORMAT_2M16',WAVE_FORMAT_2M16);
    AddConstant('WAVE_FORMAT_2S16',WAVE_FORMAT_2S16);
    AddConstant('WAVE_FORMAT_4M08',WAVE_FORMAT_4M08);
    AddConstant('WAVE_FORMAT_4S08',WAVE_FORMAT_4S08);
    AddConstant('WAVE_FORMAT_4M16',WAVE_FORMAT_4M16);
    AddConstant('WAVE_FORMAT_4S16',WAVE_FORMAT_4S16);
    AddConstant('WAVE_FORMAT_PCM',WAVE_FORMAT_PCM);
    AddConstant('MIDIERR_UNPREPARED',MIDIERR_UNPREPARED);
    AddConstant('MIDIERR_STILLPLAYING',MIDIERR_STILLPLAYING);
    AddConstant('MIDIERR_NOMAP',MIDIERR_NOMAP);
    AddConstant('MIDIERR_NOTREADY',MIDIERR_NOTREADY);
    AddConstant('MIDIERR_NODEVICE',MIDIERR_NODEVICE);
    AddConstant('MIDIERR_INVALIDSETUP',MIDIERR_INVALIDSETUP);
    AddConstant('MIDIERR_BADOPENMODE',MIDIERR_BADOPENMODE);
    AddConstant('MIDIERR_DONT_CONTINUE',MIDIERR_DONT_CONTINUE);
    AddConstant('MIDIERR_LASTERROR',MIDIERR_LASTERROR);
    AddConstant('MIDIPATCHSIZE',MIDIPATCHSIZE);
    AddConstant('MIM_OPEN',MIM_OPEN);
    AddConstant('MIM_CLOSE',MIM_CLOSE);
    AddConstant('MIM_DATA',MIM_DATA);
    AddConstant('MIM_LONGDATA',MIM_LONGDATA);
    AddConstant('MIM_ERROR',MIM_ERROR);
    AddConstant('MIM_LONGERROR',MIM_LONGERROR);
    AddConstant('MOM_OPEN',MOM_OPEN);
    AddConstant('MOM_CLOSE',MOM_CLOSE);
    AddConstant('MOM_DONE',MOM_DONE);
    AddConstant('MIM_MOREDATA',MIM_MOREDATA);
    AddConstant('MOM_POSITIONCB',MOM_POSITIONCB);
    AddConstant('MIDIMAPPER',MIDIMAPPER);
    AddConstant('MIDI_MAPPER',MIDI_MAPPER);
    AddConstant('MIDI_IO_STATUS',MIDI_IO_STATUS);
    AddConstant('MIDI_CACHE_ALL',MIDI_CACHE_ALL);
    AddConstant('MIDI_CACHE_BESTFIT',MIDI_CACHE_BESTFIT);
    AddConstant('MIDI_CACHE_QUERY',MIDI_CACHE_QUERY);
    AddConstant('MIDI_UNCACHE',MIDI_UNCACHE);
    AddConstant('MOD_MIDIPORT',MOD_MIDIPORT);
    AddConstant('MOD_SYNTH',MOD_SYNTH);
    AddConstant('MOD_SQSYNTH',MOD_SQSYNTH);
    AddConstant('MOD_FMSYNTH',MOD_FMSYNTH);
    AddConstant('MOD_MAPPER',MOD_MAPPER);
    AddConstant('MIDICAPS_VOLUME',MIDICAPS_VOLUME);
    AddConstant('MIDICAPS_LRVOLUME',MIDICAPS_LRVOLUME);
    AddConstant('MIDICAPS_CACHE',MIDICAPS_CACHE);
    AddConstant('MIDICAPS_STREAM',MIDICAPS_STREAM);
    AddConstant('MHDR_DONE',MHDR_DONE);
    AddConstant('MHDR_PREPARED',MHDR_PREPARED);
    AddConstant('MHDR_INQUEUE',MHDR_INQUEUE);
    AddConstant('MHDR_ISSTRM',MHDR_ISSTRM);
    AddConstant('MEVT_F_SHORT',MEVT_F_SHORT);
    AddConstant('MEVT_F_LONG',MEVT_F_LONG);
    AddConstant('MEVT_F_CALLBACK',MEVT_F_CALLBACK);
    AddConstant('MEVT_SHORTMSG',MEVT_SHORTMSG);
    AddConstant('MEVT_TEMPO',MEVT_TEMPO);
    AddConstant('MEVT_NOP',MEVT_NOP);
    AddConstant('MEVT_LONGMSG',MEVT_LONGMSG);
    AddConstant('MEVT_COMMENT',MEVT_COMMENT);
    AddConstant('MEVT_VERSION',MEVT_VERSION);
    AddConstant('MIDISTRM_ERROR',MIDISTRM_ERROR);
    AddConstant('MIDIPROP_SET',MIDIPROP_SET);
    AddConstant('MIDIPROP_GET',MIDIPROP_GET);
    AddConstant('MIDIPROP_TIMEDIV',MIDIPROP_TIMEDIV);
    AddConstant('MIDIPROP_TEMPO',MIDIPROP_TEMPO);
    AddConstant('AUX_MAPPER',AUX_MAPPER);
    AddConstant('AUXCAPS_CDAUDIO',AUXCAPS_CDAUDIO);
    AddConstant('AUXCAPS_AUXIN',AUXCAPS_AUXIN);
    AddConstant('AUXCAPS_VOLUME',AUXCAPS_VOLUME);
    AddConstant('AUXCAPS_LRVOLUME',AUXCAPS_LRVOLUME);
    AddConstant('MIXER_SHORT_NAME_CHARS',MIXER_SHORT_NAME_CHARS);
    AddConstant('MIXER_LONG_NAME_CHARS',MIXER_LONG_NAME_CHARS);
    AddConstant('MIXERR_INVALLINE',MIXERR_INVALLINE);
    AddConstant('MIXERR_INVALCONTROL',MIXERR_INVALCONTROL);
    AddConstant('MIXERR_INVALVALUE',MIXERR_INVALVALUE);
    AddConstant('MIXERR_LASTERROR',MIXERR_LASTERROR);
    AddConstant('MIXER_OBJECTF_HANDLE',MIXER_OBJECTF_HANDLE);
    AddConstant('MIXER_OBJECTF_MIXER',MIXER_OBJECTF_MIXER);
    AddConstant('MIXER_OBJECTF_HMIXER',MIXER_OBJECTF_HMIXER);
    AddConstant('MIXER_OBJECTF_WAVEOUT',MIXER_OBJECTF_WAVEOUT);
    AddConstant('MIXER_OBJECTF_HWAVEOUT',MIXER_OBJECTF_HWAVEOUT);
    AddConstant('MIXER_OBJECTF_WAVEIN',MIXER_OBJECTF_WAVEIN);
    AddConstant('MIXER_OBJECTF_HWAVEIN',MIXER_OBJECTF_HWAVEIN);
    AddConstant('MIXER_OBJECTF_MIDIOUT',MIXER_OBJECTF_MIDIOUT);
    AddConstant('MIXER_OBJECTF_HMIDIOUT',MIXER_OBJECTF_HMIDIOUT);
    AddConstant('MIXER_OBJECTF_MIDIIN',MIXER_OBJECTF_MIDIIN);
    AddConstant('MIXER_OBJECTF_HMIDIIN',MIXER_OBJECTF_HMIDIIN);
    AddConstant('MIXER_OBJECTF_AUX',MIXER_OBJECTF_AUX);
    AddConstant('MIXERLINE_LINEF_ACTIVE',MIXERLINE_LINEF_ACTIVE);
    AddConstant('MIXERLINE_LINEF_DISCONNECTED',MIXERLINE_LINEF_DISCONNECTED);
    AddConstant('MIXERLINE_LINEF_SOURCE',MIXERLINE_LINEF_SOURCE);
    AddConstant('MIXERLINE_COMPONENTTYPE_DST_FIRST',MIXERLINE_COMPONENTTYPE_DST_FIRST);
    AddConstant('MIXERLINE_COMPONENTTYPE_DST_UNDEFINED',MIXERLINE_COMPONENTTYPE_DST_UNDEFINED);
    AddConstant('MIXERLINE_COMPONENTTYPE_DST_DIGITAL',MIXERLINE_COMPONENTTYPE_DST_DIGITAL);
    AddConstant('MIXERLINE_COMPONENTTYPE_DST_LINE',MIXERLINE_COMPONENTTYPE_DST_LINE);
    AddConstant('MIXERLINE_COMPONENTTYPE_DST_MONITOR',MIXERLINE_COMPONENTTYPE_DST_MONITOR);
    AddConstant('MIXERLINE_COMPONENTTYPE_DST_SPEAKERS',MIXERLINE_COMPONENTTYPE_DST_SPEAKERS);
    AddConstant('MIXERLINE_COMPONENTTYPE_DST_HEADPHONES',MIXERLINE_COMPONENTTYPE_DST_HEADPHONES);
    AddConstant('MIXERLINE_COMPONENTTYPE_DST_TELEPHONE',MIXERLINE_COMPONENTTYPE_DST_TELEPHONE);
    AddConstant('MIXERLINE_COMPONENTTYPE_DST_WAVEIN',MIXERLINE_COMPONENTTYPE_DST_WAVEIN);
    AddConstant('MIXERLINE_COMPONENTTYPE_DST_VOICEIN',MIXERLINE_COMPONENTTYPE_DST_VOICEIN);
    AddConstant('MIXERLINE_COMPONENTTYPE_DST_LAST',MIXERLINE_COMPONENTTYPE_DST_LAST);
    AddConstant('MIXERLINE_COMPONENTTYPE_SRC_FIRST',MIXERLINE_COMPONENTTYPE_SRC_FIRST);
    AddConstant('MIXERLINE_COMPONENTTYPE_SRC_UNDEFINED',MIXERLINE_COMPONENTTYPE_SRC_UNDEFINED);
    AddConstant('MIXERLINE_COMPONENTTYPE_SRC_DIGITAL',MIXERLINE_COMPONENTTYPE_SRC_DIGITAL);
    AddConstant('MIXERLINE_COMPONENTTYPE_SRC_LINE',MIXERLINE_COMPONENTTYPE_SRC_LINE);
    AddConstant('MIXERLINE_COMPONENTTYPE_SRC_MICROPHONE',MIXERLINE_COMPONENTTYPE_SRC_MICROPHONE);
    AddConstant('MIXERLINE_COMPONENTTYPE_SRC_SYNTHESIZER',MIXERLINE_COMPONENTTYPE_SRC_SYNTHESIZER);
    AddConstant('MIXERLINE_COMPONENTTYPE_SRC_COMPACTDISC',MIXERLINE_COMPONENTTYPE_SRC_COMPACTDISC);
    AddConstant('MIXERLINE_COMPONENTTYPE_SRC_TELEPHONE',MIXERLINE_COMPONENTTYPE_SRC_TELEPHONE);
    AddConstant('MIXERLINE_COMPONENTTYPE_SRC_PCSPEAKER',MIXERLINE_COMPONENTTYPE_SRC_PCSPEAKER);
    AddConstant('MIXERLINE_COMPONENTTYPE_SRC_WAVEOUT',MIXERLINE_COMPONENTTYPE_SRC_WAVEOUT);
    AddConstant('MIXERLINE_COMPONENTTYPE_SRC_AUXILIARY',MIXERLINE_COMPONENTTYPE_SRC_AUXILIARY);
    AddConstant('MIXERLINE_COMPONENTTYPE_SRC_ANALOG',MIXERLINE_COMPONENTTYPE_SRC_ANALOG);
    AddConstant('MIXERLINE_COMPONENTTYPE_SRC_LAST',MIXERLINE_COMPONENTTYPE_SRC_LAST);
    AddConstant('MIXERLINE_TARGETTYPE_UNDEFINED',MIXERLINE_TARGETTYPE_UNDEFINED);
    AddConstant('MIXERLINE_TARGETTYPE_WAVEOUT',MIXERLINE_TARGETTYPE_WAVEOUT);
    AddConstant('MIXERLINE_TARGETTYPE_WAVEIN',MIXERLINE_TARGETTYPE_WAVEIN);
    AddConstant('MIXERLINE_TARGETTYPE_MIDIOUT',MIXERLINE_TARGETTYPE_MIDIOUT);
    AddConstant('MIXERLINE_TARGETTYPE_MIDIIN',MIXERLINE_TARGETTYPE_MIDIIN);
    AddConstant('MIXERLINE_TARGETTYPE_AUX',MIXERLINE_TARGETTYPE_AUX);
    AddConstant('MIXER_GETLINEINFOF_DESTINATION',MIXER_GETLINEINFOF_DESTINATION);
    AddConstant('MIXER_GETLINEINFOF_SOURCE',MIXER_GETLINEINFOF_SOURCE);
    AddConstant('MIXER_GETLINEINFOF_LINEID',MIXER_GETLINEINFOF_LINEID);
    AddConstant('MIXER_GETLINEINFOF_COMPONENTTYPE',MIXER_GETLINEINFOF_COMPONENTTYPE);
    AddConstant('MIXER_GETLINEINFOF_TARGETTYPE',MIXER_GETLINEINFOF_TARGETTYPE);
    AddConstant('MIXER_GETLINEINFOF_QUERYMASK',MIXER_GETLINEINFOF_QUERYMASK);
    AddConstant('MIXERCONTROL_CONTROLF_UNIFORM',MIXERCONTROL_CONTROLF_UNIFORM);
    AddConstant('MIXERCONTROL_CONTROLF_MULTIPLE',MIXERCONTROL_CONTROLF_MULTIPLE);
    AddConstant('MIXERCONTROL_CONTROLF_DISABLED',MIXERCONTROL_CONTROLF_DISABLED);
    AddConstant('MIXERCONTROL_CT_CLASS_MASK',MIXERCONTROL_CT_CLASS_MASK);
    AddConstant('MIXERCONTROL_CT_CLASS_CUSTOM',MIXERCONTROL_CT_CLASS_CUSTOM);
    AddConstant('MIXERCONTROL_CT_CLASS_METER',MIXERCONTROL_CT_CLASS_METER);
    AddConstant('MIXERCONTROL_CT_CLASS_SWITCH',MIXERCONTROL_CT_CLASS_SWITCH);
    AddConstant('MIXERCONTROL_CT_CLASS_NUMBER',MIXERCONTROL_CT_CLASS_NUMBER);
    AddConstant('MIXERCONTROL_CT_CLASS_SLIDER',MIXERCONTROL_CT_CLASS_SLIDER);
    AddConstant('MIXERCONTROL_CT_CLASS_FADER',MIXERCONTROL_CT_CLASS_FADER);
    AddConstant('MIXERCONTROL_CT_CLASS_TIME',MIXERCONTROL_CT_CLASS_TIME);
    AddConstant('MIXERCONTROL_CT_CLASS_LIST',MIXERCONTROL_CT_CLASS_LIST);
    AddConstant('MIXERCONTROL_CT_SUBCLASS_MASK',MIXERCONTROL_CT_SUBCLASS_MASK);
    AddConstant('MIXERCONTROL_CT_SC_SWITCH_BOOLEAN',MIXERCONTROL_CT_SC_SWITCH_BOOLEAN);
    AddConstant('MIXERCONTROL_CT_SC_SWITCH_BUTTON',MIXERCONTROL_CT_SC_SWITCH_BUTTON);
    AddConstant('MIXERCONTROL_CT_SC_METER_POLLED',MIXERCONTROL_CT_SC_METER_POLLED);
    AddConstant('MIXERCONTROL_CT_SC_TIME_MICROSECS',MIXERCONTROL_CT_SC_TIME_MICROSECS);
    AddConstant('MIXERCONTROL_CT_SC_TIME_MILLISECS',MIXERCONTROL_CT_SC_TIME_MILLISECS);
    AddConstant('MIXERCONTROL_CT_SC_LIST_SINGLE',MIXERCONTROL_CT_SC_LIST_SINGLE);
    AddConstant('MIXERCONTROL_CT_SC_LIST_MULTIPLE',MIXERCONTROL_CT_SC_LIST_MULTIPLE);
    AddConstant('MIXERCONTROL_CT_UNITS_MASK',MIXERCONTROL_CT_UNITS_MASK);
    AddConstant('MIXERCONTROL_CT_UNITS_CUSTOM',MIXERCONTROL_CT_UNITS_CUSTOM);
    AddConstant('MIXERCONTROL_CT_UNITS_BOOLEAN',MIXERCONTROL_CT_UNITS_BOOLEAN);
    AddConstant('MIXERCONTROL_CT_UNITS_SIGNED',MIXERCONTROL_CT_UNITS_SIGNED);
    AddConstant('MIXERCONTROL_CT_UNITS_UNSIGNED',MIXERCONTROL_CT_UNITS_UNSIGNED);
    AddConstant('MIXERCONTROL_CT_UNITS_DECIBELS',MIXERCONTROL_CT_UNITS_DECIBELS);
    AddConstant('MIXERCONTROL_CT_UNITS_PERCENT',MIXERCONTROL_CT_UNITS_PERCENT);
    AddConstant('MIXERCONTROL_CONTROLTYPE_CUSTOM',MIXERCONTROL_CONTROLTYPE_CUSTOM);
    AddConstant('MIXERCONTROL_CONTROLTYPE_BOOLEANMETER',MIXERCONTROL_CONTROLTYPE_BOOLEANMETER);
    AddConstant('MIXERCONTROL_CONTROLTYPE_SIGNEDMETER',MIXERCONTROL_CONTROLTYPE_SIGNEDMETER);
    AddConstant('MIXERCONTROL_CONTROLTYPE_PEAKMETER',MIXERCONTROL_CONTROLTYPE_PEAKMETER);
    AddConstant('MIXERCONTROL_CONTROLTYPE_UNSIGNEDMETER',MIXERCONTROL_CONTROLTYPE_UNSIGNEDMETER);
    AddConstant('MIXERCONTROL_CONTROLTYPE_BOOLEAN',MIXERCONTROL_CONTROLTYPE_BOOLEAN);
    AddConstant('MIXERCONTROL_CONTROLTYPE_ONOFF',MIXERCONTROL_CONTROLTYPE_ONOFF);
    AddConstant('MIXERCONTROL_CONTROLTYPE_MUTE',MIXERCONTROL_CONTROLTYPE_MUTE);
    AddConstant('MIXERCONTROL_CONTROLTYPE_MONO',MIXERCONTROL_CONTROLTYPE_MONO);
    AddConstant('MIXERCONTROL_CONTROLTYPE_LOUDNESS',MIXERCONTROL_CONTROLTYPE_LOUDNESS);
    AddConstant('MIXERCONTROL_CONTROLTYPE_STEREOENH',MIXERCONTROL_CONTROLTYPE_STEREOENH);
    AddConstant('MIXERCONTROL_CONTROLTYPE_BUTTON',MIXERCONTROL_CONTROLTYPE_BUTTON);
    AddConstant('MIXERCONTROL_CONTROLTYPE_DECIBELS',MIXERCONTROL_CONTROLTYPE_DECIBELS);
    AddConstant('MIXERCONTROL_CONTROLTYPE_SIGNED',MIXERCONTROL_CONTROLTYPE_SIGNED);
    AddConstant('MIXERCONTROL_CONTROLTYPE_UNSIGNED',MIXERCONTROL_CONTROLTYPE_UNSIGNED);
    AddConstant('MIXERCONTROL_CONTROLTYPE_PERCENT',MIXERCONTROL_CONTROLTYPE_PERCENT);
    AddConstant('MIXERCONTROL_CONTROLTYPE_SLIDER',MIXERCONTROL_CONTROLTYPE_SLIDER);
    AddConstant('MIXERCONTROL_CONTROLTYPE_PAN',MIXERCONTROL_CONTROLTYPE_PAN);
    AddConstant('MIXERCONTROL_CONTROLTYPE_QSOUNDPAN',MIXERCONTROL_CONTROLTYPE_QSOUNDPAN);
    AddConstant('MIXERCONTROL_CONTROLTYPE_FADER',MIXERCONTROL_CONTROLTYPE_FADER);
    AddConstant('MIXERCONTROL_CONTROLTYPE_VOLUME',MIXERCONTROL_CONTROLTYPE_VOLUME);
    AddConstant('MIXERCONTROL_CONTROLTYPE_BASS',MIXERCONTROL_CONTROLTYPE_BASS);
    AddConstant('MIXERCONTROL_CONTROLTYPE_TREBLE',MIXERCONTROL_CONTROLTYPE_TREBLE);
    AddConstant('MIXERCONTROL_CONTROLTYPE_EQUALIZER',MIXERCONTROL_CONTROLTYPE_EQUALIZER);
    AddConstant('MIXERCONTROL_CONTROLTYPE_SINGLESELECT',MIXERCONTROL_CONTROLTYPE_SINGLESELECT);
    AddConstant('MIXERCONTROL_CONTROLTYPE_MUX',MIXERCONTROL_CONTROLTYPE_MUX);
    AddConstant('MIXERCONTROL_CONTROLTYPE_MULTIPLESELECT',MIXERCONTROL_CONTROLTYPE_MULTIPLESELECT);
    AddConstant('MIXERCONTROL_CONTROLTYPE_MIXER',MIXERCONTROL_CONTROLTYPE_MIXER);
    AddConstant('MIXERCONTROL_CONTROLTYPE_MICROTIME',MIXERCONTROL_CONTROLTYPE_MICROTIME);
    AddConstant('MIXERCONTROL_CONTROLTYPE_MILLITIME',MIXERCONTROL_CONTROLTYPE_MILLITIME);
    AddConstant('MIXER_GETLINECONTROLSF_ALL',MIXER_GETLINECONTROLSF_ALL);
    AddConstant('MIXER_GETLINECONTROLSF_ONEBYID',MIXER_GETLINECONTROLSF_ONEBYID);
    AddConstant('MIXER_GETLINECONTROLSF_ONEBYTYPE',MIXER_GETLINECONTROLSF_ONEBYTYPE);
    AddConstant('MIXER_GETLINECONTROLSF_QUERYMASK',MIXER_GETLINECONTROLSF_QUERYMASK);
    AddConstant('MIXER_GETCONTROLDETAILSF_VALUE',MIXER_GETCONTROLDETAILSF_VALUE);
    AddConstant('MIXER_GETCONTROLDETAILSF_LISTTEXT',MIXER_GETCONTROLDETAILSF_LISTTEXT);
    AddConstant('MIXER_GETCONTROLDETAILSF_QUERYMASK',MIXER_GETCONTROLDETAILSF_QUERYMASK);
    AddConstant('MIXER_SETCONTROLDETAILSF_VALUE',MIXER_SETCONTROLDETAILSF_VALUE);
    AddConstant('MIXER_SETCONTROLDETAILSF_CUSTOM',MIXER_SETCONTROLDETAILSF_CUSTOM);
    AddConstant('MIXER_SETCONTROLDETAILSF_QUERYMASK',MIXER_SETCONTROLDETAILSF_QUERYMASK);
    AddConstant('TIMERR_NOERROR',TIMERR_NOERROR);
    AddConstant('TIMERR_NOCANDO',TIMERR_NOCANDO);
    AddConstant('TIMERR_STRUCT',TIMERR_STRUCT);
    AddConstant('TIME_ONESHOT',TIME_ONESHOT);
    AddConstant('TIME_PERIODIC',TIME_PERIODIC);
    AddConstant('TIME_CALLBACK_FUNCTION',TIME_CALLBACK_FUNCTION);
    AddConstant('TIME_CALLBACK_EVENT_SET',TIME_CALLBACK_EVENT_SET);
    AddConstant('TIME_CALLBACK_EVENT_PULSE',TIME_CALLBACK_EVENT_PULSE);
    AddConstant('JOYERR_NOERROR',JOYERR_NOERROR);
    AddConstant('JOYERR_PARMS',JOYERR_PARMS);
    AddConstant('JOYERR_NOCANDO',JOYERR_NOCANDO);
    AddConstant('JOYERR_UNPLUGGED',JOYERR_UNPLUGGED);
    AddConstant('JOY_BUTTON1',JOY_BUTTON1);
    AddConstant('JOY_BUTTON2',JOY_BUTTON2);
    AddConstant('JOY_BUTTON3',JOY_BUTTON3);
    AddConstant('JOY_BUTTON4',JOY_BUTTON4);
    AddConstant('JOY_BUTTON1CHG',JOY_BUTTON1CHG);
    AddConstant('JOY_BUTTON2CHG',JOY_BUTTON2CHG);
    AddConstant('JOY_BUTTON3CHG',JOY_BUTTON3CHG);
    AddConstant('JOY_BUTTON4CHG',JOY_BUTTON4CHG);
    AddConstant('JOY_BUTTON5',JOY_BUTTON5);
    AddConstant('JOY_BUTTON6',JOY_BUTTON6);
    AddConstant('JOY_BUTTON7',JOY_BUTTON7);
    AddConstant('JOY_BUTTON8',JOY_BUTTON8);
    AddConstant('JOY_BUTTON9',JOY_BUTTON9);
    AddConstant('JOY_BUTTON10',JOY_BUTTON10);
    AddConstant('JOY_BUTTON11',JOY_BUTTON11);
    AddConstant('JOY_BUTTON12',JOY_BUTTON12);
    AddConstant('JOY_BUTTON13',JOY_BUTTON13);
    AddConstant('JOY_BUTTON14',JOY_BUTTON14);
    AddConstant('JOY_BUTTON15',JOY_BUTTON15);
    AddConstant('JOY_BUTTON16',JOY_BUTTON16);
    AddConstant('JOY_BUTTON17',JOY_BUTTON17);
    AddConstant('JOY_BUTTON18',JOY_BUTTON18);
    AddConstant('JOY_BUTTON19',JOY_BUTTON19);
    AddConstant('JOY_BUTTON20',JOY_BUTTON20);
    AddConstant('JOY_BUTTON21',JOY_BUTTON21);
    AddConstant('JOY_BUTTON22',JOY_BUTTON22);
    AddConstant('JOY_BUTTON23',JOY_BUTTON23);
    AddConstant('JOY_BUTTON24',JOY_BUTTON24);
    AddConstant('JOY_BUTTON25',JOY_BUTTON25);
    AddConstant('JOY_BUTTON26',JOY_BUTTON26);
    AddConstant('JOY_BUTTON27',JOY_BUTTON27);
    AddConstant('JOY_BUTTON28',JOY_BUTTON28);
    AddConstant('JOY_BUTTON29',JOY_BUTTON29);
    AddConstant('JOY_BUTTON30',JOY_BUTTON30);
    AddConstant('JOY_BUTTON31',JOY_BUTTON31);
    AddConstant('JOY_BUTTON32',JOY_BUTTON32);
    AddConstant('JOY_POVCENTERED',JOY_POVCENTERED);
    AddConstant('JOY_POVFORWARD',JOY_POVFORWARD);
    AddConstant('JOY_POVRIGHT',JOY_POVRIGHT);
    AddConstant('JOY_POVBACKWARD',JOY_POVBACKWARD);
    AddConstant('JOY_POVLEFT',JOY_POVLEFT);
    AddConstant('JOY_RETURNX',JOY_RETURNX);
    AddConstant('JOY_RETURNY',JOY_RETURNY);
    AddConstant('JOY_RETURNZ',JOY_RETURNZ);
    AddConstant('JOY_RETURNR',JOY_RETURNR);
    AddConstant('JOY_RETURNU',JOY_RETURNU);
    AddConstant('JOY_RETURNV',JOY_RETURNV);
    AddConstant('JOY_RETURNPOV',JOY_RETURNPOV);
    AddConstant('JOY_RETURNBUTTONS',JOY_RETURNBUTTONS);
    AddConstant('JOY_RETURNRAWDATA',JOY_RETURNRAWDATA);
    AddConstant('JOY_RETURNPOVCTS',JOY_RETURNPOVCTS);
    AddConstant('JOY_RETURNCENTERED',JOY_RETURNCENTERED);
    AddConstant('JOY_USEDEADZONE',JOY_USEDEADZONE);
    AddConstant('JOY_RETURNALL',JOY_RETURNALL);
    AddConstant('JOY_CAL_READALWAYS',JOY_CAL_READALWAYS);
    AddConstant('JOY_CAL_READXYONLY',JOY_CAL_READXYONLY);
    AddConstant('JOY_CAL_READ3',JOY_CAL_READ3);
    AddConstant('JOY_CAL_READ4',JOY_CAL_READ4);
    AddConstant('JOY_CAL_READXONLY',JOY_CAL_READXONLY);
    AddConstant('JOY_CAL_READYONLY',JOY_CAL_READYONLY);
    AddConstant('JOY_CAL_READ5',JOY_CAL_READ5);
    AddConstant('JOY_CAL_READ6',JOY_CAL_READ6);
    AddConstant('JOY_CAL_READZONLY',JOY_CAL_READZONLY);
    AddConstant('JOY_CAL_READRONLY',JOY_CAL_READRONLY);
    AddConstant('JOY_CAL_READUONLY',JOY_CAL_READUONLY);
    AddConstant('JOY_CAL_READVONLY',JOY_CAL_READVONLY);
    AddConstant('JOYSTICKID1',JOYSTICKID1);
    AddConstant('JOYSTICKID2',JOYSTICKID2);
    AddConstant('JOYCAPS_HASZ',JOYCAPS_HASZ);
    AddConstant('JOYCAPS_HASR',JOYCAPS_HASR);
    AddConstant('JOYCAPS_HASU',JOYCAPS_HASU);
    AddConstant('JOYCAPS_HASV',JOYCAPS_HASV);
    AddConstant('JOYCAPS_HASPOV',JOYCAPS_HASPOV);
    AddConstant('JOYCAPS_POV4DIR',JOYCAPS_POV4DIR);
    AddConstant('JOYCAPS_POVCTS',JOYCAPS_POVCTS);
    AddConstant('MMIOERR_BASE',MMIOERR_BASE);
    AddConstant('MMIOERR_FILENOTFOUND',MMIOERR_FILENOTFOUND);
    AddConstant('MMIOERR_OUTOFMEMORY',MMIOERR_OUTOFMEMORY);
    AddConstant('MMIOERR_CANNOTOPEN',MMIOERR_CANNOTOPEN);
    AddConstant('MMIOERR_CANNOTCLOSE',MMIOERR_CANNOTCLOSE);
    AddConstant('MMIOERR_CANNOTREAD',MMIOERR_CANNOTREAD);
    AddConstant('MMIOERR_CANNOTWRITE',MMIOERR_CANNOTWRITE);
    AddConstant('MMIOERR_CANNOTSEEK',MMIOERR_CANNOTSEEK);
    AddConstant('MMIOERR_CANNOTEXPAND',MMIOERR_CANNOTEXPAND);
    AddConstant('MMIOERR_CHUNKNOTFOUND',MMIOERR_CHUNKNOTFOUND);
    AddConstant('MMIOERR_UNBUFFERED',MMIOERR_UNBUFFERED);
    AddConstant('MMIOERR_PATHNOTFOUND',MMIOERR_PATHNOTFOUND);
    AddConstant('MMIOERR_ACCESSDENIED',MMIOERR_ACCESSDENIED);
    AddConstant('MMIOERR_SHARINGVIOLATION',MMIOERR_SHARINGVIOLATION);
    AddConstant('MMIOERR_NETWORKERROR',MMIOERR_NETWORKERROR);
    AddConstant('MMIOERR_TOOMANYOPENFILES',MMIOERR_TOOMANYOPENFILES);
    AddConstant('MMIOERR_INVALIDFILE',MMIOERR_INVALIDFILE);
    AddConstant('CFSEPCHAR',CFSEPCHAR);
    AddConstant('MMIO_RWMODE',MMIO_RWMODE);
    AddConstant('MMIO_SHAREMODE',MMIO_SHAREMODE);
    AddConstant('MMIO_CREATE',MMIO_CREATE);
    AddConstant('MMIO_PARSE',MMIO_PARSE);
    AddConstant('MMIO_DELETE',MMIO_DELETE);
    AddConstant('MMIO_EXIST',MMIO_EXIST);
    AddConstant('MMIO_ALLOCBUF',MMIO_ALLOCBUF);
    AddConstant('MMIO_GETTEMP',MMIO_GETTEMP);
    AddConstant('MMIO_DIRTY',MMIO_DIRTY);
    AddConstant('MMIO_READ',MMIO_READ);
    AddConstant('MMIO_WRITE',MMIO_WRITE);
    AddConstant('MMIO_READWRITE',MMIO_READWRITE);
    AddConstant('MMIO_COMPAT',MMIO_COMPAT);
    AddConstant('MMIO_EXCLUSIVE',MMIO_EXCLUSIVE);
    AddConstant('MMIO_DENYWRITE',MMIO_DENYWRITE);
    AddConstant('MMIO_DENYREAD',MMIO_DENYREAD);
    AddConstant('MMIO_DENYNONE',MMIO_DENYNONE);
    AddConstant('MMIO_FHOPEN',MMIO_FHOPEN);
    AddConstant('MMIO_EMPTYBUF',MMIO_EMPTYBUF);
    AddConstant('MMIO_TOUPPER',MMIO_TOUPPER);
    AddConstant('MMIO_INSTALLPROC',MMIO_INSTALLPROC);
    AddConstant('MMIO_GLOBALPROC',MMIO_GLOBALPROC);
    AddConstant('MMIO_REMOVEPROC',MMIO_REMOVEPROC);
    AddConstant('MMIO_UNICODEPROC',MMIO_UNICODEPROC);
    AddConstant('MMIO_FINDPROC',MMIO_FINDPROC);
    AddConstant('MMIO_FINDCHUNK',MMIO_FINDCHUNK);
    AddConstant('MMIO_FINDRIFF',MMIO_FINDRIFF);
    AddConstant('MMIO_FINDLIST',MMIO_FINDLIST);
    AddConstant('MMIO_CREATERIFF',MMIO_CREATERIFF);
    AddConstant('MMIO_CREATELIST',MMIO_CREATELIST);
    AddConstant('MMIOM_READ',MMIOM_READ);
    AddConstant('MMIOM_WRITE',MMIOM_WRITE);
    AddConstant('MMIOM_SEEK',MMIOM_SEEK);
    AddConstant('MMIOM_OPEN',MMIOM_OPEN);
    AddConstant('MMIOM_CLOSE',MMIOM_CLOSE);
    AddConstant('MMIOM_WRITEFLUSH',MMIOM_WRITEFLUSH);
    AddConstant('MMIOM_RENAME',MMIOM_RENAME);
    AddConstant('MMIOM_USER',MMIOM_USER);
    AddConstant('FOURCC_RIFF',FOURCC_RIFF);
    AddConstant('FOURCC_LIST',FOURCC_LIST);
    AddConstant('FOURCC_DOS',FOURCC_DOS);
    AddConstant('FOURCC_MEM',FOURCC_MEM);
    AddConstant('SEEK_SET',SEEK_SET);
    AddConstant('SEEK_CUR',SEEK_CUR);
    AddConstant('SEEK_END',SEEK_END);
    AddConstant('MMIO_DEFAULTBUFFER',MMIO_DEFAULTBUFFER);
    AddConstant('MCIERR_INVALID_DEVICE_ID',MCIERR_INVALID_DEVICE_ID);
    AddConstant('MCIERR_UNRECOGNIZED_KEYWORD',MCIERR_UNRECOGNIZED_KEYWORD);
    AddConstant('MCIERR_UNRECOGNIZED_COMMAND',MCIERR_UNRECOGNIZED_COMMAND);
    AddConstant('MCIERR_HARDWARE',MCIERR_HARDWARE);
    AddConstant('MCIERR_INVALID_DEVICE_NAME',MCIERR_INVALID_DEVICE_NAME);
    AddConstant('MCIERR_OUT_OF_MEMORY',MCIERR_OUT_OF_MEMORY);
    AddConstant('MCIERR_DEVICE_OPEN',MCIERR_DEVICE_OPEN);
    AddConstant('MCIERR_CANNOT_LOAD_DRIVER',MCIERR_CANNOT_LOAD_DRIVER);
    AddConstant('MCIERR_MISSING_COMMAND_STRING',MCIERR_MISSING_COMMAND_STRING);
    AddConstant('MCIERR_PARAM_OVERFLOW',MCIERR_PARAM_OVERFLOW);
    AddConstant('MCIERR_MISSING_STRING_ARGUMENT',MCIERR_MISSING_STRING_ARGUMENT);
    AddConstant('MCIERR_BAD_INTEGER',MCIERR_BAD_INTEGER);
    AddConstant('MCIERR_PARSER_INTERNAL',MCIERR_PARSER_INTERNAL);
    AddConstant('MCIERR_DRIVER_INTERNAL',MCIERR_DRIVER_INTERNAL);
    AddConstant('MCIERR_MISSING_PARAMETER',MCIERR_MISSING_PARAMETER);
    AddConstant('MCIERR_UNSUPPORTED_FUNCTION',MCIERR_UNSUPPORTED_FUNCTION);
    AddConstant('MCIERR_FILE_NOT_FOUND',MCIERR_FILE_NOT_FOUND);
    AddConstant('MCIERR_DEVICE_NOT_READY',MCIERR_DEVICE_NOT_READY);
    AddConstant('MCIERR_INTERNAL',MCIERR_INTERNAL);
    AddConstant('MCIERR_DRIVER',MCIERR_DRIVER);
    AddConstant('MCIERR_CANNOT_USE_ALL',MCIERR_CANNOT_USE_ALL);
    AddConstant('MCIERR_MULTIPLE',MCIERR_MULTIPLE);
    AddConstant('MCIERR_EXTENSION_NOT_FOUND',MCIERR_EXTENSION_NOT_FOUND);
    AddConstant('MCIERR_OUTOFRANGE',MCIERR_OUTOFRANGE);
    AddConstant('MCIERR_FLAGS_NOT_COMPATIBLE',MCIERR_FLAGS_NOT_COMPATIBLE);
    AddConstant('MCIERR_FILE_NOT_SAVED',MCIERR_FILE_NOT_SAVED);
    AddConstant('MCIERR_DEVICE_TYPE_REQUIRED',MCIERR_DEVICE_TYPE_REQUIRED);
    AddConstant('MCIERR_DEVICE_LOCKED',MCIERR_DEVICE_LOCKED);
    AddConstant('MCIERR_DUPLICATE_ALIAS',MCIERR_DUPLICATE_ALIAS);
    AddConstant('MCIERR_BAD_CONSTANT',MCIERR_BAD_CONSTANT);
    AddConstant('MCIERR_MUST_USE_SHAREABLE',MCIERR_MUST_USE_SHAREABLE);
    AddConstant('MCIERR_MISSING_DEVICE_NAME',MCIERR_MISSING_DEVICE_NAME);
    AddConstant('MCIERR_BAD_TIME_FORMAT',MCIERR_BAD_TIME_FORMAT);
    AddConstant('MCIERR_NO_CLOSING_QUOTE',MCIERR_NO_CLOSING_QUOTE);
    AddConstant('MCIERR_DUPLICATE_FLAGS',MCIERR_DUPLICATE_FLAGS);
    AddConstant('MCIERR_INVALID_FILE',MCIERR_INVALID_FILE);
    AddConstant('MCIERR_NULL_PARAMETER_BLOCK',MCIERR_NULL_PARAMETER_BLOCK);
    AddConstant('MCIERR_UNNAMED_RESOURCE',MCIERR_UNNAMED_RESOURCE);
    AddConstant('MCIERR_NEW_REQUIRES_ALIAS',MCIERR_NEW_REQUIRES_ALIAS);
    AddConstant('MCIERR_NOTIFY_ON_AUTO_OPEN',MCIERR_NOTIFY_ON_AUTO_OPEN);
    AddConstant('MCIERR_NO_ELEMENT_ALLOWED',MCIERR_NO_ELEMENT_ALLOWED);
    AddConstant('MCIERR_NONAPPLICABLE_FUNCTION',MCIERR_NONAPPLICABLE_FUNCTION);
    AddConstant('MCIERR_ILLEGAL_FOR_AUTO_OPEN',MCIERR_ILLEGAL_FOR_AUTO_OPEN);
    AddConstant('MCIERR_FILENAME_REQUIRED',MCIERR_FILENAME_REQUIRED);
    AddConstant('MCIERR_EXTRA_CHARACTERS',MCIERR_EXTRA_CHARACTERS);
    AddConstant('MCIERR_DEVICE_NOT_INSTALLED',MCIERR_DEVICE_NOT_INSTALLED);
    AddConstant('MCIERR_GET_CD',MCIERR_GET_CD);
    AddConstant('MCIERR_SET_CD',MCIERR_SET_CD);
    AddConstant('MCIERR_SET_DRIVE',MCIERR_SET_DRIVE);
    AddConstant('MCIERR_DEVICE_LENGTH',MCIERR_DEVICE_LENGTH);
    AddConstant('MCIERR_DEVICE_ORD_LENGTH',MCIERR_DEVICE_ORD_LENGTH);
    AddConstant('MCIERR_NO_INTEGER',MCIERR_NO_INTEGER);
    AddConstant('MCIERR_WAVE_OUTPUTSINUSE',MCIERR_WAVE_OUTPUTSINUSE);
    AddConstant('MCIERR_WAVE_SETOUTPUTINUSE',MCIERR_WAVE_SETOUTPUTINUSE);
    AddConstant('MCIERR_WAVE_INPUTSINUSE',MCIERR_WAVE_INPUTSINUSE);
    AddConstant('MCIERR_WAVE_SETINPUTINUSE',MCIERR_WAVE_SETINPUTINUSE);
    AddConstant('MCIERR_WAVE_OUTPUTUNSPECIFIED',MCIERR_WAVE_OUTPUTUNSPECIFIED);
    AddConstant('MCIERR_WAVE_INPUTUNSPECIFIED',MCIERR_WAVE_INPUTUNSPECIFIED);
    AddConstant('MCIERR_WAVE_OUTPUTSUNSUITABLE',MCIERR_WAVE_OUTPUTSUNSUITABLE);
    AddConstant('MCIERR_WAVE_SETOUTPUTUNSUITABLE',MCIERR_WAVE_SETOUTPUTUNSUITABLE);
    AddConstant('MCIERR_WAVE_INPUTSUNSUITABLE',MCIERR_WAVE_INPUTSUNSUITABLE);
    AddConstant('MCIERR_WAVE_SETINPUTUNSUITABLE',MCIERR_WAVE_SETINPUTUNSUITABLE);
    AddConstant('MCIERR_SEQ_DIV_INCOMPATIBLE',MCIERR_SEQ_DIV_INCOMPATIBLE);
    AddConstant('MCIERR_SEQ_PORT_INUSE',MCIERR_SEQ_PORT_INUSE);
    AddConstant('MCIERR_SEQ_PORT_NONEXISTENT',MCIERR_SEQ_PORT_NONEXISTENT);
    AddConstant('MCIERR_SEQ_PORT_MAPNODEVICE',MCIERR_SEQ_PORT_MAPNODEVICE);
    AddConstant('MCIERR_SEQ_PORT_MISCERROR',MCIERR_SEQ_PORT_MISCERROR);
    AddConstant('MCIERR_SEQ_TIMER',MCIERR_SEQ_TIMER);
    AddConstant('MCIERR_SEQ_PORTUNSPECIFIED',MCIERR_SEQ_PORTUNSPECIFIED);
    AddConstant('MCIERR_SEQ_NOMIDIPRESENT',MCIERR_SEQ_NOMIDIPRESENT);
    AddConstant('MCIERR_NO_WINDOW',MCIERR_NO_WINDOW);
    AddConstant('MCIERR_CREATEWINDOW',MCIERR_CREATEWINDOW);
    AddConstant('MCIERR_FILE_READ',MCIERR_FILE_READ);
    AddConstant('MCIERR_FILE_WRITE',MCIERR_FILE_WRITE);
    AddConstant('MCIERR_NO_IDENTITY',MCIERR_NO_IDENTITY);
    AddConstant('MCIERR_CUSTOM_DRIVER_BASE',MCIERR_CUSTOM_DRIVER_BASE);
    AddConstant('MCI_OPEN',MCI_OPEN);
    AddConstant('MCI_CLOSE',MCI_CLOSE);
    AddConstant('MCI_ESCAPE',MCI_ESCAPE);
    AddConstant('MCI_PLAY',MCI_PLAY);
    AddConstant('MCI_SEEK',MCI_SEEK);
    AddConstant('MCI_STOP',MCI_STOP);
    AddConstant('MCI_PAUSE',MCI_PAUSE);
    AddConstant('MCI_INFO',MCI_INFO);
    AddConstant('MCI_GETDEVCAPS',MCI_GETDEVCAPS);
    AddConstant('MCI_SPIN',MCI_SPIN);
    AddConstant('MCI_SET',MCI_SET);
    AddConstant('MCI_STEP',MCI_STEP);
    AddConstant('MCI_RECORD',MCI_RECORD);
    AddConstant('MCI_SYSINFO',MCI_SYSINFO);
    AddConstant('MCI_BREAK',MCI_BREAK);
    AddConstant('MCI_SOUND',MCI_SOUND);
    AddConstant('MCI_SAVE',MCI_SAVE);
    AddConstant('MCI_STATUS',MCI_STATUS);
    AddConstant('MCI_CUE',MCI_CUE);
    AddConstant('MCI_REALIZE',MCI_REALIZE);
    AddConstant('MCI_WINDOW',MCI_WINDOW);
    AddConstant('MCI_PUT',MCI_PUT);
    AddConstant('MCI_WHERE',MCI_WHERE);
    AddConstant('MCI_FREEZE',MCI_FREEZE);
    AddConstant('MCI_UNFREEZE',MCI_UNFREEZE);
    AddConstant('MCI_LOAD',MCI_LOAD);
    AddConstant('MCI_CUT',MCI_CUT);
    AddConstant('MCI_COPY',MCI_COPY);
    AddConstant('MCI_PASTE',MCI_PASTE);
    AddConstant('MCI_UPDATE',MCI_UPDATE);
    AddConstant('MCI_RESUME',MCI_RESUME);
    AddConstant('MCI_DELETE',MCI_DELETE);
    AddConstant('MCI_USER_MESSAGES',MCI_USER_MESSAGES);
    AddConstant('MCI_LAST',MCI_LAST);
    AddConstant('MCI_ALL_DEVICE_ID',MCI_ALL_DEVICE_ID);
    AddConstant('MCI_DEVTYPE_VCR',MCI_DEVTYPE_VCR);
    AddConstant('MCI_DEVTYPE_VIDEODISC',MCI_DEVTYPE_VIDEODISC);
    AddConstant('MCI_DEVTYPE_OVERLAY',MCI_DEVTYPE_OVERLAY);
    AddConstant('MCI_DEVTYPE_CD_AUDIO',MCI_DEVTYPE_CD_AUDIO);
    AddConstant('MCI_DEVTYPE_DAT',MCI_DEVTYPE_DAT);
    AddConstant('MCI_DEVTYPE_SCANNER',MCI_DEVTYPE_SCANNER);
    AddConstant('MCI_DEVTYPE_ANIMATION',MCI_DEVTYPE_ANIMATION);
    AddConstant('MCI_DEVTYPE_DIGITAL_VIDEO',MCI_DEVTYPE_DIGITAL_VIDEO);
    AddConstant('MCI_DEVTYPE_OTHER',MCI_DEVTYPE_OTHER);
    AddConstant('MCI_DEVTYPE_WAVEFORM_AUDIO',MCI_DEVTYPE_WAVEFORM_AUDIO);
    AddConstant('MCI_DEVTYPE_SEQUENCER',MCI_DEVTYPE_SEQUENCER);
    AddConstant('MCI_DEVTYPE_FIRST',MCI_DEVTYPE_FIRST);
    AddConstant('MCI_DEVTYPE_LAST',MCI_DEVTYPE_LAST);
    AddConstant('MCI_DEVTYPE_FIRST_USER',MCI_DEVTYPE_FIRST_USER);
    AddConstant('MCI_MODE_NOT_READY',MCI_MODE_NOT_READY);
    AddConstant('MCI_MODE_STOP',MCI_MODE_STOP);
    AddConstant('MCI_MODE_PLAY',MCI_MODE_PLAY);
    AddConstant('MCI_MODE_RECORD',MCI_MODE_RECORD);
    AddConstant('MCI_MODE_SEEK',MCI_MODE_SEEK);
    AddConstant('MCI_MODE_PAUSE',MCI_MODE_PAUSE);
    AddConstant('MCI_MODE_OPEN',MCI_MODE_OPEN);
    AddConstant('MCI_FORMAT_MILLISECONDS',MCI_FORMAT_MILLISECONDS);
    AddConstant('MCI_FORMAT_HMS',MCI_FORMAT_HMS);
    AddConstant('MCI_FORMAT_MSF',MCI_FORMAT_MSF);
    AddConstant('MCI_FORMAT_FRAMES',MCI_FORMAT_FRAMES);
    AddConstant('MCI_FORMAT_SMPTE_24',MCI_FORMAT_SMPTE_24);
    AddConstant('MCI_FORMAT_SMPTE_25',MCI_FORMAT_SMPTE_25);
    AddConstant('MCI_FORMAT_SMPTE_30',MCI_FORMAT_SMPTE_30);
    AddConstant('MCI_FORMAT_SMPTE_30DROP',MCI_FORMAT_SMPTE_30DROP);
    AddConstant('MCI_FORMAT_BYTES',MCI_FORMAT_BYTES);
    AddConstant('MCI_FORMAT_SAMPLES',MCI_FORMAT_SAMPLES);
    AddConstant('MCI_FORMAT_TMSF',MCI_FORMAT_TMSF);
    AddConstant('MCI_NOTIFY_SUCCESSFUL',MCI_NOTIFY_SUCCESSFUL);
    AddConstant('MCI_NOTIFY_SUPERSEDED',MCI_NOTIFY_SUPERSEDED);
    AddConstant('MCI_NOTIFY_ABORTED',MCI_NOTIFY_ABORTED);
    AddConstant('MCI_NOTIFY_FAILURE',MCI_NOTIFY_FAILURE);
    AddConstant('MCI_NOTIFY',MCI_NOTIFY);
    AddConstant('MCI_WAIT',MCI_WAIT);
    AddConstant('MCI_FROM',MCI_FROM);
    AddConstant('MCI_TO',MCI_TO);
    AddConstant('MCI_TRACK',MCI_TRACK);
    AddConstant('MCI_OPEN_SHAREABLE',MCI_OPEN_SHAREABLE);
    AddConstant('MCI_OPEN_ELEMENT',MCI_OPEN_ELEMENT);
    AddConstant('MCI_OPEN_ALIAS',MCI_OPEN_ALIAS);
    AddConstant('MCI_OPEN_ELEMENT_ID',MCI_OPEN_ELEMENT_ID);
    AddConstant('MCI_OPEN_TYPE_ID',MCI_OPEN_TYPE_ID);
    AddConstant('MCI_OPEN_TYPE',MCI_OPEN_TYPE);
    AddConstant('MCI_SEEK_TO_START',MCI_SEEK_TO_START);
    AddConstant('MCI_SEEK_TO_END',MCI_SEEK_TO_END);
    AddConstant('MCI_STATUS_ITEM',MCI_STATUS_ITEM);
    AddConstant('MCI_STATUS_START',MCI_STATUS_START);
    AddConstant('MCI_STATUS_LENGTH',MCI_STATUS_LENGTH);
    AddConstant('MCI_STATUS_POSITION',MCI_STATUS_POSITION);
    AddConstant('MCI_STATUS_NUMBER_OF_TRACKS',MCI_STATUS_NUMBER_OF_TRACKS);
    AddConstant('MCI_STATUS_MODE',MCI_STATUS_MODE);
    AddConstant('MCI_STATUS_MEDIA_PRESENT',MCI_STATUS_MEDIA_PRESENT);
    AddConstant('MCI_STATUS_TIME_FORMAT',MCI_STATUS_TIME_FORMAT);
    AddConstant('MCI_STATUS_READY',MCI_STATUS_READY);
    AddConstant('MCI_STATUS_CURRENT_TRACK',MCI_STATUS_CURRENT_TRACK);
    AddConstant('MCI_INFO_PRODUCT',MCI_INFO_PRODUCT);
    AddConstant('MCI_INFO_FILE',MCI_INFO_FILE);
    AddConstant('MCI_INFO_MEDIA_UPC',MCI_INFO_MEDIA_UPC);
    AddConstant('MCI_INFO_MEDIA_IDENTITY',MCI_INFO_MEDIA_IDENTITY);
    AddConstant('MCI_INFO_NAME',MCI_INFO_NAME);
    AddConstant('MCI_INFO_COPYRIGHT',MCI_INFO_COPYRIGHT);
    AddConstant('MCI_GETDEVCAPS_ITEM',MCI_GETDEVCAPS_ITEM);
    AddConstant('MCI_GETDEVCAPS_CAN_RECORD',MCI_GETDEVCAPS_CAN_RECORD);
    AddConstant('MCI_GETDEVCAPS_HAS_AUDIO',MCI_GETDEVCAPS_HAS_AUDIO);
    AddConstant('MCI_GETDEVCAPS_HAS_VIDEO',MCI_GETDEVCAPS_HAS_VIDEO);
    AddConstant('MCI_GETDEVCAPS_DEVICE_TYPE',MCI_GETDEVCAPS_DEVICE_TYPE);
    AddConstant('MCI_GETDEVCAPS_USES_FILES',MCI_GETDEVCAPS_USES_FILES);
    AddConstant('MCI_GETDEVCAPS_COMPOUND_DEVICE',MCI_GETDEVCAPS_COMPOUND_DEVICE);
    AddConstant('MCI_GETDEVCAPS_CAN_EJECT',MCI_GETDEVCAPS_CAN_EJECT);
    AddConstant('MCI_GETDEVCAPS_CAN_PLAY',MCI_GETDEVCAPS_CAN_PLAY);
    AddConstant('MCI_GETDEVCAPS_CAN_SAVE',MCI_GETDEVCAPS_CAN_SAVE);
    AddConstant('MCI_SYSINFO_QUANTITY',MCI_SYSINFO_QUANTITY);
    AddConstant('MCI_SYSINFO_OPEN',MCI_SYSINFO_OPEN);
    AddConstant('MCI_SYSINFO_NAME',MCI_SYSINFO_NAME);
    AddConstant('MCI_SYSINFO_INSTALLNAME',MCI_SYSINFO_INSTALLNAME);
    AddConstant('MCI_SET_DOOR_OPEN',MCI_SET_DOOR_OPEN);
    AddConstant('MCI_SET_DOOR_CLOSED',MCI_SET_DOOR_CLOSED);
    AddConstant('MCI_SET_TIME_FORMAT',MCI_SET_TIME_FORMAT);
    AddConstant('MCI_SET_AUDIO',MCI_SET_AUDIO);
    AddConstant('MCI_SET_VIDEO',MCI_SET_VIDEO);
    AddConstant('MCI_SET_ON',MCI_SET_ON);
    AddConstant('MCI_SET_OFF',MCI_SET_OFF);
    AddConstant('MCI_SET_AUDIO_ALL',MCI_SET_AUDIO_ALL);
    AddConstant('MCI_SET_AUDIO_LEFT',MCI_SET_AUDIO_LEFT);
    AddConstant('MCI_SET_AUDIO_RIGHT',MCI_SET_AUDIO_RIGHT);
    AddConstant('MCI_BREAK_KEY',MCI_BREAK_KEY);
    AddConstant('MCI_BREAK_HWND',MCI_BREAK_HWND);
    AddConstant('MCI_BREAK_OFF',MCI_BREAK_OFF);
    AddConstant('MCI_RECORD_INSERT',MCI_RECORD_INSERT);
    AddConstant('MCI_RECORD_OVERWRITE',MCI_RECORD_OVERWRITE);
    AddConstant('MCI_SOUND_NAME',MCI_SOUND_NAME);
    AddConstant('MCI_SAVE_FILE',MCI_SAVE_FILE);
    AddConstant('MCI_LOAD_FILE',MCI_LOAD_FILE);
    AddConstant('MCI_VD_MODE_PARK',MCI_VD_MODE_PARK);
    AddConstant('MCI_VD_MEDIA_CLV',MCI_VD_MEDIA_CLV);
    AddConstant('MCI_VD_MEDIA_CAV',MCI_VD_MEDIA_CAV);
    AddConstant('MCI_VD_MEDIA_OTHER',MCI_VD_MEDIA_OTHER);
    AddConstant('MCI_VD_FORMAT_TRACK',MCI_VD_FORMAT_TRACK);
    AddConstant('MCI_VD_PLAY_REVERSE',MCI_VD_PLAY_REVERSE);
    AddConstant('MCI_VD_PLAY_FAST',MCI_VD_PLAY_FAST);
    AddConstant('MCI_VD_PLAY_SPEED',MCI_VD_PLAY_SPEED);
    AddConstant('MCI_VD_PLAY_SCAN',MCI_VD_PLAY_SCAN);
    AddConstant('MCI_VD_PLAY_SLOW',MCI_VD_PLAY_SLOW);
    AddConstant('MCI_VD_SEEK_REVERSE',MCI_VD_SEEK_REVERSE);
    AddConstant('MCI_VD_STATUS_SPEED',MCI_VD_STATUS_SPEED);
    AddConstant('MCI_VD_STATUS_FORWARD',MCI_VD_STATUS_FORWARD);
    AddConstant('MCI_VD_STATUS_MEDIA_TYPE',MCI_VD_STATUS_MEDIA_TYPE);
    AddConstant('MCI_VD_STATUS_SIDE',MCI_VD_STATUS_SIDE);
    AddConstant('MCI_VD_STATUS_DISC_SIZE',MCI_VD_STATUS_DISC_SIZE);
    AddConstant('MCI_VD_GETDEVCAPS_CLV',MCI_VD_GETDEVCAPS_CLV);
    AddConstant('MCI_VD_GETDEVCAPS_CAV',MCI_VD_GETDEVCAPS_CAV);
    AddConstant('MCI_VD_SPIN_UP',MCI_VD_SPIN_UP);
    AddConstant('MCI_VD_SPIN_DOWN',MCI_VD_SPIN_DOWN);
    AddConstant('MCI_VD_GETDEVCAPS_CAN_REVERSE',MCI_VD_GETDEVCAPS_CAN_REVERSE);
    AddConstant('MCI_VD_GETDEVCAPS_FAST_RATE',MCI_VD_GETDEVCAPS_FAST_RATE);
    AddConstant('MCI_VD_GETDEVCAPS_SLOW_RATE',MCI_VD_GETDEVCAPS_SLOW_RATE);
    AddConstant('MCI_VD_GETDEVCAPS_NORMAL_RATE',MCI_VD_GETDEVCAPS_NORMAL_RATE);
    AddConstant('MCI_VD_STEP_FRAMES',MCI_VD_STEP_FRAMES);
    AddConstant('MCI_VD_STEP_REVERSE',MCI_VD_STEP_REVERSE);
    AddConstant('MCI_VD_ESCAPE_STRING',MCI_VD_ESCAPE_STRING);
    AddConstant('MCI_CDA_STATUS_TYPE_TRACK',MCI_CDA_STATUS_TYPE_TRACK);
    AddConstant('MCI_CDA_TRACK_AUDIO',MCI_CDA_TRACK_AUDIO);
    AddConstant('MCI_CDA_TRACK_OTHER',MCI_CDA_TRACK_OTHER);
    AddConstant('MCI_WAVE_PCM',MCI_WAVE_PCM);
    AddConstant('MCI_WAVE_MAPPER',MCI_WAVE_MAPPER);
    AddConstant('MCI_WAVE_OPEN_BUFFER',MCI_WAVE_OPEN_BUFFER);
    AddConstant('MCI_WAVE_SET_FORMATTAG',MCI_WAVE_SET_FORMATTAG);
    AddConstant('MCI_WAVE_SET_CHANNELS',MCI_WAVE_SET_CHANNELS);
    AddConstant('MCI_WAVE_SET_SAMPLESPERSEC',MCI_WAVE_SET_SAMPLESPERSEC);
    AddConstant('MCI_WAVE_SET_AVGBYTESPERSEC',MCI_WAVE_SET_AVGBYTESPERSEC);
    AddConstant('MCI_WAVE_SET_BLOCKALIGN',MCI_WAVE_SET_BLOCKALIGN);
    AddConstant('MCI_WAVE_SET_BITSPERSAMPLE',MCI_WAVE_SET_BITSPERSAMPLE);
    AddConstant('MCI_WAVE_INPUT',MCI_WAVE_INPUT);
    AddConstant('MCI_WAVE_OUTPUT',MCI_WAVE_OUTPUT);
    AddConstant('MCI_WAVE_STATUS_FORMATTAG',MCI_WAVE_STATUS_FORMATTAG);
    AddConstant('MCI_WAVE_STATUS_CHANNELS',MCI_WAVE_STATUS_CHANNELS);
    AddConstant('MCI_WAVE_STATUS_SAMPLESPERSEC',MCI_WAVE_STATUS_SAMPLESPERSEC);
    AddConstant('MCI_WAVE_STATUS_AVGBYTESPERSEC',MCI_WAVE_STATUS_AVGBYTESPERSEC);
    AddConstant('MCI_WAVE_STATUS_BLOCKALIGN',MCI_WAVE_STATUS_BLOCKALIGN);
    AddConstant('MCI_WAVE_STATUS_BITSPERSAMPLE',MCI_WAVE_STATUS_BITSPERSAMPLE);
    AddConstant('MCI_WAVE_STATUS_LEVEL',MCI_WAVE_STATUS_LEVEL);
    AddConstant('MCI_WAVE_SET_ANYINPUT',MCI_WAVE_SET_ANYINPUT);
    AddConstant('MCI_WAVE_SET_ANYOUTPUT',MCI_WAVE_SET_ANYOUTPUT);
    AddConstant('MCI_WAVE_GETDEVCAPS_INPUTS',MCI_WAVE_GETDEVCAPS_INPUTS);
    AddConstant('MCI_WAVE_GETDEVCAPS_OUTPUTS',MCI_WAVE_GETDEVCAPS_OUTPUTS);
    AddConstant('MCI_SEQ_DIV_PPQN',MCI_SEQ_DIV_PPQN);
    AddConstant('MCI_SEQ_DIV_SMPTE_24',MCI_SEQ_DIV_SMPTE_24);
    AddConstant('MCI_SEQ_DIV_SMPTE_25',MCI_SEQ_DIV_SMPTE_25);
    AddConstant('MCI_SEQ_DIV_SMPTE_30DROP',MCI_SEQ_DIV_SMPTE_30DROP);
    AddConstant('MCI_SEQ_DIV_SMPTE_30',MCI_SEQ_DIV_SMPTE_30);
    AddConstant('MCI_SEQ_FORMAT_SONGPTR',MCI_SEQ_FORMAT_SONGPTR);
    AddConstant('MCI_SEQ_FILE',MCI_SEQ_FILE);
    AddConstant('MCI_SEQ_MIDI',MCI_SEQ_MIDI);
    AddConstant('MCI_SEQ_SMPTE',MCI_SEQ_SMPTE);
    AddConstant('MCI_SEQ_NONE',MCI_SEQ_NONE);
    AddConstant('MCI_SEQ_MAPPER',MCI_SEQ_MAPPER);
    AddConstant('MCI_SEQ_STATUS_TEMPO',MCI_SEQ_STATUS_TEMPO);
    AddConstant('MCI_SEQ_STATUS_PORT',MCI_SEQ_STATUS_PORT);
    AddConstant('MCI_SEQ_STATUS_SLAVE',MCI_SEQ_STATUS_SLAVE);
    AddConstant('MCI_SEQ_STATUS_MASTER',MCI_SEQ_STATUS_MASTER);
    AddConstant('MCI_SEQ_STATUS_OFFSET',MCI_SEQ_STATUS_OFFSET);
    AddConstant('MCI_SEQ_STATUS_DIVTYPE',MCI_SEQ_STATUS_DIVTYPE);
    AddConstant('MCI_SEQ_STATUS_NAME',MCI_SEQ_STATUS_NAME);
    AddConstant('MCI_SEQ_STATUS_COPYRIGHT',MCI_SEQ_STATUS_COPYRIGHT);
    AddConstant('MCI_SEQ_SET_TEMPO',MCI_SEQ_SET_TEMPO);
    AddConstant('MCI_SEQ_SET_PORT',MCI_SEQ_SET_PORT);
    AddConstant('MCI_SEQ_SET_SLAVE',MCI_SEQ_SET_SLAVE);
    AddConstant('MCI_SEQ_SET_MASTER',MCI_SEQ_SET_MASTER);
    AddConstant('MCI_SEQ_SET_OFFSET',MCI_SEQ_SET_OFFSET);
    AddConstant('MCI_ANIM_OPEN_WS',MCI_ANIM_OPEN_WS);
    AddConstant('MCI_ANIM_OPEN_PARENT',MCI_ANIM_OPEN_PARENT);
    AddConstant('MCI_ANIM_OPEN_NOSTATIC',MCI_ANIM_OPEN_NOSTATIC);
    AddConstant('MCI_ANIM_PLAY_SPEED',MCI_ANIM_PLAY_SPEED);
    AddConstant('MCI_ANIM_PLAY_REVERSE',MCI_ANIM_PLAY_REVERSE);
    AddConstant('MCI_ANIM_PLAY_FAST',MCI_ANIM_PLAY_FAST);
    AddConstant('MCI_ANIM_PLAY_SLOW',MCI_ANIM_PLAY_SLOW);
    AddConstant('MCI_ANIM_PLAY_SCAN',MCI_ANIM_PLAY_SCAN);
    AddConstant('MCI_ANIM_STEP_REVERSE',MCI_ANIM_STEP_REVERSE);
    AddConstant('MCI_ANIM_STEP_FRAMES',MCI_ANIM_STEP_FRAMES);
    AddConstant('MCI_ANIM_STATUS_SPEED',MCI_ANIM_STATUS_SPEED);
    AddConstant('MCI_ANIM_STATUS_FORWARD',MCI_ANIM_STATUS_FORWARD);
    AddConstant('MCI_ANIM_STATUS_HWND',MCI_ANIM_STATUS_HWND);
    AddConstant('MCI_ANIM_STATUS_HPAL',MCI_ANIM_STATUS_HPAL);
    AddConstant('MCI_ANIM_STATUS_STRETCH',MCI_ANIM_STATUS_STRETCH);
    AddConstant('MCI_ANIM_INFO_TEXT',MCI_ANIM_INFO_TEXT);
    AddConstant('MCI_ANIM_GETDEVCAPS_CAN_REVERSE',MCI_ANIM_GETDEVCAPS_CAN_REVERSE);
    AddConstant('MCI_ANIM_GETDEVCAPS_FAST_RATE',MCI_ANIM_GETDEVCAPS_FAST_RATE);
    AddConstant('MCI_ANIM_GETDEVCAPS_SLOW_RATE',MCI_ANIM_GETDEVCAPS_SLOW_RATE);
    AddConstant('MCI_ANIM_GETDEVCAPS_NORMAL_RATE',MCI_ANIM_GETDEVCAPS_NORMAL_RATE);
    AddConstant('MCI_ANIM_GETDEVCAPS_PALETTES',MCI_ANIM_GETDEVCAPS_PALETTES);
    AddConstant('MCI_ANIM_GETDEVCAPS_CAN_STRETCH',MCI_ANIM_GETDEVCAPS_CAN_STRETCH);
    AddConstant('MCI_ANIM_GETDEVCAPS_MAX_WINDOWS',MCI_ANIM_GETDEVCAPS_MAX_WINDOWS);
    AddConstant('MCI_ANIM_REALIZE_NORM',MCI_ANIM_REALIZE_NORM);
    AddConstant('MCI_ANIM_REALIZE_BKGD',MCI_ANIM_REALIZE_BKGD);
    AddConstant('MCI_ANIM_WINDOW_HWND',MCI_ANIM_WINDOW_HWND);
    AddConstant('MCI_ANIM_WINDOW_STATE',MCI_ANIM_WINDOW_STATE);
    AddConstant('MCI_ANIM_WINDOW_TEXT',MCI_ANIM_WINDOW_TEXT);
    AddConstant('MCI_ANIM_WINDOW_ENABLE_STRETCH',MCI_ANIM_WINDOW_ENABLE_STRETCH);
    AddConstant('MCI_ANIM_WINDOW_DISABLE_STRETCH',MCI_ANIM_WINDOW_DISABLE_STRETCH);
    AddConstant('MCI_ANIM_WINDOW_DEFAULT',MCI_ANIM_WINDOW_DEFAULT);
    AddConstant('MCI_ANIM_RECT',MCI_ANIM_RECT);
    AddConstant('MCI_ANIM_PUT_SOURCE',MCI_ANIM_PUT_SOURCE);
    AddConstant('MCI_ANIM_PUT_DESTINATION',MCI_ANIM_PUT_DESTINATION);
    AddConstant('MCI_ANIM_WHERE_SOURCE',MCI_ANIM_WHERE_SOURCE);
    AddConstant('MCI_ANIM_WHERE_DESTINATION',MCI_ANIM_WHERE_DESTINATION);
    AddConstant('MCI_ANIM_UPDATE_HDC',MCI_ANIM_UPDATE_HDC);
    AddConstant('MCI_OVLY_OPEN_WS',MCI_OVLY_OPEN_WS);
    AddConstant('MCI_OVLY_OPEN_PARENT',MCI_OVLY_OPEN_PARENT);
    AddConstant('MCI_OVLY_STATUS_HWND',MCI_OVLY_STATUS_HWND);
    AddConstant('MCI_OVLY_STATUS_STRETCH',MCI_OVLY_STATUS_STRETCH);
    AddConstant('MCI_OVLY_INFO_TEXT',MCI_OVLY_INFO_TEXT);
    AddConstant('MCI_OVLY_GETDEVCAPS_CAN_STRETCH',MCI_OVLY_GETDEVCAPS_CAN_STRETCH);
    AddConstant('MCI_OVLY_GETDEVCAPS_CAN_FREEZE',MCI_OVLY_GETDEVCAPS_CAN_FREEZE);
    AddConstant('MCI_OVLY_GETDEVCAPS_MAX_WINDOWS',MCI_OVLY_GETDEVCAPS_MAX_WINDOWS);
    AddConstant('MCI_OVLY_WINDOW_HWND',MCI_OVLY_WINDOW_HWND);
    AddConstant('MCI_OVLY_WINDOW_STATE',MCI_OVLY_WINDOW_STATE);
    AddConstant('MCI_OVLY_WINDOW_TEXT',MCI_OVLY_WINDOW_TEXT);
    AddConstant('MCI_OVLY_WINDOW_ENABLE_STRETCH',MCI_OVLY_WINDOW_ENABLE_STRETCH);
    AddConstant('MCI_OVLY_WINDOW_DISABLE_STRETCH',MCI_OVLY_WINDOW_DISABLE_STRETCH);
    AddConstant('MCI_OVLY_WINDOW_DEFAULT',MCI_OVLY_WINDOW_DEFAULT);
    AddConstant('MCI_OVLY_RECT',MCI_OVLY_RECT);
    AddConstant('MCI_OVLY_PUT_SOURCE',MCI_OVLY_PUT_SOURCE);
    AddConstant('MCI_OVLY_PUT_DESTINATION',MCI_OVLY_PUT_DESTINATION);
    AddConstant('MCI_OVLY_PUT_FRAME',MCI_OVLY_PUT_FRAME);
    AddConstant('MCI_OVLY_PUT_VIDEO',MCI_OVLY_PUT_VIDEO);
    AddConstant('MCI_OVLY_WHERE_SOURCE',MCI_OVLY_WHERE_SOURCE);
    AddConstant('MCI_OVLY_WHERE_DESTINATION',MCI_OVLY_WHERE_DESTINATION);
    AddConstant('MCI_OVLY_WHERE_FRAME',MCI_OVLY_WHERE_FRAME);
    AddConstant('MCI_OVLY_WHERE_VIDEO',MCI_OVLY_WHERE_VIDEO);
    AddConstant('NEWTRANSPARENT',NEWTRANSPARENT);
    AddConstant('QUERYROPSUPPORT',QUERYROPSUPPORT);
    AddConstant('SELECTDIB',SELECTDIB);
    AddConstant('SC_SCREENSAVE',SC_SCREENSAVE);
    AddConstant('mmsyst',mmsyst);
  end;
end;

class function TatMMSystemLibrary.LibraryName: string;
begin
  result := 'MMSystem';
end;

initialization
  RegisterScripterLibrary(TatMMSystemLibrary, True);

{$WARNINGS ON}

end.

