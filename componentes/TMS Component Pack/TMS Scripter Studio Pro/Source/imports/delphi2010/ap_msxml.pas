{***************************************************************************}
{ This source code was generated automatically by                           }
{ Pas file import tool for Scripter Studio (Pro)                            }
{                                                                           }
{ Scripter Studio and Pas file import tool for Scripter Studio              }
{ written by TMS Software                                                   }
{            copyright © 1997 - 2010                                        }
{            Email : info@tmssoftware.com                                   }
{            Web : http://www.tmssoftware.com                               }
{***************************************************************************}
unit ap_msxml;

interface

uses
  Windows,
  ActiveX,
  msxml,
  Variants,
  ap_System,
  atScript;

{$WARNINGS OFF}

type
  TatmsxmlLibrary = class(TatScripterLibrary)
    procedure __GetLIBID_MSXML2(AMachine: TatVirtualMachine);
    procedure __GetIID_IXMLDOMImplementation(AMachine: TatVirtualMachine);
    procedure __GetIID_IXMLDOMNode(AMachine: TatVirtualMachine);
    procedure __GetIID_IXMLDOMNodeList(AMachine: TatVirtualMachine);
    procedure __GetIID_IXMLDOMNamedNodeMap(AMachine: TatVirtualMachine);
    procedure __GetIID_IXMLDOMDocument(AMachine: TatVirtualMachine);
    procedure __GetIID_IXMLDOMDocumentType(AMachine: TatVirtualMachine);
    procedure __GetIID_IXMLDOMElement(AMachine: TatVirtualMachine);
    procedure __GetIID_IXMLDOMAttribute(AMachine: TatVirtualMachine);
    procedure __GetIID_IXMLDOMDocumentFragment(AMachine: TatVirtualMachine);
    procedure __GetIID_IXMLDOMCharacterData(AMachine: TatVirtualMachine);
    procedure __GetIID_IXMLDOMText(AMachine: TatVirtualMachine);
    procedure __GetIID_IXMLDOMComment(AMachine: TatVirtualMachine);
    procedure __GetIID_IXMLDOMCDATASection(AMachine: TatVirtualMachine);
    procedure __GetIID_IXMLDOMProcessingInstruction(AMachine: TatVirtualMachine);
    procedure __GetIID_IXMLDOMEntityReference(AMachine: TatVirtualMachine);
    procedure __GetIID_IXMLDOMParseError(AMachine: TatVirtualMachine);
    procedure __GetIID_IXMLDOMDocument2(AMachine: TatVirtualMachine);
    procedure __GetIID_IXMLDOMSchemaCollection(AMachine: TatVirtualMachine);
    procedure __GetIID_IXMLDOMDocument3(AMachine: TatVirtualMachine);
    procedure __GetIID_IXMLDOMNotation(AMachine: TatVirtualMachine);
    procedure __GetIID_IXMLDOMEntity(AMachine: TatVirtualMachine);
    procedure __GetIID_IXMLDOMParseError2(AMachine: TatVirtualMachine);
    procedure __GetIID_IXMLDOMParseErrorCollection(AMachine: TatVirtualMachine);
    procedure __GetIID_IXTLRuntime(AMachine: TatVirtualMachine);
    procedure __GetIID_IXSLTemplate(AMachine: TatVirtualMachine);
    procedure __GetIID_IXSLProcessor(AMachine: TatVirtualMachine);
    procedure __GetIID_ISAXXMLReader(AMachine: TatVirtualMachine);
    procedure __GetIID_ISAXEntityResolver(AMachine: TatVirtualMachine);
    procedure __GetIID_ISAXContentHandler(AMachine: TatVirtualMachine);
    procedure __GetIID_ISAXLocator(AMachine: TatVirtualMachine);
    procedure __GetIID_ISAXAttributes(AMachine: TatVirtualMachine);
    procedure __GetIID_ISAXDTDHandler(AMachine: TatVirtualMachine);
    procedure __GetIID_ISAXErrorHandler(AMachine: TatVirtualMachine);
    procedure __GetIID_ISAXXMLFilter(AMachine: TatVirtualMachine);
    procedure __GetIID_ISAXLexicalHandler(AMachine: TatVirtualMachine);
    procedure __GetIID_ISAXDeclHandler(AMachine: TatVirtualMachine);
    procedure __GetIID_IVBSAXXMLReader(AMachine: TatVirtualMachine);
    procedure __GetIID_IVBSAXEntityResolver(AMachine: TatVirtualMachine);
    procedure __GetIID_IVBSAXContentHandler(AMachine: TatVirtualMachine);
    procedure __GetIID_IVBSAXLocator(AMachine: TatVirtualMachine);
    procedure __GetIID_IVBSAXAttributes(AMachine: TatVirtualMachine);
    procedure __GetIID_IVBSAXDTDHandler(AMachine: TatVirtualMachine);
    procedure __GetIID_IVBSAXErrorHandler(AMachine: TatVirtualMachine);
    procedure __GetIID_IVBSAXXMLFilter(AMachine: TatVirtualMachine);
    procedure __GetIID_IVBSAXLexicalHandler(AMachine: TatVirtualMachine);
    procedure __GetIID_IVBSAXDeclHandler(AMachine: TatVirtualMachine);
    procedure __GetIID_IMXWriter(AMachine: TatVirtualMachine);
    procedure __GetIID_IMXAttributes(AMachine: TatVirtualMachine);
    procedure __GetIID_IMXReaderControl(AMachine: TatVirtualMachine);
    procedure __GetIID_IMXSchemaDeclHandler(AMachine: TatVirtualMachine);
    procedure __GetIID_ISchemaItem(AMachine: TatVirtualMachine);
    procedure __GetIID_ISchemaParticle(AMachine: TatVirtualMachine);
    procedure __GetIID_ISchemaElement(AMachine: TatVirtualMachine);
    procedure __GetIID_ISchema(AMachine: TatVirtualMachine);
    procedure __GetIID_ISchemaItemCollection(AMachine: TatVirtualMachine);
    procedure __GetIID_ISchemaStringCollection(AMachine: TatVirtualMachine);
    procedure __GetIID_ISchemaType(AMachine: TatVirtualMachine);
    procedure __GetIID_ISchemaComplexType(AMachine: TatVirtualMachine);
    procedure __GetIID_ISchemaAny(AMachine: TatVirtualMachine);
    procedure __GetIID_ISchemaModelGroup(AMachine: TatVirtualMachine);
    procedure __GetIID_IMXXMLFilter(AMachine: TatVirtualMachine);
    procedure __GetIID_IXMLDOMSchemaCollection2(AMachine: TatVirtualMachine);
    procedure __GetIID_ISchemaAttribute(AMachine: TatVirtualMachine);
    procedure __GetIID_ISchemaAttributeGroup(AMachine: TatVirtualMachine);
    procedure __GetIID_ISchemaIdentityConstraint(AMachine: TatVirtualMachine);
    procedure __GetIID_ISchemaNotation(AMachine: TatVirtualMachine);
    procedure __GetIID_IXMLDOMSelection(AMachine: TatVirtualMachine);
    procedure __GetDIID_XMLDOMDocumentEvents(AMachine: TatVirtualMachine);
    procedure __GetIID_IDSOControl(AMachine: TatVirtualMachine);
    procedure __GetIID_IXMLHTTPRequest(AMachine: TatVirtualMachine);
    procedure __GetIID_IServerXMLHTTPRequest(AMachine: TatVirtualMachine);
    procedure __GetIID_IServerXMLHTTPRequest2(AMachine: TatVirtualMachine);
    procedure __GetIID_IMXNamespacePrefixes(AMachine: TatVirtualMachine);
    procedure __GetIID_IVBMXNamespaceManager(AMachine: TatVirtualMachine);
    procedure __GetIID_IMXNamespaceManager(AMachine: TatVirtualMachine);
    procedure __GetCLASS_DOMDocument(AMachine: TatVirtualMachine);
    procedure __GetCLASS_DOMDocument26(AMachine: TatVirtualMachine);
    procedure __GetCLASS_DOMDocument30(AMachine: TatVirtualMachine);
    procedure __GetCLASS_DOMDocument40(AMachine: TatVirtualMachine);
    procedure __GetCLASS_DOMDocument60(AMachine: TatVirtualMachine);
    procedure __GetCLASS_FreeThreadedDOMDocument(AMachine: TatVirtualMachine);
    procedure __GetCLASS_FreeThreadedDOMDocument26(AMachine: TatVirtualMachine);
    procedure __GetCLASS_FreeThreadedDOMDocument30(AMachine: TatVirtualMachine);
    procedure __GetCLASS_FreeThreadedDOMDocument40(AMachine: TatVirtualMachine);
    procedure __GetCLASS_FreeThreadedDOMDocument60(AMachine: TatVirtualMachine);
    procedure __GetCLASS_XMLSchemaCache(AMachine: TatVirtualMachine);
    procedure __GetCLASS_XMLSchemaCache26(AMachine: TatVirtualMachine);
    procedure __GetCLASS_XMLSchemaCache30(AMachine: TatVirtualMachine);
    procedure __GetCLASS_XMLSchemaCache40(AMachine: TatVirtualMachine);
    procedure __GetCLASS_XMLSchemaCache60(AMachine: TatVirtualMachine);
    procedure __GetCLASS_XSLTemplate(AMachine: TatVirtualMachine);
    procedure __GetCLASS_XSLTemplate26(AMachine: TatVirtualMachine);
    procedure __GetCLASS_XSLTemplate30(AMachine: TatVirtualMachine);
    procedure __GetCLASS_XSLTemplate40(AMachine: TatVirtualMachine);
    procedure __GetCLASS_XSLTemplate60(AMachine: TatVirtualMachine);
    procedure __GetCLASS_DSOControl(AMachine: TatVirtualMachine);
    procedure __GetCLASS_DSOControl26(AMachine: TatVirtualMachine);
    procedure __GetCLASS_DSOControl30(AMachine: TatVirtualMachine);
    procedure __GetCLASS_DSOControl40(AMachine: TatVirtualMachine);
    procedure __GetCLASS_XMLHTTP(AMachine: TatVirtualMachine);
    procedure __GetCLASS_XMLHTTP26(AMachine: TatVirtualMachine);
    procedure __GetCLASS_XMLHTTP30(AMachine: TatVirtualMachine);
    procedure __GetCLASS_XMLHTTP40(AMachine: TatVirtualMachine);
    procedure __GetCLASS_XMLHTTP60(AMachine: TatVirtualMachine);
    procedure __GetCLASS_ServerXMLHTTP(AMachine: TatVirtualMachine);
    procedure __GetCLASS_ServerXMLHTTP30(AMachine: TatVirtualMachine);
    procedure __GetCLASS_ServerXMLHTTP40(AMachine: TatVirtualMachine);
    procedure __GetCLASS_ServerXMLHTTP60(AMachine: TatVirtualMachine);
    procedure __GetCLASS_SAXXMLReader(AMachine: TatVirtualMachine);
    procedure __GetCLASS_SAXXMLReader30(AMachine: TatVirtualMachine);
    procedure __GetCLASS_SAXXMLReader40(AMachine: TatVirtualMachine);
    procedure __GetCLASS_SAXXMLReader60(AMachine: TatVirtualMachine);
    procedure __GetCLASS_MXXMLWriter(AMachine: TatVirtualMachine);
    procedure __GetCLASS_MXXMLWriter30(AMachine: TatVirtualMachine);
    procedure __GetCLASS_MXXMLWriter40(AMachine: TatVirtualMachine);
    procedure __GetCLASS_MXXMLWriter60(AMachine: TatVirtualMachine);
    procedure __GetCLASS_MXHTMLWriter(AMachine: TatVirtualMachine);
    procedure __GetCLASS_MXHTMLWriter30(AMachine: TatVirtualMachine);
    procedure __GetCLASS_MXHTMLWriter40(AMachine: TatVirtualMachine);
    procedure __GetCLASS_MXHTMLWriter60(AMachine: TatVirtualMachine);
    procedure __GetCLASS_SAXAttributes(AMachine: TatVirtualMachine);
    procedure __GetCLASS_SAXAttributes30(AMachine: TatVirtualMachine);
    procedure __GetCLASS_SAXAttributes40(AMachine: TatVirtualMachine);
    procedure __GetCLASS_SAXAttributes60(AMachine: TatVirtualMachine);
    procedure __GetCLASS_MXNamespaceManager(AMachine: TatVirtualMachine);
    procedure __GetCLASS_MXNamespaceManager40(AMachine: TatVirtualMachine);
    procedure __GetCLASS_MXNamespaceManager60(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  CoDOMDocumentClass = class of CoDOMDocument;
  CoDOMDocument26Class = class of CoDOMDocument26;
  CoDOMDocument30Class = class of CoDOMDocument30;
  CoDOMDocument40Class = class of CoDOMDocument40;
  CoDOMDocument60Class = class of CoDOMDocument60;
  CoFreeThreadedDOMDocumentClass = class of CoFreeThreadedDOMDocument;
  CoFreeThreadedDOMDocument26Class = class of CoFreeThreadedDOMDocument26;
  CoFreeThreadedDOMDocument30Class = class of CoFreeThreadedDOMDocument30;
  CoFreeThreadedDOMDocument40Class = class of CoFreeThreadedDOMDocument40;
  CoFreeThreadedDOMDocument60Class = class of CoFreeThreadedDOMDocument60;
  CoXMLSchemaCacheClass = class of CoXMLSchemaCache;
  CoXMLSchemaCache26Class = class of CoXMLSchemaCache26;
  CoXMLSchemaCache30Class = class of CoXMLSchemaCache30;
  CoXMLSchemaCache40Class = class of CoXMLSchemaCache40;
  CoXMLSchemaCache60Class = class of CoXMLSchemaCache60;
  CoXSLTemplateClass = class of CoXSLTemplate;
  CoXSLTemplate26Class = class of CoXSLTemplate26;
  CoXSLTemplate30Class = class of CoXSLTemplate30;
  CoXSLTemplate40Class = class of CoXSLTemplate40;
  CoXSLTemplate60Class = class of CoXSLTemplate60;
  CoDSOControlClass = class of CoDSOControl;
  CoDSOControl26Class = class of CoDSOControl26;
  CoDSOControl30Class = class of CoDSOControl30;
  CoDSOControl40Class = class of CoDSOControl40;
  CoXMLHTTPClass = class of CoXMLHTTP;
  CoXMLHTTP26Class = class of CoXMLHTTP26;
  CoXMLHTTP30Class = class of CoXMLHTTP30;
  CoXMLHTTP40Class = class of CoXMLHTTP40;
  CoXMLHTTP60Class = class of CoXMLHTTP60;
  CoServerXMLHTTPClass = class of CoServerXMLHTTP;
  CoServerXMLHTTP30Class = class of CoServerXMLHTTP30;
  CoServerXMLHTTP40Class = class of CoServerXMLHTTP40;
  CoServerXMLHTTP60Class = class of CoServerXMLHTTP60;
  CoSAXXMLReaderClass = class of CoSAXXMLReader;
  CoSAXXMLReader30Class = class of CoSAXXMLReader30;
  CoSAXXMLReader40Class = class of CoSAXXMLReader40;
  CoSAXXMLReader60Class = class of CoSAXXMLReader60;
  CoMXXMLWriterClass = class of CoMXXMLWriter;
  CoMXXMLWriter30Class = class of CoMXXMLWriter30;
  CoMXXMLWriter40Class = class of CoMXXMLWriter40;
  CoMXXMLWriter60Class = class of CoMXXMLWriter60;
  CoMXHTMLWriterClass = class of CoMXHTMLWriter;
  CoMXHTMLWriter30Class = class of CoMXHTMLWriter30;
  CoMXHTMLWriter40Class = class of CoMXHTMLWriter40;
  CoMXHTMLWriter60Class = class of CoMXHTMLWriter60;
  CoSAXAttributesClass = class of CoSAXAttributes;
  CoSAXAttributes30Class = class of CoSAXAttributes30;
  CoSAXAttributes40Class = class of CoSAXAttributes40;
  CoSAXAttributes60Class = class of CoSAXAttributes60;
  CoMXNamespaceManagerClass = class of CoMXNamespaceManager;
  CoMXNamespaceManager40Class = class of CoMXNamespaceManager40;
  CoMXNamespaceManager60Class = class of CoMXNamespaceManager60;



implementation



procedure TatmsxmlLibrary.__GetLIBID_MSXML2(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.LIBID_MSXML2)));
  end;
end;

procedure TatmsxmlLibrary.__GetIID_IXMLDOMImplementation(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.IID_IXMLDOMImplementation)));
  end;
end;

procedure TatmsxmlLibrary.__GetIID_IXMLDOMNode(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.IID_IXMLDOMNode)));
  end;
end;

procedure TatmsxmlLibrary.__GetIID_IXMLDOMNodeList(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.IID_IXMLDOMNodeList)));
  end;
end;

procedure TatmsxmlLibrary.__GetIID_IXMLDOMNamedNodeMap(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.IID_IXMLDOMNamedNodeMap)));
  end;
end;

procedure TatmsxmlLibrary.__GetIID_IXMLDOMDocument(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.IID_IXMLDOMDocument)));
  end;
end;

procedure TatmsxmlLibrary.__GetIID_IXMLDOMDocumentType(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.IID_IXMLDOMDocumentType)));
  end;
end;

procedure TatmsxmlLibrary.__GetIID_IXMLDOMElement(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.IID_IXMLDOMElement)));
  end;
end;

procedure TatmsxmlLibrary.__GetIID_IXMLDOMAttribute(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.IID_IXMLDOMAttribute)));
  end;
end;

procedure TatmsxmlLibrary.__GetIID_IXMLDOMDocumentFragment(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.IID_IXMLDOMDocumentFragment)));
  end;
end;

procedure TatmsxmlLibrary.__GetIID_IXMLDOMCharacterData(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.IID_IXMLDOMCharacterData)));
  end;
end;

procedure TatmsxmlLibrary.__GetIID_IXMLDOMText(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.IID_IXMLDOMText)));
  end;
end;

procedure TatmsxmlLibrary.__GetIID_IXMLDOMComment(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.IID_IXMLDOMComment)));
  end;
end;

procedure TatmsxmlLibrary.__GetIID_IXMLDOMCDATASection(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.IID_IXMLDOMCDATASection)));
  end;
end;

procedure TatmsxmlLibrary.__GetIID_IXMLDOMProcessingInstruction(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.IID_IXMLDOMProcessingInstruction)));
  end;
end;

procedure TatmsxmlLibrary.__GetIID_IXMLDOMEntityReference(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.IID_IXMLDOMEntityReference)));
  end;
end;

procedure TatmsxmlLibrary.__GetIID_IXMLDOMParseError(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.IID_IXMLDOMParseError)));
  end;
end;

procedure TatmsxmlLibrary.__GetIID_IXMLDOMDocument2(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.IID_IXMLDOMDocument2)));
  end;
end;

procedure TatmsxmlLibrary.__GetIID_IXMLDOMSchemaCollection(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.IID_IXMLDOMSchemaCollection)));
  end;
end;

procedure TatmsxmlLibrary.__GetIID_IXMLDOMDocument3(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.IID_IXMLDOMDocument3)));
  end;
end;

procedure TatmsxmlLibrary.__GetIID_IXMLDOMNotation(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.IID_IXMLDOMNotation)));
  end;
end;

procedure TatmsxmlLibrary.__GetIID_IXMLDOMEntity(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.IID_IXMLDOMEntity)));
  end;
end;

procedure TatmsxmlLibrary.__GetIID_IXMLDOMParseError2(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.IID_IXMLDOMParseError2)));
  end;
end;

procedure TatmsxmlLibrary.__GetIID_IXMLDOMParseErrorCollection(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.IID_IXMLDOMParseErrorCollection)));
  end;
end;

procedure TatmsxmlLibrary.__GetIID_IXTLRuntime(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.IID_IXTLRuntime)));
  end;
end;

procedure TatmsxmlLibrary.__GetIID_IXSLTemplate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.IID_IXSLTemplate)));
  end;
end;

procedure TatmsxmlLibrary.__GetIID_IXSLProcessor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.IID_IXSLProcessor)));
  end;
end;

procedure TatmsxmlLibrary.__GetIID_ISAXXMLReader(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.IID_ISAXXMLReader)));
  end;
end;

procedure TatmsxmlLibrary.__GetIID_ISAXEntityResolver(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.IID_ISAXEntityResolver)));
  end;
end;

procedure TatmsxmlLibrary.__GetIID_ISAXContentHandler(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.IID_ISAXContentHandler)));
  end;
end;

procedure TatmsxmlLibrary.__GetIID_ISAXLocator(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.IID_ISAXLocator)));
  end;
end;

procedure TatmsxmlLibrary.__GetIID_ISAXAttributes(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.IID_ISAXAttributes)));
  end;
end;

procedure TatmsxmlLibrary.__GetIID_ISAXDTDHandler(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.IID_ISAXDTDHandler)));
  end;
end;

procedure TatmsxmlLibrary.__GetIID_ISAXErrorHandler(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.IID_ISAXErrorHandler)));
  end;
end;

procedure TatmsxmlLibrary.__GetIID_ISAXXMLFilter(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.IID_ISAXXMLFilter)));
  end;
end;

procedure TatmsxmlLibrary.__GetIID_ISAXLexicalHandler(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.IID_ISAXLexicalHandler)));
  end;
end;

procedure TatmsxmlLibrary.__GetIID_ISAXDeclHandler(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.IID_ISAXDeclHandler)));
  end;
end;

procedure TatmsxmlLibrary.__GetIID_IVBSAXXMLReader(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.IID_IVBSAXXMLReader)));
  end;
end;

procedure TatmsxmlLibrary.__GetIID_IVBSAXEntityResolver(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.IID_IVBSAXEntityResolver)));
  end;
end;

procedure TatmsxmlLibrary.__GetIID_IVBSAXContentHandler(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.IID_IVBSAXContentHandler)));
  end;
end;

procedure TatmsxmlLibrary.__GetIID_IVBSAXLocator(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.IID_IVBSAXLocator)));
  end;
end;

procedure TatmsxmlLibrary.__GetIID_IVBSAXAttributes(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.IID_IVBSAXAttributes)));
  end;
end;

procedure TatmsxmlLibrary.__GetIID_IVBSAXDTDHandler(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.IID_IVBSAXDTDHandler)));
  end;
end;

procedure TatmsxmlLibrary.__GetIID_IVBSAXErrorHandler(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.IID_IVBSAXErrorHandler)));
  end;
end;

procedure TatmsxmlLibrary.__GetIID_IVBSAXXMLFilter(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.IID_IVBSAXXMLFilter)));
  end;
end;

procedure TatmsxmlLibrary.__GetIID_IVBSAXLexicalHandler(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.IID_IVBSAXLexicalHandler)));
  end;
end;

procedure TatmsxmlLibrary.__GetIID_IVBSAXDeclHandler(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.IID_IVBSAXDeclHandler)));
  end;
end;

procedure TatmsxmlLibrary.__GetIID_IMXWriter(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.IID_IMXWriter)));
  end;
end;

procedure TatmsxmlLibrary.__GetIID_IMXAttributes(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.IID_IMXAttributes)));
  end;
end;

procedure TatmsxmlLibrary.__GetIID_IMXReaderControl(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.IID_IMXReaderControl)));
  end;
end;

procedure TatmsxmlLibrary.__GetIID_IMXSchemaDeclHandler(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.IID_IMXSchemaDeclHandler)));
  end;
end;

procedure TatmsxmlLibrary.__GetIID_ISchemaItem(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.IID_ISchemaItem)));
  end;
end;

procedure TatmsxmlLibrary.__GetIID_ISchemaParticle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.IID_ISchemaParticle)));
  end;
end;

procedure TatmsxmlLibrary.__GetIID_ISchemaElement(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.IID_ISchemaElement)));
  end;
end;

procedure TatmsxmlLibrary.__GetIID_ISchema(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.IID_ISchema)));
  end;
end;

procedure TatmsxmlLibrary.__GetIID_ISchemaItemCollection(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.IID_ISchemaItemCollection)));
  end;
end;

procedure TatmsxmlLibrary.__GetIID_ISchemaStringCollection(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.IID_ISchemaStringCollection)));
  end;
end;

procedure TatmsxmlLibrary.__GetIID_ISchemaType(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.IID_ISchemaType)));
  end;
end;

procedure TatmsxmlLibrary.__GetIID_ISchemaComplexType(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.IID_ISchemaComplexType)));
  end;
end;

procedure TatmsxmlLibrary.__GetIID_ISchemaAny(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.IID_ISchemaAny)));
  end;
end;

procedure TatmsxmlLibrary.__GetIID_ISchemaModelGroup(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.IID_ISchemaModelGroup)));
  end;
end;

procedure TatmsxmlLibrary.__GetIID_IMXXMLFilter(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.IID_IMXXMLFilter)));
  end;
end;

procedure TatmsxmlLibrary.__GetIID_IXMLDOMSchemaCollection2(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.IID_IXMLDOMSchemaCollection2)));
  end;
end;

procedure TatmsxmlLibrary.__GetIID_ISchemaAttribute(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.IID_ISchemaAttribute)));
  end;
end;

procedure TatmsxmlLibrary.__GetIID_ISchemaAttributeGroup(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.IID_ISchemaAttributeGroup)));
  end;
end;

procedure TatmsxmlLibrary.__GetIID_ISchemaIdentityConstraint(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.IID_ISchemaIdentityConstraint)));
  end;
end;

procedure TatmsxmlLibrary.__GetIID_ISchemaNotation(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.IID_ISchemaNotation)));
  end;
end;

procedure TatmsxmlLibrary.__GetIID_IXMLDOMSelection(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.IID_IXMLDOMSelection)));
  end;
end;

procedure TatmsxmlLibrary.__GetDIID_XMLDOMDocumentEvents(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.DIID_XMLDOMDocumentEvents)));
  end;
end;

procedure TatmsxmlLibrary.__GetIID_IDSOControl(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.IID_IDSOControl)));
  end;
end;

procedure TatmsxmlLibrary.__GetIID_IXMLHTTPRequest(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.IID_IXMLHTTPRequest)));
  end;
end;

procedure TatmsxmlLibrary.__GetIID_IServerXMLHTTPRequest(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.IID_IServerXMLHTTPRequest)));
  end;
end;

procedure TatmsxmlLibrary.__GetIID_IServerXMLHTTPRequest2(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.IID_IServerXMLHTTPRequest2)));
  end;
end;

procedure TatmsxmlLibrary.__GetIID_IMXNamespacePrefixes(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.IID_IMXNamespacePrefixes)));
  end;
end;

procedure TatmsxmlLibrary.__GetIID_IVBMXNamespaceManager(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.IID_IVBMXNamespaceManager)));
  end;
end;

procedure TatmsxmlLibrary.__GetIID_IMXNamespaceManager(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.IID_IMXNamespaceManager)));
  end;
end;

procedure TatmsxmlLibrary.__GetCLASS_DOMDocument(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.CLASS_DOMDocument)));
  end;
end;

procedure TatmsxmlLibrary.__GetCLASS_DOMDocument26(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.CLASS_DOMDocument26)));
  end;
end;

procedure TatmsxmlLibrary.__GetCLASS_DOMDocument30(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.CLASS_DOMDocument30)));
  end;
end;

procedure TatmsxmlLibrary.__GetCLASS_DOMDocument40(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.CLASS_DOMDocument40)));
  end;
end;

procedure TatmsxmlLibrary.__GetCLASS_DOMDocument60(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.CLASS_DOMDocument60)));
  end;
end;

procedure TatmsxmlLibrary.__GetCLASS_FreeThreadedDOMDocument(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.CLASS_FreeThreadedDOMDocument)));
  end;
end;

procedure TatmsxmlLibrary.__GetCLASS_FreeThreadedDOMDocument26(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.CLASS_FreeThreadedDOMDocument26)));
  end;
end;

procedure TatmsxmlLibrary.__GetCLASS_FreeThreadedDOMDocument30(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.CLASS_FreeThreadedDOMDocument30)));
  end;
end;

procedure TatmsxmlLibrary.__GetCLASS_FreeThreadedDOMDocument40(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.CLASS_FreeThreadedDOMDocument40)));
  end;
end;

procedure TatmsxmlLibrary.__GetCLASS_FreeThreadedDOMDocument60(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.CLASS_FreeThreadedDOMDocument60)));
  end;
end;

procedure TatmsxmlLibrary.__GetCLASS_XMLSchemaCache(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.CLASS_XMLSchemaCache)));
  end;
end;

procedure TatmsxmlLibrary.__GetCLASS_XMLSchemaCache26(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.CLASS_XMLSchemaCache26)));
  end;
end;

procedure TatmsxmlLibrary.__GetCLASS_XMLSchemaCache30(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.CLASS_XMLSchemaCache30)));
  end;
end;

procedure TatmsxmlLibrary.__GetCLASS_XMLSchemaCache40(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.CLASS_XMLSchemaCache40)));
  end;
end;

procedure TatmsxmlLibrary.__GetCLASS_XMLSchemaCache60(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.CLASS_XMLSchemaCache60)));
  end;
end;

procedure TatmsxmlLibrary.__GetCLASS_XSLTemplate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.CLASS_XSLTemplate)));
  end;
end;

procedure TatmsxmlLibrary.__GetCLASS_XSLTemplate26(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.CLASS_XSLTemplate26)));
  end;
end;

procedure TatmsxmlLibrary.__GetCLASS_XSLTemplate30(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.CLASS_XSLTemplate30)));
  end;
end;

procedure TatmsxmlLibrary.__GetCLASS_XSLTemplate40(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.CLASS_XSLTemplate40)));
  end;
end;

procedure TatmsxmlLibrary.__GetCLASS_XSLTemplate60(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.CLASS_XSLTemplate60)));
  end;
end;

procedure TatmsxmlLibrary.__GetCLASS_DSOControl(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.CLASS_DSOControl)));
  end;
end;

procedure TatmsxmlLibrary.__GetCLASS_DSOControl26(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.CLASS_DSOControl26)));
  end;
end;

procedure TatmsxmlLibrary.__GetCLASS_DSOControl30(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.CLASS_DSOControl30)));
  end;
end;

procedure TatmsxmlLibrary.__GetCLASS_DSOControl40(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.CLASS_DSOControl40)));
  end;
end;

procedure TatmsxmlLibrary.__GetCLASS_XMLHTTP(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.CLASS_XMLHTTP)));
  end;
end;

procedure TatmsxmlLibrary.__GetCLASS_XMLHTTP26(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.CLASS_XMLHTTP26)));
  end;
end;

procedure TatmsxmlLibrary.__GetCLASS_XMLHTTP30(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.CLASS_XMLHTTP30)));
  end;
end;

procedure TatmsxmlLibrary.__GetCLASS_XMLHTTP40(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.CLASS_XMLHTTP40)));
  end;
end;

procedure TatmsxmlLibrary.__GetCLASS_XMLHTTP60(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.CLASS_XMLHTTP60)));
  end;
end;

procedure TatmsxmlLibrary.__GetCLASS_ServerXMLHTTP(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.CLASS_ServerXMLHTTP)));
  end;
end;

procedure TatmsxmlLibrary.__GetCLASS_ServerXMLHTTP30(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.CLASS_ServerXMLHTTP30)));
  end;
end;

procedure TatmsxmlLibrary.__GetCLASS_ServerXMLHTTP40(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.CLASS_ServerXMLHTTP40)));
  end;
end;

procedure TatmsxmlLibrary.__GetCLASS_ServerXMLHTTP60(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.CLASS_ServerXMLHTTP60)));
  end;
end;

procedure TatmsxmlLibrary.__GetCLASS_SAXXMLReader(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.CLASS_SAXXMLReader)));
  end;
end;

procedure TatmsxmlLibrary.__GetCLASS_SAXXMLReader30(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.CLASS_SAXXMLReader30)));
  end;
end;

procedure TatmsxmlLibrary.__GetCLASS_SAXXMLReader40(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.CLASS_SAXXMLReader40)));
  end;
end;

procedure TatmsxmlLibrary.__GetCLASS_SAXXMLReader60(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.CLASS_SAXXMLReader60)));
  end;
end;

procedure TatmsxmlLibrary.__GetCLASS_MXXMLWriter(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.CLASS_MXXMLWriter)));
  end;
end;

procedure TatmsxmlLibrary.__GetCLASS_MXXMLWriter30(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.CLASS_MXXMLWriter30)));
  end;
end;

procedure TatmsxmlLibrary.__GetCLASS_MXXMLWriter40(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.CLASS_MXXMLWriter40)));
  end;
end;

procedure TatmsxmlLibrary.__GetCLASS_MXXMLWriter60(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.CLASS_MXXMLWriter60)));
  end;
end;

procedure TatmsxmlLibrary.__GetCLASS_MXHTMLWriter(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.CLASS_MXHTMLWriter)));
  end;
end;

procedure TatmsxmlLibrary.__GetCLASS_MXHTMLWriter30(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.CLASS_MXHTMLWriter30)));
  end;
end;

procedure TatmsxmlLibrary.__GetCLASS_MXHTMLWriter40(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.CLASS_MXHTMLWriter40)));
  end;
end;

procedure TatmsxmlLibrary.__GetCLASS_MXHTMLWriter60(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.CLASS_MXHTMLWriter60)));
  end;
end;

procedure TatmsxmlLibrary.__GetCLASS_SAXAttributes(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.CLASS_SAXAttributes)));
  end;
end;

procedure TatmsxmlLibrary.__GetCLASS_SAXAttributes30(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.CLASS_SAXAttributes30)));
  end;
end;

procedure TatmsxmlLibrary.__GetCLASS_SAXAttributes40(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.CLASS_SAXAttributes40)));
  end;
end;

procedure TatmsxmlLibrary.__GetCLASS_SAXAttributes60(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.CLASS_SAXAttributes60)));
  end;
end;

procedure TatmsxmlLibrary.__GetCLASS_MXNamespaceManager(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.CLASS_MXNamespaceManager)));
  end;
end;

procedure TatmsxmlLibrary.__GetCLASS_MXNamespaceManager40(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.CLASS_MXNamespaceManager40)));
  end;
end;

procedure TatmsxmlLibrary.__GetCLASS_MXNamespaceManager60(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.CLASS_MXNamespaceManager60)));
  end;
end;

procedure TatmsxmlLibrary.Init;
begin
  With Scripter.DefineClass(CoDOMDocument) do
  begin
  end;
  With Scripter.DefineClass(CoDOMDocument26) do
  begin
  end;
  With Scripter.DefineClass(CoDOMDocument30) do
  begin
  end;
  With Scripter.DefineClass(CoDOMDocument40) do
  begin
  end;
  With Scripter.DefineClass(CoDOMDocument60) do
  begin
  end;
  With Scripter.DefineClass(CoFreeThreadedDOMDocument) do
  begin
  end;
  With Scripter.DefineClass(CoFreeThreadedDOMDocument26) do
  begin
  end;
  With Scripter.DefineClass(CoFreeThreadedDOMDocument30) do
  begin
  end;
  With Scripter.DefineClass(CoFreeThreadedDOMDocument40) do
  begin
  end;
  With Scripter.DefineClass(CoFreeThreadedDOMDocument60) do
  begin
  end;
  With Scripter.DefineClass(CoXMLSchemaCache) do
  begin
  end;
  With Scripter.DefineClass(CoXMLSchemaCache26) do
  begin
  end;
  With Scripter.DefineClass(CoXMLSchemaCache30) do
  begin
  end;
  With Scripter.DefineClass(CoXMLSchemaCache40) do
  begin
  end;
  With Scripter.DefineClass(CoXMLSchemaCache60) do
  begin
  end;
  With Scripter.DefineClass(CoXSLTemplate) do
  begin
  end;
  With Scripter.DefineClass(CoXSLTemplate26) do
  begin
  end;
  With Scripter.DefineClass(CoXSLTemplate30) do
  begin
  end;
  With Scripter.DefineClass(CoXSLTemplate40) do
  begin
  end;
  With Scripter.DefineClass(CoXSLTemplate60) do
  begin
  end;
  With Scripter.DefineClass(CoDSOControl) do
  begin
  end;
  With Scripter.DefineClass(CoDSOControl26) do
  begin
  end;
  With Scripter.DefineClass(CoDSOControl30) do
  begin
  end;
  With Scripter.DefineClass(CoDSOControl40) do
  begin
  end;
  With Scripter.DefineClass(CoXMLHTTP) do
  begin
  end;
  With Scripter.DefineClass(CoXMLHTTP26) do
  begin
  end;
  With Scripter.DefineClass(CoXMLHTTP30) do
  begin
  end;
  With Scripter.DefineClass(CoXMLHTTP40) do
  begin
  end;
  With Scripter.DefineClass(CoXMLHTTP60) do
  begin
  end;
  With Scripter.DefineClass(CoServerXMLHTTP) do
  begin
  end;
  With Scripter.DefineClass(CoServerXMLHTTP30) do
  begin
  end;
  With Scripter.DefineClass(CoServerXMLHTTP40) do
  begin
  end;
  With Scripter.DefineClass(CoServerXMLHTTP60) do
  begin
  end;
  With Scripter.DefineClass(CoSAXXMLReader) do
  begin
  end;
  With Scripter.DefineClass(CoSAXXMLReader30) do
  begin
  end;
  With Scripter.DefineClass(CoSAXXMLReader40) do
  begin
  end;
  With Scripter.DefineClass(CoSAXXMLReader60) do
  begin
  end;
  With Scripter.DefineClass(CoMXXMLWriter) do
  begin
  end;
  With Scripter.DefineClass(CoMXXMLWriter30) do
  begin
  end;
  With Scripter.DefineClass(CoMXXMLWriter40) do
  begin
  end;
  With Scripter.DefineClass(CoMXXMLWriter60) do
  begin
  end;
  With Scripter.DefineClass(CoMXHTMLWriter) do
  begin
  end;
  With Scripter.DefineClass(CoMXHTMLWriter30) do
  begin
  end;
  With Scripter.DefineClass(CoMXHTMLWriter40) do
  begin
  end;
  With Scripter.DefineClass(CoMXHTMLWriter60) do
  begin
  end;
  With Scripter.DefineClass(CoSAXAttributes) do
  begin
  end;
  With Scripter.DefineClass(CoSAXAttributes30) do
  begin
  end;
  With Scripter.DefineClass(CoSAXAttributes40) do
  begin
  end;
  With Scripter.DefineClass(CoSAXAttributes60) do
  begin
  end;
  With Scripter.DefineClass(CoMXNamespaceManager) do
  begin
  end;
  With Scripter.DefineClass(CoMXNamespaceManager40) do
  begin
  end;
  With Scripter.DefineClass(CoMXNamespaceManager60) do
  begin
  end;
  With Scripter.DefineClass(ClassType) do
  begin
    DefineProp('LIBID_MSXML2',tkVariant,__GetLIBID_MSXML2,nil,nil,false,0);
    DefineProp('IID_IXMLDOMImplementation',tkVariant,__GetIID_IXMLDOMImplementation,nil,nil,false,0);
    DefineProp('IID_IXMLDOMNode',tkVariant,__GetIID_IXMLDOMNode,nil,nil,false,0);
    DefineProp('IID_IXMLDOMNodeList',tkVariant,__GetIID_IXMLDOMNodeList,nil,nil,false,0);
    DefineProp('IID_IXMLDOMNamedNodeMap',tkVariant,__GetIID_IXMLDOMNamedNodeMap,nil,nil,false,0);
    DefineProp('IID_IXMLDOMDocument',tkVariant,__GetIID_IXMLDOMDocument,nil,nil,false,0);
    DefineProp('IID_IXMLDOMDocumentType',tkVariant,__GetIID_IXMLDOMDocumentType,nil,nil,false,0);
    DefineProp('IID_IXMLDOMElement',tkVariant,__GetIID_IXMLDOMElement,nil,nil,false,0);
    DefineProp('IID_IXMLDOMAttribute',tkVariant,__GetIID_IXMLDOMAttribute,nil,nil,false,0);
    DefineProp('IID_IXMLDOMDocumentFragment',tkVariant,__GetIID_IXMLDOMDocumentFragment,nil,nil,false,0);
    DefineProp('IID_IXMLDOMCharacterData',tkVariant,__GetIID_IXMLDOMCharacterData,nil,nil,false,0);
    DefineProp('IID_IXMLDOMText',tkVariant,__GetIID_IXMLDOMText,nil,nil,false,0);
    DefineProp('IID_IXMLDOMComment',tkVariant,__GetIID_IXMLDOMComment,nil,nil,false,0);
    DefineProp('IID_IXMLDOMCDATASection',tkVariant,__GetIID_IXMLDOMCDATASection,nil,nil,false,0);
    DefineProp('IID_IXMLDOMProcessingInstruction',tkVariant,__GetIID_IXMLDOMProcessingInstruction,nil,nil,false,0);
    DefineProp('IID_IXMLDOMEntityReference',tkVariant,__GetIID_IXMLDOMEntityReference,nil,nil,false,0);
    DefineProp('IID_IXMLDOMParseError',tkVariant,__GetIID_IXMLDOMParseError,nil,nil,false,0);
    DefineProp('IID_IXMLDOMDocument2',tkVariant,__GetIID_IXMLDOMDocument2,nil,nil,false,0);
    DefineProp('IID_IXMLDOMSchemaCollection',tkVariant,__GetIID_IXMLDOMSchemaCollection,nil,nil,false,0);
    DefineProp('IID_IXMLDOMDocument3',tkVariant,__GetIID_IXMLDOMDocument3,nil,nil,false,0);
    DefineProp('IID_IXMLDOMNotation',tkVariant,__GetIID_IXMLDOMNotation,nil,nil,false,0);
    DefineProp('IID_IXMLDOMEntity',tkVariant,__GetIID_IXMLDOMEntity,nil,nil,false,0);
    DefineProp('IID_IXMLDOMParseError2',tkVariant,__GetIID_IXMLDOMParseError2,nil,nil,false,0);
    DefineProp('IID_IXMLDOMParseErrorCollection',tkVariant,__GetIID_IXMLDOMParseErrorCollection,nil,nil,false,0);
    DefineProp('IID_IXTLRuntime',tkVariant,__GetIID_IXTLRuntime,nil,nil,false,0);
    DefineProp('IID_IXSLTemplate',tkVariant,__GetIID_IXSLTemplate,nil,nil,false,0);
    DefineProp('IID_IXSLProcessor',tkVariant,__GetIID_IXSLProcessor,nil,nil,false,0);
    DefineProp('IID_ISAXXMLReader',tkVariant,__GetIID_ISAXXMLReader,nil,nil,false,0);
    DefineProp('IID_ISAXEntityResolver',tkVariant,__GetIID_ISAXEntityResolver,nil,nil,false,0);
    DefineProp('IID_ISAXContentHandler',tkVariant,__GetIID_ISAXContentHandler,nil,nil,false,0);
    DefineProp('IID_ISAXLocator',tkVariant,__GetIID_ISAXLocator,nil,nil,false,0);
    DefineProp('IID_ISAXAttributes',tkVariant,__GetIID_ISAXAttributes,nil,nil,false,0);
    DefineProp('IID_ISAXDTDHandler',tkVariant,__GetIID_ISAXDTDHandler,nil,nil,false,0);
    DefineProp('IID_ISAXErrorHandler',tkVariant,__GetIID_ISAXErrorHandler,nil,nil,false,0);
    DefineProp('IID_ISAXXMLFilter',tkVariant,__GetIID_ISAXXMLFilter,nil,nil,false,0);
    DefineProp('IID_ISAXLexicalHandler',tkVariant,__GetIID_ISAXLexicalHandler,nil,nil,false,0);
    DefineProp('IID_ISAXDeclHandler',tkVariant,__GetIID_ISAXDeclHandler,nil,nil,false,0);
    DefineProp('IID_IVBSAXXMLReader',tkVariant,__GetIID_IVBSAXXMLReader,nil,nil,false,0);
    DefineProp('IID_IVBSAXEntityResolver',tkVariant,__GetIID_IVBSAXEntityResolver,nil,nil,false,0);
    DefineProp('IID_IVBSAXContentHandler',tkVariant,__GetIID_IVBSAXContentHandler,nil,nil,false,0);
    DefineProp('IID_IVBSAXLocator',tkVariant,__GetIID_IVBSAXLocator,nil,nil,false,0);
    DefineProp('IID_IVBSAXAttributes',tkVariant,__GetIID_IVBSAXAttributes,nil,nil,false,0);
    DefineProp('IID_IVBSAXDTDHandler',tkVariant,__GetIID_IVBSAXDTDHandler,nil,nil,false,0);
    DefineProp('IID_IVBSAXErrorHandler',tkVariant,__GetIID_IVBSAXErrorHandler,nil,nil,false,0);
    DefineProp('IID_IVBSAXXMLFilter',tkVariant,__GetIID_IVBSAXXMLFilter,nil,nil,false,0);
    DefineProp('IID_IVBSAXLexicalHandler',tkVariant,__GetIID_IVBSAXLexicalHandler,nil,nil,false,0);
    DefineProp('IID_IVBSAXDeclHandler',tkVariant,__GetIID_IVBSAXDeclHandler,nil,nil,false,0);
    DefineProp('IID_IMXWriter',tkVariant,__GetIID_IMXWriter,nil,nil,false,0);
    DefineProp('IID_IMXAttributes',tkVariant,__GetIID_IMXAttributes,nil,nil,false,0);
    DefineProp('IID_IMXReaderControl',tkVariant,__GetIID_IMXReaderControl,nil,nil,false,0);
    DefineProp('IID_IMXSchemaDeclHandler',tkVariant,__GetIID_IMXSchemaDeclHandler,nil,nil,false,0);
    DefineProp('IID_ISchemaItem',tkVariant,__GetIID_ISchemaItem,nil,nil,false,0);
    DefineProp('IID_ISchemaParticle',tkVariant,__GetIID_ISchemaParticle,nil,nil,false,0);
    DefineProp('IID_ISchemaElement',tkVariant,__GetIID_ISchemaElement,nil,nil,false,0);
    DefineProp('IID_ISchema',tkVariant,__GetIID_ISchema,nil,nil,false,0);
    DefineProp('IID_ISchemaItemCollection',tkVariant,__GetIID_ISchemaItemCollection,nil,nil,false,0);
    DefineProp('IID_ISchemaStringCollection',tkVariant,__GetIID_ISchemaStringCollection,nil,nil,false,0);
    DefineProp('IID_ISchemaType',tkVariant,__GetIID_ISchemaType,nil,nil,false,0);
    DefineProp('IID_ISchemaComplexType',tkVariant,__GetIID_ISchemaComplexType,nil,nil,false,0);
    DefineProp('IID_ISchemaAny',tkVariant,__GetIID_ISchemaAny,nil,nil,false,0);
    DefineProp('IID_ISchemaModelGroup',tkVariant,__GetIID_ISchemaModelGroup,nil,nil,false,0);
    DefineProp('IID_IMXXMLFilter',tkVariant,__GetIID_IMXXMLFilter,nil,nil,false,0);
    DefineProp('IID_IXMLDOMSchemaCollection2',tkVariant,__GetIID_IXMLDOMSchemaCollection2,nil,nil,false,0);
    DefineProp('IID_ISchemaAttribute',tkVariant,__GetIID_ISchemaAttribute,nil,nil,false,0);
    DefineProp('IID_ISchemaAttributeGroup',tkVariant,__GetIID_ISchemaAttributeGroup,nil,nil,false,0);
    DefineProp('IID_ISchemaIdentityConstraint',tkVariant,__GetIID_ISchemaIdentityConstraint,nil,nil,false,0);
    DefineProp('IID_ISchemaNotation',tkVariant,__GetIID_ISchemaNotation,nil,nil,false,0);
    DefineProp('IID_IXMLDOMSelection',tkVariant,__GetIID_IXMLDOMSelection,nil,nil,false,0);
    DefineProp('DIID_XMLDOMDocumentEvents',tkVariant,__GetDIID_XMLDOMDocumentEvents,nil,nil,false,0);
    DefineProp('IID_IDSOControl',tkVariant,__GetIID_IDSOControl,nil,nil,false,0);
    DefineProp('IID_IXMLHTTPRequest',tkVariant,__GetIID_IXMLHTTPRequest,nil,nil,false,0);
    DefineProp('IID_IServerXMLHTTPRequest',tkVariant,__GetIID_IServerXMLHTTPRequest,nil,nil,false,0);
    DefineProp('IID_IServerXMLHTTPRequest2',tkVariant,__GetIID_IServerXMLHTTPRequest2,nil,nil,false,0);
    DefineProp('IID_IMXNamespacePrefixes',tkVariant,__GetIID_IMXNamespacePrefixes,nil,nil,false,0);
    DefineProp('IID_IVBMXNamespaceManager',tkVariant,__GetIID_IVBMXNamespaceManager,nil,nil,false,0);
    DefineProp('IID_IMXNamespaceManager',tkVariant,__GetIID_IMXNamespaceManager,nil,nil,false,0);
    DefineProp('CLASS_DOMDocument',tkVariant,__GetCLASS_DOMDocument,nil,nil,false,0);
    DefineProp('CLASS_DOMDocument26',tkVariant,__GetCLASS_DOMDocument26,nil,nil,false,0);
    DefineProp('CLASS_DOMDocument30',tkVariant,__GetCLASS_DOMDocument30,nil,nil,false,0);
    DefineProp('CLASS_DOMDocument40',tkVariant,__GetCLASS_DOMDocument40,nil,nil,false,0);
    DefineProp('CLASS_DOMDocument60',tkVariant,__GetCLASS_DOMDocument60,nil,nil,false,0);
    DefineProp('CLASS_FreeThreadedDOMDocument',tkVariant,__GetCLASS_FreeThreadedDOMDocument,nil,nil,false,0);
    DefineProp('CLASS_FreeThreadedDOMDocument26',tkVariant,__GetCLASS_FreeThreadedDOMDocument26,nil,nil,false,0);
    DefineProp('CLASS_FreeThreadedDOMDocument30',tkVariant,__GetCLASS_FreeThreadedDOMDocument30,nil,nil,false,0);
    DefineProp('CLASS_FreeThreadedDOMDocument40',tkVariant,__GetCLASS_FreeThreadedDOMDocument40,nil,nil,false,0);
    DefineProp('CLASS_FreeThreadedDOMDocument60',tkVariant,__GetCLASS_FreeThreadedDOMDocument60,nil,nil,false,0);
    DefineProp('CLASS_XMLSchemaCache',tkVariant,__GetCLASS_XMLSchemaCache,nil,nil,false,0);
    DefineProp('CLASS_XMLSchemaCache26',tkVariant,__GetCLASS_XMLSchemaCache26,nil,nil,false,0);
    DefineProp('CLASS_XMLSchemaCache30',tkVariant,__GetCLASS_XMLSchemaCache30,nil,nil,false,0);
    DefineProp('CLASS_XMLSchemaCache40',tkVariant,__GetCLASS_XMLSchemaCache40,nil,nil,false,0);
    DefineProp('CLASS_XMLSchemaCache60',tkVariant,__GetCLASS_XMLSchemaCache60,nil,nil,false,0);
    DefineProp('CLASS_XSLTemplate',tkVariant,__GetCLASS_XSLTemplate,nil,nil,false,0);
    DefineProp('CLASS_XSLTemplate26',tkVariant,__GetCLASS_XSLTemplate26,nil,nil,false,0);
    DefineProp('CLASS_XSLTemplate30',tkVariant,__GetCLASS_XSLTemplate30,nil,nil,false,0);
    DefineProp('CLASS_XSLTemplate40',tkVariant,__GetCLASS_XSLTemplate40,nil,nil,false,0);
    DefineProp('CLASS_XSLTemplate60',tkVariant,__GetCLASS_XSLTemplate60,nil,nil,false,0);
    DefineProp('CLASS_DSOControl',tkVariant,__GetCLASS_DSOControl,nil,nil,false,0);
    DefineProp('CLASS_DSOControl26',tkVariant,__GetCLASS_DSOControl26,nil,nil,false,0);
    DefineProp('CLASS_DSOControl30',tkVariant,__GetCLASS_DSOControl30,nil,nil,false,0);
    DefineProp('CLASS_DSOControl40',tkVariant,__GetCLASS_DSOControl40,nil,nil,false,0);
    DefineProp('CLASS_XMLHTTP',tkVariant,__GetCLASS_XMLHTTP,nil,nil,false,0);
    DefineProp('CLASS_XMLHTTP26',tkVariant,__GetCLASS_XMLHTTP26,nil,nil,false,0);
    DefineProp('CLASS_XMLHTTP30',tkVariant,__GetCLASS_XMLHTTP30,nil,nil,false,0);
    DefineProp('CLASS_XMLHTTP40',tkVariant,__GetCLASS_XMLHTTP40,nil,nil,false,0);
    DefineProp('CLASS_XMLHTTP60',tkVariant,__GetCLASS_XMLHTTP60,nil,nil,false,0);
    DefineProp('CLASS_ServerXMLHTTP',tkVariant,__GetCLASS_ServerXMLHTTP,nil,nil,false,0);
    DefineProp('CLASS_ServerXMLHTTP30',tkVariant,__GetCLASS_ServerXMLHTTP30,nil,nil,false,0);
    DefineProp('CLASS_ServerXMLHTTP40',tkVariant,__GetCLASS_ServerXMLHTTP40,nil,nil,false,0);
    DefineProp('CLASS_ServerXMLHTTP60',tkVariant,__GetCLASS_ServerXMLHTTP60,nil,nil,false,0);
    DefineProp('CLASS_SAXXMLReader',tkVariant,__GetCLASS_SAXXMLReader,nil,nil,false,0);
    DefineProp('CLASS_SAXXMLReader30',tkVariant,__GetCLASS_SAXXMLReader30,nil,nil,false,0);
    DefineProp('CLASS_SAXXMLReader40',tkVariant,__GetCLASS_SAXXMLReader40,nil,nil,false,0);
    DefineProp('CLASS_SAXXMLReader60',tkVariant,__GetCLASS_SAXXMLReader60,nil,nil,false,0);
    DefineProp('CLASS_MXXMLWriter',tkVariant,__GetCLASS_MXXMLWriter,nil,nil,false,0);
    DefineProp('CLASS_MXXMLWriter30',tkVariant,__GetCLASS_MXXMLWriter30,nil,nil,false,0);
    DefineProp('CLASS_MXXMLWriter40',tkVariant,__GetCLASS_MXXMLWriter40,nil,nil,false,0);
    DefineProp('CLASS_MXXMLWriter60',tkVariant,__GetCLASS_MXXMLWriter60,nil,nil,false,0);
    DefineProp('CLASS_MXHTMLWriter',tkVariant,__GetCLASS_MXHTMLWriter,nil,nil,false,0);
    DefineProp('CLASS_MXHTMLWriter30',tkVariant,__GetCLASS_MXHTMLWriter30,nil,nil,false,0);
    DefineProp('CLASS_MXHTMLWriter40',tkVariant,__GetCLASS_MXHTMLWriter40,nil,nil,false,0);
    DefineProp('CLASS_MXHTMLWriter60',tkVariant,__GetCLASS_MXHTMLWriter60,nil,nil,false,0);
    DefineProp('CLASS_SAXAttributes',tkVariant,__GetCLASS_SAXAttributes,nil,nil,false,0);
    DefineProp('CLASS_SAXAttributes30',tkVariant,__GetCLASS_SAXAttributes30,nil,nil,false,0);
    DefineProp('CLASS_SAXAttributes40',tkVariant,__GetCLASS_SAXAttributes40,nil,nil,false,0);
    DefineProp('CLASS_SAXAttributes60',tkVariant,__GetCLASS_SAXAttributes60,nil,nil,false,0);
    DefineProp('CLASS_MXNamespaceManager',tkVariant,__GetCLASS_MXNamespaceManager,nil,nil,false,0);
    DefineProp('CLASS_MXNamespaceManager40',tkVariant,__GetCLASS_MXNamespaceManager40,nil,nil,false,0);
    DefineProp('CLASS_MXNamespaceManager60',tkVariant,__GetCLASS_MXNamespaceManager60,nil,nil,false,0);
    AddConstant('MSXML2MajorVersion',MSXML2MajorVersion);
    AddConstant('MSXML2MinorVersion',MSXML2MinorVersion);
    AddConstant('NODE_INVALID',NODE_INVALID);
    AddConstant('NODE_ELEMENT',NODE_ELEMENT);
    AddConstant('NODE_ATTRIBUTE',NODE_ATTRIBUTE);
    AddConstant('NODE_TEXT',NODE_TEXT);
    AddConstant('NODE_CDATA_SECTION',NODE_CDATA_SECTION);
    AddConstant('NODE_ENTITY_REFERENCE',NODE_ENTITY_REFERENCE);
    AddConstant('NODE_ENTITY',NODE_ENTITY);
    AddConstant('NODE_PROCESSING_INSTRUCTION',NODE_PROCESSING_INSTRUCTION);
    AddConstant('NODE_COMMENT',NODE_COMMENT);
    AddConstant('NODE_DOCUMENT',NODE_DOCUMENT);
    AddConstant('NODE_DOCUMENT_TYPE',NODE_DOCUMENT_TYPE);
    AddConstant('NODE_DOCUMENT_FRAGMENT',NODE_DOCUMENT_FRAGMENT);
    AddConstant('NODE_NOTATION',NODE_NOTATION);
    AddConstant('SOMITEM_SCHEMA',SOMITEM_SCHEMA);
    AddConstant('SOMITEM_ATTRIBUTE',SOMITEM_ATTRIBUTE);
    AddConstant('SOMITEM_ATTRIBUTEGROUP',SOMITEM_ATTRIBUTEGROUP);
    AddConstant('SOMITEM_NOTATION',SOMITEM_NOTATION);
    AddConstant('SOMITEM_ANNOTATION',SOMITEM_ANNOTATION);
    AddConstant('SOMITEM_IDENTITYCONSTRAINT',SOMITEM_IDENTITYCONSTRAINT);
    AddConstant('SOMITEM_KEY',SOMITEM_KEY);
    AddConstant('SOMITEM_KEYREF',SOMITEM_KEYREF);
    AddConstant('SOMITEM_UNIQUE',SOMITEM_UNIQUE);
    AddConstant('SOMITEM_ANYTYPE',SOMITEM_ANYTYPE);
    AddConstant('SOMITEM_DATATYPE',SOMITEM_DATATYPE);
    AddConstant('SOMITEM_DATATYPE_ANYTYPE',SOMITEM_DATATYPE_ANYTYPE);
    AddConstant('SOMITEM_DATATYPE_ANYURI',SOMITEM_DATATYPE_ANYURI);
    AddConstant('SOMITEM_DATATYPE_BASE64BINARY',SOMITEM_DATATYPE_BASE64BINARY);
    AddConstant('SOMITEM_DATATYPE_BOOLEAN',SOMITEM_DATATYPE_BOOLEAN);
    AddConstant('SOMITEM_DATATYPE_BYTE',SOMITEM_DATATYPE_BYTE);
    AddConstant('SOMITEM_DATATYPE_DATE',SOMITEM_DATATYPE_DATE);
    AddConstant('SOMITEM_DATATYPE_DATETIME',SOMITEM_DATATYPE_DATETIME);
    AddConstant('SOMITEM_DATATYPE_DAY',SOMITEM_DATATYPE_DAY);
    AddConstant('SOMITEM_DATATYPE_DECIMAL',SOMITEM_DATATYPE_DECIMAL);
    AddConstant('SOMITEM_DATATYPE_DOUBLE',SOMITEM_DATATYPE_DOUBLE);
    AddConstant('SOMITEM_DATATYPE_DURATION',SOMITEM_DATATYPE_DURATION);
    AddConstant('SOMITEM_DATATYPE_ENTITIES',SOMITEM_DATATYPE_ENTITIES);
    AddConstant('SOMITEM_DATATYPE_ENTITY',SOMITEM_DATATYPE_ENTITY);
    AddConstant('SOMITEM_DATATYPE_FLOAT',SOMITEM_DATATYPE_FLOAT);
    AddConstant('SOMITEM_DATATYPE_HEXBINARY',SOMITEM_DATATYPE_HEXBINARY);
    AddConstant('SOMITEM_DATATYPE_ID',SOMITEM_DATATYPE_ID);
    AddConstant('SOMITEM_DATATYPE_IDREF',SOMITEM_DATATYPE_IDREF);
    AddConstant('SOMITEM_DATATYPE_IDREFS',SOMITEM_DATATYPE_IDREFS);
    AddConstant('SOMITEM_DATATYPE_INT',SOMITEM_DATATYPE_INT);
    AddConstant('SOMITEM_DATATYPE_INTEGER',SOMITEM_DATATYPE_INTEGER);
    AddConstant('SOMITEM_DATATYPE_LANGUAGE',SOMITEM_DATATYPE_LANGUAGE);
    AddConstant('SOMITEM_DATATYPE_LONG',SOMITEM_DATATYPE_LONG);
    AddConstant('SOMITEM_DATATYPE_MONTH',SOMITEM_DATATYPE_MONTH);
    AddConstant('SOMITEM_DATATYPE_MONTHDAY',SOMITEM_DATATYPE_MONTHDAY);
    AddConstant('SOMITEM_DATATYPE_NAME',SOMITEM_DATATYPE_NAME);
    AddConstant('SOMITEM_DATATYPE_NCNAME',SOMITEM_DATATYPE_NCNAME);
    AddConstant('SOMITEM_DATATYPE_NEGATIVEINTEGER',SOMITEM_DATATYPE_NEGATIVEINTEGER);
    AddConstant('SOMITEM_DATATYPE_NMTOKEN',SOMITEM_DATATYPE_NMTOKEN);
    AddConstant('SOMITEM_DATATYPE_NMTOKENS',SOMITEM_DATATYPE_NMTOKENS);
    AddConstant('SOMITEM_DATATYPE_NONNEGATIVEINTEGER',SOMITEM_DATATYPE_NONNEGATIVEINTEGER);
    AddConstant('SOMITEM_DATATYPE_NONPOSITIVEINTEGER',SOMITEM_DATATYPE_NONPOSITIVEINTEGER);
    AddConstant('SOMITEM_DATATYPE_NORMALIZEDSTRING',SOMITEM_DATATYPE_NORMALIZEDSTRING);
    AddConstant('SOMITEM_DATATYPE_NOTATION',SOMITEM_DATATYPE_NOTATION);
    AddConstant('SOMITEM_DATATYPE_POSITIVEINTEGER',SOMITEM_DATATYPE_POSITIVEINTEGER);
    AddConstant('SOMITEM_DATATYPE_QNAME',SOMITEM_DATATYPE_QNAME);
    AddConstant('SOMITEM_DATATYPE_SHORT',SOMITEM_DATATYPE_SHORT);
    AddConstant('SOMITEM_DATATYPE_STRING',SOMITEM_DATATYPE_STRING);
    AddConstant('SOMITEM_DATATYPE_TIME',SOMITEM_DATATYPE_TIME);
    AddConstant('SOMITEM_DATATYPE_TOKEN',SOMITEM_DATATYPE_TOKEN);
    AddConstant('SOMITEM_DATATYPE_UNSIGNEDBYTE',SOMITEM_DATATYPE_UNSIGNEDBYTE);
    AddConstant('SOMITEM_DATATYPE_UNSIGNEDINT',SOMITEM_DATATYPE_UNSIGNEDINT);
    AddConstant('SOMITEM_DATATYPE_UNSIGNEDLONG',SOMITEM_DATATYPE_UNSIGNEDLONG);
    AddConstant('SOMITEM_DATATYPE_UNSIGNEDSHORT',SOMITEM_DATATYPE_UNSIGNEDSHORT);
    AddConstant('SOMITEM_DATATYPE_YEAR',SOMITEM_DATATYPE_YEAR);
    AddConstant('SOMITEM_DATATYPE_YEARMONTH',SOMITEM_DATATYPE_YEARMONTH);
    AddConstant('SOMITEM_DATATYPE_ANYSIMPLETYPE',SOMITEM_DATATYPE_ANYSIMPLETYPE);
    AddConstant('SOMITEM_SIMPLETYPE',SOMITEM_SIMPLETYPE);
    AddConstant('SOMITEM_COMPLEXTYPE',SOMITEM_COMPLEXTYPE);
    AddConstant('SOMITEM_PARTICLE',SOMITEM_PARTICLE);
    AddConstant('SOMITEM_ANY',SOMITEM_ANY);
    AddConstant('SOMITEM_ANYATTRIBUTE',SOMITEM_ANYATTRIBUTE);
    AddConstant('SOMITEM_ELEMENT',SOMITEM_ELEMENT);
    AddConstant('SOMITEM_GROUP',SOMITEM_GROUP);
    AddConstant('SOMITEM_ALL',SOMITEM_ALL);
    AddConstant('SOMITEM_CHOICE',SOMITEM_CHOICE);
    AddConstant('SOMITEM_SEQUENCE',SOMITEM_SEQUENCE);
    AddConstant('SOMITEM_EMPTYPARTICLE',SOMITEM_EMPTYPARTICLE);
    AddConstant('SOMITEM_NULL',SOMITEM_NULL);
    AddConstant('SOMITEM_NULL_TYPE',SOMITEM_NULL_TYPE);
    AddConstant('SOMITEM_NULL_ANY',SOMITEM_NULL_ANY);
    AddConstant('SOMITEM_NULL_ANYATTRIBUTE',SOMITEM_NULL_ANYATTRIBUTE);
    AddConstant('SOMITEM_NULL_ELEMENT',SOMITEM_NULL_ELEMENT);
    AddConstant('SCHEMADERIVATIONMETHOD_EMPTY',SCHEMADERIVATIONMETHOD_EMPTY);
    AddConstant('SCHEMADERIVATIONMETHOD_SUBSTITUTION',SCHEMADERIVATIONMETHOD_SUBSTITUTION);
    AddConstant('SCHEMADERIVATIONMETHOD_EXTENSION',SCHEMADERIVATIONMETHOD_EXTENSION);
    AddConstant('SCHEMADERIVATIONMETHOD_RESTRICTION',SCHEMADERIVATIONMETHOD_RESTRICTION);
    AddConstant('SCHEMADERIVATIONMETHOD_LIST',SCHEMADERIVATIONMETHOD_LIST);
    AddConstant('SCHEMADERIVATIONMETHOD_UNION',SCHEMADERIVATIONMETHOD_UNION);
    AddConstant('SCHEMADERIVATIONMETHOD_ALL',SCHEMADERIVATIONMETHOD_ALL);
    AddConstant('SCHEMADERIVATIONMETHOD_NONE',SCHEMADERIVATIONMETHOD_NONE);
    AddConstant('SCHEMATYPEVARIETY_NONE',SCHEMATYPEVARIETY_NONE);
    AddConstant('SCHEMATYPEVARIETY_ATOMIC',SCHEMATYPEVARIETY_ATOMIC);
    AddConstant('SCHEMATYPEVARIETY_LIST',SCHEMATYPEVARIETY_LIST);
    AddConstant('SCHEMATYPEVARIETY_UNION',SCHEMATYPEVARIETY_UNION);
    AddConstant('SCHEMAWHITESPACE_NONE',SCHEMAWHITESPACE_NONE);
    AddConstant('SCHEMAWHITESPACE_PRESERVE',SCHEMAWHITESPACE_PRESERVE);
    AddConstant('SCHEMAWHITESPACE_REPLACE',SCHEMAWHITESPACE_REPLACE);
    AddConstant('SCHEMAWHITESPACE_COLLAPSE',SCHEMAWHITESPACE_COLLAPSE);
    AddConstant('SCHEMAPROCESSCONTENTS_NONE',SCHEMAPROCESSCONTENTS_NONE);
    AddConstant('SCHEMAPROCESSCONTENTS_SKIP',SCHEMAPROCESSCONTENTS_SKIP);
    AddConstant('SCHEMAPROCESSCONTENTS_LAX',SCHEMAPROCESSCONTENTS_LAX);
    AddConstant('SCHEMAPROCESSCONTENTS_STRICT',SCHEMAPROCESSCONTENTS_STRICT);
    AddConstant('SCHEMACONTENTTYPE_EMPTY',SCHEMACONTENTTYPE_EMPTY);
    AddConstant('SCHEMACONTENTTYPE_TEXTONLY',SCHEMACONTENTTYPE_TEXTONLY);
    AddConstant('SCHEMACONTENTTYPE_ELEMENTONLY',SCHEMACONTENTTYPE_ELEMENTONLY);
    AddConstant('SCHEMACONTENTTYPE_MIXED',SCHEMACONTENTTYPE_MIXED);
    AddConstant('SCHEMAUSE_OPTIONAL',SCHEMAUSE_OPTIONAL);
    AddConstant('SCHEMAUSE_PROHIBITED',SCHEMAUSE_PROHIBITED);
    AddConstant('SCHEMAUSE_REQUIRED',SCHEMAUSE_REQUIRED);
    AddConstant('SXH_OPTION_URL',SXH_OPTION_URL);
    AddConstant('SXH_OPTION_URL_CODEPAGE',SXH_OPTION_URL_CODEPAGE);
    AddConstant('SXH_OPTION_ESCAPE_PERCENT_IN_URL',SXH_OPTION_ESCAPE_PERCENT_IN_URL);
    AddConstant('SXH_OPTION_IGNORE_SERVER_SSL_CERT_ERROR_FLAGS',SXH_OPTION_IGNORE_SERVER_SSL_CERT_ERROR_FLAGS);
    AddConstant('SXH_OPTION_SELECT_CLIENT_SSL_CERT',SXH_OPTION_SELECT_CLIENT_SSL_CERT);
    AddConstant('SXH_SERVER_CERT_IGNORE_UNKNOWN_CA',SXH_SERVER_CERT_IGNORE_UNKNOWN_CA);
    AddConstant('SXH_SERVER_CERT_IGNORE_WRONG_USAGE',SXH_SERVER_CERT_IGNORE_WRONG_USAGE);
    AddConstant('SXH_SERVER_CERT_IGNORE_CERT_CN_INVALID',SXH_SERVER_CERT_IGNORE_CERT_CN_INVALID);
    AddConstant('SXH_SERVER_CERT_IGNORE_CERT_DATE_INVALID',SXH_SERVER_CERT_IGNORE_CERT_DATE_INVALID);
    AddConstant('SXH_SERVER_CERT_IGNORE_ALL_SERVER_ERRORS',SXH_SERVER_CERT_IGNORE_ALL_SERVER_ERRORS);
    AddConstant('SXH_PROXY_SET_DEFAULT',SXH_PROXY_SET_DEFAULT);
    AddConstant('SXH_PROXY_SET_PRECONFIG',SXH_PROXY_SET_PRECONFIG);
    AddConstant('SXH_PROXY_SET_DIRECT',SXH_PROXY_SET_DIRECT);
    AddConstant('SXH_PROXY_SET_PROXY',SXH_PROXY_SET_PROXY);
  end;
end;

class function TatmsxmlLibrary.LibraryName: string;
begin
  result := 'msxml';
end;

initialization
  RegisterScripterLibrary(TatmsxmlLibrary, True);

{$WARNINGS ON}

end.

