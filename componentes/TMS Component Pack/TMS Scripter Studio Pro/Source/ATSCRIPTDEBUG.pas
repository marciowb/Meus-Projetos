{***************************************************************************}
{ Scripter Studio Components for Delphi & C++Builder                        }
{ version 4.7 (Std), 1.7 (Pro)                                              }
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

unit atScriptDebug;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  atScriptDebugForm, atScript, atPascal, atBasic;


type
  /// Summary:
  ///   Used to display a script debugger modal dialog.
  /// Description:
  ///   TatScripterDebugger encapsulates a dialog for script debugging. You can use this component to quickly
  ///   associate a scripter to it and call Execute method to open a debug window and perform debug operations in the script.
  ///   In the Pro version of Scripter Studio, this component is deprecated, since all debug operations can be performed
  ///   in the Scripter Studio IDE
  TatScriptDebugger = class(TComponent)
  private
    FScripter: TatCustomScripter;
    FUpdateSourceCode: boolean;
    FRoutineName: string;
    FMemoReadOnly: boolean;
  protected
    procedure Notification(AComponent: TComponent; AOperation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    
    /// Summary:
    ///   Opens the debug dialog window for debugging purposes.
    /// Description:
    ///   Execute method opens the dialog window for debugging. The source code is retrieved from the scripter component
    ///   indicated in Scripter property. The dialog is displayed in modal form. 
    /// See Also:
    ///   UpdateSourceCode; Scripter
    procedure Execute;
  published
    /// Summary:
    ///   Points to the scripter component containing the source code to be debugged.
    property Scripter: TatCustomScripter read FScripter write FScripter;
    
    /// Summary:
    ///   Indicates the name of the routine to be debugged in debugger. If RoutineName is empty (default), the main block
    ///   of the script will be debugged
    property RoutineName: string read FRoutineName write FRoutineName;
    
    /// Summary:
    ///   If UpdateSourceCode is true, changes to the source code made by the end-user will be applied to the script source code.
    ///   If this property is false (default), then any changes to source code made in debug window will be discarded.
    property UpdateSourceCode: boolean read FUpdateSourceCode write FUpdateSourceCode;
    
    /// Summary:
    ///   Indicates if the memo editor in debug window will be read-only or not.
    property MemoReadOnly: boolean read FMemoReadOnly write FMemoReadOnly;
  end;

implementation

{ TScriptDebugger }

constructor TatScriptDebugger.Create(AOwner: TComponent);
begin
  inherited;
  FUpdateSourceCode := true;
  FRoutineName := '';
  FMemoReadOnly := false;
end;

procedure TatScriptDebugger.Execute;
var
  ADebugForm: TDebugForm;
begin
  if not Assigned(Scripter) then
    raise Exception.Create('No scripter engine assigned');

  ADebugForm := TDebugForm.Create(Application);
  ADebugForm.Position := poScreenCenter;
  ADebugForm.RoutineToRun := FRoutineName;
  ADebugForm.AdvMemo1.ReadOnly := FMemoReadOnly;
  ADebugForm.Scripter := Scripter;
  if not Scripter.Running then
  begin
    ADebugForm.ShowModal;
    if FUpdateSourceCode then
      Scripter.SourceCode.Assign(ADebugForm.AdvMemo1.Lines);
  end else
  begin
    ADebugForm.Show;
    Scripter.Paused := true;
  end;
end;

procedure TatScriptDebugger.Notification(AComponent: TComponent;
  AOperation: TOperation);
begin
  inherited;
  if (AOperation = opRemove) and (AComponent = Scripter) then
    Scripter := nil;
end;

end.
