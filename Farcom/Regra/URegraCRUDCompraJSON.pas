unit URegraCRUDCompraJSON;

interface

uses
    URegraCRUD
  , URegraCRUDCompra
  , URepositorioJSON
  , URepositorioCompraJSON
  , UEntidade
  , UCompra
  ;

type
  TRegraCRUDCompraJSON = class(TRegraCRUDCompra)
  public
    constructor Create; override;
  end;

implementation

{ TRegraCRUDClienteJSON }

constructor TRegraCRUDCompraJSON.Create;
begin
  inherited;
  FRepositorio := TRepositorioJSON<TENTIDADE>(TRepositorioCompraJSON.Create);
end;

end.
