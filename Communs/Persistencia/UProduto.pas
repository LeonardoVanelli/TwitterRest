unit UProduto;

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
  TBL_PRODUTO                     = 'PRODUTO';
  FLD_PRODUTO_PRINCIPIO_ATIVO     = 'PRINCIPIO_ATIVO';
  FLD_PRODUTO_CNPJ                = 'CNPJ';
  FLD_PRODUTO_LABORATORIO         = 'LABORATORIO';
  FLD_PRODUTO_CODGREM             = 'CODGGREM';
  FLD_PRODUTO_EAN                 = 'EAN';
  FLD_PRODUTO_NOME                = 'NOME';
  FLD_PRODUTO_APRESENTACAO        = 'APRESENTACAO';
  FLD_PRODUTO_PRECOFAB            = 'PRECOFAB';
  FLD_PRODUTO_PRECOCOMERCIAL      = 'PRECOCOMERCIAL';
  FLD_PRODUTO_RESTRICAOHOSPITALAR = 'RESTRICAOHOSPITALAR';

resourcestring
  STR_PRODUTO = 'Produto';

implementation

{ TPRODUTO }

constructor TMEDICAMENTO.Create(const coJSONObject: TJSONOBject);
begin
  inherited;
  with coJSONObject do
    begin
      PRINCIPIO_ATIVO     := Get(FLD_PRODUTO_PRINCIPIO_ATIVO    ).JsonValue.Value;
      CNPJ                := Get(FLD_PRODUTO_CNPJ               ).JsonValue.Value;
      LABORATORIO         := Get(FLD_PRODUTO_LABORATORIO        ).JsonValue.Value;
      CODGREM             := Get(FLD_PRODUTO_CODGREM            ).JsonValue.Value;
      EAN                 := Get(FLD_PRODUTO_EAN                ).JsonValue.Value;
      NOME                := Get(FLD_PRODUTO_NOME               ).JsonValue.Value;
      APRESENTACAO        := Get(FLD_PRODUTO_APRESENTACAO       ).JsonValue.Value;
      PRECOFAB            := Get(FLD_PRODUTO_PRECOFAB           ).JsonValue.Value;
      PRECOCOMERCIAL      := Get(FLD_PRODUTO_PRECOCOMERCIAL     ).JsonValue.Value;
      RESTRICAOHOSPITALAR := Get(FLD_PRODUTO_RESTRICAOHOSPITALAR).JsonValue.Value;
    end;
end;

function TMEDICAMENTO.RetornaJSON: TJSONOBject;
begin
  Result := Inherited;
  Result.AddPair(FLD_PRODUTO_PRINCIPIO_ATIVO    , PRINCIPIO_ATIVO    );
  Result.AddPair(FLD_PRODUTO_CNPJ               , CNPJ               );
  Result.AddPair(FLD_PRODUTO_LABORATORIO        , LABORATORIO        );
  Result.AddPair(FLD_PRODUTO_CODGREM            , CODGREM            );
  Result.AddPair(FLD_PRODUTO_EAN                , EAN                );
  Result.AddPair(FLD_PRODUTO_NOME               , NOME               );
  Result.AddPair(FLD_PRODUTO_APRESENTACAO       , APRESENTACAO       );
  Result.AddPair(FLD_PRODUTO_PRECOFAB           , PRECOFAB           );
  Result.AddPair(FLD_PRODUTO_PRECOCOMERCIAL     , PRECOCOMERCIAL     );
  Result.AddPair(FLD_PRODUTO_RESTRICAOHOSPITALAR, RESTRICAOHOSPITALAR);
end;

end.
