unit URegraCRUDClienteJSON;

interface

uses
    URegraCRUD
  , URegraCRUDCliente
  , URepositorioJSON
  , URepositorioClienteJSON
  , UEntidade
  , UCliente
  ;

type
  TRegraCRUDClienteJSON = class(TRegraCRUDCliente)
  public
    constructor Create; override;
  end;

implementation

{ TRegraCRUDClienteJSON }

constructor TRegraCRUDClienteJSON.Create;
begin
  inherited;
  FRepositorio := TRepositorioJSON<TENTIDADE>(TRepositorioClienteJSON.Create);
end;

end.
