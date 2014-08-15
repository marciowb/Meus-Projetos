
{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressQuantumGrid export routines                          }
{                                                                   }
{       Copyright (c) 1998-2010 Developer Express Inc.              }
{       ALL RIGHTS RESERVED                                         }
{                                                                   }
{   The entire contents of this file is protected by U.S. and       }
{   International Copyright Laws. Unauthorized reproduction,        }
{   reverse-engineering, and distribution of all or any portion of  }
{   the code contained in this file is strictly prohibited and may  }
{   result in severe civil and criminal penalties and will be       }
{   prosecuted to the maximum extent possible under the law.        }
{                                                                   }
{   RESTRICTIONS                                                    }
{                                                                   }
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES           }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE    }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS   }
{   LICENSED TO DISTRIBUTE THE EXPRESSGRID AND ALL ACCOMPANYING VCL }
{   CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY.                 }
{                                                                   }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED      }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE        }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE       }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT  }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                      }
{                                                                   }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON       }
{   ADDITIONAL RESTRICTIONS.                                        }
{                                                                   }
{*******************************************************************}

unit dxGrExpt;

interface

{$I dxTLVer.inc}

uses
  Classes, dxDBCtrl, dxDBGrid, dxTL, Graphics{$IFDEF DELPHI6}, Variants{$ENDIF};

type
  { TdxDBGridExport }

  TdxDBGridExportWrapper = class(TdxDBGrid);

  TdxDBGridExport = class
  private
    FFileName: string;
    FGrid: TdxDBGridExportWrapper;
    FSaveAll: Boolean;
  protected
    TotalCount: Integer;
    Stream: TStream;
    procedure DoBeginWriting; virtual;
    procedure DoEndWriting; virtual;
    procedure DoWriteHeader; virtual;
    procedure DoWriteFooter; virtual;
    procedure DoWriteRecord(Node: TdxTreeListNode); virtual;
  public
    procedure Execute; virtual;
    procedure SaveToStream(Stream: TStream); virtual;
    property FileName: string read FFileName write FFileName;
    property Grid: TdxDBGridExportWrapper read FGrid write FGrid;
    property SaveAll: Boolean read FSaveAll write FSaveAll;
  end;

  { TdxDBGridExportExcel }

  TdxDBGridExportExcel = class(TdxDBGridExport)
  protected
    VisColIndexes: array [0..255] of Integer;
    VisColCount: Integer;
    procedure DoBeginWriting; override;
    procedure DoEndWriting; override;
    procedure DoWriteHeader; override;
    procedure DoWriteFooter; override;
    procedure DoWriteRecord(Node: TdxTreeListNode); override;
  end;

  { TdxDBGridExportHTML }

  TdxDBGridExportHTML = class(TdxDBGridExport)
  private
    procedure GetFontStyle(AFont: TFont; var SBegin, SEnd: string);
    function GetHTMLAlignment(AAlignment: TAlignment): String;
    procedure Write(const S: string);
    procedure WriteLn(S: string);
  protected
    procedure DoBeginWriting; override;
    procedure DoEndWriting; override;
    procedure DoWriteHeader; override;
    procedure DoWriteFooter; override;
    procedure DoWriteRecord(Node: TdxTreeListNode); override;
  end;

  { TdxDBGridExportText }
                     
  TdxDBGridExportText = class(TdxDBGridExport)
  private
    FSeparator: string;
    FBeginString, FEndString: string;
    procedure WriteLn(S: string);
  protected
    procedure DoWriteHeader; override;
    procedure DoWriteRecord(Node: TdxTreeListNode); override;
  public
    property Separator: string read FSeparator write FSeparator;
    property BeginString: string read FBeginString write FBeginString;
    property EndString: string read FEndString write FEndString;
  end;

  { TdxDBGridExportXML }

  TdxDBGridExportXML = class(TdxDBGridExport)
  private
    FGroupCount: Integer;
    FIndentCharCount: Integer;
    procedure BeginRows;
    procedure ChangeIndent(AValue: Integer);
    procedure CloseGroup;
    procedure CloseGroups;
    procedure EndRows;
    function GetIndentStr: string;
    function GetNodeValue(ANode: TdxTreeListNode; AColumn: TdxDBGridColumn): string;
    procedure WriteBands;
    procedure WriteColumns;
    procedure WriteDTD;
    procedure WriteGroup(Node: TdxTreeListNode);
    procedure WriteRow(Node: TdxTreeListNode);
    procedure WriteXSL;
  protected
    procedure DoBeginWriting; override;
    procedure DoEndWriting; override;
    procedure DoWriteHeader; override;
    procedure DoWriteFooter; override;
    procedure DoWriteRecord(Node: TdxTreeListNode); override;
    procedure Write(const S: string);
    procedure WriteLn(S: string);
  end;

procedure SaveToHTML(AGrid: TdxDBGrid; const AFileName: string; ASaveAll: Boolean);
procedure SaveToXLS(AGrid: TdxDBGrid; const AFileName: string; ASaveAll: Boolean);
procedure SaveToText(AGrid: TdxDBGrid; const AFileName: string; ASaveAll: Boolean;
  const ASeparator, ABeginString, AEndString: string);
procedure SaveToXML(AGrid: TdxDBGrid; const AFileName: string; ASaveAll: Boolean);

implementation

uses
  Windows, SysUtils, DB, Forms, dxGrDate;

// Excel format
const
  XLSBOF: array[0..4] of Word = ($409, 6, 0, $10, 0);
  XLSGUTS: array[0..5] of Word = ($80, 8, 0, 0, 0, 0);
  XLSPalette: array[0..2] of Word = ($92, 0, 0);
  XLSDimension: array [0..6] of Word = ($200, $0A, 0, $FFFF, 0, $FF, 0);
  XLSEOF: array[0..1] of Word = ($0A, 0);
  XLSFONTH: array[0..9] of Byte = ($31, 2, 0, 0, 0, 0, 0, 0, 8, 0);
  XLSFONTG: array[0..9] of Byte = ($31, 2, 0, 0, 0, 0, 0, 0, 10, 0);
  XLSFONT: array[0..9] of Byte = ($31, 2, 0, 0, 0, 0, 0, 0, 0, 0);
  XLSXF1: array[0..15] of Byte = ($43, 4, $0C, 0, 0, 0, $F5, $FF, $20, 0, 0, $CE, 0, 0, 0, 0);
  XLSXF2: array[0..15] of Byte = ($43, 4, $0C, 0, 1, 0, $F5, $FF, $20, $F4, 0, $CE, 0, 0, 0, 0);
  XLSXF3: array[0..15] of Byte = ($43, 4, $0C, 0, 2, 0, $F5, $FF, $20, $F4, 0, $CE, 0, 0, 0, 0);
  XLSXF4: array[0..15] of Byte = ($43, 4, $0C, 0, 0, 0, $F5, $FF, $20, $F4, 0, $CE, 0, 0, 0, 0);
  XLSXF5: array[0..15] of Byte = ($43, 4, $0C, 0, 0, 0, 1, 0, $20, 0, 0, $CE, 0, 0, 0, 0);
  XLSXF6: array[0..15] of Byte = ($43, 4, $0C, 0, 1, $21, $F5, $FF, $20, $F8, 0, $CE, 0, 0, 0, 0);
  XLSXF7: array[0..15] of Byte = ($43, 4, $0C, 0, 1, $1F, $F5, $FF, $20, $F8, 0, $CE, 0, 0, 0, 0);
  XLSXF8: array[0..15] of Byte = ($43, 4, $0C, 0, 1, $20, $F5, $FF, $20, $F8, 0, $CE, 0, 0, 0, 0);
  XLSXF9: array[0..15] of Byte = ($43, 4, $0C, 0, 1, $1E, $F5, $FF, $20, $F8, 0, $CE, 0, 0, 0, 0);
  XLSXF10: array[0..15] of Byte = ($43, 4, $0C, 0, 1, $0D, $F5, $FF, $20, $F8, 0, $CE, 0, 0, 0, 0);
  XLSXF: array[0..15] of Byte = ($43, 4, $0C, 0, 5, 0, 1, 0, $21, $78, $41, 3, 0, 0, 0, 0);
  XLSXFB: array[0..15] of Byte = ($43, 4, $0C, 0, 8, 0, 1, 0, $22, $78, $41, 2, $71, $71, $71, 0);
  XLSXFH: array[0..15] of Byte = ($43, 4, $0C, 0, 6, 0, 1, 0, $22, $78, $41, 2, $71, $71, $71, $71);
  XLSXFG: array[0..15] of Byte = ($43, 4, $0C, 0, 7, 0, 1, 0, $21, $78, $C1, 2, 0, 0, 0, 0);
  XLSXFF: array[0..15] of Byte = ($43, 4, $0C, 0, 5, 0, 1, 0, $22, $78, $C1, 2, $B9, $B9, $B9, $B9);
  XLSXFF1: array[0..15] of Byte = ($43, 4, $0C, 0, 5, 0, 1, 0, $22, $78, $C1, 2, $B9, 0, $B9, 0);
  XLSXFRF: array[0..15] of Byte = ($43, 4, $0C, 0, 9, 0, 1, 0, $21, $78, $C1, 2, $B9, $B9, $B9, $B9);
  XLSXFRF1: array[0..15] of Byte = ($43, 4, $0C, 0, 9, 0, 1, 0, $21, $78, $C1, 2, $B9, 0, $B9, 0);
  XLSCOL: array[0..7] of Word = ($7D, $0C, 0, 0, 0, $F, 0, 0);
  XLSSFONT: array[0..15] of Byte = ($31, 2, $0C, 0, $C8, 0, 0, 0, $FF, $7F, 5, $41, $72, $69, $61, $6C);
  XLSLabel: array[0..5] of Word = ($204, 0, 0, 0, 0, 0);
  XLSBlank: array[0..4] of Word = ($201, 6, 0, 0, $17);
  XLSBlankF: array[0..4] of Word = ($201, 6, 0, 0, $19);
  XLSBlankRF: array[0..4] of Word = ($201, 6, 0, 0, $1C);
//  XLSBlankH: array[0..4] of Word = ($201, 6, 0, 0, $16);
//  XLSBlankB: array[0..4] of Word = ($201, 6, 0, 0, $1A);
  XLSNumber: array[0..4] of Word = ($203, 14, 0, 0, 0);
  XLSRK: array[0..4] of Word = ($27E, 10, 0, 0, 0);
  XLSFormula: array[0..15] of Word =($406, $1D, 0, 0, $18, 0, 0, 0, 0, 3, $0B, $25, 0, 0, 0, 0);

function CompareByPointer(Item1, Item2: Pointer): Integer;
begin
  Result := {DWORD}Integer(Item1) - {DWORD}Integer(Item2);
end;

function CompareByAbsoluteIndex(Item1, Item2: Pointer): Integer;
var
  Node1, Node2: TdxTreeListNode;
begin
  Node1 := TdxTreeListNode(Item1);
  Node2 := TdxTreeListNode(Item2);
  if Node1.HasAsParent(Node2) then
  begin
    Result := 1;
    Exit;
  end;
  if Node2.HasAsParent(Node1) then
  begin
    Result := -1;
    Exit;
  end;
  while Node1.Level > Node2.Level do Node1 := Node1.Parent;
  while Node2.Level > Node1.Level do Node2 := Node2.Parent;
  while Node1.Parent <> Node2.Parent do
  begin
    Node1 := Node1.Parent;
    Node2 := Node2.Parent;
  end;
  Result := (Node1.Index - Node2.Index);
end;

// XML routines

// Date in a subset of ISO 8601 format, with optional time and no optional zone.
// Fractional seconds can be as precise as nanoseconds.
// For example, "1988-04-07T18:39:09".
function ConvertDateToXmlStr(const V: Variant): string;
const
  DTFormat: array [Boolean] of string = ('yyyy-mm-dd', 'yyyy-mm-dd"T"hh:nn:ss');
var
  D: TDateTime;
begin
  D := TDateTime(V);
  if D = NullDate then
    Result := ''
  else
    if DateOf(D) = 0 then
      Result := FormatDateTime('hh:nn:ss', V)
    else
      Result := FormatDateTime(DTFormat[TimeOf(V) <> 0], V);
end;

function CharToUTF8(const AChar: Char): string;
var
  WS: WideString;
begin
  WS := AChar;
  SetLength(Result, 2);
  WideCharToMultiByte(CP_UTF8, 0, PWideChar(WS), 1, @Result[1], 2, nil, nil);
end;

function ConvertTextToXml(const AText: string): string;
const
  NormalAlpha = ['0'..'9', ':', ';', '*', '+', ',', '-', '.', '/', '!', ' ',
    'A'..'Z', 'a'..'z', '_'];
var
  I: Integer;
begin
  Result := '';
  for I := 1 to Length(AText) do
    if AText[I] in NormalAlpha then
      Result := Result + AText[I]
    else
      Result := Result + CharToUTF8(AText[I]);
//      Result := Result + Format('&#%d;', [Ord(AText[I])]);
end;

function ConvertFileNameToXml(const AText: string): string;
const
  NormalAlpha = ['0'..'9', '-', '.', 'A'..'Z', 'a'..'z', '_'];
var
  I: Integer;
begin
  Result := AText;
  for I := 1 to Length(Result) do
    if not (Result[I] in NormalAlpha) then
      Result[I] := '_';
end;

function GetColumnIdentifier(AColumn: TdxTreeListColumn): string;
begin
  if AColumn.Name = '' then
    Result := 'Column' + IntToStr(AColumn.Index)
  else
    Result := AColumn.Name;
end;

procedure SaveToHTML(AGrid: TdxDBGrid; const AFileName : String; ASaveAll: Boolean);
begin
  with TdxDBGridExportHTML.Create do
  try
    FileName := AFileName;
    Grid := TdxDBGridExportWrapper(AGrid);
    SaveAll := ASaveAll;
    Execute;
  finally
    Free;
  end;
end;

procedure SaveToXLS(AGrid: TdxDBGrid; const AFileName : String; ASaveAll: Boolean);
begin
  with TdxDBGridExportExcel.Create do
  try
    FileName := AFileName;
    Grid := TdxDBGridExportWrapper(AGrid);
    SaveAll := ASaveAll;
    Execute;
  finally
    Free;
  end;
end;

procedure SaveToText(AGrid: TdxDBGrid; const AFileName: string; ASaveAll: Boolean;
  const ASeparator, ABeginString, AEndString: string);
begin
  with TdxDBGridExportText.Create do
  try
    Separator := ASeparator;
    BeginString := ABeginString;
    EndString := AEndString;
    FileName := AFileName;
    Grid := TdxDBGridExportWrapper(AGrid);
    SaveAll := ASaveAll;
    Execute;
  finally
    Free;
  end;
end;

procedure SaveToXML(AGrid: TdxDBGrid; const AFileName: string; ASaveAll: Boolean);
begin
  with TdxDBGridExportXML.Create do
  try
    FileName := AFileName;
    Grid := TdxDBGridExportWrapper(AGrid);
    SaveAll := ASaveAll;
    Execute;
  finally
    Free;
  end;
end;

{ TdxDBGridExport }

procedure TdxDBGridExport.Execute;
begin
  Stream := TFileStream.Create(FileName, fmCreate);
  try
    SaveToStream(Stream);
  finally
    Stream.Free;
    Stream := nil;
  end;
end;

procedure TdxDBGridExport.SaveToStream(Stream: TStream);
var
  FlagAll: Boolean;
  DataSet: TDataSet;
  Current: TBookmarkStr;
  i: Integer;
  FList: TList;
  Node: TdxTreeListNode;
  OldTopIndex: Integer;
  FlagDataSet: Boolean;

  procedure LoadList(Node: TdxTreeListNode);
  var
    i: Integer;
  begin
    FList.Add(Node);
    if Node.HasChildren then
      for i := 0 to Node.Count - 1 do
        LoadList(Node[i]);
  end;

  procedure LoadParent(Node: TdxTreeListNode);
  begin
    if (Node <> nil) and (FList.IndexOf(Node) = -1 ) then
    begin
      FList.Add(Node);
      LoadParent(Node.Parent);
    end;
  end;

  procedure LoadSelNodeList(Node: TdxTreeListNode);
  var
    i: Integer;
  begin
    FList.Add(Node);
    LoadParent(Node.Parent);
    if Node.HasChildren then
      for i := 0 to Node.Count - 1 do
        LoadList(Node[i]);
  end;

  procedure LoadNodes(List: TList);
  var
    i: Integer;
  begin
    List.Clear;
    with Grid do
    if FlagAll then
      for i := 0 to Count - 1 do
        LoadList(Items[i])
    else
    begin
      for i := 0 to SelectedCount - 1 do
        LoadSelNodeList(SelectedNodes[i]);
      // sort by pointer and kill equal nodes
      List.Sort(CompareByPointer);
      for i := List.Count - 1 downto 1 do
        if List[i] = List[i - 1] then List.Delete(i);
      // sort by absolute order
      List.Sort(CompareByAbsoluteIndex);
    end;
  end;

begin
  if Assigned(FGrid) and Assigned(FGrid.DataSource) and
    Assigned(FGrid.DataSource.DataSet) then
  with FGrid do
  begin
    FlagAll := FSaveAll or (SelectedCount = 0);
    FlagDataSet := IsGridMode or (IsPartialLoad and FlagAll); 
    DataSet := DataSource.DataSet;
    if FlagDataSet then
    begin
      DataSet.DisableControls;
      Current := DataSet.Bookmark;
      OldTopIndex := TopIndex;
    end
    else
      OldTopIndex := -1;  
    DoBeginWriting;
    try
      TotalCount := 0;
      // write header
      DoWriteHeader;
      if FlagDataSet{IsGridMode or (IsPartialLoad and FlagAll)} then
      begin
        if FlagAll then
        begin
          DataSet.First;
          while not DataSet.EOF do
          begin
            // processing record
            DoWriteRecord(nil);
            Inc(TotalCount);
            DataSet.Next;
          end;
        end
        else
        for i := 0 to SelectedCount - 1 do
        begin
          DataSet.Bookmark := SelectedRows[i];
          // processing record
          DoWriteRecord(nil);
          Inc(TotalCount);
        end;
      end
      else
      begin
        FList := TList.Create;
        try
          LoadNodes(FList);
          for i := 0 to FList.Count - 1 do
          begin
            Node := TdxTreeListNode(FList[i]);
            // processing record
            DoWriteRecord(Node);
            Inc(TotalCount);
          end;
        finally
          FList.Free;
        end;
      end;
      DoWriteFooter;
    finally
      DoEndWriting;
      if FlagDataSet then
      begin
        DataSet.Bookmark := Current;
        DataSet.EnableControls;
        TopIndex := OldTopIndex;
      end;
    end;
  end;
end;

procedure TdxDBGridExport.DoBeginWriting;
begin
end;

procedure TdxDBGridExport.DoEndWriting;
begin
end;

procedure TdxDBGridExport.DoWriteHeader;
begin
end;

procedure TdxDBGridExport.DoWriteFooter;
begin
end;

procedure TdxDBGridExport.DoWriteRecord(Node: TdxTreeListNode);
begin
end;

{TdxDBGridExportExcel}
procedure TdxDBGridExportExcel.DoBeginWriting;
var
  C: LongInt;
  S: string;
  B: Byte;
  i, j, k: Integer;
begin
with Grid do
begin
  VisColCount := 0;
  for i := 0 to  GetBandCount - 1 do
    for j := 0 to GetHeaderRowCount(i) - 1 do
      for k := 0 to GetHeaderColCount(i, j) - 1 do
        if IsHeaderVisible(GetHeaderAbsoluteIndex(i,j,k)) then
        begin
          VisColIndexes[VisColCount] := GetHeaderAbsoluteIndex(i,j,k);
          Inc(VisColCount);
        end;
  Stream.WriteBuffer(XLSBOF, SizeOf(XLSBOF));
  Stream.WriteBuffer(XLSGUTS, SizeOf(XLSGUTS));
  // XLS Palette
  XLSPalette[1] := 54;
  XLSPalette[2] := 13;
  Stream.WriteBuffer(XLSPalette, SizeOf(XLSPalette));
  if HeaderFont.Color = clNone then
    C := 0
  else
    C := ColorToRGB(HeaderFont.Color);
  Stream.WriteBuffer(C, SizeOf(C));
  if HeaderColor = clNone then
    C := 0
  else
    C := ColorToRGB(HeaderColor);
  Stream.WriteBuffer(C, SizeOf(C));
  if GroupNodeTextColor = clNone then
    C := 0
  else
    C := ColorToRGB(GroupNodeTextColor);
  Stream.WriteBuffer(C, SizeOf(C));
  if GroupNodeColor = clNone then
    C := 0
  else
    C := ColorToRGB(GroupNodeColor);
  Stream.WriteBuffer(C, SizeOf(C));
  if Font.Color = clNone then
    C := 0
  else
    C := ColorToRGB(Font.Color);
  Stream.WriteBuffer(C, SizeOf(C));
  if Color = clNone then
    C := 0
  else
    C := ColorToRGB(Color);
  Stream.WriteBuffer(C, SizeOf(C));
  C := ColorToRGB(clWindowFrame);
  Stream.WriteBuffer(C, SizeOf(C));
  C := ColorToRGB(clWindow);
  Stream.WriteBuffer(C, SizeOf(C));
  if BandFont.Color = clNone then
    C := 0
  else
    C := ColorToRGB(BandFont.Color);
  Stream.WriteBuffer(C, SizeOf(C));
  if BandColor = clNone then
    C := 0
  else
    C := ColorToRGB(BandColor);
  Stream.WriteBuffer(C, SizeOf(C));
  if RowFooterTextColor = clNone then
    C := 0
  else
    C := ColorToRGB(RowFooterTextColor);
  Stream.WriteBuffer(C, SizeOf(C));
  if RowFooterColor = clNone then
    C := 0
  else
    C := ColorToRGB(RowFooterColor);
  Stream.WriteBuffer(C, SizeOf(C));
  if GridLineColor = clNone then
    C := 0
  else
    C := ColorToRGB(GridLineColor);
  Stream.WriteBuffer(C, SizeOf(C));
  // XLS Font
  Stream.WriteBuffer(XLSSFont, SizeOf(XLSSFont));
  Stream.WriteBuffer(XLSSFont, SizeOf(XLSSFont));
  Stream.WriteBuffer(XLSSFont, SizeOf(XLSSFont));
  Stream.WriteBuffer(XLSSFont, SizeOf(XLSSFont));
    // Grid Font
    S := Font.Name;
    B := Length(S);
    XLSFont[2] := B + 7;
    XLSFont[4] := Font.Size*20 mod 256;
    XLSFont[5] := Font.Size*20 div 256;
    XLSFont[6] := 0;
    if (fsBold in Font.Style) then XLSFont[6] := XLSFont[6] + 1;
    if (fsItalic in Font.Style) then XLSFont[6] := XLSFont[6] + 2;
    if (fsUnderline in Font.Style) then XLSFont[6] := XLSFont[6] + 4;
    if (fsStrikeOut in Font.Style) then XLSFont[6] := XLSFont[6] + 8;
    XLSFont[8] := 12;
    Stream.WriteBuffer(XLSFont, SizeOf(XLSFont));
    Stream.WriteBuffer(B, SizeOf(B));
    Stream.WriteBuffer(Pointer(S)^, Length(S));
    // Header Font
    S := HeaderFont.Name;
    B := Length(S);
    XLSFontH[2] := B + 7;
    XLSFontH[4] := HeaderFont.Size*20 mod 256;
    XLSFontH[5] := HeaderFont.Size*20 div 256;
    XLSFontH[6] := 0;
    if (fsBold in HeaderFont.Style) then XLSFontH[6] := XLSFontH[6] + 1;
    if (fsItalic in HeaderFont.Style) then XLSFontH[6] := XLSFontH[6] + 2;
    if (fsUnderline in HeaderFont.Style) then XLSFontH[6] := XLSFontH[6] + 4;
    if (fsStrikeOut in HeaderFont.Style) then XLSFontH[6] := XLSFontH[6] + 8;
    Stream.WriteBuffer(XLSFontH, SizeOf(XLSFontH));
    Stream.WriteBuffer(B, SizeOf(B));
    Stream.WriteBuffer(Pointer(S)^, Length(S));
    // Group Font
    S := Font.Name;
    B := Length(S);
    XLSFontG[2] := B + 7;
    XLSFontG[4] := Font.Size*20 mod 256;
    XLSFontG[5] := Font.Size*20 div 256;
    XLSFontG[6] := 0;
    if (fsBold in Font.Style) then XLSFontG[6] := XLSFontG[6] + 1;
    if (fsItalic in Font.Style) then XLSFontG[6] := XLSFontG[6] + 2;
    if (fsUnderline in Font.Style) then XLSFontG[6] := XLSFontG[6] + 4;
    if (fsStrikeOut in Font.Style) then XLSFontG[6] := XLSFontG[6] + 8;
    Stream.WriteBuffer(XLSFontG, SizeOf(XLSFontG));
    Stream.WriteBuffer(B, SizeOf(B));
    Stream.WriteBuffer(Pointer(S)^, Length(S));
    // Band Font
    S := BandFont.Name;
    B := Length(S);
    XLSFont[2] := B + 7;
    XLSFont[4] := BandFont.Size*20 mod 256;
    XLSFont[5] := BandFont.Size*20 div 256;
    XLSFont[6] := 0;
    if (fsBold in BandFont.Style) then XLSFont[6] := XLSFont[6] + 1;
    if (fsItalic in BandFont.Style) then XLSFont[6] := XLSFont[6] + 2;
    if (fsUnderline in BandFont.Style) then XLSFont[6] := XLSFont[6] + 4;
    if (fsStrikeOut in BandFont.Style) then XLSFont[6] := XLSFont[6] + 8;
    XLSFont[8] := 16;
    Stream.WriteBuffer(XLSFont, SizeOf(XLSFont));
    Stream.WriteBuffer(B, SizeOf(B));
    Stream.WriteBuffer(Pointer(S)^, Length(S));
    // Footer Font
    S := Font.Name;
    B := Length(S);
    XLSFont[2] := B + 7;
    XLSFont[4] := Font.Size*20 mod 256;
    XLSFont[5] := Font.Size*20 div 256;
    XLSFont[6] := 0;
    if (fsBold in Font.Style) then XLSFont[6] := XLSFont[6] + 1;
    if (fsItalic in Font.Style) then XLSFont[6] := XLSFont[6] + 2;
    if (fsUnderline in Font.Style) then XLSFont[6] := XLSFont[6] + 4;
    if (fsStrikeOut in Font.Style) then XLSFont[6] := XLSFont[6] + 8;
    XLSFont[8] := 18;
    Stream.WriteBuffer(XLSFont, SizeOf(XLSFont));
    Stream.WriteBuffer(B, SizeOf(B));
    Stream.WriteBuffer(Pointer(S)^, Length(S));
    // Columns Fonts
    for i := 0 to  VisColCount - 1 do
    begin
      S := GetColumnFont(VisColIndexes[i]).Name;
      B := Length(S);
      XLSFont[2] := B + 7;
      XLSFont[4] := GetColumnFont(VisColIndexes[i]).Size*20 mod 256;
      XLSFont[5] := GetColumnFont(VisColIndexes[i]).Size*20 div 256;
      XLSFont[6] := 0;
      if (fsBold in GetColumnFont(VisColIndexes[i]).Style) then XLSFont[6] := XLSFont[6] + 1;
      if (fsItalic in GetColumnFont(VisColIndexes[i]).Style) then XLSFont[6] := XLSFont[6] + 2;
      if (fsUnderline in GetColumnFont(VisColIndexes[i]).Style) then XLSFont[6] := XLSFont[6] + 4;
      if (fsStrikeOut in GetColumnFont(VisColIndexes[i]).Style) then XLSFont[6] := XLSFont[6] + 8;
      XLSFont[8] := 12;
      Stream.WriteBuffer(XLSFont, SizeOf(XLSFont));
      Stream.WriteBuffer(B, SizeOf(B));
      Stream.WriteBuffer(Pointer(S)^, Length(S));
    end;
    // Grid
    Stream.WriteBuffer(XLSXF1, SizeOf(XLSXF1));
    Stream.WriteBuffer(XLSXF2, SizeOf(XLSXF2));
    Stream.WriteBuffer(XLSXF2, SizeOf(XLSXF2));
    Stream.WriteBuffer(XLSXF3, SizeOf(XLSXF3));
    Stream.WriteBuffer(XLSXF3, SizeOf(XLSXF3));
    for i := 0 to 9 do
      Stream.WriteBuffer(XLSXF4, SizeOf(XLSXF4));
    Stream.WriteBuffer(XLSXF5, SizeOf(XLSXF5));
    Stream.WriteBuffer(XLSXF6, SizeOf(XLSXF6));
    Stream.WriteBuffer(XLSXF7, SizeOf(XLSXF7));
    Stream.WriteBuffer(XLSXF8, SizeOf(XLSXF8));
    Stream.WriteBuffer(XLSXF9, SizeOf(XLSXF9));
    Stream.WriteBuffer(XLSXF10, SizeOf(XLSXF10));
    if ShowGrid then
    begin
      XLSXF[12] := $A1;
      XLSXF[13] := $A1;
      XLSXF[14] := $A1;
      XLSXF[15] := $A1;
    end;
    Stream.WriteBuffer(XLSXF, SizeOf(XLSXF));
    Stream.WriteBuffer(XLSXFH, SizeOf(XLSXFH));
    Stream.WriteBuffer(XLSXFG, SizeOf(XLSXFG));
    Stream.WriteBuffer(XLSXFF, SizeOf(XLSXFF));
    Stream.WriteBuffer(XLSXFF1, SizeOf(XLSXFF1));
    Stream.WriteBuffer(XLSXFB, SizeOf(XLSXFB));
    Stream.WriteBuffer(XLSXFRF, SizeOf(XLSXFRF));
    Stream.WriteBuffer(XLSXFRF1, SizeOf(XLSXFRF1));
    for i := 0 to  VisColCount - 1 do
    begin
      XLSXF[4] := i + 10;
      case Columns[VisColIndexes[i]].Alignment of
       taLeftJustify : XLSXF[8] := $21;
       taRightJustify : XLSXF[8] := $23;
       taCenter : XLSXF[8] := $22;
      end;
//      XLSXF[11] := i*2 + 21; ////
      Stream.WriteBuffer(XLSXF, SizeOf(XLSXF));
    end;
    // Group Columns
    for i := 0 to GroupColumnCount - 1 do
    begin
      XLSCOL[2] := i;
      XLSCOL[3] := i;
      XLSCOL[4] := 400;
      Stream.WriteBuffer(XLSCOL, SizeOf(XLSCOL));
    end;
    // VsibleColumns
    for i := 0 to  VisColCount - 1 do
    begin
      XLSCOL[2] := i + GroupColumnCount;
      XLSCOL[3] := i + GroupColumnCount;
      XLSCOL[4] := 36 * GetHeaderBoundsWidth(VisColIndexes[i]);
      Stream.WriteBuffer(XLSCOL, SizeOf(XLSCOL));
    end;
    Stream.WriteBuffer(XLSDimension, SizeOf(XLSDimension));
  end;
end;

procedure TdxDBGridExportExcel.DoWriteHeader;
var
  i, j, k: Integer;
  S: string;
begin
with Grid do
begin
  // Draw Bands
  if ShowBands then
  begin
    for i := 0 to GroupColumnCount - 1 do
    begin
      XLSBlank[2] := TotalCount;
      XLSBlank[3] := i;
      Stream.WriteBuffer(XLSBlank, SizeOf(XLSBlank));
    end;
    for j := 0 to VisColCount - 1 do
    begin
      XLSBlank[2] := TotalCount;
      XLSBlank[3] := j + GroupColumnCount;
      Stream.WriteBuffer(XLSBlank, SizeOf(XLSBlank));
    end;
    k := 0;
    for i := 0 to  GetBandCount - 1 do
    begin
      S := GetBandText(i);
      XLSLAbel[1] := Length(S) + 8;
      XLSLabel[2] := TotalCount;
      XLSLabel[3] := k + GroupColumnCount;
      XLSLabel[4] := $1A;
      XLSLabel[5] := Length(S);
      Stream.WriteBuffer(XLSLabel, SizeOf(XLSLabel));
      Stream.WriteBuffer(Pointer(S)^, Length(S));
      for j := 0 to GetHeaderRowCount(i) - 1 do
        k := k + GetHeaderColCount(i,j);
    end;
    Inc(TotalCount);
  end;
  // Draw Heders
  if ShowHeader then
  begin
    for i := 0 to GroupColumnCount - 1 do
    begin
      XLSBlank[2] := TotalCount;
      XLSBlank[3] := i;
      Stream.WriteBuffer(XLSBlank, SizeOf(XLSBlank));
    end;
    for i := 0 to  VisColCount - 1 do
    begin
//      S := GetHeaderText(VisColIndexes[i]);
      S := Columns[VisColIndexes[i]].Caption;
      if Columns[VisColIndexes[i]].DisableCaption then
        S := '';
      XLSLAbel[1] := Length(S) + 8;
      XLSLabel[2] := TotalCount;
      XLSLabel[3] := i + GroupColumnCount;
      XLSLabel[4] := $16;
      XLSLabel[5] := Length(S);
      Stream.WriteBuffer(XLSLabel, SizeOf(XLSLabel));
      Stream.WriteBuffer(Pointer(S)^, Length(S));
    end;
    Inc(TotalCount);
  end;
end;
end;

procedure TdxDBGridExportExcel.DoWriteRecord(Node: TdxTreeListNode);
var
  C: LongInt;
  F: Double;
  i, j: Integer;
  S: string;
  V: Variant;
begin
  with Grid do
  begin
    if (GroupColumnCount > 0) and (Node <> nil) then
    begin
      for i := 0 to GroupColumnCount - 1 do
        if i = Node.Level then
        begin
          S := Node.Strings[GroupColumns[Node.Level].Index];
          XLSLAbel[1] := Length(S) + 8;
          XLSLabel[2] := TotalCount;
          XLSLabel[3] := i;
          XLSLabel[4] := $17;
          XLSLAbel[5] := Length(S);
          Stream.WriteBuffer(XLSLabel, SizeOf(XLSLabel));
          Stream.WriteBuffer(Pointer(S)^, Length(S));
        end
        else
        begin
          XLSBlank[2] := TotalCount;
          XLSBlank[3] := i;
          Stream.WriteBuffer(XLSBlank, SizeOf(XLSBlank));
        end;
    end;
    for i := 0 to  VisColCount - 1 do
    begin
      if (Node <> nil) and Node.HasChildren then
      begin
        XLSBlank[2] := TotalCount;
        XLSBlank[3] := GroupColumnCount + i;
        Stream.WriteBuffer(XLSBlank, SizeOf(XLSBlank));
      end
      else
        if (Columns[VisColIndexes[i]].FieldName = '') or
          not Assigned(Columns[VisColIndexes[i]].Field ) then
        begin
          XLSLAbel[1] := 8;
          XLSLabel[2] := TotalCount;
          XLSLabel[3] := i;
          XLSLabel[4] := $1D + i;
          XLSLAbel[5] := 0;
          Stream.WriteBuffer(XLSLabel, SizeOf(XLSLabel));
        end
        else
        begin
          with Columns[VisColIndexes[i]].Field do
          begin
            if Node <> nil then
              V := Node.Values[Columns[VisColIndexes[i]].Index]
            else V := Value;
            // Convert Value
            if Columns[VisColIndexes[i]].ConvertExportValue(V, False) then
              case VarType(V) of
                varSmallint, varInteger:
                  begin
                    if VarIsNull(V) then C := 0
                    else C := V;
                    C := C shl 2 + 2;
                    XLSRK[2] := TotalCount;
                    XLSRK[3] := GroupColumnCount + i;
                    XLSRK[4] := $1D + i;
                    Stream.WriteBuffer(XLSRK, SizeOf(XLSRK));
                    Stream.WriteBuffer(C, SizeOf(C));
                  end;
                varSingle, varDouble, varCurrency:
                  begin
                    if VarIsNull(V) then F := 0.0
                    else F := V;
                    XLSNumber[2] := TotalCount;
                    XLSNumber[3] := GroupColumnCount + i;
                    XLSNumber[4] := $1D + i;
                    Stream.WriteBuffer(XLSNumber, SizeOf(XLSNumber));
                    Stream.WriteBuffer(F, SizeOf(F));
                  end;
              else {String}
                begin
                  if VarIsNull(V) then S := ''
                  else S := V;
                  if DataType = ftMemo then
                    S := Copy(S, 0, 255);
                  XLSLAbel[1] := Length(S) + 8;
                  XLSLabel[2] := TotalCount;
                  XLSLabel[3] := GroupColumnCount + i;
                  XLSLabel[4] := $1D + i;
                  XLSLAbel[5] := Length(S);
                  Stream.WriteBuffer(XLSLabel, SizeOf(XLSLabel));
                  Stream.WriteBuffer(Pointer(S)^, Length(S));
                end;
              end
            else {old}
            begin
              case DataType of
                ftSmallint, ftInteger, ftWord, ftAutoInc, ftBytes:
                begin
                  if Node = nil then
                    C := AsInteger
                  else
                  begin
                    V := TdxDBGridNode(Node).VariantValues[Columns[VisColIndexes[i]].Index];
                    if V = Null then C := 0
                    else C := V;
                  end;
                  C := C shl 2 + 2;
                  XLSRK[2] := TotalCount;
                  XLSRK[3] := GroupColumnCount + i;
                  XLSRK[4] := $1D + i;
                  Stream.WriteBuffer(XLSRK, SizeOf(XLSRK));
                  Stream.WriteBuffer(C, SizeOf(C));
                end;
                ftFloat, ftCurrency, ftBCD:
                begin
                  if Node = nil then
                    F := AsFloat
                  else
                  begin
                    V := TdxDBGridNode(Node).VariantValues[Columns[VisColIndexes[i]].Index];
                    if V = Null then F := 0.0
                    else F := V;
                  end;
                  XLSNumber[2] := TotalCount;
                  XLSNumber[3] := GroupColumnCount + i;
                  XLSNumber[4] := $1D + i;
                  Stream.WriteBuffer(XLSNumber, SizeOf(XLSNumber));
                  Stream.WriteBuffer(F, SizeOf(F));
                end;
                else
                begin
                  if Node = nil then
                    S := DisplayText
                  else S := TdxDBGridNode(Node).Strings[Columns[VisColIndexes[i]].Index];
                  if DataType = ftMemo then
                    S := Copy(S, 0, 255);
                  XLSLAbel[1] := Length(S) + 8;
                  XLSLabel[2] := TotalCount;
                  XLSLabel[3] := GroupColumnCount + i;
                  XLSLabel[4] := $1D + i;
                  XLSLAbel[5] := Length(S);
                  Stream.WriteBuffer(XLSLabel, SizeOf(XLSLabel));
                  Stream.WriteBuffer(Pointer(S)^, Length(S));
                end;
              end;
            end;
          end;
        end;
    end;
    for j := 0 to GetRowFooterCount(Node) - 1 do
    begin
      Inc(TotalCount);
      for i := 0 to GetNodeFooterLevel(Node,j) do
      begin
        XLSBlank[2] := TotalCount;
        XLSBlank[3] := i;
        Stream.WriteBuffer(XLSBlank, SizeOf(XLSBlank));
      end;
      for i := 0 to  VisColCount - 1 do
        if not IsExistRowFooterCell(Node,VisColIndexes[i],j) then
        begin
          XLSBlankRF[2] := TotalCount;
          XLSBlankRF[3] := GroupColumnCount + i;
          Stream.WriteBuffer(XLSBlankRF, SizeOf(XLSBlankRF));
        end
        else
        begin
          S := GetFooterCellText(Node,VisColIndexes[i],j);
          XLSLabel[1] := Length(S) + 8;
          XLSLabel[2] := TotalCount;
          XLSLabel[3] := GroupColumnCount + i;
          if (i = 0) and (GroupColumnCount - GetNodeFooterLevel(Node,j) - 1 > 0) then
            XLSLabel[3] := GetNodeFooterLevel(Node,j) + 1 ;
          XLSLabel[4] := $1B;
          XLSLabel[5] := Length(S);
          Stream.WriteBuffer(XLSLabel, SizeOf(XLSLabel));
          Stream.WriteBuffer(Pointer(S)^, Length(S));
        end;
      for i := 1 to GroupColumnCount - GetNodeFooterLevel(Node,j) - 1 do
      begin
        XLSBlankRF[2] := TotalCount;
        XLSBlankRF[3] := GroupColumnCount - i + 1;
        Stream.WriteBuffer(XLSBlankRF, SizeOf(XLSBlankRF));
      end;
    end;
  end;
end;

procedure TdxDBGridExportExcel.DoWriteFooter;

  function FindSummaryCol(const FieldName: string; var Column: TdxDBTreeListColumn): Integer;
  var
    i: Integer;
  begin
    Result := -1;
    for i := 0 to VisColCount - 1 do
      if AnsiCompareText(Grid.Columns[VisColIndexes[i]].FieldName, FieldName) = 0 then
      begin
        Result := i;
        Exit;
      end;
  end;

var
  i, ColIndx: Integer;
  Col: TdxDBTreeListColumn;
  b: Byte;
begin
  with Grid do
  if ShowSummaryFooter then
  begin
    for i := 0 to GroupColumnCount - 1 do
    begin
      XLSBlankF[2] := TotalCount;
      XLSBlankF[3] := i;
      Stream.WriteBuffer(XLSBlankF, SizeOf(XLSBlankF));
    end;
    for i := 0 to VisColCount - 1 do
    begin
      with TdxDBGridColumn(Columns[VisColIndexes[i]]) do
      begin
        case SummaryFooterType of
          cstAvg: XLSFormula[15] := $501;
          cstCount: XLSFormula[15] := $A901;
          cstMax: XLSFormula[15] := $701;
          cstMin: XLSFormula[15] := $601;
          cstSum: XLSFormula[15] := $10;
        end;
        ColIndx := FindSummaryCol(SummaryFooterField, Col);
        if (SummaryFooterType = cstCount) then ColIndx := i;
        if (SummaryFooterType = cstNone) or (ColIndx = -1) then
        begin
          XLSBlankF[2] := TotalCount;
          XLSBlankF[3] := GroupColumnCount + i;
          Stream.WriteBuffer(XLSBlankF, SizeOf(XLSBlankF));
        end
        else
        begin
          XLSFormula[2] := TotalCount;
          XLSFormula[3] := GroupColumnCount + i;
          XLSFormula[11] := $25;
          if ShowBands then XLSFormula[11] := XLSFormula[11] + $100;
          if ShowHeader then XLSFormula[11] := XLSFormula[11] + $100;
          XLSFormula[12] := ((TotalCount - 1) shl 8) + $C0;
          XLSFormula[13] := ((GroupColumnCount + ColIndx) shl 8) + (((TotalCount - 1) shr 8) or $C0);
          if SummaryFooterType = cstSum then
             XLSFormula[14] := $1900 + GroupColumnCount + ColIndx
          else XLSFormula[14] := $4200 + GroupColumnCount + ColIndx;
          Stream.WriteBuffer(XLSFormula, SizeOf(XLSFormula));
          b := 0;
          Stream.WriteBuffer(b, SizeOf(b));
        end;
      end;
    end;
  end;
end;

procedure TdxDBGridExportExcel.DoEndWriting;
begin
  Stream.WriteBuffer(XLSEOF, SizeOf(XLSEOF));
end;

{TdxDBGridExportHTML}
procedure TdxDBGridExportHTML.GetFontStyle(AFont: TFont; var SBegin, SEnd: string);
begin
  SBegin := '';
  if (fsBold in AFont.Style) then SBegin := SBegin + '<B>';
  if (fsItalic in AFont.Style) then SBegin := SBegin + '<I>';
  if (fsUnderline in AFont.Style) then SBegin := SBegin + '<U>';
  if (fsStrikeOut in AFont.Style) then SBegin := SBegin + '<STRIKE>';
  SEnd := '';
  if (fsStrikeOut in AFont.Style) then SEnd := SEnd + '</STRIKE>';
  if (fsUnderline in AFont.Style) then SEnd := SEnd + '</U>';
  if (fsItalic in AFont.Style) then SEnd := SEnd + '</I>';
  if (fsBold in AFont.Style) then SEnd := SEnd + '</B>';
end;

function TdxDBGridExportHTML.GetHTMLAlignment(AAlignment: TAlignment): String;
begin
  case AAlignment of
    taLeftJustify: Result := 'LEFT';
    taCenter: Result := 'CENTER';
    taRightJustify: Result := 'RIGHT';
  end;
end;

procedure TdxDBGridExportHTML.Write(const S: string);
begin
  Stream.WriteBuffer(Pointer(S)^, Length(S));
end;

procedure TdxDBGridExportHTML.WriteLn(S: string);
begin
  S := S + #13#10;
  Stream.WriteBuffer(Pointer(S)^, Length(S));
end;

procedure TdxDBGridExportHTML.DoBeginWriting;
var
  S, St: string;
begin
  // HTML Header
  WriteLn('<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">');
  WriteLn('<HTML>');
  WriteLn('<HEAD>');
  Write('<TITLE>');
  Write(Grid.Name);
  Writeln('</TITLE> ');
  Writeln('<STYLE>');
  Writeln('<!--');
  S := '.Band{font-family: ';
  S := S + Grid.BandFont.Name;
  S := S + '; font-size: ';
  S := S + IntToStr(Grid.BandFont.Size);
  S := S + 'pt; color: #';
  if Grid.BandFont.Color = clNone then
    St := '000000'
  else
    St := IntToHex(ColorToRGB(Grid.BandFont.Color), 6);
  S := S + Copy(St, 5, 2) + Copy(St, 3, 2) + Copy(St, 1, 2);
  S := S + '}';
  Writeln(S);
  S := '.Header{font-family: ';
  S := S + Grid.HeaderFont.Name;
  S := S + '; font-size: ';
  S := S + IntToStr(Grid.HeaderFont.Size);
  S := S + 'pt; color: #';
  if Grid.HeaderFont.Color = clNone then
    St := '000000'
  else
    St := IntToHex(ColorToRGB(Grid.HeaderFont.Color), 6);
  S := S + Copy(St, 5, 2) + Copy(St, 3, 2) + Copy(St, 1, 2);
  S := S + '}';
  Writeln(S);
  S := '.Footer{font-family: ';
  S := S + Grid.Font.Name;
  S := S + '; font-size: ';
  S := S + IntToStr(Grid.Font.Size);
  S := S + 'pt; color: #';
  if Grid.Font.Color = clNone then
    St := '000000'
  else
    St := IntToHex(ColorToRGB(Grid.Font.Color), 6);
  S := S + Copy(St, 5, 2) + Copy(St, 3, 2) + Copy(St, 1, 2);
  S := S + '}';
  Writeln(S);
  S := '.RowFooter{font-family: ';
  S := S + Grid.Font.Name;
  S := S + '; font-size: ';
  S := S + IntToStr(Grid.Font.Size);
  S := S + 'pt; color: #';
  if Grid.RowFooterTextColor = clNone then
    St := '000000'
  else
    St := IntToHex(ColorToRGB(Grid.RowFooterTextColor), 6);
  S := S + Copy(St, 5, 2) + Copy(St, 3, 2) + Copy(St, 1, 2);
  S := S + '}';
  Writeln(S);
  S := '.Group{font-family: ';
  S := S + Grid.Font.Name;
  S := S + '; font-size: ';
  S := S + IntToStr(Grid.Font.Size);
  S := S + 'pt; color: #';
  if Grid.GroupNodeTextColor = clNone then
    St := '000000'
  else
    St := IntToHex(ColorToRGB(Grid.GroupNodeTextColor), 6);
  S := S + Copy(St, 5, 2) + Copy(St, 3, 2) + Copy(St, 1, 2);
  S := S + '}';
  Writeln(S);
  Writeln('-->');
  Writeln('</STYLE>');
  Writeln('</HEAD> ');
  Writeln('<BODY BGCOLOR=#C0C0C0>');
  // Table
  if Grid.BorderStyle = bsSingle then
    Writeln('<TABLE BORDER=1 CELLSPACING=0 CELLPADDING=1 BGCOLOR=#C0C0C0><TR><TD>');
  S := '<TABLE ';
  if Grid.ShowGrid then
    if Grid.Ctl3D then S := S + 'BORDER=1 CELLSPACING=0 CELLPADDING=1'
    else S := S + 'BORDER=0 CELLSPACING=1 CELLPADDING=2'
  else S := S + 'BORDER=0 CELLSPACING=0 CELLPADDING=2';
  S := S + ' BGCOLOR=#C0C0C0>';
  Writeln(S);
end;

procedure TdxDBGridExportHTML.DoWriteHeader;
var
  S, St, St1: string;
  i, j, k, AI: Integer;
begin
  with Grid do
  begin
    // Draw Bands
    if ShowBands then
    begin
      S := '<TR VALIGN="TOP" class="Band" BGCOLOR=#';
      if Grid.BandColor = clNone then
        St := '000000'
      else
        St := IntToHex(ColorToRGB(Grid.BandColor), 6);
      S := S + Copy(St, 5, 2) + Copy(St, 3, 2) + Copy(St, 1, 2) + '>';
      Write(S);
      GetFontStyle(BandFont, St, St1);
      if GroupColumnCount > 0 then
      begin
        S := '<TD NOWRAP WIDTH=10 COLSPAN=';
        S := S + IntToStr(GroupColumnCount)+'></TD>';
        Write(S);
      end;
      for i := 0 to GetBandCount - 1 do
      begin
        k := 0;
        for j := 0 to GetHeaderRowCount(i) - 1 do
          k := k + GetHeaderColCount(i,j);
        S := '<TD NOWRAP COLSPAN=' + IntToStr(k);
        S := S + ' ALIGN="' + GetHTMLAlignment(GetBandAlignment(i));
        S := S + '" HEIGHT=' + IntToStr(BandPanelHeight) + '>';
        if GetBandText(i) = '' then
          S := S + '&nbsp;'
        else
          S := S + St + GetBandText(i) + St1;
        S := S + '</TD>';
        Write(S);
      end;
      Writeln('</TR>');
    end;
    // Draw Headers
    if ShowHeader then
    begin
      S := '<TR VALIGN="TOP" class="Header" BGCOLOR=#';
      if Grid.HeaderColor = clNone then
        St := '000000'
      else
        St := IntToHex(ColorToRGB(Grid.HeaderColor), 6);
      S := S + Copy(St, 5, 2) + Copy(St, 3, 2) + Copy(St, 1, 2) + '>';
      Write(S);
      if GroupColumnCount > 0 then
      begin
        S := '<TD NOWRAP WIDTH=10 COLSPAN=';
        S := S + IntToStr(GroupColumnCount)+'></TD>';
        Write(S);
      end;
      GetFontStyle(HeaderFont, St, St1);
      for i := 0 to  GetBandCount - 1 do
        for j := 0 to GetHeaderRowCount(i) - 1 do
          for k := 0 to GetHeaderColCount(i, j) - 1 do
          begin
            AI := GetHeaderAbsoluteIndex(i,j,k);
            if IsHeaderVisible(AI) then
            begin
              S := '<TD NOWRAP WIDTH=' + IntToStr(GetHeaderBoundsWidth(AI));
              S := S + ' ALIGN="' + GetHTMLAlignment(GetHeaderAlignment(AI)) + '">';
              if (Columns[AI].Caption = '') or Columns[AI].DisableCaption then
                S := S + '&nbsp;'
              else
                S := S + St + Columns[AI].Caption{GetHeaderText(AI)} + St1;
              S := S + '</TD>';
              Write(S);
            end;
          end;
      Writeln('</TR>');
    end;
  end;
end;

procedure TdxDBGridExportHTML.DoEndWriting;
begin
  Writeln('</TABLE>');
  if Grid.BorderStyle = bsSingle then
    Writeln('</TD></TR></TABLE>');
  Writeln('</BODY>');
  Writeln('</HTML>');
end;

procedure TdxDBGridExportHTML.DoWriteFooter;
var
  S, S1, St, St1: string;
  i, j, k, AI: Integer;
begin
  with Grid do
  if ShowSummaryFooter and not IsGridMode then
  begin
    S := '<TR class="Footer" BGCOLOR=#';
    if HeaderColor = clNone then
      St := '000000'
    else
      St := IntToHex(ColorToRGB(HeaderColor), 6);
    S := S + Copy(St, 5, 2) + Copy(St, 3, 2) + Copy(St, 1, 2) + '>';
    Write(S);
    GetFontStyle(Font, St, St1);
    if GroupColumnCount > 0 then
    begin
      S := '<TD NOWRAP WIDTH=10 COLSPAN=';
      S := S + IntToStr(GroupColumnCount)+'></TD>';
      Write(S);
    end;
    for i := 0 to  GetBandCount - 1 do
      for j := 0 to GetHeaderRowCount(i) - 1 do
        for k := 0 to GetHeaderColCount(i, j) - 1 do
        begin
          AI := GetHeaderAbsoluteIndex(i,j,k);
          if IsHeaderVisible(AI) then
            with Columns[AI] do
            begin
              S := '<TD NOWRAP ALIGN="';
              S := S + GetHTMLAlignment(Alignment) + '">';
              GetFontStyle(Font, St, St1);
              S1 := Columns[AI].SummaryFooterText;
              if S1 = '' then
                S1 := S1
              else S := S + St + S1 + St1;
              S := S + '</TD>';
              Write(S);
            end;
        end;
  Writeln('</TR>');
  end;
end;

procedure TdxDBGridExportHTML.DoWriteRecord(Node: TdxTreeListNode);
var
  S, S1, St, St1: string;
  i, j, k, AI, FI: Integer;
  V: Variant;
begin
  with Grid do
  begin
    // group ident
    if (Node <> nil) and (Node.HasChildren) then
    begin
      S := '<TR class="Group" BGCOLOR=#';
      Write(S);
      if GroupNodeColor = clNone then
        St := '000000'
      else
        St := IntToHex(ColorToRGB(GroupNodeColor), 6);
      S := Copy(St, 5, 2) + Copy(St, 3, 2) + Copy(St, 1, 2) + '>';
      Write(S);
      GetFontStyle(Font, St, St1);
      for i := 0 to Node.Level - 1 do
      begin
        Write('<TD NOWRAP BGCOLOR=#');
        if GroupNodeColor = clNone then
          St := '000000'
        else
          St := IntToHex(ColorToRGB(GroupNodeColor), 6);
        S := Copy(St, 5, 2) + Copy(St, 3, 2) + Copy(St, 1, 2) + ' WIDTH=10></TD>';
        Write(S);
      end;
    end
    else
    begin
      Write('<TR>');
      for i := 0 to GroupColumnCount - 1 do
      begin
        Write('<TD NOWRAP BGCOLOR=#');
        if GroupNodeColor = clNone then
          St := '000000'
        else
          St := IntToHex(ColorToRGB(GroupNodeColor), 6);
        S := Copy(St, 5, 2) + Copy(St, 3, 2) + Copy(St, 1, 2) + ' WIDTH=10></TD>';
        Write(S);
      end;
    end;
    if (Node <> nil) and (Node.HasChildren) then
    begin
      GetFontStyle(Font, St, St1);
      S := '<TD NOWRAP ALIGN="LEFT" COLSPAN=';
      S := S + IntToStr(GetVisibleHeaderCount + GroupColumnCount - Node.Level) + '>';
      S1 := Node.Strings[GroupColumns[Node.Level].Index];
      if S1 = '' then
        S := S + '&nbsp;'
      else
        S := S + St + S1 + St1;
      S := S + '</TD>';
      Write(S);
    end
    else
    begin
    for i := 0 to  GetBandCount - 1 do
      for j := 0 to GetHeaderRowCount(i) - 1 do
        for k := 0 to GetHeaderColCount(i, j) - 1 do
        begin
          AI := GetHeaderAbsoluteIndex(i,j,k);
          if IsHeaderVisible(AI) then
            with Columns[AI] do
            begin
              S := '<TD NOWRAP ALIGN="';
              S := S + GetHTMLAlignment(Alignment) + '" BGCOLOR=#';
              if Color = clNone then
                S1 := '000000'
              else
                S1 := IntToHex(ColorToRGB(Color), 6);
              S := S + Copy(S1, 5, 2) + Copy(S1, 3, 2) + Copy(S1, 1, 2) + '>';
              S := S + '<FONT STYLE="font-family: ' + Font.Name;
              S := S + '; font-size: ' + IntToStr(Font.Size);
              S := S + 'pt; color: #';
              if Font.Color = clNone then
                S1 := '000000'
              else
                S1 := IntToHex(ColorToRGB(Font.Color), 6);
              S := S + Copy(S1, 5, 2) + Copy(S1, 3, 2) + Copy(S1, 1, 2);
              S := S + '">';
              GetFontStyle(Font, St, St1);
              // Value
              if Node <> nil then
                V := Node.Values[AI]
              else
                if Field <> nil then
                  V := Field.Value
                else V := '';
              // Convert Value
              if ConvertExportValue(V, True) then
              begin
                if VarIsNull(V) then S1 := ''
                else S1 := V
              end
              else
              begin
                if Node = nil then
                  if Field <> nil then
                    S1 := Field.DisplayText
                  else S1 := ''
                else S1 := Node.Strings[AI];
              end;
//
//              S1 := '<a href="'+S1+'">' + S1 + '</a>';
//
              if S1 = '' then
                S := S + '&nbsp;'
              else
                S := S + St + S1 + St1;
              S := S + '</FONT></TD>';
              Write(S);
            end;
        end;
    end;
    Writeln('</TR>');
    for FI := 0 to GetRowFooterCount(Node) - 1 do
    with Grid do
    begin
      S := '<TR class="RowFooter" BGCOLOR=#';
      if RowFooterColor = clNone then
        St := '000000'
      else
        St := IntToHex(ColorToRGB(RowFooterColor), 6);
      S := S + Copy(St, 5, 2) + Copy(St, 3, 2) + Copy(St, 1, 2) + '>';
      Write(S);
      for i := 0 to GetNodeFooterLevel(Node,FI) do
      begin
        Write('<TD NOWRAP BGCOLOR=');
        if GroupNodeColor = clNone then
          St := '000000'
        else
          St := IntToHex(ColorToRGB(GroupNodeColor), 6);
        S := Copy(St, 5, 2) + Copy(St, 3, 2) + Copy(St, 1, 2) + ' WIDTH=10></TD>';
        Write(S);
      end;
      GetFontStyle(Font, St, St1);
      for i := 0 to  GetBandCount - 1 do
        for j := 0 to GetHeaderRowCount(i) - 1 do
          for k := 0 to GetHeaderColCount(i, j) - 1 do
          begin
            AI := GetHeaderAbsoluteIndex(i,j,k);
            if IsHeaderVisible(AI) then
            begin
              S := '<TD NOWRAP ALIGN="';
              S := S + GetHTMLAlignment(GetFooterCellAlignment(Node,AI,FI)) + '"';
              if (i = 0) and (j = 0) and (k = 0) then
                S := S + ' COLSPAN=' + IntToStr(GroupColumnCount - GetNodeFooterLevel(Node,FI));
              S := S + '>';
              S1 := GetFooterCellText(Node,AI,FI);
              if (S1 = '') or (not IsExistRowFooterCell(Node,AI,FI)) then
                S1 := '&nbsp;'
              else
                S := S + St + S1 + St1;
              S := S + '</TD>';
              Write(S);
            end;
          end;
    Writeln('</TR>');
    end;
  end;
end;

{ TdxDBGridExportText }
procedure TdxDBGridExportText.DoWriteHeader;
var
  I, C: Integer;
  S: string;
begin
  with Grid do
  begin
    S := '';
    C := GetVisibleHeaderCount;
    for I := 0 to C - 1 do
    begin
      if not Columns[GetFocusedAbsoluteIndex(I)].DisableCaption then
        S := S + Columns[GetFocusedAbsoluteIndex(I)].Caption;
      if I <> (C - 1) then
        S := S + Separator;
    end;
    Writeln(S);
    Writeln('');
  end;
end;

procedure TdxDBGridExportText.DoWriteRecord(Node: TdxTreeListNode);
var
  I, C, AbsoluteIndex: Integer;
  S, S1: string;
  V: Variant;
begin
  with Grid do
  begin
    S := '';
    if Assigned(Node) and IsRowGroup(Node) then
      S := Node.Strings[0]
    else
    begin
      C := GetVisibleHeaderCount;
      for I := 0 to C - 1 do
      begin
        AbsoluteIndex := GetFocusedAbsoluteIndex(I);
        with Columns[AbsoluteIndex] do
        begin
          if Node <> nil then
            V := Node.Values[AbsoluteIndex]
          else
            if Field <> nil then
              V := Field.Value
            else V := '';
          // Convert Value
          if ConvertExportValue(V, False) then
          begin
            if VarIsNull(V) then S1 := ''
            else S1 := V
          end
          else
          begin
            if Node = nil then
              if Field <> nil then
                S1 := Field.DisplayText
              else S1 := ''
            else S1 := Node.Strings[AbsoluteIndex];
          end;
        end;
        S := S + BeginString + S1 + EndString;
        if I <> (C - 1) then
          S := S + Separator;
      end;
    end;
    Writeln(S);
  end;
end;

procedure TdxDBGridExportText.WriteLn(S: string);
begin
  S := S + #13#10;
  Stream.WriteBuffer(Pointer(S)^, Length(S));
end;

{ TdxDBGridExportXSL }

type
  TdxDBGridExportXSL = class
  private
    FFileName: string;
    FGrid: TdxDBGridExportWrapper;
    FStream: TStream;
  protected
    procedure WriteContent;
    procedure WriteLn(S: string);
  public
    procedure Execute;
    property FileName: string read FFileName write FFileName;
    property Grid: TdxDBGridExportWrapper read FGrid write FGrid;
  end;

procedure TdxDBGridExportXSL.Execute;
begin
  FStream := TFileStream.Create(FileName, fmCreate);
  try
    WriteContent;
  finally
    FStream.Free;
    FStream := nil;
  end;
end;

procedure TdxDBGridExportXSL.WriteContent;
const
  StartIndent = '        ';

  procedure WriteRows(AGroupIndex: Integer);
  var
    I, J, K: Integer;
    AIndex: Integer;
    Indent: string;
    AColumn: TdxDBGridColumn;
  begin
    Indent := StartIndent;
    if AGroupIndex <> -1 then
    begin
      for I := 0 to AGroupIndex - 1 do
        Indent := Indent + '  ';
    end;   
    WriteLn(Format(Indent + '<TABLE style="font:%dpt %s" border="1" CELLSPACING="0" CELLPADDING="1" BGCOLOR="#FFFFFF">',
      [Grid.Font.Size, Grid.Font.Name]));
    // Header
    WriteLn(Indent + '  <THEAD style="font:bold; background-color:#C0C0C0">');
    WriteLn(Indent + '    <TR valign="top">');
    WriteLn(Indent + '      <xsl:for-each select="/GRID/COLUMNS/COLUMN">');
    WriteLn(Indent + '        <TD align="left">');
    WriteLn(Indent + '          <xsl:attribute name="width"><xsl:value-of select="@Width"/></xsl:attribute>');
    WriteLn(Indent + '          <xsl:value-of select="@Caption"/>');
    WriteLn(Indent + '        </TD>');
    WriteLn(Indent + '      </xsl:for-each>');
    WriteLn(Indent + '    </TR>');
    WriteLn(Indent + '  </THEAD>');
    // Rows
    if AGroupIndex = -1 then
      WriteLn(Indent + '  <xsl:for-each select="GRID/ROWS/ROW">')
    else
      WriteLn(Indent + '  <xsl:for-each select="ROW">');
    WriteLn(Indent + '  <TR valign="top">');
    for I := 0 to Grid.GetBandCount - 1 do
      for J := 0 to Grid.GetHeaderRowCount(I) - 1 do
        for K := 0 to Grid.GetHeaderColCount(I, J) - 1 do
        begin
          AIndex := Grid.GetHeaderAbsoluteIndex(I, J, K);
          if Grid.IsHeaderVisible(AIndex) then
          begin
            AColumn := TdxDBGridColumn(Grid.Columns[AIndex]);
            WriteLn(Indent + '    <TD align="left">');
            WriteLn(Format(Indent + '      <xsl:value-of select="@%s"/>', [GetColumnIdentifier(AColumn)]));
            WriteLn(Format(Indent + '      <xsl:if test="@%s[.='''']">&#160;</xsl:if>', [GetColumnIdentifier(AColumn)]));
            WriteLn(Indent + '    </TD>');
          end;
        end;
    WriteLn(Indent + '  </TR>');
    WriteLn(Indent + '  </xsl:for-each>');
    WriteLn(Indent + '</TABLE>');
  end;

  procedure BeginGroup(AGroupIndex: Integer);
  var
    I: Integer;
    Indent: string;
    S: string;
  begin
    Indent := StartIndent;
    for I := 0 to AGroupIndex - 1 do
      Indent := Indent + '  ';
    S := '';
    if AGroupIndex = 0 then
      S := '/GRID/GROUP'
    else
      S := 'GROUP';
    WriteLn(Format(Indent + '<xsl:for-each select="%s">', [S]));
    WriteLn(Format(Indent + '  <TABLE style="font:%dpt %s" BORDER="0" CELLSPACING="0" CELLPADDING="1" BGCOLOR="#C0C0C0">',
      [Grid.Font.Size, Grid.Font.Name]));
    WriteLn(Indent + '    <TR valign="top">');
    WriteLn(Indent + '      <TD align="left" width="20">&#160;</TD><TD align="left" width="100">'); // width="1000"
    WriteLn(Indent + '        &#160;<xsl:value-of select="@GroupText"/>');
    WriteLn(Indent + '      </TD>');
    WriteLn(Indent + '    </TR>');
    WriteLn(Indent + '    <TR valign="top">');
    WriteLn(Indent + '      <TD align="left" width="20">&#160;</TD><TD align="left" width="100">'); // width="1000"
  end;

  procedure EndGroup(AGroupIndex: Integer);
  var
    I: Integer;
    Indent: string;
  begin
    Indent := StartIndent;
    for I := 0 to AGroupIndex - 1 do
      Indent := Indent + '  ';
    WriteLn(Indent + '      </TD>');
    WriteLn(Indent + '    </TR>');
    WriteLn(Indent + '  </TABLE>');
    WriteLn(Indent + '</xsl:for-each>');
  end;

  procedure WriteSubGroups(AGroupIndex: Integer);
  begin
    if AGroupIndex = Grid.GroupColumnCount then
      WriteRows(AGroupIndex)
    else
    begin
      BeginGroup(AGroupIndex);
      WriteSubGroups(AGroupIndex + 1);
      EndGroup(AGroupIndex);
    end;
  end;

begin
  WriteLn('<?xml version="1.0"?>');
  WriteLn('<xsl:stylesheet xmlns:xsl="http://www.w3.org/TR/WD-xsl">');
  WriteLn('  <xsl:template match="/">');
  WriteLn('    <HTML>');
  WriteLn('      <BODY>');
  if Grid.GroupColumnCount = 0 then
    WriteRows(-1)
  else
    WriteSubGroups(0);
  WriteLn('      </BODY>');
  WriteLn('    </HTML>');
  WriteLn('  </xsl:template>');
  WriteLn('</xsl:stylesheet>');
end;

procedure TdxDBGridExportXSL.WriteLn(S: string);
begin
  S := S + #13#10;
  FStream.WriteBuffer(Pointer(S)^, Length(S));
end;

{ TdxDBGridExportXML }

procedure TdxDBGridExportXML.DoBeginWriting;
begin
  FIndentCharCount := 0;
  WriteLn('<?xml version = "1.0" ?>');
  WriteXSL;
  WriteDTD;
  WriteLn('<GRID ExportVersion="1.0">');
end;

procedure TdxDBGridExportXML.DoEndWriting;
begin
  WriteLn('</GRID>');
end;

procedure TdxDBGridExportXML.DoWriteHeader;
begin
  WriteBands;
  WriteColumns;
  BeginRows;
end;

procedure TdxDBGridExportXML.DoWriteFooter;
begin
  EndRows;
end;

procedure TdxDBGridExportXML.DoWriteRecord(Node: TdxTreeListNode);
begin
  if (Node <> nil) and (Node.Count > 0) then
    WriteGroup(Node)
  else
    WriteRow(Node);
end;

procedure TdxDBGridExportXML.Write(const S: string);
begin
  Stream.WriteBuffer(Pointer(S)^, Length(S));
end;

procedure TdxDBGridExportXML.WriteLn(S: string);
begin
  S := S + #13#10;
  Stream.WriteBuffer(Pointer(S)^, Length(S));
end;

procedure TdxDBGridExportXML.BeginRows;
begin
  if Grid.GroupColumnCount = 0 then
  begin
    ChangeIndent(1);
    WriteLn(GetIndentStr + '<ROWS>');
  end;
end;

procedure TdxDBGridExportXML.ChangeIndent(AValue: Integer);
begin
  Inc(FIndentCharCount, AValue);
end;

procedure TdxDBGridExportXML.CloseGroups;
begin
  while FGroupCount > 0 do
    CloseGroup;
end;

procedure TdxDBGridExportXML.CloseGroup;
begin
  WriteLn(GetIndentStr + '</GROUP>');
  Dec(FGroupCount);
  ChangeIndent(-1);
end;

procedure TdxDBGridExportXML.EndRows;
begin
  if Grid.GroupColumnCount = 0 then
  begin
    WriteLn(GetIndentStr + '</ROWS>');
    ChangeIndent(-1);
  end
  else
    CloseGroups;
end;

function TdxDBGridExportXML.GetNodeValue(ANode: TdxTreeListNode; AColumn: TdxDBGridColumn): string;
const
  DateTimeFields = [ftDate, ftTime, ftDateTime];
  SimpleFields = [ftSmallint, ftInteger, ftWord, ftBoolean, ftFloat, ftCurrency,
    ftBCD, ftDate, ftTime, ftDateTime, ftAutoInc];
var
  ATextFlag: Boolean;
  V: Variant;
begin
  if ANode <> nil then
    V := ANode.Values[AColumn.Index]
  else
    if AColumn.Field <> nil then
      V := AColumn.Field.Value
    else
      V := '';
  ATextFlag := False;
  if AColumn.ConvertExportValue(V, False{!}) then
  begin
    if VarIsNull(V) then
      Result := ''
    else
    begin
      if VarType(V) = varDate then
        Result := ConvertDateToXmlStr(V)
      else
      begin
        Result := V;
        ATextFlag := (VarType(V) = varString) and (Result <> '');
      end;
    end;
  end
  else
  begin
    if ANode = nil then
    begin
      if Assigned(AColumn.Field) then
      begin
        if (AColumn.Field.DataType in SimpleFields) and not Assigned(AColumn.Field.OnGetText) then
        begin
          if AColumn.Field.DataType in DateTimeFields then
            Result := ConvertDateToXmlStr(AColumn.Field.AsDateTime{Value})
          else
            Result := AColumn.Field.AsString;
        end
        else
        begin
          Result := AColumn.Field.DisplayText;
          ATextFlag := Result <> '';
        end;
      end
      else
        Result := '';
    end
    else
    begin
      V := ANode.Values[AColumn.Index];
      if VarType(V) = varDate then
        Result := ConvertDateToXmlStr(V)
      else
      begin
        Result := ANode.Strings[AColumn.Index];
        ATextFlag := (VarType(V) = varString) and (Result <> '');
      end;
    end;
  end;
  if not ATextFlag then ATextFlag := True; // TODO:
  if ATextFlag then
    Result := ConvertTextToXml(Result); //Format('<![CDATA[%s]]>', [Result]);
end;

function TdxDBGridExportXML.GetIndentStr: string;
var
  I: Integer;
begin
  SetLength(Result, FIndentCharCount * 2);
  for I := 1 to Length(Result) do
    Result[I] := ' ';
end;

procedure TdxDBGridExportXML.WriteBands;
var
  I: Integer;
begin
  with Grid do
  begin
    ChangeIndent(1);
    WriteLn(GetIndentStr + '<BANDS>');
    ChangeIndent(1);
    for I := 0 to GetBandCount - 1 do
    begin
      WriteLn(Format(GetIndentStr + '<BAND Index="%d" Caption="%s"></BAND>',
        [I, ConvertTextToXml(GetBandText(I))]));
    end;
    ChangeIndent(-1);
    WriteLn(GetIndentStr + '</BANDS>');
    ChangeIndent(-1);
  end;
end;

procedure TdxDBGridExportXML.WriteColumns;
var
  I, J, K: Integer;
  AIndex: Integer;
  AColumn: TdxTreeListColumn;
  S: string;
begin
  with Grid do
  begin
    ChangeIndent(1);
    WriteLn(GetIndentStr + '<COLUMNS>');
    ChangeIndent(1);
    for I := 0 to GetBandCount - 1 do
      for J := 0 to GetHeaderRowCount(I) - 1 do
        for K := 0 to GetHeaderColCount(I, J) - 1 do
        begin
          AIndex := GetHeaderAbsoluteIndex(I, J, K);
          if IsHeaderVisible(AIndex) then
          begin
            AColumn := Columns[AIndex];
            if AColumn.DisableCaption then
              S := ''
            else
              S := AColumn.Caption;
            WriteLn(Format(GetIndentStr + '<COLUMN Name="%s" Caption="%s" ' +
              'Index="%d" BandIndex="%d" RowIndex="%d" ColIndex="%d" Width="%d"></COLUMN>',
              [GetColumnIdentifier(AColumn), ConvertTextToXml(S),
              AIndex, I, J, K, AColumn.Width]));
          end;
        end;
    ChangeIndent(-1);
    WriteLn(GetIndentStr + '</COLUMNS>');
    ChangeIndent(-1);
  end;
end;

procedure TdxDBGridExportXML.WriteDTD;
var
  I: Integer;
begin
  WriteLn('<!DOCTYPE GRID [');
  Write('  <!ELEMENT GRID (BANDS, COLUMNS');
  if Grid.Count = 0 then
    WriteLn(')>')
  else
    if Grid.GroupColumnCount > 0 then
      WriteLn(', GROUP*)>')
    else
      WriteLn(', ROWS*)>');
  WriteLn('  <!ATTLIST GRID ExportVersion CDATA #REQUIRED>');
  // Bands
  WriteLn('  <!ELEMENT BANDS (BAND*)>');
  WriteLn('  <!ELEMENT BAND EMPTY>');
  WriteLn('  <!ATTLIST BAND Index CDATA #REQUIRED>');
  WriteLn('  <!ATTLIST BAND Caption CDATA #IMPLIED>');
  // Columns
  WriteLn('  <!ELEMENT COLUMNS (COLUMN*)>');
  WriteLn('  <!ELEMENT COLUMN EMPTY>');
  WriteLn('  <!ATTLIST COLUMN Name CDATA #REQUIRED>');
  WriteLn('  <!ATTLIST COLUMN Caption CDATA #IMPLIED>');
  WriteLn('  <!ATTLIST COLUMN Index CDATA #REQUIRED>');
  WriteLn('  <!ATTLIST COLUMN BandIndex CDATA #REQUIRED>');
  WriteLn('  <!ATTLIST COLUMN RowIndex CDATA #REQUIRED>');
  WriteLn('  <!ATTLIST COLUMN ColIndex CDATA #REQUIRED>');
  WriteLn('  <!ATTLIST COLUMN Width CDATA #IMPLIED>');
  // Group
  WriteLn('  <!ELEMENT GROUP (GROUP*, ROW*)>');
  WriteLn('  <!ATTLIST GROUP GroupText CDATA #IMPLIED>');
  // Rows
  WriteLn('  <!ELEMENT ROWS (ROW*)>');
  // Row
  WriteLn('  <!ELEMENT ROW EMPTY>');
  for I := 0 to Grid.ColumnCount - 1 do
    if Grid.IsHeaderVisible(I) then
      WriteLn(Format('  <!ATTLIST ROW %s CDATA #IMPLIED>', [GetColumnIdentifier(Grid.Columns[I])]));
  // Common
  WriteLn(']>');
end;

procedure TdxDBGridExportXML.WriteXSL;
var
  S, SFileName: string;
begin
  with TdxDBGridExportXSL.Create do
  try
    S := ExtractFilePath(Self.FileName);
    SFileName := ExtractFileName(Self.FileName);
    SFileName := ConvertFileNameToXml(ChangeFileExt(SFileName, '.xsl'));
    FileName := S + SFileName;
    Grid := Self.Grid;
    Execute;
  finally
    Free;
  end;
  WriteLn(Format('<?xml:stylesheet type="text/xsl" href="%s"?>', [SFileName]));
end;

procedure TdxDBGridExportXML.WriteGroup(Node: TdxTreeListNode);
var
  AColumn: TdxTreeListColumn;
  AGroupText: string; 
begin
  while Node.Level < FGroupCount do
    CloseGroup;
  ChangeIndent(1);
  AColumn := Grid.GroupColumns[Node.Level];
  AGroupText := ConvertTextToXml(Node.Strings[AColumn.Index]);
  WriteLn(Format(GetIndentStr + '<GROUP GroupText="%s">', [AGroupText]));
  Inc(FGroupCount);
end;

procedure TdxDBGridExportXML.WriteRow(Node: TdxTreeListNode);
var
  I, J, K: Integer;
  AIndex: Integer;
  AColumn: TdxDBGridColumn;
begin
  ChangeIndent(1);
  Write(GetIndentStr + '<ROW');
  for I := 0 to Grid.GetBandCount - 1 do
    for J := 0 to Grid.GetHeaderRowCount(I) - 1 do
      for K := 0 to Grid.GetHeaderColCount(I, J) - 1 do
      begin
        AIndex := Grid.GetHeaderAbsoluteIndex(I, J, K);
        if Grid.IsHeaderVisible(AIndex) then
        begin
          AColumn := TdxDBGridColumn(Grid.Columns[AIndex]);
          Write(Format(' %s="%s"', [GetColumnIdentifier(AColumn), GetNodeValue(Node, AColumn)]));
        end;
      end;
  WriteLn('></ROW>');
  ChangeIndent(-1);
end;

end.
