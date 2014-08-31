unit uSplash;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFormPadrao_Pan, JvExControls, JvEnterTab, jpeg, cxImage, cxControls,
  cxContainer, cxEdit, cxProgressBar, DB, DBClient, ZSqlProcessor,Registry,
  ExtCtrls;

type
  TfrmSplash = class(TfrmPadrao)
    pbDetalhe: TcxProgressBar;
    cxImage1: TcxImage;
    Cds: TClientDataSet;
    Script: TZSQLProcessor;
    pbMaster: TcxProgressBar;
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Procedure VerificaTabelas;
    Procedure VerificaCampos;
    Function AddCampo(Campo , Tabela : String ; Tipo : String ) : String;
    Procedure Entra;
  end;

var
  frmSplash: TfrmSplash;

implementation

uses Comandos_Pan, uDMConexao_Pan;

{$R *.dfm}

{ TfrmSplash }

function TfrmSplash.AddCampo(Campo, Tabela, Tipo: String): String;
begin
  Result := ' ALTER TABLE '+Tabela+' ADD '+Campo +'  '+ Tipo;
end;

procedure TfrmSplash.Entra;
label Update;
var
  Reg : TRegistry;
  versao : String;
begin
    Application.BringToFront;
    
    Reg := TRegistry.Create;
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    Reg.OpenKey('Software\Pan' , True);

    if Reg.ReadString('Versão') = '' then
    Begin
      Reg.WriteString('Versão', GetBuildInfo(True, Application.ExeName));
      goto Update;
    End else
    Begin
      if Reg.ReadString('Versão') = GetBuildInfo(True, Application.ExeName) then
        Exit
      else
      Begin
         Update:
         pbDetalhe.Visible := True;
         pbMaster.Visible := True;
         pbMaster.Position := 50;
         Repaint;
         VerificaTabelas;
         pbMaster.Position := 80;
         Repaint;
         VerificaCampos;
         Reg.WriteString('Versão', GetBuildInfo(True, Application.ExeName));
         pbMaster.Position := 100;
         Repaint;
      End;

    End;
   FreeAndNil(Reg);

end;

procedure TfrmSplash.VerificaCampos;
var
  StrSQL : String;
  CdsTabela : TClientDataSet;
begin
  Try
    CdsTabela := TClientDataSet.Create(Self);
    try
      StartTrans;   { TODO : rever }
      pbDetalhe.Position := 20;
      {$Region 'Classerisco'}
        StrSQL :=
          'SELECT COLUMN_NAME FIELD '+
          '  FROM INFORMATION_SCHEMA.COLUMNS '+
          ' WHERE table_name = ''classerisco''   '+
          '   AND table_schema = ''PAN''  ';
        Atu_Cds(CdsTabela, StrSQL) ;
        if not CdsTabela.Locate('FIELD','CLASSE', [])  then
        Begin
          Exec_SQL(AddCampo('CLASSE','classerisco ', 'char(5) character set latin1 default NULL' ));
        End;

      {$ENdRegion}
      pbDetalhe.Position := 40;
      {$Region 'cliente'}
        StrSQL :=
          'SELECT COLUMN_NAME FIELD '+
          '  FROM INFORMATION_SCHEMA.COLUMNS '+
          ' WHERE table_name = ''cliente''   '+
          '   AND table_schema = ''PAN''  ';

        Atu_Cds(CdsTabela, StrSQL) ;
        if not CdsTabela.Locate('FIELD','NOMECLIENTE', [])  then
        Begin
          Exec_SQL(AddCampo('NOMECLIENTE','cliente ', 'varchar(50) default NULL' ));
        End;

        if not CdsTabela.Locate('FIELD','CODIGO', [])  then
        Begin
          Exec_SQL(AddCampo('CODIGO','cliente ', 'char(10) character set latin1 default NULL' ));
        End;

      {$ENdRegion}
      pbDetalhe.Position := 60;
      {$Region 'produto'}
        StrSQL :=
          'SELECT COLUMN_NAME FIELD '+
          '  FROM INFORMATION_SCHEMA.COLUMNS '+
          ' WHERE table_name = ''produto''   '+
          '   AND table_schema = ''PAN''  ';
        Atu_Cds(CdsTabela, StrSQL) ;
        if not CdsTabela.Locate('FIELD','UNIDADE', [])  then
        Begin
          Exec_SQL(AddCampo('UNIDADE','produto ', 'varchar(10) default NULL' ));
        End;

        if not CdsTabela.Locate('FIELD','NUMONU', [])  then
        Begin
          Exec_SQL(AddCampo('NUMONU','produto ', 'int(11) default NULL' ));
        End;

        if not CdsTabela.Locate('FIELD','DIASVALIDADE', [])  then
        Begin
          Exec_SQL(AddCampo('DIASVALIDADE','produto ', 'int(11) default NULL' ));
        End;
      {$ENdRegion}
      pbDetalhe.Position := 80;
      {$Region 'saida'}
        StrSQL :=
          'SELECT COLUMN_NAME FIELD '+
          '  FROM INFORMATION_SCHEMA.COLUMNS '+
          ' WHERE table_name = ''saida''   '+
          '   AND table_schema = ''PAN''  ';
        Atu_Cds(CdsTabela, StrSQL) ;
        
        if not CdsTabela.Locate('FIELD','DATA', [])  then
        Begin
          Exec_SQL(AddCampo('DATA','saida ', 'date NOT NULL' ));
        End;

        if not CdsTabela.Locate('FIELD','HORA', [])  then
        Begin
          Exec_SQL(AddCampo('HORA','saida ', 'time NOT NULL' ));
        End;

        if not CdsTabela.Locate('FIELD','LOTE', [])  then
        Begin
          Exec_SQL(AddCampo('LOTE','saida ', 'char(20) character set latin1 default NULL' ));
        End;

        if not CdsTabela.Locate('FIELD','PESOLIQUIDO', [])  then
        Begin
          Exec_SQL(AddCampo('PESOLIQUIDO','saida ', 'float(15,6) default NULL' ));
        End;

        if not CdsTabela.Locate('FIELD','PESOBRUTO', [])  then
        Begin
          Exec_SQL(AddCampo('PESOBRUTO','saida ', 'float(15,6) default NULL' ));
        End;

        if not CdsTabela.Locate('FIELD','FABRICACAO', [])  then
        Begin
          Exec_SQL(AddCampo('FABRICACAO','saida ', 'date default NULL' ));
        End;
      
        if not CdsTabela.Locate('FIELD','VALIDADE', [])  then
        Begin
          Exec_SQL(AddCampo('VALIDADE','saida ', 'date default NULL' ));
        End;

        if not CdsTabela.Locate('FIELD','NUMONU', [])  then
        Begin
          Exec_SQL(AddCampo('NUMONU','saida ', 'int(11) default NULL' ));
        End;

        if not CdsTabela.Locate('FIELD','IDCLIENTE', [])  then
        Begin
          Exec_SQL(AddCampo('IDCLIENTE','saida ', 'int(11) NOT NULL' ));
        End;

        if not CdsTabela.Locate('FIELD','IDPRODUTO', [])  then
        Begin
          Exec_SQL(AddCampo('IDPRODUTO','saida ', 'int(11) NOT NULL' ));
        End;

        if not CdsTabela.Locate('FIELD','IDCLASSERISCO', [])  then
        Begin
          Exec_SQL(AddCampo('IDCLASSERISCO','saida ', 'int(11) default NULL' ));
        End;

        if not CdsTabela.Locate('FIELD','IDTEXTOS', [])  then
        Begin
          Exec_SQL(AddCampo('IDTEXTOS','saida ', 'int(11) default NULL' ));
        End;

        if not CdsTabela.Locate('FIELD','TITULO1', [])  then
        Begin
          Exec_SQL(AddCampo('TITULO1','saida ', 'varchar(30) default NULL' ));
        End;

        if not CdsTabela.Locate('FIELD','TITULO2', [])  then
        Begin
          Exec_SQL(AddCampo('TITULO2','saida ', 'varchar(30) default NULL' ));
        End;

        if not CdsTabela.Locate('FIELD','TITULO3', [])  then
        Begin
          Exec_SQL(AddCampo('TITULO3','saida ', 'varchar(30) default NULL' ));
        End;

        if not CdsTabela.Locate('FIELD','TITULO4', [])  then
        Begin
          Exec_SQL(AddCampo('TITULO4','saida ', 'varchar(30) default NULL' ));
        End;

        if not CdsTabela.Locate('FIELD','TITULO5', [])  then
        Begin
          Exec_SQL(AddCampo('TITULO5','saida ', 'varchar(30) default NULL' ));
        End;

        if not CdsTabela.Locate('FIELD','TITULO6', [])  then
        Begin
          Exec_SQL(AddCampo('TITULO6','saida ', 'varchar(30) default NULL' ));
        End;

        if not CdsTabela.Locate('FIELD','TEXTO1', [])  then
        Begin
          Exec_SQL(AddCampo('TEXTO1','saida ', 'text character set latin1' ));
        End;

        if not CdsTabela.Locate('FIELD','TEXTO2', [])  then
        Begin
          Exec_SQL(AddCampo('TEXTO2','saida ', 'text character set latin1' ));
        End;

        if not CdsTabela.Locate('FIELD','TEXTO3', [])  then
        Begin
          Exec_SQL(AddCampo('TEXTO3','saida ', 'text character set latin1' ));
        End;

        if not CdsTabela.Locate('FIELD','TEXTO4', [])  then
        Begin
          Exec_SQL(AddCampo('TEXTO4','saida ', 'text character set latin1' ));
        End;

        if not CdsTabela.Locate('FIELD','TEXTO5', [])  then
        Begin
          Exec_SQL(AddCampo('TEXTO5','saida ', 'text character set latin1' ));
        End;

        if not CdsTabela.Locate('FIELD','TEXTO6', [])  then
        Begin
          Exec_SQL(AddCampo('TEXTO6','saida ', 'text character set latin1' ));
        End;        


      {$ENdRegion}
      pbDetalhe.Position := 100;
      Commit;
    except
      on E: Exception do
      Begin
        RollBack;
        Raise;
      End;
    end;

  Finally
    FreeAndNil(CdsTabela );
  End;


end;

procedure TfrmSplash.VerificaTabelas;
var
  StrSQL : String;
begin
  StrSQL := 'show tables in Pan';
  Atu_Cds(Cds, StrSQL);
  pbDetalhe.Position := 10;
  Repaint;
  if not Cds.Locate('Tables_in_pan', 'classerisco',[]) then
  Begin
    StrSQL :=
        ' SET @saved_cs_client     = @@character_set_client;'+
        ' SET character_set_client = utf8; '+
        ' CREATE TABLE `classerisco` (  '+
        '                `IDCLASSERISCO` int(10) NOT NULL auto_increment, '+
        '                `CLASSE` char(5) character set latin1 default NULL, '+
        '                PRIMARY KEY  (`IDCLASSERISCO`) '+
        '              ) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8; '+
        '              SET character_set_client = @saved_cs_client; '+
        '  LOCK TABLES `classerisco` WRITE; '+
        '     /*!40000 ALTER TABLE `classerisco` DISABLE KEYS */; '+
        '    /*!40000 ALTER TABLE `classerisco` ENABLE KEYS */;  '+
        '  UNLOCK TABLES; ';
    Try
      StartTrans;
      Script.Clear;
      Script.Script.Add(StrSQL);
      Script.Execute;
      Commit;
    Except
      on e: Exception do
      Begin
        RollBack;
        Raise;
      End;

    End;
  End;

  pbDetalhe.Position := 20;
  Repaint;
  if not Cds.Locate('Tables_in_pan', 'cliente',[]) then
  Begin
    StrSQL :=
        'SET @saved_cs_client     = @@character_set_client;  '+
        'SET character_set_client = utf8; '+
        '      CREATE TABLE `cliente` (    '+
        '        `IDCLIENTE` smallint(5) unsigned NOT NULL auto_increment, '+
        '        `NOMECLIENTE` varchar(50) default NULL, '+
        '        `CODIGO` char(10) character set latin1 default NULL,'+
        '        PRIMARY KEY  (`IDCLIENTE`)'+
        '      ) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;'+
        '      SET character_set_client = @saved_cs_client; '+
        '  LOCK TABLES `classerisco` WRITE; '+
        '     /*!40000 ALTER TABLE `classerisco` DISABLE KEYS */; '+
        '    /*!40000 ALTER TABLE `classerisco` ENABLE KEYS */;  '+
        '  UNLOCK TABLES; ';
    Try
      StartTrans;
      Script.Clear;
      Script.Script.Add(StrSQL);
      Script.Execute;
      Commit;
    Except
      on e: Exception do
      Begin
        RollBack;
        Raise;
      End;

    End;
  End;

  pbDetalhe.Position := 40;
  Repaint;
  if not Cds.Locate('Tables_in_pan', 'produto',[]) then
  Begin
    StrSQL :=
        'SET @saved_cs_client     = @@character_set_client;  '+
        'SET character_set_client = utf8; '+
        '      CREATE TABLE `produto` (               '+
        '                  `IDPRODUTO` int(10) unsigned NOT NULL auto_increment, '+
        '                  `CODIGO` char(10) character set latin1 default NULL,  '+
        '                  `NOMEPRODUTO` varchar(200) default NULL, '+
        '                  `UNIDADE` varchar(10) default NULL, '+
        '                  `NUMONU` int(11) default NULL, '+
        '                  `DIASVALIDADE` int(11) default NULL, '+
        '                  PRIMARY KEY  (`IDPRODUTO`) '+
        '                ) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8; '+
        '                SET character_set_client = @saved_cs_client; '+
        '  LOCK TABLES `classerisco` WRITE; '+
        '     /*!40000 ALTER TABLE `classerisco` DISABLE KEYS */; '+
        '    /*!40000 ALTER TABLE `classerisco` ENABLE KEYS */;  '+
        '  UNLOCK TABLES; ';
    Try
      StartTrans;
      Script.Clear;
      Script.Script.Add(StrSQL);
      Script.Execute;
      Commit;
    Except
      on e: Exception do
      Begin
        RollBack;
        Raise;
      End;

    End;
  End;

  pbDetalhe.Position := 60;
  Repaint;
  if not Cds.Locate('Tables_in_pan', 'saida',[]) then
  Begin
    StrSQL :=
        'SET @saved_cs_client     = @@character_set_client;  '+
        'SET character_set_client = utf8; '+
        '      CREATE TABLE `saida` (  '+
        '          `IDSAIDA` int(10) unsigned NOT NULL auto_increment,  '+
        '          `DATA` date NOT NULL,   '+
        '          `HORA` time NOT NULL,    '+
        '          `LOTE` char(20) character set latin1 default NULL,    '+
        '          `PESOLIQUIDO` float(15,6) default NULL,  '+
        '          `PESOBRUTO` float(15,6) default NULL,   '+
        '          `FABRICACAO` date default NULL,       '+
        '          `VALIDADE` date default NULL,    '+
        '          `NUMONU` int(11) default NULL,   '+
        '          `IDCLIENTE` int(11) NOT NULL,    '+
        '          `IDPRODUTO` int(11) NOT NULL,   '+
        '          `IDCLASSERISCO` int(11) default NULL,     '+
        '          `IDTEXTOS` int(11) default NULL,   '+
        '          `TITULO1` varchar(30) default NULL,   '+
        '          `TEXTO1` text character set latin1,   '+
        '          `TITULO2` varchar(30) default NULL,   '+
        '          `TEXTO2` text character set latin1,   '+
        '          `TITULO3` varchar(30) default NULL,  '+
        '          `TEXTO3` text character set latin1,  '+
        '          `TITULO4` varchar(30) default NULL,  '+
        '          `TEXTO4` text character set latin1,   '+
        '          `TITULO5` varchar(30) default NULL,   '+
        '          `TEXTO5` text character set latin1,   '+
        '          `TITULO6` varchar(30) default NULL,    '+
        '          `TEXTO6` text character set latin1,   '+
        '          PRIMARY KEY  (`IDSAIDA`)         '+
        '        ) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;  '+
        '        SET character_set_client = @saved_cs_client;'+
        '  LOCK TABLES `classerisco` WRITE; '+
        '     /*!40000 ALTER TABLE `classerisco` DISABLE KEYS */; '+
        '    /*!40000 ALTER TABLE `classerisco` ENABLE KEYS */;  '+
        '  UNLOCK TABLES; ';
    Try
      StartTrans;
      Script.Clear;
      Script.Script.Add(StrSQL);
      Script.Execute;
      Commit;
    Except
      on e: Exception do
      Begin
        RollBack;
        Raise;
      End;

    End;
  End;

  pbDetalhe.Position := 80;
  Repaint;
  if not Cds.Locate('Tables_in_pan', 'textos',[]) then
  Begin
    StrSQL :=
        'SET @saved_cs_client     = @@character_set_client;  '+
        'SET character_set_client = utf8; '+
        '      CREATE TABLE `textos` (   '+
        '            `IDTEXTOS` int(11) NOT NULL auto_increment,   '+
        '            `CODIGO` varchar(10) default NULL,                '+
        '            `DESCRICAO` varchar(40) default NULL,   '+
        '            `TITULO1` varchar(30) default NULL,   '+
        '            `TEXTO1` text character set latin1,   '+
        '            `TITULO2` varchar(30) default NULL,   '+
        '            `TEXTO2` text character set latin1,   '+
        '            `TITULO3` varchar(30) default NULL,   '+
        '            `TEXTO3` text character set latin1,      '+
        '            `TITULO4` varchar(30) default NULL,     '+
        '            `TEXTO4` text character set latin1,   '+
        '            `TITULO5` varchar(30) default NULL,   '+
        '            `TEXTO5` text character set latin1,   '+
        '            `TITULO6` varchar(30) default NULL,      '+
        '            `TEXTO6` text character set latin1,       '+
        '            PRIMARY KEY  (`IDTEXTOS`)   '+
        '          ) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;   '+
        '          SET character_set_client = @saved_cs_client;'+
        '  LOCK TABLES `classerisco` WRITE; '+
        '     /*!40000 ALTER TABLE `classerisco` DISABLE KEYS */; '+
        '    /*!40000 ALTER TABLE `classerisco` ENABLE KEYS */;  '+
        '  UNLOCK TABLES; ';
    Try
      StartTrans;
      Script.Clear;
      Script.Script.Add(StrSQL);
      Script.Execute;
      Commit;
    Except
      on e: Exception do
      Begin
        RollBack;
        Raise;
      End;

    End;
  End;
  pbDetalhe.Position := 100;
  Repaint;

end;

procedure TfrmSplash.FormActivate(Sender: TObject);
begin
  inherited;
  Application.ProcessMessages;
  pbDetalhe.Position := 0;
  pbMaster.Position := 0;
  Sleep(2000);
  Entra;
  Sleep(2000);
  PostMessage(Handle, WM_CLOSE,0,0);
end;

end.
