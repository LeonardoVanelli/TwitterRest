unit UPrescricao;

interface

uses
    UEntidade
  , UFuncionario
  , UCliente
  , UProduto
  , DBXJSON
  ;

type
  TPrescricao = class(TENTIDADE)
  public
    FUNCIONARIO           : TFUNCIONARIO;
    CLIENTE               : TCLIENTE;
    MEDICAMENTO           : TMEDICAMENTO;
    DESCRICAO             : String;
    DATA_HORA_PRESCRITA   : TDateTime;
    DATA_HORA_VENCIMENTO  : TDate;

    constructor Create(const coJSONObject: TJSONOBject); override;

    function RetornaJSON: TJSONOBject; override;
  end;

const
  { Relacionado a tabela }
  TBL_PRESCRICAO                      = 'PRESCRICAO';
  FLD_PRESCRICAO_COD_FUNCIONARIO      = 'COD_FUNCIONARIO';
  FLD_PRESCRICAO_COD_CLIENTE          = 'COD_CLIENTE';
  FLD_PRESCRICAO_COD_MEDICAMENTO      = 'COD_MEDICAMENTO';
  FLD_PRESCRICAO_DESCRICAO            = 'DESCRICAO';
  FLD_PRESCRICAO_DATA_HORA_PRESCRITA  = 'DATA_HORA_PRESCRITA';
  FLD_PRESCRICAO_DATA_HORA_VENCIMENTO = 'DATA_VENCIMENTO';

    { Relacionado a serialização }
  CNT_PRESCRICAO_FUNCIONARIO = 'FUNCIONARIO';
  CNT_PRESCRICAO_MEDICAMENTO = 'MEDICAMENTO';
  CNT_PRESCRICAO_CLIENTE = 'CLIENTE';

resourcestring
  STR_PRESCRICAO = 'Prescricao';

implementation

uses
    SysUtils
  , Dialogs
  ;

{ TPrescricao }

{ TPrescricao }

constructor TPrescricao.Create(const coJSONObject: TJSONOBject);
begin
  inherited;
 with coJSONObject do
  begin
    FUNCIONARIO          := TFUNCIONARIO.Create(TJSONObject(Get(CNT_PRESCRICAO_FUNCIONARIO).JsonValue));
    CLIENTE              := TCLIENTE.Create(TJSONObject(Get(CNT_PRESCRICAO_CLIENTE).JsonValue));
    MEDICAMENTO          := TMEDICAMENTO.Create(TJSONObject(Get(CNT_PRESCRICAO_MEDICAMENTO).JsonValue));
    DESCRICAO            := Get(FLD_PRESCRICAO_DESCRICAO).JsonValue.Value;
    DATA_HORA_PRESCRITA  := StrToDate(Get(FLD_PRESCRICAO_DATA_HORA_PRESCRITA).JsonValue.Value);
    DATA_HORA_VENCIMENTO := StrToDate(Get(FLD_PRESCRICAO_DATA_HORA_VENCIMENTO).JsonValue.Value);

  end;
end;

function TPrescricao.RetornaJSON: TJSONOBject;
begin
  Result := Inherited;
  Result.AddPair(CNT_PRESCRICAO_FUNCIONARIO         , FUNCIONARIO.RetornaJSON);
  Result.AddPair(CNT_PRESCRICAO_CLIENTE             , CLIENTE.RetornaJSON);
  Result.AddPair(CNT_PRESCRICAO_MEDICAMENTO         , MEDICAMENTO.RetornaJSON);
  Result.AddPair(FLD_PRESCRICAO_DESCRICAO           , DESCRICAO);
  Result.AddPair(FLD_PRESCRICAO_DATA_HORA_PRESCRITA , DateToStr(DATA_HORA_PRESCRITA));
  Result.AddPair(FLD_PRESCRICAO_DATA_HORA_VENCIMENTO, DateToStr(DATA_HORA_VENCIMENTO));
end;

end.
