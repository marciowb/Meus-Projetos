///This unit contains the TFlexCelReportNoDB component.

unit UFlexCelReportNoDB;
{$IFDEF LINUX}{$INCLUDE ../FLXCOMPILER.INC}{$ELSE}{$INCLUDE ..\FLXCOMPILER.INC}{$ENDIF}
interface
uses
  SysUtils, Classes, UCustomFlexCelReport, UXlsDB,
  contnrs, 
  {$IFDEF FLX_NEEDSVARIANTS} variants, {$ENDIF}
  typinfo, UExcelAdapter, UFlxMessages, UFlxFullDataSets;

type
  /// <summary>
  /// A specialized TFlexCelReport without database support.
  /// </summary>
  /// <remarks>
  /// FlexCelReportNoDB is a &quot;light&quot; version of TFlexCelReport that doesn't use the DB unit,
  /// allowing you to have smaller exe files if your applications don't use databases at all.<para></para>
  /// <para></para>
  /// This component does not work with datasets, only with <see cref="TFlxMemTable" /> components.
  /// TFlexCelReport works with both of them.<para></para>
  /// <para></para>
  /// <b>Use TFlexCelReportNoDB if you are not using databases at all on your application. If you have any
  /// reference to the DB unit, use TFlexCelReport instead, since there is no advantage on using this one</b>.
  /// </remarks>                                                                                              
  TFlexCelReportNoDB = class(TCustomFlexCelReport)
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

    /// <summary>
    /// See <see cref="TFlexCelReport.DesignDataModule" text="TFlexCelReport.DesignDataModule Method" /> 
    /// </summary>                                                                                       
    function DesignDataModule: TComponent; override;
    { Public declarations }

  published
    /// <summary>
    /// See <see cref="TFlexCelReport.DataModule" text="TFlexCelReport.DataModule Property" />
    /// </summary>                                                                            
    property DataModule: TComponent read FDataModule write SetDataModule;
    /// <summary>
    /// See <see cref="TFlexCelReport.PagesDataSet" text="TFlexCelReport.PagesDataSet Property" />
    /// </summary>                                                                                
    property PagesDataSet: TFlxDataSet read FPagesDataSet write SetPagesDataSet;

    { Published declarations }

  end;

  ClassOfTFlexCelReportNoDB= class of TFlexCelReportNoDB;

implementation

{ TFlexCelReportNoDB }

constructor TFlexCelReportNoDB.Create(AOwner: TComponent);
begin
  inherited;
  FDataModule:=AOwner;
end;

destructor TFlexCelReportNoDB.Destroy;
begin
  inherited;
end;

procedure TFlexCelReportNoDB.Notification(AComponent: TComponent; Operation: TOperation);
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

procedure TFlexCelReportNoDB.SetPagesDataSet(const Value: TFlxDataSet);
var
  IDs: IXlsDataSet;
begin
  if (Value<>nil) then
   if not Supports(Value, IXlsDataSet, IDs) then raise Exception.CreateFmt(ErrComponentIsNotXlsDataSet, [Value.Name]);
  FPagesDataSet := Value;
end;

procedure TFlexCelReportNoDB.SetDataModule(const Value: TComponent);
begin
  if Value=nil then FDataModule := Owner else FDataModule:=Value;
end;

function TFlexCelReportNoDB.GetDataSet(const DataSetName: string): IXlsDataSet;
var
  Ds: TComponent;
begin
  Ds:=FDataModule.FindComponent(DataSetName);
  if (Ds=nil) then Result:=nil else
  if not Supports(Ds,IXlsDataSet, Result) then Result:=nil;
end;

function TFlexCelReportNoDB.GetPagesDataSet: IXlsDataSet;
begin
  if FPagesDataSet=nil then Result:=nil else
    if not Supports(FPagesDataSet, IXlsDataSet, Result) then Result:=nil;
end;

function TFlexCelReportNoDB.DesignDataModule: TComponent;
begin
  Result:=FDataModule;
end;

end.
