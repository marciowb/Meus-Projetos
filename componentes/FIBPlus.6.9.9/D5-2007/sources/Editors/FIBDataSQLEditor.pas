{***************************************************************}
{ FIBPlus - component library for direct access to Firebird and }
{ Interbase databases                                           }
{                                                               }
{    FIBPlus is based in part on the product                    }
{    Free IB Components, written by Gregory H. Deatz for        }
{    Hoagland, Longo, Moran, Dunst & Doukas Company.            }
{    mailto:gdeatz@hlmdd.com                                    }
{                                                               }
{    Copyright (c) 1998-2004 Serge Buzadzhy                     }
{    Contact: buzz@devrace.com                                  }
{                                                               }
{ ------------------------------------------------------------- }
{    FIBPlus home page      : http://www.fibplus.net/           }
{    FIBPlus support e-mail : fibplus@devrace.com               }
{ ------------------------------------------------------------- }
{                                                               }
{  Please see the file License.txt for full license information }
{***************************************************************}

unit FIBDataSQLEditor;

interface

{$I FIBPlus.inc}
uses
  Windows, Messages, SysUtils, {$IFDEF D6+}Variants, {$ENDIF}Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, fraSQLEdit, ComCtrls,pFIBDataSet,
  fraDSSQLEdit,pFIBProps;

type
  TfrmDstSQLedit = class(TForm)
    Panel1: TPanel;
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    fSQLsEdit: TfDSSQLEdit;
    procedure Panel1Resize(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    procedure ReadOptions;
    procedure SaveOptions;
    procedure SaveFieldsOrigins(aDataSet:TpFIBDataSet);
  public
    { Public declarations }
  end;

var
  frmDstSQLedit: TfrmDstSQLedit;

  function ShowDSSQLsEdit(aDataSet:TpFIBDataSet;var ExitToCodeEditor:integer):boolean;
  function ShowDSSQLEdit(aDataSet:TpFIBDataSet;KindSQL:integer; var ExitToCodeEditor:integer):boolean; overload;
  function ShowDSSQLEdit(aDataSet:TpFIBDataSet;KindSQL:integer ):boolean; overload;  

implementation

{$R *.dfm}
 uses
 {$IFNDEF NO_REGISTRY} RegUtils, {$ENDIF}
 StdFuncs;

var
   LastTop, LastLeft,   LastWidth,LastHeight:integer;

const
   RegFIBSQLEdOptions='SQLEditor';



  function ShowDSSQLEdit(aDataSet:TpFIBDataSet;KindSQL:integer;var ExitToCodeEditor:integer):boolean;
  var
   ForceClose:boolean;
   Modified  :boolean;
  begin
    frmDstSQLedit:= TfrmDstSQLedit.Create(Application);
    with frmDstSQLedit do
    begin
     with fSQLsEdit do
     begin
       vDataSet:=aDataSet;
       PrepareFrame(aDataSet.Database,
         aDataSet.SelectSQL.Text,
         aDataSet.InsertSQL.Text,         
         aDataSet.UpdateSQL.Text,
         aDataSet.DeleteSQL.Text,
         aDataSet.RefreshSQL.Text
       );
     end;
       ReadOptions;
       if   LastTop>-1 then
       begin
         Top :=LastTop;
         Left:=LastLeft;
         Width :=LastWidth;
         Height:=LastHeight;
       end;

     Caption:='SQL edit :'+CmpFullName(aDataSet);
     case KindSQL of
       0: fSQLsEdit.pgCtrl.ActivePage:=fSQLsEdit.shSelect;
     else
      fSQLsEdit.pgCtrl.ActivePage  :=fSQLsEdit.shModifySQLs;
      fSQLsEdit.grSQLKind.ItemIndex:=KindSQL-1
     end;
     Result:=ShowModal in [mrOk,mrYes];
     ExitToCodeEditor:=-1;
     if Result then
     begin
      if ModalResult=mrYes then
      begin
       if fSQLsEdit.pgCtrl.ActivePageIndex=0 then
        ExitToCodeEditor:=0
       else
        ExitToCodeEditor:=fSQLsEdit.grSQLKind.ItemIndex+1;
      end
      else
       ExitToCodeEditor:=-1;
      ForceClose:=aDataSet.Active;
      if ForceClose then
        aDataSet.Close;
      Modified:=aDataSet.SelectSQL.Text<>fSQLsEdit.SelectSQLEdit.SQLText;
      if Modified then
       aDataSet.SelectSQL.Text:=fSQLsEdit.SelectSQLEdit.SQLText;
      if aDataSet.InsertSQL.Text<>fSQLsEdit.FInsertSQL then
      begin
       aDataSet.InsertSQL.Text:=fSQLsEdit.FInsertSQL;
       Modified:=True;
      end;
      if aDataSet.UpdateSQL.Text<>fSQLsEdit.FUpdateSQL then
      begin
       aDataSet.UpdateSQL.Text:=fSQLsEdit.FUpdateSQL;
       Modified:=True;
      end;
      if aDataSet.DeleteSQL.Text<>fSQLsEdit.FDeleteSQL then
      begin
         aDataSet.DeleteSQL.Text:=fSQLsEdit.FDeleteSQL;
         Modified:=True;
      end;
      if aDataSet.RefreshSQL.Text<>fSQLsEdit.FRefreshSQL then
      begin
         aDataSet.RefreshSQL.Text:=fSQLsEdit.FRefreshSQL;
         Modified:=True;
      end;
      Result:=Modified;
      if fSQLsEdit.chFieldOrigin.Checked then
       SaveFieldsOrigins(aDataSet);
      if ForceClose then
       aDataSet.Open;
     end;
     Free
    end;
  end;

function ShowDSSQLsEdit(aDataSet:TpFIBDataSet;var ExitToCodeEditor:integer):boolean;
begin
   Result:= ShowDSSQLEdit(aDataSet,0,ExitToCodeEditor);
end;

function ShowDSSQLEdit(aDataSet:TpFIBDataSet;KindSQL:integer ):boolean;
var
 ExitToCodeEditor:integer;
begin
   Result:= ShowDSSQLEdit(aDataSet,0,ExitToCodeEditor);
end;

procedure TfrmDstSQLedit.Panel1Resize(Sender: TObject);
begin
 btnCancel.Left:=Panel1.Width-80;
 btnOK.Left    :=btnCancel.Left-btnOK.Width-5;
end;




procedure TfrmDstSQLedit.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 LastTop :=Top;
 LastLeft:=Left;
 LastWidth:=Width;
 LastHeight:=Height;
 SaveOptions;
end;



procedure TfrmDstSQLedit.ReadOptions;

{$IFNDEF NO_REGISTRY}
var v:Variant;
    i:integer;
{$ENDIF}
begin
{$IFNDEF NO_REGISTRY}
 v:=
  DefReadFromRegistry(['Software',RegFIBRoot,RegFIBSQLEdOptions],
   ['Top',
    'Left',
    'Height',
    'Width',
    'Origins'
   ]
 );
 if (VarType(v)<>varBoolean) then
  for i:=0 to 4 do
   if V[1,i] then
   case i of
    0: LastTop               :=V[0,i];
    1: LastLeft              :=V[0,i];
    2: LastHeight:=V[0,i];
    3: LastWidth :=V[0,i];
    4: fSQLsEdit.chFieldOrigin.Checked:=V[0,i]
   end;
 fSQLsEdit.ReadOptions;

{$ENDIF}
end;



procedure TfrmDstSQLedit.SaveOptions;
begin
{$IFNDEF NO_REGISTRY}
 DefWriteToRegistry(['Software',RegFIBRoot,RegFIBSQLEdOptions],
   ['Top',
    'Left',
    'Height',
    'Width',
    'Origins'
   ],
   [
    LastTop,
    LastLeft,
    LastHeight,
    LastWidth,
    fSQLsEdit.chFieldOrigin.Checked
   ]
 );
 fSQLsEdit.SaveOptions;
{$ENDIF}


end;

procedure TfrmDstSQLedit.SaveFieldsOrigins(aDataSet:TpFIBDataSet);
var
 i:integer;
begin
 with aDataSet do
 begin
   if DefaultFields or (not Active and (FieldCount=0)) then
    Exit;
   if not Database.Connected then
     Exit;
   for i:=0 to Pred(FieldCount) do
     Fields[i].Origin:=GetFieldOrigin(Fields[i]);
 end;
end;

initialization
  LastTop:=-1;
end.
