unit UFlexCelTemplateEditor;
{$IFDEF LINUX}{$INCLUDE ../FLXCOMPILER.INC}{$ELSE}{$INCLUDE ..\FLXCOMPILER.INC}{$ENDIF}
{$IFDEF LINUX}{$INCLUDE ../FLXCONFIG.INC}{$ELSE}{$INCLUDE ..\FLXCONFIG.INC}{$ENDIF}

interface

uses
  {$IFDEF FLX_CLX}
    SysUtils, Classes, QGraphics, QControls, QForms, QDialogs,
  {$ENDIF}
  {$IFDEF FLX_VCL}
    Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  {$ENDIF}

  {$IFDEF FLX_FPC}
      ComponentEditors,
  {$ELSE}
    {$IFDEF FLX_NEEDSDESIGNINTF}  //Delphi 6 or above
      DesignIntf, DesignEditors,
    {$ELSE}
      DsgnIntf,
    {$ENDIF}
  {$ENDIF}  
    TemplateStore, UFlxMessages, UFlxDesignHelp, UTemplateEdit;
type
  TFlexCelTemplateEditor = class(TComponentEditor)
  private
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
    function GetVerb(Index: Integer): String; override;
    function GetVerbCount: Integer; override;
    procedure ExecuteVerb(Index: Integer); override;
  end;

implementation
function TFlexCelTemplateEditor.GetVerbCount: Integer;
begin
  Result := 3;
end;

function TFlexCelTemplateEditor.GetVerb(Index: Integer): String;

begin
  case Index of
    0: Result := 'Edit Template Store...';
    1: Result := 'Refresh...';
    2: Result := 'About...';
  end;
end;

procedure TFlexCelTemplateEditor.ExecuteVerb(Index: Integer);
var
  IsModified: boolean;
begin
  IsModified:=false;
  chdir(ExtractFilePath(GetActiveProjectFileName));
  case Index of
    0: InvokeTemplateEditor(Component as TXLSTemplateStore, IsModified);
    1: begin;RefreshTemplateStore(Component as TXLSTemplateStore, IsModified);showmessage(TxtTemplateStoreRefreshed);end;
    2: ShowMessage(Format(MsgAbout,[FlexCelVersion]));
  end;  //case
  if IsModified then Designer.Modified;
end;

end.
