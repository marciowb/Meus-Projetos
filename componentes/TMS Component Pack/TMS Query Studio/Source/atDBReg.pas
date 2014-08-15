unit atdbreg;

{$I tmsdefs.inc}

{$IFDEF TMSDOTNET}
{$R TatVisualQuery.bmp}
{$ENDIF}

interface

const
  SQueryStudioPaletteName = 'TMS Query Studio';
//  SQueryStudioExtraPaletteName = 'QS Extra';

procedure Register;

implementation

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
  Classes,
  DB, DBTables,
  atVisualQuery,
  atVisualQueryEditor
  {atPanel, atListBoxDlg,
  atSQLConditionPanel,
  atSQLConditionPanelEditor,
  atSQLControls,
  atMetaSQLEditor,
  atMetaSQL,
  atCheckListEdit,
  atVisualQuery,
  atVisualQueryEditor,
  atQueryCombo,
  atDatabase,
  atBdeDatabase,
  atCustomDatabase,
  atDataDictionary,
  atObjectStorage};


procedure Register;
begin
  { Query studio }
  RegisterComponents( SQueryStudioPaletteName, [TatVisualQuery] );
  RegisterComponentEditor( TatVisualQuery, TatVisualQueryEditor );
//  RegisterComponents( SQueryStudioExtraPaletteName, [TatComboBox,TatQueryCombo]);
end;

initialization
  RegisterClasses([ TatVisualQuery]);
end.
