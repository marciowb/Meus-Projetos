unit fSyntaxTree;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, atScript, atParser;

type
  TfmSyntaxTree = class(TForm)
    TreeView1: TTreeView;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
  private
    procedure InternalBuildSyntaxTree(AParser: TatSyntaxParser; ATreeView: TTreeView=nil);
    { Private declarations }
  public
    { Public declarations }
    procedure BuildSyntaxTreeView(AScripter:TatCustomScripter);
  end;

procedure SyntaxTreeViewDlg( AScript: TatCustomScripter );
procedure ShowSyntaxTree( AParser: TatSyntaxParser; ATreeView: TTreeView=nil );

implementation

{$R *.DFM}

procedure SyntaxTreeViewDlg( AScript: TatCustomScripter );
begin
   With TfmSyntaxTree.Create(Application) do
   try
      BuildSyntaxTreeView( AScript );
      ShowModal;
   finally
      Free;
   end;
end;

procedure ShowSyntaxTree( AParser: TatSyntaxParser; ATreeView: TTreeView=nil );
begin
   With TfmSyntaxTree.Create(Application) do
   try
      InternalBuildSyntaxTree( AParser, ATreeView );
      if not Assigned(ATreeView) then
        ShowModal;
   finally
      Free;
   end;
end;

procedure TfmSyntaxTree.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if word(key)=VK_ESCAPE then
   begin
      key:=#0;
      Close;
   end;
end;

procedure TfmSyntaxTree.FormShow(Sender: TObject);
begin
   with TreeView1 do
      if Items.Count>0 then
         Selected:=Items[0];
end;

procedure TfmSyntaxTree.BuildSyntaxTreeView(AScripter:TatCustomScripter);
begin
  InternalBuildSyntaxTree(AScripter.CurrentScript.Parser);
end;

procedure TfmSyntaxTree.InternalBuildSyntaxTree(AParser:TatSyntaxParser; ATreeView: TTreeView=nil);

   procedure ShowNodes( ViewNode:TTreeNode; SyntaxNodes:TNoTerminalNodes );
   var c   : integer;
       aux : string;
   begin
      for c:=0 to SyntaxNodes.Count-1 do
         with SyntaxNodes[c] do
         begin
            if Nodes.Count=0 then aux:=': '+InputToken else aux:='';
            ShowNodes( ATreeView.Items.AddChildObject( ViewNode, AParser.NoTerminals[NoTerminalIndex].IdS+aux, SyntaxNodes[c] ),
                       SyntaxNodes[c].Nodes );
         end;
   end;

begin
   if not Assigned(ATreeView) then
     ATreeView := TreeView1;
   with ATreeView do
   begin
      Items.BeginUpDate;
      Items.Clear;
      ShowNodes( Items.AddChildObject( nil,AParser.NoTerminals[AParser.Node.NoTerminalIndex].IdS, AParser.Node ),
                 AParser.Node.Nodes );
      FullExpand;
      Items.EndUpDate;
   end;
end;

end.
