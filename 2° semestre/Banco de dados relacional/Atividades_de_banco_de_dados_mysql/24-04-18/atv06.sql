/* 67. Considere um sistema de gerenciamento de eventos, onde um evento pode
ter vários participantes e cada participante pode estar em vários eventos. Cada
participante tem um nome e um endereço de email. */

CREATE TABLE evento (
  id_evento INT NOT NULL PRIMARY KEY,
  id_participante INT NOT NULL,
  nome_evento varchar(50) null,
  data_evento date null,
);

CREATE TABLE participante (
  id_participante INT NOT NULL PRIMARY KEY,
  id_evento INT NOT NULL,
  nome_participante VARCHAR(50) NULL,
  email_participante VARCHAR(40) NULL,
);

create table Evento_participante(
  id_evento int,
  id_participante int,
  PRIMARY key (id_evento, id_participante),
  FOREIGN key (id_evento) references evento(id_evento),
  FOREIGN key (id_participante) references participante(id_participante))

/* 68. Considere um sistema de gerenciamento de uma biblioteca. O sistema
deve registrar informações sobre os livros, os autores e as editoras. Cada livro
pode ter um ou mais autores, e cada autor pode ter escrito um ou mais livros.
Cada livro é publicado por uma editora. Utilize o modelo ER abaixo para criar o
modelo físico do banco de dados. */ 

create table autor(
  id_autor int not null PRIMARY KEY,
  nome varchar(100),
  cpf varchar(11),
  data_nasc date,
  id_livro int  
)
  
create table livro(
  id_livro int not null PRIMARY key,
  nome varchar(100),
  ano varchar(4),
  genero varchar(20),
  id_editora int,
  id_autor int
  FOREIGN key (id_editora) references Editora(id_editora)
)

create table autor_livro(
  id_autor int,
  id_livro int,
  primary key (id_autor, id_livro),
  FOREIGN key (id_autor) references autor(id_autor),
  FOREIGN key (id_livro) references livro(id_livro)
)

create table editora(
  id_editora int not null primary key,
  nome varchar(100),
  localidade varchar(150)
)