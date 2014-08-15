unit UHelp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  {$IFDEF FPC} LResources,{$ENDIF}
  Dialogs, StdCtrls;

type
  TFHelp = class(TForm)
    Memo1: TMemo;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$IFNDEF FPC}
{$R *.dfm}
{$ENDIF}
{$IFDEF FPC}
initialization
{$I UHelp.lrs}
{$ENDIF}

end.
