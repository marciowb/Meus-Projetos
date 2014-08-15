{***************************************************************************}
{ TAdvMemo component                                                        }
{ for Delphi & C++Builder                                                   }
{ version 2.0                                                               }
{                                                                           }
{ written by TMS Software                                                   }
{            copyright © 2001 - 2006                                        }
{            Email : info@tmssoftware.com                                   }
{            Web : http://www.tmssoftware.com                               }
{                                                                           }
{ The source code is given as is. The author is not responsible             }
{ for any possible damage done due to the use of this code.                 }
{ The component can be freely used in any application. The complete         }
{ source code remains property of the author and may not be distributed,    }
{ published, given or sold in any form as such. No parts of the source      }
{ code can be included in any other component or application without        }
{ written authorization of TMS software.                                    }
{***************************************************************************}

unit AdvMemoReg;

interface

{$I TMSDEFS.INC}

uses
  Classes,
  AdvMemo,
  AdvmPS,
  AdvmBS,
  AdvCodeList,
  AdvMemoStylerManager
  ;

procedure Register;

implementation

uses
  ActnList;                                            

procedure Register;
begin
  RegisterComponents('TMS Memo', [TAdvMemo,TAdvMemoSource,
                                  TAdvPascalMemoStyler,
                                  TAdvBasicMemoStyler,
                                  TAdvMemoFindDialog,
                                  TAdvMemoFindReplaceDialog,
                                  TAdvCodeList,
                                  TAdvMemoStylerManager]);

  RegisterActions('AdvMemo', [TAdvMemoCut, TAdvMemoCopy, TAdvMemoPaste,
    TAdvMemoDelete, TAdvMemoUndo, TAdvMemoRedo, TAdvMemoSelectAll], nil);
end;

end.
