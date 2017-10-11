unit URepositorioCompraJSON;

interface

uses
    URepositorioJSON
  , UCompra
  , UEntidade
  ;

type
  TRepositorioCompraJSON = class(TRepositorioJSON<TCOMPRA>)
  public
    constructor Create;
  end;

implementation

uses
    SysUtils
  ;

{ TRepositorioClienteJSON }

constructor TRepositorioCompraJSON.Create;
begin
  Inherited Create(TCOMPRA, TBL_COMPRA, 'compras');
end;


end.
