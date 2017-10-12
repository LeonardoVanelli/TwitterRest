unit UTwits;

interface

uses
   UEntidade
  ,UUsuarioTwitter
  ,SysUtils
  ;


type
  TTWITS = class (TENTIDADE)

  public
    NOME_TW   : String;
    MENSAGEM  : String;
    ARROBA_TW : TUSUARIOTWITTER;
    DATA      : TDate;

    constructor Create; override;
    destructor destroy; override;
  end;
const
    TBL_TWITS              = 'TWITS';
    FLD_TWITS_NOME         = 'NOME_TW';
    FLD_TWITS_MENSAGEM     = 'MENSAGEM';
    FLD_TWITS_ARROBA       = 'ARROBA_TW';
    FLD_TWITS_DATA         = 'DATA';

resourcestring

   STR_TWITS  = 'TWITADAS DO USUARIO';

implementation

{ TTWITS }

constructor TTWITS.Create;
begin
  inherited;
  ARROBA_TW := TUSUARIOTWITTER.CREATE;
end;

destructor TTWITS.destroy;
begin
   FREEANDNIL(ARROBA_TW);
  inherited;
end;

end.
