{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2008                    BBBBB   }
  
unit daSQLEdit;

interface

uses
  Windows,
  Messages,
  Classes,
  Controls,
  Graphics,

  ppTypes,
  daSQLParser,

{$IFDEF UniCode}
  daSynUHighlighterSQL,
  ppSynUEdit;
{$ELSE}
  daSynHighlighterSQL,
  ppSynEdit;
{$ENDIF}


type

  TdaSQLEdit = class(TSynEdit)
  private
    FDatabaseType: TppDatabaseType;
    FWantReturns: Boolean;
    procedure SetDatabaseType(const Value: TppDatabaseType);
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
  public
    constructor Create(aOwner: TComponent); override;
    property DatabaseType: TppDatabaseType read FDatabaseType write SetDatabaseType;
    property WantReturns: Boolean read FWantReturns write FWantReturns;
  end;

implementation

{------------------------------------------------------------------------------}
{ TdaSQLEdit.Create }

constructor TdaSQLEdit.Create(aOwner: TComponent);
begin

  inherited;

  // configure tabbing behavior
  //   - remove smart tabs, it causes tabs to not work
  //   - add block indent support
  WantTabs := True;
  WantReturns := True;
  TabWidth := 2;
  Options := Options - [eoSmartTabs] +  [eoTabIndent];


  BevelOuter := bvNone;
  BevelInner := bvNone;

  FDatabaseType := dtOther;

  Highlighter := TdaSynHighlighterSQL.Create(Self);
  Highlighter.CommentAttribute.Foreground := clNavy;
  Highlighter.StringAttribute.Foreground := clGreen;

end;

procedure TdaSQLEdit.SetDatabaseType(const Value: TppDatabaseType);
begin
  FDatabaseType := Value;

  TdaSynHighlighterSQL(Highlighter).SQLDialect := ppDatabaseTypeToSQLDialect(Value);

end;

procedure TdaSQLEdit.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  inherited;
  if FWantReturns and (GetKeyState(VK_CONTROL) >= 0) then
    Message.Result := Message.Result or DLGC_WANTALLKEYS;

end;

end.
