unit atMetaSQLAbstractEditor;

{$I tmsdefs.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,atMetaSQL;

type
  TfmMetaSQLAbstractEditor = class(TFrame)
  private
    FMetaSQL: TatMetaSQL;
    FDatabaseName: string;
    procedure SetDatabaseName(const Value: string);
    function GetMetaSQLOwner: TComponent;
  protected
    procedure SetMetaSQL(Value: TatMetaSQL); virtual;
    {Override this to load any db-related lists, like combo boxes}
    procedure LoadDBItems; virtual;
  public
     procedure DeActivateEditor; virtual;
     procedure ActivateEditor; virtual;
     property MetaSQL: TatMetaSQL read FMetaSQL write SetMetaSQL;
     property DatabaseName: string read FDatabaseName write SetDatabaseName;
     property MetaSQLOwner: TComponent read GetMetaSQLOwner;
  end;

implementation
uses atMetaSQLFOrm;

{$R *.DFM}

{ TfmMetaSQLAbstractEditor }

procedure TfmMetaSQLAbstractEditor.SetMetaSQL(Value: TatMetaSQL);
begin
   FMetaSQL:=Value;
end;

procedure TfmMetaSQLAbstractEditor.SetDatabaseName(const Value: string);
begin
   FDatabaseName := Value;
   LoadDBItems;
end;

procedure TfmMetaSQLAbstractEditor.LoadDBItems;
begin
end;

procedure TfmMetaSQLAbstractEditor.ActivateEditor;
begin
   SetFocus;
end;

procedure TfmMetaSQLAbstractEditor.DeActivateEditor;
begin
end;

function TfmMetaSQLAbstractEditor.GetMetaSQLOwner: TComponent;
begin
  if Assigned(Owner) and (Owner is TfmMetaSQLEditor) then
    result:=TfmMetaSQLEditor(Owner).MetaSQLOwner
  else
    result := nil;
end;

end.
