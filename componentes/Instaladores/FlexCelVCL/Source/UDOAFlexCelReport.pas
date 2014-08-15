unit UDOAFlexCelReport;
{$IFDEF LINUX}{$INCLUDE ../FLXCOMPILER.INC}{$ELSE}{$INCLUDE ..\FLXCOMPILER.INC}{$ENDIF}
{$IFDEF LINUX}{$INCLUDE ../FLXCONFIG.INC}{$ELSE}{$INCLUDE ..\FLXCONFIG.INC}{$ENDIF}
interface
{$IFDEF FLEXCELDOA}
uses
  SysUtils, Classes, UCustomFlexCelReport, UXlsDB, UXlsTDOADataSet,
  contnrs, Oracle,
  {$IFDEF FLX_NEEDSVARIANTS} variants, {$ENDIF}
  typinfo, UExcelAdapter, UFlxMessages, UFlxFullDataSets;

type

  TDOAFlexCelReport = class(TCustomFlexCelReport)
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

  ClassOfTDOAFlexCelReport= class of TDOAFlexCelReport;
{$ENDIF}

implementation

{$IFDEF FLEXCELDOA}

{ TDOAFlexCelReport }

constructor TDOAFlexCelReport.Create(AOwner: TComponent);
begin
  inherited;
  FDataModule:=AOwner;
end;

destructor TDOAFlexCelReport.Destroy;
begin
  inherited;
end;

procedure TDOAFlexCelReport.Notification(AComponent: TComponent; Operation: TOperation);
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

procedure TDOAFlexCelReport.SetPagesDataSet(const Value: TFlxDataSet);
var
  IDs: IXlsDataSet;
begin
  if (Value<>nil) then
    if not (Value is TOracleQuery) then
     if not Supports(Value, IXlsDataSet, IDs) then raise Exception.CreateFmt(ErrComponentIsNotXlsDataSet, [Value.Name]);
  FPagesDataSet := Value;
end;

procedure TDOAFlexCelReport.SetDataModule(const Value: TComponent);
begin
  if Value=nil then FDataModule := Owner else FDataModule:=Value;
end;

function TDOAFlexCelReport.GetDataSet(const DataSetName: string): IXlsDataSet;
var
  Ds: TComponent;
begin
  Ds:=FDataModule.FindComponent(DataSetName);
  if (Ds=nil) then Result:=nil else
  if not Supports(Ds,IXlsDataSet, Result) then
  if (Ds is TOracleQuery) then
    Result:=TXlsTDOADataSet.Create(Ds as TOracleQuery, FUseDisplayNames, FUseHiddenFields, FDataModule.FindComponent(RecordCountPrefix+DataSetName) as TOracleQuery)
  else Result:=nil;
end;

function TDOAFlexCelReport.GetPagesDataSet: IXlsDataSet;
var
  IDs:IXlsDataSet;
begin
  if FPagesDataSet=nil then Result:=nil else
    if (FPagesDataSet is TOracleQuery) then Result:= TXlsTDOADataSet.Create(FPagesDataSet as TOracleQuery, FUseDisplayNames, FUseHiddenFields, FDataModule.FindComponent(RecordCountPrefix+FPagesDataSet.Name) as TOracleQuery)
    else if Supports(FPagesDataSet, IXlsDataSet, IDs) then Result:=IDs
    else Result:=nil;
end;

function TDOAFlexCelReport.DesignDataModule: TComponent;
begin
  Result:=FDataModule;
end;
{$ENDIF}
end.
