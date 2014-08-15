{***************************************************************************}
{ Scripter Studio Pro Components for Delphi & C++Builder                    }
{ version 1.6.0.1                                                           }
{                                                                           }
{ written by TMS Software                                                   }
{            copyright © 1997 - 2010                                        }
{            Email : info@tmssoftware.com                                   }
{            Web : http://www.tmssoftware.com                               }
{                                                                           }
{ For information about version history, check the section "What's New"     }
{ at Scripter Studio manual.                                                }                                                                         
{                                                                           }
{ The source code is given as is. The author is not responsible             }
{ for any possible damage done due to the use of this code.                 }
{ The component can be freely used in any application. The complete         }
{ source code remains property of the author and may not be distributed,    }
{ published, given or sold in any form as such. No parts of the source      }
{ code can be included in any other component or application without        }
{ written authorization of the author.                                      }
{***************************************************************************}

unit FormScript;

interface

{$I AScript.Inc}

uses
  atScript, Forms, Windows, Classes, SysUtils, Controls, Graphics, Dialogs,
  atPascal, atBasic
  {$IFDEF ISDELPHI}
    {$IFDEF DELPHI5_LVL}
    , ap_Classes
    {$ENDIF}
  {$ENDIF}
  ;

type
  /// Summary:
  ///   A TatPascalScripter descendant that automatically register all components in the form
  /// Description:
  ///   TatPascalFormScripter is a TatPascalScripter descendant with a single difference: it automatically
  ///   registers all components belonging to the form it is owned, so they can be accessed from script.
  ///   This component is deprecated because the new multi-language TatScripter component should be used
  ///   instead of specific language scripters. Components in form can be easily registered using
  ///   TatCustomScripter.AddComponents method
  /// See Also:
  ///   TatScripter; TatCustomScripter.AddComponents
  TatPascalFormScripter = class(TatPascalScripter)
  private
    FScriptFile: string;
    FAdded: TList;
  protected
    procedure GetControlCount(AMachine: TatVirtualMachine);
    procedure GetControls(AMachine: TatVirtualMachine);
    procedure Prepare;
    procedure AddChildControls(Control: TWinControl);
    procedure AddComponents(AOwner: TComponent);
    procedure SetBold(AMachine: TatVirtualMachine);
    procedure SetItalic;
    procedure SetUnderline;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Loaded; override;
    procedure BeforeCompile; override;
    procedure BeforeLoadCode; override;
    
    /// Summary:
    ///   Register some methods and constants in scripter, like TWinControl.ControlCount, and clMenu, clBtnFace, etc.
    ///   It is called automatically when the scripter is loaded from the form, you have the option to call this method
    ///   in case you create the scripter from code
    procedure RegisterConstants;
  published
 
    /// Summary:
    ///   Specifies a file name where the script source code should be automatically loaded from, when the form is created.
    property ScriptFile: string read FScriptFile write FScriptFile;
  end;

  /// Summary:
  ///   A TatBasicScripter descendant that automatically register all components in the form
  /// Description:
  ///   TatBasicFormScripter is a TatBasicScripter descendant with a single difference: it automatically
  ///   registers all components belonging to the form it is owned, so they can be accessed from script.
  ///   This component is deprecated because the new multi-language TatScripter component should be used
  ///   instead of specific language scripters. Components in form can be easily registered using
  ///   TatCustomScripter.AddComponents method
  /// See Also:
  ///   TatScripter; TatCustomScripter.AddComponents
  TatBasicFormScripter = class(TatBasicScripter)
  private
    FScriptFile: string;
    FAdded: TList;
  protected
    procedure GetControlCount(AMachine: TatVirtualMachine);
    procedure GetControls(AMachine: TatVirtualMachine);
    procedure Prepare;
    procedure AddChildControls(Control: TWinControl);
    procedure AddComponents(AOwner: TComponent);
    procedure SetBold(AMachine: TatVirtualMachine);
    procedure SetItalic;
    procedure SetUnderline;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Loaded; override;
    procedure BeforeCompile; override;
    procedure BeforeLoadCode; override;

    /// Summary:
    ///   Register some methods and constants in scripter, like TWinControl.ControlCount, and clMenu, clBtnFace, etc.
    ///   It is called automatically when the scripter is loaded from the form, you have the option to call this method
    ///   in case you create the scripter from code
    procedure RegisterConstants;
  published

    /// Summary:
    ///   Specifies a file name where the script source code should be automatically loaded from, when the form is created.
    property ScriptFile: string read FScriptFile write FScriptFile;
  end;


implementation

{ TatPascalFormScripter }

constructor TatPascalFormScripter.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FAdded := TList.Create;
  if not (Owner is TForm) then
    raise Exception.Create('Control parent must be a form!');
end;

procedure TatPascalFormScripter.Loaded;
begin
  inherited;
  RegisterConstants;
end;

procedure TatPascalFormScripter.RegisterConstants;
begin
  with DefineClass(TWinControl) do
  begin
    DefineMethod('ControlCount',0,tkInteger,nil,GetControlCount);
    DefineMethod('Controls',1,tkClass,TControl,GetControls);
  end;

  with DefineClass(TFont) do
  begin
    DefineMethod('SetBold',1,tkNone,nil,SetBold);
    DefineMethod('SetItalic',1,tkNone,nil,SetBold);
    DefineMethod('SetUnderline',1,tkNone,nil,SetBold);
  end;

  {$IFDEF ISDELPHI}
    {$IFDEF DELPHI5_LVL}
  AddLibrary(TatClassesLibrary);
    {$ENDIF}
  {$ENDIF}

  SystemLibrary.AddObject('Form', Owner);
  SystemLibrary.AddConstant('clScrollBar',clScrollBar);
  SystemLibrary.AddConstant('clBackground',clBackground);
  SystemLibrary.AddConstant('clActiveCaption',clActiveCaption);
  SystemLibrary.AddConstant('clInactiveCaption',clInactiveCaption);
  SystemLibrary.AddConstant('clMenu',clMenu);
  SystemLibrary.AddConstant('clWindow',clWindow);
  SystemLibrary.AddConstant('clWindowFrame',clWindowFrame);
  SystemLibrary.AddConstant('clMenuText',clMenuText);
  SystemLibrary.AddConstant('clWindowText',clWindowText);
  SystemLibrary.AddConstant('clCaptionText',clCaptionText);
  SystemLibrary.AddConstant('clActiveBorder',clActiveBorder);
  SystemLibrary.AddConstant('clInactiveBorder',clInactiveBorder);
  SystemLibrary.AddConstant('clAppWorkSpace',clAppWorkSpace);
  SystemLibrary.AddConstant('clHighlight',clHighlight);
  SystemLibrary.AddConstant('clHighlightText',clHighlightText);
  SystemLibrary.AddConstant('clBtnFace',clBtnFace);
  SystemLibrary.AddConstant('clBtnShadow',clBtnShadow);
  SystemLibrary.AddConstant('clGrayText',clGrayText);
  SystemLibrary.AddConstant('clBtnText',clBtnText);
  SystemLibrary.AddConstant('clInactiveCaptionText',clInactiveCaptionText);
  SystemLibrary.AddConstant('clBtnHighlight',clBtnHighlight);
  SystemLibrary.AddConstant('cl3DDkShadow',cl3DDkShadow);
  SystemLibrary.AddConstant('cl3DLight',cl3DLight);
  SystemLibrary.AddConstant('clInfoText',clInfoText);
  SystemLibrary.AddConstant('clInfoBk',clInfoBk);

  SystemLibrary.AddConstant('clBlack',clBlack);
  SystemLibrary.AddConstant('clMaroon',clMaroon);
  SystemLibrary.AddConstant('clGreen',clGreen);
  SystemLibrary.AddConstant('clOlive',clOlive);
  SystemLibrary.AddConstant('clNavy',clNavy);
  SystemLibrary.AddConstant('clPurple',clPurple);
  SystemLibrary.AddConstant('clTeal',clTeal);
  SystemLibrary.AddConstant('clGray',clGray);
  SystemLibrary.AddConstant('clSilver',clSilver);
  SystemLibrary.AddConstant('clRed',clRed);
  SystemLibrary.AddConstant('clLime',clLime);
  SystemLibrary.AddConstant('clYellow',clYellow);
  SystemLibrary.AddConstant('clBlue',clBlue);
  SystemLibrary.AddConstant('clFuchsia',clFuchsia);
  SystemLibrary.AddConstant('clAqua',clAqua);
  SystemLibrary.AddConstant('clLtGray',clLtGray);
  SystemLibrary.AddConstant('clDkGray',clDkGray);
  SystemLibrary.AddConstant('clWhite',clWhite);
  SystemLibrary.AddConstant('clNone',clNone);
  SystemLibrary.AddConstant('clDefault',clDefault);

  if FScriptFile <> '' then
    if FileExists(FScriptFile) then
      SourceCode.LoadFromFile(FScriptFile);
end;

procedure TatPascalFormScripter.GetControlCount;
begin
  with TForm(CurrentObject) do
  begin
    ReturnOutputArg(ControlCount);
  end;
end;

procedure TatPascalFormScripter.GetControls;
begin
  with TForm(CurrentObject) do
  begin
    {$WARNINGS OFF}
    ReturnOutputArg(Integer(Controls[GetInputArgAsInteger(0)]));
    {$WARNINGS ON}
  end;
end;


procedure TatPascalFormScripter.AddChildControls(Control: TWinControl);
var
  i: Integer;
begin
  for i := 0 to Control.ControlCount - 1 do
  begin
    if FAdded.IndexOf(Control.Controls[i]) = -1 then
    begin
      SystemLibrary.AddObject(Control.Controls[i].Name,Control.Controls[i]);
      FAdded.Add(Control.Controls[i]);
    end;

    if Control.Controls[i] is TWinControl then
    if (Control.Controls[i] as TWinControl).ControlCount > 0 then
    begin
      AddChildControls(TWinControl(Control.Controls[i]));
    end;
  end;
end;

procedure TatPascalFormScripter.Prepare;
begin
  if Assigned(Owner) then
  begin
    if Owner is TWinControl then
      AddChildControls(TWinControl(Owner));
    AddComponents(Owner);
  end;
end;

procedure TatPascalFormScripter.BeforeCompile;
begin
  Prepare;
end;

procedure TatPascalFormScripter.BeforeLoadCode;
begin
  Prepare;
end;

procedure TatPascalFormScripter.SetBold;
begin
  if GetInputArgAsBoolean(0) then
    TFont(CurrentObject).Style := TFont(CurrentObject).Style + [fsBold]
  else
    TFont(CurrentObject).Style := TFont(CurrentObject).Style - [fsBold];
end;

procedure TatPascalFormScripter.SetItalic;
begin
  if GetInputArgAsBoolean(0) then
    TFont(CurrentObject).Style := TFont(CurrentObject).Style + [fsItalic]
  else
    TFont(CurrentObject).Style := TFont(CurrentObject).Style - [fsItalic];
end;

procedure TatPascalFormScripter.SetUnderline;
begin
  if GetInputArgAsBoolean(0) then
    TFont(CurrentObject).Style := TFont(CurrentObject).Style + [fsUnderline]
  else
    TFont(CurrentObject).Style := TFont(CurrentObject).Style - [fsUnderline];
end;


destructor TatPascalFormScripter.Destroy;
begin
  FAdded.Free;
  inherited;
end;

procedure TatPascalFormScripter.AddComponents(AOwner: TComponent);
var
  i: Integer;
begin
  for i := 0 to AOwner.ComponentCount - 1 do
  begin
    if FAdded.IndexOf(AOwner.Components[i]) = -1 then
    begin
      SystemLibrary.AddObject(AOwner.Components[i].Name, AOwner.Components[i]);
      FAdded.Add(AOwner.Components[i]);
    end;
  end;
end;

{ TatBasicFormScripter }

constructor TatBasicFormScripter.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FAdded := TList.Create;
  if not (Owner is TForm) then
    raise Exception.Create('Control parent must be a form!');
end;

procedure TatBasicFormScripter.Loaded;
begin
  inherited;
  RegisterConstants;
end;

procedure TatBasicFormScripter.RegisterConstants;
begin
  with DefineClass(TWinControl) do
  begin
    DefineMethod('ControlCount',0,tkInteger,nil,GetControlCount);
    DefineMethod('Controls',1,tkClass,TControl,GetControls);
  end;

  with AddDelphiClass(TFont) do
  begin
    DefineMethod('SetBold',1,tkNone,nil,SetBold);
    DefineMethod('SetItalic',1,tkNone,nil,SetBold);
    DefineMethod('SetUnderline',1,tkNone,nil,SetBold);
  end;

  {$IFDEF ISDELPHI}
    {$IFDEF DELPHI5_LVL}
  AddLibrary(TatClassesLibrary);
    {$ENDIF}
  {$ENDIF}

  SystemLibrary.AddObject('Form', Owner);
  SystemLibrary.AddConstant('clScrollBar',clScrollBar);
  SystemLibrary.AddConstant('clBackground',clBackground);
  SystemLibrary.AddConstant('clActiveCaption',clActiveCaption);
  SystemLibrary.AddConstant('clInactiveCaption',clInactiveCaption);
  SystemLibrary.AddConstant('clMenu',clMenu);
  SystemLibrary.AddConstant('clWindow',clWindow);
  SystemLibrary.AddConstant('clWindowFrame',clWindowFrame);
  SystemLibrary.AddConstant('clMenuText',clMenuText);
  SystemLibrary.AddConstant('clWindowText',clWindowText);
  SystemLibrary.AddConstant('clCaptionText',clCaptionText);
  SystemLibrary.AddConstant('clActiveBorder',clActiveBorder);
  SystemLibrary.AddConstant('clInactiveBorder',clInactiveBorder);
  SystemLibrary.AddConstant('clAppWorkSpace',clAppWorkSpace);
  SystemLibrary.AddConstant('clHighlight',clHighlight);
  SystemLibrary.AddConstant('clHighlightText',clHighlightText);
  SystemLibrary.AddConstant('clBtnFace',clBtnFace);
  SystemLibrary.AddConstant('clBtnShadow',clBtnShadow);
  SystemLibrary.AddConstant('clGrayText',clGrayText);
  SystemLibrary.AddConstant('clBtnText',clBtnText);
  SystemLibrary.AddConstant('clInactiveCaptionText',clInactiveCaptionText);
  SystemLibrary.AddConstant('clBtnHighlight',clBtnHighlight);
  SystemLibrary.AddConstant('cl3DDkShadow',cl3DDkShadow);
  SystemLibrary.AddConstant('cl3DLight',cl3DLight);
  SystemLibrary.AddConstant('clInfoText',clInfoText);
  SystemLibrary.AddConstant('clInfoBk',clInfoBk);

  SystemLibrary.AddConstant('clBlack',clBlack);
  SystemLibrary.AddConstant('clMaroon',clMaroon);
  SystemLibrary.AddConstant('clGreen',clGreen);
  SystemLibrary.AddConstant('clOlive',clOlive);
  SystemLibrary.AddConstant('clNavy',clNavy);
  SystemLibrary.AddConstant('clPurple',clPurple);
  SystemLibrary.AddConstant('clTeal',clTeal);
  SystemLibrary.AddConstant('clGray',clGray);
  SystemLibrary.AddConstant('clSilver',clSilver);
  SystemLibrary.AddConstant('clRed',clRed);
  SystemLibrary.AddConstant('clLime',clLime);
  SystemLibrary.AddConstant('clYellow',clYellow);
  SystemLibrary.AddConstant('clBlue',clBlue);
  SystemLibrary.AddConstant('clFuchsia',clFuchsia);
  SystemLibrary.AddConstant('clAqua',clAqua);
  SystemLibrary.AddConstant('clLtGray',clLtGray);
  SystemLibrary.AddConstant('clDkGray',clDkGray);
  SystemLibrary.AddConstant('clWhite',clWhite);
  SystemLibrary.AddConstant('clNone',clNone);
  SystemLibrary.AddConstant('clDefault',clDefault);

  if FScriptFile <> '' then
    if FileExists(FScriptFile) then
      SourceCode.LoadFromFile(FScriptFile);
end;

procedure TatBasicFormScripter.GetControlCount;
begin
  with TForm(CurrentObject) do
  begin
    ReturnOutputArg(ControlCount);
  end;
end;

procedure TatBasicFormScripter.GetControls;
begin
  with TForm(CurrentObject) do
  begin
    {$WARNINGS OFF}
    ReturnOutputArg(Integer(Controls[GetInputArgAsInteger(0)]));
    {$WARNINGS ON}
  end;
end;


procedure TatBasicFormScripter.AddChildControls(Control: TWinControl);
var
  i: Integer;
begin
  for i := 0 to Control.ControlCount - 1 do
  begin
    if FAdded.IndexOf(Control.Controls[i]) = -1 then
    begin
      SystemLibrary.AddObject(Control.Controls[i].Name,Control.Controls[i]);
      FAdded.Add(Control.Controls[i]);
    end;

    if Control.Controls[i] is TWinControl then
    if (Control.Controls[i] as TWinControl).ControlCount > 0 then
    begin
      AddChildControls(TWinControl(Control.Controls[i]));
    end;
  end;
end;

procedure TatBasicFormScripter.Prepare;
begin
  if Assigned(Owner) then
  begin
    if Owner is TWinControl then
      AddChildControls(TWinControl(Owner));
    AddComponents(Owner);
  end;
end;

procedure TatBasicFormScripter.BeforeCompile;
begin
  Prepare;
end;

procedure TatBasicFormScripter.BeforeLoadCode;
begin
  Prepare;
end;

procedure TatBasicFormScripter.SetBold;
begin
  if GetInputArgAsBoolean(0) then
    TFont(CurrentObject).Style := TFont(CurrentObject).Style + [fsBold]
  else
    TFont(CurrentObject).Style := TFont(CurrentObject).Style - [fsBold];
end;

procedure TatBasicFormScripter.SetItalic;
begin
  if GetInputArgAsBoolean(0) then
    TFont(CurrentObject).Style := TFont(CurrentObject).Style + [fsItalic]
  else
    TFont(CurrentObject).Style := TFont(CurrentObject).Style - [fsItalic];
end;

procedure TatBasicFormScripter.SetUnderline;
begin
  if GetInputArgAsBoolean(0) then
    TFont(CurrentObject).Style := TFont(CurrentObject).Style + [fsUnderline]
  else
    TFont(CurrentObject).Style := TFont(CurrentObject).Style - [fsUnderline];
end;



destructor TatBasicFormScripter.Destroy;
begin
  FAdded.Free;
  inherited;
end;

procedure TatBasicFormScripter.AddComponents(AOwner: TComponent);
var
  i: Integer;
begin
  for i := 0 to AOwner.ComponentCount - 1 do
  begin
    if FAdded.IndexOf(AOwner.Components[i]) = -1 then
    begin
      SystemLibrary.AddObject(AOwner.Components[i].Name, AOwner.Components[i]);
      FAdded.Add(AOwner.Components[i]);
    end;
  end;
end;

end.
