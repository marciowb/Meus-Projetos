{************************************************}
{                                                }
{               EurekaLog v 6.x                  }
{    ToolServices API classes - EToolServices    }
{                                                }
{  Copyright (c) 2001 - 2008 by Fabio Dell'Aria  }
{                                                }
{************************************************}

unit EToolServices;

{$I Exceptions.inc}

interface

uses
  Windows, SysUtils, Classes;

{$I VersionStrings.inc}

procedure InitMenu;
procedure InitDelayedMenu;
procedure DoneMenu;
procedure InitNotifier;
procedure DoneNotifier;

implementation

uses
  ECommon, EBaseModule, ECore, EOption, EConsts, EParser, ExptIntf, ToolIntf,
  EditIntf, IniFiles, Forms, Messages;

type
  TOnClickWrapper = class
    class procedure OnOptionsClick(Sender: TIMenuItemIntF);
    class procedure OnViewLogClick(Sender: TIMenuItemIntF);
    class procedure OnTutorialClick(Sender: TIMenuItemIntF);
    class procedure OnAboutClick(Sender: TIMenuItemIntF);
    class procedure OnIDEOptionsClick(Sender: TIMenuItemIntF);
{$IFDEF Delphi4Up}
    class procedure OnHelpOptionsClick(Sender: TIMenuItemIntF);
{$ENDIF}    
{$IFDEF EUREKALOG_DEMO}
    class procedure OnBuyClick(Sender: TIMenuItemIntF);
{$ENDIF}
  end;

  TIDENewManager = class(TIDEManager)
  public
    class function InstallNotifier(const FileName: AnsiString): Boolean; override;
    class function RemoveNotifier(const FileName: AnsiString): Boolean; override;
    class procedure MarkModified(const FileName: AnsiString); override;
    class function GetText(const FileName: AnsiString): AnsiString; override;
    class procedure InsertText(const FileName: AnsiString; StartPos: Integer; Text: PAnsiChar); override;
    class procedure DeleteText(const FileName: AnsiString; StartPos, EndPos: Integer); override;
    class function ShowFile(CompiledFile, UnitName, ProcName: AnsiString;
      Line, Offset: Integer; Compiled: TDateTime): Boolean; override;
    class procedure UnloadProjectsList; override;
  end;

  TNewAddIn = class(TIAddInNotifier)
    procedure FileNotification(NotifyCode: TFileNotification;
      const FileName: AnsiString; var Cancel: Boolean); override;
    procedure EventNotification(NotifyCode: TEventNotification;
      var Cancel: Boolean); override;
  end;

  TNewModuleNotifier = class(TIModuleNotifier)
  protected
    FModule: AnsiString;
    FIndex: Integer;
  public
    constructor Create(AModule: AnsiString);
    procedure Notify(NotifyCode: TNotifyCode); override;
    procedure ComponentRenamed(ComponentHandle: Pointer;
      const OldName, NewName: AnsiString); override;
  end;

//------------------------------------------------------------------------------

var
  AddIn: TNewAddIn = nil;
  SepItem, OptItem, OptView, OptTutorial, OptAbout
  {$IFDEF EUREKALOG_DEMO} ,BuySep, BuyItem {$ENDIF}, Sep2Item, Opt2Item,
  Sep3Item, Opt3Item: TIMenuItemIntf;

//------------------------------------------------------------------------------

constructor TNewModuleNotifier.Create(AModule: AnsiString);
begin
  FModule := AModule;
end;

procedure TNewModuleNotifier.Notify(NotifyCode: TNotifyCode);
var
  Index: Integer;
begin
  if IsEurekaLogPackage(FModule) then Exit;

  if NotifyCode in [ncModuleDeleted, ncAfterSave] then
  begin
    Index := ModuleOptions.FindByName(FModule);
    if (Index = -1) then Exit;
    
    if NotifyCode = ncModuleDeleted then
    begin
      ModuleOptions.Delete(Index);
      IDEManager.RemoveNotifier(FModule);
    end
    else
      if NotifyCode = ncAfterSave then
      begin
        FModule := GetCurrentModuleNameProc;
        ModuleOptions[Index].Name := FModule;
        ModuleOptions[Index].SaveOptions;
      end;
  end;
end;

procedure TNewModuleNotifier.ComponentRenamed(ComponentHandle: Pointer;
  const OldName, NewName: AnsiString);
begin
end;

procedure TNewAddIn.FileNotification(NotifyCode: TFileNotification;
  const FileName: AnsiString; var Cancel: Boolean);
var
  F: AnsiString;
  Opt: TIniFile;
  Ext: AnsiString;
begin
  HookApplicationOnException;

  if (IsEurekaLogPackage(FileName)) then Exit;

  if (ToolServices <> nil) then
  begin
    Ext := UpperCase(ExtractFileExt(FileName));
    if (CurrentPersonality.IsOptionEqual(Ext, otProjectFileExt, FileName)) or
      (CurrentPersonality.IsOptionEqual(Ext, otPackageFileExt, FileName)) then
    begin
      if (NotifyCode = fnProjectOpening) then
      begin
        F := ChangeFileExt(FileName, OptionFileExt(FileName));
        if (FileExists(F)) and (FileGetAttr(F) and faReadOnly = 0) then
        begin
          Opt := TIniFile.Create(F);
          try
            if (Opt.ReadString('Compiler', 'D', '0') <> '1') then
              Opt.WriteString('Compiler', 'D', '1');
            if (Opt.ReadString('Linker', 'MapFile', '0') <> '3') then
              Opt.WriteString('Linker', 'MapFile', '3');
          finally
            Opt.Free;
          end;
        end;
      end
      else
        if (NotifyCode = fnProjectOpened) then IDEManager.CheckAndInstallNotify(FileName);
    end;
  end;
end;

procedure TNewAddIn.EventNotification(NotifyCode: TEventNotification; var Cancel: Boolean);
begin
  if (GetCurrentModuleNameProc = '') then Exit;

  case NotifyCode of
    enBeforeCompile:
    begin
      if (ModuleOptions.CurrentModule <> nil) then
      begin
        IDEManager.CheckAndInstallNotify(ModuleOptions.CurrentModule.Name);
        ModuleOptions.CurrentModule.BeforeCompile;
      end
    end;
    enAfterCompile:
      ModuleOptions.CurrentModule.AfterCompile;
  end;
end;

//------------------------------------------------------------------------------

{ TOnClickWrapper }

class procedure TOnClickWrapper.OnOptionsClick(Sender: TIMenuItemIntF);
begin
  TMenuEvents.OnOptionsClick(nil);
end;

class procedure TOnClickWrapper.OnViewLogClick(Sender: TIMenuItemIntF);
begin
  TMenuEvents.OnViewLogClick(nil);
end;

class procedure TOnClickWrapper.OnTutorialClick(Sender: TIMenuItemIntF);
begin
  TMenuEvents.OnTutorialClick(nil);
end;

class procedure TOnClickWrapper.OnAboutClick(Sender: TIMenuItemIntF);
begin
  TMenuEvents.OnAboutClick(nil);
end;

{$IFDEF EUREKALOG_DEMO}
class procedure TOnClickWrapper.OnBuyClick(Sender: TIMenuItemIntF);
begin
  TMenuEvents.OnBuyClick(nil);
end;
{$ENDIF}

class procedure TOnClickWrapper.OnIDEOptionsClick(Sender: TIMenuItemIntF);
begin
  TMenuEvents.OnIDEOptionsClick(nil);
end;

{$IFDEF Delphi4Up}
class procedure TOnClickWrapper.OnHelpOptionsClick(Sender: TIMenuItemIntF);
begin
  TMenuEvents.OnHelpOptionsClick(nil);
end;
{$ENDIF}

//------------------------------------------------------------------------------

{ TIDENewManager }

class procedure TIDENewManager.DeleteText(const FileName: AnsiString; StartPos, EndPos: Integer);
var
  // IDE interfaces...
  Module: TIModuleInterface;
  Editor: TIEditorInterface;
  Writer: TIEditWriter;
begin
  Module := ToolServices.GetModuleInterface(FileName);
  try
    Editor := Module.GetEditorInterface;
    try
      Writer := Editor.CreateWriter;
      try
        Writer.CopyTo(StartPos);
        Writer.DeleteTo(EndPos);
      finally
        Writer.Free;
      end;
    finally
      Editor.Free;
    end;
  finally
    Module.Free;
  end;
end;

class function TIDENewManager.GetText(const FileName: AnsiString): AnsiString;
var
  // IDE interfaces...
  Module: TIModuleInterface;
  Editor: TIEditorInterface;
  Reader: TIEditReader;

  // Buffer for store Source text (for search "Uses" word).
  Text, TextBuffer: AnsiString;

  Len: integer;
begin
  Result := '';
  if (FileName = '') then Exit; // FName='' into the Temp-Modules...
  Module := ToolServices.GetModuleInterface(FileName);
  if (Assigned(Module)) then
  try
    Editor := Module.GetEditorInterface;

    // Read the Source text (first BufferSize chars)...
    if (Assigned(Editor)) then
    try
      Reader := Editor.CreateReader;
      if (Assigned(Reader)) then
      try
        Text := '';
        repeat
          SetLength(TextBuffer, BuffSize);
          Len := Reader.GetText(length(Text), PAnsiChar(TextBuffer), BuffSize);
          SetLength(TextBuffer, Len);
          Text := Text + TextBuffer;
        until Len = 0;
        Result := Text;
      finally
        Reader.Free;
      end;
    finally
      Editor.Free;
    end;
  finally
    Module.Free;
  end;
end;

class procedure TIDENewManager.InsertText(const FileName: AnsiString;
  StartPos: Integer; Text: PAnsiChar);
var
  // IDE interfaces...
  Module: TIModuleInterface;
  Editor: TIEditorInterface;
  Writer: TIEditWriter;
begin
  Module := ToolServices.GetModuleInterface(FileName);
  try
    Editor := Module.GetEditorInterface;
    try
      Writer := Editor.CreateWriter;
      try
        Writer.CopyTo(StartPos);
        Writer.Insert(Text);
      finally
        Writer.Free;
      end;
    finally
      Editor.Free;
    end;
  finally
    Module.Free;
  end;
end;

class function TIDENewManager.InstallNotifier(const FileName: AnsiString): Boolean;
var
  ModIntf: TIModuleInterface;
  Notifier: TNewModuleNotifier;
begin
  Result := False;
  if (ToolServices <> nil) then
  begin
    // get the module interface
    ModIntf := ToolServices.GetModuleInterface(FileName);
    if (ModIntf <> nil) then
    begin
      // create the module notifier
      Notifier := TNewModuleNotifier.Create(FileName);
      // install the notifier
      ModIntf.AddNotifier(Notifier);
      // add the notifier to the list
      InternalInstallNotifier(FileName, Notifier);
      Result := True;
    end;
  end;
end;

class function TIDENewManager.RemoveNotifier(const FileName: AnsiString): Boolean;
var
  ModIntf: TIModuleInterface;
  Notifier: TNewModuleNotifier;
begin
  Result := False;
  if (ToolServices <> nil) then
  begin
    // get the module interface
    ModIntf := ToolServices.GetModuleInterface(FileName);
    if (ModIntf <> nil) then
    begin
      // checks if the notifier is in the list
      Notifier := FindNotifier(FileName);
      if (Assigned(Notifier)) then
      begin
        ModIntf.RemoveNotifier(Notifier);
       // destroy the notifier
       Notifier.Free;
       Result := True;
      end;
    end;
  end;
end;

class procedure TIDENewManager.MarkModified(const FileName: AnsiString);
var
  Module: TIModuleInterface;
  Editor: TIEditorInterface;
begin
  Module := ToolServices.GetModuleInterface(FileName);
  if (Assigned(Module)) then
  begin
    try
      Editor := Module.GetEditorInterface;
      if (Assigned(Editor)) then
      begin
        try
          Editor.MarkModified;
        finally
          Editor.Free;
        end;
      end;
    finally
      Module.Free;
    end;
  end;
end;

class function TIDENewManager.ShowFile(CompiledFile, UnitName, ProcName: AnsiString;
  Line, Offset: Integer; Compiled: TDateTime): Boolean;
var
  ModIntf: TIModuleInterface;
  Editor: TIEditorInterface;
  EView: TIEditView;
  CPos: TEditPos;
  Modified: TDateTime;
  NewLine: Integer;

  function FindFullPath(var FileName: AnsiString): Boolean;
  var
    i: Integer;
  begin
    Result := False;
    if UpperCase(ExtractFileName(FileName)) =
      UpperCase(ExtractFileName(GetCurrentModuleNameProc)) then
    begin
      FileName := GetCurrentModuleNameProc;
      Result := True;
    end
    else
      for i := 0 to ToolServices.GetUnitCount - 1 do
      begin
        if UpperCase(ExtractFileName(FileName)) =
          UpperCase(ExtractFileName(ToolServices.GetUnitName(i))) then
        begin
          FileName := ToolServices.GetUnitName(i);
          Result := True;
          Break;
        end;
      end;
  end;

begin
  Result := False;

  if ((not FindFullPath(UnitName)) and (not PathFromInternalFiles(UnitName))) then Exit;

  ModIntf := ToolServices.GetModuleInterface(UnitName);
  if ModIntf = nil then
  begin
    ToolServices.OpenFile(UnitName);
    ModIntf := ToolServices.GetModuleInterface(UnitName);
  end;
  if (ModIntf = nil) then
    raise Exception.CreateFmt('Cannot open "%s" file.', [UnitName]);
  try
    if (not ModIntf.ShowSource) then Exit;
    Editor := ModIntf.GetEditorInterface;
    try
      if Editor.GetViewCount = 0 then Exit;

      if (Offset >= 0) then
      begin
        Modified := GetGMTDateTime(GetModifiedDate(UnitName));
        if (Modified > Compiled) then
        begin
          if (CurrentPersonality.Getpersonality = ptDelphiWin32) then
            NewLine := FindProcStartLineDelphi(GetText(UnitName), ProcName)
          else
            NewLine := FindProcStartLineCppBuilder(GetText(UnitName), ProcName);
          if (NewLine > 0) then Line := (NewLine + Offset);
        end;
      end;

      Application.Restore;
      SetForegroundWindow(Application.Handle);

      CPos.Col := 1;
      CPos.Line := Line;
      EView := Editor.GetView(0);
      try
        EView.CursorPos := CPos;
        Dec(CPos.Line, EView.GetViewSize.cy div 2);
        if CPos.Line < 1 then CPos.Line := 1;
        EView.TopPos := CPos;
        Result := True;
      finally
        EView.Free;
      end;
    finally
      Editor.Free;
    end;
  finally
    ModIntf.Free;
  end;
end;

class procedure TIDENewManager.UnloadProjectsList;
var
  n: Integer;
begin
  for n := (ModuleOptions.Count - 1) downto 0 do
  begin
    IDEManager.RemoveNotifier(ModuleOptions[n].Name);
    ModuleOptions.Delete(n);
  end;
end;

//------------------------------------------------------------------------------

procedure InitMenu;
var
  MainMenu: TIMainMenuIntf;
  ToolsMenu, ConfigToolsItem: TIMenuItemIntf;
begin
  SepItem := nil;
  OptItem := nil;
  OptView := nil;
  OptTutorial := nil;
  OptAbout := nil;
  Sep2Item := nil;
  Opt2Item := nil;
{$IFDEF EUREKALOG_DEMO}
  BuySep := nil;
  BuyItem := nil;
{$ENDIF}
  MainMenu := ToolServices.GetMainMenu;
  if (MainMenu <> nil) then
  try
    ToolsMenu := MainMenu.FindMenuItem('ProjectMenu');
    if (ToolsMenu <> nil) then
    try
      ConfigToolsItem := MainMenu.FindMenuItem('ProjectOptionsItem');
      if (ConfigToolsItem <> nil) then
      try
        SepItem := ToolsMenu.InsertItem(ConfigToolsItem.GetIndex + 1, '-',
          'SeparatorItem', '', 0, 0, 0, [mfVisible, mfEnabled], nil);
        OptItem := ToolsMenu.InsertItem(ConfigToolsItem.GetIndex + 2,
          EOptions, 'ExceptionOptions', '', 0, 0, 0, [mfVisible, mfEnabled],
          TOnClickWrapper.OnOptionsClick);
        OptView := ToolsMenu.InsertItem(ConfigToolsItem.GetIndex + 3,
          EViewItem, 'ExceptionViewLog', '', 0, 0, 0, [mfVisible, mfEnabled],
          TOnClickWrapper.OnViewLogClick);
        OptTutorial := ToolsMenu.InsertItem(ConfigToolsItem.GetIndex + 4,
          ETutorialItem, 'ExceptionTutorial', '', 0, 0, 0, [mfVisible, mfEnabled],
          TOnClickWrapper.OnTutorialClick);
        OptAbout := ToolsMenu.InsertItem(ConfigToolsItem.GetIndex + 5,
          EAboutItem, 'ExceptionAbout', '', 0, 0, 0, [mfVisible, mfEnabled],
          TOnClickWrapper.OnAboutClick);
{$IFDEF EUREKALOG_DEMO}
        BuySep := ToolsMenu.InsertItem(ConfigToolsItem.GetIndex + 6, '-',
          'SeparatorItem2', '', 0, 0, 0, [mfVisible, mfEnabled], nil);
        BuyItem := ToolsMenu.InsertItem(ConfigToolsItem.GetIndex + 7,
          EBuyItem, 'ExceptionBuy', '', 0, 0, 0, [mfVisible, mfEnabled],
          TOnClickWrapper.OnBuyClick);
{$ENDIF}
      finally
        ConfigToolsItem.Free;
      end;
    finally
      ToolsMenu.Free;
    end;
  finally
    MainMenu.Free;
  end;
end;

procedure InitDelayedMenu;
var
  MainMenu: TIMainMenuIntf;
  ToolsMenu, ConfigToolsItem {$IFDEF Delphi4Up}, HelpMenu, HelpItem {$ENDIF} : TIMenuItemIntf;
begin
  MainMenu := ToolServices.GetMainMenu;
  if (MainMenu <> nil) then
  try
    ToolsMenu := MainMenu.FindMenuItem('ToolsMenu');
    if (ToolsMenu <> nil) then
    try
      ConfigToolsItem := MainMenu.FindMenuItem('ToolsToolsItem');
      if (ConfigToolsItem <> nil) then
      try
        Sep2Item := ToolsMenu.InsertItem(ConfigToolsItem.GetIndex + 1, '-',
          'Separator2Item', '', 0, 0, 0, [mfVisible, mfEnabled], nil);
        Opt2Item := ToolsMenu.InsertItem(ConfigToolsItem.GetIndex + 2,
          EOptions2, 'ExceptionIDEOptions', '', 0, 0, 0, [mfVisible, mfEnabled],
          TOnClickWrapper.OnIDEOptionsClick);
      finally
        ConfigToolsItem.Free;
      end;
    finally
      ToolsMenu.Free;
    end;

{$IFDEF Delphi4Up}
    HelpMenu := MainMenu.FindMenuItem('HelpMenu');
    if (HelpMenu <> nil) then
    try
      HelpItem := MainMenu.FindMenuItem('HelpAboutItem');
      if (HelpItem <> nil) then
      try
        Sep3Item := HelpMenu.InsertItem(HelpItem.GetIndex + 1, '-',
          'Separator3Item', '', 0, 0, 0, [mfVisible, mfEnabled], nil);
        Opt3Item := HelpMenu.InsertItem(HelpItem.GetIndex + 2,
          EOptions3, 'ExceptionHelpOptions', '', 0, 0, 0, [mfVisible, mfEnabled],
          TOnClickWrapper.OnHelpOptionsClick);
      finally
        HelpItem.Free;
      end;
    finally
      HelpMenu.Free;
    end;
{$ENDIF}
  finally
    MainMenu.Free;
  end;
end;

procedure DoneMenu;
begin
  if (SepItem <> nil) then
  begin
    SepItem.Free;
    SepItem := nil;
  end;
  if (OptItem <> nil) then
  begin
    OptItem.Free;
    OptItem := nil;
  end;
  if (OptView <> nil) then
  begin
    OptView.Free;
    OptView := nil;
  end;
  if (OptTutorial <> nil) then
  begin
    OptTutorial.Free;
    OptTutorial := nil;
  end;
  if (OptAbout <> nil) then
  begin
    OptAbout.Free;
    OptAbout := nil;
  end;
{$IFDEF EUREKALOG_DEMO}
  if (BuySep <> nil) then
  begin
    BuySep.Free;
    BuySep := nil;
  end;
  if (BuyItem <> nil) then
  begin
    BuyItem.Free;
    BuyItem := nil;
  end;
{$ENDIF}
  if (Sep2Item <> nil) then
  begin
    Sep2Item.Free;
    Sep2Item := nil;
  end;
  if (Opt2Item <> nil) then
  begin
    Opt2Item.Free;
    Opt2Item := nil;
  end;
  if (Sep3Item <> nil) then
  begin
    Sep3Item.Free;
    Sep3Item := nil;
  end;
  if (Opt3Item <> nil) then
  begin
    Opt3Item.Free;
    Opt3Item := nil;
  end;
end;

procedure InitNotifier;
begin
  if (not Assigned(ToolServices)) then Exit;

  AddIn := TNewAddIn.Create;
  ToolServices.AddNotifierEx(AddIn);
end;

procedure DoneNotifier;
begin
  if (Assigned(ToolServices)) and (Assigned(AddIn)) then ToolServices.RemoveNotifier(AddIn);
  if (Assigned(AddIn)) then
  begin
    AddIn.Free;
    AddIn := nil;
  end;
end;

//------------------------------------------------------------------------------

procedure Init;
begin
  IDEManager := TIDENewManager;
end;

procedure Done;
begin
end;

//------------------------------------------------------------------------------

initialization
  SafeExec(Init, 'EToolServices.Init');

finalization
  SafeExec(Done, 'EToolServices.Done');

end.
