/// Holds the definition of a TXlsTemplateStore class.
unit TemplateStore;
{$IFDEF LINUX}{$INCLUDE ../FLXCOMPILER.INC}{$ELSE}{$INCLUDE ..\FLXCOMPILER.INC}{$ENDIF}

interface
uses
  SysUtils, Classes, XlsMessages, UFlxMessages, XlsBaseTemplateStore,
  contnrs;

type
  /// <summary>
  /// This class holds one file stored in a TXlsTemplateStore.
  /// </summary>
  /// <remarks>
  /// You shouldn't normally need to use this class.<para></para>
  /// If you have the files in a template store and have lost the original files, sou could use the SaveAs
  /// method to get the files back from the store.<para></para>
  /// 
  /// </remarks>                                                                                          
  TXlsTemplate= class (TCollectionItem)
  private
    FFileName: TFileName;
    FStoredFile: ByteArray;
    FModifiedDate: TDateTime;

    procedure SetFileName(const Value: TFileName);
  protected
    function GetDisplayName: String; override;
    procedure SetDisplayName(const Value: String); override;

    procedure WriteData(Stream: TStream);
    procedure ReadData(Stream: TStream);
    procedure WriteModifiedDate(Writer: TWriter);
    procedure ReadModifiedDate(Reader: TReader);
    procedure DefineProperties(Filer: TFiler); override;
    function Equal(aTemplate: TXlsTemplate): Boolean;
  public
    /// <summary>
    /// An array of bytes containing the xls file stored in this entry.
    /// </summary>                                                     
    property StoredFile: ByteArray read FStoredFile;
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;

    /// <summary>
    /// Saves the file to disk.
    /// </summary>
    /// <remarks>
    /// You can use this method if you have lost the original xls files and you want to retrieve them from
    /// the store.
    /// </remarks>
    /// <param name="aFileName">\File where the xls file will be saved.</param>                           
    procedure SaveAs(const aFileName: TFileName);

    /// <summary>
    /// Loads a new file into the store.
    /// </summary>
    /// <remarks>
    /// This method is for internal use. You shouldn't call it directly.
    /// </remarks>
    /// <param name="aFileName">\File to load.</param>                  
    procedure LoadFrom(const aFileName: TFileName);overload;

    /// <summary>
    /// Loads a new file into the store.
    /// </summary>
    /// <remarks>
    /// This method is for internal use. You shouldn't call it directly.
    /// </remarks>
    /// <param name="aStream">Stream with the data to load.</param>     
    procedure LoadFrom(const aStream: TStream);overload;

    /// <summary>
    /// Date and time when the file stored was last modified.
    /// </summary>
    /// <remarks>
    /// FlexCel uses this value to know when it has to refresh the files.
    /// </remarks>                                                       
    property ModifiedDate: TDateTime read FModifiedDate;
  published
    /// <summary>
    /// FileName associated with this entry in the TemplateStore.
    /// </summary>                                               
    property FileName: TFileName read FFileName write SetFileName stored false;
  end;

  /// <summary>
  /// A List of TXlsTemplate objects.
  /// </summary>
  /// <remarks>
  /// this class is for internal use.<para></para>
  /// 
  /// </remarks>                                  
  TXlsTemplateList=class(TOwnedCollection) //Items are TXlsTemplate
  private
    function GetItems(Index: integer): TXlsTemplate;
  public
    property Items[Index: integer]: TXlsTemplate read GetItems; default;
  end;

  /// <summary>
  /// This component holds a collection of xls templates that will be linked in the exe.
  /// </summary>
  /// <remarks>
  /// This component allows you to link the templates directly into the exe, so you don't have to
  /// distribute additional files.<para></para>
  /// To use it, just drop one TemplateStore into the data module, connect it to a TXLSAdapter, and load
  /// the templates using the Templates property, or by double-clicking the component.<para></para>
  /// <para></para>
  /// At design time, you should always have a folder with the templates, and have the RefreshPath property
  /// from the TemplateStore point to it. This way, you can modify that files, and the TemplateStore will
  /// automatically detect it and warn you when checking the report .<para></para>
  /// <para></para>
  /// <b>Note</b>: Using a TemplateStore means that each time you want to change a template, you have to
  /// load it again and recompile your application. Depending on the kind of application you are doing,
  /// this might be an advantage or a disadvantage.<para></para>
  /// 
  /// </remarks>                                                                                           
  TXlsTemplateStore = class(TXlsBaseTemplateStore)
  private
    FCompress: boolean;
    FCaseInsensitive: boolean;
    FRefreshPath: UTF16String;
    procedure SetCompress(const Value: boolean);
    function DoUp(s: UTF16String): UTF16String;
  protected
    /// <summary>
    /// The list of templates stored into the component.
    /// </summary>
    /// <remarks>
    /// This field is for use in descending components, normally you should use should use the &quot;Templates&quot;
    /// property.
    /// </remarks>                                                                                                  
    FTemplates: TXlsTemplateList;

    /// <summary>
    /// This method returns a template stored in the component.
    /// </summary>
    /// <remarks>
    /// Override this method when creating a descendant from this component.
    /// </remarks>
    /// <param name="Name">Name of the file we want to retrieve. Depending on the value of CaseInsensitive
    ///                    property, this name might need to match the stored name with the exact case or
    ///                    not.</param>
    /// <returns>
    /// The file data as an array of bytes.<para></para>
    ///
    /// </returns>
    function GetStoredFile(Name: UTF16String): ByteArray; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy;override;

    /// <summary>
    /// \Returns true if the files on disk are same date that the files on the store.
    /// </summary>
    /// <remarks>
    /// For this method to return true, you need to have a RefreshPath defined, and pointing to the folder
    /// where the templates are stored.<para></para>
    ///
    /// </remarks>
    function IsUpToDate: boolean;override;

    /// <summary>
    /// Refreshes the store with the files on the disk.
    /// </summary>
    /// <remarks>
    /// his method will load the modified files located at RefreshPath back into the store. You normally
    /// don't need to call this method directly, but this is the method used when you right-click &quot;Refresh&quot;
    /// on a TemplateStore component.<para></para>
    ///
    /// </remarks>
    procedure Refresh;override;

    /// <summary>
    /// Adds a template to the store from a stream.
    /// </summary>
    /// <remarks>
    /// This method is used by the design time template editor to load templates into the component. Calling
    /// it from your code doesn't make that much sense since it would not be linked into the exe.
    /// </remarks>
    /// <param name="aStream">Stream containing the Excel file.</param>
    /// <param name="aTemplateName">Template name that will be used for the file.</param>
    procedure LoadTemplateFromStream(const aStream: TStream; const aTemplateName: UTF16String);
  published

    /// <summary>
    /// List of templates kept by this store.
    /// </summary>
    /// <remarks>
    /// Click on the ellipsis (&quot;...&quot;) button on the property inspector of this property to access
    /// the template list. There you can add new files to the store, or delete the ones you don't need. After
    /// you add a new entry, select its &quot;Filename&quot; property, and browse for the file you want to
    /// include.<para></para>
    ///
    /// </remarks>
    property Templates: TXlsTemplateList read FTemplates write FTemplates;

    /// <summary>
    /// This property is not implemented.
    /// </summary>
    property Compress: boolean read FCompress write SetCompress;

    /// <summary>
    /// Set this property to false if you want to match the filenames without case.
    /// </summary>
    /// <remarks>
    /// If this proeprty is true and you have a file stored as &quot;TEMPL.XLS&quot;, then specifying the
    /// filename &quot;templ.xls&quot; will find the file anyway.<para></para>
    /// If you ever plan to run your reports in Linux or other case sensitive systems, it is recommended that
    /// you leave this property true, since you can use case sensitive filenames in case insensitive file
    /// systems, but not the other way around.
    /// </remarks>
    property CaseInsensitive: boolean read FCaseInsensitive write FCaseInsensitive default false;

    /// <summary>
    /// Path where the actual xls files are in your development machine.
    /// </summary>
    /// <remarks>
    /// While you don't need to set this property (since templates are saved in your form, so once you chave
    /// loaded them you could safely delete them), it is normally very useful to have it set. If you set it,
    /// every time you modify the templates you can just right click the TemplateStore and press Refresh.<para></para>
    /// <para></para>
    /// In this property FlexCel stores the path for refreshing the template store. If RefreshPath is empty
    /// and you right-click the XLSTemplateStore on Refresh, FlexCel will ask for a folder and store it here.
    /// The next time, FlexCel will automatically refresh the store without asking.<para></para>
    /// <para></para>
    ///
    /// </remarks>
    property RefreshPath: UTF16String read FRefreshPath write FRefreshPath;
  end;

implementation

{ TXlsTemplate }

constructor TXlsTemplate.Create(Collection: TCollection);
begin
  inherited;
  SetLength(FStoredFile, 0);
end;

procedure TXlsTemplate.DefineProperties(Filer: TFiler);

  function DoWrite: Boolean;
  begin
    if Filer.Ancestor <> nil then
      Result := not (Filer.Ancestor is TXlsTemplate) or
        not Equal(TXlsTemplate(Filer.Ancestor))
    else
      Result := FFileName<>'';
  end;

begin
  inherited DefineProperties(Filer);
  Filer.DefineBinaryProperty('TemplateData', ReadData, WriteData, DoWrite);
  Filer.DefineProperty('ModifiedDate', ReadModifiedDate, WriteModifiedDate, DoWrite);
end;

destructor TXlsTemplate.Destroy;
begin
  inherited;
end;

function TXlsTemplate.Equal(aTemplate: TXlsTemplate): Boolean;
begin
  Result:=FFileName=aTemplate.FFileName;
end;

function TXlsTemplate.GetDisplayName: String;
begin
  Result:=FFileName;
end;

procedure TXlsTemplate.ReadData(Stream: TStream);
var
  Version: SmallInt;
  Ln: integer;
  w: UTF16String; //So we save filenames as widestrings.
begin
  Stream.ReadBuffer(Version, SizeOf(Version));
  if (Version < 2) then raise Exception.Create('The TemplateStore has data in older format. Please refresh it.');

  Stream.ReadBuffer(Ln, SizeOF(Ln));
  SetLength(w, Ln div 2);
  Stream.ReadBuffer(w[1], Ln);
  FFileName := w; //Convert if FFileName is string.

  Stream.ReadBuffer(Ln, SizeOF(Ln));
  SetLength(FStoredFile, Ln);
  Stream.ReadBuffer(FStoredFile[0], Ln);
end;

procedure TXlsTemplate.ReadModifiedDate(Reader: TReader);
begin
  FModifiedDate:=Reader.ReadDate;
end;

procedure TXlsTemplate.SaveAs(const aFileName: TFileName);
var
  f: TFileStream;
begin
  f := TFileStream.Create(aFileName, fmCreate);
  try
    f.WriteBuffer(FStoredFile[0], Length(FStoredFile));
  finally
    FreeAndNil(f);
  end;
end;

procedure TXlsTemplate.LoadFrom(const aFileName: TFileName);
var
  f: TFileStream;
begin
  f := TFileStream.Create(aFileName, fmOpenRead or fmShareDenyNone);
  try
    LoadFrom(f);
  finally
    FreeAndNil(f);
  end;
end;

procedure TXlsTemplate.LoadFrom(const aStream: TStream);
begin
  SetLength(FStoredFile, aStream.Size - aStream.Position);
  aStream.ReadBuffer(FStoredFile[0], Length(FStoredFile));
end;


procedure TXlsTemplate.SetDisplayName(const Value: String);
begin
  inherited;
  FileName:=Value;
end;

procedure TXlsTemplate.SetFileName(const Value: TFileName);
begin
  LoadFrom(Value);
  FFileName := ExtractFileName(Value);
  {$IFDEF BCB2006UP}
     FileAge(Value, FModifiedDate);
  {$ELSE}
     FModifiedDate:=FileDateToDateTime(FileAge(Value));
  {$ENDIF}
end;

procedure TXlsTemplate.WriteData(Stream: TStream);
var
  Version: SmallInt;
  Ln: integer;
  w: UTF16String;
begin
  Version:=2;
  Stream.WriteBuffer(Version,SizeOf(Version));

  w:=FFileName;
  Ln:=Length(FFileName) * 2;
  Stream.WriteBuffer(Ln, SizeOf(Ln));
  Stream.WriteBuffer(w[1], Ln);

  Ln:=Length(FStoredFile);
  Stream.WriteBuffer(Ln, SizeOf(Ln));
  Stream.WriteBuffer(FStoredFile[0], Ln);
end;

procedure TXlsTemplate.WriteModifiedDate(Writer: TWriter);
begin
  Writer.WriteDate(FModifiedDate);
end;

{ TXlsTemplateStore }

constructor TXlsTemplateStore.Create(AOwner: TComponent);
begin
  inherited;
  FTemplates:= TXlsTemplateList.Create(Self, TXlsTemplate);
end;

destructor TXlsTemplateStore.Destroy;
begin
  FreeAndNil(FTemplates);
  inherited;
end;

function TXlsTemplateStore.DoUp(s: UTF16String): UTF16String;
begin
  if FCaseInsensitive then Result := UpperCase(s) else Result := s;
end;

function TXlsTemplateStore.GetStoredFile(Name: UTF16String): ByteArray;
var
  i: integer;
begin
  Name:= ExtractFileName(Name);
  if FCaseInsensitive then Name := UpperCase(Name);

  for i:=0 to Templates.Count -1 do if DoUp(Templates[i].FileName)=Name then
  begin
    Result:=Templates[i].StoredFile;
    exit;
  end;
  raise Exception.CreateFmt(ErrFileNotFound, [Name]);
end;

function TXlsTemplateStore.IsUpToDate: boolean;
var
  FileName: UTF16String;
  i: integer;
  {$IFDEF BCB2006UP}
  Modified: TDateTime;
  {$ENDIF}
begin
  Result:=false;
  for i:=0 to Templates.Count-1 do
  begin
    FileName:=IncludeTrailingPathDelimiter(RefreshPath)+Templates[i].FileName;
    if not FileExists(FileName) then exit;

    {$IFDEF BCB2006UP}
       FileAge(FileName, Modified);
       if Modified <> Templates[i].ModifiedDate then exit;
    {$ELSE}
       if FileAge(FileName) <> DateTimeToFileDate(Templates[i].ModifiedDate) then exit;
    {$ENDIF}
  end;
  Result:=true;
end;

procedure TXlsTemplateStore.LoadTemplateFromStream(const aStream: TStream;
  const aTemplateName: UTF16String);
var
  NewTemplate: TXlsTemplate;
begin
  NewTemplate:=(Templates.Add as TXlsTemplate);
  NewTemplate.LoadFrom(aStream);
  NewTemplate.FFileName := aTemplateName;
end;

procedure TXlsTemplateStore.Refresh;
var
  i: integer;
begin
  for i:=0 to Templates.Count-1 do
  begin
    Templates[i].FileName:=IncludeTrailingPathDelimiter(RefreshPath)+Templates[i].FileName;
  end;
end;

procedure TXlsTemplateStore.SetCompress(const Value: boolean);
begin
  FCompress := Value;
end;

{ TXlsTemplateList }

function TXlsTemplateList.GetItems(Index: integer): TXlsTemplate;
begin
  Result:= inherited Items[Index] as TXlsTemplate;
end;
end.
