unit URepositorioFuncionarioDB;

interface

uses
    UCompra
  , UEntidade
  , URepositorioDB
  , SqlExpr
  , UFuncionario
  , URepositorioMunicipioDB
  ;

type
  TRepositorioFuncionarioDB = class(TRepositorioDB<TFUNCIONARIO>)
  private
    FRepositorioMunicipioDB: TRepositorioMunicipioDB;

  protected
    procedure AtribuiDBParaEntidade(const coFUNCIONARIO: TFUNCIONARIO); override;
    procedure AtribuiEntidadeParaDB(const coFUNCIONARIO: TFUNCIONARIO;
                                    const coSQLQuery: TSQLQuery); override;
  public
    constructor Create;
    destructor Destroy; override;

    function RetornaPeloCPF(const csCPF: String): TFUNCIONARIO;
  end;

implementation

uses
    UDM
  , sysUtils
  , UMunicipio
  ;


{ TRepositorioFuncionarioDB }

procedure TRepositorioFuncionarioDB.AtribuiDBParaEntidade(
  const coFUNCIONARIO: TFUNCIONARIO);
begin
  inherited;
  with FSQLSelect do
    begin
      coFUNCIONARIO.CPF              := FieldByName(FLD_FUNCIONARIO_CPF             ).AsString;
      coFUNCIONARIO.NOME             := FieldByName(FLD_FUNCIONARIO_NOME            ).AsString;
      coFUNCIONARIO.DATA_NASCIMENTO  := FieldByName(FLD_FUNCIONARIO_DATA_NASC       ).AsDateTime;
      coFUNCIONARIO.ENDERECO         := FieldByName(FLD_FUNCIONARIO_ENDERECO        ).AsString;
      coFUNCIONARIO.COMPLEMENTO      := FieldByName(FLD_FUNCIONARIO_COMPLEMENTO     ).AsString;
      coFUNCIONARIO.NUMERO           := FieldByName(FLD_FUNCIONARIO_NUMERO          ).AsString;
      coFUNCIONARIO.BAIRRO           := FieldByName(FLD_FUNCIONARIO_BAIRRO          ).AsString;
      coFUNCIONARIO.CEP              := FieldByName(FLD_FUNCIONARIO_CEP             ).AsString;
      coFUNCIONARIO.CELULAR          := FieldByName(FLD_FUNCIONARIO_CELULAR         ).AsString;
      coFUNCIONARIO.FONE             := FieldByName(FLD_FUNCIONARIO_FONE            ).AsString;
      coFUNCIONARIO.RG               := FieldByName(FLD_FUNCIONARIO_RG              ).AsString;
      coFUNCIONARIO.RG_ORGAO_EMISSOR := FieldByName(FLD_FUNCIONARIO_RG_ORGAO_EMISSOR).AsString;
      coFUNCIONARIO.RG_DATA_EMISSAO  := FieldByName(FLD_FUNCIONARIO_RG_DATA_EMISSAO ).AsDateTime;
      coFUNCIONARIO.EMAIL            := FieldByName(FLD_FUNCIONARIO_EMAIL           ).AsString;
      coFUNCIONARIO.SENHA            := FieldByName(FLD_FUNCIONARIO_SENHA           ).AsString;
      coFUNCIONARIO.FUNCAO           := FieldByName(FLD_FUNCIONARIO_FUNCAO          ).AsString;
      coFUNCIONARIO.MUNICIPIO        := TMUNICIPIO(
        FRepositorioMunicipioDB.Retorna(FieldByName(FLD_FUNCIONARIO_COD_MUNICIPIO).AsInteger));
    end;
end;

procedure TRepositorioFuncionarioDB.AtribuiEntidadeParaDB(
  const coFUNCIONARIO: TFUNCIONARIO; const coSQLQuery: TSQLQuery);
begin
  inherited;
  with coSQLQuery do
    begin
      ParamByName(FLD_FUNCIONARIO_CPF             ).AsString   := coFUNCIONARIO.CPF;
      ParamByName(FLD_FUNCIONARIO_NOME            ).AsString   := coFUNCIONARIO.NOME;
      ParamByName(FLD_FUNCIONARIO_DATA_NASC       ).AsDateTime := coFUNCIONARIO.DATA_NASCIMENTO;
      ParamByName(FLD_FUNCIONARIO_ENDERECO        ).AsString   := coFUNCIONARIO.ENDERECO;
      ParamByName(FLD_FUNCIONARIO_COMPLEMENTO     ).AsString   := coFUNCIONARIO.COMPLEMENTO;
      ParamByName(FLD_FUNCIONARIO_NUMERO          ).AsString   := coFUNCIONARIO.NUMERO;
      ParamByName(FLD_FUNCIONARIO_BAIRRO          ).AsString   := coFUNCIONARIO.BAIRRO;
      ParamByName(FLD_FUNCIONARIO_CEP             ).AsString   := coFUNCIONARIO.CEP;
      ParamByName(FLD_FUNCIONARIO_CELULAR         ).AsString   := coFUNCIONARIO.CELULAR;
      ParamByName(FLD_FUNCIONARIO_FONE            ).AsString   := coFUNCIONARIO.FONE;
      ParamByName(FLD_FUNCIONARIO_RG              ).AsString   := coFUNCIONARIO.RG;
      ParamByName(FLD_FUNCIONARIO_RG_ORGAO_EMISSOR).AsString   := coFUNCIONARIO.RG_ORGAO_EMISSOR;
      ParamByName(FLD_FUNCIONARIO_RG_DATA_EMISSAO ).AsDateTime := coFUNCIONARIO.RG_DATA_EMISSAO;
      ParamByName(FLD_FUNCIONARIO_EMAIL           ).AsString   := coFUNCIONARIO.EMAIL;
      ParamByName(FLD_FUNCIONARIO_SENHA           ).AsString   := coFUNCIONARIO.SENHA;
      ParamByName(FLD_FUNCIONARIO_FUNCAO          ).AsString   := coFUNCIONARIO.FUNCAO;
    end;
end;

constructor TRepositorioFuncionarioDB.Create;
begin
  inherited Create(TFUNCIONARIO, TBL_FUNCIONARIO, FLD_ENTIDADE_ID, STR_FUNCIONARIO);
  FRepositorioMunicipioDB := TRepositorioMunicipioDB.Create;
end;

destructor TRepositorioFuncionarioDB.Destroy;
begin
  FreeAndNil(FRepositorioMunicipioDB);
  inherited;
end;

function TRepositorioFuncionarioDB.RetornaPeloCPF(
  const csCPF: String): TFUNCIONARIO;
begin
  FSQLSelect.Close;
  FSQLSelect.CommandText := Format(CNT_SELECT_UNIQUE, [TBL_FUNCIONARIO
                                                     , FLD_FUNCIONARIO_CPF]);
  FSQLSelect.ParamByName(FLD_FUNCIONARIO_CPF).AsString := csCPF;
  FSQLSelect.Open;

  Result := nil;
  if not FSQLSelect.Eof then
    begin
      Result := TFUNCIONARIO.Create;
      AtribuiDBParaEntidade(Result);
    end;
end;

end.
