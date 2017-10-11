unit URepositorioJSON;

interface

uses
    SqlExpr
  , URepositorio
  , UEntidade
  , IdHTTP
  , Generics.Collections
  ;

type
  TRepositorioJSON<T: TENTIDADE, constructor> = class abstract (TInterfacedObject, IRepositorio<T>)
  private
    FNomeEntidade: String;
    FIdHTTP: TIdHTTP;

  protected
    FEntidadeClasse: TEntidadeClasse;
    FRecurso: String;

    function ExecutaRequisicaoObjeto(const csCaminho: String;
                                     const csParametros: String): TENTIDADE;

  public
    constructor Create(const EntidadeClasse: TEntidadeClasse;
                       const NomeEntidade: String;
                       const Recurso: String);

    ///Excluir o registro pela PK
    procedure Exclui(const ciPK: Integer); virtual;
    //Atualiza o registro com os dados do objeto
    procedure Atualiza(const coENTIDADE: T); virtual;
    //Insere um novo registro com os dados do objeto
    procedure Insere(const coENTIDADE: T); virtual;

    //Docs TO-DO
    function Retorna(const ciId: Integer): TENTIDADE; virtual;
    //Docs TO-DO
    function Achou(const ciPK: Integer): Boolean; virtual;
    //Docs TO-DO
    function RetornaNomeEntidade: String; virtual;
    //Docs TO-DO
    function RetornaTodos: TList<T>;

    property NOME_ENTIDADE: String read FNomeEntidade;
  end;

implementation

uses
    Forms
  , Classes
  , SysUtils
  , Dialogs
  , DBXJSON
  ;


{ TRepositorioJSON<T> }

function TRepositorioJSON<T>.Achou(const ciPK: Integer): Boolean;
begin
  Result := False;
end;

procedure TRepositorioJSON<T>.Atualiza(const coENTIDADE: T);
begin

end;

constructor TRepositorioJSON<T>.Create(const EntidadeClasse: TEntidadeClasse;
                                       const NomeEntidade: String;
                                       const Recurso: String);
begin
  FIdHTTP := TIdHTTP.Create(Application);
  FEntidadeClasse := EntidadeClasse;
  FRecurso := Recurso;
  FNomeEntidade := NomeEntidade;
end;

procedure TRepositorioJSON<T>.Exclui(const ciPK: Integer);
begin

end;

function TRepositorioJSON<T>.ExecutaRequisicaoObjeto(const csCaminho,
  csParametros: String): TENTIDADE;
var
  JSONObject: TJSONObject;
  Resposta: String;
begin
  FIdHTTP.Request.ContentType := 'application/json';
  FIdHTTP.Request.CharSet     := 'utf-8';
  Result := nil;
  try
     Resposta := FIdHTTP.Get('http://localhost:8080/' + FRecurso + csCaminho + csParametros);
     if (FIdHTTP.ResponseCode = 200)
     and (Resposta <> EmptyStr) then
       begin
         JSONObject := TJSONObject.ParseJSONValue(Resposta) as TJSONObject;
         Result     := FEntidadeClasse.Create(JSONObject);
       end;
  except
    on E: Exception do
      ShowMessage('Error on request: '#13#10 + e.Message);
  end;
end;

procedure TRepositorioJSON<T>.Insere(const coENTIDADE: T);
var
  JsonToSend: TStringStream;
  Body: String;
  Resposta: String;
  JSONObject: TJSONObject;
begin
  JsonToSend := TStringStream.Create(coENTIDADE.RetornaJSON.ToString, TEncoding.UTF8);
  try
    FIdHTTP.Request.ContentType := 'application/json';
    FIdHTTP.Request.CharSet     := 'utf-8';
    try
       Resposta := FIdHTTP.Post('http://localhost:8080/' + FRecurso, JsonToSend);
       JSONObject := TJSONObject.ParseJSONValue(Resposta) as TJSONObject;

       coENTIDADE.ID := StrToInt(JSONObject.Get('ID').JsonValue.Value);
    except
      on E: Exception do
        ShowMessage('Error on request: '#13#10 + e.Message);
    end;
  finally
    JsonToSend.Free;
  end;
end;

function TRepositorioJSON<T>.Retorna(const ciId: Integer): TENTIDADE;
begin
  ExecutaRequisicaoObjeto('/' + IntToStr(ciId), '');
end;

function TRepositorioJSON<T>.RetornaNomeEntidade: String;
begin
  Result := FNomeEntidade;
end;

function TRepositorioJSON<T>.RetornaTodos: TList<T>;
var
  Resposta: String;
  JSONArray: TJSONArray;
  JSONObject: TJSONObject;
  Indice: Integer;
begin
  Result := TList<T>.Create;

  FIdHTTP.Request.ContentType := 'application/json';
  FIdHTTP.Request.CharSet     := 'utf-8';
  try
     Resposta := FIdHTTP.Get('http://localhost:8080/' + FRecurso);
     if FIdHTTP.ResponseCode = 200 then
       begin
         JSONArray := TJSONObject.ParseJSONValue(Resposta) as TJSONArray;
         for Indice := 0 to Pred(JSONArray.Size) do
           Result.Add(FEntidadeClasse.Create(JSONArray.Get(Indice) as TJSONObject));
       end;
  except
    on E: Exception do
      ShowMessage('Error on request: '#13#10 + e.Message);
  end;
end;

end.
