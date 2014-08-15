{********************************************************************}
{                                                                    }
{       Developer Express Visual Component Library                   }
{       ExpressSpellChecker                                          }
{                                                                    }
{       Copyright (c) 1998-2010 Developer Express Inc.               }
{       ALL RIGHTS RESERVED                                          }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSSPELLCHECKER AND ALL           }
{   ACCOMPANYING VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY. }
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

unit dxSpellCheckerCheckAsYouType;

{$I cxVer.inc}

interface

uses
  Types, Windows, SysUtils, Messages, Classes, Graphics, cxClasses, Controls,
  Forms, StdCtrls, cxControls, dxSpellCheckerRules, dxSpellCheckerAlgorithms,
  cxLookAndFeels, dxSpellChecker, cxGeometry, ExtCtrls, Menus, cxEdit;

type
  TdxSpellCheckerCheckAsYouTypeMode = class;
  TdxSpellCheckerCheckAsYouTypeManager = class;

  TdxSpellCheckerCheckAsYouTypeCurrentWordInfo = packed record
    Bounds: TRect;
    IsMisspelled: Boolean;
  end;

  { TdxSpellCheckerSpelledWord }

  TdxSpellCheckerSpelledWord = class(TObject)
  private
    FChecked: Boolean;
    FPosition: Integer;
    FWord: WideString;
    function GetEndPosition: Integer;
  public
    constructor Create(APosition: Integer; const AWord: WideString); virtual;

    property Checked: Boolean read FChecked write FChecked;
    property EndPosition: Integer read GetEndPosition;
    property Position: Integer read FPosition write FPosition;
    property Word: WideString read FWord;
  end;

  TdxSpellCheckerSpelledWordClass = class of TdxSpellCheckerSpelledWord;

  { TdxSpellCheckerSpelledWordList }

  TdxSpellCheckerSpelledWordList = class(TcxObjectList)
  private
    function GetItem(AIndex: Integer): TdxSpellCheckerSpelledWord;
  protected
    function GetSpellCheckerWordClass: TdxSpellCheckerSpelledWordClass; virtual;
  public
    function AddWord(APos: Integer; const AWord: WideString): TdxSpellCheckerSpelledWord;
    procedure DropCheckedFlag;
    function FindWord(const AWord: WideString;
      AUncheckedOnly: Boolean; out AItem: TdxSpellCheckerSpelledWord): Boolean;
    procedure RemoveItem(AItem: TdxSpellCheckerSpelledWord); virtual;
    procedure RemoveUncheckedItems;

    property Items[Index: Integer]: TdxSpellCheckerSpelledWord read GetItem; default;
  end;

  { TdxSpellCheckerMisspelledWord }

  TdxSpellCheckerMisspelledWord = class(TdxSpellCheckerSpelledWord)
  private
    FBounds: array of TRect;
    FShowSquiggle: Boolean;
    FSpellingCode: TdxSpellCheckerSpellingCode;
    function GetUnderlineRect(Index: Integer): TRect;
    function GetUnderlineRectCount: Integer;
  public
    constructor Create(APosition: Integer; const AWord: WideString); override;
    destructor Destroy; override;
    procedure AddRect(const R: TRect);
    function Contains(const APoint: TPoint): Boolean;
    procedure DeleteUnderlineRects;
    //
    property ShowSquiggle: Boolean read FShowSquiggle write FShowSquiggle;
    property SpellingCode: TdxSpellCheckerSpellingCode read FSpellingCode;
    property UnderlineRect[Index: Integer]: TRect read GetUnderlineRect;
    property UnderlineRectCount: Integer read GetUnderlineRectCount;
  end;

  { TdxSpellCheckerMisspelledWordList }

  TdxSpellCheckerMisspelledWordList = class(TdxSpellCheckerSpelledWordList)
  private
    function GetItem(AIndex: Integer): TdxSpellCheckerMisspelledWord;
  protected
    function GetSpellCheckerWordClass: TdxSpellCheckerSpelledWordClass; override;
  public
    function AddWord(APos: Integer; const AWord: WideString): TdxSpellCheckerMisspelledWord;
    function FindWord(const AWord: WideString; AUncheckedOnly: Boolean;
      out AItem: TdxSpellCheckerMisspelledWord): Boolean;
    function ItemAtIndex(AIndex: Integer; out AWord: TdxSpellCheckerMisspelledWord): Boolean;
    function ItemAtPos(const APoint: TPoint; out AWord: TdxSpellCheckerMisspelledWord): Boolean;

    property Items[Index: Integer]: TdxSpellCheckerMisspelledWord read GetItem; default;
  end;

  { TdxSpellCheckerPainter }

  TdxSpellCheckerPainter = class(TObject)
  private
    FLineColor: TColor;
    FLineStyle: TdxSpellCheckerUnderlineStyle;
    procedure SetLineColor(const Value: TColor);
  protected
    procedure Draw(DC: HDC; const R: TRect; ALineStyleNeeded: Boolean);
    procedure DrawLine(DC: HDC; const R: TRect); virtual;
    procedure DrawWavyLine(DC: HDC; const R: TRect); virtual;
  public
    constructor Create(ALineColor: TColor);
    procedure DrawWord(DC: HDC; ALineStyleNeeded: Boolean;
      AWord: TdxSpellCheckerMisspelledWord);

    property LineColor: TColor read FLineColor write SetLineColor;
    property LineStyle: TdxSpellCheckerUnderlineStyle read FLineStyle write FLineStyle;
  end;

  { TdxSpellCheckerCheckAsYouTypeTextParser }

  TdxSpellCheckerCheckAsYouTypeTextParser = class(TdxSpellCheckerTextParser)
  private
    FVisibleEndIndex: Integer;
    FVisibleStartIndex: Integer;
  protected
    procedure UpdateTextInfo(AAdapter: TdxSpellCheckerCustomEditAdapter); override;
  public
    function GetNextWord(var AStart, ALength: Integer;
      out ADelimiters: WideString): WideString; override;
    function IsCharVisible(APosition: Integer): Boolean;
    function IsWordVisible(APosition, AWordLength: Integer): Boolean;

    property VisibleEndIndex: Integer read FVisibleEndIndex;
    property VisibleStartIndex: Integer read FVisibleStartIndex;
  end;

  { TdxSpellCheckerCheckAsYouTypeThread }

  TdxSpellCheckerCheckAsYouTypeThread = class(TcxThread)
  private
    FCheckMode: TdxSpellCheckerCheckAsYouTypeMode;
  protected
    procedure Execute; override;
  public
    constructor Create(ACheckMode: TdxSpellCheckerCheckAsYouTypeMode);
    //
    property CheckMode: TdxSpellCheckerCheckAsYouTypeMode read FCheckMode;
  end;

  { TdxSpellCheckerCheckAsYouTypeEditAdapter }

  TdxSpellCheckerCheckAsYouTypeEditAdapter = class(TdxSpellCheckerEditAdapter)
  private
    FIsLineDrawStyleNeeded: Boolean;
    FLineHeight: Integer;
    function GetIsMultiLine: Boolean;
  protected
    function GetCharIndex(const APoint: TPoint): Integer; virtual;
    function GetCharPosition(ACharIndex: Integer): TPoint; virtual;
    function GetFirstCharIndexInLine(ALineIndex: Integer): Integer; virtual;
    function GetFirstVisibleLineIndex: Integer; virtual;
    function GetLineHeight(ACharIndex: Integer): Integer; virtual;
    function GetLineIndex(ACharIndex: Integer): Integer; virtual;
    function GetLineLength(ALineIndex: Integer): Integer; virtual;
    function GetSpellingStartPosition: Integer; virtual;
    function GetTextAreaRect: TRect; virtual;
    function GetTextWidth(APosition, ALength: Integer): Integer; virtual;
    procedure GetVisibleTextBounds(out AStartIndex, AEndIndex: Integer); virtual;
    function InternalGetLineHeightByFont(ALineIndex: Integer): Integer; virtual;
  public
    procedure RefreshParams; virtual;
    //
    property IsLineDrawStyleNeeded: Boolean read FIsLineDrawStyleNeeded;
    property IsMultiLine: Boolean read GetIsMultiLine;
    property TextAreaRect: TRect read GetTextAreaRect;
  end;

  TdxSpellCheckerCheckAsYouTypeEditAdapterClass = class of TdxSpellCheckerCheckAsYouTypeEditAdapter;

  { TdxSpellCheckerCheckAsYouTypeViewInfoItem }

  TdxSpellCheckerCheckAsYouTypeViewInfoItem = class(TObject)
  private
    FBounds: TRect;
    FExcludeFromRegion: Boolean;
  public
    constructor Create(const ABounds: TRect);

    property Bounds: TRect read FBounds write FBounds;
    property ExcludeFromRegion: Boolean read FExcludeFromRegion write FExcludeFromRegion;
  end;

  { TdxSpellCheckerCheckAsYouTypeViewInfoList }

  TdxSpellCheckerCheckAsYouTypeViewInfoList = class(TcxObjectList)
  private
    function GetItem(Index: Integer): TdxSpellCheckerCheckAsYouTypeViewInfoItem;
  public
    procedure AddItem(const R: TRect);
    function CreateUpdateRegion: HRGN;
    function FindItem(const R: TRect;
      out AItem: TdxSpellCheckerCheckAsYouTypeViewInfoItem): Boolean;

    property Items[Index: Integer]: TdxSpellCheckerCheckAsYouTypeViewInfoItem read GetItem;
  end;

  { TdxSpellCheckerCheckAsYouTypeViewInfo }

  TdxSpellCheckerCheckAsYouTypeViewInfo = class(TObject)
  private
    FRectsToDraw: TdxSpellCheckerCheckAsYouTypeViewInfoList;
    FRectsToErase: TdxSpellCheckerCheckAsYouTypeViewInfoList;
    FUpdateRgn: HRGN;
    procedure AddWordToList(AList: TdxSpellCheckerCheckAsYouTypeViewInfoList;
      AWord: TdxSpellCheckerMisspelledWord);
    function GetUpdateRegion: HRGN;
  protected
    procedure DoChanged;
  public
    constructor Create; virtual;
    destructor Destroy; override;

    procedure AddToDrawRegion(const AList: TdxSpellCheckerMisspelledWordList);
    procedure AddToEraseRegion(const AList: TdxSpellCheckerMisspelledWordList);
    procedure ClearRegions;

    property RectsToDraw: TdxSpellCheckerCheckAsYouTypeViewInfoList read FRectsToDraw;
    property RectsToErase: TdxSpellCheckerCheckAsYouTypeViewInfoList read FRectsToErase;
    property UpdateRegion: HRGN read GetUpdateRegion;
  end;

  { TdxSpellCheckerCheckAsYouTypeMode }

  TdxSpellCheckerCheckAsYouTypeMode = class(TdxSpellCheckerCustomCheckMode)
  private
    FCheckThread: TdxSpellCheckerCheckAsYouTypeThread;
    FCorrectWords: TdxSpellCheckerSpelledWordList;
    FCurrentWordInfo: TdxSpellCheckerCheckAsYouTypeCurrentWordInfo;
    FCursorPosition: Integer;
    FDelayTimer: TTimer;
    FLock: TRTLCriticalSection;
    FManager: TdxSpellCheckerCheckAsYouTypeManager;
    FMisspelledWords: TdxSpellCheckerMisspelledWordList;
    FSelectionLength: Integer;
    FTypingPosition: Integer;
    FViewInfo: TdxSpellCheckerCheckAsYouTypeViewInfo;
    function GetAdapter: TdxSpellCheckerCheckAsYouTypeEditAdapter;
    function GetPainter: TdxSpellCheckerPainter;
  protected
    procedure AddMisspelledWord(const AWord: WideString);
    procedure CalculateBounds(AWord: TdxSpellCheckerMisspelledWord);
    function CanStartSpellingThread: Boolean; virtual;
    procedure Changed(AFullRefresh: Boolean); virtual;
    function GetParserClass: TdxSpellCheckerTextParserClass; override;
    function GetSelectedMisspelledWord(out AWord: TdxSpellCheckerMisspelledWord): Boolean;
    function InternalProcessWord(const AWord: WideString): Boolean; override;
    function IsInCurrentWordBounds(APosition: Integer): Boolean;
    function IsValidWord(const AWord: WideString): Boolean; override;
    procedure DelayTimerEvent(Sender: TObject);
    procedure SelectionChanged;
    procedure SetMisspelledWordInfo(AWord: TdxSpellCheckerMisspelledWord);
    procedure StartSpellingThread(ADelayed: Boolean); overload;
    procedure StartSpellingThread; overload; virtual;
    procedure StopSpellingThread;
    procedure TextChanged;
    procedure UpdateByDictionary(ADictionary: TdxCustomSpellCheckerDictionary); override;
    //
    property CursorPosition: Integer read FCursorPosition;
    property DelayTimer: TTimer read FDelayTimer;
    property SelectionLength: Integer read FSelectionLength;
    property TypingPosition: Integer read FTypingPosition;
  public
    constructor Create(ASpellChecker: TdxCustomSpellChecker;
      AAdapter: TdxSpellCheckerCustomEditAdapter); override;
    destructor Destroy; override;

    procedure Add; override;
    procedure Change(const AWord: WideString); override;
    procedure Delete; override;
    procedure Draw(DC: HDC);
    procedure IgnoreAll; override;
    procedure InvalidateEditor;
    procedure Lock;
    procedure SpellingBegin;
    procedure SpellingDone(AAborted: Boolean);
    procedure Unlock;

    property Adapter: TdxSpellCheckerCheckAsYouTypeEditAdapter read GetAdapter;
    property CheckThread: TdxSpellCheckerCheckAsYouTypeThread read FCheckThread;
    property CorrectWords: TdxSpellCheckerSpelledWordList read FCorrectWords;
    property Manager: TdxSpellCheckerCheckAsYouTypeManager read FManager;
    property MisspelledWords: TdxSpellCheckerMisspelledWordList read FMisspelledWords;
    property Painter: TdxSpellCheckerPainter read GetPainter;
    property ViewInfo: TdxSpellCheckerCheckAsYouTypeViewInfo read FViewInfo;
  end;

  { TdxSpellCheckerCheckAsYouTypeManager }

  TdxSpellCheckerCheckAsYouTypeManager = class(TdxSpellCheckerCustomCheckAsYouTypeManager)
  private
    FInternalPopupMenu: TPopupMenu;
    FMisspelledItem: TdxSpellCheckerMisspelledWord;
    FPainter: TdxSpellCheckerPainter;
    function GetAdapter: TdxSpellCheckerCheckAsYouTypeEditAdapter;
    function GetCheckMode: TdxSpellCheckerCheckAsYouTypeMode;
  protected
    function CanPopup(const P: TPoint): Boolean; virtual;
    procedure CreateInternalPopupMenu; virtual;
    procedure CreateItems(APopup: TPopupMenu; AList: TcxObjectList); virtual;
    procedure DoActiveChanged; override;
    procedure DoFinalizeController; override;
    procedure DoOptionsChanged; override;
    function GetAdapterClass(
      AControl: TWinControl): TdxSpellCheckerCustomEditAdapterClass; override;
    function GetCheckModeClass: TdxSpellCheckerCustomCheckModeClass; override;
    procedure MenuItemClickHandler(ASender: TObject);
    procedure RedrawEditor;
    procedure Reset; override;
    procedure SpellingOptionsChanged; override;
    procedure ValidateAdapter; override;

    property InternalPopupMenu: TPopupMenu read FInternalPopupMenu write FInternalPopupMenu;
  public
    constructor Create(ASpellChecker: TdxCustomSpellChecker); override;
    destructor Destroy; override;
    procedure Refresh(AFullRefresh: Boolean = False); override;

    procedure DrawMisspellings(AControl: TWinControl); override;
    procedure LayoutChanged(AControl: TWinControl); override;
    function QueryPopup(APopup: TComponent; const P: TPoint): Boolean; override;
    procedure SelectionChanged(AControl: TWinControl); override;
    procedure TextChanged(AControl: TWinControl); override;

    property Adapter: TdxSpellCheckerCheckAsYouTypeEditAdapter read GetAdapter;
    property CheckMode: TdxSpellCheckerCheckAsYouTypeMode read GetCheckMode;
    property MisspelledItem: TdxSpellCheckerMisspelledWord read FMisspelledItem write FMisspelledItem;
    property Painter: TdxSpellCheckerPainter read FPainter;
  end;


implementation

uses
  cxRichEdit, dxOffice11, cxTextEdit, ComCtrls, RichEdit, Dialogs, ComObj,
  cxGraphics, dxSpellCheckerStrs, cxContainer, dxSpellCheckerDialogs, dxCore,
  dxSpellCheckerUtils, Math;

const
  dxSpellCheckerCheckAsYouTypeTimeDelay = 200;
  dxSpellCheckerUnderlineSize = 3;

type
  TcxRichInnerEditAccess = class(TcxRichInnerEdit);
  TdxCustomSpellCheckerAccess = class(TdxCustomSpellChecker);

  { TdxSpellCheckerCheckAsYouTypeRichEditAdapter }

  TdxSpellCheckerCheckAsYouTypeRichEditAdapter = class(TdxSpellCheckerCheckAsYouTypeEditAdapter)
  private
    FRichVersion: Integer;
  protected
    function GetCharIndex(const APoint: TPoint): Integer; override;
    function GetCharPosition(ACharIndex: Integer): TPoint; override;
    function GetLineHeight(ACharIndex: Integer): Integer; override;
    function GetText: WideString; override;
    function GetTextWidth(APosition, ALength: Integer): Integer; override;
    function InternalGetLineHeightByFont(ALineIndex: Integer): Integer; override;
    procedure SetHideSelection(AValue: Boolean); override;
    //
    property RichVersion: Integer read FRichVersion;
  public
    constructor Create(AEdit: TWinControl); override;
  end;

{ TdxSpellCheckerCheckAsYouTypeRichEditAdapter }

constructor TdxSpellCheckerCheckAsYouTypeRichEditAdapter.Create(AEdit: TWinControl);
begin
  FRichVersion := TcxRichInnerEditAccess(AEdit).RichVersion;
  inherited Create(AEdit);
end;

function TdxSpellCheckerCheckAsYouTypeRichEditAdapter.GetCharIndex(
  const APoint: TPoint): Integer;
begin
  Result := SendMessage(EditorHandle, EM_CHARFROMPOS, 0, LParam(@APoint));
end;

function TdxSpellCheckerCheckAsYouTypeRichEditAdapter.GetCharPosition(
  ACharIndex: Integer): TPoint;
begin
  if (RichVersion >= 200) and (RichVersion < 300) then
    Result := inherited GetCharPosition(ACharIndex)
  else
    SendMessage(EditorHandle, EM_POSFROMCHAR, WParam(@Result), ACharIndex);
end;

function TdxSpellCheckerCheckAsYouTypeRichEditAdapter.GetLineHeight(ACharIndex: Integer): Integer;
var
  ALineIndex: Integer;
begin
  if not IsMultiLine then
    Result := InternalGetLineHeightByFont(0)
  else
  begin
    ALineIndex := GetLineIndex(ACharIndex);
    Result := GetFirstCharIndexInLine(ALineIndex + 1);
    if Result = -1 then
      Result := InternalGetLineHeightByFont(ALineIndex)
    else
    begin
      Result := GetCharPosition(Result).Y - GetCharPosition(ACharIndex).Y;
      if Result <= 0 then
        Result := InternalGetLineHeightByFont(ALineIndex);
    end;
  end;
end;

function TdxSpellCheckerCheckAsYouTypeRichEditAdapter.GetText: WideString;
var
  ADest: WideString;
  ALen: Integer;
  ASource: WideString;
begin
  ASource := inherited GetText;
  ALen := Length(ASource);
  SetLength(ADest, ALen);
  ALen := AdjustRichLineBreaksW(PWideChar(ADest), PWideChar(ASource), RichVersion >= 200);
  SetLength(ADest, ALen);
  Result := ADest;
end;

function TdxSpellCheckerCheckAsYouTypeRichEditAdapter.GetTextWidth(APosition, ALength: Integer): Integer;
begin
  if GetLineIndex(APosition) = GetLineIndex(APosition + ALength) then
    Result := GetCharPosition(APosition + ALength).X - GetCharPosition(APosition).X
  else
    if ALength > 1 then
    begin
      Result := GetCharPosition(APosition + ALength - 1).X - GetCharPosition(APosition).X;
      Result := Result + Result div (ALength - 1);
    end
    else
      Result := 0;
end;

function TdxSpellCheckerCheckAsYouTypeRichEditAdapter.InternalGetLineHeightByFont(
  ALineIndex: Integer): Integer;
var
  ACharIndex: Integer;
  DC: HDC;
begin
  DC := GetDC(EditorHandle);
  try
    ACharIndex := GetFirstCharIndexInLine(ALineIndex);
    cxDrawRichEdit(DC, TextAreaRect, EditorHandle, ACharIndex,
      ACharIndex + GetLineLength(ALineIndex), True, Result);
  finally
    ReleaseDC(EditorHandle, DC);
  end;
end;

procedure TdxSpellCheckerCheckAsYouTypeRichEditAdapter.SetHideSelection(
  AValue: Boolean);
begin
  SendMessage(EditorHandle, EM_HIDESELECTION, Ord(AValue), 0);
end; 

{ TdxSpellCheckerCheckAsYouTypeThread }

constructor TdxSpellCheckerCheckAsYouTypeThread.Create(
  ACheckMode: TdxSpellCheckerCheckAsYouTypeMode);
begin
  FCheckMode := ACheckMode;
  inherited Create(False, True);
end;

procedure TdxSpellCheckerCheckAsYouTypeThread.Execute;
var
  AWord: WideString;
begin
  try
    while not (Terminated or Destroying) do
    begin
      CheckForPause;
      CheckMode.SpellingBegin;
      try
        while Running and CheckMode.GetNextWord(AWord)  do
        begin
          if not Running then
            Break
          else
            if CheckMode.InternalProcessWord(AWord) then
              Continue;

          if CheckMode.InternalCheckWord(AWord) <> scNoError then
          begin
            if Running then
              CheckMode.AddMisspelledWord(AWord)
            else
              Break;
          end;
          CheckMode.PrevWord := AWord;
          Inc(CheckMode.FMisspellingStart, CheckMode.FMisspellingLen);
        end;
      finally
        CheckMode.SpellingDone(not Running);
        Pause;
      end;
    end;
  except
    HandleException;
  end;
end;

{ TdxSpellCheckerCheckAsYouTypeMode }

constructor TdxSpellCheckerCheckAsYouTypeMode.Create(
  ASpellChecker: TdxCustomSpellChecker; AAdapter: TdxSpellCheckerCustomEditAdapter);
begin
  inherited Create(ASpellChecker, AAdapter);
  FManager := TdxSpellCheckerCheckAsYouTypeManager(TdxCustomSpellCheckerAccess(ASpellChecker).CheckAsYouTypeManager);
  FCorrectWords := TdxSpellCheckerSpelledWordList.Create;
  FMisspelledWords := TdxSpellCheckerMisspelledWordList.Create;
  FViewInfo := TdxSpellCheckerCheckAsYouTypeViewInfo.Create;
  InitializeCriticalSection(FLock);
  FCheckThread := TdxSpellCheckerCheckAsYouTypeThread.Create(Self);
  FDelayTimer := TTimer.Create(nil);
  FDelayTimer.Enabled := False;
  FDelayTimer.Interval := dxSpellCheckerCheckAsYouTypeTimeDelay div 2;
  FDelayTimer.OnTimer := DelayTimerEvent;
  FTypingPosition := -1;
  Changed(True);
end;

destructor TdxSpellCheckerCheckAsYouTypeMode.Destroy;
begin
  FreeAndNil(FCheckThread);
  FreeAndNil(FCorrectWords);
  FreeAndNil(FDelayTimer);
  FreeAndNil(FMisspelledWords);
  FreeAndNil(FViewInfo);
  DeleteCriticalSection(FLock);
  inherited Destroy;
end;

function TdxSpellCheckerCheckAsYouTypeMode.GetAdapter: TdxSpellCheckerCheckAsYouTypeEditAdapter;
begin
  Result := TdxSpellCheckerCheckAsYouTypeEditAdapter(inherited Adapter);
end;

function TdxSpellCheckerCheckAsYouTypeMode.GetPainter: TdxSpellCheckerPainter;
begin
  Result := Manager.Painter;
end;

procedure TdxSpellCheckerCheckAsYouTypeMode.AddMisspelledWord(const AWord: WideString);

  function GetIsCurrentWord(APosition: Integer): Boolean;
  begin
    Result := (APosition <= CursorPosition) and (CursorPosition <= FMisspellingLen + APosition);
  end;

  function DoAddWord(const AWord: WideString; ACurrentWord: Boolean): TdxSpellCheckerMisspelledWord;
  var
    AItem: TdxSpellCheckerMisspelledWord;
  begin
    Lock;
    try
      if not MisspelledWords.FindWord(AWord, True, Result) then
      begin
        Result := MisspelledWords.AddWord(FMisspellingStart - 1, AWord);
        if ACurrentWord and (TypingPosition = CursorPosition) then
        begin
          if MisspelledWords.ItemAtIndex(FMisspellingStart, AItem) and (AItem <> Result) then
            Result.ShowSquiggle := AItem.ShowSquiggle
          else
            Result.ShowSquiggle := False;
        end;
      end;
    finally
      Unlock;
    end;
  end;

var
  ACurrentWord: Boolean;
  AItem: TdxSpellCheckerMisspelledWord;
begin
  ACurrentWord := GetIsCurrentWord(FMisspellingStart - 1);
  AItem := DoAddWord(AWord, ACurrentWord);
  if ACurrentWord then
  begin
    FCurrentWordInfo.Bounds := Bounds(FMisspellingStart - 1, 0, FMisspellingLen, 0);;
    FCurrentWordInfo.IsMisspelled := True;
  end;
  AItem.ShowSquiggle := AItem.ShowSquiggle or not ACurrentWord or (SelectionLength > 0);
  AItem.Position := FMisspellingStart - 1;
  AItem.FSpellingCode := LastCode;
  AItem.Checked := True;
  CalculateBounds(AItem);
end;

procedure TdxSpellCheckerCheckAsYouTypeMode.CalculateBounds(AWord: TdxSpellCheckerMisspelledWord);
var
  ACharIndex, AWordPartLength: Integer;
  AFinishLineIndex: Integer;
  AFirstLineCharIndex: Integer;
  AStartLineIndex: Integer;
  I: Integer;
  R: TRect;
begin
  AWord.DeleteUnderlineRects;

  AStartLineIndex := Adapter.GetLineIndex(AWord.Position);
  AFinishLineIndex := Adapter.GetLineIndex(AWord.EndPosition - 1);
  for I := AStartLineIndex to AFinishLineIndex do
  begin
    AFirstLineCharIndex := Adapter.GetFirstCharIndexInLine(I);
    if I = AStartLineIndex then
      ACharIndex := AWord.Position
    else
      ACharIndex := AFirstLineCharIndex;

    if I = AFinishLineIndex then
      AWordPartLength := AWord.EndPosition - ACharIndex
    else
      AWordPartLength := Adapter.GetLineLength(I) - ACharIndex + AFirstLineCharIndex;

    R.TopLeft := Adapter.GetCharPosition(ACharIndex);
    R.Bottom := R.Top + Adapter.GetLineHeight(ACharIndex);
    R.Right := R.Left + Adapter.GetTextWidth(ACharIndex, AWordPartLength);
    AWord.AddRect(R);
  end;
end;

function TdxSpellCheckerCheckAsYouTypeMode.CanStartSpellingThread: Boolean;
begin
  Result := Manager.IsSpellCheckerReady and not Adapter.ReadOnly;
end;

procedure TdxSpellCheckerCheckAsYouTypeMode.StartSpellingThread(ADelayed: Boolean);
begin
  if ADelayed then
  begin
    DelayTimer.Tag := GetTickCount;
    DelayTimer.Enabled := True;
  end
  else
    StartSpellingThread;
end;

procedure TdxSpellCheckerCheckAsYouTypeMode.StartSpellingThread;
begin
  DelayTimer.Enabled := False;
  StopSpellingThread;
  if CanStartSpellingThread then
    FCheckThread.Unpause
  else
    if MisspelledWords.Count > 0 then
    begin
      Lock;
      try
        MisspelledWords.DropCheckedFlag;
        MisspelledWords.RemoveUncheckedItems;
      finally
        Unlock;
      end;
      InvalidateEditor;
    end;
end;

procedure TdxSpellCheckerCheckAsYouTypeMode.StopSpellingThread;
begin
  FCheckThread.Pause(True);
end;

procedure TdxSpellCheckerCheckAsYouTypeMode.Changed(AFullRefresh: Boolean);
begin
  Manager.MisspelledItem := nil;
  if AFullRefresh then
  begin
    MisspelledWords.DropCheckedFlag;
    StartSpellingThread(True);
    InvalidateEditor;
  end
  else
    StartSpellingThread;
end;

procedure TdxSpellCheckerCheckAsYouTypeMode.Add;
begin
  if Assigned(Manager.MisspelledItem) then
  begin
    SetMisspelledWordInfo(Manager.MisspelledItem);
    inherited Add;
  end;
end;

procedure TdxSpellCheckerCheckAsYouTypeMode.Change(const AWord: WideString);
begin
  if Assigned(Manager.MisspelledItem) then
  begin
    SetMisspelledWordInfo(Manager.MisspelledItem);
    inherited Change(AWord);
  end;
end;

procedure TdxSpellCheckerCheckAsYouTypeMode.Delete;
begin
  if Assigned(Manager.MisspelledItem) then
  begin
    SetMisspelledWordInfo(Manager.MisspelledItem);
    inherited Delete;
  end;
end;

procedure TdxSpellCheckerCheckAsYouTypeMode.Draw(DC: HDC);
var
  AItem: TdxSpellCheckerMisspelledWord;
  I: Integer;
begin
  Lock;
  try
    for I := MisspelledWords.Count - 1 downto 0 do
    begin
      AItem := MisspelledWords.Items[I];
      if AItem.Checked then
        Painter.DrawWord(DC, Adapter.IsLineDrawStyleNeeded, AItem);
    end;
  finally
    Unlock;
  end;
end;

procedure TdxSpellCheckerCheckAsYouTypeMode.IgnoreAll;
begin
  if Assigned(Manager.MisspelledItem) then
  begin
    SetMisspelledWordInfo(Manager.MisspelledItem);
    inherited IgnoreAll;
  end;
end;

procedure TdxSpellCheckerCheckAsYouTypeMode.InvalidateEditor;
begin
  InvalidateRgn(Adapter.EditorHandle, ViewInfo.UpdateRegion, True);
end;

procedure TdxSpellCheckerCheckAsYouTypeMode.SetMisspelledWordInfo(
  AWord: TdxSpellCheckerMisspelledWord);
begin
  FMisspellingStart := AWord.Position + 1;
  FMisspellingLen := AWord.EndPosition - FMisspellingStart + 1;
  FMisspelledWord := AWord.Word;
end;

procedure TdxSpellCheckerCheckAsYouTypeMode.SelectionChanged;
begin
  if FCurrentWordInfo.IsMisspelled then
  begin
    if not IsInCurrentWordBounds(Adapter.SelStart) or
      (Adapter.SelLength <> SelectionLength)
    then
      StartSpellingThread(True);
  end;
  InvalidateEditor;
end;

procedure TdxSpellCheckerCheckAsYouTypeMode.TextChanged;
begin
  FTypingPosition := Adapter.SelStart;
  Changed(False);
end;

procedure TdxSpellCheckerCheckAsYouTypeMode.SpellingBegin;
begin
  CreateParser;
  Adapter.RefreshParams;
  FCursorPosition := Adapter.SelStart;
  FSelectionLength := Adapter.SelLength;
  FCurrentWordInfo.IsMisspelled := False;
  FMisspellingStart := SpellingStart;
  Manager.ValidateRules(Parser);
  CorrectWords.DropCheckedFlag;
  MisspelledWords.DropCheckedFlag;
  ViewInfo.ClearRegions;
  ViewInfo.AddToEraseRegion(MisspelledWords);
end;

procedure TdxSpellCheckerCheckAsYouTypeMode.SpellingDone(AAborted: Boolean);

  procedure ValidateMisspelledWordsCache(ASpellingPosition: Integer);
  var
    I: Integer;
  begin
    if not AAborted then
      MisspelledWords.RemoveUncheckedItems
    else
      for I := MisspelledWords.Count - 1 downto 0 do
      begin
        if MisspelledWords[I].Position < ASpellingPosition then
          MisspelledWords.RemoveItem(MisspelledWords[I]);
      end;
  end;

  procedure ValidateLists;
  begin
    Lock;
    try
      ViewInfo.AddToDrawRegion(MisspelledWords);
      CorrectWords.RemoveUncheckedItems;
      ValidateMisspelledWordsCache(FMisspellingStart + FMisspellingLen);
    finally
      Unlock;
    end;
  end;

begin
  ValidateLists;
  if Manager.IsManualCheckingActive then
    Manager.ValidateRules(SpellChecker.CheckMode.Parser);
  InvalidateEditor;
end;

procedure TdxSpellCheckerCheckAsYouTypeMode.Lock;
begin
  EnterCriticalSection(FLock);
end;

procedure TdxSpellCheckerCheckAsYouTypeMode.Unlock;
begin
  LeaveCriticalSection(FLock);
end;

function TdxSpellCheckerCheckAsYouTypeMode.GetParserClass: TdxSpellCheckerTextParserClass;
begin
  Result := TdxSpellCheckerCheckAsYouTypeTextParser;
end;

function TdxSpellCheckerCheckAsYouTypeMode.GetSelectedMisspelledWord(
  out AWord: TdxSpellCheckerMisspelledWord): Boolean;
begin
  Result := MisspelledWords.ItemAtIndex(Adapter.SelStart, AWord);
end;

function TdxSpellCheckerCheckAsYouTypeMode.InternalProcessWord(const AWord: WideString): Boolean;
begin
  Result := IsNeedIgnoreWord(AWord);
  if Result then
  begin
    FMisspelledWord := AWord;
    CorrectWords.AddWord(FMisspellingStart - 1, AWord);
    Ignore;
  end;
end;

function TdxSpellCheckerCheckAsYouTypeMode.IsInCurrentWordBounds(APosition: Integer): Boolean;
begin
   Result := (APosition >= FCurrentWordInfo.Bounds.Left) and
    (APosition <= FCurrentWordInfo.Bounds.Right);
end;

function TdxSpellCheckerCheckAsYouTypeMode.IsValidWord(const AWord: WideString): Boolean;
var
  AItem: TdxSpellCheckerSpelledWord;
begin
  Lock;
  try
    Result := not WideSameStr(AWord, PrevWord) and CorrectWords.FindWord(AWord, False, AItem);
    if Result then
      AItem.Checked := True
    else
    begin
      Result := inherited IsValidWord(AWord);
      if Result then
        CorrectWords.AddWord(FMisspellingStart - 1, AWord);
    end;
  finally
    Unlock;
  end;
end;

procedure TdxSpellCheckerCheckAsYouTypeMode.DelayTimerEvent(Sender: TObject);
begin
  if GetTickCount - DWORD(DelayTimer.Tag) >= dxSpellCheckerCheckAsYouTypeTimeDelay then
  begin
    DelayTimer.Enabled := False;
    StartSpellingThread;
  end;
end;

procedure TdxSpellCheckerCheckAsYouTypeMode.UpdateByDictionary(
  ADictionary: TdxCustomSpellCheckerDictionary);
begin
  inherited UpdateByDictionary(ADictionary);
  Changed(False);  
end;

{ TdxSpellCheckerCheckAsYouTypeViewInfoItem }

constructor TdxSpellCheckerCheckAsYouTypeViewInfoItem.Create(const ABounds: TRect);
begin
  FBounds := ABounds;
end;

{ TdxSpellCheckerCheckAsYouTypeViewInfoList }

function TdxSpellCheckerCheckAsYouTypeViewInfoList.GetItem(
  Index: Integer): TdxSpellCheckerCheckAsYouTypeViewInfoItem;
begin
  Result := TdxSpellCheckerCheckAsYouTypeViewInfoItem(inherited Items[Index]);
end;

procedure TdxSpellCheckerCheckAsYouTypeViewInfoList.AddItem(const R: TRect);
begin
  Add(TdxSpellCheckerCheckAsYouTypeViewInfoItem.Create(R));
end;

function TdxSpellCheckerCheckAsYouTypeViewInfoList.CreateUpdateRegion: HRGN;
var
  AItem: TdxSpellCheckerCheckAsYouTypeViewInfoItem;
  ARgn: HRGN;
  I: Integer;
begin
  Result := CreateRectRgn(0, 0, 0, 0);
  for I := 0 to Count - 1 do
  begin
    AItem := Items[I];
    if not AItem.ExcludeFromRegion then
    begin
      ARgn := CreateRectRgnIndirect(AItem.Bounds);
      CombineRgn(Result, Result, ARgn, RGN_OR);
      DeleteObject(ARgn);
    end;
  end;
end;

function TdxSpellCheckerCheckAsYouTypeViewInfoList.FindItem(const R: TRect;
  out AItem: TdxSpellCheckerCheckAsYouTypeViewInfoItem): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to Count - 1 do
  begin
    AItem := Items[I];
    Result := cxRectCompare(AItem.Bounds, R);
    if Result then
      Break;
  end;
end;

{ TdxSpellCheckerCheckAsYouTypeViewInfo }

constructor TdxSpellCheckerCheckAsYouTypeViewInfo.Create;
begin
  FRectsToDraw := TdxSpellCheckerCheckAsYouTypeViewInfoList.Create;
  FRectsToErase := TdxSpellCheckerCheckAsYouTypeViewInfoList.Create;
end;

destructor TdxSpellCheckerCheckAsYouTypeViewInfo.Destroy;
begin
  FreeAndNil(FRectsToDraw);
  FreeAndNil(FRectsToErase);
  inherited Destroy;
end;

procedure TdxSpellCheckerCheckAsYouTypeViewInfo.AddToDrawRegion(
  const AList: TdxSpellCheckerMisspelledWordList);
var
  AWordItem: TdxSpellCheckerMisspelledWord;
  I: Integer;
begin
  for I := 0 to AList.Count - 1 do
  begin
    AWordItem := AList.Items[I];
    if AWordItem.Checked then
      AddWordToList(RectsToDraw, AWordItem);
  end;
end;

procedure TdxSpellCheckerCheckAsYouTypeViewInfo.AddToEraseRegion(
  const AList: TdxSpellCheckerMisspelledWordList);
var
  I: Integer;
begin
  for I := 0 to AList.Count - 1 do
    AddWordToList(RectsToErase, AList.Items[I]);
  DoChanged;
end;

procedure TdxSpellCheckerCheckAsYouTypeViewInfo.AddWordToList(
  AList: TdxSpellCheckerCheckAsYouTypeViewInfoList;
  AWord: TdxSpellCheckerMisspelledWord);
var
  I: Integer;
begin
  for I := 0 to AWord.UnderlineRectCount - 1 do
    AList.AddItem(cxRectInflate(AWord.UnderlineRect[I], 1, 1));
  DoChanged;
end;

procedure TdxSpellCheckerCheckAsYouTypeViewInfo.ClearRegions;
begin
  FRectsToDraw.Clear;
  FRectsToErase.Clear;
  DoChanged;
end;

procedure TdxSpellCheckerCheckAsYouTypeViewInfo.DoChanged;
begin
  if FUpdateRgn <> 0 then
  begin
    DeleteObject(FUpdateRgn);
    FUpdateRgn := 0;
  end;
end;

function TdxSpellCheckerCheckAsYouTypeViewInfo.GetUpdateRegion: HRGN;
var
  ATemp: HRGN;
begin
  if FUpdateRgn = 0 then
  begin
    FUpdateRgn := RectsToDraw.CreateUpdateRegion;
    ATemp := RectsToErase.CreateUpdateRegion;
    CombineRgn(FUpdateRgn, FUpdateRgn, ATemp, RGN_OR);
    DeleteObject(ATemp);
  end;
  Result := FUpdateRgn;
end;

{ TdxSpellCheckerCheckAsYouTypeEditAdapter }

function TdxSpellCheckerCheckAsYouTypeEditAdapter.GetCharIndex(
  const APoint: TPoint): Integer;
begin
  Result := LoWord(SendMessage(EditorHandle,
    EM_CHARFROMPOS, 0, MakeLParam(APoint.X, APoint.Y)));
end;

function TdxSpellCheckerCheckAsYouTypeEditAdapter.GetCharPosition(ACharIndex: Integer): TPoint;
var
  APosition: Integer;
begin
  APosition := SendMessage(EditorHandle, EM_POSFROMCHAR, ACharIndex, 0);
  Result.X := SmallInt(LoWord(APosition));
  Result.Y := SmallInt(HiWord(APosition));
end;

function TdxSpellCheckerCheckAsYouTypeEditAdapter.GetIsMultiLine: Boolean;
begin
  Result := SendMessage(EditorHandle, EM_GETLINECOUNT, 0, 0) > 1; 
end;

function TdxSpellCheckerCheckAsYouTypeEditAdapter.GetFirstCharIndexInLine(
  ALineIndex: Integer): Integer;
begin
  Result := SendMessage(EditorHandle, EM_LINEINDEX, ALineIndex, 0);
end;

function TdxSpellCheckerCheckAsYouTypeEditAdapter.GetFirstVisibleLineIndex: Integer;
begin
  Result := SendMessage(EditorHandle, EM_GETFIRSTVISIBLELINE, 0, 0);
end;

function TdxSpellCheckerCheckAsYouTypeEditAdapter.GetLineHeight(ACharIndex: Integer): Integer;
begin
  Result := FLineHeight;
end;

function TdxSpellCheckerCheckAsYouTypeEditAdapter.InternalGetLineHeightByFont(
  ALineIndex: Integer): Integer;
var
  AFont: HFONT;
  DC: HDC;
begin
  DC := GetDC(EditorHandle);
  AFont := SelectObject(DC, SendMessage(EditorHandle, WM_GETFONT, 0, 0));
  Result := cxTextSize(DC, 'Wg').cy;
  SelectObject(DC, AFont);
  ReleaseDC(EditorHandle, DC);
end;

function TdxSpellCheckerCheckAsYouTypeEditAdapter.GetLineIndex(
  ACharIndex: Integer): Integer;
begin
  Result := SendMessage(EditorHandle, EM_LINEFROMCHAR, ACharIndex, 0);
end;

function TdxSpellCheckerCheckAsYouTypeEditAdapter.GetLineLength(
  ALineIndex: Integer): Integer;
begin
  Result := SendMessage(EditorHandle, EM_LINELENGTH, GetFirstCharIndexInLine(ALineIndex), 0);
end;

function TdxSpellCheckerCheckAsYouTypeEditAdapter.GetSpellingStartPosition: Integer;
var
  ALineIndex: Integer;
begin
  Result := 1;
  if IsMultiLine then
  begin
    ALineIndex := GetFirstVisibleLineIndex;
    if ALineIndex > 0 then
      Result := GetFirstCharIndexInLine(ALineIndex - 1);
  end;
end;

function TdxSpellCheckerCheckAsYouTypeEditAdapter.GetTextAreaRect: TRect;
begin
  SendMessage(EditorHandle, EM_GETRECT, 0, Integer(@Result));
end;

function TdxSpellCheckerCheckAsYouTypeEditAdapter.GetTextWidth(APosition, ALength: Integer): Integer;
var
  AOldFont: HFONT;
  AText: WideString;
  ATextSize: TSize;
  DC: HDC;
begin
  DC := GetDC(EditorHandle);
  AOldFont := SelectObject(DC, SendMessage(EditorHandle, WM_GETFONT, 0, 0));
  AText := Copy(Text, APosition + 1, ALength);
  GetTextExtentPointW(DC, PWideChar(AText), Length(AText), ATextSize);
  Result := ATextSize.cx;
  SelectObject(DC, AOldFont);
  ReleaseDC(EditorHandle, DC);
end;

procedure TdxSpellCheckerCheckAsYouTypeEditAdapter.GetVisibleTextBounds(
  out AStartIndex, AEndIndex: Integer);
var
  R: TRect;
begin
  R := TextAreaRect;
  InflateRect(R, -1, -1);
  AStartIndex := GetCharIndex(R.TopLeft);
  AEndIndex := GetCharIndex(R.BottomRight);
end;

procedure TdxSpellCheckerCheckAsYouTypeEditAdapter.RefreshParams;
begin
  FLineHeight := InternalGetLineHeightByFont(0);
  FIsLineDrawStyleNeeded := FLineHeight >= cxRectHeight(TextAreaRect);
end;

{ TdxSpellCheckerCheckAsYouTypeManager }

constructor TdxSpellCheckerCheckAsYouTypeManager.Create(
  ASpellChecker: TdxCustomSpellChecker);
begin
  inherited Create(ASpellChecker);
  FPainter := TdxSpellCheckerPainter.Create(clRed);
end;

destructor TdxSpellCheckerCheckAsYouTypeManager.Destroy;
begin
  FinalizeController;
  FreeAndNil(FPainter);
  FreeAndNil(FInternalPopupMenu);
  inherited Destroy;
end;

function TdxSpellCheckerCheckAsYouTypeManager.CanPopup(const P: TPoint): Boolean;

  function IsQueryPopupAtMesspelledWord: Boolean;
  begin
    if cxPointIsEqual(cxInvalidPoint, P) then
      Result := CheckMode.MisspelledWords.ItemAtIndex(Adapter.SelStart, FMisspelledItem)
    else
      Result := CheckMode.MisspelledWords.ItemAtPos(P, FMisspelledItem);
  end;

begin
  Result := Active and (CheckMode <> nil) and (Options.PopupMenuItems <> []) and
    (Adapter.Edit.HandleAllocated and (GetFocus = Adapter.EditorHandle)) and
    IsQueryPopupAtMesspelledWord;
end;

procedure TdxSpellCheckerCheckAsYouTypeManager.CreateInternalPopupMenu;
begin
  FreeAndNil(FInternalPopupMenu);
  FInternalPopupMenu := TPopupMenu.Create(nil);
end;

procedure TdxSpellCheckerCheckAsYouTypeManager.CreateItems(
  APopup: TPopupMenu; AList: TcxObjectList);

  procedure AddItem(var APosition: Integer; ATag: Integer; const ACaption: WideString;
    ASubMenuItem: TMenuItem = nil);
  var
    AItem: TMenuItem;
  begin
    if ASubMenuItem = nil then
      AItem := TMenuItem.Create(InternalPopupMenu)
    else
      AItem := TMenuItem.Create(ASubMenuItem);
    AItem.Caption := dxWideStringToString(ACaption);
    if not AItem.IsLine then
    begin
      AItem.Tag := ATag;
      AItem.OnClick := MenuItemClickHandler;
      AItem.AutoHotkeys := maManual;
    end;
    if ASubMenuItem = nil then
      APopup.Items.Insert(APosition, AItem)
    else
      ASubMenuItem.Insert(ASubMenuItem.Count, AItem);
    AList.Add(AItem);
    Inc(APosition);
  end;

  procedure GenerateAutoCorrectItems(var APosition: Integer; ASuggestionList: TdxSpellCheckerSuggestionList);
  var
    I: Integer;
    ASubMenuItem: TMenuItem;
  begin
    if APosition > 0 then
      AddItem(APosition, 0, cLineCaption);
    AddItem(APosition, -1, cxGetResourceString(@sdxSpellCheckerAutoCorrect));
    ASubMenuItem := TMenuItem(AList[AList.Count - 1]);
    I := 0;
    if ASuggestionList.Count > 0 then
    begin
      while (I < ASuggestionList.Count) and (I < Options.SuggestionCount) do
        AddItem(I, -I - 2, ASuggestionList[I].Word, ASubMenuItem);
      AddItem(I, 0, cLineCaption, ASubMenuItem);
    end;
    AddItem(I, Ord(scmiAutoCorrect), cxGetResourceString(@sdxSpellCheckerAutoCorrectOptionsFormCaption), ASubMenuItem);
  end;

  procedure GenerateItemsForMisspelledWord(var APosition: Integer);
  var
    ASuggestionList: TdxSpellCheckerSuggestionList;
  begin
    ASuggestionList := SpellChecker.GetSuggestions(TdxSpellCheckerMisspelledWord(FMisspelledItem).Word);
    try
      APosition := 0;
      if scmiSuggestions in Options.PopupMenuItems then
        while (APosition < ASuggestionList.Count) and (APosition < Options.SuggestionCount) do
          AddItem(APosition, Ord(scmiSuggestions) + APosition, ASuggestionList[APosition].Word);
      if APosition > 0 then
        AddItem(APosition, 0, cLineCaption);
      if scmiIgnoreAll in Options.PopupMenuItems then
        AddItem(APosition, Ord(scmiIgnoreAll), cxGetResourceString(@sdxSpellCheckerIgnoreAllButton));
      if (scmiAddToDictionary in Options.PopupMenuItems) and SpellChecker.HasEnabledUserDictionary then
        AddItem(APosition, Ord(scmiAddToDictionary), cxGetResourceString(@sdxSpellCheckerAddButton));
      if SpellChecker.AutoCorrectOptions.Active and (scmiAutoCorrect in Options.PopupMenuItems) then
        GenerateAutoCorrectItems(APosition, ASuggestionList);
    finally
      FreeAndNil(ASuggestionList);
    end;
  end;

  procedure GenerateItemsForRepeatedWord(var APosition: Integer);
  begin
    APosition := 0;
    if scmiDelete in Options.PopupMenuItems then
      AddItem(APosition, Ord(scmiDelete), cxGetResourceString(@sdxSpellCheckerDeleteButton));
  end;

var
  I: Integer;
begin
  if Assigned(MisspelledItem) then
  begin
    AList.Clear;
    I := 0;
    case MisspelledItem.SpellingCode of
      scMisspelled:
        GenerateItemsForMisspelledWord(I);
      scRepeatedWords:
        GenerateItemsForRepeatedWord(I);
    end;
    if I > 0 then
      AddItem(I, 0, cLineCaption);
    if scmiSpelling in Options.PopupMenuItems then
    begin
      AddItem(I, Ord(scmiSpelling), cxGetResourceString(@sdxSpellCheckerSpellingFormCaption));
      AddItem(I, 0, cLineCaption);
    end;
  end;
end;

procedure TdxSpellCheckerCheckAsYouTypeManager.DoActiveChanged;
begin
  if Active then
    CheckStart(FindControl(GetFocus))
  else
    CheckFinish;
end;

procedure TdxSpellCheckerCheckAsYouTypeManager.DoFinalizeController;
begin
  RedrawEditor;
end;

procedure TdxSpellCheckerCheckAsYouTypeManager.DoOptionsChanged;
begin
  Painter.LineColor := Options.UnderlineColor;
  Painter.LineStyle := Options.UnderlineStyle;
  if Assigned(CheckMode) then
    CheckMode.InvalidateEditor;
end;

function TdxSpellCheckerCheckAsYouTypeManager.GetAdapterClass(
  AControl: TWinControl): TdxSpellCheckerCustomEditAdapterClass;
begin
  if AControl is TcxRichInnerEdit then
    Result := TdxSpellCheckerCheckAsYouTypeRichEditAdapter
  else
    if AControl is TCustomEdit then
      Result := TdxSpellCheckerCheckAsYouTypeEditAdapter
    else
      Result := inherited GetAdapterClass(AControl);
end;

function TdxSpellCheckerCheckAsYouTypeManager.GetCheckModeClass: TdxSpellCheckerCustomCheckModeClass;
begin
  Result := TdxSpellCheckerCheckAsYouTypeMode;
end;

function TdxSpellCheckerCheckAsYouTypeManager.GetAdapter: TdxSpellCheckerCheckAsYouTypeEditAdapter;
begin
  Result := TdxSpellCheckerCheckAsYouTypeEditAdapter(inherited Adapter);
end;

function TdxSpellCheckerCheckAsYouTypeManager.GetCheckMode: TdxSpellCheckerCheckAsYouTypeMode;
begin
  Result := TdxSpellCheckerCheckAsYouTypeMode(inherited CheckMode);
end;

procedure TdxSpellCheckerCheckAsYouTypeManager.MenuItemClickHandler(ASender: TObject);

  procedure SuggestionClick(AIndex: Integer; AIsAutoCorrect: Boolean);
  var
    ASuggestionList: TdxSpellCheckerSuggestionList;
    AItem: TdxSpellCheckerReplacement;
    AWord: WideString;
  begin
    ASuggestionList := SpellChecker.GetSuggestions(MisspelledItem.Word);
    try
      if ASuggestionList.Count >= AIndex then
      begin
        if AIsAutoCorrect then
        begin
          AWord := MisspelledItem.Word;
          AItem := SpellChecker.AutoCorrectOptions.Replacements.FindReplacement(AWord);
          if (AItem = nil) then
            SpellChecker.AutoCorrectOptions.Replacements.Add(AWord, ASuggestionList[AIndex].Word)
          else
          begin
            BeginManualCheck;
            try
              if (MessageDlg(Format(cxGetResourceString(@sdxSpellCheckerAutoCorrectReplacementExistMessageFormat),
                  [AWord]), mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
                SpellChecker.AutoCorrectOptions.Replacements.Add(AWord, ASuggestionList[AIndex].Word);
            finally
              EndManualCheck;
            end;
          end;
        end;
        CheckMode.Change(ASuggestionList[AIndex].Word);
      end;
    finally
      FreeAndNil(ASuggestionList);
    end;
  end;

var
  ACommand: Integer;
  AIndex: Integer;
begin
  if Assigned(MisspelledItem) then
  begin
    ACommand := TMenuItem(ASender).Tag;
    case ACommand of
      Ord(scmiAutoCorrect):
        dxShowAutoCorrectOptionsDialog(SpellChecker, SpellChecker.DialogLookAndFeel);
      Ord(scmiIgnoreAll):
        CheckMode.IgnoreAll;
      Ord(scmiAddToDictionary):
        CheckMode.Add;
      Ord(scmiDelete):
        CheckMode.Delete;
      Ord(scmiSpelling):
        StartManualSpelling(Adapter);
    else
      if (ACommand >= Ord(scmiSuggestions)) or (ACommand < -1) then
      begin
        if ACommand < -1 then
          AIndex := -ACommand - 2
        else
          AIndex := ACommand - Ord(scmiSuggestions);
        SuggestionClick(AIndex, ACommand < -1);
      end;
    end;
  end;
end;

procedure TdxSpellCheckerCheckAsYouTypeManager.DrawMisspellings(AControl: TWinControl);
var
  DC: HDC;
begin
  ValidateAdapter;
  if (Edit = AControl) and Edit.HandleAllocated then
  begin
    DC := GetDC(Edit.Handle);
    CheckMode.Draw(DC);
    ReleaseDC(Edit.Handle, DC);
  end;
end;

procedure TdxSpellCheckerCheckAsYouTypeManager.LayoutChanged(AControl: TWinControl);
begin
  ValidateAdapter;
  if Edit = AControl then
    Refresh(True);
end;

function TdxSpellCheckerCheckAsYouTypeManager.QueryPopup(
  APopup: TComponent; const P: TPoint): Boolean;

  function GetPopupPos: TPoint;
  var
    R: TRect;
  begin
    with MisspelledItem do
      R := UnderlineRect[UnderlineRectCount - 1];
    Result := cxPoint(R.Left, R.Bottom);
    if not PtInRect(Adapter.Edit.ClientRect, cxPoint(R.Left, R.Top)) then
    begin
      GetCaretPos(Result);
      Result.Y := R.Bottom;
    end;
    Result := Adapter.Edit.ClientToScreen(Result);
  end;

var
  AAddItems: TcxObjectList;
  I: Integer;
begin
  Result := CanPopup(P);
  if Result then
  begin
    if Options.PopupMenu <> nil then
    begin
      InnerShowPopupMenu(Options.PopupMenu, GetPopupPos);
      Exit;
    end;
    AAddItems := TcxObjectList.Create;
    try
      if not Options.ModifyControlPopupMenu or not (APopup is TPopupMenu) then
      begin
        CreateInternalPopupMenu;
        APopup := InternalPopupMenu;
      end;
      CreateItems(TPopupMenu(APopup), AAddItems);
      InnerShowPopupMenu(APopup, GetPopupPos);
      Application.ProcessMessages;
    finally
      for I := AAddItems.Count - 1 downto 0 do
        AAddItems.FreeAndDelete(I);
      FreeAndNil(AAddItems);
    end;
  end;
end;

procedure TdxSpellCheckerCheckAsYouTypeManager.RedrawEditor;
begin
  if Assigned(Adapter) and Adapter.Edit.HandleAllocated then
    InvalidateRect(Adapter.EditorHandle, nil, True);
end;

procedure TdxSpellCheckerCheckAsYouTypeManager.SpellingOptionsChanged;
begin
  inherited SpellingOptionsChanged;
  Reset;
end;

procedure TdxSpellCheckerCheckAsYouTypeManager.ValidateAdapter;
var
  AContainer: IcxCompoundControl;
  AControl: TWinControl;
begin
  inherited ValidateAdapter;
  if Adapter = nil then
  begin
    AControl := FindControl(GetFocus);
    if (AControl <> nil) and Supports(AControl, IcxCompoundControl, AContainer) then
      CheckStart(AContainer.ActiveControl);
  end;
end;

procedure TdxSpellCheckerCheckAsYouTypeManager.Refresh(AFullRefresh: Boolean);
begin
  if Assigned(CheckMode) then
    CheckMode.Changed(AFullRefresh);
end;

procedure TdxSpellCheckerCheckAsYouTypeManager.Reset;
begin
  if Assigned(CheckMode) then
    CheckMode.CorrectWords.Clear;
  Refresh(True);
end;

procedure TdxSpellCheckerCheckAsYouTypeManager.SelectionChanged(AControl: TWinControl);
begin
  ValidateAdapter;
  if Edit = AControl then
    CheckMode.SelectionChanged;
end;

procedure TdxSpellCheckerCheckAsYouTypeManager.TextChanged(AControl: TWinControl);
begin
  ValidateAdapter;
  if Edit = AControl then
    CheckMode.TextChanged;
end;

{ TdxSpellCheckerPainter }

constructor TdxSpellCheckerPainter.Create(ALineColor: TColor);
begin
  inherited Create;
  LineColor := ALineColor;
end;

procedure TdxSpellCheckerPainter.Draw(
  DC: HDC; const R: TRect; ALineStyleNeeded: Boolean);
begin
  if (LineStyle = usLine) or ((LineStyle = usAuto) and ALineStyleNeeded) then
    DrawLine(DC, R)
  else
    DrawWavyLine(DC, R);
end;

procedure TdxSpellCheckerPainter.DrawLine(DC: HDC; const R: TRect);
begin
  FillRectByColor(DC, cxRectCenter(R, cxRectWidth(R), 1), LineColor);
end;

procedure TdxSpellCheckerPainter.DrawWavyLine(DC: HDC; const R: TRect);

  procedure CalculateWavyLine(out P: TPointArray);
  var
    ADelta: Integer;
    ATop: Boolean;
    I, X: Integer;
  begin
    X := R.Left;
    ATop := True;
    ADelta := dxSpellCheckerUnderlineSize - 1;
    SetLength(P, (R.Right - R.Left) div ADelta + 2);
    for I := 0 to Length(P) - 1 do
    begin
      P[I] := Point(X, IfThen(ATop, R.Top, R.Bottom - 1));
      ATop := not ATop;
      Inc(X, ADelta);
    end;
  end;

var
  P: TPointArray;
begin
  CalculateWavyLine(P);
  try
    cxPaintCanvas.BeginPaint(DC);
    try
      cxPaintCanvas.SetClipRegion(TcxRegion.Create(R), roSet);
      cxPaintCanvas.Pen.Color := LineColor;
      cxPaintCanvas.Polyline(P);
    finally
      cxPaintCanvas.EndPaint;
    end;
  finally
    P := nil;
  end;
end;

procedure TdxSpellCheckerPainter.DrawWord(DC: HDC; ALineStyleNeeded: Boolean;
  AWord: TdxSpellCheckerMisspelledWord);
var
  I: Integer;
begin
  if AWord.ShowSquiggle then
  begin
    for I := 0 to AWord.UnderlineRectCount - 1 do
      Draw(DC, AWord.UnderlineRect[I], ALineStyleNeeded);
  end;
end;

procedure TdxSpellCheckerPainter.SetLineColor(const Value: TColor);
begin
  FLineColor := ColorToRGB(Value);
end;

{ TdxSpellCheckerCheckAsYouTypeTextParser }

function TdxSpellCheckerCheckAsYouTypeTextParser.GetNextWord(
  var AStart, ALength: Integer; out ADelimiters: WideString): WideString;
begin
  while True do
  begin
    Result := inherited GetNextWord(AStart, ALength, ADelimiters);
    if AStart >= VisibleEndIndex then
      ALength := 0;
    if (ALength = 0) or IsWordVisible(AStart, ALength) then
      Break
    else
      Inc(AStart, ALength);      
  end;
end;

function TdxSpellCheckerCheckAsYouTypeTextParser.IsCharVisible(
  APosition: Integer): Boolean;
begin
  Result := (APosition >= VisibleStartIndex) and (APosition <= VisibleEndIndex);
end;

function TdxSpellCheckerCheckAsYouTypeTextParser.IsWordVisible(
  APosition, AWordLength: Integer): Boolean;
begin
  Result := IsCharVisible(APosition) or IsCharVisible(APosition + AWordLength);
end;

procedure TdxSpellCheckerCheckAsYouTypeTextParser.UpdateTextInfo(
  AAdapter: TdxSpellCheckerCustomEditAdapter);
var
  AAsYouTypeAdapter: TdxSpellCheckerCheckAsYouTypeEditAdapter;
begin
  inherited UpdateTextInfo(AAdapter);
  if AAdapter is TdxSpellCheckerCheckAsYouTypeEditAdapter then
  begin
    AAsYouTypeAdapter := TdxSpellCheckerCheckAsYouTypeEditAdapter(AAdapter);
    AAsYouTypeAdapter.GetVisibleTextBounds(FVisibleStartIndex, FVisibleEndIndex);
    FSpellingStart := AAsYouTypeAdapter.GetSpellingStartPosition;
    FSpellingEnd := Length(FText) + 1;
  end;
end;

{ TdxSpellCheckerSpelledWordList }

function TdxSpellCheckerSpelledWordList.AddWord(
  APos: Integer; const AWord: WideString): TdxSpellCheckerSpelledWord;
begin
  Result := GetSpellCheckerWordClass.Create(APos, AWord);
  Add(Result);
end;

procedure TdxSpellCheckerSpelledWordList.DropCheckedFlag;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    Items[I].Checked := False;
end;

function TdxSpellCheckerSpelledWordList.GetItem(AIndex: Integer): TdxSpellCheckerSpelledWord;
begin
  Result := TdxSpellCheckerSpelledWord(inherited Items[AIndex]);
end;

function TdxSpellCheckerSpelledWordList.GetSpellCheckerWordClass: TdxSpellCheckerSpelledWordClass;
begin
  Result := TdxSpellCheckerSpelledWord; 
end;

function TdxSpellCheckerSpelledWordList.FindWord(const AWord: WideString;
  AUncheckedOnly: Boolean; out AItem: TdxSpellCheckerSpelledWord): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to Count - 1 do
  begin
    AItem := Items[I];
    Result := (AWord = AItem.Word) and not (AUncheckedOnly and AItem.Checked);
    if Result then
      Break;
  end;
end;

procedure TdxSpellCheckerSpelledWordList.RemoveItem(AItem: TdxSpellCheckerSpelledWord);
begin
  if Remove(AItem) >= 0 then
    AItem.Free;
end;

procedure TdxSpellCheckerSpelledWordList.RemoveUncheckedItems;
var
  I: Integer;
begin
  for I := Count - 1 downto 0 do
  begin
    if not Items[I].Checked then
      RemoveItem(Items[I]);
  end;
end;

{ TdxSpellCheckerSpelledWord }

constructor TdxSpellCheckerSpelledWord.Create(APosition: Integer; const AWord: WideString);
begin
  FWord := AWord;
  FPosition := APosition;
  FChecked := True;
end;

function TdxSpellCheckerSpelledWord.GetEndPosition: Integer;
begin
  Result := Position + Length(FWord);
end;

{ TdxSpellCheckerMisspelledWord }

constructor TdxSpellCheckerMisspelledWord.Create(APosition: Integer; const AWord: WideString);
begin
  inherited Create(APosition, AWord);
  FShowSquiggle := True;
end;

destructor TdxSpellCheckerMisspelledWord.Destroy;
begin
  DeleteUnderlineRects;
  inherited Destroy;
end;

procedure TdxSpellCheckerMisspelledWord.AddRect(const R: TRect);
var
  AIndex: Integer;
begin
  AIndex := Length(FBounds);
  SetLength(FBounds, AIndex + 1);
  FBounds[AIndex] := R;
end;

function TdxSpellCheckerMisspelledWord.Contains(const APoint: TPoint): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to Length(FBounds) - 1 do
  begin
    Result := PtInRect(FBounds[I], APoint);
    if Result then
      Break;
  end;
end;

procedure TdxSpellCheckerMisspelledWord.DeleteUnderlineRects;
begin
  SetLength(FBounds, 0);
end;

function TdxSpellCheckerMisspelledWord.GetUnderlineRect(Index: Integer): TRect;
begin
  Result := FBounds[Index];
  Inc(Result.Bottom);
  Result.Top := Result.Bottom - dxSpellCheckerUnderlineSize;
end;

function TdxSpellCheckerMisspelledWord.GetUnderlineRectCount: Integer;
begin
  Result := Length(FBounds);
end;

{ TdxSpellCheckerMisspelledWordList }

function TdxSpellCheckerMisspelledWordList.GetItem(
  AIndex: Integer): TdxSpellCheckerMisspelledWord;
begin
  Result := TdxSpellCheckerMisspelledWord(inherited Items[AIndex]);
end;

function TdxSpellCheckerMisspelledWordList.GetSpellCheckerWordClass: TdxSpellCheckerSpelledWordClass;
begin
  Result := TdxSpellCheckerMisspelledWord;
end;

function TdxSpellCheckerMisspelledWordList.AddWord(
  APos: Integer; const AWord: WideString): TdxSpellCheckerMisspelledWord;
begin
  Result := TdxSpellCheckerMisspelledWord(inherited AddWord(APos, AWord));
end;

function TdxSpellCheckerMisspelledWordList.FindWord(const AWord: WideString;
  AUncheckedOnly: Boolean; out AItem: TdxSpellCheckerMisspelledWord): Boolean;
begin
  Result := inherited FindWord(AWord, AUncheckedOnly, TdxSpellCheckerSpelledWord(AItem));
end;

function TdxSpellCheckerMisspelledWordList.ItemAtIndex(
  AIndex: Integer; out AWord: TdxSpellCheckerMisspelledWord): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to Count - 1 do
  begin
    AWord := Items[I];
    Result := (AIndex >= AWord.Position + 1) and (AIndex < AWord.EndPosition + 1);   
    if Result then
      Break;
  end;
end;

function TdxSpellCheckerMisspelledWordList.ItemAtPos(
  const APoint: TPoint; out AWord: TdxSpellCheckerMisspelledWord): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to Count - 1 do
  begin
    Result := Items[I].Contains(APoint);
    if Result then
    begin
      AWord := Items[I];
      Break;
    end;
  end;
end;

end.
