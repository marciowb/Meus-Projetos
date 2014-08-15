{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2009                    BBBBB   }

unit ppLanguage;

interface

uses
  Classes;

type

  TppLanguageClass = class of TppLanguage;

  {@TppLanguage

    This class provides the information needed to register and unregister
    separate language translations to be shown in the ReportBuilder user
    interface.

    Using this class along with the provided utility routines, it is possible
    to switch between any number of language translations including numerous
    custom languages.}

  {@TppLanguage.LanguageExt

    File extension that coorilates to the translated language.  Each language
    dll file is given a unique file extension.}

  {@TppLanguage.LanguageName

    Common name or description of the language being registered.

    Example: English (United States) }

  TppLanguage = class
  private
    FLanguageExt: String;
    FLanguageName: String;
  public
    constructor Create(aLanguageName, aLanguageExt: string);

    property LanguageExt: String read FLanguageExt write FLanguageExt;
    property LanguageName: String read FLanguageName write FLanguageName;
  end;



  {register routines}
  procedure ppGetLanguageClasses(aList: TStrings);
  function  ppGetLanguageExtForName(aLanguageName: String): String;
  procedure ppRegisterStandardLanguages;
  procedure ppRegisterLanguage(aLanguageName, aLanguageExt: String);
  procedure ppUnRegisterLanguage(aLanguageName: String);

implementation

uses
  Contnrs;

var
  uLanguageClassList: TObjectList = nil;

constructor TppLanguage.Create(aLanguageName, aLanguageExt: string);
begin
  FLanguageName := aLanguageName;
  FLanguageExt := aLanguageExt;

end;

procedure ppRegisterStandardLanguages;
begin
  ppRegisterLanguage('Danish (Denmark)', 'dan');
  ppRegisterLanguage('Dutch (Netherlands)', 'ned');
  ppRegisterLanguage('English (United States)', 'eng');
  ppRegisterLanguage('French (France)', 'fra');
  ppRegisterLanguage('German (Germany)', 'deu');
  ppRegisterLanguage('Italian (Italy)', 'ita');
  ppRegisterLanguage('Portuguese (Brazil)', 'ptb');
  ppRegisterLanguage('Portuguese (Portugal)', 'ptg');
  ppRegisterLanguage('Spanish (Mexico)', 'esm');
  ppRegisterLanguage('Spanish (Spain)', 'esp');
  ppRegisterLanguage('Norwegian (Norway)', 'nor');
  ppRegisterLanguage('Swedish (Sweden)', 'sve');
  ppRegisterLanguage('Default', 'dft');
  ppRegisterLanguage('Custom', 'cst');

end;

function ppGetLanguageClassList: TObjectList;
begin

  if uLanguageClassList = nil then
    begin
      uLanguageClassList := TObjectList.Create;
      uLanguageClassList.OwnsObjects := True;

      ppRegisterStandardLanguages;
    end;

  Result := uLanguageClassList;

end;

function ppGetLanguageExtForName(aLanguageName: String): String;
var
  lClassList: TObjectList;
  lLanguage: TppLanguage;
  liIndex: Integer;
begin

  lClassList := ppGetLanguageClassList;

  for liIndex := 0 to lClassList.Count - 1 do
    begin
      lLanguage := TppLanguage(lClassList[liIndex]);

      if lLanguage.LanguageName = aLanguageName then
        Result := lLanguage.LanguageExt;
    end;

end;

procedure ppGetLanguageClasses(aList: TStrings);
var
  lClassList: TObjectList;
  liIndex: Integer;
  lClass: TppLanguage;
begin

  lClassList := ppGetLanguageClassList;

  for liIndex := 0 to lClassList.Count - 1 do
    begin
      lClass := TppLanguage(lClassList[liIndex]);

      aList.AddObject(lClass.LanguageName, TObject(lClass));
    end;

end;

procedure ppRegisterLanguage(aLanguageName, aLanguageExt: String);
var
  lClasses: TStringList;
  liIndex: Integer;
  lLanguage: TppLanguage;
begin

  lClasses := TStringList.Create;

  try
    ppGetLanguageClasses(lClasses);

    liIndex := lClasses.IndexOf(aLanguageName);

    if (liIndex = -1) then
      begin
        lLanguage := TppLanguage.Create(aLanguageName, aLanguageExt);
        ppGetLanguageClassList.Add(TObject(lLanguage));
      end;

    finally
      lClasses.Free;
    end;

end;

procedure ppUnRegisterLanguage(aLanguageName: String);
var
  lClasses: TStringList;
  liIndex: Integer;
begin

  lClasses := TStringList.Create;

  try
    ppGetLanguageClasses(lClasses);

    liIndex := lClasses.IndexOf(aLanguageName);

    if (liIndex > -1) then
      ppGetLanguageClassList.Delete(liIndex);

  finally
    lClasses.Free;
  end;

end;

initialization

finalization
  uLanguageClassList.Free;
  uLanguageClassList := nil;


end.
