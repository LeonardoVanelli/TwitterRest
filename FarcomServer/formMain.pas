(*
   ------------------------------------
   RestWebService - Ver�o 1.0

   Este Web service Application foi desenvolvido para possibilitar
   a exist�ncia de WebServices REST+JSON em Delphi na vers�o PROFESSIONAL
   a partir da XE2 na qual esta aplica��o foi desenvolvida :
     - sem a utiliza��o de Datasnap,
     - Sem necessidade de utiliza��o da Vers�o Enterprise do Delphi
     - Sem outros frameworks externos (free ou n�o)
   mas apenas utilizando o INDY que vem com o Delphi em todas as
   edi��es.

   Foi feito e testado na XE2 professional, mas � muito prov�vel
   que funcionar� em todas as vers�es posteriores at� o momento
   at� o momento a �ltima vers�o do Delphi � (ou �ra) a DX Seattle

   -----------------------------------
   Autor : Claudio Ferreira

   Licen�a :
     Livre para copiar, usar e melhorar, pe�o apenas que mantenha
     este cabe�alho

   Novas vers�es melhoradas acrescente aqui as melhorias e autoria

     ** Vers�o 1.0 - Claudio Ferreira
        1a. Vers�o
*)

unit formMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, ExtCtrls,
  IdBaseComponent, IdComponent, IdCustomTCPServer, IdCustomHTTPServer,
  IdHTTPServer, AppEvnts, IdContext, Buttons, DBXJson, IdTCPConnection,
  IdTCPClient, IdHTTP;

type
  TfrmMain = class(TForm)
    apl1: TApplicationEvents;
    IdHTTPServer1: TIdHTTPServer;
    TrayIcon1: TTrayIcon;
    txtInfoLabel: TStaticText;
    lblNome: TLabel;
    btnAtivar: TBitBtn;
    btnParar: TBitBtn;
    memoReq: TMemo;
    memoResp: TMemo;
    Label1: TLabel;
    Label2: TLabel;
    IdHTTP1: TIdHTTP;
    procedure TrayIcon1Click(Sender: TObject);
    procedure apl1Minimize(Sender: TObject);
    procedure btnAtivarClick(Sender: TObject);
    procedure btnPararClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure IdHTTPServer1CommandGet(AContext: TIdContext;
      ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
    procedure IdHTTPServer1CommandOther(AContext: TIdContext;
      ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
  private
    { Private declarations }
    procedure LoglastRequest (ARequestInfo: TIdHTTPRequestInfo);
    procedure LogLastResponse (AResponseInfo: TIdHTTPResponseInfo);
  public
    { Public declarations }

  end;

var
  frmMain: TfrmMain;
  CriticalSection: TRTLCriticalSection;

implementation

{$R *.dfm}

Uses
     Systypes, ServerUtils, ServerMethodsUnit1;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
     btnAtivarClick(self);
end;

procedure TfrmMain.TrayIcon1Click(Sender: TObject);
begin
     TrayIcon1.Visible := False;
     Show();
     WindowState := wsNormal;
     Application.BringToFront();
end;

procedure TfrmMain.apl1Minimize(Sender: TObject);
begin
     Self.Hide();
     Self.WindowState := wsMinimized;
     TrayIcon1.Visible := True;
     TrayIcon1.Animate := True;
     TrayIcon1.ShowBalloonHint;
end;

procedure TfrmMain.btnAtivarClick(Sender: TObject);
begin
     IdHTTPServer1.Active := True;
     txtInfoLabel.Caption := 'Aguardando requisi��es...';
end;


procedure TfrmMain.btnPararClick(Sender: TObject);
begin
     IdHTTPServer1.Active := False;
     txtInfoLabel.Caption := 'WebService parado.';
end;

procedure TfrmMain.LoglastRequest (ARequestInfo: TIdHTTPRequestInfo);
Begin
     EnterCriticalSection(CriticalSection);
     memoReq.Lines.Add(ARequestInfo.UserAgent + #13 + #10 +
                       ARequestInfo.RawHTTPCommand);
     LeaveCriticalSection(CriticalSection);
End;

procedure TfrmMain.LogLastResponse (AResponseInfo: TIdHTTPResponseInfo);
Begin
     EnterCriticalSection(CriticalSection);
     memoResp.Lines.Add(AResponseInfo.ContentText);
     LeaveCriticalSection(CriticalSection);
End;


procedure TfrmMain.IdHTTPServer1CommandGet(AContext: TIdContext;
  ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
Var
     Cmd           : String;
     Argumentos    : TArguments;
     ServerMethod1 : TServerMethods1;
     JSONStr       : string;
     Body          : TStringList;
     JSONObject    : TJSONObject;
begin
     Body := TStringList.Create;
     Cmd  := ARequestInfo.RawHTTPCommand;

     if (UpperCase(Copy (Cmd, 1, 3)) = 'GET') OR
        (UpperCase(Copy (Cmd, 1, 4)) = 'POST') OR
        (UpperCase(Copy (Cmd, 1, 3)) = 'HEAD') then
       Begin
        Argumentos    := TServerUtils.ParseRESTURL (ARequestInfo.URI);
        ServerMethod1 := TServerMethods1.Create (nil);
        Try
           LoglastRequest (ARequestInfo);
           If UpperCase(Copy (Cmd, 1, 3)) = 'GET' Then
              JSONStr := ServerMethod1.CallGETServerMethod(Argumentos
                                                         , ARequestInfo.QueryParams);
           if UpperCase(Copy (Cmd, 1, 4)) = 'POST' Then
             begin
               Body.LoadFromStream(ARequestInfo.PostStream);

               JSONObject := TJSONObject.ParseJSONValue(Body.Text) as TJSONObject;
               JSONStr    := ServerMethod1.CallPOSTServerMethod(Argumentos, JSONObject);
             end;

           AResponseInfo.ContentText := JSONStr;

           LoglastResponse (AResponseInfo);
           AResponseInfo.WriteContent;
        Finally
           ServerMethod1.Free;
        End;
     end;
 end;

// TRATE AQUI PUT E DELETE
procedure TfrmMain.IdHTTPServer1CommandOther(AContext: TIdContext;
  ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
Var
     Cmd           : String;
     Argumentos    : TArguments;
     ServerMethod1 : TServerMethods1;
     JSONStr       : string;
begin
     Cmd := ARequestInfo.RawHTTPCommand;
     if (UpperCase(Copy (Cmd, 1, 3)) = 'PUT') OR
        (UpperCase(Copy (Cmd, 1, 6)) = 'DELETE')
     then Begin
        Argumentos    := TServerUtils.ParseRESTURL (ARequestInfo.URI);
        ServerMethod1 := TServerMethods1.Create (nil);
        Try
           LoglastRequest (ARequestInfo);
           If UpperCase(Copy (Cmd, 1, 3)) = 'PUT' Then
              JSONStr := ServerMethod1.CallPUTServerMethod(Argumentos);
           If UpperCase(Copy (Cmd, 1, 6)) = 'DELETE' Then
              JSONStr := ServerMethod1.CallDELETEServerMethod(Argumentos);

           AResponseInfo.ContentText := JSONStr;
           LoglastResponse (AResponseInfo);
           AResponseInfo.WriteContent;
        Finally
           ServerMethod1.Free;
        End;
     end;
end;

initialization
  InitializeCriticalSection(CriticalSection);

finalization
  DeleteCriticalSection(CriticalSection);


end.
