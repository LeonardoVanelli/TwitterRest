unit ServerMethodsUnit1;

interface

uses SysUtils, Classes, UDM,
     {$IFDEF VER220}
         DBXJSON,
     {$ENDIF}

     {$IFDEF VER230}   // XE2
         Data.DBXJSON,
     {$ENDIF}

     {$IFDEF VER280}   // XE7
         System.JSON,
     {$ENDIF}

     {$IFDEF VER290}   // XE8
         System.JSON,
     {$ENDIF}

     {$IFDEF VER300}   // SEATTLE
         System.JSON,
     {$ENDIF}

     Dialogs, ServerUtils, SysTypes;

type
  {$METHODINFO ON}
  TServerMethods1 = class(TComponent)
  private
    { Private declarations }
    Function ReturnErro : String;

    // http://localhost:8080/InsereAluno/fulano
    function InsereAluno (NomeAluno : String) : String;

//    // http://localhost:8080/ConsultaAluno/fulano
//    function ConsultaAluno (NomeAluno : String) : String;
//
//    // http://localhost:8080/GetListaAlunos
//    function GetListaAlunos : String;
//
//    // http://localhost:8080/AtualizaAluno/Fulano/cicrano
//    function AtualizaAluno (OldNomeAluno, NewNome : String) : String;
//
//    // http://localhost:8080/ExcluiAluno/NomeAluno
//    function ExcluiAluno (NomeAluno : String) : String;



    function TrataGetClientes(Argumentos : TArguments; QueryParameters: TStringList): String;
    function TrataGetCliente(Argumentos : TArguments; QueryParameters: TStringList): String;
    function TrataGetFuncionarios(Argumentos : TArguments; QueryParameters: TStringLIst): String;
    function TrataGetMedicamento(Argumentos : TArguments; QueryParameters: TStringList): String;
    function TrataGetCompras(Argumentos : TArguments; QueryParameters: TStringList): String;
    function TrataGetPrescricoes(Argumentos : TArguments; QueryParameters: TStringList): String;

  public
    { Public declarations }
    constructor Create (aOwner : TComponent); Override;
    destructor Destroy; override;

    function CallGETServerMethod (Argumentos : TArguments; QueryParameters: String) : String;
    function CallPUTServerMethod (Argumentos : TArguments) : string;
    function CallDELETEServerMethod (Argumentos : TArguments) : string;
    function CallPOSTServerMethod (Argumentos : TArguments; Body: TJSONObject) : string;
  end;
{$METHODINFO OFF}

const
  STR_SELECT_DB = 'select * from %s';

implementation


uses
    StrUtils
  , UCliente
  , UFuncionario
  , UMedicamento
  , UPrescricao
  , URegraCRUDClienteDB
  , URegraCRUDPrescricaoDB
  , URepositorioClienteDB
  , URepositorioFuncionarioDB
  , URepositorioMedicamentoDB
  , URepositorioPrescricaoDB
  , Windows
  ;

Constructor TServerMethods1.Create (aOwner : TComponent);
Begin
     inherited Create (aOwner);
End;

Destructor TServerMethods1.Destroy;
begin
     inherited;
End;

Function TServerMethods1.ReturnErro : String;
Var
     WSResult : TResultErro;
begin
     WSResult.STATUS   := -1;
     WSResult.MENSAGEM := 'Total de argumentos incorretos';
     Result := TServerUtils.Result2JSON(WSResult);
end;

function TServerMethods1.TrataGetCliente(Argumentos: TArguments;
  QueryParameters: TStringList): String;
var
  RepositorioMedicamentoDB: TRepositorioMedicamento;
  FCLIENTE: TCLIENTE;
begin
  RepositorioMedicamentoDB := TRepositorioMedicamento.Create;
  try
    FCLIENTE := TCLIENTE(RepositorioMedicamentoDB.Retorna(StrToInt(QueryParameters.values['ID'])));
    Result   := FCLIENTE.RetornaJSON.ToString;
  finally
    FreeAndNil(RepositorioMedicamentoDB);
  end;
end;

function TServerMethods1.TrataGetClientes(Argumentos: TArguments; QueryParameters: TStringList): String;
var
  JSONArray: TJSONArray;
  RepositorioClienteDB: TRepositorioClienteDB;
  CLIENTE: TCLIENTE;
begin
  RepositorioClienteDB := TRepositorioClienteDB.Create;
  Result := '';
  try
    if Length(Argumentos) = 2 then
      begin
        CLIENTE := TCLIENTE(RepositorioClienteDB.Retorna(StrToInt(Argumentos[1])));
        if Assigned(CLIENTE) then
          Result := CLIENTE.RetornaJSON.ToString;
      end
    else
      begin
        JSONArray := TJSONArray.Create;
        for CLIENTE in RepositorioClienteDB.RetornaTodos do
          JSONArray.Add(CLIENTE.RetornaJSON);
        Result := JSONArray.ToString;
      end;
  finally
    FreeAndNil(RepositorioClienteDB);
  end;
end;

function TServerMethods1.TrataGetCompras(Argumentos: TArguments;
  QueryParameters: TStringList): String;
begin
end;

function TServerMethods1.TrataGetFuncionarios(Argumentos: TArguments; QueryParameters: TStringList): String;
var
  RepositorioFuncionarioDB: TRepositorioFuncionarioDB;
  FUNCIONARIO: TFUNCIONARIO;
begin
  RepositorioFuncionarioDB := TRepositorioFuncionarioDB.Create;
  try
    FUNCIONARIO := TFUNCIONARIO(RepositorioFuncionarioDB.RetornaPeloCPF(QueryParameters.Values['CPF']));
    Result      := FUNCIONARIO.RetornaJSON.ToString;
  finally
    FreeAndNil(RepositorioFuncionarioDB);
  end;
end;


function TServerMethods1.TrataGetMedicamento(Argumentos: TArguments;
  QueryParameters: TStringList): String;
var
  RepositorioMedicamentoDB: TRepositorioMedicamento;
  FMEDICAMENTO: TMEDICAMENTO;
begin
  RepositorioMedicamentoDB := TRepositorioMedicamento.Create;
  try
    FMEDICAMENTO := TMEDICAMENTO(RepositorioMedicamentoDB.Retorna(StrToInt(QueryParameters.values['ID'])));
    Result       := FMEDICAMENTO.RetornaJSON.ToString;
  finally
    FreeAndNil(RepositorioMedicamentoDB);
  end;
end;

function TServerMethods1.TrataGetPrescricoes(Argumentos: TArguments;
  QueryParameters: TStringList): String;
var
  JSONArray: TJSONArray;
  RepositorioPrescricaoDB: TRepositorioPrescricaoDB;
  PRESCRICAO: TPRESCRICAO;
begin
  RepositorioPrescricaoDB := TRepositorioPrescricaoDB.Create;
  try
    if Length(Argumentos) = 2 then
      begin
        PRESCRICAO := TPRESCRICAO(RepositorioPrescricaoDB.Retorna(StrToInt(Argumentos[1])));
        Result  := PRESCRICAO.RetornaJSON.ToString;
      end
    else
      begin
        JSONArray := TJSONArray.Create;
        for PRESCRICAO in RepositorioPrescricaoDB.RetornaTodos do
          JSONArray.Add(PRESCRICAO.RetornaJSON);
        Result := JSONArray.ToString;
      end;
  finally
    FreeAndNil(RepositorioPrescricaoDB);
  end;
end;

function TServerMethods1.CallGETServerMethod (Argumentos : TArguments;
                                              QueryParameters: String) : string;
var
  Parameters: TStringList;
begin
  Parameters := TStringList.Create;
  Parameters.Add(QueryParameters);
  try
    if UpperCase(Argumentos[0]) = UpperCase('clientes') then
      Result := TrataGetClientes(Argumentos, Parameters)
    else if UpperCase(Argumentos[0]) = UpperCase('funcionarios') then
      Result := TrataGetFuncionarios(Argumentos, Parameters)
    else if UpperCase(Argumentos[0]) = UpperCase('medicamentos') then
      Result := TrataGetMedicamento(Argumentos, Parameters)
    else if UpperCase(Argumentos[0]) = UpperCase('compras') then
      Result := TrataGetCompras(Argumentos, Parameters)
    else if  UpperCase(Argumentos[0]) = UpperCase('prescricoes') then
      Result := TrataGetPrescricoes(Argumentos, Parameters)
    else if UpperCase(Argumentos[0]) = UpperCase('cliente') then
      Result := TrataGetCliente(Argumentos, Parameters)


  finally
    FreeAndNil(Parameters);
  end;
end;

function TServerMethods1.CallPOSTServerMethod (Argumentos : TArguments; Body: TJSONObject) : string;
var
  loCLIENTE: TCLIENTE;
  loRegraCRUDCliente: TRegraCRUDClienteDB;
  loPRESCRICAO: TPRESCRICAO;
  loRegraCRUDPrescricao: TRegraCRUDPrescricaoDB;
begin
  if UpperCase(Argumentos[0]) = UpperCase('clientes') then
    begin
      loCLIENTE := TCLIENTE.Create(Body);
      loRegraCRUDCliente := TRegraCRUDClienteDB.Create;
      try
        loRegraCRUDCliente.Insere(loCLIENTE);
        Result := loCLIENTE.RetornaJSON.ToString;
      finally
        FreeAndNil(loCLIENTE);
        FreeAndNil(loRegraCRUDCliente);
      end;
    end;
  if UpperCase(Argumentos[0]) = UpperCase('prescricoes') then
    begin
      loPRESCRICAO := TPRESCRICAO.Create(Body);
      loRegraCRUDPrescricao := TRegraCRUDPrescricaoDB.Create;
      try
        loRegraCRUDPrescricao.Insere(loPRESCRICAO);
        Result := loPRESCRICAO.RetornaJSON.ToString;
      finally
        FreeAndNil(loPRESCRICAO);
        FreeAndNil(loRegraCRUDPrescricao);
      end;
    end;
end;

function TServerMethods1.CallPUTServerMethod (Argumentos : TArguments) : string;
begin
     if UpperCase(Argumentos[0]) = UpperCase('InsereAluno') then begin
        if Length (Argumentos) = 2 then
           Result := InsereAluno (Argumentos[1])
        Else
           Result := ReturnErro;
     end;
end;

function TServerMethods1.CallDELETEServerMethod (Argumentos : TArguments) : string;
begin
end;

// Aqui voce vai
// 1 - Conectar com o Banco
// 2 - Executar a query
// 3 - Fechar conexão com o banco
// 4 - Retornar o resultado em JSON

// Foi usado um Arquivo Texto para armazenar dados e um StringList
// o objetivo aqui é apenas mostrar como é um WebService REST + JSON
// e suas operações, o codigo de banco fica por sua conta.

function TServerMethods1.InsereAluno (NomeAluno : String) : String;
Var
     List : TStringList;
     JSONObject : TJSONObject;
Begin
     List       := TStringList.Create;
     JSONObject := TJSONObject.Create;
     try
         if Not FileExists (ExtractFilePath(ParamStr(0)) + '\Alunos.Txt') then
            FileClose(FileCreate (ExtractFilePath(ParamStr(0)) + '\Alunos.Txt'));

         List.LoadFromFile(ExtractFilePath(ParamStr(0)) + '\Alunos.Txt');
         List.Add (NomeAluno);
         List.SaveToFile(ExtractFilePath(ParamStr(0)) + '\Alunos.Txt');

         JSONObject.AddPair(TJSONPair.Create('STATUS', 'OK'));
         JSONObject.AddPair(TJSONPair.Create('MENSAGEM', 'Inserido com sucesso'));
         Result := JSONObject.ToString;
     Finally
         List.Free;
         JSONObject.Free;
     end;
End;

//function TServerMethods1.ConsultaAluno (NomeAluno : String) : String;
//Var
//     List : TStringList;
//     JSONObject : TJSONObject;
//     ID : Integer;
//Begin
//     List := TStringList.Create;
//     JSONObject := TJSONObject.Create;
//     try
//         List.LoadFromFile(ExtractFilePath(ParamStr(0)) + '\Alunos.Txt');
//         ID := List.IndexOf(NomeAluno);
//         if ID > -1 then Begin
//            JSONObject.AddPair(TJSONPair.Create('ID', IntToStr (ID)));
//         end else begin
//            JSONObject.AddPair(TJSONPair.Create('STATUS', 'OK'));
//            JSONObject.AddPair(TJSONPair.Create('MENSAGEM', 'Não encontrado'));
//            Result := JSONObject.ToString;
//         end;
//         Result := JSONObject.ToString;
//     Finally
//         List.Free;
//         JSONObject.Free;
//     end;
//end;
//
//function TServerMethods1.GetListaAlunos : String;
//Var
//     List        : TStringList;
//     ID          : Integer;
//     LJson       : TJSONObject;
//     LJsonObject : TJSONObject;
//     LArr        : TJSONArray;
//Begin
//     List        := TStringList.Create;
//     LJsonObject := TJSONObject.Create;
//     LArr        := TJSONArray.Create;
//     try
//         List.LoadFromFile(ExtractFilePath(ParamStr(0)) + '\Alunos.Txt');
//         for Id := 0 to List.Count - 1 do Begin
//             LJson := TJSONObject.Create;
//             LJson.AddPair(TJSONPair.Create('NomeAluno', List [ID]));
//             LArr.Add(LJson);
//         End;
//         LJsonObject.AddPair(TJSONPair.Create('Alunos', LArr));
//         Result := LJsonObject.ToString;
//     Finally
//         List.Free;
//         LJsonObject.Free;
//     end;
//end;
//
//function TServerMethods1.AtualizaAluno (OldNomeAluno, NewNome : String) : String;
//Var
//     List       : TStringList;
//     JSONObject : TJSONObject;
//     ID         : Integer;
//Begin
//     List := TStringList.Create;
//     JSONObject := TJSONObject.Create;
//     try
//         List.LoadFromFile(ExtractFilePath(ParamStr(0)) + '\Alunos.Txt');
//         ID := List.IndexOf(OldNomeAluno);
//         if ID > -1 then Begin
//            List[ID] := NewNome;
//            List.SaveToFile(ExtractFilePath(ParamStr(0)) + '\Alunos.Txt');
//            JSONObject.AddPair(TJSONPair.Create('STATUS', 'OK'));
//            JSONObject.AddPair(TJSONPair.Create('MENSAGEM', 'Atualizado com sucesso'));
//         End else begin
//            JSONObject.AddPair(TJSONPair.Create('STATUS', 'OK'));
//            JSONObject.AddPair(TJSONPair.Create('MENSAGEM', 'Aluno não encontrado'));
//         end;
//         Result := JSONObject.ToString;
//     Finally
//         List.Free;
//         JSONObject.Free;
//     end;
//end;
//
//function TServerMethods1.ExcluiAluno (NomeAluno : String) : String;
//Var
//     List       : TStringList;
//     JSONObject : TJSONObject;
//     ID         : Integer;
//Begin
//     List := TStringList.Create;
//     JSONObject := TJSONObject.Create;
//     try
//         List.LoadFromFile(ExtractFilePath(ParamStr(0)) + '\Alunos.Txt');
//         ID := List.IndexOf(NomeAluno);
//         if ID > -1 then Begin
//            List.Delete(ID);
//            List.SaveToFile(ExtractFilePath(ParamStr(0)) + '\Alunos.Txt');
//            JSONObject.AddPair(TJSONPair.Create('STATUS', 'OK'));
//            JSONObject.AddPair(TJSONPair.Create('MENSAGEM', 'Deletado com sucesso'));
//         End else begin
//            JSONObject.AddPair(TJSONPair.Create('STATUS', 'OK'));
//            JSONObject.AddPair(TJSONPair.Create('MENSAGEM', 'Aluno não encontrado'));
//         end;
//         Result := JSONObject.ToString;
//     Finally
//         List.Free;
//         JSONObject.Free;
//     end;
//end;


end.



