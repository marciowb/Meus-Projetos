/// Contains the TFlexCelReport component.
unit UFlexCelReport;
{$IFDEF LINUX}{$INCLUDE ../FLXCOMPILER.INC}{$ELSE}{$INCLUDE ..\FLXCOMPILER.INC}{$ENDIF}
{******************************************************************
 Component to automate reporting to Excel

// Portions created by Adrian Gallero are Copyright
// (C) 2002-2008 Adrian Gallero. All Rights Reserved.
******************************************************************** }
interface
uses
  SysUtils, Classes, UCustomFlexCelReport, UXlsDB, UXlsTDataSet,
  contnrs, DB,
  {$IFDEF FLX_NEEDSVARIANTS} variants, {$ENDIF}
  typinfo, UExcelAdapter, UFlxMessages, UFlxFullDataSets;

type
  /// <summary>
  /// Defines how TFlexCelReport will count the records in a TDataSet.<para></para>
  /// See <see cref="TFlexCelReport.CalcRecordCount" text="CalcRecordCount Property" /> for more
  /// information.
  /// </summary>                                                                                
  TCalcRecordCount=(

  /// <summary>
  /// FlexCel will assume RecordCount is returning a correct value. See <see cref="TFlexCelReport.CalcRecordCount" text="CalcRecordCount Property" />
  /// for more information.
  /// </summary>
  cr_None,

  /// <summary>
  /// FlexCel will do a db.Last command and assume the number returned by RecordCount is ok. See <see cref="TFlexCelReport.CalcRecordCount" text="CalcRecordCount Property" />
  /// for more information.
  /// </summary>
  cr_Count,

  /// <summary>
  /// FlexCel will count all records in the database, assuming RecordCount is returning an incorrect value.
  /// See <see cref="TFlexCelReport.CalcRecordCount" text="CalcRecordCount Property" /> for more
  /// information. 
  /// </summary>                                                                                           
   cr_SlowCount);

  /// <summary>
  /// <see cref="TFlexCelReport.OnRecordCount" />.
  /// </summary>                                  
  TRecordCountEvent = procedure (Sender: TObject; const DataSet: TDataSet; var RecordCount: integer) of object;

  /// <summary>
  /// This is the component to use when you want to create Excel reports.
  /// </summary>
  /// <remarks>
  /// TFlexCelReport is a component for making reports in Excel from a Delphi application using a template.
  /// It uses Excel as the Report Designer, allowing you to use all of its power, from conditional
  /// formatting to pivot tables, including charts, formulas, multiple sheets, multiple master-detail
  /// relationships and whatever you can do from Excel.<para></para>
  /// <para></para>
  /// Templates can be linked into the exe file by using a TXlsTemplateStore, allowing you to create single
  /// exe applications.<para></para>
  /// 
  /// </remarks>                                                                                           
  TFlexCelReport = class(TCustomFlexCelReport)
  private
    FDataModule: TComponent;
    FCalcRecordCount: TCalcRecordCount;
    FPagesDataSet: TFlxDataSet; 

    FOnRecordCount: TRecordCountEvent;

    procedure SetPagesDataSet(const Value: TFlxDataSet);
    procedure SetOnRecordCount(const Value: TRecordCountEvent);
    procedure SetDataModule(const Value: TComponent);

    function RecordCount(const DbSet: TDataSet): integer;
    { Private declarations }

  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;

    { Protected declarations }
  public
    /// <summary>
    /// This property is of internal use.
    /// </summary>                       
    function GetPagesDataSet: IXlsDataSet; override;

    /// <summary>
    /// \Internal use.
    /// </summary>
    /// <param name="DataSetName">\Internal use.</param>
    function GetDataSet(const DataSetName: string): IXlsDataSet; override;
  public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;

    /// <summary>
    /// Component containing the databases used for the report.
    /// </summary>
    /// <remarks>
    /// This returns the DataModule or Form containing the TQuery/TTables FlexCel is going to use to create
    /// the report.<para></para>
    /// It is Read-Only; if you want to modify this value, use the DataModule property.<para></para>
    /// <para></para>
    /// Even when the name says &quot;DataModule&quot;, and even when it usually is, this property can really
    /// point to any component.
    /// </remarks>
    function DesignDataModule: TComponent; override;

  published
    /// <summary>
    /// Datamodule containing the Tables/Queries needed by the report.
    /// </summary>
    /// <remarks>
    /// This is the datamodule where all the datasets for the report are located, and the published
    /// properties defined. Normally it will be the same datamodule that has the TFlexCelReport component, so
    /// it's assigned automatically and you don't have to care about it.<para></para>
    /// <para></para>
    /// Really, the datamodule doesn't need to be a TDataModule descendant, but any TComponent, as long as it
    /// holds the necessary DataSets. That said, for any medium-complex project, it will probably be one
    /// TDatamodule dedicated exclusively to the reports.<para></para>
    /// <para></para>
    /// <b>Known issue</b>: You can not set this property to point to another DataModule at design time. This
    /// is an issue with the Delphi IDE, and the only workaround is assigning this property on your code.<para></para>
    /// 
    /// </remarks>                                                                                                    
    property DataModule: TComponent read FDataModule write SetDataModule;

    /// <summary>
    /// Method FlexCel will use to calculate the record count of a DataSet.
    /// </summary>
    /// <remarks>
    /// If you have spent some time with different databases, you probably are aware of all the issues
    /// regarding TDataSet.RecordCount.<para></para>
    /// Some databases return the right number of records, others will give the unfiltered count (be careful
    /// with these, they may work right until someone filters the dataset), others will give always -1, and
    /// in short, every data layer seems to like returning his own number on this property.<para></para>
    /// <para></para>
    /// The conclusion to it would be &quot;don't use RecordCount at all&quot;. But we really needed to.
    /// Inserting rows in Excel is by far the most time consuming task, much more than counting the records.
    /// So the code:
    /// 
    /// <code lang="delphi">
    /// db.First;
    /// Rc:=0;
    /// while not db.eof do inc (Rc);
    /// ExcelApp.InsertRow(Rc) ;
    /// </code>
    /// 
    /// is normally much faster than:
    /// 
    /// <code lang="delphi">
    /// db.First;
    /// while not db.eof do ExcelApp.InsertRow
    /// </code>
    /// 
    /// So, depending of the database and the dataset you use, there are 4 ways to count the records: The
    /// first is using the OnRecordCount event, and the others are setting CalcRecordCount to:
    /// 
    /// <xtable columnwidths="20c%">
    /// Value          Meaning
    /// -------------  ------------------------------------------------------------------------------------------------
    /// cr_None        Use it if you are sure RecordCount is always right, with the dataset filtered or not. This is
    ///                 the case if you are using a TClientDataSet. You can safely use this mode with ClientDataSet or
    ///                 TFlxMemTable databases.
    /// cr_Count       The default. It will make a db.Last before using RecordCount, to make sure all records have
    ///                 been fetched. This works with some BDE datasets, or InterbaseExpress.
    /// cr_SlowCount   This will assume RecordCount is always wrong and count the records one by one using a procedure
    ///                 like the one in the example above. Whenever you are not sure, or you are getting strange
    ///                 results use this mode.
    /// </xtable>
    /// 
    /// </remarks>                                                                                                     
    property CalcRecordCount: TCalcRecordCount read FCalcRecordCount write FCalcRecordCount default cr_Count;

    /// <summary>
    /// Dataset used to create multiple sheet reports.
    /// </summary>
    /// <remarks>
    /// If you assign this property, the active page on the template will be duplicated once for each entry
    /// of the DataSet, and filled with the data corresponding to this entry. The name of the page will be
    /// given by the PagesDataField property.<para></para>
    /// 
    /// </remarks>                                                                                         
    property PagesDataSet: TFlxDataSet read FPagesDataSet write SetPagesDataSet;

    /// <summary>
    /// Occurs when FlexCel needs to know the record count on a dataset.
    /// </summary>
    /// <remarks>
    /// This event can be used instead of the CalcRecordCount property when you want more control on how to
    /// count the records.<para></para>
    /// <para></para>
    /// Here you will count the records yourself normally by senidng a &quot;Select count&quot; SQL command
    /// to the database, and returning that count in the RecordCount variable. Look at the example for more
    /// information.<para></para>
    /// <para></para>
    /// <b>Note</b>: Assigning this event leaves the value of CalcRecordCount without meaning.<para></para>
    /// 
    /// </remarks>
    /// <param name="Sender">TFlexCelReport component sending the event.</param>
    /// <param name="DataSet">Dataset from which we want the record count.</param>
    /// <param name="RecordCount">Return the record count of &quot;DataSet&quot; here.</param>
    /// 
    /// <example>
    /// This might be a typical implementation of this event:
    /// 
    /// <code lang="delphi">
    /// procedure TFTestReport.ExcelReport1RecordCount(Sender: TObject;
    ///   const DataSet: TDataSet; var RecordCount: Integer);
    /// begin
    ///   QCount.Open;
    ///   try
    ///     RecordCount:=QCountTotal.Value;
    ///   finally
    ///       QCount.Close;
    ///   end; //finally
    /// end;
    /// </code>
    /// 
    /// and the SQL property of QCount may be something like this:
    /// 
    /// <code>
    ///  Select count(*) as Total from table
    /// </code>
    /// 
    /// Be sure that QCount and Dataset use the same readonly, snapshot transaction, or someone might delete
    /// a record from table after calling QCount, but before the data is passed to Excel.<para></para>
    /// <para></para>
    /// 
    /// </example>                                                                                          
    property OnRecordCount: TRecordCountEvent read FOnRecordCount write SetOnRecordCount;
  end;

  ClassOfTFlexCelReport= class of TFlexCelReport;

implementation

{ TFlexCelReport }

constructor TFlexCelReport.Create(AOwner: TComponent);
begin
  inherited;
  FDataModule:=AOwner;
  FCalcRecordCount:=cr_Count;
end;

destructor TFlexCelReport.Destroy;
begin
  inherited;
end;

procedure TFlexCelReport.Notification(AComponent: TComponent; Operation: TOperation);
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
function TFlexCelReport.RecordCount(const DbSet: TDataSet): integer;
begin
  Result:=0;
  if Canceled then exit;
  if DbSet<>nil then
  begin
    //Count the records
    DbSet.First;

    //If the event OnCountRecords is Assigned, the var FCalcRecordCount has no meaning
    if Assigned (FOnRecordCount) then FOnRecordCount(Self, DbSet, Result)
    else
      case FCalcRecordCount of
        cr_None:
          Result:= DbSet.RecordCount;
        cr_Count:
        begin
          DbSet.Last;
          DbSet.First;
          Result:= DbSet.RecordCount;
        end; //cr_Count
        cr_SlowCount:
        begin
          while not DbSet.Eof do
          begin
            inc(Result);
            DbSet.Next;
          end;
          DbSet.First;
        end; //cr_SlowCount
      end; //case
  end //DbSet <>nil
  else Result:=1;
end;

procedure TFlexCelReport.SetPagesDataSet(const Value: TFlxDataSet);
var
  IDs: IXlsDataSet;
begin
  if (Value<>nil) then
    if not (Value is TDataSet) then
     if not Supports(Value, IXlsDataSet, IDs) then raise Exception.CreateFmt(ErrComponentIsNotXlsDataSet, [Value.Name]);
  FPagesDataSet := Value;
end;

procedure TFlexCelReport.SetOnRecordCount(const Value: TRecordCountEvent);
begin
  FOnRecordCount := Value;
end;

procedure TFlexCelReport.SetDataModule(const Value: TComponent);
begin
  if Value=nil then FDataModule := Owner else FDataModule:=Value;
end;

function TFlexCelReport.GetDataSet(const DataSetName: string): IXlsDataSet;
var
  Ds: TComponent;
begin
  Ds:=FDataModule.FindComponent(DataSetName);
  if (Ds=nil) then Result:=nil else
  if not Supports(Ds,IXlsDataSet, Result) then
  if (Ds is TDataSet) then Result:=TXlsTDataSet.Create(Ds as TDataSet, RecordCount, FUseDisplayNames, FUseHiddenFields)
  else Result:=nil;
end;

function TFlexCelReport.GetPagesDataSet: IXlsDataSet;
var
  IDs:IXlsDataSet;
begin
  if FPagesDataSet=nil then Result:=nil else
    if (FPagesDataSet is TDataSet) then Result:= TXlsTDataSet.Create(FPagesDataSet as TDataSet, RecordCount, FUseDisplayNames, FUseHiddenFields)
    else if Supports(FPagesDataSet, IXlsDataSet, IDs) then Result:=IDs
    else Result:=nil;
end;

function TFlexCelReport.DesignDataModule: TComponent;
begin
  Result:=FDataModule;
end;

end.

