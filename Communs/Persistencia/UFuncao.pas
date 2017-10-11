unit UFuncao;

interface

uses
    UEntidade
  , UUtilitarios
  , DBXJSON
  ;

type
  TFUNCAO = class(TEntidade)
  public
    NOME        : String;
    TIPO_SERVICO: String;//TTipoServico;

    constructor Create(const coJSONObject: TJSONOBject); override;

    function RetornaJSON: TJSONOBject; override;
  end;

const
  { Relacionado a tabela }
  TBL_FUNCAO                  = 'FUNCAO';
  FLD_FUNCAO_NOME             = 'NOME';
  FLD_FUNCAO_COD_FARMA_MEDICO = 'COD_FARMA_MEDICO';

  { Relacionado a serialiazação }

resourcestring
  STR_FUNCAO = 'Função';

implementation

{ TFUNCAO }

constructor TFUNCAO.Create(const coJSONObject: TJSONOBject);
begin
  inherited;
  with coJSONObject do
    begin
      NOME         := Get(FLD_FUNCAO_NOME).JsonValue.Value;
      TIPO_SERVICO := Get(FLD_FUNCAO_COD_FARMA_MEDICO).JsonValue.Value;
    end;
end;

function TFUNCAO.RetornaJSON: TJSONOBject;
begin
  Result := Inherited;
  Result.AddPair(FLD_FUNCAO_NOME             , NOME);
  Result.AddPair(FLD_FUNCAO_COD_FARMA_MEDICO , TIPO_SERVICO);
end;

end.
