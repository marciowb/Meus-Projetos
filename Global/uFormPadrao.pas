unit uFormPadrao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, EditPesquisa, DB, StdCtrls, Mask, DBCtrls,TypInfo, LabelDBEdit
  {$IfDef ALPHA} ,uAcessoUsuario, ActnList,MinhasClasses{$EndIf} {$IfDef Dragon},uCfgDragon {$EndIf};

type
  iFormPadrao = interface

  end;
  TfrmPadrao = class(TForm,iFormPadrao)
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private
    FOnLooping: TNotifyEvent;
    {$IfDef ALPHA}
      FIdForm: Integer;
    {$EndIf}

    { Private declarations }
  public
    { Public declarations }
    {$IfDef ALPHA} Property IdForm : Integer read FIdForm write FIdForm; {$EndIf}
    Procedure AbrePesquisaEdit (Sender: TObject;ADataSet: TDataSet;
                                aTipoPesquisa: Integer; Titulo: string;
                                 out Resultado: Variant);
    Property OnLooping : TNotifyEvent read FOnLooping  write FOnLooping ;
  end;

var
  frmPadrao: TfrmPadrao;

implementation

uses Comandos;


{$R *.dfm}

{ TfrmPadrao }

procedure TfrmPadrao.AbrePesquisaEdit(Sender: TObject; ADataSet: TDataSet;
  aTipoPesquisa: Integer; Titulo: string; out Resultado: Variant);
begin
   AbrePesquisa(Sender, (Sender as TEditPesquisa).DataSet, (Sender as TEditPesquisa).TipoPesquisa, (Sender as TEditPesquisa).Titulo, Resultado);
end;

procedure TfrmPadrao.FormCreate(Sender: TObject);
var
  i :integer;
  cc : TEditCharCase;
begin
  Try
    {$IfDef ALPHA}
     IdForm := GravarInfoForm(UnitName, Self.ClassName, Self.Caption);
    {$EndIf}
    cc := ecUpperCase;
    {$IfDef Dragon}
       if MyCfgDragon.GetConfiguracao(tpcGeralTipoCaracter) = '0' then // Normal
         cc := ecNormal;
    {$EndIf}
    for I := 0 to ComponentCount - 1 do
    Begin
       if Components[i] is TEditPesquisa then
       Begin
        if (Components[i] as TEditPesquisa).Tag <> 99 then
          (Components[i] as TEditPesquisa).OnAbrePesquisa := AbrePesquisaEdit;
       End;
       ConfiguraCx(Components[i]);
       if GetPropInfo(Components[i], 'CharCase') <> nil Then
          SetPropValue(Components[i],'CharCase', cc);
       if Assigned(OnLooping) then
         OnLooping(Components[i]);
       {$IfDef ALPHA}
         if IdForm <= 0 then
           Continue;
         if (Components[i] is TCustomAction) then
         Begin
           if ((Components[i] As TCustomAction).Owner = Self) and (Assigned((Components[i] As TCustomAction).OnExecute )) then
           Begin
             GravaObjetosForm((Components[i] As TCustomAction), IdForm);
             SetPermissao((Components[i] As TCustomAction), IdForm);
           End;
         End;
       {$EndIf}
    End;
  Finally

  End;

end;

procedure TfrmPadrao.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of

    VK_RETURN:
      Begin
        if ((ActiveControl is TDBMemo) or (ActiveControl is TMemo)) and (ssCtrl in Shift) then
          Key := 0
        else
          SelectNext(ActiveControl, True, True);
      End;
    VK_ESCAPE:
      Begin
        Close;
      End;

  end;
end;

procedure TfrmPadrao.FormKeyPress(Sender: TObject; var Key: Char);
begin
  case key of
    ',','.':
      Begin
        if (ActiveControl <> nil ) and (IsNumericDBControl(ActiveControl)) then
          Key := DecimalSeparator;
     
      End;


  end;
end;



procedure TfrmPadrao.FormShow(Sender: TObject);
var
  i :integer;
  cc : TEditCharCase;
begin
//  Try
//    {$IfDef ALPHA}
//     IdForm := GravarInfoForm(UnitName, Self.ClassName, Self.Caption);
//    {$EndIf}
//    cc := ecUpperCase;
//    {$IfDef Dragon}
//       if MyCfgDragon.GetConfiguracao(tpcGeralTipoCaracter) = '0' then // Normal
//         cc := ecNormal;
//    {$EndIf}
//    for I := 0 to ComponentCount - 1 do
//    Begin
//       if Components[i] is TEditPesquisa then
//       Begin
//        if (Components[i] as TEditPesquisa).Tag <> 99 then
//          (Components[i] as TEditPesquisa).OnAbrePesquisa := AbrePesquisaEdit;
//       End;
//       ConfiguraCx(Components[i]);
//       if GetPropInfo(Components[i], 'CharCase') <> nil Then
//          SetPropValue(Components[i],'CharCase', cc);
//
//       {$IfDef ALPHA}
//         if IdForm <= 0 then
//           Continue;
//         if (Components[i] is TCustomAction) then
//         Begin
//           if ((Components[i] As TCustomAction).Owner = Self) and (Assigned((Components[i] As TCustomAction).OnExecute )) then
//           Begin
//             GravaObjetosForm((Components[i] As TCustomAction), IdForm);
//             SetPermissao((Components[i] As TCustomAction), IdForm);
//           End;
//         End;
//       {$EndIf}
//    End;
//  Finally
//
//  End;




end;


end.


