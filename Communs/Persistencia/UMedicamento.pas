unit UMedicamento;

interface

uses
    UEntidade
  , DBXJSON
  ;

type
  TMEDICAMENTO = class(TENTIDADE)
  public
    PRINCIPIO_ATIVO     : string;
    CNPJ                : String;
    LABORATORIO         : String;
    CODGREM             : String;
    EAN                 : String;
    NOME                : String;
    APRESENTACAO        : String;
    PRECOFAB            : String;
    PRECOCOMERCIAL      : String;
    RESTRICAOHOSPITALAR : String;

    constructor Create(const coJSONObject: TJSONOBject); override;

    function RetornaJSON: TJSONOBject; override;

  end;

const
  { Relacionado a tabela }
  TBL_MEDICAMENTO                     = 'MEDICAMENTO';
  FLD_MEDICAMENTO_PRINCIPIO_ATIVO     = 'PRINCIPIO_ATIVO';
  FLD_MEDICAMENTO_CNPJ                = 'CNPJ';
  FLD_MEDICAMENTO_LABORATORIO         = 'LABORATORIO';
  FLD_MEDICAMENTO_CODGREM             = 'CODGGREM';
  FLD_MEDICAMENTO_EAN                 = 'EAN';
  FLD_MEDICAMENTO_NOME                = 'NOME';
  FLD_MEDICAMENTO_APRESENTACAO        = 'APRESENTACAO';
  FLD_MEDICAMENTO_PRECOFAB            = 'PRECOFAB';
  FLD_MEDICAMENTO_PRECOCOMERCIAL      = 'PRECOCOMERCIAL';
  FLD_MEDICAMENTO_RESTRICAOHOSPITALAR = 'RESTRICAOHOSPITALAR';

  { Relacionado a serialização }
  CNT_CLIENTE_MUNICIPIO = 'MUNICIPIO';

resourcestring
  STR_MEDICAMENTO = 'Medicamento';

implementation

{ TMEDICAMENTO }

constructor TMEDICAMENTO.Create(const coJSONObject: TJSONOBject);
begin
  inherited;
  with coJSONObject do
  begin
    PRINCIPIO_ATIVO     := Get(FLD_MEDICAMENTO_PRINCIPIO_ATIVO).JsonValue.Value;
    CNPJ                := Get(FLD_MEDICAMENTO_CNPJ).JsonValue.Value;
    LABORATORIO         := Get(FLD_MEDICAMENTO_LABORATORIO).JsonValue.Value;
    CODGREM             := Get(FLD_MEDICAMENTO_CODGREM).JsonValue.Value;
    EAN                 := Get(FLD_MEDICAMENTO_EAN).JsonValue.Value;
    NOME                := Get(FLD_MEDICAMENTO_NOME).JsonValue.Value;
    APRESENTACAO        := Get(FLD_MEDICAMENTO_APRESENTACAO).JsonValue.Value;
    PRECOFAB            := Get(FLD_MEDICAMENTO_PRECOFAB).JsonValue.Value;
    PRECOCOMERCIAL      := Get(FLD_MEDICAMENTO_PRECOCOMERCIAL).JsonValue.Value;
    RESTRICAOHOSPITALAR := Get(FLD_MEDICAMENTO_RESTRICAOHOSPITALAR).JsonValue.Value;
  end;
end;

function TMEDICAMENTO.RetornaJSON: TJSONOBject;
begin
  Result := Inherited;
  Result.AddPair(FLD_MEDICAMENTO_PRINCIPIO_ATIVO     , PRINCIPIO_ATIVO);
  Result.AddPair(FLD_MEDICAMENTO_CNPJ                , CNPJ);
  Result.AddPair(FLD_MEDICAMENTO_LABORATORIO         , LABORATORIO);
  Result.AddPair(FLD_MEDICAMENTO_CODGREM             , CODGREM);
  Result.AddPair(FLD_MEDICAMENTO_EAN                 , EAN);
  Result.AddPair(FLD_MEDICAMENTO_NOME                , NOME);
  Result.AddPair(FLD_MEDICAMENTO_APRESENTACAO        , APRESENTACAO);
  Result.AddPair(FLD_MEDICAMENTO_PRECOFAB            , PRECOFAB);
  Result.AddPair(FLD_MEDICAMENTO_PRECOCOMERCIAL      , PRECOCOMERCIAL);
  Result.AddPair(FLD_MEDICAMENTO_RESTRICAOHOSPITALAR , RESTRICAOHOSPITALAR);
end;

end.
