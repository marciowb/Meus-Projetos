unit UFlexCelDbMemEditor;
{$IFDEF LINUX}{$INCLUDE ../FLXCOMPILER.INC}{$ELSE}{$INCLUDE ..\FLXCOMPILER.INC}{$ENDIF}
{$IFDEF LINUX}{$INCLUDE ../FLXCONFIG.INC}{$ELSE}{$INCLUDE ..\FLXCONFIG.INC}{$ENDIF}

interface
  uses
  {$IFDEF FLX_CLX}
    QDialogs,
  {$ENDIF}
  {$IFDEF FLX_VCL}
    Dialogs,
  {$ENDIF}

  {$IFDEF FLX_FPC}
      ComponentEditors, PropEdits,
  {$ELSE}
    {$IFDEF FLX_NEEDSDESIGNINTF}
      DesignIntf, DesignEditors,
    {$ELSE}
      DsgnIntf,
    {$ENDIF}
  {$ENDIF}

    SysUtils, UFlxMemTable, UFlxMessages;

type
  TFlexCelDbMemEditor = class(TDefaultEditor )
  private
    { Private declarations }
  protected
  {$IFDEF FLX_FPC}
      procedure EditProperty(const PropertyEditor: TPropertyEditor; var Continue: boolean); override;
  {$ELSE}
    {$IFDEF FLX_NEEDSDESIGNINTF}
      procedure EditProperty(const PropertyEditor: IProperty; var Continue: Boolean); override;
    {$ELSE}
      procedure EditProperty(PropertyEditor: TPropertyEditor; var Continue, FreeEditor: Boolean); override;
    {$ENDIF}
  {$ENDIF}
    { Protected declarations }
  public
    { Public declarations }
    function GetVerb(Index: Integer): String; override;
    function GetVerbCount: Integer; override;
    procedure ExecuteVerb(Index: Integer); override;
  end;

implementation
function TFlexCelDbMemEditor.GetVerbCount: Integer;
begin
  Result := 2;
end;

function TFlexCelDbMemEditor.GetVerb(Index: Integer): String;

begin
  case Index of
    0: Result := 'Edit Fields...';
    1: Result := 'About...';
  end;
end;

procedure TFlexCelDbMemEditor.ExecuteVerb(Index: Integer);
var
  IsModified: boolean;
begin
  IsModified:=false;
  case Index of
    0: Edit; //(Component as TFlxMemTable).Columns.Edit;
    1: ShowMessage(Format(MsgAbout,[FlexCelVersion]));
  end;  //case
  if IsModified then Designer.Modified;
end;

{$IFDEF FLX_FPC}
  procedure TFlexCelDbMemEditor.EditProperty(const PropertyEditor: TPropertyEditor; var Continue: boolean);
{$ELSE}
  {$IFDEF FLX_NEEDSDESIGNINTF}  //Delphi 6 or above
    procedure TFlexCelDbMemEditor.EditProperty(const PropertyEditor: IProperty; var Continue: Boolean);
  {$ELSE}
    procedure TFlexCelDbMemEditor.EditProperty(PropertyEditor: TPropertyEditor; var Continue, FreeEditor: Boolean);
  {$ENDIF}
{$ENDIF}
begin
  if (CompareText(PropertyEditor.GetName, 'Columns')=0) then
  begin
    PropertyEditor.Edit;
    Continue:=false;
  end
  else inherited;
end;


end.
