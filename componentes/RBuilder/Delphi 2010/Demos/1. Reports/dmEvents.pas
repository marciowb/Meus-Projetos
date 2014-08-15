{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2001                    BBBBB   }

unit dmEvents;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ppPrnabl, ppClass, ppCtrls, ppBands, ppCache, ppDB, ppDBBDE, ppComm,
  ppProd, ppReport, Db, DBTables, StdCtrls, ppTypes, ExtCtrls;

type
  TfrmEvents = class(TForm)
    ListBox1: TListBox;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    procedure FormCreate(Sender: TObject);
  private
    FEventCounter: Integer;
  public
    procedure Clear;
    procedure AddEvent(const aDesc: String);
  end;

var
  frmEvents: TfrmEvents;

implementation

{$R *.DFM}

procedure TfrmEvents.Clear;
begin
  ListBox1.Items.Clear;
  FEventCounter := 0;
end;

procedure TfrmEvents.AddEvent(const aDesc: String);
begin
  Inc(FEventCounter);

  ListBox1.Items.Add(IntToStr(FEventCounter) + '  ' + aDesc);

  ListBox1.ItemIndex := ListBox1.Items.Count - 1;
end;



procedure TfrmEvents.FormCreate(Sender: TObject);
begin
  Clear;
  Left := Application.MainForm.Left;
  Top := Application.MainForm.Top;
end;

end.
