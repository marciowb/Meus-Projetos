unit DFlexCelReportEditor;
{$IFDEF LINUX}{$INCLUDE ../FLXCOMPILER.INC}{$ELSE}{$INCLUDE ..\FLXCOMPILER.INC}{$ENDIF}
interface
uses
  {$IFNDEF FLX_FPC}Windows, ShellAPI,{$ENDIF}
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  {$IFDEF FLX_FPC}
      ComponentEditors,
  {$ELSE}
    {$IFDEF FLX_NEEDSDESIGNINTF}  //Delphi 6 or above
      DesignIntf, DesignEditors,
    {$ELSE}
      DsgnIntf,
    {$ENDIF}
  {$ENDIF}
  UCustomFlexCelReport, UFlxMessages, UExcelEdit, UFlxDesignHelp, UCheckTemplate;
type
  TFlexCelReportEditor = class(TComponentEditor)
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
function TFlexCelReportEditor.GetVerbCount: Integer;
begin
  Result := 5;
end;

function TFlexCelReportEditor.GetVerb(Index: Integer): String;

begin
  case Index of
    0: Result := 'Edit Report...';
    1: Result := 'Open Report';
    2: Result := 'Check Report...';
    3: Result := 'Check All Reports on Datamodule...';
    4: Result := 'About...';
  end;
end;


procedure TFlexCelReportEditor.ExecuteVerb(Index: Integer);
var
  FName: string;
  Fr, Fr1: TCustomFlexCelReport;
  CheckTemplate: TCheckTemplate;
  i: integer;
begin
  chdir(ExtractFilePath(GetActiveProjectFileName));
  case Index of
    0:
    begin
      Fr:=(Component as TCustomFlexCelReport);
      {$IFDEF FLX_FPC}
        ShowMessage('Report designer is not available in Lazarus');
      {$ELSE}
        InvokeExcelEditor(Fr, GetActiveProjectFileName);
      {$ENDIF}
    end;
    1:
    begin
      if (Component as TCustomFlexCelReport).Adapter=nil then raise Exception.Create(ErrNoAdapter);
      try
        FName:=SearchPathStr((Component as TCustomFlexCelReport).Adapter.BasePathToOpen, (Component as TCustomFlexCelReport).Template);
      except
        on e:Exception do
        begin
          ShowMessage(format(ErrNoTemplate, [e.Message, GetActiveProjectFileName]));
          exit;
        end;
      end; //except

      {$IFDEF FLX_FPC}
        SysUtils.ExecuteProcess(FName, []);
      {$ELSE}
        ShellExecute( 0, 'open', PCHAR(FName), nil, nil, SW_SHOWMAXIMIZED);
      {$ENDIF}
    end;

    2:
    begin
      Fr:=(Component as TCustomFlexCelReport);
      InvokeCheckTemplate(Fr, Nil, True, Fr.Template, GetActiveProjectFileName);
    end;
    3:
    begin
      Fr:=(Component as TCustomFlexCelReport);
      CheckTemplate:=TCheckTemplate.Create(Nil);
      try
        for i:=0 to Fr.DesignDataModule.ComponentCount-1 do
          if (Fr.DesignDataModule.Components[i] is TCustomFlexCelReport) then
          begin
            Fr1:=(Fr.DesignDataModule.Components[i] as TCustomFlexCelReport);
            InvokeCheckTemplate(Fr1, CheckTemplate, True, Fr1.Template, GetActiveProjectFileName);
          end;
        CheckTemplate.ShowModal;
      finally
        FreeAndNil(CheckTemplate);
      end; //Finally
    end;

    4: ShowMessage(Format(MsgAbout,[FlexCelVersion]));
  end  //case
end;
end.
