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

unit PropertyInspEditors;

interface

uses Classes, Graphics, PropertyList, Dialogs;

type
  TPropertyEditor = class
  private
    FProp: TProperty;
  public
    constructor Create(AProp: TProperty); virtual;
    function Execute: Boolean; virtual; abstract;
    property Prop: TProperty read FProp;
  end;

  TPropertyEditorClass = class of TPropertyEditor;

  TFontPropertyEditor = class(TPropertyEditor)
  public
    function Execute: Boolean; override;
  end;

  TColorPropertyEditor = class(TPropertyEditor)
  public
    function Execute: Boolean; override;
  end;

implementation

constructor TPropertyEditor.Create(AProp: TProperty);
begin
  inherited Create;
  FProp:=AProp;
end;

function TFontPropertyEditor.Execute: Boolean;
begin
  with TFontDialog.Create(nil) do
  try
    Font.Assign(TFont(Prop.AsObject));
    Result:=Execute;
    if Result then TFont(Prop.AsObject).Assign(Font);
  finally
    Free;
  end;
end;

function TColorPropertyEditor.Execute: Boolean;
begin
  with TColorDialog.Create(nil) do
  try
    Color:=Prop.AsInteger;
    Result:=Execute;
    if Result then Prop.AsInteger:=Color;
  finally
    Free;
  end;
end;

end.
