unit UUsuarioTwitter;

interface

uses
  UEntidade;


type
  TUSUARIOTWITTER = class (TENTIDADE)

  public
    NOME   : String;
    LOGIN  : String;
    SENHA  : String;
    ARROBA : String;
    EMAIL  : String;
  end;
const
    TBL_USUARIO            = 'USUARIO';
    FLD_USUARIO_NOME       = 'NOME';
    FLD_USUARIO_LOGIN      = 'LOGIN';
    FLD_USUARIO_SENHA      = 'SENHA';
    FLD_USUARIO_ARROBA     = 'ARROBA';
    FLD_USUARIO_EMAIL      = 'EMAIL';

resourcestring

   STR_USUARIO  = 'Usuario do Twitter';

implementation

end.
