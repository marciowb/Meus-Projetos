{***************************************************************************}
{ This source code was generated automatically by                           }
{ Pas file import tool for Scripter Studio (Pro)                            }
{                                                                           }
{ Scripter Studio and Pas file import tool for Scripter Studio              }
{ written by TMS Software                                                   }
{            copyright © 1997 - 2010                                        }
{            Email : info@tmssoftware.com                                   }
{            Web : http://www.tmssoftware.com                               }
{***************************************************************************}
unit ap_Dlgs;

interface

uses
  Dlgs,
  atScript;

{$WARNINGS OFF}

type
  TatDlgsLibrary = class(TatScripterLibrary)
    procedure Init; override;
    class function LibraryName: string; override;
  end;



  tagCRGBWrapper = class(TatRecordWrapper)
  private
    FbRed: BYTE;
    FbGreen: BYTE;
    FbBlue: BYTE;
    FbExtra: BYTE;
  public
    constructor Create(ARecord: tagCRGB);
    function ObjToRec: tagCRGB;
  published
    property bRed: BYTE read FbRed write FbRed;
    property bGreen: BYTE read FbGreen write FbGreen;
    property bBlue: BYTE read FbBlue write FbBlue;
    property bExtra: BYTE read FbExtra write FbExtra;
  end;
  

implementation

constructor tagCRGBWrapper.Create(ARecord: tagCRGB);
begin
  inherited Create;
  FbRed := ARecord.bRed;
  FbGreen := ARecord.bGreen;
  FbBlue := ARecord.bBlue;
  FbExtra := ARecord.bExtra;
end;

function tagCRGBWrapper.ObjToRec: tagCRGB;
begin
  result.bRed := FbRed;
  result.bGreen := FbGreen;
  result.bBlue := FbBlue;
  result.bExtra := FbExtra;
end;



procedure TatDlgsLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    AddConstant('ctlFirst',ctlFirst);
    AddConstant('ctlLast',ctlLast);
    AddConstant('psh1',psh1);
    AddConstant('psh2',psh2);
    AddConstant('psh3',psh3);
    AddConstant('psh4',psh4);
    AddConstant('psh5',psh5);
    AddConstant('psh6',psh6);
    AddConstant('psh7',psh7);
    AddConstant('psh8',psh8);
    AddConstant('psh9',psh9);
    AddConstant('psh10',psh10);
    AddConstant('psh11',psh11);
    AddConstant('psh12',psh12);
    AddConstant('psh13',psh13);
    AddConstant('psh14',psh14);
    AddConstant('psh15',psh15);
    AddConstant('pshHelp',pshHelp);
    AddConstant('psh16',psh16);
    AddConstant('chx1',chx1);
    AddConstant('chx2',chx2);
    AddConstant('chx3',chx3);
    AddConstant('chx4',chx4);
    AddConstant('chx5',chx5);
    AddConstant('chx6',chx6);
    AddConstant('chx7',chx7);
    AddConstant('chx8',chx8);
    AddConstant('chx9',chx9);
    AddConstant('chx10',chx10);
    AddConstant('chx11',chx11);
    AddConstant('chx12',chx12);
    AddConstant('chx13',chx13);
    AddConstant('chx14',chx14);
    AddConstant('chx15',chx15);
    AddConstant('chx16',chx16);
    AddConstant('rad1',rad1);
    AddConstant('rad2',rad2);
    AddConstant('rad3',rad3);
    AddConstant('rad4',rad4);
    AddConstant('rad5',rad5);
    AddConstant('rad6',rad6);
    AddConstant('rad7',rad7);
    AddConstant('rad8',rad8);
    AddConstant('rad9',rad9);
    AddConstant('rad10',rad10);
    AddConstant('rad11',rad11);
    AddConstant('rad12',rad12);
    AddConstant('rad13',rad13);
    AddConstant('rad14',rad14);
    AddConstant('rad15',rad15);
    AddConstant('rad16',rad16);
    AddConstant('grp1',grp1);
    AddConstant('grp2',grp2);
    AddConstant('grp3',grp3);
    AddConstant('grp4',grp4);
    AddConstant('frm1',frm1);
    AddConstant('frm2',frm2);
    AddConstant('frm3',frm3);
    AddConstant('frm4',frm4);
    AddConstant('rct1',rct1);
    AddConstant('rct2',rct2);
    AddConstant('rct3',rct3);
    AddConstant('rct4',rct4);
    AddConstant('ico1',ico1);
    AddConstant('ico2',ico2);
    AddConstant('ico3',ico3);
    AddConstant('ico4',ico4);
    AddConstant('stc1',stc1);
    AddConstant('stc2',stc2);
    AddConstant('stc3',stc3);
    AddConstant('stc4',stc4);
    AddConstant('stc5',stc5);
    AddConstant('stc6',stc6);
    AddConstant('stc7',stc7);
    AddConstant('stc8',stc8);
    AddConstant('stc9',stc9);
    AddConstant('stc10',stc10);
    AddConstant('stc11',stc11);
    AddConstant('stc12',stc12);
    AddConstant('stc13',stc13);
    AddConstant('stc14',stc14);
    AddConstant('stc15',stc15);
    AddConstant('stc16',stc16);
    AddConstant('stc17',stc17);
    AddConstant('stc18',stc18);
    AddConstant('stc19',stc19);
    AddConstant('stc20',stc20);
    AddConstant('stc21',stc21);
    AddConstant('stc22',stc22);
    AddConstant('stc23',stc23);
    AddConstant('stc24',stc24);
    AddConstant('stc25',stc25);
    AddConstant('stc26',stc26);
    AddConstant('stc27',stc27);
    AddConstant('stc28',stc28);
    AddConstant('stc29',stc29);
    AddConstant('stc30',stc30);
    AddConstant('stc31',stc31);
    AddConstant('stc32',stc32);
    AddConstant('lst1',lst1);
    AddConstant('lst2',lst2);
    AddConstant('lst3',lst3);
    AddConstant('lst4',lst4);
    AddConstant('lst5',lst5);
    AddConstant('lst6',lst6);
    AddConstant('lst7',lst7);
    AddConstant('lst8',lst8);
    AddConstant('lst9',lst9);
    AddConstant('lst10',lst10);
    AddConstant('lst11',lst11);
    AddConstant('lst12',lst12);
    AddConstant('lst13',lst13);
    AddConstant('lst14',lst14);
    AddConstant('lst15',lst15);
    AddConstant('lst16',lst16);
    AddConstant('cmb1',cmb1);
    AddConstant('cmb2',cmb2);
    AddConstant('cmb3',cmb3);
    AddConstant('cmb4',cmb4);
    AddConstant('cmb5',cmb5);
    AddConstant('cmb6',cmb6);
    AddConstant('cmb7',cmb7);
    AddConstant('cmb8',cmb8);
    AddConstant('cmb9',cmb9);
    AddConstant('cmb10',cmb10);
    AddConstant('cmb11',cmb11);
    AddConstant('cmb12',cmb12);
    AddConstant('cmb13',cmb13);
    AddConstant('cmb14',cmb14);
    AddConstant('cmb15',cmb15);
    AddConstant('cmb16',cmb16);
    AddConstant('edt1',edt1);
    AddConstant('edt2',edt2);
    AddConstant('edt3',edt3);
    AddConstant('edt4',edt4);
    AddConstant('edt5',edt5);
    AddConstant('edt6',edt6);
    AddConstant('edt7',edt7);
    AddConstant('edt8',edt8);
    AddConstant('edt9',edt9);
    AddConstant('edt10',edt10);
    AddConstant('edt11',edt11);
    AddConstant('edt12',edt12);
    AddConstant('edt13',edt13);
    AddConstant('edt14',edt14);
    AddConstant('edt15',edt15);
    AddConstant('edt16',edt16);
    AddConstant('scr1',scr1);
    AddConstant('scr2',scr2);
    AddConstant('scr3',scr3);
    AddConstant('scr4',scr4);
    AddConstant('scr5',scr5);
    AddConstant('scr6',scr6);
    AddConstant('scr7',scr7);
    AddConstant('scr8',scr8);
    AddConstant('FILEOPENORD',FILEOPENORD);
    AddConstant('MULTIFILEOPENORD',MULTIFILEOPENORD);
    AddConstant('PRINTDLGORD',PRINTDLGORD);
    AddConstant('PRNSETUPDLGORD',PRNSETUPDLGORD);
    AddConstant('FINDDLGORD',FINDDLGORD);
    AddConstant('REPLACEDLGORD',REPLACEDLGORD);
    AddConstant('FONTDLGORD',FONTDLGORD);
    AddConstant('FORMATDLGORD31',FORMATDLGORD31);
    AddConstant('FORMATDLGORD30',FORMATDLGORD30);
    AddConstant('PAGESETUPDLGORD',PAGESETUPDLGORD);
    AddConstant('NEWFILEOPENORD',NEWFILEOPENORD);
  end;
end;

class function TatDlgsLibrary.LibraryName: string;
begin
  result := 'Dlgs';
end;

initialization
  RegisterScripterLibrary(TatDlgsLibrary, True);

{$WARNINGS ON}

end.

