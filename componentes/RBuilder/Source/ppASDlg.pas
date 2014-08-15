{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2008                    BBBBB   }

unit ppASDlg;

interface

{$I ppIfDef.pas}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls,
  ppComm, ppForms, ppTypes, ppUtils, ppASField, ppASCtrl;

type

  {@TppAutoSearchDialog

    The AutoSearchDialog implementation may look imposing, but it is actually
    quite simple, consisting primarily of a TScrollBox which is dynamically
    filled with TPanel components.  The AutoSearchNotebook contains the
    ScrollBox and each Panel is contained in an AutoSearchPanel component.
    When the dialog is first displayed, the AutoSearchPanel component creates
    the necessary visual controls for a single AutoSearchField and transfers
    the property values of the field to the visual controls .  When the dialog
    is closed, the search criteria entered by the user is validated and then
    transferred from the visual controls back to the AutoSearchField.  When
    you are using the data workspace, all of this happens automatically when
    you create search criteria in the Query Designer and select the AutoSearch
    feature.  If you are using the standard version of ReportBuilder, or wish
    to manually assign the value of search criteria created in ReportBuilder
    Professonal or Enterprise, then see the AutoSearchFields topic for a
    discussion of the different ways you can use AutoSearchFields.

    Before the AutoSearchDialog is instantiated by the Report component, the
    OnAutoSearchDialogCreate event fires, giving you the opportunity to create
    the appropriate AutoSearchField components.  After this event has fired,
    the AutoSearchDialog creates the AutoSearchNotebook, and calls the Init
    method, which creates an AutoSearchPanel for each field. The
    AutoSearchPanel creates a set of visual controls which corresponding with
    a single AutoSearchField.  Once this process is complete, the dialog is
    displayed, allowing the user to enter search criteria.  When the user
    clicks the OK button, the Valid method of each AutoSearchPanel is called.
    Any panel which does not contain valid search criteria displays an error
    message and returns False from the Valid method, which prevents the dialog
    from closing. Panels which contain a valid search criteria value transfer
    this value to the corresponding AutoSearchField when Valid is called.  If
    all panels return True from the Valid method, then the dialog can be
    closed, at which point the OnAutoSearchDialogClose event fires, giving you
    the chance to retrieve the search criteria values saved in the
    AutoSearchFields.

    A diagram of the various classes which participate in the AutoSearchDialog
    implementation is provided below. You can click on any unit, class or
    property in this diagram in order to access the corresponding help topic.

    <IMAGE AutoSearchObjectModel>

    You can modify the behavior of the AutoSearch dialog by either replacing
    it with a customized descendant or by creating new AutoSearchPanel
    descendants.

    The first approach requires that you create a descendant of the
    CustomAutoSearchDialog class and register it as the 'official'
    AutoSearchDialog.  You then add the unit containing this new dialog to
    your project. When you run the project, ReportBuilder will use your
    AutoSearch dialog instead of the built-in dialog.}

  TppAutoSearchDialog = class(TppCustomAutoSearchDialog)
      pnlBottom: TPanel;
      pnlButtons: TPanel;
      btnOK: TButton;
      btnCancel: TButton;
      shpMandatory: TShape;
      lblMandatory: TLabel;
      procedure btnOKClick(Sender: TObject);
      procedure FormCreate(Sender: TObject);
      procedure FormDestroy(Sender: TObject);
      procedure FormActivate(Sender: TObject);
      
    private
      FAutoSearchGroups: TppAutosearchGroups;
      FNotebook: TppAutoSearchNotebook;

    protected
      function GetAutosearchGroups: TPersistent; override;
      procedure SetAutosearchGroups(aAutosearchGroups: TPersistent); override;

      procedure GetPanelClassForField(aField: TppAutoSearchField; var aPanelClass: TppAutoSearchPanelClass); virtual;
      procedure LanguageChanged; override;
      procedure PanelCreated(aField: TppAutoSearchField; aPanel: TppAutoSearchPanel); virtual;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      procedure Init; override;
      procedure AssignAutoSearchFields(aAutosearchFields: TList); override;

  end; {class, TppAutoSearchDialog}

var
  ppAutoSearchDialog: TppAutoSearchDialog;

implementation

{$R *.DFM}

{******************************************************************************
 *
 ** A U T O   S E A R C H    D I A L O G
 *
{******************************************************************************}
 
{@TppAutoSearchDialog.Create }

constructor TppAutoSearchDialog.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);

  FAutoSearchGroups := TppAutosearchGroups.Create(nil);
end;
   
{@TppAutoSearchDialog.Destroy }

destructor TppAutoSearchDialog.Destroy;
begin
  FAutoSearchGroups.Free;

  inherited Destroy;
end;
 
{@TppAutoSearchDialog.GetAutosearchGroups }

function TppAutoSearchDialog.GetAutosearchGroups: TPersistent;
begin
  Result := FAutoSearchGroups;
end;

{@TppAutoSearchDialog.SetAutosearchGroups }

procedure TppAutoSearchDialog.SetAutosearchGroups(aAutosearchGroups: TPersistent);
begin
  FAutoSearchGroups.Assign(TppAutosearchGroups(aAutosearchGroups));
end;

{@TppAutoSearchDialog.AssignAutosearchFields }

procedure TppAutoSearchDialog.AssignAutosearchFields(aAutosearchFields: TList);
begin
  FAutoSearchGroups.AssignAutoSearchFields(aAutosearchFields);
end;

{------------------------------------------------------------------------------}
{ TppAutoSearchDialog.FormCreate }

procedure TppAutoSearchDialog.FormCreate(Sender: TObject);
begin
  FNotebook := nil;
end; {procedure, FormCreate}

{------------------------------------------------------------------------------}
{ TppAutoSearchDialog.FormDestroy }

procedure TppAutoSearchDialog.FormDestroy(Sender: TObject);
begin
  FNotebook.Free;
end; {procedure, FormDestroy}

{------------------------------------------------------------------------------}
{ TppAutoSearchDialog.FormActivate }

procedure TppAutoSearchDialog.FormActivate(Sender: TObject);
begin
  FNotebook.SetFocus;
end; {procedure, FormActivate}

{------------------------------------------------------------------------------}
{ TppAutoSearchDialog.Init }

procedure TppAutoSearchDialog.Init;
begin

  if (FNotebook = nil) then
    begin
      FNotebook := TppAutoSearchNotebook.Create(Self);

      FNotebook.OnGetPanelClass := GetPanelClassForField;
      FNotebook.OnCreatePanel := PanelCreated;
      FNotebook.AutoSearchGroups := TppAutoSearchGroups(AutoSearchGroups);


      if (Report <> nil) and (pppcDesigning in TppCommunicator(Report).DesignState) then
        FNotebook.Designing := True;

      FNotebook.Init;

      shpMandatory.Visible := FNotebook.MandatoryFieldsExist;
      lblMandatory.Visible := FNotebook.MandatoryFieldsExist;
    end;

  if (FNotebook.Height < (ClientHeight - pnlButtons.Height)) then
    ClientHeight := FNotebook.Height + pnlButtons.Height;

  ClientWidth := 1000;
  
  if (FNotebook.Width < ClientWidth) then
    begin
      if (FNotebook.Width <= 438) then
        ClientWidth := 438
      else
        ClientWidth := FNotebook.Width;
    end;

end; {procedure, Init}

{------------------------------------------------------------------------------}
{ TppAutoSearchDialog.btnOKClick }

procedure TppAutoSearchDialog.btnOKClick(Sender: TObject);
begin
  if FNotebook.Valid then
    ModalResult := mrOK;
end; {procedure, btnOKClick}

{------------------------------------------------------------------------------}
{ TppAutoSearchDialog.LanguageChanged }

procedure TppAutoSearchDialog.LanguageChanged;
begin

  Caption := ppLoadStr(65); {Search}

  lblMandatory.Caption := ppLoadStr(66); {indicates that this search value must be entered.}

  btnOK.Caption := ppLoadStr(ppMsgOK);
  btnCancel.Caption := ppLoadStr(ppMsgCancel);

end; {procedure, LanguageChanged}


{@TppAutoSearchDialog.PanelCreated

 Fires after an AutoSearchPanel has been created for a given field.

 This method can be overridden so that the configuration of an AutoSearchPanel
 can be modified.}

procedure TppAutoSearchDialog.PanelCreated(aField: TppAutoSearchField; aPanel: TppAutoSearchPanel);
begin

end; {procedure, PanelCreated}


{@TppAutoSearchDialog.GetPanelClassForField

 Given an AutoSearchField, returns the class of the appropriate
 AutoSearchPanel component.  The standard implementation of this method
 returns a TppSimpleSearchPanel for all AutoSearchFields except those with a
 SearchOperator of soInList or soNotInList (which requires
 TppInListSearchPanel) and soBetween and soNotBetween (which requires a
 TppBetweenSearchPanel.)

 This method can be overridden in order to provide alternate AutoSearchPanel
 descendant classes.  For more on this see AutoSearchDialog.}

procedure TppAutoSearchDialog.GetPanelClassForField(aField: TppAutoSearchField; var aPanelClass: TppAutoSearchPanelClass);
begin


end; {function, GetPanelClassForField}


{******************************************************************************
 *
 ** I N I T I A L I Z A T I O N   /   F I N A L I Z A T I O N
 *
{******************************************************************************}

initialization

  ppRegisterForm(TppCustomAutoSearchDialog, TppAutoSearchDialog);

finalization

  ppUnRegisterForm(TppCustomAutoSearchDialog);

end.
