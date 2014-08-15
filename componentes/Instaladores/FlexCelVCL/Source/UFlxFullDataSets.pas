unit UFlxFullDataSets;
{$IFDEF LINUX}{$INCLUDE ../FLXCOMPILER.INC}{$ELSE}{$INCLUDE ..\FLXCOMPILER.INC}{$ENDIF}

interface
uses contnrs;
type
  TFullDataSet= class
  public
    Text: string;
    RowOffset: integer;
    Col: integer;
    constructor Create(const aText: string; const aRowOffset, aCol: integer);
  end;

  TFullDataSetList= class(TObjectList)
  private
    function GetItems(index: integer): TFullDataSet;
  public
    property Items[index: integer]: TFullDataSet read GetItems; default;
  end;
implementation

{ TFullDataSetList }

function TFullDataSetList.GetItems(index: integer): TFullDataSet;
begin
  Result:= Inherited Items[index] as TFullDataSet;
end;

{ TFullDataSet }

constructor TFullDataSet.Create(const aText: string; const aRowOffset,
  aCol: integer);
begin
  inherited Create;
  Text:= aText;
  RowOffset:=aRowOffset;
  Col:=aCol;
end;

end.
