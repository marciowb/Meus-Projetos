
{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       Express non data aware standalone editors                   }
{                                                                   }
{       Copyright (c) 1998-2010 Developer Express Inc.              }
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

unit dxEdLib;

interface

{$I dxEdLVer.inc}

uses SysUtils, Messages, Windows, Classes, Graphics, Menus, Controls, Forms,
  StdCtrls, Mask, dxCntner{$IFDEF DELPHI4}, ActnList, StdActns{$ENDIF},
  dxEditor, dxExEdtr;

type
  { TCustomdxEdit }
  TCustomdxEdit = class(TdxInplaceTextEdit)
  public
    class function IsInplace: Boolean; override;
  end;

  { TdxEdit }
  TdxEdit = class(TCustomdxEdit)
  published
    property Color;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property ImeMode;
    property ImeName;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Style;
    property TabOrder;
    property TabStop default True;
    property Text;
    property Visible;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
  {$IFDEF DELPHI4}
    property Anchors;
//    property BiDiMode;
    property Constraints;
    property DragKind;
//    property ParentBiDiMode;
    property OnEndDock;
    property OnStartDock;
  {$ENDIF}
  {$IFDEF DELPHI5}
    property OnContextPopup;
  {$ENDIF}
    // original (standard)
    property Alignment;
    property AutoSelect;
    property AutoSize;
    property CharCase;
    property HideSelection;
    property MaxLength;
    property OEMConvert;
    property PasswordChar;
    property ReadOnly;
    property StyleController;
    property OnChange;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnSelectionChange;
    property OnValidate;
  end;

  { TCustomdxMaskEdit }
  TCustomdxMaskEdit = class(TdxInplaceMaskEdit)
  public
    class function IsInplace: Boolean; override;
  end;

  { TdxMaskEdit }
  TdxMaskEdit = class(TCustomdxMaskEdit)
  published
    property Color;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property ImeMode;
    property ImeName;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Style;
    property TabOrder;
    property TabStop default True;
    property Visible;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
  {$IFDEF DELPHI4}
    property Anchors;
//    property BiDiMode;
    property Constraints;
    property DragKind;
//    property ParentBiDiMode;
    property OnEndDock;
    property OnStartDock;
  {$ENDIF}
    // original (standard)
    property Alignment;
    property AutoSelect;
    property AutoSize;
    property CharCase;
    property EditMask; // original
    property IgnoreMaskBlank; // original
    property MaxLength;
    property PasswordChar;
    property ReadOnly;
    property StyleController;
    property Text;
    property OnChange;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnSelectionChange;
    property OnValidate;
  end;

  { TCustomdxMemo }
  TCustomdxMemo = class(TdxInplaceMemoEdit)
  public
    class function IsInplace: Boolean; override;
  end;

  { TdxMemo }
  TdxMemo = class(TCustomdxMemo)
  published
    property Align;
    property Color;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property ImeMode;
    property ImeName;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Style;
    property TabOrder;
    property TabStop default True;
    property Visible;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
  {$IFDEF DELPHI4}
    property Anchors;
//    property BiDiMode;
    property Constraints;
    property DragKind;
//    property ParentBiDiMode;
    property OnEndDock;
    property OnStartDock;
  {$ENDIF}
  {$IFDEF DELPHI5}
    property OnContextPopup;
  {$ENDIF}
    // original (standard)
    property Alignment;
    property AutoSelect default False;
    property CharCase;
    property HideSelection;
    property MaxLength;
    property OEMConvert;
    property PasswordChar;
    property ReadOnly;
    property StyleController;
    property OnChange;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnSelectionChange;
    property OnValidate;
    // memo
    property HideScrollBars;
    property Lines;
    property ScrollBars;
    property SelectionBar;
    property WantReturns;
    property WantTabs;
    property WordWrap;
  end;

  { TCustomdxDateEdit }
  TCustomdxDateEdit = class(TdxInplaceDateEdit)
  public
    class function IsInplace: Boolean; override;
  end;

  { TdxDateEdit }
  TdxDateEdit = class(TCustomdxDateEdit)
  published
    property Color;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property ImeMode;
    property ImeName;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Style;
    property TabOrder;
    property TabStop default True;
    property Visible;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
  {$IFDEF DELPHI4}
    property Anchors;
//    property BiDiMode;
    property Constraints;
    property DragKind;
//    property ParentBiDiMode;
    property OnEndDock;
    property OnStartDock;
  {$ENDIF}
  {$IFDEF DELPHI5}
    property OnContextPopup;
  {$ENDIF}
    // original (standard)
    property Alignment;
    property AutoSelect;
    property AutoSize;
    property HideSelection;
    property ReadOnly;
    property StyleController;
    property OnChange;
    property OnDropDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnValidate;
    // drop down
    property ButtonGlyph;
    property PopupAlignment;
    property PopupBorder;
    // date
    property Date;
    property DateButtons;
    property DateOnError;
    property DateValidation;
    property SaveTime;
    property UseEditMask;
    property OnDateChange;
    property OnDateValidateInput;
  end;

  { TCustomdxButtonEdit }
  TCustomdxButtonEdit = class(TdxInplaceButtonEdit)
  public
    class function IsInplace: Boolean; override;
  end;

  { TdxButtonEdit }
  TdxButtonEdit = class(TCustomdxButtonEdit)
  published
    property Color;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property ImeMode;
    property ImeName;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Style;
    property TabOrder;
    property TabStop default True;
    property Visible;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
  {$IFDEF DELPHI4}
    property Anchors;
//    property BiDiMode;
    property Constraints;
    property DragKind;
//    property ParentBiDiMode;
    property OnEndDock;
    property OnStartDock;
  {$ENDIF}
  {$IFDEF DELPHI5}
    property OnContextPopup;
  {$ENDIF}
    // original (standard)
    property Alignment;
    property AutoSelect;
    property AutoSize;
    property CharCase;
    property EditMask; // mask
    property MaxLength;
    property PasswordChar;
    property ReadOnly;
    property StyleController;
    property Text;
    property OnChange;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnSelectionChange;
    property OnValidate;
    // button
    property Buttons;
    property ClickKey;
    property ViewStyle;
    property OnButtonClick;
  end;

  { TCustomdxCheckEdit }
  TCustomdxCheckEdit = class(TdxInplaceCheckEdit)
  public
    class function IsInplace: Boolean; override;
  end;

  { TdxCheckEdit }
  TdxCheckEdit = class(TCustomdxCheckEdit)
  published
//    property Action; TODO
    property Color;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property ImeMode;
    property ImeName;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Style;
    property TabOrder;
    property TabStop default True;
    property Visible;
    property OnClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
  {$IFDEF DELPHI4}
    property Anchors;
//    property BiDiMode;
    property Constraints;
    property DragKind;
//    property ParentBiDiMode;
    property OnEndDock;
    property OnStartDock;
  {$ENDIF}
  {$IFDEF DELPHI5}
    property OnContextPopup;
  {$ENDIF}
    // original (standard)
    property Alignment;
    property AutoSize;
    property Caption;
    property ReadOnly;
    property StyleController;
    property OnChange;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnValidate;
    // check
    property AllowGrayed;
    property Checked;
    property FullFocusRect;
    property Glyph;
    property GlyphCount;
    property MultiLine;
    property NullStyle;
    property State;
  end;

  { TCustomdxImageEdit }
  TCustomdxImageEdit = class(TdxInplaceImageEdit)
  public
    class function IsInplace: Boolean; override;
  end;

  { TdxImageEdit }
  TdxImageEdit = class(TCustomdxImageEdit)
  published
    property Color;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property ImeMode;
    property ImeName;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Style;
    property TabOrder;
    property TabStop default True;
    property Text;
    property Visible;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
  {$IFDEF DELPHI4}
    property Anchors;
//    property BiDiMode;
    property Constraints;
    property DragKind;
//    property ParentBiDiMode;
    property OnEndDock;
    property OnStartDock;
  {$ENDIF}
  {$IFDEF DELPHI5}
    property OnContextPopup;
  {$ENDIF}
    // original (standard)
    property Alignment;
    property AutoSize;
    property ReadOnly;
    property StyleController;
    property OnChange;
    property OnCloseUp;
    property OnDropDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnValidate;
    // drop down
    property ButtonGlyph;
    property DropDownRows;
    property DropDownWidth;
    property PopupAlignment;
    property PopupBorder;
    // image
    property DefaultImages;
    property Descriptions;
    property ImageIndexes;
    property Images;
    property LargeImages;
    property MultiLineText;
    property ShowDescription;
    property Values;
  end;

  { TCustomdxSpinEdit }
  TCustomdxSpinEdit = class(TdxInplaceSpinEdit)
  public
    class function IsInplace: Boolean; override;
  end;

  { TdxSpinEdit }
  TdxSpinEdit = class(TCustomdxSpinEdit)
  public
    property IntValue;
    property Text;
  published
    property Color;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property ImeMode;
    property ImeName;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Style;
    property TabOrder;
    property TabStop default True;
    property Visible;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
  {$IFDEF DELPHI4}
    property Anchors;
//    property BiDiMode;
    property Constraints;
    property DragKind;
//    property ParentBiDiMode;
    property OnEndDock;
    property OnStartDock;
  {$ENDIF}
    // original (standard)
    property Alignment;
    property AutoSelect;
    property AutoSize;
    property HideSelection;
//    property MaxLength;
    property PasswordChar;
    property ReadOnly;
    property StyleController;
    property OnChange;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnSelectionChange;
    property OnValidate;
    // spin
    property EditorEnabled;
    property Increment;
    property MaxValue;
    property MinValue;
    property Value;
    property ValueType;
  end;

  { TCustomdxPickEdit }
  TCustomdxPickEdit = class(TdxInplacePickEdit)
  public
    class function IsInplace: Boolean; override;
  end;

  { TdxPickEdit }
  TdxPickEdit = class(TCustomdxPickEdit)
  public
    property ItemIndex;
  published
    property Color;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property ImeMode;
    property ImeName;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Style;
    property TabOrder;
    property TabStop default True;
    property Visible;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
  {$IFDEF DELPHI4}
    property Anchors;
//    property BiDiMode;
    property Constraints;
    property DragKind;
//    property ParentBiDiMode;
    property OnEndDock;
    property OnStartDock;
  {$ENDIF}
    // original (standard)
    property Alignment;
    property AutoSelect;
    property AutoSize;
    property CharCase;
    property EditMask; // mask
    property HideSelection;
    property MaxLength;
    property PasswordChar;
    property ReadOnly;
    property StyleController;
    property Text;
    property OnChange;
    property OnCloseUp;
    property OnDropDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnSelectionChange;
    property OnValidate;
    // drop down
    property ButtonGlyph;
    property DropDownRows;
    property DropDownWidth;
    property ImmediateDropDown;
    property PopupAlignment;
    property PopupBorder;
    // pick
    property DropDownListStyle;
    property Items;
    property CanDeleteText;
    property Revertable;
    property Sorted;
  end;

  { TCustomdxCalcEdit }
  TCustomdxCalcEdit = class(TdxInplaceCalcEdit)
  public
    constructor Create(AOwner: TComponent); override;
    class function IsInplace: Boolean; override;
  end;

  { TdxCalcEdit }
  TdxCalcEdit = class(TCustomdxCalcEdit)
  published
    property Color;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property ImeMode;
    property ImeName;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Style;
    property TabOrder;
    property TabStop default True;
    property Visible;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
  {$IFDEF DELPHI4}
    property Anchors;
//    property BiDiMode;
    property Constraints;
    property DragKind;
//    property ParentBiDiMode;
    property OnEndDock;
    property OnStartDock;
  {$ENDIF}
    // original (standard)
    property Alignment;
    property AutoSelect;
    property AutoSize;
//    property EditMask; // mask
    property HideSelection;
//    property MaxLength;
    property PasswordChar;
    property ReadOnly;
    property StyleController;
    property Text;
    property OnChange;
    property OnDropDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnSelectionChange;
    property OnValidate;
    // drop down
    property ButtonGlyph;
    property PopupAlignment;
    property PopupBorder;
    // calc
    property BeepOnError;
    property ButtonStyle;
    property Precision;
    property QuickClose;
    property ShowButtonFrame;
  end;

  { TCustomdxHyperLinkEdit }
  TCustomdxHyperLinkEdit = class(TdxInplaceHyperLinkEdit)
  public
    class function IsInplace: Boolean; override;
  end;

  { TdxHyperLinkEdit }
  TdxHyperLinkEdit = class(TCustomdxHyperLinkEdit)
  published
    property Color;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property ImeMode;
    property ImeName;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Style;
    property TabOrder;
    property TabStop default True;
    property Text;
    property Visible;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
  {$IFDEF DELPHI4}
    property Anchors;
//    property BiDiMode;
    property Constraints;
    property DragKind;
//    property ParentBiDiMode;
    property OnEndDock;
    property OnStartDock;
  {$ENDIF}
  {$IFDEF DELPHI5}
    property OnContextPopup;
  {$ENDIF}
    // original (standard)
    property Alignment;
    property AutoSelect;
    property AutoSize;
    property CharCase;
    property HideSelection;
    property MaxLength;
    property OEMConvert;
    property PasswordChar;
    property ReadOnly;
    property StyleController;
    property OnChange;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnSelectionChange;
    property OnValidate;
    // hyper
    property LinkColor;
    property SingleClick;
    property StartKey;
    property OnStartClick;
  end;

  { TCustomdxTimeEdit }
  TCustomdxTimeEdit = class(TdxInplaceTimeEdit)
  public
    class function IsInplace: Boolean; override;
  end;

  { TdxTimeEdit }
  TdxTimeEdit = class(TCustomdxTimeEdit)
  public
    property Text;
  published
    property Color;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property ImeMode;
    property ImeName;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Style;
    property TabOrder;
    property TabStop default True;
    property Visible;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
  {$IFDEF DELPHI4}
    property Anchors;
//    property BiDiMode;
    property Constraints;
    property DragKind;
//    property ParentBiDiMode;
    property OnEndDock;
    property OnStartDock;
  {$ENDIF}
    // original (standard)
    property Alignment;
    property AutoSelect;
    property AutoSize;
    property HideSelection;
//    property MaxLength;
    property ReadOnly;
    property StyleController;
    property OnChange;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnSelectionChange;
    property OnValidate;
    // time
    property Time;
    property TimeEditFormat;
  end;

  { TCustomdxCurrencyEdit }
  TCustomdxCurrencyEdit = class(TdxInplaceCurrencyEdit)
  public
    class function IsInplace: Boolean; override;
  end;

  { TdxCurrencyEdit }
  TdxCurrencyEdit = class(TCustomdxCurrencyEdit)
  published
    property Color;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property ImeMode;
    property ImeName;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Style;
    property TabOrder;
    property TabStop default True;
    property Visible;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
  {$IFDEF DELPHI4}
    property Anchors;
//    property BiDiMode;
    property Constraints;
    property DragKind;
//    property ParentBiDiMode;
    property OnEndDock;
    property OnStartDock;
  {$ENDIF}
    // original (standard)
    property Alignment;
    property AutoSelect;
    property AutoSize;
    property HideSelection;
    property MaxLength;
    property ReadOnly;
    property StyleController;
    property OnChange;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnSelectionChange;
    property OnValidate;
    // currency
    property DecimalPlaces;
    property DisplayFormat;
    property MaxValue;
    property MinValue;
    property UseThousandSeparator;
    property Value;
  end;

  { TCustomdxGraphicEdit }
  TCustomdxGraphicEdit = class(TdxInplaceGraphicEdit)
  public
    class function IsInplace: Boolean; override;
  end;

  { TdxGraphicEdit }
  TdxGraphicEdit = class(TCustomdxGraphicEdit)
  public
    property ClipboardFormat;
    property ToolbarPos;
  published
    property Align;
    property Color;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property ImeMode;
    property ImeName;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Style;
    property TabOrder;
    property TabStop default True;
    property Visible;
    property OnClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
  {$IFDEF DELPHI4}
    property Anchors;
//    property BiDiMode;
    property Constraints;
    property DragKind;
//    property ParentBiDiMode;
    property OnEndDock;
    property OnStartDock;
  {$ENDIF}
  {$IFDEF DELPHI5}
    property OnContextPopup;
  {$ENDIF}
    // original (standard)
    property AutoSize;
    property Caption;
    property ReadOnly;
    property StyleController;
    property OnChange;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnValidate;
    // graphic
    property Center;
    property CustomFilter;
    property DblClickActivate;
    property GraphicTransparency;
    property Picture;
    property QuickDraw;
    property Stretch;
    property ToolbarLayout;
    property ToolbarPosStored;
    property OnCustomClick;
  end;

  { TCustomdxBlobEdit }
  TCustomdxBlobEdit = class(TdxInplaceBlobEdit)
  public
    class function IsInplace: Boolean; override;
  end;

  { TdxBlobEdit }
  TdxBlobEdit = class(TCustomdxBlobEdit)
  public
    property PictureClipboardFormat;
    property PictureGraphicClass;
    property Text; // BlobData
  published
    property Color;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property ImeMode;
    property ImeName;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Style;
    property TabOrder;
    property TabStop default True;
    property Visible;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
  {$IFDEF DELPHI4}
    property Anchors;
//    property BiDiMode;
    property Constraints;
    property DragKind;
//    property ParentBiDiMode;
    property OnEndDock;
    property OnStartDock;
  {$ENDIF}
    // original (standard)
    property Alignment;
    property AutoSize;
    property ReadOnly;
    property StyleController;
    property OnChange;
    property OnDropDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnValidate;
    // drop down
    property PopupAlignment;
    property PopupBorder;
    // blob: common
    property BlobEditKind;
    property BlobPaintStyle;
    property BlobText;
    property PopupHeight;
    property PopupWidth;
    property SizeablePopup;
    // blob: memo
    property AlwaysSaveText;
    property MemoCharCase;
    property MemoHideScrollBars;
    property MemoMaxLength;
    property MemoOEMConvert;
    property MemoScrollBars;
    property MemoSelectionBar;
    property MemoWantReturns;
    property MemoWantTabs;
    property MemoWordWrap;
    // blob: picture
    property PictureAutoSize;
    property PictureFilter;
    property PictureTransparency;
    property ShowExPopupItems;
    property ShowPicturePopup;
  end;

  { TCustomdxMRUEdit }
  TCustomdxMRUEdit = class(TdxInplaceMRUEdit)
  public
    class function IsInplace: Boolean; override;
  end;

  { TdxMRUEdit }
  TdxMRUEdit = class(TCustomdxMRUEdit)
  public
    property ItemIndex;
  published
    property Color;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property ImeMode;
    property ImeName;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Style;
    property TabOrder;
    property TabStop default True;
    property Visible;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
  {$IFDEF DELPHI4}
    property Anchors;
//    property BiDiMode;
    property Constraints;
    property DragKind;
//    property ParentBiDiMode;
    property OnEndDock;
    property OnStartDock;
  {$ENDIF}
    // original (standard)
    property Alignment;
    property AutoSelect;
    property AutoSize;
    property CharCase;
    property EditMask; // mask
    property HideSelection;
    property MaxLength;
    property PasswordChar;
    property ReadOnly;
    property StyleController;
    property Text;
    property OnChange;
    property OnDropDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnSelectionChange;
    property OnValidate;
    // drop down
    property ButtonGlyph;
    property DropDownRows;
    property DropDownWidth;
    property ImmediateDropDown;
    property PopupAlignment;
    property PopupBorder;
    // pick
    property DropDownListStyle;
    property Items;
    property CanDeleteText;
    property Revertable;
    // MRU
    property MaxItemCount;
    property ShowEllipsis;
    property OnButtonClick;
  end;

  { TCustomdxPopupEdit }
  TCustomdxPopupEdit = class(TdxInplacePopupEdit)
  public
    class function IsInplace: Boolean; override;
  end;

  { TdxPopupEdit }
  TdxPopupEdit = class(TCustomdxPopupEdit)
  published
    property Color;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property ImeMode;
    property ImeName;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Style;
    property TabOrder;
    property TabStop default True;
    property Visible;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
  {$IFDEF DELPHI4}
    property Anchors;
//    property BiDiMode;
    property Constraints;
    property DragKind;
//    property ParentBiDiMode;
    property OnEndDock;
    property OnStartDock;
  {$ENDIF}
    // original (standard)
    property Alignment;
    property AutoSelect;
    property AutoSize;
    property CharCase;
    property EditMask; // mask
    property HideSelection;
    property MaxLength;
    property PasswordChar;
    property ReadOnly;
    property StyleController;
    property Text;
    property OnChange;
    property OnDropDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnSelectionChange;
    property OnValidate;
    // drop down
    property ButtonGlyph;
    property PopupAlignment; // TODO ?
    // popup edit
    property HideEditCursor;
    property PopupAutoSize;
    property PopupControl;
    property PopupFormBorderStyle;
    property PopupFormCaption;
    property PopupClientEdge;
    property PopupFlatBorder;
    property PopupHeight;
    property PopupMinHeight;
    property PopupMinWidth;
    property PopupSizeable;
    property PopupWidth;
    property OnCloseQuery;
    property OnCloseUp;
    property OnInitPopup;
    property OnPopup;
  end;

implementation

{ TCustomdxEdit }
class function TCustomdxEdit.IsInplace: Boolean;
begin
  Result := False;
end;

{ TCustomdxMaskEdit }
class function TCustomdxMaskEdit.IsInplace: Boolean;
begin
  Result := False;
end;

{ TCustomdxMemo }
class function TCustomdxMemo.IsInplace: Boolean;
begin
  Result := False;
end;

{ TCustomdxDateEdit }
class function TCustomdxDateEdit.IsInplace: Boolean;
begin
  Result := False;
end;

{ TCustomdxButtonEdit }
class function TCustomdxButtonEdit.IsInplace: Boolean;
begin
  Result := False;
end;

{ TCustomdxCheckEdit }
class function TCustomdxCheckEdit.IsInplace: Boolean;
begin
  Result := False;
end;

{ TCustomdxImageEdit }
class function TCustomdxImageEdit.IsInplace: Boolean;
begin
  Result := False;
end;

{ TCustomdxSpinEdit }
class function TCustomdxSpinEdit.IsInplace: Boolean;
begin
  Result := False;
end;

{ TCustomdxPickEdit }
class function TCustomdxPickEdit.IsInplace: Boolean;
begin
  Result := False;
end;

{ TCustomdxCalcEdit }
constructor TCustomdxCalcEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle - [csSetCaption];
  Text := '0';
end;

class function TCustomdxCalcEdit.IsInplace: Boolean;
begin
  Result := False;
end;

{ TCustomdxHyperLinkEdit }
class function TCustomdxHyperLinkEdit.IsInplace: Boolean;
begin
  Result := False;
end;

{ TCustomdxTimeEdit }
class function TCustomdxTimeEdit.IsInplace: Boolean;
begin
  Result := False;
end;

{ TCustomdxCurrencyEdit }
class function TCustomdxCurrencyEdit.IsInplace: Boolean;
begin
  Result := False;
end;

{ TCustomdxGraphicEdit }
class function TCustomdxGraphicEdit.IsInplace: Boolean;
begin
  Result := False;
end;

{ TCustomdxBlobEdit }
class function TCustomdxBlobEdit.IsInplace: Boolean;
begin
  Result := False;
end;

{ TCustomdxMRUEdit }
class function TCustomdxMRUEdit.IsInplace: Boolean;
begin
  Result := False;
end;

{ TCustomdxPopupEdit }
class function TCustomdxPopupEdit.IsInplace: Boolean;
begin
  Result := False;
end;

end.

