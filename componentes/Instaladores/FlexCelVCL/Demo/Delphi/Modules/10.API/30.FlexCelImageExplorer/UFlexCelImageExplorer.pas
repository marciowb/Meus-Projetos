unit UFlexCelImageExplorer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UExcelAdapter, XLSAdapter, UFlexCelImport, ImgList, ActnList,
  {$IFDEF FPC} LResources,{$ENDIF}
  StdCtrls, ExtCtrls, ComCtrls, ToolWin, UFlxMessages, TypInfo, ExtDlgs, UXlsPictures;

type
  TFFlexCelImageExplorer = class(TForm)
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton5: TToolButton;
    ToolButton4: TToolButton;
    ToolButton6: TToolButton;
    Actions: TActionList;
    ActionOpen: TAction;
    ActionSaveImage: TAction;
    ActionInfo: TAction;
    ActionClose: TAction;
    OpenDialog: TOpenDialog;
    ToolbarImages: TImageList;
    ToolbarImagesH: TImageList;
    ToolbarImagesD: TImageList;
    Xls: TFlexCelImport;
    XLSAdapter1: TXLSAdapter;
    Panel2: TPanel;
    ImageList: TListView;
    Splitter2: TSplitter;
    Panel3: TPanel;
    SaveDialog: TSavePictureDialog;
    Panel1: TPanel;
    cbFitImage: TCheckBox;
    ScrollBox1: TScrollBox;
    Image1: TImage;
    procedure ActionOpenExecute(Sender: TObject);
    procedure ActionCloseExecute(Sender: TObject);
    procedure ActionInfoExecute(Sender: TObject);
    procedure ActionSaveImageExecute(Sender: TObject);
    procedure ImageListChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure cbFitImageClick(Sender: TObject);
  private
    procedure OpenFile(const FileName: string);
    procedure AddPicture(const i: integer; const Pic: TStream;
      const PicType: TXlsImgTypes; const Anchor: TClientAnchor);
    procedure SetActiveSheet(const SheetName: string);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FFlexCelImageExplorer: TFFlexCelImageExplorer;

implementation

{$IFNDEF FPC}
{$R *.dfm}
{$ENDIF}

procedure TFFlexCelImageExplorer.ActionCloseExecute(Sender: TObject);
begin
  Close;
end;

procedure TFFlexCelImageExplorer.ActionInfoExecute(Sender: TObject);
begin
  ShowMessage('This example shows the images inside an xls file, and allows you to extract the non-compressed version');
end;

procedure TFFlexCelImageExplorer.ActionOpenExecute(Sender: TObject);
begin
  if not OpenDialog.Execute then exit;
  OpenFile(OpenDialog.FileName);
end;


procedure TFFlexCelImageExplorer.OpenFile(const FileName: string);
var
  i, sheet: integer;
  Pic: TStream;
  PicType: TXlsImgTypes;
  Anchor: TClientAnchor;
begin
  ImageList.OnChange := nil;
  try

    ImageList.Clear;
    Xls.OpenFile(FileName);

    for sheet := 1 to Xls.SheetCount do
    begin
      Xls.ActiveSheet := sheet;

      for i := 0 to Xls.PicturesCount - 1 do
      begin
        Pic:=TMemoryStream.Create;
        try
          Xls.GetPicture(i, Pic, PicType, Anchor);
          AddPicture(i, Pic, PicType, Anchor);
        finally
          FreeAndNil(Pic);
        end; //Finally
      end;
    end;

    Image1.Picture := nil;
  finally
    ImageList.OnChange := ImageListChange;
  end;
end;

procedure TFFlexCelImageExplorer.AddPicture(const i: integer; const Pic: TStream; const PicType: TXlsImgTypes; const Anchor: TClientAnchor);
var
  Item: TListItem;
  p: TPicture;
  Handled: boolean;
  w,h: string;
begin
  Item := ImageList.Items.Add;
  Item.Caption := Xls.ActiveSheetName;
  Item.SubItems.Add(IntToStr(i));

  p := TPicture.Create;
  try
    Pic.Position := 0;
    try
      SaveImgStreamToGraphic(Pic, PicType, p, Handled);
    except
      w := 'Error in image';
      h := w;
    end;
    if not Handled then
    begin
      w := 'Can''t convert this image';
      h := w;
    end
    else
    begin
      w := IntToStr(p.Width);
      h := IntToStr(p.Height);
    end;

  finally
    FreeAndNil(p);
  end;

  Item.SubItems.Add(w);
  Item.SubItems.Add(h);

  Item.SubItems.Add(GetEnumName(TypeInfo(TXlsImgTypes), ord(PicType)));
  Item.SubItems.Add(IntToStr(Pic.Size));
  Item.SubItems.Add(Xls.PictureName[i]);

end;

procedure TFFlexCelImageExplorer.cbFitImageClick(Sender: TObject);
begin
  if cbFitImage.Checked then
  begin
    Image1.Stretch := true;
    Image1.Align := alClient;
  end
  else
  begin
    Image1.Stretch := false;
    Image1.Align := alNone;
  end

end;

procedure TFFlexCelImageExplorer.ImageListChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
var
  ImgPos: integer;
  ImgPosStr: string;
  Pic: TMemoryStream;
  PicType: TXlsImgTypes;
  Anchor: TClientAnchor;
  Handled: boolean;
  p: TPicture;
begin
  if (Item = nil)  then exit;

  SetActiveSheet(Item.Caption);
  ImgPosStr := Item.SubItems[0];
  ImgPos := StrToInt(ImgPosStr);


  Pic := TMemoryStream.Create;
  try
    Xls.GetPicture(ImgPos, Pic, PicType, Anchor);
    Pic.Position := 0;
    p:= TPicture.Create;
    try
      SaveImgStreamToGraphic(Pic, PicType, p, Handled);
      Image1.Picture.Assign(p); //this wil copy the image, so we still have to free p.
    finally
      FreeAndNil(p);
    end;
  finally
    FreeAndNil(Pic);
  end;
end;

procedure TFFlexCelImageExplorer.SetActiveSheet(const SheetName: string);
var
  i: integer;
begin
  for i := 1 to Xls.SheetCount do
  begin
    Xls.ActiveSheet := i;
    if Xls.ActiveSheetName = SheetName then exit;
  end;

  raise Exception.Create ('Sheet not found');
end;

procedure TFFlexCelImageExplorer.ActionSaveImageExecute(Sender: TObject);
var
  ImageStream: TFileStream;
  ImgSelected: TListItem;
  Pic: TStream;
  PicType: TXlsImgTypes;
  Anchor: TClientAnchor;
  ImgPos: integer;
  ImgPosStr: string;
  Saved: boolean;
begin
  ImgSelected := ImageList.Selected;
  if (ImgSelected = nil)  then
  begin
    ShowMessage('There is no image selected.');
    exit;
  end;

  SetActiveSheet(ImgSelected.Caption);
  ImgPosStr := ImgSelected.SubItems[0];
  ImgPos := StrToInt(ImgPosStr);


  Pic := TMemoryStream.Create;
  try
    Xls.GetPicture(ImgPos, Pic, PicType, Anchor);

    case PicType of
      xli_Emf:  begin; SaveDialog.DefaultExt := 'emf'; SaveDialog.Filter := 'EMF Images|*.emf'; end;
      xli_Wmf:  begin; SaveDialog.DefaultExt := 'wmf'; SaveDialog.Filter := 'WMF Images|*.wmf'; end;
      xli_Jpeg: begin; SaveDialog.DefaultExt := 'jpg'; SaveDialog.Filter := 'JPG Images|*.jpg'; end;
      xli_Png:  begin; SaveDialog.DefaultExt := 'png'; SaveDialog.Filter := 'PNG Images|*.png'; end;
      xli_Bmp:  begin; SaveDialog.DefaultExt := 'bmp'; SaveDialog.Filter := 'BMP Images|*.bmp'; end;
      else begin; ShowMessage('Unknown image format'); exit; end;
    end;

    SaveDialog.FileName := ''; //clear old extensions

    if not SaveDialog.Execute then exit;


    ImageStream := TFileStream.Create(SaveDialog.FileName, fmCreate);
    try
      Pic.Position := 0;
      SaveImgStreamToDiskImage(Pic, PicType, ImageStream, Saved); //The disk representation for images is not the one in this stream, so we can't save directly.
      if not Saved then ShowMessage('Error saving image');
      
    finally
      FreeAndNil(ImageStream);
    end;
  finally
    FreeAndNil(Pic);
  end;

end;

{$IFDEF FPC}
initialization
{$I UFlexCelImageExplorer.lrs}
{$ENDIF}

end.
