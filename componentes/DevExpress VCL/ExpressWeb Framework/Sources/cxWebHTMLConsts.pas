{*******************************************************************}
{                                                                   }
{       ExpressWeb Framework by Developer Express                   }
{       Designer Module                                             }
{                                                                   }
{       Copyright (c) 2000-2010 Developer Express Inc.              }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSWEB FRAMEWORK AND ALL         }
{   ACCOMPANYING VCL CLASSES AS PART OF AN EXECUTABLE WEB           }
{   APPLICATION ONLY.                                               }
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

unit cxWebHTMLConsts;

interface

const

  //
  // Dispatch IDS for IExplorer Dispatch Events.
  //
  DISPID_BEFORENAVIGATE     = 100;   // this is sent before navigation to give a chance to abort
  DISPID_NAVIGATECOMPLETE   = 101;   // in async, this is sent when we have enough to show
  DISPID_STATUSTEXTCHANGE   = 102;
  DISPID_QUIT               = 103;
  DISPID_DOWNLOADCOMPLETE   = 104;
  DISPID_COMMANDSTATECHANGE = 105;
  DISPID_DOWNLOADBEGIN      = 106;
  DISPID_NEWWINDOW          = 107;   // sent when a new window should be created
  DISPID_PROGRESSCHANGE     = 108;   // sent when download progress is updated
  DISPID_WINDOWMOVE         = 109;   // sent when main window has been moved
  DISPID_WINDOWRESIZE       = 110;   // sent when main window has been sized
  DISPID_WINDOWACTIVATE     = 111;  // sent when main window has been activated
  DISPID_PROPERTYCHANGE     = 112;   // sent when the PutProperty method is called
  DISPID_TITLECHANGE        = 113;   // sent when the document title changes
  DISPID_TITLEICONCHANGE    = 114;   // sent when the top level window icon may have changed.

  DISPID_FRAMEBEFORENAVIGATE    = 200;
  DISPID_FRAMENAVIGATECOMPLETE  = 201;
  DISPID_FRAMENEWWINDOW         = 204;

  DISPID_BEFORENAVIGATE2      = 250;   // hyperlink clicked on
  DISPID_NEWWINDOW2           = 251;
  DISPID_NAVIGATECOMPLETE2    = 252;   // UIActivate new document
  DISPID_ONQUIT               = 253;
  DISPID_ONVISIBLE            = 254;   // sent when the window goes visible/hidden
  DISPID_ONTOOLBAR            = 255;   // sent when the toolbar should be shown/hidden
  DISPID_ONMENUBAR            = 256;   // sent when the menubar should be shown/hidden
  DISPID_ONSTATUSBAR          = 257;   // sent when the statusbar should be shown/hidden
  DISPID_ONFULLSCREEN         = 258;  // sent when kiosk mode should be on/off
  DISPID_DOCUMENTCOMPLETE     = 259;   // new document goes ReadyState_Complete
  DISPID_ONTHEATERMODE        = 260;   // sent when theater mode should be on/off
  DISPID_ONADDRESSBAR         = 261;   // sent when the address bar should be shown/hidden
  DISPID_WINDOWSETRESIZABLE   = 262;   // sent to set the style of the host window frame
  DISPID_WINDOWCLOSING        = 263;   // sent before script window.close closes the window
  DISPID_WINDOWSETLEFT        = 264;   // sent when the put_left method is called on the WebOC
  DISPID_WINDOWSETTOP         = 265;   // sent when the put_top method is called on the WebOC
  DISPID_WINDOWSETWIDTH       = 266;   // sent when the put_width method is called on the WebOC
  DISPID_WINDOWSETHEIGHT      = 267;   // sent when the put_height method is called on the WebOC
  DISPID_CLIENTTOHOSTWINDOW   = 268;   // sent during window.open to request conversion of dimensions
  DISPID_SETSECURELOCKICON    = 269;   // sent to suggest the appropriate security icon to show
  DISPID_FILEDOWNLOAD         = 270;   // Fired to indicate the File Download dialog is opening
  DISPID_NAVIGATEERROR        = 271;   // Fired to indicate the a binding error has occured
  DISPID_PRIVACYIMPACTEDSTATECHANGE   = 272;  // Fired when the user's browsing experience is impacted

  DISPID_AMBIENT_DLCONTROL = -5512;
  DLCTL_DLIMAGES                  = $00000010;
  DLCTL_VIDEOS                    = $00000020;
  DLCTL_BGSOUNDS                  = $00000040;
  DLCTL_NO_SCRIPTS                = $00000080;
  DLCTL_NO_JAVA                   = $00000100;
  DLCTL_NO_RUNACTIVEXCTLS         = $00000200;
  DLCTL_NO_DLACTIVEXCTLS          = $00000400;
  DLCTL_DOWNLOADONLY              = $00000800;
  DLCTL_NO_FRAMEDOWNLOAD          = $00001000;
  DLCTL_RESYNCHRONIZE             = $00002000;
  DLCTL_PRAGMA_NO_CACHE           = $00004000;
  DLCTL_NO_BEHAVIORS              = $00008000;
  DLCTL_NO_METACHARSET            = $00010000;
  DLCTL_URL_ENCODING_DISABLE_UTF8 = $00020000;
  DLCTL_URL_ENCODING_ENABLE_UTF8  = $00040000;
  DLCTL_FORCEOFFLINE              = $10000000;
  DLCTL_NO_CLIENTPULL             = $20000000;
  DLCTL_SILENT                    = $40000000;
  DLCTL_OFFLINEIFNOTCONNECTED     = $80000000;


  SID_SHTMLEditServices: TGUID = '{3050F7F9-98B5-11CF-BB82-00AA00BDCE0B}';
  CGID_MSHTML: TGUID = '{DE4BA900-59CA-11CF-9592-444553540000}';
  // MSHTML Command IDs

  IDM_UNKNOWN                 = 0;
  IDM_ALIGNBOTTOM             = 1;
  IDM_ALIGNHORIZONTALCENTERS  = 2;
  IDM_ALIGNLEFT               = 3;
  IDM_ALIGNRIGHT              = 4;
  IDM_ALIGNTOGRID             = 5;
  IDM_ALIGNTOP                = 6;
  IDM_ALIGNVERTICALCENTERS    = 7;
  IDM_ARRANGEBOTTOM           = 8;
  IDM_ARRANGERIGHT            = 9;
  IDM_BRINGFORWARD            = 10;
  IDM_BRINGTOFRONT            = 11;
  IDM_CENTERHORIZONTALLY      = 12;
  IDM_CENTERVERTICALLY        = 13;
  IDM_CODE                    = 14;
  IDM_DELETE                  = 17;  
  IDM_FONTNAME                = 18;  
  IDM_FONTSIZE                = 19;  
  IDM_GROUP                   = 20;
  IDM_HORIZSPACECONCATENATE   = 21;
  IDM_HORIZSPACEDECREASE      = 22;
  IDM_HORIZSPACEINCREASE      = 23;
  IDM_HORIZSPACEMAKEEQUAL     = 24;
  IDM_INSERTOBJECT            = 25;  
  IDM_MULTILEVELREDO          = 30;
  IDM_SENDBACKWARD            = 32;
  IDM_SENDTOBACK              = 33;
  IDM_SHOWTABLE               = 34;
  IDM_SIZETOCONTROL           = 35;
  IDM_SIZETOCONTROLHEIGHT     = 36;
  IDM_SIZETOCONTROLWIDTH      = 37;
  IDM_SIZETOFIT               = 38;
  IDM_SIZETOGRID              = 39;
  IDM_SNAPTOGRID              = 40;
  IDM_TABORDER                = 41;
  IDM_TOOLBOX                 = 42;
  IDM_MULTILEVELUNDO          = 44;
  IDM_UNGROUP                 = 45;
  IDM_VERTSPACECONCATENATE    = 46;
  IDM_VERTSPACEDECREASE       = 47;
  IDM_VERTSPACEINCREASE       = 48;
  IDM_VERTSPACEMAKEEQUAL      = 49;
  IDM_JUSTIFYFULL             = 50;  
  IDM_BACKCOLOR               = 51;  
  IDM_BOLD                    = 52;  
  IDM_BORDERCOLOR             = 53;
  IDM_FLAT                    = 54;
  IDM_FORECOLOR               = 55;  
  IDM_ITALIC                  = 56;  
  IDM_JUSTIFYCENTER           = 57;  
  IDM_JUSTIFYGENERAL          = 58;  
  IDM_JUSTIFYLEFT             = 59;  
  IDM_JUSTIFYRIGHT            = 60;  
  IDM_RAISED                  = 61;
  IDM_SUNKEN                  = 62;
  IDM_UNDERLINE               = 63;  
  IDM_CHISELED                = 64;
  IDM_ETCHED                  = 65;
  IDM_SHADOWED                = 66;
  IDM_FIND                    = 67;  
  IDM_SHOWGRID                = 69;
  IDM_OBJECTVERBLIST0         = 72;
  IDM_OBJECTVERBLIST1         = 73;
  IDM_OBJECTVERBLIST2         = 74;
  IDM_OBJECTVERBLIST3         = 75;
  IDM_OBJECTVERBLIST4         = 76;
  IDM_OBJECTVERBLIST5         = 77;
  IDM_OBJECTVERBLIST6         = 78;
  IDM_OBJECTVERBLIST7         = 79;
  IDM_OBJECTVERBLIST8         = 80;
  IDM_OBJECTVERBLIST9         = 81;
  IDM_OBJECTVERBLISTLAST = IDM_OBJECTVERBLIST9;
  IDM_CONVERTOBJECT           = 82;
  IDM_CUSTOMCONTROL           = 83;
  IDM_CUSTOMIZEITEM           = 84;
  IDM_RENAME                  = 85;
  IDM_IMPORT                  = 86;
  IDM_NEWPAGE                 = 87;
  IDM_MOVE                    = 88;
  IDM_CANCEL                  = 89;
  IDM_FONT                    = 90;  
  IDM_STRIKETHROUGH           = 91;  
  IDM_DELETEWORD              = 92;  
  IDM_EXECPRINT               = 93;
  IDM_JUSTIFYNONE             = 94;  
  IDM_TRISTATEBOLD            = 95;  
  IDM_TRISTATEITALIC          = 96;  
  IDM_TRISTATEUNDERLINE       = 97;  

  INSERTBR = 26;

  IDM_FOLLOW_ANCHOR           = 2008;

  IDM_INSINPUTIMAGE           = 2114;  
  IDM_INSINPUTBUTTON          = 2115;  
  IDM_INSINPUTRESET           = 2116;  
  IDM_INSINPUTSUBMIT          = 2117;  
  IDM_INSINPUTUPLOAD          = 2118;  
  IDM_INSFIELDSET             = 2119;  

  IDM_PASTEINSERT             = 2120;
  IDM_REPLACE                 = 2121;
  IDM_EDITSOURCE              = 2122;
  IDM_BOOKMARK                = 2123;  
  IDM_HYPERLINK               = 2124;  
  IDM_UNLINK                  = 2125;
  IDM_BROWSEMODE              = 2126;
  IDM_EDITMODE                = 2127;
  IDM_UNBOOKMARK              = 2128;

  IDM_TOOLBARS                = 2130;
  IDM_STATUSBAR               = 2131;
  IDM_FORMATMARK              = 2132;
  IDM_TEXTONLY                = 2133;
  IDM_OPTIONS                 = 2135;  
  IDM_FOLLOWLINKC             = 2136;
  IDM_FOLLOWLINKN             = 2137;
  IDM_VIEWSOURCE              = 2139;  
  IDM_ZOOMPOPUP               = 2140;

  IDM_BASELINEFONT1           = 2141;  
  IDM_BASELINEFONT2           = 2142;  
  IDM_BASELINEFONT3           = 2143;  
  IDM_BASELINEFONT4           = 2144;  
  IDM_BASELINEFONT5           = 2145;  

  IDM_HORIZONTALLINE          = 2150;  
  IDM_LINEBREAKNORMAL         = 2151;  
  IDM_LINEBREAKLEFT           = 2152;  
  IDM_LINEBREAKRIGHT          = 2153;  
  IDM_LINEBREAKBOTH           = 2154;  
  IDM_NONBREAK                = 2155;  
  IDM_SPECIALCHAR             = 2156;
  IDM_HTMLSOURCE              = 2157;
  IDM_IFRAME                  = 2158;  
  IDM_HTMLCONTAIN             = 2159;
  IDM_TEXTBOX                 = 2161;  
  IDM_TEXTAREA                = 2162;  
  IDM_CHECKBOX                = 2163;  
  IDM_RADIOBUTTON             = 2164;
  IDM_DROPDOWNBOX             = 2165;  
  IDM_LISTBOX                 = 2166;  
  IDM_BUTTON                  = 2167;  
  IDM_IMAGE                   = 2168;  
  IDM_OBJECT                  = 2169;
  IDM_1D                      = 2170;  
  IDM_IMAGEMAP                = 2171;
  IDM_FILE                    = 2172;
  IDM_COMMENT                 = 2173;
  IDM_SCRIPT                  = 2174;
  IDM_JAVAAPPLET              = 2175;
  IDM_PLUGIN                  = 2176;
  IDM_PAGEBREAK               = 2177;
  IDM_HTMLAREA                = 2178;

  IDM_PARAGRAPH               = 2180;  
  IDM_FORM                    = 2181;
  IDM_MARQUEE                 = 2182;  
  IDM_LIST                    = 2183;
  IDM_ORDERLIST               = 2184;  
  IDM_UNORDERLIST             = 2185;  
  IDM_INDENT                  = 2186;  
  IDM_OUTDENT                 = 2187;  
  IDM_PREFORMATTED            = 2188;
  IDM_ADDRESS                 = 2189;
  IDM_BLINK                   = 2190;
  IDM_DIV                     = 2191;

  IDM_TABLEINSERT             = 2200;
  IDM_RCINSERT                = 2201;
  IDM_CELLINSERT              = 2202;
  IDM_CAPTIONINSERT           = 2203;
  IDM_CELLMERGE               = 2204;
  IDM_CELLSPLIT               = 2205;
  IDM_CELLSELECT              = 2206;
  IDM_ROWSELECT               = 2207;
  IDM_COLUMNSELECT            = 2208;
  IDM_TABLESELECT             = 2209;
  IDM_TABLEPROPERTIES         = 2210;
  IDM_CELLPROPERTIES          = 2211;
  IDM_ROWINSERT               = 2212;
  IDM_ROWINSERTBELOW          = 2214;
  IDM_COLUMNINSERT            = 2213;
  IDM_COLUMNINSERTRIGHT       = 2215;
  IDM_TABLEDELETE             = 2216;
  IDM_ROWDELETE               = 2217;
  IDM_COLUMNDELETE            = 2218;
  IDM_CELLDELETE              = 2219;

  IDM_HELP_CONTENT            = 2220;  
  IDM_HELP_ABOUT              = 2221;  
  IDM_HELP_README             = 2222;  

  IDM_REMOVEFORMAT            = 2230;  
  IDM_PAGEINFO                = 2231;
  IDM_TELETYPE                = 2232;
  IDM_GETBLOCKFMTS            = 2233;  
  IDM_BLOCKFMT                = 2234;  
  IDM_SHOWHIDE_CODE           = 2235;
  IDM_TABLE                   = 2236;

  IDM_COPYFORMAT              = 2237;
  IDM_PASTEFORMAT             = 2238;
  IDM_GOTO                    = 2239;

  IDM_CHANGEFONT              = 2240;
  IDM_CHANGEFONTSIZE          = 2241;
  IDM_CHANGECASE              = 2246;
  IDM_SHOWSPECIALCHAR         = 2249;

  IDM_SUBSCRIPT               = 2247;  
  IDM_SUPERSCRIPT             = 2248;  

  IDM_CENTERALIGNPARA         = 2250;
  IDM_LEFTALIGNPARA           = 2251;
  IDM_RIGHTALIGNPARA          = 2252;
  IDM_REMOVEPARAFORMAT        = 2253;
  IDM_APPLYNORMAL             = 2254;
  IDM_APPLYHEADING1           = 2255;
  IDM_APPLYHEADING2           = 2256;
  IDM_APPLYHEADING3           = 2257;

  IDM_DOCPROPERTIES           = 2260;
  IDM_ADDFAVORITES            = 2261;  
  IDM_COPYSHORTCUT            = 2262;
  IDM_SAVEBACKGROUND          = 2263;  
  IDM_SETWALLPAPER            = 2264;  
  IDM_COPYBACKGROUND          = 2265;  
  IDM_CREATESHORTCUT          = 2266;  
  IDM_PAGE                    = 2267;
  IDM_SAVETARGET              = 2268;
  IDM_SHOWPICTURE             = 2269;
  IDM_SAVEPICTURE             = 2270;
  IDM_DYNSRCPLAY              = 2271;  
  IDM_DYNSRCSTOP              = 2272;  
  IDM_PRINTTARGET             = 2273;
  IDM_IMGARTPLAY              = 2274;
  IDM_IMGARTSTOP              = 2275;
  IDM_IMGARTREWIND            = 2276;
  IDM_PRINTQUERYJOBSPENDING   = 2277;  
  IDM_SETDESKTOPITEM          = 2278;

  IDM_CONTEXTMENU             = 2280;  
  IDM_GOBACKWARD              = 2282;  
  IDM_GOFORWARD               = 2283;  
  IDM_PRESTOP                 = 2284;

  IDM_MP_MYPICS               = 2287;
  IDM_MP_EMAILPICTURE         = 2288;
  IDM_MP_PRINTPICTURE         = 2289;

  IDM_CREATELINK              = 2290;
  IDM_COPYCONTENT             = 2291;

  IDM_LANGUAGE                = 2292;  

  IDM_GETPRINTTEMPLATE        = 2295;
  IDM_SETPRINTTEMPLATE        = 2296;
  IDM_TEMPLATE_PAGESETUP      = 2298;

  IDM_REFRESH                 = 2300;  
  IDM_STOPDOWNLOAD            = 2301;

  IDM_ENABLE_INTERACTION      = 2302;

  IDM_LAUNCHDEBUGGER          = 2310;  
  IDM_BREAKATNEXT             = 2311;  

  IDM_INSINPUTHIDDEN          = 2312;  
  IDM_INSINPUTPASSWORD        = 2313;  

  IDM_OVERWRITE               = 2314;  

  IDM_PARSECOMPLETE           = 2315;

  IDM_HTMLEDITMODE            = 2316;  

  IDM_REGISTRYREFRESH         = 2317;
  IDM_COMPOSESETTINGS         = 2318;  

  IDM_SHOWALLTAGS             = 2327;  
  IDM_SHOWALIGNEDSITETAGS     = 2321;  
  IDM_SHOWSCRIPTTAGS          = 2322;  
  IDM_SHOWSTYLETAGS           = 2323;  
  IDM_SHOWCOMMENTTAGS         = 2324;  
  IDM_SHOWAREATAGS            = 2325;  
  IDM_SHOWUNKNOWNTAGS         = 2326;  
  IDM_SHOWMISCTAGS            = 2320;  
  IDM_SHOWZEROBORDERATDESIGNTIME         = 2328; 

  IDM_AUTODETECT              = 2329;  

  IDM_SCRIPTDEBUGGER          = 2330;

  IDM_GETBYTESDOWNLOADED      = 2331;

  IDM_NOACTIVATENORMALOLECONTROLS        = 2332;  
  IDM_NOACTIVATEDESIGNTIMECONTROLS       = 2333;  
  IDM_NOACTIVATEJAVAAPPLETS              = 2334;
  IDM_NOFIXUPURLSONPASTE                 = 2335;

  IDM_EMPTYGLYPHTABLE         = 2336;
  IDM_ADDTOGLYPHTABLE         = 2337;
  IDM_REMOVEFROMGLYPHTABLE    = 2338;
  IDM_REPLACEGLYPHCONTENTS    = 2339;

  IDM_SHOWWBRTAGS             = 2340;

  IDM_PERSISTSTREAMSYNC       = 2341;
  IDM_SETDIRTY                = 2342;

  IDM_RUNURLSCRIPT            = 2343;

  IDM_ZOOMRATIO               = 2344;
  IDM_GETZOOMNUMERATOR        = 2345;
  IDM_GETZOOMDENOMINATOR      = 2346;

  IDM_DIRLTR                  = 2350;  
  IDM_DIRRTL                  = 2351;  
  IDM_BLOCKDIRLTR             = 2352;  
  IDM_BLOCKDIRRTL             = 2353;  
  IDM_INLINEDIRLTR            = 2354;
  IDM_INLINEDIRRTL            = 2355;

  IDM_ISTRUSTEDDLG            = 2356;  

  IDM_INSERTSPAN              = 2357;  
  IDM_LOCALIZEEDITOR          = 2358;  

  IDM_SAVEPRETRANSFORMSOURCE  = 2370;
  IDM_VIEWPRETRANSFORMSOURCE  = 2371;

  IDM_SCROLL_HERE             = 2380;
  IDM_SCROLL_TOP              = 2381;
  IDM_SCROLL_BOTTOM           = 2382;
  IDM_SCROLL_PAGEUP           = 2383;
  IDM_SCROLL_PAGEDOWN         = 2384;
  IDM_SCROLL_UP               = 2385;
  IDM_SCROLL_DOWN             = 2386;
  IDM_SCROLL_LEFTEDGE         = 2387;
  IDM_SCROLL_RIGHTEDGE        = 2388;
  IDM_SCROLL_PAGELEFT         = 2389;
  IDM_SCROLL_PAGERIGHT        = 2390;
  IDM_SCROLL_LEFT             = 2391;
  IDM_SCROLL_RIGHT            = 2392;

  IDM_MULTIPLESELECTION       = 2393;  
  IDM_2D_POSITION             = 2394;  
  IDM_2D_ELEMENT              = 2395;  
  IDM_1D_ELEMENT              = 2396;  
  IDM_ABSOLUTE_POSITION       = 2397;  
  IDM_LIVERESIZE              = 2398;  
  IDM_ATOMICSELECTION	     = 2399;   

  IDM_AUTOURLDETECT_MODE      = 2400;   

  IDM_IE50_PASTE              = 2401;

  IDM_IE50_PASTE_MODE         = 2402;   

  IDM_GETIPRINT               = 2403;

  IDM_DISABLE_EDITFOCUS_UI    = 2404;  

  IDM_RESPECTVISIBILITY_INDESIGN  = 2405;  

  IDM_CSSEDITING_LEVEL            = 2406;  

  IDM_UI_OUTDENT                  = 2407;  

  IDM_UPDATEPAGESTATUS            = 2408;

  IDM_IME_ENABLE_RECONVERSION	= 2409;   

  IDM_KEEPSELECTION		= 2410;   

  IDM_UNLOADDOCUMENT              = 2411;

  IDM_OVERRIDE_CURSOR             = 2420;

  IDM_PEERHITTESTSAMEINEDIT       = 2423;

  IDM_TRUSTAPPCACHE               = 2425;

  IDM_BACKGROUNDIMAGECACHE        = 2430;

  IDM_DEFAULTBLOCK                = 6046;

  IDM_MIMECSET__FIRST__           = 3609;
  IDM_MIMECSET__LAST__            = 3699;

  IDM_MENUEXT_FIRST__       = 3700;
  IDM_MENUEXT_LAST__        = 3732;
  IDM_MENUEXT_COUNT         = 3733;  

  IDM_OPEN                    = 2000; 
  IDM_NEW                     = 2001;
  IDM_SAVE                    = 70;    
  IDM_SAVEAS                  = 71;
  IDM_SAVECOPYAS              = 2002;
  IDM_PRINTPREVIEW            = 2003; 
  IDM_SHOWPRINT               = 2010;
  IDM_SHOWPAGESETUP           = 2011;
  IDM_PRINT                   = 27; 
  IDM_PAGESETUP               = 2004;  
  IDM_SPELL                   = 2005;
  IDM_PASTESPECIAL            = 2006;
  IDM_CLEARSELECTION          = 2007;  
  IDM_PROPERTIES              = 28;  
  IDM_REDO                    = 29;  
  IDM_UNDO                    = 43;  
  IDM_SELECTALL               = 31;  
  IDM_ZOOMPERCENT             = 50;
  IDM_GETZOOM                 = 68;
  IDM_STOP                    = 2138;  
  IDM_COPY                    = 15; 
  IDM_CUT                     = 16; 
  IDM_PASTE                   = 26; 

  CMD_ZOOM_PAGEWIDTH = -1;
  CMD_ZOOM_ONEPAGE = -2;
  CMD_ZOOM_TWOPAGES = -3;
  CMD_ZOOM_SELECTION = -4;
  CMD_ZOOM_FIT = -5;

  IDM_CONTEXT                 = 1;
  IDM_HWND                    = 2;

  IDM_NEW_TOPLEVELWINDOW      = 7050;

  IDM_PRESERVEUNDOALWAYS      = 6049;
  IDM_PERSISTDEFAULTVALUES    = 7100;
  IDM_PROTECTMETATAGS         = 7101;

  IDM_GETFRAMEZONE            = 6037;

  IDM_FIRE_PRINTTEMPLATEUP        = 15000;
  IDM_FIRE_PRINTTEMPLATEDOWN      = 15001;
  IDM_SETPRINTHANDLES             = 15002;
  IDM_CLEARAUTHENTICATIONCACHE	= 15003;

  IDM_FRAMEINSLEFT   = 5000;
  IDM_FRAMEINSRIGHT  = 5001;
  IDM_FRAMEINSTOP    = 5002;
  IDM_FRAMEINSBOTTOM = 5003;
  IDM_FRAMEDELETE    = 5004;
  IDM_FRAMEINSERT    = 5005;

implementation

end.
