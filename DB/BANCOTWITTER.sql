create table usuario (
    id integer not null,
    nome varchar (60) not null,
    login varchar (60) not null,
    senha varchar (60) not null,
    arroba varchar (60) not null,
    email varchar (60) not null,
    
    
    constraint pk_id_user primary key (id),
    constraint uk_login_user unique (login),
    constraint uk_arroba_user unique (arroba),
    constraint uk_email_user unique (email)
    
);

create table twits (
   id integer not null,
   nome_tw varchar (60) not null,
   arroba_tw varchar (60) not null,
   mensagem varchar (140),
   data date not null,
   
   constraint pk_id_tw primary key (id),
   constraint fk_arroba_tw_user foreign key (arroba_tw) references usuario(arroba)
   --constraint fk_nome_tw_user foreign key (nome_tw) references usuario(nome)
   
);