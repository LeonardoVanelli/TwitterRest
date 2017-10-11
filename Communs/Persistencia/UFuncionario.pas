unit UFuncionario;

interface

uses
  UEntidade,
  UFuncao,
  UTurno,
  UMunicipio,
  UUtilitarios
  , DBXJSON
  ;

type
	TFUNCIONARIO = class(TENTIDADE)
  private
    //function RetornaTipoServico: TTipoServico;

	public
		CPF 		        : String;
		NOME		        : String;
		DATA_NASCIMENTO	: TDate;
    ENDERECO	      : String;
    COMPLEMENTO     : string;
    NUMERO          : String;
    BAIRRO		      : String;
		MUNICIPIO	      : TMUNICIPIO;
    CEP             : String;
		CELULAR		      : String;
    FONE		        : String;
    RG              : String;
		RG_ORGAO_EMISSOR: String;
    RG_DATA_EMISSAO	: TDate;
    EMAIL		        : String;
    SENHA           : String;
    FUNCAO          : String;
  //  CAMINHO_FOTO    : String;

    constructor Create(const coJSONObject: TJSONOBject); override;

    function RetornaJSON: TJSONOBject; override;

    //property TIPO_SERVICO: TTipoServico read RetornaTipoServico;
	end;

const
  { Relacionado a tabela }
  TBL_FUNCIONARIO                   = 'FUNCIONARIO';
  FLD_FUNCIONARIO_CPF               = 'CPF';
  FLD_FUNCIONARIO_NOME              = 'NOME';
  FLD_FUNCIONARIO_DATA_NASC         = 'DATA_NASCIMENTO';
  FLD_FUNCIONARIO_ENDERECO          = 'ENDERECO';
  FLD_FUNCIONARIO_COMPLEMENTO       = 'COMPLEMENTO';
  FLD_FUNCIONARIO_NUMERO            = 'NUMERO';
  FLD_FUNCIONARIO_BAIRRO            = 'BAIRRO';
  FLD_FUNCIONARIO_COD_MUNICIPIO     = 'COD_MUNICIPIO';
  FLD_FUNCIONARIO_CEP               = 'CEP';
  FLD_FUNCIONARIO_CELULAR           = 'CELULAR';
  FLD_FUNCIONARIO_FONE              = 'FONE';
  FLD_FUNCIONARIO_RG                = 'RG';
  FLD_FUNCIONARIO_RG_ORGAO_EMISSOR  = 'RG_ORGAO_EMISSOR';
  FLD_FUNCIONARIO_RG_DATA_EMISSAO   = 'RG_DATA_EMISSAO';
  FLD_FUNCIONARIO_EMAIL             = 'EMAIL';
  FLD_FUNCIONARIO_SENHA             = 'SENHA';
  FLD_FUNCIONARIO_FUNCAO            = 'FUNCAO';
 // FLD_FUNCIONARIO_CAMINHO_FOTO      = 'CAMINHO_FOTO';

  { Relacionado a serialização }
  CNT_FUNCIONARIO_MUNICIPIO = 'MUNICIPIO';
  CNT_FUNCIONARIO_FUNCAO = 'FUNCAO';
  CNT_FUNCIONARIO_TURNO =  'TURNO';

resourcestring
  STR_FUNCIONARIO = 'Funcionario';

implementation

{ TFUNCIONARIO }

uses
    SysUtils
  , Dialogs
  ;

//function TFUNCIONARIO.RetornaTipoServico: TTipoServico;
//begin
//  Result := FUNCAO.TIPO_SERVICO
//end;

{ TFUNCIONARIO }

constructor TFUNCIONARIO.Create(const coJSONObject: TJSONOBject);
begin
  Inherited;
  with coJSONObject do
  begin
    CPF              := Get(FLD_FUNCIONARIO_CPF).JsonValue.Value;
    NOME             := Get(FLD_FUNCIONARIO_NOME).JsonValue.Value;
    DATA_NASCIMENTO  := StrToDate(Get(FLD_FUNCIONARIO_DATA_NASC).JsonValue.Value);
    ENDERECO         := Get(FLD_FUNCIONARIO_ENDERECO).JsonValue.Value;
    COMPLEMENTO      := Get(FLD_FUNCIONARIO_COMPLEMENTO).JsonValue.Value;
    NUMERO           := Get(FLD_FUNCIONARIO_NUMERO).JsonValue.Value;
    BAIRRO           := Get(FLD_FUNCIONARIO_BAIRRO).JsonValue.Value;
    MUNICIPIO        := TMUNICIPIO.Create(TJSONObject(Get(CNT_FUNCIONARIO_MUNICIPIO).JsonValue));
    CEP              := Get(FLD_FUNCIONARIO_CEP).JsonValue.Value;
    CELULAR          := Get(FLD_FUNCIONARIO_CELULAR).JsonValue.Value;
    FONE             := Get(FLD_FUNCIONARIO_FONE).JsonValue.Value;
    RG               := Get(FLD_FUNCIONARIO_RG ).JsonValue.Value;
    RG_ORGAO_EMISSOR := Get(FLD_FUNCIONARIO_RG_ORGAO_EMISSOR).JsonValue.Value;
    RG_DATA_EMISSAO  := StrToDate(Get(FLD_FUNCIONARIO_RG_DATA_EMISSAO).JsonValue.Value);
    EMAIL            := Get(FLD_FUNCIONARIO_EMAIL).JsonValue.Value;
    SENHA            := Get(FLD_FUNCIONARIO_SENHA).JsonValue.Value;
    FUNCAO           := Get(FLD_FUNCIONARIO_FUNCAO).JsonValue.Value;
  end;
end;

function TFUNCIONARIO.RetornaJSON: TJSONOBject;
begin
  Result := Inherited;
  Result.AddPair(FLD_FUNCIONARIO_CPF             , CPF);
  Result.AddPair(FLD_FUNCIONARIO_NOME            , NOME);
  Result.AddPair(FLD_FUNCIONARIO_DATA_NASC       , DateToStr(DATA_NASCIMENTO));
  Result.AddPair(FLD_FUNCIONARIO_ENDERECO        , ENDERECO);
  Result.AddPair(FLD_FUNCIONARIO_COMPLEMENTO     , COMPLEMENTO);
  Result.AddPair(FLD_FUNCIONARIO_NUMERO          , NUMERO);
  Result.AddPair(FLD_FUNCIONARIO_BAIRRO          , BAIRRO);
  Result.AddPair(CNT_FUNCIONARIO_MUNICIPIO       , MUNICIPIO.RetornaJSON);
  Result.AddPair(FLD_FUNCIONARIO_CEP             , CEP);
  Result.AddPair(FLD_FUNCIONARIO_CELULAR         , CELULAR);
  Result.AddPair(FLD_FUNCIONARIO_FONE            , FONE);
  Result.AddPair(FLD_FUNCIONARIO_RG              , RG);
  Result.AddPair(FLD_FUNCIONARIO_RG_ORGAO_EMISSOR, RG_ORGAO_EMISSOR);
  Result.AddPair(FLD_FUNCIONARIO_RG_DATA_EMISSAO , DateToStr(RG_DATA_EMISSAO));
  Result.AddPair(FLD_FUNCIONARIO_EMAIL           , EMAIL);
  Result.AddPair(FLD_FUNCIONARIO_SENHA           , SENHA);
  Result.AddPair(FLD_FUNCIONARIO_FUNCAO          , FUNCAO);

end;

end.

