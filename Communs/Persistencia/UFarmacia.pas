unit UFarmacia;

interface

uses
    UEntidade
  , UMunicipio
  , DBXJSON
  ;

type
  TFARMACIA = class (TENTIDADE)
  public
    CNPJ            : String;
    NOME            : String;
    TELEFONE        : String;
    ENDERECO        : String;
    MUNICIPIO       : TMUNICIPIO;
    BAIRRO          : String;
    CEP             : String;
    EMAIL           : String;
    HORA_ABERTURA   : TTime;
    HORA_FECHAMENTO : TTime;
    COMPLEMENTO     : String;
    KEY_FARMA       : String;

    constructor Create(const coJSONObject: TJSONOBject); override;

    function RetornaJSON: TJSONOBject; override;
  end;

const
  TBL_FARMACIA                  = 'FARMACIA';
  FLD_FARMACIA_CNPJ             = 'CNPJ';
  FLD_FARMACIA_NOME             = 'NOME';
  FLD_FARMACIA_ENDERECO         = 'ENDERECO';
  FLD_FARMACIA_BAIRRO           = 'BAIRRO';
  FLD_FARMACIA_COMPLEMENTO      = 'COMPLEMENTO';
  FLD_FARMACIA_TELEFONE         = 'TELEFONE';
  FLD_FARMACIA_COD_MUNICIPIO    = 'COD_MUNICIPIO';
  FLD_FARMACIA_CEP              = 'CEP';
  FLD_FARMACIA_EMAIL            = 'EMAIL';
  FLD_FARMACIA_HORA_ABERTURA    = 'HORA_ABERTURA';
  FLD_FARMACIA_HORA_FECHAMENTO  = 'HORA_FECHAMENTO';
  FLD_FARMACIA_KEY_FARMA        = 'KEY_FARMA';


  CNT_FARMACIA_MUNICIPIO = 'MUNICIPIO';

resourcestring
  STR_FARMACIA = 'Farmacia';

implementation

uses
    SysUtils
  ;

{ TFARMACIA }

constructor TFARMACIA.Create(const coJSONObject: TJSONOBject);
begin
  with coJSONObject do
  begin
    CNPJ            := Get(FLD_FARMACIA_CNPJ).JsonValue.Value;
    NOME            := Get(FLD_FARMACIA_NOME).JsonValue.Value;
    TELEFONE        := Get(FLD_FARMACIA_TELEFONE).JsonValue.Value;
    MUNICIPIO       := TMUNICIPIO.Create(TJSONObject(Get(CNT_FARMACIA_MUNICIPIO).JsonValue));
    ENDERECO        := Get(FLD_FARMACIA_ENDERECO).JsonValue.Value;
    BAIRRO          := Get(FLD_FARMACIA_BAIRRO).JsonValue.Value;
    CEP             := Get(FLD_FARMACIA_CEP).JsonValue.Value;
    EMAIL           := Get(FLD_FARMACIA_EMAIL).JsonValue.Value;
    HORA_ABERTURA   := StrToTime(coJSONObject.Get(FLD_FARMACIA_HORA_ABERTURA).JsonValue.Value);
    HORA_FECHAMENTO := StrToTime(Get(FLD_FARMACIA_HORA_FECHAMENTO).JsonValue.Value);
    COMPLEMENTO     := Get(FLD_FARMACIA_COMPLEMENTO).JsonValue.Value;
    KEY_FARMA       := Get(FLD_FARMACIA_KEY_FARMA).JsonValue.Value;
  end;
end;

function TFARMACIA.RetornaJSON: TJSONOBject;
begin
  Result := TJSONObject.Create;
  Result.AddPair(FLD_FARMACIA_CNPJ, CNPJ);
  Result.AddPair(FLD_FARMACIA_NOME           , NOME);
  Result.AddPair(FLD_FARMACIA_ENDERECO       , ENDERECO);
  Result.AddPair(FLD_FARMACIA_BAIRRO         , BAIRRO);
  Result.AddPair(FLD_FARMACIA_COMPLEMENTO    , COMPLEMENTO);
  Result.AddPair(FLD_FARMACIA_TELEFONE       , TELEFONE);
  Result.AddPair(CNT_FARMACIA_MUNICIPIO      , MUNICIPIO.RetornaJSON);
  Result.AddPair(FLD_FARMACIA_CEP            , CEP);
  Result.AddPair(FLD_FARMACIA_EMAIL          , EMAIL);
  Result.AddPair(FLD_FARMACIA_HORA_ABERTURA  , TimeToStr(HORA_ABERTURA));
  Result.AddPair(FLD_FARMACIA_HORA_FECHAMENTO, TimeToStr(HORA_FECHAMENTO));
  Result.AddPair(FLD_FARMACIA_KEY_FARMA      , KEY_FARMA);
  Result.AddPair(CNT_FARMACIA_MUNICIPIO      , MUNICIPIO.RetornaJSON);
end;

end.
