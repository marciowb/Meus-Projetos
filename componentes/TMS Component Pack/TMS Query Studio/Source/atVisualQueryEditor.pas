unit atVisualQueryEditor;

interface

{$I tmsdefs.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
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
  StdCtrls, ExtCtrls, ComCtrls, atVisualQuery, atMetaSQL;

type
  TfmVisualQueryEditor = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    atVisualQuery1: TatVisualQuery;
    procedure FormShow(Sender: TObject);
  private
    procedure Localize;
  protected
    procedure Loaded; override;
  public
  end;

  TatVisualQueryEditor = class(TDefaultEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
    procedure Edit; override;
  end;

function EditVisualQuery( AVisualQuery: TatVisualQuery ): boolean;

var
  fmVisualQueryEditor: TfmVisualQueryEditor;

implementation

uses
  qsRes;

{$R *.DFM}

function EditVisualQuery( AVisualQuery: TatVisualQuery ): boolean;
begin
  with TfmVisualQueryEditor.Create(Application) do
  try
    atVisualQuery1.Assign( AVisualQuery );
    { também copia propriedades visuais para que a edição
      seja mais próxima do Wysiwyg }
    atVisualQuery1.Color := AVisualQuery.Color;
    atVisualQuery1.EditorColor := AVisualQuery.EditorColor;
    atVisualQuery1.Font := AVisualQuery.Font;
    atVisualQuery1.Ctl3d := AVisualQuery.Ctl3d;

    result := (ShowModal = mrOk);
    if result then
    begin
      AVisualQuery.Assign( atVisualQuery1 );
      AVisualQuery.UpdateCurrentQuery( True );
    end;
  finally
    Release;
  end;
end;

{ TatVisualQueryEditor }

procedure TatVisualQueryEditor.Edit;
begin
  ExecuteVerb(0);
end;

procedure TatVisualQueryEditor.ExecuteVerb(Index: Integer);
var visualQuery : TatVisualQuery;
begin
  if (index>=0) and (index<GetVerbCount) then
  begin
    visualQuery := Component as TatVisualQuery;
    case index of
      0 : EditVisualQuery( visualQuery );
      1 : visualQuery.ImportFromTargetDataset;
      2 : visualQuery.ImportFromTargetMetaSql;
      3 : visualQuery.ImportQueriesFromFile;
      4 : visualQuery.ExportQueriesToFile;
    end;
    Designer.Modified;
  end;
end;

function TatVisualQueryEditor.GetVerb(Index: Integer): string;
begin
  { *** futuramente implementar um importador de consultas mais completo,
    com opções para escolha da fonte (dataset, meta-sql ou mesmo outro visualquery }
  case Index of
    0 : result := _str(SVisualQueryEditor) + '...';
    1 : result := _str(SImportQueryFromTargetDataset);
    2 : result := _str(SImportQueryFromTargetMetaSQL);
    3 : result := _str(SImportQueriesFromFile) + '...';
    4 : result := _str(SExportQueriesToFile) + '...';
  end;
end;

function TatVisualQueryEditor.GetVerbCount: Integer;
begin
//result := 5; options 3 and 4 are disabled now 
  result := 3;
end;

procedure TfmVisualQueryEditor.FormShow(Sender: TObject);
begin
  atVisualQuery1.FullExpand;
end;

procedure TfmVisualQueryEditor.Loaded;
begin
  inherited;
  Localize;
end;

procedure TfmVisualQueryEditor.Localize;
begin
  Self.Caption := _str('fmVisualQueryEditor.Self.Caption');
  TabSheet1.Caption := _str('fmVisualQueryEditor.TabSheet1.Caption');
  atVisualQuery1.MetaSqlDefs[0].Title := _str('fmVisualQueryEditor.atVisualQuery1.MetaSqlDefs0.Title');
  Button1.Caption := _str('fmVisualQueryEditor.Button1.Caption');
  Button2.Caption := _str('fmVisualQueryEditor.Button2.Caption');
end;

end.
