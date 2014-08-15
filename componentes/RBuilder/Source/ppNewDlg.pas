{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2008                    BBBBB   }

unit ppNewDlg;

interface

{$I ppIfDef.pas}

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  StdCtrls,
  ComCtrls,
  ExtCtrls,

  ppJvTabbar,

  ppForms,
  ppDesignerForms,
  ppTypes,
  ppWizard,
  ppClass,
  ppUtils;

type

  {@TppNewDialog }
  TppNewDialog = class(TppCustomNewDialog)
    btnOK: TButton;
    btnCancel: TButton;
    nbkNew: TNotebook;
    lvwWizards: TListView;
    lvwTemplates: TListView;
    procedure FormCreate(Sender: TObject);
    procedure lvwWizardsDblClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure lvwTemplatesDblClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);

    private
      FTemplateClasses: TStringList;
      FTemplateImageList: TImagelist;
      FWizardClasses: TStringList;
      FWizardImageList: TImagelist;
      FTabSet: TppJVTabBar;

      procedure Initialize;
      procedure InitializeWizardClasses;
      procedure InitializeTemplateClasses;

    protected
      procedure LanguageChanged; override;

      procedure Activate; override;
      function  GetCreateClass: TClass; override;
      function  GetWizardClasses: TStrings; override;
      function  GetTemplateClasses: TStrings; override;
      procedure SetWizardClasses(aList: TStrings); override;
      procedure SetTemplateClasses(aList: TStrings); override;

      procedure ehTabSet_TabSelected(Sender: TObject; Item: TppJvTabBarItem); virtual;

      property TabSet: TppJVTabbar read FTabSet;

  end; {class, TppNewDialog}



var
  ppNewDialog: TppNewDialog;

implementation

{$R *.DFM}

{------------------------------------------------------------------------------}
{ TppNewDialog.FormCreate }

procedure TppNewDialog.FormCreate(Sender: TObject);
begin

  FWizardClasses   := TStringList.Create;
  FTemplateClasses := TStringList.Create;

  FWizardImageList := TImageList.Create(Self);
  FWizardImageList.Width := 32;
  FWizardImageList.Height := 32;

  FTemplateImageList := TImageList.Create(Self);
  FTemplateImageList.Width := 32;
  FTemplateImageList.Height := 32;

  FTabSet := TppJVTabBar.Create(Self);
  FTabSet.Parent := Self;
  FTabSet.CloseButton := False;
  FTabSet.Top := nbkNew.Top - FTabSet.Height;
  FTabSet.AddTab('New');
  FTabSet.AddTab('Templates');
  FTabSet.OnTabSelected := ehTabSet_TabSelected;
  FTabset.Visible := False;

  FTabSet.SelectedTab := FTabSet.Tabs[0];
  nbkNew.PageIndex := 0;


end; {procedure, FormCreate}

{------------------------------------------------------------------------------}
{ TppNewDialog.FormDestroy }

procedure TppNewDialog.FormDestroy(Sender: TObject);
begin

  FWizardClasses.Free;
  FTemplateClasses.Free;

end; {procedure, FormDestroy}

{------------------------------------------------------------------------------}
{ TppNewDialog.Activate }

procedure TppNewDialog.Activate;
begin

  inherited Activate;

  Initialize;

end; {procedure, Activate}

{------------------------------------------------------------------------------}
{ TppNewDialog.Initialize }

procedure TppNewDialog.Initialize;
begin

  {this dialog can display a list of available wizard and template classes}
  InitializeWizardClasses;
  InitializeTemplateClasses;

  if (lvwWizards.Items.Count > 0) and (lvwTemplates.Items.Count > 0) then
    begin
      FTabset.Visible := True;

      lvwWizards.Align := alNone;
      lvwWizards.Height := lvwWizards.Height - 3;
      lvwWizards.Top := lvwWizards.Top + 3;

      lvwTemplates.Align := alNone;
      lvwTemplates.Height := lvwTemplates.Height - 3;
      lvwTemplates.Top := lvwTemplates.Top + 3;

    end
  else
    begin
      FTabset.Visible := False;
      nbkNew.Top := FTabSet.Top + 5;
      nbkNew.Height := nbkNew.Height + FTabset.Height - 5;
    end;

  {select the first item}
  if (lvwWizards.Items.Count > 0) then
    begin
      nbkNew.PageIndex := 0;
      lvwWizards.SetFocus;
      lvwWizards.Selected := lvwWizards.Items[0];
    end
  else if (lvwTemplates.Items.Count > 0) then
    begin
      nbkNew.PageIndex := 1;
      lvwTemplates.SetFocus;
      lvwTemplates.Selected := lvwTemplates.Items[0];

    end;

end; {procedure, Initialize}

{------------------------------------------------------------------------------}
{ TppNewDialog.InitializeWizardClasses }

procedure TppNewDialog.InitializeWizardClasses;
var
  lWizardClass: TppWizardClass;
  lListItem: TListItem;
  liIndex: Integer;
  lBitMap: TBitmap;

begin

  if FWizardClasses.Count = 0 then Exit;

  lBitMap := TBitmap.Create;

  for liIndex := 0 to FWizardClasses.Count - 1 do
    begin

      lWizardClass :=  TppWizardClass(FWizardClasses.Objects[liIndex]);

      lBitMap.Handle := ppBitmapFromResource(lWizardClass.ClassName);

      if (lBitmap.Handle = 0) then
        lBitMap.Handle := lWizardClass.ClassBitmap;

      if (lBitmap.Handle = 0) then
        lBitMap.Handle := ppBitmapFromResource('PPNOWIZARDBITMAP');


      if (lBitMap.Width = 32) and (lBitMap.Height = 32) then
        FWizardImageList.AddMasked(lBitMap, lBitMap.TransparentColor);

    end;

  lBitMap.Free;

  lvwWizards.LargeImages := FWizardImageList;

  for liIndex := 0 to FWizardClasses.Count-1 do
    begin
      lWizardClass := TppWizardClass(FWizardClasses.Objects[liIndex]);

      lListItem := lvwWizards.Items.Add;

      lListItem.ImageIndex := liIndex;
      lListItem.Caption    := lWizardClass.ClassDescription;

      lListItem.Data := lWizardClass;
    end;

end; {procedure, InitializeWizardClasses}

{------------------------------------------------------------------------------}
{ TppNewDialog.InitializeTemplateClasses }

procedure TppNewDialog.InitializeTemplateClasses;
var
  lClass: TClass;
  lDataViewClass: TdaDataViewClass;
  lReportClass: TppCustomReportClass;
  lListItem: TListItem;
  liIndex: Integer;
  lBitMap: TBitmap;
begin

  if (FTemplateClasses.Count = 0) then Exit;

  lBitMap := TBitmap.Create;

  for liIndex := 0 to FTemplateClasses.Count - 1 do
    begin
      lClass :=  TClass(FTemplateClasses.Objects[liIndex]);

      if (lClass.InheritsFrom(TdaDataView)) then
        begin
          lDataViewClass := TdaDataViewClass(lClass);

          lBitMap.Handle := ppBitmapFromResource(lDataViewClass.ClassName);

          if (lBitmap.Handle = 0) then
            lBitMap.Handle := lDataViewClass.ClassBitmap;
        end

      else if (lClass.InheritsFrom(TppCustomReport)) then
        begin
          lReportClass := TppCustomReportClass(lClass);

          lBitMap.Handle := ppBitmapFromResource(lReportClass.ClassName);

          if (lBitmap.Handle = 0) then
            lBitMap.Handle := lReportClass.ClassBitmap;
        end;

      if (lBitMap.Width = 32) and (lBitMap.Height = 32) then
        FTemplateImageList.AddMasked(lBitMap, lBitmap.TransparentColor);

    end;


  lvwTemplates.LargeImages := FTemplateImageList;

  for liIndex := 0 to FTemplateClasses.Count-1 do
    begin
      lClass := TClass(FTemplateClasses.Objects[liIndex]);

      lListItem := lvwTemplates.Items.Add;

      lListItem.ImageIndex := liIndex;
      lListItem.Data       := lClass;

      if (lClass.InheritsFrom(TdaDataView)) then
        lListItem.Caption := TdaDataViewClass(lClass).ClassDescription

      else if (lClass.InheritsFrom(TppCustomReport)) then
        lListItem.Caption := TppCustomReportClass(lClass).ClassDescription;

    end;

  lBitMap.Free;

end; {procedure, InitializeTemplateClasses}

{------------------------------------------------------------------------------}
{ TppNewDialog.GetCreateClass }

function TppNewDialog.GetCreateClass: TClass;
begin

  {return wizard class}
  if (nbkNew.PageIndex = 0) and (lvwWizards.Selected <> nil) then
    Result := TClass(lvwWizards.Selected.Data)

  else if (nbkNew.PageIndex = 1) and (lvwTemplates.Selected <> nil) then
    Result := TClass(lvwTemplates.Selected.Data)

  else
    Result := nil;

end; {function, GetCreateClass}

{------------------------------------------------------------------------------}
{ TppNewDialog.GetWizardClasses }

function  TppNewDialog.GetWizardClasses: TStrings;
begin
  Result := FWizardClasses;
end; {function, GetWizardClasses}

{------------------------------------------------------------------------------}
{ TppNewDialog.GetTemplateClasses }

function  TppNewDialog.GetTemplateClasses: TStrings;
begin
  Result := FTemplateClasses;
end; {function, GetTemplateClasses}

{------------------------------------------------------------------------------}
{ TppNewDialog.SetTemplateClasses }

procedure TppNewDialog.SetTemplateClasses(aList: TStrings);
begin
  FTemplateClasses.Assign(aList);
end; {procedure, SetTemplateClasses}

{------------------------------------------------------------------------------}
{ TppNewDialog.SetWizardClasses }

procedure TppNewDialog.SetWizardClasses(aList: TStrings);
begin
  FWizardClasses.Assign(aList);
end; {procedure, SetWizardClasses}

{------------------------------------------------------------------------------}
{ TppNewDialog.lvwTemplatesDblClick }

procedure TppNewDialog.lvwTemplatesDblClick(Sender: TObject);
begin
  if lvwTemplates.Selected <> nil then
    ModalResult := mrOK;
end; {procedure, lvwTemplatesDblClick}

{------------------------------------------------------------------------------}
{ TppNewDialog.lvwWizardsDblClick }

procedure TppNewDialog.lvwWizardsDblClick(Sender: TObject);
begin
  if lvwWizards.Selected <> nil then
    ModalResult := mrOK;
end; {procedure, lvwWizardsDblClick}

{------------------------------------------------------------------------------}
{ TppNewDialog.btnOKClick }

procedure TppNewDialog.btnOKClick(Sender: TObject);
begin
  if (nbkNew.PageIndex = 0) and (lvwWizards.Selected <> nil) then
    ModalResult := mrOK

  else if (nbkNew.PageIndex = 1) and (lvwTemplates.Selected <> nil) then
    ModalResult := mrOK;
end; {procedure, btnOKClick}

{------------------------------------------------------------------------------}
{ TdaDataSettingsDialog.ehTabSet_TabSelected }

procedure TppNewDialog.ehTabSet_TabSelected(Sender: TObject; Item: TppJvTabBarItem);
begin

  nbkNew.PageIndex := Item.Index;

end;

{------------------------------------------------------------------------------}
{ TppNewDialog.LanguageChanged }

procedure TppNewDialog.LanguageChanged;
begin

  Caption := ppLoadStr(690); {New Items}

  btnOK.Caption := ppLoadStr(ppMsgOK);
  btnCancel.Caption := ppLoadStr(ppMsgCancel);

end; {procedure, LanguageChanged}

{******************************************************************************
 *
 ** I N I T I A L I Z A T I O N   /   F I N A L I Z A T I O N
 *
{******************************************************************************}

initialization

  ppRegisterForm(TppCustomNewDialog, TppNewDialog);

finalization

  ppUnRegisterForm(TppCustomNewDialog);

end.
