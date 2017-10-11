unit UMunicipio;

interface

uses
    UEntidade
  , DBXJSON
  ;

type
  TMUNICIPIO = class (TENTIDADE)
  public
    NOME : String;
    UF   : String;

    constructor Create(const coJSONObject: TJSONOBject); override;

    function RetornaJSON: TJSONOBject; override;
  end;

const
  TBL_MUNICIPIO       = 'MUNICIPIO';
  FLD_MUNICIPIO_NOME  = 'NOME';
  FLD_MUNICIPIO_UF    = 'UF';

resourcestring
  STR_MUNICIPIO = 'Municipio';

implementation

{ TMUNICIPIO }

//Deserialization
constructor TMUNICIPIO.Create(const coJSONObject: TJSONObject);
begin
  inherited;

  if Assigned(coJSONObject.Get(FLD_MUNICIPIO_NOME)) then
    NOME := coJSONObject.Get(FLD_MUNICIPIO_NOME).JsonValue.Value;

  if Assigned(coJSONObject.Get(FLD_MUNICIPIO_UF)) then
    UF := coJSONObject.Get(FLD_MUNICIPIO_UF).JsonValue.Value;
end;

//Serialization
function TMUNICIPIO.RetornaJSON: TJSONOBject;
//var
//  JSONMedicamentos: TJSONArray;
begin
  Result := inherited;
  Result.AddPair(FLD_MUNICIPIO_NOME, NOME);
  Result.AddPair(FLD_MUNICIPIO_UF  , UF);

//  JSONMedicamentos := TJSONArray.Create;

//  while
//    JSONMedicamentos.Add(MEDICAMENTO.RetornaJSON);
//  end;

//  Result.AddPair(CNT_MEDICAMENTOS, JSONMedicamentos);
end;

end.
