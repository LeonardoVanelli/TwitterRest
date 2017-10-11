unit URepositorioProdutoDB;

interface

uses
    UProduto
  , UEntidade
  , URepositorioDB
  , SqlExpr
  ;

type
  TRepositorioProdutoDB = class(TRepositorioDB<TMEDICAMENTO>)
  protected
    procedure AtribuiDBParaEntidade(const coCLIENTE: TMEDICAMENTO); override;
    procedure AtribuiEntidadeParaDB(const coCLIENTE: TMEDICAMENTO;
                                    const coSQLQuery: TSQLQuery); override;
  public
    constructor Create;
  end;

implementation

uses
  UDM
  , sysUtils
  ;

{ TRepositorioClienteDB }

constructor TRepositorioProdutoDB.Create;
begin
  inherited Create(TMEDICAMENTO, TBL_PRODUTO, FLD_ENTIDADE_ID, STR_PRODUTO);
end;

procedure TRepositorioProdutoDB.AtribuiDBParaEntidade(const coCLIENTE: TMEDICAMENTO);
begin
  inherited;
  with FSQLSelect do
    begin
      coCLIENTE.PRINCIPIO_ATIVO     := FieldByName(FLD_PRODUTO_PRINCIPIO_ATIVO).AsString;
      coCLIENTE.CNPJ                := FieldByName(FLD_PRODUTO_CNPJ).AsString;
      coCLIENTE.LABORATORIO         := FieldByName(FLD_PRODUTO_LABORATORIO).AsString;
      coCLIENTE.CODGREM             := FieldByName(FLD_PRODUTO_CODGREM).AsString;
      coCLIENTE.EAN                 := FieldByName(FLD_PRODUTO_EAN).AsString;
      coCLIENTE.NOME                := FieldByName(FLD_PRODUTO_NOME).AsString;
      coCLIENTE.APRESENTACAO        := FieldByName(FLD_PRODUTO_APRESENTACAO).AsString;
      coCLIENTE.PRECOFAB            := FieldByName(FLD_PRODUTO_PRECOFAB).AsString;
      coCLIENTE.PRECOCOMERCIAL      := FieldByName(FLD_PRODUTO_PRECOCOMERCIAL).AsString;
      coCLIENTE.RESTRICAOHOSPITALAR := FieldByName(FLD_PRODUTO_RESTRICAOHOSPITALAR).AsString;
    end;
end;

procedure TRepositorioProdutoDB.AtribuiEntidadeParaDB(const coCLIENTE: TMEDICAMENTO;
  const coSQLQuery: TSQLQuery);
begin
  inherited;
  with coSQLQuery do
    begin
      ParamByName(FLD_PRODUTO_PRINCIPIO_ATIVO).AsString     := coCLIENTE.PRINCIPIO_ATIVO;
      ParamByName(FLD_PRODUTO_CNPJ).AsString                := coCLIENTE.CNPJ;
      ParamByName(FLD_PRODUTO_LABORATORIO).AsString         := coCLIENTE.LABORATORIO;
      ParamByName(FLD_PRODUTO_CODGREM).AsString             := coCLIENTE.CODGREM;
      ParamByName(FLD_PRODUTO_EAN).AsString                 := coCLIENTE.EAN;
      ParamByName(FLD_PRODUTO_NOME).AsString                := coCLIENTE.NOME;
      ParamByName(FLD_PRODUTO_APRESENTACAO).AsString        := coCLIENTE.APRESENTACAO;
      ParamByName(FLD_PRODUTO_PRECOFAB).AsString            := coCLIENTE.PRECOFAB;
      ParamByName(FLD_PRODUTO_PRECOCOMERCIAL).AsString      := coCLIENTE.PRECOCOMERCIAL;
      ParamByName(FLD_PRODUTO_RESTRICAOHOSPITALAR).AsString := coCLIENTE.RESTRICAOHOSPITALAR;

    end;
end;

end.
