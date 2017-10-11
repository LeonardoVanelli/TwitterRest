unit UConsultorio;

interface

uses
  UEntidade
  , UMunicipio
  , DBXJSON
  , SysUtils;

type
  TCONSULTORIO = class (TENTIDADE)
  public
    CNPJ            : String;
    NOME            : String;
    TELEFONE        : String;
    ENDERECO        : String;
    MUNICIPIO       : TMunicipio;
    CEP             : String;
    HORA_ABERTURA   : TTime;
    HORA_FECHAMENTO : TTime;
    EMAIL           : String;
    ESPECIALIZACAO  : String;
    MEDICOS         : String;
    KEY_CONSUL      : String;
   // BAIRRO          : String;
   // COMPLEMENTO     : String;

    constructor Create(const coJSONObject: TJSONOBject); override;

    function RetornaJSON: TJSONOBject; override;
  end;

const
  TBL_CONSULTORIO                  = 'CONSULTORIO';
  FLD_CONSULTORIO_CNPJ             = 'CNPJ';
  FLD_CONSULTORIO_NOME             = 'NOME';
  FLD_CONSULTORIO_TELEFONE         = 'TELEFONE';
  FLD_CONSULTORIO_ENDERECO         = 'ENDERECO';
  FLD_CONSULTORIO_COD_MUNICIPIO    = 'COD_MUNICIPIO';
  FLD_CONSULTORIO_CEP              = 'CEP';
  FLD_CONSULTORIO_HORA_ABERTURA    = 'HORA_ABERTURA';
  FLD_CONSULTORIO_HORA_FECHAMENTO  = 'HORA_FECHAMENTO';
  FLD_CONSULTORIO_EMAIL            = 'EMAIL';
  FLD_CONSULTORIO_ESPECIALIZACAO   = 'ESPECIALIZACAO';
  FLD_CONSULTORIO_MEDICOS          = 'MEDICOS';
  FLD_CONSULTORIO_KEY_CONSUL       = 'KEY_CONSUL';
  FLD_CONSULTORIO_BAIRRO           = 'BAIRRO';
  FLD_CONSULTORIO_COMPLEMENTO      = 'COMPLEMENTO';

  CNT_CONSULTORIO_MUNICIPIO = 'MUNICIPIO';

resourcestring
  STR_CONSULTORIO = 'Consultorio';

implementation

{ TCONSULTORIO }

constructor TCONSULTORIO.Create(const coJSONObject: TJSONOBject);
begin
  inherited;
  with coJSONObject do
  begin
    CNPJ            := Get(FLD_CONSULTORIO_CNPJ).JsonValue.Value;
    NOME            := Get(FLD_CONSULTORIO_NOME).JsonValue.Value;
    TELEFONE        := Get(FLD_CONSULTORIO_TELEFONE).JsonValue.Value;
    ENDERECO        := Get(FLD_CONSULTORIO_ENDERECO).JsonValue.Value;
    //BAIRRO          := Get(FLD_CONSULTORIO_BAIRRO).JsonValue.Value;
    CEP             := Get(FLD_CONSULTORIO_CEP).JsonValue.Value;
    EMAIL           := Get(FLD_CONSULTORIO_EMAIL).JsonValue.Value;
    HORA_ABERTURA   := StrToTime(coJSONObject.Get(FLD_CONSULTORIO_HORA_ABERTURA).JsonValue.Value);
    HORA_FECHAMENTO := StrToTime(Get(FLD_CONSULTORIO_HORA_FECHAMENTO).JsonValue.Value);
    //COMPLEMENTO     := Get(FLD_CONSULTORIO_COMPLEMENTO).JsonValue.Value;
    KEY_CONSUL      := Get(FLD_CONSULTORIO_KEY_CONSUL).JsonValue.Value;
    MUNICIPIO       := TMUNICIPIO.Create(TJSONObject(Get(CNT_CONSULTORIO_MUNICIPIO).JsonValue));
  end;
end;

function TCONSULTORIO.RetornaJSON: TJSONOBject;
begin
  Result := TJSONObject.Create;
  Result.AddPair(FLD_CONSULTORIO_CNPJ           , CNPJ);
  Result.AddPair(FLD_CONSULTORIO_NOME           , NOME);
  Result.AddPair(FLD_CONSULTORIO_ENDERECO       , ENDERECO);
//  Result.AddPair(FLD_CONSULTORIO_BAIRRO         , BAIRRO);
//  Result.AddPair(FLD_CONSULTORIO_COMPLEMENTO    , COMPLEMENTO);
  Result.AddPair(FLD_CONSULTORIO_TELEFONE       , TELEFONE);
  Result.AddPair(CNT_CONSULTORIO_MUNICIPIO      , MUNICIPIO.RetornaJSON);
  Result.AddPair(FLD_CONSULTORIO_CEP            , CEP);
  Result.AddPair(FLD_CONSULTORIO_EMAIL          , EMAIL);
  Result.AddPair(FLD_CONSULTORIO_HORA_ABERTURA  , TimeToStr(HORA_ABERTURA));
  Result.AddPair(FLD_CONSULTORIO_HORA_FECHAMENTO, TimeToStr(HORA_FECHAMENTO));
  Result.AddPair(FLD_CONSULTORIO_KEY_CONSUL      , KEY_CONSUL);
  Result.AddPair(CNT_CONSULTORIO_MUNICIPIO       , MUNICIPIO.RetornaJSON);
end;

end.
