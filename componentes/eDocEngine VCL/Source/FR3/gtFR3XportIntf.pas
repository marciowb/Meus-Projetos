{***************************************************************************}
{                                                                           }
{  Gnostice eDocEngine 		                                                  }
{                                                                           }
{  Copyright © 2002-2008 Gnostice Information Technologies Private Limited  }
{  http://www.gnostice.com                                                  }
{                                                                           }
{***************************************************************************}

{------------------------------------}
{          Editor Options            }
{------------------------------------}
{                                    }
{ Tab Stops = 2                      }
{ Use Tab Character = True           }
{                                    }
{------------------------------------}

{$I ..\gtDefines.inc}

// TO ENABLE: Remove the dot(.) before $DEFINE to look as {$DEFINE ...}
// TO DISABLE: Add a dot(.) before $DEFINE to look as {.$DEFINE ...}

// --- FastReport3 Trial Version Support ---
// ENABLE this switch for supporting Trial version of FastReport 3.
{.$DEFINE FR3Trial}

unit gtFR3XportIntf;

interface

uses
  Windows, Classes, Graphics, Controls, StdCtrls, frxClass,
	gtXportIntf, gtCstDocEng, frxRes, Dialogs, gtUtils;

type
  TgtFR3Xport_Base = class(TfrxCustomExportFilter)
  private
    FParent: TObject;
  	FEngine: TgtCustomDocumentEngine;
    FShowSaveDialog: Boolean;
    FSaveDialog: TSaveDialog;
    FMeta: TMetafile;
    FMetaCanvas: TMetafileCanvas;
    procedure SetEngine(const Value: TgtCustomDocumentEngine);
    procedure SetShowSaveDialog(const Value: Boolean);
  protected
  	property Engine: TgtCustomDocumentEngine read FEngine write SetEngine;

  public
  	constructor Create(AOwner: TComponent); override;
		destructor Destroy; override;
    function Start: Boolean; override;
    procedure StartPage(Page: TfrxReportPage; Index: Integer); override;
    procedure ExportObject(Obj: TfrxComponent); override;
    procedure FinishPage(Page: TfrxReportPage; Index: Integer); override;
    property ShowSaveDialog: Boolean read FShowSaveDialog
      write SetShowSaveDialog default True;
  end;

  TgtFR3ClipboardXport = class(TgtFR3Xport_Base)
  public
    class function GetDescription: String; override;
  end;

  TgtFR3PDFXport = class(TgtFR3Xport_Base)
  public
    class function GetDescription: String; override;
  end;

  TgtFR3RTFXport = class(TgtFR3Xport_Base)
  public
    class function GetDescription: String; override;
  end;

  TgtFR3HTMLXport = class(TgtFR3Xport_Base)
  public
    class function GetDescription: String; override;
  end;

  TgtFR3XHTMLXport = class(TgtFR3Xport_Base)
  public
    class function GetDescription: String; override;
  end;

  TgtFR3TextXport = class(TgtFR3Xport_Base)
  public
    class function GetDescription: String; override;
  end;

  TgtFR3ExcelXport = class(TgtFR3Xport_Base)
  public
    class function GetDescription: String; override;
  end;

  TgtFR3DIFXport = class(TgtFR3Xport_Base)
  public
    class function GetDescription: String; override;
  end;

  TgtFR3QuattroProXport = class(TgtFR3Xport_Base)
  public
    class function GetDescription: String; override;
  end;

  TgtFR3LotusXport = class(TgtFR3Xport_Base)
  public
    class function GetDescription: String; override;
  end;

  TgtFR3SYLKXport = class(TgtFR3Xport_Base)
  public
    class function GetDescription: String; override;
  end;

  TgtFR3BMPXport = class(TgtFR3Xport_Base)
  public
    class function GetDescription: String; override;
  end;

  TgtFR3GIFXport = class(TgtFR3Xport_Base)
  public
    class function GetDescription: String; override;
  end;

  TgtFR3JPEGXport = class(TgtFR3Xport_Base)
  public
    class function GetDescription: String; override;
  end;

  TgtFR3WMFXport = class(TgtFR3Xport_Base)
  public
    class function GetDescription: String; override;
  end;

  TgtFR3EMFXport = class(TgtFR3Xport_Base)
  public
    class function GetDescription: String; override;
  end;

  {$IFDEF gtPro}
  TgtFR3TIFFXport = class(TgtFR3Xport_Base)
  public
    class function GetDescription: String; override;
  end;

  TgtFR3PNGXport = class(TgtFR3Xport_Base)
  public
    class function GetDescription: String; override;
  end;

  TgtFR3SVGXport = class(TgtFR3Xport_Base)
  public
    class function GetDescription: String; override;
  end;
  {$ENDIF}

	TgtFR3ExportInterface = class(TgtExportInterface)
  private
    FFR3Xport: TgtFR3Xport_Base;
    FShowSaveDialog: Boolean;
    procedure SetEngine(const Value: TgtCustomDocumentEngine);
    procedure SetVisible(const Value: Boolean);
    procedure FR3Register;
    procedure FR3Unregister;
    procedure SetShowSaveDialog(const Value: Boolean);
  protected
  public
  	constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure RenderDocument(AReport: TfrxReport;
    	APrepared, AShowPreparedReport: Boolean);
  published
    property ShowSaveDialog: Boolean read FShowSaveDialog
      write SetShowSaveDialog default True;
  	property Engine write SetEngine;
    property Visible write SetVisible;
  end;

implementation

uses
	SysUtils,
  gtPDFEng, gtRTFEng, gtHTMLEng, gtXHTMLEng, gtTXTEng,
  gtXLSEng, gtQProEng, gtSLKEng, gtDIFEng, gtLotusEng,
  gtBMPEng, gtJPEGEng, gtGIFEng, gtEMFEng, gtWMFEng
{$IFDEF gtPro}
  , gtTIFFEng, gtPNGEng, gtSVGEng
{$ENDIF}
{$IFNDEF gtRE}
  ,gtClipboard
{$ENDIF}
  ;

constructor TgtFR3Xport_Base.Create(AOwner: TComponent);
begin
  inherited;
  FParent := AOwner;
  FShowSaveDialog := True;
end;

destructor TgtFR3Xport_Base.Destroy;
begin
  inherited;
end;

constructor TgtFR3ExportInterface.Create(AOwner: TComponent);
begin
  inherited;
  ShowSaveDialog := True;
end;

destructor TgtFR3ExportInterface.Destroy;
begin
  inherited;
end;

procedure TgtFR3ExportInterface.RenderDocument(AReport: TfrxReport;
	APrepared, AShowPreparedReport: Boolean);
begin
	Visible := True;
	FFR3Xport.Engine := Engine;
  FFR3Xport.Report := AReport;
  if (not APrepared) then AReport.PrepareReport;
  if (AShowPreparedReport) then
  begin
  	AReport.ShowPreparedReport;
    if (AReport.Preview <> nil) then
      AReport.Export(FFR3Xport);
  end
	else
  	AReport.Export(FFR3Xport);
end;

procedure TgtFR3ExportInterface.FR3Register;
begin
  if Engine is TgtPDFEngine then
    FFR3Xport := TgtFR3PDFXport.Create(Self)
  else if Engine is TgtRTFEngine then
    FFR3Xport := TgtFR3RTFXport.Create(Self)
  else if Engine is TgtXHTMLEngine then
    FFR3Xport := TgtFR3XHTMLXport.Create(Self)
  else if Engine is TgtHTMLEngine then
    FFR3Xport := TgtFR3HTMLXport.Create(Self)
  else if Engine is TgtJPEGEngine then
    FFR3Xport := TgtFR3JPEGXport.Create(Self)
  else if Engine is TgtGIFEngine then
    FFR3Xport := TgtFR3GIFXport.Create(Self)
  else if Engine is TgtEMFEngine then
    FFR3Xport := TgtFR3EMFXport.Create(Self)
  else if Engine is TgtWMFEngine then
    FFR3Xport := TgtFR3WMFXport.Create(Self)
  else if Engine is TgtBMPEngine then
    FFR3Xport := TgtFR3BMPXport.Create(Self)
  else if Engine is TgtExcelEngine then
    FFR3Xport := TgtFR3ExcelXport.Create(Self)
  else if Engine is TgtQuattroProEngine then
    FFR3Xport := TgtFR3QuattroProXport.Create(Self)
  else if Engine is TgtLotusEngine then
    FFR3Xport := TgtFR3LotusXport.Create(Self)
  else if Engine is TgtDIFEngine then
    FFR3Xport := TgtFR3DIFXport.Create(Self)
  else if Engine is TgtSYLKEngine then
    FFR3Xport := TgtFR3SYLKXport.Create(Self)
  else if Engine is TgtTextEngine then
    FFR3Xport := TgtFR3TextXport.Create(Self)
{$IFNDEF gtRE}
  else if Engine is TgtClipboard then
  	FFR3Xport := TgtFR3ClipboardXport.Create(Self)
{$ENDIF}
{$IFDEF gtPro}
  else if Engine is TgtSVGEngine then
    FFR3Xport := TgtFR3SVGXport.Create(Self)
  else if Engine is TgtTIFFEngine then
    FFR3Xport := TgtFR3TIFFXport.Create(Self)
  else if Engine is TgtPNGEngine then
    FFR3Xport := TgtFR3PNGXport.Create(Self)
{$ENDIF}
	;
  FFR3Xport.Engine := Engine;
  FFR3Xport.ShowSaveDialog := ShowSaveDialog;
end;

procedure TgtFR3ExportInterface.FR3Unregister;
begin
	FFR3Xport.Free;
end;

procedure TgtFR3ExportInterface.SetEngine(
  const Value: TgtCustomDocumentEngine);
begin
	if Engine <> nil then FR3Unregister;
  inherited Engine := Value;
  if ((Engine <> nil) and Visible) then FR3Register;
end;

procedure TgtFR3ExportInterface.SetVisible(const Value: Boolean);
begin
	if (Visible <> Value) then
  begin
    inherited Visible := Value;
    if (Engine <> nil) then
    begin
	    if Visible then FR3Register
    	else FR3Unregister;
    end;
  end;
end;

function TgtFR3Xport_Base.Start: Boolean;
begin
  Result := inherited Start;
  FEngine.MeasurementUnit := muPixels;
  FEngine.ReferencePoint := rpPage;
  IgtDocumentEngine(FEngine).Page.PaperSize := Custom;
  if ShowSaveDialog then
  begin
    FSaveDialog := TSaveDialog.Create(Self);
    try
      with FSaveDialog do
      begin
        Title := 'Save Document...';
        DefaultExt := IgtDocumentEngine(FEngine).FileExtension;
        FileName := IgtDocumentEngine(FEngine).FileName;
        Filter := IgtDocumentEngine(FEngine).FileDescription + '|*.' +
        	IgtDocumentEngine(FEngine).FileExtension;
        if Execute then
          IgtDocumentEngine(FEngine).FileName := FileName
        else
        	Result := False;
      end;
    finally
    	FSaveDialog.Free;
    end;
  end;
end;

procedure TgtFR3Xport_Base.StartPage(Page: TfrxReportPage; Index: Integer);
begin
  // Set Page size...
  IgtDocumentEngine(FEngine).Page.Height := Page.Height;
  IgtDocumentEngine(FEngine).Page.Width := Page.Width;
  if (Index = 0) then
  begin
    if FParent is TgtFR3ExportInterface then
    	TgtFR3ExportInterface(FParent).StartDocument
    else
      IgtDocumentEngine(FEngine).BeginDoc;
  end
  else
    IgtDocumentEngine(FEngine).NewPage;
  if (Page.BackPicture <> nil) and (Page.BackPicture.Graphic <> nil) and
    (not Page.BackPicture.Graphic.Empty) then
  begin
    IgtDocumentEngine(FEngine).ImageSettings.Stretch := True;
    IgtDocumentEngine(FEngine).DrawImage(gtRect(0, 0,
      IgtDocumentEngine(FEngine).Page.Width, IgtDocumentEngine(FEngine).Page.Height),
      Page.BackPicture.Graphic);
  end;
  FMeta := TMetafile.Create;
  FMeta.Height := Round(Page.Height);
  FMeta.Width := Round(Page.Width);
  FMetaCanvas := TMetafileCanvas.Create(FMeta, 0);
end;

procedure TgtFR3Xport_Base.ExportObject(Obj: TfrxComponent);
begin
  if (Engine.EngineStatus <> esStarted) then Exit;
  if Obj is TfrxView then
    if Obj.Name <> '_pagebackground' then // for PictureView
      TfrxView(Obj).Draw(FMetaCanvas, 1, 1, 0, 0);
end;

procedure TgtFR3Xport_Base.FinishPage(Page: TfrxReportPage; Index: Integer);
begin
  inherited;
  FMetaCanvas.Free;
  IgtDocumentEngine(FEngine).PlayMetafile(FMeta);
  FMeta.Free;
  if (Index = Report.PreviewPages.Count - 1)
    {$IFDEF FR3Trial} or (Index = 4) {$ENDIF} then
  begin
    if FParent is TgtFR3ExportInterface then
      TgtFR3ExportInterface(FParent).EndDocument
    else
    	IgtDocumentEngine(FEngine).EndDoc;
  end;
end;

procedure TgtFR3Xport_Base.SetEngine(const Value: TgtCustomDocumentEngine);
begin
  FEngine := Value;
  with IgtDocumentEngine(Engine) do
  begin
    frxResources.Add(Engine.ClassName,
      FileDescription + ' (*.' + FileExtension + ')');
  end
end;

{ TgtFR3ClipboardXport }

class function TgtFR3ClipboardXport.GetDescription: String;
begin
  Result := frxResources.Get('TgtClipboard');
end;

{ TgtFR3PDFXport }

class function TgtFR3PDFXport.GetDescription: String;
begin
  Result := frxResources.Get('TgtPDFEngine');
end;

{ TgtFR3RTFXport }

class function TgtFR3RTFXport.GetDescription: String;
begin
  Result := frxResources.Get('TgtRTFEngine');
end;

{ TgtFR3HTMLXport }

class function TgtFR3HTMLXport.GetDescription: String;
begin
  Result := frxResources.Get('TgtHTMLEngine');
end;

{ TgtFR3XHTMLXport }

class function TgtFR3XHTMLXport.GetDescription: String;
begin
  Result := frxResources.Get('TgtXHTMLEngine');
end;

{ TgtFR3TextXport }

class function TgtFR3TextXport.GetDescription: String;
begin
  Result := frxResources.Get('TgtTextEngine');
end;

{ TgtFR3ExcelXport }

class function TgtFR3ExcelXport.GetDescription: String;
begin
  Result := frxResources.Get('TgtExcelEngine');
end;

{ TgtFR3DIFXport }

class function TgtFR3DIFXport.GetDescription: String;
begin
  Result := frxResources.Get('TgtDIFEngine');
end;

{ TgtFR3QuattroProXport }

class function TgtFR3QuattroProXport.GetDescription: String;
begin
  Result := frxResources.Get('TgtQuattroProEngine');
end;

{ TgtFR3LotusXport }

class function TgtFR3LotusXport.GetDescription: String;
begin
  Result := frxResources.Get('TgtLotusEngine');
end;

{ TgtFR3SYLKXport }

class function TgtFR3SYLKXport.GetDescription: String;
begin
  Result := frxResources.Get('TgtSYLKEngine');
end;

{ TgtFR3BMPXport }

class function TgtFR3BMPXport.GetDescription: String;
begin
  Result := frxResources.Get('TgtBMPEngine');
end;

{ TgtFR3GIFXport }

class function TgtFR3GIFXport.GetDescription: String;
begin
  Result := frxResources.Get('TgtGIFEngine');
end;

{ TgtFR3JPEGXport }

class function TgtFR3JPEGXport.GetDescription: String;
begin
  Result := frxResources.Get('TgtJPEGEngine');
end;

{ TgtFR3WMFXport }

class function TgtFR3WMFXport.GetDescription: String;
begin
  Result := frxResources.Get('TgtWMFEngine');
end;

{ TgtFR3EMFXport }

class function TgtFR3EMFXport.GetDescription: String;
begin
  Result := frxResources.Get('TgtEMFEngine');
end;

{$IFDEF gtPro}
{ TgtFR3TIFFXport }

class function TgtFR3TIFFXport.GetDescription: String;
begin
  Result := frxResources.Get('TgtTIFFEngine');
end;

{ TgtFR3PNGXport }

class function TgtFR3PNGXport.GetDescription: String;
begin
  Result := frxResources.Get('TgtPNGEngine');
end;

{ TgtFR3SVGXport }

class function TgtFR3SVGXport.GetDescription: String;
begin
  Result := frxResources.Get('TgtSVGEngine');
end;
{$ENDIF}

procedure TgtFR3ExportInterface.SetShowSaveDialog(const Value: Boolean);
begin
  FShowSaveDialog := Value;
  if (FFR3Xport <> nil) then
    FFR3Xport.ShowSaveDialog := Value;
end;

procedure TgtFR3Xport_Base.SetShowSaveDialog(const Value: Boolean);
begin
  FShowSaveDialog := Value;
end;

end.

