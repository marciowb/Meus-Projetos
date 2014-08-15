unit ImageListEditor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ImgList, ExtCtrls, StdCtrls, Math, ExtDlgs;

type
  TEditingImage = class;
  TEditingImages = class;

  TEditingImageOption = (eioNone, eioCenter, eioCrop, eioStretch); 

  TfmImageListEditor = class(TForm)
    ImageList: TImageList;
    gbSelected: TGroupBox;
    gbImages: TGroupBox;
    lvImages: TListView;
    btAdd: TButton;
    btReplace: TButton;
    btDelete: TButton;
    btClear: TButton;
    btExport: TButton;
    btOK: TButton;
    btApply: TButton;
    btCancel: TButton;
    pnSelected: TPanel;
    imSelected: TImage;
    dlgSave: TSaveDialog;
    dlgOpen: TOpenPictureDialog;
    Label1: TLabel;
    cbTransparentColor: TComboBox;
    Label2: TLabel;
    cbFillColor: TComboBox;
    rgOptions: TRadioGroup;
    procedure lvImagesChange(Sender: TObject; Item: TListItem; Change: TItemChange);
    procedure btAddClick(Sender: TObject);
    procedure btClearClick(Sender: TObject);
    procedure btApplyClick(Sender: TObject);
    procedure btReplaceClick(Sender: TObject);
    procedure btDeleteClick(Sender: TObject);
    procedure btExportClick(Sender: TObject);
    procedure lvImagesDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
    procedure lvImagesDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cbTransparentColorDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cbTransparentColorChange(Sender: TObject);
    procedure rgOptionsClick(Sender: TObject);
    procedure cbFillColorChange(Sender: TObject);
  private
    FEditedImageList: TImageList;
    FEditingImages: TEditingImages;
    procedure AddBitmap(AFileName: string; AIndex: integer=-1);
    procedure AddIcon(AFileName: string; AIndex: integer=-1);
    procedure AddImages(AReplacing: boolean);
    procedure ChangeImage(AImageIndex: integer);
    procedure DeleteImages;
    function EditingImage: TEditingImage;
    procedure ImageListAdd(AGraphic: TGraphic; var AIndex: integer);
    procedure RefreshList(AImageIndex: integer=-1);
    procedure SelectImage(AImageIndex: integer);
    procedure SetEditedImageList(const Value: TImageList);
  public
    procedure ApplyChanges;
    property EditedImageList: TImageList read FEditedImageList write SetEditedImageList;
  end;

  TEditingImages = class(TCollection)
  private
    function GetItem(i: integer): TEditingImage;
    procedure SetItem(i: integer; const Value: TEditingImage);
  public
    constructor Create;
    function Add(AIndex: integer=-1; ABitmap: TBitmap=nil): TEditingImage;
    procedure Init(ACount: integer);
    procedure Move(AIndex1, AIndex2: integer);
    property Items[i: integer]: TEditingImage read GetItem write SetItem; default;
  end;

  TEditingImage = class(TCollectionItem)
  private
    FFillColor: TColor;
    FBitmap: TBitmap;
    FOption: TEditingImageOption;
  public
    destructor Destroy; override;
    property FillColor: TColor read FFillColor write FFillColor;
    property Option: TEditingImageOption read FOption write FOption;
    property Bitmap: TBitmap read FBitmap;
  end;

procedure EditImageList(AImageList: TImageList);

implementation

const
  COLOR_FILL           = clWhite;
  COLOR_TRANSPARENT    = clFuchsia;
  TEXT_CAPTION         = 'ImageList: %s';
  TEXT_INVALIDFORMAT   = 'Invalid file format: %s';
  TEXT_SEPARATEBITMAPS = 'Bitmap dimensions for %s are greater than ImageList dimensions. Separate into %d separate bitmaps?';

{$R *.dfm}

procedure EditImageList(AImageList: TImageList);
begin
  with TfmImageListEditor.Create(nil) do
  try
    EditedImageList := AImageList;
    if ShowModal = mrOk then
      ApplyChanges;
  finally
    Free;
  end;
end;

{ TfmImageListEditor }

function GetLVItemIndex(LV: TListView): integer;
begin
  Result := -1;
  if LV.Selected <> nil then
    Result := LV.Selected.Index;
end;

procedure SetLVItemIndex(LV: TListView; Value: integer);
begin
  if Value < 0 then
  begin
    if LV.Selected <> nil then
      LV.Selected.Selected := False
  end
  else
    LV.Items[Value].Selected := True;
end;

procedure TfmImageListEditor.ApplyChanges;
begin
  if Assigned(FEditedImageList) then
    FEditedImageList.Assign(ImageList);
end;

procedure TfmImageListEditor.RefreshList(AImageIndex: integer=-1);
var
  i: integer;
begin
  lvImages.Items.BeginUpdate;
  try
    if AImageIndex < 0 then
    begin
      AImageIndex := GetLVItemIndex(lvImages);
    end;
    lvImages.Items.Clear;
    for i:=0 to ImageList.Count-1 do
      with lvImages.Items.Add do
      begin
        Caption := IntToStr(i);
        ImageIndex := i;
      end;

    btClear.Enabled := lvImages.Items.Count > 0;
    btExport.Enabled := lvImages.Items.Count > 0;

    if (AImageIndex >= 0) and (AImageIndex < lvImages.Items.Count) then
    begin
      SetLVItemIndex(lvImages, AImageIndex)
    end
    else if lvImages.Items.Count > 0 then
      SetLVItemIndex(lvImages, 0);

    SelectImage(GetLVItemIndex(lvImages));
  finally
    lvImages.Items.EndUpdate;
  end;
end;

procedure TfmImageListEditor.SetEditedImageList(const Value: TImageList);
begin
  FEditedImageList := Value;
  if Assigned(FEditedImageList) then
  begin
    ImageList.Assign(FEditedImageList);
    FEditingImages.Init(ImageList.Count);
    Caption := Format(TEXT_CAPTION, [FEditedImageList.Name]);
    lvImages.LargeImages := ImageList;
    RefreshList;
  end;
end;

procedure TfmImageListEditor.lvImagesChange(Sender: TObject; Item: TListItem; Change: TItemChange);
begin
  if Change = ctState then
    SelectImage(GetLVItemIndex(lvImages));
end;

procedure TfmImageListEditor.btAddClick(Sender: TObject);
begin
  AddImages(False);
end;

procedure TfmImageListEditor.btClearClick(Sender: TObject);
begin
  ImageList.Clear;
  FEditingImages.Clear;
  RefreshList;
  btApply.Enabled := True;
end;

procedure TfmImageListEditor.SelectImage(AImageIndex: integer);
var
  i, j: integer;
  xcolor: string;
  img: TEditingImage;
  canedit: boolean;
begin
  img := nil;
  imSelected.Picture := nil;
  imSelected.Tag := AImageIndex;
  cbTransparentColor.Items.Clear;

  if AImageIndex >= 0 then
  begin
    ImageList.GetBitmap(AImageIndex, imSelected.Picture.Bitmap);

    if AImageIndex < FEditingImages.Count then
    begin
      img := FEditingImages[AImageIndex];

      if Assigned(img.Bitmap) then
      begin
        with img.Bitmap do
        begin
          for i:=0 to Width-1 do
            for j:=0 to Height-1 do
            begin
              xcolor := Format('%.10d', [Canvas.Pixels[i, j]]);
              if cbTransparentColor.Items.IndexOf(xcolor) < 0 then
                cbTransparentColor.Items.Add(xcolor);
            end;
        end;
      end;
    end;
  end;

  canedit := Assigned(img) and Assigned(img.Bitmap);
  cbTransparentColor.Enabled := canedit;
  cbFillColor.Items.Assign(cbTransparentColor.Items);
  cbFillColor.Enabled := canedit and ((img.Bitmap.Width < ImageList.Width) or (img.Bitmap.Height < ImageList.Height));
  rgOptions.Enabled := canedit and ((img.Bitmap.Width <> ImageList.Width) or (img.Bitmap.Height <> ImageList.Height));

  if canedit then
  begin
    cbTransparentColor.ItemIndex := cbTransparentColor.Items.IndexOf(Format('%.10d', [img.Bitmap.TransparentColor and $FFFFFF]));
    cbFillColor.ItemIndex := cbFillColor.Items.IndexOf(Format('%.10d', [img.FillColor]));
    rgOptions.ItemIndex := Ord(img.Option) - 1;
  end
  else
  begin
    cbTransparentColor.ItemIndex := -1;
    cbFillColor.ItemIndex := -1;
    rgOptions.ItemIndex := -1;
  end;

  btReplace.Enabled := AImageIndex >= 0;
  btDelete.Enabled := lvImages.SelCount > 0;
end;

procedure TfmImageListEditor.btApplyClick(Sender: TObject);
begin
  ApplyChanges;
  btApply.Enabled := False;
end;

procedure TfmImageListEditor.btReplaceClick(Sender: TObject);
begin
  AddImages(True);
end;

procedure TfmImageListEditor.btDeleteClick(Sender: TObject);
begin
  DeleteImages;
  RefreshList;
  btApply.Enabled := True;
end;

procedure TfmImageListEditor.btExportClick(Sender: TObject);
var
  total, square, i, x, y: integer;
  bmp: TBitmap;
begin
  if dlgSave.Execute then
  begin
    total := lvImages.SelCount;
    if total = 0 then
      total := ImageList.Count;
    square := Ceil(Sqrt(total));
    bmp := TBitmap.Create;
    try
      bmp.Width := ImageList.Width * square;
      bmp.Height := ImageList.Height * Ceil(total / square);
      bmp.Canvas.Brush.Color := COLOR_TRANSPARENT;
      bmp.Canvas.FillRect(Rect(0, 0, bmp.Width, bmp.Height));
      x := 0;
      y := 0;
      
      for i:=0 to ImageList.Count-1 do
        if lvImages.Items[i].Selected or (total = ImageList.Count) then
        begin                                              
          ImageList.Draw(bmp.Canvas, x, y, i);
          Inc(x, ImageList.Width);
          if x >= bmp.Width then
          begin
            x := 0;
            Inc(y, ImageList.Height);
          end;
        end;

      bmp.SaveToFile(dlgSave.FileName);
    finally
      bmp.Free;
    end;
  end;
end;

procedure TfmImageListEditor.AddBitmap(AFileName: string; AIndex: integer);
var
  bmp, bmp2: TBitmap;
  w, h, total: integer;
begin
  bmp := TBitmap.Create;
  try
    bmp.LoadFromFile(AFileName);
    if (bmp.Width <= ImageList.Width) and (bmp.Height <= ImageList.Height) then
      ImageListAdd(bmp, AIndex)
    else
    begin
      if bmp.Width mod ImageList.Width = 0 then
        w := ImageList.Width
      else
        w := bmp.Width;
      if bmp.Height mod ImageList.Height = 0 then
        h := ImageList.Height
      else
        h := bmp.Height;
      total := (bmp.Width div w) * (bmp.Height div h);

      if (total > 1) and (MessageDlg(Format(TEXT_SEPARATEBITMAPS,
        [ExtractFileName(AFileName), total]), mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
      begin
        Screen.Cursor := crHourGlass;
        bmp2 := TBitmap.Create;
        try
          bmp2.Width := w;
          bmp2.Height := h;
          w := 0;
          h := 0;
          while (w < bmp.Width) and (h < bmp.Height) do
          begin
            bmp2.Canvas.CopyRect(Rect(0, 0, bmp2.Width, bmp2.Height), bmp.Canvas, Rect(w, h, w + bmp2.Width, h + bmp2.Height));
            ImageListAdd(bmp2, AIndex);
            if w + bmp2.Width < bmp.Width then
              Inc(w, bmp2.Width)
            else
            begin
              Inc(h, bmp2.Height);
              w := 0;
            end;
          end;
        finally
          bmp2.Free;
          Screen.Cursor := crDefault;
        end;
      end
      else
        ImageListAdd(bmp, AIndex);
    end;
  finally
    bmp.Free;
  end;
end;

procedure TfmImageListEditor.AddIcon(AFileName: string; AIndex: integer);
var
  ico: TIcon;
begin
  ico := TIcon.Create;
  try
    ico.LoadFromFile(AFileName);
    ImageListAdd(ico, AIndex);
  finally
    ico.Free;
  end;
end;

procedure TfmImageListEditor.lvImagesDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := Sender = lvImages;
end;

procedure TfmImageListEditor.lvImagesDragDrop(Sender, Source: TObject; X, Y: Integer);
var
  liDrag, liDrop: TListItem;
begin
  if Sender = Source then
  begin
    liDrag := lvImages.Selected;
    liDrop := lvImages.GetItemAt(X, Y);
    if Assigned(liDrag) and Assigned(liDrop) and (liDrag <> liDrop) then
    begin
      ImageList.Move(liDrag.Index, liDrop.Index);
      FEditingImages.Move(liDrag.Index, liDrop.Index);
      lvImages.Selected := nil;
      lvImages.ItemFocused := liDrop;
      btApply.Enabled := True;
    end;
  end;
end;

procedure TfmImageListEditor.AddImages(AReplacing: boolean);
var
  i, idx: integer;
  fname, fext: string;
begin
  if dlgOpen.Execute then
  begin
    if AReplacing then
    begin
      idx := GetLVItemIndex(lvImages);
      DeleteImages;
      if idx >= ImageList.Count then
        idx := -1;
    end
    else
      idx := -1;

    for i:=0 to dlgOpen.Files.Count-1 do
    begin
      fname := dlgOpen.Files[i];
      if FileExists(fname) then
      begin
        fext := UpperCase(ExtractFileExt(fname));
        if fext = '.BMP' then
          AddBitmap(fname, idx)
        else if fext = '.ICO' then
          AddIcon(fname, idx)
        else
          raise Exception.CreateFmt(TEXT_INVALIDFORMAT, [fext]);
      end;
    end;

    RefreshList(ImageList.Count-1);
    btApply.Enabled := True;
  end;
end;

procedure TfmImageListEditor.DeleteImages;
var
  i: integer;
begin
  for i:=lvImages.Items.Count-1 downto 0 do
    if lvImages.Items[i].Selected then
    begin
      ImageList.Delete(i);
      FEditingImages.Delete(i);
    end;
end;

procedure TfmImageListEditor.ImageListAdd(AGraphic: TGraphic; var AIndex: integer);
var
  mcolor: TColor;
  bmp, bmpAdd: TBitmap;
  ico: TIcon;
  i: integer;
begin
  i := AIndex;
  if AGraphic is TBitmap then
  begin
    bmp := TBitmap(AGraphic);
    bmpAdd := TBitmap.Create;
    try
      mcolor := bmp.Canvas.Pixels[0, bmp.Height-1];
      bmpAdd.Width := ImageList.Width;
      bmpAdd.Height := ImageList.Height;
      bmpAdd.Canvas.StretchDraw(Rect(0, 0, ImageList.Width, ImageList.Height), bmp);
      if AIndex >= 0 then
        ImageList.InsertMasked(AIndex, bmpAdd, mcolor)
      else
        i := ImageList.AddMasked(bmpAdd, mcolor);
      FEditingImages.Add(i, bmp);
    finally
      bmpAdd.Free;
    end;
    Inc(AIndex);
  end
  else if AGraphic is TIcon then
  begin
    ico := TIcon(AGraphic);
    if AIndex >= 0 then
      ImageList.InsertIcon(AIndex, ico)
    else
      i := ImageList.AddIcon(ico);
    FEditingImages.Add(i);
  end;
end;

procedure TfmImageListEditor.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    ModalResult := mrCancel;
end;

procedure TfmImageListEditor.cbTransparentColorDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
  with TComboBox(Control) do
  begin
    if (Index >= 0) and (Index < Items.Count) then
    begin
      Canvas.Brush.Color := StrToInt(Items[Index]);
      Canvas.FillRect(Rect);
      if odSelected in State then
      begin
        Canvas.Pen.Style := psDot;
        Canvas.Pen.Color := clWhite;
        Canvas.Rectangle(Rect.Left, Rect.Top, Rect.Right, Rect.Bottom);
        Canvas.Pen.Color := clBlack;
        Canvas.Rectangle(Rect.Left+1, Rect.Top+1, Rect.Right-1, Rect.Bottom-1);
      end;
    end;
  end;
end;

procedure TfmImageListEditor.ChangeImage(AImageIndex: integer);
var
  bmp: TBitmap;
  bmpRect: TRect;
  x, y: integer;
begin
  if (AImageIndex >= 0) and (AImageIndex < FEditingImages.Count) then
  begin
    bmp := TBitmap.Create;
    try
      bmp.Width := ImageList.Width;
      bmp.Height := ImageList.height;
      bmpRect := Rect(0, 0, bmp.Width, bmp.Height);
      
      with FEditingImages[AImageIndex] do
      begin
        bmp.Canvas.Brush.Color := FillColor;
        bmp.Canvas.FillRect(bmpRect);
        case Option of
          eioCenter:
            begin
              x := (Bitmap.Width div 2) - (bmp.Width div 2);
              y := (Bitmap.Height div 2) - (bmp.Height div 2);
              bmp.Canvas.CopyRect(bmpRect, Bitmap.Canvas, Rect(x, y, x + bmp.Width, y + bmp.Height));
            end;
          eioCrop:
            bmp.Canvas.CopyRect(bmpRect, Bitmap.Canvas, Rect(0, 0, bmp.Width, bmp.Height));
          eioStretch:
            bmp.Canvas.StretchDraw(bmpRect, Bitmap);
        end;
        bmp.TransparentColor := Bitmap.TransparentColor;
      end;

      ImageList.ReplaceMasked(AImageIndex, bmp, bmp.TransparentColor);
      imSelected.Picture := nil;
      ImageList.GetBitmap(AImageIndex, imSelected.Picture.Bitmap);
      imSelected.Picture.Bitmap.TransparentColor := bmp.TransparentColor;

      btApply.Enabled := True;
    finally
      bmp.Free;
    end;
  end;
end;

function TfmImageListEditor.EditingImage: TEditingImage;
var
  index: integer;
begin
  index := imSelected.Tag;
  if (index >= 0) and (index < FEditingImages.Count) then
    result := FEditingImages[index]
  else
    result := nil;
end;

{ TEditingImage }

destructor TEditingImage.Destroy;
begin
  if Assigned(FBitmap) then
    FBitmap.Free;
  inherited;
end;

{ TEditingImages }

function TEditingImages.Add(AIndex: integer; ABitmap: TBitmap): TEditingImage;
begin
  if AIndex < 0 then
    result := TEditingImage(inherited Add)
  else
    result := TEditingImage(inherited Insert(AIndex));
  if Assigned(ABitmap) then
  begin
    result.FBitmap := TBitmap.Create;
    result.FBitmap.Assign(ABitmap);
    result.FBitmap.TransparentColor := ABitmap.Canvas.Pixels[0, ABitmap.Height-1];
    result.FillColor := COLOR_FILL;
    result.Option := eioStretch;
  end;
end;

constructor TEditingImages.Create;
begin
  inherited Create(TEditingImage);
end;

function TEditingImages.GetItem(i: integer): TEditingImage;
begin
  result := TEditingImage(inherited Items[i]);
end;

procedure TEditingImages.Init(ACount: integer);
begin
  Clear;
  while Count < ACount do
    Add;
end;

procedure TEditingImages.Move(AIndex1, AIndex2: integer);
var
  img1, img2: TEditingImage;
begin
  img1 := Items[AIndex1];
  img2 := Items[AIndex2];
  img1.SetIndex(AIndex2);
  img2.SetIndex(AIndex1);
end;

procedure TEditingImages.SetItem(i: integer; const Value: TEditingImage);
begin
  Items[i].Assign(Value);
end;

procedure TfmImageListEditor.FormCreate(Sender: TObject);
begin
  FEditingImages := TEditingImages.Create;
end;

procedure TfmImageListEditor.FormDestroy(Sender: TObject);
begin
  FEditingImages.Free;
end;

procedure TfmImageListEditor.cbTransparentColorChange(Sender: TObject);
begin
  if EditingImage <> nil then
  begin
    EditingImage.Bitmap.TransparentColor := StrToInt(cbTransparentColor.Text);
    ChangeImage(EditingImage.Index);
  end;
end;

procedure TfmImageListEditor.rgOptionsClick(Sender: TObject);
begin
  if EditingImage <> nil then
  begin
    EditingImage.Option := TEditingImageOption(rgOptions.ItemIndex + 1);
    ChangeImage(EditingImage.Index);
  end;
end;

procedure TfmImageListEditor.cbFillColorChange(Sender: TObject);
begin
  if EditingImage <> nil then
  begin
    EditingImage.FillColor := StrToInt(cbFillColor.Text);
    ChangeImage(EditingImage.Index);
  end;
end;

end.

