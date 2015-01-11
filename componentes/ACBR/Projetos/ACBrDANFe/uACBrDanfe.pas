unit uACBrDanfe;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, RLConsts,
  Dialogs, ACBrNFeDANFEClass, ACBrNFeDANFERaveCB, ACBrNFe, IniFiles, ExtCtrls,
  System.UITypes,
  ACBrNFeUtil, ACBrDFeUtil, pcnConversao, ACBrNFeDANFeRLClass, ACBrNFeDANFERave, ACBrNFeDANFeRL,
  ACBrNFeDANFEFR;

type
  Tfrm_danfe = class(TForm)
    ACBrNFe1: TACBrNFe;
    TrayIcon1: TTrayIcon;
    Timer1: TTimer;
    Image1: TImage;
    ACBrNFeDANFERave1: TACBrNFeDANFERave;
    ACBrNFeDANFERaveCB1: TACBrNFeDANFERaveCB;
    ACBrNFeDANFeRL1: TACBrNFeDANFeRL;
    ACBrNFeDANFEFR1: TACBrNFeDANFEFR;
    function  Configuracao: boolean;
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    const
      wArquivoINI: string =
'[DANFe]'+sLineBreak+
'Versao                         = <VERSAOINI>'+sLineBreak+
'# DANFe                          = Rave'+sLineBreak+
'# DANFe                          = Fortes'+sLineBreak+
'# DANFe                          = Fast'+sLineBreak+
'DANFe                          = RaveCB'+sLineBreak+
sLineBreak+
'[PROPRIEDADES_DANFe]'+sLineBreak+
'CasasDecimais_Qtde             = 2'+sLineBreak+
'CasasDecimais_Unidade          = 2'+sLineBreak+
'CasasDecimais_Mask_Qtde        ='+sLineBreak+
'CasasDecimais_Mask_Unidade     ='+sLineBreak+
'Email                          ='+sLineBreak+
'ExibirResumoCanhoto            = 0'+sLineBreak+
'ExibirResumoCanhoto_Texto      ='+sLineBreak+
'ExpandirLogoMarca              = 0'+sLineBreak+
'Fax                            ='+sLineBreak+
'FormularioContinuo             = 0'+sLineBreak+
'Impressora                     ='+sLineBreak+
'ImprimirDescPorc               = 0'+sLineBreak+
'ImprimirDetalhamentoEspecifico = 1'+sLineBreak+
'ImprimirTotalLiquido           = 0'+sLineBreak+
'Logo                           ='+sLineBreak+
'MargemDireita                  = 0,51'+sLineBreak+
'MargemEsquerda                 = 0,6'+sLineBreak+
'MargemInferior                 = 0,8'+sLineBreak+
'MargemSuperior                 = 0,8'+sLineBreak+
'MostrarPreview                 = 1'+sLineBreak+
'MostrarStatus                  = 1'+sLineBreak+
'NumCopias                      = 1'+sLineBreak+
'PathPdf                        ='+sLineBreak+
'ProdutosPorPagina              = 0'+sLineBreak+
'ProtocoloNFe                   ='+sLineBreak+
'Sistema                        ='+sLineBreak+
'Site                           ='+sLineBreak+
'TamanhoFonte_DemaisCampos      = 10'+sLineBreak+
'# TipoDANFE                      = tiPaisagem'+sLineBreak+
'TipoDANFE                      = tiRetrato'+sLineBreak+
'Usuario                        ='+sLineBreak+
sLineBreak+
'[PROPRIEDADEs_DANFe_RAVE]'+sLineBreak+
'EspessuraBorda                 = 1'+sLineBreak+
'TamanhoFonte_RazaoSocial       = 12'+sLineBreak+
'TamanhoFonte_ANTT              = 10'+sLineBreak+
'TributosFonte                  ='+sLineBreak+
'# TributosPercentual             = ptValorNF'+sLineBreak+
'# TributosPercentual             = ptPersonalizado'+sLineBreak+
'TributosPercentual             = ptValorProdutos'+sLineBreak+
'MarcaDaguaMSG                  ='+sLineBreak+
sLineBreak+
'[PROPRIEDADEs_DANFe_RAVECB]'+sLineBreak+
'EspessuraBorda                 = 2'+sLineBreak+
'ExpandirDadosAdicionaisAuto    = 0'+sLineBreak+
'# Fonte                          = ftCourier'+sLineBreak+
'Fonte                          = ftTimes'+sLineBreak+
'TamanhoCampoCodigo             = 0'+sLineBreak+
'TamanhoFonte_ANTT              = 10'+sLineBreak+
'MostrarSetup                   = 0'+sLineBreak+
'TributosFonte                  ='+sLineBreak+
'# TributosPercentual             = ptValorNF'+sLineBreak+
'# TributosPercentual             = ptPersonalizado'+sLineBreak+
'TributosPercentual             = ptValorProdutos'+sLineBreak+
'MarcaDaguaMSG                  ='+sLineBreak+
'TamanhoCampoVlUnit             = 0'+sLineBreak+
'#LocalImpCanhoto                = 1'+sLineBreak+
'LocalImpCanhoto                = 0'+sLineBreak+
sLineBreak+
'[PROPRIEDADEs_DANFe_FORTES]'+sLineBreak+
'# FonteNome                      = nfArial'+sLineBreak+
'# FonteNome                      = nfCourierNew'+sLineBreak+
'FonteNome                      = nfTimesNewRoman'+sLineBreak+
'Negrito                        = 0'+sLineBreak+
'TamanhoFonte_RazaoSocial       = 12'+sLineBreak+
'LarguraCodProd                 = 0'+sLineBreak+
'MarcadAgua                     ='+sLineBreak+
'# PosCanhoto                     = pcRodape'+sLineBreak+
'PosCanhoto                     = pcCabecalho'+sLineBreak+
'ExibirEAN                      = 0'+sLineBreak+
sLineBreak+
'[PROPRIEDADEs_DANFe_FAST]'+sLineBreak+
'EspessuraBorda                 = 1'+sLineBreak+
'ShowDialog                     = 0'+sLineBreak+
'ExibirTotalTributosItem        = 0'+sLineBreak+
'ExibeCampoFatura               = 1'+sLineBreak+
'TributosFonte                  ='+sLineBreak+
'# TributosPercentual             = ptValorNF'+sLineBreak+
'# TributosPercentual             = ptPersonalizado'+sLineBreak+
'TributosPercentual             = ptValorProdutos'+sLineBreak+
'MarcaDaguaMSG                  ='+sLineBreak+
'TributosPercentualPersonalizado= 0'+sLineBreak+
'ImprimirUnQtVlComercial        = 0'+sLineBreak+
'';

    function  VersaoExecutavel(lExeName: string): String;
  public
    { Public declarations }
    wPDF: boolean;
    wNFeCancelada: boolean;
  end;

var
  frm_danfe: Tfrm_danfe;

implementation

{$R *.dfm}

function Tfrm_danfe.Configuracao: boolean;
   procedure Delay(msecs:integer);
   var
      FirstTickCount : longint;
   begin
      FirstTickCount:=GetTickCount;
      repeat
         Application.ProcessMessages;
      until ((GetTickCount-FirstTickCount) >= Longint(msecs));
   end;
var
   Ini: TIniFile;
   wString: TStringList;
   wDanfe: string;
   IniFile : string;
   VersaoIni: string;
   CriaINI: Boolean;
begin
   result:=false;

   wString:=TStringList.Create;
   IniFile := ExtractFilePath(Application.ExeName)+'ACBrDANFe.ini';
   Ini:=TIniFile.Create(IniFile);
   try
      CriaIni := not FileExists(IniFile);
      if not CriaIni then
      begin
        VersaoIni := Trim(Ini.ReadString('DANFe','VERSAO' ,''));
        if VersaoExecutavel(Application.ExeName) <> VersaoIni then
        begin
          RenameFile(IniFile,ChangeFileExt(IniFile,'.ini_antigo'));
          CriaINI := True;
        end;
      end;
      if CriaIni then
      begin
        wString.Text:=wArquivoINI;
        wString.Text := StringReplace(wString.Text,'<VERSAOINI>',Trim(VersaoExecutavel(Application.ExeName)),[rfReplaceAll, rfIgnoreCase]);
        wString.SaveToFile(IniFile);
        Delay(3000);
      end;

      try
         wDanfe := Trim(Ini.ReadString('DANFe','DANFe' ,'RaveCB'));
         if wDanfe='Rave' then
            ACBrNFe1.DANFE := ACBrNFeDANFeRave1
         else if wDanfe='RaveCB' then
            ACBrNFe1.DANFE := ACBrNFeDANFeRaveCB1
         else if wDanfe='Fortes' then
            ACBrNFe1.DANFE := ACBrNFeDANFeRL1
         else if wDanfe='Fast' then
            ACBrNFe1.DANFE := ACBrNFeDANFeFR1;

         with ACBrNFe1.DANFE do
         begin
            CasasDecimais._qCom            := Ini.ReadInteger('PROPRIEDADES_DANFe','CasasDecimais_Qtde' ,2);
            CasasDecimais._vUnCom          := Ini.ReadInteger('PROPRIEDADES_DANFe','CasasDecimais_Unidade' ,2);
            CasasDecimais._Mask_qCom       := Trim(Ini.ReadString('PROPRIEDADES_DANFe','CasasDecimais_Mask_Qtde' ,''));
            CasasDecimais._Mask_vUnCom     := Trim(Ini.ReadString('PROPRIEDADES_DANFe','CasasDecimais_Mask_Unidade' ,''));
            Email                          := Trim(Ini.ReadString('PROPRIEDADES_DANFe','Email' ,''));
            ExibirResumoCanhoto            := Ini.ReadBool('PROPRIEDADES_DANFe','ExibirResumoCanhoto' ,false);
            ExibirResumoCanhoto_Texto      := Trim(Ini.ReadString('PROPRIEDADES_DANFe','ExibirResumoCanhoto_Texto' ,''));
            ExpandirLogoMarca              := Ini.ReadBool('PROPRIEDADES_DANFe','ExpandirLogoMarca' ,false);
            Fax                            := Trim(Ini.ReadString('PROPRIEDADES_DANFe','Fax' ,''));
            FormularioContinuo             := Ini.ReadBool('PROPRIEDADES_DANFe','FormularioContinuo' ,false);
            Impressora                     := Trim(Ini.ReadString('PROPRIEDADES_DANFe','Impressora' ,''));
            ImprimirDescPorc               := Ini.ReadBool('PROPRIEDADES_DANFe','ImprimirDescPorc' ,false);
            ImprimirDetalhamentoEspecifico := Ini.ReadBool('PROPRIEDADES_DANFe','ImprimirDetalhamentoEspecifico' ,true);
            ImprimirTotalLiquido           := Ini.ReadBool('PROPRIEDADES_DANFe','ImprimirTotalLiquido' ,false);
            Logo                           := Trim(Ini.ReadString('PROPRIEDADES_DANFe','Logo' ,''));
            MargemDireita                  := Ini.ReadFloat('PROPRIEDADES_DANFe','MargemDireita' ,0.51);
            MargemEsquerda                 := Ini.ReadFloat('PROPRIEDADES_DANFe','MargemEsquerda' ,0.6);
            MargemInferior                 := Ini.ReadFloat('PROPRIEDADES_DANFe','MargemInferior' ,0.8);
            MargemSuperior                 := Ini.ReadFloat('PROPRIEDADES_DANFe','MargemSuperior' ,0.8);
            MostrarPreview                 := Ini.ReadBool('PROPRIEDADES_DANFe','MostrarPreview' ,true);
            MostrarStatus                  := Ini.ReadBool('PROPRIEDADES_DANFe','MostrarStatus' ,true);
            NumCopias                      := Ini.ReadInteger('PROPRIEDADES_DANFe','NumCopias' ,1);
            PathPdf                        := Trim(Ini.ReadString('PROPRIEDADES_DANFe','PathPdf' ,''));
            ProdutosPorPagina              := Ini.ReadInteger('PROPRIEDADES_DANFe','ProdutosPorPagina' ,0);
            ProtocoloNFe                   := Trim(Ini.ReadString('PROPRIEDADES_DANFe','ProtocoloNFe' ,''));
            Sistema                        := Trim(Ini.ReadString('PROPRIEDADES_DANFe','Sistema' ,''));
            Site                           := Trim(Ini.ReadString('PROPRIEDADES_DANFe','Site' ,''));
            TamanhoFonte_DemaisCampos      := Ini.ReadInteger('PROPRIEDADES_DANFe','TamanhoFonte_DemaisCampos' ,10);
            TipoDANFE                      := DFeUtil.SeSenao(Trim(Ini.ReadString('PROPRIEDADEs_DANFe','TipoDANFE' ,'tiRetrato'))='tiRetrato',tiRetrato, tiPaisagem);
            Usuario                        := Trim(Ini.ReadString('PROPRIEDADES_DANFe','Usuario' ,''));
         end;

         with ACBrNFeDANFeRave1 do
         begin
            RavFile                        := ExtractFilePath(Application.ExeName)+'DANFE_Rave513.rav';
            EspessuraBorda                 := Ini.ReadInteger('PROPRIEDADES_DANFe_RAVE','EspessuraBorda' ,2);
            TamanhoFonte_RazaoSocial       := Ini.ReadInteger('PROPRIEDADES_DANFe_RAVE','TamanhoFonte_RazaoSocial' ,12);
            TamanhoFonte_ANTT              := Ini.ReadInteger('PROPRIEDADES_DANFe_RAVE','TamanhoFonte_ANTT' ,10);
            TributosFonte                  := Trim(Ini.ReadString('PROPRIEDADES_DANFe_RAVE','TributosFonte' ,''));
            TributosPercentual             := DFeUtil.SeSenao(Trim(Ini.ReadString('PROPRIEDADEs_DANFe_RAVE','TributosPercentual' ,'ptValorProdutos'))='ptValorProdutos',ptValorProdutos,
                                                              DFeUtil.SeSenao(Trim(Ini.ReadString('PROPRIEDADEs_DANFe_RAVE','TributosPercentual' ,'ptValorNF'))='ptValorNF',ptValorNF,
                                                              ptPersonalizado));
            MarcaDaguaMSG                  := Trim(Ini.ReadString('PROPRIEDADES_DANFe_RAVE','MarcaDaguaMSG' ,''));
         end;

         with ACBrNFeDANFeRaveCB1 do
         begin
            EspessuraBorda                 := Ini.ReadInteger('PROPRIEDADEs_DANFe_RAVECB','EspessuraBorda' ,2);
            ExpandirDadosAdicionaisAuto    := Ini.ReadBool('PROPRIEDADEs_DANFe_RAVECB','ExpandirDadosAdicionaisAuto' ,false);
            Fonte                          := DFeUtil.SeSenao(Trim(Ini.ReadString('PROPRIEDADEs_DANFe_RAVECB','Fonte' ,'ftTimes'))='ftTimes',ftTimes, ftCourier);
            TamanhoCampoCodigo             := Ini.ReadInteger('PROPRIEDADEs_DANFe_RAVECB','TamanhoCampoCodigo' ,10);
            TamanhoFonte_ANTT              := Ini.ReadInteger('PROPRIEDADES_DANFe_RAVE','TamanhoFonte_ANTT' ,10);
            MostrarSetup                   := Ini.ReadBool('PROPRIEDADEs_DANFe_RAVECB','MostrarSetup' ,false);
            TributosFonte                  := Trim(Ini.ReadString('PROPRIEDADES_DANFe_RAVECB','TributosFonte' ,''));
            TributosPercentual             := DFeUtil.SeSenao(Trim(Ini.ReadString('PROPRIEDADEs_DANFe_RAVECB','TributosPercentual' ,'ptValorProdutos'))='ptValorProdutos',ptValorProdutos,
                                                              DFeUtil.SeSenao(Trim(Ini.ReadString('PROPRIEDADEs_DANFe_RAVECB','TributosPercentual' ,'ptValorNF'))='ptValorNF',ptValorNF,
                                                              ptPersonalizado));
            MarcaDaguaMSG                  := Trim(Ini.ReadString('PROPRIEDADES_DANFe_RAVECB','MarcaDaguaMSG' ,''));
            TamanhoCampoVlUnit             := Ini.ReadInteger('PROPRIEDADES_DANFe_RAVECB','TamanhoCampoVlUnit' ,0);
            LocalImpCanhoto                := Ini.ReadInteger('PROPRIEDADES_DANFe_RAVECB','LocalImpCanhoto' ,0);
         end;

         with ACBrNFeDANFeRL1 do
         begin
            Fonte.Nome                     := DFeUtil.SeSenao(Trim(Ini.ReadString('PROPRIEDADEs_DANFe_FORTES','FonteNome' ,'nfTimesNewRoman'))='nfTimesNewRoman',nfTimesNewRoman,
                                                              DFeUtil.SeSenao(Trim(Ini.ReadString('PROPRIEDADEs_DANFe_FORTES','FonteNome' ,'nfCourierNew'))='nfCourierNew',nfCourierNew,
                                                              nfArial));
            Fonte.Negrito                  := Ini.ReadBool('PROPRIEDADEs_DANFe_FORTES','Negrito' ,false);
            Fonte.TamanhoFonte_RazaoSocial := Ini.ReadInteger('PROPRIEDADES_DANFe_FORTES','TamanhoFonte_RazaoSocial' ,12);
            LarguraCodProd                 := Ini.ReadInteger('PROPRIEDADEs_DANFe_FORTES','LarguraCodProd' ,0);
            MarcadAgua                     := Trim(Ini.ReadString('PROPRIEDADES_DANFe_FORTES','MarcadAgua' ,''));
            PosCanhoto                     := DFeUtil.SeSenao(Trim(Ini.ReadString('PROPRIEDADEs_DANFe_FORTES','PosCanhoto' ,'pcCabecalho'))='pcCabecalho',pcCabecalho,pcRodape);
            ExibirEAN                      := Ini.ReadBool('PROPRIEDADEs_DANFe_FORTES','ExibirEAN' ,false);
         end;

         with ACBrNFeDANFeFR1 do
         begin
            FastFile                       := ExtractFilePath(Application.ExeName)+'DANFeRetrato.fr3';
            EspessuraBorda                 := Ini.ReadInteger('PROPRIEDADES_DANFe_FAST','EspessuraBorda' ,1);
            ShowDialog                     := Ini.ReadBool('PROPRIEDADEs_DANFe_FAST','ShowDialog' ,false);
            ExibirTotalTributosItem        := Ini.ReadBool('PROPRIEDADEs_DANFe_FAST','ExibirTotalTributosItem' ,false);
            ExibeCampoFatura               := Ini.ReadBool('PROPRIEDADEs_DANFe_FAST','ExibeCampoFatura' ,true);
            TributosFonte                  := Trim(Ini.ReadString('PROPRIEDADES_DANFe_FAST','TributosFonte' ,''));
            TributosPercentual             := DFeUtil.SeSenao(Trim(Ini.ReadString('PROPRIEDADEs_DANFe_FAST','TributosPercentual' ,'ptValorProdutos'))='ptValorProdutos',ptValorProdutos,
                                                              DFeUtil.SeSenao(Trim(Ini.ReadString('PROPRIEDADEs_DANFe_FAST','TributosPercentual' ,'ptValorNF'))='ptValorNF',ptValorNF,
                                                              ptPersonalizado));
            TributosPercentualPersonalizado:= Ini.ReadFloat('PROPRIEDADES_DANFe_FAST','TributosPercentualPersonalizado' ,0);
            MarcaDaguaMSG                  := Trim(Ini.ReadString('PROPRIEDADES_DANFe_FAST','MarcaDaguaMSG' ,''));
            ImprimirUnQtVlComercial        := Ini.ReadBool('PROPRIEDADEs_DANFe_FAST','ImprimirUnQtVlComercial' ,false);
         end;

         Result:=True;
      except
         on EXC: Exception do
         begin
            MessageDlg('Erro:'+sLineBreak+sLineBreak+exc.message,mtError,[mbOk],0);
         end;
      end;
   finally
      wString.Free;
      Ini.Free;
   end;
end;

procedure Tfrm_danfe.FormCreate(Sender: TObject);
var
   wArquivo: string;
   wTemp: string;
begin
   if ParamCount <= 0 then
      MessageDlg('Informe um arquivo XML para impressão',mtError,[mbOk],0)
   else
   begin
      wArquivo:=ParamStr(1);
      if not FileExists(wArquivo) then
         MessageDlg('Arquivo '+wArquivo+' não Encontrado',mtError,[mbOk],0)
      else
      begin
         wPDF:=False;
         wNfeCancelada:=False;
         if (ParamCount > 1) then
         begin
            wtemp:=UpperCase(ParamStr(2));
            if wtemp='PDF' then
               wPDF:=true
            else if wtemp='C' then
               wNFeCancelada:=true;
            if (ParamCount > 2) then
            begin
               wtemp:=UpperCase(ParamStr(3));
               if wtemp='PDF' then
                  wPDF:=true
               else if wtemp='C' then
                  wNFeCancelada:=true;
            end;
         end;

         if Configuracao then
         begin
            try
               ACBrNFe1.DANFE.NFeCancelada := wNFeCancelada;
               ACBrNFe1.NotasFiscais.Clear;
               ACBrNFe1.NotasFiscais.LoadFromFile(wArquivo);

               if wPDF then
                  ACBrNFe1.NotasFiscais.ImprimirPDF
               else
                  ACBrNFe1.NotasFiscais.Imprimir;
            except on
               EXC:Exception do
               begin
                  MessageDlg('Erro:'+sLineBreak+sLineBreak+
                             exc.message,mtError,[mbOk],0);
               end;
            end;
         end;                        end;
   end;

   Timer1.Enabled:=True;
end;

procedure Tfrm_danfe.Timer1Timer(Sender: TObject);
begin
   Close;
end;

function Tfrm_danfe.VersaoExecutavel(lExeName: string): String;
type
  PFFI = ^vs_FixedFileInfo;
var
  F       : PFFI;
  Handle  : Dword;
  Len     : Longint;
  Data    : Pchar;
  Buffer  : Pointer;
  Tamanho : Dword;
  Parquivo: Pchar;
  Arquivo : String;
begin
  Arquivo  := lExeName;
  if FileExists(Arquivo) then
  begin
    Parquivo := StrAlloc(Length(Arquivo) + 1);
    StrPcopy(Parquivo, Arquivo);
    Len := GetFileVersionInfoSize(Parquivo, Handle);
    Result := '';
    if Len > 0 then
    begin
      Data:=StrAlloc(Len+1);
      if GetFileVersionInfo(Parquivo,Handle,Len,Data) then
      begin
        VerQueryValue(Data, '',Buffer,Tamanho);
        F := PFFI(Buffer);
        Result := Format('%d.%d.%d.%d',
                        [HiWord(F^.dwFileVersionMs),
                         LoWord(F^.dwFileVersionMs),
                         HiWord(F^.dwFileVersionLs),
                         Loword(F^.dwFileVersionLs)]
                        );
      end;
      StrDispose(Data);
    end;
    StrDispose(Parquivo);
  end
  else
    raise Exception.Create('Arquivo '+Arquivo+' não encontrado.');
end;

end.
