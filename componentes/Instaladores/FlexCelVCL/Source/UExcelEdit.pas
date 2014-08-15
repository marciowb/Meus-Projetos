unit UExcelEdit;
{$IFDEF LINUX}{$INCLUDE ../FLXCOMPILER.INC}{$ELSE}{$INCLUDE ..\FLXCOMPILER.INC}{$ENDIF}
{$IFDEF LINUX}{$INCLUDE ../FLXCONFIG.INC}{$ELSE}{$INCLUDE ..\FLXCONFIG.INC}{$ENDIF}

interface
{$IFDEF FLX_FPC}
implementation
{$ELSE}
uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ExtCtrls, DB, ImgList, Menus,
  UFlxMessages, TypInfo, UOleDrag,
  {$IFDEF FLX_NEEDSVARIANTS} variants,{$ENDIF}
  {$IFDEF IBOBJECTS}
  IB_Components,
  {$ENDIF}
  {$IFDEF FLEXCELDOA}
  Oracle,
  {$ENDIF}
  UXlsDB, UCUstomFlexCelReport, UCheckTemplate, ActnList, ToolWin;

type
  TExcelEdit = class(TForm)
    PanelFields: TPanel;
    edFields: TTreeView;
    TreeImageList: TImageList;
    MainMenu1: TMainMenu;
    ImageList1: TImageList;
    ImageList2: TImageList;
    ImageList3: TImageList;
    ToolBar1: TToolBar;
    btnCancel: TToolButton;
    File1: TMenuItem;
    Exit1: TMenuItem;
    ActionList1: TActionList;
    ActionClose: TAction;
    SaveDialog: TSaveDialog;
    ToolButton4: TToolButton;
    FormCaption: TPanel;
    Splitter1: TSplitter;
    PopupMenu1: TPopupMenu;
    New1: TMenuItem;
    Delete1: TMenuItem;
    Refresh1: TMenuItem;
    ActionCheckTemplate: TAction;
    ToolButton9: TToolButton;
    N1: TMenuItem;
    CheckTemplate1: TMenuItem;
    procedure edFieldsMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ActionCloseExecute(Sender: TObject);
    procedure ActionCheckTemplateExecute(Sender: TObject);
  private
    FileName: TFileName;
    FUseDisplayNames: boolean;
    FUseHiddenFields: boolean;
    FProjName: string;
    FDataModule: TComponent;
    FFlexCelReport: TCustomFlexCelReport;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    { Private declarations }
  public
    procedure LoadData(const aFlexCelReport: TCustomFlexCelReport; const aFileName: string; const aProjName: string);
    constructor Create(AOwner: TComponent); override;
    { Public declarations }
  end;

  procedure InvokeExcelEditor(const aFlexCelReport: TCustomFlexCelReport; const ProjName: string='');
implementation

uses
  {$IFNDEF FLX_FPC}Windows,{$ENDIF}
  ActiveX;

{$R *.dfm}

constructor TExcelEdit.Create(AOwner: TComponent);
begin
  inherited;
  {$IFDEF FLX_FIX_PARENTBACKGROUND}
  FormCaption.ParentBackground := false; //workarounds a bug in delphi.
  {$ENDIF}
end;

procedure TExcelEdit.CreateParams(var Params: TCreateParams) ;
begin
  inherited;
  Params.ExStyle := Params.ExStyle + WS_EX_TOOLWINDOW;
  Params.WndParent := GetDesktopWindow;
end;

procedure InvokeExcelEditor(const aFlexCelReport: TCustomFlexCelReport; const ProjName: string='');
var
  ExcelEdit: TExcelEdit;
  OldCursor: TCursor;
begin
  OldCursor:=Screen.Cursor;
  Screen.Cursor:=crHourGlass;
  try
    ExcelEdit:= TExcelEdit.Create(nil);
    try
      ExcelEdit.LoadData(aFlexCelReport, aFlexCelReport.Template, ProjName);
      ExcelEdit.ShowModal;
    finally
      FreeAndNil(ExcelEdit);
    end;
  finally
    Screen.Cursor:=OldCursor;
  end; //finally
end;

{ TExcelEdit }


procedure TExcelEdit.LoadData(const aFlexCelReport: TCustomFlexCelReport; const aFileName: string; const aProjName: string);
var
  i, k: integer;
  CurrItem, Child, Root: TTreeNode;
  Ds: TDataSet;
  {$IFDEF IBOBJECTS}
  IBODs: TIB_DataSet;
  {$ENDIF}
  {$IFDEF FLEXCELDOA}
  DOADs: TOracleQuery;
  {$ENDIF}
  IDs: IXlsDataSet;

  count:    integer;
  data:     PTypeData;
  info:     PTypeInfo;
  propList: PPropList;

begin
  FFlexCelReport:=aFlexCelReport;
  FDatamodule:=aFlexCelReport.DesignDataModule;
  FUseDisplayNames:=aFlexCelReport.UseDisplayNames;
  FUseHiddenFields:=aFlexCelReport.UseHiddenFields;
  FProjName:=aProjName;
  edFields.Items.Clear;
  Root:=edFields.Items.Add(Nil, TxtDatasets);
  Root.ImageIndex:=2;
  Root.SelectedIndex:=2;
  Root.Data:=nil;

  for i:=0 to FDatamodule.ComponentCount-1 do
  begin
    if (FDatamodule.Components[i]is TDataSet) then
    begin
      Ds:=FDatamodule.Components[i] as TDataSet;
      CurrItem:=edFields.Items.AddChild(Root, Ds.Name);
      CurrItem.ImageIndex:=0;
      CurrItem.SelectedIndex:=0;
      CurrItem.Data:=nil;

      Child:= edFields.Items.AddChild(CurrItem, FullDataSetStr);
      Child.ImageIndex:=1;
      Child.SelectedIndex:=1;
      Child.Data:=nil;
      for k:=0 to Ds.FieldCount-1 do
      begin
        if (FUseHiddenFields or Ds.Fields[k].Visible) then
        begin
          if FFlexCelReport.UseDisplayNames then
            Child:= edFields.Items.AddChild(CurrItem, Ds.Fields[k].DisplayName)
          else
            Child:= edFields.Items.AddChild(CurrItem, Ds.Fields[k].FieldName);
          Child.ImageIndex:=1;
          Child.SelectedIndex:=1;
          Child.Data:=Ds.Fields[k];
        end;
      end;
    end else
    {$IFDEF IBOBJECTS}
    if (FDataModule.Components[i]is TIB_DataSet) then
    begin
      IBODs:=FDataModule.Components[i] as TIB_DataSet;
      CurrItem:=edFields.Items.AddChild(Root, IBODs.Name);
      CurrItem.ImageIndex:=0;
      CurrItem.SelectedIndex:=0;
      CurrItem.Data:=nil;

      Child:= edFields.Items.AddChild(CurrItem, FullDataSetStr);
      Child.ImageIndex:=1;
      Child.SelectedIndex:=1;
      Child.Data:=nil;
      for k:=0 to IBODs.FieldCount-1 do
      begin
        if (FUseHiddenFields or IBODs.Fields[k].Visible) then
        begin
          if FFlexCelReport.UseDisplayNames then
            Child:= edFields.Items.AddChild(CurrItem, IBODs.Fields[k].DisplayName)
          else
            Child:= edFields.Items.AddChild(CurrItem, IBODs.Fields[k].FieldName);
          Child.ImageIndex:=1;
          Child.SelectedIndex:=1;
          Child.Data:=nil;
        end;
      end;
    end else
    {$ENDIF}
    {$IFDEF FLEXCELDOA}
    if (FDataModule.Components[i]is TOracleQuery) then
    begin
      DOADs:=FDataModule.Components[i] as TOracleQuery;
      CurrItem:=edFields.Items.AddChild(Root, DOADs.Name);
      CurrItem.ImageIndex:=0;
      CurrItem.SelectedIndex:=0;
      CurrItem.Data:=nil;

      Child:= edFields.Items.AddChild(CurrItem, FullDataSetStr);
      Child.ImageIndex:=1;
      Child.SelectedIndex:=1;
      Child.Data:=nil;
      for k:=0 to DOADs.FieldCount-1 do
      begin
        Child:= edFields.Items.AddChild(CurrItem, DOADs.FieldName(k));
        Child.ImageIndex:=1;
        Child.SelectedIndex:=1;
        Child.Data:=nil; //we don't have a real displayname
      end;
    end else
    {$ENDIF}
    if Supports(FDataModule.Components[i], IXlsDataSet, IDs) then
    begin
      CurrItem:=edFields.Items.AddChild(Root, IDs.DsName);
      CurrItem.ImageIndex:=8;
      CurrItem.SelectedIndex:=8;
      CurrItem.Data:=nil;

      Child:= edFields.Items.AddChild(CurrItem, FullDataSetStr);
      Child.ImageIndex:=7;
      Child.SelectedIndex:=7;
      Child.Data:=nil;
      for k:=0 to IDs.FieldCount-1 do
      begin
        Child:= edFields.Items.AddChild(CurrItem, IDs.Fields[k].DisplayName);
        Child.ImageIndex:=7;
        Child.SelectedIndex:=7;
        Child.Data:=nil;
      end;
    end;
  end;

  //Properties
  Root:=edFields.Items.Add(Nil, TxtProperties);
  Root.ImageIndex:=3;
  Root.SelectedIndex:=3;


  info := FDataModule.ClassInfo;
  data := GetTypeData(info);
  GetMem(propList, data^.PropCount * SizeOf(PPropInfo));
  try
    count := GetPropList(info, [tkVariant],  propList);
    for i := 0 to count - 1 do
    begin
    {$IFDEF DELPHI2008UP}
      Child:= edFields.Items.AddChild(Root, String(propList^[i]^.Name));
    {$ELSE}
      Child:= edFields.Items.AddChild(Root, propList^[i]^.Name);
    {$ENDIF}
      Child.ImageIndex:=4;
      Child.SelectedIndex:=4;
    end;
  finally
    FreeMem(propList, data^.PropCount * SizeOf(PPropInfo));
  end; //finally

  //Extras
  Root:=edFields.Items.Add(Nil, TxtExtras);
  Root.ImageIndex:=5;
  Root.SelectedIndex:=5;
  Child:= edFields.Items.AddChild(Root, MarkedRowStr);
  Child.ImageIndex:=6;
  Child.SelectedIndex:=6;
  Child:= edFields.Items.AddChild(Root, HPageBreakStr);
  Child.ImageIndex:=6;
  Child.SelectedIndex:=6;


  edFields.AlphaSort;

  FileName:=aFileName;
end;

procedure TExcelEdit.edFieldsMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  dwEffect: integer;
  DataObject: IDataObject;
  DropSource: IDropSource;
  DragText: string;
begin
  if (Button=mbLeft) and (edFields.Selected<>nil) then
  begin
    DragText:='';
    if ((edFields.Selected.ImageIndex=1) or (edFields.Selected.ImageIndex=7))
    and (edFields.Selected.Parent<>nil) then //Field or IXlsField
    begin
      DragText:=FieldStr+edFields.Selected.Parent.Text+FieldStr+edFields.Selected.Text;
      if (ssAlt in Shift) then
        if (edFields.Selected.Data<>nil)  then //Field
          DragText:=TField(edFields.Selected.Data).DisplayName+#13+#10+DragText
        else //IXlsField
          DragText:=edFields.Selected.Text+#13+#10+DragText
    end;

    if (edFields.Selected.ImageIndex=4)and (edFields.Selected.Parent<>nil) then //Property
      DragText:=VarStr+edFields.Selected.Text+VarStr;

    if (edFields.Selected.ImageIndex=6)and (edFields.Selected.Parent<>nil) then //Extra
      DragText:=edFields.Selected.Text;

    if DragText<>'' then
    begin
      DataObject:= TFlxDataObject.Create(DragText);
      DropSource:= TFlxDropsource.Create;
      ActiveX.DoDragDrop(DataObject, DropSource, DROPEFFECT_COPY or DROPEFFECT_MOVE, dweffect);
    end;
  end;
end;

procedure TExcelEdit.ActionCloseExecute(Sender: TObject);
begin
  Close;
end;


procedure TExcelEdit.ActionCheckTemplateExecute(Sender: TObject);
begin
  if FFlexCelReport.Adapter=nil then raise Exception.Create(ErrNoAdapter);
  InvokeCheckTemplate(FFlexCelReport, nil, False, FFlexCelReport.Template, FProjName);
end;
{$ENDIF}
end.
