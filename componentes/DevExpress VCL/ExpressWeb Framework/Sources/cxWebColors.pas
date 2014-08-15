{*******************************************************************}
{                                                                   }
{       ExpressWeb Framework by Developer Express                   }
{       Web Colors                                                  }
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
unit cxWebColors;

{$I cxVer.inc}

interface

uses
  {$IFDEF VCL}
   Windows,
  {$ENDIF}
  cxWebTypes;

const
  { standard system colors }
  {$IFDEF LINUX}
  cxcActive = 96;
  cxcDisabled = 64;

  clWebHighlight = TcxWebColor(-13);
  clWebHighlightText = TcxWebColor(-14);
  clWebGrayText = TcxWebColor(-3);
  clWebAppWorkspace = TcxWebColor(-6);
  clWebButtonText = TcxWebColor(-9);
  clWebButtonFace = TcxWebColor(-2);
  clWebBackground = TcxWebColor(-11);
  clWebButtonShadow = TcxWebColor(-5);
  clWebInfoBackground = TcxWebColor($E1FFFF);
  clWebInfoText = TcxWebColor(-7);
  clWebActiveBorder = TcxWebColor(clWebHighlight - cxcActive);
  clWebActiveCaption = TcxWebColor(clWebHighlightText - cxcActive);
  clWebButtonHighlight = TcxWebColor(clWebGrayText - cxcActive);
  clWebCaptionText = clWebHighlightText;
  clWebInactiveBorder = TcxWebColor(clWebHighlight - cxcDisabled);
  clWebInactiveCaption = TcxWebColor(clWebHighlightText - cxcDisabled);
  clWebInactiveCaptionText = TcxWebColor(clWebHighlightText - cxcDisabled);
  clWebMenu = TcxWebColor(clWebAppWorkspace);
  clWebMenuText = TcxWebColor(clWebButtonText);
  clWebScrollbar = TcxWebColor(clWebButtonFace);

  clWebThreeDDarkShadow = TcxWebColor(clWebButtonShadow);
  clWebThreeDFace = TcxWebColor(clWebButtonFace);
  clWebThreeDHighlight = TcxWebColor(clWebButtonHighlight);
  clWebThreeDLightShadow = TcxWebColor(-4);
  clWebThreeDShadow = TcxWebColor(clWebAppWorkspace);

  clWebWindow = TcxWebColor(-10);
  clWebWindowFrame = TcxWebColor(clWebHighlight);
  clWebWindowText = TcxWebColor(clWebInfoText);
  {$ELSE}
  clWebActiveBorder = TcxWebColor(COLOR_ACTIVEBORDER or $80000000);
  clWebActiveCaption = TcxWebColor(COLOR_ACTIVECAPTION or $80000000);
  clWebAppWorkspace = TcxWebColor(COLOR_APPWORKSPACE or $80000000);
  clWebBackground = TcxWebColor(COLOR_BACKGROUND or $80000000);
  clWebButtonFace = TcxWebColor(COLOR_BTNFACE or $80000000);
  clWebButtonHighlight = TcxWebColor(COLOR_BTNHIGHLIGHT or $80000000);
  clWebButtonShadow = TcxWebColor(COLOR_BTNSHADOW or $80000000);
  clWebButtonText = TcxWebColor(COLOR_BTNTEXT or $80000000);
  clWebCaptionText = TcxWebColor(COLOR_CAPTIONTEXT or $80000000);
  clWebGrayText = TcxWebColor(COLOR_GRAYTEXT or $80000000);
  clWebHighlight = TcxWebColor(COLOR_HIGHLIGHT or $80000000);
  clWebHighlightText = TcxWebColor(COLOR_HIGHLIGHTTEXT or $80000000);
  clWebInactiveBorder = TcxWebColor(COLOR_INACTIVEBORDER or $80000000);
  clWebInactiveCaption = TcxWebColor(COLOR_INACTIVECAPTION or $80000000);
  clWebInactiveCaptionText = TcxWebColor(COLOR_INACTIVECAPTIONTEXT or $80000000);
  clWebInfoBackground = TcxWebColor(COLOR_INFOBK or $80000000);
  clWebInfoText = TcxWebColor(COLOR_INFOTEXT or $80000000);
  clWebMenu = TcxWebColor(COLOR_MENU or $80000000);
  clWebMenuText = TcxWebColor(COLOR_MENUTEXT or $80000000);
  clWebScrollbar = TcxWebColor(COLOR_SCROLLBAR or $80000000);
  clWebThreeDDarkShadow = TcxWebColor(COLOR_3DDKSHADOW or $80000000);
  clWebThreeDFace = TcxWebColor(COLOR_3DFACE or $80000000);
  clWebThreeDHighlight = TcxWebColor(COLOR_3DHIGHLIGHT or $80000000);
  clWebThreeDLightShadow = TcxWebColor(COLOR_3DLIGHT or $80000000);
  clWebThreeDShadow = TcxWebColor(COLOR_3DSHADOW or $80000000);
  clWebWindow = TcxWebColor(COLOR_WINDOW or $80000000);
  clWebWindowFrame = TcxWebColor(COLOR_WINDOWFRAME or $80000000);
  clWebWindowText = TcxWebColor(COLOR_WINDOWTEXT or $80000000);
  {$ENDIF}

  { standard pure web colors }
  clWebAliceBlue = TcxWebColor($FFF8F0);             // 255, 248, 240
  clWebAntiqueWhite = TcxWebColor($D7EBFA);          // 215, 235, 250
  clWebAqua = TcxWebColor($FFFF00);                  // 255, 255,   0
  clWebAquamarine = TcxWebColor($D4FF7F);            // 212, 255, 127
  clWebAzure = TcxWebColor($FFFFF0);                 // 255, 255, 240

  clWebBeige = TcxWebColor($DCF5F5);                 // 220, 245, 245
  clWebBisque = TcxWebColor($C4E4FF);                // 196, 228, 255
  clWebBlack = TcxWebColor($000000);                 //   0,   0,   0
  clWebBlanchedAlmond = TcxWebColor($CDEBFF);        // 205, 235, 255
  clWebBlue = TcxWebColor($FF0000);                  // 255,   0,   0

  clWebBlueViolet = TcxWebColor($E22B8A);            // 226,  43, 138
  clWebBrown = TcxWebColor($2A2AA5);                 //  42,  42, 165
  clWebBurlyWood = TcxWebColor($87B8DE);             // 135, 184, 222
  clWebCadetBlue = TcxWebColor($A09E5F);             // 160, 158,  95
  clWebChartreuse = TcxWebColor($00FF7F);            //   0, 255, 127 
  
  clWebChocolate = TcxWebColor($1E69D2);             //  30, 105, 210
  clWebCoral = TcxWebColor($507FFF);                 //  80, 127, 255 
  clWebCornflowerBlue = TcxWebColor($ED9564);        // 237, 149, 100 
  clWebCornsilk = TcxWebColor($DCF8FF);              // 220, 248, 255 
  clWebCrimson = TcxWebColor($3C14DC);               //  60,  20, 220 

  clWebCyan = TcxWebColor($FFFF00);                  // 255, 255,   0 
  clWebDarkBlue = TcxWebColor($8B0000);              // 139,   0,   0 
  clWebDarkCyan = TcxWebColor($8B8B00);              // 139, 139,   0 
  clWebDarkGoldenrod = TcxWebColor($0B86B8);         //  11, 134, 184 
  clWebDarkGray = TcxWebColor($A9A9A9);              // 169, 169, 169
  
  clWebDarkGreen = TcxWebColor($006400);             //   0, 100,   0
  clWebDarkKhaki = TcxWebColor($6BB7BD);             // 107, 189, 183 
  clWebDarkMagenta = TcxWebColor($8B008B);           // 139,   0, 139
  clWebDarkOliveGreen = TcxWebColor($2F6B55);        //  47, 107,  85 
  clWebDarkOrange = TcxWebColor($008CFF);            //   0, 140, 255 
  
  clWebDarkOrchid = TcxWebColor($CC3299);            // 204,  50, 153 
  clWebDarkRed = TcxWebColor($00008B);               //   0,   0, 139 
  clWebDarkSalmon = TcxWebColor($7A96E9);            // 122, 150, 233 
  clWebDarkSeaGreen = TcxWebColor($8FBC8F);          // 143, 188, 143 
  clWebDarkSlateBlue = TcxWebColor($8B3D48);         // 139,  61,  72 

  clWebDarkSlateGray = TcxWebColor($4F4F2F);         //  79,  79,  47 
  clWebDarkTurquoise = TcxWebColor($D1CE00);         // 209, 206,   0 
  clWebDarkViolet = TcxWebColor($D30094);            // 211,   0, 148 
  clWebDeepPink = TcxWebColor($9314FF);              // 147,  20, 255 
  clWebDeepSkyBlue = TcxWebColor($FFBF00);           // 255, 191,   0

  clWebDimGray = TcxWebColor($696969);               // 105, 105, 105 
  clWebDodgerBlue = TcxWebColor($FF901E);            // 255, 144,  30 
  clWebFireBrick = TcxWebColor($2222B2);             //  34,  34, 178 
  clWebFloralWhite = TcxWebColor($F0FAFF);           // 240, 250, 255 
  clWebForestGreen = TcxWebColor($228B22);           //  34, 139,  34 
  
  clWebFuchsia = TcxWebColor($FF00FF);               // 255,   0, 255
  clWebGainsboro = TcxWebColor($DCDCDC);             // 220, 220, 220
  clWebGhostWhite = TcxWebColor($FFF8F8);            // 255, 248, 248 
  clWebGold = TcxWebColor($00D7FF);                  //   0, 215, 255 
  clWebGoldenrod = TcxWebColor($20A5DA);             //  32, 165, 218 
  
  clWebGray = TcxWebColor($808080);                  // 128, 128, 128 
  clWebGreen = TcxWebColor($008000);                 //   0, 128,   0 
  clWebGreenYellow = TcxWebColor($2FFFAD);           //  47, 255, 173 
  clWebHoneydew = TcxWebColor($F0FFF0);              // 240, 255, 240 
  clWebHotPink = TcxWebColor($B469FF);               // 180, 105, 255
  
  clWebIndianRed = TcxWebColor($5C5CCD);             //  92,  92, 205 
  clWebIndigo = TcxWebColor($82004B);                // 130,   0,  75 
  clWebIvory = TcxWebColor($F0FFFF);                 // 240, 255, 255 
  clWebKhaki = TcxWebColor($8CE6F0);                 // 140, 230, 240 
  clWebLavender = TcxWebColor($FAE6E6);              // 250, 230, 230 
  
  clWebLavenderBlush = TcxWebColor($F5F0FF);         // 245, 240, 255 
  clWebLawnGreen = TcxWebColor($00FC7C);             //   0, 252, 124 
  clWebLemonChiffon = TcxWebColor($CDFAFF);          // 205, 250, 255 
  clWebLightBlue = TcxWebColor($E6D8AD);             // 230, 216, 173 
  clWebLightCoral = TcxWebColor($8080F0);            // 128, 128, 240 
  
  clWebLightCyan = TcxWebColor($FFFFE0);             // 255, 255, 224
  clWebLightGoldenrodYellow = TcxWebColor($D2FAFA);  // 210, 250, 250 
  clWebLightGreen = TcxWebColor($90EE90);            // 144, 238, 144 
  clWebLightGrey = TcxWebColor($D3D3D3);             // 211, 211, 211
  clWebLightPink = TcxWebColor($C1B6FF);             // 193,  82, 255 
  
  clWebLightSalmon = TcxWebColor($7AA0FF);           // 122, 160, 255 
  clWebLightSeaGreen = TcxWebColor($AAB220);         // 170, 178,  32
  clWebLightSkyBlue = TcxWebColor($FACE87);          // 250, 206, 135 
  clWebLightSlateGray = TcxWebColor($998877);        // 153, 136, 119
  clWebLightSteelBlue = TcxWebColor($DEC4B0);        // 222, 196, 176 
  
  clWebLightYellow = TcxWebColor($E0FFFF);           // 224, 255, 255 
  clWebLime = TcxWebColor($00FF00);                  //   0, 255,   0 
  clWebLimeGreen = TcxWebColor($32CD32);             //  50, 205,  50 
  clWebLinen = TcxWebColor($E6F0FA);                 // 230, 240, 250 
  clWebMagenta = TcxWebColor($FF00FF);               // 255,   0, 255 
  
  clWebMaroon = TcxWebColor($000080);                //   0,   0  128 
  clWebMediumAquamarine = TcxWebColor($AACD66);      // 170, 205, 102 
  clWebMediumBlue = TcxWebColor($CD0000);            // 205,   0,   0
  clWebMediumOrchid = TcxWebColor($D355BA);          // 211,  85, 186 
  clWebMediumPurple = TcxWebColor($DB7093);          // 219, 112, 147 

  clWebMediumSeaGreen = TcxWebColor($71B33C);        // 113, 179,  60 
  clWebMediumSlateBlue = TcxWebColor($EE687B);       // 238, 104, 123 
  clWebMediumSpringGreen = TcxWebColor($9AFA00);     // 154, 250,   0 
  clWebMediumTurquoise = TcxWebColor($CCD148);       // 204, 209,  72 
  clWebMediumVioletRed = TcxWebColor($8515C7);       // 133,  21, 199 
  
  clWebMidnightBlue = TcxWebColor($701919);          // 112,  25,  25 
  clWebMintCream = TcxWebColor($FAFFF5);             // 250, 255, 245 
  clWebMistyRose = TcxWebColor($E1E4FF);             // 225, 228, 255
  clWebMoccasin = TcxWebColor($B5E4FF);              // 181, 228, 255 
  clWebNavajoWhite = TcxWebColor($ADDEFF);           // 173, 222, 255
  
  clWebNavy = TcxWebColor($800000);                  // 128,   0,   0 
  clWebOldLace = TcxWebColor($E6F5FD);               // 230, 245, 253
  clWebOlive = TcxWebColor($008080);                 //   0, 128, 128
  clWebOliveDrab = TcxWebColor($238E6B);             //  35, 142, 107 
  clWebOrange = TcxWebColor($00A5FF);                //   0, 165, 255 
  
  clWebOrangeRed = TcxWebColor($0045FF);             //   0,  69, 255 
  clWebOrchid = TcxWebColor($D670DA);                // 214, 112, 218 
  clWebPaleGoldenrod = TcxWebColor($AAE8EE);         // 170, 232, 238 
  clWebPaleGreen = TcxWebColor($98FB98);             // 152, 251, 152 
  clWebPaleTurquoise = TcxWebColor($EEEEAF);         // 238, 238, 175
  
  clWebPaleVioletRed = TcxWebColor($9370DB);         // 147, 112, 219
  clWebPapayaWhip = TcxWebColor($D5EFFF);            // 213, 239, 255
  clWebPeachPuff = TcxWebColor($B9DAFF);             // 185, 218, 255
  clWebPeru = TcxWebColor($3F85CD);                  //  63  133, 205
  clWebPink = TcxWebColor($CBC0FF);                  // 203, 192, 255
  
  clWebPlum = TcxWebColor($DDA0DD);                  // 221, 160, 221
  clWebPowderBlue = TcxWebColor($E6E0B0);            // 230, 224, 176
  clWebPurple = TcxWebColor($800080);                // 128,   0, 128 
  clWebRed = TcxWebColor($0000FF);                   //   0,   0, 255 
  clWebRosyBrown = TcxWebColor($8F8FBC);             // 143, 143, 188
  
  clWebRoyalBlue = TcxWebColor($E16941);             // 225,  65, 105
  clWebSaddleBrown = TcxWebColor($13458B);           //  19,  69, 139
  clWebSalmon = TcxWebColor($7280FA);                // 114, 128, 250
  clWebSandyBrown = TcxWebColor($60A4F4);            //  96, 164, 244
  clWebSeaGreen = TcxWebColor($578B2E);              //  87, 139,  46
  
  clWebSeashell = TcxWebColor($EEF5FF);              // 238, 245, 255
  clWebSienna = TcxWebColor($2D52A0);                //  45,  82, 160
  clWebSilver = TcxWebColor($C0C0C0);                // 192, 192, 192
  clWebSkyBlue = TcxWebColor($EBCE87);               // 235, 206, 135
  clWebSlateBlue = TcxWebColor($CD5A6A);             // 205,  90, 106

  clWebSlateGray = TcxWebColor($908070);             // 144, 128, 112
  clWebSnow = TcxWebColor($FAFAFF);                  // 250, 250, 255
  clWebSpringGreen = TcxWebColor($7FFF00);           // 127, 255,   0
  clWebSteelBlue = TcxWebColor($B48246);             // 180, 130,  70
  clWebTan = TcxWebColor($8CB4D2);                   // 140, 180, 210

  clWebTeal = TcxWebColor($808000);                  // 128, 128,   0
  clWebThistle = TcxWebColor($D8BFD8);               // 216, 191, 216
  clWebTomato = TcxWebColor($4763FF);                //  71, 255,  99
  clWebTurquoise = TcxWebColor($D0E040);             // 208, 224,  64
  clWebViolet = TcxWebColor($EE82EE);                // 238, 130, 238

  clWebWheat = TcxWebColor($B3DEF5);                 // 179, 222, 245
  clWebWhite = TcxWebColor($FFFFFF);                 // 255, 255, 255
  clWebWhiteSmoke = TcxWebColor($F5F5F5);            // 245, 245, 245
  clWebYellow = TcxWebColor($00FFFF);                //   0, 255, 255
  clWebYellowGreen = TcxWebColor($32CD9A);           // 50,  205, 154

implementation

end.
