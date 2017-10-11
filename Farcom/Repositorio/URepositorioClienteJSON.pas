unit URepositorioClienteJSON;

interface

uses
    URepositorioJSON
  , UCliente
  , UEntidade
  ;

type
  TRepositorioClienteJSON = class(TRepositorioJSON<TCLIENTE>)
  public
    constructor Create;

    function RetornaPeloID(const csID: Integer): TCLIENTE;
  end;

implementation

uses
    SysUtils
  ;

{ TRepositorioClienteJSON }

constructor TRepositorioClienteJSON.Create;
begin
  Inherited Create(TCLIENTE, STR_CLIENTE, 'clientes');
end;

function TRepositorioClienteJSON.RetornaPeloID(const csID: Integer): TCLIENTE;
begin
  Result := TCLIENTE(ExecutaRequisicaoObjeto('/' + IntToStr(csID), ''));
end;

end.
