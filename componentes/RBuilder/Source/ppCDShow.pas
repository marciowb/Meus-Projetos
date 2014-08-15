{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit ppCDShow;

interface

{$I ppIfDef.pas}

{.$Define CodeSite}

uses
  {$IFDEF CodeSite} csIntf, {$ENDIF}
  {$IFDEF Delphi6} DesignIntf, {$ELSE} DsgnIntf, {$ENDIF}
  Classes, ppDsIntf;

{$IFDEF Delphi6}
procedure ppShowComponentDesigner(aDesigner: IDesigner; aComponent: TComponent);
{$ELSE}
procedure ppShowComponentDesigner(aDesigner: IFormDesigner; aComponent: TComponent);
{$ENDIF}

implementation

uses
  Dialogs, Forms,
  ppDsgWin, ppComm, ppTypes, ppForms, ppUtils;

{------------------------------------------------------------------------------}
{ ppShowComponentDesigner }

{$IFDEF Delphi6}
procedure ppShowComponentDesigner(aDesigner: IDesigner; aComponent: TComponent);
{$ELSE}
procedure ppShowComponentDesigner(aDesigner: IFormDesigner; aComponent: TComponent);
{$ENDIF}
const
{$IFDEF CBuilder}
  cProduct = 'C++ Builder';
{$ELSE}
  cProduct = 'Delphi';
{$ENDIF}

var
  lCommunicator: TppCommunicator;
  lDesignWindow: TppDesignWindow;
  lComponentDesignerClass: TppComponentDesignerClass;
  lComponentDesigner: TppComponentDesigner;
  lsMsg: String;
  lFormClass: TFormClass;
  lDemoBox: TppCustomDemoDialog;
begin

  if (aComponent = nil) then Exit;

  if not(aComponent is TppCommunicator) then Exit;

  lCommunicator := TppCommunicator(aComponent);

  if (lCommunicator.ComponentDesigner <> nil) then
    begin
      lComponentDesigner := lCommunicator.ComponentDesigner;
      lComponentDesigner.FormDesigner.SetDesigner(aDesigner);

      if not lComponentDesigner.ValidSettings then
        begin
          MessageDlg(lComponentDesigner.ErrorMessage, mtError, [mbOK], 0);
          lComponentDesigner.Free;
        end
      else
        begin
          lCommunicator.ComponentDesigner.Show;

          if lCommunicator.ComponentDesigner.WindowState = wsMinimized then
            lCommunicator.ComponentDesigner.WindowState := wsNormal;
        end;
        
    end

  else

    begin

{$IFNDEF Delphi6}
{$IFDEF Delphi5}
      if (aComponent.ClassName = 'TppReport') and (aComponent.Owner is TDataModule) then
        begin
          lsMsg := 'There are known issues with using the Report Designer at ' + cProduct + ' design-time ' +
                   'for reports residing on a TDataModule. You may experience instability and slow performance.';
          MessageDlg(lsMsg, mtWarning, [mbOK], 0);

        end;
{$ENDIF}
{$ENDIF}

      lComponentDesignerClass := ppGetComponentDesignerClass(aComponent);

      if (lComponentDesignerClass = nil) then
        begin
          if (aComponent.ClassName = 'TppDataDictionary') then
            lsMsg := 'Data Dictionary Builder cannot be loaded because ' +
                      'DADE is not installed.'
          else
            lsMsg := 'No editor registered for this component';

          MessageDlg(lsMsg, mtError, [mbOK], 0);

          Exit;

        end;

{$IFDEF CodeSite}
  CodeSite.SendString('ppShowComponentDesigner',  'TppDesignWindow.Create(Application)');
{$ENDIF}

      {create window which communicates with Object Inspector}
      lDesignWindow := TppDesignWindow.Create(Application);

{$IFDEF CodeSite}
  CodeSite.SendString('ppShowComponentDesigner',  'lComponentDesigner := CreateDesignTimeDesigner');
{$ENDIF}

     {create component designer with design window as owner}
      lComponentDesigner := lComponentDesignerClass.CreateDesignTimeDesigner(lDesignWindow, aDesigner);

{$IFDEF CodeSite}
  CodeSite.SendString('ppShowComponentDesigner',  'lDesignWindow.RBComponentDesigner := lComponentDesigner');
{$ENDIF}

      {assign component designer to design window}
      lDesignWindow.RBComponentDesigner := lComponentDesigner;

{$IFDEF CodeSite}
  CodeSite.SendString('ppShowComponentDesigner',  'lDesignWindow.Designer := aDesigner');
{$ENDIF}

      {assign form designer to design window}
      lDesignWindow.Designer := aDesigner;

{$IFDEF CodeSite}
  CodeSite.SendString('ppShowComponentDesigner',  'lCommunicator.ComponentDesigner := lComponentDesigner');
{$ENDIF}

      {assign component designer to component}
      lCommunicator.ComponentDesigner := lComponentDesigner;

{$IFDEF CodeSite}
  CodeSite.SendString('ppShowComponentDesigner',  'lDesignWindow.Form := TForm(aComponent.Owner)');
{$ENDIF}

      {assign form to design window}
      if (aComponent.Owner <> nil) and (aComponent.Owner is TForm) then
        lDesignWindow.Form := TForm(aComponent.Owner);

{$IFDEF CodeSite}
  CodeSite.SendString('ppShowComponentDesigner',  'lComponentDesigner.Component := aComponent');
{$ENDIF}

      {assign component to component designer}
      lComponentDesigner.Component := aComponent;

      if not lComponentDesigner.ValidSettings then
        begin
          MessageDlg(lComponentDesigner.ErrorMessage, mtError, [mbOK], 0);
          lComponentDesigner.Free;
        end
      else
        begin
{$IFDEF CodeSite}
  CodeSite.SendString('ppShowComponentDesigner',  'lComponentDesigner.Show');
{$ENDIF}

          {display component designer }
          lComponentDesigner.Show;

          if not(ppValidDate) then
            begin
              lFormClass := ppGetFormClass(TppCustomDemoDialog);
              lDemoBox := TppCustomDemoDialog(lFormClass.Create(Application));
              lDemoBox.ShowModal;

              lDemoBox.Release;
            end;

        end;
        
   end;

end; {procedure, ppShowComponentDesigner}



end.
