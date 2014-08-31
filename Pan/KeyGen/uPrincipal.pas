unit uPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, JvComponentBase, JvComputerInfoEx, JvSerialMaker, Mask,
  ExtCtrls;


type
  TForm1 = class(TForm)
    Button1: TButton;
    Computer: TJvComputerInfoEx;
    EdtSerial: TMaskEdit;
    Serial: TJvSerialMaker;
    edtString: TLabeledEdit;
    Label1: TLabel;
    Button2: TButton;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

  end;

var
  Form1: TForm1;

implementation

uses HD;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
 Sn : String;
begin
  Sn := edtString.Text;
  EdtSerial.Text := Serial.GiveSerial(10,Sn)
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  EdtSerial.CopyToClipboard;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  edtString.PasteFromClipboard;
end;

end.
