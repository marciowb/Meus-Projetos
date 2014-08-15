{***********************************************************************}
{ TMS Security framework                                                }
{ for Delphi & C++Builder                                               }
{                                                                       }
{ written by                                                            }
{   TMS Software                                                        }
{   Copyright © 2003 - 2008                                             }
{   Email : info@tmssoftware.com                                        }
{   Web : http://www.tmssoftware.com                                    }
{***********************************************************************}
unit uAboutUILSecurity;

interface

{$I TMSDEFS.INC}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ShellApi,
  {$IFDEF DELPHI6_LVL}
  DesignIntf,
  DesignEditors,
  {$ELSE}
  DsgnIntf,
  {$ENDIF} 
  usmGlobals;

type
  TfrmAboutUilUtilities = class(TForm)
    btnOK: TButton;
    labTitle: TLabel;
    Bevel1: TBevel;
    Label4: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Image1: TImage;
    procedure FormCreate(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure Label5Click(Sender: TObject);
    procedure Label7Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

type
   TVersionEditor = class(TPropertyEditor)
      function AllEqual : boolean; override;
      procedure Edit; override;
      function GetAttributes : TPropertyAttributes; override;
      function GetValue : string; override;
      procedure SetValue(const Value : string); override;
   end;

implementation

function TVersionEditor.AllEqual : boolean;
{ Called whenever more than one component is selected. If this method returns true, GetValue is called; otherwise nothing is displayed in the Object Inspector. Only called when GetAttributes returns paMultiSelect. }
var
   componentIndex : integer;
   currentValue : String;
begin
   { To call the inherited implementation, use "result := inherited AllEqual;" }
   { CDK: Place your overriding code here. Example code follows: }
   result := false;
   if (PropCount > 1) then
   begin
      { CDK: Confirm the following assignment is appropriate for your property editor: }
      currentValue := GetStrValue;
      for componentIndex := 1 to PropCount - 1 do
      begin
         { CDK: Confirm the following comparison is appropriate for your property editor: }
         if (GetStrValueAt(componentIndex) <> currentValue) then
            exit;
      end;
   end;
   result := true;
end;  { AllEqual }

procedure TVersionEditor.Edit;
{ Called when the '...' button is pressed or the property is double-clicked. }
begin
   { To call the inherited implementation, use "inherited Edit;" }
   { CDK: Place your overriding code here. }
   with TfrmAboutUilUtilities.Create(nil) do
   begin
      try
         ShowModal;
      finally
         Free;  { Free dialog. }
      end;
   end;
end;  { Edit }

function TVersionEditor.GetAttributes : TPropertyAttributes;
{ Returns information used by the Object Inspector to show the approprate adornments (e.g., "..." button, drop-down button). }
begin
   result := [paMultiSelect, paDialog, paRevertable];
end;  { GetAttributes }

function TVersionEditor.GetValue : string;
{ Returns a string representation for the property's current value, so that the Object Inspector can display it. The default is "unknown". }
begin
   { CDK: Replace following call to inherited GetValue with your own string representation of the current value of the property being edited. }
   result := VersionString;
end;  { GetValue }

procedure TVersionEditor.SetValue(const Value : string);
{ Called to set the value of the property.  }
begin
   { CDK: If Value is not in the correct format or is an illegal value, you should raise an exception describing the problem. Example: }
   { if ((Value is illegal)) then }
   {    raise EPropertyError.CreateFmt('Invalid value for property %s.', [GetName]); }
   { CDK: Confirm that following code converts Value appropriately, or optionally you can ignore all changes and force users to edit the property via an Edit method override. }
//   SetStrValue(Value);
end;  { SetValue }


{$R *.DFM}

procedure TfrmAboutUilUtilities.FormCreate(Sender: TObject);
begin
   labTitle.Caption := LabTitle.Caption + VersionString;
end;

procedure TfrmAboutUilUtilities.Label1Click(Sender: TObject);
begin
  shellexecute(0,'open','http://www.tmssoftware.com',nil,nil,SW_NORMAL);
end;

procedure TfrmAboutUilUtilities.Label5Click(Sender: TObject);
begin
  shellexecute(0,'open','mailto:help@tmssoftware.com',nil,nil,SW_NORMAL);
end;

procedure TfrmAboutUilUtilities.Label7Click(Sender: TObject);
begin
  shellexecute(0,'open','mailto:info@tmssoftware.com',nil,nil,SW_NORMAL);
end;

end.
