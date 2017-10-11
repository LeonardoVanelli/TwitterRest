unit UCompra;

interface

uses
    UEntidade
  , UCliente
  , DBXJSON
  , UProduto
  ;

type
  TCompra = class(TENTIDADE)
  public
    PRODUTO          : TMEDICAMENTO;
    VALOR_COMPRA     : String;
    DATA_HORA_COMPRA : TDateTime;

    constructor Create(const coJSONObject: TJSONOBject); override;

    function RetornaJSON: TJSONOBject; override;
  end;

const
  { Relacionado a tabela }
  TBL_COMPRA                  = 'COMPRA';
  FLD_COMPRA_COD_PRODUTO      = 'COD_PRODUTO';
  FLD_COMPRA_VALOR_COMPRA     = 'VALOR_COMPRA';
  FLD_COMPRA_DATA_HORA_COMPRA = 'DATA_HORA_COMPRA';

  { Relacionado a serialização }
  CNT_COMPRA_PRODUTO = 'PRODUTOO';

resourcestring
  STR_COMPRA = 'COMPRA';

implementation

uses
    SysUtils
  , Dialogs
  ;

{ TPrescricao }

constructor TCompra.Create(const coJSONObject: TJSONOBject);
begin
  inherited;
  with coJSONObject do
  begin
    PRODUTO          := TMEDICAMENTO.Create(TJSONObject(Get(CNT_COMPRA_PRODUTO).JsonValue));
    VALOR_COMPRA     := Get(FLD_COMPRA_VALOR_COMPRA).JsonValue.Value;
    DATA_HORA_COMPRA := StrToDateTime(Get(FLD_COMPRA_DATA_HORA_COMPRA).JsonValue.Value);
  end;
end;

function TCompra.RetornaJSON: TJSONOBject;
begin
  Result := Inherited;
  Result.AddPair(CNT_COMPRA_PRODUTO          , PRODUTO.RetornaJSON);
  Result.AddPair(FLD_COMPRA_VALOR_COMPRA     , VALOR_COMPRA);
  Result.AddPair(FLD_COMPRA_DATA_HORA_COMPRA , DateTimeToStr(DATA_HORA_COMPRA));
end;

end.
