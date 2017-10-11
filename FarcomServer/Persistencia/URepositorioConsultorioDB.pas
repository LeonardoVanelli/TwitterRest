unit URepositorioConsultorioDB;

interface

uses
    UConsultorio
  , UEntidade
  , URepositorioDB
  , SqlExpr
  , UMunicipio
  , URepositorioMunicipioDB
  ;

type
  TRepositorioConsultorioDB = class(TRepositorioDB<TCONSULTORIO>)
  private
    FRepositorioMunicipioDB : TRepositorioMunicipioDB;
  public
    constructor Create;

    procedure AtribuiDBParaEntidade(const coCONSULTORIO: TConsultorio); override;
    procedure AtribuiEntidadeParaDB(const coCONSULTORIO: TCONSULTORIO;
                                    const coSQLQuery: TSQLQuery); override;
  end;

implementation

uses
  UDM
  ;

{ TRepositorioConsultorioDB }

constructor TRepositorioConsultorioDB.Create;
begin
  inherited Create(TCONSULTORIO, TBL_CONSULTORIO, FLD_ENTIDADE_ID, STR_CONSULTORIO);
  FRepositorioMunicipioDB := TRepositorioMunicipioDB.Create;
end;

procedure TRepositorioConsultorioDB.AtribuiDBParaEntidade(const coCONSULTORIO: TCONSULTORIO);
begin
  inherited;
  with FSQLSelect do
  begin
  coCONSULTORIO.NOME            := FieldByName(FLD_CONSULTORIO_NOME).AsString;
  coCONSULTORIO.CNPJ            := FieldByName(FLD_CONSULTORIO_CNPJ).AsString;
  coCONSULTORIO.TELEFONE        := FieldByName(FLD_CONSULTORIO_TELEFONE).AsString;
  coCONSULTORIO.ENDERECO        := FieldByName(FLD_CONSULTORIO_ENDERECO).AsString;
  coCONSULTORIO.CEP             := FieldByName(FLD_CONSULTORIO_CEP).AsString;
  coCONSULTORIO.EMAIL           := FieldByName(FLD_CONSULTORIO_EMAIL).AsString;
  coCONSULTORIO.HORA_ABERTURA   := FieldByName(FLD_CONSULTORIO_HORA_ABERTURA).AsDateTime;
  coCONSULTORIO.HORA_FECHAMENTO := FieldByName(FLD_CONSULTORIO_HORA_FECHAMENTO).AsDateTime;
  coCONSULTORIO.ESPECIALIZACAO  := FieldByName(FLD_CONSULTORIO_ESPECIALIZACAO).AsString;
  coCONSULTORIO.MEDICOS         := FieldByName(FLD_CONSULTORIO_MEDICOS).AsString;
  coCONSULTORIO.KEY_CONSUL      := FieldByName(FLD_CONSULTORIO_KEY_CONSUL).AsString;

  coCONSULTORIO.MUNICIPIO := TMUNICIPIO(
    FRepositorioMunicipioDB.Retorna(FieldByName(FLD_CONSULTORIO_COD_MUNICIPIO).AsInteger));
  end;
end;

procedure TRepositorioConsultorioDB.AtribuiEntidadeParaDB(const coCONSULTORIO: TCONSULTORIO;
  const coSQLQuery: TSQLQuery);
begin
  inherited;
  with coSQLQuery do
  begin
  ParamByName(FLD_CONSULTORIO_NOME).AsString              := coCONSULTORIO.NOME;
  ParamByName(FLD_CONSULTORIO_CNPJ).AsString              :=  coCONSULTORIO.CNPJ;
  ParamByName(FLD_CONSULTORIO_ENDERECO).AsString          :=  coCONSULTORIO.ENDERECO;
  ParamByName(FLD_CONSULTORIO_CEP).AsString               :=  coCONSULTORIO.CEP;
  ParamByName(FLD_CONSULTORIO_COD_MUNICIPIO).AsInteger    := coCONSULTORIO.MUNICIPIO.ID;
  ParamByName(FLD_CONSULTORIO_EMAIL).AsString             :=  coCONSULTORIO.EMAIL;
  ParamByName(FLD_CONSULTORIO_TELEFONE).AsString          :=  coCONSULTORIO.TELEFONE;
  ParamByName(FLD_CONSULTORIO_HORA_ABERTURA).AsDateTime   :=  coCONSULTORIO.HORA_ABERTURA;
  ParamByName(FLD_CONSULTORIO_HORA_FECHAMENTO).AsDateTime :=  coCONSULTORIO.HORA_FECHAMENTO;
  ParamByName(FLD_CONSULTORIO_ESPECIALIZACAO).AsString    :=  coCONSULTORIO.ESPECIALIZACAO;
  ParamByName(FLD_CONSULTORIO_MEDICOS).AsString           :=  coCONSULTORIO.MEDICOS;
  ParamByName(FLD_CONSULTORIO_KEY_CONSUL).AsString        :=  coCONSULTORIO.KEY_CONSUL;
  end;
end;



end.
