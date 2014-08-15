unit pascalform;

{This is just an example of how to load DFM files from scripter.
 This unit is not needed, only the dfm file is used.
 DO NOT use events or the form will not be loaded.}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TfmPascalForm = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

end.
