unit fraSQLEdit;

interface

{$I FIBPlus.inc}
{$I pFIBPropEd.inc}
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Menus, Forms, Dialogs,
  Buttons, ExtCtrls, StdCtrls, Grids, DBGrids, DB, FIBDatabase,FIBDataSet, pFIBDataSet,
  pFIBDatabase,FIBQuery,pFIBQuery,pFIBProps {$IFDEF D6+},Variants{$ENDIF}, ComCtrls, DBCtrls
  {$IFDEF USE_SYN_EDIT}
   ,SynEditHighlighter, SynHighlighterSQL, SynEdit, SynMemo,SynCompletionProposal,
  Mask
  {$ENDIF}

  ;




type
  TfSQLEdit = class(TFrame)
    Panel1: TPanel;
    Panel10: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    qryAllTables: TpFIBDataSet;
    qrySPs: TpFIBDataSet;
    Panel6: TPanel;
    Panel7: TGroupBox;
    LbTableSyn: TCheckBox;
    chReplaceSQL: TCheckBox;
    Splitter2: TSplitter;
    ds: TDataSource;
    trTransaction: TpFIBTransaction;
    qryTabFields: TpFIBDataSet;
    qrySPparams: TpFIBDataSet;
    FontDialog1: TFontDialog;
    FindDialog1: TFindDialog;
    dsFields: TDataSource;
    chOnlySelFields: TCheckBox;
    qrySPFields: TpFIBDataSet;
    btnCheck: TSpeedButton;
    GroupBox1: TGroupBox;
    Panel2: TPanel;
    Splitter1: TSplitter;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    Panel3: TPanel;
    Label4: TLabel;
    Edit1: TEdit;
    cmbTabsNameViews: TComboBox;
    btnGenSQL: TSpeedButton;
    cmbKindSQL: TComboBox;
    Label1: TLabel;
    splPlan: TSplitter;
    menuPlan: TPopupMenu;
    miHidePlan: TMenuItem;
    Label2: TLabel;
    cmbParamSymbol: TComboBox;
    btnReplaceZv: TSpeedButton;
    StatusBar1: TStatusBar;
    qryTabFields1: TpFIBDataSet;
    qryAllTables1: TpFIBDataSet;
    btnShowInCodeEditor: TSpeedButton;
    qryAllGenerators: TpFIBDataSet;
    Panel4: TPanel;
    edDomain: TDBEdit;
    Label3: TLabel;
    Label5: TLabel;
    edFieldType: TEdit;
    chNotNull: TDBCheckBox;
    procedure Panel7Resize(Sender: TObject);
    procedure cmbTabsNameViewsChange(Sender: TObject);
    procedure qrySPsFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure Edit1Change(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure FindDialog1Find(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnGenSQLClick(Sender: TObject);
    procedure Panel10Resize(Sender: TObject);
    procedure btnCheckClick(Sender: TObject);
    procedure miHidePlanClick(Sender: TObject);
    procedure cmbParamSymbolChange(Sender: TObject);
    procedure DBGrid1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure btnReplaceZvClick(Sender: TObject);
    procedure qryTabFieldsBeforeOpen(DataSet: TDataSet);
    procedure btnShowInCodeEditorClick(Sender: TObject);
    procedure qryTabFieldsAfterScroll(DataSet: TDataSet);
    procedure qrySPFieldsAfterOpen(DataSet: TDataSet);
  private
    OutPutTxt:TStrings;
    Dialect  :integer;
    vParamSymb:Char;
    FDatabase  :TFIBDatabase;
    FCanConnect:boolean;
    FConnectForced:boolean;
    FExistField_ForPrecision:integer;
    procedure GenTemplate(IsSP,OnlySelFields:boolean);
    procedure viewSQLKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure viewSQLKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure viewSQLMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);


    procedure ShowHideTemplateSupport;
    procedure CheckSQL;
    function GetSQLText: string;
    procedure SetSQLText(const Value: string);
    procedure EditorDragOver(Sender, Source: TObject; X, Y: Integer;
     State: TDragState; var Accept: Boolean);
    procedure EditorDragDrop(Sender, Source: TObject; X, Y: Integer);
    function GetModified: boolean;
  public
    vEdComponent:TFIBQuery;
   {$IFDEF USE_SYN_EDIT}
    viewSQL: TSynMemo;
    viewPlan:TSynMemo;
    SynSQLSyn1: TSynSQLSyn;
    CompleteProposal:TSynCompletionProposal;
    {$IFNDEF  SYNEDIT_08_2001}
     procedure CompleteProposalExecute(Kind: SynCompletionType;
      Sender: TObject; var CurrentInput: String; var x, y: Integer;
      var CanExecute: Boolean
     );
    {$ENDIF}
   {$ELSE}
    viewSQL: TMemo;
    viewPlan: TMemo;
   {$ENDIF}
    procedure Search(Again:boolean);
  public
    destructor Destroy; override;
    procedure ShowEditorStatus;
    procedure ReadOptions;
    procedure SaveOptions;

    procedure PrepareFrame(Database:TFIBDatabase);
    property  SQLText:string read GetSQLText write SetSQLText;
    property  CanConnect: boolean read FCanConnect;
    property  Modified:boolean read GetModified;
  end;

implementation

{$R *.dfm}

uses
 {$IFNDEF NO_REGISTRY} RegUtils, {$ENDIF}
SqlTxtRtns,FIBConsts,StrUtil,pFIBDataInfo,ToCodeEditorIntfs;

const
   RegFIBSQLEdOptions='SQLEditorFrame';

   
procedure TfSQLEdit.Panel7Resize(Sender: TObject);
begin
 DBGrid1.Columns[0].Width:=Panel7.Width-30;
 Edit1.Width:=Panel7.Width-104;
 cmbTabsNameViews.Width:=Panel7.Width-7;
 DBGrid2.Columns[0].Width:=DBGrid1.Columns[0].Width;
end;

procedure TfSQLEdit.PrepareFrame(Database: TFIBDatabase);

//var Splitter1:TSplitter;

procedure PrepareDataSet(DS:TpFIBDataSet);
begin
   DS.DataBase         :=DataBase;
   DS.Transaction      :=trTransaction;
   DS.UpdateTransaction:=trTransaction;
end;

begin
   FDatabase:=Database;
   if Assigned(Database) then
   begin
     Dialect:=Database.SQLDialect;
     if Database.Connected then
      FCanConnect:=True
     else
     try
      Database.Connected:=True;
      FCanConnect   :=True;
      FConnectForced:=True;
//      Database.Connected:=False
     except
     end;
   end
   else
   begin
    Dialect:=1;
    Panel6.Visible:=False;
    Splitter2.Visible:=False;
    btnCheck.Enabled :=False;
    btnGenSQL.Visible:=False;
   end;
   vParamSymb:=':';
   {$IFDEF USE_SYN_EDIT}

    SynSQLSyn1 :=TSynSQLSyn.Create(Self);
    with SynSQLSyn1 do
    begin
      DefaultFilter:= 'SQL files (*.sql)|*.sql';
      CommentAttri.Foreground := clBlue;
      NumberAttri.Foreground  := clRed ;
      StringAttri.Background  := clInactiveBorder;
      SQLDialect              := sqlInterbase6;
    end;
    viewSQL    :=TSynMemo.Create(Self);
    viewSQL.Highlighter:=SynSQLSyn1;
    viewSQL.Gutter.ShowLineNumbers:=True;
    viewPlan   :=TSynMemo.Create(Self);
    viewPlan.Highlighter:=SynSQLSyn1;

    {$IFNDEF  SYNEDIT_08_2001}
    CompleteProposal:=TSynCompletionProposal.Create(Self);
    CompleteProposal.Editor:=viewSQL;
    CompleteProposal.OnExecute:=CompleteProposalExecute;

    CompleteProposal.ShortCut:=ShortCut(VK_SPACE,[ssCtrl]);
//    CompleteProposal.EndOfTokenChr:='()/*,+-=<> ';
    CompleteProposal.EndOfTokenChr:=')/*,+-=<> ';
    CompleteProposal.Options:=
     CompleteProposal.Options+[scoUsePrettyText,scoUseInsertList,scoUseBuiltInTimer];
    {$ENDIF}
   {$ELSE}
    viewSQL:=TMemo.Create(Self);
    viewSQL.ScrollBars:=ssBoth;
    viewPlan:=TMemo.Create(Self);
    viewPlan.ScrollBars:=ssBoth;
   {$ENDIF}
   OutPutTxt :=viewSQL.Lines;
   with viewSQL do
   begin
     Font.Name:='Courier New';
     Font.Size:=10;
     Parent:=Panel1;
     Align:=alClient;
     SendToBack;

     OnKeyDown:=viewSQLKeyDown;
     OnKeyUp:=viewSQLKeyUp;
     OnMouseUp:=viewSQLMouseUp;
     OnDragOver:=EditorDragOver;
     OnDragDrop:=EditorDragDrop;
   end;
   with viewPlan do
   begin
     Font.Name:='Courier New';
     Font.Size:=10;
     Parent:=Panel1;
     Align:=alBottom;
     SendToBack;
     Visible:=False;
     Height:=80;
     PopupMenu:= menuPlan;
     ReadOnly:=True
   end;


   if FCanConnect then
   begin
     trTransaction.DefaultDatabase :=DataBase;
     PrepareDataSet(qryAllTables);
     PrepareDataSet(qrySPs);
     PrepareDataSet(qrySPparams);
     PrepareDataSet(qryTabFields);
     PrepareDataSet(qrySPFields);
     PrepareDataSet(qryTabFields1);
     PrepareDataSet(qryAllTables1);
     PrepareDataSet(qryAllGenerators)
   end;

  cmbTabsNameViews.Items.Add(SGenSQLView1);
  cmbTabsNameViews.Items.Add(SGenSQLView2);
  cmbTabsNameViews.Items.Add(SGenSQLView3);

  if FCanConnect then
  begin
    cmbTabsNameViews.ItemIndex:=1;
    cmbTabsNameViewsChange(cmbTabsNameViews);
  end
  else
  begin
   cmbTabsNameViews.ItemIndex:=0;
  end;
  cmbKindSQL.ItemIndex:=0;
  DBGrid1.Align:=alTop;
  Splitter1.Height:=3;
  cmbParamSymbol.ItemIndex:=0;
end;

{$IFDEF USE_SYN_EDIT}
{$IFNDEF  SYNEDIT_08_2001}
const
  CMPFORMAT = '\color{clBlue}%s \style{+B}\color{clBlack}%s\style{-B} ';

procedure TfSQLEdit.CompleteProposalExecute(Kind: SynCompletionType;
  Sender: TObject; var CurrentInput: String; var x, y: Integer;
  var CanExecute: Boolean);
var
   AliasName,TableName,FieldName:string;
   PointPos:integer;
   PointBracket:integer;
   PosIn:TSQLSections;
   InFromClause: boolean;
   ObjName:string;
   PosInText:integer;
   ts:TStrings;
   i:integer;
begin
  CompleteProposal.ClearList;
  if FCanConnect then
  begin 
   SetLength(PosIn,0);
   with CompleteProposal.Editor do
   begin
    PosInText:=(CaretX-Length(Lines[CaretY-1]));
    if PosInText>0 then
     PosInText:=SelStart-PosInText
    else
    PosInText:=SelStart ;
    PosIn:=PosInSections(Text,PosInText);
   end;

   InFromClause :=(Length(PosIn)>0) and
    (PosIn[Length(PosIn)-1]=stFrom);
   PointPos:=PosCh('.',CurrentInput);
   if PointPos=0 then
    PointBracket:=PosCh('(',CurrentInput)
   else
    PointBracket:=0;
   if (PointPos=0) and (PointBracket=0) and InFromClause then
   begin
    qryAllTables1.CloseOpen(False);
    if (Length(CurrentInput)>0) and (CurrentInput[1]='"') then
     CurrentInput:=Copy(CurrentInput,2,MaxInt);
    while not qryAllTables1.eof do
    begin
      if (CurrentInput='') or
       (PosCI(CurrentInput,qryAllTables1.Fields[0].AsString)=1)
      then
      begin
       case qryAllTables1.Fields[1].AsInteger of
        0:ObjName:='Table';
        1:ObjName:='View';
        2:ObjName:='Procedure';
       else
         ObjName:='Unknown object'; 
       end;

       if not NeedQuote(qryAllTables1.Fields[0].asString) then
        CompleteProposal.AddItem(
          Format(CMPFORMAT,[ObjName+' :', qryAllTables1.Fields[0].asString])
         ,
            qryAllTables1.Fields[0].asString
        )
       else
        CompleteProposal.AddItem(
          Format(CMPFORMAT,[ObjName+' :','"'+qryAllTables1.Fields[0].asString+'"'])
         ,
           '"'+ qryAllTables1.Fields[0].asString+'"'
        )


      end;

      qryAllTables1.Next;
    end;
   end
   else
   begin
     if PointBracket>0 then
     begin
      if FastUpperCase(Copy(CurrentInput,1,PointBracket-1))='GEN_ID' then
      begin
//         qryAllGenerators.Close;
         qryAllGenerators.Open;
         qryAllGenerators.First;
         while not qryAllGenerators.eof do
         begin
          ObjName:=FormatIdentifier(FDatabase.SQLDialect,qryAllGenerators.Fields[0].asString);
          CompleteProposal.AddItem(
            Format(CMPFORMAT,['Generator :',ObjName])
           ,
              'GEN_ID('+ ObjName+',1)'
          );
          qryAllGenerators.Next
         end;
      end;
     end;
//     else
   // Not in from clause
     if PointPos>0 then
     begin
       FieldName:=Copy(CurrentInput,PointPos+1,MaxInt);
       AliasName:=Copy(CurrentInput,1,PointPos-1);
       TableName:=TableByAlias(viewSQL.Text,AliasName);
       AliasName:=AliasName+'.';
       if (Length(TableName)>0) and (TableName[1]='"') then
        TableName:=Copy(TableName,2,Length(TableName)-2);
     end
     else
     begin
       TableName:='';
       AliasName:='';
       FieldName:=CurrentInput;
     end;
     if AliasName='' then
     begin
      ts:=TStringList.Create;
      try
       AllTables(CompleteProposal.Editor.Text,ts,True);
       for i:=0 to ts.Count-1 do
       begin
         PointPos:=PosCh(' ',ts[i]);
         if PointPos>0 then
          AliasName:=Trim(Copy(ts[i],PointPos+1,MaxInt))+'.'
         else
          AliasName:=Trim(ts[i])+'.';
            

         CompleteProposal.AddItem(
            Format(CMPFORMAT,[' :', ts[i]])
           ,
              AliasName
         );

       end;
      finally
       ts.Free
      end;
     end
     else
     begin
       qryTabFields1.Params[0].asString:=TableName;
       qryTabFields1.CloseOpen(False);
       while not qryTabFields1.eof do
       begin
        if (FieldName='') or
          (PosCI(FieldName, qryTabFields1.Fields[0].asString)=1)
        then
         ObjName:=FormatIdentifier(FDatabase.SQLDialect,qryTabFields1.Fields[0].asString);
         CompleteProposal.AddItem(
            Format(CMPFORMAT,['Field :', ObjName])
           ,
              AliasName+ObjName
         );
         qryTabFields1.Next
       end;
     end;
   end;



  end;

//  CanExecute:=TSynBaseCompletionProposal(Sender).ItemList.Count>0
end;
{$ENDIF}
{$ENDIF}

procedure TfSQLEdit.cmbTabsNameViewsChange(Sender: TObject);
begin
 case cmbTabsNameViews.ItemIndex of
   0:
   begin
    qryAllTables.Close;
    qrySPs.Close;
   end;
   1:
   begin
      qrySPFields.DataSource :=nil;
      qryTabFields.DataSource:=ds;
      ds.DataSet:=qryAllTables;
      ds.DataSet.Open;
      dsFields.DataSet:=qryTabFields;
   end;
   2:
   begin
      qrySPFields.DataSource :=ds;
      qryTabFields.DataSource:=nil;

      ds.DataSet:=qrySPs;
      ds.DataSet.Open;
      dsFields.DataSet:=qrySPFields;      
   end;
 end;
end;

procedure TfSQLEdit.qrySPsFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
 Accept :=true;
 with DataSet do       
  if Trim(Edit1.Text)<>'' then
   Accept :=PosCI(Trim(Edit1.Text),Fields[0].AsString)<>0;
end;

procedure TfSQLEdit.Edit1Change(Sender: TObject);
begin
// qryAllTables.RefreshClientFields
   qryAllTables.RefreshFilters;
   qrySPs.RefreshFilters;
end;

procedure TfSQLEdit.DBGrid1DblClick(Sender: TObject);
begin
 GenTemplate(cmbTabsNameViews.ItemIndex=2,chOnlySelFields.Checked);
end;



function GetLinePosition(SQL:TStrings;Position:integer):integer;
var L:integer;
begin
 Result:=0; L:=0;
 while (L<Position) and (Result<SQL.Count) do
 begin
   L:=L+Length(SQL[Result])+2;
   Inc(Result);
 end;
end;

procedure TfSQLEdit.GenTemplate(IsSP,OnlySelFields: boolean);
var DefSyn:string;
    DefSyn1:string;
    Dest:TStrings;
    DFrom:TPoint;
    SysTab:TFIBDataSet;
    LineFrom:integer;
    fn,pars:string;
    IsExecSP:boolean;
    CurMetaObj:string;
    i,c:integer;
    s:string;
    p,p1:integer;
procedure AddField(const FName:string);
begin
  with Dest do
  begin
      fn:=FormatIdentifier(Dialect,FName);
      if chReplaceSQL.Checked then
       Add(SpaceStr+DefSyn1+fn+',')
      else
      begin
       Dest[LineFrom-1]:=Dest[LineFrom-1]+',';
       Insert(LineFrom,SpaceStr+DefSyn1+fn);
       Inc(LineFrom)
      end;
  end;
end;

procedure AddUpdateField(const FName:string);
begin
  with Dest do
  begin
      fn:=FormatIdentifier(Dialect,FName);
      Add(SpaceStr+fn+'='+vParamSymb+fn+',')
  end;
end;

begin
 LineFrom:=0;
 if DBGrid1.DataSource.DataSet.FieldCount=0 then Exit;
 CurMetaObj:=DBGrid1.DataSource.DataSet.Fields[0].asString;
 if LbTableSyn.Checked and (cmbKindSQL.ItemIndex=0)  then
 begin
   DefSyn:=FormatIdentifier(FDatabase.SQLDialect, Copy(CurMetaObj,1,3));
   if not InputQuery('Enter alias for table :'+CurMetaObj,'',DefSyn) then
    DefSyn:=''
 end
 else
  DefSyn:='';
 if DefSyn<>'' then
  DefSyn1:=DefSyn+'.'
 else
  DefSyn1:='';
 Dest:=OutPutTxt;
 if chReplaceSQL.Checked then Dest.Clear;
 if isSP then SysTab:=qrySPparams else SysTab:=qryTabFields;
 with SysTab,Dest do
 begin
{   if Params[0].AsString<>CurMetaObj then
   begin
    Params[0].AsString :=CurMetaObj;
    Close;    Open;
   end;
 }
   if Params.ByName['NAME'].AsString<>CurMetaObj then
   begin
    Params.ByName['NAME'].AsString :=CurMetaObj;
    Close;    Open;
   end;
   
   if RecordCount=0 then
   begin
    if isSP then
    begin
     Add('EXECUTE PROCEDURE '+ FormatIdentifier(Dialect,CurMetaObj));
    end;
    Exit;
   end;

   IsExecSP:=IsSP and ((Fields[2].asInteger=0) or (cmbKindSQL.ItemIndex=4));
   if IsExecSP then
   begin
     Add('EXECUTE PROCEDURE '+ FormatIdentifier(Dialect,CurMetaObj));
     DefSyn:=' ';
   end;
   if (chReplaceSQL.Checked) or (cmbKindSQL.ItemIndex<>0) then
   begin
    if not IsExecSP then
    case cmbKindSQL.ItemIndex of
     0:Add('SELECT');
     1:
     begin
       DefSyn:='';
       Add('INSERT INTO '+FormatIdentifier(Dialect,CurMetaObj)+' (');
     end;

     2:Add('UPDATE '+FormatIdentifier(Dialect,CurMetaObj)+' SET ');
     3:Add('DELETE FROM '+FormatIdentifier(Dialect,CurMetaObj));
    end;
   end
   else
   begin
    DFrom:=DispositionFrom(Dest.Text);
    if DFrom.X=0 then raise Exception.Create('Clause "FROM" not found')
    else
    begin
     s:=Dest.Text;
     if Copy(s,DFrom.Y-DFrom.X-1,2)<>ForceNewStr then
      Dest.Text:=Copy(s,1,DFrom.X-1)+#13#10+
                Copy(s,DFrom.X,DFrom.Y-DFrom.X)+ForceNewStr+
                Copy(s,DFrom.Y+1,MaxInt)
     else
      Dest.Text:=Copy(s,1,DFrom.X-1)+#13#10+
                Copy(s,DFrom.X,DFrom.Y-DFrom.X)+
                Copy(s,DFrom.Y+1,MaxInt);
     LineFrom:=GetLinePosition(Dest,DFrom.X+2)-1;
    end;
   end;

   if not OnlySelFields then
   begin
     First;
     while not eof and not IsExecSP and (not IsSP or (Fields[2].asInteger<>0)) do
     begin
       case cmbKindSQL.ItemIndex of
        0,1,4: AddField(Fields[0].asString);
        2: AddUpdateField(Fields[0].asString);
       end;
      Next
     end;
   end
   else
   with DBGrid2,DBGrid2.DataSource.DataSet do
   begin
    if SelectedRows.Count>0 then
      for i:=0 to Pred(SelectedRows.Count) do
      begin
        Bookmark:=SelectedRows[i];
       case cmbKindSQL.ItemIndex of
        0,1,4: AddField(Fields[0].asString);
        2: AddUpdateField(Fields[0].asString);
       end;
      end
     else
     begin
       case cmbKindSQL.ItemIndex of
        0,1,4: AddField(Fields[0].asString);
        2: AddUpdateField(Fields[0].asString);
       end;
     end;
   end;
   pars:='';
   if IsSP then
   begin
     //Input SP params
       while not eof  do
       begin
        if Fields[2].asInteger=0 then
        begin
         if pars<>'' then
          pars:=pars+','+ForceNewStr;
          pars:=pars+vParamSymb+Trim(Fields[0].asString);
        end;
        Next
       end;
       if pars<>'' then         
        pars:='('+pars+')';
   end;

   if chReplaceSQL.Checked then
   case cmbKindSQL.ItemIndex of
   0:begin
      Strings[Pred(Count)]:=Copy(Strings[Pred(Count)],1,Length(Strings[Pred(Count)])-1);
      if not IsExecSP then
       Add('FROM');
      Add(SpaceStr+ FormatIdentifier(Dialect,CurMetaObj)+pars+' '+DefSyn)
     end;
   1:begin
      Strings[Pred(Count)]:=Copy(Strings[Pred(Count)],1,Length(Strings[Pred(Count)])-1);
      Add(') VALUES (');
      c:=Count-2;
      for i:=1 to c do
      begin
        Add(SpaceStr+vParamSymb+Trim(Strings[i]));
      end;
      Add(')');
     end;
    2:begin
       Strings[Pred(Count)]:=Copy(Strings[Pred(Count)],1,Length(Strings[Pred(Count)])-1);
       Add('WHERE');

       s:=DBPrimaryKeyFields(CurMetaObj,trTransaction);
       if s<>'' then
       begin
        p1:=1;
        p:=PosCh(';',s);
        while p>0 do
        begin
         pars:=FormatIdentifier(Dialect,Copy(s,p1,p-p1));
         Add(SpaceStr+pars+'='+vParamSymb+pars + ' AND ') ;
         p1:=p+1;
         p:=PosCh1(';',s,p1);
        end;
        pars:=FormatIdentifier(Dialect,Copy(s,p1,Length(s)-p1+1));
        Add(SpaceStr+pars+'='+vParamSymb+pars) ;
       end
       else
       begin
         c:=Count-3;
         for i:=1 to c do
         begin
            Add(Copy(Strings[i],1,Length(Strings[i])-1)+' AND ') ;
         end;
         Add(Strings[c+1]) ;
       end;
      end;
    3:
     begin
       Add('WHERE');
       s:=DBPrimaryKeyFields(CurMetaObj,trTransaction);
       if s<>'' then
       begin
        p1:=1;
        p:=PosCh(';',s);
        while p>0 do
        begin
         pars:=FormatIdentifier(Dialect,Copy(s,p1,p-p1));
         Add(SpaceStr+pars+'='+vParamSymb+pars + ' AND ') ;
         p1:=p+1;
         p:=PosCh1(';',s,p1);
        end;
        pars:=FormatIdentifier(Dialect,Copy(s,p1,Length(s)-p1+1));
        Add(SpaceStr+pars+'='+vParamSymb+pars) ;
       end
     end;
    4:  Add(pars) ;
   end
   else
   begin
    DFrom:=DispositionFrom(Dest.Text);
    LineFrom :=GetLinePosition(Dest,DFrom.Y)-1;
    if (Trim(Dest[LineFrom-1])='') and (Length(Dest[LineFrom-1])>0) then
     Dest[LineFrom-1]:=SpaceStr+ 'JOIN '+
      Trim(FormatIdentifier(Dialect,CurMetaObj))+pars+' '+DefSyn+ ' ON ( )'
    else
    Insert(LineFrom,SpaceStr+ 'JOIN '+
      Trim(FormatIdentifier(Dialect,CurMetaObj))+pars+' '+DefSyn+ ' ON ( )')
   end;
   DeleteEmptyStr(Dest);
 end;
end;

procedure TfSQLEdit.SpeedButton1Click(Sender: TObject);
begin
 with FontDialog1.Font do
 begin
   Name :=viewSQL.Font.Name;
   Size :=viewSQL.Font.Size;
   Color:=viewSQL.Font.Color;
   Style:=viewSQL.Font.Style;
   CharSet:=viewSQL.Font.CharSet;
 end;
 if FontDialog1.Execute then
  viewSQL.Font:=FontDialog1.Font
end;

procedure TfSQLEdit.SpeedButton2Click(Sender: TObject);
begin
 FindDialog1.Execute
end;

procedure TfSQLEdit.FindDialog1Find(Sender: TObject);
begin
  Search(False);
end;

procedure TfSQLEdit.Search(Again:boolean);
var L,p,j:integer;
    curL:integer;
    lv:string;
    sStart:integer;
  {$IFDEF USE_SYN_EDIT}
    CurMemo:TSynMemo;
  {$ELSE}
    CurMemo:TMemo;
  {$ENDIF}
begin
  //Некое подобие поиска.
  L:=0;
  CurMemo:=viewSQL;
  if Again then
   sStart:=CurMemo.SelStart
  else
   sStart:=1;
  with CurMemo do
  for j:=0 to Pred(Lines.Count) do
  begin
    curL:=Length(Lines[j]);
    if (L+curL)<sStart then L:=L+curL+2
    else
    begin
       if (L-1)< sStart then
       begin
     {$IFDEF USE_SYN_EDIT}
        lv:=Copy(Lines[j],sStart+SelEnd   -L,MaxInt);
     {$ELSE}
        lv:=Copy(Lines[j],sStart+SelLength-L,MaxInt);
     {$ENDIF}
        p:=PosCI(FindDialog1.FindText,lv);
     {$IFDEF USE_SYN_EDIT}
        if p>0 then p:=p+sStart+SelEnd-L-1;
     {$ELSE}
        if p>0 then p:=p+sStart+SelLength-L-1;
     {$ENDIF}
       end
       else
       begin
        lv:=Lines[j];
        p:=PosCI(FindDialog1.FindText,lv);
       end;
       if (p=0)  then L:=L+curL+2
       else
       begin
         if L=0 then SelStart :=p-1 else SelStart :=L+p-1;
     {$IFDEF USE_SYN_EDIT}
         SelEnd   :=SelStart+Length(FindDialog1.FindText);
     {$ELSE}
         SelLength:=Length(FindDialog1.FindText);
     {$ENDIF}
         SetFocus;
      {$IFNDEF LINUX}
         FindDialog1.CloseDialog;
      {$ENDIF}
         Exit;
       end;
    end;
  end;
 {$IFNDEF LINUX}
  FindDialog1.CloseDialog;
 {$ENDIF}
end;

procedure TfSQLEdit.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 {$IFDEF MSWINDOWS}
  if Key=VK_RETURN then
 {$ENDIF}
 {$IFDEF LINUX}
   if Key=Key_Return then
 {$ENDIF}
 DBGrid1DblClick(Sender)
end;

procedure TfSQLEdit.ShowEditorStatus;
begin
 if Modified then
  StatusBar1.Panels[0].Text:='Modified';
{$IFDEF USE_SYN_EDIT}
   with viewSQL do
   begin
     StatusBar1.Panels[1].Text:=IntToStr(CaretY)+':'+IntToStr(CaretX);
   end;
{$ELSE}
   with viewSQL.CaretPos do
   begin
     StatusBar1.Panels[1].Text:=IntToStr(Y+1)+':'+IntToStr(X+1);
   end;
{$ENDIF}
end;


procedure TfSQLEdit.viewSQLKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
begin
 ShowEditorStatus
end;

procedure TfSQLEdit.viewSQLMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
begin
 ShowEditorStatus
end;

procedure TfSQLEdit.viewSQLKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 with viewSQL do    
 if ssCtrl in Shift then
  case Chr(Key) of
  'F','f': FindDialog1.Execute;
  'A','a': SelectAll;
  end
 else
 case Key of
  {$IFDEF MSWINDOWS}
   VK_F3:
  {$ELSE}
   Key_F3:
  {$ENDIF}
//   FindDialog1Find(FindDialog1);
    Search(True);
   VK_F11:
   begin
    if FCanConnect then
     ShowHideTemplateSupport;
   end;
 end;
end;


procedure TfSQLEdit.ShowHideTemplateSupport;
begin
    Splitter2.Visible:=not Splitter2.Visible;
    Panel6.Visible:=not Panel6.Visible;
    Splitter2.Left:=Panel6.Left-100;
    btnGenSQL.Visible:=Panel6.Visible
end;

procedure TfSQLEdit.btnGenSQLClick(Sender: TObject);
begin
 DBGrid1DblClick(DBGrid1);
end;

procedure TfSQLEdit.Panel10Resize(Sender: TObject);
begin
 btnGenSQL.Left:=Panel10.Width-btnGenSQL.Width-1
end;

procedure TfSQLEdit.CheckSQL;
var
 qryCheck:TpFIBQuery;
begin
  if (EmptyStrings(OutPutTxt)) or (not FCanConnect) then Exit;
  qryCheck:=TpFIBQuery.Create(Self);
  with qryCheck do
  begin
    Database:=FDatabase;
    Transaction:=trTransaction;
    Options:=[qoStartTransaction,qoNoForceIsNull];
    SQL.Assign(OutPutTxt);
    try
     try
       Prepare;
       viewPlan.Text:=Plan;
     except
      ON E:Exception do
      begin
        viewPlan.Text:=E.Message;
        viewPlan.Lines.Delete(0);
      end;
     end;
    finally
      viewPlan.Visible:=True;
      splPlan.Top:=1;
      splPlan.Visible:=True;
      Free;
    end;
  end;
end;

procedure TfSQLEdit.btnCheckClick(Sender: TObject);
begin
 CheckSQL
end;

procedure TfSQLEdit.miHidePlanClick(Sender: TObject);
begin
   viewPlan.Visible:=False;
   splPlan.Visible:=False;
end;

procedure TfSQLEdit.cmbParamSymbolChange(Sender: TObject);
begin
 if Length(cmbParamSymbol.Text)>0 then
  vParamSymb:=cmbParamSymbol.Text[1];
end;

function TfSQLEdit.GetSQLText: string;
begin
  Result:=viewSQL.Text
end;

procedure TfSQLEdit.SetSQLText(const Value: string);
begin
 viewSQL.Text:=Value;
 viewSQL.Modified:=False;
end;

procedure TfSQLEdit.EditorDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
 Accept:=(Source=DBGrid1) or (Source=DBGrid2)
end;




{$IFDEF USE_SYN_EDIT}
function GetPositionOfMouse(Mem:TSynMemo;out Point: TPoint): Boolean;
begin
  { Get XY caret position of mouse. Returns False if point is outside the
    region of the SynEdit control. }
  with Mem do
  begin
    Result := False;
    GetCursorPos(Point);                    // mouse position (on screen)
    Point := ScreenToClient(Point);    // convert to SynEdit coordinates
    { Make sure it fits within the SynEdit bounds }
    if (Point.X < 0) or (Point.Y < 0) or (Point.X > Width) or (Point.Y> Height) then
      EXIT;

    { inside the eidtor, get the word under the mouse pointer }
{$IFNDEF SYNEDIT_1.3}    
    Point := PixelsToRowColumn(Point); // convert coordinate to LineCol coordinates
{$ELSE}
   with PixelsToRowColumn(Point.X, Point.Y) do
   begin
     Point.X:=Column;
     Point.Y:=Row
   end;
{$ENDIF}    
    Result := True;                         // return that the point was valid
  end;
end;
{$ENDIF}

procedure TfSQLEdit.EditorDragDrop(Sender, Source: TObject; X, Y: Integer);
var
  s,s1:string;
  i:integer;
  {$IFDEF USE_SYN_EDIT}
  p:TPoint;
  diffY:integer;
  {$ENDIF}
begin
  {$IFDEF USE_SYN_EDIT}
   diffY:=0;
  {$ENDIF}
   if not (Source is TDBGrid) then
    Exit;
   with TDBGrid(Source) do
   begin
    if SelectedRows.Count=0 then
    begin
     s :=' '+FormatIdentifier(3,DataSource.DataSet.Fields[0].asString)+' ';
    end
    else
    begin
      if SelectedRows.Count>1 then
      begin
       s1:=' '+FormatIdentifier(3,DataSource.DataSet.Fields[0].asString)+','#13#10;
  {$IFDEF USE_SYN_EDIT}
       Inc(diffY);
  {$ENDIF}
      end
      else
       s1:='';
      s:=' ';
      DataSource.DataSet.DisableControls;
      try
        for i:=0 to Pred(SelectedRows.Count) do
        begin
          TDBGrid(Source).DataSource.DataSet.Bookmark:=SelectedRows[i];
          s:=s+' '+FormatIdentifier(3,DataSource.DataSet.Fields[0].asString)+','#13#10;
  {$IFDEF USE_SYN_EDIT}
          Inc(diffY);
  {$ENDIF}
        end;
        s:=s+s1;
      finally
       DataSource.DataSet.EnableControls;
      end;
    end;
   end;


  {$IFDEF USE_SYN_EDIT}
    GetPositionOfMouse(viewSQL,p);
  {$ELSE}

  {$ENDIF}
{$IFDEF USE_SYN_EDIT}
    if (p.Y<1) then p.Y:=1
    else
    if (p.Y>viewSQL.Lines.Count) then
     p.Y:=viewSQL.Lines.Count;
    viewSQL.Lines[p.Y-1]:=
     Copy(viewSQL.Lines[p.Y-1],1,p.X-1)+s+Copy(viewSQL.Lines[p.Y-1],p.X,MaxInt);
    viewSQL.Text:=viewSQL.Text;
    if diffY>0 then
    begin
    {$IFDEF USE_SYN_EDIT}
      viewSQL.CaretY:=p.Y+diffY-1;
      viewSQL.CaretX:=Length(viewSQL.Lines[viewSQL.CaretY-1])+1;
    {$ELSE}
{      viewSQL.CaretPos:=
       Point(Length(viewSQL.Lines[viewSQL.CaretPos.Y-1])+1,p.Y+diffY-1);}
    {$ENDIF}
    end
    else
    begin
     {$IFDEF USE_SYN_EDIT}
      viewSQL.CaretY:=p.Y;
      viewSQL.CaretX:=P.X+ Length(s);
     {$ELSE}
{      viewSQL.CaretPos:=
       Point(P.X+ Length(s),p.Y);}
     {$ENDIF}
    end;
  {$ENDIF}
    viewSQL.SetFocus
end;

procedure TfSQLEdit.DBGrid1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
//{$IFDEF USE_SYN_EDIT}
 if ssLeft  in Shift then
  TDBGrid(Sender).BeginDrag(False)
//{$ENDIF}
end;


procedure TfSQLEdit.btnReplaceZvClick(Sender: TObject);
var i,j,p:integer;
    s,s1:string;
    Alias,RelTable:string;
    dsShablon:TpFIBDataSet;
begin
 if FCanConnect then
 begin
   dsShablon:=TpFIBDataSet.Create(Self);
   try
     dsShablon.Database:=FDatabase;
     dsShablon.Transaction:=trTransaction;
     dsShablon.PrepareOptions:=[];
     s1:=viewSQL.Text;s:='';
     p:=PosCh('*',s1);
     if p=0 then Exit;
     while p<>0 do
     begin
      if (p>1) and (s1[p-1]='/') then
      begin
       p:=PosInRight('*',s1,p+1);
       Continue
      end;
      if (p<Length(s1)) and (s1[p+1]='/') then
      begin
       p:=PosInRight('*',s1,p+1);
       Continue
      end;

      j:=p-1;
      while (j>0) and (s1[j] in [' ',#9,#13,#10]) do Dec(j);
      RelTable:='';Alias:='';
      if (j>0) and (s1[j]='.') then
      begin
       while (j>0) and (s1[j] in [' ',#9,#13,#10,'.']) do
        Dec(j);
       while (j>0) and not (s1[j] in [' ',#9,#13,#10,'.']) do
       begin
        Alias:=s1[j]+Alias;
        Dec(j);
       end;
       RelTable:=TableByAlias(viewSQL.Text,Alias);
      end;
      s:=s+Copy(s1,1,j);
      if LastChar(s)<>#10 then s:=s+#13#10#9;
      with  dsShablon do
      begin
       Close; SelectSQL.Text:=viewSQL.Text;
       Open;
       for i :=0  to Pred(FieldCount) do
       begin
         if (RelTable='') or
          (GetRelationTableName(Fields[i])=FastUpperCase(RelTable))
         then
         begin
          if Alias<>'' then
           s:=s+Alias+'.'+ FormatIdentifier(3,GetRelationFieldName(Fields[i]))
          else
           s:=s+
            FormatIdentifier(3,GetRelationTableName(Fields[i]))+'.'+
            FormatIdentifier(3,GetRelationFieldName(Fields[i]));
          if i<FieldCount-1 then s:=s+','+#13#10#9;
         end;
       end;
      end;
      s1:=Copy(s1,p+1,MaxInt);
      p:=Pos('*',s1);
     end;
     j:=1; p:=Length(s1);
     while (j<=p) and  (s1[j]in [' ',#13,#9,#10]) do Inc(j);
     s1:=Copy(s1,j,100000);
     if (LastChar(s)<>#10) then s:=s+#13#10;
     s:=s+s1;
     viewSQL.Text:=s;
   finally
     dsShablon.Free;
   end;
 end;
end;

destructor TfSQLEdit.Destroy;
begin
  if FConnectForced  then    
   FDatabase.Connected:=False  ;
  inherited;
end;


function StrToFontStyle(const Str:String):TFontStyles;
begin
  Result:=[];
  if Pos('fsBold',Str)>0 then Include( Result, fsBold  );
  if Pos('fsItalic',Str)>0 then Include( Result, fsItalic  );
  if Pos('fsUnderline',Str)>0 then Include( Result, fsUnderline  );
  if Pos('fsStrikeOut',Str)>0 then Include( Result, fsStrikeOut  );
end;



procedure TfSQLEdit.ReadOptions;
{$IFNDEF NO_REGISTRY}
var v:Variant;
    i:integer;
{$ENDIF}
begin

{$IFNDEF NO_REGISTRY}
 v:=
  DefReadFromRegistry(['Software',RegFIBRoot,RegFIBSQLEdOptions],
   [
    'FontName',
    'FontSize',
    'FontColor',
    'FontStyle',
    'FontCharSet',
    'DoReplaceSQL',
    'UseOnlySelectedFields',
    'UseTableAlias',
    'ParamSymbol',
    'AssistantWidth',
    'TableListHeigth'
   ]
 );
 if (VarType(v)<>varBoolean) then
  for i:=0 to  10 do
   if V[1,i] then
   case i of
    0:viewSQL.Font.Name   :=V[0,i];
    1:viewSQL.Font.Size   :=V[0,i];
    2:viewSQL.Font.Color  :=V[0,i];
    3:viewSQL.Font.Style  :=StrToFontStyle(V[0,i]);
    4:viewSQL.Font.CharSet:=V[0,i];
    5:chReplaceSQL.Checked:=V[0,i];
    6:chOnlySelFields.Checked:=V[0,i];
    7:LbTableSyn.Checked :=V[0,i];
    8:cmbParamSymbol.Text:=V[0,i];
    9:Panel6.Width       :=V[0,i];
    10:DBGrid1.Height    :=v[0,i];
   end;
{$ENDIF}

end;

function FontStyleToStr(Font:TFont):string;
begin
  Result:='[';
  if fsBold in Font.Style then Result:= Result+'fsBold,';
  if fsItalic in Font.Style then Result:= Result+'fsItalic,';
  if fsUnderline in Font.Style then Result:= Result+'fsUnderline,';
  if fsStrikeOut in Font.Style then Result:= Result+'fsStrikeOut';
  if Result[Length( Result )]=',' then
   Result[Length( Result )]:=']'
  else
   Result:= Result+']'
end;

procedure TfSQLEdit.SaveOptions;
begin
{$IFNDEF NO_REGISTRY}
 DefWriteToRegistry(['Software',RegFIBRoot,RegFIBSQLEdOptions],
   [
    'FontName',
    'FontSize',
    'FontColor',
    'FontStyle',
    'FontCharSet',
    'DoReplaceSQL',
    'UseOnlySelectedFields',
    'UseTableAlias',
    'ParamSymbol',
    'AssistantWidth',
    'TableListHeigth'
   ],
   [viewSQL.Font.Name,
    viewSQL.Font.Size,
    viewSQL.Font.Color,
    FontStyleToStr(viewSQL.Font),
    Font.CharSet,
    chReplaceSQL.Checked,
    chOnlySelFields.Checked,
    LbTableSyn.Checked,
    cmbParamSymbol.Text,
    Panel6.Width,
    DBGrid1.Height
   ]
 );
{$ENDIF}
end;

procedure TfSQLEdit.qryTabFieldsBeforeOpen(DataSet: TDataSet);
begin
  DBGrid2.SelectedRows.Clear;
  if FDatabase.IsFirebirdConnect then
  begin
   case FExistField_ForPrecision of
    0: begin
         if FDatabase.QueryValue('  SELECT Count(*)   FROM RDB$RELATION_FIELDS WHERE  RDB$FIELD_NAME='+
         '''RDB$FIELD_PRECISION''   and RDB$RELATION_NAME=''RDB$FIELDS''',0)=0 then
          FExistField_ForPrecision:=2
         else
          FExistField_ForPrecision:=1;
         if FExistField_ForPrecision=1 then
          qryTabFields.ParamByName('PREC').asString:='F.rdb$field_precision'
         else
          qryTabFields.ParamByName('PREC').AsString:=qryTabFields.ParamByName('PREC').DefMacroValue
       end;
    1: qryTabFields.ParamByName('PREC').asString:='F.rdb$field_precision'
   else
    qryTabFields.ParamByName('PREC').AsString:=qryTabFields.ParamByName('PREC').DefMacroValue
   end
  end
  else
   qryTabFields.ParamByName('PREC').AsString:=qryTabFields.ParamByName('PREC').DefMacroValue
end;


procedure TfSQLEdit.btnShowInCodeEditorClick(Sender: TObject);
var
  Form:TComponent;
begin
 if not Assigned(StringsToCodeEditor) then
  Exit;
 with StringsToCodeEditor do
 begin
   Form:=Owner;
   while (Form<>nil) and not (Form is TForm) do
    Form:=Form.Owner;
   if (Form<>nil) and (Form is TForm) then
    TForm(Form).ModalResult:=mrYes;
   if not(vEdComponent.Owner is TFIBDataSet) then
    ICreatePropInCode(vEdComponent,'SQL',viewSQL.Lines,GetModified)
   else
   begin
     if vEdComponent= TFIBDataSet(vEdComponent.Owner).QSelect then
      ICreatePropInCode(vEdComponent.Owner,'SelectSQL',viewSQL.Lines,GetModified)
     else
     if vEdComponent= TFIBDataSet(vEdComponent.Owner).QInsert then
      ICreatePropInCode(vEdComponent.Owner,'InsertSQL',viewSQL.Lines,GetModified)
     else
     if vEdComponent= TFIBDataSet(vEdComponent.Owner).QUpdate then
      ICreatePropInCode(vEdComponent.Owner,'UpdateSQL',viewSQL.Lines,GetModified)
     else
     if vEdComponent= TFIBDataSet(vEdComponent.Owner).QDelete then
      ICreatePropInCode(vEdComponent.Owner,'DeleteSQL',viewSQL.Lines,GetModified)
     else
     if vEdComponent= TFIBDataSet(vEdComponent.Owner).QRefresh then
      ICreatePropInCode(vEdComponent.Owner,'RefreshSQL',viewSQL.Lines,GetModified);
   end;
 end;
end;

function TfSQLEdit.GetModified: boolean;
begin
 {$IFDEF USE_SYN_EDIT}
  Result:=Trim(vEdComponent.SQL.Text)<>viewSQL.Lines.Text
 {$ELSE}
   Result:=vEdComponent.SQL.Text<>viewSQL.Lines.Text
 {$ENDIF}
end;

procedure TfSQLEdit.qryTabFieldsAfterScroll(DataSet: TDataSet);
var
   s:string;
   prec:string;
begin
 with Dataset do
 case FieldByName('RDB$FIELD_TYPE').asInteger of
  7 : s:='SMALL';
  8 : if FieldByName('RDB$FIELD_SCALE').asInteger=0 then
       s:='INTEGER'
      else
      begin
       s:='NUMERIC';
       if FieldByName('rdb$field_precision').asInteger=0 then
        prec:='9'
       else
        prec:=FieldByName('rdb$field_precision').asString;
       s:=s+'('+prec+','+IntToStr(-FieldByName('RDB$FIELD_SCALE').asInteger)+')';
      end;
  12: s:='DATE';
  13: s:='TIME';
  14: s:='CHAR('+FieldByName('RDB$FIELD_LENGTH').asString+')';
  16:
  begin
   if (FieldByName('RDB$FIELD_SUB_TYPE').asInteger=0) and
      (FieldByName('RDB$FIELD_SCALE').asInteger=0)
   then
      s:='BIGINT'
   else
   begin
     s:='NUMERIC';
     if FieldByName('rdb$field_precision').asInteger=0 then
      prec:='18'
     else
      prec:=FieldByName('rdb$field_precision').asString;

     if (FieldByName('RDB$FIELD_SCALE').asInteger=0) then
      s:=s+'('+prec+',0)'
     else
      s:=s+'('+prec+','+IntToStr(-FieldByName('RDB$FIELD_SCALE').asInteger)+')';
   end;
  end;
  27: if FieldByName('RDB$FIELD_SCALE').asInteger=0 then
       s:='DOUBLE PRECISION'
      else
      begin
       s:='NUMERIC';
       if FieldByName('rdb$field_precision').asInteger=0 then
        prec:='15'
       else
        prec:=FieldByName('rdb$field_precision').asString;
       s:=s+'('+prec+','+IntToStr(-FieldByName('RDB$FIELD_SCALE').asInteger)+')';
      end;
  35: s:='TIMESTAMP';
  37: s:='VARCHAR('+FieldByName('RDB$FIELD_LENGTH').asString+')';
  261: if FieldByName('RDB$FIELD_SUB_TYPE').asInteger=2 then
        s:='Text'
       else
        s:='BLOB';
 else
  s:=''
 end;
 edFieldType.Text:=s;
end;

procedure TfSQLEdit.qrySPFieldsAfterOpen(DataSet: TDataSet);
begin
 edFieldType.Text:=''
end;

end.
