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
unit ap_Messages;

interface

uses
  Windows,
  Messages,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatMessagesLibrary = class(TatScripterLibrary)
    procedure Init; override;
    class function LibraryName: string; override;
  end;



  TMessageWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FWParam: Longint;
    FLParam: Longint;
    FResult: Longint;
    FWParamLo: Word;
    FWParamHi: Word;
    FLParamLo: Word;
    FLParamHi: Word;
    FResultLo: Word;
    FResultHi: Word;
  public
    constructor Create(ARecord: TMessage);
    function ObjToRec: TMessage;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property WParam: Longint read FWParam write FWParam;
    property LParam: Longint read FLParam write FLParam;
    property Result: Longint read FResult write FResult;
    property WParamLo: Word read FWParamLo write FWParamLo;
    property WParamHi: Word read FWParamHi write FWParamHi;
    property LParamLo: Word read FLParamLo write FLParamLo;
    property LParamHi: Word read FLParamHi write FLParamHi;
    property ResultLo: Word read FResultLo write FResultLo;
    property ResultHi: Word read FResultHi write FResultHi;
  end;
  
  TWMNoParamsWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMNoParams);
    function ObjToRec: TWMNoParams;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMKeyWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FCharCode: Word;
    FUnused: Word;
    FKeyData: Longint;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMKey);
    function ObjToRec: TWMKey;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property CharCode: Word read FCharCode write FCharCode;
    property Unused: Word read FUnused write FUnused;
    property KeyData: Longint read FKeyData write FKeyData;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMMouseWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FKeys: Longint;
    FXPos: Smallint;
    FYPos: Smallint;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMMouse);
    function ObjToRec: TWMMouse;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property Keys: Longint read FKeys write FKeys;
    property XPos: Smallint read FXPos write FXPos;
    property YPos: Smallint read FYPos write FYPos;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMMouseWheelWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FKeys: SmallInt;
    FWheelDelta: SmallInt;
    FXPos: Smallint;
    FYPos: Smallint;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMMouseWheel);
    function ObjToRec: TWMMouseWheel;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property Keys: SmallInt read FKeys write FKeys;
    property WheelDelta: SmallInt read FWheelDelta write FWheelDelta;
    property XPos: Smallint read FXPos write FXPos;
    property YPos: Smallint read FYPos write FYPos;
    property Result: Longint read FResult write FResult;
  end;
  
  TMSHMouseWheelWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FWheelDelta: Integer;
    FXPos: Smallint;
    FYPos: Smallint;
    FResult: Longint;
  public
    constructor Create(ARecord: TMSHMouseWheel);
    function ObjToRec: TMSHMouseWheel;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property WheelDelta: Integer read FWheelDelta write FWheelDelta;
    property XPos: Smallint read FXPos write FXPos;
    property YPos: Smallint read FYPos write FYPos;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMWindowPosMsgWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FUnused: Integer;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMWindowPosMsg);
    function ObjToRec: TWMWindowPosMsg;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property Unused: Integer read FUnused write FUnused;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMScrollWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FScrollCode: Smallint;
    FPos: Smallint;
    FScrollBar: HWND;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMScroll);
    function ObjToRec: TWMScroll;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property ScrollCode: Smallint read FScrollCode write FScrollCode;
    property Pos: Smallint read FPos write FPos;
    property ScrollBar: HWND read FScrollBar write FScrollBar;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMActivateWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FActive: Word;
    FMinimized: WordBool;
    FActiveWindow: HWND;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMActivate);
    function ObjToRec: TWMActivate;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property Active: Word read FActive write FActive;
    property Minimized: WordBool read FMinimized write FMinimized;
    property ActiveWindow: HWND read FActiveWindow write FActiveWindow;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMActivateAppWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FActive: BOOL;
    FThreadId: Longint;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMActivateApp);
    function ObjToRec: TWMActivateApp;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property Active: BOOL read FActive write FActive;
    property ThreadId: Longint read FThreadId write FThreadId;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMAskCBFormatNameWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FNameLen: Word;
    FUnused: Word;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMAskCBFormatName);
    function ObjToRec: TWMAskCBFormatName;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property NameLen: Word read FNameLen write FNameLen;
    property Unused: Word read FUnused write FUnused;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMChangeCBChainWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FRemove: HWND;
    FNext: HWND;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMChangeCBChain);
    function ObjToRec: TWMChangeCBChain;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property Remove: HWND read FRemove write FRemove;
    property Next: HWND read FNext write FNext;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMCharToItemWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FKey: Word;
    FCaretPos: Word;
    FListBox: HWND;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMCharToItem);
    function ObjToRec: TWMCharToItem;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property Key: Word read FKey write FKey;
    property CaretPos: Word read FCaretPos write FCaretPos;
    property ListBox: HWND read FListBox write FListBox;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMChooseFont_GetLogFontWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FUnused: Longint;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMChooseFont_GetLogFont);
    function ObjToRec: TWMChooseFont_GetLogFont;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property Unused: Longint read FUnused write FUnused;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMCommandWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FItemID: Word;
    FNotifyCode: Word;
    FCtl: HWND;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMCommand);
    function ObjToRec: TWMCommand;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property ItemID: Word read FItemID write FItemID;
    property NotifyCode: Word read FNotifyCode write FNotifyCode;
    property Ctl: HWND read FCtl write FCtl;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMCompactingWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FCompactRatio: Longint;
    FUnused: Longint;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMCompacting);
    function ObjToRec: TWMCompacting;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property CompactRatio: Longint read FCompactRatio write FCompactRatio;
    property Unused: Longint read FUnused write FUnused;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMCompareItemWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FCtl: HWnd;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMCompareItem);
    function ObjToRec: TWMCompareItem;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property Ctl: HWnd read FCtl write FCtl;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMCopyDataWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FFrom: HWND;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMCopyData);
    function ObjToRec: TWMCopyData;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property From: HWND read FFrom write FFrom;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMCreateWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FUnused: Integer;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMCreate);
    function ObjToRec: TWMCreate;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property Unused: Integer read FUnused write FUnused;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMCtlColorWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FChildDC: HDC;
    FChildWnd: HWND;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMCtlColor);
    function ObjToRec: TWMCtlColor;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property ChildDC: HDC read FChildDC write FChildDC;
    property ChildWnd: HWND read FChildWnd write FChildWnd;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMDDE_AckWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FPostingApp: HWND;
    FApp: Word;
    FTopic: Word;
    FResult: Longint;
    FPackedVal: Longint;
  public
    constructor Create(ARecord: TWMDDE_Ack);
    function ObjToRec: TWMDDE_Ack;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property PostingApp: HWND read FPostingApp write FPostingApp;
    property App: Word read FApp write FApp;
    property Topic: Word read FTopic write FTopic;
    property Result: Longint read FResult write FResult;
    property PackedVal: Longint read FPackedVal write FPackedVal;
  end;
  
  TWMDDE_AdviseWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FPostingApp: HWND;
    FPackedVal: Longint;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMDDE_Advise);
    function ObjToRec: TWMDDE_Advise;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property PostingApp: HWND read FPostingApp write FPostingApp;
    property PackedVal: Longint read FPackedVal write FPackedVal;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMDDE_DataWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FPostingApp: HWND;
    FPackedVal: Longint;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMDDE_Data);
    function ObjToRec: TWMDDE_Data;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property PostingApp: HWND read FPostingApp write FPostingApp;
    property PackedVal: Longint read FPackedVal write FPackedVal;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMDDE_ExecuteWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FPostingApp: HWND;
    FCommands: THandle;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMDDE_Execute);
    function ObjToRec: TWMDDE_Execute;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property PostingApp: HWND read FPostingApp write FPostingApp;
    property Commands: THandle read FCommands write FCommands;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMDDE_InitiateWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FPostingApp: HWND;
    FApp: Word;
    FTopic: Word;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMDDE_Initiate);
    function ObjToRec: TWMDDE_Initiate;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property PostingApp: HWND read FPostingApp write FPostingApp;
    property App: Word read FApp write FApp;
    property Topic: Word read FTopic write FTopic;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMDDE_PokeWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FPostingApp: HWND;
    FPackedVal: Longint;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMDDE_Poke);
    function ObjToRec: TWMDDE_Poke;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property PostingApp: HWND read FPostingApp write FPostingApp;
    property PackedVal: Longint read FPackedVal write FPackedVal;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMDDE_RequestWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FPostingApp: HWND;
    FFormat: Word;
    FItem: Word;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMDDE_Request);
    function ObjToRec: TWMDDE_Request;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property PostingApp: HWND read FPostingApp write FPostingApp;
    property Format: Word read FFormat write FFormat;
    property Item: Word read FItem write FItem;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMDDE_TerminateWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FPostingApp: HWND;
    FUnused: Longint;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMDDE_Terminate);
    function ObjToRec: TWMDDE_Terminate;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property PostingApp: HWND read FPostingApp write FPostingApp;
    property Unused: Longint read FUnused write FUnused;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMDDE_UnadviseWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FPostingApp: HWND;
    FFormat: Word;
    FItem: Word;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMDDE_Unadvise);
    function ObjToRec: TWMDDE_Unadvise;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property PostingApp: HWND read FPostingApp write FPostingApp;
    property Format: Word read FFormat write FFormat;
    property Item: Word read FItem write FItem;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMDeleteItemWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FCtl: HWND;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMDeleteItem);
    function ObjToRec: TWMDeleteItem;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property Ctl: HWND read FCtl write FCtl;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMDevModeChangeWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FUnused: Integer;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMDevModeChange);
    function ObjToRec: TWMDevModeChange;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property Unused: Integer read FUnused write FUnused;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMDrawItemWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FCtl: HWND;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMDrawItem);
    function ObjToRec: TWMDrawItem;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property Ctl: HWND read FCtl write FCtl;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMDropFilesWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FDrop: THANDLE;
    FUnused: Longint;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMDropFiles);
    function ObjToRec: TWMDropFiles;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property Drop: THANDLE read FDrop write FDrop;
    property Unused: Longint read FUnused write FUnused;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMEnableWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FEnabled: LongBool;
    FUnused: Longint;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMEnable);
    function ObjToRec: TWMEnable;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property Enabled: LongBool read FEnabled write FEnabled;
    property Unused: Longint read FUnused write FUnused;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMEndSessionWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FEndSession: LongBool;
    FUnused: Longint;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMEndSession);
    function ObjToRec: TWMEndSession;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property EndSession: LongBool read FEndSession write FEndSession;
    property Unused: Longint read FUnused write FUnused;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMEnterIdleWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FSource: Longint;
    FIdleWnd: HWND;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMEnterIdle);
    function ObjToRec: TWMEnterIdle;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property Source: Longint read FSource write FSource;
    property IdleWnd: HWND read FIdleWnd write FIdleWnd;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMEnterMenuLoopWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FIsTrackPopupMenu: LongBool;
    FUnused: Longint;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMEnterMenuLoop);
    function ObjToRec: TWMEnterMenuLoop;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property IsTrackPopupMenu: LongBool read FIsTrackPopupMenu write FIsTrackPopupMenu;
    property Unused: Longint read FUnused write FUnused;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMEraseBkgndWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FDC: HDC;
    FUnused: Longint;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMEraseBkgnd);
    function ObjToRec: TWMEraseBkgnd;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property DC: HDC read FDC write FDC;
    property Unused: Longint read FUnused write FUnused;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMGetIconWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FBigIcon: Longbool;
    FUnused: Longint;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMGetIcon);
    function ObjToRec: TWMGetIcon;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property BigIcon: Longbool read FBigIcon write FBigIcon;
    property Unused: Longint read FUnused write FUnused;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMGetMinMaxInfoWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FUnused: Integer;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMGetMinMaxInfo);
    function ObjToRec: TWMGetMinMaxInfo;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property Unused: Integer read FUnused write FUnused;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMGetTextWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FTextMax: Integer;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMGetText);
    function ObjToRec: TWMGetText;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property TextMax: Integer read FTextMax write FTextMax;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMHotKeyWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FHotKey: Longint;
    FUnused: Longint;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMHotKey);
    function ObjToRec: TWMHotKey;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property HotKey: Longint read FHotKey write FHotKey;
    property Unused: Longint read FUnused write FUnused;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMHScrollClipboardWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FViewer: HWND;
    FScrollCode: Word;
    FPos: Word;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMHScrollClipboard);
    function ObjToRec: TWMHScrollClipboard;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property Viewer: HWND read FViewer write FViewer;
    property ScrollCode: Word read FScrollCode write FScrollCode;
    property Pos: Word read FPos write FPos;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMInitDialogWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FFocus: HWND;
    FInitParam: Longint;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMInitDialog);
    function ObjToRec: TWMInitDialog;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property Focus: HWND read FFocus write FFocus;
    property InitParam: Longint read FInitParam write FInitParam;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMInitMenuWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FMenu: HMENU;
    FUnused: Longint;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMInitMenu);
    function ObjToRec: TWMInitMenu;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property Menu: HMENU read FMenu write FMenu;
    property Unused: Longint read FUnused write FUnused;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMInitMenuPopupWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FMenuPopup: HMENU;
    FPos: Smallint;
    FSystemMenu: WordBool;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMInitMenuPopup);
    function ObjToRec: TWMInitMenuPopup;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property MenuPopup: HMENU read FMenuPopup write FMenuPopup;
    property Pos: Smallint read FPos write FPos;
    property SystemMenu: WordBool read FSystemMenu write FSystemMenu;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMKillFocusWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FFocusedWnd: HWND;
    FUnused: Longint;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMKillFocus);
    function ObjToRec: TWMKillFocus;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property FocusedWnd: HWND read FFocusedWnd write FFocusedWnd;
    property Unused: Longint read FUnused write FUnused;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMMDIActivateWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FChildWnd: HWND;
    FDeactiveWnd: HWND;
    FActiveWnd: HWND;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMMDIActivate);
    function ObjToRec: TWMMDIActivate;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property ChildWnd: HWND read FChildWnd write FChildWnd;
    property DeactiveWnd: HWND read FDeactiveWnd write FDeactiveWnd;
    property ActiveWnd: HWND read FActiveWnd write FActiveWnd;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMMDICascadeWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FCascade: Longint;
    FUnused: Longint;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMMDICascade);
    function ObjToRec: TWMMDICascade;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property Cascade: Longint read FCascade write FCascade;
    property Unused: Longint read FUnused write FUnused;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMMDICreateWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FUnused: Integer;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMMDICreate);
    function ObjToRec: TWMMDICreate;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property Unused: Integer read FUnused write FUnused;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMMDIDestroyWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FChild: HWND;
    FUnused: Longint;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMMDIDestroy);
    function ObjToRec: TWMMDIDestroy;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property Child: HWND read FChild write FChild;
    property Unused: Longint read FUnused write FUnused;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMMDIMaximizeWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FMaximize: HWND;
    FUnused: Longint;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMMDIMaximize);
    function ObjToRec: TWMMDIMaximize;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property Maximize: HWND read FMaximize write FMaximize;
    property Unused: Longint read FUnused write FUnused;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMMDINextWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FChild: HWND;
    FNext: Longint;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMMDINext);
    function ObjToRec: TWMMDINext;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property Child: HWND read FChild write FChild;
    property Next: Longint read FNext write FNext;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMMDIRestoreWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FIDChild: HWND;
    FUnused: Longint;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMMDIRestore);
    function ObjToRec: TWMMDIRestore;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property IDChild: HWND read FIDChild write FIDChild;
    property Unused: Longint read FUnused write FUnused;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMMDISetMenuWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FMenuFrame: HMENU;
    FMenuWindow: HMENU;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMMDISetMenu);
    function ObjToRec: TWMMDISetMenu;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property MenuFrame: HMENU read FMenuFrame write FMenuFrame;
    property MenuWindow: HMENU read FMenuWindow write FMenuWindow;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMMDITileWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FTile: Longint;
    FUnused: Longint;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMMDITile);
    function ObjToRec: TWMMDITile;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property Tile: Longint read FTile write FTile;
    property Unused: Longint read FUnused write FUnused;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMMeasureItemWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FIDCtl: HWnd;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMMeasureItem);
    function ObjToRec: TWMMeasureItem;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property IDCtl: HWnd read FIDCtl write FIDCtl;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMMenuCharWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FUser: Char;
    FUnused: Byte;
    FMenuFlag: Word;
    FMenu: HMENU;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMMenuChar);
    function ObjToRec: TWMMenuChar;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property User: Char read FUser write FUser;
    property Unused: Byte read FUnused write FUnused;
    property MenuFlag: Word read FMenuFlag write FMenuFlag;
    property Menu: HMENU read FMenu write FMenu;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMMenuSelectWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FIDItem: Word;
    FMenuFlag: Word;
    FMenu: HMENU;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMMenuSelect);
    function ObjToRec: TWMMenuSelect;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property IDItem: Word read FIDItem write FIDItem;
    property MenuFlag: Word read FMenuFlag write FMenuFlag;
    property Menu: HMENU read FMenu write FMenu;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMMouseActivateWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FTopLevel: HWND;
    FHitTestCode: Word;
    FMouseMsg: Word;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMMouseActivate);
    function ObjToRec: TWMMouseActivate;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property TopLevel: HWND read FTopLevel write FTopLevel;
    property HitTestCode: Word read FHitTestCode write FHitTestCode;
    property MouseMsg: Word read FMouseMsg write FMouseMsg;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMMoveWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FUnused: Integer;
    FXPos: Smallint;
    FYPos: Smallint;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMMove);
    function ObjToRec: TWMMove;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property Unused: Integer read FUnused write FUnused;
    property XPos: Smallint read FXPos write FXPos;
    property YPos: Smallint read FYPos write FYPos;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMNCActivateWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FActive: BOOL;
    FUnused: Longint;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMNCActivate);
    function ObjToRec: TWMNCActivate;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property Active: BOOL read FActive write FActive;
    property Unused: Longint read FUnused write FUnused;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMNCCalcSizeWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FCalcValidRects: BOOL;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMNCCalcSize);
    function ObjToRec: TWMNCCalcSize;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property CalcValidRects: BOOL read FCalcValidRects write FCalcValidRects;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMNCCreateWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FUnused: Integer;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMNCCreate);
    function ObjToRec: TWMNCCreate;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property Unused: Integer read FUnused write FUnused;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMNCHitTestWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FUnused: Longint;
    FXPos: Smallint;
    FYPos: Smallint;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMNCHitTest);
    function ObjToRec: TWMNCHitTest;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property Unused: Longint read FUnused write FUnused;
    property XPos: Smallint read FXPos write FXPos;
    property YPos: Smallint read FYPos write FYPos;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMNCHitMessageWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FHitTest: Longint;
    FXCursor: Smallint;
    FYCursor: Smallint;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMNCHitMessage);
    function ObjToRec: TWMNCHitMessage;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property HitTest: Longint read FHitTest write FHitTest;
    property XCursor: Smallint read FXCursor write FXCursor;
    property YCursor: Smallint read FYCursor write FYCursor;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMNCPaintWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FRGN: HRGN;
    FUnused: Longint;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMNCPaint);
    function ObjToRec: TWMNCPaint;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property RGN: HRGN read FRGN write FRGN;
    property Unused: Longint read FUnused write FUnused;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMNextDlgCtlWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FCtlFocus: Longint;
    FHandle: WordBool;
    FUnused: Word;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMNextDlgCtl);
    function ObjToRec: TWMNextDlgCtl;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property CtlFocus: Longint read FCtlFocus write FCtlFocus;
    property Handle: WordBool read FHandle write FHandle;
    property Unused: Word read FUnused write FUnused;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMNotifyWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FIDCtrl: Longint;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMNotify);
    function ObjToRec: TWMNotify;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property IDCtrl: Longint read FIDCtrl write FIDCtrl;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMNotifyFormatWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FFrom: HWND;
    FCommand: Longint;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMNotifyFormat);
    function ObjToRec: TWMNotifyFormat;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property From: HWND read FFrom write FFrom;
    property Command: Longint read FCommand write FCommand;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMPaintWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FDC: HDC;
    FUnused: Longint;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMPaint);
    function ObjToRec: TWMPaint;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property DC: HDC read FDC write FDC;
    property Unused: Longint read FUnused write FUnused;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMPaintClipboardWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FViewer: HWND;
    FPaintStruct: THandle;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMPaintClipboard);
    function ObjToRec: TWMPaintClipboard;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property Viewer: HWND read FViewer write FViewer;
    property PaintStruct: THandle read FPaintStruct write FPaintStruct;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMPaletteChangedWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FPalChg: HWND;
    FUnused: Longint;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMPaletteChanged);
    function ObjToRec: TWMPaletteChanged;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property PalChg: HWND read FPalChg write FPalChg;
    property Unused: Longint read FUnused write FUnused;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMPaletteIsChangingWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FRealize: HWND;
    FUnused: Longint;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMPaletteIsChanging);
    function ObjToRec: TWMPaletteIsChanging;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property Realize: HWND read FRealize write FRealize;
    property Unused: Longint read FUnused write FUnused;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMParentNotifyWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FChildID: Word;
    FChildWnd: HWnd;
    FValue: Word;
    FXPos: Smallint;
    FYPos: Smallint;
    FValue1: Word;
    FValue2: Longint;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMParentNotify);
    function ObjToRec: TWMParentNotify;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property ChildID: Word read FChildID write FChildID;
    property ChildWnd: HWnd read FChildWnd write FChildWnd;
    property Value: Word read FValue write FValue;
    property XPos: Smallint read FXPos write FXPos;
    property YPos: Smallint read FYPos write FYPos;
    property Value1: Word read FValue1 write FValue1;
    property Value2: Longint read FValue2 write FValue2;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMPowerWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FPowerEvt: Longint;
    FUnused: Longint;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMPower);
    function ObjToRec: TWMPower;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property PowerEvt: Longint read FPowerEvt write FPowerEvt;
    property Unused: Longint read FUnused write FUnused;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMQueryEndSessionWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FSource: Longint;
    FUnused: Longint;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMQueryEndSession);
    function ObjToRec: TWMQueryEndSession;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property Source: Longint read FSource write FSource;
    property Unused: Longint read FUnused write FUnused;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMQuitWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FExitCode: Longint;
    FUnused: Longint;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMQuit);
    function ObjToRec: TWMQuit;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property ExitCode: Longint read FExitCode write FExitCode;
    property Unused: Longint read FUnused write FUnused;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMRenderFormatWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FFormat: Longint;
    FUnused: Longint;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMRenderFormat);
    function ObjToRec: TWMRenderFormat;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property Format: Longint read FFormat write FFormat;
    property Unused: Longint read FUnused write FUnused;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMSetCursorWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FCursorWnd: HWND;
    FHitTest: Word;
    FMouseMsg: Word;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMSetCursor);
    function ObjToRec: TWMSetCursor;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property CursorWnd: HWND read FCursorWnd write FCursorWnd;
    property HitTest: Word read FHitTest write FHitTest;
    property MouseMsg: Word read FMouseMsg write FMouseMsg;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMSetFocusWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FFocusedWnd: HWND;
    FUnused: Longint;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMSetFocus);
    function ObjToRec: TWMSetFocus;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property FocusedWnd: HWND read FFocusedWnd write FFocusedWnd;
    property Unused: Longint read FUnused write FUnused;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMSetFontWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FFont: HFONT;
    FRedraw: WordBool;
    FUnused: Word;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMSetFont);
    function ObjToRec: TWMSetFont;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property Font: HFONT read FFont write FFont;
    property Redraw: WordBool read FRedraw write FRedraw;
    property Unused: Word read FUnused write FUnused;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMSetHotKeyWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FKey: Longint;
    FUnused: Longint;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMSetHotKey);
    function ObjToRec: TWMSetHotKey;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property Key: Longint read FKey write FKey;
    property Unused: Longint read FUnused write FUnused;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMSetIconWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FBigIcon: Longbool;
    FIcon: HICON;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMSetIcon);
    function ObjToRec: TWMSetIcon;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property BigIcon: Longbool read FBigIcon write FBigIcon;
    property Icon: HICON read FIcon write FIcon;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMSetRedrawWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FRedraw: Longint;
    FUnused: Longint;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMSetRedraw);
    function ObjToRec: TWMSetRedraw;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property Redraw: Longint read FRedraw write FRedraw;
    property Unused: Longint read FUnused write FUnused;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMSetTextWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FUnused: Longint;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMSetText);
    function ObjToRec: TWMSetText;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property Unused: Longint read FUnused write FUnused;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMShowWindowWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FShow: BOOL;
    FStatus: Longint;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMShowWindow);
    function ObjToRec: TWMShowWindow;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property Show: BOOL read FShow write FShow;
    property Status: Longint read FStatus write FStatus;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMSizeWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FSizeType: Longint;
    FWidth: Word;
    FHeight: Word;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMSize);
    function ObjToRec: TWMSize;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property SizeType: Longint read FSizeType write FSizeType;
    property Width: Word read FWidth write FWidth;
    property Height: Word read FHeight write FHeight;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMSizeClipboardWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FViewer: HWND;
    FRC: THandle;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMSizeClipboard);
    function ObjToRec: TWMSizeClipboard;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property Viewer: HWND read FViewer write FViewer;
    property RC: THandle read FRC write FRC;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMSpoolerStatusWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FJobStatus: Longint;
    FJobsLeft: Word;
    FUnused: Word;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMSpoolerStatus);
    function ObjToRec: TWMSpoolerStatus;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property JobStatus: Longint read FJobStatus write FJobStatus;
    property JobsLeft: Word read FJobsLeft write FJobsLeft;
    property Unused: Word read FUnused write FUnused;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMStyleChangeWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FStyleType: Longint;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMStyleChange);
    function ObjToRec: TWMStyleChange;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property StyleType: Longint read FStyleType write FStyleType;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMSysCommandWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FActivateWnd: HWND;
    FKey: Word;
    FXPos: Smallint;
    FYPos: Smallint;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMSysCommand);
    function ObjToRec: TWMSysCommand;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property ActivateWnd: HWND read FActivateWnd write FActivateWnd;
    property Key: Word read FKey write FKey;
    property XPos: Smallint read FXPos write FXPos;
    property YPos: Smallint read FYPos write FYPos;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMSysDeadCharWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FCharCode: Word;
    FUnused: Word;
    FKeyData: Longint;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMSysDeadChar);
    function ObjToRec: TWMSysDeadChar;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property CharCode: Word read FCharCode write FCharCode;
    property Unused: Word read FUnused write FUnused;
    property KeyData: Longint read FKeyData write FKeyData;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMSystemErrorWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FErrSpec: Word;
    FUnused: Longint;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMSystemError);
    function ObjToRec: TWMSystemError;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property ErrSpec: Word read FErrSpec write FErrSpec;
    property Unused: Longint read FUnused write FUnused;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMTimerWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FTimerID: Longint;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMTimer);
    function ObjToRec: TWMTimer;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property TimerID: Longint read FTimerID write FTimerID;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMUIStateWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FAction: Word;
    FFlags: Word;
    FUnused: Longint;
  public
    constructor Create(ARecord: TWMUIState);
    function ObjToRec: TWMUIState;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property Action: Word read FAction write FAction;
    property Flags: Word read FFlags write FFlags;
    property Unused: Longint read FUnused write FUnused;
  end;
  
  TWMVScrollClipboardWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FViewer: HWND;
    FScollCode: Word;
    FThumbPos: Word;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMVScrollClipboard);
    function ObjToRec: TWMVScrollClipboard;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property Viewer: HWND read FViewer write FViewer;
    property ScollCode: Word read FScollCode write FScollCode;
    property ThumbPos: Word read FThumbPos write FThumbPos;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMWinIniChangeWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FUnused: Integer;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMWinIniChange);
    function ObjToRec: TWMWinIniChange;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property Unused: Integer read FUnused write FUnused;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMSettingChangeWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FFlag: Integer;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMSettingChange);
    function ObjToRec: TWMSettingChange;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property Flag: Integer read FFlag write FFlag;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMHelpWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FUnused: Integer;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMHelp);
    function ObjToRec: TWMHelp;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property Unused: Integer read FUnused write FUnused;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMDisplayChangeWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FBitsPerPixel: Integer;
    FWidth: Word;
    FHeight: Word;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMDisplayChange);
    function ObjToRec: TWMDisplayChange;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property BitsPerPixel: Integer read FBitsPerPixel write FBitsPerPixel;
    property Width: Word read FWidth write FWidth;
    property Height: Word read FHeight write FHeight;
    property Result: Longint read FResult write FResult;
  end;
  
  TWMContextMenuWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FhWnd: HWND;
    FXPos: Smallint;
    FYPos: Smallint;
    FResult: Longint;
  public
    constructor Create(ARecord: TWMContextMenu);
    function ObjToRec: TWMContextMenu;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property hWnd: HWND read FhWnd write FhWnd;
    property XPos: Smallint read FXPos write FXPos;
    property YPos: Smallint read FYPos write FYPos;
    property Result: Longint read FResult write FResult;
  end;
  

implementation

constructor TMessageWrapper.Create(ARecord: TMessage);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FWParam := ARecord.WParam;
  FLParam := ARecord.LParam;
  FResult := ARecord.Result;
  FWParamLo := ARecord.WParamLo;
  FWParamHi := ARecord.WParamHi;
  FLParamLo := ARecord.LParamLo;
  FLParamHi := ARecord.LParamHi;
  FResultLo := ARecord.ResultLo;
  FResultHi := ARecord.ResultHi;
end;

function TMessageWrapper.ObjToRec: TMessage;
begin
  result.Msg := FMsg;
  result.WParam := FWParam;
  result.LParam := FLParam;
  result.Result := FResult;
  result.WParamLo := FWParamLo;
  result.WParamHi := FWParamHi;
  result.LParamLo := FLParamLo;
  result.LParamHi := FLParamHi;
  result.ResultLo := FResultLo;
  result.ResultHi := FResultHi;
end;

constructor TWMNoParamsWrapper.Create(ARecord: TWMNoParams);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FResult := ARecord.Result;
end;

function TWMNoParamsWrapper.ObjToRec: TWMNoParams;
begin
  result.Msg := FMsg;
  result.Result := FResult;
end;

constructor TWMKeyWrapper.Create(ARecord: TWMKey);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FCharCode := ARecord.CharCode;
  FUnused := ARecord.Unused;
  FKeyData := ARecord.KeyData;
  FResult := ARecord.Result;
end;

function TWMKeyWrapper.ObjToRec: TWMKey;
begin
  result.Msg := FMsg;
  result.CharCode := FCharCode;
  result.Unused := FUnused;
  result.KeyData := FKeyData;
  result.Result := FResult;
end;

constructor TWMMouseWrapper.Create(ARecord: TWMMouse);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FKeys := ARecord.Keys;
  FXPos := ARecord.XPos;
  FYPos := ARecord.YPos;
  FResult := ARecord.Result;
end;

function TWMMouseWrapper.ObjToRec: TWMMouse;
begin
  result.Msg := FMsg;
  result.Keys := FKeys;
  result.XPos := FXPos;
  result.YPos := FYPos;
  result.Result := FResult;
end;

constructor TWMMouseWheelWrapper.Create(ARecord: TWMMouseWheel);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FKeys := ARecord.Keys;
  FWheelDelta := ARecord.WheelDelta;
  FXPos := ARecord.XPos;
  FYPos := ARecord.YPos;
  FResult := ARecord.Result;
end;

function TWMMouseWheelWrapper.ObjToRec: TWMMouseWheel;
begin
  result.Msg := FMsg;
  result.Keys := FKeys;
  result.WheelDelta := FWheelDelta;
  result.XPos := FXPos;
  result.YPos := FYPos;
  result.Result := FResult;
end;

constructor TMSHMouseWheelWrapper.Create(ARecord: TMSHMouseWheel);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FWheelDelta := ARecord.WheelDelta;
  FXPos := ARecord.XPos;
  FYPos := ARecord.YPos;
  FResult := ARecord.Result;
end;

function TMSHMouseWheelWrapper.ObjToRec: TMSHMouseWheel;
begin
  result.Msg := FMsg;
  result.WheelDelta := FWheelDelta;
  result.XPos := FXPos;
  result.YPos := FYPos;
  result.Result := FResult;
end;

constructor TWMWindowPosMsgWrapper.Create(ARecord: TWMWindowPosMsg);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FUnused := ARecord.Unused;
  FResult := ARecord.Result;
end;

function TWMWindowPosMsgWrapper.ObjToRec: TWMWindowPosMsg;
begin
  result.Msg := FMsg;
  result.Unused := FUnused;
  result.Result := FResult;
end;

constructor TWMScrollWrapper.Create(ARecord: TWMScroll);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FScrollCode := ARecord.ScrollCode;
  FPos := ARecord.Pos;
  FScrollBar := ARecord.ScrollBar;
  FResult := ARecord.Result;
end;

function TWMScrollWrapper.ObjToRec: TWMScroll;
begin
  result.Msg := FMsg;
  result.ScrollCode := FScrollCode;
  result.Pos := FPos;
  result.ScrollBar := FScrollBar;
  result.Result := FResult;
end;

constructor TWMActivateWrapper.Create(ARecord: TWMActivate);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FActive := ARecord.Active;
  FMinimized := ARecord.Minimized;
  FActiveWindow := ARecord.ActiveWindow;
  FResult := ARecord.Result;
end;

function TWMActivateWrapper.ObjToRec: TWMActivate;
begin
  result.Msg := FMsg;
  result.Active := FActive;
  result.Minimized := FMinimized;
  result.ActiveWindow := FActiveWindow;
  result.Result := FResult;
end;

constructor TWMActivateAppWrapper.Create(ARecord: TWMActivateApp);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FActive := ARecord.Active;
  FThreadId := ARecord.ThreadId;
  FResult := ARecord.Result;
end;

function TWMActivateAppWrapper.ObjToRec: TWMActivateApp;
begin
  result.Msg := FMsg;
  result.Active := FActive;
  result.ThreadId := FThreadId;
  result.Result := FResult;
end;

constructor TWMAskCBFormatNameWrapper.Create(ARecord: TWMAskCBFormatName);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FNameLen := ARecord.NameLen;
  FUnused := ARecord.Unused;
  FResult := ARecord.Result;
end;

function TWMAskCBFormatNameWrapper.ObjToRec: TWMAskCBFormatName;
begin
  result.Msg := FMsg;
  result.NameLen := FNameLen;
  result.Unused := FUnused;
  result.Result := FResult;
end;

constructor TWMChangeCBChainWrapper.Create(ARecord: TWMChangeCBChain);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FRemove := ARecord.Remove;
  FNext := ARecord.Next;
  FResult := ARecord.Result;
end;

function TWMChangeCBChainWrapper.ObjToRec: TWMChangeCBChain;
begin
  result.Msg := FMsg;
  result.Remove := FRemove;
  result.Next := FNext;
  result.Result := FResult;
end;

constructor TWMCharToItemWrapper.Create(ARecord: TWMCharToItem);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FKey := ARecord.Key;
  FCaretPos := ARecord.CaretPos;
  FListBox := ARecord.ListBox;
  FResult := ARecord.Result;
end;

function TWMCharToItemWrapper.ObjToRec: TWMCharToItem;
begin
  result.Msg := FMsg;
  result.Key := FKey;
  result.CaretPos := FCaretPos;
  result.ListBox := FListBox;
  result.Result := FResult;
end;

constructor TWMChooseFont_GetLogFontWrapper.Create(ARecord: TWMChooseFont_GetLogFont);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FUnused := ARecord.Unused;
  FResult := ARecord.Result;
end;

function TWMChooseFont_GetLogFontWrapper.ObjToRec: TWMChooseFont_GetLogFont;
begin
  result.Msg := FMsg;
  result.Unused := FUnused;
  result.Result := FResult;
end;

constructor TWMCommandWrapper.Create(ARecord: TWMCommand);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FItemID := ARecord.ItemID;
  FNotifyCode := ARecord.NotifyCode;
  FCtl := ARecord.Ctl;
  FResult := ARecord.Result;
end;

function TWMCommandWrapper.ObjToRec: TWMCommand;
begin
  result.Msg := FMsg;
  result.ItemID := FItemID;
  result.NotifyCode := FNotifyCode;
  result.Ctl := FCtl;
  result.Result := FResult;
end;

constructor TWMCompactingWrapper.Create(ARecord: TWMCompacting);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FCompactRatio := ARecord.CompactRatio;
  FUnused := ARecord.Unused;
  FResult := ARecord.Result;
end;

function TWMCompactingWrapper.ObjToRec: TWMCompacting;
begin
  result.Msg := FMsg;
  result.CompactRatio := FCompactRatio;
  result.Unused := FUnused;
  result.Result := FResult;
end;

constructor TWMCompareItemWrapper.Create(ARecord: TWMCompareItem);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FCtl := ARecord.Ctl;
  FResult := ARecord.Result;
end;

function TWMCompareItemWrapper.ObjToRec: TWMCompareItem;
begin
  result.Msg := FMsg;
  result.Ctl := FCtl;
  result.Result := FResult;
end;

constructor TWMCopyDataWrapper.Create(ARecord: TWMCopyData);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FFrom := ARecord.From;
  FResult := ARecord.Result;
end;

function TWMCopyDataWrapper.ObjToRec: TWMCopyData;
begin
  result.Msg := FMsg;
  result.From := FFrom;
  result.Result := FResult;
end;

constructor TWMCreateWrapper.Create(ARecord: TWMCreate);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FUnused := ARecord.Unused;
  FResult := ARecord.Result;
end;

function TWMCreateWrapper.ObjToRec: TWMCreate;
begin
  result.Msg := FMsg;
  result.Unused := FUnused;
  result.Result := FResult;
end;

constructor TWMCtlColorWrapper.Create(ARecord: TWMCtlColor);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FChildDC := ARecord.ChildDC;
  FChildWnd := ARecord.ChildWnd;
  FResult := ARecord.Result;
end;

function TWMCtlColorWrapper.ObjToRec: TWMCtlColor;
begin
  result.Msg := FMsg;
  result.ChildDC := FChildDC;
  result.ChildWnd := FChildWnd;
  result.Result := FResult;
end;

constructor TWMDDE_AckWrapper.Create(ARecord: TWMDDE_Ack);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FPostingApp := ARecord.PostingApp;
  FApp := ARecord.App;
  FTopic := ARecord.Topic;
  FResult := ARecord.Result;
  FPackedVal := ARecord.PackedVal;
end;

function TWMDDE_AckWrapper.ObjToRec: TWMDDE_Ack;
begin
  result.Msg := FMsg;
  result.PostingApp := FPostingApp;
  result.App := FApp;
  result.Topic := FTopic;
  result.Result := FResult;
  result.PackedVal := FPackedVal;
end;

constructor TWMDDE_AdviseWrapper.Create(ARecord: TWMDDE_Advise);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FPostingApp := ARecord.PostingApp;
  FPackedVal := ARecord.PackedVal;
  FResult := ARecord.Result;
end;

function TWMDDE_AdviseWrapper.ObjToRec: TWMDDE_Advise;
begin
  result.Msg := FMsg;
  result.PostingApp := FPostingApp;
  result.PackedVal := FPackedVal;
  result.Result := FResult;
end;

constructor TWMDDE_DataWrapper.Create(ARecord: TWMDDE_Data);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FPostingApp := ARecord.PostingApp;
  FPackedVal := ARecord.PackedVal;
  FResult := ARecord.Result;
end;

function TWMDDE_DataWrapper.ObjToRec: TWMDDE_Data;
begin
  result.Msg := FMsg;
  result.PostingApp := FPostingApp;
  result.PackedVal := FPackedVal;
  result.Result := FResult;
end;

constructor TWMDDE_ExecuteWrapper.Create(ARecord: TWMDDE_Execute);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FPostingApp := ARecord.PostingApp;
  FCommands := ARecord.Commands;
  FResult := ARecord.Result;
end;

function TWMDDE_ExecuteWrapper.ObjToRec: TWMDDE_Execute;
begin
  result.Msg := FMsg;
  result.PostingApp := FPostingApp;
  result.Commands := FCommands;
  result.Result := FResult;
end;

constructor TWMDDE_InitiateWrapper.Create(ARecord: TWMDDE_Initiate);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FPostingApp := ARecord.PostingApp;
  FApp := ARecord.App;
  FTopic := ARecord.Topic;
  FResult := ARecord.Result;
end;

function TWMDDE_InitiateWrapper.ObjToRec: TWMDDE_Initiate;
begin
  result.Msg := FMsg;
  result.PostingApp := FPostingApp;
  result.App := FApp;
  result.Topic := FTopic;
  result.Result := FResult;
end;

constructor TWMDDE_PokeWrapper.Create(ARecord: TWMDDE_Poke);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FPostingApp := ARecord.PostingApp;
  FPackedVal := ARecord.PackedVal;
  FResult := ARecord.Result;
end;

function TWMDDE_PokeWrapper.ObjToRec: TWMDDE_Poke;
begin
  result.Msg := FMsg;
  result.PostingApp := FPostingApp;
  result.PackedVal := FPackedVal;
  result.Result := FResult;
end;

constructor TWMDDE_RequestWrapper.Create(ARecord: TWMDDE_Request);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FPostingApp := ARecord.PostingApp;
  FFormat := ARecord.Format;
  FItem := ARecord.Item;
  FResult := ARecord.Result;
end;

function TWMDDE_RequestWrapper.ObjToRec: TWMDDE_Request;
begin
  result.Msg := FMsg;
  result.PostingApp := FPostingApp;
  result.Format := FFormat;
  result.Item := FItem;
  result.Result := FResult;
end;

constructor TWMDDE_TerminateWrapper.Create(ARecord: TWMDDE_Terminate);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FPostingApp := ARecord.PostingApp;
  FUnused := ARecord.Unused;
  FResult := ARecord.Result;
end;

function TWMDDE_TerminateWrapper.ObjToRec: TWMDDE_Terminate;
begin
  result.Msg := FMsg;
  result.PostingApp := FPostingApp;
  result.Unused := FUnused;
  result.Result := FResult;
end;

constructor TWMDDE_UnadviseWrapper.Create(ARecord: TWMDDE_Unadvise);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FPostingApp := ARecord.PostingApp;
  FFormat := ARecord.Format;
  FItem := ARecord.Item;
  FResult := ARecord.Result;
end;

function TWMDDE_UnadviseWrapper.ObjToRec: TWMDDE_Unadvise;
begin
  result.Msg := FMsg;
  result.PostingApp := FPostingApp;
  result.Format := FFormat;
  result.Item := FItem;
  result.Result := FResult;
end;

constructor TWMDeleteItemWrapper.Create(ARecord: TWMDeleteItem);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FCtl := ARecord.Ctl;
  FResult := ARecord.Result;
end;

function TWMDeleteItemWrapper.ObjToRec: TWMDeleteItem;
begin
  result.Msg := FMsg;
  result.Ctl := FCtl;
  result.Result := FResult;
end;

constructor TWMDevModeChangeWrapper.Create(ARecord: TWMDevModeChange);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FUnused := ARecord.Unused;
  FResult := ARecord.Result;
end;

function TWMDevModeChangeWrapper.ObjToRec: TWMDevModeChange;
begin
  result.Msg := FMsg;
  result.Unused := FUnused;
  result.Result := FResult;
end;

constructor TWMDrawItemWrapper.Create(ARecord: TWMDrawItem);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FCtl := ARecord.Ctl;
  FResult := ARecord.Result;
end;

function TWMDrawItemWrapper.ObjToRec: TWMDrawItem;
begin
  result.Msg := FMsg;
  result.Ctl := FCtl;
  result.Result := FResult;
end;

constructor TWMDropFilesWrapper.Create(ARecord: TWMDropFiles);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FDrop := ARecord.Drop;
  FUnused := ARecord.Unused;
  FResult := ARecord.Result;
end;

function TWMDropFilesWrapper.ObjToRec: TWMDropFiles;
begin
  result.Msg := FMsg;
  result.Drop := FDrop;
  result.Unused := FUnused;
  result.Result := FResult;
end;

constructor TWMEnableWrapper.Create(ARecord: TWMEnable);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FEnabled := ARecord.Enabled;
  FUnused := ARecord.Unused;
  FResult := ARecord.Result;
end;

function TWMEnableWrapper.ObjToRec: TWMEnable;
begin
  result.Msg := FMsg;
  result.Enabled := FEnabled;
  result.Unused := FUnused;
  result.Result := FResult;
end;

constructor TWMEndSessionWrapper.Create(ARecord: TWMEndSession);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FEndSession := ARecord.EndSession;
  FUnused := ARecord.Unused;
  FResult := ARecord.Result;
end;

function TWMEndSessionWrapper.ObjToRec: TWMEndSession;
begin
  result.Msg := FMsg;
  result.EndSession := FEndSession;
  result.Unused := FUnused;
  result.Result := FResult;
end;

constructor TWMEnterIdleWrapper.Create(ARecord: TWMEnterIdle);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FSource := ARecord.Source;
  FIdleWnd := ARecord.IdleWnd;
  FResult := ARecord.Result;
end;

function TWMEnterIdleWrapper.ObjToRec: TWMEnterIdle;
begin
  result.Msg := FMsg;
  result.Source := FSource;
  result.IdleWnd := FIdleWnd;
  result.Result := FResult;
end;

constructor TWMEnterMenuLoopWrapper.Create(ARecord: TWMEnterMenuLoop);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FIsTrackPopupMenu := ARecord.IsTrackPopupMenu;
  FUnused := ARecord.Unused;
  FResult := ARecord.Result;
end;

function TWMEnterMenuLoopWrapper.ObjToRec: TWMEnterMenuLoop;
begin
  result.Msg := FMsg;
  result.IsTrackPopupMenu := FIsTrackPopupMenu;
  result.Unused := FUnused;
  result.Result := FResult;
end;

constructor TWMEraseBkgndWrapper.Create(ARecord: TWMEraseBkgnd);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FDC := ARecord.DC;
  FUnused := ARecord.Unused;
  FResult := ARecord.Result;
end;

function TWMEraseBkgndWrapper.ObjToRec: TWMEraseBkgnd;
begin
  result.Msg := FMsg;
  result.DC := FDC;
  result.Unused := FUnused;
  result.Result := FResult;
end;

constructor TWMGetIconWrapper.Create(ARecord: TWMGetIcon);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FBigIcon := ARecord.BigIcon;
  FUnused := ARecord.Unused;
  FResult := ARecord.Result;
end;

function TWMGetIconWrapper.ObjToRec: TWMGetIcon;
begin
  result.Msg := FMsg;
  result.BigIcon := FBigIcon;
  result.Unused := FUnused;
  result.Result := FResult;
end;

constructor TWMGetMinMaxInfoWrapper.Create(ARecord: TWMGetMinMaxInfo);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FUnused := ARecord.Unused;
  FResult := ARecord.Result;
end;

function TWMGetMinMaxInfoWrapper.ObjToRec: TWMGetMinMaxInfo;
begin
  result.Msg := FMsg;
  result.Unused := FUnused;
  result.Result := FResult;
end;

constructor TWMGetTextWrapper.Create(ARecord: TWMGetText);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FTextMax := ARecord.TextMax;
  FResult := ARecord.Result;
end;

function TWMGetTextWrapper.ObjToRec: TWMGetText;
begin
  result.Msg := FMsg;
  result.TextMax := FTextMax;
  result.Result := FResult;
end;

constructor TWMHotKeyWrapper.Create(ARecord: TWMHotKey);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FHotKey := ARecord.HotKey;
  FUnused := ARecord.Unused;
  FResult := ARecord.Result;
end;

function TWMHotKeyWrapper.ObjToRec: TWMHotKey;
begin
  result.Msg := FMsg;
  result.HotKey := FHotKey;
  result.Unused := FUnused;
  result.Result := FResult;
end;

constructor TWMHScrollClipboardWrapper.Create(ARecord: TWMHScrollClipboard);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FViewer := ARecord.Viewer;
  FScrollCode := ARecord.ScrollCode;
  FPos := ARecord.Pos;
  FResult := ARecord.Result;
end;

function TWMHScrollClipboardWrapper.ObjToRec: TWMHScrollClipboard;
begin
  result.Msg := FMsg;
  result.Viewer := FViewer;
  result.ScrollCode := FScrollCode;
  result.Pos := FPos;
  result.Result := FResult;
end;

constructor TWMInitDialogWrapper.Create(ARecord: TWMInitDialog);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FFocus := ARecord.Focus;
  FInitParam := ARecord.InitParam;
  FResult := ARecord.Result;
end;

function TWMInitDialogWrapper.ObjToRec: TWMInitDialog;
begin
  result.Msg := FMsg;
  result.Focus := FFocus;
  result.InitParam := FInitParam;
  result.Result := FResult;
end;

constructor TWMInitMenuWrapper.Create(ARecord: TWMInitMenu);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FMenu := ARecord.Menu;
  FUnused := ARecord.Unused;
  FResult := ARecord.Result;
end;

function TWMInitMenuWrapper.ObjToRec: TWMInitMenu;
begin
  result.Msg := FMsg;
  result.Menu := FMenu;
  result.Unused := FUnused;
  result.Result := FResult;
end;

constructor TWMInitMenuPopupWrapper.Create(ARecord: TWMInitMenuPopup);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FMenuPopup := ARecord.MenuPopup;
  FPos := ARecord.Pos;
  FSystemMenu := ARecord.SystemMenu;
  FResult := ARecord.Result;
end;

function TWMInitMenuPopupWrapper.ObjToRec: TWMInitMenuPopup;
begin
  result.Msg := FMsg;
  result.MenuPopup := FMenuPopup;
  result.Pos := FPos;
  result.SystemMenu := FSystemMenu;
  result.Result := FResult;
end;

constructor TWMKillFocusWrapper.Create(ARecord: TWMKillFocus);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FFocusedWnd := ARecord.FocusedWnd;
  FUnused := ARecord.Unused;
  FResult := ARecord.Result;
end;

function TWMKillFocusWrapper.ObjToRec: TWMKillFocus;
begin
  result.Msg := FMsg;
  result.FocusedWnd := FFocusedWnd;
  result.Unused := FUnused;
  result.Result := FResult;
end;

constructor TWMMDIActivateWrapper.Create(ARecord: TWMMDIActivate);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FChildWnd := ARecord.ChildWnd;
  FDeactiveWnd := ARecord.DeactiveWnd;
  FActiveWnd := ARecord.ActiveWnd;
  FResult := ARecord.Result;
end;

function TWMMDIActivateWrapper.ObjToRec: TWMMDIActivate;
begin
  result.Msg := FMsg;
  result.ChildWnd := FChildWnd;
  result.DeactiveWnd := FDeactiveWnd;
  result.ActiveWnd := FActiveWnd;
  result.Result := FResult;
end;

constructor TWMMDICascadeWrapper.Create(ARecord: TWMMDICascade);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FCascade := ARecord.Cascade;
  FUnused := ARecord.Unused;
  FResult := ARecord.Result;
end;

function TWMMDICascadeWrapper.ObjToRec: TWMMDICascade;
begin
  result.Msg := FMsg;
  result.Cascade := FCascade;
  result.Unused := FUnused;
  result.Result := FResult;
end;

constructor TWMMDICreateWrapper.Create(ARecord: TWMMDICreate);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FUnused := ARecord.Unused;
  FResult := ARecord.Result;
end;

function TWMMDICreateWrapper.ObjToRec: TWMMDICreate;
begin
  result.Msg := FMsg;
  result.Unused := FUnused;
  result.Result := FResult;
end;

constructor TWMMDIDestroyWrapper.Create(ARecord: TWMMDIDestroy);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FChild := ARecord.Child;
  FUnused := ARecord.Unused;
  FResult := ARecord.Result;
end;

function TWMMDIDestroyWrapper.ObjToRec: TWMMDIDestroy;
begin
  result.Msg := FMsg;
  result.Child := FChild;
  result.Unused := FUnused;
  result.Result := FResult;
end;

constructor TWMMDIMaximizeWrapper.Create(ARecord: TWMMDIMaximize);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FMaximize := ARecord.Maximize;
  FUnused := ARecord.Unused;
  FResult := ARecord.Result;
end;

function TWMMDIMaximizeWrapper.ObjToRec: TWMMDIMaximize;
begin
  result.Msg := FMsg;
  result.Maximize := FMaximize;
  result.Unused := FUnused;
  result.Result := FResult;
end;

constructor TWMMDINextWrapper.Create(ARecord: TWMMDINext);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FChild := ARecord.Child;
  FNext := ARecord.Next;
  FResult := ARecord.Result;
end;

function TWMMDINextWrapper.ObjToRec: TWMMDINext;
begin
  result.Msg := FMsg;
  result.Child := FChild;
  result.Next := FNext;
  result.Result := FResult;
end;

constructor TWMMDIRestoreWrapper.Create(ARecord: TWMMDIRestore);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FIDChild := ARecord.IDChild;
  FUnused := ARecord.Unused;
  FResult := ARecord.Result;
end;

function TWMMDIRestoreWrapper.ObjToRec: TWMMDIRestore;
begin
  result.Msg := FMsg;
  result.IDChild := FIDChild;
  result.Unused := FUnused;
  result.Result := FResult;
end;

constructor TWMMDISetMenuWrapper.Create(ARecord: TWMMDISetMenu);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FMenuFrame := ARecord.MenuFrame;
  FMenuWindow := ARecord.MenuWindow;
  FResult := ARecord.Result;
end;

function TWMMDISetMenuWrapper.ObjToRec: TWMMDISetMenu;
begin
  result.Msg := FMsg;
  result.MenuFrame := FMenuFrame;
  result.MenuWindow := FMenuWindow;
  result.Result := FResult;
end;

constructor TWMMDITileWrapper.Create(ARecord: TWMMDITile);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FTile := ARecord.Tile;
  FUnused := ARecord.Unused;
  FResult := ARecord.Result;
end;

function TWMMDITileWrapper.ObjToRec: TWMMDITile;
begin
  result.Msg := FMsg;
  result.Tile := FTile;
  result.Unused := FUnused;
  result.Result := FResult;
end;

constructor TWMMeasureItemWrapper.Create(ARecord: TWMMeasureItem);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FIDCtl := ARecord.IDCtl;
  FResult := ARecord.Result;
end;

function TWMMeasureItemWrapper.ObjToRec: TWMMeasureItem;
begin
  result.Msg := FMsg;
  result.IDCtl := FIDCtl;
  result.Result := FResult;
end;

constructor TWMMenuCharWrapper.Create(ARecord: TWMMenuChar);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FUser := ARecord.User;
  FUnused := ARecord.Unused;
  FMenuFlag := ARecord.MenuFlag;
  FMenu := ARecord.Menu;
  FResult := ARecord.Result;
end;

function TWMMenuCharWrapper.ObjToRec: TWMMenuChar;
begin
  result.Msg := FMsg;
  result.User := FUser;
  result.Unused := FUnused;
  result.MenuFlag := FMenuFlag;
  result.Menu := FMenu;
  result.Result := FResult;
end;

constructor TWMMenuSelectWrapper.Create(ARecord: TWMMenuSelect);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FIDItem := ARecord.IDItem;
  FMenuFlag := ARecord.MenuFlag;
  FMenu := ARecord.Menu;
  FResult := ARecord.Result;
end;

function TWMMenuSelectWrapper.ObjToRec: TWMMenuSelect;
begin
  result.Msg := FMsg;
  result.IDItem := FIDItem;
  result.MenuFlag := FMenuFlag;
  result.Menu := FMenu;
  result.Result := FResult;
end;

constructor TWMMouseActivateWrapper.Create(ARecord: TWMMouseActivate);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FTopLevel := ARecord.TopLevel;
  FHitTestCode := ARecord.HitTestCode;
  FMouseMsg := ARecord.MouseMsg;
  FResult := ARecord.Result;
end;

function TWMMouseActivateWrapper.ObjToRec: TWMMouseActivate;
begin
  result.Msg := FMsg;
  result.TopLevel := FTopLevel;
  result.HitTestCode := FHitTestCode;
  result.MouseMsg := FMouseMsg;
  result.Result := FResult;
end;

constructor TWMMoveWrapper.Create(ARecord: TWMMove);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FUnused := ARecord.Unused;
  FXPos := ARecord.XPos;
  FYPos := ARecord.YPos;
  FResult := ARecord.Result;
end;

function TWMMoveWrapper.ObjToRec: TWMMove;
begin
  result.Msg := FMsg;
  result.Unused := FUnused;
  result.XPos := FXPos;
  result.YPos := FYPos;
  result.Result := FResult;
end;

constructor TWMNCActivateWrapper.Create(ARecord: TWMNCActivate);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FActive := ARecord.Active;
  FUnused := ARecord.Unused;
  FResult := ARecord.Result;
end;

function TWMNCActivateWrapper.ObjToRec: TWMNCActivate;
begin
  result.Msg := FMsg;
  result.Active := FActive;
  result.Unused := FUnused;
  result.Result := FResult;
end;

constructor TWMNCCalcSizeWrapper.Create(ARecord: TWMNCCalcSize);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FCalcValidRects := ARecord.CalcValidRects;
  FResult := ARecord.Result;
end;

function TWMNCCalcSizeWrapper.ObjToRec: TWMNCCalcSize;
begin
  result.Msg := FMsg;
  result.CalcValidRects := FCalcValidRects;
  result.Result := FResult;
end;

constructor TWMNCCreateWrapper.Create(ARecord: TWMNCCreate);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FUnused := ARecord.Unused;
  FResult := ARecord.Result;
end;

function TWMNCCreateWrapper.ObjToRec: TWMNCCreate;
begin
  result.Msg := FMsg;
  result.Unused := FUnused;
  result.Result := FResult;
end;

constructor TWMNCHitTestWrapper.Create(ARecord: TWMNCHitTest);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FUnused := ARecord.Unused;
  FXPos := ARecord.XPos;
  FYPos := ARecord.YPos;
  FResult := ARecord.Result;
end;

function TWMNCHitTestWrapper.ObjToRec: TWMNCHitTest;
begin
  result.Msg := FMsg;
  result.Unused := FUnused;
  result.XPos := FXPos;
  result.YPos := FYPos;
  result.Result := FResult;
end;

constructor TWMNCHitMessageWrapper.Create(ARecord: TWMNCHitMessage);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FHitTest := ARecord.HitTest;
  FXCursor := ARecord.XCursor;
  FYCursor := ARecord.YCursor;
  FResult := ARecord.Result;
end;

function TWMNCHitMessageWrapper.ObjToRec: TWMNCHitMessage;
begin
  result.Msg := FMsg;
  result.HitTest := FHitTest;
  result.XCursor := FXCursor;
  result.YCursor := FYCursor;
  result.Result := FResult;
end;

constructor TWMNCPaintWrapper.Create(ARecord: TWMNCPaint);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FRGN := ARecord.RGN;
  FUnused := ARecord.Unused;
  FResult := ARecord.Result;
end;

function TWMNCPaintWrapper.ObjToRec: TWMNCPaint;
begin
  result.Msg := FMsg;
  result.RGN := FRGN;
  result.Unused := FUnused;
  result.Result := FResult;
end;

constructor TWMNextDlgCtlWrapper.Create(ARecord: TWMNextDlgCtl);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FCtlFocus := ARecord.CtlFocus;
  FHandle := ARecord.Handle;
  FUnused := ARecord.Unused;
  FResult := ARecord.Result;
end;

function TWMNextDlgCtlWrapper.ObjToRec: TWMNextDlgCtl;
begin
  result.Msg := FMsg;
  result.CtlFocus := FCtlFocus;
  result.Handle := FHandle;
  result.Unused := FUnused;
  result.Result := FResult;
end;

constructor TWMNotifyWrapper.Create(ARecord: TWMNotify);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FIDCtrl := ARecord.IDCtrl;
  FResult := ARecord.Result;
end;

function TWMNotifyWrapper.ObjToRec: TWMNotify;
begin
  result.Msg := FMsg;
  result.IDCtrl := FIDCtrl;
  result.Result := FResult;
end;

constructor TWMNotifyFormatWrapper.Create(ARecord: TWMNotifyFormat);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FFrom := ARecord.From;
  FCommand := ARecord.Command;
  FResult := ARecord.Result;
end;

function TWMNotifyFormatWrapper.ObjToRec: TWMNotifyFormat;
begin
  result.Msg := FMsg;
  result.From := FFrom;
  result.Command := FCommand;
  result.Result := FResult;
end;

constructor TWMPaintWrapper.Create(ARecord: TWMPaint);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FDC := ARecord.DC;
  FUnused := ARecord.Unused;
  FResult := ARecord.Result;
end;

function TWMPaintWrapper.ObjToRec: TWMPaint;
begin
  result.Msg := FMsg;
  result.DC := FDC;
  result.Unused := FUnused;
  result.Result := FResult;
end;

constructor TWMPaintClipboardWrapper.Create(ARecord: TWMPaintClipboard);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FViewer := ARecord.Viewer;
  FPaintStruct := ARecord.PaintStruct;
  FResult := ARecord.Result;
end;

function TWMPaintClipboardWrapper.ObjToRec: TWMPaintClipboard;
begin
  result.Msg := FMsg;
  result.Viewer := FViewer;
  result.PaintStruct := FPaintStruct;
  result.Result := FResult;
end;

constructor TWMPaletteChangedWrapper.Create(ARecord: TWMPaletteChanged);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FPalChg := ARecord.PalChg;
  FUnused := ARecord.Unused;
  FResult := ARecord.Result;
end;

function TWMPaletteChangedWrapper.ObjToRec: TWMPaletteChanged;
begin
  result.Msg := FMsg;
  result.PalChg := FPalChg;
  result.Unused := FUnused;
  result.Result := FResult;
end;

constructor TWMPaletteIsChangingWrapper.Create(ARecord: TWMPaletteIsChanging);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FRealize := ARecord.Realize;
  FUnused := ARecord.Unused;
  FResult := ARecord.Result;
end;

function TWMPaletteIsChangingWrapper.ObjToRec: TWMPaletteIsChanging;
begin
  result.Msg := FMsg;
  result.Realize := FRealize;
  result.Unused := FUnused;
  result.Result := FResult;
end;

constructor TWMParentNotifyWrapper.Create(ARecord: TWMParentNotify);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FChildID := ARecord.ChildID;
  FChildWnd := ARecord.ChildWnd;
  FValue := ARecord.Value;
  FXPos := ARecord.XPos;
  FYPos := ARecord.YPos;
  FValue1 := ARecord.Value1;
  FValue2 := ARecord.Value2;
  FResult := ARecord.Result;
end;

function TWMParentNotifyWrapper.ObjToRec: TWMParentNotify;
begin
  result.Msg := FMsg;
  result.ChildID := FChildID;
  result.ChildWnd := FChildWnd;
  result.Value := FValue;
  result.XPos := FXPos;
  result.YPos := FYPos;
  result.Value1 := FValue1;
  result.Value2 := FValue2;
  result.Result := FResult;
end;

constructor TWMPowerWrapper.Create(ARecord: TWMPower);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FPowerEvt := ARecord.PowerEvt;
  FUnused := ARecord.Unused;
  FResult := ARecord.Result;
end;

function TWMPowerWrapper.ObjToRec: TWMPower;
begin
  result.Msg := FMsg;
  result.PowerEvt := FPowerEvt;
  result.Unused := FUnused;
  result.Result := FResult;
end;

constructor TWMQueryEndSessionWrapper.Create(ARecord: TWMQueryEndSession);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FSource := ARecord.Source;
  FUnused := ARecord.Unused;
  FResult := ARecord.Result;
end;

function TWMQueryEndSessionWrapper.ObjToRec: TWMQueryEndSession;
begin
  result.Msg := FMsg;
  result.Source := FSource;
  result.Unused := FUnused;
  result.Result := FResult;
end;

constructor TWMQuitWrapper.Create(ARecord: TWMQuit);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FExitCode := ARecord.ExitCode;
  FUnused := ARecord.Unused;
  FResult := ARecord.Result;
end;

function TWMQuitWrapper.ObjToRec: TWMQuit;
begin
  result.Msg := FMsg;
  result.ExitCode := FExitCode;
  result.Unused := FUnused;
  result.Result := FResult;
end;

constructor TWMRenderFormatWrapper.Create(ARecord: TWMRenderFormat);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FFormat := ARecord.Format;
  FUnused := ARecord.Unused;
  FResult := ARecord.Result;
end;

function TWMRenderFormatWrapper.ObjToRec: TWMRenderFormat;
begin
  result.Msg := FMsg;
  result.Format := FFormat;
  result.Unused := FUnused;
  result.Result := FResult;
end;

constructor TWMSetCursorWrapper.Create(ARecord: TWMSetCursor);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FCursorWnd := ARecord.CursorWnd;
  FHitTest := ARecord.HitTest;
  FMouseMsg := ARecord.MouseMsg;
  FResult := ARecord.Result;
end;

function TWMSetCursorWrapper.ObjToRec: TWMSetCursor;
begin
  result.Msg := FMsg;
  result.CursorWnd := FCursorWnd;
  result.HitTest := FHitTest;
  result.MouseMsg := FMouseMsg;
  result.Result := FResult;
end;

constructor TWMSetFocusWrapper.Create(ARecord: TWMSetFocus);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FFocusedWnd := ARecord.FocusedWnd;
  FUnused := ARecord.Unused;
  FResult := ARecord.Result;
end;

function TWMSetFocusWrapper.ObjToRec: TWMSetFocus;
begin
  result.Msg := FMsg;
  result.FocusedWnd := FFocusedWnd;
  result.Unused := FUnused;
  result.Result := FResult;
end;

constructor TWMSetFontWrapper.Create(ARecord: TWMSetFont);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FFont := ARecord.Font;
  FRedraw := ARecord.Redraw;
  FUnused := ARecord.Unused;
  FResult := ARecord.Result;
end;

function TWMSetFontWrapper.ObjToRec: TWMSetFont;
begin
  result.Msg := FMsg;
  result.Font := FFont;
  result.Redraw := FRedraw;
  result.Unused := FUnused;
  result.Result := FResult;
end;

constructor TWMSetHotKeyWrapper.Create(ARecord: TWMSetHotKey);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FKey := ARecord.Key;
  FUnused := ARecord.Unused;
  FResult := ARecord.Result;
end;

function TWMSetHotKeyWrapper.ObjToRec: TWMSetHotKey;
begin
  result.Msg := FMsg;
  result.Key := FKey;
  result.Unused := FUnused;
  result.Result := FResult;
end;

constructor TWMSetIconWrapper.Create(ARecord: TWMSetIcon);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FBigIcon := ARecord.BigIcon;
  FIcon := ARecord.Icon;
  FResult := ARecord.Result;
end;

function TWMSetIconWrapper.ObjToRec: TWMSetIcon;
begin
  result.Msg := FMsg;
  result.BigIcon := FBigIcon;
  result.Icon := FIcon;
  result.Result := FResult;
end;

constructor TWMSetRedrawWrapper.Create(ARecord: TWMSetRedraw);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FRedraw := ARecord.Redraw;
  FUnused := ARecord.Unused;
  FResult := ARecord.Result;
end;

function TWMSetRedrawWrapper.ObjToRec: TWMSetRedraw;
begin
  result.Msg := FMsg;
  result.Redraw := FRedraw;
  result.Unused := FUnused;
  result.Result := FResult;
end;

constructor TWMSetTextWrapper.Create(ARecord: TWMSetText);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FUnused := ARecord.Unused;
  FResult := ARecord.Result;
end;

function TWMSetTextWrapper.ObjToRec: TWMSetText;
begin
  result.Msg := FMsg;
  result.Unused := FUnused;
  result.Result := FResult;
end;

constructor TWMShowWindowWrapper.Create(ARecord: TWMShowWindow);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FShow := ARecord.Show;
  FStatus := ARecord.Status;
  FResult := ARecord.Result;
end;

function TWMShowWindowWrapper.ObjToRec: TWMShowWindow;
begin
  result.Msg := FMsg;
  result.Show := FShow;
  result.Status := FStatus;
  result.Result := FResult;
end;

constructor TWMSizeWrapper.Create(ARecord: TWMSize);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FSizeType := ARecord.SizeType;
  FWidth := ARecord.Width;
  FHeight := ARecord.Height;
  FResult := ARecord.Result;
end;

function TWMSizeWrapper.ObjToRec: TWMSize;
begin
  result.Msg := FMsg;
  result.SizeType := FSizeType;
  result.Width := FWidth;
  result.Height := FHeight;
  result.Result := FResult;
end;

constructor TWMSizeClipboardWrapper.Create(ARecord: TWMSizeClipboard);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FViewer := ARecord.Viewer;
  FRC := ARecord.RC;
  FResult := ARecord.Result;
end;

function TWMSizeClipboardWrapper.ObjToRec: TWMSizeClipboard;
begin
  result.Msg := FMsg;
  result.Viewer := FViewer;
  result.RC := FRC;
  result.Result := FResult;
end;

constructor TWMSpoolerStatusWrapper.Create(ARecord: TWMSpoolerStatus);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FJobStatus := ARecord.JobStatus;
  FJobsLeft := ARecord.JobsLeft;
  FUnused := ARecord.Unused;
  FResult := ARecord.Result;
end;

function TWMSpoolerStatusWrapper.ObjToRec: TWMSpoolerStatus;
begin
  result.Msg := FMsg;
  result.JobStatus := FJobStatus;
  result.JobsLeft := FJobsLeft;
  result.Unused := FUnused;
  result.Result := FResult;
end;

constructor TWMStyleChangeWrapper.Create(ARecord: TWMStyleChange);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FStyleType := ARecord.StyleType;
  FResult := ARecord.Result;
end;

function TWMStyleChangeWrapper.ObjToRec: TWMStyleChange;
begin
  result.Msg := FMsg;
  result.StyleType := FStyleType;
  result.Result := FResult;
end;

constructor TWMSysCommandWrapper.Create(ARecord: TWMSysCommand);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FActivateWnd := ARecord.ActivateWnd;
  FKey := ARecord.Key;
  FXPos := ARecord.XPos;
  FYPos := ARecord.YPos;
  FResult := ARecord.Result;
end;

function TWMSysCommandWrapper.ObjToRec: TWMSysCommand;
begin
  result.Msg := FMsg;
  result.ActivateWnd := FActivateWnd;
  result.Key := FKey;
  result.XPos := FXPos;
  result.YPos := FYPos;
  result.Result := FResult;
end;

constructor TWMSysDeadCharWrapper.Create(ARecord: TWMSysDeadChar);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FCharCode := ARecord.CharCode;
  FUnused := ARecord.Unused;
  FKeyData := ARecord.KeyData;
  FResult := ARecord.Result;
end;

function TWMSysDeadCharWrapper.ObjToRec: TWMSysDeadChar;
begin
  result.Msg := FMsg;
  result.CharCode := FCharCode;
  result.Unused := FUnused;
  result.KeyData := FKeyData;
  result.Result := FResult;
end;

constructor TWMSystemErrorWrapper.Create(ARecord: TWMSystemError);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FErrSpec := ARecord.ErrSpec;
  FUnused := ARecord.Unused;
  FResult := ARecord.Result;
end;

function TWMSystemErrorWrapper.ObjToRec: TWMSystemError;
begin
  result.Msg := FMsg;
  result.ErrSpec := FErrSpec;
  result.Unused := FUnused;
  result.Result := FResult;
end;

constructor TWMTimerWrapper.Create(ARecord: TWMTimer);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FTimerID := ARecord.TimerID;
  FResult := ARecord.Result;
end;

function TWMTimerWrapper.ObjToRec: TWMTimer;
begin
  result.Msg := FMsg;
  result.TimerID := FTimerID;
  result.Result := FResult;
end;

constructor TWMUIStateWrapper.Create(ARecord: TWMUIState);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FAction := ARecord.Action;
  FFlags := ARecord.Flags;
  FUnused := ARecord.Unused;
end;

function TWMUIStateWrapper.ObjToRec: TWMUIState;
begin
  result.Msg := FMsg;
  result.Action := FAction;
  result.Flags := FFlags;
  result.Unused := FUnused;
end;

constructor TWMVScrollClipboardWrapper.Create(ARecord: TWMVScrollClipboard);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FViewer := ARecord.Viewer;
  FScollCode := ARecord.ScollCode;
  FThumbPos := ARecord.ThumbPos;
  FResult := ARecord.Result;
end;

function TWMVScrollClipboardWrapper.ObjToRec: TWMVScrollClipboard;
begin
  result.Msg := FMsg;
  result.Viewer := FViewer;
  result.ScollCode := FScollCode;
  result.ThumbPos := FThumbPos;
  result.Result := FResult;
end;

constructor TWMWinIniChangeWrapper.Create(ARecord: TWMWinIniChange);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FUnused := ARecord.Unused;
  FResult := ARecord.Result;
end;

function TWMWinIniChangeWrapper.ObjToRec: TWMWinIniChange;
begin
  result.Msg := FMsg;
  result.Unused := FUnused;
  result.Result := FResult;
end;

constructor TWMSettingChangeWrapper.Create(ARecord: TWMSettingChange);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FFlag := ARecord.Flag;
  FResult := ARecord.Result;
end;

function TWMSettingChangeWrapper.ObjToRec: TWMSettingChange;
begin
  result.Msg := FMsg;
  result.Flag := FFlag;
  result.Result := FResult;
end;

constructor TWMHelpWrapper.Create(ARecord: TWMHelp);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FUnused := ARecord.Unused;
  FResult := ARecord.Result;
end;

function TWMHelpWrapper.ObjToRec: TWMHelp;
begin
  result.Msg := FMsg;
  result.Unused := FUnused;
  result.Result := FResult;
end;

constructor TWMDisplayChangeWrapper.Create(ARecord: TWMDisplayChange);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FBitsPerPixel := ARecord.BitsPerPixel;
  FWidth := ARecord.Width;
  FHeight := ARecord.Height;
  FResult := ARecord.Result;
end;

function TWMDisplayChangeWrapper.ObjToRec: TWMDisplayChange;
begin
  result.Msg := FMsg;
  result.BitsPerPixel := FBitsPerPixel;
  result.Width := FWidth;
  result.Height := FHeight;
  result.Result := FResult;
end;

constructor TWMContextMenuWrapper.Create(ARecord: TWMContextMenu);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FhWnd := ARecord.hWnd;
  FXPos := ARecord.XPos;
  FYPos := ARecord.YPos;
  FResult := ARecord.Result;
end;

function TWMContextMenuWrapper.ObjToRec: TWMContextMenu;
begin
  result.Msg := FMsg;
  result.hWnd := FhWnd;
  result.XPos := FXPos;
  result.YPos := FYPos;
  result.Result := FResult;
end;



procedure TatMessagesLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    AddConstant('WM_NULL',WM_NULL);
    AddConstant('WM_CREATE',WM_CREATE);
    AddConstant('WM_DESTROY',WM_DESTROY);
    AddConstant('WM_MOVE',WM_MOVE);
    AddConstant('WM_SIZE',WM_SIZE);
    AddConstant('WM_ACTIVATE',WM_ACTIVATE);
    AddConstant('WM_SETFOCUS',WM_SETFOCUS);
    AddConstant('WM_KILLFOCUS',WM_KILLFOCUS);
    AddConstant('WM_ENABLE',WM_ENABLE);
    AddConstant('WM_SETREDRAW',WM_SETREDRAW);
    AddConstant('WM_SETTEXT',WM_SETTEXT);
    AddConstant('WM_GETTEXT',WM_GETTEXT);
    AddConstant('WM_GETTEXTLENGTH',WM_GETTEXTLENGTH);
    AddConstant('WM_PAINT',WM_PAINT);
    AddConstant('WM_CLOSE',WM_CLOSE);
    AddConstant('WM_QUERYENDSESSION',WM_QUERYENDSESSION);
    AddConstant('WM_QUIT',WM_QUIT);
    AddConstant('WM_QUERYOPEN',WM_QUERYOPEN);
    AddConstant('WM_ERASEBKGND',WM_ERASEBKGND);
    AddConstant('WM_SYSCOLORCHANGE',WM_SYSCOLORCHANGE);
    AddConstant('WM_ENDSESSION',WM_ENDSESSION);
    AddConstant('WM_SYSTEMERROR',WM_SYSTEMERROR);
    AddConstant('WM_SHOWWINDOW',WM_SHOWWINDOW);
    AddConstant('WM_CTLCOLOR',WM_CTLCOLOR);
    AddConstant('WM_WININICHANGE',WM_WININICHANGE);
    AddConstant('WM_SETTINGCHANGE',WM_SETTINGCHANGE);
    AddConstant('WM_DEVMODECHANGE',WM_DEVMODECHANGE);
    AddConstant('WM_ACTIVATEAPP',WM_ACTIVATEAPP);
    AddConstant('WM_FONTCHANGE',WM_FONTCHANGE);
    AddConstant('WM_TIMECHANGE',WM_TIMECHANGE);
    AddConstant('WM_CANCELMODE',WM_CANCELMODE);
    AddConstant('WM_SETCURSOR',WM_SETCURSOR);
    AddConstant('WM_MOUSEACTIVATE',WM_MOUSEACTIVATE);
    AddConstant('WM_CHILDACTIVATE',WM_CHILDACTIVATE);
    AddConstant('WM_QUEUESYNC',WM_QUEUESYNC);
    AddConstant('WM_GETMINMAXINFO',WM_GETMINMAXINFO);
    AddConstant('WM_PAINTICON',WM_PAINTICON);
    AddConstant('WM_ICONERASEBKGND',WM_ICONERASEBKGND);
    AddConstant('WM_NEXTDLGCTL',WM_NEXTDLGCTL);
    AddConstant('WM_SPOOLERSTATUS',WM_SPOOLERSTATUS);
    AddConstant('WM_DRAWITEM',WM_DRAWITEM);
    AddConstant('WM_MEASUREITEM',WM_MEASUREITEM);
    AddConstant('WM_DELETEITEM',WM_DELETEITEM);
    AddConstant('WM_VKEYTOITEM',WM_VKEYTOITEM);
    AddConstant('WM_CHARTOITEM',WM_CHARTOITEM);
    AddConstant('WM_SETFONT',WM_SETFONT);
    AddConstant('WM_GETFONT',WM_GETFONT);
    AddConstant('WM_SETHOTKEY',WM_SETHOTKEY);
    AddConstant('WM_GETHOTKEY',WM_GETHOTKEY);
    AddConstant('WM_QUERYDRAGICON',WM_QUERYDRAGICON);
    AddConstant('WM_COMPAREITEM',WM_COMPAREITEM);
    AddConstant('WM_GETOBJECT',WM_GETOBJECT);
    AddConstant('WM_COMPACTING',WM_COMPACTING);
    AddConstant('WM_COMMNOTIFY',WM_COMMNOTIFY);
    AddConstant('WM_WINDOWPOSCHANGING',WM_WINDOWPOSCHANGING);
    AddConstant('WM_WINDOWPOSCHANGED',WM_WINDOWPOSCHANGED);
    AddConstant('WM_POWER',WM_POWER);
    AddConstant('WM_COPYDATA',WM_COPYDATA);
    AddConstant('WM_CANCELJOURNAL',WM_CANCELJOURNAL);
    AddConstant('WM_NOTIFY',WM_NOTIFY);
    AddConstant('WM_INPUTLANGCHANGEREQUEST',WM_INPUTLANGCHANGEREQUEST);
    AddConstant('WM_INPUTLANGCHANGE',WM_INPUTLANGCHANGE);
    AddConstant('WM_TCARD',WM_TCARD);
    AddConstant('WM_HELP',WM_HELP);
    AddConstant('WM_USERCHANGED',WM_USERCHANGED);
    AddConstant('WM_NOTIFYFORMAT',WM_NOTIFYFORMAT);
    AddConstant('WM_CONTEXTMENU',WM_CONTEXTMENU);
    AddConstant('WM_STYLECHANGING',WM_STYLECHANGING);
    AddConstant('WM_STYLECHANGED',WM_STYLECHANGED);
    AddConstant('WM_DISPLAYCHANGE',WM_DISPLAYCHANGE);
    AddConstant('WM_GETICON',WM_GETICON);
    AddConstant('WM_SETICON',WM_SETICON);
    AddConstant('WM_NCCREATE',WM_NCCREATE);
    AddConstant('WM_NCDESTROY',WM_NCDESTROY);
    AddConstant('WM_NCCALCSIZE',WM_NCCALCSIZE);
    AddConstant('WM_NCHITTEST',WM_NCHITTEST);
    AddConstant('WM_NCPAINT',WM_NCPAINT);
    AddConstant('WM_NCACTIVATE',WM_NCACTIVATE);
    AddConstant('WM_GETDLGCODE',WM_GETDLGCODE);
    AddConstant('WM_NCMOUSEMOVE',WM_NCMOUSEMOVE);
    AddConstant('WM_NCLBUTTONDOWN',WM_NCLBUTTONDOWN);
    AddConstant('WM_NCLBUTTONUP',WM_NCLBUTTONUP);
    AddConstant('WM_NCLBUTTONDBLCLK',WM_NCLBUTTONDBLCLK);
    AddConstant('WM_NCRBUTTONDOWN',WM_NCRBUTTONDOWN);
    AddConstant('WM_NCRBUTTONUP',WM_NCRBUTTONUP);
    AddConstant('WM_NCRBUTTONDBLCLK',WM_NCRBUTTONDBLCLK);
    AddConstant('WM_NCMBUTTONDOWN',WM_NCMBUTTONDOWN);
    AddConstant('WM_NCMBUTTONUP',WM_NCMBUTTONUP);
    AddConstant('WM_NCMBUTTONDBLCLK',WM_NCMBUTTONDBLCLK);
    AddConstant('WM_KEYFIRST',WM_KEYFIRST);
    AddConstant('WM_KEYDOWN',WM_KEYDOWN);
    AddConstant('WM_KEYUP',WM_KEYUP);
    AddConstant('WM_CHAR',WM_CHAR);
    AddConstant('WM_DEADCHAR',WM_DEADCHAR);
    AddConstant('WM_SYSKEYDOWN',WM_SYSKEYDOWN);
    AddConstant('WM_SYSKEYUP',WM_SYSKEYUP);
    AddConstant('WM_SYSCHAR',WM_SYSCHAR);
    AddConstant('WM_SYSDEADCHAR',WM_SYSDEADCHAR);
    AddConstant('WM_KEYLAST',WM_KEYLAST);
    AddConstant('WM_INITDIALOG',WM_INITDIALOG);
    AddConstant('WM_COMMAND',WM_COMMAND);
    AddConstant('WM_SYSCOMMAND',WM_SYSCOMMAND);
    AddConstant('WM_TIMER',WM_TIMER);
    AddConstant('WM_HSCROLL',WM_HSCROLL);
    AddConstant('WM_VSCROLL',WM_VSCROLL);
    AddConstant('WM_INITMENU',WM_INITMENU);
    AddConstant('WM_INITMENUPOPUP',WM_INITMENUPOPUP);
    AddConstant('WM_MENUSELECT',WM_MENUSELECT);
    AddConstant('WM_MENUCHAR',WM_MENUCHAR);
    AddConstant('WM_ENTERIDLE',WM_ENTERIDLE);
    AddConstant('WM_MENURBUTTONUP',WM_MENURBUTTONUP);
    AddConstant('WM_MENUDRAG',WM_MENUDRAG);
    AddConstant('WM_MENUGETOBJECT',WM_MENUGETOBJECT);
    AddConstant('WM_UNINITMENUPOPUP',WM_UNINITMENUPOPUP);
    AddConstant('WM_MENUCOMMAND',WM_MENUCOMMAND);
    AddConstant('WM_CHANGEUISTATE',WM_CHANGEUISTATE);
    AddConstant('WM_UPDATEUISTATE',WM_UPDATEUISTATE);
    AddConstant('WM_QUERYUISTATE',WM_QUERYUISTATE);
    AddConstant('WM_CTLCOLORMSGBOX',WM_CTLCOLORMSGBOX);
    AddConstant('WM_CTLCOLOREDIT',WM_CTLCOLOREDIT);
    AddConstant('WM_CTLCOLORLISTBOX',WM_CTLCOLORLISTBOX);
    AddConstant('WM_CTLCOLORBTN',WM_CTLCOLORBTN);
    AddConstant('WM_CTLCOLORDLG',WM_CTLCOLORDLG);
    AddConstant('WM_CTLCOLORSCROLLBAR',WM_CTLCOLORSCROLLBAR);
    AddConstant('WM_CTLCOLORSTATIC',WM_CTLCOLORSTATIC);
    AddConstant('WM_MOUSEFIRST',WM_MOUSEFIRST);
    AddConstant('WM_MOUSEMOVE',WM_MOUSEMOVE);
    AddConstant('WM_LBUTTONDOWN',WM_LBUTTONDOWN);
    AddConstant('WM_LBUTTONUP',WM_LBUTTONUP);
    AddConstant('WM_LBUTTONDBLCLK',WM_LBUTTONDBLCLK);
    AddConstant('WM_RBUTTONDOWN',WM_RBUTTONDOWN);
    AddConstant('WM_RBUTTONUP',WM_RBUTTONUP);
    AddConstant('WM_RBUTTONDBLCLK',WM_RBUTTONDBLCLK);
    AddConstant('WM_MBUTTONDOWN',WM_MBUTTONDOWN);
    AddConstant('WM_MBUTTONUP',WM_MBUTTONUP);
    AddConstant('WM_MBUTTONDBLCLK',WM_MBUTTONDBLCLK);
    AddConstant('WM_MOUSEWHEEL',WM_MOUSEWHEEL);
    AddConstant('WM_MOUSELAST',WM_MOUSELAST);
    AddConstant('WM_PARENTNOTIFY',WM_PARENTNOTIFY);
    AddConstant('WM_ENTERMENULOOP',WM_ENTERMENULOOP);
    AddConstant('WM_EXITMENULOOP',WM_EXITMENULOOP);
    AddConstant('WM_NEXTMENU',WM_NEXTMENU);
    AddConstant('WM_SIZING',WM_SIZING);
    AddConstant('WM_CAPTURECHANGED',WM_CAPTURECHANGED);
    AddConstant('WM_MOVING',WM_MOVING);
    AddConstant('WM_POWERBROADCAST',WM_POWERBROADCAST);
    AddConstant('WM_DEVICECHANGE',WM_DEVICECHANGE);
    AddConstant('WM_IME_STARTCOMPOSITION',WM_IME_STARTCOMPOSITION);
    AddConstant('WM_IME_ENDCOMPOSITION',WM_IME_ENDCOMPOSITION);
    AddConstant('WM_IME_COMPOSITION',WM_IME_COMPOSITION);
    AddConstant('WM_IME_KEYLAST',WM_IME_KEYLAST);
    AddConstant('WM_IME_SETCONTEXT',WM_IME_SETCONTEXT);
    AddConstant('WM_IME_NOTIFY',WM_IME_NOTIFY);
    AddConstant('WM_IME_CONTROL',WM_IME_CONTROL);
    AddConstant('WM_IME_COMPOSITIONFULL',WM_IME_COMPOSITIONFULL);
    AddConstant('WM_IME_SELECT',WM_IME_SELECT);
    AddConstant('WM_IME_CHAR',WM_IME_CHAR);
    AddConstant('WM_IME_REQUEST',WM_IME_REQUEST);
    AddConstant('WM_IME_KEYDOWN',WM_IME_KEYDOWN);
    AddConstant('WM_IME_KEYUP',WM_IME_KEYUP);
    AddConstant('WM_MDICREATE',WM_MDICREATE);
    AddConstant('WM_MDIDESTROY',WM_MDIDESTROY);
    AddConstant('WM_MDIACTIVATE',WM_MDIACTIVATE);
    AddConstant('WM_MDIRESTORE',WM_MDIRESTORE);
    AddConstant('WM_MDINEXT',WM_MDINEXT);
    AddConstant('WM_MDIMAXIMIZE',WM_MDIMAXIMIZE);
    AddConstant('WM_MDITILE',WM_MDITILE);
    AddConstant('WM_MDICASCADE',WM_MDICASCADE);
    AddConstant('WM_MDIICONARRANGE',WM_MDIICONARRANGE);
    AddConstant('WM_MDIGETACTIVE',WM_MDIGETACTIVE);
    AddConstant('WM_MDISETMENU',WM_MDISETMENU);
    AddConstant('WM_ENTERSIZEMOVE',WM_ENTERSIZEMOVE);
    AddConstant('WM_EXITSIZEMOVE',WM_EXITSIZEMOVE);
    AddConstant('WM_DROPFILES',WM_DROPFILES);
    AddConstant('WM_MDIREFRESHMENU',WM_MDIREFRESHMENU);
    AddConstant('WM_MOUSEHOVER',WM_MOUSEHOVER);
    AddConstant('WM_MOUSELEAVE',WM_MOUSELEAVE);
    AddConstant('WM_CUT',WM_CUT);
    AddConstant('WM_COPY',WM_COPY);
    AddConstant('WM_PASTE',WM_PASTE);
    AddConstant('WM_CLEAR',WM_CLEAR);
    AddConstant('WM_UNDO',WM_UNDO);
    AddConstant('WM_RENDERFORMAT',WM_RENDERFORMAT);
    AddConstant('WM_RENDERALLFORMATS',WM_RENDERALLFORMATS);
    AddConstant('WM_DESTROYCLIPBOARD',WM_DESTROYCLIPBOARD);
    AddConstant('WM_DRAWCLIPBOARD',WM_DRAWCLIPBOARD);
    AddConstant('WM_PAINTCLIPBOARD',WM_PAINTCLIPBOARD);
    AddConstant('WM_VSCROLLCLIPBOARD',WM_VSCROLLCLIPBOARD);
    AddConstant('WM_SIZECLIPBOARD',WM_SIZECLIPBOARD);
    AddConstant('WM_ASKCBFORMATNAME',WM_ASKCBFORMATNAME);
    AddConstant('WM_CHANGECBCHAIN',WM_CHANGECBCHAIN);
    AddConstant('WM_HSCROLLCLIPBOARD',WM_HSCROLLCLIPBOARD);
    AddConstant('WM_QUERYNEWPALETTE',WM_QUERYNEWPALETTE);
    AddConstant('WM_PALETTEISCHANGING',WM_PALETTEISCHANGING);
    AddConstant('WM_PALETTECHANGED',WM_PALETTECHANGED);
    AddConstant('WM_HOTKEY',WM_HOTKEY);
    AddConstant('WM_PRINT',WM_PRINT);
    AddConstant('WM_PRINTCLIENT',WM_PRINTCLIENT);
    AddConstant('WM_HANDHELDFIRST',WM_HANDHELDFIRST);
    AddConstant('WM_HANDHELDLAST',WM_HANDHELDLAST);
    AddConstant('WM_PENWINFIRST',WM_PENWINFIRST);
    AddConstant('WM_PENWINLAST',WM_PENWINLAST);
    AddConstant('WM_COALESCE_FIRST',WM_COALESCE_FIRST);
    AddConstant('WM_COALESCE_LAST',WM_COALESCE_LAST);
    AddConstant('WM_DDE_FIRST',WM_DDE_FIRST);
    AddConstant('WM_DDE_INITIATE',WM_DDE_INITIATE);
    AddConstant('WM_DDE_TERMINATE',WM_DDE_TERMINATE);
    AddConstant('WM_DDE_ADVISE',WM_DDE_ADVISE);
    AddConstant('WM_DDE_UNADVISE',WM_DDE_UNADVISE);
    AddConstant('WM_DDE_ACK',WM_DDE_ACK);
    AddConstant('WM_DDE_DATA',WM_DDE_DATA);
    AddConstant('WM_DDE_REQUEST',WM_DDE_REQUEST);
    AddConstant('WM_DDE_POKE',WM_DDE_POKE);
    AddConstant('WM_DDE_EXECUTE',WM_DDE_EXECUTE);
    AddConstant('WM_DDE_LAST',WM_DDE_LAST);
    AddConstant('WM_APP',WM_APP);
    AddConstant('WM_USER',WM_USER);
    AddConstant('BN_CLICKED',BN_CLICKED);
    AddConstant('BN_PAINT',BN_PAINT);
    AddConstant('BN_HILITE',BN_HILITE);
    AddConstant('BN_UNHILITE',BN_UNHILITE);
    AddConstant('BN_DISABLE',BN_DISABLE);
    AddConstant('BN_DOUBLECLICKED',BN_DOUBLECLICKED);
    AddConstant('BN_PUSHED',BN_PUSHED);
    AddConstant('BN_UNPUSHED',BN_UNPUSHED);
    AddConstant('BN_DBLCLK',BN_DBLCLK);
    AddConstant('BN_SETFOCUS',BN_SETFOCUS);
    AddConstant('BN_KILLFOCUS',BN_KILLFOCUS);
    AddConstant('BM_GETCHECK',BM_GETCHECK);
    AddConstant('BM_SETCHECK',BM_SETCHECK);
    AddConstant('BM_GETSTATE',BM_GETSTATE);
    AddConstant('BM_SETSTATE',BM_SETSTATE);
    AddConstant('BM_SETSTYLE',BM_SETSTYLE);
    AddConstant('BM_CLICK',BM_CLICK);
    AddConstant('BM_GETIMAGE',BM_GETIMAGE);
    AddConstant('BM_SETIMAGE',BM_SETIMAGE);
    AddConstant('LBN_ERRSPACE',LBN_ERRSPACE);
    AddConstant('LBN_SELCHANGE',LBN_SELCHANGE);
    AddConstant('LBN_DBLCLK',LBN_DBLCLK);
    AddConstant('LBN_SELCANCEL',LBN_SELCANCEL);
    AddConstant('LBN_SETFOCUS',LBN_SETFOCUS);
    AddConstant('LBN_KILLFOCUS',LBN_KILLFOCUS);
    AddConstant('LB_ADDSTRING',LB_ADDSTRING);
    AddConstant('LB_INSERTSTRING',LB_INSERTSTRING);
    AddConstant('LB_DELETESTRING',LB_DELETESTRING);
    AddConstant('LB_SELITEMRANGEEX',LB_SELITEMRANGEEX);
    AddConstant('LB_RESETCONTENT',LB_RESETCONTENT);
    AddConstant('LB_SETSEL',LB_SETSEL);
    AddConstant('LB_SETCURSEL',LB_SETCURSEL);
    AddConstant('LB_GETSEL',LB_GETSEL);
    AddConstant('LB_GETCURSEL',LB_GETCURSEL);
    AddConstant('LB_GETTEXT',LB_GETTEXT);
    AddConstant('LB_GETTEXTLEN',LB_GETTEXTLEN);
    AddConstant('LB_GETCOUNT',LB_GETCOUNT);
    AddConstant('LB_SELECTSTRING',LB_SELECTSTRING);
    AddConstant('LB_DIR',LB_DIR);
    AddConstant('LB_GETTOPINDEX',LB_GETTOPINDEX);
    AddConstant('LB_FINDSTRING',LB_FINDSTRING);
    AddConstant('LB_GETSELCOUNT',LB_GETSELCOUNT);
    AddConstant('LB_GETSELITEMS',LB_GETSELITEMS);
    AddConstant('LB_SETTABSTOPS',LB_SETTABSTOPS);
    AddConstant('LB_GETHORIZONTALEXTENT',LB_GETHORIZONTALEXTENT);
    AddConstant('LB_SETHORIZONTALEXTENT',LB_SETHORIZONTALEXTENT);
    AddConstant('LB_SETCOLUMNWIDTH',LB_SETCOLUMNWIDTH);
    AddConstant('LB_ADDFILE',LB_ADDFILE);
    AddConstant('LB_SETTOPINDEX',LB_SETTOPINDEX);
    AddConstant('LB_GETITEMRECT',LB_GETITEMRECT);
    AddConstant('LB_GETITEMDATA',LB_GETITEMDATA);
    AddConstant('LB_SETITEMDATA',LB_SETITEMDATA);
    AddConstant('LB_SELITEMRANGE',LB_SELITEMRANGE);
    AddConstant('LB_SETANCHORINDEX',LB_SETANCHORINDEX);
    AddConstant('LB_GETANCHORINDEX',LB_GETANCHORINDEX);
    AddConstant('LB_SETCARETINDEX',LB_SETCARETINDEX);
    AddConstant('LB_GETCARETINDEX',LB_GETCARETINDEX);
    AddConstant('LB_SETITEMHEIGHT',LB_SETITEMHEIGHT);
    AddConstant('LB_GETITEMHEIGHT',LB_GETITEMHEIGHT);
    AddConstant('LB_FINDSTRINGEXACT',LB_FINDSTRINGEXACT);
    AddConstant('LB_SETLOCALE',LB_SETLOCALE);
    AddConstant('LB_GETLOCALE',LB_GETLOCALE);
    AddConstant('LB_SETCOUNT',LB_SETCOUNT);
    AddConstant('LB_INITSTORAGE',LB_INITSTORAGE);
    AddConstant('LB_ITEMFROMPOINT',LB_ITEMFROMPOINT);
    AddConstant('LB_MSGMAX',LB_MSGMAX);
    AddConstant('CBN_ERRSPACE',CBN_ERRSPACE);
    AddConstant('CBN_SELCHANGE',CBN_SELCHANGE);
    AddConstant('CBN_DBLCLK',CBN_DBLCLK);
    AddConstant('CBN_SETFOCUS',CBN_SETFOCUS);
    AddConstant('CBN_KILLFOCUS',CBN_KILLFOCUS);
    AddConstant('CBN_EDITCHANGE',CBN_EDITCHANGE);
    AddConstant('CBN_EDITUPDATE',CBN_EDITUPDATE);
    AddConstant('CBN_DROPDOWN',CBN_DROPDOWN);
    AddConstant('CBN_CLOSEUP',CBN_CLOSEUP);
    AddConstant('CBN_SELENDOK',CBN_SELENDOK);
    AddConstant('CBN_SELENDCANCEL',CBN_SELENDCANCEL);
    AddConstant('CB_GETEDITSEL',CB_GETEDITSEL);
    AddConstant('CB_LIMITTEXT',CB_LIMITTEXT);
    AddConstant('CB_SETEDITSEL',CB_SETEDITSEL);
    AddConstant('CB_ADDSTRING',CB_ADDSTRING);
    AddConstant('CB_DELETESTRING',CB_DELETESTRING);
    AddConstant('CB_DIR',CB_DIR);
    AddConstant('CB_GETCOUNT',CB_GETCOUNT);
    AddConstant('CB_GETCURSEL',CB_GETCURSEL);
    AddConstant('CB_GETLBTEXT',CB_GETLBTEXT);
    AddConstant('CB_GETLBTEXTLEN',CB_GETLBTEXTLEN);
    AddConstant('CB_INSERTSTRING',CB_INSERTSTRING);
    AddConstant('CB_RESETCONTENT',CB_RESETCONTENT);
    AddConstant('CB_FINDSTRING',CB_FINDSTRING);
    AddConstant('CB_SELECTSTRING',CB_SELECTSTRING);
    AddConstant('CB_SETCURSEL',CB_SETCURSEL);
    AddConstant('CB_SHOWDROPDOWN',CB_SHOWDROPDOWN);
    AddConstant('CB_GETITEMDATA',CB_GETITEMDATA);
    AddConstant('CB_SETITEMDATA',CB_SETITEMDATA);
    AddConstant('CB_GETDROPPEDCONTROLRECT',CB_GETDROPPEDCONTROLRECT);
    AddConstant('CB_SETITEMHEIGHT',CB_SETITEMHEIGHT);
    AddConstant('CB_GETITEMHEIGHT',CB_GETITEMHEIGHT);
    AddConstant('CB_SETEXTENDEDUI',CB_SETEXTENDEDUI);
    AddConstant('CB_GETEXTENDEDUI',CB_GETEXTENDEDUI);
    AddConstant('CB_GETDROPPEDSTATE',CB_GETDROPPEDSTATE);
    AddConstant('CB_FINDSTRINGEXACT',CB_FINDSTRINGEXACT);
    AddConstant('CB_SETLOCALE',CB_SETLOCALE);
    AddConstant('CB_GETLOCALE',CB_GETLOCALE);
    AddConstant('CB_GETTOPINDEX',CB_GETTOPINDEX);
    AddConstant('CB_SETTOPINDEX',CB_SETTOPINDEX);
    AddConstant('CB_GETHORIZONTALEXTENT',CB_GETHORIZONTALEXTENT);
    AddConstant('CB_SETHORIZONTALEXTENT',CB_SETHORIZONTALEXTENT);
    AddConstant('CB_GETDROPPEDWIDTH',CB_GETDROPPEDWIDTH);
    AddConstant('CB_SETDROPPEDWIDTH',CB_SETDROPPEDWIDTH);
    AddConstant('CB_INITSTORAGE',CB_INITSTORAGE);
    AddConstant('CB_MSGMAX',CB_MSGMAX);
    AddConstant('EN_SETFOCUS',EN_SETFOCUS);
    AddConstant('EN_KILLFOCUS',EN_KILLFOCUS);
    AddConstant('EN_CHANGE',EN_CHANGE);
    AddConstant('EN_UPDATE',EN_UPDATE);
    AddConstant('EN_ERRSPACE',EN_ERRSPACE);
    AddConstant('EN_MAXTEXT',EN_MAXTEXT);
    AddConstant('EN_HSCROLL',EN_HSCROLL);
    AddConstant('EN_VSCROLL',EN_VSCROLL);
    AddConstant('EM_GETSEL',EM_GETSEL);
    AddConstant('EM_SETSEL',EM_SETSEL);
    AddConstant('EM_GETRECT',EM_GETRECT);
    AddConstant('EM_SETRECT',EM_SETRECT);
    AddConstant('EM_SETRECTNP',EM_SETRECTNP);
    AddConstant('EM_SCROLL',EM_SCROLL);
    AddConstant('EM_LINESCROLL',EM_LINESCROLL);
    AddConstant('EM_SCROLLCARET',EM_SCROLLCARET);
    AddConstant('EM_GETMODIFY',EM_GETMODIFY);
    AddConstant('EM_SETMODIFY',EM_SETMODIFY);
    AddConstant('EM_GETLINECOUNT',EM_GETLINECOUNT);
    AddConstant('EM_LINEINDEX',EM_LINEINDEX);
    AddConstant('EM_SETHANDLE',EM_SETHANDLE);
    AddConstant('EM_GETHANDLE',EM_GETHANDLE);
    AddConstant('EM_GETTHUMB',EM_GETTHUMB);
    AddConstant('EM_LINELENGTH',EM_LINELENGTH);
    AddConstant('EM_REPLACESEL',EM_REPLACESEL);
    AddConstant('EM_GETLINE',EM_GETLINE);
    AddConstant('EM_LIMITTEXT',EM_LIMITTEXT);
    AddConstant('EM_CANUNDO',EM_CANUNDO);
    AddConstant('EM_UNDO',EM_UNDO);
    AddConstant('EM_FMTLINES',EM_FMTLINES);
    AddConstant('EM_LINEFROMCHAR',EM_LINEFROMCHAR);
    AddConstant('EM_SETTABSTOPS',EM_SETTABSTOPS);
    AddConstant('EM_SETPASSWORDCHAR',EM_SETPASSWORDCHAR);
    AddConstant('EM_EMPTYUNDOBUFFER',EM_EMPTYUNDOBUFFER);
    AddConstant('EM_GETFIRSTVISIBLELINE',EM_GETFIRSTVISIBLELINE);
    AddConstant('EM_SETREADONLY',EM_SETREADONLY);
    AddConstant('EM_SETWORDBREAKPROC',EM_SETWORDBREAKPROC);
    AddConstant('EM_GETWORDBREAKPROC',EM_GETWORDBREAKPROC);
    AddConstant('EM_GETPASSWORDCHAR',EM_GETPASSWORDCHAR);
    AddConstant('EM_SETMARGINS',EM_SETMARGINS);
    AddConstant('EM_GETMARGINS',EM_GETMARGINS);
    AddConstant('EM_SETLIMITTEXT',EM_SETLIMITTEXT);
    AddConstant('EM_GETLIMITTEXT',EM_GETLIMITTEXT);
    AddConstant('EM_POSFROMCHAR',EM_POSFROMCHAR);
    AddConstant('EM_CHARFROMPOS',EM_CHARFROMPOS);
    AddConstant('EM_SETIMESTATUS',EM_SETIMESTATUS);
    AddConstant('EM_GETIMESTATUS',EM_GETIMESTATUS);
    AddConstant('SBM_SETPOS',SBM_SETPOS);
    AddConstant('SBM_GETPOS',SBM_GETPOS);
    AddConstant('SBM_SETRANGE',SBM_SETRANGE);
    AddConstant('SBM_SETRANGEREDRAW',SBM_SETRANGEREDRAW);
    AddConstant('SBM_GETRANGE',SBM_GETRANGE);
    AddConstant('SBM_ENABLE_ARROWS',SBM_ENABLE_ARROWS);
    AddConstant('SBM_SETSCROLLINFO',SBM_SETSCROLLINFO);
    AddConstant('SBM_GETSCROLLINFO',SBM_GETSCROLLINFO);
    AddConstant('DM_GETDEFID',DM_GETDEFID);
    AddConstant('DM_SETDEFID',DM_SETDEFID);
    AddConstant('DM_REPOSITION',DM_REPOSITION);
    AddConstant('PSM_PAGEINFO',PSM_PAGEINFO);
    AddConstant('PSM_SHEETINFO',PSM_SHEETINFO);
  end;
end;

class function TatMessagesLibrary.LibraryName: string;
begin
  result := 'Messages';
end;

initialization
  RegisterScripterLibrary(TatMessagesLibrary, True);

{$WARNINGS ON}

end.

