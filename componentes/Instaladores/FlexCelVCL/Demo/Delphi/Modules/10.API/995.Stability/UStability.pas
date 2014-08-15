unit UStability;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  {$IFDEF FPC} LResources,{$ENDIF}
  Dialogs, UExcelAdapter, XLSAdapter, UFlexCelImport, StdCtrls, UFlxFormats,
  ImgList, ActnList, ComCtrls, ToolWin;

type
  TFStability = class(TForm)
    Fi: TFlexCelImport;
    XLSAdapter1: TXLSAdapter;
    Memo1: TMemo;
    MainToolBar: TToolBar;
    ToolButton2: TToolButton;
    MenuCommands: TActionList;
    ActionRun: TAction;
    ToolbarImages: TImageList;
    ToolbarImagesH: TImageList;
    ToolbarImagesD: TImageList;
    ToolButton1: TToolButton;
    ActionClose: TAction;
    ToolButton3: TToolButton;
    procedure ActionRunExecute(Sender: TObject);
    procedure ActionCloseExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FStability: TFStability;

implementation

{$IFNDEF FPC}
{$R *.dfm}
{$ENDIF}

procedure TFStability.ActionCloseExecute(Sender: TObject);
begin
  Close;
end;

procedure TFStability.ActionRunExecute(Sender: TObject);
var
  i: integer;
  {$warnings off} // We don't really want to use the net GetMemoryManagerState methods, since they won't work in older delphi.
    h:  THeapStatus;
  {$warnings on}
    lam: int64;
    fam: int64;

  f:TFlxFormat;
  fmt: integer;
begin
  ActionRun.Enabled := false;
  try
  ActionClose.Enabled := false;
  try
    Memo1.Lines.Clear;
    lam:=0;fam:=-1;
    try
      for i:=0 to 5000 do
      begin
        Fi.OpenFile('Test.xls');
        Fi.CellValue[1,1]:='Hi from flexcel';
        Fi.CellFormula[2,1]:='=1+2';

        Fi.GetDefaultFormat(f);
        f.Font.Name:='Arial';
        f.Font.ColorIndex:=Fi.NearestColorIndex(clred);
        f.FillPattern.FgColorIndex:=Fi.NearestColorIndex(clBlue);
        f.FillPattern.Pattern:= 2;
        fmt:=Fi.AddFormat(f);

        Fi.CellFormat[1,1]:=fmt;

        Fi.Save('Test2.xls');

        if i mod 50 = 0 then
        begin
          {$warnings off} // We don't really want to use the net GetMemoryManagerState methods, since they won't work in older delphi.
          h:=GetHeapStatus;
          {$warnings on}
          if fam=-1 then fam:=h.TotalAllocated;
          Memo1.Lines.Add('Pass: '+IntToStr(i)+' ----- Memory used: '+IntToStr(h.TotalAllocated)+'     ---  Free: '+inttostr(h.TotalFree)+  '    ----- Difference: '+IntToStr(h.TotalAllocated-lam)+  '    ----- Total Diff: '+IntToStr(h.TotalAllocated-fam));
          lam:=h.TotalAllocated;
          Application.ProcessMessages;
        end;
      end;
    finally
      Fi.CloseFile; //Unload file from memory.
    end;
  finally
    ActionClose.Enabled := true;
  end;
  finally
    ActionRun.Enabled := true;
  end;
  ShowMessage('Finished');
end;
{$IFDEF FPC}
initialization
{$I UStability.lrs}
{$ENDIF}

end.
