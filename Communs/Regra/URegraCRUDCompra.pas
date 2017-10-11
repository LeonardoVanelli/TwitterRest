unit URegraCRUDCompra;

interface

uses
    URegraCRUD
  , URepositorio
  , UEntidade
  , UCompra
  ;

type
  TRegraCRUDCompra = class(TRegraCRUD)
  protected
    procedure ValidaInsercao(const coENTIDADE: TENTIDADE); override;
  end;

implementation

{ TRegraCRUDCidade }

uses
    SysUtils
  , UUtilitarios
  , UMensagens
  , UConstantes
  ;

procedure TRegraCRUDCompra.ValidaInsercao(const coENTIDADE: TENTIDADE);
begin
  inherited;
  // NOME
//  if Trim(TCLIENTE(coENTIDADE).NOME) = EmptyStr Then
//    raise EValidacaoNegocio.Create(Format(STR_CAMPO_NAO_INFORMADO, ['Nome']));
//
//  // CPF
//  if IntToStr(Trim(TCLIENTE(coENTIDADE).CPF)) = EmptyStr then
//    raise EValidacaoNegocio.CreateFmt(Format(STR_CAMPO_NAO_INFORMADO, ['Cpf']));
end;

end.
