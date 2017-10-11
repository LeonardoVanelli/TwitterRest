unit URepositorioMunicipioJSON;

interface

uses
    URepositorio
  , UMunicipio
  , UEntidade
  , URepositorioJSON
  ;

type
  TRepositorioMunicipioJSON = class(TRepositorioJSON<TMUNICIPIO>)
  public
    constructor Create;
  end;

implementation

uses
    SysUtils
  ;

{ TRepositorioMunicipioJSON }

constructor TRepositorioMunicipioJSON.Create;
begin
  Inherited Create(TMUNICIPIO, TBL_MUNICIPIO, 'municipios');
end;

end.
