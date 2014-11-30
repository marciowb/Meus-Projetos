unit uNFSe;

interface
   uses
       MinhasClasses, uSQLERP,Comandos,Classes,SysUtils, Math,DB,pFIBClientDataSet,
       StrUtils,ulibERP, DateUtils, Generics.Collections,uDocumentoFiscal;
   type
     TNFSe = class
     Private
       FDoc: IDocumentoFiscal;
       Function GeraArquivo: TRetorno;
     public
       constructor Create(Const Doc: TDocumentoFiscal);
       Function Enviar: TRetorno;
     end;
implementation

{ TNFSe }

constructor TNFSe.Create(Const Doc: TDocumentoFiscal);
begin
  FDoc := Doc;


end;

function TNFSe.Enviar: TRetorno;
begin

end;

function TNFSe.GeraArquivo: TRetorno;
begin
   Try
     Result.Erro := False;
   Except
     on e: Exception do
     begin
       result.Erro := True;
       Result.Mensagem := E.Message;
     end;
   End;
end;

end.
