unit FormularioPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, jpeg, ExtCtrls, RegularExpressions;

type
  TfrmPrincipal = class(TForm)
    edTwits: TEdit;
    meTwits: TMemo;
    btnTwit: TButton;
    Image1: TImage;
    meTrends: TMemo;
    lbTrends: TLabel;
    Label1: TLabel;
    Image2: TImage;
    Label2: TLabel;
    edBuscar: TEdit;
    meBusca: TMemo;
    Button1: TButton;
    labelCaunt: TLabel;
    btnCarregar: TButton;
    btnSalvar: TButton;
    fodCarregar: TFileOpenDialog;
    fsdSalvar: TFileSaveDialog;
    procedure FormCreate(Sender: TObject);
    procedure edTwitsClick(Sender: TObject);
    procedure btnTwitClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnCarregarClick(Sender: TObject);
  private
    TweetsComHashtag: Array of string;
    SomenteHashtags: Array of string;
    ListaTweets: TStringList;
    ListaSalvar: TStringList;
    procedure DrawRounded(Control: TWinControl);
    procedure AtualizaMemo;
    procedure ProcurarHashtag(const searchMe: String);
    procedure TrendingTopics;
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;
  regexpr : TRegEx;
  match   : TMatch;

implementation

uses
  Generics.Collections;
{$R *.dfm}

{ TForm1 }

procedure TfrmPrincipal.AtualizaMemo;
begin
  meTwits.Lines.Text := ListaTweets.Text;
end;

procedure TfrmPrincipal.btnCarregarClick(Sender: TObject);
var
  i: integer;
begin
  if fodCarregar.Execute then
    begin
      ListaSalvar.LoadFromFile(fodCarregar.FileName);
      for I := 0 to ListaSalvar.Count-1 do
        begin
          ListaTweets.Add('========================================================================');
          ListaTweets.Add(ListaSalvar[i]);
          ListaTweets.Add('========================================================================');
        end;
      ProcurarHashtag(ListaTweets.Text);
      AtualizaMemo;
    end;
end;

procedure TfrmPrincipal.btnSalvarClick(Sender: TObject);
begin
  if fsdSalvar.Execute then
    ListaSalvar.SaveToFile(fsdSalvar.FileName);
end;

procedure TfrmPrincipal.btnTwitClick(Sender: TObject);
var
  Indice: Integer;
  texto: string;
begin
  if (Trim(edTwits.Text) <> EmptyStr) and (edTwits.Text <> '  No que você está pensando?') then
    begin
      ListaTweets.Add('==================================');
      ListaTweets.Add(edTwits.Text);
      ListaTweets.Add('==================================');
      ListaSalvar.Add(edTwits.Text);
      AtualizaMemo;
      texto := ListaTweets.Text;
      ProcurarHashtag(texto);
    end;
  edTwits.Clear;
  edTwits.Text := '  No que você está pensando?';
end;

procedure TfrmPrincipal.Button1Click(Sender: TObject);
var
IndiceExterno, IndiceInterno, indice : integer;
parte: String;
begin
  meBusca.Clear;
  setLength(TweetsComHashtag, 0);
  for IndiceExterno := 1 to ListaTweets.Count -1 do
    begin
      IndiceInterno := 1;
      while IndiceInterno < length(ListaTweets[IndiceExterno]) - 1 do
        begin
          if ListaTweets[IndiceExterno][IndiceInterno] = '#' then
            begin
	            indice := IndiceInterno;
              while (ListaTweets[IndiceExterno][indice] <> ' ') and (ListaTweets[IndiceExterno][indice] <> #0) do
                begin
	                parte := parte + listaTweets[IndiceExterno][indice];
		              inc(Indice);
                end;
              if Uppercase(edBuscar.Text) = UpperCase(Parte) then
                begin
	                setLength(TweetsComHashtag, length(TweetsComHashtag)+1);
                  TweetsComHashtag[high(TweetsComHashtag)] := listaTweets[IndiceExterno];
                end;
              parte := '';
	          end;
          inc(IndiceInterno);
        end;
   end;
  meBusca.Clear;
  for Indice := Low(TweetsComHashtag) to High(TweetsComHashtag) do
    begin
      meBusca.Lines.Add(TweetsComHashTag[indice]);
      meBusca.Lines.Add(' ')
    end;
    edBuscar.Clear;
end;

procedure TfrmPrincipal.TrendingTopics;
var
  Dicionario: TDictionary<String, Integer>;
  Palavra, auxHastag, i: String;
  hashtag: Tarray<string>; posicao: Tarray<integer>;
  Quantidade, indice, auxPosicao: Integer;
  trocou: boolean;
begin
  Dicionario := TDictionary<String, Integer>.Create;
  for indice := low(SomenteHashtags) to high(SomenteHashtags) do
    begin
      if Dicionario.ContainsKey(SomenteHashtags[indice]) then
        begin
          Quantidade := Dicionario[SomenteHashtags[indice]];
          Inc(Quantidade);
          Dicionario[SomenteHashtags[indice]] := Quantidade;
        end
      else
      dicionario.Add(SomenteHashtags[indice],1);
    end;
  Setlength(hashtag, 0);
  Setlength(posicao, 0);
  for i in Dicionario.Keys do
    begin
      Setlength(hashtag, length(hashtag) + 1);
      Setlength(posicao, length(posicao) + 1);
      hashtag[length(hashtag) -1] :=   i;
      posicao[length(posicao) -1] :=   Dicionario[i];
    end;
    trocou := true;
    while Trocou do
      begin
        Trocou := False;
          for indice := Low(posicao) to High(posicao)-1 do
            begin
              if posicao[indice] < posicao[indice +1] then
                begin
                  auxHastag           := hashtag[indice];
                  hashtag[indice]     := hashtag[indice +1];
                  hashtag[indice +1]  := auxHastag;
                  auxPosicao          := posicao[indice];
                  posicao[indice]     := posicao[indice +1];
                  posicao[indice +1]  := auxPosicao;
                  Trocou := True;
                end;
            end;
      end;
  meTrends.Clear;
  for indice := Low(hashtag) to High(hashtag) do
    meTrends.Lines.Add(hashtag[indice])
end;


procedure TfrmPrincipal.DrawRounded(Control: TWinControl);
var
  R: TRect;
  Rgn: HRGN;
begin
  with Control do
    begin
      R := ClientRect;
      rgn := CreateRoundRectRgn(R.Left, R.Top, R.Right, R.Bottom, 20, 20) ;
      Perform(EM_GETRECT, 0, lParam(@r)) ;
      InflateRect(r, - 4, - 4) ;
      Perform(EM_SETRECTNP, 0, lParam(@r)) ;
      SetWindowRgn(Handle, rgn, True) ;
      Invalidate;
    end;
end;

procedure TfrmPrincipal.edTwitsClick(Sender: TObject);
begin
  edTwits.Clear;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  ListaSalvar        := TStringList.Create;
  ListaTweets        := TStringList.Create;
  ListaTweets.Sorted := False;
  edTwits.BorderStyle := bsNone;
  DrawRounded(edTwits);
end;

procedure TfrmPrincipal.ProcurarHashtag(const searchMe: String);
var
  matches : TMatchCollection;
  i: integer;
begin
  SetLength(SomenteHashTags,0);
  regexpr := TRegEx.Create('\S*#(?:\[[^\]]+\]|\S+)',[roIgnoreCase,roMultiline]);
  match := regexpr.Match(searchMe);
  while match.Success do
    begin
      SetLength (SomenteHashTags, Length(SomenteHashTags) + 1);
      SomenteHashtags[high(SomenteHashTags)] := (match.Value);
      match := match.NextMatch;
      TrendingTopics;
    end;
  matches := regexpr.Matches(searchMe);
end;

end.
