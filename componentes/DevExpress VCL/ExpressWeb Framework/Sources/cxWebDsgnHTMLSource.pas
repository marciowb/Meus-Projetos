{*******************************************************************}
{                                                                   }
{       ExpressWeb Framework by Developer Express                   }
{       Designer Module                                             }
{                                                                   }
{       Copyright (c) 2000-2010 Developer Express Inc.              }
{       ALL RIGHTS RESERVED                                         }
{                                                                   }
{   The entire contents of this file is protected by U.S. and       }
{   International Copyright Laws. Unauthorized reproduction,        }
{   reverse-engineering, and distribution of all or any portion of  }
{   the code contained in this file is strictly prohibited and may  }
{   result in severe civil and criminal penalties and will be       }
{   prosecuted to the maximum extent possible under the law.        }
{                                                                   }
{   RESTRICTIONS                                                    }
{                                                                   }
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES           }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE    }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS   }
{   LICENSED TO DISTRIBUTE THE EXPRESSWEB FRAMEWORK AND ALL         }
{   ACCOMPANYING VCL CLASSES AS PART OF AN EXECUTABLE WEB           }
{   APPLICATION ONLY.                                               }
{                                                                   }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED      }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE        }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE       }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT  }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                      }
{                                                                   }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON       }
{   ADDITIONAL RESTRICTIONS.                                        }
{                                                                   }
{*******************************************************************}
unit cxWebDsgnHTMLSource;

interface

uses
  Classes, SysUtils, ToolsAPI, DesignIntf;

type
  TcxWebDsgnHTMLSource = class
    FSourceEditor: IOTASourceEditor;

    function GetSourceEditor(AFileName: string; ADesigner: IDesigner): IOTASourceEditor;
    function ReadHTML: string;
    procedure WriteHTML(AText: string);
    function IsReadonly: Boolean;
  public
    constructor Create(AFileName: string; ADesigner: IDesigner);
    destructor Destroy; override;

    procedure ChangeComponentName(const AOldName, ANewName: string);
    function HasHTMLFile: Boolean;
    procedure ReRequestSourceEditor(AFileName: string; ADesigner: IDesigner);
    procedure ShowParserError(AParserError: Boolean; const AErrorStr, AMessage: string);


    property SourceEditor: IOTASourceEditor read FSourceEditor;
    property HTML: string read ReadHTML write WriteHTML;
  end;

implementation

{ TcxWebDsgnHTMLSource }
constructor TcxWebDsgnHTMLSource.Create(AFileName: string; ADesigner: IDesigner);
begin
  inherited Create;
  FSourceEditor := GetSourceEditor(AFileName, ADesigner);
end;

destructor TcxWebDsgnHTMLSource.Destroy;
begin
  FSourceEditor := nil;
  inherited Destroy;
end;

procedure TcxWebDsgnHTMLSource.ChangeComponentName(const AOldName, ANewName: string);
var
  AHTML, APosHTML: string;
  AIsDirty, AFounded: Boolean;
  APos: Integer;
  
begin
  if SourceEditor = nil then exit;
  AHTML := ReadHTML;
  AIsDirty := False;
  APosHTML := AHTML;
  AHTML := '';
  APos := Pos(UpperCase(AOldName), UpperCase(APosHTML));
  while APos > 0 do
  begin
    if (APos > 1) and not (APosHTML[APos - 1] in ['0'..'1', 'A'..'z']) and
      (APos + Length(AOldName) < Length(APosHTML)) and
      not (APosHTML[APos + Length(AOldName)] in ['0'..'1', 'A'..'z']) then
      AFounded := True
   else AFounded := False;
   if AFounded then
   begin
     AHTML := AHTML + Copy(APosHTML, 1, APos  - 1) + ANewName;
     AIsDirty := True;
   end
   else AHTML := AHTML + Copy(APosHTML, 1, APos + Length(AOldName));
   APosHTML := Copy(APosHTML, APos + Length(AOldName), Length(APosHTML) - APos - Length(AOldName));
   APos := Pos(UpperCase(AOldName), UpperCase(APosHTML));
  end;
  if AIsDirty then
  begin
    AHTML := AHTML + APosHTML;
    WriteHTML(AHTML);
  end;
end;

function TcxWebDsgnHTMLSource.HasHTMLFile: Boolean;
begin
  Result := SourceEditor <> nil;
end;

procedure TcxWebDsgnHTMLSource.ReRequestSourceEditor(AFileName: string; ADesigner: IDesigner);
begin
  if SourceEditor = nil then
    FSourceEditor := GetSourceEditor(AFileName, ADesigner);
end;


function TcxWebDsgnHTMLSource.GetSourceEditor(AFileName: string; ADesigner: IDesigner): IOTASourceEditor;

  function GetDesignerByFormModule(AFormModule: IOTAModule): IDesigner;
  var
    I: Integer;
    AFormEditor: IOTAFormEditor;
    ANTAFormEditor: INTAFormEditor;
  begin
    Result := nil;
    for I := 0 to AFormModule.ModuleFileCount - 1 do
      if AFormModule.GetModuleFileEditor(I).QueryInterface(IOTAFormEditor, AFormEditor) = S_OK then
      begin
        if AFormEditor.QueryInterface(INTAFormEditor, ANTAFormEditor) = S_OK then
          Result := ANTAFormEditor.FormDesigner;
        break;
      end;
  end;
var
  ModuleServices: IOTAModuleServices;
  FormModule: IOTAModule;
  Addon: IOTAAdditionalModuleFiles;
  I: Integer;
begin
  Result := nil;
  ModuleServices := BorlandIDEServices as IOTAModuleServices;
  if AFileName <> '' then
    FormModule := ModuleServices.FindModule(AFileName)
  else
  begin
    FormModule := ModuleServices.CurrentModule;
    if GetDesignerByFormModule(FormModule) <> ADesigner then
      FormModule := nil;
    if FormModule <> nil then
    begin
      for I := 0 to ModuleServices.ModuleCount - 1 do
        if GetDesignerByFormModule(ModuleServices.Modules[I]) = ADesigner then
        begin
          FormModule := ModuleServices.Modules[I];
          break;
        end;
    end;    
  end;
  if FormModule <> nil then
  begin
    FormModule.QueryInterface(IOTAAdditionalModuleFiles, Addon);
    if Addon <> nil then
    begin
      for I := 0 to Addon.AdditionalModuleFileCount - 1 do
        if Pos('.html', Addon.AdditionalModuleFileEditors[I].FileName) > 0 then
        begin
          Result := Addon.AdditionalModuleFileEditors[I] as IOTASourceEditor;
          break;
        end;
    end;
  end
end;

procedure TcxWebDsgnHTMLSource.ShowParserError(AParserError: Boolean; const AErrorStr, AMessage: string);

  procedure LocateError;
  var
    I: Integer;
    ASearchError: Integer;
  begin
    for I := 0 to SourceEditor.EditViewCount - 1 do
    begin
      if SourceEditor.EditViews[I].Position.Search(AErrorStr, True, False, True, sdForward, ASearchError) then
      begin
        if AParserError then
          SourceEditor.EditViews[I].Position.MoveRelative(0, 1);
        break;
      end;
    end;

  end;

begin
  if SourceEditor = nil then exit;
  SourceEditor.Show;
  LocateError;

  raise Exception.Create(AMessage);
end;


const
  EditorBufferSize = 1024;

function TcxWebDsgnHTMLSource.ReadHTML: string;
var
  i: Integer;
  Reader: IOTAEditReader;
  Buffer: PChar;
  ReadSize: Integer;
begin
  Result := '';
  if SourceEditor = nil then exit;
  Reader := SourceEditor.CreateReader;
  if Reader <> nil then
  begin
    Buffer := StrAlloc(EditorBufferSize + 1);
    i := 0;
    ReadSize := EditorBufferSize;
    while(ReadSize = EditorBufferSize) do
    begin
      ReadSize := Reader.GetText(i, Buffer, EditorBufferSize);
      Buffer[ReadSize] := #0;
      Inc(i, ReadSize);
      Result := Result + Buffer;
    end;
    StrDispose(Buffer);
  end;
end;

procedure TcxWebDsgnHTMLSource.WriteHTML(AText: string);
var
  Writer: IOTAEditWriter;
begin
  if (SourceEditor = nil) or IsReadonly then exit;
  Writer := SourceEditor.CreateWriter;
  if Writer <> nil then
  begin
    Writer.DeleteTo(MaxInt);
    Writer.Insert(PChar(AText));
  end;
end;

function TcxWebDsgnHTMLSource.IsReadonly: Boolean;
var
  AFileSystem: IOTAFileSystem;
begin
  Result := True;
  if (SourceEditor <> nil) and (SourceEditor.Module <> nil) then
  begin
    if (SourceEditor.Module.FileSystem <> '') then
    begin
      AFileSystem := (BorlandIDEServices as IOTAModuleServices).FindFileSystem(SourceEditor.Module.FileSystem);
      if AFileSystem <> nil then
        Result := AFileSystem.IsReadonly(SourceEditor.FileName);
    end else
    begin
      Result := SysUtils.FileExists(SourceEditor.FileName) and SysUtils.FileIsReadOnly(SourceEditor.FileName);
    end;
  end;
end;

end.
