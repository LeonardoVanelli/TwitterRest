unit UDialogo;

interface

uses
    Windows
  , SysUtils
  ;

type
  TDialogo = class
  public
    class procedure Informacao(const csMensagem: String);
    class procedure Alerta(const csMensagem: String);
    class procedure Erro(const csMensagem: String);
    class procedure Excecao(const coExcecao: Exception);

    class function Questiona(const csMensagem: String): Boolean; overload;
    class function Questiona(const csMensagem: String; const caArgumentos: array of const): Boolean; overload;
  end;

resourcestring
  STR_ATENCAO = 'Atenção';

implementation

uses
    Forms
  , UUtilitarios
  ;

{ TDialogo }

class procedure TDialogo.Alerta(const csMensagem: String);
begin
  Application.MessageBox(PChar(csMensagem)
                       , PChar(STR_ATENCAO)
                       , MB_OK Or MB_ICONWARNING);
end;

class procedure TDialogo.Erro(const csMensagem: String);
begin
  Application.MessageBox(PChar(csMensagem)
                       , PChar(STR_ATENCAO)
                       , MB_OK Or MB_ICONERROR);
end;

class procedure TDialogo.Excecao(const coExcecao: Exception);
begin
  if coExcecao is EValidacaoNegocio then
    TDialogo.Alerta(coExcecao.Message)
  else
    TDialogo.Erro(coExcecao.Message);
end;

class procedure TDialogo.Informacao(const csMensagem: String);
begin
  Application.MessageBox(PChar(csMensagem)
                       , PChar(STR_ATENCAO)
                       , MB_OK Or MB_ICONINFORMATION);
end;

class function TDialogo.Questiona(const csMensagem: String; const caArgumentos: array of const): Boolean;
begin
  Result := Application.MessageBox(PChar(Format(csMensagem, caArgumentos))
                                 , PChar(STR_ATENCAO)
                                 , MB_YESNO Or MB_ICONQUESTION) = IDYES;
end;

class function TDialogo.Questiona(const csMensagem: String): Boolean;
begin
  Result := Application.MessageBox(PChar(csMensagem)
                                 , PChar(STR_ATENCAO)
                                 , MB_YESNO Or MB_ICONQUESTION) = IDYES;
end;

end.
