{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2006                    BBBBB   }

unit ppToolResources;

interface

uses
  Classes,
  Controls,
  Graphics,

  ppTypes,
  ppUtils,
  ppMetaBitmap;

type

  {@TppToolImageList }
  TppToolImageList = class(TImageList)
  private
    FToolNames: TStrings;

  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;

    procedure ExtractImageWithMask(Index: Integer; Image, Mask: TBitmap);

    function IndexOfTool(aToolName: String): Integer;
    function AddIcon(const aIconName: String): Integer;
    function AddTool(const aToolName: String): Integer; overload;
    function AddMetaBitmap(aClass: TppMetaBitmapClass): Integer; overload;
    function AddTool(const aToolName: String; aMaskColor: TColor): Integer;
        overload;
    function AddToolWithMask(const aToolName, aMaskName: String): Integer;

  end;

  function ToolImageList: TppToolImageList;


  {TppToolItemDescription}
{  TppToolItemDescription = record
    Name: String
    HintIndex: Integer;
    ImageName: String;
  end;
}

  {TppToolDescription}
{  TppToolDescription = class
  private
    FCaption: Integer;
    FName: Integer;
    function GetItemCount: Integer;

  public
    property Caption: Integer read FCaption;
    property ItemCount: Integer read GetItemCount;
    property Items[Index: Integer]: TppToolItemDescription read GetItemForIndex;
    property Name: Integer read FName;
  end;

}




const
  cAnchors: array [0..2, 0..2] of TppAnchors =
                  (([atLeft, atTop], [atTop], [atTop, atRight]),
                   ([atLeft], [], [atRight]),
                   ([atLeft, atBottom], [atBottom], [atRight, atBottom]));

  cStdColors: array [0..15] of TColor =
                  (clBlack, clGray, clMaroon, clOlive, clGreen, clTeal, clNavy, clPurple,
                   clWhite, clLtGray, clRed, clYellow,  clLime, clAqua, clBlue, clFuchsia);

  cLineStyle: array [0..4] of TPenStyle =
                  (psSolid, psDot, psDash, psDashDot, psDashDotDot);



  cAnchorResNames: array [0..8] of String =
                   ('PPANCHORLEFTTOP', 'PPANCHORTOP', 'PPANCHORRIGHTTOP', 'PPANCHORLEFT',
                    'PPANCHORNONE', 'PPANCHORRIGHT', 'PPANCHORLEFTBOTTOM', 'PPANCHORBOTTOM',
                    'PPANCHORRIGHTBOTTOM');

  cLineStyleResNames: array [0..4] of String =
                   ('PPSTYLESOLID', 'PPSTYLEDOT', 'PPSTYLEDASH', 'PPSTYLEDASHDOT', 'PPSTYLEDASHDOTDOT');

  cLineThickness: array [0..12] of Single =
                  (0.125, 0.25, 0.5, 0.75, 1.0, 1.5, 2.25, 3.0, 4.5, 6.0, 3.0, 4.5, 6.0);

  cLineThicknessStyle: array [0..12] of TppLineStyleType =
                  (lsSingle, lsSingle, lsSingle, lsSingle, lsSingle, lsSingle, lsSingle,
                   lsSingle, lsSingle, lsSingle, lsDouble, lsDouble, lsDouble);

  cLineThicknessResNames: array [0..12] of String =
                   ('PPLINE18','PPLINE14', 'PPLINE12', 'PPLINE34', 'PPLINE1', 'PPLINE112', 'PPLINE214',
                    'PPLINE3', 'PPLINE412', 'PPLINE6', 'PPDOUBLELINE3', 'PPDOUBLELINE412', 'PPDOUBLELINE6');

  cAlignNames: array [0..9] of String =
                   ('AlignLeft', 'AlignMiddle', 'AlignRight',
                    'AlignTop',  'AlignCenter',  'AlignBottom',
                    'SpaceHorizontally', 'SpaceVertically',
                     'CenterHorizontally', 'CenterVertically');


  cAlignResNames: array [0..9] of String =
                   ('PPALIGNLEFTEDGES', 'PPALIGNVERTICALCENTERS', 'PPALIGNRIGHTEDGES',
                    'PPALIGNTOPEDGES',  'PPALIGNHORIZONTALCENTERS',  'PPALIGNBOTTOMEDGES',
                    'PPSPACEHORIZONTALLY', 'PPSPACEVERTICALLY',
                    'PPCENTERHORIZONTALLY', 'PPCENTERVERTICALLY');

 { cAlignHints: array [0..9] of String =
                   ('Align Left', 'Align Middle', 'Align Right',
                    'Align Top',  'Align Center',  'Align Bottom',
                    'Space Horizontally', 'Space Vertically',
                     'Center Horizontally in Band', 'Center Vertically in Band'); }

  cAlignHints: array [0..9] of Integer =
                   (103, 106, 104,
                    105, 102, 101,
                    113, 114,
                    107, 108);

  cSizeNames: array [0..3] of String =
                   ('ShrinkWidth',  'GrowWidth',
                    'ShrinkHeight', 'GrowHeight');

  cSizeResNames: array [0..3] of String =
                   ('PPSHRINKWIDTH', 'PPGROWWIDTH', 'PPSHRINKHEIGHT', 'PPGROWHEIGHT');


 { cSizeHints: array [0..3] of String =
                   ('Shrink Width to Smallest',  'Grow Width to Largest',
                    'Shrink Height to Smallest', 'Grow Height to Largest'); }


  cSizeHints: array [0..3] of Integer = (112, 110, 111, 109);


  cNudgeResNames: array [0..3] of String =
                   ('PPNUDGEUP', 'PPNUDGEDOWN', 'PPNUDGELEFT', 'PPNUDGERIGHT');


  cNudgeItemNames: array [0..3] of String =
                   ('NudgeUp', 'NudgeDown', 'NudgeLeft', 'NudgeRight'); // do not localize

 { cNudgeHints: array [0..3] of String =
                   ('Nudge Up', 'Nudge Down', 'Nudge Left', 'Nudge Right');}

  cNudgeHints: array [0..3] of Integer = (467, 468, 469, 470);


  cFontSizes: array [0..15] of Integer =
                    (8, 9, 10, 11, 12, 14, 16, 18, 20, 22, 24, 26, 28, 36, 48, 72);


  cColorItemNames:array [0..3] of String = ('FontColor', 'LineColor', 'FillColor', 'HighlightColor' );

  cColorItemHints: array [0..3] of Integer = (480, 483, 482,  481);

  cColorResNames: array [0..3] of String  = ('PPFONTCOLOR', 'PPLINECOLOR', 'PPFILLCOLOR', 'PPHIGHLIGHTCOLOR');


  cStandardItemNames: array [0..8] of String= ('New', 'Open', 'Save', 'PageSetup', 'Print', 'PrintPreview',
                                               'Cut', 'Copy', 'Paste');

  cStandardItemResNames: array [0..8] of String = ('PPNEW', 'PPOPEN', 'PPSAVE',
                                                   'PPPAGESETUP', 'PPPRINT', 'PPPRINTPREVIEW', 'PPCUT', 'PPCOPY', 'PPPASTE');

  cStandardItemHints: array [0..8] of Integer = (156, 361, 362, 218, 022, 023, 365, 366, 367);

  cTextAlignmentNames: array [0..3] of String = ('LeftJustify', 'RightJustify', 'Center', 'FullJustify');

  cTextAlignmentResNames: array [0..3] of String = ('PPALIGNLEFT', 'PPALIGNRIGHT', 'PPALIGNCENTER', 'PPFULLJUSTIFY');

  cTextAlignmentHints: array [0..3] of Integer = (173, 176, 229, 1125);

  cFontStyleNames: array [0..2] of string = ('Bold', 'Italic', 'Underline');

  cFontStyleResNames: array [0..2] of string = ('PPBOLD', 'PPITALIC', 'PPUNDERLINE');

  cFontStyleHints: array [0..2] of Integer = (160, 171, 179);

  cZOrderNames: array [0..3] of string = ('BringForward', 'BringToFront', 'SendBackward', 'SendToBack');

  cZOrderResNames: array [0..3] of string = ('PPBRINGFORWARD', 'PPBRINGTOFRONT', 'PPSENDBACKWARD', 'PPSENDTOBACK');

  cZOrderHints: array [0..3] of Integer = (1159, 161, 1160, 177);


implementation

var
  uToolImageList: TppToolImageList;

{------------------------------------------------------------------------------}
{ ToolImageList}

function ToolImageList: TppToolImageList;
begin

  if (uToolImageList = nil) then
    begin
      uToolImageList := TppToolImageList.Create(nil);
    end;

  Result := uToolImageList;

end; {function, ToolImageList}


{******************************************************************************
 *
 **  T O O L   I M A G E    L I S T
 *
{******************************************************************************}

{ TppToolImageList.Create }

constructor TppToolImageList.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  FToolNames := TStringList.Create;

  Clear;

end;

{ TppToolImageList.Destroy }

destructor TppToolImageList.Destroy;
begin

  FToolNames.Free;

  inherited Destroy;
end;

{ TppToolImageList.IndexOfTool }

function TppToolImageList.IndexOfTool(aToolName: String): Integer;
begin
  Result := FToolNames.IndexOf(aToolName);
end;

{ TppToolImageList.AddIcon }

function TppToolImageList.AddIcon(const aIconName: String): Integer;
var
  liIndex: Integer;
  lBitmap: TBitmap;
  lMaskColor: TColor;
begin

  liIndex := IndexOfTool(aIconName);

  if liIndex >= 0 then
    Result := liIndex
  else
    begin

      Result := -1;
      lBitmap := TBitmap.Create;

      try
        lBitmap.Handle := ppBitmapFromResource(aIconName);

        if (lBitmap.Handle <> 0) then
          begin

            lBitmap.Width := Width;
            lBitmap.Height := Height;

            lMaskColor := lBitmap.Canvas.Pixels[0, lBitmap.Height-1];

            AddMasked(lBitmap, lMaskColor);

            FToolNames.Add(aIconName);

            Result := FToolNames.Count - 1;
          end;


      finally
        lBitmap.Free;


      end;
      
    end;

end;


function TppToolImageList.AddTool(const aToolName: String): Integer;
var
  liIndex: Integer;
  lBitmap: TBitmap;
  lMaskColor: TColor;
begin

  liIndex := IndexOfTool(aToolName);

  if liIndex >= 0 then
    Result := liIndex
  else
    begin

      lBitmap := TBitmap.Create;

      try
        lBitmap.Handle := ppBitmapFromResource(aToolName);

        if (lBitmap.Handle = 0) then
          lBitmap.Handle := ppBitmapFromResource('PPNOBITMAP');

        lBitmap.Width := Width;
        lBitmap.Height := Height;

        lMaskColor := lBitmap.Canvas.Pixels[0, lBitmap.Height-1];

        AddMasked(lBitmap, lMaskColor);

        FToolNames.Add(aToolName);


      finally
        lBitmap.Free;

        Result := FToolNames.Count - 1;

      end;
      
    end;


end;

function TppToolImageList.AddMetaBitmap(aClass: TppMetaBitmapClass): Integer;
var
  liIndex: Integer;
  lBitmap: TBitmap;
begin

  liIndex := IndexOfTool(aClass.ClassName);

  if liIndex >= 0 then
    Result := liIndex
  else
    begin
      lBitmap := ppGetMetaBitmap(aClass);

      try
        AddMasked(lBitmap, clSilver);
        FToolNames.Add(aClass.ClassName);
        Result := FToolNames.Count - 1;

      finally
        lBitmap.Free;
      end;

    end;


end;

function TppToolImageList.AddTool(const aToolName: String; aMaskColor: TColor):
    Integer;
var
  liIndex: Integer;
  lBitmap: TBitmap;
begin

  liIndex := IndexOfTool(aToolName);

  if liIndex >= 0 then
    Result := liIndex
  else
    begin

      lBitmap := TBitmap.Create;

      try
        lBitmap.Handle := ppBitmapFromResource(aToolName);

        if (lBitmap.Handle = 0) then
          lBitmap.Handle := ppBitmapFromResource('PPNOBITMAP');

        lBitmap.Width := Width;
        lBitmap.Height := Height;

        AddMasked(lBitmap, aMaskColor);

        FToolNames.Add(aToolName);


      finally
        lBitmap.Free;

        Result := FToolNames.Count - 1;

      end;
      
    end;


end;

{ TppToolImageList.AddToolWithMask }

function TppToolImageList.AddToolWithMask(const aToolName, aMaskName: String): Integer;
var
  lBitmap: TBitmap;
  lMask: TBitmap;
begin

  lBitmap := TBitmap.Create;
  lMask   := TBitmap.Create;

  try
    lBitmap.Handle := ppBitmapFromResource(aToolName);
    lMask.Handle := ppBitmapFromResource(aMaskName);

    Add(lBitmap, lMask);

    FToolNames.Add(aToolName);

  finally
    lBitmap.Free;
    lMask.Free;

  end;

  Result := FToolNames.Count - 1;

end;

{ TppToolImageList.ExtractImageWithMask }

procedure TppToolImageList.ExtractImageWithMask(Index: Integer; Image, Mask: TBitmap);
begin

  GetImages(Index, Image, Mask);

end;

initialization
  uToolImageList := nil;

finalization
  uToolImageList.Free;
  uToolImageList := nil;




end.
