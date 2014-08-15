unit fSimplifiedCode;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, atScript, atParser, TypInfo;

type
  TfmSimplifiedCode = class(TForm)
    ListView1: TListView;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure BuildSimplifiedCodeListView( AScript: TatScript );
  end;

procedure pCodeViewDlg( AScripter: TatCustomScripter );
procedure CodeView( AScript: TatScript );

implementation

{$R *.DFM}

procedure pCodeViewDlg( AScripter: TatCustomScripter );
begin
   With TfmSimplifiedCode.Create(Application) do
   try
      BuildSimplifiedCodeListView( AScripter.CurrentScript );
      ShowModal;
   finally
      Free;
   end;
end;

procedure CodeView( AScript: TatScript );
begin
   With TfmSimplifiedCode.Create(Application) do
   try
      BuildSimplifiedCodeListView( AScript );
      ShowModal;
   finally
      Free;
   end;
end;

procedure TfmSimplifiedCode.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if word(key)=VK_ESCAPE then Close;
end;

procedure TfmSimplifiedCode.BuildSimplifiedCodeListView( AScript: TatScript );
var line      : pSimplifiedCode;
    c,row,col : integer;
begin
   if not AScript.ExpandedDebugInfo then
      AScript.ExpandDebugInfo;
   with ListView1 do
   begin
      Items.BeginUpDate;
      Items.Clear;
      line:=AScript.FirstInstruction;
      c:=0;
      while line<>nil do
      begin
         with Items.Add do
         begin
            Caption:=Format('$%X',[c]);
            SubItems.Add( copy(GetEnumName(TypeInfo(TInstruction),ord(line.OpCode)),3,MaxInt) );
            SubItems.Add( Format('$%X',[line.vInteger]) );
            SubItems.Add( IntToStr(line.vByte) );
            if line.OpCode=inPushDouble then
               SubItems.Add( FloatToStr(line.vDouble) )
            else
               SubItems.Add( Format('$%X, $%X',[line.vInteger2,line.vInteger3]) );
            SubItems.Add( line.vString );
            if AScript.Parser.Strings.Count=0 then
               SubItems.Add( Format('%d (no source)',[line.vDebugInfo]) )
            else
            begin
//             GetRowColFromSource(line.vDebugInfo,row,col);
               row:=line.vDebugInfo and $FFFFF;
               col:=line.vDebugInfo shr 20;
               SubItems.Add( Format('%d, %d',[row,col]) );
            end;
            if line.vInteger1>0 then SubItems.Add(inttostr(line.vInteger1));
         end;
         line:=line^.Next;
         inc(c);
      end;
      Items.EndUpDate;
   end;
end;

end.
