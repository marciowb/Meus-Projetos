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

unit dxSpellChecker;

{$I cxVer.inc}

interface

uses
  Types, Windows, SysUtils, Messages, Classes, Graphics, cxClasses, Controls,
  Forms, StdCtrls, RichEdit, Menus,
  dxCore, cxControls, dxSpellCheckerRules, dxSpellCheckerAlgorithms,
  cxLookAndFeels, cxEdit, cxTextEdit, cxRichEdit;

type
  TdxCustomSpellChecker = class;
  TdxSpellCheckerWordList = class;
  TdxSpellCheckerTextParser = class;
  TdxCustomSpellCheckerDictionary = class;
  TdxSpellCheckerSuggestionList = class;
  TdxSpellCheckerAutoCorrectExceptions = class;
  TdxSpellCheckerAutoCorrectOptions = class;
  TdxSpellCheckerCustomAutoCorrectManager = class;
  TdxSpellCheckerSpellingOptions = class;
  TdxSpellCheckerCheckAsYouTypeOptions = class;
  TdxSpellCheckerSuggestionBuilder = class;

  EdxSpellCheckerException = class(EdxException);

  { TdxSpellCheckerPersistent }

  TdxSpellCheckerPersistent = class(TPersistent)
  private
    FSpellChecker: TdxCustomSpellChecker;
  public
    constructor Create(ASpellChecker: TdxCustomSpellChecker); virtual;
    property SpellChecker: TdxCustomSpellChecker read FSpellChecker;
  end;

  { TdxSpellCheckerLanguages }

  TdxSpellCheckerLanguages = class
  private
    FSysLangs: array of TLangRec;
    function LocalesCallback(LocaleID: PChar): Integer; stdcall;
    function GetCount: integer;
    function GetExt(Index: Integer): string;
    function GetID(Index: Integer): string;
    function GetLocaleID(Index: Integer): LCID; overload;
    function GetName(Index: Integer): string;
    function GetNameFromLocaleID(ID: LCID): string;
    function GetNameFromLCID(const ID: string): string;
  public
    constructor Create;
    function GetDefaultLanguageLCID: LCID;
    function GetLCID(const AName: string): LCID;
    function IndexOf(ID: LCID): Integer;
    property Count: Integer read GetCount;
    property Name[Index: Integer]: string read GetName;
    property NameFromLocaleID[ID: LCID]: string read GetNameFromLocaleID;
    property NameFromLCID[const ID: string]: string read GetNameFromLCID;
    property ID[Index: Integer]: string read GetID;
    property LocaleID[Index: Integer]: LCID read GetLocaleID;
    property Ext[Index: Integer]: string read GetExt;
  end;

  { TdxSpellCheckerSuggestion }

  TdxSpellCheckerSuggestion = class
  private
    FDictionary: TdxCustomSpellCheckerDictionary;
    FDistance: Integer;
    FWord: WideString;
    FOrder: Integer;
  public
    constructor Create(const AWord: WideString;
      ADictionary: TdxCustomSpellCheckerDictionary; ADistance: Integer);

    property Dictionary: TdxCustomSpellCheckerDictionary read FDictionary;
    property Distance: Integer read FDistance;
    property Word: WideString read FWord write FWord;
  end;

  { TdxSpellCheckerSuggestionList }

  TdxSpellCheckerSuggestionList = class(TcxObjectList)
  private
    function GetItem(Index: Integer): TdxSpellCheckerSuggestion;
  public
    procedure Add(const AWord: WideString;
      ADictionary: TdxCustomSpellCheckerDictionary; ADistance: Integer);
    procedure Assign(ASuggestions: TdxSpellCheckerSuggestionList);
    procedure Delete(AIndex: Integer);
    procedure FixCapitalization(const AMask: WideString);
    procedure Insert(AIndex: Integer; const AWord: WideString;
      ADictionary: TdxCustomSpellCheckerDictionary; ADistance: Integer);
    procedure RemoveDuplicates;
    procedure SortByDistance;
    procedure SortByWord;
    procedure SaveToStrings(AStrings: TStrings);

    property Items[Index: Integer]: TdxSpellCheckerSuggestion read GetItem; default;
  end;

  { TdxSpellCheckerSuggestionCacheItem }

  TdxSpellCheckerSuggestionCacheItem = class
  private
    FRefCount: Integer;
    FWord: WideString;
    FSuggestions: TdxSpellCheckerSuggestionList;
  protected
    property RefCount: Integer read FRefCount;
    property Word: WideString read FWord;
  public
    constructor Create(const AWord: WideString; ASuggestions: TdxSpellCheckerSuggestionList);
    destructor Destroy; override;
    procedure GetSuggestions(ASuggestions: TdxSpellCheckerSuggestionList);
  end;

  { TdxSpellCheckerSuggestionCache }

  TdxSpellCheckerSuggestionCache = class(TcxObjectList)
  private
    FMaxCapacity: Integer;
    function GetItem(Index: Integer): TdxSpellCheckerSuggestionCacheItem;
    function GetRareItemIndex: Integer;
  protected
    function Find(const AWord: WideString): TdxSpellCheckerSuggestionCacheItem;
  public
    constructor Create(AMaxCapacity: Integer);
    procedure Add(const AWord: WideString; ASuggestions: TdxSpellCheckerSuggestionList);
    function GetSuggestions(const AWord: WideString; ASuggestions: TdxSpellCheckerSuggestionList): Boolean;
    procedure Reset;

    property Items[Index: Integer]: TdxSpellCheckerSuggestionCacheItem read GetItem; default;
  end;

  { TdxSpellCheckerReplacement }

  TdxSpellCheckerReplacement = class
  private
    FReplacement: WideString;
    FText: WideString;
  public
    constructor Create(const AText, AReplacement: WideString);

    procedure ChangeReplacement(const S: WideString);

    property Replacement: WideString read FReplacement;
    property Text: WideString read FText;
  end;

  { TdxSpellCheckerReplacementList }

  TdxSpellCheckerReplacementList = class(TcxObjectList)
  private
    FAllowDuplicates: Boolean;
    function GetItem(Index: Integer): TdxSpellCheckerReplacement;
  public
    constructor Create(AllowDuplicates: Boolean = False);
    procedure Add(const AText, AReplacement: WideString);
    function FindReplacement(const AText: WideString): TdxSpellCheckerReplacement;
    procedure SortByText;

    property Items[Index: Integer]: TdxSpellCheckerReplacement read GetItem; default;
  end;

  { TdxSpellCheckerCustomEditAdapter }

  TdxSpellCheckerCustomEditAdapter = class
  protected
    FEdit: TWinControl;
    FNeedImmediatePost: Boolean;
    FSelStart: Integer;
    FSelLength: Integer;
    FText: WideString;
    function EditorHandleAllocated: Boolean;
    function GetEditorHandle: THandle; virtual;
    function GetHideSelection: Boolean; virtual; abstract;
    function GetReadOnly: Boolean; virtual; abstract;
    function GetSelLength: Integer; virtual; abstract;
    function GetSelStart: Integer; virtual; abstract;
    function GetSelText: string; virtual; abstract;
    function GetText: WideString; virtual;
    procedure Post(AUpdateValue: Boolean = True); virtual;
    procedure SetHideSelection(AValue: Boolean); virtual; abstract;
    procedure SetSelLength(AValue: Integer); virtual; abstract;
    procedure SetSelStart(AValue: Integer); virtual; abstract;
    procedure SetSelText(const AValue: string); virtual; abstract;
    function IsInplace: Boolean;
  public
    constructor Create(AEdit: TWinControl); virtual;
    procedure ClearSelection; virtual;
    procedure GetSpellingBounds(out ASpellingStart, ASpellingEnd: Integer); virtual;

    property Edit: TWinControl read FEdit;
    property EditorHandle: THandle read GetEditorHandle;
    property HideSelection: Boolean read GetHideSelection write SetHideSelection;
    property ReadOnly: Boolean read GetReadOnly;
    property SelLength: Integer read GetSelLength write SetSelLength;
    property SelStart: Integer read GetSelStart write SetSelStart;
    property SelText: string read GetSelText write SetSelText;
    property Text: WideString read GetText;
  end;

  TdxSpellCheckerCustomEditAdapterClass = class of TdxSpellCheckerCustomEditAdapter;

  { TdxSpellCheckercxTextEditAdapter }

  TdxSpellCheckercxTextEditAdapter = class(TdxSpellCheckerCustomEditAdapter)
  private
    function GetEdit: TcxCustomTextEdit;
  protected
    function GetHideSelection: Boolean; override;
    function GetReadOnly: Boolean; override;
    function GetSelLength: Integer; override;
    function GetSelStart: Integer; override;
    function GetSelText: string; override;
    procedure SetHideSelection(AValue: Boolean); override;
    procedure SetSelLength(AValue: Integer); override;
    procedure SetSelStart(AValue: Integer); override;
    procedure SetSelText(const AValue: string); override;
    property Edit: TcxCustomTextEdit read GetEdit;
  end;

  { TdxSpellCheckercxRichEditAdapter }

  TdxSpellCheckercxRichEditAdapter = class(TdxSpellCheckercxTextEditAdapter)
  private
    function GetEdit: TcxCustomRichEdit;
  protected
    function GetReadOnly: Boolean; override;
    function GetText: WideString; override;
    property Edit: TcxCustomRichEdit read GetEdit;
  end;

  { TdxSpellCheckerEditAdapter }

  TdxSpellCheckerEditAdapter = class(TdxSpellCheckerCustomEditAdapter)
  private
    function GetEdit: TCustomEdit;
  protected
    function GetHideSelection: Boolean; override;
    function GetReadOnly: Boolean; override;
    function GetSelLength: Integer; override;
    function GetSelStart: Integer; override;
    function GetSelText: string; override;
    procedure SetHideSelection(AValue: Boolean); override;
    procedure SetSelLength(AValue: Integer); override;
    procedure SetSelStart(AValue: Integer); override;
    procedure SetSelText(const AValue: string); override;
    property Edit: TCustomEdit read GetEdit;
  end;

  { TdxSpellCheckerTextAdapter }

  TdxSpellCheckerTextAdapter = class(TdxSpellCheckerEditAdapter)
  public
    constructor Create(const AText: WideString); reintroduce; virtual;
  end;

  { TdxSpellCheckerTextParser }

  TdxSpellCheckerSentence = record
    StartTextPosition: Integer;
    StartWordPosition: Integer;
    Text: WideString;
  end;

  TdxSpellCheckerTextParser = class(TdxCustomSpellCheckerTextHelper)
  private
    FSpellChecker: TdxCustomSpellChecker;
    function LastWideCharIsSpace(const S: WideString): Boolean;
  protected
    FDelimiters: WideString;
    FMeaningfulCharacters: WideString;
    FPrevWord: WideString;
    FSpellingEnd: Integer;
    FSpellingStart: Integer;
    FText: WideString;
    FUrlDelimiters: WideString;
    function IsDelimiter(AChar: WideChar): Boolean;
    function IsMeaningfulCharacters(AChar: WideChar): Boolean;
    function IsUrlDelimiter(AChar: WideChar): Boolean;
    procedure UpdateTextInfo(AAdapter: TdxSpellCheckerCustomEditAdapter); virtual;

    property SpellChecker: TdxCustomSpellChecker read FSpellChecker;
  public
    constructor Create(ASpellChecker: TdxCustomSpellChecker); virtual;

    function GetNextWord(var AStart, ALength: Integer; out ADelimiters: WideString): WideString; virtual;
    function GetPrevWord: WideString; override;
    function WordExists(const AWord: WideString): Boolean; override;

    function GetNextDelimiterPosition(var AStart: Integer; ADirection: Integer): Boolean;
    function GetSentence(APos: Integer): TdxSpellCheckerSentence; virtual;
    function GetSuggestions(const AWord: WideString): TdxSpellCheckerSuggestionList; virtual;

    property Delimiters: WideString read FDelimiters write FDelimiters;
    property MeaningfulCharacters: WideString read FMeaningfulCharacters;
    property Text: WideString read FText;
    property UrlDelimiters: WideString read FUrlDelimiters write FUrlDelimiters;
  end;

  TdxSpellCheckerTextParserClass = class of TdxSpellCheckerTextParser;

  { TdxSpellCheckerUndoItem }

  TdxSpellCheckerUndoItem = class
  private
    FMisspelledWord: WideString;
    FMisspelledWordPosition: Integer;
    FPrevWord: WideString;
    FReplacement: WideString;
  public
    constructor Create(const AMisspelledWord, AReplacement, APrevWord: WideString;
      AMisspelledWordPosition: Integer);

    property MisspelledWord: WideString read FMisspelledWord;
    property MisspelledWordPosition: Integer read FMisspelledWordPosition;
    property PrevWord: WideString read FPrevWord;
    property Replacement: WideString read FReplacement;
  end;

  { TdxSpellCheckerUndoManager }

  TdxSpellCheckerUndoManager = class(TPersistent)
  private
    FUndoList: TcxObjectList;
    function GetCount: Integer;
    function GetItem(Index: Integer): TdxSpellCheckerUndoItem;
    function GetLast: TdxSpellCheckerUndoItem;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Add(const AMisspelledWord, AReplacement, APrevWord: WideString;
      AMisspelledWordPosition: Integer);
    procedure UndoLast;

    property Count: Integer read GetCount;
    property Last: TdxSpellCheckerUndoItem read GetLast;
    property Items[Index: Integer]: TdxSpellCheckerUndoItem read GetItem; default;
  end;

  { TdxSpellCheckerCustomCheckMode }

  TdxSpellCheckerCustomCheckMode = class(TPersistent)
  private
    FAdapter: TdxSpellCheckerCustomEditAdapter;
    FParser: TdxSpellCheckerTextParser;
    FSpellChecker: TdxCustomSpellChecker;
    FSpellingEnd: Integer;
    FSpellingStart: Integer;
    function GetPrevWord: WideString;
    procedure SetPrevWord(const AValue: WideString);
    procedure SetSpellingEnd(const AValue: Integer);
    procedure SetSpellingStart(const AValue: Integer);
  protected
    FLastCode: TdxSpellCheckerSpellingCode;
    FMisspellingLen: Integer;
    FMisspellingStart: Integer;
    FMisspelledWord: WideString;
    function CheckWord(const AWord: WideString): TdxSpellCheckerSpellingCode; virtual;
    procedure CreateParser; virtual;
    function GetNextWord(out AWord: WideString): Boolean; virtual;
    function GetOwner: TPersistent; override;
    function GetParserClass: TdxSpellCheckerTextParserClass; virtual;
    function InternalCheckWord(var AWord: WideString): TdxSpellCheckerSpellingCode; virtual;
    function InternalProcessWord(const AWord: WideString): Boolean; virtual;
    function IsNeedChangeWord(const AWord: WideString;
      out AReplacement: WideString): Boolean; virtual;
    function IsNeedDeleteWord(const AWord: WideString): Boolean; virtual;
    function IsNeedIgnoreWord(const AWord: WideString): Boolean; virtual;
    function IsValidWord(const AWord: WideString): Boolean; virtual;
    procedure RestoreSelection; virtual;
    procedure StoreSelection; virtual;
    procedure SelectMisspelledWord; virtual;
    procedure SelectMisspelledWordAfterUndo; virtual;
    procedure UpdateByDictionary(ADictionary: TdxCustomSpellCheckerDictionary); virtual;
    procedure UpdateSpellingBounds(ADelta: Integer); virtual;
    procedure UpdateTextInfo; virtual;
    procedure ValidateSpellingBounds; virtual;

    property PrevWord: WideString read GetPrevWord write SetPrevWord;
    property SpellingEnd: Integer read FSpellingEnd write SetSpellingEnd;
    property SpellingStart: Integer read FSpellingStart write SetSpellingStart;
  public
    constructor Create(AOwner: TdxCustomSpellChecker; AAdapter: TdxSpellCheckerCustomEditAdapter); virtual;
    destructor Destroy; override;

    procedure Add; virtual;
    function CanUndo: Boolean; virtual;
    procedure Change(const AWord: WideString); virtual;
    procedure ChangeAll(const AWord: WideString); virtual;
    procedure Delete; virtual;
    procedure DeleteAll; virtual;
    function GetSuggestions(const AWord: WideString): TdxSpellCheckerSuggestionList; virtual;
    function GetNextMisspelledWord: Boolean; virtual;
    procedure Ignore; virtual;
    procedure IgnoreAll; virtual;
    procedure UndoLast; virtual;

    property Adapter: TdxSpellCheckerCustomEditAdapter read FAdapter;
    property LastCode: TdxSpellCheckerSpellingCode read FLastCode;
    property MisspelledWord: WideString read FMisspelledWord;
    property Parser: TdxSpellCheckerTextParser read FParser;
    property SpellChecker: TdxCustomSpellChecker read FSpellChecker;
  end;

  TdxSpellCheckerCustomCheckModeClass = class of TdxSpellCheckerCustomCheckMode;

  { TdxSpellCheckerDialogCheckMode }

  TdxSpellCheckerDialogCheckMode = class(TdxSpellCheckerCustomCheckMode)
  private
    FCheckedRange: Integer;
    FSaveHideSelection: Boolean;
    FSaveSelLength: Integer;
    FSaveSelStart: Integer;
    FSelectionChecked: Boolean;
    FUndoManager: TdxSpellCheckerUndoManager;
    function GetLanguages: TdxSpellCheckerLanguages;
  protected
    procedure CreateParser; override;
    function IsCheckingSelectedText: Boolean; virtual;
    procedure RestoreSelection; override;
    procedure StoreSelection; override;
    procedure ValidateSpellingBounds; override;
    procedure ValidateSpellingBoundsAfterUndo;

    property UndoManager: TdxSpellCheckerUndoManager read FUndoManager;
  public
    constructor Create(AOwner: TdxCustomSpellChecker; AAdapter: TdxSpellCheckerCustomEditAdapter); override;
    destructor Destroy; override;

    function CanUndo: Boolean; override;
    procedure Change(const AWord: WideString); override;
    procedure Delete; override;
    procedure Ignore; override;
    function ShowDialog: Integer; virtual;
    procedure UndoLast; override;

    property Languages: TdxSpellCheckerLanguages read GetLanguages;
  end;

  { TdxSpellCheckerOutlookCheckMode }

  TdxSpellCheckerOutlookCheckMode = class(TdxSpellCheckerDialogCheckMode)
  protected
    procedure SelectMisspelledWordAfterUndo; override;
  public
    function ShowDialog: Integer; override;
  end;

  { TdxSpellCheckerWordCheckMode }

  TdxSpellCheckerWordCheckMode = class(TdxSpellCheckerDialogCheckMode)
  private
    function GetMisspelledSentence: TdxSpellCheckerSentence;
  protected
    procedure SelectMisspelledWordAfterUndo; override;
  public
    procedure ChangeSentence(const ASentence: WideString); virtual;
    function ShowDialog: Integer; override;

    property MisspelledSentence: TdxSpellCheckerSentence read GetMisspelledSentence;
  end;

  { TdxSpellCheckerWordList }

  TdxMetaphoneTable = array[Word] of PWideChar;
  PdxMetaphoneTable = ^TdxMetaphoneTable;

  TdxSpellCheckerWordList = class
  private
    FCount: Integer;
    FFindMostValidCapitalizationInDuplicates: Boolean;
    FLangID: Cardinal;
    FLock: TRTLCriticalSection;
    FMetaphone: TdxDoubleMetaphone;
    FMetaphoneTable: PdxMetaphoneTable;
    FTable: PPointerList;
    FTableSize: Integer;
    FUpperCaseBuffer: array[0..256] of WideChar;
    FUseDoubleMetaphone: Boolean;
    function GetCodePage: Cardinal;
    procedure InitMetaphoneTable;
    procedure SetUseDoubleMetaphone(AValue: Boolean);
    procedure UpdateMetaphoneInfo(ANewWord: PWideChar; ALength: Integer);
    procedure UpdateWordsMetaphone;
  protected
    function ElfHash(P: PWideChar; ALength: Integer): Integer;
    function FindWord(const S: WideString): PWideChar;
    function NewWord(S: PWideChar; ALength: Integer): PWideChar; {$IFDEF DELPHI9} inline; {$ENDIF}
    function AllocWord(ACharCount: Cardinal): PWideChar;
    procedure DisposeWord(AWord: PWideChar);
    function GetNextMetaphoneWord(AWord: PWideChar): Pointer; {$IFDEF DELPHI9} inline; {$ENDIF}
    function GetNextWord(AWord: PWideChar): Pointer; {$IFDEF DELPHI9} inline; {$ENDIF}
    procedure SetNextMetaphoneWord(AWord: PWideChar; AValue: Pointer); {$IFDEF DELPHI9} inline; {$ENDIF}
    procedure SetNextWord(AWord: PWideChar; AValue: Pointer); {$IFDEF DELPHI9} inline; {$ENDIF}
    function WordLength(AWord: PWideChar): Integer; {$IFDEF DELPHI9} inline; {$ENDIF}

    property CodePage: Cardinal  read GetCodePage;
  public
    constructor Create(ALangID: Cardinal; ATableSize: Integer);
    destructor Destroy; override;
    procedure Add(const S: WideString);
    procedure Clear;
    function Find(const S: WideString): Boolean;
    procedure LoadFromStrings(AStrings: TStrings);
    procedure PopulateMetaphoneSuggestions(ASuggestionBuilder: TdxSpellCheckerSuggestionBuilder;
      const AWord: WideString);
    procedure SaveToStrings(AStrings: TStrings);

    property Count: Integer read FCount;
    property FindMostValidCapitalizationInDuplicates: Boolean
      read FFindMostValidCapitalizationInDuplicates write FFindMostValidCapitalizationInDuplicates;
    property LangID: Cardinal read FLangID write FLangID;
    property UseDoubleMetaphone: Boolean read FUseDoubleMetaphone write SetUseDoubleMetaphone;
  end;

  { TdxSpellCheckerSuggestionBuilder }

  TdxSpellCheckerSuggestionBuilder = class
  private
    FStartTicks: Cardinal;
    FAlphabet: WideString;
    FDictionary: TdxCustomSpellCheckerDictionary;
    FSuggestions: TdxSpellCheckerSuggestionList;
    FWord: WideString;
    function GetTimeout: Cardinal;
    procedure SetAlphabet(const AValue: WideString);
    function GetMaxDistance: Integer;
    function GetSimilarity: TdxStringSimilarityCalculator;
  protected
    function CanAddToSuggestions(const ATestWord: WideString): Boolean; virtual;
    procedure CheckAddMetaphoneSuggestion(ATestWord, AUpperWord1: PWideChar;
      AUpperWordLen1: Integer; AUpperWord2: PWideChar; AUpperWordLen2: Integer);
    procedure PopulateCapitalizationSuggestions;
    procedure DoAddMetaphoneSuggestions; virtual;
    procedure DoAddSuggestions; virtual;
    function IsCaseSensitive: Boolean; virtual;
    function IsTimeOut: Boolean;
    function PrepareWord(const AWord: WideString): WideString; virtual;

    property Alphabet: WideString read FAlphabet write SetAlphabet;
    property Dictionary: TdxCustomSpellCheckerDictionary read FDictionary;
    property MaxDistance: Integer read GetMaxDistance;
    property Similarity: TdxStringSimilarityCalculator read GetSimilarity;
    property Suggestions: TdxSpellCheckerSuggestionList read FSuggestions write FSuggestions;
    property Timeout: Cardinal read GetTimeout;
    property Word: WideString read FWord write FWord;
  public
    constructor Create(ADictionary: TdxCustomSpellCheckerDictionary); virtual;
    procedure AddSuggestions(const AWord: WideString; ASuggestions: TdxSpellCheckerSuggestionList); virtual;
  end;

  { TdxNearMissStrategy }

  TdxNearMissStrategy = class(TdxSpellCheckerSuggestionBuilder)
  protected
    procedure CheckAddToSuggestions(const ATestWord: WideString);
    procedure CheckChangeOneLetter;
    procedure CheckDeleteLetter;
    procedure CheckDoubleTwoChars;
    procedure CheckInsertLetter;
    procedure CheckInsertSpace;
    procedure CheckMoveChar;
    procedure DoAddSuggestions; override;
    procedure InterchangeTwoLetters;
    procedure LongInterchangeTwoLetters;
  end;

  { TdxDictionaryLoadThread }

  TdxDictionaryLoadThread = class(TcxThread)
  private
    FDictionary: TdxCustomSpellCheckerDictionary;
    FFinished: Boolean;
  protected
    procedure Execute; override;

    property Dictionary: TdxCustomSpellCheckerDictionary read FDictionary;
  public
    constructor Create(ADictionary: TdxCustomSpellCheckerDictionary);
    function IsLoadComplete: Boolean;

    property Finished: Boolean read FFinished;
  end;

  { TdxCustomSpellCheckerDictionary }

  TdxSpellCheckerDictionaryLoadingEvent = procedure (Sender: TdxCustomSpellCheckerDictionary; var AHandled: Boolean) of object;
  TdxSpellCheckerDictionaryLoadedEvent = procedure (Sender: TdxCustomSpellCheckerDictionary) of object;
  TdxSpellCheckerDictionaryLoadMode = (dlmDefault, dlmDirectLoad, dlmThreadedLoad);

  TdxCustomSpellCheckerDictionary = class(TdxSpellCheckerPersistent)
  private
    FAlphabet: WideString;
    FCodePage: Cardinal;
    FEnabled: Boolean;
    FLanguage: DWORD;
    FLoaded: Boolean;
    FLoadThread: TdxDictionaryLoadThread;
    FTerminated: Boolean;
    FTimeout: Cardinal;
    FOnLoading: TdxSpellCheckerDictionaryLoadingEvent;
    FOnLoaded: TdxSpellCheckerDictionaryLoadedEvent;
    function GetActive: Boolean;
    procedure SetEnabled(AValue: Boolean);
    procedure SetCodePage(AValue: Cardinal);
    procedure SetLanguage(const AValue: DWORD);
  protected
    function CanLoad: Boolean; virtual;
    function CanUseDoubleMetaphone: Boolean; virtual;
    procedure Cleanup; virtual;
    function CreateSuggestionBuilder: TdxSpellCheckerSuggestionBuilder; virtual;
    procedure DirectLoad; virtual;
    procedure DoActivate; virtual;
    function DoLoad: Boolean; virtual;
    procedure DoLoadedEvent; virtual;
    function DoLoadingEvent: Boolean; virtual;
    function DoUnload: Boolean; virtual;
    procedure FreeContent; virtual;
    function GetActiveAlphabet: WideString; virtual;
    function GetDisplayName: string; virtual;
    procedure InitializeContent; virtual;
    function IsEnglishLanguage: Boolean;
    procedure LanguageChanged; virtual;
    procedure LoadingComplete; virtual;
    function LoadingTerminated: Boolean; {$IFDEF DELPHI9} inline; {$ENDIF}
    procedure LoadUsingThread; virtual;
    procedure PopulateCapitalizationSuggestions(
      ASuggestionBuilder: TdxSpellCheckerSuggestionBuilder;
      const AWord: WideString); virtual;
    procedure PopulateMetaphoneSuggestions(
      ASuggestionBuilder: TdxSpellCheckerSuggestionBuilder;
      const AWord: WideString); virtual;
    procedure Reload;
    procedure Terminate;
    procedure ThreadDone(Sender: TObject); virtual;
    procedure Update; virtual;
    procedure UpdateLoadedOnLoadEvent;
    procedure UpdateUsingMetaphone; virtual;
    procedure UpdateWordChars(var AWordChars: WideString); virtual;

    property LoadThread: TdxDictionaryLoadThread read FLoadThread;
    property Timeout: Cardinal read FTimeout write FTimeout;
  public
    constructor Create(ASpellChecker: TdxCustomSpellChecker); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;

    procedure Activate;
    function HasWord(const AWord: WideString): Boolean; virtual;

    procedure Clear;
    procedure Load(AMode: TdxSpellCheckerDictionaryLoadMode = dlmDefault);
    procedure Unload;

    property Active: Boolean read GetActive;
    property Alphabet: WideString read FAlphabet write FAlphabet;
    property CodePage: Cardinal read FCodePage write SetCodePage default CP_ACP;
    property Enabled: Boolean read FEnabled write SetEnabled default True;
    property Language: DWORD read FLanguage write SetLanguage default 0;
    property Loaded: Boolean read FLoaded;
    property OnLoaded: TdxSpellCheckerDictionaryLoadedEvent read FOnLoaded write FOnLoaded;
    property OnLoading: TdxSpellCheckerDictionaryLoadingEvent read FOnLoading write FOnLoading;
  end;

  TdxCustomSpellCheckerDictionaryClass = class of TdxCustomSpellCheckerDictionary;

  { TdxSpellCheckerDictionary }

  TdxSpellCheckerDictionary = class(TdxCustomSpellCheckerDictionary)
  private
    FCheckCapitalization: Boolean;
    FWords: TdxSpellCheckerWordList;
    function GetWordCount: Integer;
    procedure SetCheckCapitalization(AValue: Boolean);
  protected
    function CanUseDoubleMetaphone: Boolean; override;
    procedure Cleanup; override;
    function DoUnload: Boolean; override;
    procedure FreeContent; override;
    procedure InitializeContent; override;
    function IsCorrectCapitalization(const AWord, APattern: WideString): Boolean; virtual;
    procedure LanguageChanged; override;
    procedure PopulateCapitalizationSuggestions(
      ASuggestionBuilder: TdxSpellCheckerSuggestionBuilder;
      const AWord: WideString); override;
    procedure PopulateMetaphoneSuggestions(
      ASuggestionBuilder: TdxSpellCheckerSuggestionBuilder;
      const AWord: WideString); override;
    procedure UpdateUsingMetaphone; override;

    property Words: TdxSpellCheckerWordList read FWords;
  public
    procedure Assign(Source: TPersistent); override;
    function HasWord(const AWord: WideString): Boolean; override;

    property Active;
    property Alphabet;
    property CheckCapitalization: Boolean read FCheckCapitalization write SetCheckCapitalization default False;
    property CodePage;
    property Enabled;
    property Language;
    property Loaded;
    property WordCount: Integer read GetWordCount;
    property OnLoaded;
    property OnLoading;
  end;

  { TdxUserSpellCheckerDictionary }

  TdxUserSpellCheckerDictionaryOption = (udFileMustExist, udSaveOnUnload);
  TdxUserSpellCheckerDictionaryOptions = set of TdxUserSpellCheckerDictionaryOption;

  TdxUserSpellCheckerDictionary = class(TdxSpellCheckerDictionary)
  private
    FDictionaryPath: TFileName;
    FOptions: TdxUserSpellCheckerDictionaryOptions;
  protected
    function DoLoad: Boolean; override;
    function DoUnload: Boolean; override;
    function GetDisplayName: string; override;
  public
    constructor Create(ASpellChecker: TdxCustomSpellChecker); override;
    procedure Assign(Source: TPersistent); override;
    procedure AddWord(const AWord: WideString);
    procedure LoadFromStrings(AStrings: TStrings);
    procedure SaveToStrings(AStrings: TStrings);
  published
    property Alphabet;
    property CheckCapitalization;
    property CodePage;
    property Enabled;
    property DictionaryPath: TFileName read FDictionaryPath write FDictionaryPath;
    property Options: TdxUserSpellCheckerDictionaryOptions read FOptions write FOptions default [udSaveOnUnload];
    property OnLoaded;
    property OnLoading;
  end;

  { TdxSpellCheckerDictionaryItem }

  TdxSpellCheckerDictionaries = class;

  TdxSpellCheckerDictionaryItem = class(TCollectionItem)
  private
    FDictionaryType: TdxCustomSpellCheckerDictionary;
    FDictionaryTypeClass: TdxCustomSpellCheckerDictionaryClass;
    FDictionaryEvents: TNotifyEvent;
    function GetCollection: TdxSpellCheckerDictionaries;
    function GetDictionaryTypeClassName: string;
    procedure SetDictionaryType(AValue: TdxCustomSpellCheckerDictionary);
    procedure SetDictionaryTypeClassName(const AValue: string);
    procedure SetDictionaryTypeClass(AValue: TdxCustomSpellCheckerDictionaryClass);
  protected
    function GetDisplayName: string; override;
    procedure RecreateDictionaryType;
  public
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;

    property Collection: TdxSpellCheckerDictionaries read GetCollection;
    property DictionaryTypeClass: TdxCustomSpellCheckerDictionaryClass read FDictionaryTypeClass write SetDictionaryTypeClass;
  published
    property DictionaryTypeClassName: string read GetDictionaryTypeClassName write SetDictionaryTypeClassName;
    property DictionaryType: TdxCustomSpellCheckerDictionary read FDictionaryType write SetDictionaryType;
    property DictionaryEvents: TNotifyEvent read FDictionaryEvents write FDictionaryEvents;
  end;

  { TdxSpellCheckerDictionaries }

  TdxSpellCheckerDictionaries = class(TCollection)
  private
    FSpellChecker: TdxCustomSpellChecker;
    function GetItem(Index: Integer): TdxSpellCheckerDictionaryItem;
    procedure SetItem(Index: Integer; AValue: TdxSpellCheckerDictionaryItem);
  protected
    function GetOwner: TPersistent; override;

    property SpellChecker: TdxCustomSpellChecker read FSpellChecker;
  public
    constructor Create(ASpellChecker: TdxCustomSpellChecker);
    function Add: TdxSpellCheckerDictionaryItem;
    function GetNamePath: string; override;

    property Items[Index: Integer]: TdxSpellCheckerDictionaryItem read GetItem write SetItem; default;
  end;

  { TdxSpellCheckerCustomOptions }

  TdxSpellCheckerCustomOptions = class(TdxSpellCheckerPersistent)
  protected
    procedure InitializeOptions; virtual;
  public
    constructor Create(ASpellChecker: TdxCustomSpellChecker); override;
  end;

  { TdxSpellCheckerAutoCorrectExceptions }

  TdxSpellCheckerAutoCorrectExceptionAddEvent = procedure (Sender: TdxSpellCheckerAutoCorrectExceptions;
    var AException: WideString; var AAllow: Boolean) of object;
  TdxSpellCheckerAutoCorrectExceptionDeleteEvent = procedure (Sender: TdxSpellCheckerAutoCorrectExceptions;
    const AException: WideString; var AAllow: Boolean) of object;

  TdxSpellCheckerAutoCorrectExceptions = class
  private
    FAutoInclude: Boolean;
    FCount: Integer;
    FList: PPointerList;
    FLock: TRTLCriticalSection;
    FOptions: TdxSpellCheckerAutoCorrectOptions;
    FOnAdd: TdxSpellCheckerAutoCorrectExceptionAddEvent;
    FOnDelete: TdxSpellCheckerAutoCorrectExceptionDeleteEvent;
    function GetException(Index: Integer): WideString;
  protected
    procedure DisposeException(AException: PWideChar);
    function DoAdd(var AException: WideString): Boolean;
    function DoDelete(const AException: WideString): Boolean;
    procedure SetCount(AValue: Integer); virtual;

    property OnAdd: TdxSpellCheckerAutoCorrectExceptionAddEvent read FOnAdd write FOnAdd;
    property OnDelete: TdxSpellCheckerAutoCorrectExceptionDeleteEvent read FOnDelete write FOnDelete;
  public
    constructor Create(AOptions: TdxSpellCheckerAutoCorrectOptions); virtual;
    destructor Destroy; override;

    function Add(const AException: WideString): Integer;
    procedure Clear;
    procedure Delete(AIndex: Integer); overload;
    procedure Delete(const AException: WideString); overload;
    function Find(const AException: WideString): Integer;
    procedure LoadFromFile(const AFileName: WideString);
    procedure LoadFromStream(AStream: TStream);
    procedure PopulateExceptions(AList: TStrings);
    procedure SaveToFile(const AFileName: WideString);
    procedure SaveToStream(AStream: TStream);

    property AutoInclude: Boolean read FAutoInclude write FAutoInclude;
    property Count: Integer read FCount;
    property Exceptions[Index: Integer]: WideString read GetException; default;
  end;

  { TdxSpellCheckerAutoCorrectReplacementList }

  TdxSpellCheckerAutoCorrectReplacementList = class(TdxSpellCheckerReplacementList)
  public
    procedure LoadFromFile(const AFileName: WideString);
    procedure LoadFromStream(AStream: TStream);
    procedure SaveToFile(const AFileName: WideString);
    procedure SaveToStream(AStream: TStream);
  end;

  { TdxSpellCheckerAutoCorrectOptions }

  TdxSpellCheckerAutoCorrectOptionsChangedEvent = procedure (Sender: TdxSpellCheckerAutoCorrectOptions) of object;

  TdxSpellCheckerAutoCorrectOptions = class(TdxSpellCheckerCustomOptions)
  private
    FActive: Boolean;
    FAutomaticallyUseSuggestions: Boolean;
    FCorrectCapsLock: Boolean;
    FCorrectInitialCaps: Boolean;
    FCorrectSentenceCaps: Boolean;
    FDisableCapsLock: Boolean;
    FFirstLetterExceptions: TdxSpellCheckerAutoCorrectExceptions;
    FInitialCapsExceptions: TdxSpellCheckerAutoCorrectExceptions;
    FReplacements: TdxSpellCheckerAutoCorrectReplacementList;
    FReplaceTextAsYouType: Boolean;
    FOnChanged: TdxSpellCheckerAutoCorrectOptionsChangedEvent;
    procedure FirstLetterExceptionAddHandler(Sender: TdxSpellCheckerAutoCorrectExceptions;
      var AException: WideString; var AAllow: Boolean);
    procedure InitialCapsExceptionAddHandler(Sender: TdxSpellCheckerAutoCorrectExceptions;
      var AException: WideString; var AAllow: Boolean);
    procedure SetActive(const AValue: Boolean);
    procedure SetAutomaticallyUseSuggestions(const AValue: Boolean);
    procedure SetCorrectCapsLock(const AValue: Boolean);
    procedure SetCorrectInitialCaps(const AValue: Boolean);
    procedure SetCorrectSentenceCaps(const AValue: Boolean);
    procedure SetDisableCapsLock(const AValue: Boolean);
    procedure SetReplaceTextAsYouType(const AValue: Boolean);
  protected
    procedure Changed; virtual;
    procedure DoChanged; virtual;
    procedure InitializeOptions; override;
  public
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;

    function GetReplacement(const AText: WideString; out AReplacement: WideString): Boolean; virtual;

    property FirstLetterExceptions: TdxSpellCheckerAutoCorrectExceptions read FFirstLetterExceptions;
    property InitialCapsExceptions: TdxSpellCheckerAutoCorrectExceptions read FInitialCapsExceptions;
    property Replacements: TdxSpellCheckerAutoCorrectReplacementList read FReplacements;
    property OnChanged: TdxSpellCheckerAutoCorrectOptionsChangedEvent read FOnChanged write FOnChanged;
  published
    property Active: Boolean read FActive write SetActive default False;
    property AutomaticallyUseSuggestions: Boolean read FAutomaticallyUseSuggestions write SetAutomaticallyUseSuggestions default True;
    property CorrectCapsLock: Boolean read FCorrectCapsLock write SetCorrectCapsLock default True;
    property CorrectInitialCaps: Boolean read FCorrectInitialCaps write SetCorrectInitialCaps default True;
    property CorrectSentenceCaps: Boolean read FCorrectSentenceCaps write SetCorrectSentenceCaps default True;
    property DisableCapsLock: Boolean read FDisableCapsLock write SetDisableCapsLock default False;
    property ReplaceTextAsYouType: Boolean read FReplaceTextAsYouType write SetReplaceTextAsYouType default True;
  end;

  { TdxSpellCheckerSpellingOptions }

  TdxSpellCheckerSpellingOptionsChangedEvent = procedure (Sender: TdxSpellCheckerSpellingOptions) of object;

  TdxSpellCheckerSpellingOptions = class(TdxSpellCheckerCustomOptions)
  private
    FIgnoreMixedCaseWords: Boolean;
    FIgnoreUpperCaseWords: Boolean;
    FIgnoreMarkupTags: Boolean;
    FIgnoreRepeatedWords: Boolean;
    FCheckSelectedTextFirst: Boolean;
    FIgnoreUrls: Boolean;
    FCheckFromCursorPos: Boolean;
    FIgnoreEmails: Boolean;
    FIgnoreWordsWithNumbers: Boolean;
    FOnChanged: TdxSpellCheckerSpellingOptionsChangedEvent;
    procedure SetCheckFromCursorPos(AValue: Boolean);
    procedure SetCheckSelectedTextFirst(AValue: Boolean);
    procedure SetIgnoreEmails(AValue: Boolean);
    procedure SetIgnoreMarkupTags(AValue: Boolean);
    procedure SetIgnoreMixedCaseWords(AValue: Boolean);
    procedure SetIgnoreRepeatedWords(AValue: Boolean);
    procedure SetIgnoreUpperCaseWords(AValue: Boolean);
    procedure SetIgnoreUrls(AValue: Boolean);
    procedure SetIgnoreWordsWithNumbers(AValue: Boolean);
  protected
    procedure Changed; virtual;
    procedure DoChanged; virtual;
    procedure InitializeOptions; override;
    procedure PopulateRules(ARules: TdxSpellCheckerRules;
      AParser: TdxSpellCheckerTextParser); virtual;

    property IgnoreMarkupTags: Boolean read FIgnoreMarkupTags write SetIgnoreMarkupTags default True;
  public
    procedure Assign(Source: TPersistent); override;

    property OnChanged: TdxSpellCheckerSpellingOptionsChangedEvent read FOnChanged write FOnChanged;
  published
    property CheckFromCursorPos: Boolean read FCheckFromCursorPos write SetCheckFromCursorPos default False;
    property CheckSelectedTextFirst: Boolean read FCheckSelectedTextFirst write SetCheckSelectedTextFirst default True;
    property IgnoreEmails: Boolean read FIgnoreEmails write SetIgnoreEmails default True;
    property IgnoreMixedCaseWords: Boolean read FIgnoreMixedCaseWords write SetIgnoreMixedCaseWords default True;
    property IgnoreRepeatedWords: Boolean read FIgnoreRepeatedWords write SetIgnoreRepeatedWords default False;
    property IgnoreUpperCaseWords: Boolean read FIgnoreUpperCaseWords write SetIgnoreUpperCaseWords default True;
    property IgnoreUrls: Boolean read FIgnoreUrls write SetIgnoreUrls default True;
    property IgnoreWordsWithNumbers: Boolean read FIgnoreWordsWithNumbers write SetIgnoreWordsWithNumbers default True;
  end;

  { TdxSpellCheckerCheckAsYouTypeOptions }

  TdxSpellCheckerUnderlineStyle = (usAuto, usWavyLine, usLine);

  TdxSpellCheckerPopupMenuItem = (scmiAddToDictionary, scmiAutoCorrect, scmiDelete,
    scmiIgnoreAll, scmiSpelling, scmiSuggestions);
  TdxSpellCheckerPopupMenuItems = set of TdxSpellCheckerPopupMenuItem;

  TdxSpellCheckerCheckAsYouTypeOptionsChangedEvent = procedure(
    ASender: TdxSpellCheckerCheckAsYouTypeOptions) of object;

  TdxSpellCheckerCheckAsYouTypeOptions = class(TdxSpellCheckerCustomOptions)
  private
    FActive: Boolean;
    FModifyControlPopupMenu: Boolean;
    FPopupMenu: TComponent;
    FPopupMenuItems: TdxSpellCheckerPopupMenuItems;
    FSuggestionCount: Integer;
    FUnderlineColor: TColor;
    FUnderlineStyle: TdxSpellCheckerUnderlineStyle;
    FOnChanged: TdxSpellCheckerCheckAsYouTypeOptionsChangedEvent;
    procedure SetActive(AValue: Boolean);
    procedure SetPopupMenu(AValue: TComponent);
    procedure SetModifyControlPopupMenu(AValue: Boolean);
    procedure SetPopupMenuItems(AValue: TdxSpellCheckerPopupMenuItems);
    procedure SetSuggestionCount(AValue: Integer);
    procedure SetUnderlineColor(AValue: TColor);
    procedure SetUnderlineStyle(AValue: TdxSpellCheckerUnderlineStyle);
  protected
    procedure Changed; virtual;
    procedure DoChanged; virtual;
    procedure InitializeOptions; override;
    procedure Notification(AComponent: TComponent; AOperation: TOperation); virtual;
  public
    procedure Assign(Source: TPersistent); override;

    property OnChanged: TdxSpellCheckerCheckAsYouTypeOptionsChangedEvent
      read FOnChanged write FOnChanged;
  published
    property Active: Boolean read FActive write SetActive default False;
    property ModifyControlPopupMenu: Boolean read FModifyControlPopupMenu
      write SetModifyControlPopupMenu default True;
    property PopupMenu: TComponent read FPopupMenu write SetPopupMenu;
    property PopupMenuItems: TdxSpellCheckerPopupMenuItems read FPopupMenuItems
      write SetPopupMenuItems default [scmiAddToDictionary, scmiAutoCorrect, scmiDelete, scmiIgnoreAll, scmiSpelling, scmiSuggestions];
    property SuggestionCount: Integer read FSuggestionCount write SetSuggestionCount default 5;
    property UnderlineColor: TColor read FUnderlineColor write SetUnderlineColor default clRed;
    property UnderlineStyle: TdxSpellCheckerUnderlineStyle read FUnderlineStyle
      write SetUnderlineStyle default usAuto;
  end;

  { TdxSpellCheckerCustomManager }

  TdxSpellCheckerCustomManager = class(TdxSpellCheckerPersistent)
  private
    FCheckMode: TdxSpellCheckerCustomCheckMode;
    FContainer: TcxCustomEdit;
    function GetEdit: TWinControl;
    procedure SetEdit(const AValue: TWinControl);
  protected
    FAdapter: TdxSpellCheckerCustomEditAdapter;
    procedure CreateAdapter(AAdapterClass: TdxSpellCheckerCustomEditAdapterClass; AControl: TWinControl); virtual;
    procedure DoActiveChanged; virtual; abstract;
    procedure DoFinalizeController; virtual;
    procedure DoFinish(AControl: TWinControl); virtual; abstract;
    procedure DoOptionsChanged; virtual; abstract;
    function DoStart(AControl: TWinControl): Boolean; virtual; abstract;
    function GetActive: Boolean; virtual;
    function GetAdapterClass(AControl: TWinControl): TdxSpellCheckerCustomEditAdapterClass; virtual;
    function GetCheckModeClass: TdxSpellCheckerCustomCheckModeClass; virtual;
    procedure FinalizeController; virtual;
    procedure InitializeController(AControl: TWinControl); virtual;
    function IsCheckSupported(AControl: TWinControl): Boolean;
    procedure ValidateAdapter; virtual;

    property Container: TcxCustomEdit read FContainer;
  public
    constructor Create(ASpellChecker: TdxCustomSpellChecker); override;

    procedure CheckFinish; virtual;
    procedure CheckStart(AControl: TWinControl); virtual;

    property Active: Boolean read GetActive;
    property Adapter: TdxSpellCheckerCustomEditAdapter read FAdapter;
    property CheckMode: TdxSpellCheckerCustomCheckMode read FCheckMode;
    property Edit: TWinControl read GetEdit write SetEdit;
  end;

  { TdxSpellCheckerAutoCorrectCustomRule }

  TdxSpellCheckerAutoCorrectCustomRule = class
  private
    FManager: TdxSpellCheckerCustomAutoCorrectManager;
    FWordDelimiters: WideString;
    function GetLastKey: WideChar;
    function GetOptions: TdxSpellCheckerAutoCorrectOptions;
  protected
    function GetActive: Boolean; virtual;
    procedure InitializeDelimiters; virtual; abstract;
    procedure SetWordDelimiters(const AWordDelimiters: WideString);
    function WideCapitalizeCase(const AWord: WideString): WideString;

    property LastKey: WideChar read GetLastKey;
  public
    constructor Create(AManager: TdxSpellCheckerCustomAutoCorrectManager); virtual;

    procedure AfterCorrect; virtual;
    procedure BeforeCorrect; virtual;
    function IsCheckWord(const AText: WideString; var AStart, ALength: Integer;
      var AWord: WideString): Boolean; virtual; abstract;
    function IsTerminating: Boolean; virtual;
    function IsWordDelimiter(AChar: WideChar): Boolean;
    procedure Undo; virtual;

    property Active: Boolean read GetActive;
    property Manager: TdxSpellCheckerCustomAutoCorrectManager read FManager;
    property Options: TdxSpellCheckerAutoCorrectOptions read GetOptions;
    property WordDelimiters: WideString read FWordDelimiters;
  end;

  { TdxSpellCheckerCustomAutoCorrectManager }

  TdxSpellCheckerCustomAutoCorrectManager = class(TdxSpellCheckerCustomManager)
  private
    FLastKey: WideChar;
    function GetOptions: TdxSpellCheckerAutoCorrectOptions;
  protected
    procedure CreateAdapter(AAdapterClass: TdxSpellCheckerCustomEditAdapterClass; AControl: TWinControl); override;
    function DoAutoCorrect(ARule: TdxSpellCheckerAutoCorrectCustomRule;
      var AWordRange: TdxSpellCheckerAutoCorrectWordRange): Boolean; virtual;
    procedure DoFinish(AControl: TWinControl); override;
    function DoStart(AControl: TWinControl): Boolean; override;
    function GetActive: Boolean; override;
    function GetAdapterClass(
      AControl: TWinControl): TdxSpellCheckerCustomEditAdapterClass; override;
    procedure Undo; virtual;
    function WideCapitalizeCase(const AWord: WideString): WideString;

    property LastKey: WideChar read FLastKey;
  public
    procedure KeyPress(AKey: Char); virtual;

    property Options: TdxSpellCheckerAutoCorrectOptions read GetOptions;
  end;

  { TdxSpellCheckerCustomCheckAsYouTypeManager }

  TdxSpellCheckerCustomCheckAsYouTypeManager = class(TdxSpellCheckerCustomManager)
  private
    FManualCheckCount: Integer;
    function GetIsManualCheckingActive: Boolean;
    function GetIsSpellCheckerReady: Boolean;
    function GetOptions: TdxSpellCheckerCheckAsYouTypeOptions;
  protected
    procedure DoFinish(AControl: TWinControl); override;
    function DoStart(AControl: TWinControl): Boolean; override;
    function GetActive: Boolean; override;
    procedure InnerShowPopupMenu(APopup: TComponent; const P: TPoint);
    procedure Reset; virtual;
    procedure SpellingOptionsChanged; virtual;
    procedure StartManualSpelling(AAdapter: TdxSpellCheckerCustomEditAdapter); virtual;
    procedure ValidateRules(AParser: TdxSpellCheckerTextParser); virtual;
  public
    procedure BeginManualCheck; virtual;
    procedure CheckFinish; override;
    procedure CheckStart(AControl: TWinControl); override;
    procedure EndManualCheck; virtual;
    procedure KeyDown(AKey: Word; Shift: TShiftState); virtual;
    procedure KeyUp(AKey: Word; Shift: TShiftState); virtual;
    procedure Refresh(AFullRefresh: Boolean = False); virtual; abstract;

    procedure DrawMisspellings(AControl: TWinControl); virtual; abstract;
    procedure LayoutChanged(AControl: TWinControl); virtual; abstract;
    function QueryPopup(APopup: TComponent; const P: TPoint): Boolean; virtual; abstract;
    procedure SelectionChanged(AControl: TWinControl); virtual; abstract;
    procedure TextChanged(AControl: TWinControl); virtual; abstract;

    property IsManualCheckingActive: Boolean read GetIsManualCheckingActive;
    property IsSpellCheckerReady: Boolean read GetIsSpellCheckerReady;
    property Options: TdxSpellCheckerCheckAsYouTypeOptions read GetOptions;
  end;

  { TdxCustomSpellChecker }

  TdxSpellCheckerSpellingFormType = (sftOutlook, sftWord);

  TdxSpellCheckerEvent = procedure (Sender: TdxCustomSpellChecker) of object;
  TdxSpellCheckerCheckWordEvent = procedure (Sender: TdxCustomSpellChecker;
    const AWord: WideString; out AValid: Boolean; var AHandled: Boolean) of object;
  TdxSpellCheckerAddWordEvent = procedure (AUserDictionary: TdxUserSpellCheckerDictionary;
    const AWord: WideString; var AHandled: Boolean) of object;
  TdxSpellCheckerAutoCorrectEvent = procedure (Sender: TdxCustomSpellChecker;
    ARule: TdxSpellCheckerAutoCorrectCustomRule; var AWordRange: TdxSpellCheckerAutoCorrectWordRange;
    var AAllow: Boolean) of object;
  TdxSpellCheckerEnabledDictionariesLoadedEvent = procedure (Sender: TdxCustomSpellChecker;
    const AWord: WideString; var AHandled: Boolean) of object;
  TdxSpellCheckerSpellingComplete = procedure (Sender: TdxCustomSpellChecker;
    var AHandled: Boolean) of object;
  TdxSpellCheckerCheckFinishEvent = procedure (Sender: TdxCustomSpellChecker;
    AControl: TWinControl) of object;
  TdxSpellCheckerCheckStartEvent = procedure (Sender: TdxCustomSpellChecker;
    AControl: TWinControl; var AAllow: Boolean) of object;
  TdxSpellCheckerCheckAsYouTypePopupEvent = procedure(ASender: TdxCustomSpellChecker;
    APopupMenu: TComponent; var AHandled: Boolean) of object;
  TdxSpellCheckerCheckControlInContainerEvent = procedure (Sender: TdxCustomSpellChecker;
    AControl: TWinControl; var AAllow: Boolean; var AContinue: Boolean) of object;
  TdxSpellCheckerGetSuggestionsEvent = procedure (Sender: TdxCustomSpellChecker;
    const AWord: WideString; ASuggestions: TdxSpellCheckerSuggestionList) of object;

  TdxCustomSpellChecker = class(TComponent,
    IdxSkinSupport, IdxSpellChecker, IdxSpellChecker2)
  private
    FAutoCorrectManager: TdxSpellCheckerCustomAutoCorrectManager;
    FAutoCorrectOptions: TdxSpellCheckerAutoCorrectOptions;
    FAutoLoadDictionaries: Boolean;
    FChangeList: TdxSpellCheckerReplacementList;
    FCheckAsYouTypeManager: TdxSpellCheckerCustomCheckAsYouTypeManager;
    FCheckAsYouTypeOptions: TdxSpellCheckerCheckAsYouTypeOptions;
    FCheckGroupMode: Boolean;
    FCheckingContainer: Boolean;
    FCheckMode: TdxSpellCheckerCustomCheckMode;
    FCreating: Boolean;
    FDeleteList: TdxSpellCheckerWordList;
    FDialogLookAndFeel: TcxLookAndFeel;
    FDictionaryItems: TdxSpellCheckerDictionaries;
    FIgnoreList: TdxSpellCheckerWordList;
    FLanguages: TdxSpellCheckerLanguages;
    FLastDialogResult: Integer;
    FMetaphoneDistance: Integer;
    FRules: TdxSpellCheckerRules;
    FSimilarity: TdxStringSimilarityCalculator;
    FSpellingFormType: TdxSpellCheckerSpellingFormType;
    FSpellingOptions: TdxSpellCheckerSpellingOptions;
    FSuggestionCache: TdxSpellCheckerSuggestionCache;
    FThreadedLoadPriority: TThreadPriority;
    FUseThreadedLoad: Boolean;
    FOnAddWord: TdxSpellCheckerAddWordEvent;
    FOnAfterCheck: TdxSpellCheckerEvent;
    FOnAutoCorrect: TdxSpellCheckerAutoCorrectEvent;
    FOnAutoCorrectFinish: TdxSpellCheckerCheckFinishEvent;
    FOnAutoCorrectStart: TdxSpellCheckerCheckStartEvent;
    FOnBeforeCheck: TdxSpellCheckerEvent;
    FOnCheckAsYouTypeFinish: TdxSpellCheckerCheckFinishEvent;
    FOnCheckAsYouTypeStart: TdxSpellCheckerCheckStartEvent;
    FOnCheckControlInContainer: TdxSpellCheckerCheckControlInContainerEvent;
    FOnCheckWord: TdxSpellCheckerCheckWordEvent;
    FOnEnabledDictionariesLoaded: TdxSpellCheckerEvent;
    FOnGetSuggestions: TdxSpellCheckerGetSuggestionsEvent;
    FOnCheckAsYouTypePopup: TdxSpellCheckerCheckAsYouTypePopupEvent;
    FOnSpellingComplete: TdxSpellCheckerSpellingComplete;
    function GetActiveDictionary(
      Index: Integer): TdxCustomSpellCheckerDictionary;
    function GetActiveDictionaryCount: Integer;
    function GetCheckMode: TdxSpellCheckerCustomCheckMode;
    function GetDictionary(Index: Integer): TdxCustomSpellCheckerDictionary;
    function GetDictionaryCount: Integer;
    function GetEnabledDictionary(
      Index: Integer): TdxCustomSpellCheckerDictionary;
    function GetEnabledDictionaryCount: Integer;
    function GetUserDictionary(Index: Integer): TdxUserSpellCheckerDictionary;
    function GetUserDictionaryCount: Integer;
    procedure SetAutoCorrectOptions(AValue: TdxSpellCheckerAutoCorrectOptions);
    procedure SetCheckAsYouTypeOptions(AValue: TdxSpellCheckerCheckAsYouTypeOptions);
    procedure SetDialogLookAndFeel(AValue: TcxLookAndFeel);
    procedure SetDictionaryItems(AValue: TdxSpellCheckerDictionaries);
    procedure SetMetaphoneDistance(AValue: Integer);
    procedure SetSpellingOptions(AValue: TdxSpellCheckerSpellingOptions);
  protected
    procedure AddToIgnoreList(const AWord: WideString); virtual;
    procedure CheckCallEnabledDictionariesLoaded;
    function CreateSimilarity: TdxStringSimilarityCalculator; virtual;
    function CreateSpellingOptions: TdxSpellCheckerSpellingOptions; virtual;
    function DoAddWord(AUserDictionary: TdxUserSpellCheckerDictionary;
      const AWord: WideString): Boolean; virtual;
    procedure DoAfterCheck; virtual;
    function DoAutoCorrect(ARule: TdxSpellCheckerAutoCorrectCustomRule;
      var AWordRange: TdxSpellCheckerAutoCorrectWordRange): Boolean; virtual;
    procedure DoAutoCorrectFinish(AControl: TWinControl); virtual;
    function DoAutoCorrectStart(AControl: TWinControl): Boolean; virtual;
    procedure DoBeforeCheck; virtual;
    procedure DoCheck(ADialogCheckMode: TdxSpellCheckerDialogCheckMode); virtual;
    procedure DoCheckAsYouTypeFinish(AControl: TWinControl); virtual;
    function DoCheckAsYouTypePopup(APopup: TComponent): Boolean; virtual;
    function DoCheckAsYouTypeStart(AControl: TWinControl): Boolean; virtual;
    procedure DoCheckContainer(AContainer: TWinControl; ARecursive: Boolean); virtual;
    function DoCheckControlInContainer(AControl: TWinControl; var AContinue: Boolean): Boolean; virtual;
    function DoCheckWord(const AWord: WideString; var AValid: Boolean): Boolean; virtual;
    procedure DoEnabledDictionariesLoaded; virtual;
    procedure DoGetSuggestions(const AWord: WideString; ASuggestions: TdxSpellCheckerSuggestionList); virtual;
    function DoSpellingComplete: Boolean; virtual;
    procedure BeginManualCheck;
    procedure EndManualCheck;
    function GetDialogCheckModeClass: TdxSpellCheckerCustomCheckModeClass; virtual;
    function GetWordChars: WideString; virtual;
    procedure InternalCheck(AAdapter: TdxSpellCheckerCustomEditAdapter); virtual;
    procedure LoadDictionariesDirect(AIgnoreDisabled: Boolean = True); virtual;
    procedure LoadDictionariesUsingThread(AIgnoreDisabled: Boolean = True); virtual;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SpellingComplete;
    procedure SpellingOptionsChanged; virtual;
    procedure ValidateRules(AParser: TdxSpellCheckerTextParser); virtual;
    procedure UpdateByDictionary(ADictionary: TdxCustomSpellCheckerDictionary); virtual;

    // IdxSpellChecker
    procedure CheckFinish;
    procedure CheckStart(AControl: TWinControl);
    procedure DrawMisspellings(AControl: TWinControl);
    function IsSpellCheckerDialogControl(AWnd: THandle): Boolean;
    procedure KeyPress(AKey: Char);
    function QueryPopup(APopup: TComponent; const P: TPoint): Boolean;
    procedure LayoutChanged(AControl: TWinControl);
    procedure SelectionChanged(AControl: TWinControl);
    procedure TextChanged(AControl: TWinControl);
    procedure Undo;
    // IdxSpellChecker2
    procedure KeyDown(AKey: Word; Shift: TShiftState);
    procedure KeyUp(AKey: Word; Shift: TShiftState);

    property AutoCorrectManager: TdxSpellCheckerCustomAutoCorrectManager read FAutoCorrectManager;
    property ChangeList: TdxSpellCheckerReplacementList read FChangeList;
    property CheckAsYouTypeManager: TdxSpellCheckerCustomCheckAsYouTypeManager read FCheckAsYouTypeManager;
    property CheckingContainer: Boolean read FCheckingContainer;
    property DeleteList: TdxSpellCheckerWordList read FDeleteList;
    property IgnoreList: TdxSpellCheckerWordList read FIgnoreList;
    property Languages: TdxSpellCheckerLanguages read FLanguages;
    property Similarity: TdxStringSimilarityCalculator read FSimilarity;
    property SuggestionCache: TdxSpellCheckerSuggestionCache read FSuggestionCache;
    property OnAddWord: TdxSpellCheckerAddWordEvent read FOnAddWord write FOnAddWord;
    property OnAfterCheck: TdxSpellCheckerEvent read FOnAfterCheck write FOnAfterCheck;
    property OnAutoCorrect: TdxSpellCheckerAutoCorrectEvent read FOnAutoCorrect write FOnAutoCorrect;
    property OnAutoCorrectFinish: TdxSpellCheckerCheckFinishEvent read FOnAutoCorrectFinish write FOnAutoCorrectFinish;
    property OnAutoCorrectStart: TdxSpellCheckerCheckStartEvent read FOnAutoCorrectStart write FOnAutoCorrectStart;
    property OnBeforeCheck: TdxSpellCheckerEvent read FOnBeforeCheck write FOnBeforeCheck;
    property OnCheckAsYouTypeFinish: TdxSpellCheckerCheckFinishEvent
      read FOnCheckAsYouTypeFinish write FOnCheckAsYouTypeFinish;
    property OnCheckAsYouTypePopup: TdxSpellCheckerCheckAsYouTypePopupEvent
      read FOnCheckAsYouTypePopup write FOnCheckAsYouTypePopup;
    property OnCheckAsYouTypeStart: TdxSpellCheckerCheckStartEvent
      read FOnCheckAsYouTypeStart write FOnCheckAsYouTypeStart;
    property OnCheckControlInContainer: TdxSpellCheckerCheckControlInContainerEvent
      read FOnCheckControlInContainer write FOnCheckControlInContainer;
    property OnCheckWord: TdxSpellCheckerCheckWordEvent read FOnCheckWord write FOnCheckWord;
    property OnEnabledDictionariesLoaded: TdxSpellCheckerEvent
      read FOnEnabledDictionariesLoaded write FOnEnabledDictionariesLoaded;
    property OnGetSuggestions: TdxSpellCheckerGetSuggestionsEvent
      read FOnGetSuggestions write FOnGetSuggestions;
    property OnSpellingComplete: TdxSpellCheckerSpellingComplete
      read FOnSpellingComplete write FOnSpellingComplete;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure Check(var AText: AnsiString); overload;
    procedure Check(var AText: WideString); overload;
    procedure Check(AEdit: TCustomEdit); overload;
    procedure Check(AEdit: TcxCustomTextEdit); overload;
    procedure CheckContainer(AContainer: TWinControl; ARecursive: Boolean);

    procedure AddWordToUserDictionary(const AWord: WideString);
    function FindDictionaryByWord(const AWord: WideString): TdxCustomSpellCheckerDictionary;
    function FindFirstEnabledUserDictionary: TdxUserSpellCheckerDictionary;
    function GetSuggestions(const AWord: WideString): TdxSpellCheckerSuggestionList;
    function HasWordInDictionaries(const AWord: WideString): Boolean;
    function HasEnabledUserDictionary: Boolean;
    function IsValidWord(const AWord: WideString): Boolean;
    procedure PopulateLanguages(AList: TStrings);
    procedure ShowSpellingCompleteMessage; virtual;

    procedure LoadDictionaries(AIgnoreDisabled: Boolean = True);
    procedure UnloadDictionaries;

    function GetTwoWordsDistance(const AWord1, AWord2: WideString): Integer;

    property ActiveDictionaries[Index: Integer]: TdxCustomSpellCheckerDictionary read GetActiveDictionary;
    property ActiveDictionaryCount: Integer read GetActiveDictionaryCount;
    property AutoCorrectOptions: TdxSpellCheckerAutoCorrectOptions read FAutoCorrectOptions write SetAutoCorrectOptions;
    property AutoLoadDictionaries: Boolean read FAutoLoadDictionaries write FAutoLoadDictionaries default False;
    property CheckMode: TdxSpellCheckerCustomCheckMode read GetCheckMode;
    property CheckAsYouTypeOptions: TdxSpellCheckerCheckAsYouTypeOptions read FCheckAsYouTypeOptions write SetCheckAsYouTypeOptions;
    property DialogLookAndFeel: TcxLookAndFeel read FDialogLookAndFeel write SetDialogLookAndFeel;
    property Dictionaries[Index: Integer]: TdxCustomSpellCheckerDictionary read GetDictionary;
    property DictionaryCount: Integer read GetDictionaryCount;
    property DictionaryItems: TdxSpellCheckerDictionaries read FDictionaryItems write SetDictionaryItems;
    property EnabledDictionaries[Index: Integer]: TdxCustomSpellCheckerDictionary read GetEnabledDictionary;
    property EnabledDictionaryCount: Integer read GetEnabledDictionaryCount;
    property MetaphoneDistance: Integer read FMetaphoneDistance write SetMetaphoneDistance default 3;
    property Rules: TdxSpellCheckerRules read FRules;
    property SpellingFormType: TdxSpellCheckerSpellingFormType read FSpellingFormType write FSpellingFormType default sftOutlook;
    property SpellingOptions: TdxSpellCheckerSpellingOptions read FSpellingOptions write SetSpellingOptions;
    property ThreadedLoadPriority: TThreadPriority read FThreadedLoadPriority write FThreadedLoadPriority default tpLower;
    property UserDictionaries[Index: Integer]: TdxUserSpellCheckerDictionary read GetUserDictionary;
    property UserDictionaryCount: Integer read GetUserDictionaryCount;
    property UseThreadedLoad: Boolean read FUseThreadedLoad write FUseThreadedLoad default False;
  end;

  { TdxSpellChecker }

  TdxSpellChecker = class(TdxCustomSpellChecker)
  published
    property AutoCorrectOptions;
    property AutoLoadDictionaries;
    property CheckAsYouTypeOptions;
    property DialogLookAndFeel;
    property DictionaryItems;
    property MetaphoneDistance;
    property SpellingFormType;
    property SpellingOptions;
    property ThreadedLoadPriority;
    property UseThreadedLoad;
    property OnAddWord;
    property OnAfterCheck;
    property OnAutoCorrect;
    property OnAutoCorrectFinish;
    property OnAutoCorrectStart;
    property OnBeforeCheck;
    property OnCheckAsYouTypeFinish;
    property OnCheckAsYouTypePopup;
    property OnCheckAsYouTypeStart;
    property OnCheckControlInContainer;
    property OnCheckWord;
    property OnEnabledDictionariesLoaded;
    property OnGetSuggestions;
    property OnSpellingComplete;
  end;

function GetRegisteredDictionaryTypes: TcxRegisteredClasses;

implementation

uses
  Dialogs, cxGeometry, dxOffice11, dxSpellCheckerStrs, dxSpellCheckerUtils,
  dxSpellCheckerDialogs, dxISpellDecompressor, dxSpellCheckerCheckAsYouType,
  dxHunspellDictionary,
{$IFDEF DELPHI12}
  AnsiStrings,
{$ENDIF}
  cxContainer, dxSpellCheckerAutoCorrect, dxSpellCheckerBaseForm,
  StrUtils, RTLConsts;

const
  dxCharToCharEntity: array [0..3, 0..1] of WideString = (
    ('&', '&amp;'),
    ('"', '&quot;'),
    ('<', '&lt;'),
    ('>', '&gt;'));

  dxBeforeSelectionChecked  =   1;
  dxSelectionChecked        =   2;
  dxAfterSelectionChecked   =   3;

var
  FRegisteredDictionaryTypes: TcxRegisteredClasses;

type
  TcxCustomTextEditPropertiesAccess = class(TcxCustomTextEditProperties);

  TdxXMLNodes = class;

  { TdxXMLNode }

  TdxXMLNode = class(TPersistent)
  private
    FAttributes: TStringList;
    FChildList: TdxXMLNodes;
    FNodeName: WideString;
    FNameSpaces: WideString;
    FValues: TStringList;
    function GetChildCount: Integer;
  protected
    function FindAttribute(const AName: WideString): Integer;
  public
    constructor Create; virtual;
    destructor Destroy; override;

    procedure Assign(Source: TPersistent); override;

    procedure AddAttribute(const AName, AValue: WideString);
    procedure AddChild(ANode: TdxXMLNode);
    function FindChild(const ANodeName: WideString): TdxXMLNode;
    procedure FromStr(const S: WideString; var APos: Integer);
    function GetValue(const AAttribute: WideString): WideString;
    function HasChild: Boolean;
    procedure SetAttribute(const AName, AValue: WideString);
    function ToStr: UTF8String;

    property Attributes: TStringList read FAttributes;
    property ChildCount: Integer read GetChildCount;
    property ChildList: TdxXMLNodes read FChildList;
    property NameSpaces: WideString read FNameSpaces write FNameSpaces;
    property NodeName: WideString read FNodeName write FNodeName;
    property Values: TStringList read FValues;
  end;

  { TdxXMLNodes }

  TdxXMLNodes = class(TcxObjectList)
  private
    function GetItem(Index: Integer): TdxXMLNode;
  public
    property Items[Index: Integer]: TdxXMLNode read GetItem; default;
  end;

  { TdxXMLDocument }

  TdxXMLDocument = class(TPersistent)
  private
    FEncoding: WideString;
    FNodes: TdxXMLNodes;
  public
    constructor Create; virtual;
    destructor Destroy; override;

    function FindNode(const ANodeName: WideString): TdxXMLNode;
    procedure LoadFromFile(const AFileName: WideString);
    procedure LoadFromStream(AStream: TStream);
    procedure SaveToFile(const AFileName: WideString);
    procedure SaveToStream(AStream: TStream);

    property Encoding: WideString read FEncoding write FEncoding;
    property Nodes: TdxXMLNodes read FNodes;
  end;

function GetRegisteredDictionaryTypes: TcxRegisteredClasses;
begin
  if FRegisteredDictionaryTypes = nil then
  begin
    FRegisteredDictionaryTypes := TcxRegisteredClasses.Create;
    FRegisteredDictionaryTypes.Sorted := True;
  end;
  Result := FRegisteredDictionaryTypes;
end;

procedure FreeRegisteredDictionaryTypes;
begin
  FreeAndNil(FRegisteredDictionaryTypes);
end;

procedure SpellCheckerCreatingError(APointer: Pointer);
begin
  raise EdxSpellCheckerException.Create(cxGetResourceString(APointer));
end;

procedure SkipSpace(const S: WideString; var APos: Integer);
var
  ALen: Integer;
begin
  ALen := Length(S);
  while (APos < ALen) and WideIsSpace(S[APos]) do
    Inc(APos);
end;

function GetNextPart(const S: WideString; var APos: Integer;
  ADelimiter: WideChar; ACanBeSpace: Boolean = True): WideString;
var
  ALen: Integer;
begin
  ALen := Length(S);
  Result := '';
  while (APos < ALen) and not ((ADelimiter = S[APos]) or
    (ACanBeSpace and WideIsSpace(S[APos]))) do
  begin
    Result := Result + S[APos];
    Inc(APos);
  end;
  if ALen > APos then
    Inc(APos);
end;

function XMLValueToValue(const S: WideString): WideString;

  function ReplaceCharEntry: WideString;
  var
    I: Integer;
  begin
    Result := S;
    for I := 0 to 3 do
      Result := AnsiReplaceText(Result, dxCharToCharEntity[I, 1], dxCharToCharEntity[I, 0]);
  end;

  function WideNextPos(ABeginPos: Integer; const ASubStr, S: WideString): Integer;
  begin
    Result := WidePos(ASubStr, Copy(S, ABeginPos, Length(S) - ABeginPos + 1));
    if Result > 0 then
      Result := Result + ABeginPos - 1;
  end;

var
  APos: Integer;
  ATmp: WideString;
  AChar: WideChar;
  AOldPos: Integer;
begin
  Result := ReplaceCharEntry;
  APos := WidePos('&', Result);
  while APos > 0 do
  begin
    AOldPos := APos;
    Inc(APos);
    ATmp := GetNextPart(Result, APos, ';', False);
    if Length(ATmp) > 0 then
    begin
      if ATmp[1] = '#' then
      begin
        AChar := WideChar(StrToInt(Copy(ATmp, 2, Length(ATmp) - 1)));
        ATmp := Result;
        Result := Copy(ATmp, 1, AOldPos - 1) + AChar;
        if APos <= Length(ATmp) then
          Result := Result + Copy(ATmp, APos, Length(ATmp) - APos + 1);
      end;
      APos := AOldPos + 1;
    end;
    APos := WideNextPos(APos, '&', Result);
  end;
end;

function ValueToXMLValue(const S: WideString): UTF8String;
var
  I: Integer;
  AStr: WideString;
begin
  AStr := S;
  for I := 0 to 3 do
    AStr := AnsiReplaceText(AStr, dxCharToCharEntity[I, 0], dxCharToCharEntity[I, 1]);
  Result := UTF8Encode(AStr);
end;

{ TdxXMLNode }

constructor TdxXMLNode.Create;
begin
  inherited Create;
  FAttributes := TStringList.Create;
  FChildList := TdxXMLNodes.Create;
  FValues := TStringList.Create;
end;

destructor TdxXMLNode.Destroy;
begin
  FreeAndNil(FAttributes);
  FreeAndNil(FValues);
  FreeAndNil(FChildList);
  inherited Destroy;
end;

procedure TdxXMLNode.Assign(Source: TPersistent);
var
  I: Integer;
  ANode: TdxXMLNode;
begin
  if Source is TdxXMLNode then
    with TdxXMLNode(Source) do
    begin
      Self.Attributes.Clear;
      for I := 0 to Attributes.Count - 1 do
        Self.Attributes.Add(Attributes[I]);
      Self.Values.Clear;
      for I := 0 to Values.Count - 1 do
        Self.Values.Add(Values[I]);
      Self.ChildList.Clear;
      for I := 0 to ChildList.Count - 1 do
      begin
        ANode := TdxXMLNode.Create;
        ANode.Assign(ChildList[I]);
        Self.ChildList.Add(ANode);
      end;
      Self.FNodeName := NodeName;
      Self.FNameSpaces := NameSpaces;
    end;
  inherited Assign(Source);
end;

procedure TdxXMLNode.AddAttribute(const AName, AValue: WideString);
var
  AIndex: Integer;
begin
  AIndex := FindAttribute(AName);
  if AIndex = -1 then
  begin
    Attributes.Add(AName);
    Values.Add('');
    SetAttribute(AName, AValue);
  end
  else
    AddAttribute(AName, AValue);
end;

procedure TdxXMLNode.AddChild(ANode: TdxXMLNode);
begin
  ChildList.Add(ANode);
end;

function TdxXMLNode.FindChild(const ANodeName: WideString): TdxXMLNode;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to ChildList.Count - 1 do
    if WideCompareText(ChildList[I].NodeName, ANodeName) = 0 then
    begin
      Result := ChildList[I];
      Break;
    end;
end;

procedure TdxXMLNode.FromStr(const S: WideString; var APos: Integer);

  procedure ParseChild;
  var
    ANode: TdxXMLNode;
    ALen: Integer;
    ATmp: WideString;
  begin
    ALen := Length(S);
    SkipSpace(S, APos);
    ATmp := GetNextPart(S, APos, '<', False);
    if (ALen > APos) and (Length(ATmp) > 0) then
      SpellCheckerCreatingError(@sdxSpellCheckerFileFormatMismatch);
    while (APos < ALen) and (S[APos] <> '/') do
    begin
      ANode := TdxXMLNode.Create;
      Dec(APos);
      ANode.FromStr(S, APos);
      AddChild(ANode);
      SkipSpace(S, APos);
      GetNextPart(S, APos, '<', False);
    end;
    Inc(APos);
    if WideCompareText(GetNextPart(S, APos, '>', False), NodeName) <> 0 then
      SpellCheckerCreatingError(@sdxSpellCheckerFileFormatMismatch);
  end;

var
  ATmp: WideString;
  AAttribute, AValue: WideString;
  ANodeString: WideString;
  ANodePos: Integer;
  ALen: Integer;
  AHasChild: Boolean;
begin
  SkipSpace(S, APos);
  ATmp := GetNextPart(S, APos, '<', False);
  if Length(ATmp) > 0 then
    SpellCheckerCreatingError(@sdxSpellCheckerFileFormatMismatch);
  NodeName := GetNextPart(S, APos, ' ');
  SkipSpace(S, APos);
  ANodeString := GetNextPart(S, APos, '>', False);
  ALen := Length(ANodeString);
  ANodePos := 1;
  AHasChild := False;
  while ALen > ANodePos do
  begin
    SkipSpace(ANodeString, ANodePos);
    if ANodePos < ALen then
    begin
      SkipSpace(ANodeString, ANodePos);
      if ANodePos <= ALen then
      begin
        AAttribute := GetNextPart(ANodeString, ANodePos, '=');
        AddAttribute(AAttribute, '');
        SkipSpace(ANodeString, ANodePos);
        GetNextPart(ANodeString, ANodePos, '"', False);
        SkipSpace(ANodeString, ANodePos);
        AValue := XMLValueToValue(GetNextPart(ANodeString, ANodePos, '"', False));
        SetAttribute(AAttribute, AValue);
        SkipSpace(ANodeString, ANodePos);
      end;
      SkipSpace(ANodeString, ANodePos);
      if ANodeString[ANodePos] = '/' then
      begin
        if ANodePos <> ALen then
          SpellCheckerCreatingError(@sdxSpellCheckerFileFormatMismatch);
      end
      else
        AHasChild := ANodePos = ALen;
    end;
  end;
  if AHasChild then
    ParseChild;
end;

function TdxXMLNode.GetValue(const AAttribute: WideString): WideString;
var
  AIndex: Integer;
begin
  Result := '';
  AIndex := FindAttribute(AAttribute);
  if AIndex >= 0 then
    Result := Values[AIndex];
end;

function TdxXMLNode.HasChild: Boolean;
begin
  Result := ChildList.Count > 0;
end;

procedure TdxXMLNode.SetAttribute(const AName, AValue: WideString);
var
  AIndex: Integer;
begin
  AIndex := FindAttribute(AName);
  if AIndex > -1 then
    Values[AIndex] := AValue
  else
    AddAttribute(AName, AValue);
end;

function TdxXMLNode.ToStr: UTF8String;
var
  I: Integer;
begin
  Result := '<' + dxWideStringToUTF8String(NodeName);
  if Length(NameSpaces) > 0 then
    Result := Result + ' xmlns:block-list="' + dxWideStringToUTF8String(NameSpaces) + '"';
  for I := 0 to Attributes.Count - 1 do
    Result := Result + ' ' + dxWideStringToUTF8String(Attributes[I]) + '="' + ValueToXMLValue(Values[I]) + '"';
  if HasChild then
  begin
    Result := Result + '>';
    for I := 0 to ChildList.Count - 1 do
      Result := Result + ChildList[I].ToStr;
    Result := Result + '</' + dxWideStringToUTF8String(NodeName) + '>';
  end
  else
    Result := Result + '/>';
end;

function TdxXMLNode.FindAttribute(const AName: WideString): Integer;
begin
  for Result := 0 to Attributes.Count - 1 do
    if WideCompareText(AName, Attributes[Result]) = 0 then
      Exit;
  Result := -1;
end;

function TdxXMLNode.GetChildCount: Integer;
begin
  Result := ChildList.Count;
end;

{ TdxXMLNodes }

function TdxXMLNodes.GetItem(Index: Integer): TdxXMLNode;
begin
  Result := TdxXMLNode(inherited Items[Index]);
end;

{ TdxXMLDocument }

constructor TdxXMLDocument.Create;
begin
  inherited Create;
  FNodes := TdxXMLNodes.Create;
end;

destructor TdxXMLDocument.Destroy;
begin
  FreeAndNil(FNodes);
  inherited Destroy;
end;

function TdxXMLDocument.FindNode(const ANodeName: WideString): TdxXMLNode;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to Nodes.Count - 1 do
    if WideCompareText(Nodes[I].NodeName, ANodeName) = 0 then
    begin
      Result := Nodes[I];
      Break;
    end;
end;

procedure TdxXMLDocument.LoadFromFile(const AFileName: WideString);
var
  AStream: TStream;
begin
  AStream := TFileStream.Create(AFileName, fmOpenRead or fmShareDenyWrite);
  try
    LoadFromStream(AStream);
  finally
    AStream.Free;
  end;
end;

procedure TdxXMLDocument.LoadFromStream(AStream: TStream);

  function SkipStandartPart(const S, APart: WideString; var APos: Integer): Boolean;
  begin
    Result := False;
    SkipSpace(S, APos);
    if Pos(APart, S) <> APos then
      Exit;
    Inc(APos, Length(APart));
    Result := True;
  end;

var
  AXMLText: UTF8String;
  AStr: WideString;
  APos: Integer;
  ARootNode: TdxXMLNode;
begin
  AStream.Position := 0;
  SetLength(AXMLText, AStream.Size - AStream.Position);
  AStream.Read(AXMLText[1], AStream.Size - AStream.Position);
  AStr := dxUTF8StringToWideString(AXMLText);
  APos := 1;
  SkipSpace(AStr, APos);
  if not SkipStandartPart(AStr, '<?xml', APos) then
    SpellCheckerCreatingError(@sdxSpellCheckerFileFormatMismatch);
  if not SkipStandartPart(AStr, 'version="1.0"', APos) then
    SpellCheckerCreatingError(@sdxSpellCheckerFileFormatMismatch);
  if not SkipStandartPart(AStr, 'encoding="', APos) then
    SpellCheckerCreatingError(@sdxSpellCheckerFileFormatMismatch);
  Encoding := GetNextPart(AStr, APos, '"', False);
  if not SkipStandartPart(AStr, '?>', APos) then
    SpellCheckerCreatingError(@sdxSpellCheckerFileFormatMismatch);
  SkipSpace(AStr, APos);
  ARootNode := TdxXMLNode.Create;
  ARootNode.FromStr(AStr, APos);
  Nodes.Add(ARootNode);
end;

procedure TdxXMLDocument.SaveToFile(const AFileName: WideString);
var
  AStream: TStream;
begin
  AStream := TFileStream.Create(AFileName, fmCreate);
  try
    SaveToStream(AStream);
  finally
    AStream.Free;
  end;
end;

procedure TdxXMLDocument.SaveToStream(AStream: TStream);
var
  S: UTF8String;
  I: Integer;
begin
  if Length(Encoding) > 0 then
  begin
    S := '<?xml version="1.0" encoding="' + dxWideStringToUTF8String(Encoding) + '"?>';
    AStream.Write(Pointer(S)^, Length(S));
  end;
  for I := 0 to Nodes.Count - 1 do
  begin
    S := Nodes[I].ToStr;
    AStream.Write(Pointer(S)^, Length(S));
  end;
end;

{ TdxSpellCheckerPersistent }

constructor TdxSpellCheckerPersistent.Create(ASpellChecker: TdxCustomSpellChecker);
begin
  inherited Create;
  FSpellChecker := ASpellChecker;
end;

{ TdxSpellCheckerLanguages }

var
  FTmpLanguages: TdxSpellCheckerLanguages;

procedure InternalEnumLanguages(ALocaleID: PChar); stdcall;
begin
  FTmpLanguages.LocalesCallback(ALocaleID);
end;

constructor TdxSpellCheckerLanguages.Create;
begin
  inherited;
  FTmpLanguages := Self;
  EnumSystemLocales(@InternalEnumLanguages, LCID_SUPPORTED);
end;

function TdxSpellCheckerLanguages.GetDefaultLanguageLCID: DWORD;
begin
  Result := GetSystemDefaultLCID;
end;

function TdxSpellCheckerLanguages.GetLCID(const AName: string): DWORD;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to Count - 1 do
  begin
    if AnsiCompareText(AName, Name[I]) = 0 then
    begin
      Result := LocaleID[I];
      Break;
    end;
  end;
end;

function TdxSpellCheckerLanguages.IndexOf(ID: LCID): Integer;
begin
  for Result := Low(FSysLangs) to High(FSysLangs) do
    if FSysLangs[Result].FLCID = ID then Exit;
  Result := -1;
end;

function TdxSpellCheckerLanguages.LocalesCallback(LocaleID: PChar): Integer; stdcall;
var
  AID: LCID;
  AShortLangName: string;
begin
  AID := StrToInt('$' + Copy(LocaleID, 5, 4));
  AShortLangName := dxGetLocaleInfo(AID, LOCALE_SABBREVLANGNAME, '');
  if AShortLangName <> '' then
  begin
    SetLength(FSysLangs, Length(FSysLangs) + 1);
    with FSysLangs[High(FSysLangs)] do
    begin
      FName := dxGetLocaleInfo(AID, LOCALE_SLANGUAGE, '');
      FLCID := AID;
      FExt := AShortLangName;
    end;
  end;
  Result := 1;
end;

function TdxSpellCheckerLanguages.GetCount: integer;
begin
  Result := High(FSysLangs) + 1;
end;

function TdxSpellCheckerLanguages.GetExt(Index: Integer): string;
begin
  Result := FSysLangs[Index].FExt;
end;

function TdxSpellCheckerLanguages.GetID(Index: Integer): string;
begin
  Result := HexDisplayPrefix + IntToHex(FSysLangs[Index].FLCID, 8);
end;

function TdxSpellCheckerLanguages.GetLocaleID(Index: Integer): LCID;
begin
  Result := FSysLangs[Index].FLCID;
end;

function TdxSpellCheckerLanguages.GetName(Index: Integer): string;
begin
  Result := FSysLangs[Index].FName;
end;

function TdxSpellCheckerLanguages.GetNameFromLocaleID(ID: LCID): string;
var
  AIndex: Integer;
begin
  Result := sdxSpellCheckerUnknown;
  AIndex := IndexOf(ID);
  if AIndex <> - 1 then Result := Name[AIndex];
  if Result = '' then Result := sdxSpellCheckerUnknown;
end;

function TdxSpellCheckerLanguages.GetNameFromLCID(const ID: string): string;
begin
  Result := NameFromLocaleID[StrToIntDef(ID, 0)];
end;

{ TdxSpellCheckerSuggestion }

constructor TdxSpellCheckerSuggestion.Create(const AWord: WideString;
  ADictionary: TdxCustomSpellCheckerDictionary; ADistance: Integer);
begin
  inherited Create;
  FDictionary := ADictionary;
  FWord := AWord;
  FDistance := ADistance;
end;

{ TdxSpellCheckerSuggestionList }

procedure TdxSpellCheckerSuggestionList.Add(const AWord: WideString;
  ADictionary: TdxCustomSpellCheckerDictionary; ADistance: Integer);
var
  AItem: TdxSpellCheckerSuggestion;
begin
  AItem := TdxSpellCheckerSuggestion.Create(AWord, ADictionary, ADistance);
  AItem.FOrder := Count;
  inherited Add(AItem);
end;

procedure TdxSpellCheckerSuggestionList.Assign(
  ASuggestions: TdxSpellCheckerSuggestionList);
var
  I: Integer;
  AItem: TdxSpellCheckerSuggestion;
begin
  Clear;
  for I := 0 to ASuggestions.Count - 1 do
  begin
    AItem := ASuggestions[I];
    Add(AItem.Word, AItem.Dictionary, AItem.Distance);
  end;
end;

procedure TdxSpellCheckerSuggestionList.Delete(AIndex: Integer);
begin
  Items[AIndex].Free;
  inherited Delete(AIndex);
end;

procedure TdxSpellCheckerSuggestionList.FixCapitalization(const AMask: WideString);
var
  I: Integer;
begin
  if Length(AMask) = 0 then Exit;
  case GetWordCapitalizationType(AMask) of
//    ctLower:
//      for I := 0 to Count - 1 do
//        with Items[I] do
//          FWord := WideLowerCase(FWord);
    ctUpper:
      for I := 0 to Count - 1 do
        with Items[I] do
          FWord := WideUpperCase(FWord);
    ctCapitalized:
      for I := 0 to Count - 1 do
        with Items[I] do
          if Length(FWord) > 0 then
            FWord[1] := WideUpperCase(FWord[1])[1];
  end;
end;

procedure TdxSpellCheckerSuggestionList.Insert(AIndex: Integer; const AWord: WideString;
  ADictionary: TdxCustomSpellCheckerDictionary; ADistance: Integer);
var
  AItem: TdxSpellCheckerSuggestion;
begin
  AItem := TdxSpellCheckerSuggestion.Create(AWord, ADictionary, ADistance);
  AItem.FOrder := Count;
  inherited Insert(AIndex, AItem);
end;

procedure TdxSpellCheckerSuggestionList.RemoveDuplicates;
var
  I: Integer;
begin
  SortByWord;
  I := 1;
  while I < Count do
  begin
    while (I < Count) and WideSameStr(Items[I].Word, Items[I - 1].Word) do
      Delete(I);
    Inc(I);
  end;
  SortByDistance;
end;

procedure TdxSpellCheckerSuggestionList.SaveToStrings(AStrings: TStrings);
var
  I: Integer;
begin
  AStrings.BeginUpdate;
  try
    AStrings.Clear;
    for I := 0 to Count - 1 do
      AStrings.AddObject(Items[I].Word, Pointer(Items[I].Distance));
  finally
    AStrings.EndUpdate;
  end;
end;

function CompareSuggestionsByDistance(Item1, Item2: Pointer): Integer;
begin
  Result := TdxSpellCheckerSuggestion(Item1).Distance - TdxSpellCheckerSuggestion(Item2).Distance;
  if Result = 0 then
    Result := TdxSpellCheckerSuggestion(Item1).FOrder - TdxSpellCheckerSuggestion(Item2).FOrder;
end;

procedure TdxSpellCheckerSuggestionList.SortByDistance;
begin
  Sort(CompareSuggestionsByDistance);
end;

{
function CompareSuggestionsByWord(Item1, Item2: Pointer): Integer;
var
  AAlphabet: WideString;
  ALen, I: Integer;
  AWord1, AWord2: WideString;
begin
  AWord1 := TdxSpellCheckerSuggestion(Item1).Word;
  AWord2 := TdxSpellCheckerSuggestion(Item2).Word;
  Result := Length(AWord2) - Length(AWord1);
  if Result = 0 then
  begin
    AAlphabet := TdxSpellCheckerSuggestion(Item1).Dictionary.Alphabet;
    ALen := Length(AWord1);
    for I := 1 to ALen do
    begin
      Result := WideCharPos(AWord2[I], AAlphabet) - WideCharPos(AWord1[I], AAlphabet);
      if Result <> 0 then
        Break;
    end;
  end;
end;
}

function CompareSuggestionsByWord(Item1, Item2: Pointer): Integer;
begin
  Result := WideCompareText(TdxSpellCheckerSuggestion(Item1).Word, TdxSpellCheckerSuggestion(Item2).Word);
  if Result = 0 then
    Result := TdxSpellCheckerSuggestion(Item1).FOrder - TdxSpellCheckerSuggestion(Item2).FOrder;
end;

procedure TdxSpellCheckerSuggestionList.SortByWord;
begin
  Sort(CompareSuggestionsByWord);
end;

function TdxSpellCheckerSuggestionList.GetItem(
  Index: Integer): TdxSpellCheckerSuggestion;
begin
  Result := TdxSpellCheckerSuggestion(inherited Items[Index]);
end;

{ TdxSpellCheckerSuggestionCacheItem }

constructor TdxSpellCheckerSuggestionCacheItem.Create(const AWord: WideString;
  ASuggestions: TdxSpellCheckerSuggestionList);
begin
  inherited Create;
  FSuggestions := TdxSpellCheckerSuggestionList.Create;
  FSuggestions.Assign(ASuggestions);
  FWord := AWord;
end;

destructor TdxSpellCheckerSuggestionCacheItem.Destroy;
begin
  FreeAndNil(FSuggestions);
  inherited Destroy;
end;

procedure TdxSpellCheckerSuggestionCacheItem.GetSuggestions(
  ASuggestions: TdxSpellCheckerSuggestionList);
begin
  Inc(FRefCount);
  ASuggestions.Assign(FSuggestions);
end;

{ TdxSpellCheckerSuggestionCache }

constructor TdxSpellCheckerSuggestionCache.Create(AMaxCapacity: Integer);
begin
  inherited Create;
  FMaxCapacity := AMaxCapacity;
  Capacity := AMaxCapacity;
end;

procedure TdxSpellCheckerSuggestionCache.Add(const AWord: WideString;
  ASuggestions: TdxSpellCheckerSuggestionList);
var
  AItem: TdxSpellCheckerSuggestionCacheItem;
  AIndex: Integer;
begin
  if Count = FMaxCapacity then
  begin
    AIndex := GetRareItemIndex;
    with Items[AIndex] do
    begin
      FWord := AWord;
      FRefCount := 0;
      FSuggestions.Assign(ASuggestions);
    end;
  end
  else
  begin
    AItem := TdxSpellCheckerSuggestionCacheItem.Create(AWord, ASuggestions);
    inherited Add(AItem);
  end;
end;

function TdxSpellCheckerSuggestionCache.Find(
  const AWord: WideString): TdxSpellCheckerSuggestionCacheItem;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
  begin
    Result := Items[I];
    if WideCompareStr(Result.Word, AWord) = 0 then
      Exit;
  end;
  Result := nil;
end;

function TdxSpellCheckerSuggestionCache.GetItem(
  Index: Integer): TdxSpellCheckerSuggestionCacheItem;
begin
  Result := TdxSpellCheckerSuggestionCacheItem(inherited Items[Index]);
end;

function TdxSpellCheckerSuggestionCache.GetRareItemIndex: Integer;
var
  I, AValue: Integer;
begin
  Result := 0;
  AValue := MaxInt;
  for I := 0 to Count - 1 do
  begin
    if Items[I].RefCount < AValue then
    begin
      AValue := Items[I].RefCount;
      Result := I;
      if AValue = 0 then
        Exit;
    end;
  end;
end;

function TdxSpellCheckerSuggestionCache.GetSuggestions(const AWord: WideString;
  ASuggestions: TdxSpellCheckerSuggestionList): Boolean;
var
  AItem: TdxSpellCheckerSuggestionCacheItem;
begin
  AItem := Find(AWord);
  Result := AItem <> nil;
  if Result then
    AItem.GetSuggestions(ASuggestions);
end;

procedure TdxSpellCheckerSuggestionCache.Reset;
begin
  Clear;
end;

{ TdxSpellCheckerReplacement }

constructor TdxSpellCheckerReplacement.Create(
  const AText, AReplacement: WideString);
begin
  inherited Create;
  FText := AText;
  FReplacement := AReplacement;
end;

procedure TdxSpellCheckerReplacement.ChangeReplacement(const S: WideString);
begin
  FReplacement := S;
end;

{ TdxSpellCheckerReplacementList }

constructor TdxSpellCheckerReplacementList.Create(AllowDuplicates: Boolean = False);
begin
  inherited Create;
  Capacity := 256;
  FAllowDuplicates := AllowDuplicates;
end;

procedure TdxSpellCheckerReplacementList.Add(
  const AText, AReplacement: WideString);
var
  AItem: TdxSpellCheckerReplacement;
begin
  if FAllowDuplicates then
    inherited Add(TdxSpellCheckerReplacement.Create(AText, AReplacement))
  else
  begin
    AItem := FindReplacement(AText);
    if AItem = nil then
    begin
      inherited Add(TdxSpellCheckerReplacement.Create(AText, AReplacement));
      SortByText;
    end
    else
      AItem.FReplacement := AReplacement;
  end;
end;

function TdxSpellCheckerReplacementList.FindReplacement(
  const AText: WideString): TdxSpellCheckerReplacement;
var
  L, H, I, C: Integer;
begin
  Result := nil;
  L := 0;
  H := Count - 1;
  while L <= H do
  begin
    I := (L + H) shr 1;
    C := WideCompareText(TdxSpellCheckerReplacement(List^[I]).Text, AText);
    if C < 0 then
      L := I + 1
    else
    begin
      H := I - 1;
      if C = 0 then
      begin
        Result := TdxSpellCheckerReplacement(List^[I]);
        Break;
      end;
    end;
  end;
end;

function TdxSpellCheckerReplacementList.GetItem(
  Index: Integer): TdxSpellCheckerReplacement;
begin
  Result := TdxSpellCheckerReplacement(inherited Items[Index]);
end;

function CompareReplacementByText(Item1, Item2: Pointer): Integer;
begin
  Result := WideCompareText(TdxSpellCheckerReplacement(Item1).Text,
    TdxSpellCheckerReplacement(Item2).Text);
end;

procedure TdxSpellCheckerReplacementList.SortByText;
begin
  Sort(CompareReplacementByText);
end;

{ TdxSpellCheckerCustomEditAdapter }

constructor TdxSpellCheckerCustomEditAdapter.Create(AEdit: TWinControl);
begin
  inherited Create;
  FEdit := AEdit;
  FNeedImmediatePost := (AEdit <> nil) and not AEdit.Focused;
end;

procedure TdxSpellCheckerCustomEditAdapter.ClearSelection;
begin
  SelText := '';
end;

procedure TdxSpellCheckerCustomEditAdapter.GetSpellingBounds(
  out ASpellingStart, ASpellingEnd: Integer);
begin
  ASpellingStart := 1;
  if EditorHandleAllocated then
    ASpellingEnd := SendMessageW(EditorHandle, WM_GETTEXTLENGTH, 0, 0) + 1
  else
    ASpellingEnd := Length(FText);
end;

function TdxSpellCheckerCustomEditAdapter.EditorHandleAllocated: Boolean;
begin
  Result := (FEdit <> nil) and FEdit.HandleAllocated
end;

function TdxSpellCheckerCustomEditAdapter.GetEditorHandle: THandle;
begin
  if EditorHandleAllocated then
    Result := FEdit.Handle
  else
    Result := 0;
end;

function TdxSpellCheckerCustomEditAdapter.GetText: WideString;
var
  ALen: Integer;
  ATemp: AnsiString;
begin
  if EditorHandleAllocated then
  begin
    if IsWindowUnicode(EditorHandle) then
    begin
      ALen := SendMessageW(EditorHandle, WM_GETTEXTLENGTH, 0, 0) + 1;
      SetLength(FText, ALen);
      GetWindowTextW(EditorHandle, Pointer(FText), ALen);
    end
    else
    begin
      ALen := SendMessageA(EditorHandle, WM_GETTEXTLENGTH, 0, 0) + 1;
      SetLength(ATemp, ALen);
      GetWindowTextA(EditorHandle, Pointer(ATemp), ALen);
      FText := dxAnsiStringToWideString(ATemp);
    end;
  end;
  Result := FText;
end;

procedure TdxSpellCheckerCustomEditAdapter.Post(AUpdateValue: Boolean = True);
var
  AEdit: IdxSpellCheckerControl;
begin
  if Supports(GetInnerControlContainer(FEdit), IdxSpellCheckerControl, AEdit) and
    AUpdateValue and not EditorHandleAllocated then
  begin
    FText := PWideChar(FText);
    AEdit.SetValue(FText);
  end;
end;

function TdxSpellCheckerCustomEditAdapter.IsInplace: Boolean;
var
  AContainer: TcxCustomEdit;
begin
  AContainer := TcxCustomEdit(GetInnerControlContainer(FEdit));
  Result := (AContainer <> nil) and AContainer.IsInplace;
end;

{ TdxSpellCheckercxTextEditAdapter }

function TdxSpellCheckercxTextEditAdapter.GetHideSelection: Boolean;
begin
  Result := Edit.Properties.HideSelection;
end;

function TdxSpellCheckercxTextEditAdapter.GetReadOnly: Boolean;
begin
  Result := Edit.Properties.ReadOnly;
end;

function TdxSpellCheckercxTextEditAdapter.GetSelLength: Integer;
begin
  Result := Edit.SelLength;
end;

function TdxSpellCheckercxTextEditAdapter.GetSelStart: Integer;
begin
  Result := Edit.SelStart
end;

function TdxSpellCheckercxTextEditAdapter.GetSelText: string;
begin
  Result := Edit.SelText
end;

procedure TdxSpellCheckercxTextEditAdapter.SetHideSelection(AValue: Boolean);
begin
  TcxCustomTextEditPropertiesAccess(Edit.Properties).HideSelection := AValue;
end;

procedure TdxSpellCheckercxTextEditAdapter.SetSelLength(AValue: Integer);
begin
  Edit.SelLength := AValue;
end;

procedure TdxSpellCheckercxTextEditAdapter.SetSelStart(AValue: Integer);
begin
  Edit.SelStart := AValue;
end;

procedure TdxSpellCheckercxTextEditAdapter.SetSelText(const AValue: string);
var
  AIntf: IdxSpellCheckerControl;
begin
  if Supports(Edit, IdxSpellCheckerControl, AIntf) then
    AIntf.SetSelText(AValue, FNeedImmediatePost)
  else
    Edit.SelText := AValue;
end;

function TdxSpellCheckercxTextEditAdapter.GetEdit: TcxCustomTextEdit;
begin
  Result := TcxCustomTextEdit(inherited Edit);
end;

{ TdxSpellCheckercxRichEditAdapter }

function TdxSpellCheckercxRichEditAdapter.GetReadOnly: Boolean;
begin
  Result := Edit.ActiveProperties.ReadOnly;
end;

function TdxSpellCheckercxRichEditAdapter.GetText: WideString;
var
  ASource, ADest: WideString;
  ALen: Integer;
begin
  ASource := inherited GetText;
  ALen := Length(ASource);
  SetLength(ADest, ALen);
  ALen := AdjustRichLineBreaksW(PWideChar(ADest), PWideChar(ASource),
    Edit.RichVersion >= 200);
  SetLength(ADest, ALen);
  Result := ADest;
end;

function TdxSpellCheckercxRichEditAdapter.GetEdit: TcxCustomRichEdit;
begin
  Result := TcxCustomRichEdit(inherited Edit);
end;

{ TdxSpellCheckerEditAdapter }

function TdxSpellCheckerEditAdapter.GetHideSelection: Boolean;
begin
  if FEdit is TMemo then
    Result := TMemo(FEdit).HideSelection
  else
    if FEdit is TEdit then
      Result := TEdit(FEdit).HideSelection
    else
      if FEdit is TcxCustomRichEdit then
        Result := True
      else
        Result := False;
end;

function TdxSpellCheckerEditAdapter.GetReadOnly: Boolean;
begin
  Result := TEdit(FEdit).ReadOnly;
end;

function TdxSpellCheckerEditAdapter.GetSelLength: Integer;
begin
  if EditorHandleAllocated then
    Result := Edit.SelLength
  else
    Result := FSelLength;
end;

function TdxSpellCheckerEditAdapter.GetSelStart: Integer;
begin
  if EditorHandleAllocated then
    Result := Edit.SelStart
  else
    Result := FSelStart;
end;

function TdxSpellCheckerEditAdapter.GetSelText: string;
begin
  if EditorHandleAllocated then
    Result := Edit.SelText
  else
    Result := Copy(FText, FSelStart, FSelLength);
end;

procedure TdxSpellCheckerEditAdapter.SetHideSelection(AValue: Boolean);
begin
  if FEdit is TMemo then
    TMemo(FEdit).HideSelection := AValue
  else
    if FEdit is TEdit then
      TEdit(FEdit).HideSelection := AValue;
end;

procedure TdxSpellCheckerEditAdapter.SetSelLength(AValue: Integer);
begin
  if EditorHandleAllocated then
    Edit.SelLength := AValue;
  FSelLength := AValue;
end;

procedure TdxSpellCheckerEditAdapter.SetSelStart(AValue: Integer);
begin
  if EditorHandleAllocated then
    Edit.SelStart := AValue;
  FSelStart := AValue;
end;

procedure TdxSpellCheckerEditAdapter.SetSelText(const AValue: string);
var
  AContainer: TWinControl;
  AIntf: IdxSpellCheckerControl;
begin
  FText := Copy(FText, 1, FSelStart) + AValue + Copy(FText, FSelStart + FSelLength + 1, Length(FText) - FSelStart - FSelLength);
  if EditorHandleAllocated then
  begin
    AContainer := GetInnerControlContainer(Edit);
    if Supports(TObject(AContainer), IdxSpellCheckerControl, AIntf) then
      AIntf.SetSelText(AValue, FNeedImmediatePost)
    else
      Edit.SelText := AValue;
  end;
end;

function TdxSpellCheckerEditAdapter.GetEdit: TCustomEdit;
begin
  Result := TCustomEdit(inherited Edit);
end;

{ TdxSpellCheckerTextAdapter }

constructor TdxSpellCheckerTextAdapter.Create(const AText: WideString);
begin
  inherited Create(nil);
  FText := AText + #0;
end;

{ TdxSpellCheckerTextParser }

constructor TdxSpellCheckerTextParser.Create(ASpellChecker: TdxCustomSpellChecker);
begin
  inherited Create;
  FSpellChecker  := ASpellChecker;
  FDelimiters    := #0#9#10#11#13#32'.,<>=!?:;"()[]{}+|-/\'#$201C#$201D;
  FUrlDelimiters := #0#9#10#11#13#32',<>!;()[]{}|';
  FText := #0;
  FMeaningfulCharacters := SpellChecker.GetWordChars;
end;

function TdxSpellCheckerTextParser.GetNextWord(var AStart, ALength: Integer; out ADelimiters: WideString): WideString;

  procedure SkipFirstDelimiters;
  begin
    if (AStart <= FSpellingEnd) and WideIsSpace(FText[AStart]) then
      while (AStart < FSpellingEnd) and WideIsSpace(FText[AStart]) do
      begin
        ADelimiters := ADelimiters + FText[AStart];
        Inc(AStart);
      end
    else
      while (AStart < FSpellingEnd) and not (WideIsAlphaNumeric(FText[AStart]) or IsMeaningfulCharacters(FText[AStart])) do
      begin
        ADelimiters := ADelimiters + FText[AStart];
        Inc(AStart);
      end;
  end;

var
  APos: Integer;
  APreDelimiters: WideString;
begin
  ADelimiters := '';
  SkipFirstDelimiters;
  ALength := 0;
  APos := AStart;
  while (APos < FSpellingEnd) and not WideIsSpace(FText[APos]) do
    Inc(APos);
  ALength := APos - AStart;
  if ALength = 0 then
    Result := ''
  else
  begin
    Result := Copy(FText, AStart, ALength);
    if ((Length(ADelimiters) = 0) or LastWideCharIsSpace(ADelimiters)) and IsUrl(Result) then
    begin
      while (APos > AStart) and IsUrlDelimiter(FText[APos]) do
        Dec(APos);
      ALength := APos - AStart + 1;
      Result := Copy(FText, AStart, ALength);
    end
    else
    begin
      while (AStart < FSpellingEnd) and (IsDelimiter(FText[AStart]) and not IsMeaningfulCharacters(FText[AStart])) do
      begin
        ADelimiters := ADelimiters + FText[AStart];
        Inc(AStart);
      end;
      ALength := 0;
      APos := AStart;
      while (APos < FSpellingEnd) and not (IsDelimiter(FText[APos]) and not IsMeaningfulCharacters(FText[APos])) do
        Inc(APos);
      ALength := APos - AStart;
      Result := Copy(FText, AStart, ALength);
      if not WideStringContainsAlpha(Result) then
      begin
        APreDelimiters := ADelimiters + Result;
        Inc(AStart, ALength);
        Result := GetNextWord(AStart, ALength, ADelimiters);
        ADelimiters := APreDelimiters + ADelimiters;
      end;
    end;
  end;
end;

function TdxSpellCheckerTextParser.GetPrevWord: WideString;
begin
  Result := FPrevWord;
end;

function TdxSpellCheckerTextParser.IsDelimiter(AChar: WideChar): Boolean;
begin
  Result := WideCharPos(AChar, FDelimiters) > 0;
end;

function TdxSpellCheckerTextParser.IsMeaningfulCharacters(AChar: WideChar): Boolean;
begin
  Result := WideCharPos(AChar, FMeaningfulCharacters) > 0;
end;

function TdxSpellCheckerTextParser.IsUrlDelimiter(AChar: WideChar): Boolean;
begin
  Result := WideCharPos(AChar, FUrlDelimiters) > 0;
end;

function TdxSpellCheckerTextParser.WordExists(const AWord: WideString): Boolean;
begin
  Result := SpellChecker.HasWordInDictionaries(AWord);
end;

function TdxSpellCheckerTextParser.GetSentence(APos: Integer): TdxSpellCheckerSentence;

  function IsSentenceDelimiters(ACh: WideChar): Boolean;
  begin
    Result := (ACh = '.') or (WideIsSpace(ACh) and (ACh <> ' '));
  end;

  function GetSentenceText(var AStartPos: Integer): WideString;
  var
    AEndPos: Integer;
    ALength: Integer;
  begin
    AEndPos := AStartPos;
    while (AStartPos > 0) and not IsSentenceDelimiters(Text[AStartPos]) do
      Dec(AStartPos);
    while (AStartPos > 0) and (IsSentenceDelimiters(Text[AStartPos]) or (Text[AStartPos] = ' ')) do
      Inc(AStartPos);
    ALength := Length(FText);
    while (AEndPos <= ALength) and (not IsSentenceDelimiters(Text[AEndPos]) or (Text[AEndPos] = '.')) do
      Inc(AEndPos);
    Result := Copy(Text, AStartPos, AEndPos - AStartPos);
  end;

begin
  with Result do
  begin
    StartTextPosition := APos;
    Text := GetSentenceText(StartTextPosition);
    if StartTextPosition = 0 then
      Inc(StartTextPosition);
    StartWordPosition := APos - StartTextPosition;
  end;
end;

function TdxSpellCheckerTextParser.GetNextDelimiterPosition(var AStart: Integer; ADirection: Integer): Boolean;
begin
  while (AStart <= FSpellingEnd) and (AStart >= FSpellingStart) and not WideIsSpace(FText[AStart]) do
    Inc(AStart, ADirection);
  Result := WideIsSpace(FText[AStart]);
end;

function TdxSpellCheckerTextParser.GetSuggestions(
  const AWord: WideString): TdxSpellCheckerSuggestionList;
begin
  Result := SpellChecker.GetSuggestions(AWord);
end;

procedure TdxSpellCheckerTextParser.UpdateTextInfo(AAdapter: TdxSpellCheckerCustomEditAdapter);
begin
  AAdapter.GetSpellingBounds(FSpellingStart, FSpellingEnd);
  FText := AAdapter.Text;
end;

function TdxSpellCheckerTextParser.LastWideCharIsSpace(const S: WideString): Boolean;
var
  I: Integer;
begin
  I := Length(S);
  Result := (I > 0) and WideIsSpace(S[I]);
end;

{ TdxSpellCheckerUndoItem }

constructor TdxSpellCheckerUndoItem.Create(
  const AMisspelledWord, AReplacement, APrevWord: WideString;
  AMisspelledWordPosition: Integer);
begin
  inherited Create;
  FMisspelledWord := AMisspelledWord;
  FReplacement := AReplacement;
  FPrevWord := APrevWord;
  FMisspelledWordPosition := AMisspelledWordPosition;
end;

{ TdxSpellCheckerUndoManager }

constructor TdxSpellCheckerUndoManager.Create;
begin
  inherited Create;
  FUndoList := TcxObjectList.Create;
end;

destructor TdxSpellCheckerUndoManager.Destroy;
begin
  FreeAndNil(FUndoList);
  inherited Destroy;
end;

procedure TdxSpellCheckerUndoManager.Add(
  const AMisspelledWord, AReplacement, APrevWord: WideString;
  AMisspelledWordPosition: Integer);
begin
  FUndoList.Add(TdxSpellCheckerUndoItem.Create(AMisspelledWord, AReplacement,
    APrevWord, AMisspelledWordPosition));
end;

procedure TdxSpellCheckerUndoManager.UndoLast;
begin
  if Count > 0 then
  begin
    Last.Free;
    FUndoList.Delete(Count - 1);
  end;
end;

function TdxSpellCheckerUndoManager.GetCount: Integer;
begin
  Result := FUndoList.Count;
end;

function TdxSpellCheckerUndoManager.GetItem(Index: Integer): TdxSpellCheckerUndoItem;
begin
  Result := TdxSpellCheckerUndoItem(FUndoList[Index]);
end;

function TdxSpellCheckerUndoManager.GetLast: TdxSpellCheckerUndoItem;
begin
  if Count > 0 then
    Result := Items[Count - 1]
  else
    Result := nil;
end;

{ TdxSpellCheckerCustomManager }

constructor TdxSpellCheckerCustomManager.Create(ASpellChecker: TdxCustomSpellChecker);
begin
  inherited Create(ASpellChecker);
  FContainer := nil;
end;

procedure TdxSpellCheckerCustomManager.CheckFinish;
begin
  Edit := nil;
end;

procedure TdxSpellCheckerCustomManager.CheckStart(AControl: TWinControl);
begin
  if Active then
  begin
    if (AControl <> nil) and IsCheckSupported(AControl) then
      Edit := AControl
    else
      Edit := nil;
  end;
end;

procedure TdxSpellCheckerCustomManager.CreateAdapter(AAdapterClass: TdxSpellCheckerCustomEditAdapterClass; AControl: TWinControl);
begin
  FAdapter := AAdapterClass.Create(AControl);
end;

procedure TdxSpellCheckerCustomManager.DoFinalizeController;
begin
end;

function TdxSpellCheckerCustomManager.GetActive: Boolean;
begin
  Result := False;
end;

function TdxSpellCheckerCustomManager.GetAdapterClass(AControl: TWinControl): TdxSpellCheckerCustomEditAdapterClass;
begin
  Result := nil;
end;

function TdxSpellCheckerCustomManager.GetCheckModeClass: TdxSpellCheckerCustomCheckModeClass;
begin
  Result := TdxSpellCheckerCustomCheckMode;
end;

procedure TdxSpellCheckerCustomManager.FinalizeController;
begin
  if Assigned(CheckMode) then
  begin
    DoFinish(Container);
    DoFinalizeController;
    FreeAndNil(FCheckMode);
    FreeAndNil(FAdapter);
    FContainer := nil;
  end;
end;

procedure TdxSpellCheckerCustomManager.InitializeController(AControl: TWinControl);
var
  AAdapterClass: TdxSpellCheckerCustomEditAdapterClass;
begin
  if (AControl = nil) or (GetParentForm(AControl) is TfmSpellCheckerBaseForm) then
    FContainer := nil
  else
  begin
    FContainer := TcxCustomEdit(GetInnerControlContainer(AControl));
    AAdapterClass := GetAdapterClass(AControl);
    if Assigned(AAdapterClass) and DoStart(FContainer) then
    begin
      CreateAdapter(AAdapterClass, AControl);
      FCheckMode := GetCheckModeClass.Create(SpellChecker, Adapter);
    end;
  end;
end;

function TdxSpellCheckerCustomManager.IsCheckSupported(AControl: TWinControl): Boolean;
var
  AItf: IdxSpellCheckerControl;
begin
  Result := Assigned(AControl) and AControl.HandleAllocated and
    Supports(GetInnerControlContainer(AControl), IdxSpellCheckerControl, AItf) and
    AItf.SupportsSpelling;
end;

procedure TdxSpellCheckerCustomManager.ValidateAdapter;
begin
  if Adapter = nil then
    CheckStart(FindControl(GetFocus))
end;

function TdxSpellCheckerCustomManager.GetEdit: TWinControl;
begin
  if Adapter <> nil then
    Result := Adapter.Edit
  else
    Result := nil;
end;

procedure TdxSpellCheckerCustomManager.SetEdit(const AValue: TWinControl);
begin
  if Edit <> AValue then
  begin
    FinalizeController;
    InitializeController(AValue);
  end;
end;

{ TdxSpellCheckerAutoCorrectCustomRule }

constructor TdxSpellCheckerAutoCorrectCustomRule.Create(
  AManager: TdxSpellCheckerCustomAutoCorrectManager);
begin
  inherited Create;
  FManager := AManager;
  InitializeDelimiters;
end;

procedure TdxSpellCheckerAutoCorrectCustomRule.AfterCorrect;
begin
end;

procedure TdxSpellCheckerAutoCorrectCustomRule.BeforeCorrect;
begin
end;

function TdxSpellCheckerAutoCorrectCustomRule.IsTerminating: Boolean;
begin
  Result := True;
end;

function TdxSpellCheckerAutoCorrectCustomRule.IsWordDelimiter(
  AChar: WideChar): Boolean;
begin
  Result := WideCharPos(AChar, FWordDelimiters) > 0;
end;

procedure TdxSpellCheckerAutoCorrectCustomRule.Undo;
begin
end;

function TdxSpellCheckerAutoCorrectCustomRule.GetActive: Boolean;
begin
  Result := False;
end;

procedure TdxSpellCheckerAutoCorrectCustomRule.SetWordDelimiters(const AWordDelimiters: WideString);
begin
  FWordDelimiters := AWordDelimiters;
end;

function TdxSpellCheckerAutoCorrectCustomRule.WideCapitalizeCase(const AWord: WideString): WideString;
begin
  Result := Manager.WideCapitalizeCase(AWord);
end;

function TdxSpellCheckerAutoCorrectCustomRule.GetLastKey: WideChar;
begin
  Result := Manager.LastKey;
end;

function TdxSpellCheckerAutoCorrectCustomRule.GetOptions: TdxSpellCheckerAutoCorrectOptions;
begin
  Result := Manager.SpellChecker.AutoCorrectOptions;
end;

{ TdxSpellCheckerCustomAutoCorrectManager }

procedure TdxSpellCheckerCustomAutoCorrectManager.KeyPress(AKey: Char);
begin
  ValidateAdapter;
  FLastKey := WideChar(AKey);
end;

procedure TdxSpellCheckerCustomAutoCorrectManager.CreateAdapter(AAdapterClass: TdxSpellCheckerCustomEditAdapterClass; AControl: TWinControl);
begin
  FAdapter := AAdapterClass.Create(FContainer);
end;

function TdxSpellCheckerCustomAutoCorrectManager.DoAutoCorrect(ARule: TdxSpellCheckerAutoCorrectCustomRule;
  var AWordRange: TdxSpellCheckerAutoCorrectWordRange): Boolean;
begin
  Result := SpellChecker.DoAutoCorrect(ARule, AWordRange);
end;

procedure TdxSpellCheckerCustomAutoCorrectManager.DoFinish(AControl: TWinControl);
begin
  SpellChecker.DoAutoCorrectFinish(AControl);
end;

function TdxSpellCheckerCustomAutoCorrectManager.DoStart(AControl: TWinControl): Boolean;
begin
  Result := SpellChecker.DoAutoCorrectStart(AControl);
end;

function TdxSpellCheckerCustomAutoCorrectManager.GetActive: Boolean;
begin
  Result := Options.Active;
end;

function TdxSpellCheckerCustomAutoCorrectManager.GetAdapterClass(
  AControl: TWinControl): TdxSpellCheckerCustomEditAdapterClass;
var
  AEdit: TcxCustomEdit;
begin
  AEdit := TcxCustomEdit(GetInnerControlContainer(AControl));
  if AEdit is TcxCustomRichEdit then
    Result := TdxSpellCheckercxRichEditAdapter
  else
    if AEdit is TcxCustomEdit then
      Result := TdxSpellCheckercxTextEditAdapter
    else
      Result := inherited GetAdapterClass(AControl);
end;

procedure TdxSpellCheckerCustomAutoCorrectManager.Undo;
begin
end;

function TdxSpellCheckerCustomAutoCorrectManager.WideCapitalizeCase(const AWord: WideString): WideString;
begin
  Result := dxSpellCheckerUtils.WideCapitalizeCase(AWord);
end;

function TdxSpellCheckerCustomAutoCorrectManager.GetOptions: TdxSpellCheckerAutoCorrectOptions;
begin
  Result := SpellChecker.AutoCorrectOptions;
end;

{ TdxSpellCheckerCustomCheckAsYouTypeManager }

procedure TdxSpellCheckerCustomCheckAsYouTypeManager.BeginManualCheck;
begin
  Inc(FManualCheckCount);
end;

procedure TdxSpellCheckerCustomCheckAsYouTypeManager.CheckFinish;
begin
  if not IsManualCheckingActive then
    inherited CheckFinish;
end;

procedure TdxSpellCheckerCustomCheckAsYouTypeManager.CheckStart(AControl: TWinControl);
begin
  if not IsManualCheckingActive then
    inherited CheckStart(AControl);
end;

procedure TdxSpellCheckerCustomCheckAsYouTypeManager.EndManualCheck;
begin
  Dec(FManualCheckCount);
  if FManualCheckCount = 0 then
    CheckStart(FindControl(GetFocus));
end;

procedure TdxSpellCheckerCustomCheckAsYouTypeManager.KeyDown(AKey: Word; Shift: TShiftState);
begin
end;

procedure TdxSpellCheckerCustomCheckAsYouTypeManager.KeyUp(AKey: Word; Shift: TShiftState);
begin
end;

function TdxSpellCheckerCustomCheckAsYouTypeManager.GetIsManualCheckingActive: Boolean;
begin
  Result := FManualCheckCount > 0;
end;

procedure TdxSpellCheckerCustomCheckAsYouTypeManager.InnerShowPopupMenu(APopup: TComponent; const P: TPoint);
begin
  if not SpellChecker.DoCheckAsYouTypePopup(APopup) then
    ShowPopupMenu(nil, APopup, P.X, P.Y);
end;

procedure TdxSpellCheckerCustomCheckAsYouTypeManager.Reset;
begin
end;

procedure TdxSpellCheckerCustomCheckAsYouTypeManager.SpellingOptionsChanged;
begin
  if CheckMode <> nil then
    SpellChecker.ValidateRules(CheckMode.Parser);
end;

function TdxSpellCheckerCustomCheckAsYouTypeManager.GetIsSpellCheckerReady: Boolean;
begin
  Result := SpellChecker.ActiveDictionaryCount > 0;
end;

function TdxSpellCheckerCustomCheckAsYouTypeManager.GetOptions: TdxSpellCheckerCheckAsYouTypeOptions;
begin
  Result := SpellChecker.CheckAsYouTypeOptions;
end;

procedure TdxSpellCheckerCustomCheckAsYouTypeManager.DoFinish(AControl: TWinControl);
begin
  SpellChecker.DoCheckAsYouTypeFinish(AControl);
end;

function TdxSpellCheckerCustomCheckAsYouTypeManager.DoStart(AControl: TWinControl): Boolean;
begin
  Result := SpellChecker.DoCheckAsYouTypeStart(AControl);
end;

function TdxSpellCheckerCustomCheckAsYouTypeManager.GetActive: Boolean;
begin
  Result := Options.Active;
end;

procedure TdxSpellCheckerCustomCheckAsYouTypeManager.StartManualSpelling(
  AAdapter: TdxSpellCheckerCustomEditAdapter);
begin
  SpellChecker.InternalCheck(AAdapter);
end;

procedure TdxSpellCheckerCustomCheckAsYouTypeManager.ValidateRules(
  AParser: TdxSpellCheckerTextParser);
begin
  SpellChecker.ValidateRules(AParser);
end;

{ TdxSpellCheckerCustomCheckMode }

constructor TdxSpellCheckerCustomCheckMode.Create(AOwner: TdxCustomSpellChecker;
  AAdapter: TdxSpellCheckerCustomEditAdapter);
begin
  inherited Create;
  FSpellChecker := AOwner;
  FAdapter := AAdapter;
  StoreSelection;
  CreateParser;
  FMisspellingStart := SpellingStart;
end;

destructor TdxSpellCheckerCustomCheckMode.Destroy;
begin
  FreeAndNil(FParser);
  RestoreSelection;
  inherited Destroy;
end;

procedure TdxSpellCheckerCustomCheckMode.Add;
begin
  if SpellChecker.HasEnabledUserDictionary then
    SpellChecker.AddWordToUserDictionary(FMisspelledWord);
end;

function TdxSpellCheckerCustomCheckMode.CanUndo: Boolean;
begin
  Result := False;
end;

procedure TdxSpellCheckerCustomCheckMode.Change(const AWord: WideString);
var
  ADelta: Integer;
begin
  SelectMisspelledWord;
  ADelta := Length(AWord) - Length(Adapter.SelText);
  Adapter.SelText := dxWideStringToString(AWord);
  PrevWord := AWord;
  UpdateSpellingBounds(ADelta);
  UpdateTextInfo;
  Inc(FMisspellingStart, Length(AWord));
end;

procedure TdxSpellCheckerCustomCheckMode.ChangeAll(const AWord: WideString);
begin
  SpellChecker.ChangeList.Add(MisspelledWord, AWord);
  Change(AWord);
end;

function TdxSpellCheckerCustomCheckMode.CheckWord(const AWord: WideString): TdxSpellCheckerSpellingCode;
begin
  if not IsValidWord(AWord) then
  begin
    FLastCode := SpellChecker.Rules.ErrorCode;
    FMisspelledWord := AWord;
  end
  else
    FLastCode := scNoError;
  Result := FLastCode;
end;

procedure TdxSpellCheckerCustomCheckMode.Delete;
begin
  Inc(FMisspellingLen);
  Dec(FMisspellingStart);
  SelectMisspelledWord;
  Adapter.ClearSelection;
  UpdateSpellingBounds(-FMisspellingLen);
  UpdateTextInfo;
end;

procedure TdxSpellCheckerCustomCheckMode.DeleteAll;
begin
  SpellChecker.DeleteList.Add(MisspelledWord);
  Delete;
end;

function TdxSpellCheckerCustomCheckMode.GetNextWord(out AWord: WideString): Boolean;
var
  ADelimiters: WideString;
begin
  AWord := Parser.GetNextWord(FMisspellingStart, FMisspellingLen, ADelimiters);
  if AWord = '' then
  begin
    ValidateSpellingBounds;
    AWord := Parser.GetNextWord(FMisspellingStart, FMisspellingLen, ADelimiters);
  end;
  if (Length(ADelimiters) = 0) or (Length(ADelimiters) <> GetWideCharCount(' ', ADelimiters)) then
    PrevWord := '';
  Result := FMisspellingLen > 0;
end;

function TdxSpellCheckerCustomCheckMode.GetNextMisspelledWord: Boolean;
var
  AWord: WideString;
begin
  FMisspelledWord := '';
  while GetNextWord(AWord) do
  begin
    if InternalProcessWord(AWord) then
      Continue;
    if InternalCheckWord(AWord) <> scNoError then
      Break;
    PrevWord := AWord;
    Inc(FMisspellingStart, FMisspellingLen);
  end;
  if FMisspellingLen = 0 then
    FLastCode := scNoError
  else
    SelectMisspelledWord;
  Result := FLastCode <> scNoError;
end;

function TdxSpellCheckerCustomCheckMode.GetSuggestions(
  const AWord: WideString): TdxSpellCheckerSuggestionList;
begin
  Result := Parser.GetSuggestions(AWord);
end;

function TdxSpellCheckerCustomCheckMode.InternalProcessWord(
  const AWord: WideString): Boolean;
var
  AReplacement: WideString;
begin
  Result := True;
  if IsNeedIgnoreWord(AWord) then
  begin
    FMisspelledWord := AWord;
    Ignore;
  end
  else
    if IsNeedChangeWord(AWord, AReplacement) then
    begin
      Change(AReplacement);
      PrevWord := AReplacement;
    end
    else
    begin
      if IsNeedDeleteWord(AWord) then
        Delete
      else
        Result := False;
    end;
end;

procedure TdxSpellCheckerCustomCheckMode.Ignore;
begin
  Inc(FMisspellingStart, FMisspellingLen);
end;

procedure TdxSpellCheckerCustomCheckMode.IgnoreAll;
begin
  SpellChecker.AddToIgnoreList(MisspelledWord);
  Ignore;
end;

function TdxSpellCheckerCustomCheckMode.IsValidWord(
  const AWord: WideString): Boolean;
begin
  Result := SpellChecker.IsValidWord(AWord);
end;

procedure TdxSpellCheckerCustomCheckMode.RestoreSelection;
begin
end;

procedure TdxSpellCheckerCustomCheckMode.StoreSelection;
begin
end;

procedure TdxSpellCheckerCustomCheckMode.UndoLast;
begin
end;

procedure TdxSpellCheckerCustomCheckMode.CreateParser;
begin
  if FParser = nil then
    FParser := GetParserClass.Create(SpellChecker);
  Adapter.GetSpellingBounds(FSpellingStart, FSpellingEnd);
  Parser.UpdateTextInfo(Adapter);
end;

function TdxSpellCheckerCustomCheckMode.GetOwner: TPersistent;
begin
  Result := FSpellChecker;
end;

function TdxSpellCheckerCustomCheckMode.GetParserClass: TdxSpellCheckerTextParserClass;
begin
  Result := TdxSpellCheckerTextParser;
end;

function TdxSpellCheckerCustomCheckMode.InternalCheckWord(var AWord: WideString): TdxSpellCheckerSpellingCode;
var
  AWordWithoutLastChar: WideString;
begin
  Result := CheckWord(AWord);
  if (Result <> scNoError) and (FMisspellingLen >= 2) then
  begin
    //remove the last non-alphanumeric symbol (.')
    AWordWithoutLastChar := Copy(AWord, 1, FMisspellingLen - 1);
    if Parser.IsMeaningfulCharacters(AWord[FMisspellingLen]) and
      not WideIsAlphaNumeric(AWord[FMisspellingLen]) then
    begin
      AWord := AWordWithoutLastChar;
      Dec(FMisspellingLen);
      Result := CheckWord(AWord);
    end;
  end;
  //skip all non-alphanumeric symbols
  if (Result = scMisspelled) and (FMisspellingLen >= 2) then
  begin
    while (FMisspellingLen > 0) and not WideIsAlphaNumeric(AWord[1]) do
    begin
      Inc(FMisspellingStart);
      Dec(FMisspellingLen);
      System.Delete(AWord, 1, 1);
    end;
    while (FMisspellingLen > 0) and not WideIsAlphaNumeric(AWord[FMisspellingLen]) do
    begin
      System.Delete(AWord, FMisspellingLen, 1);
      Dec(FMisspellingLen);
    end;
    if FMisspellingLen = 0 then
      Result := scNoError
    else
      Result := CheckWord(AWord);
  end;
end;

function TdxSpellCheckerCustomCheckMode.IsNeedChangeWord(const AWord: WideString;
  out AReplacement: WideString): Boolean;
var
  AItem: TdxSpellCheckerReplacement;
begin
  AItem := SpellChecker.ChangeList.FindReplacement(AWord);
  Result := Assigned(AItem);
  if Result then
    AReplacement := AItem.Replacement;
end;

function TdxSpellCheckerCustomCheckMode.IsNeedDeleteWord(const AWord: WideString): Boolean;
begin
  Result := SpellChecker.DeleteList.Find(AWord);
end;

function TdxSpellCheckerCustomCheckMode.IsNeedIgnoreWord(const AWord: WideString): Boolean;
var
  AWordLength: Integer;
  ACorrectedWord: WideString;
begin
  AWordLength := Length(AWord);
  if AWord[AWordLength] = '.' then
  begin
    ACorrectedWord := Copy(AWord, 1, AWordLength - 1);
    Result := SpellChecker.IgnoreList.Find(ACorrectedWord);
  end
  else
    Result := SpellChecker.IgnoreList.Find(AWord);
end;

procedure TdxSpellCheckerCustomCheckMode.SelectMisspelledWord;
begin
  if FMisspellingLen > 0 then
    Adapter.SelStart := FMisspellingStart - 1;
  Adapter.SelLength := FMisspellingLen;
end;

procedure TdxSpellCheckerCustomCheckMode.SelectMisspelledWordAfterUndo;
begin
  SelectMisspelledWord;
end;

procedure TdxSpellCheckerCustomCheckMode.UpdateByDictionary(
  ADictionary: TdxCustomSpellCheckerDictionary);
begin
end;

procedure TdxSpellCheckerCustomCheckMode.UpdateSpellingBounds(ADelta: Integer);
begin
  if FMisspellingStart < FSpellingStart then
    Inc(FSpellingStart, ADelta);
  if FMisspellingStart < FSpellingEnd then
    Inc(FSpellingEnd, ADelta);
  ValidateSpellingBounds;
end;

procedure TdxSpellCheckerCustomCheckMode.UpdateTextInfo;
begin
  Parser.UpdateTextInfo(Adapter);
  FParser.FSpellingStart := SpellingStart;
  FParser.FSpellingEnd := SpellingEnd;
end;

procedure TdxSpellCheckerCustomCheckMode.ValidateSpellingBounds;
begin
end;

function TdxSpellCheckerCustomCheckMode.GetPrevWord: WideString;
begin
  Result := Parser.FPrevWord;
end;

procedure TdxSpellCheckerCustomCheckMode.SetPrevWord(const AValue: WideString);
begin
  Parser.FPrevWord := AValue;
end;

procedure TdxSpellCheckerCustomCheckMode.SetSpellingEnd(
  const AValue: Integer);
begin
  FSpellingEnd := AValue;
end;

procedure TdxSpellCheckerCustomCheckMode.SetSpellingStart(
  const AValue: Integer);
begin
  FSpellingStart := AValue;
end;

{ TdxSpellCheckerDialogCheckMode }

constructor TdxSpellCheckerDialogCheckMode.Create(AOwner: TdxCustomSpellChecker;
  AAdapter: TdxSpellCheckerCustomEditAdapter);
begin
  inherited Create(AOwner, AAdapter);
  FUndoManager := TdxSpellCheckerUndoManager.Create;
  FSelectionChecked := False;
  Adapter.HideSelection := False;
end;

destructor TdxSpellCheckerDialogCheckMode.Destroy;
begin
  FreeAndNil(FUndoManager);
  inherited Destroy;
end;

function TdxSpellCheckerDialogCheckMode.CanUndo: Boolean;
begin
  Result := FUndoManager.Count > 0;
end;

procedure TdxSpellCheckerDialogCheckMode.Change(const AWord: WideString);
begin
  FUndoManager.Add(MisspelledWord, AWord, '', FMisspellingStart - 1);
  inherited Change(AWord);
end;

procedure TdxSpellCheckerDialogCheckMode.CreateParser;
begin
  inherited CreateParser;
  FCheckedRange := 0;
  if not SpellChecker.CheckingContainer then
  begin
    if SpellChecker.SpellingOptions.CheckFromCursorPos or IsCheckingSelectedText then
    begin
      SpellingStart := FSaveSelStart;
      Parser.GetNextDelimiterPosition(FSpellingStart, -1);
    end;
    if IsCheckingSelectedText then
    begin
      SpellingEnd := FSaveSelStart + FSaveSelLength;
      Parser.GetNextDelimiterPosition(FSpellingEnd, 1);
      FCheckedRange := dxSelectionChecked;
    end;
  end;
  UpdateTextInfo;
end;

procedure TdxSpellCheckerDialogCheckMode.Delete;
begin
  FUndoManager.Add(' ' + MisspelledWord, '', PrevWord, FMisspellingStart - 2);
  inherited Delete;
end;

procedure TdxSpellCheckerDialogCheckMode.Ignore;
begin
  FUndoManager.Add(MisspelledWord, MisspelledWord, PrevWord, FMisspellingStart - 1);
  inherited Ignore;
end;

function TdxSpellCheckerDialogCheckMode.ShowDialog: Integer;
begin
  if not Adapter.EditorHandleAllocated then
    Adapter.Post;
  Result := 0;
end;

function TdxSpellCheckerDialogCheckMode.IsCheckingSelectedText: Boolean;
begin
  Result := SpellChecker.SpellingOptions.CheckSelectedTextFirst and
    (FSaveSelLength > 0);
end;

procedure TdxSpellCheckerDialogCheckMode.RestoreSelection;
begin
  Adapter.HideSelection := FSaveHideSelection;
  Adapter.SelStart := FSaveSelStart;
  Adapter.SelLength := FSaveSelLength;
end;

procedure TdxSpellCheckerDialogCheckMode.UndoLast;
var
  AItem: TdxSpellCheckerUndoItem;
begin
  AItem := FUndoManager.Last;
  if CanUndo and (AItem <> nil) then
  begin
    Adapter.SelStart := AItem.MisspelledWordPosition;
    Adapter.SelLength := Length(AItem.Replacement);
    UpdateSpellingBounds(Length(AItem.MisspelledWord) - Adapter.SelLength);
    Adapter.SelText := AItem.MisspelledWord;
    UpdateTextInfo;
    SelectMisspelledWordAfterUndo;
    ValidateSpellingBoundsAfterUndo;
    PrevWord := AItem.PrevWord;
    FUndoManager.UndoLast;
  end;
end;

procedure TdxSpellCheckerDialogCheckMode.StoreSelection;
begin
  FSaveHideSelection := Adapter.HideSelection;
  FSaveSelLength := Adapter.SelLength;
  FSaveSelStart := Adapter.SelStart;
  inherited StoreSelection;
end;

procedure TdxSpellCheckerDialogCheckMode.ValidateSpellingBounds;

  procedure SetBeforeSelectionBounds;
  begin
    SpellingEnd := SpellingStart;
    SpellingStart := 1;
    FMisspellingStart := 1;
  end;

var
  ASpellingStart, ASpellingEnd: Integer;
begin
  if (SpellChecker.SpellingOptions.CheckFromCursorPos or IsCheckingSelectedText) and not SpellChecker.CheckingContainer then
  begin
    Adapter.GetSpellingBounds(ASpellingStart, ASpellingEnd);
    if ((FMisspellingStart >= ASpellingEnd) or (FMisspellingStart < SpellingStart)) and (SpellingStart > 1) and
      not IsCheckingSelectedText then
    begin
      SetBeforeSelectionBounds;
      UpdateTextInfo;
    end
    else
      if IsCheckingSelectedText and (FMisspellingStart >= SpellingEnd) then
      begin
        if (FCheckedRange = dxSelectionChecked) and (FSelectionChecked or
          (MessageDlg(cxGetResourceString(@sdxSpellCheckerSelectionCheckIsFinished), mtInformation, [mbYes, mbNo], 0) = mrYes)) then
        begin
          SpellingEnd := ASpellingEnd;
          FSelectionChecked := True;
          UpdateTextInfo;
          FCheckedRange := dxAfterSelectionChecked;
        end
        else
          if (FCheckedRange = dxAfterSelectionChecked) and (FMisspellingStart > ASpellingStart) then
          begin
            SetBeforeSelectionBounds;
            FCheckedRange := dxBeforeSelectionChecked;
          end;
      end;
  end;
end;

procedure TdxSpellCheckerDialogCheckMode.ValidateSpellingBoundsAfterUndo;
var
  ASpellingStart, ASpellingEnd: Integer;
begin
  Adapter.GetSpellingBounds(ASpellingStart, ASpellingEnd);
  if (FMisspellingStart >= SpellingEnd) and (SpellingEnd < ASpellingEnd) then
  begin
    FCheckedRange := dxAfterSelectionChecked;
    SpellingStart := SpellingEnd;
    SpellingEnd := ASpellingEnd;
    UpdateTextInfo;
  end;
end;

function TdxSpellCheckerDialogCheckMode.GetLanguages: TdxSpellCheckerLanguages;
begin
  Result := SpellChecker.Languages;
end;

{ TdxSpellCheckerOutlookCheckMode }

function TdxSpellCheckerOutlookCheckMode.ShowDialog: Integer;
begin
  Result := dxShowOutlookSpellingDialog(SpellChecker);
  inherited ShowDialog;
end;

procedure TdxSpellCheckerOutlookCheckMode.SelectMisspelledWordAfterUndo;
var
  AItem: TdxSpellCheckerUndoItem;
begin
  AItem := FUndoManager.Last;
  if AItem <> nil then
    FMisspellingStart := FMisspellingStart - Length(AItem.Replacement) + Length(AItem.MisspelledWord);
  inherited;
end;

{ TdxSpellCheckerWordCheckMode }

procedure TdxSpellCheckerWordCheckMode.ChangeSentence(const ASentence: WideString);
var
  AMisspelledSentence: TdxSpellCheckerSentence;
  ADelta: Integer;
begin
  AMisspelledSentence := MisspelledSentence;
  FUndoManager.Add(AMisspelledSentence.Text, ASentence, '', AMisspelledSentence.StartTextPosition - 1);
  Adapter.SelStart := AMisspelledSentence.StartTextPosition - 1;
  Adapter.SelLength := Length(AMisspelledSentence.Text);
  PrevWord := '';
  ADelta := Length(ASentence) - Adapter.SelLength;
  Adapter.SelText := ASentence;
  UpdateSpellingBounds(ADelta);
  UpdateTextInfo;
  FMisspellingStart := AMisspelledSentence.StartTextPosition - 1;
end;

procedure TdxSpellCheckerWordCheckMode.SelectMisspelledWordAfterUndo;
var
  AItem: TdxSpellCheckerUndoItem;
begin
  AItem := FUndoManager.Last;
  if AItem <> nil then
  begin
    FMisspellingStart := AItem.MisspelledWordPosition + 1;
    FMisspellingLen := Length(AItem.MisspelledWord);
  end;
  inherited SelectMisspelledWordAfterUndo;
end;

function TdxSpellCheckerWordCheckMode.ShowDialog: Integer;
begin
  Result := dxShowWordSpellingDialog(SpellChecker);
  inherited ShowDialog;
end;

function TdxSpellCheckerWordCheckMode.GetMisspelledSentence: TdxSpellCheckerSentence;
begin
  Result := Parser.GetSentence(FMisspellingStart);
end;

{ TdxSpellCheckerSuggestionBuilder }

constructor TdxSpellCheckerSuggestionBuilder.Create(
  ADictionary: TdxCustomSpellCheckerDictionary);
begin
  inherited Create;
  FDictionary := ADictionary;
  Alphabet := ADictionary.GetActiveAlphabet;
end;

procedure TdxSpellCheckerSuggestionBuilder.AddSuggestions(
  const AWord: WideString; ASuggestions: TdxSpellCheckerSuggestionList);
begin
  if (ASuggestions = nil) or (Length(AWord) = 0) then Exit;
  FSuggestions := ASuggestions;
  FWord := PrepareWord(AWord);
  try
    FStartTicks := GetTickCount;
    DoAddSuggestions;
    if (Suggestions.Count = 0) and Dictionary.CanUseDoubleMetaphone then
      DoAddMetaphoneSuggestions;
  except
    on EAbort do;
    else
      raise;
  end;
end;

function TdxSpellCheckerSuggestionBuilder.CanAddToSuggestions(
  const ATestWord: WideString): Boolean;
begin
  Result := Dictionary.HasWord(ATestWord);
  if IsTimeOut then
    Abort;
end;

procedure TdxSpellCheckerSuggestionBuilder.CheckAddMetaphoneSuggestion(
  ATestWord, AUpperWord1: PWideChar; AUpperWordLen1: Integer;
  AUpperWord2: PWideChar; AUpperWordLen2: Integer);
var
  ADistance: Integer;
begin
  ADistance := Similarity.GetDistance(AUpperWord1, AUpperWordLen1, AUpperWord2,
    AUpperWordLen2);
  if ADistance <= MaxDistance then
    Suggestions.Add(ATestWord, Dictionary, ADistance);
  if IsTimeOut then
    Abort;
end;

procedure TdxSpellCheckerSuggestionBuilder.PopulateCapitalizationSuggestions;
begin
  Dictionary.PopulateCapitalizationSuggestions(Self, Word);
end;

procedure TdxSpellCheckerSuggestionBuilder.DoAddMetaphoneSuggestions;
begin
  Dictionary.PopulateMetaphoneSuggestions(Self, Word);
end;

procedure TdxSpellCheckerSuggestionBuilder.DoAddSuggestions;
begin
  PopulateCapitalizationSuggestions;
end;

function TdxSpellCheckerSuggestionBuilder.IsCaseSensitive: Boolean;
begin
  Result := False;
end;

function TdxSpellCheckerSuggestionBuilder.IsTimeOut: Boolean;
begin
  Result := (Timeout > 0) and (GetTickCount >= Timeout + FStartTicks);
end;

function TdxSpellCheckerSuggestionBuilder.PrepareWord(
  const AWord: WideString): WideString;
begin
  Result := WideLowerCase(AWord);
end;

function TdxSpellCheckerSuggestionBuilder.GetMaxDistance: Integer;
begin
  Result := Dictionary.SpellChecker.MetaphoneDistance * 2;
end;

function TdxSpellCheckerSuggestionBuilder.GetSimilarity: TdxStringSimilarityCalculator;
begin
  Result := Dictionary.SpellChecker.Similarity;
end;

function TdxSpellCheckerSuggestionBuilder.GetTimeout: Cardinal;
begin
  Result := Dictionary.Timeout;
end;

procedure TdxSpellCheckerSuggestionBuilder.SetAlphabet(const AValue: WideString);
var
  I: Integer;
  ALower: WideString;
begin
  FAlphabet := '';
  if Length(AValue) > 0 then
  begin
    if IsCaseSensitive then
      FAlphabet := AValue
    else
    begin
      ALower := WideLowerCase(AValue);
      for I := 1 to Length(ALower) do
        if WideCharPos(ALower[I], FAlphabet) = 0 then
          FAlphabet := FAlphabet + ALower[I];
    end;
  end;
end;

{ TdxNearMissStrategy }

procedure TdxNearMissStrategy.CheckAddToSuggestions(const ATestWord: WideString);
begin
  if CanAddToSuggestions(ATestWord) then
    if IsCaseSensitive then
      FSuggestions.Add(ATestWord, Dictionary, 2)
    else
      FSuggestions.Add(WidePatternCase(Word, ATestWord), Dictionary, 2);
end;

procedure TdxNearMissStrategy.CheckChangeOneLetter;
var
  ATestWord: WideString;
  ASymbol: WideChar;
  I, J: Integer;
begin
  if Length(Alphabet) = 0 then Exit;
  for I := 1 to Length(Word) do
    for J := 1 to Length(Alphabet) do
    begin
      ASymbol := Alphabet[J];
      if Word[I] <> ASymbol then
      begin
        ATestWord := Word;
        ATestWord[I] := ASymbol;
        CheckAddToSuggestions(ATestWord);
      end;
    end;
end;

procedure TdxNearMissStrategy.CheckDeleteLetter;
var
  ATestWord: WideString;
  ASymbol: WideChar;
  ADeletePos, ALen: Integer;
begin
  ALen := Length(FWord);
  if ALen < 2 then Exit;
  ADeletePos := ALen;
  repeat
    ATestWord := FWord;
    ASymbol := ATestWord[ADeletePos];
    Delete(ATestWord, ADeletePos, 1);
    CheckAddToSuggestions(ATestWord);
    Dec(ADeletePos);
    while (ADeletePos >= 1) and (ASymbol = FWord[ADeletePos]) do
      Dec(ADeletePos);
  until ADeletePos < 1;
end;

procedure TdxNearMissStrategy.CheckDoubleTwoChars;
var
  AWord: PWideChar;
  ATestWord: WideString;
  ALen: Integer;
  I: Integer;
begin
  ALen := Length(Word);
  if ALen < 4 then Exit;
  AWord := PWideChar(Word);
  for I := 0 to ALen - 3 do
    if PCardinal(@AWord[I])^ = PCardinal(@AWord[I + 2])^ then
    begin
      ATestWord := Word;
      Delete(ATestWord, I + 1, 2);
      CheckAddToSuggestions(PWideChar(ATestWord));
    end;
end;

procedure TdxNearMissStrategy.CheckInsertLetter;
var
  ATestWord: WideString;
  ASymbol: WideChar;
  I, AInsertPos, ALen: Integer;
begin
  if Length(Alphabet) = 0 then Exit;
  ALen := Length(Word);
  for I := 1 to Length(Alphabet) do
  begin
    ASymbol := Alphabet[I];
    AInsertPos := 1;
    repeat
      ATestWord := Word;
      while (AInsertPos <= ALen) and (ASymbol = ATestWord[AInsertPos]) do
        Inc(AInsertPos);
      Insert(ASymbol, ATestWord, AInsertPos);
      CheckAddToSuggestions(ATestWord);
      if AInsertPos > ALen then
        Break
      else
        Inc(AInsertPos);
    until False;
  end;
end;

procedure TdxNearMissStrategy.CheckInsertSpace;
var
  ATestWord1, ATestWord2: WideString;
  I, ALen: Integer;
begin
  ALen := Length(Word);
  if ALen < 2 then Exit;
  for I := ALen - 1 downto 1 do
  begin
    ATestWord1 := Copy(Word, 1, I);
    ATestWord2 := Copy(Word, I + 1, ALen);
    if CanAddToSuggestions(ATestWord1) and  CanAddToSuggestions(ATestWord2) then
      FSuggestions.Add(ATestWord1 + ' ' + ATestWord2, Dictionary, 2);
  end;
end;

procedure TdxNearMissStrategy.CheckMoveChar;
var
  ATestWord: WideString;
  I, J: Integer;
  AChar: WideChar;
  ALen: Integer;
begin
  ALen := Length(Word);
  if ALen < 2 then
    Exit;
  ATestWord := Word;
  for I := 1 to ALen do
  begin
    J := I + 1;
    while (J < ALen) and ((J - I) < 10) do
    begin
      AChar := ATestWord[J];
      ATestWord[J] := ATestWord[J + 1];
      ATestWord[J + 1] := AChar;
      if (J - I) >= 2 then
        CheckAddToSuggestions(ATestWord);
      Inc(J);
    end;
    ATestWord := Word;
  end;

  for I := ALen downto 1 do
  begin
    J := I - 1;
    while (J > 1) and ((I - J) < 10) do
    begin
      AChar := ATestWord[J];
      ATestWord[J] := ATestWord[J - 1];
      ATestWord[J - 1] := AChar;
      if (I - J) >=2 then
        CheckAddToSuggestions(ATestWord);
      Dec(J);
    end;
    ATestWord := Word;
  end;
end;

procedure TdxNearMissStrategy.DoAddSuggestions;
begin
  inherited DoAddSuggestions;
  InterchangeTwoLetters;
  LongInterchangeTwoLetters;
  CheckDeleteLetter;
  CheckInsertLetter;
  CheckMoveChar;
  CheckChangeOneLetter;
  CheckDoubleTwoChars;
  CheckInsertSpace;
end;

procedure TdxNearMissStrategy.InterchangeTwoLetters;
var
  ATestWord: WideString;
  I, ALen: Integer;
begin
  ALen := Length(Word);
  if ALen < 2 then Exit;
  for I := 1 to ALen - 1 do
  begin
    if FWord[I] = Word[I + 1] then Continue;
    ATestWord := Word;
    ATestWord[I] := ATestWord[I + 1];
    ATestWord[I + 1] := Word[I];
    CheckAddToSuggestions(ATestWord);
  end;
end;

procedure TdxNearMissStrategy.LongInterchangeTwoLetters;
var
  AWord: WideString;
  AChar: WideChar;
  ALen, I, J: Integer;
begin
  ALen := Length(Word);
  if ALen < 3 then Exit;
  for I := 1 to ALen do
    for J := I + 2 to ALen do
    begin
      AWord := Word;
      AChar := AWord[I];
      AWord[I] := AWord[J];
      AWord[J] := AChar;
      CheckAddToSuggestions(AWord);
    end;
end;

{ TdxSpellCheckerWordList }

constructor TdxSpellCheckerWordList.Create(ALangID: Cardinal; ATableSize: Integer);
begin
  inherited Create;
  InitializeCriticalSection(FLock);
  FLangID := ALangID;
  FCount := 0;
  FTableSize := ATableSize;
  FTable := AllocMem(FTableSize * SizeOf(Integer));
end;

destructor TdxSpellCheckerWordList.Destroy;
begin
  Clear;
  FreeMem(FTable);
  UseDoubleMetaphone := False; //free memory
  DeleteCriticalSection(FLock);
  inherited Destroy;
end;

procedure TdxSpellCheckerWordList.Add(const S: WideString);
var
  AIndex, ASrcLen, AWordLen: Integer;
  AWord, ATemp, P: PWideChar;
  CT1, CT2: TdxCapitalizationType;
begin
  ASrcLen := Length(S);
  if ASrcLen = 0 then Exit;
  EnterCriticalSection(FLock);
  try
    P := Pointer(S);
    AIndex := ElfHash(P, ASrcLen) mod FTableSize;
    AWord := FTable^[AIndex];
    if AWord = nil then
      FTable^[AIndex] := NewWord(P, ASrcLen)
    else
    begin
      repeat
        AWordLen := WordLength(AWord);
        if (AWordLen = ASrcLen) and
          (CompareStringW(LangID, NORM_IGNORECASE, AWord, AWordLen, P, ASrcLen) = CSTR_EQUAL) then
        begin
          if FindMostValidCapitalizationInDuplicates then
          begin
            CT1 := GetWordCapitalizationType(AWord, AWordLen, LangID);
            if CT1 = ctLower then
              Exit;
            CT2 := GetWordCapitalizationType(P, AWordLen, LangID);
            if (CT1 <> CT2) and ((CT2 = ctLower) or ((CT2 = ctCapitalized) and (CT1 = ctUpper))) then
              Move(Pointer(P)^, Pointer(AWord)^, AWordLen * SizeOf(WideChar));
          end;
          Exit;
        end;
        ATemp := GetNextWord(AWord);
        if ATemp = nil then
        begin
          SetNextWord(AWord, NewWord(P, ASrcLen));
          Break;
        end;
        AWord := ATemp;
      until False;
    end;
    Inc(FCount);
  finally
    LeaveCriticalSection(FLock);
  end;
end;

procedure TdxSpellCheckerWordList.Clear;
var
  I: Integer;
  AWord, ATemp: PWideChar;
begin
  if Count = 0 then Exit;
  EnterCriticalSection(FLock);
  try
    InitMetaphoneTable;
    for I := 0 to FTableSize - 1 do
    begin
      AWord := FTable^[I];
      while AWord <> nil do
      begin
        ATemp := AWord;
        AWord := GetNextWord(AWord);
        DisposeWord(ATemp);
      end;
      FTable^[I] := nil;
    end;
    FCount := 0;
  finally
    LeaveCriticalSection(FLock);
  end;
end;

function TdxSpellCheckerWordList.Find(const S: WideString): Boolean;
begin
  Result := FindWord(S) <> nil;
end;

procedure TdxSpellCheckerWordList.LoadFromStrings(AStrings: TStrings);
var
  I: Integer;
begin
  if AStrings = nil then Exit;
  Clear;
  for I := 0 to AStrings.Count - 1 do
    Add(AStrings[I]);
end;

procedure TdxSpellCheckerWordList.PopulateMetaphoneSuggestions(
  ASuggestionBuilder: TdxSpellCheckerSuggestionBuilder; const AWord: WideString);
var
  AKey: Word;
  ASrcLen, ATestLen: Integer;
  ATestWord: PWideChar;
  ABuffer: array[0..256] of WideChar;
begin
  ASrcLen := Length(AWord);
  if not UseDoubleMetaphone or (ASrcLen = 0) or (ASuggestionBuilder = nil) or Find(AWord) then Exit;
  //FUpperCaseBuffer contains an upper string here
  FMetaphone.DoubleMetaphone(@FUpperCaseBuffer, ASrcLen);
  AKey := FMetaphone.PrimaryKey;
  if AKey = 0 then Exit;
  ATestWord := FMetaphoneTable^[AKey];
  while ATestWord <> nil do
  begin
    ATestLen := WordLength(ATestWord);
    if Abs(ATestLen - ASrcLen) <= ASuggestionBuilder.MaxDistance then
    begin
      LCMapStringW(LangID, LCMAP_UPPERCASE, ATestWord, ATestLen, @ABuffer,
        SizeOf(ABuffer) div SizeOf(WideChar));
      ASuggestionBuilder.CheckAddMetaphoneSuggestion(ATestWord, @ABuffer, ATestLen,
         @FUpperCaseBuffer, ASrcLen);
    end;
    ATestWord := GetNextMetaphoneWord(ATestWord);
  end;
end;

procedure TdxSpellCheckerWordList.SaveToStrings(AStrings: TStrings);
var
  I: Integer;
  AWord: PWideChar;
begin
  if AStrings = nil then Exit;
  AStrings.BeginUpdate;
  try
    AStrings.Clear;
    for I := 0 to FTableSize - 1 do
    begin
      AWord := FTable^[I];
      while AWord <> nil do
      begin
        AStrings.Add(AWord);
        AWord := GetNextWord(AWord);
      end;
    end;
  finally
    AStrings.EndUpdate;
  end;
end;

function TdxSpellCheckerWordList.ElfHash(P: PWideChar; ALength: Integer): Integer;
begin
  Result := dxElfHash(P, ALength, @FUpperCaseBuffer, SizeOf(FUpperCaseBuffer) div SizeOf(WideChar));
end;

function TdxSpellCheckerWordList.FindWord(const S: WideString): PWideChar;
var
  AIndex, ASrcLen, AResultLen: Integer;
  P: PWideChar;
begin
  Result := nil;
  ASrcLen := Length(S);
  if ASrcLen = 0 then Exit;
  P := Pointer(S);
  AIndex := ElfHash(P, ASrcLen) mod FTableSize;
  Result := FTable^[AIndex];
  while Result <> nil do
  begin
    AResultLen := WordLength(Result);
    if (AResultLen = ASrcLen) and
      (CompareStringW(LangID, NORM_IGNORECASE, Result, AResultLen, P, ASrcLen) = CSTR_EQUAL) then Exit;
    Result := GetNextWord(Result);
  end;
end;

function TdxSpellCheckerWordList.NewWord(S: PWideChar; ALength: Integer): PWideChar;
begin
  Result := AllocWord(ALength);
  if UseDoubleMetaphone then
    UpdateMetaphoneInfo(Result, ALength);
  Inc(ALength); //include terminated null
  Move(S^, Result^, ALength * SizeOf(WideChar));
end;

function TdxSpellCheckerWordList.AllocWord(ACharCount: Cardinal): PWideChar;
var
  ASize: Integer;
begin
  ASize := (ACharCount + 1) * Sizeof(WideChar); //add terminated null
  Inc(ASize, SizeOf(Cardinal) * 4); //Size, NextMetaphone, Next, Length
  GetMem(Result, ASize);
  Cardinal(Pointer(Result)^) := ASize;      //Size
  Inc(Integer(Result), SizeOf(Cardinal));
  Pointer(Pointer(Result)^) := nil;         //NextMetaphone
  Inc(Integer(Result), SizeOf(Cardinal));
  Pointer(Pointer(Result)^) := nil;         //Next
  Inc(Integer(Result), SizeOf(Cardinal));
  Cardinal(Pointer(Result)^) := ACharCount; //Length
  Inc(Integer(Result), SizeOf(Cardinal));
end;

procedure TdxSpellCheckerWordList.DisposeWord(AWord: PWideChar);
begin
  if AWord <> nil then
  begin
    Dec(Integer(AWord), SizeOf(Cardinal) * 4);
    FreeMem(AWord, Cardinal(Pointer(AWord)^));
  end;
end;

function TdxSpellCheckerWordList.GetNextMetaphoneWord(AWord: PWideChar): Pointer;
begin
  if AWord = nil then
    Result := nil
  else
  begin
    Dec(Integer(AWord), SizeOf(Cardinal) * 3);
    Result := Pointer(Pointer(AWord)^);
  end;
end;

function TdxSpellCheckerWordList.GetNextWord(AWord: PWideChar): Pointer;
begin
  if AWord = nil then
    Result := nil
  else
  begin
    Dec(Integer(AWord), SizeOf(Cardinal) * 2);
    Result := Pointer(Pointer(AWord)^);
  end;
end;

procedure TdxSpellCheckerWordList.SetNextMetaphoneWord(AWord: PWideChar; AValue: Pointer);
begin
  if AWord <> nil then
  begin
    Dec(Integer(AWord), SizeOf(Cardinal) * 3);
    Pointer(Pointer(AWord)^) := AValue;
  end;
end;

procedure TdxSpellCheckerWordList.SetNextWord(AWord: PWideChar; AValue: Pointer);
begin
  if AWord <> nil then
  begin
    Dec(Integer(AWord), SizeOf(Cardinal) * 2);
    Pointer(Pointer(AWord)^) := AValue;
  end;
end;

function TdxSpellCheckerWordList.WordLength(AWord: PWideChar): Integer;
begin
  if AWord = nil then
    Result := 0
  else
  begin
    Dec(Integer(AWord), SizeOf(Cardinal));
    Result :=  Cardinal(Pointer(AWord)^);
  end;
end;

function TdxSpellCheckerWordList.GetCodePage: Cardinal;
begin
  Result := LanguageToCodePage(FLangID);
end;

procedure TdxSpellCheckerWordList.InitMetaphoneTable;
begin
  if not UseDoubleMetaphone then
    Exit;
  ZeroMemory(FMetaphoneTable, SizeOf(TdxMetaphoneTable));
end;

procedure TdxSpellCheckerWordList.SetUseDoubleMetaphone(AValue: Boolean);
begin
  if FUseDoubleMetaphone <> AValue then
  begin
    FUseDoubleMetaphone := AValue;
    if AValue then
    begin
      FMetaphoneTable := AllocMem(SizeOf(TdxMetaphoneTable));
      FMetaphone := TdxDoubleMetaphone.Create;
    end
    else
    begin
      FreeAndNil(FMetaphone);
      FreeMem(FMetaphoneTable);
      FMetaphoneTable := nil;
    end;
    UpdateWordsMetaphone;
  end;
end;

procedure TdxSpellCheckerWordList.UpdateMetaphoneInfo(ANewWord: PWideChar; ALength: Integer);
var
  AKey: Word;
  AWord, ATemp: PWideChar;
begin
  FMetaphone.DoubleMetaphone(@FUpperCaseBuffer, ALength);
  AKey := FMetaphone.PrimaryKey;
  if AKey = 0 then Exit;
  AWord := FMetaphoneTable^[AKey];
  if AWord = nil then
    FMetaphoneTable^[AKey] := ANewWord
  else
  begin
    repeat
      ATemp := GetNextMetaphoneWord(AWord);
      if ATemp = nil then
      begin
        SetNextMetaphoneWord(AWord, ANewWord);
        Break;
      end;
      AWord := ATemp;
    until False;
  end;
end;

procedure TdxSpellCheckerWordList.UpdateWordsMetaphone;
var
  I, AWordLen: Integer;
  AWord: PWideChar;
begin
  if Count = 0 then Exit;
  for I := 0 to FTableSize - 1 do
  begin
    AWord := FTable^[I];
    while AWord <> nil do
    begin
      if UseDoubleMetaphone then
      begin
        AWordLen := WordLength(AWord);
        LCMapStringW(LangID, LCMAP_UPPERCASE, AWord, AWordLen, @FUpperCaseBuffer,
          SizeOf(FUpperCaseBuffer) div SizeOf(WideChar));
        UpdateMetaphoneInfo(AWord, AWordLen);
      end
      else
        SetNextMetaphoneWord(AWord, nil);
      AWord := GetNextWord(AWord);
    end;
  end;
end;

{ TdxDictionaryLoadThread }

constructor TdxDictionaryLoadThread.Create(
  ADictionary: TdxCustomSpellCheckerDictionary);
begin
  inherited Create(False);
  FDictionary := ADictionary;
  Priority := Dictionary.SpellChecker.ThreadedLoadPriority;
  OnTerminate := Dictionary.ThreadDone;
end;

function TdxDictionaryLoadThread.IsLoadComplete: Boolean;
begin
  Result := not Terminated and Dictionary.Loaded;
end;

procedure TdxDictionaryLoadThread.Execute;
begin
  FFinished := False;
  try
    ResetException;
    try
      with Dictionary do
      begin
        try
          Synchronize(UpdateLoadedOnLoadEvent);
          if not Loaded then
            FLoaded := DoLoad and not Terminated;
        except
          FLoaded := False;
          raise;
        end;
        if Loaded then
          Synchronize(LoadingComplete);
      end;
    except
      HandleException;
    end;
  finally
    FFinished := True;
  end;
end;

{ TdxCustomSpellCheckerDictionary }

constructor TdxCustomSpellCheckerDictionary.Create(ASpellChecker: TdxCustomSpellChecker);
begin
  inherited Create(ASpellChecker);
  FEnabled := True;
  FCodePage := CP_ACP;
  InitializeContent;
  Language := GetSystemDefaultLangID;
  FTimeout := 0;
end;

destructor TdxCustomSpellCheckerDictionary.Destroy;
begin
  Terminate;
  FLoadThread.Free;    //don't use FreeAndNil
  FLoadThread := nil;
  Unload;
  FreeContent;
  inherited Destroy;
end;

procedure TdxCustomSpellCheckerDictionary.Assign(Source: TPersistent);
begin
  if Source is TdxCustomSpellCheckerDictionary then
  begin
    FAlphabet := TdxCustomSpellCheckerDictionary(Source).Alphabet;
    FCodePage := TdxCustomSpellCheckerDictionary(Source).CodePage;
    FEnabled := TdxCustomSpellCheckerDictionary(Source).Enabled;
    FLanguage := TdxCustomSpellCheckerDictionary(Source).Language;
    FTimeout := TdxCustomSpellCheckerDictionary(Source).Timeout;
  end;
end;

procedure TdxCustomSpellCheckerDictionary.Activate;
begin
  DoActivate;
end;

procedure TdxCustomSpellCheckerDictionary.Load(
  AMode: TdxSpellCheckerDictionaryLoadMode = dlmDefault);
begin
  case AMode of
    dlmDefault:
      begin
        if SpellChecker.UseThreadedLoad then
          LoadUsingThread
        else
          DirectLoad;
      end;
    dlmDirectLoad:
      DirectLoad;
    dlmThreadedLoad:
      LoadUsingThread;
  end;
end;

procedure TdxCustomSpellCheckerDictionary.Unload;
begin
  if LoadThread <> nil then
    LoadThread.Terminate;
  if Loaded then
    FLoaded := not DoUnload;
  if not Loaded then
    Cleanup;
  Update;
end;

procedure TdxCustomSpellCheckerDictionary.Clear;
begin
  Enabled := False;
  Unload;
end;

function TdxCustomSpellCheckerDictionary.CanLoad: Boolean;
begin
  Result := not Loaded and ((FLoadThread = nil) or FLoadThread.Finished);
end;

function TdxCustomSpellCheckerDictionary.CanUseDoubleMetaphone: Boolean;
begin
  Result := False;
end;

procedure TdxCustomSpellCheckerDictionary.Cleanup;
begin
end;

function TdxCustomSpellCheckerDictionary.CreateSuggestionBuilder: TdxSpellCheckerSuggestionBuilder;
begin
  Result := TdxNearMissStrategy.Create(Self);
end;

procedure TdxCustomSpellCheckerDictionary.DirectLoad;
begin
  if not CanLoad then Exit;
  ShowHourglassCursor;
  try
    try
      FLoaded := DoLoadingEvent or DoLoad;
    except
      FLoaded := False;
      raise;
    end;
    if Loaded then
      LoadingComplete;
  finally
    HideHourglassCursor;
  end;
end;

procedure TdxCustomSpellCheckerDictionary.DoActivate;
begin
  Load;
  Enabled := True;
end;

function TdxCustomSpellCheckerDictionary.DoLoad: Boolean;
begin
  Result := False;
end;

procedure TdxCustomSpellCheckerDictionary.DoLoadedEvent;
begin
  if Assigned(FOnLoaded) then
    FOnLoaded(Self);
end;

function TdxCustomSpellCheckerDictionary.DoLoadingEvent: Boolean;
begin
  Result := False;
  if Assigned(FOnLoading) then
    FOnLoading(Self, Result);
end;

function TdxCustomSpellCheckerDictionary.DoUnload: Boolean;
begin
  Result := True;
end;

procedure TdxCustomSpellCheckerDictionary.FreeContent;
begin
end;

function TdxCustomSpellCheckerDictionary.GetActiveAlphabet: WideString;
begin
  if Alphabet = '' then
    Result := CreateDefaultAlphabet(CodePage)
  else
    Result := Alphabet;
end;

function TdxCustomSpellCheckerDictionary.GetDisplayName: string;
begin
  Result := GetRegisteredDictionaryTypes.GetDescriptionByClass(ClassType);
  if Result = '' then
    Result := ClassName;
end;

procedure TdxCustomSpellCheckerDictionary.InitializeContent;
begin
end;

function TdxCustomSpellCheckerDictionary.IsEnglishLanguage: Boolean;
begin
  Result := (Language and $3FF) = LANG_ENGLISH;
end;

procedure TdxCustomSpellCheckerDictionary.LanguageChanged;
begin
end;

procedure TdxCustomSpellCheckerDictionary.LoadingComplete;
begin
  DoLoadedEvent;
  Update;
end;

function TdxCustomSpellCheckerDictionary.LoadingTerminated: Boolean;
begin
  Result := FTerminated or (FLoadThread <> nil) and FLoadThread.Terminated;
end;

procedure TdxCustomSpellCheckerDictionary.LoadUsingThread;
begin
  if not CanLoad then Exit;
  FreeAndNil(FLoadThread);
  FLoadThread := TdxDictionaryLoadThread.Create(Self);
end;

procedure TdxCustomSpellCheckerDictionary.PopulateCapitalizationSuggestions(
  ASuggestionBuilder: TdxSpellCheckerSuggestionBuilder; const AWord: WideString);
begin
end;

procedure TdxCustomSpellCheckerDictionary.PopulateMetaphoneSuggestions(
  ASuggestionBuilder: TdxSpellCheckerSuggestionBuilder; const AWord: WideString);
begin
end;

procedure TdxCustomSpellCheckerDictionary.Reload;
begin
  if Loaded then
  begin
    Unload;
    Load;
    Update;
  end;
end;

procedure TdxCustomSpellCheckerDictionary.Terminate;
begin
  FTerminated := True;
end;

procedure TdxCustomSpellCheckerDictionary.ThreadDone(Sender: TObject);
begin
  if not LoadThread.IsLoadComplete then
    Cleanup
  else
    SpellChecker.CheckCallEnabledDictionariesLoaded;
end;

procedure TdxCustomSpellCheckerDictionary.Update;
begin
  SpellChecker.UpdateByDictionary(Self);
end;

procedure TdxCustomSpellCheckerDictionary.UpdateLoadedOnLoadEvent;
begin
  FLoaded := DoLoadingEvent;
end;

procedure TdxCustomSpellCheckerDictionary.UpdateUsingMetaphone;
begin
end;

procedure TdxCustomSpellCheckerDictionary.UpdateWordChars(var AWordChars: WideString);
begin
end;

function TdxCustomSpellCheckerDictionary.GetActive: Boolean;
begin
  Result := Loaded and Enabled;
end;

function TdxCustomSpellCheckerDictionary.HasWord(
  const AWord: WideString): Boolean;
begin
  Result := False;
end;

procedure TdxCustomSpellCheckerDictionary.SetEnabled(AValue: Boolean);
begin
  if FEnabled <> AValue then
  begin
    FEnabled := AValue;
    if Loaded then
      Update;
  end;
end;

procedure TdxCustomSpellCheckerDictionary.SetCodePage(AValue: Cardinal);
begin
  if FCodePage <> AValue then
  begin
    FCodePage := AValue;
    Reload;
  end;
end;

procedure TdxCustomSpellCheckerDictionary.SetLanguage(const AValue: DWORD);
begin
  if FLanguage <> AValue then
  begin
    FLanguage := AValue;
    LanguageChanged;
  end;
end;

{ TdxSpellCheckerDictionary }

procedure TdxSpellCheckerDictionary.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
  if Source is TdxSpellCheckerDictionary then
    FCheckCapitalization := TdxSpellCheckerDictionary(Source).CheckCapitalization;
end;

function TdxSpellCheckerDictionary.HasWord(
  const AWord: WideString): Boolean;
var
  AWordInDictionary: PWideChar;
begin
  AWordInDictionary := FWords.FindWord(AWord);
  Result := (AWordInDictionary <> nil);
  if Result and CheckCapitalization then
    Result := IsCorrectCapitalization(AWord, AWordInDictionary);
end;

function TdxSpellCheckerDictionary.CanUseDoubleMetaphone: Boolean;
begin
  Result := Words.UseDoubleMetaphone;
end;

procedure TdxSpellCheckerDictionary.Cleanup;
begin
  Words.Clear;
end;

function TdxSpellCheckerDictionary.DoUnload: Boolean;
begin
  Words.Clear;
  Result := True;
end;

procedure TdxSpellCheckerDictionary.FreeContent;
begin
  FWords.Free;
end;

procedure TdxSpellCheckerDictionary.InitializeContent;
begin
  FWords := TdxSpellCheckerWordList.Create(CodePage, 269683);
end;

function TdxSpellCheckerDictionary.IsCorrectCapitalization(
  const AWord, APattern: WideString): Boolean;
begin
  case GetWordCapitalizationType(APattern) of
    ctLower: Result := GetWordCapitalizationType(AWord) in [ctLower,ctCapitalized, ctUpper];
    ctUpper: Result := GetWordCapitalizationType(AWord) = ctUpper;
    ctCapitalized: Result := GetWordCapitalizationType(AWord) in [ctCapitalized, ctUpper];
    ctMixed: Result := (AWord = APattern) or (GetWordCapitalizationType(AWord) = ctUpper);
  else
    Result := True;
  end;
end;

procedure TdxSpellCheckerDictionary.LanguageChanged;
begin
  Words.LangID := FLanguage;
  UpdateUsingMetaphone;
end;

procedure TdxSpellCheckerDictionary.PopulateCapitalizationSuggestions(
  ASuggestionBuilder: TdxSpellCheckerSuggestionBuilder; const AWord: WideString);
var
  AWordInDictionary: PWideChar;
begin
  if not CheckCapitalization then
    Exit;
  AWordInDictionary := Words.FindWord(AWord);
  if AWordInDictionary <> nil then
    ASuggestionBuilder.Suggestions.Add(AWordInDictionary, Self, 1);
end;

procedure TdxSpellCheckerDictionary.PopulateMetaphoneSuggestions(
  ASuggestionBuilder: TdxSpellCheckerSuggestionBuilder; const AWord: WideString);
begin
  Words.PopulateMetaphoneSuggestions(ASuggestionBuilder, AWord);
end;

procedure TdxSpellCheckerDictionary.UpdateUsingMetaphone;
begin
  FWords.UseDoubleMetaphone := IsEnglishLanguage and
    (SpellChecker.MetaphoneDistance > 1);
end;

function TdxSpellCheckerDictionary.GetWordCount: Integer;
begin
  Result := FWords.Count;
end;

procedure TdxSpellCheckerDictionary.SetCheckCapitalization(AValue: Boolean);
begin
  if FCheckCapitalization <> AValue then
  begin
    FCheckCapitalization := AValue;
    Words.FindMostValidCapitalizationInDuplicates := AValue;
    Reload;
  end;
end;

{ TdxUserSpellCheckerDictionary }

constructor TdxUserSpellCheckerDictionary.Create(
  ASpellChecker: TdxCustomSpellChecker);
begin
  inherited Create(ASpellChecker);
  FOptions := [udSaveOnUnload];
end;

procedure TdxUserSpellCheckerDictionary.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
  if Source is TdxUserSpellCheckerDictionary then
  begin
    DictionaryPath := TdxUserSpellCheckerDictionary(Source).DictionaryPath;
    Options := TdxUserSpellCheckerDictionary(Source).Options;
  end;
end;

procedure TdxUserSpellCheckerDictionary.AddWord(const AWord: WideString);
begin
  Words.Add(AWord);
  Update;
end;

procedure TdxUserSpellCheckerDictionary.LoadFromStrings(AStrings: TStrings);
begin
  Words.LoadFromStrings(AStrings);
  Update;
end;

procedure TdxUserSpellCheckerDictionary.SaveToStrings(AStrings: TStrings);
begin
  if AStrings = nil then Exit;
  Words.SaveToStrings(AStrings);
  if AStrings is TStringList then
    TStringList(AStrings).Sort;
end;

function TdxUserSpellCheckerDictionary.DoLoad: Boolean;
var
  AStrings: TStrings;
begin
  Result := True;
  if not FileExists(DictionaryPath) then
    if not (udFileMustExist in Options) then Exit;
  AStrings := TStringList.Create;
  try
    AStrings.LoadFromFile(DictionaryPath);
    Words.LoadFromStrings(AStrings);
  finally
    AStrings.Free;
  end;
end;

function TdxUserSpellCheckerDictionary.DoUnload: Boolean;
var
  AStrings: TStrings;
begin
  Result := True;
  if udSaveOnUnload in Options then
  begin
    AStrings := TStringList.Create;
    try
      Words.SaveToStrings(AStrings);
      try
        AStrings.SaveToFile(DictionaryPath);
      except
        if not (csDestroying in SpellChecker.ComponentState) then
          raise;
      end;
    finally
      AStrings.Free;
    end;
  end;
end;

function TdxUserSpellCheckerDictionary.GetDisplayName: string;
var
  AFileName: TFileName;
begin
  Result := inherited GetDisplayName;
  AFileName := SysUtils.ExtractFileName(DictionaryPath);
  if AFileName <> '' then
    Result := Format('%s (%s)', [Result, AFileName]);
end;

{ TdxSpellCheckerDictionaryItem }

destructor TdxSpellCheckerDictionaryItem.Destroy;
begin
  FreeAndNil(FDictionaryType);
  inherited Destroy;
end;

procedure TdxSpellCheckerDictionaryItem.Assign(Source: TPersistent);
begin
  if Source is TdxSpellCheckerDictionaryItem then
  begin
    DictionaryTypeClassName := TdxSpellCheckerDictionaryItem(Source).DictionaryTypeClassName;
    DictionaryType := TdxSpellCheckerDictionaryItem(Source).DictionaryType;
  end;
end;

function TdxSpellCheckerDictionaryItem.GetDisplayName: string;
begin
  if FDictionaryType <> nil then
    Result := FDictionaryType.GetDisplayName
  else
    Result := inherited GetDisplayName;
end;

procedure TdxSpellCheckerDictionaryItem.RecreateDictionaryType;
begin
  FreeAndNil(FDictionaryType);
  if FDictionaryTypeClass <> nil then
    FDictionaryType := FDictionaryTypeClass.Create(Collection.SpellChecker);
end;

function TdxSpellCheckerDictionaryItem.GetCollection: TdxSpellCheckerDictionaries;
begin
  Result := TdxSpellCheckerDictionaries(inherited Collection);
end;

function TdxSpellCheckerDictionaryItem.GetDictionaryTypeClassName: string;
begin
  if FDictionaryType = nil then
    Result := ''
  else
    Result := FDictionaryType.ClassName;
end;

procedure TdxSpellCheckerDictionaryItem.SetDictionaryType(
  AValue: TdxCustomSpellCheckerDictionary);
begin
  if (FDictionaryType <> nil) and (AValue <> nil) then
    FDictionaryType.Assign(AValue);
end;

procedure TdxSpellCheckerDictionaryItem.SetDictionaryTypeClass(
  AValue: TdxCustomSpellCheckerDictionaryClass);
begin
  if FDictionaryTypeClass <> AValue then
  begin
    FDictionaryTypeClass := AValue;
    RecreateDictionaryType;
  end;
end;

procedure TdxSpellCheckerDictionaryItem.SetDictionaryTypeClassName(
  const AValue: string);
begin
  if not SameText(DictionaryTypeClassName, AValue) then
  begin
    with GetRegisteredDictionaryTypes do
      DictionaryTypeClass := TdxCustomSpellCheckerDictionaryClass(FindByClassName(AValue));
  end;
end;

{ TdxSpellCheckerDictionaries }

constructor TdxSpellCheckerDictionaries.Create(ASpellChecker: TdxCustomSpellChecker);
begin
  inherited Create(TdxSpellCheckerDictionaryItem);
  FSpellChecker := ASpellChecker;
end;

function TdxSpellCheckerDictionaries.Add: TdxSpellCheckerDictionaryItem;
begin
  Result := TdxSpellCheckerDictionaryItem(inherited Add);
end;

function TdxSpellCheckerDictionaries.GetNamePath: string;
var
  S: string;
begin
  S := SpellChecker.Name;
  if S = '' then
    S := SpellChecker.GetNamePath;
  Result := S + '.' + 'Items';
end;

function TdxSpellCheckerDictionaries.GetOwner: TPersistent;
begin
  Result := SpellChecker;
end;

function TdxSpellCheckerDictionaries.GetItem(
  Index: Integer): TdxSpellCheckerDictionaryItem;
begin
  Result := TdxSpellCheckerDictionaryItem(inherited Items[Index]);
end;

procedure TdxSpellCheckerDictionaries.SetItem(Index: Integer;
  AValue: TdxSpellCheckerDictionaryItem);
begin
  inherited Items[Index] := AValue;
end;

{ TdxSpellCheckerCustomOptions }

constructor TdxSpellCheckerCustomOptions.Create(ASpellChecker: TdxCustomSpellChecker);
begin
  inherited Create(ASpellChecker);
  InitializeOptions;
end;

procedure TdxSpellCheckerCustomOptions.InitializeOptions;
begin
end;

{ TdxSpellCheckerAutoCorrectExceptions }

constructor TdxSpellCheckerAutoCorrectExceptions.Create(AOptions: TdxSpellCheckerAutoCorrectOptions);
begin
  inherited Create;
  InitializeCriticalSection(FLock);
  FOptions := AOptions;
  FAutoInclude := True;
  FCount := 0;
end;

destructor TdxSpellCheckerAutoCorrectExceptions.Destroy;
begin
  Clear;
  DeleteCriticalSection(FLock);
  inherited Destroy;
end;

function TdxSpellCheckerAutoCorrectExceptions.Add(const AException: WideString): Integer;
var
  ALen: Integer;
  S: WideString;
begin
  S := AException;
  if not DoAdd(S) then
  begin
    Result := -1;
    Exit;
  end;
  ALen := Length(S);
  if ALen = 0 then
  begin
    Result := -1;
    Exit;
  end;
  Result := Find(S);
  if Result = -1 then
  begin
    EnterCriticalSection(FLock);
    try
      Result := Count;
      SetCount(Count + 1);
      FList^[Result] := AllocMem((ALen + 1) * SizeOf(WideChar));
      Move(PWideChar(S)^, FList^[Result]^, ALen * SizeOf(WideChar));
    finally
      LeaveCriticalSection(FLock);
    end;
  end;
end;

procedure TdxSpellCheckerAutoCorrectExceptions.Clear;
var
  I: Integer;
begin
  if Count = 0 then Exit;
  EnterCriticalSection(FLock);
  try
    for I := 0 to FCount - 1 do
      DisposeException(FList^[I]);
    SetCount(0);
  finally
    LeaveCriticalSection(FLock);
  end;
end;

procedure TdxSpellCheckerAutoCorrectExceptions.Delete(AIndex: Integer);
var
  I: Integer;
begin
  if (AIndex < 0) or (AIndex >= Count) or (FList[AIndex] = nil) or not DoDelete(PWideChar(FList^[AIndex])) then
    Exit;
  DisposeException(FList^[AIndex]);
  for I := AIndex to Count - 2 do
    FList^[I] := FList^[I + 1];
  SetCount(Count - 1);
end;

procedure TdxSpellCheckerAutoCorrectExceptions.Delete(const AException: WideString);
begin
  Delete(Find(AException));
end;

function TdxSpellCheckerAutoCorrectExceptions.Find(const AException: WideString): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := 0 to Count - 1 do
    if WideCompareStr(AException, Exceptions[I]) = 0 then
    begin
      Result := I;
      Break;
    end;
end;

procedure TdxSpellCheckerAutoCorrectExceptions.LoadFromFile(const AFileName: WideString);
var
  AStream: TStream;
begin
  AStream := TFileStream.Create(AFileName, fmOpenRead or fmShareDenyWrite);
  try
    LoadFromStream(AStream);
  finally
    AStream.Free;
  end;
end;

procedure TdxSpellCheckerAutoCorrectExceptions.LoadFromStream(AStream: TStream);
var
  ADocument: TdxXMLDocument;
  ANode, ARootNode: TdxXMLNode;
  I: Integer;
begin
  Clear;
  ADocument := TdxXMLDocument.Create;
  try
    ADocument.LoadFromStream(AStream);
    ARootNode := ADocument.FindNode('block-list:block-list');
    if ARootNode <> nil then
      for I := 0 to ARootNode.ChildCount - 1 do
      begin
        ANode := ARootNode.ChildList[I];
        Add(ANode.GetValue('block-list:abbreviated-name'));
      end;
  finally
    FreeAndNil(ADocument);
  end;
end;

procedure TdxSpellCheckerAutoCorrectExceptions.PopulateExceptions(AList: TStrings);
var
  I: Integer;
begin
  if AList = nil then
    Exit;
  for I := 0 to Count - 1 do
    AList.Add(Exceptions[I]);
end;

procedure TdxSpellCheckerAutoCorrectExceptions.SaveToFile(const AFileName: WideString);
var
  AStream: TStream;
begin
  AStream := TFileStream.Create(AFileName, fmCreate);
  try
    SaveToStream(AStream);
  finally
    AStream.Free;
  end;
end;

procedure TdxSpellCheckerAutoCorrectExceptions.SaveToStream(AStream: TStream);
var
  ADocument: TdxXMLDocument;
  ANode, ARootNode: TdxXMLNode;
  I: Integer;
begin
  ADocument := TdxXMLDocument.Create;
  try
    ADocument.Encoding := 'UTF-8';
    ARootNode := TdxXMLNode.Create;
    ARootNode.NodeName := 'block-list:block-list';
    ARootNode.NameSpaces := 'http://www.devexpress.com';
    ADocument.Nodes.Add(ARootNode);
    for I := 0 to Count - 1 do
    begin
      ANode := TdxXMLNode.Create;
      ANode.NodeName := 'block-list:block';
      ANode.AddAttribute('block-list:abbreviated-name', Exceptions[I]);
      ARootNode.AddChild(ANode);
    end;
    ADocument.SaveToStream(AStream);
  finally
    FreeAndNil(ADocument);
  end;
end;

procedure TdxSpellCheckerAutoCorrectExceptions.DisposeException(AException: PWideChar);
begin
  if AException <> nil then
    FreeMem(AException, Cardinal(Pointer(AException)^));
end;

function TdxSpellCheckerAutoCorrectExceptions.DoAdd(var AException: WideString): Boolean;
begin
  Result := True;
  if Assigned(OnAdd) then
    OnAdd(Self, AException, Result);
end;

function TdxSpellCheckerAutoCorrectExceptions.DoDelete(const AException: WideString): Boolean;
begin
  Result := True;
  if Assigned(OnDelete) then
    OnDelete(Self, AException, Result);
end;

procedure TdxSpellCheckerAutoCorrectExceptions.SetCount(AValue: Integer);
begin
  FCount := AValue;
  if FCount > 0 then
    FList := ReallocMemory(FList, FCount * SizeOf(Cardinal))
  else
    if FList <> nil then
    begin
      FreeMem(FList);
      FList := nil;
    end;
end;

function TdxSpellCheckerAutoCorrectExceptions.GetException(
  Index: Integer): WideString;
begin
  if (Index < 0) or (Index > Count - 1) then
    TList.Error(@SListIndexError, Index);
  Result := PWideChar(FList^[Index]);
end;

{ TdxSpellCheckerAutoCorrectReplacementList }

procedure TdxSpellCheckerAutoCorrectReplacementList.LoadFromFile(const AFileName: WideString);
var
  AStream: TStream;
begin
  AStream := TFileStream.Create(AFileName, fmOpenRead or fmShareDenyWrite);
  try
    LoadFromStream(AStream);
  finally
    AStream.Free;
  end;
end;

procedure TdxSpellCheckerAutoCorrectReplacementList.LoadFromStream(AStream: TStream);
var
  ADocument: TdxXMLDocument;
  ANode, ARootNode: TdxXMLNode;
  I: Integer;
begin
  Clear;
  ADocument := TdxXMLDocument.Create;
  try
    ADocument.LoadFromStream(AStream);
    ARootNode := ADocument.FindNode('block-list:block-list');
    if ARootNode <> nil then
      for I := 0 to ARootNode.ChildCount - 1 do
      begin
        ANode := ARootNode.ChildList[I];
        Add(ANode.GetValue('block-list:abbreviated-name'), ANode.GetValue('block-list:name'));
      end;
  finally
    FreeAndNil(ADocument);
  end;
end;

procedure TdxSpellCheckerAutoCorrectReplacementList.SaveToFile(const AFileName: WideString);
var
  AStream: TStream;
begin
  AStream := TFileStream.Create(AFileName, fmCreate);
  try
    SaveToStream(AStream);
  finally
    AStream.Free;
  end;
end;

procedure TdxSpellCheckerAutoCorrectReplacementList.SaveToStream(AStream: TStream);
var
  ADocument: TdxXMLDocument;
  ANode, ARootNode: TdxXMLNode;
  I: Integer;
begin
  ADocument := TdxXMLDocument.Create;
  try
    ADocument.Encoding := 'UTF-8';
    ARootNode := TdxXMLNode.Create;
    ARootNode.NodeName := 'block-list:block-list';
    ARootNode.NameSpaces := 'http://www.devexpress.com';
    ADocument.Nodes.Add(ARootNode);
    for I := 0 to Count - 1 do
    begin
      ANode := TdxXMLNode.Create;
      ANode.NodeName := 'block-list:block';
      ANode.AddAttribute('block-list:abbreviated-name', Items[I].Text);
      ANode.AddAttribute('block-list:name', Items[I].Replacement);
      ARootNode.AddChild(ANode);
    end;
    ADocument.SaveToStream(AStream);
  finally
    FreeAndNil(ADocument);
  end;
end;

{ TdxSpellCheckerAutoCorrectOptions }

destructor TdxSpellCheckerAutoCorrectOptions.Destroy;
begin
  FreeAndNil(FFirstLetterExceptions);
  FreeAndNil(FInitialCapsExceptions);
  FreeAndNil(FReplacements);
  inherited Destroy;
end;

procedure TdxSpellCheckerAutoCorrectOptions.Assign(Source: TPersistent);
begin
  if Source is TdxSpellCheckerAutoCorrectOptions then
    with TdxSpellCheckerAutoCorrectOptions(Source) do
    begin
      Self.FActive := Active;
      Self.FAutomaticallyUseSuggestions := AutomaticallyUseSuggestions;
      Self.FCorrectSentenceCaps := CorrectSentenceCaps;
      Self.FCorrectCapsLock := CorrectCapsLock;
      Self.FCorrectInitialCaps := CorrectInitialCaps;
      Self.FDisableCapsLock := DisableCapsLock;
      Self.FReplaceTextAsYouType := ReplaceTextAsYouType;
    end;
  inherited Assign(Source);
end;

function TdxSpellCheckerAutoCorrectOptions.GetReplacement(const AText: WideString;
  out AReplacement: WideString): Boolean;

  function WordContainsOnlyAlpha(const S: WideString): Boolean;
  var
    I: Integer;
    ALen: Integer;
  begin
    ALen := Length(S);
    Result := ALen > 0;
    if Result then
      for I := 1 to ALen do
      begin
        Result := dxWideIsAlpha(S[I]);
        if not Result then
          Break;
      end;
  end;

var
  AItem: TdxSpellCheckerReplacement;
  ASuggestions: TdxSpellCheckerSuggestionList;
begin
  AItem := Replacements.FindReplacement(AText);
  Result := AItem <> nil;
  if Result then
    AReplacement := AItem.Replacement
  else
    if AutomaticallyUseSuggestions and WordContainsOnlyAlpha(AText) then
    begin
      ASuggestions := SpellChecker.GetSuggestions(AText);
      try
        Result := ASuggestions.Count = 1;
        if Result then
          AReplacement := ASuggestions.Items[0].Word;
      finally
        FreeAndNil(ASuggestions);
      end;
    end;
end;

procedure TdxSpellCheckerAutoCorrectOptions.Changed;
begin
  if SpellChecker.CheckAsYouTypeManager <> nil then
    SpellChecker.AutoCorrectManager.DoOptionsChanged;
  DoChanged;
end;

procedure TdxSpellCheckerAutoCorrectOptions.DoChanged;
begin
  if Assigned(FOnChanged) then
    FOnChanged(Self);
end;

procedure TdxSpellCheckerAutoCorrectOptions.InitializeOptions;
begin
  FActive := False;
  FAutomaticallyUseSuggestions := True;
  FCorrectSentenceCaps := True;
  FCorrectCapsLock := True;
  FCorrectInitialCaps := True;
  FDisableCapsLock := False;
  FReplaceTextAsYouType := True;
  FFirstLetterExceptions := TdxSpellCheckerAutoCorrectExceptions.Create(Self);
  FFirstLetterExceptions.OnAdd := FirstLetterExceptionAddHandler;
  FInitialCapsExceptions := TdxSpellCheckerAutoCorrectExceptions.Create(Self);
  FInitialCapsExceptions.OnAdd := InitialCapsExceptionAddHandler;
  FReplacements := TdxSpellCheckerAutoCorrectReplacementList.Create;
end;

procedure TdxSpellCheckerAutoCorrectOptions.FirstLetterExceptionAddHandler(Sender: TdxSpellCheckerAutoCorrectExceptions;
  var AException: WideString; var AAllow: Boolean);
var
  ALen, I: Integer;
  ACorrectException: Boolean;
begin
  AAllow := False;
  ALen := Length(AException);
  if ALen > 0 then
  begin
    ACorrectException := True;
    for I := 1 to ALen do
    begin
      ACorrectException := dxWideIsAlpha(AException[I]);
      if I = ALen then
        ACorrectException := ACorrectException or (AException[I] = '.');
      if not ACorrectException then
        Break;
    end;
    if ACorrectException then
    begin
      if AException[ALen] <> '.' then
        AException := AException + '.';
      AException := WideLowerCase(AException);
      AAllow := True;
    end;
  end;
end;

procedure TdxSpellCheckerAutoCorrectOptions.InitialCapsExceptionAddHandler(Sender: TdxSpellCheckerAutoCorrectExceptions;
  var AException: WideString; var AAllow: Boolean);
var
  S: WideString;
  ALen, I: Integer;
begin
  AAllow := False;
  AException := WideLowerCase(AException);
  ALen := Length(AException);
  if ALen > 2 then
  begin
    for I := 1 to ALen do
    begin
      AAllow := dxWideIsAlpha(AException[I]);
      if not AAllow then
        Break;
    end;
    if AAllow then
    begin
      S := WideUpperCase(AException);
      AException[1] := S[1];
      AException[2] := S[2];
    end;
  end;
end;

procedure TdxSpellCheckerAutoCorrectOptions.SetActive(
  const AValue: Boolean);
begin
  if FActive <> AValue then
  begin
    FActive := AValue;
    SpellChecker.AutoCorrectManager.DoActiveChanged;
    Changed;
  end;
end;

procedure TdxSpellCheckerAutoCorrectOptions.SetAutomaticallyUseSuggestions(
  const AValue: Boolean);
begin
  if FAutomaticallyUseSuggestions <> AValue then
  begin
    FAutomaticallyUseSuggestions := AValue;
    Changed;
  end;
end;

procedure TdxSpellCheckerAutoCorrectOptions.SetCorrectCapsLock(
  const AValue: Boolean);
begin
  if FCorrectCapsLock <> AValue then
  begin
    FCorrectCapsLock := AValue;
    Changed;
  end;
end;

procedure TdxSpellCheckerAutoCorrectOptions.SetCorrectInitialCaps(
  const AValue: Boolean);
begin
  if FCorrectInitialCaps <> AValue then
  begin
    FCorrectInitialCaps := AValue;
    Changed;
  end;
end;

procedure TdxSpellCheckerAutoCorrectOptions.SetCorrectSentenceCaps(
  const AValue: Boolean);
begin
  if FCorrectSentenceCaps <> AValue then
  begin
    FCorrectSentenceCaps := AValue;
    Changed;
  end;
end;

procedure TdxSpellCheckerAutoCorrectOptions.SetDisableCapsLock(
  const AValue: Boolean);
begin
  if FDisableCapsLock <> AValue then
  begin
    FDisableCapsLock := AValue;
    Changed;
  end;
end;

procedure TdxSpellCheckerAutoCorrectOptions.SetReplaceTextAsYouType(
  const AValue: Boolean);
begin
  if FReplaceTextAsYouType <> AValue then
  begin
    FReplaceTextAsYouType := AValue;
    Changed;
  end;
end;

{ TdxSpellCheckerSpellingOptions }

procedure TdxSpellCheckerSpellingOptions.Assign(Source: TPersistent);
begin
  if Source is TdxSpellCheckerSpellingOptions then
  begin
    FIgnoreMixedCaseWords := TdxSpellCheckerSpellingOptions(Source).IgnoreMixedCaseWords;
    FIgnoreUpperCaseWords := TdxSpellCheckerSpellingOptions(Source).IgnoreUpperCaseWords;
    FIgnoreMarkupTags := TdxSpellCheckerSpellingOptions(Source).IgnoreMarkupTags;
    FIgnoreRepeatedWords := TdxSpellCheckerSpellingOptions(Source).IgnoreRepeatedWords;
    FCheckSelectedTextFirst := TdxSpellCheckerSpellingOptions(Source).CheckSelectedTextFirst;
    FIgnoreUrls := TdxSpellCheckerSpellingOptions(Source).IgnoreUrls;
    FCheckFromCursorPos := TdxSpellCheckerSpellingOptions(Source).CheckFromCursorPos;
    FIgnoreEmails := TdxSpellCheckerSpellingOptions(Source).IgnoreEmails;
    FIgnoreWordsWithNumbers := TdxSpellCheckerSpellingOptions(Source).IgnoreWordsWithNumbers;
  end;
end;

procedure TdxSpellCheckerSpellingOptions.Changed;
begin
  SpellChecker.SpellingOptionsChanged;
  DoChanged;
end;

procedure TdxSpellCheckerSpellingOptions.DoChanged;
begin
  if Assigned(FOnChanged) then
    FOnChanged(Self);
end;

procedure TdxSpellCheckerSpellingOptions.InitializeOptions;
begin
  FIgnoreMixedCaseWords := True;
  FIgnoreUpperCaseWords := True;
  FIgnoreMarkupTags := True;
  FIgnoreRepeatedWords := False;
  FCheckSelectedTextFirst := True;
  FIgnoreUrls := True;
  FCheckFromCursorPos := False;
  FIgnoreEmails := True;
  FIgnoreWordsWithNumbers := True;
end;

procedure TdxSpellCheckerSpellingOptions.PopulateRules(
  ARules: TdxSpellCheckerRules; AParser: TdxSpellCheckerTextParser);
begin
  if AParser = nil then
    Exit;
  if not IgnoreRepeatedWords then
    ARules.Add(TdxSpellCheckerRepeatedWordsRule.Create(AParser));
  if IgnoreEmails then
    ARules.Add(TdxSpellCheckerIgnoreEmailRule.Create(AParser));
  if IgnoreMixedCaseWords then
    ARules.Add(TdxSpellCheckerIgnoreMixedCaseWordsRule.Create(AParser));
  if IgnoreUpperCaseWords then
    ARules.Add(TdxSpellCheckerIgnoreUpperCaseWordsRule.Create(AParser));
  if IgnoreUrls then
    ARules.Add(TdxSpellCheckerIgnoreUrlRule.Create(AParser));
  if IgnoreWordsWithNumbers then
    ARules.Add(TdxSpellCheckerIgnoreWordsWithNumbersRule.Create(AParser));
end;

procedure TdxSpellCheckerSpellingOptions.SetCheckFromCursorPos(
  AValue: Boolean);
begin
  if FCheckFromCursorPos <> AValue then
  begin
    FCheckFromCursorPos := AValue;
    Changed;
  end;
end;

procedure TdxSpellCheckerSpellingOptions.SetCheckSelectedTextFirst(
  AValue: Boolean);
begin
  if FCheckSelectedTextFirst <> AValue then
  begin
    FCheckSelectedTextFirst := AValue;
    Changed;
  end;
end;

procedure TdxSpellCheckerSpellingOptions.SetIgnoreEmails(
  AValue: Boolean);
begin
  if FIgnoreEmails <> AValue then
  begin
    FIgnoreEmails := AValue;
    Changed;
  end;
end;

procedure TdxSpellCheckerSpellingOptions.SetIgnoreMarkupTags(
  AValue: Boolean);
begin
  if FIgnoreMarkupTags <> AValue then
  begin
    FIgnoreMarkupTags := AValue;
    Changed;
  end;
end;

procedure TdxSpellCheckerSpellingOptions.SetIgnoreMixedCaseWords(
  AValue: Boolean);
begin
  if FIgnoreMixedCaseWords <> AValue then
  begin
    FIgnoreMixedCaseWords := AValue;
    Changed;
  end;
end;

procedure TdxSpellCheckerSpellingOptions.SetIgnoreRepeatedWords(
  AValue: Boolean);
begin
  if FIgnoreRepeatedWords <> AValue then
  begin
    FIgnoreRepeatedWords := AValue;
    Changed;
  end;
end;

procedure TdxSpellCheckerSpellingOptions.SetIgnoreUpperCaseWords(
  AValue: Boolean);
begin
  if FIgnoreUpperCaseWords <> AValue then
  begin
    FIgnoreUpperCaseWords := AValue;
    Changed;
  end;
end;

procedure TdxSpellCheckerSpellingOptions.SetIgnoreUrls(
  AValue: Boolean);
begin
  if FIgnoreUrls <> AValue then
  begin
    FIgnoreUrls := AValue;
    Changed;
  end;
end;

procedure TdxSpellCheckerSpellingOptions.SetIgnoreWordsWithNumbers(
  AValue: Boolean);
begin
  if FIgnoreWordsWithNumbers <> AValue then
  begin
    FIgnoreWordsWithNumbers := AValue;
    Changed;
  end;
end;

{ TdxSpellCheckerCheckAsYouTypeOptions }

procedure TdxSpellCheckerCheckAsYouTypeOptions.Assign(Source: TPersistent);
begin
  if Source is TdxSpellCheckerCheckAsYouTypeOptions then
  begin
    FSuggestionCount := TdxSpellCheckerCheckAsYouTypeOptions(Source).FSuggestionCount;
    FUnderlineColor := TdxSpellCheckerCheckAsYouTypeOptions(Source).FUnderlineColor;
    FUnderlineStyle := TdxSpellCheckerCheckAsYouTypeOptions(Source).FUnderlineStyle;
    FModifyControlPopupMenu := TdxSpellCheckerCheckAsYouTypeOptions(Source).ModifyControlPopupMenu;
    FPopupMenu := TdxSpellCheckerCheckAsYouTypeOptions(Source).PopupMenu;
    FPopupMenuItems := TdxSpellCheckerCheckAsYouTypeOptions(Source).PopupMenuItems;
    Changed;
  end;
end;

procedure TdxSpellCheckerCheckAsYouTypeOptions.Changed;
begin
  if SpellChecker.CheckAsYouTypeManager <> nil then
    SpellChecker.CheckAsYouTypeManager.DoOptionsChanged;
  DoChanged;
end;

procedure TdxSpellCheckerCheckAsYouTypeOptions.DoChanged;
begin
  if Assigned(FOnChanged) then
    FOnChanged(Self);
end;

procedure TdxSpellCheckerCheckAsYouTypeOptions.InitializeOptions;
begin
  FSuggestionCount := 5;
  FUnderlineColor := clRed;
  FUnderlineStyle := usAuto;
  FModifyControlPopupMenu := True;
  FPopupMenuItems := [scmiAddToDictionary, scmiAutoCorrect, scmiDelete, scmiIgnoreAll, scmiSpelling, scmiSuggestions];
end;

procedure TdxSpellCheckerCheckAsYouTypeOptions.Notification(AComponent: TComponent; AOperation: TOperation);
begin
  if (AComponent = FPopupMenu) and (AOperation = opRemove) then
    PopupMenu := nil;
end;

procedure TdxSpellCheckerCheckAsYouTypeOptions.SetActive(AValue: Boolean);
begin
  if FActive <> AValue then
  begin
    FActive := AValue;
    SpellChecker.CheckAsYouTypeManager.DoActiveChanged;
    Changed;
  end;
end;

procedure TdxSpellCheckerCheckAsYouTypeOptions.SetPopupMenu(AValue: TComponent);
begin
  if FPopupMenu <> AValue then
  begin
    if (FPopupMenu <> nil) and not (csDestroying in FPopupMenu.ComponentState) then
      FPopupMenu.RemoveFreeNotification(SpellChecker);
    FPopupMenu := AValue;
    if FPopupMenu <> nil then
      FPopupMenu.FreeNotification(SpellChecker);
    Changed;
  end;
end;

procedure TdxSpellCheckerCheckAsYouTypeOptions.SetModifyControlPopupMenu(AValue: Boolean);
begin
  if AValue <> FModifyControlPopupMenu then
  begin
    FModifyControlPopupMenu := AValue;
    Changed;
  end;
end;

procedure TdxSpellCheckerCheckAsYouTypeOptions.SetPopupMenuItems(AValue: TdxSpellCheckerPopupMenuItems);
begin
  if AValue <> FPopupMenuItems then
  begin
    FPopupMenuItems := AValue;
    Changed;
  end;
end;

procedure TdxSpellCheckerCheckAsYouTypeOptions.SetSuggestionCount(AValue: Integer);
begin
  if AValue <> FSuggestionCount then
  begin
    FSuggestionCount := AValue;
    Changed;
  end;
end;

procedure TdxSpellCheckerCheckAsYouTypeOptions.SetUnderlineColor(AValue: TColor);
begin
  if FUnderlineColor <> AValue then
  begin
    FUnderlineColor := AValue;
    Changed;
  end;
end;

procedure TdxSpellCheckerCheckAsYouTypeOptions.SetUnderlineStyle(
  AValue: TdxSpellCheckerUnderlineStyle);
begin
  if FUnderlineStyle <> AValue then
  begin
    FUnderlineStyle := AValue;
    Changed;
  end;
end;

{ TdxCustomSpellChecker }

function IsContainer(AComponent: TComponent): Boolean;
begin
  Result := (AComponent is TCustomForm) or (AComponent is TCustomFrame) or
    (AComponent is TDataModule);
end;

function IsSpellCheckerAlreadyExists(AOwner: TComponent;
  AInstance: TdxCustomSpellChecker): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to AOwner.ComponentCount - 1 do
    if (AOwner.Components[I] <> AInstance) and (AOwner.Components[I] is TdxCustomSpellChecker) then
    begin
      Result := True;
      Break;
    end;
end;

constructor TdxCustomSpellChecker.Create(AOwner: TComponent);
var
  I: Integer;
  AComponent: TComponent;
begin
  FCreating := True;
  if IsContainer(AOwner) and IsSpellCheckerAlreadyExists(AOwner, Self) then
    SpellCheckerCreatingError(@sdxSpellCheckerMoreThanOne);
  for I := 0 to Application.ComponentCount - 1 do
  begin
    AComponent := Application.Components[I];
    if IsContainer(AComponent) and IsSpellCheckerAlreadyExists(AComponent, Self) then
      SpellCheckerCreatingError(@sdxSpellCheckerMoreThanOne);
  end;
  FThreadedLoadPriority := tpLower;
  FCreating := False;
  inherited Create(AOwner);
  FAutoLoadDictionaries := False;
  FSpellingFormType := sftOutlook;
  FMetaphoneDistance := 3;
  FDictionaryItems := TdxSpellCheckerDictionaries.Create(Self);
  FSimilarity := CreateSimilarity;
  FRules := TdxSpellCheckerRules.Create;
  FSuggestionCache := TdxSpellCheckerSuggestionCache.Create(256);
  FDialogLookAndFeel := TcxLookAndFeel.Create(nil);
  FSpellingOptions := CreateSpellingOptions;
  FAutoCorrectOptions := TdxSpellCheckerAutoCorrectOptions.Create(Self);
  FAutoCorrectManager := TdxSpellCheckerAutoCorrectManager.Create(Self);
  FCheckAsYouTypeOptions := TdxSpellCheckerCheckAsYouTypeOptions.Create(Self);
  FCheckAsYouTypeManager := TdxSpellCheckerCheckAsYouTypeManager.Create(Self);
  SpellingOptionsChanged;
  FLanguages := TdxSpellCheckerLanguages.Create;
  FChangeList := TdxSpellCheckerReplacementList.Create;
  FDeleteList := TdxSpellCheckerWordList.Create(LANG_SYSTEM_DEFAULT, 257);
  FIgnoreList := TdxSpellCheckerWordList.Create(LANG_SYSTEM_DEFAULT, 257);
  dxISpellChecker := Self;
  dxISpellChecker2 := Self;
end;

destructor TdxCustomSpellChecker.Destroy;
begin
  if not FCreating then
  begin
    dxISpellChecker := nil;
    dxISpellChecker2 := nil;
    CheckAsYouTypeOptions.Active := False;
    FreeAndNil(FSuggestionCache);
    FreeAndNil(FChangeList);
    FreeAndNil(FDeleteList);
    FreeAndNil(FIgnoreList);
    UnloadDictionaries;
    FreeAndNil(FLanguages);
    FreeAndNil(FSpellingOptions);
    FreeAndNil(FRules);
    FreeAndNil(FSimilarity);
    FreeAndNil(FCheckAsYouTypeManager);
    FreeAndNil(FCheckAsYouTypeOptions);
    FreeAndNil(FAutoCorrectOptions);
    FreeAndNil(FAutoCorrectManager);
    FreeAndNil(FDialogLookAndFeel);
    FreeAndNil(FDictionaryItems);
  end;
  inherited Destroy;
end;

procedure TdxCustomSpellChecker.Check(var AText: AnsiString);
var
  AEditAdapter: TdxSpellCheckerTextAdapter;
begin
  AEditAdapter := TdxSpellCheckerTextAdapter.Create(dxAnsiStringToWideString(AText));
  try
    InternalCheck(AEditAdapter);
    AText := dxWideStringToAnsiString(AEditAdapter.Text);
  finally
    FreeAndNil(AEditAdapter);
  end;
end;

procedure TdxCustomSpellChecker.Check(var AText: WideString);
var
  AEditAdapter: TdxSpellCheckerTextAdapter;
begin
  AEditAdapter := TdxSpellCheckerTextAdapter.Create(AText);
  try
    InternalCheck(AEditAdapter);
    AText := AEditAdapter.Text;
  finally
    FreeAndNil(AEditAdapter);
  end;
end;

procedure TdxCustomSpellChecker.Check(AEdit: TCustomEdit);
var
  AEditAdapter: TdxSpellCheckerEditAdapter;
begin
  AEditAdapter := TdxSpellCheckerEditAdapter.Create(AEdit);
  try
    InternalCheck(AEditAdapter);
  finally
    FreeAndNil(AEditAdapter);
  end;
end;

procedure TdxCustomSpellChecker.Check(AEdit: TcxCustomTextEdit);
var
  AEditAdapter: TdxSpellCheckercxTextEditAdapter;
begin
  if AEdit is TcxCustomRichEdit then
    AEditAdapter := TdxSpellCheckercxRichEditAdapter.Create(AEdit)
  else
    AEditAdapter := TdxSpellCheckercxTextEditAdapter.Create(AEdit);
  try
    InternalCheck(AEditAdapter);
  finally
    FreeAndNil(AEditAdapter);
  end;
end;

procedure TdxCustomSpellChecker.CheckContainer(AContainer: TWinControl; ARecursive: Boolean);
begin
  if AContainer = nil then Exit;
  FCheckingContainer := True;
  try
    FCheckGroupMode := True;
    FLastDialogResult := mrOk;
    try
      DoCheckContainer(AContainer, ARecursive);
    finally
      FCheckGroupMode := False;
    end;
    if FLastDialogResult <> mrCancel then
      SpellingComplete;
  finally
    FCheckingContainer := False;
  end;
end;

procedure TdxCustomSpellChecker.AddToIgnoreList(const AWord: WideString);
begin
  IgnoreList.Add(AWord);
  CheckAsYouTypeManager.Refresh;
end;

procedure TdxCustomSpellChecker.AddWordToUserDictionary(
  const AWord: WideString);
var
  AUserDictionary: TdxUserSpellCheckerDictionary;
begin
  AUserDictionary := FindFirstEnabledUserDictionary;
  if AUserDictionary <> nil then
  begin
    if not DoAddWord(AUserDictionary, AWord) then
      AUserDictionary.AddWord(AWord);
  end;
end;

function TdxCustomSpellChecker.FindDictionaryByWord(const AWord: WideString): TdxCustomSpellCheckerDictionary;
var
  I: Integer;
  ADictionary: TdxCustomSpellCheckerDictionary;
begin
  Result := nil;
  for I := 0 to ActiveDictionaryCount - 1 do
  begin
    ADictionary := ActiveDictionaries[I];
    if ADictionary.HasWord(AWord) then
    begin
      Result := ADictionary;
      Break;
    end;
  end;
end;

function TdxCustomSpellChecker.FindFirstEnabledUserDictionary: TdxUserSpellCheckerDictionary;
var
  I: Integer;
  ADictionary: TdxUserSpellCheckerDictionary;
begin
  Result := nil;
  for I := 0 to UserDictionaryCount - 1 do
  begin
    ADictionary := UserDictionaries[I];
    if ADictionary.Enabled then
    begin
      Result := ADictionary;
      Break;
    end;
  end;
end;

function TdxCustomSpellChecker.GetSuggestions(const AWord: WideString): TdxSpellCheckerSuggestionList;
var
  I: Integer;
  ADictionary: TdxCustomSpellCheckerDictionary;
begin
  Result := TdxSpellCheckerSuggestionList.Create;
  if not HasWordInDictionaries(AWord) then
  begin
    if not SuggestionCache.GetSuggestions(AWord, Result) then
    begin
      for I := 0 to ActiveDictionaryCount - 1 do
      begin
        ADictionary := ActiveDictionaries[I];
        with ADictionary.CreateSuggestionBuilder do
        try
          AddSuggestions(AWord, Result);
        finally
          Free;
        end;
      end;
      Result.RemoveDuplicates;
      SuggestionCache.Add(AWord, Result);
    end;
    DoGetSuggestions(AWord, Result);
  end;
end;

function TdxCustomSpellChecker.HasWordInDictionaries(const AWord: WideString): Boolean;
begin
  Result := FindDictionaryByWord(AWord) <> nil;
end;

function TdxCustomSpellChecker.HasEnabledUserDictionary: Boolean;
begin
  Result := FindFirstEnabledUserDictionary <> nil;
end;

function TdxCustomSpellChecker.IsValidWord(const AWord: WideString): Boolean;
begin
  Result := False;
  if not DoCheckWord(AWord, Result) then
    Result := Rules.IsValid(AWord);
end;

procedure TdxCustomSpellChecker.PopulateLanguages(AList: TStrings);
var
  I: Integer;
  ADictionary: TdxCustomSpellCheckerDictionary;
  ALanguageName: string;
  ALangID: Cardinal;
begin
  for I := 0 to DictionaryItems.Count - 1 do
  begin
    ADictionary := Dictionaries[I];
    if ADictionary is TdxUserSpellCheckerDictionary then
      Continue;
    if ADictionary.Language <> 0 then
      ALangID := ADictionary.Language
    else
      ALangID := Languages.GetDefaultLanguageLCID;
    ALanguageName := Languages.NameFromLocaleID[ALangID];
    if AList.IndexOf(ALanguageName) < 0 then
      AList.AddObject(ALanguageName, Pointer(ALangID));
  end;
end;

procedure TdxCustomSpellChecker.ShowSpellingCompleteMessage;
begin
  ShowMessage(cxGetResourceString(@sdxSpellCheckerSpellingComplete));
end;

procedure TdxCustomSpellChecker.LoadDictionaries(AIgnoreDisabled: Boolean = True);
begin
  if UseThreadedLoad then
    LoadDictionariesUsingThread(AIgnoreDisabled)
  else
    LoadDictionariesDirect(AIgnoreDisabled);
end;

procedure TdxCustomSpellChecker.UnloadDictionaries;
var
  I: Integer;
begin
  ShowHourglassCursor;
  try
    for I := 0 to DictionaryCount - 1 do
      Dictionaries[I].Terminate;
    for I := 0 to DictionaryCount - 1 do
      Dictionaries[I].Unload;
  finally
    HideHourglassCursor;
  end;
end;

function TdxCustomSpellChecker.GetTwoWordsDistance(
  const AWord1, AWord2: WideString): Integer;
begin
  Result := Similarity.GetDistance(PWideChar(WideUpperCase(AWord1)), Length(AWord1),
    PWideChar(WideUpperCase(AWord2)), Length(AWord2)) div 2;
end;

procedure TdxCustomSpellChecker.CheckCallEnabledDictionariesLoaded;
begin
  CheckAsYouTypeManager.Refresh(True);
  if ActiveDictionaryCount = EnabledDictionaryCount then
    DoEnabledDictionariesLoaded;
end;

function TdxCustomSpellChecker.CreateSimilarity: TdxStringSimilarityCalculator;
begin
  Result := TdxStringSimilarityCalculator.Create;
end;

function TdxCustomSpellChecker.CreateSpellingOptions: TdxSpellCheckerSpellingOptions;
begin
  Result := TdxSpellCheckerSpellingOptions.Create(Self);
end;

procedure TdxCustomSpellChecker.BeginManualCheck;
begin
  CheckAsYouTypeManager.BeginManualCheck;
end;

procedure TdxCustomSpellChecker.EndManualCheck;
begin
  CheckAsYouTypeManager.EndManualCheck;
end;

function TdxCustomSpellChecker.DoAddWord(AUserDictionary: TdxUserSpellCheckerDictionary;
  const AWord: WideString): Boolean;
begin
  Result := False;
  if Assigned(FOnAddWord) then
    FOnAddWord(AUserDictionary, AWord, Result);
end;

procedure TdxCustomSpellChecker.DoAfterCheck;
begin
  if Assigned(FOnAfterCheck) then
    FOnAfterCheck(Self);
end;

function TdxCustomSpellChecker.DoAutoCorrect(ARule: TdxSpellCheckerAutoCorrectCustomRule;
  var AWordRange: TdxSpellCheckerAutoCorrectWordRange): Boolean;
begin
  Result := True;
  if Assigned(FOnAutoCorrect) then
    FOnAutoCorrect(Self, ARule, AWordRange, Result);
end;

procedure TdxCustomSpellChecker.DoAutoCorrectFinish(AControl: TWinControl);
begin
  if Assigned(OnAutoCorrectFinish) then
    OnAutoCorrectFinish(Self, AControl);
end;

function TdxCustomSpellChecker.DoAutoCorrectStart(AControl: TWinControl): Boolean;
begin
  Result := Assigned(AControl);
  if Result and Assigned(OnAutoCorrectStart) then
    OnAutoCorrectStart(Self, AControl, Result);
end;

procedure TdxCustomSpellChecker.DoBeforeCheck;
begin
  if Assigned(FOnBeforeCheck) then
    FOnBeforeCheck(Self);
end;

procedure TdxCustomSpellChecker.DoCheck(ADialogCheckMode: TdxSpellCheckerDialogCheckMode);
begin
  if ActiveDictionaryCount = 0 then
    raise EdxSpellCheckerException.Create(cxGetResourceString(@sdxSpellCheckerNoActiveDictionaries));
  DoBeforeCheck;
  try
    ValidateRules(ADialogCheckMode.Parser);
    if not ADialogCheckMode.GetNextMisspelledWord then
    begin
      SpellingComplete;
      FLastDialogResult := mrOk;
    end
    else
    begin
      FLastDialogResult := ADialogCheckMode.ShowDialog;
      if FLastDialogResult = mrOk then
        SpellingComplete;
    end;
  finally
    DoAfterCheck;
  end;
end;

procedure TdxCustomSpellChecker.DoCheckAsYouTypeFinish(AControl: TWinControl);
begin
  if Assigned(OnCheckAsYouTypeFinish) then
    OnCheckAsYouTypeFinish(Self, AControl);
end;

function TdxCustomSpellChecker.DoCheckAsYouTypePopup(APopup: TComponent): Boolean;
begin
  Result := False;
  if Assigned(FOnCheckAsYouTypePopup) then
    FOnCheckAsYouTypePopup(Self, APopup, Result);
end;

function TdxCustomSpellChecker.DoCheckAsYouTypeStart(AControl: TWinControl): Boolean;
begin
  Result := Assigned(AControl);
  if Result and Assigned(OnCheckAsYouTypeStart) then
    OnCheckAsYouTypeStart(Self, AControl, Result);
end;

procedure TdxCustomSpellChecker.DoCheckContainer(AContainer: TWinControl;
  ARecursive: Boolean);

  function StopCheck(AContinue: Boolean): Boolean;
  begin
    Result := not AContinue or (FLastDialogResult <> mrOk);
    if Result then
      FLastDialogResult := mrCancel;
  end;

var
  I: Integer;
  AControl: TWinControl;
  AContinue: Boolean;
  L: TList;
begin
  L := TList.Create;
  try
    AContainer.GetTabOrderList(L);
    for I := 0 to L.Count - 1 do
    begin
      AControl := TWinControl(L[I]);
      if not AControl.CanFocus or (not ARecursive and (AControl.Parent <> AContainer)) then
        Continue;
      AContinue := True;
      if (AControl is TCustomEdit) or (AControl is TcxCustomTextEdit) then
      begin
        AControl := GetInnerControlContainer(AControl);
        if DoCheckControlInContainer(AControl, AContinue) then
        begin
          if AControl is TcxCustomTextEdit then
            Check(TcxCustomTextEdit(AControl))
          else
            Check(TCustomEdit(AControl));
        end;
        if StopCheck(AContinue) then
          Break;
      end;
    end;
  finally
    L.Free;
  end;
end;

function TdxCustomSpellChecker.DoCheckControlInContainer(AControl: TWinControl;
  var AContinue: Boolean): Boolean;
begin
  Result := True;
  if Assigned(FOnCheckControlInContainer) then
    FOnCheckControlInContainer(Self, AControl, Result, AContinue);
end;

function TdxCustomSpellChecker.DoCheckWord(const AWord: WideString; var AValid: Boolean): Boolean;
begin
  Result := False;
  if Assigned(FOnCheckWord) then
    FOnCheckWord(Self, AWord, AValid, Result);
end;

procedure TdxCustomSpellChecker.DoEnabledDictionariesLoaded;
begin
  if Assigned(FOnEnabledDictionariesLoaded) then
    FOnEnabledDictionariesLoaded(Self);
end;

procedure TdxCustomSpellChecker.DoGetSuggestions(const AWord: WideString;
  ASuggestions: TdxSpellCheckerSuggestionList);
begin
  if Assigned(FOnGetSuggestions) then
    FOnGetSuggestions(Self, AWord, ASuggestions);
end;

function TdxCustomSpellChecker.DoSpellingComplete: Boolean;
begin
  Result := False;
  if Assigned(FOnSpellingComplete) then
    FOnSpellingComplete(Self, Result);
end;

function TdxCustomSpellChecker.GetDialogCheckModeClass: TdxSpellCheckerCustomCheckModeClass;
begin
  if sftWord = SpellingFormType then
    Result := TdxSpellCheckerWordCheckMode
  else
    Result := TdxSpellCheckerOutlookCheckMode;
end;

procedure TdxCustomSpellChecker.InternalCheck(AAdapter: TdxSpellCheckerCustomEditAdapter);
begin
  if ActiveDictionaryCount = 0 then
    Exit;
  BeginManualCheck;
  try
    FCheckMode := GetDialogCheckModeClass.Create(Self, AAdapter);
    try
      DoCheck(FCheckMode as TdxSpellCheckerDialogCheckMode);
    finally
      FreeAndNil(FCheckMode);
    end;
  finally
    EndManualCheck;
  end;
end;

procedure TdxCustomSpellChecker.LoadDictionariesDirect(
  AIgnoreDisabled: Boolean = True);
var
  I: Integer;
  ADictionary: TdxCustomSpellCheckerDictionary;
begin
  ShowHourglassCursor;
  try
    for I := 0 to DictionaryCount - 1 do
    begin
      ADictionary := Dictionaries[I];
      if ADictionary.Enabled or not AIgnoreDisabled then
        ADictionary.Load;
    end;
  finally
    HideHourglassCursor;
  end;
end;

procedure TdxCustomSpellChecker.LoadDictionariesUsingThread(
  AIgnoreDisabled: Boolean = True);
var
  I: Integer;
  ADictionary: TdxCustomSpellCheckerDictionary;
begin
  for I := 0 to DictionaryCount - 1 do
  begin
    ADictionary := Dictionaries[I];
    if ADictionary.Enabled or not AIgnoreDisabled then
      ADictionary.LoadUsingThread;
  end;
end;

procedure TdxCustomSpellChecker.Loaded;
begin
  inherited Loaded;
  if AutoLoadDictionaries and not (csDesigning in ComponentState) then
    LoadDictionaries;
end;

procedure TdxCustomSpellChecker.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if CheckAsYouTypeOptions <> nil then
    CheckAsYouTypeOptions.Notification(AComponent, Operation);
end;

procedure TdxCustomSpellChecker.SpellingOptionsChanged;
begin
  if Assigned(CheckMode) then
    ValidateRules(CheckMode.Parser);
  CheckAsYouTypeManager.SpellingOptionsChanged;
end;

procedure TdxCustomSpellChecker.ValidateRules(AParser: TdxSpellCheckerTextParser);
begin
  Rules.Clear;
  if Assigned(AParser) then
  begin
    SpellingOptions.PopulateRules(Rules, AParser);
    Rules.Add(TdxSpellCheckerWordExistsRule.Create(AParser));
  end;
end;

procedure TdxCustomSpellChecker.UpdateByDictionary(
  ADictionary: TdxCustomSpellCheckerDictionary);
begin
  if Assigned(CheckMode) then
    CheckMode.UpdateByDictionary(ADictionary);
  if Assigned(CheckAsYouTypeManager) then
    CheckAsYouTypeManager.Reset;
  if Assigned(SuggestionCache) then
    SuggestionCache.Reset;
end;

procedure TdxCustomSpellChecker.SpellingComplete;
begin
  if not FCheckGroupMode and not DoSpellingComplete then
    ShowSpellingCompleteMessage;
end;

function TdxCustomSpellChecker.GetActiveDictionary(
  Index: Integer): TdxCustomSpellCheckerDictionary;
var
  I, J: Integer;
  ADictionary: TdxCustomSpellCheckerDictionary;
begin
  Result := nil;
  J := 0;
  for I := 0 to DictionaryItems.Count - 1 do
  begin
    ADictionary := DictionaryItems[I].DictionaryType;
    if (ADictionary <> nil) and (ADictionary.Active) then
    begin
      if J = Index then
      begin
        Result := ADictionary;
        Exit;
      end;
      Inc(J);
    end;
  end;
end;

function TdxCustomSpellChecker.GetActiveDictionaryCount: Integer;
var
  I: Integer;
  ADictionary: TdxCustomSpellCheckerDictionary;
begin
  Result := 0;
  for I := 0 to DictionaryItems.Count - 1 do
  begin
    ADictionary := DictionaryItems[I].DictionaryType;
    if (ADictionary <> nil) and (ADictionary.Active) then
      Inc(Result);
  end;
end;

function TdxCustomSpellChecker.GetCheckMode: TdxSpellCheckerCustomCheckMode;
begin
  Result := FCheckMode;
  if (Result = nil) and Assigned(CheckAsYouTypeManager) and CheckAsYouTypeManager.Active then
    Result := CheckAsYouTypeManager.CheckMode;
end;

function TdxCustomSpellChecker.GetDictionary(
  Index: Integer): TdxCustomSpellCheckerDictionary;
var
  I, J: Integer;
  ADictionary: TdxCustomSpellCheckerDictionary;
begin
  Result := nil;
  J := 0;
  for I := 0 to DictionaryItems.Count - 1 do
  begin
    ADictionary := DictionaryItems[I].DictionaryType;
    if ADictionary <> nil then
    begin
      if J = Index then
      begin
        Result := ADictionary;
        Exit;
      end;
      Inc(J);
    end;
  end;
end;

function TdxCustomSpellChecker.GetDictionaryCount: Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to DictionaryItems.Count - 1 do
    if DictionaryItems[I].DictionaryType <> nil then
      Inc(Result);
end;

function TdxCustomSpellChecker.GetEnabledDictionary(
  Index: Integer): TdxCustomSpellCheckerDictionary;
var
  I, J: Integer;
  ADictionary: TdxCustomSpellCheckerDictionary;
begin
  Result := nil;
  J := 0;
  for I := 0 to DictionaryItems.Count - 1 do
  begin
    ADictionary := DictionaryItems[I].DictionaryType;
    if (ADictionary <> nil) and (ADictionary.Enabled) then
    begin
      if J = Index then
      begin
        Result := DictionaryItems[I].DictionaryType;
        Exit;
      end;
      Inc(J);
    end;
  end;
end;

function TdxCustomSpellChecker.GetEnabledDictionaryCount: Integer;
var
  I: Integer;
  ADictionary: TdxCustomSpellCheckerDictionary;
begin
  Result := 0;
  for I := 0 to DictionaryItems.Count - 1 do
  begin
    ADictionary := DictionaryItems[I].DictionaryType;
    if (ADictionary <> nil) and (ADictionary.Enabled) then
      Inc(Result);
  end;
end;

function TdxCustomSpellChecker.GetUserDictionary(
  Index: Integer): TdxUserSpellCheckerDictionary;
var
  I, J: Integer;
begin
  Result := nil;
  J := 0;
  for I := 0 to DictionaryItems.Count - 1 do
  begin
    if DictionaryItems[I].DictionaryType is TdxUserSpellCheckerDictionary then
    begin
      if J = Index then
      begin
        Result := TdxUserSpellCheckerDictionary(DictionaryItems[I].DictionaryType);
        Exit;
      end;
      Inc(J);
    end;
  end;
end;

function TdxCustomSpellChecker.GetUserDictionaryCount: Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to DictionaryItems.Count - 1 do
    if DictionaryItems[I].DictionaryType is TdxUserSpellCheckerDictionary then
      Inc(Result);
end;

function TdxCustomSpellChecker.GetWordChars: WideString;
var
  I: Integer;
  ADictionary: TdxCustomSpellCheckerDictionary;
begin
  Result := '''.';
  for I := 0 to DictionaryItems.Count - 1 do
  begin
    ADictionary := DictionaryItems[I].DictionaryType;
    if (ADictionary <> nil) and (ADictionary.Active) then
      ADictionary.UpdateWordChars(Result);
  end;
end;

procedure TdxCustomSpellChecker.SetAutoCorrectOptions(AValue: TdxSpellCheckerAutoCorrectOptions);
begin
  FAutoCorrectOptions.Assign(AValue);
end;

procedure TdxCustomSpellChecker.SetCheckAsYouTypeOptions(
  AValue: TdxSpellCheckerCheckAsYouTypeOptions);
begin
  FCheckAsYouTypeOptions.Assign(AValue);
end;

procedure TdxCustomSpellChecker.SetDialogLookAndFeel(AValue: TcxLookAndFeel);
begin
  FDialogLookAndFeel.Assign(AValue);
end;

procedure TdxCustomSpellChecker.SetDictionaryItems(
  AValue: TdxSpellCheckerDictionaries);
begin
  FDictionaryItems.Assign(AValue);
end;

procedure TdxCustomSpellChecker.SetMetaphoneDistance(AValue: Integer);
var
  I: Integer;
begin
  if AValue < 1 then AValue := 1;
  if AValue > 5 then AValue := 5;
  if FMetaphoneDistance <> AValue then
  begin
    FMetaphoneDistance := AValue;
    for I := 0 to DictionaryCount - 1 do
      Dictionaries[I].UpdateUsingMetaphone;
  end;
end;

procedure TdxCustomSpellChecker.SetSpellingOptions(
  AValue: TdxSpellCheckerSpellingOptions);
begin
  FSpellingOptions.Assign(AValue);
end;

// IdxSpellCheckerEditHelper
procedure TdxCustomSpellChecker.CheckFinish;
begin
  CheckAsYouTypeManager.CheckFinish;
  AutoCorrectManager.CheckFinish;
end;

procedure TdxCustomSpellChecker.CheckStart(AControl: TWinControl);
begin
  CheckAsYouTypeManager.CheckStart(AControl);
  AutoCorrectManager.CheckStart(AControl);
end;

procedure TdxCustomSpellChecker.DrawMisspellings(AControl: TWinControl);
begin
  CheckAsYouTypeManager.DrawMisspellings(AControl);
end;

function TdxCustomSpellChecker.IsSpellCheckerDialogControl(AWnd: THandle): Boolean;
begin
  Result := CheckAsYouTypeManager.Active and CheckAsYouTypeManager.IsManualCheckingActive;
end;

procedure TdxCustomSpellChecker.KeyPress(AKey: Char);
begin
  AutoCorrectManager.KeyPress(AKey);
end;

function TdxCustomSpellChecker.QueryPopup(
  APopup: TComponent; const P: TPoint): Boolean;
begin
  Result := CheckAsYouTypeManager.QueryPopup(APopup, P);
end;

procedure TdxCustomSpellChecker.LayoutChanged(AControl: TWinControl);
begin
  CheckAsYouTypeManager.LayoutChanged(AControl);
end;

procedure TdxCustomSpellChecker.SelectionChanged(AControl: TWinControl);
begin
  CheckAsYouTypeManager.SelectionChanged(AControl);
end;

procedure TdxCustomSpellChecker.TextChanged(AControl: TWinControl);
begin
  CheckAsYouTypeManager.TextChanged(AControl);
end;

procedure TdxCustomSpellChecker.Undo;
begin
  AutoCorrectManager.Undo;
end;

procedure TdxCustomSpellChecker.KeyDown(AKey: Word; Shift: TShiftState);
begin
  CheckAsYouTypeManager.KeyDown(AKey, Shift);
end;

procedure TdxCustomSpellChecker.KeyUp(AKey: Word; Shift: TShiftState);
begin
  CheckAsYouTypeManager.KeyUp(AKey, Shift);
end;

initialization
  GetRegisteredDictionaryTypes.Register(
    TdxUserSpellCheckerDictionary, cxGetResourceString(@sdxSpellCheckerUserDictionary));

finalization
  FreeRegisteredDictionaryTypes;

end.
