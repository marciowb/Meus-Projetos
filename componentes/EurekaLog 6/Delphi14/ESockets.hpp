// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Esockets.pas' rev: 21.00

#ifndef EsocketsHPP
#define EsocketsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Winsock.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Esockets
{
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TSocketErrorEvent)(System::TObject* Sender, int ErrorCode, const System::AnsiString ErrorMsg);

typedef void __fastcall (__closure *TSocketSendEvent)(System::TObject* Sender, int BytesSent, int TotalBytes);

class DELPHICLASS TEurekaClientSocket;
class PASCALIMPLEMENTATION TEurekaClientSocket : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	sockaddr_in FAddr;
	System::AnsiString FHost;
	System::Word FPort;
	int FType;
	unsigned FTimeout;
	bool FConnected;
	int FSocket;
	System::AnsiString FLog;
	System::AnsiString FErrorLog;
	TSocketErrorEvent FOnError;
	TSocketSendEvent FOnSent;
	bool FQuietErrors;
	in_addr __fastcall LookupName(const System::AnsiString Name);
	
protected:
	int __fastcall SendBuf(void *Buf, int Count);
	int __fastcall ReceiveBuf(void *Buf, int Count);
	void __fastcall Error(const System::AnsiString Msg, System::TVarRec const *Args, const int Args_Size);
	
public:
	__fastcall TEurekaClientSocket(const System::AnsiString Host, System::Word Port, bool TCP, unsigned Timeout);
	__fastcall virtual ~TEurekaClientSocket(void);
	virtual void __fastcall Open(void);
	virtual void __fastcall Close(void);
	int __fastcall SendText(const System::AnsiString Text);
	System::AnsiString __fastcall ReceiveText(void);
	System::AnsiString __fastcall GetFullText(void);
	System::AnsiString __fastcall ReceiveFullText(void);
	__property bool QuietErrors = {read=FQuietErrors, write=FQuietErrors, nodefault};
	__property TSocketErrorEvent OnError = {read=FOnError, write=FOnError};
	__property TSocketSendEvent OnSent = {read=FOnSent, write=FOnSent};
};


class DELPHICLASS TEurekaClientSMTP;
class PASCALIMPLEMENTATION TEurekaClientSMTP : public TEurekaClientSocket
{
	typedef TEurekaClientSocket inherited;
	
public:
	virtual void __fastcall Open(void);
	bool __fastcall GetText(System::Word *Codes, const int Codes_Size);
	bool __fastcall SendCommand(System::AnsiString Command, System::Word *Codes, const int Codes_Size);
public:
	/* TEurekaClientSocket.Create */ inline __fastcall TEurekaClientSMTP(const System::AnsiString Host, System::Word Port, bool TCP, unsigned Timeout) : TEurekaClientSocket(Host, Port, TCP, Timeout) { }
	/* TEurekaClientSocket.Destroy */ inline __fastcall virtual ~TEurekaClientSMTP(void) { }
	
};


class DELPHICLASS EEurekaSocketError;
class PASCALIMPLEMENTATION EEurekaSocketError : public Sysutils::Exception
{
	typedef Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall EEurekaSocketError(const System::UnicodeString Msg) : Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall EEurekaSocketError(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size) : Sysutils::Exception(Msg, Args, Args_Size) { }
	/* Exception.CreateRes */ inline __fastcall EEurekaSocketError(int Ident)/* overload */ : Sysutils::Exception(Ident) { }
	/* Exception.CreateResFmt */ inline __fastcall EEurekaSocketError(int Ident, System::TVarRec const *Args, const int Args_Size)/* overload */ : Sysutils::Exception(Ident, Args, Args_Size) { }
	/* Exception.CreateHelp */ inline __fastcall EEurekaSocketError(const System::UnicodeString Msg, int AHelpContext) : Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall EEurekaSocketError(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size, int AHelpContext) : Sysutils::Exception(Msg, Args, Args_Size, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EEurekaSocketError(int Ident, int AHelpContext)/* overload */ : Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EEurekaSocketError(System::PResStringRec ResStringRec, System::TVarRec const *Args, const int Args_Size, int AHelpContext)/* overload */ : Sysutils::Exception(ResStringRec, Args, Args_Size, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~EEurekaSocketError(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE System::AnsiString __fastcall GetMXServerFromEmail(const System::AnsiString Email, unsigned Timeout);

}	/* namespace Esockets */
using namespace Esockets;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// EsocketsHPP
