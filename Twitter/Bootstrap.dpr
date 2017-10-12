program Bootstrap;

uses
  Forms,
  UFrmPrincipal in 'VisaoControle\UFrmPrincipal.pas' {FrmPrincipal},
  UFrmCRUD in 'VisaoControle\UFrmCRUD.pas' {FrmCRUD},
  UUtilitarios in 'Modelo\UUtilitarios.pas',
  UMensagens in 'Modelo\UMensagens.pas',
  UConstantes in 'Modelo\UConstantes.pas',
  UDialogo in 'Modelo\UDialogo.pas',
  UOpcaoPesquisa in 'Modelo\UOpcaoPesquisa.pas',
  UDM in 'Modelo\Persistencia\UDM.pas' {dmEntra21: TDataModule},
  UEntidade in 'Modelo\Persistencia\UEntidade.pas',
  URepositorio in 'Modelo\Persistencia\URepositorio.pas',
  URepositorioDB in 'Modelo\Persistencia\URepositorioDB.pas',
  URegraCRUD in 'Modelo\Regra\URegraCRUD.pas',
  UFrmPesquisa in 'VisaoControle\UFrmPesquisa.pas' {frmPesquisa},
  UFrmPrincipalTwitter in 'VisaoControle\UFrmPrincipalTwitter.pas' {frmPrincipalTwitter};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmPrincipalTwitter, frmPrincipalTwitter);
  Application.CreateForm(TdmEntra21, dmEntra21);
  Application.Run;
end.
