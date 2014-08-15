Gnostice eDocEngine 2.5.2 VCL
Copyright © 2002-2009 Gnostice Information Technologies Private Limited

Support	:	support@gnostice.com
Sales	:	sales@gnostice.com
Web	:	http://www.gnostice.com

Introduction
------------
Gnostice eDocEngine is a generic electronic document creation component suite for Borland® Delphi™ and Borland® C++Builder™. eDocEngine enables developers to deliver information straight from the applications they develop, to over 20 popular electronic document formats. Rich content can be easily formatted to the precise look and feel required and delivered directly to users’ web browsers, sent as email attachments or saved to disk. eDocEngine currently supports the creation of documents in PDF, RTF, HTML, XHTML, EXCEL, TEXT, CSV, Quattro Pro, LOTUS 1-2-3, DIF, SYLK, TIFF, PNG, SVG (XML based vector graphics), JPEG, GIF, BMP, EMF and WMF formats. Metafile, BMP, DIFF, SYLK and Text can be directly output to the Windows® Clipboard.

This ReadMe file contains late-breaking information that may not be contained anywhere else. The ReadMe file also contains information on where to start and get access to additional resources to get the best out of Gnostice eDocEngine. We strongly recommend that you read this ReadMe file before you get started.

Contents of ReadMe
==================
1. Installation and Getting Started
2. Known Issues
3. Important resources
4. Ordering
5. Uninstalling

1. Installation and Getting Started
-----------------------------------
The Gnostice eDocEngine Setup program is designed to install eDocEngine and register components automatically into your programming environment - Delphi or C++Builder. To recompile eDocEngine, install the Report Export Interfaces and additional components provided please see below.

To get a quick overview of how to create your own documents using eDocEngine, take a look at the Frequently Asked Questions sections in the eDocEngine Help file. The Help file can be found on the Start menu at:
Start > Programs > Gnostice > eDocEngine VCL > eDocEngine Help

To see sample code in action, launch Delphi or C++Builder and open the samples project from:
For Delphi <eDocEngine InstallDir>\Demos\Delphi\1. DocumentCreationSamples\DocCreate
For C++Builder <eDocEngine InstallDir>\Demos\CBuilder\1. DocumentCreationSamples\DocCreate

For help on recompiling the registered version, please refer to the help file at:
Start > Programs > Gnostice > eDocEngine VCL > eDocEngine Help
Help Topic: Installation | Re-Compiling/Re-Installing - Registered Edition 

To facilitate the creation of PDF, HTML, RTF Excel and other documents from reporting tools such as QuickReport, ReportBuilder, FastReport, Rave, Express PrintingSystem and other VCL components, eDocEngine provides Export Interface components. Export Interface components need to be installed manually after eDocEngine installs.
For help on installing the Export Interface components, please refer to the help file at:
Start > Programs > Gnostice > eDocEngine VCL > eDocEngine Help
Help Topic: Installation | Installing and Re-Compiling eDocEngine Additionals

2. Known Issues
---------------
The following is a list of features or functionality that was changed, not supported or has limitations in the final release of Gnostice eDocEngine 2.5.2. These limitations could be due to the feature not being supported in the document format itself.

PDF Engine
* Hyperlinking of rotated text is not supported
* Some Annotation types require Adobe Acrobat Professional to be installed to work
* Unicode in Form Fields not supported

RTF Engine
* Image rotation is not supported
* Rotated text items are stored as images
* Arcs, Pies, and Chords are stored as images

HTML Engine
* Brush styles other than bsSolid and bsClear are not supported
* Pen styles other then psSolid, psClear and psDash are not supported
* Image rotation is not supported
* Line spacing for paragraphs are not visible in viewers but can be noticed in FrontPage

Excel Engine
* Image rotation is not supported
* Frames for Images are not supported
* Rotation of frames is not supported
* Text rotation is not supported
* Unicode characters not supported

Quattro Pro Engine
* Images and Shapes are not supported
* Text rotation is not supported

DIF, SYLK and Lotus 1-2-3 Engines
* Font attribute and text rotation are not supported

SVG Engine
* Multi-byte character sets and non-ANSI characters are not supported by viewers

All Graphic Engines
* Pen Style is always solid for pen widths greater than 1

All Engines
* Hebrew/Arabic Right-to-Left characters not supported
* Unicode Support for exporting through Export Interface components may not be always possible
* ACE v1.70 is not supported by eDocEngine. Please use ACE v1.71 which fixes an incompatibility problem in v1.70
* Rendering documents with 120 dpi systems (large fonts settings) has known issues.

Metafile rendering
* Clipping of regions not supported

3. Important Resources
----------------------
The following is a list of resources to helps you get information on eDocEngine, fast:

* The eDocEngine web pages at www.gnostice.com always contain the latest information please keep a watch here:
http://www.gnostice.com/edoc_engine.asp

* The FAQs on the eDocEngine web pages and the included help file give you specific answers fast. Access the help file on the Start menu at:
Start > Programs > Gnostice > eDocEngine VCL > eDocEngine Help

* The included code samples and demos are a practical way of getting to know how to use eDocEngine. Open the sample projects within Delphi or C++Builder from here:
For Delphi <eDocEngine InstallDir>\Demos\Delphi\
For C++Builder <eDocEngine InstallDir>\Demos\CBuilder\

* To know about the current status of eDocEngine and what specific features were added or addressed in a specific version or update, you can access the eDocEngine History page at www.gnostice.com.
The page is located at:
http://www.gnostice.com/edochistory.asp

* If you have specific questions and can’t find answers to them, do not wait any longer. Go to the support page at www.gnostice.com and follow the instructions given to get quick answers to your queries. The support page is located at:
http://www.gnostice.com/support.asp

4. Ordering
-----------
The fastest way to order Gnostice eDocEngine and start enjoying the benefits of the registered version is to order it from our Secure Online Store (hosted at ShareIt). There may also be special offers and special pricing available. To learn of the special offers and to order online please go to:
http://www.gnostice.com/buynow.asp

You can also order Gnostice eDocEngine over phone, fax, email or postal mail. Please see the included Order Form for details. The Order Form can be accessed from the Start menu at:
Start > Programs > Gnostice > eDocEngine VCL > eDocEngine Order Form

Gnostice eDocEngine is delivered electronically. As soon as your payment is authorized you will receive an email with details on how to get access to the registered version. IMPORTANT: When you submit your order please make sure the email you have provided is valid and presently working.

Gnostice eDocEngine is also available for OEM Licensing. Please send your enquiries about OEM licensing to, sales@gnostice.com.

5. Uninstalling
---------------
To remove Library path and Browsing path information:

1. Open Delphi or C++Builder
2. Choose Component | Install Packages 
3. Select Gnostice eDocEngine packages installed and click Remove. Repeat this step for all Gnostice eDocEngine packages.
4. Choose Tools | Environment Options...
5. Select the Library tab
6. Remove Gnostice eDocEngine path information from Library Path
7. Remove Gnostice eDocEngine path information from Browsing Path

To remove the installed files:

1. Go to Start |Settings | Control Panel
2. Open 'Add/Remove Programs'
3. Remove 'Gnostice eDocEngine' from the list
4. Un-install will complete

The Un-install program may not remove newly created files or folders. Check and manually delete the folder where you installed Gnostice eDocEngine if required.

=============================================================================================
Copyright © 2002-2009 Gnostice Information Technologies Private Limited. All rights reserved.

All Gnostice brand and product names are trademarks or registered trademarks of Gnostice Information Technologies Private Limited. All other names and trademarks are the property of their respective owners.
=============================================================================================