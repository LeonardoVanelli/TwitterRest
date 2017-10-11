unit URepositorioClienteDB;

interface

uses
    UCliente
  , UEntidade
  , URepositorioDB
  , SqlExpr
  , URepositorioMunicipioDB
  , UMunicipio
  ;

type
  TRepositorioClienteDB = class(TRepositorioDB<TCLIENTE>)
  private
    FRepositorioMunicipioDB : TRepositorioMunicipioDB;
  protected
    procedure AtribuiDBParaEntidade(const coCLIENTE: TCLIENTE); override;
    procedure AtribuiEntidadeParaDB(const coCLIENTE: TCLIENTE;
                                    const coSQLQuery: TSQLQuery); override;
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  UDM
  , sysUtils
  ;

{ TRepositorioClienteDB }

constructor TRepositorioClienteDB.Create;
begin
  inherited Create(TCLIENTE, TBL_CLIENTE, FLD_ENTIDADE_ID, STR_CLIENTE);
  FRepositorioMunicipioDB := TRepositorioMunicipioDB.Create;
end;

destructor TRepositorioClienteDB.Destroy;
begin
  FreeAndNil(FRepositorioMunicipioDB);
  inherited;
end;

procedure TRepositorioClienteDB.AtribuiDBParaEntidade(const coCLIENTE: TCLIENTE);
begin
  inherited;
  with FSQLSelect do
    begin
      coCLIENTE.NOME            := FieldByName(FLD_CLIENTE_NOME).AsString;
      coCLIENTE.CPF             := FieldByName(FLD_CLIENTE_CPF).AsString;
      coCLIENTE.DATA_NASCIMENTO := FieldByName(FLD_CLIENTE_DATA_NASCIMENTO).AsDateTime;
      coCLIENTE.ENDERECO        := FieldByName(FLD_CLIENTE_ENDERECO).AsString;
      coCLIENTE.COMPLEMENTO     := FieldByName(FLD_CLIENTE_COMPLEMENTO).AsString;
      coCLIENTE.NUMERO          := FieldByName(FLD_CLIENTE_NUMERO).AsInteger;
      coCLIENTE.BAIRRO          := FieldByName(FLD_CLIENTE_BAIRRO).AsString;
      coCLIENTE.CEP             := FieldByName(FLD_CLIENTE_CEP).AsString;
      coCLIENTE.EMAIL           := FieldByName(FLD_CLIENTE_EMAIL).AsString;
      coCLIENTE.TELEFONE        := FieldByName(FLD_CLIENTE_TELEFONE).AsString;
      coCLIENTE.CELULAR         := FieldByName(FLD_CLIENTE_CELULAR).AsString;
      coCLIENTE.RG              := FieldByName(FLD_CLIENTE_RG).AsString;
      coCLIENTE.RG_DATA_EMISSAO := FieldByName(FLD_CLIENTE_RG_DATA_EMISSAO).AsDateTime;
      coCLIENTE.RG_ORGAO_EMISSOR:= FieldByName(FLD_CLIENTE_RG_ORGAO_EMISSOR).AsString;

      coCLIENTE.MUNICIPIO := TMUNICIPIO(
        FRepositorioMunicipioDB.Retorna(FieldByName(FLD_CLIENTE_COD_MUNICIPIO).AsInteger));
    end;
end;

procedure TRepositorioClienteDB.AtribuiEntidadeParaDB(const coCLIENTE: TCLIENTE;
  const coSQLQuery: TSQLQuery);
begin
  inherited;
  with coSQLQuery do
    begin
      ParamByName(FLD_CLIENTE_NOME).AsString              := coCLIENTE.NOME;
      ParamByName(FLD_CLIENTE_CPF).AsString               := coCLIENTE.CPF;
      ParamByName(FLD_CLIENTE_DATA_NASCIMENTO).AsDateTime := coCLIENTE.DATA_NASCIMENTO;
      ParamByName(FLD_CLIENTE_ENDERECO).AsString          := coCLIENTE.ENDERECO;
      ParamByName(FLD_CLIENTE_COMPLEMENTO).AsString       := coCLIENTE.COMPLEMENTO;
      ParamByName(FLD_CLIENTE_NUMERO).AsInteger           := coCLIENTE.NUMERO;
      ParamByName(FLD_CLIENTE_BAIRRO).AsString            := coCLIENTE.BAIRRO;
      ParamByName(FLD_CLIENTE_CEP).AsString               := coCLIENTE.CEP;
      ParamByName(FLD_CLIENTE_COD_MUNICIPIO).AsInteger    := coCLIENTE.MUNICIPIO.ID;
      ParamByName(FLD_CLIENTE_EMAIL).AsString             := coCLIENTE.EMAIL;
      ParamByName(FLD_CLIENTE_TELEFONE).AsString          := coCLIENTE.TELEFONE;
      ParamByName(FLD_CLIENTE_CELULAR).AsString           := coCLIENTE.CELULAR;
      ParamByName(FLD_CLIENTE_RG).AsString                := coCLIENTE.RG;
      ParamByName(FLD_CLIENTE_RG_DATA_EMISSAO).AsDate     := coCLIENTE.RG_DATA_EMISSAO;
      ParamByName(FLD_CLIENTE_RG_ORGAO_EMISSOR).AsString  := coCLIENTE.RG_ORGAO_EMISSOR;
    end;
end;

end.
