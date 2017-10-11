unit URepositorioMedicamentoDB;

interface

uses
    UProduto
  , UEntidade
  , URepositorioDB
  , SqlExpr
  ;

type
  TRepositorioMedicamento = class(TRepositorioDB<TMEDICAMENTO>)
  protected
    procedure AtribuiDBParaEntidade(const coMEDICAMENTO: TMEDICAMENTO); override;
    procedure AtribuiEntidadeParaDB(const coMEDICAMENTO: TMEDICAMENTO;
                                    const coSQLQuery: TSQLQuery); override;
  public
    constructor Create;
  end;

implementation

uses
    UDM
  , SysUtils
  , UUtilitarios
  ;

const
  CNT_SELECT_NOME = 'select * from medicamento where codigo = :codigo';

{ TRepositorioMedicamento }

procedure TRepositorioMedicamento.AtribuiDBParaEntidade(
  const coMEDICAMENTO: TMEDICAMENTO);
begin
  inherited;
  with FSQLSelect do
    begin
      coMEDICAMENTO.PRINCIPIO_ATIVO    := FieldByName(FLD_PRODUTO_PRINCIPIO_ATIVO).AsString;
      coMEDICAMENTO.CNPJ               := FieldByName(FLD_PRODUTO_CNPJ).AsString;
      coMEDICAMENTO.LABORATORIO        := FieldByName(FLD_PRODUTO_LABORATORIO).AsString;
      coMEDICAMENTO.CODGREM            := FieldByName(FLD_PRODUTO_CODGREM).AsString;
      coMEDICAMENTO.EAN                := FieldByName(FLD_PRODUTO_EAN).AsString;
      coMEDICAMENTO.NOME               := FieldByName(FLD_PRODUTO_NOME).AsString;
      coMEDICAMENTO.APRESENTACAO       := FieldByName(FLD_PRODUTO_APRESENTACAO).AsString;
      coMEDICAMENTO.PRECOFAB           := FieldByName(FLD_PRODUTO_PRECOFAB).AsString;
      coMEDICAMENTO.PRECOCOMERCIAL     := FieldByName(FLD_PRODUTO_PRECOCOMERCIAL).AsString;
      coMEDICAMENTO.RESTRICAOHOSPITALAR:= FieldByName(FLD_PRODUTO_RESTRICAOHOSPITALAR).AsStrING;
    end;
end;

procedure TRepositorioMedicamento.AtribuiEntidadeParaDB(
  const coMEDICAMENTO: TMEDICAMENTO; const coSQLQuery: TSQLQuery);
begin
  inherited;
  with coSQLQuery do
    begin
      FieldByName(FLD_PRODUTO_PRINCIPIO_ATIVO)    .AsString := coMEDICAMENTO.PRINCIPIO_ATIVO;
      FieldByName(FLD_PRODUTO_CNPJ)               .AsString := coMEDICAMENTO.CNPJ;
      FieldByName(FLD_PRODUTO_LABORATORIO)        .AsString := coMEDICAMENTO.LABORATORIO;
      FieldByName(FLD_PRODUTO_CODGREM)            .AsString := coMEDICAMENTO.CODGREM;
      FieldByName(FLD_PRODUTO_EAN)                .AsString := coMEDICAMENTO.EAN;
      FieldByName(FLD_PRODUTO_NOME)               .AsString := coMEDICAMENTO.NOME;
      FieldByName(FLD_PRODUTO_APRESENTACAO)       .AsString := coMEDICAMENTO.APRESENTACAO;
      FieldByName(FLD_PRODUTO_PRECOFAB)           .AsString := coMEDICAMENTO.PRECOFAB;
      FieldByName(FLD_PRODUTO_PRECOCOMERCIAL)     .AsString := coMEDICAMENTO.PRECOCOMERCIAL;
      FieldByName(FLD_PRODUTO_RESTRICAOHOSPITALAR).AsString := coMEDICAMENTO.RESTRICAOHOSPITALAR;
    end;
end;

constructor TRepositorioMedicamento.Create;
begin
  inherited Create(TMEDICAMENTO, TBL_PRODUTO, FLD_ENTIDADE_ID, STR_PRODUTO);
end;

end.
