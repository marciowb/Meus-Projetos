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

unit FIBSQLEditor;

interface

{$I FIBPlus.inc}
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, DB,fraSQLEdit,FIBDatabase,pFIBQuery, ExtCtrls, StdCtrls, Buttons
  {$IFDEF D6+}
   ,Variants
  {$ENDIF}
  ;

type
  TfrmSQLEdit = class(TForm)
    fSQLEdit1: TfSQLEdit;
    Panel1: TPanel;
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    procedure Panel1Resize(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
  public
    { Public declarations }
  end;

var
  frmSQLEdit: TfrmSQLEdit;

  function ShowSQLEdit(aQuery:TpFIBQuery):boolean;

implementation

{$R *.dfm}
uses StdFuncs {SVD}{$IFDEF CODEEDITOR}, ToCodeEditor{$ENDIF};

var
   LastTop, LastLeft,   LastWidth,LastHeight:integer;



function ShowSQLEdit(aQuery:TpFIBQuery):boolean;
begin
    frmSQLEdit:= TfrmSQLEdit.Create(Application);
    with frmSQLEdit do
    begin
     fSQLEdit1.PrepareFrame(aQuery.Database);
     fSQLEdit1.ReadOptions;
     fSQLEdit1.SQLText:=aQuery.SQL.Text;
     fSQLEdit1.vEdComponent:=aQuery;
     Caption:='SQL edit :'+CmpFullName(aQuery);
     if   LastTop>-1 then
     begin
         Top :=LastTop;
         Left:=LastLeft;
         Width :=LastWidth;
         Height:=LastHeight;
     end;
     Result:=ShowModal = mrOk;
     if Result then
      aQuery.SQL.Text:=fSQLEdit1.SQLText;
     Free
    end;
end;

procedure TfrmSQLEdit.Panel1Resize(Sender: TObject);
begin
 btnCancel.Left:=Panel1.Width-80;
 btnOK.Left    :=btnCancel.Left-btnOK.Width-5;
end;

procedure TfrmSQLEdit.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 LastTop   :=Top;
 LastLeft  :=Left;
 LastWidth :=Width;
 LastHeight:=Height;
 fSQLEdit1.SaveOptions;
end;

initialization
  LastTop:=-1;

end.
