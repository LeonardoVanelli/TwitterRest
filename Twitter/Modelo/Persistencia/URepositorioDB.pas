unit URepositorioDB;

interface

uses
    SqlExpr
  , URepositorio
  , UEntidade
  , Generics.Collections
  ;

type
  TRepositorioDB<T: TENTIDADE, constructor> = class(TInterfacedObject, IRepositorio<T>)
  private
    FNomeTabela: String;
    FNomeCampoPK: String;
    FNomeGerador: String;
    FNomeEntidade: String;

    //Pede para o generator o proximo ID ao fazer insert
    function RetornaNovoId: Integer;

  protected
    FID: Integer;
    FEntidadeClasse: TEntidadeClasse;
    FSQLInsert: TSQLQuery;
    FSQLDelete: TSQLQuery;
    FSQLUpdate: TSQLQuery;
    FSQLSelect: TSQLDataSet;
    FSQLTable: TSQLTable;

  protected
    //Prepara na query o comando SQL para fazer o insert
    procedure PreparaInsercao;
    //Excuta a query de inserção
    procedure ExecutaInsercao;
    //Prepara na query o comando SQL para fazer o update
    procedure PreparaAtualizacao;
    //Executa a query de atualização
    procedure ExecutaAtualizacao(const ciPK: Integer);
    //Atribui os dados do banco no objeto
    procedure AtribuiDBParaEntidade(const coENTIDADE: T); virtual;
    //Atribui os dados do objeto no banco
    procedure AtribuiEntidadeParaDB(const coENTIDADE: T;
                                    const coSQLQuery: TSQLQuery); virtual;

    //Retorna uma string formada para insert ou update com todos os campos da tabela
    //carregados dinamicamente
    function RetornaParametros(const csFormatacao: String): String;

  public
    constructor Create(const coEntidadeClasse: TEntidadeClasse;
                       const csNomeTabela: String;
                       const csNomeCampoPK: String;
                       const csNomeEntidade: String);
    destructor Destroy; override;

    //Excluir o registro pela PK
    procedure Exclui(const ciPK: Integer);
    //Atualiza o registro com os dados do objeto
    procedure Atualiza(const coENTIDADE: T);
    //Insere um novo registro com os dados do objeto
    procedure Insere(const coENTIDADE: T);

    //Docs TO-DO
    function Retorna(const ciId: Integer): TENTIDADE;
    //Docs TO-DO
    function RetornaTodos: TList<T>;
    //Docs TO-DO
    function Achou(const ciPK: Integer): Boolean;

    property NOME_ENTIDADE: String read FNomeEntidade;
  end;

const
  CNT_SELECT_ALL        = 'select * from %s order by %s';
  CNT_SELECT_UNIQUE     = 'select * from %s where %s = :%1:s';
  CNT_SELECT_GEN_ID     = 'select gen_id(%s, 1) from RDB$DATABASE';
  CNT_INSERT            = 'insert into %s values (%s)';
  CNT_NOME_GERADOR      = 'gen_%s_%s';
  CNT_UPDATE            = 'update %s set %s where %s = :%2:s';
  CNT_DELETE            = 'delete from %s where %s = :%1:s';

  FLD_METADADOS_NOME_COLUNA = 'column_name';
  FLD_GEN_ID                = 'gen_id';

  //Tem como fazer generico
  CNT_FORMATACAO_INSERT = ':%s, ';
  CNT_FORMATACAO_UPDATE = '%0:s = :%0:s, ';

implementation

uses
    UDM
  , SysUtils
  , DB
  ;

{ TPersisteDB }

constructor TRepositorioDB<T>.Create(const coEntidadeClasse: TEntidadeClasse;
                                     const csNomeTabela: String;
                                     const csNomeCampoPK: String;
                                     const csNomeEntidade: String);
begin
  Inherited Create;
  FEntidadeClasse := coEntidadeClasse;
  FNomeTabela     := csNomeTabela;
  FNomeCampoPK    := csNomeCampoPK;
  FNomeEntidade   := csNomeEntidade;
  FNomeGerador    := Format(CNT_NOME_GERADOR, [csNomeTabela, csNomeCampoPK]);

  FSQLInsert               := TSQLQuery.Create(UDM.dmEntra21);
  FSQLInsert.SQLConnection := dmEntra21.SQLConnection;

  FSQLDelete               := TSQLQuery.Create(UDM.dmEntra21);
  FSQLDelete.SQLConnection := dmEntra21.SQLConnection;

  FSQLUpdate               := TSQLQuery.Create(UDM.dmEntra21);
  FSQLUpdate.SQLConnection := dmEntra21.SQLConnection;

  FSQLSelect               := TSQLDataSet.Create(UDM.dmEntra21);
  FSQLSelect.SQLConnection := dmEntra21.SQLConnection;

  FSQLTable                := TSQLTable.Create(UDM.dmEntra21);
  FSQLTable.SQLConnection  := dmEntra21.SQLConnection;
end;

destructor TRepositorioDB<T>.Destroy;
begin
  FreeAndNil(FSQLInsert);
  FreeAndNil(FSQLDelete);
  FreeAndNil(FSQLUpdate);
  FreeAndNil(FSQLSelect);
  FreeAndNil(FSQLTable);
  inherited;
end;

function TRepositorioDB<T>.Achou(const ciPK: Integer): Boolean;
begin
  FSQLSelect.Close;
  //select *
  //  from 'nome da tabela'
  // where 'campo PK' = :'campo PK'
  FSQLSelect.CommandText := Format(CNT_SELECT_UNIQUE, [FNomeTabela
                                                     , FNomeCampoPK]);
  FSQLSelect.ParamByName(FNomeCampoPK).AsInteger := ciPK;
  FSQLSelect.Open;

  Result := Not FSQLSelect.Eof;
end;

procedure TRepositorioDB<T>.Exclui(const ciPK: Integer);
begin
  dmEntra21.ValidaTransacaoAtiva;

  FSQLDelete.Close;
  FSQLDelete.SQL.Clear;
  FSQLDelete.SQL.Add(Format(CNT_DELETE, [FNomeTabela
                                                   , FNomeCampoPK]));
  FSQLDelete.Prepared := True;
  FSQLDelete.ParamByName(FNomeCampoPK).AsInteger := ciPK;
  FSQLDelete.ExecSQL;
end;

procedure TRepositorioDB<T>.ExecutaAtualizacao(const ciPK: Integer);
begin
  FSQLUpdate.ParamByName(FNomeCampoPK).AsInteger := ciPK;
  FSQLUpdate.ExecSQL;
end;

procedure TRepositorioDB<T>.ExecutaInsercao;
begin
  FSQLInsert.ExecSQL;
end;

procedure TRepositorioDB<T>.PreparaAtualizacao;
begin
  FSQLUpdate.Close;

  //update 'nome da tabela'
  //   set 'nome dos campos'
  // where 'campo PK' = :'campo PK'
  FSQLUpdate.SQL.Clear;
  FSQLUpdate.SQL.Add(Format(CNT_UPDATE, [FNomeTabela
                                       , RetornaParametros(CNT_FORMATACAO_UPDATE)
                                       , FNomeCampoPK]));
  FSQLUpdate.Prepared := True;
end;

procedure TRepositorioDB<T>.PreparaInsercao;
begin
  FID := RetornaNovoId;

  //insert into 'nome da tabela' values ('valores dos campos')
  FSQLInsert.Close;
  FSQLInsert.SQL.Clear;
  FSQLInsert.SQL.Add(Format(CNT_INSERT, [FNomeTabela
                                       , RetornaParametros(CNT_FORMATACAO_INSERT)
                                       , FNomeCampoPK]));
  FSQLInsert.Prepared := True;
end;

function TRepositorioDB<T>.RetornaParametros(const csFormatacao: String): String;
var
  lsNomeCampo: String;
  loCampo: TField;
begin
  Result := EmptyStr;

  FSQLTable.GetMetadata := True;
  FSQLTable.TableName := FNomeTabela;
  FSQLTable.Active := True;

  for loCampo in FSQLTable.Fields do
    begin
      lsNomeCampo := loCampo.FieldName;
      Result      := Result + Format(csFormatacao, [lsNomeCampo]);
    end;

  Result := Copy(Result, 1, Length(Result) -2);
end;

function TRepositorioDB<T>.RetornaTodos: TList<T>;
var
  ENTIDADE: T;
begin
  FSQLSelect.Close;
  FSQLSelect.CommandText := Format(CNT_SELECT_ALL, [FNomeTabela, FNomeCampoPK]);
  FSQLSelect.Open;

  Result := TList<T>.Create;
  while not FSQLSelect.Eof do
    begin
      ENTIDADE := T.Create;
      AtribuiDBParaEntidade(ENTIDADE);
      Result.Add(ENTIDADE);

      FSQLSelect.Next;
    end;
end;

function TRepositorioDB<T>.RetornaNovoId: Integer;
begin
  FSQLSelect.Close;
  FSQLSelect.CommandText := Format(CNT_SELECT_GEN_ID, [FNomeGerador]);
  FSQLSelect.Open;

  Result := FSQLSelect.FieldByName(FLD_GEN_ID).AsInteger;
end;

procedure TRepositorioDB<T>.Insere(const coENTIDADE: T);
begin
  PreparaInsercao;
  AtribuiEntidadeParaDB(coENTIDADE, FSQLInsert);
  ExecutaInsercao;

  coENTIDADE.ID := FID;
end;

procedure TRepositorioDB<T>.AtribuiDBParaEntidade(const coENTIDADE: T);
begin
  coENTIDADE.ID := FSQLSelect.FieldByName(FLD_ENTIDADE_ID).AsInteger;
end;

procedure TRepositorioDB<T>.AtribuiEntidadeParaDB(const coENTIDADE: T;
                                                  const coSQLQuery: TSQLQuery);
begin
  coSQLQuery.ParamByName(FLD_ENTIDADE_ID).AsInteger := FID;
end;

procedure TRepositorioDB<T>.Atualiza(const coENTIDADE: T);
begin
  FID := coENTIDADE.ID;

  PreparaAtualizacao;
  AtribuiEntidadeParaDB(coENTIDADE, FSQLUpdate);
  ExecutaAtualizacao(coENTIDADE.ID);
end;

function TRepositorioDB<T>.Retorna(const ciId: Integer): TENTIDADE;
begin
  Result := nil;
  if Achou(ciId) then
    begin
      Result := FEntidadeClasse.Create;
      AtribuiDBParaEntidade(Result);
    end;
end;

end.
