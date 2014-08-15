unit IDEReg;

{$I tmsdefs.inc}

interface
uses Classes, IDEMain;

procedure Register;

implementation
uses
  IDEDialog,
  {$IFDEF DELPHI6_LVL}
  DesignIntf, DesignEditors,
  {$ELSE}
  DsgnIntf,
  {$ENDIF}
  DesignerControlsEditor, FormDesigner;

type
  TIDEOICompProperty = class(TComponentProperty)
    procedure GetValues(Proc: TGetStrProc); override;
  end;

  TIDEFormDesignerEditor = class(TComponentEditor)
    function GetVerbCount: Integer; override;
    function GetVerb(Index: Integer): string; override;
    procedure ExecuteVerb(Index: Integer); override;
  end;

procedure TIDEOICompProperty.GetValues(Proc: TGetStrProc);
var
  P: TPersistent;
begin
  inherited;
  P := GetComponent(0);
  if P is TComponent then Proc(Designer.GetObjectName(TComponent(P).Owner));
end;

function TIDEFormDesignerEditor.GetVerbCount: Integer;
begin
  Result:=1;
end;

function TIDEFormDesignerEditor.GetVerb(Index: Integer): string;
begin
  Result:='Control &lists editor...';
end;

procedure TIDEFormDesignerEditor.ExecuteVerb(Index: Integer);
begin
  if EditLists(Component as TIDEFormDesigner, ltLocked) then Designer.Modified;
end;

procedure Register;
begin
  RegisterComponents('Scripter Studio', [
    TIDEEngine, TIDEScripter, TIDEDialog, TIDEFormDesignControl, TIDEInspector, TIDEPaletteToolbar, TIDEMemo, TIDEComponentComboBox,
    TIDEWatchListView]);
  {$IFDEF DELPHI9_LVL}
  RegisterComponents('Scripter Studio', [TIDEPaletteButtons]);
  {$ENDIF}

  RegisterPropertyEditor(TypeInfo(TComponent), TIDEInspector, 'Root', TIDEOICompProperty);
  RegisterPropertyEditor(TypeInfo(TComponent), TIDEInspector, 'Instance', TIDEOICompProperty);
  RegisterPropertyEditor(TypeInfo(TComponent), TIDEComponentComboBox, 'Root', TIDEOICompProperty);
  RegisterPropertyEditor(TypeInfo(TComponent), TIDEComponentComboBox, 'Instance', TIDEOICompProperty);

  {RegisterPropertyEditor(TypeInfo(TComponent), TComponentTree,'Root',TOIComponentProperty);
  RegisterPropertyEditor(TypeInfo(TComponent), TComponentTree,'Instance',TOIComponentProperty);}
  
  RegisterComponentEditor(TIDEFormDesigner, TIDEFormDesignerEditor);
end;

end.
