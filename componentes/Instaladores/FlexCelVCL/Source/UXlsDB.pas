unit UXlsDB;
{$IFDEF LINUX}{$INCLUDE ../FLXCOMPILER.INC}{$ELSE}{$INCLUDE ..\FLXCOMPILER.INC}{$ENDIF}

interface
uses Classes;
type
  TFlxDataSet=TComponent;

  IXlsDataSet=interface;

  IXlsField= interface
    ['{ACD0F8B5-596E-4C27-B383-8425BDB9051F}']
    function Value: variant;

   //    function DataSet: IXlsDataSet;
   //This has been deprecated, to allow for a field cache on the parent dataset
   //without circular references on interfaces
    function IsTDateTimeField: boolean;
    function IsTMemoField: boolean;
    function AsFloat: extended;

    function Visible: boolean;

    function DisplayName: string;
  end;

  IXlsDataSet= interface
    ['{35524AD4-16B3-4CCC-A69D-90CFC892003B}']
    function GetFields(index: integer): IXlsField;
    function GetActive: boolean;

    procedure Open;
    procedure Close;
    property Active: boolean read GetActive;

    function RecordCount: integer;
    procedure First;
    procedure Next;
    procedure Last;
    function Eof: boolean;

    function DsName: string;

    function FieldByName(const Name: string): IXlsField;
    function FieldCount: integer;
    function FieldVisibleCount: integer;
    property Fields[index: integer]: IXlsField read GetFields;
  end;

implementation

end.
