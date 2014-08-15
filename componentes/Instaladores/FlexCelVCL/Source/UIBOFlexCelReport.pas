unit UIBOFlexCelReport;
{$IFDEF LINUX}{$INCLUDE ../FLXCOMPILER.INC}{$ELSE}{$INCLUDE ..\FLXCOMPILER.INC}{$ENDIF}
{$IFDEF LINUX}{$INCLUDE ../FLXCONFIG.INC}{$ELSE}{$INCLUDE ..\FLXCONFIG.INC}{$ENDIF}
interface
{$IFDEF IBOBJECTS}

uses
  SysUtils, Classes, UCustomFlexCelReport, UXlsDB, UXlsTIBODataSet,
  contnrs, IB_Components,
  {$IFDEF FLX_NEEDSVARIANTS} variants,{$ENDIF}
  typinfo, UExcelAdapter, UFlxMessages, UFlxFullDataSets;

type

  TIBOFlexCelReport = class(TCustomFlexCelReport)
  private
    FDataModule: TComponent;
    FPagesDataSet: TFlxDataSet;

    procedure SetPagesDataSet(const Value: TFlxDataSet);
    procedure SetDataModule(const Value: TComponent);

    { Private declarations }

  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;

    { Protected declarations }
  public
    function GetPagesDataSet: IXlsDataSet; override;
    function GetDataSet(const DataSetName: string): IXlsDataSet; override;
  public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;

    function DesignDataModule: TComponent; override;
    { Public declarations }

  published
    property DataModule: TComponent read FDataModule write SetDataModule;
    property PagesDataSet: TFlxDataSet read FPagesDataSet write SetPagesDataSet;
    { Published declarations }

  end;

  ClassOfTIBOFlexCelReport= class of TIBOFlexCelReport;
{$ENDIF}
implementation
{$IFDEF IBOBJECTS}

{ TIBOFlexCelReport }

constructor TIBOFlexCelReport.Create(AOwner: TComponent);
begin
  inherited;
  FDataModule:=AOwner;
end;

destructor TIBOFlexCelReport.Destroy;
begin
  inherited;
end;

procedure TIBOFlexCelReport.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
  begin
    if AComponent = FPagesDataSet then
        FPagesDataSet:= nil;
    if AComponent = FDataModule then
        FDataModule:= Owner;
  end;
end;

//----------------------------------------------------------------------------//

procedure TIBOFlexCelReport.SetPagesDataSet(const Value: TFlxDataSet);
var
  IDs: IXlsDataSet;
begin
  if (Value<>nil) then
    if not (Value is TIB_DataSet) then
     if not Supports(Value, IXlsDataSet, IDs) then raise Exception.CreateFmt(ErrComponentIsNotXlsDataSet, [Value.Name]);
  FPagesDataSet := Value;
end;

procedure TIBOFlexCelReport.SetDataModule(const Value: TComponent);
begin
  if Value=nil then FDataModule := Owner else FDataModule:=Value;
end;

function TIBOFlexCelReport.GetDataSet(const DataSetName: string): IXlsDataSet;
var
  Ds: TComponent;
begin
  Ds:=FDataModule.FindComponent(DataSetName);
  if (Ds=nil) then Result:=nil else
  if not Supports(Ds,IXlsDataSet, Result) then
  if (Ds is TIB_DataSet) then Result:=TXlsTIBODataSet.Create(Ds as TIB_DataSet, FUseDisplayNames, FUseHiddenFields)
  else Result:=nil;
end;

function TIBOFlexCelReport.GetPagesDataSet: IXlsDataSet;
var
  IDs:IXlsDataSet;
begin
  if FPagesDataSet=nil then Result:=nil else
    if (FPagesDataSet is TIB_DataSet) then Result:= TXlsTIBODataSet.Create(FPagesDataSet as TIB_DataSet, FUseDisplayNames, FUseHiddenFields)
    else if Supports(FPagesDataSet, IXlsDataSet, IDs) then Result:=IDs
    else Result:=nil;
end;

function TIBOFlexCelReport.DesignDataModule: TComponent;
begin
  Result:=FDataModule;
end;
{$ENDIF}
end.
