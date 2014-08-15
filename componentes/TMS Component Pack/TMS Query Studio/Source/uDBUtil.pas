unit uDBUtil;

{$I tmsdefs.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, CheckLst, Grids, DBGrids, ComCtrls, ImgList, Menus,
  Db, DbTables, Buttons, TypInfo;

function PrettyText(s:string): string;
procedure PrettyTextList( lst: TStringList; ASort: boolean=True );
procedure LoadTableNameList( ADBName: string; lst: TStrings );
procedure LoadFieldNameList( ADBName,ATableName: string; lst: TStrings );
function ExtractName( AName: string ): string;
function RemoveNameExt( ATableName: string ): string;

var
  DisablePrettyText : Boolean;

implementation

function RemoveNameExt( ATableName: string ): string;
var p: integer;
begin
  p := Pos('.',ATableName);
  if p=0 then
    result := ATableName
  else
    result := Copy(ATableName,1,p-1);
end;

function ExtractName( AName: string ): string;
var c: integer;
begin
  { ignora símbolos especiais dentro do nome dado }
  result := '';
  for c:=1 to Length(AName) do
    {$IFDEF DELPHI2009_LVL}
    if CharInSet(UpCase(AName[c]), ['A'..'Z','_','0'..'1']) then
    {$ELSE}
    if UpCase(AName[c]) in ['A'..'Z','_','0'..'1'] then
    {$ENDIF}
      result := result + AName[c];
end;

function PrettyText(s:string): string;
begin
   result := AnsiUpperCase(Copy(s,1,1))+AnsiLowerCase(Copy(s,2,Length(s)));
end;

procedure LoadTableNameList( ADBName: string; lst: TStrings );
begin
  if ADBName > '' then
  begin
    lst.BeginUpdate;
    try
      lst.Clear;
      Session.GetTableNames(ADBName,'',True,False,lst); // inclui extensão para permitir Paradox e DBase
    finally
      lst.EndUpdate;
    end;
  end;
end;

procedure PrettyTextList( lst: TStringList; ASort: boolean=True );
var c: integer;
begin
  with lst do
  try
    BeginUpdate;
    for c:=0 to Count-1 do
      Strings[c]:=PrettyText(Strings[c]);
    if ASort then
      lst.Sort;
  finally
    EndUpdate;
  end;
end;

procedure LoadFieldNameList( ADBName,ATableName: string; lst: TStrings );
var table: TTable;
    c: integer;
begin
  lst.BeginUpdate;
  try
    lst.Clear;
    if (ADBName > '') and (ATableName > '') then
    begin
        table:=TTable.Create(nil);
        try
          table.DatabaseName := ADBName;
          table.TableName := ATableName;
          table.FieldDefs.Update;
          for c:=0 to table.FieldDefs.Count-1 do
            lst.AddObject(
              table.FieldDefs[c].Name,
              TObject(Ord(table.FieldDefs[c].DataType)) );
        finally
          table.Free;
        end;
    end;
  finally
    lst.EndUpdate;
  end;
end;

end.
