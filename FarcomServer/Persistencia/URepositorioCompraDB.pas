unit URepositorioCompraDB;

interface

uses
    UCompra
  , UEntidade
  , URepositorioDB
  , URepositorioProdutoDB
  , SqlExpr
  , UProduto
  ;

type
  TRepositorioCompraDB = class(TRepositorioDB<TCOMPRA>)
  private
    FRepositorioProdutoDB : TRepositorioProdutoDB;
  protected
    procedure AtribuiDBParaEntidade(const coCLIENTE: TCOMPRA); override;
    procedure AtribuiEntidadeParaDB(const coCLIENTE: TCOMPRA;
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

constructor TRepositorioCompraDB.Create;
begin
  inherited Create(TCOMPRA, TBL_COMPRA, FLD_ENTIDADE_ID, STR_COMPRA);
  FRepositorioProdutoDB := TRepositorioProdutoDB.Create;
end;

destructor TRepositorioCompraDB.Destroy;
begin
  FreeAndNil(FRepositorioProdutoDB);
  inherited;
end;

procedure TRepositorioCompraDB.AtribuiDBParaEntidade(const coCLIENTE: TCOMPRA);
begin
  inherited;
  with FSQLSelect do
    begin
      coCLIENTE.VALOR_COMPRA     := FieldByName(FLD_COMPRA_VALOR_COMPRA).AsString;
      coCLIENTE.DATA_HORA_COMPRA := FieldByName(FLD_COMPRA_DATA_HORA_COMPRA).AsDateTime;

      coCLIENTE.PRODUTO := TMEDICAMENTO(
        FRepositorioProdutoDB.Retorna(FieldByName(FLD_COMPRA_COD_PRODUTO).AsInteger));
    end;
end;

procedure TRepositorioCompraDB.AtribuiEntidadeParaDB(const coCLIENTE: TCOMPRA;
  const coSQLQuery: TSQLQuery);
begin
  inherited;
  with coSQLQuery do
    begin
      ParamByName(FLD_COMPRA_COD_PRODUTO).AsInteger       := coCLIENTE.PRODUTO.ID;
      ParamByName(FLD_COMPRA_VALOR_COMPRA).AsString       := coCLIENTE.VALOR_COMPRA;
      ParamByName(FLD_COMPRA_DATA_HORA_COMPRA).AsDateTime := coCLIENTE.DATA_HORA_COMPRA;
    end;
end;

end.
