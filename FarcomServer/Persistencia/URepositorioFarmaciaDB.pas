unit URepositorioFarmaciaDB;

interface

uses
    UFarmacia
  , UEntidade
  , URepositorioDB
  , SqlExpr
  , UMunicipio
  , URepositorioMunicipioDB
  ;

type
  TRepositorioFarmaciaDB = class(TRepositorioDB<TFARMACIA>)
  private
    FRepositorioMunicipio : TRepositorioMunicipioDB;
  public
    constructor Create;

    procedure AtribuiDBParaEntidade(const coFARMACIA: TFARMACIA); override;
    procedure AtribuiEntidadeParaDB(const coFARMACIA: TFARMACIA;
                                    const coSQLQuery: TSQLQuery); override;
  end;

implementation

uses
  UDM
  ;

{ TRepositorioFarmaciaDB }

constructor TRepositorioFarmaciaDB.Create;
begin
  inherited Create(TFARMACIA, TBL_FARMACIA, FLD_ENTIDADE_ID, STR_FARMACIA);
  FRepositorioMunicipio := TRepositorioMunicipioDB.Create;
end;

procedure TRepositorioFarmaciaDB.AtribuiDBParaEntidade(const coFARMACIA: TFARMACIA);
begin
  inherited;
  with FSQLSelect do
  begin
  coFARMACIA.NOME            := FieldByName(FLD_FARMACIA_NOME).AsString;
  coFARMACIA.CNPJ            := FieldByName(FLD_FARMACIA_CNPJ).AsString;
  coFARMACIA.TELEFONE        := FieldByName(FLD_FARMACIA_TELEFONE).AsString;
  coFARMACIA.ENDERECO        := FieldByName(FLD_FARMACIA_ENDERECO).AsString;
  coFARMACIA.CEP             := FieldByName(FLD_FARMACIA_CEP).AsString;
  coFARMACIA.EMAIL           := FieldByName(FLD_FARMACIA_EMAIL).AsString;
  coFARMACIA.HORA_ABERTURA   := FieldByName(FLD_FARMACIA_HORA_ABERTURA).AsDateTime;
  coFARMACIA.HORA_FECHAMENTO := FieldByName(FLD_FARMACIA_HORA_FECHAMENTO).AsDateTime;
  coFARMACIA.KEY_FARMA       := FieldByName(FLD_FARMACIA_KEY_FARMA).AsString;

  coFARMACIA.MUNICIPIO := TMUNICIPIO(
    FRepositorioMunicipio.Retorna(FieldByName(FLD_FARMACIA_COD_MUNICIPIO).AsInteger));
  end;
end;

procedure TRepositorioFarmaciaDB.AtribuiEntidadeParaDB(const coFARMACIA: TFARMACIA;
  const coSQLQuery: TSQLQuery);
begin
  inherited;
  with coSQLQuery do
  begin
  ParamByName(FLD_FARMACIA_NOME).AsString              := coFARMACIA.NOME;
  ParamByName(FLD_FARMACIA_CNPJ).AsString              :=  coFARMACIA.CNPJ;
  ParamByName(FLD_FARMACIA_ENDERECO).AsString          :=  coFARMACIA.ENDERECO;
  ParamByName(FLD_FARMACIA_CEP).AsString               :=  coFARMACIA.CEP;
  ParamByName(FLD_FARMACIA_EMAIL).AsString             :=  coFARMACIA.EMAIL;
  ParamByName(FLD_FARMACIA_TELEFONE).AsString          :=  coFARMACIA.TELEFONE;
  ParamByName(FLD_FARMACIA_HORA_ABERTURA).AsDateTime   :=  coFARMACIA.HORA_ABERTURA;
  ParamByName(FLD_FARMACIA_HORA_FECHAMENTO).AsDateTime :=  coFARMACIA.HORA_FECHAMENTO;
  ParamByName(FLD_FARMACIA_KEY_FARMA).AsString         :=  coFARMACIA.KEY_FARMA;
  end;
end;



end.
