unit URepositorioPrescricaoDB;

interface

uses
    UPrescricao
  , UEntidade
  , UFuncionario
  , UProduto
  , UCliente
  , URepositorioFuncionarioDB
  , URepositorioMedicamentoDB
  , URepositorioClienteDB
  , URepositorioDB
  , SqlExpr
  ;

type
  TRepositorioPrescricaoDB = class(TRepositorioDB<TPRESCRICAO>)
  private
    FRepositorioFuncionario: TRepositorioFuncionarioDB;
    FRepositorioMedicamento: TRepositorioMedicamento;
    FRepositorioCLiente    : TRepositorioClienteDB;
  public

    procedure AtribuiDBParaEntidade(const coPRESCRICAO: TPRESCRICAO); override;
    procedure AtribuiEntidadeParaDB(const coPRESCRICAO: TPRESCRICAO;
                                    const coSQLQuery: TSQLQuery); override;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TRepositorioPrescricaoDB }

uses
    UDM
  , SysUtils
  ;

procedure TRepositorioPrescricaoDB.AtribuiDBParaEntidade(const coPRESCRICAO: TPRESCRICAO);
var
  CodigoFuncionario: Integer;
  CodigoCliente    : Integer;
  CodigoMedicamento: Integer;
begin
  inherited;
  with FSQLSelect do
  begin
    coPRESCRICAO.DESCRICAO           := FieldByName(FLD_PRESCRICAO_DESCRICAO).AsString;
    coPRESCRICAO.DATA_HORA_PRESCRITA := FieldByName(FLD_PRESCRICAO_DATA_HORA_PRESCRITA).AsDateTime;
    coPRESCRICAO.DATA_HORA_VENCIMENTO:= FieldByName(FLD_PRESCRICAO_DATA_HORA_VENCIMENTO).AsDateTime;

    CodigoFuncionario := FieldByName(FLD_PRESCRICAO_COD_FUNCIONARIO).AsInteger;
    CodigoCliente := FieldByName(FLD_PRESCRICAO_COD_CLIENTE).AsInteger;
    CodigoMedicamento := FieldByName(FLD_PRESCRICAO_COD_MEDICAMENTO).AsInteger;

    coPRESCRICAO.FUNCIONARIO   := TFUNCIONARIO(
        FRepositorioFuncionario.Retorna(CodigoFuncionario));

    coPRESCRICAO.CLIENTE       := TCliente(
        FRepositorioCLiente.Retorna(CodigoCliente));

    coPRESCRICAO.MEDICAMENTO   := TMEDICAMENTO(
        FRepositorioMedicamento.Retorna(CodigoMedicamento));
  end;
end;

procedure TRepositorioPrescricaoDB.AtribuiEntidadeParaDB(
  const coPRESCRICAO: TPRESCRICAO; const coSQLQuery: TSQLQuery);
begin
  inherited;
    with coSQLQuery do
  begin
    ParamByName(FLD_PRESCRICAO_COD_FUNCIONARIO).AsInteger      :=  coPRESCRICAO.FUNCIONARIO.ID     ;
    ParamByName(FLD_PRESCRICAO_COD_CLIENTE).AsInteger          :=  coPRESCRICAO.CLIENTE.ID         ;
    ParamByName(FLD_PRESCRICAO_COD_MEDICAMENTO).AsInteger      :=  coPRESCRICAO.MEDICAMENTO.ID     ;
    ParamByName(FLD_PRESCRICAO_DESCRICAO).AsString            :=  coPRESCRICAO.DESCRICAO           ;
    ParamByName(FLD_PRESCRICAO_DATA_HORA_PRESCRITA).AsDateTime:=  coPRESCRICAO.DATA_HORA_PRESCRITA ;
    ParamByName(FLD_PRESCRICAO_DATA_HORA_VENCIMENTO).AsDate   :=  coPRESCRICAO.DATA_HORA_VENCIMENTO;
  end;
end;

constructor TRepositorioPrescricaoDB.Create;
begin
  Inherited Create(TPRESCRICAO, TBL_PRESCRICAO, FLD_ENTIDADE_ID, STR_PRESCRICAO);

  FRepositorioFuncionario := TRepositorioFuncionarioDB.Create;
  FRepositorioMedicamento := TRepositorioMedicamento.Create;
  FRepositorioCLiente     := TRepositorioClienteDB.Create;
end;

destructor TRepositorioPrescricaoDB.Destroy;
begin
  FreeAndNil(FRepositorioFuncionario);
  FreeAndNil(FRepositorioMedicamento);
  FreeAndNil(FRepositorioCLiente);
  inherited;
end;

end.
