unit UTurno;

interface

uses
    UEntidade
  , DBXJSON
  ;

type
  TTURNO = class(TENTIDADE)
  public
    NOME : String;
    HORA_INICIO : TTime;
    HORA_TERMINO : TTime;

    constructor Create(const coJSONObject: TJSONOBject); override;

    function RetornaJSON: TJSONOBject; override;
  end;

const
  { Relacionado a tabela }
  TBL_TURNO = 'TURNO';
  FLD_TURNO_NOME = 'NOME';
  FLD_TURNO_HORA_INICIO = 'HORA_INICIO';
  FLD_TURNO_HORA_TERMINO = 'HORA_TERMINO';

  { Relacionado a serialiazação }
  CNT_CLIENTE_MUNICIPIO = 'TURNO';

resourcestring
  STR_TURNO = 'Turno';

implementation

uses
  sysUtils;

{ TTURNO }

constructor TTURNO.Create(const coJSONObject: TJSONOBject);
begin
  inherited;
  with coJSONObject do
    begin
      NOME         := Get(FLD_TURNO_NOME).JsonValue.Value;
      HORA_INICIO  := StrToTime(Get(FLD_TURNO_HORA_INICIO).JsonValue.Value);
      HORA_TERMINO := StrToTime(Get(FLD_TURNO_HORA_TERMINO).JsonValue.Value);
    end;
end;

function TTURNO.RetornaJSON: TJSONOBject;
begin
  Result := Inherited;
  Result.AddPair(FLD_TURNO_NOME        , NOME);
  Result.AddPair(FLD_TURNO_HORA_INICIO , TimeToStr(HORA_INICIO));
  Result.AddPair(FLD_TURNO_HORA_TERMINO, TimeToStr(HORA_TERMINO));
end;

end.
