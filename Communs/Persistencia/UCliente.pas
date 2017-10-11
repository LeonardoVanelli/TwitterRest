unit UCliente;

interface

uses
    UEntidade
  , UMunicipio
  , DBXJSON
  ;

type
  TCLIENTE = class (TENTIDADE)
  public
    NOME            : String;
    CPF             : String;
    RG              : String;
    RG_DATA_EMISSAO : TDate;
    RG_ORGAO_EMISSOR: string;
    DATA_NASCIMENTO : TDate;
    ENDERECO        : String;
    COMPLEMENTO     : String;
    NUMERO          : integer;
    BAIRRO          : String;
    CEP             : String;
    MUNICIPIO       : TMUNICIPIO;
    EMAIL           : String;
    TELEFONE        : String;
    CELULAR         : String;

    constructor Create(const coJSONObject: TJSONOBject); override;

    function RetornaJSON: TJSONOBject; override;
  end;

const
  { Relacionado a tabela }
  TBL_CLIENTE                  = 'CLIENTE';
  FLD_CLIENTE_NOME             = 'NOME';
  FLD_CLIENTE_CPF              = 'CPF';
  FLD_CLIENTE_RG               = 'RG';
  FLD_CLIENTE_RG_DATA_EMISSAO  = 'RG_DATA_EMISSAO';
  FLD_CLIENTE_RG_ORGAO_EMISSOR = 'RG_ORGAO_EMISSOR';
  FLD_CLIENTE_DATA_NASCIMENTO  = 'DATA_NASCIMENTO';
  FLD_CLIENTE_ENDERECO         = 'ENDERECO';
  FLD_CLIENTE_COMPLEMENTO      = 'COMPLEMENTO';
  FLD_CLIENTE_NUMERO           = 'NUMERO';
  FLD_CLIENTE_BAIRRO           = 'BAIRRO';
  FLD_CLIENTE_CEP              = 'CEP';
  FLD_CLIENTE_COD_MUNICIPIO    = 'COD_MUNICIPIO';
  FLD_CLIENTE_EMAIL            = 'EMAIL';
  FLD_CLIENTE_TELEFONE         = 'TELEFONE';
  FLD_CLIENTE_CELULAR          = 'CELULAR';

  { Relacionado a serialização }
  CNT_CLIENTE_MUNICIPIO = 'MUNICIPIO';

resourcestring
  STR_CLIENTE = 'Cliente';

implementation

{ TCLIENTE }

uses
    SysUtils
  ;

constructor TCLIENTE.Create(const coJSONObject: TJSONObject);
begin
  Inherited;
  with coJSONObject do
  begin
    NOME            := Get(FLD_CLIENTE_NOME).JsonValue.Value;
    CPF             := Get(FLD_CLIENTE_CPF).JsonValue.Value;
    RG              := Get(FLD_CLIENTE_RG).JsonValue.Value;
    RG_DATA_EMISSAO := StrToDate(Get(FLD_CLIENTE_RG_DATA_EMISSAO).JsonValue.Value);
    RG_ORGAO_EMISSOR:= Get(FLD_CLIENTE_RG_ORGAO_EMISSOR).JsonValue.Value;
    DATA_NASCIMENTO := StrToDate(Get(FLD_CLIENTE_DATA_NASCIMENTO).JsonValue.Value);
    ENDERECO        := Get(FLD_CLIENTE_ENDERECO).JsonValue.Value;
    COMPLEMENTO     := Get(FLD_CLIENTE_COMPLEMENTO).JsonValue.Value;
    NUMERO          := StrToInt(Get(FLD_CLIENTE_NUMERO).JsonValue.Value);
    BAIRRO          := Get(FLD_CLIENTE_BAIRRO).JsonValue.Value;
    CEP             := Get(FLD_CLIENTE_CEP).JsonValue.Value;
    EMAIL           := Get(FLD_CLIENTE_EMAIL).JsonValue.Value;
    TELEFONE        := Get(FLD_CLIENTE_TELEFONE).JsonValue.Value;
    CELULAR         := Get(FLD_CLIENTE_CELULAR).JsonValue.Value;
    MUNICIPIO       := TMUNICIPIO.Create(TJSONObject(Get(CNT_CLIENTE_MUNICIPIO).JsonValue));
  end;
end;

function TCLIENTE.RetornaJSON: TJSONOBject;
begin
  Result := Inherited;
  Result.AddPair(FLD_CLIENTE_NOME            , NOME);
  Result.AddPair(FLD_CLIENTE_CPF             , CPF);
  Result.AddPair(FLD_CLIENTE_RG              , RG);
  Result.AddPair(FLD_CLIENTE_RG_DATA_EMISSAO , DateToStr(RG_DATA_EMISSAO));
  Result.AddPair(FLD_CLIENTE_RG_ORGAO_EMISSOR, RG_ORGAO_EMISSOR);
  Result.AddPair(FLD_CLIENTE_DATA_NASCIMENTO , DateToStr(DATA_NASCIMENTO));
  Result.AddPair(FLD_CLIENTE_ENDERECO        , ENDERECO);
  Result.AddPair(FLD_CLIENTE_COMPLEMENTO     , COMPLEMENTO);
  Result.AddPair(FLD_CLIENTE_NUMERO          , TJSONNumber.Create(NUMERO));
  Result.AddPair(FLD_CLIENTE_BAIRRO          , BAIRRO);
  Result.AddPair(FLD_CLIENTE_CEP             , CEP);
  Result.AddPair(FLD_CLIENTE_EMAIL           , EMAIL);
  Result.AddPair(FLD_CLIENTE_TELEFONE        , TELEFONE);
  Result.AddPair(FLD_CLIENTE_CELULAR         , CELULAR);
  Result.AddPair(CNT_CLIENTE_MUNICIPIO       , MUNICIPIO.RetornaJSON);
end;

end.
