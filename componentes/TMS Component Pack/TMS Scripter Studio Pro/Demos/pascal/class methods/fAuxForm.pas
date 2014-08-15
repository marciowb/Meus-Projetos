unit fAuxForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls;

type
  TMyForm = class(TForm)
    Panel1: TPanel;
  private
    { Private declarations }
  public
    { Public declarations }
    constructor CreateAndShow(const ALabel: string);
  end;

var
  MyForm: TMyForm;

implementation

{$R *.DFM}

{ TMyForm }

constructor TMyForm.CreateAndShow(const ALabel: string);
begin
   inherited Create(Application);
   Caption:=ALabel;
   Panel1.Caption:=ALabel;
   Show;
end;

end.
