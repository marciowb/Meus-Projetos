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
    procedure __GetLIBID_MSXML(AMachine: TatVirtualMachine);
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
    procedure __GetIID_IXMLDOMNotation(AMachine: TatVirtualMachine);
    procedure __GetIID_IXMLDOMEntity(AMachine: TatVirtualMachine);
    procedure __GetIID_IXTLRuntime(AMachine: TatVirtualMachine);
    procedure __GetDIID_XMLDOMDocumentEvents(AMachine: TatVirtualMachine);
    procedure __GetCLASS_DOMDocument(AMachine: TatVirtualMachine);
    procedure __GetCLASS_DOMFreeThreadedDocument(AMachine: TatVirtualMachine);
    procedure __GetIID_IXMLHttpRequest(AMachine: TatVirtualMachine);
    procedure __GetCLASS_XMLHTTPRequest(AMachine: TatVirtualMachine);
    procedure __GetIID_IXMLDSOControl(AMachine: TatVirtualMachine);
    procedure __GetCLASS_XMLDSOControl(AMachine: TatVirtualMachine);
    procedure __GetIID_IXMLElementCollection(AMachine: TatVirtualMachine);
    procedure __GetIID_IXMLDocument(AMachine: TatVirtualMachine);
    procedure __GetIID_IXMLElement(AMachine: TatVirtualMachine);
    procedure __GetIID_IXMLDocument2(AMachine: TatVirtualMachine);
    procedure __GetIID_IXMLElement2(AMachine: TatVirtualMachine);
    procedure __GetIID_IXMLAttribute(AMachine: TatVirtualMachine);
    procedure __GetIID_IXMLError(AMachine: TatVirtualMachine);
    procedure __GetCLASS_XMLDocument(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  CoDOMDocumentClass = class of CoDOMDocument;
  CoDOMFreeThreadedDocumentClass = class of CoDOMFreeThreadedDocument;
  CoXMLHTTPRequestClass = class of CoXMLHTTPRequest;
  CoXMLDSOControlClass = class of CoXMLDSOControl;
  CoXMLDocumentClass = class of CoXMLDocument;


  _xml_errorWrapper = class(TatRecordWrapper)
  private
    F_nLine: SYSUINT;
    F_pchBuf: WideString;
    F_cchBuf: SYSUINT;
    F_ich: SYSUINT;
    F_pszFound: WideString;
    F_pszExpected: WideString;
    F_reserved1: LongWord;
    F_reserved2: LongWord;
  public
    constructor Create(ARecord: _xml_error);
    function ObjToRec: _xml_error;
  published
    property _nLine: SYSUINT read F_nLine write F_nLine;
    property _pchBuf: WideString read F_pchBuf write F_pchBuf;
    property _cchBuf: SYSUINT read F_cchBuf write F_cchBuf;
    property _ich: SYSUINT read F_ich write F_ich;
    property _pszFound: WideString read F_pszFound write F_pszFound;
    property _pszExpected: WideString read F_pszExpected write F_pszExpected;
    property _reserved1: LongWord read F_reserved1 write F_reserved1;
    property _reserved2: LongWord read F_reserved2 write F_reserved2;
  end;
  

implementation

constructor _xml_errorWrapper.Create(ARecord: _xml_error);
begin
  inherited Create;
  F_nLine := ARecord._nLine;
  F_pchBuf := ARecord._pchBuf;
  F_cchBuf := ARecord._cchBuf;
  F_ich := ARecord._ich;
  F_pszFound := ARecord._pszFound;
  F_pszExpected := ARecord._pszExpected;
  F_reserved1 := ARecord._reserved1;
  F_reserved2 := ARecord._reserved2;
end;

function _xml_errorWrapper.ObjToRec: _xml_error;
begin
  result._nLine := F_nLine;
  result._pchBuf := F_pchBuf;
  result._cchBuf := F_cchBuf;
  result._ich := F_ich;
  result._pszFound := F_pszFound;
  result._pszExpected := F_pszExpected;
  result._reserved1 := F_reserved1;
  result._reserved2 := F_reserved2;
end;



procedure TatmsxmlLibrary.__GetLIBID_MSXML(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.LIBID_MSXML)));
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

procedure TatmsxmlLibrary.__GetIID_IXTLRuntime(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.IID_IXTLRuntime)));
  end;
end;

procedure TatmsxmlLibrary.__GetDIID_XMLDOMDocumentEvents(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.DIID_XMLDOMDocumentEvents)));
  end;
end;

procedure TatmsxmlLibrary.__GetCLASS_DOMDocument(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.CLASS_DOMDocument)));
  end;
end;

procedure TatmsxmlLibrary.__GetCLASS_DOMFreeThreadedDocument(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.CLASS_DOMFreeThreadedDocument)));
  end;
end;

procedure TatmsxmlLibrary.__GetIID_IXMLHttpRequest(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.IID_IXMLHttpRequest)));
  end;
end;

procedure TatmsxmlLibrary.__GetCLASS_XMLHTTPRequest(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.CLASS_XMLHTTPRequest)));
  end;
end;

procedure TatmsxmlLibrary.__GetIID_IXMLDSOControl(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.IID_IXMLDSOControl)));
  end;
end;

procedure TatmsxmlLibrary.__GetCLASS_XMLDSOControl(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.CLASS_XMLDSOControl)));
  end;
end;

procedure TatmsxmlLibrary.__GetIID_IXMLElementCollection(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.IID_IXMLElementCollection)));
  end;
end;

procedure TatmsxmlLibrary.__GetIID_IXMLDocument(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.IID_IXMLDocument)));
  end;
end;

procedure TatmsxmlLibrary.__GetIID_IXMLElement(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.IID_IXMLElement)));
  end;
end;

procedure TatmsxmlLibrary.__GetIID_IXMLDocument2(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.IID_IXMLDocument2)));
  end;
end;

procedure TatmsxmlLibrary.__GetIID_IXMLElement2(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.IID_IXMLElement2)));
  end;
end;

procedure TatmsxmlLibrary.__GetIID_IXMLAttribute(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.IID_IXMLAttribute)));
  end;
end;

procedure TatmsxmlLibrary.__GetIID_IXMLError(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.IID_IXMLError)));
  end;
end;

procedure TatmsxmlLibrary.__GetCLASS_XMLDocument(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(msxml.CLASS_XMLDocument)));
  end;
end;

procedure TatmsxmlLibrary.Init;
begin
  With Scripter.DefineClass(CoDOMDocument) do
  begin
  end;
  With Scripter.DefineClass(CoDOMFreeThreadedDocument) do
  begin
  end;
  With Scripter.DefineClass(CoXMLHTTPRequest) do
  begin
  end;
  With Scripter.DefineClass(CoXMLDSOControl) do
  begin
  end;
  With Scripter.DefineClass(CoXMLDocument) do
  begin
  end;
  With Scripter.DefineClass(ClassType) do
  begin
    DefineProp('LIBID_MSXML',tkVariant,__GetLIBID_MSXML,nil,nil,false,0);
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
    DefineProp('IID_IXMLDOMNotation',tkVariant,__GetIID_IXMLDOMNotation,nil,nil,false,0);
    DefineProp('IID_IXMLDOMEntity',tkVariant,__GetIID_IXMLDOMEntity,nil,nil,false,0);
    DefineProp('IID_IXTLRuntime',tkVariant,__GetIID_IXTLRuntime,nil,nil,false,0);
    DefineProp('DIID_XMLDOMDocumentEvents',tkVariant,__GetDIID_XMLDOMDocumentEvents,nil,nil,false,0);
    DefineProp('CLASS_DOMDocument',tkVariant,__GetCLASS_DOMDocument,nil,nil,false,0);
    DefineProp('CLASS_DOMFreeThreadedDocument',tkVariant,__GetCLASS_DOMFreeThreadedDocument,nil,nil,false,0);
    DefineProp('IID_IXMLHttpRequest',tkVariant,__GetIID_IXMLHttpRequest,nil,nil,false,0);
    DefineProp('CLASS_XMLHTTPRequest',tkVariant,__GetCLASS_XMLHTTPRequest,nil,nil,false,0);
    DefineProp('IID_IXMLDSOControl',tkVariant,__GetIID_IXMLDSOControl,nil,nil,false,0);
    DefineProp('CLASS_XMLDSOControl',tkVariant,__GetCLASS_XMLDSOControl,nil,nil,false,0);
    DefineProp('IID_IXMLElementCollection',tkVariant,__GetIID_IXMLElementCollection,nil,nil,false,0);
    DefineProp('IID_IXMLDocument',tkVariant,__GetIID_IXMLDocument,nil,nil,false,0);
    DefineProp('IID_IXMLElement',tkVariant,__GetIID_IXMLElement,nil,nil,false,0);
    DefineProp('IID_IXMLDocument2',tkVariant,__GetIID_IXMLDocument2,nil,nil,false,0);
    DefineProp('IID_IXMLElement2',tkVariant,__GetIID_IXMLElement2,nil,nil,false,0);
    DefineProp('IID_IXMLAttribute',tkVariant,__GetIID_IXMLAttribute,nil,nil,false,0);
    DefineProp('IID_IXMLError',tkVariant,__GetIID_IXMLError,nil,nil,false,0);
    DefineProp('CLASS_XMLDocument',tkVariant,__GetCLASS_XMLDocument,nil,nil,false,0);
    AddConstant('MSXMLMajorVersion',MSXMLMajorVersion);
    AddConstant('MSXMLMinorVersion',MSXMLMinorVersion);
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
    AddConstant('XMLELEMTYPE_ELEMENT',XMLELEMTYPE_ELEMENT);
    AddConstant('XMLELEMTYPE_TEXT',XMLELEMTYPE_TEXT);
    AddConstant('XMLELEMTYPE_COMMENT',XMLELEMTYPE_COMMENT);
    AddConstant('XMLELEMTYPE_DOCUMENT',XMLELEMTYPE_DOCUMENT);
    AddConstant('XMLELEMTYPE_DTD',XMLELEMTYPE_DTD);
    AddConstant('XMLELEMTYPE_PI',XMLELEMTYPE_PI);
    AddConstant('XMLELEMTYPE_OTHER',XMLELEMTYPE_OTHER);
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

