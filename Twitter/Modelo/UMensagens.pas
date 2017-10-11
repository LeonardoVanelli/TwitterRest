unit UMensagens;

interface

resourcestring
  //Geral
  STR_ATENCAO                 = 'Atenção';
  STR_CAPTION_ABA_CONSULTAS   = '%d - %s...';
  STR_TODOS                   = 'Todos';
  STR_ATUALIZADO              = 'atualizado(a)';
  STR_GRAVADO                 = 'gravado(a)';
  STR_EXCLUIDO                = 'excluido(a)';
  STR_OPERACAO_COM_SUCESSO    = '%s com código %d %s com sucesso.';
  STR_ENTIDADE_NAO_ENCONTRADA = '%s com código %d não foi encontrado(a)';

  //Entidade
  STR_ENTIDADE_GRAVADA_COM_SUCESSO    = '%s gravado(a) com sucesso! Código gerado: %d.';
  STR_ENTIDADE_ATUALIZADO_COM_SUCESSO = '%s atualizado(a) com sucesso!';
  STR_ENTIDADE_DESEJA_EXCLUIR         = 'Deseja realmente excluir este(a) %s?';

  //CRUD
  STR_CRUD_CABECALHO = 'Cadastro de %s';

  //Transação
  STR_JA_EXISTE_TRANSACAO_ATIVA   = 'Não foi possivel abrir uma nova transação! Motivo: Já existe uma transação ativa.';
  STR_NAO_EXISTE_TRANSACAO_ATIVA  = 'Não foi possivel %s a transação! Motivo: Não existe uma transação ativa.';
  STR_VALIDA_TRANSACAO_ATIVA      = 'Operação abortada! Motivo: Para realizar esta operação é necessário ter uma transação ativa.';
  STR_ABORTAR                     = 'abortar';
  STR_FINALIZAR                   = 'finalizar';

implementation

end.
