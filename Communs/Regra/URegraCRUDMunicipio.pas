unit URegraCRUDMunicipio;

interface

uses
    URegraCRUD
  , UEntidade
  , UMunicipio
  ;

type
  TRegraCRUDMunicipio = class(TRegraCRUD)
  protected
    procedure ValidaInsercao(const coENTIDADE: TENTIDADE); override;
  end;

implementation

{ TRegraCRUDMunicipio }

uses
    SysUtils
  , UUtilitarios
  , UMensagens
  , UConstantes
  ;

procedure TRegraCRUDMunicipio.ValidaInsercao(const coENTIDADE: TENTIDADE);
begin
  inherited;

  if Trim(TMUNICIPIO(coENTIDADE).NOME) = EmptyStr Then
    raise EValidacaoNegocio.Create(STR_MUNICIPIO_NOME_NAO_INFORMADO);
end;

end.
