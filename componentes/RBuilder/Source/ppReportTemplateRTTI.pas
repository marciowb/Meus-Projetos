{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2003                    BBBBB   }

unit ppReportTemplateRTTI;

interface

uses
  Classes,
  ppProd;

type

  {@TppStreamDirection }

  TppStreamDirection = (sdSave, sdLoad);


  {@TppReportTemplateRTTI

    Loads or saves the template from a stream on the producer object.}

  TppReportTemplateRTTI = class
    private
      class procedure StreamTheReport(aProducer: TppProducer; aReportStream: TMemoryStream; aStreamDirection: TppStreamDirection);

    public
      class procedure LoadFromReportStream(aProducer: TppProducer; aReportStream: TMemoryStream);
      class procedure SaveToReportStream(aProducer: TppProducer; aReportStream: TMemoryStream);

    end;

implementation

uses
  ppRTTI, ppTmplat;

{@TppReportTemplateRTTI.LoadFromReportStream }

class procedure TppReportTemplateRTTI.LoadFromReportStream(aProducer: TppProducer; aReportStream: TMemoryStream);
begin
  StreamTheReport(aProducer, aReportStream, sdLoad);
end;

{@TppReportTemplateRTTI.SaveToReportStream }

class procedure TppReportTemplateRTTI.SaveToReportStream(aProducer: TppProducer; aReportStream: TMemoryStream);
begin
  StreamTheReport(aProducer, aReportStream, sdSave);
end;

{@TppReportTemplateRTTI.StreamTheReport }

class procedure TppReportTemplateRTTI.StreamTheReport(aProducer: TppProducer; aReportStream: TMemoryStream; aStreamDirection: TppStreamDirection);
var
  lPropRec: TraPropRec;
  lRTTIClass: TraRTTIClass;
  lTemplate: TppTemplate;
begin

  lRTTIClass := TraRTTIClassRegistry.GetRTTIClass(aProducer.ClassType);

  if (lRTTIClass <> nil) and (lRTTIClass.GetPropRec(aProducer.ClassType, 'Template', lPropRec)) then
    lRTTIClass.GetPropValue(aProducer, 'Template', lTemplate)
  else
    lTemplate := nil;

  {In case the template is used by the report explorer in the end user solution,
   then we need to turn off broadcasting of the report explorer events.}
  if (lTemplate <> nil) then
    begin
      lTemplate.BroadcastReportExplorerEvents := False;

      case aStreamDirection of

        sdSave:  lTemplate.SaveToStream(aReportStream);

        sdLoad:  lTemplate.LoadFromStream(aReportStream);

      end;

      lTemplate.BroadcastReportExplorerEvents := True;
    end;

end;

end.
 
