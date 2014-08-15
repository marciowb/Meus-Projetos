{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }


unit ppChrtUI;

interface

{$I ppIfDefTee.pas}

uses
  Types,
  Graphics,

  Chart,
  TeEngine,
  TeExport,
  EditChar,
  TeeProcs,
  {$IFDEF Tee50}
    TeeEditCha, TeeEdiSeri, ppChDPEdDlg,
  {$ELSE}
    IEdiGene, IEditCha, ppChDPEd,
  {$ENDIF}

  ppPopupMenus,
  ppDesignControls,
  ppDesignControlsEx,
  ppChrt,
  ppChrtDP;

type

  {TppTeeChartUI }
  TppTeeChartUI = class(TppCustomTeeChartUI)
    public
      class function ChartClass: TppCustomTeeChartClass; override;

      class procedure Edit(aCustomTeeChart: TppCustomTeeChart); override;
      class procedure Export(aCustomTeeChart: TppCustomTeeChart);  override;

  end; {class, TppTeeChartUI}


  {TppDPTeeChartUI }
  TppDPTeeChartUI = class(TppTeeChartUI)
    public
      class function ChartClass: TppCustomTeeChartClass; override;

      class procedure Edit(aCustomTeeChart: TppCustomTeeChart); override;

  end; {class, TppDPTeeChartUI}

  {@TppCustomTeeChartPopupMenu}
  TppCustomTeeChartPopupMenu = class(TppComponentPopupMenu)
    private
      procedure EditMenuClick(Sender: TObject);
      procedure ExportMenuClick(Sender: TObject);

    protected
      procedure CreateMenuItems; override;
      procedure DoPopup(Sender: TObject); override;
  end;

  {@TppTeeChartPopupMenu}
  TppTeeChartPopupMenu = class(TppCustomTeeChartPopupMenu)
  end;

  {@TppDPTeeChartPopupMenu}
  TppDPTeeChartPopupMenu = class(TppCustomTeeChartPopupMenu)
    private
      procedure RefreshDataMenuClick(Sender: TObject);

    protected
      procedure CreateMenuItems; override;
      procedure DoPopup(Sender: TObject); override;
  end;


  {@TppCustomTeeChartControl}
  TppCustomTeeChartControl = class(TppCustomComponentControl)
    protected
      procedure DblClick; override;
      procedure PaintDesignControl(aCanvas: TCanvas); override;
  end;


  {@TppTeeChartDesignControl}
  TppTeeChartDesignControl = class(TppCustomTeeChartControl)
  end;


  {@TppDPTeeChartDesignControl}
  TppDPTeeChartDesignControl = class(TppCustomTeeChartControl)
    protected
      procedure DblClick; override;
      procedure PaintDesignControl(aCanvas: TCanvas); override;
  end;


implementation

uses
  TeeConst,
  
  ppDrwCmd,
  ppUtils;

{******************************************************************************
 *
 ** T E E C H A R T  U I
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppTeeChartUI.Edit }

class function TppTeeChartUI.ChartClass: TppCustomTeeChartClass;
begin
  Result := TppTeeChart

end;

{------------------------------------------------------------------------------}
{ TppTeeChartUI.Edit }

class procedure TppTeeChartUI.Edit(aCustomTeeChart: TppCustomTeeChart);
{$IFDEF Tee40}
var
  lChartPart: TChartClickedPart;
{$ENDIF}
begin

{$IFDEF Tee40}

  aCustomTeeChart.Chart.CalcClickedPart(aCustomTeeChart.Chart.GetCursorPos, lChartPart);
  EditChartPart(nil, aCustomTeeChart.Chart, lChartPart);

{$ELSE}
  EditChart(nil, aCustomTeeChart.Chart);

{$ENDIF}


end;

{------------------------------------------------------------------------------}
{ TppTeeChartUI.Export }

class procedure TppTeeChartUI.Export(aCustomTeeChart: TppCustomTeeChart);
begin
{$IFDEF Tee50}
  TeeExport(nil, aCustomTeeChart.Chart);
{$ELSE}
  ChartExport(nil, aCustomTeeChart.Chart);
{$ENDIF}

end;

{******************************************************************************
 *
 ** D P  T E E C H A R T  U I
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppDPTeeChartUI.Edit }

class function TppDPTeeChartUI.ChartClass: TppCustomTeeChartClass;
begin
  Result := TppDPTeeChart

end;

{$IFDEF Tee50}
{------------------------------------------------------------------------------}
{ TppDPTeeChartUI.Edit }

class procedure TppDPTeeChartUI.Edit(aCustomTeeChart: TppCustomTeeChart);
{$IFNDEF Tee52}
var
  lProc: TOnCreateEditSeries;
{$ENDIF}

begin

{$IFDEF Tee52}
    inherited Edit(aCustomTeeChart);

{$ELSE}

  lProc := TeeEdiSeri.InternalOnCreateEditSeries;

  TeeEdiSeri.InternalOnCreateEditSeries := ppChDPEdDlg.OnCreateEditDBChart;

  try
    inherited Edit(aCustomTeeChart);

  finally
    TeeEdiSeri.InternalOnCreateEditSeries := lProc;

  end;

{$ENDIF}

end;


{$ELSE} {Tee40}

{------------------------------------------------------------------------------}
{ TppTeeChartUI.Edit }

class procedure TppDPTeeChartUI.Edit(aCustomTeeChart: TppCustomTeeChart);
var
  lProc: TOnCreateEditSeries;
begin

  lProc := IEditCha.InternalOnCreateEditSeries;

  IEditCha.InternalOnCreateEditSeries := ppChDPEd.OnCreateEditDBChart;

  try
    inherited Edit(aCustomTeeChart);

  finally
    IEditCha.InternalOnCreateEditSeries := lProc;

  end;

end;

{$ENDIF}


{******************************************************************************
 *
 ** C U S T O M  T E E C H A R T  P O P U P  M E N U
 *
{******************************************************************************}

procedure TppCustomTeeChartPopupMenu.CreateMenuItems;
begin
  inherited;

  {paramters: GroupIndex, Name, Caption, StringId}
  AddItem(25, 'Edit', '',  495);
  AddItem(25, 'Export', '',  496);
  AddSeparator(26, '');

  AddSeparator(40, '');
  AddItem(41, 'Version', TeeMsg_Version,  0);
  AddItem(41, 'VersionCopyRight', TeeMsg_Copyright,  0);

end;

procedure TppCustomTeeChartPopupMenu.DoPopup(Sender: TObject);
var
  lChartUIClass: TppCustomTeeChartUIClass;
begin

  inherited;

  lChartUIClass := TppTeeChartUIPlugIn.GetChartUIClass(TppCustomTeeChart(Component));

  ItemByName('Edit').Visible   := (lChartUIClass <> nil);
  ItemByName('Export').Visible := (lChartUIClass <> nil);

  ItemByName('Edit').OnClick    := EditMenuClick;
  ItemByName('Export').OnClick  := ExportMenuClick;

end;

{------------------------------------------------------------------------------}
{ TppCustomTeeChartPopupMenu.EditMenuClick }

procedure TppCustomTeeChartPopupMenu.EditMenuClick(Sender: TObject);
begin
  TppCustomTeeChart(Component).Edit;
end;

{------------------------------------------------------------------------------}
{ TppCustomTeeChartPopupMenu.ExportMenuClick }

procedure TppCustomTeeChartPopupMenu.ExportMenuClick(Sender: TObject);
begin
  TppCustomTeeChart(Component).Export;
end;



{******************************************************************************
 *
 ** D P  T E E C H A R T  P O P U P  M E N U
 *
{******************************************************************************}

procedure TppDPTeeChartPopupMenu.CreateMenuItems;
begin
  inherited;

  {paramters: GroupIndex, Name, Caption, StringId}
  AddItem(25, 'RefreshData', '',  497);

end;

procedure TppDPTeeChartPopupMenu.DoPopup(Sender: TObject);
begin
  inherited;

  {assign menu item event handlers}
  ItemByName('RefreshData').OnClick  := RefreshDataMenuClick;

end;

{------------------------------------------------------------------------------}
{ TppDBTeeChartPopupMenu.RefreshDataMenuClick }

procedure TppDPTeeChartPopupMenu.RefreshDataMenuClick(Sender: TObject);
begin

  {repaint control}
  //InvalidateDesignControl;

end;



{******************************************************************************
 *
 ** C U S T O M  C H A R T  C O N T R O L
 *
{******************************************************************************}

procedure TppCustomTeeChartControl.PaintDesignControl(aCanvas: TCanvas);
var
  lbPainting: Boolean;
  lDrawCommand: TppDrawImage;
  liMmWidth: Integer;
  liMmHeight: Integer;
begin

  GetPropValue('Painting', lbPainting);
  GetPropValue('mmWidth', liMmWidth);
  GetPropValue('mmHeight', liMmHeight);

  if lbPainting then Exit;

  TppCustomTeeChart(Component).Painting := True;

  lDrawCommand := TppDrawImage.Create(nil);

  try

    {set print position}
    TppCustomTeeChart(Component).PrintPosRect := ppRect(0, 0, liMmWidth, liMmHeight);

    {assign draw command properties}
    TppCustomTeeChart(Component).PropertiesToDrawCommand(lDrawCommand);

    {draw to the canvas}
    aCanvas.StretchDraw(ClientRect, lDrawCommand.Picture.Graphic);

  finally

    lDrawCommand.free;

    TppCustomTeeChart(Component).Painting := False;

  end;

end;

procedure TppCustomTeeChartControl.DblClick;
begin
 inherited;

  TppTeeChartUI.Edit(TppCustomTeeChart(Component));

end;



{******************************************************************************
 *
 ** D P  C H A R T  C O N T R O L
 *
{******************************************************************************}

procedure TppDPTeeChartDesignControl.PaintDesignControl(aCanvas: TCanvas);
var
  lChart: TCustomChart;
begin

  GetPropValue('Chart', lChart);

  if (lChart <> nil) and (lChart is TppDPTeeChartControl) then
    if TppDPTeeChartControl(lChart).RefreshingData then Exit;

  inherited;

end;

procedure TppDPTeeChartDesignControl.DblClick;
begin

 inherited;

  TppDPTeeChartUI.Edit(TppCustomTeeChart(Component));

end;

initialization
  TppTeeChartUIPlugIn.Register(TppTeeChartUI);
  TppTeeChartUIPlugIn.Register(TppDPTeeChartUI);

  TppPopupMenuManager.RegisterMenuClass(TppTeeChart, TppTeeChartPopupMenu);
  TppPopupMenuManager.RegisterMenuClass(TppDPTeeChart, TppDPTeeChartPopupMenu);

  TppDesignControlFactory.RegisterDesignControlClass(TppTeeChart, TppTeeChartDesignControl);
  TppDesignControlFactory.RegisterDesignControlClass(TppDPTeeChart, TppDPTeeChartDesignControl);


finalization
  TppTeeChartUIPlugIn.UnRegister(TppTeeChartUI);
  TppTeeChartUIPlugIn.UnRegister(TppDPTeeChartUI);

end.
 
