unit atMetaSQLEditor;

{$I tmsdefs.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls,
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
  atMetaSQL;

type
  TatMetaSQLEditor = class(TDefaultEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
    procedure Edit; override;
  end;

implementation

uses
  ShowSQLForm, qsRes
  {$IFNDEF TMSDOTNET}, atMetaSQLForm{$ENDIF};

{TatMetaSQLEditor}

{$IFNDEF TMSDOTNET}
function TatMetaSQLEditor.GetVerbCount: Integer;
begin
  Result := 2;
end;

function TatMetaSQLEditor.GetVerb(Index: Integer): string;
begin
  Case Index of
     0: Result := _str(SEditMetaSQL);
     1: Result := _str(SShowSQL);
  else
     Result := ''
  end;
end;

procedure TatMetaSQLEditor.ExecuteVerb(Index: Integer);
Var MetaSQL: TatMetaSQL;
begin
   MetaSQL:=Component as TatMetaSQL;
   Case index of
      0 :
         begin
            EditMetaSQL(MetaSQL);
            Designer.Modified;
         end;
      1 : ShowSQL(MetaSQL.SQL);
   end;
end;
{$ENDIF}

{$IFDEF TMSDOTNET}
function TatMetaSQLEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

function TatMetaSQLEditor.GetVerb(Index: Integer): string;
begin
  Case Index of
     0: Result := _str(SShowSQL);
  else
     Result := ''
  end;
end;

procedure TatMetaSQLEditor.ExecuteVerb(Index: Integer);
Var MetaSQL: TatMetaSQL;
begin
   MetaSQL:=Component as TatMetaSQL;
   Case index of
      0 : ShowSQL(MetaSQL.SQL);
   end;
end;
{$ENDIF}

procedure TatMetaSQLEditor.Edit;
begin
  ExecuteVerb(0);
// inherited;
end;

end.
