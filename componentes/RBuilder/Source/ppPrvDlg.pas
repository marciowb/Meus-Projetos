{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2008                   BBBBB   }

unit ppPrvDlg;

interface

{$I ppIfDef.pas}

uses
  Windows, ComCtrls, SysUtils, Messages, Classes, Graphics, Controls, Forms, ExtCtrls, StdCtrls, Mask, Buttons,
  ppForms, ppTypes, ppProd, ppDevice, ppViewr, Dialogs, ppUtils, ppPreview,
  ppOutlineViewer,

  ppTBX,
  ppTBXStatusBars,
  ppTBXExtItems,

  ppToolbarTBX;

type

  {@TppPrintPreview }

  TppPrintPreview = class(TppCustomPreviewer)
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    
  private
    FStatusBar: TppTBXStatusBar;
    FPreview: TppCustomPreview;

    function GetAutoSearchButton: TppTBXItem;
    function GetCancelButton: TppTBXItem;
    function GetFirstButton: TppTBXItem;
    function GetLastButton: TppTBXItem;
    function GetNextButton: TppTBXItem;
    function GetEmailButton: TppTBXItem;
    function GetOutlineViewer: TppOutlineViewer;
    function GetPageNoEdit: TppTBXEditItem;
    function GetPageWidthButton: TppTBXItem;
    function GetPercent100Button: TppTBXItem;
    function GetPrintButton: TppTBXItem;
    function GetPriorButton: TppTBXItem;
    function GetSplitter: TSplitter;
    function GetTextSearchButton: TppTBXItem;
    function GetTextSearchToolbar: TPanel;
    function GetToolbar: TppToolbar;
    function GetWholePageButton: TppTBXItem;
    function GetZoomPercentageEdit: TppTBXEditItem;
    function GetStatusBar: TppTBXStatusBar;

  protected
    procedure Activate; override;
    function  GetViewer: TObject; override;
    procedure LanguageChanged; override;

    procedure PreviewCloseEvent(Sender: TObject);

    function UsingDefaultPreviewPlugIn: Boolean;
    function GetPreview: TppPreview;

  public
    procedure Init; override;

    property StatusBar: TppTBXStatusBar read GetStatusBar;

     // the following properties are declared for convenience to
    //  provide access to ui controls implemented by TppPreview.
    //  TppPreview is the default preview plug-in. If TppPreview or a descendant
    //  is not registered, then these properties will return nil.
    property AutoSearchButton: TppTBXItem read GetAutoSearchButton;
    property CancelButton: TppTBXItem read GetCancelButton;
    property FirstButton: TppTBXItem read GetFirstButton;
    property LastButton:  TppTBXItem read GetLastButton;
    property NextButton:  TppTBXItem read GetNextButton;
    property EmailButton: TppTBXItem read GetEmailButton;
    property OutlineViewer: TppOutlineViewer read GetOutlineViewer;
    property PageNoEdit: TppTBXEditItem read GetPageNoEdit;
    property PageWidthButton: TppTBXItem read GetPageWidthButton;
    property Percent100Button:   TppTBXItem read GetPercent100Button;
    property PrintButton: TppTBXItem read GetPrintButton;
    property PriorButton: TppTBXItem read GetPriorButton;
    property Splitter: TSplitter read GetSplitter;
    property TextSearchToolbar: TPanel read GetTextSearchToolbar;
    property TextSearchButton: TppTBXItem read GetTextSearchButton;
    property Toolbar: TppToolbar read GetToolbar;
    property WholePageButton: TppTBXItem read GetWholePageButton;
    property ZoomPercentageEdit: TppTBXEditItem read GetZoomPercentageEdit;


  end; {class, TppPrintPreview}

var
  ppPrintPreview: TppPrintPreview;

implementation

{$R *.DFM}

{ TppPrintPreview.FormCreate }

procedure TppPrintPreview.FormCreate(Sender: TObject);
begin

  FStatusBar := TppTBXStatusBar.Create(Self);
  FStatusBar.Parent := Self;
  FStatusBar.SimplePanel := False;
  FStatusBar.Align := alBottom;
  FStatusBar.Panels.Add;
  FStatusBar.Panels[0].Width := 275;

  {create the preview plug-in
    - the preview plug-in enables a custom preview class to be register for
      use with the Report Designer and this Preview dialog}
  FPreview := TppPreviewPlugIn.CreatePreviewPlugin(Self);

  FPreview.StatusBarTbx := FStatusBar;
  FPreview.OnClose := PreviewCloseEvent;

end;

{ TppPrintPreview.FormDestroy}

procedure TppPrintPreview.FormDestroy(Sender: TObject);
begin
  FPreview.Free;
end;

{ TppPrintPreview.FormClose}

procedure TppPrintPreview.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

{ TppPrintPreview.Activate }

procedure TppPrintPreview.Activate;
begin

  {this is in Activate because we want it to fire after OnPreviewFormCreate
   and it's before Inherited to avoid caption flash.}
  if DisplayDocumentName then
    Caption := TppProducer(Report).PrinterSetup.DocumentName;

  inherited Activate;

end;

{ TppPrintPreview.Init }

procedure TppPrintPreview.Init;
begin

  if (Report is TppProducer) then
    FPreview.Viewer.Report := TppProducer(Report);

  FPreview.BeforePreview;

end;

{ TppPrintPreview.PreviewCloseEvent}

procedure TppPrintPreview.PreviewCloseEvent(Sender: TObject);
begin
  Close;
end;

{ TppPrintPreview.LanguageChanged}

procedure TppPrintPreview.LanguageChanged;
begin

  Caption := ppLoadStr(23);

  FPreview.LanguageChanged;

end;
{ TppPrintPreview.GetViewer }

function TppPrintPreview.GetViewer: TObject;
begin
  Result := FPreview.Viewer;
end;

{ TppPrintPreview.FormKeyDown}

procedure TppPrintPreview.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin

  FPreview.KeyDown(Key, Shift);

end;

{******************************************************************************
 *
 ** I N I T I A L I Z A T I O N   /   F I N A L I Z A T I O N
 *
{******************************************************************************}

function TppPrintPreview.GetAutoSearchButton: TppTBXItem;
begin
  if UsingDefaultPreviewPlugIn then
    Result := GetPreview.AutoSearchButton
  else
    Result := nil;

end;

function TppPrintPreview.GetCancelButton: TppTBXItem;
begin
  if UsingDefaultPreviewPlugIn then
    Result := GetPreview.CancelButton
  else
    Result := nil;

end;

function TppPrintPreview.GetFirstButton: TppTBXItem;
begin
  if UsingDefaultPreviewPlugIn then
    Result := GetPreview.FirstButton
  else
    Result := nil;

end;

function TppPrintPreview.GetLastButton: TppTBXItem;
begin
  if UsingDefaultPreviewPlugIn then
    Result := GetPreview.LastButton
  else
    Result := nil;

end;

function TppPrintPreview.GetNextButton: TppTBXItem;
begin
  if UsingDefaultPreviewPlugIn then
    Result := GetPreview.NextButton
  else
    Result := nil;

end;

function TppPrintPreview.GetEmailButton: TppTBXItem;
begin
  if UsingDefaultPreviewPlugIn then
    Result := GetPreview.EmailButton
  else
    Result := nil;
    
end;

function TppPrintPreview.GetOutlineViewer: TppOutlineViewer;
begin
  if UsingDefaultPreviewPlugIn then
    Result := GetPreview.OutlineViewer
  else
    Result := nil;

end;

function TppPrintPreview.GetPageNoEdit: TppTBXEditItem;
begin
  if UsingDefaultPreviewPlugIn then
    Result := GetPreview.PageNoEdit
  else
    Result := nil;

end;

function TppPrintPreview.GetPageWidthButton: TppTBXItem;
begin
  if UsingDefaultPreviewPlugIn then
    Result := GetPreview.PageWidthButton
  else
    Result := nil;

end;

function TppPrintPreview.GetPercent100Button: TppTBXItem;
begin
  if UsingDefaultPreviewPlugIn then
    Result := GetPreview.Percent100Button
  else
    Result := nil;

end;

function TppPrintPreview.GetPreview: TppPreview;
begin
  if UsingDefaultPreviewPlugIn then
    Result := TppPreview(FPreview)
  else
    Result := nil;
end;

function TppPrintPreview.GetPrintButton: TppTBXItem;
begin
  if UsingDefaultPreviewPlugIn then
    Result := GetPreview.PrintButton
  else
    Result := nil;

end;

function TppPrintPreview.GetPriorButton: TppTBXItem;
begin
  if UsingDefaultPreviewPlugIn then
    Result := GetPreview.PriorButton
  else
    Result := nil;

end;

function TppPrintPreview.GetSplitter: TSplitter;
begin
  if UsingDefaultPreviewPlugIn then
    Result := GetPreview.Splitter
  else
    Result := nil;

end;

function TppPrintPreview.GetTextSearchButton: TppTBXItem;
begin
  if UsingDefaultPreviewPlugIn then
    Result := GetPreview.TextSearchButton
  else
    Result := nil;

end;

function TppPrintPreview.GetTextSearchToolbar: TPanel;
begin
  if UsingDefaultPreviewPlugIn then
    Result := GetPreview.TextSearchToolbar
  else
    Result := nil;


end;

function TppPrintPreview.GetToolbar: TppToolbar;
begin
  if UsingDefaultPreviewPlugIn then
    Result := GetPreview.Toolbar
  else
    Result := nil;

end;

function TppPrintPreview.GetWholePageButton: TppTBXItem;
begin
  if UsingDefaultPreviewPlugIn then
    Result := GetPreview.WholePageButton
  else
    Result := nil;

end;

function TppPrintPreview.GetZoomPercentageEdit: TppTBXEditItem;
begin
  if UsingDefaultPreviewPlugIn then
    Result := GetPreview.ZoomPercentageEdit
  else
    Result := nil;

end;

function TppPrintPreview.UsingDefaultPreviewPlugIn: Boolean;
begin
  Result := TppPreviewPlugIn.UsingDefaultPreviewClass;
end;

function TppPrintPreview.GetStatusBar: TppTBXStatusBar;
begin
  Result := FStatusBar;

end;

initialization

  ppRegisterForm(TppCustomPreviewer, TppPrintPreview);

finalization

  ppUnRegisterForm(TppCustomPreviewer);

end.
