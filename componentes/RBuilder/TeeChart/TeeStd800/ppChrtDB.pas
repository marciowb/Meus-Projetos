{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit ppChrtDB;

interface

{$I ppIfDefTee.pas}

uses
  Windows,
  Classes,
  Graphics,
  ExtCtrls,
  SysUtils,
  Controls,

  Chart,
  DBChart,
  EditChar,
  DBEditCh,
  TeEngine,
  TeExport,
{$IFNDef Tee50}
{$IFDEF Tee40}
  IEdiGene, IEditCha,
{$ENDIF}
{$ENDIF}

  ppPopupMenus,
  ppClass,
  ppCtrls,
  ppTypes,
  ppUtils,
  ppDevice,
  ppDrwCmd,
  ppChrt,
  ppChrtUI;

type

  {@TppDBTeeChart

    This component is a wrapper for a data-aware TeeChart component.  You
    can access the TeeChart component via the Chart property or by double-
    clicking on the component in the Report Designer. For a full
    explanation of the TeeChart capabilities, see the TeeChart help.

    Note: In order to install the TeeChart components in Delphi 1.0 and 
    2.0, first install TeeChart.  Then install the ppChReg.pas file located
    in the RBuilder\TeeChart\ directory. This file contains the component
    registration necessary for the TppTeeChart and TppDBTeeChart
    components. In order to see that these components have installed
    correctly, create a new form, drop a TppReport object on it and double-
    click. Icons for both components should appear in the Report Designer
    component palettes.}

  TppDBTeeChart = class(TppCustomTeeChart)
    private
    
    protected
      function GetChildOwner: TComponent;  override;
      procedure CreateChart(var aChart: TCustomChart); override;

    public
      procedure Convert(aVersionNo: Integer); override;
      procedure ChangeOwner(aNewOwner: TComponent); override;

      procedure PropertiesToDrawCommand(aDrawCommand: TppDrawCommand); override;

{$IFNDEF Tee40}
      procedure Edit; override;
{$ENDIF}

    published
      property Anchors;
      property Border;
      property Chart;
      property PrintMethod;
      property Visible;

      {these properties saved in 'fake' properties}
      property Height stored False;
      property Left stored False;
      property Top stored False;
      property Width stored False;
  end; {class, TppDBTeeChart}

  {TppDBTeeChartUI }
  TppDBTeeChartUI = class(TppTeeChartUI)
    public
      class function ChartClass: TppCustomTeeChartClass; override;

      class procedure Edit(aCustomTeeChart: TppCustomTeeChart); override;

  end; {class, TppDPTeeChartUI}


  {@TppDBTeeChartControl }
  TppDBTeeChartControl = class(TCustomDBChart)
    private
      FStreamingParent: TComponent;

      procedure SetStreamingParent(aParent: TComponent);

    protected
      procedure CreateParams(var Params: TCreateParams); override;

      procedure ReadState(Reader: TReader); override;


    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      function  HasParent: Boolean; override;
      function  GetParentComponent: TComponent; override;
      procedure SetParentComponent(Value: TComponent); override;

      property StreamingParent: TComponent read FStreamingParent write SetStreamingParent;

    published
      { TCustomDBChart properties }
      property ShowGlassCursor;

      { TCustomChart Properties }
      property BackImage;
      property BackImageInside;
      property BackImageMode;
      property BottomWall;
      property Foot;
      property Gradient;
      property LeftWall;
      property MarginBottom;
      property MarginLeft;
      property MarginRight;
      property MarginTop;
      property Title;

      { TCustomAxisPanel properties }
      property AxisVisible;
      property BackColor;
      property BottomAxis;
      property Chart3DPercent;
      property ClipPoints;
      property Frame;
      property LeftAxis;
      property Legend;
      property MaxPointsPerPage;
      property Page;
      property RightAxis;
      property ScaleLastPage;
      property SeriesList;
      property TopAxis;
      property View3D;
      property View3DWalls;

      { TPanel properties }
      property BevelInner;
      property BevelWidth;
      property BevelOuter;
      property BorderWidth;
      property BorderStyle;
      property Color;

  end; {class, TppDBTeeChartControl}

  {@TppDBTeeChartPopupMenu}
  TppDBTeeChartPopupMenu = class(TppCustomTeeChartPopupMenu)
    private
      procedure RefreshDataMenuClick(Sender: TObject);

    protected
      procedure CreateMenuItems; override;
      procedure DoPopup(Sender: TObject); override;
  end;

implementation

uses TeeConst;

{******************************************************************************
 *
 ** D B T E E   C H A R T
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppDBTeeChart.GetChildOwner }

function TppDBTeeChart.GetChildOwner: TComponent;
begin
  Result := nil;
end; {function, GetChildOwner}

{------------------------------------------------------------------------------}
{ TppDBTeeChart.CreateChart }

procedure TppDBTeeChart.CreateChart(var aChart: TCustomChart);
begin

  {create & configure tee chart control}

 {note: create with a nil owner and then insert into the Owner
         at the bottom of this procedure - this avoids D5 lockup}

  aChart := TppDBTeeChartControl.Create(nil);

  TppDBTeeChartControl(aChart).StreamingParent := Self;

  aChart.Name := GetValidName(aChart);

  aChart.Title.Text.Clear;
  aChart.Title.Text.Add('Chart');
  aChart.Foot.Font.Color := clRed;
  aChart.Foot.Font.Style :=[fsItalic];
  aChart.Color := clWhite;
  aChart.BevelOuter := bvNone;
  aChart.BufferedDisplay := False;

  if Owner <> nil then
    Owner.InsertComponent(aChart);
 


end; {procedure, CreateChart}

{------------------------------------------------------------------------------}
{ TppDBTeeChart.PropertiesToDrawCommand }

procedure TppDBTeeChart.PropertiesToDrawCommand(aDrawCommand: TppDrawCommand);
begin

  TppDBTeeChartControl(Chart).RefreshData;

  inherited PropertiesToDrawCommand(aDrawCommand);


end; {procedure, PropertiesToDrawCommand}

{$IFNDEF Tee40}

{------------------------------------------------------------------------------}
{ TppDBTeeChart.Edit }

procedure TppDBTeeChart.Edit;
var
  lForm: TForm;
begin

  {form needed here because TeeChart looks in the Form to create
   the DataSet list for the series}
  if (Owner is TForm) then
    lForm := TForm(Owner)
  else
    lForm := nil;

  if Chart is TppDBTeeChartControl then
    EditDBChart(lForm, TCustomDBChart(Chart));


  {update props}
  UpdatePropertiesFromChart(Chart);

  {notify report designer}
  PropertyChange;

  {notify report engine}
  Reset;

  {repaint control}
  InvalidateDesignControl;

end; {procedure, Edit}

{$ENDIF}

{------------------------------------------------------------------------------}
{ TppDBTeeChart.Convert }

procedure TppDBTeeChart.Convert(aVersionNo: Integer);
begin
  {do nothing}
end;

{------------------------------------------------------------------------------}
{ TppDBTeeChart.ChangeOwner }

procedure TppDBTeeChart.ChangeOwner(aNewOwner: TComponent);
var
  liIndex: Integer;
  lSeries: TChartSeries;
  lChart: TCustomChart;
  
begin

  if (csDestroying in ComponentState) then Exit;

  if (aNewOwner = Owner) then Exit;

  lChart := Chart;

  if (lChart <> nil) and (lChart.Owner = Owner) then
    begin
      if Owner <> nil then
        Owner.RemoveComponent(lChart);

      if (aNewOwner <> nil) then
        aNewOwner.InsertComponent(lChart);

      for liIndex := 0 to lChart.SeriesCount-1 do
        begin
          lSeries := lChart.Series[liIndex];

          if (lSeries.Owner = Owner) then
            begin
              if (Owner <> nil) then
                Owner.RemoveComponent(lSeries);

              if (aNewOwner <> nil) then
                aNewOwner.InsertComponent(lSeries);

            end;
        end;

    end;


   inherited ChangeOwner(aNewOwner);

end; {procedure, ChangeOwner}




{******************************************************************************
 *
 ** D B T E E   C H A R T   C O N T R O L
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppDBTeeChartControl.Create }

constructor TppDBTeeChartControl.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);

  FStreamingParent := nil;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppDBTeeChartControl.Destroy }

destructor TppDBTeeChartControl.Destroy;
begin

  {remove from parent}
  SetStreamingParent(nil);


  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppDBTeeChartControl.CreateParams }

procedure TppDBTeeChartControl.CreateParams(var Params: TCreateParams);
begin

  inherited CreateParams(Params);

  {remove ws-child so that no parent window is required}
  Params.Style := Params.Style and not(WS_CHILD);

end; {procedure, CreateParams}

{------------------------------------------------------------------------------}
{ TppDBTeeChartControl.SetStreamingParent }

procedure TppDBTeeChartControl.SetStreamingParent(aParent: TComponent);
begin

  if (FStreamingParent <> nil) and (FStreamingParent is TppCustomTeeChart) then
    TppCustomTeeChart(FStreamingParent).SetChartProperty(nil);

  FStreamingParent := aParent;

  if (FStreamingParent <> nil) and (FStreamingParent is TppCustomTeeChart) then
    TppCustomTeeChart(FStreamingParent).SetChartProperty(Self);

end; {procedure, SetStreamingParent}


{------------------------------------------------------------------------------}
{ TppDBTeeChartControl.HasParent }

function TppDBTeeChartControl.HasParent: Boolean;
begin
  Result := True;
end; {function, HasParent}

{------------------------------------------------------------------------------}
{ TppDBTeeChartControl.GetParentComponent - required method for Components with HasParent = True }

function TppDBTeeChartControl.GetParentComponent: TComponent;
begin
  Result := FStreamingParent;
end;

{------------------------------------------------------------------------------}
{ TppDBTeeChartControl.SetParentComponent - required method for Components with HasParent = True }

procedure TppDBTeeChartControl.SetParentComponent(Value: TComponent);
begin
  if (Value is TppCustomTeeChart) then
    SetStreamingParent(Value);
end;

{------------------------------------------------------------------------------}
{ TppDBTeeChartControl.ReadState }

procedure TppDBTeeChartControl.ReadState(Reader: TReader);
begin

  inherited ReadState(Reader);

end;


{******************************************************************************
 *
 ** D B  T E E C H A R T  P O P U P  M E N U
 *
{******************************************************************************}

procedure TppDBTeeChartPopupMenu.CreateMenuItems;
begin
  inherited;

  {paramters: GroupIndex, Name, Caption, StringId}
  AddItem(25, 'RefreshData', '',  497);

end;

procedure TppDBTeeChartPopupMenu.DoPopup(Sender: TObject);
begin
  inherited;

  {assign menu item event handlers}
  ItemByName('RefreshData').OnClick  := RefreshDataMenuClick;

end;

{------------------------------------------------------------------------------}
{ TppDBTeeChartPopupMenu.RefreshDataMenuClick }

procedure TppDBTeeChartPopupMenu.RefreshDataMenuClick(Sender: TObject);
begin
  TCustomDBChart(TppCustomTeeChart(Component).Chart).RefreshData;
end;

{ TppDBTeeChartUI }

class function TppDBTeeChartUI.ChartClass: TppCustomTeeChartClass;
begin
  Result := TppDBTeeChart
end;

{$IFDEF Tee50}
{------------------------------------------------------------------------------}
{ TppDBTeeChartUI.Edit }

class procedure TppDBTeeChartUI.Edit(aCustomTeeChart: TppCustomTeeChart);
{$IFNDEF Tee52}
var
  lProc: TOnCreateEditSeries;
{$ENDIF}

begin

{$IFDEF Tee52}
    inherited Edit(aCustomTeeChart);

{$ELSE}

  TppDBTeeChart(aCustomTeeChart).Edit;

{$ENDIF}

end;


{$ELSE} {Tee40}

{------------------------------------------------------------------------------}
{ TppTeeChartUI.Edit }

class procedure TppDBTeeChartUI.Edit(aCustomTeeChart: TppCustomTeeChart);
begin

  TppDBTeeChart(aCustomTeeChart).Edit;

end;

{$ENDIF}

{******************************************************************************
 *
 ** I N I T I A L I Z A T I O N   /   F I N A L I Z A T I O N
 *
{******************************************************************************}


initialization

  RegisterClasses([TppDBTeeChart, TppDBTeeChartControl]);

  TppTeeChartUIPlugIn.Register(TppDBTeeChartUI);

  ppRegisterComponent(TppDBTeeChart, 'Data Components', 6, 463, '', 0);

  TppPopupMenuManager.RegisterMenuClass(TppDBTeeChart, TppDBTeeChartPopupMenu);

finalization
  TppPopupMenuManager.UnRegisterMenuClass(TppDBTeeChart);

  ppUnRegisterComponent(TppDBTeeChart);

end. 
