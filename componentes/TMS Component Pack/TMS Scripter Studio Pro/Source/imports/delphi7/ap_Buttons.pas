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
unit ap_Buttons;

interface

uses
  Windows,
  Messages,
  Classes,
  Controls,
  Forms,
  Graphics,
  StdCtrls,
  ExtCtrls,
  CommCtrl,
  Buttons,
  Variants,
  ap_Types,
  atScript;

{$WARNINGS OFF}

type
  TatButtonsLibrary = class(TatScripterLibrary)
    procedure __TSpeedButtonCreate(AMachine: TatVirtualMachine);
    procedure __TSpeedButtonDestroy(AMachine: TatVirtualMachine);
    procedure __TSpeedButtonClick(AMachine: TatVirtualMachine);
    procedure __TBitBtnCreate(AMachine: TatVirtualMachine);
    procedure __TBitBtnDestroy(AMachine: TatVirtualMachine);
    procedure __TBitBtnClick(AMachine: TatVirtualMachine);
    procedure __DrawButtonFace(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TSpeedButtonActionLinkClass = class of TSpeedButtonActionLink;
  TSpeedButtonClass = class of TSpeedButton;
  TBitBtnClass = class of TBitBtn;



implementation



procedure TatButtonsLibrary.__TSpeedButtonCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TSpeedButtonClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatButtonsLibrary.__TSpeedButtonDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSpeedButton(CurrentObject).Destroy;
  end;
end;

procedure TatButtonsLibrary.__TSpeedButtonClick(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSpeedButton(CurrentObject).Click;
  end;
end;

procedure TatButtonsLibrary.__TBitBtnCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TBitBtnClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatButtonsLibrary.__TBitBtnDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TBitBtn(CurrentObject).Destroy;
  end;
end;

procedure TatButtonsLibrary.__TBitBtnClick(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TBitBtn(CurrentObject).Click;
  end;
end;

procedure TatButtonsLibrary.__DrawButtonFace(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := integer(TRectWrapper.Create(Buttons.DrawButtonFace(TCanvas(Integer(GetInputArg(0))),TRectWrapper(integer(GetInputArg(1))).ObjToRec,VarToInteger(GetInputArg(2)),GetInputArg(3),GetInputArg(4),GetInputArg(5),GetInputArg(6))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatButtonsLibrary.Init;
begin
  With Scripter.DefineClass(TSpeedButtonActionLink) do
  begin
  end;
  With Scripter.DefineClass(TSpeedButton) do
  begin
    DefineMethod('Create',1,tkClass,TSpeedButton,__TSpeedButtonCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TSpeedButtonDestroy,false,0);
    DefineMethod('Click',0,tkNone,nil,__TSpeedButtonClick,false,0);
  end;
  With Scripter.DefineClass(TBitBtn) do
  begin
    DefineMethod('Create',1,tkClass,TBitBtn,__TBitBtnCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TBitBtnDestroy,false,0);
    DefineMethod('Click',0,tkNone,nil,__TBitBtnClick,false,0);
  end;
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('DrawButtonFace',7,tkVariant,nil,__DrawButtonFace,false,0);
    AddConstant('blGlyphLeft',blGlyphLeft);
    AddConstant('blGlyphRight',blGlyphRight);
    AddConstant('blGlyphTop',blGlyphTop);
    AddConstant('blGlyphBottom',blGlyphBottom);
    AddConstant('bsUp',bsUp);
    AddConstant('bsDisabled',bsDisabled);
    AddConstant('bsDown',bsDown);
    AddConstant('bsExclusive',bsExclusive);
    AddConstant('bsAutoDetect',bsAutoDetect);
    AddConstant('bsWin31',bsWin31);
    AddConstant('bsNew',bsNew);
    AddConstant('bkCustom',bkCustom);
    AddConstant('bkOK',bkOK);
    AddConstant('bkCancel',bkCancel);
    AddConstant('bkHelp',bkHelp);
    AddConstant('bkYes',bkYes);
    AddConstant('bkNo',bkNo);
    AddConstant('bkClose',bkClose);
    AddConstant('bkAbort',bkAbort);
    AddConstant('bkRetry',bkRetry);
    AddConstant('bkIgnore',bkIgnore);
    AddConstant('bkAll',bkAll);
  end;
end;

class function TatButtonsLibrary.LibraryName: string;
begin
  result := 'Buttons';
end;

initialization
  RegisterScripterLibrary(TatButtonsLibrary, True);

{$WARNINGS ON}

end.

