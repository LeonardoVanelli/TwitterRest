unit UFrmPrincipalTwitter;
 {WARN SYMBOL_PLATFORM OFF}
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ButtonGroup, ComCtrls, Buttons, ImgList, jpeg,
  Menus;

type
  TfrmPrincipalTwitter = class(TForm)
    pnlCabecalho: TPanel;
    btnBaidwitar: TButton;
    btnFiltrar: TButton;
    meConsole: TMemo;
    stpFiltro: TSplitter;
    pnlMenu: TPanel;
    edFiltrar: TEdit;
    pnlFiltro: TPanel;
    meFiltro: TMemo;
    lblBVAB: TLabel;
    Timer1: TTimer;
    lblResultadosEncontrados: TLabel;
    stFiltroHashtag: TStaticText;
    stLimiteCaracter: TStaticText;
    stArroba: TStaticText;
    stNomeUsuario: TStaticText;
    stTrendingTopic1: TStaticText;
    stTrendingTopic2: TStaticText;
    stTrendingTopic3: TStaticText;
    stTrendingTopic4: TStaticText;
    stTrendingTopic5: TStaticText;
    imgMenu: TImage;
    pnlTrendingTopics: TPanel;
    stTrendingTopics: TStaticText;
    stLogo: TStaticText;
    mePostar: TMemo;
    mmMenu: TMainMenu;
    mOpcoes: TMenuItem;
    mSair: TMenuItem;
    mSalvar: TMenuItem;
    mCarregar: TMenuItem;
    btnMinimizarFiltro: TButton;
    imgPerfil: TImage;
    mMudarCor: TMenuItem;
    procedure btnBaidwitarClick(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure btnFiltrarClick(Sender: TObject);
    procedure lblTrendingTopic1Click(Sender: TObject);
    procedure stTrendingTopic5Click(Sender: TObject);
    procedure stTrendingTopic1Click(Sender: TObject);
    procedure stTrendingTopic2Click(Sender: TObject);
    procedure stTrendingTopic3Click(Sender: TObject);
    procedure stTrendingTopic4Click(Sender: TObject);
    procedure stTrendingTopic1MouseEnter(Sender: TObject);
    procedure stTrendingTopic1MouseLeave(Sender: TObject);
    procedure stTrendingTopic2MouseEnter(Sender: TObject);
    procedure stTrendingTopic2MouseLeave(Sender: TObject);
    procedure stTrendingTopic3MouseEnter(Sender: TObject);
    procedure stTrendingTopic3MouseLeave(Sender: TObject);
    procedure stTrendingTopic4MouseLeave(Sender: TObject);
    procedure stTrendingTopic4MouseEnter(Sender: TObject);
    procedure stTrendingTopic5MouseEnter(Sender: TObject);
    procedure stTrendingTopic5MouseLeave(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure mePostarClick(Sender: TObject);
    procedure mePostarChange(Sender: TObject);
    procedure mSairClick(Sender: TObject);
    procedure btnMinimizarFiltroClick(Sender: TObject);
    procedure FormStartDock(Sender: TObject; var DragObject: TDragDockObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure mMudarCorClick(Sender: TObject);
  private
    ListaTweets: Tarray<string>;
    SalvarTweets: TStringList;
    MemoriaTweetsComHashtag: Tarray<string>;
    hashtags: Tarray<string>;
    ResultadosEncontrados: integer;

    procedure HashtagETweet(hashtag: string; locarTweet: integer);
    procedure AtualizarTrendingTopic(hashtag: string);
    procedure AcharHashtag;
    procedure AtualizaMemo;
    procedure SepararTweetComHashtag(IeDoTweet: integer);
    procedure OrdenarTrendingTopic(value: Tarray<integer>; keys: Tarray<string>);
  public
    { Public declarations }
  end;
var
  frmPrincipalTwitter: TfrmPrincipalTwitter;

implementation

uses
    RegularExpressions
  , Generics.Collections
  , UFrmPrincipal;

const
  CNT_RESU_ENCO = '» Foram encontrados %d resultados para sua pesquisa';
  CNT_NOVO_TWEET = '• %s %s » %s : %s';
  CNT_ESCREVER_MEMO = 'No que você esta pensando?';

{$R *.dfm}

procedure TfrmPrincipalTwitter.AtualizaMemo;
var
  i: integer;
begin
  meConsole.Lines.Clear;
  for I := Low(ListaTweets) to High(ListaTweets) do
    begin
      meConsole.Lines.Add('════════════════════════════════════════════════════════════');
      meConsole.Lines.Add(ListaTweets[i]);
      meConsole.Lines.Add('════════════════════════════════════════════════════════════');
    end;
end;

procedure TfrmPrincipalTwitter.AtualizarTrendingTopic(hashtag: string);
var
  keys: Tarray<string>; Values: Tarray<integer>;
  TrendingTopic: TDictionary<String, Integer>;
  Quantidade, i: integer;
  chave: string;
begin
  TrendingTopic := TDictionary<String, Integer>.Create;
  for I := Low(hashtags) to High(hashtags) do
    begin
      if TrendingTopic.ContainsKey(hashtags[i]) then
        begin
          Quantidade := TrendingTopic[hashtags[i]];
          Inc(Quantidade);
          TrendingTopic[hashtags[i]] := Quantidade;
        end
      else
        TrendingTopic.Add(hashtags[i],1);
    end;

  for chave in TrendingTopic.Keys do
    begin
      SetLength(values, length(values)+1);
      values[high(values)] := TrendingTopic[chave];
      SetLength(keys, length(keys)+1);
      keys[high(keys)] := chave;
    end;
  OrdenarTrendingTopic(values, keys);
end;

procedure TfrmPrincipalTwitter.OrdenarTrendingTopic(value: Tarray<integer>; keys: Tarray<string>);
var
  trocou: boolean;
  i, auxiliarValues: integer;
  auxiliarKeys: string;
begin
  repeat
    trocou := false;
    for i := low(value) to high(value)-1 do
      begin
        if value[i] < value[i+1] then
          begin
            auxiliarValues := value[i];
            auxiliarKeys := keys[i];

            value[i] := value[i+1];
            keys[i] := keys[i+1];

            value[i+1] := auxiliarValues;
            keys[i+1] := auxiliarKeys;

            trocou := true;
          end
      end;
  until not trocou;
  for I := Low(keys) to high(keys) do
    case i of
      0: stTrendingTopic1.Caption :=keys[i];
      1: stTrendingTopic2.caption :=keys[i];
      2: stTrendingTopic3.caption :=keys[i];
      3: stTrendingTopic4.caption :=keys[i];
      4: stTrendingTopic5.caption :=keys[i];
    end;
end;

procedure TfrmPrincipalTwitter.btnBaidwitarClick(Sender: TObject);
begin
  if mePostar.Text <> '' then
    begin
      mePostar.Text := StringReplace(mePostar.Text, #$D#$A, ' ', [rfReplaceAll]);
      setlength(ListaTweets, length(ListaTweets)+1);
      ListaTweets[high(ListaTweets)] := format(CNT_NOVO_TWEET,[dateToStr(Now), TimeToStr(time), stNomeUsuario.Caption, mePostar.Text]);
      AtualizaMemo;
      mePostar.Text := Format(CNT_ESCREVER_MEMO,[]);
      AcharHashtag;
      mePostar.Height := 26;
      stLimiteCaracter.Visible := false;
      btnBaidwitar.Visible := false;
    end;
end;

procedure TfrmPrincipalTwitter.AcharHashtag;
var
  PosicaoInicial, PosicaoFinal, ie, ii: integer;
  parte: string;
begin
  SetLength(MemoriaTweetsComHashtag, 0);
  SetLength(hashtags,0);
  ResultadosEncontrados := 0;
  for Ie := Low(ListaTweets) to High(ListaTweets) do
    begin
      ii := 1;
      while ii < length(ListaTweets[ie]) do
        begin
          if ListaTweets[ie][ii] = '#' then
            begin
              PosicaoFinal := 0;
              PosicaoInicial := ii;
              while (ListaTweets[ie][ii] <> ' ') and (ListaTweets[ie][ii] <> #0) do
                begin
                  inc(ii);
                  inc(PosicaoFinal);
                end;
              if PosicaoFinal > 1 then
                begin
                  Parte := Copy(ListaTweets[ie], PosicaoInicial, PosicaoFinal);
                  HashtagETweet(Parte,ie);
                end;
            end;
          inc(ii)
        end;
    end;
  AtualizarTrendingTopic(parte);
  if Length(MemoriaTweetsComHashtag) > 0 then
    SepararTweetComHashtag(ie);
end;

procedure TfrmPrincipalTwitter.HashtagETweet(hashtag: string; locarTweet: integer);
begin
  if (Uppercase(edFiltrar.Text) = UpperCase(hashtag)) then
    begin
     inc(ResultadosEncontrados);
      SetLength(MemoriaTweetsComHashtag, length(MemoriaTweetsComHashtag)+1);
      MemoriaTweetsComHashtag[high(MemoriaTweetsComHashtag)] := ListaTweets[locarTweet];
    end;
  SetLength(hashtags,length(hashtags)+1);
  hashtags[high(hashtags)] := lowerCase(hashtag);
end;

procedure TfrmPrincipalTwitter.btnFiltrarClick(Sender: TObject);
begin
  pnlFiltro.Visible := false;
  stpFiltro.Visible := false;
  acharHashtag;
  edFiltrar.Text := '';
end;

procedure TfrmPrincipalTwitter.btnMinimizarFiltroClick(Sender: TObject);
begin
  pnlFiltro.Visible := false;
  stpFiltro.Visible := false;
end;

procedure TfrmPrincipalTwitter.Image1Click(Sender: TObject);
begin
  edFiltrar.Visible := true;
end;

procedure TfrmPrincipalTwitter.lblTrendingTopic1Click(Sender: TObject);
begin
  if edFiltrar.Text <> '' then
    begin
      edFiltrar.Text := stTrendingTopic1.Caption;
      btnFiltrar.Click;
    end;
end;

procedure TfrmPrincipalTwitter.mePostarChange(Sender: TObject);
begin
  stLimiteCaracter.Caption := IntToStr((length(mePostar.Text)-140) * -1);
end;

procedure TfrmPrincipalTwitter.mePostarClick(Sender: TObject);
begin
  stLimiteCaracter.Caption := '140';
  mePostar.Height := 86;
  stLimiteCaracter.Visible := true;
  btnBaidwitar.Visible := true;
  if mePostar.text = Format(CNT_ESCREVER_MEMO,[]) then
    mePostar.Clear;
end;

procedure TfrmPrincipalTwitter.mMudarCorClick(Sender: TObject);
begin
  if mMudarCor.Checked = false then
    mMudarCor.Checked := true
  else
    mMudarCor.Checked := false;
  if mMudarCor.Checked = true then
    begin
      meFiltro.Color := $00E6E6E6;
      mefiltro.Font.Color := clBlack;
      meConsole.Color := $00E6E6E6;
      meConsole.Font.Color := clBlack;
      stpFiltro.Color := clMedGray;
    end
  else
    begin
      meFiltro.Color := $00404040;
      mefiltro.Font.Color := clWhite;
      meConsole.Color := $00404040;
      meConsole.Font.Color := clWhite;
      stpFiltro.Color := clBlack;
    end;
end;

procedure TfrmPrincipalTwitter.mSairClick(Sender: TObject);
begin
  frmPrincipalTwitter.Close;
end;

procedure TfrmPrincipalTwitter.SepararTweetComHashtag(IeDoTweet: integer);
var
  i: integer;
begin
  pnlFiltro.Visible := true;
  stpFiltro.Visible := true;
  meFiltro.Lines.Clear;
  meFiltro.Lines.Add(Format(CNT_RESU_ENCO, [ResultadosEncontrados]));
  for I := Low(MemoriaTweetsComHashtag) to High(MemoriaTweetsComHashtag) do
    begin
      meFiltro.Lines.Add('');
      meFiltro.Lines.Add(MemoriaTweetsComHashtag[i]);
      meFiltro.Lines.Add('═══════════════════════════════════════')
    end;

end;

procedure TfrmPrincipalTwitter.Timer1Timer(Sender: TObject);
var
  numero:integer;
  PassarNoPainel: array[0..4] of string;
begin
  PassarNoPainel[0] := '»» Bem vindo ao Baiduoo ««';
  PassarNoPainel[1] := '»» Mais de 1320000000000 octalhoes de usuarios ««';
  PassarNoPainel[2] := '»» Compartilhe com seus amigos suas histórias ««';
  PassarNoPainel[3] := '»» Mark Zuckerberg que se cuide ««';
  PassarNoPainel[4] := '»» Click sobre a Hashtag nos TrendingTopics para abrir o filtro ««';
  Timer1.Interval := 10;
  lblBVAB.Left := (lblBVAB.Left)-1;
  numero := Random(5);
  if lblBVAB.Left = -600 then
    begin
      lblBVAB.Caption := PassarNoPainel[numero];
      lblBVAB.Left := 1500;
    end;
end;

procedure TfrmPrincipalTwitter.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action := cafree;
end;

procedure TfrmPrincipalTwitter.FormShow(Sender: TObject);
begin
  SalvarTweets := TStringList.Create;
  mePostar.MaxLength := 140;
  mePostar.text := Format(CNT_ESCREVER_MEMO,[]);
end;
procedure TfrmPrincipalTwitter.FormStartDock(Sender: TObject;
  var DragObject: TDragDockObject);
begin

end;

//                  FONT COLOR TrendingTopic
procedure TfrmPrincipalTwitter.stTrendingTopic1MouseEnter(Sender: TObject);
begin
  stTrendingTopic1.Font.Color := clBlue;
end;

procedure TfrmPrincipalTwitter.stTrendingTopic1MouseLeave(Sender: TObject);
begin
  stTrendingTopic1.Font.Color := clWhite;
end;

procedure TfrmPrincipalTwitter.stTrendingTopic2MouseEnter(Sender: TObject);
begin
  stTrendingTopic2.Font.Color := clBlue;
end;

procedure TfrmPrincipalTwitter.stTrendingTopic2MouseLeave(Sender: TObject);
begin
  stTrendingTopic2.Font.Color := clWhite;
end;

procedure TfrmPrincipalTwitter.stTrendingTopic3MouseEnter(Sender: TObject);
begin
  stTrendingTopic3.Font.Color := clBlue;
end;

procedure TfrmPrincipalTwitter.stTrendingTopic3MouseLeave(Sender: TObject);
begin
  stTrendingTopic3.Font.Color := clWhite;
end;

procedure TfrmPrincipalTwitter.stTrendingTopic4MouseEnter(Sender: TObject);
begin
  stTrendingTopic4.Font.Color := clBlue;
end;

procedure TfrmPrincipalTwitter.stTrendingTopic4MouseLeave(Sender: TObject);
begin
  stTrendingTopic4.Font.Color := clWhite;
end;

procedure TfrmPrincipalTwitter.stTrendingTopic5MouseEnter(Sender: TObject);
begin
  stTrendingTopic5.Font.Color := clBlue;
end;

procedure TfrmPrincipalTwitter.stTrendingTopic5MouseLeave(Sender: TObject);
begin
  stTrendingTopic5.Font.Color := clWhite;
end;
//                    ************
//              STATIC TEXT TrendingTopic
procedure TfrmPrincipalTwitter.stTrendingTopic1Click(Sender: TObject);
begin
  edFiltrar.Text := stTrendingTopic1.Caption;
  btnFiltrar.Click;
end;

procedure TfrmPrincipalTwitter.stTrendingTopic2Click(Sender: TObject);
begin
  edFiltrar.Text := stTrendingTopic2.Caption;
  btnFiltrar.Click;
end;

procedure TfrmPrincipalTwitter.stTrendingTopic3Click(Sender: TObject);
begin
  edFiltrar.Text := stTrendingTopic3.Caption;
  btnFiltrar.Click;
end;

procedure TfrmPrincipalTwitter.stTrendingTopic4Click(Sender: TObject);
begin
  edFiltrar.Text := stTrendingTopic4.Caption;
  btnFiltrar.Click;
end;

procedure TfrmPrincipalTwitter.stTrendingTopic5Click(Sender: TObject);
begin
  edFiltrar.Text := stTrendingTopic5.Caption;
  btnFiltrar.Click;
end;
//                    ***********
end.
