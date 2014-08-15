unit atMetaSQLReg;

{$I tmsdefs.inc}
{$I metasql.inc}

{$IFDEF TMSDOTNET}
{$R TatMetaSQL.bmp}
{$R TatBdeDatabase.bmp}
{$R TatCustomDatabase.bmp}
{$ENDIF}

interface
uses
  {$IFDEF DELPHI6_LVL}
  Variants,

    {$IFNDEF TMSDOTNET}
    DesignIntf, DesignEditors,
    {$ENDIF}
    {$IFDEF TMSDOTNET}
    Borland.Vcl.Design.DesignIntf, Borland.Vcl.Design.DesignEditors,
    {$ENDIF}

  {$ELSE}
  DsgnIntf,
  {$ENDIF}
  Classes, DBTables
  ;

  const
  {$IFDEF TMSIWSQL}
  SMetaSQLPaletteName = 'IW Query Builder';
  {$ELSE}
  SMetaSQLPaletteName = 'TMS Query Studio';
  {$ENDIF}

type
  TatDBStringProperty = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValueList(List: TStrings); virtual; abstract;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

  TatDatabaseNameProperty = class(TatDBStringProperty)
  public
    procedure GetValueList(List: TStrings); override;
  end;

  TatSessionNameProperty = class(TatDBStringProperty)
  public
    procedure GetValueList(List: TStrings); override;
  end;

procedure Register;

implementation                                       
uses
  atPanel, atCheckListEdit, atListBoxDlg,
  atMetaSQL, atBDEDatabase, atCustomDatabase, atMetaSQLEditor;

{ TatDBStringProperty }

function TatDBStringProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paSortList];
end;

procedure TatDBStringProperty.GetValues(Proc: TGetStrProc);
var
  I: Integer;
  Values: TStringList;
begin
  Values := TStringList.Create;
  try
    GetValueList(Values);
    for I := 0 to Values.Count - 1 do Proc(Values[I]);
  finally
    Values.Free;
  end;
end;

{ TatDatabaseNameProperty }

procedure TatDatabaseNameProperty.GetValueList(List: TStrings);
begin
  { using BDE }
  DBTables.Session.GetDatabaseNames(List);
end;

{ TatSessionNameProperty }

procedure TatSessionNameProperty.GetValueList(List: TStrings);
begin
  DBTables.Sessions.GetSessionNames(List);
end;

procedure Register;
begin
  RegisterComponents( SMetaSQLPaletteName, [TatMetaSQL]);
  RegisterComponents( SMetaSQLPaletteName, [TatBdeDatabase]);
  RegisterComponents( SMetaSQLPaletteName, [TatCustomDatabase]);

  RegisterPropertyEditor( TypeInfo(string), TatBDEDatabase, 'DatabaseName', TatDatabaseNameProperty );
  RegisterPropertyEditor( TypeInfo(string), TatBDEDatabase, 'SessionName', TatSessionNameProperty );
  RegisterComponentEditor( TatMetaSQL, TatMetaSQLEditor );
end;

end.
