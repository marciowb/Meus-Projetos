{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2010                    BBBBB   }

unit ppXLSRecordMso;

interface

{$I ppIfDef.pas}


uses
  Types,
  SysUtils,
  Classes,
  Graphics,
  JPEG,
{$IFDEF Delphi11}
  GIFImg,
{$ENDIF}
{$IFDEF Delphi12}
  PNGImage,
{$ENDIF}


  ppDCPmd4,
  ppFilDev,

  ppXLSRecordBif,
  ppXLSWorkbook;

type


{------------------------------------------------------------------------------
  BIF Obj records and subrecords
-------------------------------------------------------------------------------}

  // Bif Obj record
  TppBifObjRec = packed record
//   SubRecords: array of TppBifObjSubRecord
  end;

{---------- Obj Subrecords -------------------}

  TppBifObjSubHeaderRec = packed record
    Id: Word;
    DataSize: Word;
  end;

  // Common object data  - 15h
  TppBifObjCmoRec = packed record
    ObjectType: Word;
    ObjectId: Word;
    OptionFlags: Word;
    Reserved: array [0..11] of Byte;
  end;

  // End of Obj - 0h
  TppBifObjEnd = packed record
  end;

  // Clipboard format - 7h
  TppBifObjCF = packed record
    Format: Word;
  end;

  // Picture Option Flags - 8h
  TppBifObjPioGrBit = packed record
    Flags: Word;

  end;

  {TppBifWriterObjPicture}
  TppBifWriterObjPicture = class(TppBifWriterBase)
  protected
    class procedure WriteSubHeader(aStream: TStream; aRecordId, aDataSize: Word);
    class procedure WriteSubRecords(aStream: TStream; aDrawingShape: TppXLSDrawingShape);
  public
    class procedure Write(aStream: TStream; aDrawingShape: TppXLSDrawingShape);
  end;


  TppBif7ObjCommonRec = packed record
    Count: Integer;
    ObjectType: Word;
    ObjectID: Word;
    OptionFlags: Word;
    Col1: Word;
    DX1:  SmallInt; // 1024th's of cell width
    Row1: Word;
    DY1:  SmallInt;
    Col2: Word;
    DX2:  SmallInt;
    Row2: Word;
    DY2:  SmallInt;
    FmlaLen: Word;
    Reserved1: Array[0..5] of Byte;
  end;

  TppBif7ObjLineRec = packed record
    LineColorIndex: Byte;
    LineStyle: Byte;
    LineWeight: Byte;
    AutoBorder: Byte;
    EndStyle: Word;
    QuadrantIndex: Byte;
    Reserved1: Byte;
    NameLen: Byte;
    // Name: var array of Byte
    // FMLA: var array of Byte
  end;

  TppBif7ObjRectangleRec = packed record
    BackColorIndex: Byte;
    ForeColorIndex: Byte;
    FillPattern: Byte;
    AutoFill: Byte;
    LineColorIndex: Byte;
    LineStyle: Byte;
    LineWeight: Byte;
    AutoBorder: Byte;
    FrameStyle: Word;
    NameLen: Byte;
    // Name: var array of Byte
    // FMLA: var array of Byte
  end;

  {TppBif7WriterObjBase}
  TppBif7WriterObjBase = class(TppBifWriterBase)
  protected
    class procedure WriteObjCommon(aStream: TStream; aDrawingShape: TppXLSDrawingShape; aObjectType: Integer);
  end;

  {TppBifWriterObjLine}
  TppBifWriterObjLine = class(TppBif7WriterObjBase)
  protected
  public
    class procedure Write(aStream: TStream; aDrawingLine: TppXLSDrawingLine);
  end;

  {TppBifWriterObjRectangle}
  TppBifWriterObjRectangle = class(TppBif7WriterObjBase)
  protected
    class procedure WriteRectangleRec(aStream: TStream; aDrawingRectangle: TppXLSDrawingRectangle);
  public
    class procedure Write(aStream: TStream; aDrawingRectangle: TppXLSDrawingRectangle); virtual;
  end;

  {TppBifWriterObjOval}
  TppBifWriterObjOval = class(TppBifWriterObjRectangle)
  protected
  public
    class procedure Write(aStream: TStream; aDrawingRectangle: TppXLSDrawingRectangle); override;
  end;


{------------------------------------------------------------------------------
  BIF MSO records
-------------------------------------------------------------------------------}

  TppBifMsoDrawingRec = packed record
//  var DrawingData: array of Byte;
  end;

  TppBifMsoDrawingGroupRec = packed record
//  var DrawingGroupData: array of Byte;
  end;


  {TppBifWriterMsoDrawing}
  TppBifWriterMsoDrawing = class(TppBifWriterBase)
  public
    class procedure WriteContainer(aStream: TStream; aDrawingContainer: TppXLSDrawingContainerInfo; aShape: TppXLSDrawingShape); overload;
    class procedure WriteContainer(aStream: TStream; aDrawingContainer: TppXLSDrawingContainerInfo); overload;
    class procedure WriteShapeImage(aStream: TStream; aDrawingImage: TppXLSDrawingImage);
  end;

  {TppBifWriterMsoDrawingGroup}
  TppBifWriterMsoDrawingGroup = class(TppBifWriterBase)
  protected
    class procedure WriteBifDrawingGroupRec(aStream, aBlipStream: TStream; aCount: Integer);
    class procedure WriteBifDrawingGroupContinueRec(aStream, aBlipStream: TStream; aCount: Integer);
  public
    class procedure Write(aStream: TStream; aDrawingGroupInfo: TppXLSDrawingGroupInfo);
  end;



{------------------------------------------------------------------------------
  MSO Drawing records
-------------------------------------------------------------------------------}



  // common header
  TppMsofbHeaderRec = packed record
    Version: Word;
       // version:4
       // instance: 12
    RecordType: Word;
    Length: Longword;
  end;

{

  -------- MsoDrawingGroup --------------------------------


  F000 - msofbtDggContainer: Drawing Group Container
     F006 - msofbtDgg: Drawing Group Record

     F001 - msofbtBstoreContainer: BStore Container
       F007 - msofbtBSE: blip store entry record
          F018-F117 - msoftBlip: blip record

}

{ EMU - English Metric Unit:
     - 65 EMUs per twip
     - 12,700 EMUs per point
     - 914,400 EMUs per inch
}

  // Drawing Group Container
  TppMsofbtDggContainerRec = packed record
  end;

  // Drawing Group Record  F006
  TppMsofbtDggRec = packed record
    MaxShapeId: Longword;
    CountIdClusters: Longword;
    CountShapesSaved: Longword;
    CountDrawingsSaved: Longword;
//  Id Clusters[]: TppMsofbtIDClusterRec
  end;

  TppMsofbtSpIDClusterRec = packed record
    DrawingId: Longword;
    CountShapeIds: Longword;
  end;

  // BStore Container  F001
  TppMsofbtBstoreContainerRec = packed record
  end;


  // Blip Store Entry  F007
  TppMsofbtBSERec = packed record
    BlipTypeWin32: Byte;
    BlipTypeMacOS: Byte;
    BlipIdMD4: TppMD4Type;
    Tag: Word;
    Size: Longword;
    RefCount: Longword;
    FileOffset: Longword;
    Usage: Byte;
    NameLen: Byte;
    Unused2: Byte;
    Unused3: Byte;
//  Name: array of char {optional}
  end;

  TppMsoBlipBmpRec = packed record
    BlipIdMD4: TppMD4Type;
//    BipPrimaryIdMD4: TppMD4Type;   //optional
    Tag: Byte;
// Bits: array of Byte;

  end;


  TppMsoBlipMetaFileRec = packed record
    BlipIdMD4: TppMD4Type;
//    BipPrimaryIdMD4: TppMD4Type;   //optional
    SizeUncompressed: Longword;
    Bounds: TRect;
    Size: TPoint;  // EMU's
    SizeCompressed: Longword;
    CompressionType: Byte;
    FilterType: Byte;
// CompressedBits: array of Byte;

  end;

{
   -----------  MsoDrawing --------------------------------------

   // per sheet

   F002 - msofbtDgContainer: Drawing Container
     F008 - msofbtDg: Drawing Record (ID)
     F003 - msofbtSpgrContainer: Shape Group Container
       F004 - msofbtSpContainer: Shape container
       F009 - msofbtSpgr: Group shape (top level)
       F00A - msofbtSp: Shape

       // per drawing

       F004 - msofbtSpContainer: Shape Container
         F00A - msofbtSp: Shape Record (shape atom)
         F00B - msofbtOPT: count of properties, shape propery table
         F010 - msofbtClientAnchor: location of shape in host defined format
         F011 - msofbtClientData - host-specific data
}


  // Drawing Container  F002
  TppMsofbtDgContainerRec = packed record
  end;

  // Drawing Record F008
  //  - DrawingID stored in the Instance field
  TppMsofbtDgRec = packed record
    CountShapes: Longword;
    LastShapeId: Longword;
  end;

  // Shape Group Contaner  F003
  TppMsofbtSpgrContainerRec = packed record
  end;

  // Shape Container  F004
  TppMsofbtSpContainerRec = packed record
  end;

  // Group shape (top level)  F009
  TppMsofbtSpgrRec = packed record
    Bounds: TRect;
  end;

  // Shape (atom)    F00A
  TppMsofbtSpRec = packed record
    ShapeId: Longword;
    Flags: Longword;
  end;

  // Shape Property Table  F00B
  TppMsofbtOPTRec = packed record
//    Propertys[ ]: TppMsofbtOPTE
//    Data: array of bytes
  end;

  // Shape Property Table Entry
  TppMsofbtOPTERec = packed record
    PropId: Word;
    Value: Longword;
  end;

  // Client Anchor  F010
  //    http://msdn.microsoft.com/en-us/library/dd953659.aspx
  TppMsofbtClientAnchorRec = packed record
    Flags: Word;
    Col1: Word;
    DX1:  SmallInt; // 1024th's of cell width
    Row1: Word;
    DY1:  SmallInt;
    Col2: Word;
    DX2:  SmallInt;
    Row2: Word;
    DY2:  SmallInt;
  end;

  // Client Data F011
  TppMsofbtClientDataRec = packed record
  end;


  TppMsoDrawingWriterBase = class
  protected
    class procedure WriteHeader(aStream: TStream; aVersion, aRecordType: Word; aDataSize: Longword);
  end;

  {TppMsoDrawingWriterContainer}
  TppMsoDrawingWriterContainer = class(TppMsoDrawingWriterBase)
  protected
    class procedure WriteDrawingRecord(aStream: TStream; aDrawingContainer: TppXLSDrawingContainerInfo);
    class procedure WriteShapeContainerForGroup(aStream: TStream; aDrawingContainer: TppXLSDrawingContainerInfo);
    class procedure WriteShapeGroupContainer(aStream: TStream; aDrawingContainer: TppXLSDrawingContainerInfo);
    class procedure WriteShapeGroupRecord(aStream: TStream; aDrawingContainer: TppXLSDrawingContainerInfo);
    class procedure WriteShapeRecordForGroup(aStream: TStream; aDrawingContainer: TppXLSDrawingContainerInfo);
  public
    class procedure Write(aStream: TStream; aDrawingContainer: TppXLSDrawingContainerInfo);
  end;

 {TppMsoDrawingWriterShapeImage}
  TppMsoDrawingWriterShapeImage = class(TppMsoDrawingWriterBase)
  protected
    class procedure WriteClientAnchorRec(aStream: TStream; aDrawingImage: TppXLSDrawingImage);
    class procedure WriteClientDataRec(aStream: TStream);
    class procedure WriteShapePictureFrame(aStream: TStream; aDrawingImage: TppXLSDrawingImage);
    class procedure WriteShapePropTable(aStream: TStream; aDrawingImage: TppXLSDrawingImage);
    class procedure WriteShapePropTableEntries(aStream: TStream; aDrawingImage: TppXLSDrawingImage; var aPropCount: Word);
  public
    class procedure Write(aStream: TStream; aDrawingImage: TppXLSDrawingImage);
  end;


  {TppMsoDrawingWriterGroup}
  TppMsoDrawingWriterGroup = class(TppMsoDrawingWriterBase)
  protected
    class function GetBlipTypeMac(aGraphic: TGraphic): Byte;
    class function GetBlipTypeSignature(aGraphic: TGraphic): Word;
    class function GetBlipRecordType(aGraphic: TGraphic): Word;
    class function GetBlipTypeWin32(aGraphic: TGraphic): Byte;
    class function GetIdMd4(aStream: TStream): TppMD4Type;
    class procedure WriteBlipBitmapRec(aStream: TStream; aXLSBStoreEntry: TppXLSBStoreEntry);
    class procedure WriteBlipMetafileRec(aStream: TStream; aXLSBStoreEntry: TppXLSBStoreEntry);
    class procedure WriteBStoreContainer(aStream: TStream; aDrawingGroupInfo: TppXLSDrawingGroupInfo);
    class procedure WriteBStoreEntries(aStream: TStream; aDrawingGroupInfo: TppXLSDrawingGroupInfo);
    class procedure WriteBStoreEntry(aStream: TStream; aXLSBStoreEntry: TppXLSBStoreEntry);
    class procedure WriteDrawingGroupRecord(aStream: TStream; aDrawingGroupInfo: TppXLSDrawingGroupInfo);
    class procedure WriteDrawingGroupSpidClusters(aStream: TStream; aDrawingGroupInfo: TppXLSDrawingGroupInfo);
  public
    class procedure Write(aStream: TStream; aDrawingGroupInfo: TppXLSDrawingGroupInfo);
  end;





implementation

{------------------------------------------------------------------------------
  BIF Obj
-------------------------------------------------------------------------------}


{ TppBifWriterObjPicture }

class procedure TppBifWriterObjPicture.Write(aStream: TStream; aDrawingShape: TppXLSDrawingShape);
var
  lSubStream: TMemoryStream;
begin

  lSubStream := TMemoryStream.Create;

  try
    // write obj subrecords
    WriteSubRecords(lSubStream, aDrawingShape);

    WriteHeader(aStream, $5D, lSubStream.Size);

    aStream.CopyFrom(lSubStream, 0);

  finally
    lSubStream.Free;

  end;

end;

class procedure TppBifWriterObjPicture.WriteSubHeader(aStream: TStream; aRecordId, aDataSize: Word);
begin
  WriteHeader(aStream, aRecordID, aDataSize);
end;

class procedure TppBifWriterObjPicture.WriteSubRecords(aStream: TStream; aDrawingShape: TppXLSDrawingShape);
var
  lObjCmoRec: TppBifObjCmoRec;
  lFlags: Word;
begin

  // write common object data
  FillChar(lObjCmoRec, Sizeof(TppBifObjCmoRec), 0);

  lObjCmoRec.ObjectType := $8; // picture
  lObjCmoRec.ObjectId := aDrawingShape.ObjectId;
  lObjCmoRec.OptionFlags := $6011;

  WriteSubHeader(aStream, $15, SizeOf(TppBifObjCmoRec));
  aStream.Write(lObjCmoRec, SizeOf(TppBifObjCmoRec));

  // write clipboard format
  WriteSubHeader(aStream, $7, SizeOf(Word));
  lFlags := $FFFF;
  aStream.Write(lFlags, SizeOf(Word));

  // write picture option flags
  WriteSubHeader(aStream, $8, SizeOf(Word));
//  lFlags := $0001;
  lFlags := $0;
  aStream.Write(lFlags, SizeOf(Word));

  // write end
  WriteSubHeader(aStream, $0, 0);

end;



{-------------------------------------------------------------------------------

   MSO Drawing

--------------------------------------------------------------------------------}

{

  // common header
  TppMsofbHeaderRec = packed record
    Version: Word;
       // version:4
       // instance: 12
    RecordType: Word;
    Length: Longword;
  end;

}

class procedure TppMsoDrawingWriterBase.WriteHeader(aStream: TStream; aVersion, aRecordType: Word; aDataSize: Longword);
var
  lHeader: TppMsofbHeaderRec;
begin

  lHeader.Version := aVersion;
  lHeader.RecordType := aRecordType;
  lHeader.Length := aDataSize;

  aStream.Write(lHeader, SizeOf(TppMsofbHeaderRec));

end;



{

  -------- MsoDrawingGroup --------------------------------

}


class function TppMsoDrawingWriterGroup.GetBlipTypeWin32(aGraphic: TGraphic): Byte;
begin

  if (aGraphic is TMetaFile) then
    Result := $2 // msoblipEMF
{$IFDEF Delphi12}
  else if (aGraphic is TPNGImage) then
    Result := $6  // msoblipPNG
{$ENDIF}
{$IFDEF Delphi11}
  else if (aGraphic is TGifImage) then
    Result := $6 // msoblipPNG
{$ENDIF}
  else //if (aGraphic is TJPEGImage) then
    Result :=  $5; //   msoblipJPEG

end;

class function TppMsoDrawingWriterGroup.GetBlipTypeMac(aGraphic: TGraphic): Byte;
begin

  if (aGraphic is TMetaFile) then
    Result := $4 // msoblipPICT
{$IFDEF Delphi12}
  else if (aGraphic is TPNGImage) then
    Result := $6   // msoblipPNG
{$ENDIF}
{$IFDEF Delphi11}
  else if (aGraphic is TGifImage) then
    Result := $6  // msoblipPNG
{$ENDIF}
  else //if (aGraphic is TJPEGImage) then
    Result :=  $5; //   msoblipJPEG


end;

class function TppMsoDrawingWriterGroup.GetBlipTypeSignature(aGraphic: TGraphic): Word;
begin

  if (aGraphic is TMetaFile) then
    begin
      if TMetaFile(aGraphic).Enhanced then
        Result := $03D4 // msobiEMF
      else
        Result := $0216 // msobiWMF
    end
{$IFDEF Delphi12}
  else if (aGraphic is TPNGImage) then
    Result := $06E0    // msobiPNG
{$ENDIF}
{$IFDEF Delphi11}
  else if (aGraphic is TGifImage) then
    Result := $06E0   // msobiPNG
{$ENDIF}

  else //if (aGraphic is TJPEGImage) then
    Result :=  $046A;   // msobiJPEG

end;

class function TppMsoDrawingWriterGroup.GetBlipRecordType(aGraphic: TGraphic): Word;
begin

  if (aGraphic is TMetaFile) then
    begin
      if TMetaFile(aGraphic).Enhanced then
        Result := $F01A // emf
      else
        Result := $F01B // wmf
    end
{$IFDEF Delphi12}
  else if (aGraphic is TPNGImage) then
    Result := $F01E   // png
{$ENDIF}
{$IFDEF Delphi11}
  else if (aGraphic is TGifImage) then
    Result := $F01E  // jpeg
{$ENDIF}

  else //if (aGraphic is TJPEGImage) then
    Result :=  $F01D;

end;


class function TppMsoDrawingWriterGroup.GetIdMd4(aStream: TStream): TppMD4Type;
var
  lDcpMd4: TppTDCP_md4;
begin

  aStream.Position := 0;

  lDcpMd4 := TppTDCP_md4.Create(nil);

  try
    lDcpMd4.Init;
    lDcpMd4.UpdateStream(aStream, aStream.Size);
    lDcpMd4.Final(Result);

  finally
    lDcpMd4.Free;

  end;

end;


class procedure TppMsoDrawingWriterGroup.Write(aStream: TStream; aDrawingGroupInfo: TppXLSDrawingGroupInfo);
var
  lSubStream: TMemoryStream;
begin

  lSubStream := TMemoryStream.Create;

  try

    // drawing group record
    WriteDrawingGroupRecord(lSubStream, aDrawingGroupInfo);

    // bstore container
    WriteBStoreContainer(lSubStream, aDrawingGroupInfo);

    // write drawing container
    WriteHeader(aStream, $F, $F000, lSubStream.Size);

    // copy drawing stream
    aStream.CopyFrom(lSubStream, 0);

  finally
    lSubStream.Free;

  end;

end;


class procedure TppMsoDrawingWriterGroup.WriteDrawingGroupRecord(aStream: TStream; aDrawingGroupInfo: TppXLSDrawingGroupInfo);
var
  lDrawingGroupRec: TppMsofbtDggRec;
  lSubStream: TMemoryStream;
begin

  lSubStream := TMemoryStream.Create;

  // assign drawing group info
  lDrawingGroupRec.MaxShapeId :=  aDrawingGroupInfo.MaxShapeId + 1;;
  lDrawingGroupRec.CountIdClusters := aDrawingGroupInfo.SpIdClusters.Count + 1;
  lDrawingGroupRec.CountShapesSaved := aDrawingGroupInfo.ShapeCount;
  lDrawingGroupRec.CountDrawingsSaved := aDrawingGroupInfo.DrawingCount;

  lSubStream.Write(lDrawingGroupRec, SizeOf(TppMsofbtDggRec));

  WriteDrawingGroupSpidClusters(lSubStream, aDrawingGroupInfo);

  WriteHeader(aStream, $0, $F006, lSubStream.Size);

  // write spid cluster stream
  aStream.CopyFrom(lSubStream, 0);

  lSubStream.Free;

end;


class procedure TppMsoDrawingWriterGroup.WriteDrawingGroupSpidClusters(aStream: TStream; aDrawingGroupInfo: TppXLSDrawingGroupInfo);
var
  lSpidClusterRec: TppMsofbtSpIDClusterRec;
  liIndex: Integer;
begin

   // write Spid Clusters
  for liIndex := 0 to aDrawingGroupInfo.SpIdClusters.Count - 1 do
    begin
      lSpidClusterRec.DrawingId := aDrawingGroupInfo.SpIdClusters[liIndex].DrawingId;
      lSpidClusterRec.CountShapeIds := aDrawingGroupInfo.SpIdClusters[liIndex].ShapeCount;

      aStream.Write(lSpidClusterRec, SizeOf(TppMsofbtSpIDClusterRec));
    end;


end;


class procedure TppMsoDrawingWriterGroup.WriteBStoreContainer(aStream: TStream; aDrawingGroupInfo: TppXLSDrawingGroupInfo);
var
  lSubStream: TMemoryStream;
  lwVersion: Word;
begin

  lSubStream := TMemoryStream.Create;

  try

    // bstore entries
    WriteBStoreEntries(lSubStream, aDrawingGroupInfo);

    lwVersion := $F or (aDrawingGroupInfo.BStore.Count shl 4);

    // write bstore record
    WriteHeader(aStream, lwVersion, $F001, lSubStream.Size);

    // copy drawing stream
    aStream.CopyFrom(lSubStream, 0);

  finally
    lSubStream.Free;

  end;
end;

class procedure TppMsoDrawingWriterGroup.WriteBStoreEntries(aStream: TStream; aDrawingGroupInfo: TppXLSDrawingGroupInfo);
var
  liIndex: Integer;
begin

  for liIndex := 0 to aDrawingGroupInfo.BStore.Count - 1 do
    WriteBStoreEntry(aStream, aDrawingGroupInfo.BStore[liIndex]);


end;

class procedure TppMsoDrawingWriterGroup.WriteBStoreEntry(aStream: TStream; aXLSBStoreEntry: TppXLSBStoreEntry);
var
  lSubStream: TStream;
  lBStoreEntry: TppMsofbtBSERec;
  lwVersion: Word;
  liBSERecSize: Integer;
begin

  liBSERecSize := SizeOf(TppMsofbtBSERec);

  FillChar(lBStoreEntry, liBSERecSize, 0);

  lSubStream := TMemoryStream.Create;

  try

    // write image bits
     if aXLSBStoreEntry.Blip is TMetaFile  then
        WriteBlipMetafileRec(lSubStream, aXLSBStoreEntry)
      else
        WriteBlipBitmapRec(lSubStream, aXLSBStoreEntry);

    // write image record
    FillChar(lBStoreEntry, SizeOf(TppMsofbtBSERec), 0);

    lBStoreEntry.BlipTypeWin32 := GetBlipTypeWin32(aXLSBStoreEntry.Blip);
    lBStoreEntry.BlipTypeMacOS := GetBlipTypeMac(aXLSBStoreEntry.Blip);
    lBStoreEntry.BlipIdMD4 := aXLSBStoreEntry.IdMD4;
    lBStoreEntry.Tag := $FF;
    lBStoreEntry.Size := lSubStream.Size;
    lBStoreEntry.RefCount := aXLSBStoreEntry.RefCount;
    lBStoreEntry.FileOffset := $0; // none
    lBStoreEntry.Usage := $0; // msoblipUsageDefault
    lBStoreEntry.NameLen := 0; // none

    lwVersion := $2;
    lwVersion := lwVersion or (lBStoreEntry.BlipTypeWin32 shl 4);


    // write header
    WriteHeader(aStream, lwVersion, $F007, liBSERecSize + lSubStream.Size);

    // write blip entry record
    aStream.Write(lBStoreEntry, SizeOf(TppMsofbtBSERec));

    // write blip data
    aStream.CopyFrom(lSubStream, 0);


  finally
    lSubStream.Free;

  end;


end;

class procedure TppMsoDrawingWriterGroup.WriteBlipBitmapRec(aStream: TStream; aXLSBStoreEntry: TppXLSBStoreEntry);
var
  lBmpRec: TppMsoBlipBmpRec;
  lBlipStream: TMemoryStream;
  lwVersion: Word;
  lwRecordType: Word;
begin

  lBlipStream := TMemoryStream.Create;

  try
    // write bits
    aXLSBStoreEntry.Blip.SaveToStream(lBlipStream);

    // calc MD4 hash
    aXLSBStoreEntry.IdMD4 := GetIdMd4(lBlipStream);

    lBmpRec.BlipIdMD4 := aXLSBStoreEntry.IdMD4;
    lBmpRec.Tag := 0;

    lwRecordType := GetBlipRecordType(aXLSBStoreEntry.Blip);

    lwVersion := $0 or (GetBlipTypeSignature(aXLSBStoreEntry.Blip) shl 4);


    // write header
    WriteHeader(aStream, lwVersion, lwRecordType, SizeOf(TppMsoBlipBmpRec) + lBlipStream.Size);

    // write record
    aStream.Write(lBmpRec, SizeOf(TppMsoBlipBmpRec));

    // write image bits
    aStream.CopyFrom(lBlipStream, 0);


  finally
    lBlipStream.Free;

  end;


end;

class procedure TppMsoDrawingWriterGroup.WriteBlipMetafileRec(aStream: TStream; aXLSBStoreEntry: TppXLSBStoreEntry);
var
  lMetaFileRec: TppMsoBlipMetaFileRec;
  lBlipStream: TMemoryStream;
  lMetaFile: TMetaFile;
  lwRecordType: Word;
  lwVersion: Word;
begin

  FillChar(lMetaFileRec, SizeOf(TppMsoBlipMetaFileRec), 0);

  lBlipStream := TMemoryStream.Create;

  lMetaFile := TMetaFile(aXLSBStoreEntry.Blip);
  lMetaFile.Enhanced := True;

  // write bits to substream
  aXLSBStoreEntry.Blip.SaveToStream(lBlipStream);

  aXLSBStoreEntry.IdMD4 := GetIdMd4(lBlipStream);

  lMetaFileRec.BlipIdMD4 := aXLSBStoreEntry.IdMD4;
  lMetaFileRec.SizeUncompressed := lBlipStream.Size;

  lMetaFileRec.Bounds := Rect(0, 0, lMetaFile.Width, lMetaFile.Height);

  // size in EMU's, convert mm hundreds to inches to emus
  lMetaFileRec.Size.X := Round((lMetaFile.MMWidth / 25.4 / 100) * 914400);
  lMetaFileRec.Size.Y := Round((lMetaFile.MMHeight / 25.4 / 100) * 914400);

  // compress metafile stream
  TppFileDeviceUtils.CompressStream(lBlipStream);

  lMetaFileRec.SizeCompressed := lBlipStream.Size;
  lMetaFileRec.CompressionType := 0; // default is ZLib
  lMetaFileRec.FilterType := 254; // msofilterNone

  lwRecordType := GetBlipRecordType(aXLSBStoreEntry.Blip);

  lwVersion := $0 or (GetBlipTypeSignature(aXLSBStoreEntry.Blip) shl 4);

  // write header
  WriteHeader(aStream, lwVersion, lwRecordType, SizeOf(TppMsoBlipMetaFileRec) + lBlipStream.Size);

  // write record
  aStream.Write(lMetaFileRec, SizeOf(TppMsoBlipMetaFileRec));

  // write record
  aStream.CopyFrom(lBlipStream, 0);

  lBlipStream.Free;

end;

class procedure TppMsoDrawingWriterShapeImage.Write(aStream: TStream; aDrawingImage: TppXLSDrawingImage);
var
  lSubStream: TMemoryStream;
begin

  lSubStream := TMemoryStream.Create;

  try

    // shape for picture
    WriteShapePictureFrame(lSubStream, aDrawingImage);

    // shape prop table
    WriteShapePropTable(lSubStream, aDrawingImage);

    // client anchor
    WriteClientAnchorRec(lSubStream, aDrawingImage);

    // client data
    WriteClientDataRec(lSubStream);


    // write shape container for picture
    WriteHeader(aStream, $F, $F004, lSubStream.Size);

    aStream.CopyFrom(lSubStream, 0);


  finally
    lSubStream.Free;

  end;
end;



class procedure TppMsoDrawingWriterShapeImage.WriteShapePictureFrame(aStream: TStream; aDrawingImage: TppXLSDrawingImage);
var
  lShapeRec: TppMsofbtSpRec;
  liDataSize: Integer;
  lwVersion: Word;
begin

  liDataSize := SizeOf(TppMsofbtSpRec);

  lShapeRec.ShapeId := aDrawingImage.ShapeId;

  // flags: child + deleted
  lShapeRec.Flags := $A00;

  lwVersion :=  $2; // version
  lwVersion := lwVersion or ($4B shl 4); // shapetype: picture frame

  WriteHeader(aStream, lwVersion, $F00A, liDataSize);

  aStream.Write(lShapeRec, liDataSize);


end;

class procedure TppMsoDrawingWriterShapeImage.WriteShapePropTable(aStream: TStream; aDrawingImage: TppXLSDrawingImage);
var
  lSubStream: TMemoryStream;
  lwVersion: Word;
  liPropCount: Word;
begin

  lSubStream := TMemoryStream.Create;

  try

    // prop table entries
    WriteShapePropTableEntries(lSubStream, aDrawingImage, liPropCount);

    lwVersion := $3; // version
    lwVersion := lwVersion or (liPropCount shl 4); // property count

    // write header
    WriteHeader(aStream, lwVersion, $F00B, lSubStream.Size);

    aStream.CopyFrom(lSubStream, 0);


  finally
    lSubStream.Free;

  end;


end;

class procedure TppMsoDrawingWriterShapeImage.WriteShapePropTableEntries(aStream: TStream; aDrawingImage: TppXLSDrawingImage;
    var aPropCount: Word);
var
  lPropEntryRec: TppMsofbtOPTERec;
  lwBlipName: WideString;
  liSizeOfBlipName: Integer;
begin

  aPropCount := 0;

  lwBlipName := 'Picture' + IntToStr(aDrawingImage.ImageIndex);

  // add one to length, for the null terminated char
  liSizeOfBlipName := (Length(lwBlipName) + 1) * SizeOf(WideChar);

  // protection flags, 127
  lPropEntryRec.PropId := $7F;
  lPropEntryRec.Value := $01FB0080;

  aStream.Write(lPropEntryRec, SizeOf(lPropEntryRec));
  Inc(aPropCount);

  // text flags, 191
  lPropEntryRec.PropId := $BF;
  lPropEntryRec.Value := $0040004;

  aStream.Write(lPropEntryRec, SizeOf(lPropEntryRec));
  Inc(aPropCount);

  // blip id, 260
  lPropEntryRec.PropId := $104;
  lPropEntryRec.PropId := lPropEntryRec.PropId or (1 shl 14); // blip id flag

  lPropEntryRec.Value := aDrawingImage.ImageIndex + 1; // add 1

  aStream.Write(lPropEntryRec, SizeOf(lPropEntryRec));
  Inc(aPropCount);


  // blip name, 260
  lPropEntryRec.PropId := $105;
  lPropEntryRec.PropId := lPropEntryRec.PropId or (1 shl 15); // complex prop flag
  lPropEntryRec.PropId := lPropEntryRec.PropId or (1 shl 14); // XLS flips this bit too

  lPropEntryRec.Value := liSizeOfBlipName;

  aStream.Write(lPropEntryRec, SizeOf(lPropEntryRec));
  Inc(aPropCount);

  // picture flags, 319
  lPropEntryRec.PropId := $13F;
  lPropEntryRec.Value := $060000;

  aStream.Write(lPropEntryRec, SizeOf(lPropEntryRec));
  Inc(aPropCount);

  // fill flags, 447
  lPropEntryRec.PropId := $1BF;
  lPropEntryRec.Value := $110000;

  aStream.Write(lPropEntryRec, SizeOf(lPropEntryRec));
  Inc(aPropCount);

  // line flags, 511
  lPropEntryRec.PropId := $1FF;
  lPropEntryRec.Value := $180010;

  aStream.Write(lPropEntryRec, SizeOf(lPropEntryRec));
  Inc(aPropCount);

  // shape flags, 831
  lPropEntryRec.PropId := $33F;
  lPropEntryRec.Value :=  $180010;

  aStream.Write(lPropEntryRec, SizeOf(lPropEntryRec));
  Inc(aPropCount);


  // group shape name, 896
  lPropEntryRec.PropId := $380;
  lPropEntryRec.PropId := lPropEntryRec.PropId or ($1 shl 15); // complex prop flag
  lPropEntryRec.PropId := lPropEntryRec.PropId or (1 shl 14); // Excel flips this bit too
  lPropEntryRec.Value := liSizeOfBlipName;


  aStream.Write(lPropEntryRec, SizeOf(lPropEntryRec));
  Inc(aPropCount);

  // group shape description, 897
  lPropEntryRec.PropId := $381;
  lPropEntryRec.PropId := lPropEntryRec.PropId or ($1 shl 15); // complex prop flag
  lPropEntryRec.PropId := lPropEntryRec.PropId or (1 shl 14); // Excel flips this bit too
  lPropEntryRec.Value := liSizeOfBlipName;

  aStream.Write(lPropEntryRec, SizeOf(lPropEntryRec));
  Inc(aPropCount);

  // group shape flags, 959
  lPropEntryRec.PropId := $3BF;
  lPropEntryRec.Value := $020000;

  aStream.Write(lPropEntryRec, SizeOf(lPropEntryRec));
  Inc(aPropCount);

  // complex property data starts here

  // blip name
  aStream.Write(PWideChar(lwBlipName)^, liSizeOfBlipName);

  // group shape name
  aStream.Write(PWideChar(lwBlipName)^, liSizeOfBlipName);

  // group shape description
  aStream.Write(PWideChar(lwBlipName)^, liSizeOfBlipName);

end;



class procedure TppMsoDrawingWriterShapeImage.WriteClientAnchorRec(aStream: TStream; aDrawingImage: TppXLSDrawingImage);
var
  liDataSize: Integer;
  lClientAnchorRec: TppMsofbtClientAnchorRec;
begin

  liDataSize := SizeOf(TppMsofbtClientAnchorRec);

  // location and size of shape
  lClientAnchorRec.Flags := 2; // move but don't resize with cells
  lClientAnchorRec.Col1 := aDrawingImage.Col1;
  lClientAnchorRec.DX1 := aDrawingImage.Dx1;
  lClientAnchorRec.Row1 := aDrawingImage.Row1;
  lClientAnchorRec.DY1 := aDrawingImage.Dy1;
  lClientAnchorRec.Col2 := aDrawingImage.Col2;
  lClientAnchorRec.DX2 := aDrawingImage.Dx2;
  lClientAnchorRec.Row2 := aDrawingImage.Row2;
  lClientAnchorRec.DY2 := aDrawingImage.DY2;

  WriteHeader(aStream, 0, $F010, liDataSize);

  aStream.Write(lClientAnchorRec, liDatasize)

end;

class procedure TppMsoDrawingWriterShapeImage.WriteClientDataRec(aStream: TStream);
begin

  // end of shape
  WriteHeader(aStream, 0, $F011, 0);

end;

class procedure TppMsoDrawingWriterContainer.Write(aStream: TStream; aDrawingContainer: TppXLSDrawingContainerInfo);
var
  lSubStream: TMemoryStream;
begin

  lSubStream := TMemoryStream.Create;

  try

    // drawing rec
    WriteDrawingRecord(lSubStream, aDrawingContainer);

    // shape group container
    WriteShapeGroupContainer(lSubStream, aDrawingContainer);

    // write drawing container
    WriteHeader(aStream, $F, $F002, aDrawingContainer.StreamedSize);

    // copy drawing stream
    aStream.CopyFrom(lSubStream, 0);

  finally
    lSubStream.Free;

  end;

end;

class procedure TppMsoDrawingWriterContainer.WriteDrawingRecord(aStream: TStream; aDrawingContainer: TppXLSDrawingContainerInfo);
var
  lDrawingRec: TppMsofbtDgRec;
  lwVersion: Word;
begin

  lDrawingRec.CountShapes := aDrawingContainer.ShapeCount;
  lDrawingrec.LastShapeId := aDrawingContainer.MaxShapeID;

  lwVersion := $0 or (aDrawingContainer.DrawingID shl 4);

  // write drawing record
  WriteHeader(aStream, lwVersion, $F008, SizeOf(TppMsofbtDgRec));

  aStream.Write(lDrawingRec, SizeOf(TppMsofbtDgRec));

end;

class procedure TppMsoDrawingWriterContainer.WriteShapeGroupContainer(aStream: TStream; aDrawingContainer: TppXLSDrawingContainerInfo);
var
  lSubStream: TMemoryStream;
begin

  lSubStream := TMemoryStream.Create;

  try
    // shape container for group
    WriteShapeContainerForGroup(lSubStream, aDrawingContainer);

    // write shape group container
    WriteHeader(aStream, $F, $F003,  aDrawingContainer.StreamedSize - 24);

    aStream.CopyFrom(lSubStream, 0);


  finally
    lSubStream.Free;

  end;



end;

class procedure TppMsoDrawingWriterContainer.WriteShapeContainerForGroup(aStream: TStream; aDrawingContainer: TppXLSDrawingContainerInfo);
var
  lSubStream: TMemoryStream;
begin

  lSubStream := TMemoryStream.Create;

  try

    // 2 records: ShapeGroupRec and ShapeRec
    WriteShapeGroupRecord(lSubStream, aDrawingContainer);

    WriteShapeRecordForGroup(lSubStream, aDrawingContainer);

    // write shape container for group
    WriteHeader(aStream, $F, $F004, lSubStream.Size);

    aStream.CopyFrom(lSubStream, 0);


  finally
    lSubStream.Free;

  end;


end;

class procedure TppMsoDrawingWriterContainer.WriteShapeGroupRecord(aStream: TStream; aDrawingContainer: TppXLSDrawingContainerInfo);
var
  lGroupShape: TppMsofbtSpgrRec;
begin

  lGroupShape.Bounds := Rect(0,0,0,0);

  WriteHeader(aStream, $1, $F009, SizeOf(TppMsofbtSpgrRec));

  aStream.Write(lGroupShape, SizeOf(TppMsofbtSpgrRec));

end;

class procedure TppMsoDrawingWriterContainer.WriteShapeRecordForGroup(aStream: TStream; aDrawingContainer: TppXLSDrawingContainerInfo);
var
  lShapeRec: TppMsofbtSpRec;
begin

  lShapeRec.ShapeId := aDrawingContainer.PatriarchShapeID;

  lShapeRec.Flags := $5; // group or patriarch

  WriteHeader(aStream, $2, $F00A, SizeOf(TppMsofbtSpRec));

  aStream.Write(lShapeRec, SizeOf(TppMsofbtSpRec));

end;


class procedure TppBifWriterMsoDrawing.WriteContainer(aStream: TStream; aDrawingContainer: TppXLSDrawingContainerInfo; aShape: TppXLSDrawingShape);
var
  lSubStream: TMemoryStream;
begin
  lSubStream := TMemoryStream.Create;

  try
    TppMsoDrawingWriterContainer.Write(lSubStream, aDrawingContainer);

    TppMsoDrawingWriterShapeImage.Write(lSubStream, TppXLSDrawingImage(aShape));

    WriteHeader(aStream, $EC, lSubStream.Size);

    aStream.CopyFrom(lSubStream, 0);

  finally
    lSubStream.Free;

  end;


end;

class procedure TppBifWriterMsoDrawing.WriteContainer(aStream: TStream; aDrawingContainer: TppXLSDrawingContainerInfo);
begin

  TppMsoDrawingWriterContainer.Write(aStream, aDrawingContainer);

end;

class procedure TppBifWriterMsoDrawing.WriteShapeImage(aStream: TStream; aDrawingImage: TppXLSDrawingImage);
var
  lSubStream: TMemoryStream;
begin

  lSubStream := TMemoryStream.Create;

  try
    TppMsoDrawingWriterShapeImage.Write(lSubStream, aDrawingImage);

    WriteHeader(aStream, $EC, lSubStream.Size);

    aStream.CopyFrom(lSubStream, 0);

  finally
    lSubStream.Free;

  end;


end;

class procedure TppBifWriterMsoDrawingGroup.Write(aStream: TStream; aDrawingGroupInfo: TppXLSDrawingGroupInfo);
const
  cMaxBlockSize = 8224;
var
  lSubStream: TMemoryStream;
  liBytesRemaining: Integer;
  liBlockSize: Integer;
  lbFirstBlock: Boolean;
begin

  if aDrawingGroupInfo.ShapeCount <= 0 then Exit;


  lSubStream := TMemoryStream.Create;

  try

    TppMsoDrawingWriterGroup.Write(lSubStream, aDrawingGroupInfo);

    // write Bif record blocks
    liBytesRemaining := lSubStream.Size;
    lbFirstBlock := True;
    lSubStream.Position := 0;

    while liBytesRemaining > 0 do
      begin

        if liBytesRemaining > cMaxBlockSize then
          liBlockSize := cMaxBlockSize
        else
          liBlockSize := liBytesRemaining;

        if lbFirstBlock then
          WriteBifDrawingGroupRec(aStream, lSubStream, liBlockSize)
        else
          WriteBifDrawingGroupContinueRec(aStream, lSubStream, liBlockSize);

        liBytesRemaining := liBytesRemaining - liBlockSize;
        lbFirstBlock := False;

      end;

  finally
    lSubStream.Free;

  end;

end;

class procedure TppBifWriterMsoDrawingGroup.WriteBifDrawingGroupRec(aStream, aBlipStream: TStream; aCount: Integer);
begin
  WriteHeader(aStream, $EB, aCount);

  aStream.CopyFrom(aBlipStream, aCount);

end;

class procedure TppBifWriterMsoDrawingGroup.WriteBifDrawingGroupContinueRec(aStream, aBlipStream: TStream; aCount: Integer);
begin
  WriteHeader(aStream, $3C, aCount);

  aStream.CopyFrom(aBlipStream, aCount);

end;

{------------------------------------------------------------------------------
  BIF Obj
-------------------------------------------------------------------------------}


{ TppBif7WriterObjBase }

class procedure TppBif7WriterObjBase.WriteObjCommon(aStream: TStream; aDrawingShape: TppXLSDrawingShape; aObjectType: Integer);
var
  lCommonRec: TppBif7ObjCommonRec;
begin

    FillChar(lCommonRec, SizeOf(TppBif7ObjCommonRec), 0);

    lCommonRec.Count := 1;
    lCommonRec.ObjectType := aObjectType;
    lCommonRec.ObjectID := aDrawingShape.ObjectId;
    lCommonRec.OptionFlags := $0 or ($1 shl 9) or ($1 shl 10); // visible and printable
    lCommonRec.Col1 := aDrawingShape.Col1;
    lCommonRec.DX1 := aDrawingShape.Dx1;
    lCommonRec.Row1 := aDrawingShape.Row1;
    lCommonRec.DY1 := aDrawingShape.DY1;
    lCommonRec.Col2 := aDrawingShape.Col2;
    lCommonRec.DX2 := aDrawingShape.Dx2;
    lCommonRec.Row2 := aDrawingShape.Row2;
    lCommonRec.DY2 := aDrawingShape.Dy2;

    aStream.Write(lCommonRec, SizeOf(TppBif7ObjCommonRec));

end;

{ TppBifWriterObjLine }

class procedure TppBifWriterObjLine.Write(aStream: TStream; aDrawingLine: TppXLSDrawingLine);
var
  lSubStream: TMemoryStream;
  lLineRec: TppBif7ObjLineRec;
begin

  lSubStream := TMemoryStream.Create;

  try

    WriteObjCommon(lSubStream, aDrawingLine, $01);

    FillChar(lLineRec, SizeOf(TppBif7ObjLineRec), 0);

    lLineRec.LineColorIndex := aDrawingLine.LineColorIndex;
    lLineRec.LineStyle := aDrawingLine.LineStyle;
    lLineRec.LineWeight := aDrawingLine.LineWeight;
    lLineRec.QuadrantIndex := aDrawingLine.Quadrant;

    lSubStream.Write(lLineRec, SizeOf(TppBif7ObjLineRec));

    WriteHeader(aStream, $5D, lSubStream.Size);

    aStream.CopyFrom(lSubStream, 0);

  finally
    lSubStream.Free;

  end;

end;


{ TppBifWriterObjRectangle }

class procedure TppBifWriterObjRectangle.Write(aStream: TStream; aDrawingRectangle: TppXLSDrawingRectangle);
var
  lSubStream: TMemoryStream;
begin

  lSubStream := TMemoryStream.Create;

  try

    WriteObjCommon(lSubStream, aDrawingRectangle, $02);

    WriteRectangleRec(lSubStream, aDrawingRectangle);

    WriteHeader(aStream, $5D, lSubStream.Size);

    aStream.CopyFrom(lSubStream, 0);

  finally
    lSubStream.Free;

  end;

end;

class procedure TppBifWriterObjRectangle.WriteRectangleRec(aStream: TStream; aDrawingRectangle: TppXLSDrawingRectangle);
var
  lRectangleRec: TppBif7ObjRectangleRec;
begin

  FillChar(lRectangleRec, SizeOf(TppBif7ObjRectangleRec), 0);

  lRectangleRec.BackColorIndex := 1;
  lRectangleRec.ForeColorIndex := aDrawingRectangle.FillColorIndex;
  lRectangleRec.FillPattern := aDrawingRectangle.FillPattern;
  lRectangleRec.LineColorIndex := aDrawingRectangle.LineColorIndex;
  lRectangleRec.LineStyle := aDrawingRectangle.LineStyle;
  lRectangleRec.LineWeight := aDrawingRectangle.LineWeight;

  if aDrawingRectangle.RoundedCorners then
    lRectangleRec.FrameStyle := $1;

  aStream.Write(lRectangleRec, SizeOf(TppBif7ObjRectangleRec));

end;

{ TppBifWriterObjOval }

class procedure TppBifWriterObjOval.Write(aStream: TStream; aDrawingRectangle: TppXLSDrawingRectangle);
var
  lSubStream: TMemoryStream;
begin

  lSubStream := TMemoryStream.Create;

  try

    WriteObjCommon(lSubStream, aDrawingRectangle, $03);

    WriteRectangleRec(lSubStream, aDrawingRectangle);

    WriteHeader(aStream, $5D, lSubStream.Size);

    aStream.CopyFrom(lSubStream, 0);

  finally
    lSubStream.Free;

  end;

end;





end.
